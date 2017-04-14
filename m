Return-Path: <SRS0=WMCN=3W=codeaurora.org=okaya@kernel.org>
Return-Path: <SRS0=WMCN=3W=codeaurora.org=okaya@kernel.org>
Subject: Re: [PATCH V8 3/5] PCI/ASPM: add init hook to device_add
To: Bjorn Helgaas <helgaas@kernel.org>
References: <1491627351-1111-1-git-send-email-okaya@codeaurora.org>
 <1491627351-1111-4-git-send-email-okaya@codeaurora.org>
 <20170413204800.GB28316@bhelgaas-glaptop.roam.corp.google.com>
 <20170413210218.GA24910@bhelgaas-glaptop.roam.corp.google.com>
Cc: mayurkumar.patel@intel.com, David Daney <david.daney@cavium.com>,
 linux-pci@vger.kernel.org, timur@codeaurora.org,
 linux-kernel@vger.kernel.org, Julia Lawall <Julia.Lawall@lip6.fr>,
 linux-arm-msm@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
 Rajat Jain <rajatja@google.com>, linux-arm-kernel@lists.infradead.org
From: Sinan Kaya <okaya@codeaurora.org>
Message-ID: <76b74ad0-0c7f-a366-89d6-dc87ac315bc5@codeaurora.org>
Date: Thu, 13 Apr 2017 21:19:17 -0400
MIME-Version: 1.0
In-Reply-To: <20170413210218.GA24910@bhelgaas-glaptop.roam.corp.google.com>
Content-Type: text/plain; charset=windows-1252
List-ID: <linux-pci.vger.kernel.org>

On 4/13/2017 5:02 PM, Bjorn Helgaas wrote:
> I do see that you change the deallocation in patch [5/5], but I think
> the deallocation change should be in the same patch as the allocation
> change.  Otherwise I think we have a use-after-free problem in this
> sequence:

Sure, I'll reorder. As you can see here, link will be only removed if
root port is being removed.

Without this, we'll hit the use after free issue you mentioned.

	if (pdev->has_secondary_link) {
		link = pdev->link_state;
		down_read(&pci_bus_sem);
		mutex_lock(&aspm_lock);

		list_del(&link->sibling);
		list_del(&link->link);

		/* Clock PM is for endpoint device */
		free_link_state(link);
		mutex_unlock(&aspm_lock);
		up_read(&pci_bus_sem);
		return;
	}  

-- 
Sinan Kaya
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
