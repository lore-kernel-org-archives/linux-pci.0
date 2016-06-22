Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:51727 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751543AbcFVL6D (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Wed, 22 Jun 2016 07:58:03 -0400
Date: Wed, 22 Jun 2016 13:56:36 +0200
From: Alexander Gordeev <agordeev@redhat.com>
To: Keith Busch <keith.busch@intel.com>
Cc: Bart Van Assche <bart.vanassche@sandisk.com>,
	Christoph Hellwig <hch@lst.de>,
	"tglx@linutronix.de" <tglx@linutronix.de>,
	"axboe@fb.com" <axboe@fb.com>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 02/13] irq: Introduce IRQD_AFFINITY_MANAGED flag
Message-ID: <20160622115636.GA30337@dhcp-27-118.brq.redhat.com>
References: <20160615102311.GA16619@lst.de>
 <67ef7a1c-56e1-db2c-b038-f9784fc1f52f@sandisk.com>
 <20160615151415.GA1919@localhost.localdomain>
 <7f0b16bd-b39f-99e6-c1c1-6a508bf9bbbf@sandisk.com>
 <20160615160316.GB1919@localhost.localdomain>
 <86aa652b-48d0-a7bb-683e-bf43939aa811@sandisk.com>
 <20160615200655.GB7637@localhost.localdomain>
 <20160615201213.GC7637@localhost.localdomain>
 <7a61fe73-2808-70b4-e3b2-b6a924559d9d@sandisk.com>
 <20160616151950.GA11840@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20160616151950.GA11840@localhost.localdomain>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Jun 16, 2016 at 11:19:51AM -0400, Keith Busch wrote:
> On Wed, Jun 15, 2016 at 10:50:53PM +0200, Bart Van Assche wrote:
> > Does it matter on x86 systems whether or not these interrupt vectors are
> > also associated with a CPU with a higher CPU number? Although multiple bits
> > can be set in /proc/irq/<n>/smp_affinity only the first bit counts on x86
> > platforms. In default_cpu_mask_to_apicid_and() it is easy to see that only
> > the first bit that has been set in that mask counts on x86 systems.
> 
> Wow, thanks for the information. I didn't know the apic wasn't using
> the full cpu mask, so this changes how I need to look at this, and will
> experiment with such a configuration.

I have vague memories of this, but you probably need to check PPC as well.
Its interrupt distribution is not straightforward as well, AFAIR.
