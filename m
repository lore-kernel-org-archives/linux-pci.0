Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:44600 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760207AbbIDQoG (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Fri, 4 Sep 2015 12:44:06 -0400
Date: Fri, 4 Sep 2015 17:44:12 +0100
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
Message-ID: <20150904164412.GD22997@red-moon>
References: <CAAa04yFQEUJm7Jj1qMT57-LG7ZGtnhNDBe=PpSRa70Mj+XhW-A@mail.gmail.com>
 <20150902174716.GA6305@red-moon>
 <20150902203250.GB829@google.com>
 <20150903100115.GA15308@red-moon>
 <20150903162140.GG829@google.com>
 <20150904141903.GA22997@red-moon>
 <CAE9FiQXeByB6zakDKKC=P68fWD-sKiP1tzn-DWZ+kBsVnXZLxg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAE9FiQXeByB6zakDKKC=P68fWD-sKiP1tzn-DWZ+kBsVnXZLxg@mail.gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Sep 04, 2015 at 05:00:35PM +0100, Yinghai Lu wrote:
> On Fri, Sep 4, 2015 at 7:19 AM, Lorenzo Pieralisi
> <lorenzo.pieralisi@arm.com> wrote:
> 
> > By keeping the bridge old size while sizing the bridge if the new size
> > is < old size (ie bridge never shrinks), we implicitly assume that upon
> > first scan of the bridge apertures that are not claimed should be set to
> > size = 0 (ie as Bjorn said the size should be irrelevant in that case
> > because we are sizing the bridge to figure out what the size should be),
> > otherwise we might end up triggering issues as this thread shows because
> > the old size is always taken into consideration.
> 
> oh, we have patches that will ignore old_size in last retry.

The problem here is not the last retry, it is the first bridge scan.

By moving pci_read_bridge_bases() to core PCI code, if we do not
vet the bridge apertures (ie claim them and reset them if the claiming
fails) we end up calling (on ARM) __pci_bus_size_bridges() with apertures
that can have sizes != 0, which does not make any sense since we are calling
__pci_bus_size_bridges() to *discover* what the aperture size should
be on first bridge scan, correct ?

__pci_bus_size_bridges() expects the "old_size" to be set to a sensible
value, and it seems to me that it should be 0 on first scan given
the current __pci_bus_size_bridges() implementation and my question
is where the bridge aperture resources must be reset for systems
(eg ARM) that reassign the whole PCI resource space.

The platform triggering this issue was working without any need for
realloc before, so your patches are indeed useful but I would like
to understand what you think about the issue described above.

Thanks you !
Lorenzo

> 
> Please check
> 
> git://git.kernel.org/pub/scm/linux/kernel/git/yinghai/linux-yinghai.git
> for-pci-v4.3-next
> 
> exact patches should be:
> https://git.kernel.org/cgit/linux/kernel/git/yinghai/linux-yinghai.git/patch/?id=e8539db0a669fc076ac50800e274af165ce3c5fe
> PCI: Treat optional as required in first try for bridge rescan
> 
> https://git.kernel.org/cgit/linux/kernel/git/yinghai/linux-yinghai.git/patch/?id=a7a2e984194a051e77b88f59e2db030dd4d99e64
> PCI: Get new realloc size for bridge for last try
> 
> Thanks
> 
> Yinghai
> 
