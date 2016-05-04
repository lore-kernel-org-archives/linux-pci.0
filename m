Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:38582 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756884AbcEDBZf (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Tue, 3 May 2016 21:25:35 -0400
Date: Tue, 3 May 2016 20:25:31 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Yinghai Lu <yinghai@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	David Miller <davem@davemloft.net>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Wei Yang <weiyang@linux.vnet.ibm.com>, TJ <linux@iam.tj>,
	Yijing Wang <wangyijing@huawei.com>,
	Khalid Aziz <khalid.aziz@oracle.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [PATCH v11 04/60] sparc/PCI: Use correct offset for bus address
 to resource
Message-ID: <20160504012531.GB17170@localhost>
References: <1460074573-7481-1-git-send-email-yinghai@kernel.org>
 <1460074573-7481-5-git-send-email-yinghai@kernel.org>
 <20160422204920.GA17215@localhost>
 <CAE9FiQWQ2ke3_P4Qhj+ON7pMiVCx4myhVNVaSYO4vYAL_P4njg@mail.gmail.com>
 <20160428135607.GA12470@localhost>
 <CAE9FiQU_XSMfxFPSOrMjQ2DGnrM0D5T=0ORfDEBxqWggGrzc+Q@mail.gmail.com>
 <CAE9FiQX_8oXj=FD8pKe=eBL=YWZY-=C8sZ6yMbmkwegLVOR-fA@mail.gmail.com>
 <1462322260.30470.76.camel@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1462322260.30470.76.camel@kernel.crashing.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, May 04, 2016 at 10:37:40AM +1000, Benjamin Herrenschmidt wrote:
> On Tue, 2016-05-03 at 15:52 -0700, Yinghai Lu wrote:
> > BenH and DavidM,
> > Are you ok to let /proc/bus/pci/devices to expose resource value
> > instead of
> > BAR value?
> > powerpc already expose MMIO as resource value, but still keep IO as
> > BAR value?
> > 
> > Or can we just dump /proc/bus/pci support from now?
> 
> The problem tends to be old Xserver expectations...
> 
> That stuff has been a can of worms over the years and we did things in
> the kernel to work around X limitations. I'm not that keen on touching
> /proc at all in that regard. Leave it there do what it does today, it's
> a user visible ABI, don't change it.

I did not propose changing any user-visible ABI.  To recap what I did
propose:

  - The sysfs path uses offsets between 0 and BAR size on all arches.
    It uses pci_resource_to_user() today, but I think it should not.

  - The procfs path uses offsets of resource values (CPU physical
    addresses) on most architectures, but uses something else, e.g.,
    BAR values, on others.  pci_resource_to_user() does this
    translation.  The procfs path does not use pci_resource_to_user()
    today, but I think it should.

  - This implies that pci_mmap_page_range() should deal with resource
    values (CPU physical addresses), and proc_bus_pci_mmap() should do
    any necessary arch-specific translation from BAR values to
    resource values.
