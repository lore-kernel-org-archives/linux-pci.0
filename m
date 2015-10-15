Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.130]:58304 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752514AbbJOTQ4 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 15 Oct 2015 15:16:56 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: Marc Zyngier <marc.zyngier@arm.com>
Cc: linux-arm-kernel@lists.infradead.org,
	Thomas Gleixner <tglx@linutronix.de>,
	Jiang Liu <jiang.liu@linux.intel.com>,
	Jason Cooper <jason@lakedaemon.net>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, Ma Jun <majun258@huawei.com>
Subject: Re: [PATCH RFC 0/7] Adding core support for wire-MSI bridges
Date: Thu, 15 Oct 2015 21:16:15 +0200
Message-ID: <5879538.pKBkpUOxls@wuerfel>
In-Reply-To: <561FCDBE.8000407@arm.com>
References: <1444923568-17413-1-git-send-email-marc.zyngier@arm.com> <5027676.zPNVVQXaP4@wuerfel> <561FCDBE.8000407@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thursday 15 October 2015 17:01:02 Marc Zyngier wrote:
> 
> "Preconfigured" is the key word. While you can do something like that if
> your hardware treats MSIs just as if they were wired interrupts
> (something like GICv2m), it becomes far more hairy if the target of MSIs
> is something like a GICv3 ITS (which is the case for HiSilicon mbigen).
> 
> The main reason is that the ITS relies on "translation tables" kept in
> memory, which the OS has to configure, and handing over pre-configured
> tables is not something I'm looking forward to doing. From a CPU point
> of view, this is akin entering the kernel with the MMU already on and no
> idmap...
> 
> The approach taken here is to make the MSI-ness explicit at the irqchip
> level, and keep the interrupting device oblivious of that feature. Also,
> this relies on the fact that we can have one MSI per wire, meaning that
> we don't have to multiplex anything (no nested irqchip), and that we can
> rely on hierarchical domains, which simplifies the code (at least for
> the irqchip).
> 

Thanks, that already makes things much clearer. Just one more question:
why can't those translation tables be configured statically by the
irqchip driver? Is this all about being able to cut a few cycles
in case of virtualization? I would assume that once you have gone through
the overhead of having both an MSI and a normal interrupt line (with
the need for serialization vs DMA), you can just as well trap to user
space to deliver an IRQ to a guest.

	Arnd
