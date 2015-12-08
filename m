Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:52321 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752634AbbLHVA5 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 8 Dec 2015 16:00:57 -0500
Date: Tue, 8 Dec 2015 22:00:03 +0100 (CET)
From: Thomas Gleixner <tglx@linutronix.de>
To: Jake Oshins <jakeo@microsoft.com>
cc: gregkh@linuxfoundation.org, kys@microsoft.com,
	linux-kernel@vger.kernel.org, devel@linuxdriverproject.org,
	olaf@aepfle.de, apw@canonical.com, vkuznets@redhat.com,
	haiyangz@microsoft.com, marc.zyngier@arm.com, bhelgaas@google.com,
	linux-pci@vger.kernel.org
Subject: Re: [PATCH v7 3/7] PCI: Make it possible to implement a PCI MSI IRQ
 Domain in a module.
In-Reply-To: <1449275767-1510-4-git-send-email-jakeo@microsoft.com>
Message-ID: <alpine.DEB.2.11.1512082158310.3595@nanos>
References: <1449275767-1510-1-git-send-email-jakeo@microsoft.com> <1449275767-1510-4-git-send-email-jakeo@microsoft.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Sat, 5 Dec 2015, jakeo@microsoft.com wrote:
> From: Jake Oshins <jakeo@microsoft.com>
> 
> The Linux kernel already has the concpet of IRQ domain, wherein a
> component can expose a set of IRQs which are managed by a particular
> interrupt controller chip or other subsystem. The PCI driver exposes
> the notion of an IRQ domain for Message-Signaled Interrupts (MSI) from
> PCI Express devices. This patch exposes the functions which are
> necessary for making an MSI IRQ domain within a module.
> 
> Signed-off-by: Jake Oshins <jakeo@microsoft.com>

As the reset of the series depends on this:

Reviewed-by: Thomas Gleixner <tglx@linutronix.de>

