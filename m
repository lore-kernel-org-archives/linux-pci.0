Return-Path: <SRS0=H88W=7E=codeaurora.org=okaya@kernel.org>
Return-Path: <SRS0=H88W=7E=codeaurora.org=okaya@kernel.org>
Subject: Re: [PATCH V7 1/3] PCI: limit FLR wait time to 100ms maximum
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org, timur@codeaurora.org,
 alex.williamson@redhat.com, linux-arm-msm@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, Bjorn Helgaas <bhelgaas@google.com>,
 linux-kernel@vger.kernel.org
References: <1501701317-32249-1-git-send-email-okaya@codeaurora.org>
 <20170802202735.GE20308@bhelgaas-glaptop.roam.corp.google.com>
From: Sinan Kaya <okaya@codeaurora.org>
Message-ID: <db1860be-9b0b-85b1-814c-40e497ac792f@codeaurora.org>
Date: Wed, 2 Aug 2017 17:22:08 -0400
MIME-Version: 1.0
In-Reply-To: <20170802202735.GE20308@bhelgaas-glaptop.roam.corp.google.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-pci.vger.kernel.org>

On 8/2/2017 4:27 PM, Bjorn Helgaas wrote:
> On Wed, Aug 02, 2017 at 03:15:15PM -0400, Sinan Kaya wrote:
> My hypothesis was that CRS isn't useful on VFs because of sec 2.2.2
> says "FLR ... does not affect its existence in PCI Configuration
> Space".  But I think that hypothesis is wrong because sec 3.3.3.1
> does talk about a VF returning CRS.
> 

hmm, good catch. I'll drop the first patch.

> The SR-IOV spec (sec 3.4.1.1) says a VF's Vendor ID is read-only
> 0xffff.  But I expect CRS visibility (PCIe r3.1, sec 2.3.2) would work
> normally and return a Vendor ID of 0x0001 to indicate CRS for a VF.
> 
> Of course, not all Root Ports support CRS software visibility, so
> whatever we do has to work when it's absent.

How about a mixture of old code and new code as follows?

static void pci_flr_wait(struct pci_dev *dev)
{
	u32 id;
	bool ret = false;
	int i = 0;

	if (CRS supported) {
		/* don't touch the HW before waiting 100ms */
		msleep(100);

		ret = pci_bus_read_dev_vendor_id(dev->bus, dev->devfn, &id, 60000);
		if (ret)
			return;
	}

	do {
		msleep(100);
		pci_read_config_dword(dev, PCI_COMMAND, &id);
	} while (i++ < 10 && id == ~0);
 
	if (id == ~0)
 		dev_warn(&dev->dev, "Failed to return from FLR\n");
	else if (i > 1)
		dev_info(&dev->dev, "Required additional %dms to return from FLR\n",
			 (i - 1) * 100);
}


-- 
Sinan Kaya
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
