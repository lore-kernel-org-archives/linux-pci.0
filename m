Return-Path: <SRS0=Dddn=ZW=codeaurora.org=okaya@kernel.org>
Return-Path: <SRS0=Dddn=ZW=codeaurora.org=okaya@kernel.org>
Subject: Re: [PATCH V2] PCI: enable extended tags support for PCIe devices
To: Bjorn Helgaas <helgaas@kernel.org>
References: <1484921814-8511-1-git-send-email-okaya@codeaurora.org>
 <20170209233346.GB29169@bhelgaas-glaptop.roam.corp.google.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org
From: Sinan Kaya <okaya@codeaurora.org>
Message-ID: <11178adf-2b4c-1351-963e-d5ea53974a0f@codeaurora.org>
Date: Thu, 9 Feb 2017 18:40:56 -0500
MIME-Version: 1.0
In-Reply-To: <20170209233346.GB29169@bhelgaas-glaptop.roam.corp.google.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-pci.vger.kernel.org>

On 2/9/2017 6:33 PM, Bjorn Helgaas wrote:
> Applied to pci/enumeration for v4.11 as follows, thanks!
> 
> I added a check for PCIe, so we don't have to rely on
> pcie_capability_read_dword() doing the right thing for PCI and PCI-X
> devices.  I think pcie_capability_read_dword() would set dev_cap to zero
> and return zero, which would be safe, but I don't the reader should have to
> do that much analysis to figure it out.

Thanks for cleaning up the commit message and adding the pci_is_pcie check.

-- 
Sinan Kaya
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
