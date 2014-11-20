Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ie0-f177.google.com ([209.85.223.177]:63106 "EHLO
	mail-ie0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757210AbaKTVx4 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 20 Nov 2014 16:53:56 -0500
Received: by mail-ie0-f177.google.com with SMTP id rd18so3550509iec.8
        for <linux-pci@vger.kernel.org>; Thu, 20 Nov 2014 13:53:56 -0800 (PST)
Date: Thu, 20 Nov 2014 14:53:53 -0700
From: Bjorn Helgaas <bhelgaas@google.com>
To: Marc Zyngier <marc.zyngier@arm.com>
Cc: Yijing Wang <wangyijing@huawei.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, linux-pci@vger.kernel.org,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Jiang Liu <jiang.liu@linux.intel.com>,
	Will Deacon <will.deacon@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: Removal of bus->msi assignment breaks MSI with stacked domains
Message-ID: <20141120215353.GA7987@google.com>
References: <546E1771.4030201@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <546E1771.4030201@arm.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Nov 20, 2014 at 04:31:45PM +0000, Marc Zyngier wrote:
> Bjorn, Yijing,
> 
> I've just realized that patch c167caf8d174 (PCI/MSI: Remove useless
> bus->msi assignment) completely breaks MSI on arm64 when using the new
> MSI stacked domain:
> 
> This patch relies on architectures to implement either
> pcibios_msi_controller() or arch_setup_msi_irq(). It turns out that with
> stacked domains, none of this is actually necessary, as long as you can
> access to the msi_controller.
> 
> And everything was fine until this patch came around (and managed to
> test on a system where the PCI devices are not directly attached to the
> root bus). Of course, everything now breaks, as we cannot get to the MSI
> controller (which contains the domain we allocate the MSIs from).
> 
> In short, this patch breaks an important feature on which arm64 relies,
> and I believe this patch should be reverted ASAP.

I'm happy to revert it from pci/msi, but I think Thomas has already pulled
it into his branch, so he'd have to drop it, too.

Thomas, let me know if you want to do that.  I suppose we could add a new
patch to add it back, but that would leave bisection broken for the
interval between c167caf8d174 and the patch that adds it back.

Bjorn
