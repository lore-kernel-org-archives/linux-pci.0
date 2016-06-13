Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:43275 "EHLO
	smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1423455AbcFMOHI (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 13 Jun 2016 10:07:08 -0400
Subject: Re: PCIe EndPoint DMA driver with DMA Framework
To: Vinod Koul <vinod.koul@intel.com>,
	Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>
References: <8520D5D51A55D047800579B094147198258B267B@XAP-PVEXMBX01.xlnx.xilinx.com>
 <20160613052531.GZ16910@localhost>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	nofooter <nofooter@xilinx.com>,
	"dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>
From: Sinan Kaya <okaya@codeaurora.org>
Message-ID: <575EBE09.9090603@codeaurora.org>
Date: Mon, 13 Jun 2016 10:07:05 -0400
MIME-Version: 1.0
In-Reply-To: <20160613052531.GZ16910@localhost>
Content-Type: text/plain; charset=windows-1252
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 6/13/2016 1:25 AM, Vinod Koul wrote:
>> We are planning to write a PCIe EndPoint DMA driver with DMA Framework
>> > targeting x86 machine.  (
>> > "https://www.kernel.org/doc/Documentation/dmaengine/provider.txt") Our DMA
>> > controller is part of PCIe End Point.  We are targeting to measure PCIe
>> > performance with this Framework driver.
>> > 
>> > But when I see DMA Framework drivers is kernel source "drivers/dma" most
>> > of the drivers are platform drivers.
> wrong, there are bunch of PCI X86 driver. Look closely dw, ioat etc

I usually see endpoint specific DMA code to reside in the endpoint device
driver not in the dmaengine directory.

I think the main question is who the consumer of this DMA controller is like
Vinod asked.

If it is a general purpose DMA controller then dmaengine would be the right
place. 

If it is specific to your endpoint, then it should be set up and used in your
endpoint device driver.

-- 
Sinan Kaya
Qualcomm Technologies, Inc. on behalf of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, a Linux Foundation Collaborative Project
