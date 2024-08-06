local ScriptName = "SUIS";
local Version = "0.1";
local CreatorName = "Denys";
local Description = "SOTA Sample UI"

-------------------------------------------
---- UI

---@enum ui_type
local ui_type = {
    None = -1,
    Panel = 0,  -- UI.Panel
    Image = 1,  -- UI.Image
    Text = 2,   -- UI.Text
    Button = 3, -- UI.Button
    Input = 4,  -- UI.Input
    Toggle = 5  -- UI.Toggle
}

---@enum ui_input_type
local ui_input_type = {
    Standard = 0,      -- ContentType.Standard
    Autocorrected = 1, -- ContentType.Autocorrected
    IntegerNumber = 2, -- ContentType.IntegerNumber
    DecimalNumber = 3, -- ContentType.DecimalNumber
    Alphanumeric = 4,  -- ContentType.Alphanumeric
    Name = 5,          -- ContentType.Name
    EmailAddress = 6,  -- ContentType.EmailAddress
    Password = 7,      -- ContentType.Password
    Pin = 8            -- ContentType.Pin
}

---@enum ui_state
local ui_state = {
    Normal = 0,
    Hovered = 1,
    Pressed = 2,
    Disabled = 3
}

---@enum ui_anchor
local ui_anchor = {
    UpperLeft = 0,    -- TextAnchor.UpperLeft,
    UpperCenter = 1,  -- TextAnchor.UpperCenter,
    UpperRight = 2,   -- TextAnchor.UpperRight,
    MiddleLeft = 3,   -- TextAnchor.MiddleLeft,
    MiddleCenter = 4, -- TextAnchor.MiddleCenter,
    MiddleRight = 5,  -- TextAnchor.MiddleRight,
    LowerLeft = 6,    -- TextAnchor.LowerLeft,
    LowerCenter = 7,  -- TextAnchor.LowerCenter,
    LowerRight = 8    -- TextAnchor.LowerRight
}

---@enum ui_color
local ui_color = {
    None = "#00000001",
    Black = "#000000",
    White = "#ffffff",
    Buff = "#DAA06D",
    Gray = "#303030",
    DarkGray = "#101010",
    DimGray = "#696969",
    Onyx = "#353935",
    BlueGray = "#7393B3",
    SteelBlue = "#4682B4",
    CornflowerBlue = "#6495ED",
    Gold = "#FFD700",
    Oxblood = "#4A0404"
}

---@enum ui_texture
local ui_texture = {
    Sample = 0
}

---@enum ui_symbol
local ui_symbol = {
    Menu = "\u{2630}",
    CheckOn = "\u{2611}",
    CheckOff = "\u{2610}",
    Close = "\u{2715}",
    CloseBold = "\u{2716}",
    RadioOn = "\u{29BF}",
    Resize = "\u{25E2}"
}

---@enum ui_layout
local ui_layout = {
    Position = 0,
    Horizontal = 1,
    Vertical = 2
}

---@enum ui_resize_dir
local ui_resize_dir = {
    None = "None",
    Horizontal = "Horizontal",
    Vertical = "Vertical",
    Both = "Both"
}

---@type fun(): boolean
local ui_show

---@type fun(): boolean
local ui_hide

---Create a UI Panel which come with a few built in functionality:
--- - Bring Panel to front and back with left and right click
--- - Panel are movable
--- - Panel can also be set to resizable because the script Dragguable is already set on it.
---
---> Panel come with a Mask script by default,
--- if you set transparency on panels to ZERO, everything else will go away. Remove the mask first if you want to do this with ShroudUnsetMask
---
--- Return the ID of the newly created Panel or -1 if null.
---@type fun(x: number, y: number, width: number, height: number, parent_id?: integer, type?: ui_type): integer
local ui_panel

---Create a UI Text element.
---
---Return the ID of the newly created text or -1 if null.
---@type fun(text: string, font_size: integer, x: number, y: number, width: number, height: number, parent_id?: integer, type?: ui_type): integer
local ui_text

--- Create a UI Input field.
---
--- Will return change from input fields in ShroudOnInputChange function.
---
--- Return the ID of the newly created button or -1 if null.
---@type fun(x: number, y: number, width: number, height: number, parent_id?: integer, type?: ui_type): integer
local ui_input

---@type fun(x: number, y: number, width: number, height: number, texture_id?: integer, parent_id?: integer, type?: ui_type): integer
local ui_image

---------------------------------------
--- UI Object

---@type fun(id: integer, type: ui_type): boolean
local ui_destroy_object

--- Return the int of the parentID or -1 if it failed.
---@type fun(id: integer, type: ui_type, parent_id: integer, parent_type: ui_type): integer
local ui_set_object_parent

---@type fun(id: integer, type: ui_type, width: number, height: number): boolean
local ui_set_object_size

---@type fun(id: integer, type: ui_type, x: number, y: number): boolean
local ui_set_object_position

---@type fun(id: integer, type: ui_type, degree: number): boolean
local ui_set_object_rotation

---@type fun(id: integer, type: ui_type, x: number, y: number): boolean
local ui_set_object_pivot

---@type fun(id: integer, type: ui_type, factor: number): boolean
local ui_set_object_scale

---@type fun(id: integer, type: ui_type, hexcolor: ui_color): boolean
local ui_set_object_color

---@type fun(id: integer, type: ui_type): boolean
local ui_set_object_mask

---@type fun(id: integer, type: ui_type): boolean
local ui_unset_object_mask

---@type fun(id: integer, type: ui_type, value: number): boolean
local ui_set_object_opacity

---@type fun(id: integer, type: ui_type): boolean
local ui_show_object

---@type fun(id: integer, type: ui_type): boolean
local ui_hide_object

---------------------------------------
--- UI Pre-made scripts

---@type fun(id: integer, type: ui_type): boolean
local ui_set_object_draggable

---@type fun(id: integer, type: ui_type): boolean
local ui_unset_object_draggable

---@type fun(id: integer, type: ui_type, direction?: ui_resize_dir): boolean
local ui_set_object_resizable

---@type fun(id: integer, type: ui_type): boolean
local ui_set_object_mouse_filter

---@type fun(id: integer, type: ui_type): boolean
local ui_unset_object_mouse_filter

---------------------------------------
--- UI Text

---@type fun(id: integer, value: string): boolean
local ui_set_text_value

---@type fun(id: integer, anchor: ui_anchor): boolean
local ui_set_text_align

---@type fun(id: integer, type: ui_type, size: integer)
local ui_set_font_size

---------------------------------------
--- UI Image

---@type fun(path: string, clamp: boolean): integer
local ui_image_texture

---------------------------------------
--- UI Input

---@type fun(id: integer): string
local ui_get_input_text

---@type fun(id: integer, text: string): boolean
local ui_set_input_text

---@type fun(id: integer, type: ui_input_type): boolean
local ui_set_input_type

---@type fun(id: integer, text: string): boolean
local ui_set_input_placeholder

---@type fun(id: integer, hexcolor: ui_color|string): boolean
local ui_set_input_bg_color

---@type fun(id: integer, limit: integer): boolean
local ui_set_input_limit

---@type fun(id: integer, value: boolean): boolean
local ui_set_input_readonly

---------------------------------------
--- Screen

local screen_size_x = 0
local screen_size_y = 0

---@type fun(): integer
local get_screen_size_x

---@type fun(): integer
local get_screen_size_y

-------------------------------------------
---- Mouse and Keyboard

---@enum key_code
local key_code = {
    MouseButtonLeft = "Mouse0",
    MouseButtonRight = "Mouse1",
    Return = "Return"
}

local mouse_x = 0
local mouse_x_dir = 0
local mouse_x_spd = 0
local mouse_y = 0
local mouse_y_dir = 0
local mouse_y_spd = 0

local mouse_button_left_pressed = false
local mouse_button_right_pressed = false

---@type fun(key: key_code): boolean
local is_key_pressed

---@type fun(key: key_code): boolean
local is_key_released

-------------------------------------------
---- Player

---@type fun(): string
local get_player_name

---@type fun(): boolean
local get_player_combat_mode

---@type fun(): number
local get_adventurer_total_xp

---@type fun(): number
local get_adventurer_pooled_xp

---@type fun(): boolean
local get_adventurer_attenuation_status

---@type fun(): number
local get_producer_total_xp

---@type fun(): number
local get_producer_pooled_xp

---@type fun(): boolean
local get_producer_attenuation_status

---@type fun(): integer
local get_player_stat_count

---@type fun(idx: integer): string
local get_player_stat_name

---@type fun(idx: integer): number
local get_player_stat_value

---@type fun(name: string): number
local get_player_stat_value_by_name

---@type fun(idx: integer): string
local get_player_stat_description

-------------------------------------------
--- Utils

---@generic T
---@param n number
---@param v T
---@return T[]
local array = function(n, v)
    local a = {}
    for i = 1, n do
        a[i] = v
    end
    return a
end

---@param n number
local clock_value = function(n)
    local d = os.date("!*t", n)
    return string.format("%02d:%02d:%02d", d.hour, d.min, d.sec)
end

--- credit http://richard.warburton.it
---@param n number
---@return unknown
local comma_value = function(n)
    local left, num, right = string.match(n, '^([^%d]*%d)(%d*)(.-)$')
    return left .. (num:reverse():gsub('(%d%d%d)', '%1,'):reverse()) .. right
end

local clamp_value = function(value, min, max)
    if value > max then
        return max
    elseif value < min then
        return min
    end
    return value
end

---@param base table
local base_class = function(base)
    base.__index = base
    setmetatable(base, {
        __call = function(cls, ...)
            local self = setmetatable({}, cls)
            self:new(...)
            return self
        end,
    })
end

---@param derived table
---@param base table
local derived_class = function(derived, base)
    -- for k, v in pairs(base) do
    --     derived[k] = v
    -- end

    derived.__index = derived
    setmetatable(derived, {
        __index = base,
        __call = function(cls, ...)
            local self = setmetatable({}, cls)
            self:new(...)
            return self
        end,
    })
end

-------------------------------------------
--- Event

---@enum event_status
local event_status = {
    Running = "running",     -- Is running.
    Suspended = "suspended", -- Is suspended or not started.
    Normal = "normal",       -- Is active but not running.
    Dead = "dead"            -- Has finished or stopped with an error.
}

function Event()
    ---@class action
    ---@field id string
    ---@field callable function
    ---@field calltime number
    ---@field callargs any[]
    ---@field interval number

    ---@type action[]
    local action_ = {}
    local action_count_ = 0

    local status_ = event_status.Normal

    ---@class Event
    local self = {}

    ---@param callable function
    ---@param interval? number
    ---@param ... any -- call if args equal
    ---@return string -- action ID
    function self.action(callable, interval, ...)
        local id = tostring(callable)

        for _, a in ipairs(action_) do
            if id == a.id then
                return id
            end
        end

        if not interval then
            interval = 0
        end

        table.insert(action_, {
            id = id,
            callable = callable,
            calltime = 0,
            callargs = { ... },
            interval = interval
        })

        action_count_ = action_count_ + 1
        return id
    end

    ---@param id string
    function self.remove_action(id)
        for i, a in ipairs(action_) do
            if id == a.id then
                table.remove(action_, i)
                break
            end
        end
    end

    function self.suspend()
        status_ = event_status.Suspended
    end

    function self.resume()
        status_ = event_status.Running
    end

    ---@return event_status
    function self.status()
        return status_
    end

    function self.emit(...)
        if status_ == event_status.Suspended then
            return
        end

        local vargs = { ... }
        for _, a in ipairs(action_) do
            local next, equal = true, true
            for index, value in ipairs(a.callargs) do
                if vargs[index] ~= value then
                    equal = false
                    next = true
                    break
                end
                next = false
            end

            if equal and (a.interval < (os.clock() - a.calltime)) then
                if a.callable(...) then
                    next = false
                end
                a.calltime = os.clock()
            end

            if not next then
                break
            end
        end
    end

    return self
end

function Signal()
    ---@class Signal
    local self = {}

    local action_ = {}
    local callback_
    local keep_callback_ = false

    ---@param callable function
    ---@return string -- Action ID
    function self.action(callable)
        local id = tostring(callable)

        for _, action in ipairs(action_) do
            if id == action.id then
                return id -- exists
            end
        end

        table.insert(action_, { id = id, callable = callable })
        return id
    end

    ---@param id string
    function self.remove_action(id)
        for i, a in ipairs(action_) do
            if id == a.id then
                table.remove(action_, i)
                break
            end
        end
    end

    ---@param callable function
    ---@param keep? boolean
    function self.callback(callable, keep)
        callback_ = callable
        if keep then
            keep_callback_ = true
        end
    end

    function self.remove_callback()
        callback_ = nil
        keep_callback_ = false
    end

    function self.emit(...)
        if callback_ then
            callback_()
            if not keep_callback_ then
                self.remove_callback()
            end
            return
        end

        for _, action in ipairs(action_) do
            if action.callable(...) then
                break
            end
        end
    end

    return self
end

function Thread()
    ---@class Thread
    local self = {}

    local task_ = {}
    local task_count_ = 0

    local action_ = {}
    local action_count_ = 0
    local action_index_ = 1

    function self.task(callable)
        local id = tostring(callable)

        for _, task in ipairs(task_) do
            if id == task.id then
                return -- exists
            end
        end

        table.insert(task_, { id = id, callable = callable })
        task_count_ = task_count_ + 1
    end

    ---@param callable function
    ---@return string -- Action ID
    function self.action(callable)
        local id = tostring(callable)

        for _, action in ipairs(action_) do
            if id == action.id then
                return id -- exists
            end
        end

        table.insert(action_, { id = id, callable = callable })
        action_count_ = action_count_ + 1
        return id
    end

    function self.resume()
        if action_count_ > 0 then
            action_[action_index_].callable()
            action_index_ = action_index_ + 1
            if action_index_ > action_count_ then
                action_index_ = 1
            end
        end

        if task_count_ > 0 then
            task_[1].callable()
            table.remove(task_, 1)
            task_count_ = task_count_ - 1
        end
    end

    return self
end

local on_mouse_entered = Event()
local on_mouse_exited = Event()
local on_mouse_pressed = Signal()
local on_mouse_released = Signal()
local on_mouse_dragging = Signal()

local on_key_pressed = Event()
local on_key_released = Event()

local on_screen_changed = Signal()

local on_scene_loaded = Event()
local on_scene_unloaded = Event()

local on_input_change = Event()

local on_logout = Event()

local on_redraw = Event()
local on_update = Thread()

-------------------------------------------
--- Base Objects

---@param pos_x number
---@param pos_y number
---@param size_x number
---@param size_y number
---@param node_type ui_type
---@param parent_node? Node
function Node(pos_x, pos_y, size_x, size_y, node_id, node_type, parent_node)
    local pos_x_ = pos_x
    local pos_y_ = pos_y
    local size_x_ = size_x
    local size_y_ = size_y
    local min_size_x_ = size_x
    local min_size_y_ = size_y
    local resize_dir_ = ui_resize_dir.Both

    local id_ = node_id
    local type_ = node_type

    local parent_ = parent_node
    local parent_id_ = -1
    local parent_type_ = ui_type.None

    ---@class Node
    local self = {}

    ---@type Node[]
    local childs_ = {}

    local color_ = ui_color.Black
    local normal_color_ = ui_color.Black
    local hovered_color_ = ui_color.DimGray
    local pressed_color_ = ui_color.DarkGray

    local silent_ = false
    local visible_ = true

    local state_ = ui_state.Normal
    local hovered_ = false
    local pressed_ = false
    local toggled_ = false
    local toggle_mode_ = false
    local mouse_filter_ = false

    self.on_ready = Signal()

    self.on_hovered = Signal()
    self.on_pressed = Signal()
    self.on_toggled = Signal()
    self.on_dragging = Signal()

    self.on_size_changed = Signal()
    self.on_visibility_changed = Signal()

    self.on_child_entered_tree = Signal()
    self.on_child_exiting_tree = Signal()
    self.on_child_order_changed = Signal()

    ---@return integer
    function self.id()
        return id_
    end

    ---@return ui_type
    function self.type()
        return type_
    end

    function self.equal(other_id, other_type)
        return (id_ == other_id) and (type_ == other_type)
    end

    ---@param node Node
    function self.set_parent(node)
        if not node.equal(parent_id_, parent_type_) then
            if parent_ then
                parent_.on_child_exiting_tree.emit(self)
            end
            parent_ = node
            parent_id_ = node.id()
            parent_type_ = node.type()
            ui_set_object_parent(id_, type_, parent_id_, parent_type_)
            node.on_child_entered_tree.emit(self)
        end
    end

    ---@return Node|nil
    function self.get_parent()
        return parent_
    end

    ---@param node Node
    function self.add_child(node)
        node.set_parent(self)
    end

    ---@param node Node
    function self.remove_child(node)
        node.destroy()
    end

    ---@param index integer
    ---@return Node|nil
    function self.get_child(index)
        if index <= #childs_ then
            return childs_[index]
        end
    end

    function self.get_childs()
        return childs_
    end

    function self.get_child_count()
        return #childs_
    end

    ---@param x number
    ---@param y number
    local set_position_ = function(x, y)
        if ui_set_object_position(id_, type_, x, y) then
            pos_x_ = x
            pos_y_ = y
        end
    end

    ---@param x number
    ---@param y number
    function self.set_position(x, y)
        set_position_(x, y)
    end

    function self.get_position()
        return pos_x_, pos_y_
    end

    function self.get_absolute_position()
        if parent_ then
            local parent_x, parent_y = parent_.get_absolute_position()
            return pos_x_ + parent_x, pos_y_ + parent_y
        end
        return pos_x_, pos_y_
    end

    ---@param x number
    function self.set_pos_x(x)
        set_position_(x, pos_y_)
    end

    function self.get_pos_x()
        return pos_x_
    end

    ---@param y number
    function self.set_pos_y(y)
        set_position_(pos_x_, y)
    end

    function self.get_pos_y()
        return pos_y_
    end

    ---@param x number
    ---@param y number
    local set_size_ = function(x, y)
        if ui_set_object_size(id_, type_, x, y) then
            size_x_ = x
            size_y_ = y
            self.on_size_changed.emit(x, y)
        end
    end

    ---@param x number
    ---@param y number
    function self.set_size(x, y)
        set_size_(x, y)
    end

    function self.get_size()
        return size_x_, size_y_
    end

    ---@param x number
    ---@param y number
    function self.set_min_size(x, y)
        min_size_x_ = x
        min_size_y_ = y
        if parent_ then
            parent_.on_child_order_changed.emit()
        end
    end

    function self.get_min_size()
        return min_size_x_, min_size_y_
    end

    function self.get_min_size_x()
        return min_size_x_
    end

    function self.get_min_size_y()
        return min_size_y_
    end

    ---@param x number
    function self.set_size_x(x)
        set_size_(x, size_y_)
    end

    function self.get_size_x()
        return size_x_
    end

    ---@param y number
    function self.set_size_y(y)
        set_size_(size_x_, y)
    end

    function self.get_size_y()
        return size_y_
    end

    ---@param value ui_resize_dir
    function self.set_resize_dir(value)
        if value ~= resize_dir_ then
            resize_dir_ = value
            if parent_ then
                parent_.on_child_order_changed.emit()
            end
        end
    end

    ---@return ui_resize_dir
    function self.get_resize_dir()
        return resize_dir_
    end

    ---@param hexcolor ui_color|string
    function self.set_color(hexcolor)
        if ui_set_object_color(id_, type_, hexcolor) then
            color_ = hexcolor
        end
    end

    function self.get_color()
        return color_
    end

    ---@param hexcolor ui_color|string
    function self.set_normal_color(hexcolor)
        normal_color_ = hexcolor
        if state_ == ui_state.Normal then
            self.set_color(normal_color_)
        end
    end

    function self.get_normal_color()
        return normal_color_
    end

    ---@param hexcolor ui_color|string
    function self.set_hovered_color(hexcolor)
        hovered_color_ = hexcolor
        if state_ == ui_state.Hovered then
            self.set_color(hovered_color_)
        end
    end

    function self.get_hovered_color()
        return hovered_color_
    end

    ---@param hexcolor ui_color|string
    function self.set_pressed_color(hexcolor)
        pressed_color_ = hexcolor
        if state_ == ui_state.Pressed then
            self.set_color(pressed_color_)
        end
    end

    function self.get_pressed_color()
        return pressed_color_
    end

    ---@param value boolean
    function self.set_visible(value)
        if value and ui_show_object(id_, type_) then
            visible_ = true
            self.on_visibility_changed.emit(true)
        elseif not value and ui_hide_object(id_, type_) then
            visible_ = false
            self.on_visibility_changed.emit(false)
        end
    end

    function self.is_visible()
        return visible_
    end

    ---@param value boolean
    function self.set_silent(value)
        silent_ = value
    end

    function self.is_silent()
        return silent_
    end

    local on_mouse_entered_action_id
    local on_mouse_exited_action_id
    local on_mouse_pressed_action_id

    ---@param value boolean
    function self.set_mouse_filter(value)
        if value and not mouse_filter_ then
            on_mouse_entered_action_id = on_mouse_entered.action(function()
                self.on_hovered.emit(true)
            end, 0, id_, type_)

            on_mouse_exited_action_id = on_mouse_exited.action(function()
                self.on_hovered.emit(false)
            end, 0, id_, type_)

            on_mouse_pressed_action_id = on_mouse_pressed.action(function()
                if self.is_hovered() then
                    on_mouse_released.callback(function()
                        on_mouse_dragging.remove_callback()
                        self.on_pressed.emit(false)
                    end)

                    on_mouse_dragging.callback(function()
                        self.on_dragging.emit()
                    end, true)

                    self.on_pressed.emit(true)
                    return true
                end
            end)

            mouse_filter_ = true
        elseif not value and mouse_filter_ then
            on_mouse_entered.remove_action(on_mouse_entered_action_id)
            on_mouse_exited.remove_action(on_mouse_exited_action_id)
            on_mouse_pressed.remove_action(on_mouse_pressed_action_id)

            mouse_filter_ = false
        end
    end

    ---@param value ui_state
    ---@param signal? boolean
    function self.set_state(value, signal)
        state_ = value
        if signal then

        end
    end

    function self.get_state()
        return state_
    end

    function self.is_hovered()
        return hovered_
    end

    function self.is_pressed()
        return pressed_
    end

    ---@param value boolean
    function self.set_toggle_mode(value)
        toggle_mode_ = value
    end

    function self.destroy()
        if parent_ then
            parent_.on_child_exiting_tree.emit(self)
        end
        ui_destroy_object(id_, type_)
    end

    self.on_hovered.action(function(hovered)
        hovered_ = hovered
        if hovered_ and (state_ ~= ui_state.Pressed) then
            state_ = ui_state.Hovered
            self.set_color(hovered_color_)
        elseif not hovered_ and state_ ~= ui_state.Pressed then
            state_ = ui_state.Normal
            self.set_color(normal_color_)
        end
    end)

    self.on_pressed.action(function(pressed)
        if toggle_mode_ then
            if pressed then
                toggled_ = not toggled_
                pressed = toggled_
                self.on_toggled.emit(pressed)
            else
                return
            end
        end

        pressed_ = pressed
        if pressed_ then
            state_ = ui_state.Pressed
            self.set_color(pressed_color_)
        elseif hovered_ then
            state_ = ui_state.Hovered
            self.set_color(hovered_color_)
        else
            state_ = ui_state.Normal
            self.set_color(normal_color_)
        end
    end)

    ---@param node Node
    self.on_child_entered_tree.action(function(node)
        table.insert(childs_, node)
        self.on_child_order_changed.emit()
    end)

    ---@param node Node
    self.on_child_exiting_tree.action(function(node)
        for index, child in ipairs(childs_) do
            if child.equal(node.id(), node.type()) then
                table.remove(childs_, index)
                self.on_child_order_changed.emit()
                break
            end
        end
    end)

    self.on_size_changed.action(function(_, _)
        self.on_child_order_changed.emit()
    end)

    self.on_visibility_changed.action(function(value)
        if parent_ then
            parent_.on_child_order_changed.emit()
        end
    end)

    if parent_ then
        parent_.on_child_entered_tree.emit(self)
    end
    return self
end

---@param pos_x? number
---@param pos_y? number
---@param size_x? number
---@param size_y? number
---@param texture_id? integer
---@param parent_node? Node
function Image(pos_x, pos_y, size_x, size_y, texture_id, parent_node)
    pos_x = pos_x or 0
    pos_y = pos_y or 0
    size_x = size_x or 0
    size_y = size_y or 0
    texture_id = texture_id or ui_texture.Sample

    local id_ = -1
    local type_ = ui_type.Image
    if parent_node then
        id_ = ui_image(pos_x, pos_y, size_x, size_y, texture_id, parent_node.id(), parent_node.type())
    else
        id_ = ui_image(pos_x, pos_y, size_x, size_y, texture_id)
    end

    ---@class Image: Node
    local self = Node(pos_x, pos_y, size_x, size_y, id_, type_, parent_node)

    local mask_ = false

    function self.set_mask(value)
        if value and ui_set_object_mask(self.id(), self.type()) then
            mask_ = true
        elseif not value and ui_unset_object_mask(self.id(), self.type()) then
            mask_ = false
        end
    end

    self.set_mask(true)
    return self
end

---@param pos_x? number
---@param pos_y? number
---@param size_x? number
---@param size_y? number
---@param text_value? string
---@param font_size? integer
---@param parent_node? Node
function Text(pos_x, pos_y, size_x, size_y, text_value, font_size, parent_node)
    pos_x = pos_x or 0
    pos_y = pos_y or 0
    size_x = size_x or 0
    size_y = size_y or 0

    local value_ = text_value or ""
    local anchor_ = ui_anchor.MiddleLeft
    local font_size_ = font_size or 12
    local font_bold_ = false

    local id_ = -1
    local type_ = ui_type.Text
    if parent_node then
        id_ = ui_text(value_, font_size_, pos_x, pos_y, size_x, size_y, parent_node.id(), parent_node.type())
    else
        id_ = ui_text(value_, font_size_, pos_x, pos_y, size_x, size_y)
    end

    ---@class Text: Node
    local self = Node(pos_x, pos_y, size_x, size_y, id_, type_, parent_node)

    function self.set_value(text)
        if font_bold_ then
            text = "<b>" .. text .. "</b>"
        end

        if ui_set_text_value(self.id(), text) then
            value_ = text
        end
    end

    function self.get_value()
        return value_
    end

    ---@param value ui_anchor
    function self.set_align(value)
        if ui_set_text_align(self.id(), value) then
            anchor_ = value
        end
    end

    ---@param value integer
    function self.set_font_size(value)
        if ui_set_font_size(self.id(), self.type(), value) then
            font_size_ = value
        end
    end

    ---@param value boolean
    function self.set_font_bold(value)
        font_bold_ = value
        self.set_value(value_)
    end

    -- self.set_color(ui_color.White)
    self.set_align(anchor_)
    return self
end

---@param pos_x? number
---@param pos_y? number
---@param size_x? number
---@param size_y? number
---@param parent_node? Node
function Input(pos_x, pos_y, size_x, size_y, parent_node)
    pos_x = pos_x or 0
    pos_y = pos_y or 0
    size_x = size_x or 0
    size_y = size_y or 0

    local id_ = -1
    local type_ = ui_type.Input
    if parent_node then
        id_ = ui_input(pos_x, pos_y, size_x, size_y, parent_node.id(), parent_node.type())
    else
        id_ = ui_input(pos_x, pos_y, size_x, size_y)
    end

    ---@class Input: Node
    local self = Node(pos_x, pos_y, size_x, size_y, id_, type_, parent_node)

    local value_ = ""
    local placeholder_ = ""
    self.on_value_changed = Signal()

    ---@param value ui_input_type
    function self.set_type(value)
        ui_set_input_type(id_, value)
    end

    ---@param text string
    function self.set_value(text)
        if ui_set_input_text(id_, text) then
            value_ = text
        end
    end

    function self.get_value()
        return value_
    end

    ---@param text string
    function self.set_placeholder(text)
        if ui_set_input_placeholder(id_, text) then
            placeholder_ = text
        end
    end

    function self.get_placeholder()
        return placeholder_
    end

    ---@param value integer
    function self.set_limit(value)
        ui_set_input_limit(id_, value)
    end

    ---@param value boolean
    function self.set_readonly(value)
        ui_set_input_readonly(id_, value)
    end

    function self.set_font_size(value)
        ui_set_font_size(id_, type_, value)
    end

    ---@param hexcolor ui_color|string
    function self.set_bg_color(hexcolor)
        ui_set_input_bg_color(id_, hexcolor)
    end

    on_input_change.action(function(_, text)
        value_ = text
        self.on_value_changed.emit(text)
    end, 0, id_)
    return self
end

-------------------------------------------
--- Custom Objects

---@param pos_x? number
---@param pos_y? number
---@param size_x? number
---@param size_y? number
---@param parent_node? Node
function Panel(pos_x, pos_y, size_x, size_y, parent_node)
    ---@class Panel: Image
    local self = Image(pos_x, pos_y, size_x, size_y, nil, parent_node)

    ui_unset_object_mouse_filter(self.id(), self.type())
    self.set_color(ui_color.Black .. "ee")
    return self
end

---@param parent_node Node
function Spacer(parent_node)
    ---@class Spacer: Panel
    local self = Panel(0, 0, 0, 0, parent_node)

    self.set_resize_dir(ui_resize_dir.Both)
    self.set_color(ui_color.None)
    return self
end

---@param pos_x? number
---@param pos_y? number
---@param size_x? number
---@param size_y? number
---@param parent_node? Node
function Container(pos_x, pos_y, size_x, size_y, parent_node)
    ---@class Container: Panel
    local self = Panel(pos_x, pos_y, size_x, size_y, parent_node)

    self.on_sort_childs = Signal()

    local content_offset_left_ = 0
    local content_offset_top_ = 0
    local content_offset_right_ = 0
    local content_offset_bottom_ = 0
    local content_gutter_width_ = 0

    local set_content_offset_ = function(left, top, right, bottom, gutter)
        content_offset_left_ = left
        content_offset_top_ = top
        content_offset_right_ = right
        content_offset_bottom_ = bottom
        content_gutter_width_ = gutter
        self.on_sort_childs.emit()
    end

    ---@param left number
    ---@param top number
    ---@param right number
    ---@param bottom number
    ---@param gutter number
    function self.set_content_offset(left, top, right, bottom, gutter)
        set_content_offset_(left, top, right, bottom, gutter)
    end

    ---@param value number
    function self.set_content_offset_left(value)
        set_content_offset_(value, content_offset_top_, content_offset_right_, content_offset_bottom_,
            content_gutter_width_)
    end

    ---@param value number
    function self.set_content_offset_top(value)
        set_content_offset_(content_offset_left_, value, content_offset_right_, content_offset_bottom_,
            content_gutter_width_)
    end

    ---@param value number
    function self.set_content_offset_right(value)
        set_content_offset_(content_offset_left_, content_offset_top_, value, content_offset_bottom_,
            content_gutter_width_)
    end

    ---@param value number
    function self.set_content_offset_bottom(value)
        set_content_offset_(content_offset_left_, content_offset_top_, content_offset_right_, value,
            content_gutter_width_)
    end

    ---@param value number
    function self.set_content_gutter_width(value)
        set_content_offset_(content_offset_left_, content_offset_top_, content_offset_right_, content_offset_bottom_,
            value)
    end

    ---@return number left
    ---@return number top
    ---@return number right
    ---@return number bottom
    ---@return number gutter
    function self.get_content_offset()
        return content_offset_left_, content_offset_top_, content_offset_right_, content_offset_bottom_,
            content_gutter_width_
    end

    function self.add_spacer()
        self.add_child(Spacer(self))
    end

    self.on_child_order_changed.action(function(_)
        if not self.is_silent() then
            self.on_sort_childs.emit()
        end
    end)

    return self
end

---@param pos_x? number
---@param pos_y? number
---@param size_x? number
---@param size_y? number
---@param parent_node? Node
function HBox(pos_x, pos_y, size_x, size_y, parent_node)
    ---@class HBox: Container
    local self = Container(pos_x, pos_y, size_x, size_y, parent_node)

    self.on_sort_childs.action(function()
        local x, y = self.get_size()
        local left, top, right, bottom, gutter = self.get_content_offset()

        local c = 0
        local c_i = {}
        local e = 0
        local e_i = {}
        local w = 0

        local childs = self.get_childs()
        for index, child in ipairs(childs) do
            if child.is_visible() then
                c = c + 1
                c_i[c] = index

                local c_resize_dir = child.get_resize_dir()
                if (c_resize_dir == ui_resize_dir.Both) or (c_resize_dir == ui_resize_dir.Horizontal) then
                    e = e + 1
                    e_i[c] = index
                else
                    w = w + child.get_min_size_x()
                    e_i[c] = 0
                end
            end
        end

        if c > 0 then
            local g_x = (c - 1) * gutter
            local e_x = (x - w - g_x - left - right) / ((e > 0) and e or 1)

            local offset_x = left
            local offset_y = top
            local height = y - top - bottom
            for i = 1, c do
                local idx = c_i[i]
                local child = childs[idx]
                local width = 0
                child.set_position(offset_x, offset_y)
                if e_i[i] > 0 then
                    child.set_size(e_x, height)
                    width = e_x
                else
                    width = child.get_min_size_x()
                    child.set_size(width, height)
                end
                offset_x = offset_x + width + gutter
            end
        end
    end)

    return self
end

---@param pos_x? number
---@param pos_y? number
---@param size_x? number
---@param size_y? number
---@param parent_node? Node
function VBox(pos_x, pos_y, size_x, size_y, parent_node)
    ---@class VBox: Container
    local self = Container(pos_x, pos_y, size_x, size_y, parent_node)

    self.on_sort_childs.action(function()
        local x, y = self.get_size()
        local left, top, right, bottom, gutter = self.get_content_offset()

        local c = 0
        local c_i = {}
        local e = 0
        local e_i = {}
        local h = 0

        local childs = self.get_childs()
        for index, child in ipairs(childs) do
            if child.is_visible() then
                c = c + 1
                c_i[c] = index

                local c_resize_dir = child.get_resize_dir()
                if (c_resize_dir == ui_resize_dir.Both) or (c_resize_dir == ui_resize_dir.Vertical) then
                    e = e + 1
                    e_i[c] = index
                else
                    h = h + child.get_min_size_y()
                    e_i[c] = 0
                end
            end
        end

        if c > 0 then
            local g_y = (c - 1) * gutter
            local e_y = (y - h - g_y - top - bottom) / ((e > 0) and e or 1)

            local offset_x = left
            local offset_y = top
            local width = x - left - right
            for i = 1, c do
                local idx = c_i[i]
                local child = childs[idx]
                local height = 0
                child.set_position(offset_x, offset_y)
                if e_i[i] > 0 then
                    child.set_size(width, e_y)
                    height = e_y
                else
                    height = child.get_min_size_y()
                    child.set_size(width, height)
                end
                offset_y = offset_y + height + gutter
            end
        end
    end)

    return self
end

---@param pos_x number
---@param pos_y number
---@param size_x number
---@param size_y number
---@param title? string
function Window(pos_x, pos_y, size_x, size_y, title)
    ---@class Window: VBox
    local self = VBox(pos_x, pos_y, size_x, size_y)

    local header_ = HBox(0, 0, 0, 32, self)
    header_.set_resize_dir(ui_resize_dir.Horizontal)
    header_.set_color(ui_color.DarkGray .. "ee")
    header_.set_content_offset(10, 0, 0, 0, 10)

    local header_box_ = HBox()
    header_box_.set_visible(false)
    header_.add_child(header_box_)

    local content_ = Container(0, 0, 0, 0, self)
    content_.set_color(ui_color.None)

    ---@type Node
    local content_child_

    local footer_ = HBox(0, 0, 0, 24, self)
    footer_.set_resize_dir(ui_resize_dir.Horizontal)
    footer_.set_color(ui_color.DarkGray .. "ee")
    footer_.set_content_offset(10, 0, 0, 0, 10)

    local footer_box_ = HBox()
    footer_box_.set_visible(false)
    footer_.add_child(footer_box_)
    footer_.add_spacer()

    local title_ = Text()
    title_.set_font_size(16)
    title_.set_normal_color(ui_color.DimGray)
    title_.set_hovered_color(ui_color.DimGray)
    title_.set_pressed_color(ui_color.DimGray)
    title_.set_mouse_filter(true)

    if title then
        title_.set_value(title)
    end

    header_.add_child(title_)

    local close_ = Text(0, 0, 32, 0, ui_symbol.Close, 12, header_)
    close_.set_resize_dir(ui_resize_dir.Vertical)
    close_.set_align(ui_anchor.MiddleCenter)
    close_.set_normal_color(ui_color.DimGray)
    close_.set_hovered_color(ui_color.White)
    close_.set_pressed_color(ui_color.DimGray)
    close_.set_mouse_filter(true)

    local resize_ = Text(0, 0, 24, 0, ui_symbol.Resize, 20, footer_)
    resize_.set_resize_dir(ui_resize_dir.Vertical)
    resize_.set_align(ui_anchor.MiddleCenter)
    resize_.set_normal_color(ui_color.DimGray)
    resize_.set_hovered_color(ui_color.White)
    resize_.set_pressed_color(ui_color.DimGray)
    resize_.set_mouse_filter(true)

    self.on_resizing = Signal()
    self.on_close = Signal()

    self.set_title = title_.set_value
    self.get_title = title_.get_value

    function self.get_header_box()
        return header_box_
    end

    function self.get_footer_box()
        return header_box_
    end

    title_.on_dragging.action(function()
        local x, y = self.get_position()
        self.set_position(
            x + (mouse_x_spd * mouse_x_dir),
            y + (mouse_y_spd * mouse_y_dir)
        )
    end)

    close_.on_pressed.action(function(pressed)
        if pressed then
            self.set_visible(false)
            self.on_close.emit()
        else
            close_.on_hovered.emit(false)
        end
    end)

    resize_.on_dragging.action(function()
        local x, y = self.get_size()
        local min_x, min_y = self.get_min_size()
        local w = x + (mouse_x_spd * mouse_x_dir)
        local h = y + (mouse_y_spd * mouse_y_dir)
        self.set_size(math.max(min_x, w), math.max(min_y, h))
    end)

    resize_.on_pressed.action(function(pressed)
        if not pressed then
            if content_child_ then
                content_child_.set_size(content_.get_size())
            end
        end
    end)

    content_.on_sort_childs.action(function()

    end)

    self.on_child_entered_tree.action(function(node)
        if self.get_child_count() > 2 then
            node.set_parent(content_)
            node.set_position(0, 0)
            node.set_size(content_.get_size())
            content_child_ = node
        end
    end)

    return self
end

---@param pos_x? number
---@param pos_y? number
---@param size_x? number
---@param size_y? number
---@param text_value? string
---@param font_size? integer
---@param parent_node? Node
function Label(pos_x, pos_y, size_x, size_y, text_value, font_size, parent_node)
    ---@class Label: Text
    local self = Text(pos_x, pos_y, size_x, size_y, text_value, font_size, parent_node)

    ui_unset_object_mouse_filter(self.id(), self.type())
    return self
end

---@param pos_x? number
---@param pos_y? number
---@param size_x? number
---@param size_y? number
---@param text_value? string
---@param font_size? integer
---@param parent_node? Node
function Button(pos_x, pos_y, size_x, size_y, text_value, font_size, parent_node)
    ---@class Button: Image
    local self = Image(pos_x, pos_y, size_x, size_y, nil, parent_node)
    local label_ = Label(0, 0, size_x, size_y, text_value, font_size, self)

    self.set_text_value = label_.set_value
    self.set_text_align = label_.set_align
    self.set_font_size = label_.set_font_size
    self.set_font_bold = label_.set_font_bold
    self.set_text_color = label_.set_color

    self.on_child_order_changed.action(function()
        label_.set_size(self.get_size())
    end)

    self.set_normal_color(ui_color.None)
    self.set_hovered_color(ui_color.Gray)
    self.set_pressed_color(ui_color.None)
    self.set_text_align(ui_anchor.MiddleCenter)
    self.set_mouse_filter(true)
    return self
end

---@param pos_x? number
---@param pos_y? number
---@param size? number
---@param parent_node? Node
function CheckBox(pos_x, pos_y, size, parent_node)
    ---@class CheckBox: Text
    ---@field private set_value fun(text: string)
    ---@field private set_align fun(value: ui_anchor)
    ---@field private set_font_size fun(value: number)
    ---@field private set_font_bold fun(value: boolean)
    local self = Text(pos_x, pos_y, size, size, ui_symbol.CheckOff, 16, parent_node)

    self.on_toggled.action(function(toggled)
        if toggled then
            self.set_value(ui_symbol.CheckOn)
        else
            self.set_value(ui_symbol.CheckOff)
        end
    end)

    self.set_normal_color(ui_color.DarkGray)
    self.set_hovered_color(ui_color.DimGray)
    self.set_pressed_color(ui_color.White)

    self.on_toggled.emit(false)
    self.set_toggle_mode(true)
    self.set_align(ui_anchor.MiddleCenter)
    self.set_mouse_filter(true)
    return self
end

---@param horizontal? boolean
---@param background_color? ui_color|string
---@param progress_color? ui_color|string
---@param parent_node? Node
function ProgressBar(horizontal, background_color, progress_color, parent_node)
    local background_color_ = background_color or ui_color.Black
    local progress_color_ = progress_color or ui_color.DimGray
    local horizontal_ = horizontal and true or false

    ---@class ProgressBar: Panel
    local self = Panel(0, 0, 0, 0, parent_node)
    local line_ = Panel(0, 0, 0, 0, self)

    local value_ = 0

    function self.set_value(value)
        value_ = clamp_value(value, 0, 1)
        if horizontal_ then
            line_.set_size_x(self.get_size_x() * value)
        else
            line_.set_size_y(self.get_size_y() * value)
        end
    end

    ---@param hexcolor ui_color|string
    function self.set_value_color(hexcolor)
        line_.set_color(hexcolor)
    end

    self.on_size_changed.action(function(x, y)
        if horizontal_ then
            line_.set_size(value_ / x, y)
        else
            line_.set_size(x, value_ / y)
        end
    end)

    self.set_color(background_color_)
    line_.set_color(progress_color_)
    return self
end

---@param horizontal? boolean
---@param parent_node? Node
function ScrollBar(horizontal, parent_node)
    local horizontal_ = horizontal and true or false

    ---@class ScrollBar: Image
    local self = Image(0, 0, 0, 0, nil, parent_node)
    local grabber_ = Image(0, 0, 0, 0, nil, self)

    local value_ = 0
    self.on_value_changed = Signal()

    ---@param value number
    function self.set_value(value)
        value = clamp_value(value, 0, 1)
        if horizontal_ then
            grabber_.set_pos_x((self.get_size_x() - grabber_.get_size_x()) * value)
        else
            grabber_.set_pos_y((self.get_size_y() - grabber_.get_size_y()) * value)
        end
        self.on_value_changed.emit(value)
    end

    grabber_.on_dragging.action(function()
        local max, pos
        if horizontal_ then
            max = self.get_size_x() - grabber_.get_size_x()
            pos = grabber_.get_pos_x() + mouse_x_spd * mouse_x_dir
        else
            max = self.get_size_y() - grabber_.get_size_y()
            pos = grabber_.get_pos_y() + mouse_y_spd * mouse_y_dir
        end

        if pos >= 0 and pos <= max then
            if horizontal_ then
                grabber_.set_pos_x(pos)
            else
                grabber_.set_pos_y(pos)
            end

            if max == 0 then
                max = 1
            end
            value_ = pos / max
            self.on_value_changed.emit(value_)
        end
    end)

    self.on_pressed.action(function(pressed)
        if pressed and not grabber_.is_pressed() then
            local pos_x, pos_y = self.get_absolute_position()
            if horizontal_ then
                self.set_value((mouse_x - pos_x) / self.get_size_x())
            else
                self.set_value((mouse_y - pos_y) / self.get_size_y())
            end
        end
    end)

    self.on_size_changed.action(function(x, y)
        if horizontal_ then
            grabber_.set_size(50, y)
            grabber_.set_pos_x((x - grabber_.get_size_x()) * value_)
        else
            grabber_.set_size(x, 50)
            grabber_.set_pos_y((y - grabber_.get_size_y()) * value_)
        end

        self.on_value_changed.emit(value_)
    end)

    grabber_.set_normal_color(ui_color.DimGray)
    grabber_.set_hovered_color(ui_color.White .. "aa")
    grabber_.set_pressed_color(ui_color.White .. "aa")

    self.set_normal_color(ui_color.None)
    self.set_hovered_color(ui_color.None)
    self.set_pressed_color(ui_color.None)

    grabber_.set_mouse_filter(true)
    self.set_mouse_filter(true)
    return self
end

---@param pos_x? number
---@param pos_y? number
---@param size_x? number
---@param size_y? number
---@param parent_node? Node
function ItemList(pos_x, pos_y, size_x, size_y, parent_node)
    local rows_ = 0
    local columns_ = 0

    local item_height_ = 24
    local item_gutter_ = 1
    local scroll_size_ = 6

    ---@class ItemList: HBox
    local self = HBox(pos_x, pos_y, size_x, size_y, parent_node)
    self.set_color(ui_color.None)

    local content_ = Panel(0, 0, 0, 0, self)
    content_.set_color(ui_color.None)

    local item_list_ = VBox(0, 0, 0, 0, content_)
    item_list_.set_content_gutter_width(1)
    item_list_.set_color(ui_color.Gray .. "22")

    self.on_sort_childs.action(function()
        item_list_.set_size_x(content_.get_size_x())
    end)

    -- local progress_bar_ = ProgressBar(false, ui_color.Black, ui_color.White .. "22", self)
    -- progress_bar_.set_resize_dir(ui_resize_dir.Vertical)
    -- progress_bar_.set_min_size(2, 0)

    local scroll_bar_ = ScrollBar(false, self)
    scroll_bar_.set_resize_dir(ui_resize_dir.Vertical)
    scroll_bar_.set_min_size(scroll_size_, 0)

    self.on_filter_items = Signal()
    self.on_items_changed = Signal()

    ---@param n integer
    ---@param callback fun(index: integer, item: Node): Node
    function self.add_items(n, callback)
        --- there can be many sortings
        item_list_.set_silent(true)

        local item = item_list_.get_child(1)
        local item_count = item_list_.get_child_count()

        local item_init = false
        if not item then
            item = HBox(0, 0, 0, item_height_, item_list_)
            item.set_resize_dir(ui_resize_dir.Horizontal)
            item.set_content_offset(10, 0, 10, 0, 10)
            item_init = true
        end

        item = callback(1, item)
        local item_childs = item.get_childs()

        rows_ = item_count + n
        columns_ = #item_childs

        local start = os.clock()

        local y = 0
        local width = item_list_.get_size_x()
        for i = item_count + 1, rows_ do
            on_update.task(function()
                local row
                if item_init then
                    row = item
                    item_init = false
                else
                    ---@type HBox
                    row = callback(i, HBox(0, y, 0, item_height_, item_list_))
                    row.set_resize_dir(ui_resize_dir.Horizontal)
                    row.set_content_offset(10, 0, 10, 0, 10)
                end

                row.set_pos_y(y)
                row.set_size(width, item_height_)
                y = y + item_height_ + item_gutter_
                item_list_.set_size_y(y)

                self.on_items_changed.emit(rows_, i)
                -- if y >= h then -- follow
                --     scroll_bar_.set_value((y - h) / h)
                -- end
            end)
        end

        on_update.task(function()
            print(os.clock() - start)
            item_list_.set_silent(false)
            self.on_ready.emit()
        end)
    end

    ---@param idx integer
    ---@param value number
    function self.set_column_width(idx, value)
        if idx > 0 and idx <= columns_ then
            -- columns_width_[idx] = value
            -- content_.sort_childs()
        end
    end

    scroll_bar_.on_value_changed.action(function(value)
        local h = item_list_.get_size_y() - content_.get_size_y()
        local pos = -1 * h * value
        item_list_.set_pos_y(pos)
    end)

    self.on_filter_items.action(function(column, value)
        if column <= columns_ then
            scroll_bar_.set_value(0)
            item_list_.set_silent(true)
            
            if value == "" then
                for _, item in ipairs(item_list_.get_childs()) do
                    item.set_visible(true)
                end
                self.on_items_changed.emit(rows_, rows_)
            else
                local status, result = pcall(string.find, "", value)
                if not status then
                    return
                end

                local c = 0
                for index, item in ipairs(item_list_.get_childs()) do
                    local item_column = item.get_childs()[column]

                    ---@cast item_column Label
                    local text = item_column.get_value()
                    
                    local r = string.find(text, value)
                    if r then
                        c = c + 1
                        item.set_visible(true)
                    else
                        item.set_visible(false)
                    end
                end
                self.on_items_changed.emit(rows_, c)
            end
            
            item_list_.set_silent(false)
            item_list_.on_sort_childs.emit()
        end
    end)

    return self
end

-------------------------------------------
--- Player

function Player()
    ---@class Player
    local self = {}
    self.on_relogin = Signal()

    local nickname_ = ""
    local combat_mode_ = false

    local adventurer_xp_ = 0
    local adventurer_xp_lvl_ = 0
    local adventurer_xp_att_ = false
    local adventurer_xp_pooled_ = 0
    local adventurer_xp_stored_ = 0
    local adventurer_xp_progress_ = 0

    local producer_xp_ = 0
    local producer_xp_lvl_ = 0
    local producer_xp_att_ = false
    local producer_xp_pooled_ = 0
    local producer_xp_stored_ = 0
    local producer_xp_progress_ = 0

    local relogin_ = true

    local xp_ = { 0 }
    do -- floor(previous_level_exp * 1.1 + 1000)
        local xp = 0
        for _ = 2, 200, 1 do
            xp = math.floor(xp * 1.1 + 1000)
            table.insert(xp_, xp)
        end
    end

    local progress_xp_ = function(xp, lvl)
        return (xp - xp_[lvl]) / (xp_[lvl + 1] - xp_[lvl])
    end

    local update_xp_ = function()
        adventurer_xp_ = get_adventurer_total_xp()
        adventurer_xp_att_ = get_adventurer_attenuation_status()
        adventurer_xp_pooled_ = get_adventurer_pooled_xp()

        producer_xp_ = get_producer_total_xp()
        producer_xp_att_ = get_producer_attenuation_status()
        producer_xp_pooled_ = get_producer_pooled_xp()

        if (adventurer_xp_lvl_ + producer_xp_lvl_) > 1 then
            adventurer_xp_progress_ = progress_xp_(adventurer_xp_, adventurer_xp_lvl_)
            producer_xp_progress_ = progress_xp_(producer_xp_, producer_xp_lvl_)

            if adventurer_xp_progress_ >= 1 then
                adventurer_xp_lvl_ = adventurer_xp_lvl_ + 1
                adventurer_xp_progress_ = progress_xp_(adventurer_xp_, adventurer_xp_lvl_)
            end

            if producer_xp_progress_ >= 1 then
                producer_xp_lvl_ = producer_xp_lvl_ + 1
                producer_xp_progress_ = progress_xp_(producer_xp_, producer_xp_lvl_)
            end
        end
    end

    local store_xp_ = function()
        adventurer_xp_stored_ = adventurer_xp_
        producer_xp_stored_ = producer_xp_
    end

    function self.adventurer_xp() return adventurer_xp_ end

    function self.adventurer_xp_att() return adventurer_xp_att_ end

    function self.adventurer_xp_pooled() return adventurer_xp_pooled_ end

    function self.adventurer_xp_gained()
        local n = adventurer_xp_ - adventurer_xp_stored_
        if n > 0 then
            return n
        end
        return adventurer_xp_
    end

    function self.adventurer_xp_progress() return adventurer_xp_progress_ end

    function self.adventurer_level() return adventurer_xp_lvl_ end

    function self.producer_xp() return producer_xp_ end

    function self.producer_xp_att() return producer_xp_att_ end

    function self.producer_xp_pooled() return producer_xp_pooled_ end

    function self.producer_xp_gained()
        local n = producer_xp_ - producer_xp_stored_
        if n > 0 then
            return n
        end
        return producer_xp_
    end

    function self.producer_xp_progress() return producer_xp_progress_ end

    function self.producer_level() return producer_xp_lvl_ end

    function self.reset_xp()
        update_xp_()
        store_xp_()
    end

    on_redraw.action(function()
        combat_mode_ = get_player_combat_mode()
        update_xp_()
    end, 1)

    on_scene_loaded.action(function(_)
        self.on_relogin.emit()
    end)

    self.on_relogin.action(function()
        local name = get_player_name()
        if nickname_ ~= name then
            print("Hello " .. name)
            update_xp_()
            nickname_ = name
            producer_xp_lvl_ = 0
            adventurer_xp_lvl_ = 0

            for index, value in ipairs(xp_) do
                if adventurer_xp_lvl_ == 0 and value > adventurer_xp_ then
                    adventurer_xp_lvl_ = index - 1
                end

                if producer_xp_lvl_ == 0 and value > producer_xp_ then
                    producer_xp_lvl_ = index - 1
                end
            end
        end
    end)

    self.on_relogin.emit()
    return self
end

-------------------------------------------
--- Main

function ShroudOnMouseOver(id, type)
    on_mouse_entered.emit(id, type)
end

function ShroudOnMouseOut(id, type)
    on_mouse_exited.emit(id, type)
end

function ShroudOnSceneLoaded(scene_name)
    on_scene_loaded.emit(scene_name)
end

function ShroudOnSceneUnloaded()
    on_scene_unloaded.emit()
end

function ShroudOnInputChange(id, text)
    on_input_change.emit(id, text)
end

function ShroudOnLogout()
    on_logout.emit()
end

ShroudDeltaTime = 0

function ShroudOnUpdate()
    on_redraw.emit(ShroudDeltaTime)
    on_update.resume()
end

function ShroudOnStart()
    ---@diagnostic disable: undefined-global

    ui_type = UI
    ui_anchor = TextAnchor
    ui_input_type = ContentType

    ui_panel = ShroudUIPanel
    ui_text = ShroudUIText
    ui_input = ShroudUIInput
    ui_image = ShroudUIImage
    ui_destroy_object = ShroudDestroyObject
    ui_set_object_parent = ShroudSetParent
    ui_set_object_size = ShroudSetSize
    ui_set_object_position = ShroudSetPosition
    ui_set_object_rotation = ShroudRotateObject
    ui_set_object_pivot = ShroudSetPivot
    ui_set_object_scale = ShroudSetScale
    ui_set_object_color = ShroudSetColor
    ui_set_object_mask = ShroudSetMask
    ui_unset_object_mask = ShroudUnsetMask
    ui_set_object_opacity = ShroudSetTransparency
    ui_show_object = ShroudShowObject
    ui_hide_object = ShroudHideObject
    ui_set_object_draggable = ShroudSetDragguable
    ui_unset_object_draggable = ShroudUnsetDragguable
    ui_set_object_resizable = ShroudSetResizable
    ui_set_object_mouse_filter = ShroudSetInOutListener
    ui_unset_object_mouse_filter = ShroudUnsetInOutListener
    ui_set_text_value = ShroudModifyText
    ui_set_text_align = ShroudSetTextAlignment
    ui_set_font_size = ShroudSetFontSize

    ui_get_input_text = ShroudGetInputText
    ui_set_input_text = ShroudSetInputText
    ui_set_input_type = ShroudSetInputContentType
    ui_set_input_placeholder = ShroudSetPlaceholderText
    ui_set_input_bg_color = ShroudSetInputBackgroundColor
    ui_set_input_limit = ShroudSetInputCharacterLimit
    ui_set_input_readonly = ShroudSetInputReadonly

    ui_image_texture = ShroudLoadTexture
    ui_texture.Sample = ui_image_texture("sample.png", true)

    ui_show = ShroudShowLuaUI
    ui_hide = ShroudHideLuaUI

    get_screen_size_x = ShroudGetScreenX
    get_screen_size_y = ShroudGetScreenY

    is_key_pressed = ShroudGetOnKeyDown
    is_key_released = ShroudGetOnKeyUp

    get_player_name = ShroudGetPlayerName
    get_player_combat_mode = ShroudGetPlayerCombatMode
    get_adventurer_total_xp = ShroudGetTotalAdventurerExperience
    get_adventurer_pooled_xp = ShroudGetPooledAdventurerExperience
    get_adventurer_attenuation_status = ShroudGetAttenuationAdventurerStatus
    get_producer_total_xp = ShroudGetTotalProducerExperience
    get_producer_pooled_xp = ShroudGetPooledProducerExperience
    get_producer_attenuation_status = ShroudGetAttenuationProducerStatus

    get_player_stat_count = ShroudGetStatCount
    get_player_stat_name = ShroudGetStatNameByNumber
    get_player_stat_value = ShroudGetStatValueByNumber
    get_player_stat_value_by_name = ShroudGetStatValueByName
    get_player_stat_description = ShroudGetStatDescriptionByNumber

    ShroudUseLuaConsoleForPrint(true)

    on_update.action(function()
        if is_key_pressed(key_code.MouseButtonLeft) then
            mouse_button_left_pressed = true
            on_mouse_pressed.emit()
        elseif is_key_released(key_code.MouseButtonLeft) then
            mouse_button_left_pressed = false
            on_mouse_released.emit()
        elseif is_key_released(key_code.Return) then
            on_key_released.emit(key_code.Return)
        end

        local m_x, m_y = ShroudMouseX, ShroudMouseY
        if mouse_button_left_pressed then
            if m_x > mouse_x then
                mouse_x_dir = 1
                mouse_x_spd = m_x - mouse_x
            elseif m_x < mouse_x then
                mouse_x_dir = -1
                mouse_x_spd = mouse_x - m_x
            else
                mouse_x_dir = 0
                mouse_x_spd = 0
            end

            if m_y > mouse_y then
                mouse_y_dir = 1
                mouse_y_spd = m_y - mouse_y
            elseif m_y < mouse_y then
                mouse_y_dir = -1
                mouse_y_spd = mouse_y - m_y
            else
                mouse_y_dir = 0
                mouse_y_spd = 0
            end

            if (mouse_x ~= m_x) or (mouse_y ~= m_y) then
                on_mouse_dragging.emit()
            end
        end
        mouse_x = m_x
        mouse_y = m_y

        local s_x, s_y = get_screen_size_x(), get_screen_size_y()
        if (screen_size_x ~= s_x) or (screen_size_y ~= s_y) then
            on_screen_changed.emit()
        end
        screen_size_x = s_x
        screen_size_y = s_y
    end)

    ---@diagnostic enable: undefined-global
end

local use_test = function()
    on_update.task(function()
        local color = ui_color.Black .. "ee"

        local input = Input(100, 200, 300, 32)
        
        input.on_value_changed.action(function(text)
            print(text)
        end)
    end)
end

local use_sample = function()
    ---comment
    ---@param index integer
    ---@param node Node
    ---@return Node
    local stat_list_item = function(index, node)
        local idx = Label(0, 0, 32, 0, tostring(index), 12, node)
        idx.set_resize_dir(ui_resize_dir.Vertical)

        local name = Label(0, 0, 0, 0, get_player_stat_name(index), 12, node)

        local value = Label(0, 0, 120, 0, tostring(get_player_stat_value(index)), 12, node)
        value.set_resize_dir(ui_resize_dir.Vertical)

        local check = CheckBox(0, 0, 24, node)
        check.set_resize_dir(ui_resize_dir.Vertical)
        return node
    end

    on_update.task(function()
        local player = Player()

        -----------------------------------
        --- Taskbar

        local taskbar = HBox(0, 0, screen_size_x, 24)
        taskbar.set_color(ui_color.Black .. "fc")
        taskbar.set_content_offset(10, 2, 10, 2, 10)

        local taskbar_left = HBox(0, 0, 0, 0, taskbar)
        taskbar_left.set_color(ui_color.None)

        local taskbar_center = HBox(0, 0, 400, 0, taskbar)
        taskbar_center.set_resize_dir(ui_resize_dir.Vertical)
        taskbar_center.set_color(ui_color.None)

        local taskbar_right = HBox(0, 0, 0, 0, taskbar)
        taskbar_right.set_color(ui_color.None)
        taskbar_right.add_spacer()

        local taskbar_border = Panel(0, 24, screen_size_x, 1)
        taskbar_border.set_color(ui_color.White .. "22")

        on_screen_changed.action(function()
            taskbar.set_size_x(screen_size_x)
            taskbar_border.set_size_x(screen_size_x)
        end)

        -----------------------------------
        --- Left

        local menu_button = Button(0, 0, 32, 0, ui_symbol.Menu, 14, taskbar_left)
        menu_button.set_resize_dir(ui_resize_dir.Vertical)

        local stats_button = Button(0, 0, 40, 0, "Stats", 12, taskbar_left)
        stats_button.set_resize_dir(ui_resize_dir.Vertical)
        stats_button.set_hovered_color(ui_color.DimGray)
        stats_button.set_pressed_color(ui_color.Gray)
        stats_button.set_toggle_mode(true)

        -----------------------------------
        --- Player Stats

        local stats = Window(500, 100, 600, 400)
        stats.set_visible(false)

        local stat_list = ItemList(0, 0, 0, 0, stats)
        stat_list.add_items(get_player_stat_count(), stat_list_item)
        -- stat_list.add_items(50, stat_list_item)

        stats_button.on_toggled.action(function(pressed)
            stats.set_visible(pressed)
        end)

        stats.on_close.action(function()
            stats_button.on_pressed.emit(true)
        end)

        --- test
        stats_button.on_pressed.emit(true)

        local stats_filter = Input(0, 0, 200, 28)
        stats_filter.set_resize_dir(ui_resize_dir.Node)
        stats_filter.set_bg_color(ui_color.Black .. "ee")
        stats_filter.set_color(ui_color.White)
        stats_filter.set_placeholder("filter by name ...")
        stats_filter.set_font_size(12)
        stats_filter.set_readonly(true)

        stat_list.on_ready.action(function()
            stats_filter.set_readonly(false)
        end)

        stats_filter.on_value_changed.action(function(text)
            stat_list.on_filter_items.emit(2, text)
        end)

        local stats_count = Label()
        stats_count.set_font_size(16)
        stats_count.set_color(ui_color.DimGray)

        stat_list.on_items_changed.action(function(total, visible)
            
            stats_count.set_value(total .. " : " .. visible)
        end)

        local stats_header = stats.get_header_box()
        stats_header.set_color(ui_color.None)
        stats_header.set_content_offset(0, 2, 0, 2, 10)
        stats_header.set_min_size(300, 0)
        stats_header.set_resize_dir(ui_resize_dir.Vertical)

        stats_header.add_child(stats_filter)
        stats_header.add_child(stats_count)
        stats_header.set_visible(true)

        -----------------------------------
        --- Center

        local stopwatch = Button(0, 0, 80)
        stopwatch.set_resize_dir(ui_resize_dir.Vertical)
        stopwatch.set_text_value("00:00:00")
        stopwatch.set_font_size(16)
        stopwatch.set_font_bold(true)

        local stopwatch_value = os.time()
        on_redraw.action(function()
            stopwatch.set_text_value(clock_value(os.time() - stopwatch_value))
        end, 1)

        stopwatch.on_pressed.action(function()
            stopwatch_value = os.time()
            player.reset_xp()
        end)

        local adventurer_xp = Label()
        adventurer_xp.set_align(ui_anchor.MiddleRight)

        local adventurer_level = Label(0, 0, 60)
        adventurer_level.set_align(ui_anchor.MiddleCenter)
        adventurer_level.set_resize_dir(ui_resize_dir.Vertical)
        adventurer_level.set_font_size(11)

        local producer_xp = Label()
        producer_xp.set_align(ui_anchor.MiddleLeft)

        local producer_level = Label(0, 0, 60)
        producer_level.set_align(ui_anchor.MiddleCenter)
        producer_level.set_resize_dir(ui_resize_dir.Vertical)
        producer_level.set_font_size(11)

        on_redraw.action(function()
            local a_xp = player.adventurer_xp_gained()
            local a_progress = math.floor(player.adventurer_xp_progress() * 100)

            local p_xp = player.producer_xp_gained()
            local p_progress = math.floor(player.producer_xp_progress() * 100)

            local color = "#ffffff"
            if player.adventurer_xp_att() then
                color = "#cd6155"
            end

            adventurer_xp.set_value("<color=" .. color .. ">" .. comma_value(a_xp) .. "</color>")
            adventurer_level.set_value("<b>" .. player.adventurer_level() .. "</b>:<size=9>" .. a_progress .. "%</size>")

            --- has no att
            producer_xp.set_value(comma_value(p_xp))
            producer_level.set_value("<b>" .. player.producer_level() .. "</b>:<size=9>" .. p_progress .. "%</size>")
        end, 1)

        taskbar_center.add_child(adventurer_xp)
        taskbar_center.add_child(adventurer_level)
        taskbar_center.add_child(stopwatch)
        taskbar_center.add_child(producer_level)
        taskbar_center.add_child(producer_xp)

        -----------------------------------
        --- Right

        local fps_value = Label(0, 0, 60, 0, "", 12, taskbar_right)
        fps_value.set_resize_dir(ui_resize_dir.Vertical)
        fps_value.set_align(ui_anchor.MiddleRight)

        on_redraw.action(function(delta)
            fps_value.set_value(math.floor(1 / delta) .. " fps")
        end, 0.5)
    end)
end

--- comment, if you don't want to use
-- use_test()
use_sample()
