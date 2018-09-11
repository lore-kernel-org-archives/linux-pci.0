Return-Path: <linux-acpi-owner@vger.kernel.org>
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Len Brown <lenb@kernel.org>,
        Lukas Wunner <lukas@wunner.de>,
        Keith Busch <keith.busch@intel.com>,
        Ashok Raj <ashok.raj@intel.com>, Mario.Limonciello@dell.com,
        Anthony Wong <anthony.wong@canonical.com>,
        "D . J . Bernstein" <djb@cr.yp.to>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org
Subject: Re: [PATCH 09/10] ACPI / property: Allow multiple property compatible _DSD entries
Date: Tue, 11 Sep 2018 11:00:29 +0200
Message-ID: <24021104.3xfOQZeJ2V@aspire.rjw.lan>
In-Reply-To: <20180906155020.51700-10-mika.westerberg@linux.intel.com>
References: <20180906155020.51700-1-mika.westerberg@linux.intel.com> <20180906155020.51700-10-mika.westerberg@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thursday, September 6, 2018 5:50:19 PM CEST Mika Westerberg wrote:
> It is possible to have _DSD entries where the data is compatible with device
> properties format but are using different GUID for various reasons. In addition
> to that there can be many such _DSD entries for a single device such as for
> PCIe root port used to host a Thunderbolt hierarchy:
> 
>     Scope (\_SB.PCI0.RP21)
>     {
>         Name (_DSD, Package () {
>             ToUUID ("6211e2c0-58a3-4af3-90e1-927a4e0c55a4"),
>             Package () {
>                 Package () {"HotPlugSupportInD3", 1}
>             },
> 
>             ToUUID ("efcc06cc-73ac-4bc3-bff0-76143807c389"),
>             Package () {
>                 Package () {"ExternalFacingPort", 1},
>                 Package () {"UID", 0 }
>             }
>         })
>     }
> 
> For more information about these new _DSD entries can be found in:
> 
>   https://docs.microsoft.com/en-us/windows-hardware/drivers/pci/dsd-for-pcie-root-ports
> 
> In order to make these available for drivers via unified device property
> APIs modify ACPI property core so that it supports multiple _DSD entries
> organized in a linked list. We also store GUID of each _DSD entry in
> struct acpi_device_properties in case there is need to differerentiate
> between entries. The supported GUIDs are then listed in prp_guids array.
> 
> Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> ---
>  drivers/acpi/property.c     | 94 +++++++++++++++++++++++++++----------
>  drivers/acpi/x86/apple.c    |  2 +-
>  drivers/gpio/gpiolib-acpi.c |  2 +-
>  include/acpi/acpi_bus.h     |  8 +++-
>  include/linux/acpi.h        |  9 ++++
>  5 files changed, 86 insertions(+), 29 deletions(-)
> 
> diff --git a/drivers/acpi/property.c b/drivers/acpi/property.c
> index 693cf05b0cc4..f3ddb279d2de 100644
> --- a/drivers/acpi/property.c
> +++ b/drivers/acpi/property.c
> @@ -24,11 +24,12 @@ static int acpi_data_get_property_array(const struct acpi_device_data *data,
>  					acpi_object_type type,
>  					const union acpi_object **obj);
>  
> -/* ACPI _DSD device properties GUID: daffd814-6eba-4d8c-8a91-bc9bbf4aa301 */
> -static const guid_t prp_guid =
> +static const guid_t prp_guids[] = {
> +	/* ACPI _DSD device properties GUID: daffd814-6eba-4d8c-8a91-bc9bbf4aa301 */
>  	GUID_INIT(0xdaffd814, 0x6eba, 0x4d8c,
> -		  0x8a, 0x91, 0xbc, 0x9b, 0xbf, 0x4a, 0xa3, 0x01);
> -/* ACPI _DSD data subnodes GUID: dbb8e3e6-5886-4ba6-8795-1319f52a966b */
> +		  0x8a, 0x91, 0xbc, 0x9b, 0xbf, 0x4a, 0xa3, 0x01),
> +};
> +
>  static const guid_t ads_guid =
>  	GUID_INIT(0xdbb8e3e6, 0x5886, 0x4ba6,
>  		  0x87, 0x95, 0x13, 0x19, 0xf5, 0x2a, 0x96, 0x6b);
> @@ -56,6 +57,7 @@ static bool acpi_nondev_subnode_extract(const union acpi_object *desc,
>  	dn->name = link->package.elements[0].string.pointer;
>  	dn->fwnode.ops = &acpi_data_fwnode_ops;
>  	dn->parent = parent;
> +	INIT_LIST_HEAD(&dn->data.properties);
>  	INIT_LIST_HEAD(&dn->data.subnodes);
>  
>  	result = acpi_extract_properties(desc, &dn->data);
> @@ -288,6 +290,35 @@ static void acpi_init_of_compatible(struct acpi_device *adev)
>  	adev->flags.of_compatible_ok = 1;
>  }
>  
> +static bool acpi_is_property_guid(const guid_t *guid)
> +{
> +	int i;
> +
> +	for (i = 0; i < ARRAY_SIZE(prp_guids); i++) {
> +		if (guid_equal(guid, &prp_guids[i]))
> +			return true;
> +	}
> +
> +	return false;
> +}
> +
> +struct acpi_device_properties *
> +acpi_data_add_props(struct acpi_device_data *data, const guid_t *guid,
> +		    const union acpi_object *properties)
> +{
> +	struct acpi_device_properties *props;
> +
> +	props = kzalloc(sizeof(*props), GFP_KERNEL);
> +	if (props) {
> +		INIT_LIST_HEAD(&props->list);
> +		props->guid = guid;
> +		props->properties = properties;
> +		list_add_tail(&props->list, &data->properties);
> +	}
> +
> +	return props;
> +}
> +
>  static bool acpi_extract_properties(const union acpi_object *desc,
>  				    struct acpi_device_data *data)
>  {
> @@ -312,7 +343,7 @@ static bool acpi_extract_properties(const union acpi_object *desc,
>  		    properties->type != ACPI_TYPE_PACKAGE)
>  			break;
>  
> -		if (!guid_equal((guid_t *)guid->buffer.pointer, &prp_guid))
> +		if (!acpi_is_property_guid((guid_t *)guid->buffer.pointer))
>  			continue;
>  
>  		/*
> @@ -320,13 +351,13 @@ static bool acpi_extract_properties(const union acpi_object *desc,
>  		 * package immediately following it.
>  		 */
>  		if (!acpi_properties_format_valid(properties))
> -			break;
> +			continue;
>  
> -		data->properties = properties;
> -		return true;
> +		acpi_data_add_props(data, (const guid_t *)guid->buffer.pointer,
> +				    properties);
>  	}
>  
> -	return false;
> +	return !list_empty(&data->properties);
>  }
>  
>  void acpi_init_properties(struct acpi_device *adev)
> @@ -336,6 +367,7 @@ void acpi_init_properties(struct acpi_device *adev)
>  	acpi_status status;
>  	bool acpi_of = false;
>  
> +	INIT_LIST_HEAD(&adev->data.properties);
>  	INIT_LIST_HEAD(&adev->data.subnodes);
>  
>  	if (!adev->handle)
> @@ -398,11 +430,16 @@ static void acpi_destroy_nondev_subnodes(struct list_head *list)
>  
>  void acpi_free_properties(struct acpi_device *adev)
>  {
> +	struct acpi_device_properties *props, *tmp;
> +
>  	acpi_destroy_nondev_subnodes(&adev->data.subnodes);
>  	ACPI_FREE((void *)adev->data.pointer);
>  	adev->data.of_compatible = NULL;
>  	adev->data.pointer = NULL;
> -	adev->data.properties = NULL;
> +	list_for_each_entry_safe(props, tmp, &adev->data.properties, list) {
> +		list_del(&props->list);
> +		kfree(props);
> +	}
>  }
>  
>  /**
> @@ -427,32 +464,37 @@ static int acpi_data_get_property(const struct acpi_device_data *data,
>  				  const char *name, acpi_object_type type,
>  				  const union acpi_object **obj)
>  {
> -	const union acpi_object *properties;
> -	int i;
> +	struct acpi_device_properties *props;
>  
>  	if (!data || !name)
>  		return -EINVAL;
>  
> -	if (!data->pointer || !data->properties)
> +	if (!data->pointer || list_empty(&data->properties))
>  		return -EINVAL;
>  
> -	properties = data->properties;
> -	for (i = 0; i < properties->package.count; i++) {
> -		const union acpi_object *propname, *propvalue;
> -		const union acpi_object *property;
> +	list_for_each_entry(props, &data->properties, list) {
> +		const union acpi_object *properties;
> +		int i;
>  
> -		property = &properties->package.elements[i];
> +		properties = props->properties;
> +		for (i = 0; i < properties->package.count; i++) {
> +			const union acpi_object *propname, *propvalue;
> +			const union acpi_object *property;
>  
> -		propname = &property->package.elements[0];
> -		propvalue = &property->package.elements[1];
> +			property = &properties->package.elements[i];
>  
> -		if (!strcmp(name, propname->string.pointer)) {
> -			if (type != ACPI_TYPE_ANY && propvalue->type != type)
> -				return -EPROTO;
> -			if (obj)
> -				*obj = propvalue;
> +			propname = &property->package.elements[0];
> +			propvalue = &property->package.elements[1];
>  
> -			return 0;
> +			if (!strcmp(name, propname->string.pointer)) {
> +				if (type != ACPI_TYPE_ANY &&
> +				    propvalue->type != type)
> +					return -EPROTO;
> +				if (obj)
> +					*obj = propvalue;
> +
> +				return 0;
> +			}
>  		}
>  	}
>  	return -EINVAL;
> diff --git a/drivers/acpi/x86/apple.c b/drivers/acpi/x86/apple.c
> index 51b4cf9f25da..130df1c8ed7d 100644
> --- a/drivers/acpi/x86/apple.c
> +++ b/drivers/acpi/x86/apple.c
> @@ -132,8 +132,8 @@ void acpi_extract_apple_properties(struct acpi_device *adev)
>  	}
>  	WARN_ON(free_space != (void *)newprops + newsize);
>  
> -	adev->data.properties = newprops;
>  	adev->data.pointer = newprops;
> +	acpi_data_add_props(&adev->data, &apple_prp_guid, newprops);
>  
>  out_free:
>  	ACPI_FREE(props);
> diff --git a/drivers/gpio/gpiolib-acpi.c b/drivers/gpio/gpiolib-acpi.c
> index c48ed9d89ff5..7be705fae4b8 100644
> --- a/drivers/gpio/gpiolib-acpi.c
> +++ b/drivers/gpio/gpiolib-acpi.c
> @@ -1192,7 +1192,7 @@ int acpi_gpio_count(struct device *dev, const char *con_id)
>  bool acpi_can_fallback_to_crs(struct acpi_device *adev, const char *con_id)
>  {
>  	/* Never allow fallback if the device has properties */
> -	if (adev->data.properties || adev->driver_gpios)
> +	if (acpi_dev_has_props(adev) || adev->driver_gpios)
>  		return false;
>  
>  	return con_id == NULL;
> diff --git a/include/acpi/acpi_bus.h b/include/acpi/acpi_bus.h
> index ba4dd54f2c82..cd35e3ce9a8b 100644
> --- a/include/acpi/acpi_bus.h
> +++ b/include/acpi/acpi_bus.h
> @@ -346,10 +346,16 @@ struct acpi_device_physical_node {
>  	bool put_online:1;
>  };
>  
> +struct acpi_device_properties {
> +	const guid_t *guid;
> +	const union acpi_object *properties;
> +	struct list_head list;
> +};
> +
>  /* ACPI Device Specific Data (_DSD) */
>  struct acpi_device_data {
>  	const union acpi_object *pointer;
> -	const union acpi_object *properties;
> +	struct list_head properties;
>  	const union acpi_object *of_compatible;
>  	struct list_head subnodes;
>  };
> diff --git a/include/linux/acpi.h b/include/linux/acpi.h
> index de8d3d3fa651..51e3c29663fe 100644
> --- a/include/linux/acpi.h
> +++ b/include/linux/acpi.h
> @@ -1074,6 +1074,15 @@ static inline int acpi_node_get_property_reference(
>  		NR_FWNODE_REFERENCE_ARGS, args);
>  }
>  
> +static inline bool acpi_dev_has_props(const struct acpi_device *adev)
> +{
> +	return !list_empty(&adev->data.properties);
> +}
> +
> +struct acpi_device_properties *
> +acpi_data_add_props(struct acpi_device_data *data, const guid_t *guid,
> +		    const union acpi_object *properties);
> +
>  int acpi_node_prop_get(const struct fwnode_handle *fwnode, const char *propname,
>  		       void **valptr);
>  int acpi_dev_prop_read_single(struct acpi_device *adev,
> 

Reviewed-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
