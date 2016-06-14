Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-sn1nam02on0059.outbound.protection.outlook.com ([104.47.36.59]:62560
	"EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751259AbcFNLkI convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 14 Jun 2016 07:40:08 -0400
From: Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>
To: Sinan Kaya <okaya@codeaurora.org>,
	Vinod Koul <vinod.koul@intel.com>
CC: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	nofooter <nofooter@xilinx.com>,
	"dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>
Subject: RE: PCIe EndPoint DMA driver with DMA Framework
Date: Tue, 14 Jun 2016 11:40:00 +0000
Message-ID: <8520D5D51A55D047800579B094147198258B33B8@XAP-PVEXMBX01.xlnx.xilinx.com>
References: <8520D5D51A55D047800579B094147198258B267B@XAP-PVEXMBX01.xlnx.xilinx.com>
 <20160613052531.GZ16910@localhost> <575EBE09.9090603@codeaurora.org>
In-Reply-To: <575EBE09.9090603@codeaurora.org>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Vinod/kanya,

> On 6/13/2016 1:25 AM, Vinod Koul wrote:
> >> We are planning to write a PCIe EndPoint DMA driver with DMA
> >> Framework
> >> > targeting x86 machine.  (
> >> >
> "https://www.kernel.org/doc/Documentation/dmaengine/provider.txt")
> >> > Our DMA controller is part of PCIe End Point.  We are targeting to
> >> > measure PCIe performance with this Framework driver.
> >> >
> >> > But when I see DMA Framework drivers is kernel source "drivers/dma"
> >> > most of the drivers are platform drivers.
> > wrong, there are bunch of PCI X86 driver. Look closely dw, ioat etc
>
> I usually see endpoint specific DMA code to reside in the endpoint device
> driver not in the dmaengine directory.
>
> I think the main question is who the consumer of this DMA controller is like
> Vinod asked.
>
> If it is a general purpose DMA controller then dmaengine would be the right
> place.
>
> If it is specific to your endpoint, then it should be set up and used in your
> endpoint device driver.
>
Our DMA controller is specific to EP.

Thanks a lot kanya and vinod for the clarifications.

Bharat


This email and any attachments are intended for the sole use of the named recipient(s) and contain(s) confidential information that may be proprietary, privileged or copyrighted under applicable law. If you are not the intended recipient, do not read, copy, or forward this email message or any attachments. Delete this email message and any attachments immediately.

