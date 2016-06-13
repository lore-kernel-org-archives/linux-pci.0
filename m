Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Mon, 13 Jun 2016 10:55:31 +0530
From: Vinod Koul <vinod.koul@intel.com>
To: Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	nofooter <nofooter@xilinx.com>,
	"dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>
Subject: Re: PCIe EndPoint DMA driver with DMA Framework
Message-ID: <20160613052531.GZ16910@localhost>
References: <8520D5D51A55D047800579B094147198258B267B@XAP-PVEXMBX01.xlnx.xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <8520D5D51A55D047800579B094147198258B267B@XAP-PVEXMBX01.xlnx.xilinx.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Jun 10, 2016 at 03:39:15PM +0000, Bharat Kumar Gogada wrote:
> Hi,
> 

PLEASE wrap your replied to 80 chars..  I have reflown below..

> We are planning to write a PCIe EndPoint DMA driver with DMA Framework
> targeting x86 machine.  (
> "https://www.kernel.org/doc/Documentation/dmaengine/provider.txt") Our DMA
> controller is part of PCIe End Point.  We are targeting to measure PCIe
> performance with this Framework driver.
> 
> But when I see DMA Framework drivers is kernel source "drivers/dma" most
> of the drivers are platform drivers.

wrong, there are bunch of PCI X86 driver. Look closely dw, ioat etc
> 
> So DMA Framework is mainly targeted for platform drivers?

First it is dmaengine framework.

And your assumption is wrong, btw did you see anything is dmaengine APIs
to make the assumption that dmaengine frameowrk is suited for platform
drivers. The frameworks do not care which type of device you have.

> 
> With current design model we need to have one DMA controller driver and
> PCIe EP client driver?

That depends on what you are trying to do but yes the dmaengine driver
will provide dma services and a client needs to use it

> 
> In which part of kernel source PCIe EP client driver will go?

whatever that client is trying to do DMA for. If its network then it
should go in network.

What exactly are you trying to do?

> 
> Can we use DMA Framework on x86 ?

And asking same question multiple times does not change the answer, which is
yes.

> 
> Thanks & Regards, Bharat
> 
> 
> 
> This email and any attachments are intended for the sole use of the named
> recipient(s) and contain(s) confidential information that may be
> proprietary, privileged or copyrighted under applicable law. If you are
> not the intended recipient, do not read, copy, or forward this email
> message or any attachments. Delete this email message and any attachments
> immediately.

What confidential information you have here?

-- 
~Vinod
