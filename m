Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:50492 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731481AbeG2BzT (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sat, 28 Jul 2018 21:55:19 -0400
Subject: Re: Should a PCIe Link Down event set the PCI_DEV_DISCONNECTED bit?
To: Lukas Wunner <lukas@wunner.de>, Alex_Gagniuc@Dellteam.com
Cc: mr.nuke.me@gmail.com, keith.busch@intel.com,
        linux-pci@vger.kernel.org, Austin.Bolen@dell.com,
        Stuart.Hayes@dell.com, Narendra.K@dell.com,
        Christopher.Arzola@dell.com, David.Chalfant@dell.com
References: <47727551-86ce-040a-2516-efa47ee3a76e@gmail.com>
 <20180727071813.GA6128@wunner.de>
 <f6aa0b881a824b4f82a29dad300aaaea@ausx13mps321.AMER.DELL.COM>
 <20180727170543.GA5326@wunner.de>
 <99604d46a7554eb38ee6c1579c53d835@ausx13mps321.AMER.DELL.COM>
 <20180728183130.GA21482@wunner.de>
From: Sinan Kaya <okaya@kernel.org>
Message-ID: <29894244-e682-9394-c408-bd989fb4716a@kernel.org>
Date: Sat, 28 Jul 2018 17:26:57 -0700
MIME-Version: 1.0
In-Reply-To: <20180728183130.GA21482@wunner.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 7/28/2018 11:31 AM, Lukas Wunner wrote:
> The knowledge whether a surprise removal or a safe removal is at hand
> does exist further up in the call stack:  A surprise removal is
> initiated by pciehp_handle_presence_or_link_change(), a safe removal by
> pciehp_handle_disable_request().

Can you also check if platform supports surprise link down error
reporting (Link Capabilities Register) and reports a surprise link
down event in AER Uncorrectable Error Status Register for the
hotplug code to make it more reliable?
