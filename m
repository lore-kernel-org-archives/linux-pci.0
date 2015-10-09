Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from down.free-electrons.com ([37.187.137.238]:33359 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753859AbbJIPTO (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 9 Oct 2015 11:19:14 -0400
Date: Fri, 9 Oct 2015 17:18:52 +0200
From: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Jason Cooper <jason@lakedaemon.net>,
	Bjorn Helgaas <bhelgaas@google.com>,
	linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH 0/9] Further mvebu PCIe patches
Message-ID: <20151009171852.35bd920d@free-electrons.com>
In-Reply-To: <20151003181228.GI21513@n2100.arm.linux.org.uk>
References: <20151003181228.GI21513@n2100.arm.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Rusell, all,

On Sat, 3 Oct 2015 19:12:28 +0100, Russell King - ARM Linux wrote:

> Here are further PCIe patches which follow on from the previous set of
> six I sent earlier in September.  This set:
> 
> * Separates the DT parsing from the use of this parsed data.
> * Fixes memory leaks from kasprintf() and refcount leaks of the DT
>   node where we break out from the loop early.
> * Uses gpio_set_value_cansleep() so that GPIOs on I2C expanders can
>   be used for the PCIe reset functionality.
> * Switch to using devm_kcalloc() instead of devm_kzalloc(), which
>   eliminates the multiplication, moving it into core code.
> * Switch to using a gpio descriptor for the reset gpio, which can
>   contain the active level information from DT.  (It would be nice
>   if gpiolib automated some of the resource claiming there.)
> * Make PERST# vs clock timing to match PCIe specifications.  PCIe
>   specs require the clock to be running for 100us prior to releasing
>   reset.
> * Add the standard PCIe capability block in root port form to the
>   emulated PCIe configuration block.  This allows the PCI layer to
>   identify the "host bridge" as a PCIe device, and allows us to
>   take advantage of the code in drivers/pci/pcie, particularly
>   aspm for link power management.
> * As a result of identifying ourselves as a PCIe root port, this
>   eliminates the need to special case accesses to non-slot 0 in
>   the driver; the lack of other "slots" is something which the
>   generic PCI code knows about for PCIe root ports.

Entire series tested on Armada XP GP, with 3 PCIe cards plugged in.
They seem to work, and the lspci -v output seems sane. I've also
reviewed the patch series, and it looks good to me.

Reviewed-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com> 
Tested-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>

Thanks!

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
