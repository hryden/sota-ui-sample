local ScriptName = "SUIS";
local Version = "0.1";
local CreatorName = "Denys";
local Description = "SOTA Sample UI"

-------------------------------------------
---- UI

---@enum ui_type
local ui_type = {
    Panel = 0,  -- UI.Panel
    Image = 1,  -- UI.Image
    Text = 2,   -- UI.Text
    Button = 3, -- UI.Button
    Input = 4,  -- UI.Input
    Toggle = 5  -- UI.Toggle
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
    DarkGray = "#101010",
    DimGray = "#696969",
    Onyx = "#353935",
    BlueGray = "#7393B3",
    SteelBlue = "#4682B4",
    CornflowerBlue = "#6495ED",
    Gold = "#FFD700",
    Oxblood = "#4A0404"
}

---@enum ui_symbol
local ui_symbol = {
    CheckOn = "\u{2611}",
    CheckOff = "\u{2610}",
    Close = "\u{2715}",
    CloseBold = "\u{2716}",
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

---@type integer
local ui_texture

---------------------------------------
--- Screen

local screen_width = 0
local screen_height = 0

---@type fun(): integer
local get_screen_width

---@type fun(): integer
local get_screen_height

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

    function self.emit(...)
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
local on_mouse_pressed = Event()
local on_mouse_released = Event()
local on_mouse_dragging = Signal()

local on_key_pressed = Event()
local on_key_released = Event()

local on_scene_loaded = Event()
local on_scene_unloaded = Event()

local on_logout = Event()
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
    local id_ = node_id
    local type_ = node_type
    local parent_ = parent_node

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

    self.on_hovered = Signal()
    self.on_pressed = Signal()
    self.on_toggled = Signal()

    self.on_child_entered_tree = Signal()
    self.on_child_exiting_tree = Signal()

    ---@return integer
    function self.id()
        return id_
    end

    ---@return ui_type
    function self.type()
        return type_
    end

    function self.equal(i, t)
        return (id_ == i) and (type_ == t)
    end

    function self.parent_equal(i, t)
        return parent_ and parent_.equal(i, t)
    end

    -- ---@param node Node
    -- function self.add_child(node)
    --     if not node.parent_equal(id_, type_) then
    --         print("false")
    --     end
    --     table.insert(childs_, node)
    -- end

    ---@param node Node
    function self.remove_child(node)
        for i, c in ipairs(childs_) do
            if (node.id() == c.id()) and (node.type() == c.type()) then
                table.remove(childs_, i)
                if not silent_ then
                    self.sort_childs()
                end
                break
            end
        end
    end

    function self.sort_childs()
        --- overload
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
            -- if not silent_ then
            --     self.sort_childs()
            -- end
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
        elseif not value and ui_hide_object(id_, type_) then
            visible_ = false
        end
        -- if not silent_ and parent_ then
        --     parent_.sort_childs()
        -- end
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
    local on_mouse_released_action_id

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
                    self.on_pressed.emit(true)
                    return true
                end
            end)

            on_mouse_released_action_id = on_mouse_released.action(function()
                if self.is_pressed() then
                    self.on_pressed.emit(false)
                    return true
                end
            end)

            mouse_filter_ = true
        elseif not value and mouse_filter_ then
            on_mouse_entered.remove_action(on_mouse_entered_action_id)
            on_mouse_exited.remove_action(on_mouse_exited_action_id)
            on_mouse_pressed.remove_action(on_mouse_pressed_action_id)
            on_mouse_released.remove_action(on_mouse_released_action_id)

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
            parent_.on_child_exiting_tree(self)
            ui_destroy_object(id_, type_)
        end
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
        if not silent_ then
            self.sort_childs()
        end
    end)

    ---@param node Node
    self.on_child_exiting_tree.action(function(node)
        for index, child in ipairs(childs_) do
            if child.equal(node.id(), node.type()) then
                table.remove(childs_, index)
                break
            end
        end
        table.insert(childs_, node)
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
    texture_id = texture_id or ui_texture

    local id_ = -1
    local type_ = ui_type.Image
    if parent_node then
        id_ = ui_image(pos_x, pos_y, size_x, size_y, ui_texture, parent_node.id(), parent_node.type())
    else
        id_ = ui_image(pos_x, pos_y, size_x, size_y, ui_texture)
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

    self.set_align(anchor_)
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

---@param pos_x number
---@param pos_y number
---@param size_x number
---@param size_y number
---@param title string
function Window(pos_x, pos_y, size_x, size_y, title)
    ---@class Window: Image
    local self = Image(pos_x, pos_y, size_x, size_y)
    local header_ = Image(0, 0, size_x, 24, nil, self)
    local close_ = Button(0, 0, 32, 24, ui_symbol.Close, 10, header_)
    local title_ = Label(40, 0, 200, 24, title, 12, header_)

    self.on_dragging = Signal()
    self.on_resizing = Signal()
    self.on_close = Signal()

    ---@param text string
    function self.set_title(text)
        title_.set_value(text)
    end

    self.sort_childs = function ()
        local w, h = self.get_size()
        header_.set_size(w, 24)
        for index, child in ipairs(self.get_childs()) do
            if index == 2 then
                child.set_position(0, 24)
                child.set_size(w, h - 24 - 4)
                break
            end
        end
    end

    on_mouse_dragging.action(function()
        if header_.is_pressed() then
            local x, y = self.get_position()
            self.set_position(
                x + (mouse_x_spd * mouse_x_dir),
                y + (mouse_y_spd * mouse_y_dir)
            )
            return true
        end
    end)

    close_.on_pressed.action(function (pressed)
        self.set_visible(false)
        self.on_close.emit()
    end)

    local color = ui_color.DarkGray

    self.set_color(color)
    header_.set_normal_color(color)
    header_.set_pressed_color(color)
    header_.set_hovered_color(color)
    header_.set_mouse_filter(true)

    close_.set_normal_color(ui_color.Black .. "aa")
    title_.set_color(ui_color.DimGray)
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

    self.sort_childs = function()
        label_.set_size(self.get_size())
    end

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

---@param pos_x? number
---@param pos_y? number
---@param size_x? number
---@param size_y? number
---@param background_color? ui_color|string
---@param progress_color? ui_color|string
---@param parent_node? Node
function ProgressBar(pos_x, pos_y, size_x, size_y, background_color, progress_color, parent_node)
    local background_color_ = background_color or ui_color.Black
    local progress_color_ = progress_color or ui_color.DimGray

    ---@class ProgressBar: Panel
    local self = Panel(pos_x, pos_y, size_x, size_y, parent_node)
    local line_ = Panel(pos_x, pos_y, 0, size_y, self)

    local value_ = 0

    function self.set_value(value)
        value_ = clamp_value(value, 0, 1)
        line_.set_size_x(self.get_size_x() * value)
    end

    ---@param hexcolor ui_color|string
    function self.set_value_color(hexcolor)
        line_.set_color(hexcolor)
    end

    self.sort_childs = function()
        line_.set_size(value_ / self.get_size_x(), self.get_size_y())
    end

    self.set_color(background_color_)
    line_.set_color(progress_color_)
    return self
end

---@param width number
---@param horizontal boolean
---@param parent_node Node
function ScrollBar(width, horizontal, parent_node)
    local x = 0
    local y = 0
    local w = 0
    local h = 0
    if horizontal then
        y = parent_node.get_size_y() - width
        w = parent_node.get_size_x()
        h = width
    else
        x = parent_node.get_size_x() - width
        h = parent_node.get_size_y()
        w = width
    end

    ---@class ScrollBar: Image
    local self = Image(x, y, w, h, nil, parent_node)
    local grabber_ = Image(0, 0, 0, 0, nil, self)

    local value_ = 0
    self.on_value_changed = Signal()

    ---@param value number
    function self.set_value(value)
        value = clamp_value(value, 0, 1)
        grabber_.set_pos_y((self.get_size_y() - grabber_.get_size_y()) * value)
        self.on_value_changed.emit(value)
    end

    on_mouse_dragging.action(function()
        if grabber_.is_pressed() then
            local max = self.get_size_y() - grabber_.get_size_y()
            local pos = grabber_.get_pos_y() + mouse_y_spd * mouse_y_dir
            if pos >= 0 and pos <= max then
                grabber_.set_pos_y(pos)
                if max == 0 then
                    max = 1
                end
                value_ = pos / max
                self.on_value_changed.emit(value_)
            end
            return true
        end
    end)

    self.on_pressed.action(function(pressed)
        if pressed and not grabber_.is_pressed() then
            local _, pos_y = self.get_absolute_position()
            local pos = mouse_y - pos_y
            self.set_value(pos / self.get_size_y())
        end
    end)

    grabber_.set_size(width, 50)
    grabber_.set_normal_color(ui_color.DarkGray)
    grabber_.set_hovered_color(ui_color.White .. "22")
    grabber_.set_pressed_color(ui_color.White .. "22")

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
    size_x = size_x or 200
    size_y = size_y or 100

    local scroll_size_ = 6

    ---@class ItemList: Panel
    local self = Panel(pos_x, pos_y, size_x, size_y, parent_node)
    local content_ = Panel(0, 0, size_x - scroll_size_, 0, self)
    local scroll_bar_ = ScrollBar(scroll_size_, false, self)
    local progress_bar_ = ProgressBar(0, 0, size_x, 1, ui_color.Black, ui_color.White .. "22", self)

    local rows_ = 0
    local columns_ = 0
    local columns_width_ = {}

    local item_height_ = 24
    local item_gutter_ = 1

    local content_offset_left_ = 10
    local content_offset_right_ = 10

    local item_width_ = function(w)
        local expanded, fixed = 0, 0
        for _, v in ipairs(columns_width_) do
            if v < 1 then
                expanded = expanded + 1
            else
                fixed = fixed + v
            end
        end

        local width = array(columns_, (w - fixed) / expanded)
        for i, v in ipairs(columns_width_) do
            if v >= 1 then
                width[i] = v
            end
        end
        return width
    end

    ---@param n integer
    ---@param callback fun(index: integer, item: Node): Node
    function self.add_items(n, callback)
        content_.set_silent(true)
        local item = content_.get_child(1)
        local item_count = content_.get_child_count()
        local item_width = content_.get_size_x()

        local item_init = false
        if not item then
            item = Panel(0, 0, item_width, item_height_, content_)
            item_init = true
        end

        item = callback(1, item)
        local item_childs = item.get_childs()

        rows_ = item_count + n
        columns_ = #item_childs
        columns_width_ = array(columns_, 0)
        for index, value in ipairs(item_childs) do
            columns_width_[index] = value.get_size_x()
        end

        item_height_ = item.get_size_y()
        local item_child_width = item_width_(item_width - content_offset_left_ - content_offset_right_)

        local h = self.get_size_y()
        local y = item_count * (item_height_ + item_gutter_)
        for i = item_count + 1, rows_ do
            on_update.task(function()
                local row
                if item_init then
                    row = item
                    item_init = false
                else
                    row = callback(i, Panel(0, y, item_width, item_height_, content_))
                end

                local x = content_offset_left_
                for index, value in ipairs(row.get_childs()) do
                    local w = item_child_width[index]
                    value.set_size(w, item_height_)
                    value.set_position(x, 0)
                    x = x + w
                end

                y = y + item_height_ + item_gutter_
                content_.set_size_y(y)
                progress_bar_.set_value(i / n)
                -- if y >= h then -- follow
                --     scroll_bar_.set_value((y - h) / h)
                -- end
            end)
        end

        on_update.task(function()
            progress_bar_.set_value(0)
            content_.set_silent(false)
            self.sort_childs()
        end)
    end

    ---@param idx integer
    ---@param value number
    function self.set_column_width(idx, value)
        if idx > 0 and idx <= columns_ then
            columns_width_[idx] = value
            content_.sort_childs()
        end
    end

    content_.sort_childs = function()
        local y = 0
        local w = content_.get_size_x()
        local item_child_width = item_width_(w - content_offset_left_ - content_offset_right_)

        for _, c in ipairs(content_.get_childs()) do
            c.set_position(0, y)
            c.set_size(w, item_height_)
            local x = content_offset_left_
            for i, v in ipairs(c.get_childs()) do
                local width = item_child_width[i]
                v.set_size(width, item_height_)
                v.set_position(x, 0)
                x = x + width
            end
            y = y + item_height_ + item_gutter_
        end
    end

    self.sort_childs = function()
        local w, h = self.get_size()
        local x = w - scroll_size_

        content_.set_size_x(x)

        scroll_bar_.set_position(x, 0)
        scroll_bar_.set_size(scroll_size_, h)
    end

    scroll_bar_.on_value_changed.action(function(value)
        local h = content_.get_size_y() - self.get_size_y()
        local pos = -1 * h * value
        content_.set_pos_y(pos)
    end)

    content_.set_color(ui_color.DarkGray .. "ee")
    return self
end

-------------------------------------------
--- Player

function Player()
    ---@class Player
    local self = {}

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

function ShroudOnUpdate()
    on_update.resume()
end

function ShroudOnStart()
    ---@diagnostic disable: undefined-global

    ui_type = UI
    ui_anchor = TextAnchor

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
    ui_image_texture = ShroudLoadTexture
    ui_show = ShroudShowLuaUI
    ui_hide = ShroudHideLuaUI

    get_screen_width = ShroudGetScreenX
    get_screen_height = ShroudGetScreenY

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

    ui_texture = ui_image_texture("sample.png", true)

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

            on_mouse_dragging.emit()
        end

        mouse_x = m_x
        mouse_y = m_y

        screen_width = get_screen_width()
        screen_height = get_screen_height()
    end)

    ---@diagnostic enable: undefined-global
end

local use_test = function()
    on_update.task(function()
        local color = ui_color.Black .. "ee"
    end)
end

local use_sample = function()
    ---comment
    ---@param index integer
    ---@param node Node
    ---@return Node
    local stat_list = function(index, node)
        local idx = Label(0, 0, 32, 0, tostring(index), 12, node)
        local name = Label(0, 0, 0, 0, get_player_stat_name(index), 12, node)
        local value = Label(0, 0, 120, 0, tostring(get_player_stat_value(index)), 12, node)
        local check = CheckBox(0, 0, 24, node)
        return node
    end

    on_update.task(function()
        local window = Window(500, 100, 600, 400, "Stats")
        local list = ItemList(0, 24, 600, 370, window)
        -- list.add_items(get_player_stat_count(), stat_list)
        list.add_items(50, stat_list)
    end)
end

--- comment, if you don't want to use
-- use_test()
use_sample()
