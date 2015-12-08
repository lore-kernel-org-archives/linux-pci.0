Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:52308 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752634AbbLHU6j (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 8 Dec 2015 15:58:39 -0500
Date: Tue, 8 Dec 2015 21:57:42 +0100 (CET)
From: Thomas Gleixner <tglx@linutronix.de>
To: Jake Oshins <jakeo@microsoft.com>
cc: gregkh@linuxfoundation.org, kys@microsoft.com,
	linux-kernel@vger.kernel.org, devel@linuxdriverproject.org,
	olaf@aepfle.de, apw@canonical.com, vkuznets@redhat.com,
	haiyangz@microsoft.com, marc.zyngier@arm.com, bhelgaas@google.com,
	linux-pci@vger.kernel.org
Subject: Re: [PATCH v7 7/7] PCI: hv: New paravirtual PCI front-end for Hyper-V
 VMs
In-Reply-To: <1449275767-1510-8-git-send-email-jakeo@microsoft.com>
Message-ID: <alpine.DEB.2.11.1512082157140.3595@nanos>
References: <1449275767-1510-1-git-send-email-jakeo@microsoft.com> <1449275767-1510-8-git-send-email-jakeo@microsoft.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Sat, 5 Dec 2015, jakeo@microsoft.com wrote:

> From: Jake Oshins <jakeo@microsoft.com>
> 
> This patch introduces a new driver which exposes a root PCI bus whenever a
> PCI Express device is passed through to a guest VM under Hyper-V. The
> device can be single- or multi-function. The interrupts for the devices
> are managed by an IRQ domain, implemented within the driver.
> 
> Signed-off-by: Jake Oshins <jakeo@microsoft.com>

For the irq related parts of this:

    Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
