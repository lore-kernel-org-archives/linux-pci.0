Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-oi0-f49.google.com ([209.85.218.49]:39834 "EHLO
	mail-oi0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750898AbbAXAyJ (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 23 Jan 2015 19:54:09 -0500
Received: by mail-oi0-f49.google.com with SMTP id a3so406050oib.8
        for <linux-pci@vger.kernel.org>; Fri, 23 Jan 2015 16:54:08 -0800 (PST)
Date: Fri, 23 Jan 2015 18:54:04 -0600
From: Bjorn Helgaas <bhelgaas@google.com>
To: Rob Herring <robherring2@gmail.com>
Cc: linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
	Russell King <linux@arm.linux.org.uk>,
	Linus Walleij <linus.walleij@linaro.org>,
	Peter Maydell <peter.maydell@linaro.org>, arm@kernel.org,
	Rob Herring <robh@kernel.org>, linux-pci@vger.kernel.org
Subject: Re: [PATCH 4/9] pci: add DT based ARM Versatile PCI host driver
Message-ID: <20150124005404.GZ29776@google.com>
References: <1419967718-26909-1-git-send-email-robherring2@gmail.com>
 <1419967718-26909-5-git-send-email-robherring2@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1419967718-26909-5-git-send-email-robherring2@gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Sorry for the late reply; maybe this has already been queued up somewhere,
so this might be moot.

I usually capitalize the "PCI" and first letter of the subject, like:

  PCI: Add DT based ARM Versatile PCI host driver

And I try to ask for MAINTAINER updates since these drivers are under
drivers/pci, but I can't maintain them all myself.

On Tue, Dec 30, 2014 at 01:28:33PM -0600, Rob Herring wrote:
> From: Rob Herring <robh@kernel.org>
> 
> This converts the Versatile PCI host code to a platform driver using
> the commom DT parsing and setup. The driver uses only an empty ARM
> pci_sys_data struct and does not use pci_common_init_dev init function.
> The old host code will be removed in a subsequent commit when Versatile
> is completely converted to DT.
> 
> I've tested this on QEMU with the sym53c8xx driver in both i/o and
> memory mapped modes.
> 
> Signed-off-by: Rob Herring <robh@kernel.org>
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Cc: linux-pci@vger.kernel.org
> Cc: Russell King <linux@arm.linux.org.uk>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Cc: Peter Maydell <peter.maydell@linaro.org>

Looks fine to me.

Acked-by: Bjorn Helgaas <bhelgaas@google.com>

> +++ b/drivers/pci/host/pci-versatile.c
> ...

> +	/*
> +	 *  We need to discover the PCI core first to configure itself
> +	 *  before the main PCI probing is performed

Unusual to have two spaces between the "*" and the comments here.

> +MODULE_LICENSE("GPLv2");

This needs to be "GPL v2" per license_is_gpl_compatible().
