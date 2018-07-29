Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from bmailout1.hostsharing.net ([83.223.95.100]:33809 "EHLO
        bmailout1.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726203AbeG2NjS (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 29 Jul 2018 09:39:18 -0400
Date: Sun, 29 Jul 2018 14:09:01 +0200
From: Lukas Wunner <lukas@wunner.de>
To: Sinan Kaya <okaya@kernel.org>
Cc: Alex_Gagniuc@Dellteam.com, mr.nuke.me@gmail.com,
        keith.busch@intel.com, linux-pci@vger.kernel.org,
        Austin.Bolen@dell.com, Stuart.Hayes@dell.com, Narendra.K@dell.com,
        Christopher.Arzola@dell.com, David.Chalfant@dell.com
Subject: Re: Should a PCIe Link Down event set the PCI_DEV_DISCONNECTED bit?
Message-ID: <20180729120901.GA8489@wunner.de>
References: <47727551-86ce-040a-2516-efa47ee3a76e@gmail.com>
 <20180727071813.GA6128@wunner.de>
 <f6aa0b881a824b4f82a29dad300aaaea@ausx13mps321.AMER.DELL.COM>
 <20180727170543.GA5326@wunner.de>
 <99604d46a7554eb38ee6c1579c53d835@ausx13mps321.AMER.DELL.COM>
 <20180728183130.GA21482@wunner.de>
 <29894244-e682-9394-c408-bd989fb4716a@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <29894244-e682-9394-c408-bd989fb4716a@kernel.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Sat, Jul 28, 2018 at 05:26:57PM -0700, Sinan Kaya wrote:
> On 7/28/2018 11:31 AM, Lukas Wunner wrote:
> >The knowledge whether a surprise removal or a safe removal is at hand
> >does exist further up in the call stack:  A surprise removal is
> >initiated by pciehp_handle_presence_or_link_change(), a safe removal by
> >pciehp_handle_disable_request().
> 
> Can you also check if platform supports surprise link down error
> reporting (Link Capabilities Register) and reports a surprise link
> down event in AER Uncorrectable Error Status Register for the
> hotplug code to make it more reliable?

We read the Link Capabilities register in pcie_init() to determine if
Data Link Layer Link Active Reporting is supported.  (That's a feature
added in the PCIe r1.1 Base Spec.  Old devices that strictly adhere to
PCIe r1.0 don't support it.)

We could likewise cache the Surprise Down Error Reporting Capable bit
in struct controller.  But I don't quite understand yet how and when
you want it to be used by pciehp?  If the link goes down, pciehp doesn't
care whether that's caused by a fatal error or removal by the user.
It seems correct to me to also remove devices on a fatal error, after all
they're no longer accessible until the error is cleared (IIUC).
Do you agree or disagree?

Thanks,

Lukas
