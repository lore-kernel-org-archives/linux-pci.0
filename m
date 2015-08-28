Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:33011 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752662AbbH1Vjv (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Fri, 28 Aug 2015 17:39:51 -0400
Date: Fri, 28 Aug 2015 21:39:49 +0000 (UTC)
From: Keith Busch <keith.busch@intel.com>
To: Thomas Gleixner <tglx@linutronix.de>
cc: Keith Busch <keith.busch@intel.com>, x86@kernel.org,
	LKML <linux-kernel@vger.kernel.org>,
	Bryan Veal <bryan.e.veal@intel.com>,
	Dan Williams <dan.j.williams@intel.com>,
	linux-pci@vger.kernel.org, Jiang Liu <jiang.liu@linux.intel.com>
Subject: Re: [RFC PATCH 1/2] x86: PCI bus specific MSI operations
In-Reply-To: <alpine.DEB.2.11.1508281849510.15006@nanos>
Message-ID: <alpine.LNX.2.00.1508282044490.3969@localhost.lm.intel.com>
References: <1440715146-16578-1-git-send-email-keith.busch@intel.com> <1440715146-16578-2-git-send-email-keith.busch@intel.com> <alpine.DEB.2.11.1508281849510.15006@nanos>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, 28 Aug 2015, Thomas Gleixner wrote:
> On Thu, 27 Aug 2015, Keith Busch wrote:
>
>> This patch adds struct x86_msi_ops to x86's PCI sysdata. This gives a
>> host bridge driver the option to provide alternate MSI Data Register
>> and MSI-X Table Entry programming for devices in PCI domains that do
>> not subscribe to usual "IOAPIC" format.
>
> I'm not too fond about more ad hoc indirection and special casing. We
> should be able to handle this with hierarchical irq domains. Jiang
> might have an idea how to do that for your case.

Thank you for the suggestion, I will take a closer look at this again. All
the better if we don't require an arch specific dependency.

I asked Jiang about domain hierarchies a few weeks ago and understood
these are suited for irq controllers, but the VMD device is an aggregator.

Here's a little more h/w info in case it helps steer me in the right
direction: VMD muxes all the device interrupts in its PCI domain into
one of several VMD h/w irqs. The VMD driver then has to de-mux that into
CPU side irqs for each device.
