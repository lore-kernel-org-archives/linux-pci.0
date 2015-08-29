Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:7181 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751691AbbH2BqD (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Fri, 28 Aug 2015 21:46:03 -0400
Subject: Re: [RFC PATCH 1/2] x86: PCI bus specific MSI operations
To: Thomas Gleixner <tglx@linutronix.de>,
	Keith Busch <keith.busch@intel.com>
References: <1440715146-16578-1-git-send-email-keith.busch@intel.com>
 <1440715146-16578-2-git-send-email-keith.busch@intel.com>
 <alpine.DEB.2.11.1508281849510.15006@nanos>
Cc: x86@kernel.org, LKML <linux-kernel@vger.kernel.org>,
	Bryan Veal <bryan.e.veal@intel.com>,
	Dan Williams <dan.j.williams@intel.com>,
	linux-pci@vger.kernel.org
From: Jiang Liu <jiang.liu@linux.intel.com>
Message-ID: <55E10ED8.1010809@linux.intel.com>
Date: Sat, 29 Aug 2015 09:46:00 +0800
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.11.1508281849510.15006@nanos>
Content-Type: text/plain; charset=windows-1252
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 2015/8/29 0:54, Thomas Gleixner wrote:
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
Hi Thomas and Keith,
	I have noticed this patch set yesterday, but still investigating the
better way to handle this. Basically I think
we should build per-domain/per-bus/per-device PCI MSI irqdomain,
just like what ARM have done. That will give us a clear picture.
But I need more information about the hardware topology
to correctly build up the hierarchical irqdomain, especially the
relationship between the embedded host bridge and IOMMU units.
	Keith, could you please help to provide some doc with
hardware details?
Thanks!
Gerry
