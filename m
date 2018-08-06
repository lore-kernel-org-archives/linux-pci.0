Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from bmailout2.hostsharing.net ([83.223.90.240]:39763 "EHLO
        bmailout2.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728071AbeHFTPF (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 6 Aug 2018 15:15:05 -0400
Date: Mon, 6 Aug 2018 19:05:03 +0200
From: Lukas Wunner <lukas@wunner.de>
To: Sinan Kaya <okaya@kernel.org>
Cc: poza@codeaurora.org, linux-pci@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Keith Busch <keith.busch@intel.com>,
        linux-pci-owner@vger.kernel.org
Subject: Re: [PATCH v7 1/1] PCI: pciehp: Ignore link events when there is a
 fatal error pending
Message-ID: <20180806170503.GA30662@wunner.de>
References: <20180805225136.5800-1-okaya@kernel.org>
 <20180805225136.5800-2-okaya@kernel.org>
 <c1cfff22c63f6d3d6285575721a2a3e8@codeaurora.org>
 <20180806092614.GA28462@wunner.de>
 <2b4c23a2e97f61a124c95c49d604a853@codeaurora.org>
 <3d491f25-1d59-f257-1125-302e2d50e960@kernel.org>
 <22ce7172-b028-c0b1-d117-8096e016b15b@kernel.org>
 <20180806164445.GA28786@wunner.de>
 <1b59eb4b-e1f5-899c-cdfb-191c1bb915db@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1b59eb4b-e1f5-899c-cdfb-191c1bb915db@kernel.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Aug 06, 2018 at 12:49:04PM -0400, Sinan Kaya wrote:
> On 8/6/2018 12:44 PM, Lukas Wunner wrote:
> >On Mon, Aug 06, 2018 at 11:06:48AM -0400, Sinan Kaya wrote:
> >>Surprise Link Down is also a fatal error.
> >
> >Seriously?  On a Downstream Port which has the Hot-Plug Surprise bit
> >in the Slot Capabilities register set, Surprise Link Down is a fatal
> >error?  That would seem somewhat contradictory.  Do you have a
> >section number in the PCIe Base Spec for this?
> 
> Spec 3.0. 7.10.2. Uncorrectable Error Status Register (Offset 04h)
> bit 5 Surprise Down Error Status (Optional).

Okay, thanks.  Can we always mask out this bit on a hotplug port
with surprise removal capability?  Doesn't make sense to me to let
AER/DPC spring to action in that case.

Lukas
