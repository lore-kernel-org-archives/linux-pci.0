Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-bn1bon0089.outbound.protection.outlook.com ([157.56.111.89]:25776
	"EHLO na01-bn1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753975AbcFPKBS (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Thu, 16 Jun 2016 06:01:18 -0400
Subject: Re: automatic interrupt affinity for MSI/MSI-X capable devices V2
To: Christoph Hellwig <hch@lst.de>, <tglx@linutronix.de>,
	<axboe@fb.com>
References: <1465934346-20648-1-git-send-email-hch@lst.de>
CC: <linux-block@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<linux-nvme@lists.infradead.org>, <linux-kernel@vger.kernel.org>
From: Bart Van Assche <bart.vanassche@sandisk.com>
Message-ID: <b8cdfc80-fa77-b7cc-69b8-fb6037114087@sandisk.com>
Date: Thu, 16 Jun 2016 11:45:55 +0200
MIME-Version: 1.0
In-Reply-To: <1465934346-20648-1-git-send-email-hch@lst.de>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 06/14/2016 09:58 PM, Christoph Hellwig wrote:
> This series enhances the irq and PCI code to allow spreading around MSI and
> MSI-X vectors so that they have per-cpu affinity if possible, or at least
> per-node.  For that it takes the algorithm from blk-mq, moves it to
> a common place, and makes it available through a vastly simplified PCI
> interrupt allocation API.  It then switches blk-mq to be able to pick up
> the queue mapping from the device if available, and demonstrates all this
> using the NVMe driver.

Hello Christoph,

Is my interpretation correct that for an adapter that supports two 
interrupts and on a system with eight CPU cores and no hyperthreading 
this patch series will assign interrupt vector 0 to CPU 0 and interrupt 
vector 1 to CPU 1? Are you aware that drivers like ib_srp assume that 
interrupts have been spread evenly, that means assigning vector 0 to CPU 
0 and vector 1 to CPU 4?

Thanks,

Bart.
