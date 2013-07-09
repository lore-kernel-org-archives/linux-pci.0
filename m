Return-Path: <linux-acpi-owner@vger.kernel.org>
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	LKML <linux-kernel@vger.kernel.org>,
	Linux PCI <linux-pci@vger.kernel.org>,
	Yinghai Lu <yinghai@kernel.org>, Jiang Liu <liuj97@gmail.com>
Subject: Re: [RFC][PATCH 6/8] ACPI / hotplug / PCI: Drop acpiphp_handle_to_bridge()
Date: Wed, 10 Jul 2013 01:46:05 +0200
Message-ID: <1584852.Uglv2uCyLO@vostro.rjw.lan>
In-Reply-To: <20130709093726.GK4898@intel.com>
References: <26431283.HJCKsss0rt@vostro.rjw.lan> <3804403.VVlzfJfUyu@vostro.rjw.lan> <20130709093726.GK4898@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tuesday, July 09, 2013 12:37:26 PM Mika Westerberg wrote:
> On Tue, Jul 09, 2013 at 02:20:31AM +0200, Rafael J. Wysocki wrote:
> > @@ -953,37 +937,49 @@ static void acpiphp_sanitize_bus(struct
> >   * ACPI event handlers
> >   */
> >  
> > -static acpi_status
> > -check_sub_bridges(acpi_handle handle, u32 lvl, void *context, void **rv)
> > +static acpi_status check_sub_bridges(acpi_handle handle, u32 lvl, void *data,
> > +				     void **rv)
> >  {
> > -	struct acpiphp_bridge *bridge;
> > -	char objname[64];
> > -	struct acpi_buffer buffer = { .length = sizeof(objname),
> > -				      .pointer = objname };
> > +	struct acpiphp_context *context = acpiphp_get_context(handle);
> > +
> > +	if (!context)
> > +		return AE_OK;
> >  
> > -	bridge = acpiphp_handle_to_bridge(handle);
> > -	if (bridge) {
> > +	if (context->bridge) {
> > +		struct acpiphp_bridge *bridge = context->bridge;
> > +		char objname[64];
> > +		struct acpi_buffer buffer = { .length = sizeof(objname),
> > +					      .pointer = objname };
> > +
> > +		get_bridge(bridge);
> >  		acpi_get_name(handle, ACPI_FULL_PATHNAME, &buffer);
> > -		dbg("%s: re-enumerating slots under %s\n",
> > -			__func__, objname);
> > +		dbg("%s: re-enumerating slots under %s\n", __func__, objname);
> 
> Although not related to this patch directly, how about using
> acpi_handle_debug() or similar here?

Well, we don't have acpi_handle_debug() and I remember there was a reason why,
but I can't recall what the reason was at the moment. :-)

> >  		acpiphp_check_bridge(bridge);
> >  		put_bridge(bridge);
> >  	}
> > +	acpiphp_put_context(context);
> >  	return AE_OK ;
> >  }
-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
