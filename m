Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-wi0-f180.google.com ([209.85.212.180]:35023 "EHLO
	mail-wi0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751804AbbJEQq3 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 5 Oct 2015 12:46:29 -0400
Date: Mon, 5 Oct 2015 18:46:24 +0200
From: Ingo Molnar <mingo@kernel.org>
To: Keith Busch <keith.busch@intel.com>
Cc: LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
	linux-pci@vger.kernel.org, Jiang Liu <jiang.liu@linux.intel.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Dan Williams <dan.j.williams@intel.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Bryan Veal <bryan.e.veal@intel.com>,
	Ingo Molnar <mingo@redhat.com>,
	"H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [RFC PATCHv2] x86/pci: Initial commit for new VMD device driver
Message-ID: <20151005164624.GA13737@gmail.com>
References: <1443721454-25467-1-git-send-email-keith.busch@intel.com>
 <20151003094512.GA29104@gmail.com>
 <alpine.LNX.2.00.1510051424000.23840@localhost.lm.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <alpine.LNX.2.00.1510051424000.23840@localhost.lm.intel.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>


* Keith Busch <keith.busch@intel.com> wrote:

> On Sat, 3 Oct 2015, Ingo Molnar wrote:
> >* Keith Busch <keith.busch@intel.com> wrote:
> >>+config VMDDEV
> >>+	depends on PCI && PCI_DOMAINS && PCI_MSI && GENERIC_MSI_IRQ_DOMAIN && IRQ_DOMAIN_HIERARCHY
> >>+	tristate "Volume Management Device Driver"
> >>+	default N
> >>+	select HAVE_VMDDEV
> >>+	---help---
> >>+	Adds support for the Intel Volume Manage Device (VMD). VMD is
> >>+	a secondary PCI host bridge that allows PCI Express root ports,
> >>+	and devices attached to them, to be removed from the default PCI
> >>+	domain and placed within the VMD domain. If your system provides
> >>+	one of these and has devices attached to it, say "Y".
> >
> >So what this text does not explain is why does the user care? What tangible
> >benefits does this feature offer to users?
> 
> Hi Ingo,
> 
> The immediate benefit is that devices on VMD domains do not use resources
> on the default PCI domain, so we have more than the 256 buses available.

Would be nice to incorporate that information in the help text and in the 
changelog.

Thanks,

	Ingo
