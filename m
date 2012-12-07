Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-lb0-f174.google.com ([209.85.217.174]:42635 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755130Ab2LGSfn (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 7 Dec 2012 13:35:43 -0500
Received: by mail-lb0-f174.google.com with SMTP id gi11so628914lbb.19
        for <linux-pci@vger.kernel.org>; Fri, 07 Dec 2012 10:35:42 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20121205205724.13851.50508.stgit@bhelgaas.mtv.corp.google.com>
References: <20121205205724.13851.50508.stgit@bhelgaas.mtv.corp.google.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Fri, 7 Dec 2012 11:35:21 -0700
Message-ID: <CAErSpo5sGb=pZFsr5HwThLAEwE6ZNdmFoSOzqubGFVgZtVMXhw@mail.gmail.com>
Subject: Re: [PATCH 01/12] PCI: Add and use standard PCI-X Capability register names
To: linux-pci@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>,
	Stanislaw Gruszka <sgruszka@redhat.com>,
	David Miller <davem@davemloft.net>,
	"John W. Linville" <linville@tuxdriver.com>,
	Jeff Kirsher <jeffrey.t.kirsher@intel.com>,
	Saurav Kashyap <saurav.kashyap@qlogic.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Dec 5, 2012 at 1:57 PM, Bjorn Helgaas <bhelgaas@google.com> wrote:
> Add and use #defines for PCI-X Capability registers and fields.
> Note that the PCI-X Capability has a different layout for
> type 0 (endpoint) and type 1 (bridge) devices.

I added the following patches from this series to my -next branch and
plan to merge them in the v2.8 merge window next week.  The non-PCI
ones have been acked and the maintainers are OK with merging them
through the PCI tree.

    * pci/bjorn-pcie-cap:
      iwlwifi: Use standard #defines for PCIe Capability ASPM fields
      iwlwifi: collapse wrapper for pcie_capability_read_word()
      iwlegacy: Use standard #defines for PCIe Capability ASPM fields
      iwlegacy: collapse wrapper for pcie_capability_read_word()
      cxgb3: Use standard #defines for PCIe Capability ASPM fields
      PCI: Add standard PCIe Capability Link ASPM field names
      PCI/portdrv: Use PCI Express Capability accessors
      PCI: Use standard PCIe Capability Link register field names
      PCI: Add and use standard PCI-X Capability register names

I did not merge the following patches.  They depend on one of the
patches above and the e1000e one conflicts with other patches in the
queue.  So these can be merged at any time after v3.8-rc1 (or even
before -rc1 as long as it's after the PCI -next branch is merged).

    ath9k: Use standard #defines for PCIe Capability ASPM fields
    e1000e: Use standard #defines for PCIe Capability ASPM fields
    [SCSI] qla2xxx: Use standard PCIe Capability Link register field names

Bjorn
