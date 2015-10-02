Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:40766 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751368AbbJBPLR (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Fri, 2 Oct 2015 11:11:17 -0400
Message-ID: <560E9E90.6000709@arm.com>
Date: Fri, 02 Oct 2015 16:11:12 +0100
From: Marc Zyngier <marc.zyngier@arm.com>
MIME-Version: 1.0
To: David Daney <ddaney.cavm@gmail.com>, linux-kernel@vger.kernel.org,
	Will Deacon <will.deacon@arm.com>,
	Rob Herring <robh+dt@kernel.org>,
	Pawel Moll <pawel.moll@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Ian Campbell <ijc+devicetree@hellion.org.uk>,
	Kumar Gala <galak@codeaurora.org>,
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
	Grant Likely <grant.likely@linaro.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Jason Cooper <jason@lakedaemon.net>,
	Frank Rowand <frowand.list@gmail.com>,
	Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
CC: David Daney <david.daney@cavium.com>
Subject: Re: [PATCH v4 3/4] PCI/MSI:  Add helper function pci_msi_domain_get_msi_rid().
References: <1443747025-9918-1-git-send-email-ddaney.cavm@gmail.com> <1443747025-9918-4-git-send-email-ddaney.cavm@gmail.com>
In-Reply-To: <1443747025-9918-4-git-send-email-ddaney.cavm@gmail.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 02/10/15 01:50, David Daney wrote:
> From: David Daney <david.daney@cavium.com>
> 
> Add pci_msi_domain_get_msi_rid() to return the MSI requester id (RID).
> Initially needed by gic-v3 based systems. It will be used by follow on
> patch to drivers/irqchip/irq-gic-v3-its-pci-msi.c
> 
> Initially supports mapping the RID via OF device tree.  In the future,
> this could be extended to use ACPI _IORT tables as well.
> 
> Signed-off-by: David Daney <david.daney@cavium.com>

Reviewed-by: Marc Zyngier <marc.zyngier@arm.com>

	M.
-- 
Jazz is not dead. It just smells funny...
