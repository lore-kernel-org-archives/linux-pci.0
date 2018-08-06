Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:48946 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728475AbeHFS7D (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 6 Aug 2018 14:59:03 -0400
Subject: Re: [PATCH v7 1/1] PCI: pciehp: Ignore link events when there is a
 fatal error pending
To: Lukas Wunner <lukas@wunner.de>
Cc: poza@codeaurora.org, linux-pci@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Keith Busch <keith.busch@intel.com>,
        linux-pci-owner@vger.kernel.org
References: <20180805225136.5800-1-okaya@kernel.org>
 <20180805225136.5800-2-okaya@kernel.org>
 <c1cfff22c63f6d3d6285575721a2a3e8@codeaurora.org>
 <20180806092614.GA28462@wunner.de>
 <2b4c23a2e97f61a124c95c49d604a853@codeaurora.org>
 <3d491f25-1d59-f257-1125-302e2d50e960@kernel.org>
 <22ce7172-b028-c0b1-d117-8096e016b15b@kernel.org>
 <20180806164445.GA28786@wunner.de>
From: Sinan Kaya <okaya@kernel.org>
Message-ID: <1b59eb4b-e1f5-899c-cdfb-191c1bb915db@kernel.org>
Date: Mon, 6 Aug 2018 12:49:04 -0400
MIME-Version: 1.0
In-Reply-To: <20180806164445.GA28786@wunner.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 8/6/2018 12:44 PM, Lukas Wunner wrote:
> On Mon, Aug 06, 2018 at 11:06:48AM -0400, Sinan Kaya wrote:
>> Surprise Link Down is also a fatal error.
> 
> Seriously?  On a Downstream Port which has the Hot-Plug Surprise bit
> in the Slot Capabilities register set, Surprise Link Down is a fatal
> error?  That would seem somewhat contradictory.  Do you have a
> section number in the PCIe Base Spec for this?

Spec 3.0. 7.10.2. Uncorrectable Error Status Register (Offset 04h)
bit 5 Surprise Down Error Status (Optional).


> 
> Thanks,
> 
> Lukas
> 
