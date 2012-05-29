Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from va3ehsobe003.messaging.microsoft.com ([216.32.180.13]:55768
	"EHLO va3outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753082Ab2E2KQu (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 29 May 2012 06:16:50 -0400
Date: Tue, 29 May 2012 12:16:57 +0200
From: Joerg Roedel <joerg.roedel@amd.com>
To: Antonio Quartulli <ordex@autistici.org>
CC: Bjorn Helgaas <bhelgaas@google.com>, <linux-pci@vger.kernel.org>,
	<iommu@lists.linux-foundation.org>
Subject: Re: warn_slowpath_common in drivers/pci/search.c:44 on linux-3.4.0
Message-ID: <20120529101657.GO2604@amd.com>
References: <20120526082551.GA2723@ritirata.org>
 <CAErSpo553_-AivRa7VbjHrFraHaO4NYoYR7A9Am5fkDP-CMvSA@mail.gmail.com>
 <20120529083552.GN2604@amd.com>
 <20120529085648.GA13941@ritirata.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
In-Reply-To: <20120529085648.GA13941@ritirata.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, May 29, 2012 at 10:56:50AM +0200, Antonio Quartulli wrote:
> attached!
> Some days ago I tried to put some printk in the code and, as far as I can
> understand, you are right.

Hmm, looks like device 03:00.0 is a 32bit PCI device attached to device
00:1c.2 which calls itself a Root Port instead of a PCI Bridge. I am
not sure if the check in search.c is really necessary. As I see it there
are also other possible pcie_types like PCI_EXP_TYPE_PCIE_BRIDGE.
Putting Anil Keshavamurthy on Cc.

Anil, is this check in pci_find_upstream_pcie_bridge() really
necessary:

        /* PCI device should connect to a PCIe bridge */
        if (pdev->pcie_type != PCI_EXP_TYPE_PCI_BRIDGE) {
                /* Busted hardware? */
                WARN_ON_ONCE(1);
                return NULL;
        }

? In the warning that triggers for Antonio the value of pcie_type seems
to be PCI_EXP_TYPE_ROOT_PORT and from the available types I think that
PCI_EXP_TYPE_PCIE_BRIDGE is also possible.

Thanks,

	Joerg

-- 
AMD Operating System Research Center

Advanced Micro Devices GmbH Einsteinring 24 85609 Dornach
General Managers: Alberto Bozzo
Registration: Dornach, Landkr. Muenchen; Registerger. Muenchen, HRB Nr. 43632

