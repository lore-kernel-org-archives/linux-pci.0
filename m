Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:37904 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753813AbbDPLum (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Thu, 16 Apr 2015 07:50:42 -0400
Message-ID: <552FA20E.3060202@arm.com>
Date: Thu, 16 Apr 2015 12:50:38 +0100
From: Marc Zyngier <marc.zyngier@arm.com>
MIME-Version: 1.0
To: "Minghuan.Lian@freescale.com" <Minghuan.Lian@freescale.com>
CC: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	"Mingkai.Hu@freescale.com" <Mingkai.Hu@freescale.com>,
	Roy Zang <tie-fei.zang@freescale.com>,
	Stuart Yoder <stuart.yoder@freescale.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Scott Wood <scottwood@freescale.com>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
	Jason Cooper <jason@lakedaemon.net>,
	Thomas Gleixner <tglx@linutronix.de>,
	Will Deacon <will.deacon@arm.com>
Subject: Re: [PATCH 1/2] irqchip/gicv3-its: Support share device ID
References: <1429091364-31939-1-git-send-email-Minghuan.Lian@freescale.com>	<1429091364-31939-2-git-send-email-Minghuan.Lian@freescale.com> <20150415173654.431f5d89@arm.com> <DM2PR0301MB0640576D29E70392C41444DFE2E40@DM2PR0301MB0640.namprd03.prod.outlook.com> <552F8910.9000701@arm.com> <DM2PR0301MB0640C59C08CBEB4F2F392BAEE2E40@DM2PR0301MB0640.namprd03.prod.outlook.com>
In-Reply-To: <DM2PR0301MB0640C59C08CBEB4F2F392BAEE2E40@DM2PR0301MB0640.namprd03.prod.outlook.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Minghuan,

On 16/04/15 11:57, Minghuan.Lian@freescale.com wrote:

Please include the relevant people (Will Deacon for questions about the
SMMU), and avoid top posting, it makes it very hard to follow a discussion.

> I still have a couple of questions,
> 1. If I add a new flag and all PCI DEVID will be replaced with a
> fixed ID,  does SMMU can work correctly? For example, If we insert an
> Ethernet card with two ports, a port is assigned to kvm1, another
> port is assigned to kvm2. In this case, we should use one or two
> fixed ID?

That completely depends on what the SMMU sees. If it sees the same ID,
you won't be able to perform any form of isolation. But I have no idea
how your hardware works, so maybe explaining in details how this is
constructed will help.

> 2. If using PCIe device with SR-IOV, the driver will dynamically
> create some new PCIe devices. At this time, ITS device may has been
> created for PF.  So we must previously  create ITS device with a
> large enough nvesc. However its_get_pci_alias: dev_alias->count +=
> its_pci_msi_vec_count(dev_alias->pdev) only calculate with the
> exiting PCIe device, could not meet this requirement. How to change
> dev_alias->count?

You cannot change this dynamically. The ITT for this DeviceID will have
been allocated, and the ITS is getting live traffic. No way you're going
to resize it.

You will probable have to add some extra quirks to force the allocation
of a much larger ITT by lying about the nvec somehow. Or forget about
SRIOV and hotplug.

	M.
-- 
Jazz is not dead. It just smells funny...
