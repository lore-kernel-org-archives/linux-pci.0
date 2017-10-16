Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from Galois.linutronix.de ([146.0.238.70]:53612 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753432AbdJPWHE (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 16 Oct 2017 18:07:04 -0400
Date: Tue, 17 Oct 2017 00:06:56 +0200 (CEST)
From: Thomas Gleixner <tglx@linutronix.de>
To: Dexuan Cui <decui@microsoft.com>
cc: Bjorn Helgaas <bhelgaas@google.com>,
        KY Srinivasan <kys@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "devel@linuxdriverproject.org" <devel@linuxdriverproject.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Josh Poulson <jopoulso@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Simon Xiao <sixiao@microsoft.com>,
        Saeed Mahameed <saeedm@mellanox.com>,
        "Mihai Costache (Cloudbase Solutions SRL)" <v-micos@microsoft.com>,
        Jork Loeser <Jork.Loeser@microsoft.com>
Subject: Re: [PATCH] PCI: hv: fix "spurious APIC interrupt" due to new vector
 reservation mode
In-Reply-To: <KL1P15301MB0006E6E2D1AF8F6E27686DD0BF490@KL1P15301MB0006.APCP153.PROD.OUTLOOK.COM>
Message-ID: <alpine.DEB.2.20.1710170004480.2037@nanos>
References: <KL1P15301MB0006E6E2D1AF8F6E27686DD0BF490@KL1P15301MB0006.APCP153.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Sat, 14 Oct 2017, Dexuan Cui wrote:
> Last month the vector management code was reworked, and as a result of the
> changes, e.g. commit 22d0b12f3560 ("genirq/irqdomain: Add force
> reactivation flag to irq domains"), commit 4900be83602b ("x86/vector/msi:
> Switch to global reservation mode") etc, now we must add this new flag
> MSI_FLAG_MUST_REACTIVATE when calling pci_msi_create_irq_domain() on x86,
> otherwise Hyper-V PCIe pass-through can't work, and we get:
> "spurious APIC interrupt through vector ff on CPU#0, should never happen",
> this is because no valid MSI/MSI-X vector is allocated.
> 
> Signed-off-by: Dexuan Cui <decui@microsoft.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Cc: K. Y. Srinivasan <kys@microsoft.com>
> Cc: Haiyang Zhang <haiyangz@microsoft.com>
> Cc: Stephen Hemminger <sthemmin@microsoft.com>
> ---
> 
> Currently the "reservation mode" patchset has not been in Linus's tree yet, so
> today's mainline hasn't shown the issue, but today's linux-next has shown the
> issue (PCIe pass-through on Hyper-V can't work).
> 
> I think any caller of pci_msi_create_irq_domain() that runs on x86 needs to
> be updated, but besides pci-hyper I'm not sure which callers run on x86.

I'm sure I thought about adding something to pci_msi_create_irq_domain() in
the first place, but then forgot about it again. I'll have a look tomorrow
morning.

Thanks,

	tglx
