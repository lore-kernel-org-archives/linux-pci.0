Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:47015 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752529AbbINQ20 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Mon, 14 Sep 2015 12:28:26 -0400
Date: Mon, 14 Sep 2015 17:28:34 +0100
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To: Yinghai Lu <yinghai@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	"oe5hpm@gmail.com" <oe5hpm@gmail.com>,
	Ralf Baechle <ralf@linux-mips.org>,
	"James E.J. Bottomley" <jejb@parisc-linux.org>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Richard Henderson <rth@twiddle.net>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	David Howells <dhowells@redhat.com>,
	Russell King <linux@arm.linux.org.uk>,
	Tony Luck <tony.luck@intel.com>,
	"David S. Miller" <davem@davemloft.net>,
	Ingo Molnar <mingo@redhat.com>,
	Guenter Roeck <linux@roeck-us.net>,
	Michal Simek <monstr@monstr.eu>,
	Chris Zankel <chris@zankel.net>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: Re: trouble with PCI: Call pci_read_bridge_bases() from core instead
 of arch code
Message-ID: <20150914162834.GA11199@red-moon>
References: <20150902203250.GB829@google.com>
 <20150903100115.GA15308@red-moon>
 <20150903162140.GG829@google.com>
 <20150904141903.GA22997@red-moon>
 <CAE9FiQXeByB6zakDKKC=P68fWD-sKiP1tzn-DWZ+kBsVnXZLxg@mail.gmail.com>
 <20150904164412.GD22997@red-moon>
 <CAE9FiQVB0swnTao3eS1kOLvwU-hm0aEpOTXP7wDKFGqtLQta5g@mail.gmail.com>
 <20150907091230.GB29293@red-moon>
 <20150914100929.GB18886@red-moon>
 <CAE9FiQV-eG42xzqVcO2Q+xT3jx-Oa7uC7fEuowvopx4Fp9F7hQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAE9FiQV-eG42xzqVcO2Q+xT3jx-Oa7uC7fEuowvopx4Fp9F7hQ@mail.gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Sep 14, 2015 at 05:05:50PM +0100, Yinghai Lu wrote:
> On Mon, Sep 14, 2015 at 3:09 AM, Lorenzo Pieralisi
> <lorenzo.pieralisi@arm.com> wrote:
> > As I said, ARM is not the only platform affected, MIPS and possibly
> > Alpha suffer from the same issue and I think it should be fixed
> > in core code (I think __pci_bus_size_bridges() should ignore the
> > old aperture size on first scan).
> 
> We could just revert
> dff22d2054b5 (" PCI: Call pci_read_bridge_bases() from core instead of
> arch code")
> instead.

Sure, but still that does not explain why the old bridge aperture size
matters while sizing the bridge aperture on first bridge scan, I
still have no answer for that and I would like to get one.

As far as I understand we could just rework:

commit d65245c3297ac63abc51a976d9 ("PCI: don't shrink bridge resources")

to make sure that old size is taken into account only when the core
code tries to reallocate resources, I think that dff22d2054b5 unearthed
a problem instead of creating one but I am open to suggestions.

Thanks,
Lorenzo
