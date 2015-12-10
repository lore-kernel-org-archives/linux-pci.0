Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:56923 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752746AbbLJSNw (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Thu, 10 Dec 2015 13:13:52 -0500
Message-ID: <5669C0DD.8010304@arm.com>
Date: Thu, 10 Dec 2015 18:13:49 +0000
From: Marc Zyngier <marc.zyngier@arm.com>
MIME-Version: 1.0
To: jakeo@microsoft.com, gregkh@linuxfoundation.org, kys@microsoft.com,
	linux-kernel@vger.kernel.org, devel@linuxdriverproject.org,
	olaf@aepfle.de, apw@canonical.com, vkuznets@redhat.com,
	tglx@linutronix.de, haiyangz@microsoft.com, bhelgaas@google.com,
	linux-pci@vger.kernel.org
Subject: Re: [PATCH v10 3/7] PCI: Make it possible to implement a PCI MSI
 IRQ Domain in a module.
References: <1449769983-12948-1-git-send-email-jakeo@microsoft.com> <1449769983-12948-4-git-send-email-jakeo@microsoft.com>
In-Reply-To: <1449769983-12948-4-git-send-email-jakeo@microsoft.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 10/12/15 17:52, jakeo@microsoft.com wrote:
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

Reviewed-by: Marc Zyngier <marc.zyngier@arm.com>

	M.
-- 
Jazz is not dead. It just smells funny...
