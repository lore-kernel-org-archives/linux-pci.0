Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:46634 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753792AbbINPAl (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Mon, 14 Sep 2015 11:00:41 -0400
Message-ID: <55F6E115.9050502@arm.com>
Date: Mon, 14 Sep 2015 16:00:37 +0100
From: Marc Zyngier <marc.zyngier@arm.com>
MIME-Version: 1.0
To: jakeo@microsoft.com, gregkh@linuxfoundation.org, kys@microsoft.com,
	linux-kernel@vger.kernel.org, devel@linuxdriverproject.org,
	olaf@aepfle.de, apw@canonical.com, vkuznets@redhat.com,
	linux-pci@vger.kernel.org, bhelgaas@google.com, tglx@linutronix.de,
	Jiang Liu <jiang.liu@linux.intel.com>
Subject: Re: [PATCH v2 00/12] New paravirtual PCI front-end for Hyper-V VMs
References: <1441929670-10058-1-git-send-email-jakeo@microsoft.com>
In-Reply-To: <1441929670-10058-1-git-send-email-jakeo@microsoft.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Jake,

In the future, please CC me on anything that touches irqdomains, along
with Jiang Liu as we both co-maintain this piece of code.

On 11/09/15 01:00, jakeo@microsoft.com wrote:
> From: Jake Oshins <jakeo@microsoft.com>
> 
> The patch series updates the one sent about a month ago in three ways.  It
> integrated with other IRQ domain work done in linux-next in that time, it
> distributes interrupts to multiple virtual processors in the guest VM, and it
> incorporates feedback from Thomas Gleixner and others.
> 
> These patches change the IRQ domain code so that an IRQ domain can match on both
> bus type and on the PCI domain.  The IRQ domain match code is modified so that
> IRQ domains can have a "rank," allowing for a default one which matches every
> x86 PC and more specific ones that replace the default.

I'm not really fond of this approach. We already have a way to match an
IRQ domain, and that's the device node. It looks to me that you're going
through a lot of pain inventing a new infrastructure to avoid divorcing
the two. If you could lookup your PCI IRQ domain directly based some
(non-DT) identifier, and then possibly fallback to the default one,
would that help?

If so, here's the deal: I have been working on a patch series that
addresses the above for unrelated reasons (ACPI support on arm64). It
has been posted twice already:

http://lists.infradead.org/pipermail/linux-arm-kernel/2015-July/358768.html

and the latest version is there:

https://git.kernel.org/cgit/linux/kernel/git/maz/arm-platforms.git/log/?h=irq/gsi-irq-domain-v3

I have the feeling that you could replace a lot of your patches with
this infrastructure.

Thoughts?

	M.
-- 
Jazz is not dead. It just smells funny...
