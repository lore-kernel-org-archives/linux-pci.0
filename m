Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.17.13]:50277 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752708AbaKZQzL (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 26 Nov 2014 11:55:11 -0500
From: Arnd Bergmann <arnd@arndb.de>
To: Thierry Reding <thierry.reding@gmail.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Liviu Dudau <liviu.dudau@arm.com>,
	Marc Zyngier <marc.zyngier@arm.com>, linux-pci@vger.kernel.org,
	linux-tegra@vger.kernel.org
Subject: Re: [PATCH] PCI: tegra: Use physical range for I/O mapping
Date: Wed, 26 Nov 2014 17:55:05 +0100
Message-ID: <3072281.UjpXkitFjL@wuerfel>
In-Reply-To: <1417018897-3965-1-git-send-email-thierry.reding@gmail.com>
References: <1417018897-3965-1-git-send-email-thierry.reding@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wednesday 26 November 2014 17:21:37 Thierry Reding wrote:
> -
> +       pci_add_resource_offset(&sys->resources, &pcie->pio, sys->io_offset);
>         pci_add_resource_offset(&sys->resources, &pcie->mem, sys->mem_offset);
>         pci_add_resource_offset(&sys->resources, &pcie->prefetch,
>                                 sys->mem_offset);
> 

You don't set sys->io_offset anywhere, which is a bug if you have multiple
instances of the PCI host in one system. In my draft patch, I was setting
both io_offset and mem_offset for consistency, and while mem_offset would
in practice be always zero (as discussed on IRC), the io_offset in fact has
a realistic chance of being nonzero and you should definitely set it.

	Arnd
