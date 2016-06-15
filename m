Return-Path: <linux-kernel-owner@vger.kernel.org>
Subject: Re: [PATCH 06/13] irq: add a helper spread an affinity mask for
 MSI/MSI-X vectors
To: "Guilherme G. Piccoli" <gpiccoli@linux.vnet.ibm.com>,
	Christoph Hellwig <hch@lst.de>
References: <1465934346-20648-1-git-send-email-hch@lst.de>
 <1465934346-20648-7-git-send-email-hch@lst.de>
 <57607D0E.1060907@linux.vnet.ibm.com>
CC: <tglx@linutronix.de>, <axboe@fb.com>,
	<linux-block@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-nvme@lists.infradead.org>
From: Bart Van Assche <bart.vanassche@sandisk.com>
Message-ID: <a13c3808-97db-2fff-55b0-848fd0db13ae@sandisk.com>
Date: Wed, 15 Jun 2016 10:35:21 +0200
MIME-Version: 1.0
In-Reply-To: <57607D0E.1060907@linux.vnet.ibm.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 06/14/2016 11:54 PM, Guilherme G. Piccoli wrote:
> On 06/14/2016 04:58 PM, Christoph Hellwig wrote:
> I take this opportunity to ask you something, since I'm working in a
> related code in a specific driver - sorry in advance if my question is
> silly or if I misunderstood your code.
>
> The function irq_create_affinity_mask() below deals with the case in
> which we have nr_vecs < num_online_cpus(); in this case, wouldn't be a
> good idea to trying distribute the vecs among cores?
>
> Example: if we have 128 online cpus, 8 per core (meaning 16 cores) and
> 64 vecs, I guess would be ideal to distribute 4 vecs _per core_, leaving
> 4 CPUs in each core without vecs.

Hello Christoph and Guilherme,

I would also like to see irq_create_affinity_mask() modified such that 
it implements Guilherme's algorithm. I think blk-mq requests should be 
processed by a CPU core from the NUMA node from which the request has 
been submitted. With the proposed algorithm, if the number of MSI-X 
vectors is less than or equal to the number of CPU cores of a single 
node, all interrupt vectors will be assigned to the first NUMA node.

Bart.
