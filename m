Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from 8bytes.org ([81.169.241.247]:40503 "EHLO theia.8bytes.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754585AbcBZP4C (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Fri, 26 Feb 2016 10:56:02 -0500
Date: Fri, 26 Feb 2016 16:55:58 +0100
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
Message-ID: <20160226155558.GA32730@8bytes.org>
References: <CY1PR12MB0262D12DAC0897F8DC74541CFEA40@CY1PR12MB0262.namprd12.prod.outlook.com>
 <20160223170215.GA25203@localhost>
 <CY1PR12MB0262E17EF294E8A1F23D8CB2FEA40@CY1PR12MB0262.namprd12.prod.outlook.com>
 <CY1PR12MB02629490AFFE29BACB197EA6FEA50@CY1PR12MB0262.namprd12.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CY1PR12MB02629490AFFE29BACB197EA6FEA50@CY1PR12MB0262.namprd12.prod.outlook.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Kelly,

On Wed, Feb 24, 2016 at 06:29:56PM +0000, Zytaruk, Kelly wrote:
> I don't know if the asynchronous nature of the iommu attach/detach is
> by design or if it is broken somewhere up the tree and just not
> working in my case.  Maybe one of the iommu owners could answer this.

Thanks a lot for your bug report and the detailed analysis of the
issue. I attached a possible fix for you to try out. Can you please test
it and report whether it changes anything?


Thanks,

	Joerg

>From 027b6489833aef8ce5ec46cef3e0f9e6a61dbdcd Mon Sep 17 00:00:00 2001
From: Joerg Roedel <jroedel@suse.de>
Date: Fri, 26 Feb 2016 16:48:59 +0100
Subject: [PATCH] iommu/amd: Detach device from domain before removal

Detach the device that is about to be removed from its
domain (if it has one) to clear any related state like DTE
entry and device's ATS state.

Signed-off-by: Joerg Roedel <jroedel@suse.de>
---
 drivers/iommu/amd_iommu.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/iommu/amd_iommu.c b/drivers/iommu/amd_iommu.c
index 539b0de..60cc89f 100644
--- a/drivers/iommu/amd_iommu.c
+++ b/drivers/iommu/amd_iommu.c
@@ -114,6 +114,7 @@ struct kmem_cache *amd_iommu_irq_cache;
 
 static void update_domain(struct protection_domain *domain);
 static int protection_domain_init(struct protection_domain *domain);
+static void detach_device(struct device *dev);
 
 /*
  * For dynamic growth the aperture size is split into ranges of 128MB of
@@ -384,6 +385,9 @@ static void iommu_uninit_device(struct device *dev)
 	if (!dev_data)
 		return;
 
+	if (dev_data->domain)
+		detach_device(dev);
+
 	iommu_device_unlink(amd_iommu_rlookup_table[dev_data->devid]->iommu_dev,
 			    dev);
 
-- 
1.8.4.5

