Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-vk0-f52.google.com ([209.85.213.52]:35647 "EHLO
	mail-vk0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751848AbbINRgy (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 14 Sep 2015 13:36:54 -0400
Received: by vkao3 with SMTP id o3so51577198vka.2
        for <linux-pci@vger.kernel.org>; Mon, 14 Sep 2015 10:36:54 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20150914162834.GA11199@red-moon>
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
	<20150914162834.GA11199@red-moon>
Date: Mon, 14 Sep 2015 10:36:53 -0700
Message-ID: <CAE9FiQWJfbMD1Akq6XD-Yedc+tNNF8o0obPGHt8f_WnWX0pLbA@mail.gmail.com>
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

On Mon, Sep 14, 2015 at 9:28 AM, Lorenzo Pieralisi
<lorenzo.pieralisi@arm.com> wrote:
> On Mon, Sep 14, 2015 at 05:05:50PM +0100, Yinghai Lu wrote:
>> We could just revert
>> dff22d2054b5 (" PCI: Call pci_read_bridge_bases() from core instead of
>> arch code")
>> instead.
>
> Sure, but still that does not explain why the old bridge aperture size
> matters while sizing the bridge aperture on first bridge scan, I
> still have no answer for that and I would like to get one.
>
> As far as I understand we could just rework:
>
> commit d65245c3297ac63abc51a976d9 ("PCI: don't shrink bridge resources")
>
> to make sure that old size is taken into account only when the core
> code tries to reallocate resources, I think that dff22d2054b5 unearthed
> a problem instead of creating one but I am open to suggestions.

if arch code called pci_read_bridge_bases() via pcibios_fixup_bus(),
then it need to have
to call pcibios_allocate_bus_resources() later.

but now arm (mips ?)  does not have calling pcibios_allocate_bus_resources().

Yinghai
