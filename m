Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:59602 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759258AbbIVSXu (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Tue, 22 Sep 2015 14:23:50 -0400
Date: Tue, 22 Sep 2015 19:23:48 +0100
From: Marc Zyngier <marc.zyngier@arm.com>
To: Ley Foon Tan <lftan@altera.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Russell King <linux@arm.linux.org.uk>,
	Arnd Bergmann <arnd@arndb.de>,
	Dinh Nguyen <dinguyen@opensource.altera.com>,
	<linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>,
	<linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<lftan.linux@gmail.com>, Rob Herring <robh+dt@kernel.org>,
	Pawel Moll <pawel.moll@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Ian Campbell <ijc+devicetree@hellion.org.uk>,
	"Kumar Gala" <galak@codeaurora.org>,
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: Re: [PATCH v7 1/6] arm: add msi.h to Kbuild
Message-ID: <20150922192348.1c9814c8@arm.com>
In-Reply-To: <1442801587-3812-2-git-send-email-lftan@altera.com>
References: <1442801587-3812-1-git-send-email-lftan@altera.com>
	<1442801587-3812-2-git-send-email-lftan@altera.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, 21 Sep 2015 10:13:02 +0800
Ley Foon Tan <lftan@altera.com> wrote:

> Include asm-generic/msi.h to support CONFIG_GENERIC_MSI_IRQ_DOMAIN.
> This to fix compilation error:
> "include/linux/msi.h:123:21: fatal error: asm/msi.h:
> No such file or directory"
> 
> Signed-off-by: Ley Foon Tan <lftan@altera.com>

Acked-by: Marc Zyngier <marc.zyngier@arm.com>

	M.
-- 
Jazz is not dead. It just smells funny.
