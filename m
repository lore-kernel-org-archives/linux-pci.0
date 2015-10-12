Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.17.24]:51708 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751346AbbJLMDX (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 12 Oct 2015 08:03:23 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Ley Foon Tan <lftan@altera.com>,
	Russell King - ARM Linux <linux@arm.linux.org.uk>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Marc Zyngier <marc.zyngier@arm.com>,
	Dinh Nguyen <dinguyen@opensource.altera.com>,
	linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Pawel Moll <pawel.moll@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Ian Campbell <ijc+devicetree@hellion.org.uk>,
	Kumar Gala <galak@codeaurora.org>,
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: Re: [PATCH v8 3/6] pci:host: Add Altera PCIe host controller driver
Date: Mon, 12 Oct 2015 14:03:04 +0200
Message-ID: <7064179.1W3LTfFPxP@wuerfel>
In-Reply-To: <20151009231540.GE16112@localhost>
References: <1444297394-3122-1-git-send-email-lftan@altera.com> <CAFiDJ58oMa6rgQe_STCiWRpdL+P22BN1=Nin_+QnLXC9RGiSzQ@mail.gmail.com> <20151009231540.GE16112@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Friday 09 October 2015 18:15:40 Bjorn Helgaas wrote:
> 
> I don't know if this should be a kernel taint, a simple warning in
> dmesg, or what.  I guess the tainting mechanism is probably too
> general-purpose for this, and add_taint() doesn't give any dmesg
> indication.  We wouldn't see the taint unless the problem actually
> caused an oops or panic.  In this case, I think I want a clue in dmesg
> so we have a chance of seeing it even if there is no oops.  So
> probably something like a dev_warn("non-compliant config accesses")
> would work.
> 
> You really should double-check with the hardware guys, because it's
> pretty obvious that the PCI spec requires 1- and 2-byte config
> accesses to work correctly.  For example, if you read/modify/write to
> update PCI_COMMAND, you will inadvertently clear the RW1C bits in
> PCI_STATUS.

Would it help to require a DT property here that flags the device
as having a broken config space?

Then we could implement both in the driver, and only use the
RMW based implementation if the firmware describes the device
as "altera,broken-pci-config-space".

	Arnd
