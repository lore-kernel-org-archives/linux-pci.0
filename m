Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-bn1on0087.outbound.protection.outlook.com ([157.56.110.87]:35961
	"EHLO na01-bn1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751865AbcFTNha (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Mon, 20 Jun 2016 09:37:30 -0400
Subject: Re: [PATCH 02/13] irq: Introduce IRQD_AFFINITY_MANAGED flag
To: Christoph Hellwig <hch@lst.de>
References: <1465934346-20648-3-git-send-email-hch@lst.de>
 <0412b942-ea0d-d4eb-c724-8243d12ff6f3@sandisk.com>
 <20160615102311.GA16619@lst.de>
 <67ef7a1c-56e1-db2c-b038-f9784fc1f52f@sandisk.com>
 <20160615151415.GA1919@localhost.localdomain>
 <7f0b16bd-b39f-99e6-c1c1-6a508bf9bbbf@sandisk.com>
 <20160615160316.GB1919@localhost.localdomain>
 <86aa652b-48d0-a7bb-683e-bf43939aa811@sandisk.com>
 <20160616152006.GA13615@lst.de>
 <f22e87c1-6875-9a59-94db-42a6f71663b8@sandisk.com>
 <20160620122219.GA29059@lst.de>
CC: Keith Busch <keith.busch@intel.com>,
	"tglx@linutronix.de" <tglx@linutronix.de>,
	"axboe@fb.com" <axboe@fb.com>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
From: Bart Van Assche <bart.vanassche@sandisk.com>
Message-ID: <066e6b9d-34a8-5917-4ad8-cb466d3389c3@sandisk.com>
Date: Mon, 20 Jun 2016 15:21:47 +0200
MIME-Version: 1.0
In-Reply-To: <20160620122219.GA29059@lst.de>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 06/20/2016 02:22 PM, Christoph Hellwig wrote:
> On Thu, Jun 16, 2016 at 05:39:07PM +0200, Bart Van Assche wrote:
>> On 06/16/2016 05:20 PM, Christoph Hellwig wrote:
>>> On Wed, Jun 15, 2016 at 09:36:54PM +0200, Bart Van Assche wrote:
>> My concern
>> is that I doubt that there is an interrupt assignment scheme that works
>> optimally for all workloads. Hence my request to preserve the ability to
>> modify interrupt affinity from user space.
>
> I'd say let's do such an interface incrementally based on the use
> case - especially after we get networking over to use common code
> to distribute the interrupts.  If you were doing something like this
> with the current blk-mq code it wouldn't work very well due to the
> fact that you'd have a mismatch between the assigned interrupt and
> the blk-mq queue mapping anyway.
>
> It might be a good idea to start brainstorming how we'd want to handle
> this change - we'd basically need a per-device notification that the
> interrupt mapping changes so that we can rebuild the queue mapping,
> which is somewhat similar to the lib/cpu_rmap.c code used by a few
> networking drivers.  This would also help with dealing with cpu
> hotplug events that change the cpu mapping.

A notification mechanism that reports interrupt mapping changes will 
definitely help. What would also help is an API that allows drivers to 
query the MSI-X IRQ of an adapter that is nearest given a cpumask, e.g. 
hctx->cpumask. Another function can then map that IRQ into an index in 
the range 0..n-1 where n is the number of MSI-X interrupts for that 
adapter. Every blk-mq/scsi-mq driver will need this functionality to 
decide which IRQ to associate with a block layer hctx.

Bart.
