Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from bmailout3.hostsharing.net ([176.9.242.62]:39905 "EHLO
        bmailout3.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726195AbeIBSnS (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 2 Sep 2018 14:43:18 -0400
Date: Sun, 2 Sep 2018 16:27:14 +0200
From: Lukas Wunner <lukas@wunner.de>
To: Keith Busch <keith.busch@intel.com>
Cc: Linux PCI <linux-pci@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Sinan Kaya <okaya@kernel.org>,
        Thomas Tai <thomas.tai@oracle.com>, poza@codeaurora.org
Subject: Re: [PATCH 14/16] pciehp: Ignore link events during DPC event
Message-ID: <20180902142714.wsqi4rfggundjli7@wunner.de>
References: <20180831212639.10196-1-keith.busch@intel.com>
 <20180831212639.10196-15-keith.busch@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180831212639.10196-15-keith.busch@intel.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Aug 31, 2018 at 03:26:37PM -0600, Keith Busch wrote:
> This patch adds a channel state to a subordinate bus. When a DPC event is
> triggered, the DPC driver will set the channel state to frozen, and the
> pciehp driver will ignore link events if the subordinate bus is being
> managed by DPC error handling.
> 
> This is safe because the pciehp and DPC drivers share the same
> interrupt. The DPC driver sets the bus state in the top-half interrupt
> context, and the pciehp driver checks and masks off link events in its
> bottom-half error handler.

I really liked Sinan's approach of checking in pciehp whether a fatal
error is pending and waiting for it to be handled:
https://patchwork.ozlabs.org/patch/959464/

This seemed to avoid any races with DPC and is small and simple.
Can we pursue a solution along those lines?

Thanks,

Lukas
