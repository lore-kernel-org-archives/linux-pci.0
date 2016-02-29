Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from 8bytes.org ([81.169.241.247]:57393 "EHLO theia.8bytes.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750957AbcB2QgP (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Mon, 29 Feb 2016 11:36:15 -0500
Date: Mon, 29 Feb 2016 17:36:13 +0100
From: Joerg Roedel <joro@8bytes.org>
To: "Zytaruk, Kelly" <Kelly.Zytaruk@amd.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"bhelgaas@google.com" <bhelgaas@google.com>,
	"Marsan, Luugi" <Luugi.Marsan@amd.com>,
	Alex Williamson <alex.williamson@redhat.com>
Subject: Re: BUGZILLA [112941] - Cannot reenable SRIOV after disabling SRIOV
 on AMD GPU
Message-ID: <20160229163613.GK22747@8bytes.org>
References: <CY1PR12MB0262D12DAC0897F8DC74541CFEA40@CY1PR12MB0262.namprd12.prod.outlook.com>
 <20160223170215.GA25203@localhost>
 <CY1PR12MB0262E17EF294E8A1F23D8CB2FEA40@CY1PR12MB0262.namprd12.prod.outlook.com>
 <CY1PR12MB02629490AFFE29BACB197EA6FEA50@CY1PR12MB0262.namprd12.prod.outlook.com>
 <20160226155558.GA32730@8bytes.org>
 <SN1PR12MB026900B1076C4CFAD3BCC403FEA70@SN1PR12MB0269.namprd12.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <SN1PR12MB026900B1076C4CFAD3BCC403FEA70@SN1PR12MB0269.namprd12.prod.outlook.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Kelly,

On Fri, Feb 26, 2016 at 07:16:29PM +0000, Zytaruk, Kelly wrote:
> I applied the fix and the WARN on ats_enabled flag goes away.  The
> detach_device() gets called against the correct dev when
> pci_sriov_disable is called.  This looks like it is fixed.

Great, thanks for testing. I'll send the patch upstream so that it gets
included into v4.5

> I have a couple questions;
> 
> 1)     find_dev_data()
> I put some printk statements into the enable and disable path for
> iommu.  On the first enable in find_dev_data() I see the following.
> Note that the archdata.iommu data area does not exist and must be
> initialized;
> 
> [ 2237.701423] pci_device_add - call device_add for base device 0000:02:00.0 dev->ats_enabled = 0
> [ 2237.701555] vgaarb: device added: PCI:0000:02:00.0,decodes=io+mem,owns=none,locks=none
> [ 2237.701560] iommu_init_device - find archdata.iommu for dev 0000:02:00.0, device id = 512
> [ 2237.701565] find_dev_data - no archdata.iommu for devid 512, allocate a new one
> [ 2237.701568] find_dev_data - devid 512 not attached to domain
> 
> One the second enable (after a disable) find_dev_data() finds and reuses the previous archdata.iommu as shown below.
> 
> [ 2316.549788] pci_device_add - call device_add for base device 0000:02:00.0 dev->ats_enabled = 0
> [ 2316.549931] vgaarb: device added: PCI:0000:02:00.0,decodes=io+mem,owns=none,locks=none
> [ 2316.549936] iommu_init_device - find archdata.iommu for dev 0000:02:00.0, device id = 512
> [ 2316.549942] find_dev_data - found an existing archdata.iommu for devid 512
> [ 2316.549944] find_dev_data - devid 512 not attached to domain
> 
> Since the second enable is reusing the archdata.iommu from the first
> enable is there any further cleanup that would need to be done to the
> archdata.iommu data area?

Possibly yes, I need to have a closer look there. That caching of
dev_data structures is done for historical reasons. I'll check first if
this is still necessary.

> What is this area used for?  I understand that archdata is platform
> specific but what does iommu use it for, is there a good document that
> describes its use or do I have to read through the source code?
> How can I test to ensure that it is properly reused and has proper
> data integrity?

There are no documents about the inner structure of the AMD IOMMU driver
besides the source code. The dev_data area is used to attach
iommu-driver specific data (like the domain it is attached to) to a
struct device.

> 
> 2) What is "dev_data->domain" and "group" in relation to iommu.  I
> tried google and came up with meaningless references.  Is it
> documented anywhere?

The dev_data->domain member points to the domain this device is
currently attached to, while group points to the iommu-group the device
is in.


	Joerg

