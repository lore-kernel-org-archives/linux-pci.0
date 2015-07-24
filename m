Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:46232 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752688AbbGXQyj (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Fri, 24 Jul 2015 12:54:39 -0400
Message-ID: <55B26DC9.8010408@arm.com>
Date: Fri, 24 Jul 2015 17:54:33 +0100
From: Marc Zyngier <marc.zyngier@arm.com>
MIME-Version: 1.0
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
CC: Bjorn Helgaas <bhelgaas@google.com>,
	Russell King <linux@arm.linux.org.uk>,
	James Morse <James.Morse@arm.com>,
	Gabriele Paoloni <gabriele.paoloni@huawei.com>,
	Jayachandran C <jchandra@broadcom.com>,
	Pratyush Anand <pratyush.anand@gmail.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Jingoo Han <jingoohan1@gmail.com>,
	Simon Horman <horms@verge.net.au>,
	Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
	Thierry Reding <thierry.reding@gmail.com>,
	Michal Simek <michal.simek@xilinx.com>
Subject: Re: [PATCH v2 1/2] ARM: PCI: bios32: replace panic with WARN messages
 on failures
References: <1437754383-8162-1-git-send-email-lorenzo.pieralisi@arm.com>
In-Reply-To: <1437754383-8162-1-git-send-email-lorenzo.pieralisi@arm.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 24/07/15 17:13, Lorenzo Pieralisi wrote:
> In the ARM PCI bios32 layer, failures to dynamically allocate pci_sys_data
> for a PCI bus, or a PCI bus scan failure have to be considered serious
> warnings but they should not trigger a system panic so that at least the
> system is given a chance to be debugged.
> 
> This patch replaces the panic statements with WARN() messages to
> improve error reporting in the ARM PCI bios32 layer.
> 
> Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Cc: Russell King <linux@arm.linux.org.uk>
> Cc: Marc Zyngier <marc.zyngier@arm.com>

Acked-by: Marc Zyngier <marc.zyngier@arm.com>

	M.
-- 
Jazz is not dead. It just smells funny...
