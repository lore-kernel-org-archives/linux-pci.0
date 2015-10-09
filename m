Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.17.24]:59987 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753723AbbJIScU (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 9 Oct 2015 14:32:20 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: Liviu Dudau <Liviu.Dudau@arm.com>
Cc: Will Deacon <will.deacon@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Rob Herring <robh+dt@kernel.org>,
	Ian Campbell <ijc+devicetree@hellion.org.uk>,
	Kumar Gala <galak@codeaurora.org>,
	Jon Medhurst <tixy@linaro.org>,
	linux-pci <linux-pci@vger.kernel.org>,
	device-tree <devicetree@vger.kernel.org>,
	LAKML <linux-arm-kernel@lists.infradead.org>,
	LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 2/5] PCI: Add quirk for PLDA's XpressRICH3 host bridge class.
Date: Fri, 09 Oct 2015 20:32:07 +0200
Message-ID: <7335872.olmykfZgj7@wuerfel>
In-Reply-To: <1444409849-5685-3-git-send-email-Liviu.Dudau@arm.com>
References: <1444409849-5685-1-git-send-email-Liviu.Dudau@arm.com> <1444409849-5685-3-git-send-email-Liviu.Dudau@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Friday 09 October 2015 17:57:26 Liviu Dudau wrote:
> +/*
> + * The PLDA's XpressRICH3 doesn't describe itself as a bridge. This is required
> + * for correct/normal enumeration.
> + */
> +static void xr3pci_quirk_class(struct pci_dev *pdev)
> +{
> +       pdev->class = PCI_CLASS_BRIDGE_PCI << 8;
> +}
> +DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_PLDA, PCI_DEVICE_ID_XR3PCI, xr3pci_quirk_class);
> 

Are you sure that this device ID is only used for the host bridge, not
for related devices in endpoint mode?

While we don't support PCIe endpoint drivers at the moment, it might
happen at some point and then things break when someone tries to
plug a machine with this ID into a Linux host.

	Arnd
