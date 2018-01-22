Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:60970 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751048AbeAVWvi (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 22 Jan 2018 17:51:38 -0500
Date: Mon, 22 Jan 2018 16:51:27 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Sinan Kaya <okaya@codeaurora.org>
Cc: Ron Yuan <ron.yuan@memblaze.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Bo Chen <bo.chen@memblaze.com>,
        William Huang <william.huang@memblaze.com>,
        Fengming Wu <fengming.wu@memblaze.com>,
        Jason Jiang <jason.jiang@microsemi.com>,
        Radjendirane Codandaramane <radjendirane.codanda@microsemi.com>,
        Ramyakanth Edupuganti <Ramyakanth.Edupuganti@microsemi.com>,
        William Cheng <william.cheng@microsemi.com>,
        "Kim Helper (khelper)" <khelper@micron.com>,
        Linux PCI <linux-pci@vger.kernel.org>
Subject: Re: One Question About PCIe BUS Config Type with pcie_bus_safe or
 pcie_bus_perf On NVMe Device
Message-ID: <20180122225127.GC5317@bhelgaas-glaptop.roam.corp.google.com>
References: <ef16a3cc-b641-a30d-644a-7940e340eb3e@codeaurora.org>
 <SHAPR01MB173A5EA1677C2138CB528F2FEE90@SHAPR01MB173.CHNPR01.prod.partner.outlook.cn>
 <5727b0b1-f0d5-7c78-373e-fc9d1bd662d2@codeaurora.org>
 <CABhMZUU0643U-qVc9ymA+1PMZToSLFm2dg8-cu=iQ2LGw2Pi8Q@mail.gmail.com>
 <SHAPR01MB173A36104635A8BFF9A83E1FEE80@SHAPR01MB173.CHNPR01.prod.partner.outlook.cn>
 <0ce08a91-fc38-1288-7683-836fcbbbdf3c@codeaurora.org>
 <20180119205153.GB160618@bhelgaas-glaptop.roam.corp.google.com>
 <62d57a7c-b45d-3567-4dc6-5b0a0dba046f@codeaurora.org>
 <20180122213630.GB5317@bhelgaas-glaptop.roam.corp.google.com>
 <1e62a548-cc4c-d93e-6916-8ac695ebfdaa@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1e62a548-cc4c-d93e-6916-8ac695ebfdaa@codeaurora.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Jan 22, 2018 at 05:04:03PM -0500, Sinan Kaya wrote:
> On 1/22/2018 4:36 PM, Bjorn Helgaas wrote:
> >>> That leaves Completions.  We limit the size of Completions by
> >>> limiting MRRS.  If we set the endpoint's MRRS to its MPS (128 in
> >>> this case), it will never request more than MPS bytes at a time,
> >>> so it will never receive a Completion with more than MPS bytes.
> >>>
> >>> Therefore, we may be able to configure other devices in the
> >>> fabric with MPS larger than 128, which may benefit those
> >>> devices.
> 
> > Help me understand exactly what is problematic.  No matter what
> > your read/write mix is, a single device in isolation should get
> > the best performance with both MPS and MRRS at the highest
> > possible settings.
> 
> The performance approach is trying to maximize MPS while reducing
> MRRS value to MPS value. Meaning improving write performance while
> trading off read performance.

Right.  The intent of the PERFORMANCE mode is exactly to maximize MPS
(which maximizes write performance) by reducing MRRS in some cases
(which reduces read performance).

You had said:

>>> This is still problematic. One application may be doing a lot of
>>> writes compared to reads. We prefer maximizing endpoint write
>>> performance compared to read performance by reducing the MRRS
>>> setting.

so I thought you had an issue with this, and I was trying to
understand what you wanted instead.

> > Reducing MPS may be necessary if there are several devices in the
> > hierarchy and one requires a smaller MPS than the others.  That
> > obviously reduces the maximum read and write performance.
> > 
> > Reducing the MRRS may be useful to prevent one device from hogging
> > a link, but of course, it reduces read performance for that device
> > because we need more read requests.
> 
> Maybe, a picture could help.
> 
>                root (MPS=256)
>                  |
>          ------------------
>         /                  \
>    bridge0 (MPS=256)      bridge1 (MPS=128)
>       /                       \
>     EP0 (MPS=256)            EP1 (MPS=128)
> 
> If I understood this right, code allows the configuration above with
> the performance mode so that MPS doesn't have to be uniform across
> the tree. 

Yes.  In PERFORMANCE mode, we will set EP1's MRRS=128 and
EP0's MRRS=256, just as you show.

> It just needs to be consistent between the root port and endpoints.

No, it doesn't need to be consistent.  In PERFORMANCE mode, we'll set
the root's MPS=256 and EP1's MPS=128.

(I'm not actually 100% convinced that the PERFORMANCE mode approach of
reducing MRRS is safe, necessary, and maintainable.  I suspect that in
many of the interesting cases, the device we care about is the only
one below a Root Port, and we can get the performance we need by
maximizing MPS and MRRS for that Root Port and its children,
independent of the rest of the system.)

> Why are we reducing MRRS in this case?

We have to set EP1's MRRS=128 so it will never receive a completion
larger than 128 bytes.  If we set EP1's MRRS=256, it could receive
256-byte TLPs, which it would treat as malformed.  (We also assume no
peer-to-peer DMA that targets EP1.)

> Are we assuming that root bus cannot handle more than 256 bytes and
> bridge1 would be starved while root bus is passing the completions
> to bridge0?

We don't have to assume.  Every device tells us via Dev Cap what size
TLPs it can handle.  In your example, I assume the root's Dev Cap
tells us it supports 256-byte TLPs.

PERFORMANCE mode reduces MRRS not because of a starvation issue, but
because reducing EP1's MRRS allows EP0 to use a larger MPS.
