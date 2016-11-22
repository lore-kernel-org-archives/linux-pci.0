Return-Path: <lorenzo.pieralisi@arm.com>
Return-Path: <lorenzo.pieralisi@arm.com>
Date: Tue, 22 Nov 2016 17:03:45 +0000
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To: Gabriele Paoloni <gabriele.paoloni@huawei.com>
Cc: "liudongdong (C)" <liudongdong3@huawei.com>,
	"helgaas@kernel.org" <helgaas@kernel.org>,
	"arnd@arndb.de" <arnd@arndb.de>,
	"rafael@kernel.org" <rafael@kernel.org>,
	"tn@semihalf.com" <tn@semihalf.com>,
	"Wangzhou (B)" <wangzhou1@hisilicon.com>,
	"pratyush.anand@gmail.com" <pratyush.anand@gmail.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"jcm@redhat.com" <jcm@redhat.com>,
	"Chenxin (Charles)" <charles.chenxin@huawei.com>,
	"hanjun.guo@linaro.org" <hanjun.guo@linaro.org>,
	Linuxarm <linuxarm@huawei.com>
Subject: Re: [PATCH V6 1/2] PCI/ACPI: Provide acpi_get_rc_resources() for
 ARM64 platform
Message-ID: <20161122170345.GA2509@red-moon>
References: <1479816529-97410-1-git-send-email-liudongdong3@huawei.com>
 <1479816529-97410-2-git-send-email-liudongdong3@huawei.com>
 <20161122155648.GA2022@red-moon>
 <EE11001F9E5DDD47B7634E2F8A612F2E1F92CC43@lhreml507-mbx>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <EE11001F9E5DDD47B7634E2F8A612F2E1F92CC43@lhreml507-mbx>
List-ID: <linux-pci.vger.kernel.org>

On Tue, Nov 22, 2016 at 04:09:57PM +0000, Gabriele Paoloni wrote:

[...]

> > On Tue, Nov 22, 2016 at 08:08:48PM +0800, Dongdong Liu wrote:
> > > The acpi_get_rc_resources() is used to get the RC register address
> > that can
> > > not be described in MCFG. It takes the _HID&segment to look for and
> > returns
> > > the RC address resource. Use PNP0C02 devices to describe such RC
> > address
> > > resource. Use _UID to match segment to tell which root bus the
> > PNP0C02
> > > resource belong to.
> > 
> > Here (ie interpreting the _UID as a segment identifier) is where we
> > start interpreting the specs instead of relying on them, if you want to
> > go ahead with this feel free but I do not like this attitude at all.
> 
> Obviously there are no specs to specify the segment id of a quirk.

That's the reason why _UID (or any other standard object) should not be
(ab)used to do that, again, that's just my opinion.

> Looking at the ACPI specs it seems to me that the _UID is no worse
> than other device identification objects...

There are no bindings in the specs describing what you need. If you want
to say "for this _HID, _UID means something completely different
- ie root bridge segment identifier - go ahead if that's fine with Bjorn
and Rafael; another solution would be adding a _DSM/DSD to the PNP0c02
device to retrieve the segment number, other than that I have run out
of ideas.

Lorenzo

> 
> > 
> > > Signed-off-by: Dongdong Liu <liudongdong3@huawei.com>
> > > Signed-off-by: Tomasz Nowicki <tn@semihalf.com>
> > > ---
> > >  drivers/pci/pci-acpi.c | 69
> > ++++++++++++++++++++++++++++++++++++++++++++++++++
> > >  drivers/pci/pci.h      |  4 +++
> > >  2 files changed, 73 insertions(+)
> > >
> > > diff --git a/drivers/pci/pci-acpi.c b/drivers/pci/pci-acpi.c
> > > index d966d47..76fd6f4 100644
> > > --- a/drivers/pci/pci-acpi.c
> > > +++ b/drivers/pci/pci-acpi.c
> > > @@ -29,6 +29,75 @@
> > >  	0x91, 0x17, 0xea, 0x4d, 0x19, 0xc3, 0x43, 0x4d
> > >  };
> > >
> > > +#ifdef CONFIG_ARM64
> > 
> > CONFIG_PCI_ECAM_QUIRKS (that you will introduce earlier in your
> > series).
> > 
> > The way you did it seems to imply that on ARM64 to get RC address we
> > need to (and are allowed to) use this function (and related, *Linux
> > specific*, ACPI bindings) and that's a generic way of getting config
> > space. It is not and it must not be and I consider it a bit of a
> > stretch
> > to have it in generic code but I can live with that as long as it comes
> > with its own config option that describes that this stuff is
> > non-compliant code used by non-compliant platform drivers.
> 
> Yes probably better to have
> 
> #ifdef CONFIG_PCI_ECAM_QUIRKS
> 
> Thanks
> 
> Gab
> 
> > 
> > Thanks,
> > Lorenzo
> > 
> > > +static struct resource *acpi_get_rc_addr(struct acpi_device *adev)
> > > +{
> > > +	struct resource_entry *entry;
> > > +	struct list_head list;
> > > +	unsigned long flags;
> > > +	int ret;
> > > +	struct resource *res;
> > > +
> > > +	INIT_LIST_HEAD(&list);
> > > +	flags = IORESOURCE_MEM;
> > > +	ret = acpi_dev_get_resources(adev, &list,
> > > +				     acpi_dev_filter_resource_type_cb,
> > > +				     (void *) flags);
> > > +	if (ret <= 0)
> > > +		return NULL;
> > > +
> > > +	entry = list_first_entry(&list, struct resource_entry, node);
> > > +	res = entry->res;
> > > +	acpi_dev_free_resource_list(&list);
> > > +	return res;
> > > +}
> > > +
> > > +static acpi_status acpi_match_rc(acpi_handle handle, u32 lvl, void
> > *context,
> > > +				 void **retval)
> > > +{
> > > +	u16 *segment = context;
> > > +	unsigned long long uid;
> > > +	acpi_status status;
> > > +
> > > +	status = acpi_evaluate_integer(handle, "_UID", NULL, &uid);
> > > +	if (ACPI_FAILURE(status) || uid != *segment)
> > > +		return AE_CTRL_DEPTH;
> > > +
> > > +	*(acpi_handle *)retval = handle;
> > > +	return AE_CTRL_TERMINATE;
> > > +}
> > > +
> > > +/**
> > > + * acpi_get_rc_resources() - get the RC address resource.
> > > + * @hid:	HID to search for.
> > > + * @segment:	PCI Segment number.
> > > + *
> > > + * Get the RC address resource that can not be described in MCFG. It
> > takes
> > > + * the _HID&segment to look for and returns the RC address resource.
> > Use
> > > + * _CRS of PNP0C02 devices to describe such RC address resource. Use
> > _UID
> > > + * to match segment to tell which root bus the PNP0C02 resource
> > belong to.
> > > + *
> > > + * Return: RC address resource.
> > > + */
> > > +struct resource *acpi_get_rc_resources(const char *hid, u16 segment)
> > > +{
> > > +	struct acpi_device *adev;
> > > +	acpi_status status;
> > > +	acpi_handle handle;
> > > +	int ret;
> > > +
> > > +	status = acpi_get_devices(hid, acpi_match_rc, &segment, &handle);
> > > +	if (ACPI_FAILURE(status))
> > > +		return -ENODEV;
> > > +
> > > +	ret = acpi_bus_get_device(handle, &adev);
> > > +	if (ret)
> > > +		return ret;
> > > +
> > > +	return acpi_get_rc_addr(adev);
> > > +}
> > > +#endif
> > > +
> > >  phys_addr_t acpi_pci_root_get_mcfg_addr(acpi_handle handle)
> > >  {
> > >  	acpi_status status = AE_NOT_EXIST;
> > > diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
> > > index 4518562..bf1dbfe 100644
> > > --- a/drivers/pci/pci.h
> > > +++ b/drivers/pci/pci.h
> > > @@ -356,4 +356,8 @@ static inline int pci_dev_specific_reset(struct
> > pci_dev *dev, int probe)
> > >  }
> > >  #endif
> > >
> > > +#if defined(CONFIG_ARM64) && defined(CONFIG_ACPI)
> > > +struct resource *acpi_get_rc_resources(const char *hid, u16
> > segment);
> > > +#endif
> > > +
> > >  #endif /* DRIVERS_PCI_H */
> > > --
> > > 1.9.1
> > >
