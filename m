Return-Path: <linux-acpi-owner@vger.kernel.org>
Date: Wed, 27 Jan 2016 09:35:22 +0100 (CET)
From: Thomas Gleixner <tglx@linutronix.de>
To: Cao jin <caoj.fnst@cn.fujitsu.com>
cc: Bjorn Helgaas <helgaas@kernel.org>,
	Chen Fan <chen.fan.fnst@cn.fujitsu.com>,
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
	rjw@rjwysocki.net, lenb@kernel.org, izumi.taku@jp.fujitsu.com,
	wency@cn.fujitsu.com, ddaney.cavm@gmail.com, okaya@codeaurora.org,
	bhelgaas@google.com, jiang.liu@linux.intel.com,
	linux-pci@vger.kernel.org
Subject: Re: [PATCH v2] pci: fix unavailable irq number 255 reported by
 BIOS
In-Reply-To: <56A85494.8070606@cn.fujitsu.com>
Message-ID: <alpine.DEB.2.11.1601270933560.3886@nanos>
References: <1453705178-27389-1-git-send-email-chen.fan.fnst@cn.fujitsu.com> <20160125205803.GA10272@localhost> <alpine.DEB.2.11.1601260825510.3886@nanos> <20160126152221.GB9279@localhost> <alpine.DEB.2.11.1601261628450.3886@nanos> <20160127002505.GA3329@localhost>
 <56A85494.8070606@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, 27 Jan 2016, Cao jin wrote:
> How about using IRQ_BITMAP_BITS as that "irq_valid" flag? because it is the
> ceiling of struct irq_desc irq_desc[], and request_irq() will return -EINVAL
> in case of the ceiling.
> 
> #ifdef CONFIG_SPARSE_IRQ
> # define IRQ_BITMAP_BITS	(NR_IRQS + 8196)
> #else
> # define IRQ_BITMAP_BITS	NR_IRQS
> #endif

No. This is a core internal implementation detail.

Thanks,

	tglx
