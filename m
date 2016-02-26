Return-Path: <linux-kernel-owner@vger.kernel.org>
From: "Zytaruk, Kelly" <Kelly.Zytaruk@amd.com>
To: Joerg Roedel <joro@8bytes.org>
CC: Bjorn Helgaas <helgaas@kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"bhelgaas@google.com" <bhelgaas@google.com>,
	"Marsan, Luugi" <Luugi.Marsan@amd.com>,
	Alex Williamson <alex.williamson@redhat.com>
Subject: RE: BUGZILLA [112941] - Cannot reenable SRIOV after disabling SRIOV
 on AMD GPU
Date: Fri, 26 Feb 2016 19:16:29 +0000
Message-ID: <SN1PR12MB026900B1076C4CFAD3BCC403FEA70@SN1PR12MB0269.namprd12.prod.outlook.com>
References: <CY1PR12MB0262D12DAC0897F8DC74541CFEA40@CY1PR12MB0262.namprd12.prod.outlook.com>
 <20160223170215.GA25203@localhost>
 <CY1PR12MB0262E17EF294E8A1F23D8CB2FEA40@CY1PR12MB0262.namprd12.prod.outlook.com>
 <CY1PR12MB02629490AFFE29BACB197EA6FEA50@CY1PR12MB0262.namprd12.prod.outlook.com>
 <20160226155558.GA32730@8bytes.org>
In-Reply-To: <20160226155558.GA32730@8bytes.org>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>



> -----Original Message-----
> From: Joerg Roedel [mailto:joro@8bytes.org]
> Sent: Friday, February 26, 2016 10:56 AM
> To: Zytaruk, Kelly
> Cc: Bjorn Helgaas; linux-pci@vger.kernel.org; linux-kernel@vger.kernel.org;
> bhelgaas@google.com; Marsan, Luugi; Alex Williamson
> Subject: Re: BUGZILLA [112941] - Cannot reenable SRIOV after disabling SRIOV
> on AMD GPU
> 
> Hi Kelly,
> 
> On Wed, Feb 24, 2016 at 06:29:56PM +0000, Zytaruk, Kelly wrote:
> > I don't know if the asynchronous nature of the iommu attach/detach is
> > by design or if it is broken somewhere up the tree and just not
> > working in my case.  Maybe one of the iommu owners could answer this.
> 
> Thanks a lot for your bug report and the detailed analysis of the issue. I attached
> a possible fix for you to try out. Can you please test it and report whether it
> changes anything?
> 
Joerg,

I applied the fix and the WARN on ats_enabled flag goes away.  The detach_device() gets called against the correct dev when pci_sriov_disable is called.  This looks like it is fixed.

I have a couple questions;

1)     find_dev_data()
I put some printk statements into the enable and disable path for iommu.  On the first enable in find_dev_data() I see the following.  Note that the archdata.iommu data area does not exist and must be initialized;

[ 2237.701423] pci_device_add - call device_add for base device 0000:02:00.0 dev->ats_enabled = 0
[ 2237.701555] vgaarb: device added: PCI:0000:02:00.0,decodes=io+mem,owns=none,locks=none
[ 2237.701560] iommu_init_device - find archdata.iommu for dev 0000:02:00.0, device id = 512
[ 2237.701565] find_dev_data - no archdata.iommu for devid 512, allocate a new one
[ 2237.701568] find_dev_data - devid 512 not attached to domain

One the second enable (after a disable) find_dev_data() finds and reuses the previous archdata.iommu as shown below.

[ 2316.549788] pci_device_add - call device_add for base device 0000:02:00.0 dev->ats_enabled = 0
[ 2316.549931] vgaarb: device added: PCI:0000:02:00.0,decodes=io+mem,owns=none,locks=none
[ 2316.549936] iommu_init_device - find archdata.iommu for dev 0000:02:00.0, device id = 512
[ 2316.549942] find_dev_data - found an existing archdata.iommu for devid 512
[ 2316.549944] find_dev_data - devid 512 not attached to domain

Since the second enable is reusing the archdata.iommu from the first enable is there any further cleanup that would need to be done to the archdata.iommu data area? 
What is this area used for?  I understand that archdata is platform specific but what does iommu use it for, is there a good document that describes its use or do I have to read through the source code?
How can I test to ensure that it is properly reused and has proper data integrity?

2) What is "dev_data->domain" and "group" in relation to iommu.  I tried google and came up with meaningless references.  Is it documented anywhere?

Thanks,
Kelly

> 
> Thanks,
> 
> 	Joerg
> 
> From 027b6489833aef8ce5ec46cef3e0f9e6a61dbdcd Mon Sep 17 00:00:00 2001
> From: Joerg Roedel <jroedel@suse.de>
> Date: Fri, 26 Feb 2016 16:48:59 +0100
> Subject: [PATCH] iommu/amd: Detach device from domain before removal
> 
> Detach the device that is about to be removed from its domain (if it has one) to
> clear any related state like DTE entry and device's ATS state.
> 
> Signed-off-by: Joerg Roedel <jroedel@suse.de>
> ---
>  drivers/iommu/amd_iommu.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/iommu/amd_iommu.c b/drivers/iommu/amd_iommu.c index
> 539b0de..60cc89f 100644
> --- a/drivers/iommu/amd_iommu.c
> +++ b/drivers/iommu/amd_iommu.c
> @@ -114,6 +114,7 @@ struct kmem_cache *amd_iommu_irq_cache;
> 
>  static void update_domain(struct protection_domain *domain);  static int
> protection_domain_init(struct protection_domain *domain);
> +static void detach_device(struct device *dev);
> 
>  /*
>   * For dynamic growth the aperture size is split into ranges of 128MB of @@ -
> 384,6 +385,9 @@ static void iommu_uninit_device(struct device *dev)
>  	if (!dev_data)
>  		return;
> 
> +	if (dev_data->domain)
> +		detach_device(dev);
> +
>  	iommu_device_unlink(amd_iommu_rlookup_table[dev_data->devid]-
> >iommu_dev,
>  			    dev);
> 
> --
> 1.8.4.5
