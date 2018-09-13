Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from nblzone-211-213.nblnetworks.fi ([83.145.211.213]:43672 "EHLO
        hillosipuli.retiisi.org.uk" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726685AbeIMNIo (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 13 Sep 2018 09:08:44 -0400
Date: Thu, 13 Sep 2018 11:00:23 +0300
From: Sakari Ailus <sakari.ailus@iki.fi>
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, Lukas Wunner <lukas@wunner.de>,
        Keith Busch <keith.busch@intel.com>,
        Ashok Raj <ashok.raj@intel.com>, Mario.Limonciello@dell.com,
        Anthony Wong <anthony.wong@canonical.com>,
        "D . J . Bernstein" <djb@cr.yp.to>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org
Subject: Re: [PATCH 09/10] ACPI / property: Allow multiple property
 compatible _DSD entries
Message-ID: <20180913080022.lmt7y6o65ptjhelv@valkosipuli.retiisi.org.uk>
References: <20180906155020.51700-1-mika.westerberg@linux.intel.com>
 <20180906155020.51700-10-mika.westerberg@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180906155020.51700-10-mika.westerberg@linux.intel.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Moi Mika,

On Thu, Sep 06, 2018 at 06:50:19PM +0300, Mika Westerberg wrote:
> @@ -427,32 +464,37 @@ static int acpi_data_get_property(const struct acpi_device_data *data,
>  				  const char *name, acpi_object_type type,
>  				  const union acpi_object **obj)
>  {
> -	const union acpi_object *properties;
> -	int i;
> +	struct acpi_device_properties *props;

props could be const.

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

unsigned int i?

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

With the above considered,

Acked-by: Sakari Ailus <sakari.ailus@linux.intel.com>

-- 
Terveisin,

Sakari Ailus
e-mail: sakari.ailus@iki.fi
