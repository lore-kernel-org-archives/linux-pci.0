Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([217.72.192.73]:58756 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754613AbbKSIY1 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 19 Nov 2015 03:24:27 -0500
From: Arnd Bergmann <arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
Cc: Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>,
	rjw@rjwysocki.net, bhelgaas@google.com, robin.murphy@arm.com,
	linux-pci@vger.kernel.org,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Subject: Re: [PATCH] PCI: Fix logic OF logic in pci_dma_configure()
Date: Thu, 19 Nov 2015 09:23:43 +0100
Message-ID: <4205822.O3dsjd4r6S@wuerfel>
In-Reply-To: <1447894192-17210-1-git-send-email-Suravee.Suthikulpanit@amd.com>
References: <1447894192-17210-1-git-send-email-Suravee.Suthikulpanit@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wednesday 18 November 2015 16:49:52 Suravee Suthikulpanit wrote:
> -       if (IS_ENABLED(CONFIG_OF) && dev->dev.of_node) {
> -               if (bridge->parent)
> +       if (IS_ENABLED(CONFIG_OF) &&
> +               bridge->parent && bridge->parent->of_node) {
>                         of_dma_configure(&dev->dev, bridge->parent->of_node);
> 

Acked-by: Arnd Bergmann <arnd@arndb.de>

I was wondering for a bit whether we should warn about the case where there
is no of_node pointer, as that would mean we cannot do DMA on that PCI
device, but on second thought we have to do it exactly like you do, because
we would otherwise break machines that do not use DT.

	Arnd
