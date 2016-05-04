Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from gate.crashing.org ([63.228.1.57]:52116 "EHLO gate.crashing.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756849AbcEDAi3 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Tue, 3 May 2016 20:38:29 -0400
Message-ID: <1462322260.30470.76.camel@kernel.crashing.org>
Subject: Re: [PATCH v11 04/60] sparc/PCI: Use correct offset for bus address
 to resource
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Yinghai Lu <yinghai@kernel.org>,
	Bjorn Helgaas <helgaas@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	David Miller <davem@davemloft.net>,
	Linus Torvalds <torvalds@linux-foundation.org>
Cc: Wei Yang <weiyang@linux.vnet.ibm.com>, TJ <linux@iam.tj>,
	Yijing Wang <wangyijing@huawei.com>,
	Khalid Aziz <khalid.aziz@oracle.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Michael Ellerman <mpe@ellerman.id.au>
Date: Wed, 04 May 2016 10:37:40 +1000
In-Reply-To: <CAE9FiQX_8oXj=FD8pKe=eBL=YWZY-=C8sZ6yMbmkwegLVOR-fA@mail.gmail.com>
References: <1460074573-7481-1-git-send-email-yinghai@kernel.org>
	 <1460074573-7481-5-git-send-email-yinghai@kernel.org>
	 <20160422204920.GA17215@localhost>
	 <CAE9FiQWQ2ke3_P4Qhj+ON7pMiVCx4myhVNVaSYO4vYAL_P4njg@mail.gmail.com>
	 <20160428135607.GA12470@localhost>
	 <CAE9FiQU_XSMfxFPSOrMjQ2DGnrM0D5T=0ORfDEBxqWggGrzc+Q@mail.gmail.com>
	 <CAE9FiQX_8oXj=FD8pKe=eBL=YWZY-=C8sZ6yMbmkwegLVOR-fA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, 2016-05-03 at 15:52 -0700, Yinghai Lu wrote:
> BenH and DavidM,
> Are you ok to let /proc/bus/pci/devices to expose resource value
> instead of
> BAR value?
> powerpc already expose MMIO as resource value, but still keep IO as
> BAR value?
> 
> Or can we just dump /proc/bus/pci support from now?

The problem tends to be old Xserver expectations...

That stuff has been a can of worms over the years and we did things in
the kernel to work around X limitations. I'm not that keen on touching
/proc at all in that regard. Leave it there do what it does today, it's
a user visible ABI, don't change it.

Cheers,
Ben.

