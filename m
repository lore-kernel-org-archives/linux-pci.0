Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ig0-f174.google.com ([209.85.213.174]:34434 "EHLO
	mail-ig0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760772AbbIDXxt (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 4 Sep 2015 19:53:49 -0400
Received: by igcpb10 with SMTP id pb10so27452905igc.1
        for <linux-pci@vger.kernel.org>; Fri, 04 Sep 2015 16:53:49 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20150904164412.GD22997@red-moon>
References: <CAAa04yFQEUJm7Jj1qMT57-LG7ZGtnhNDBe=PpSRa70Mj+XhW-A@mail.gmail.com>
	<20150902174716.GA6305@red-moon>
	<20150902203250.GB829@google.com>
	<20150903100115.GA15308@red-moon>
	<20150903162140.GG829@google.com>
	<20150904141903.GA22997@red-moon>
	<CAE9FiQXeByB6zakDKKC=P68fWD-sKiP1tzn-DWZ+kBsVnXZLxg@mail.gmail.com>
	<20150904164412.GD22997@red-moon>
Date: Fri, 4 Sep 2015 16:53:48 -0700
Message-ID: <CAE9FiQVB0swnTao3eS1kOLvwU-hm0aEpOTXP7wDKFGqtLQta5g@mail.gmail.com>
Subject: Re: trouble with PCI: Call pci_read_bridge_bases() from core instead
 of arch code
From: Yinghai Lu <yinghai@kernel.org>
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
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
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Sep 4, 2015 at 9:44 AM, Lorenzo Pieralisi
<lorenzo.pieralisi@arm.com> wrote:
> On Fri, Sep 04, 2015 at 05:00:35PM +0100, Yinghai Lu wrote:
>
> The problem here is not the last retry, it is the first bridge scan.
>
> By moving pci_read_bridge_bases() to core PCI code, if we do not
> vet the bridge apertures (ie claim them and reset them if the claiming
> fails) we end up calling (on ARM) __pci_bus_size_bridges() with apertures
> that can have sizes != 0, which does not make any sense since we are calling
> __pci_bus_size_bridges() to *discover* what the aperture size should
> be on first bridge scan, correct ?

for x86, in pcibios_allocate_bridge_resources(), we do validate
the bridge resources, and reset size to 1 (strange ?!).
and they are called before pci_asssign_unassigned_resources()

so arch ARM would support pcibios_allocate_bridge_resources or other
call to do the same thing?

wonder some arches even claim fails, they still does not want you to
reset it.

Thanks

Yinghai
