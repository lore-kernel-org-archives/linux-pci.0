Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-vb0-f47.google.com ([209.85.212.47]:59807 "EHLO
	mail-vb0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755035Ab3BAWqG (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 1 Feb 2013 17:46:06 -0500
Received: by mail-vb0-f47.google.com with SMTP id e21so2729148vbm.6
        for <linux-pci@vger.kernel.org>; Fri, 01 Feb 2013 14:46:05 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.02.1301181946010.21091@jlaw-desktop.mno.stratus.com>
References: <alpine.DEB.2.02.1301181302260.31163@jlaw-desktop.mno.stratus.com>
 <CAL-B5D0+6uO7WDYR7inmZKdU0h8-bpkOs_CzbF0bD2b9i6=1ZA@mail.gmail.com>
 <alpine.DEB.2.02.1301181449440.31163@jlaw-desktop.mno.stratus.com>
 <CAL-B5D2-=x+Y-f9x+QyX+3j3F=CbfY6mRGE6mnmvuhM-zMKGnw@mail.gmail.com>
 <CAL-B5D2k6RdRGbedgbSAZfMumWR9ypMcDwyEGTt9X1_eO=qQuw@mail.gmail.com> <alpine.DEB.2.02.1301181946010.21091@jlaw-desktop.mno.stratus.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Fri, 1 Feb 2013 15:45:33 -0700
Message-ID: <CAErSpo7GWWH2Edh5=qb0SMPmN++6f+Y7UV=J6gK2rK+DLXpYng@mail.gmail.com>
Subject: Re: PCIe ASPM crash on device removal
To: Joe Lawrence <Joe.Lawrence@stratus.com>
Cc: Myron Stowe <myron.stowe@gmail.com>,
	linux-pci <linux-pci@vger.kernel.org>,
	Matthew Garrett <mjg59@srcf.ucam.org>,
	Myron Stowe <mstowe@redhat.com>,
	David Bulkow <david.bulkow@stratus.com>, shli@kernel.org,
	shli@fusionio.com, kaneshige.kenji@jp.fujitsu.com
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Jan 18, 2013 at 6:03 PM, Joe Lawrence <Joe.Lawrence@stratus.com> wrote:
> On Fri, 18 Jan 2013, Myron Stowe wrote:
>
>> [+cc Shaohua and Kenji]
>>
>> On Fri, Jan 18, 2013 at 4:15 PM, Myron Stowe <myron.stowe@gmail.com> wrote:
>> > Joe:
>> >
>> > Thanks for the data.  So the downstream port of interest has ASPM link
>> > capability but it's currently not enabled - see LnkCap and LnkCtl
>> > above.
>> >
>> > I'm still do not understand if PCI Express links would even be
>> > involved in a topology where all the devices connected below the
>> > downstream port are PCI and not PCI Express.  Seems as if the ASPM
>> > code is going to a lot of work to put link state structures in place
>> > for all these devices that would not be capable of supporting ASPM.
>> >
>> > I'm still trying to come up to speed understanding ASPM so hopefully
>> > someone knowledgeable can help clue me in.
>> >
>> > Myron
>
> Scratch my earlier worry about link_state for a device without any
> subordinate devices for pcie_aspm_exit_link_state to clean up.  I forgot
> the check that pcie_aspm_init_link_state makes on the subordinate device
> list before allocating link_state.
>
> What is confusing to me is the asymmetry between these two routines and
> how the pcie_aspm_sanity_check return value (blacklist, introduced in
> commit 46bbdfa4) is handled.  I wonder if pcie_aspm_init_link_state could
> simply skip any device who's subordinate device list contains no pcie
> devices.  (Actually one of the things that pcie_aspm_sanity_check looks
> for.)

I've looked as aspm.c three times in the last couple months, and I
agree, it is a bit difficult to analyze, and the asymmetry you mention
is one reason.  I'd love it if somebody wanted to overhaul it.

I wonder if we could have a very simple rule, e.g., allocate
link_state for a device IFF the device has a link.  Then the init/exit
paths could become symmetric, and the question of whether ASPM is
enabled could be handled separately.  It would become possible to turn
ASPM on/off at run-time.

I'm a little dubious about the link_list, too.  That list is
maintained internal to aspm.c, and we have to worry about updating it
on hotplugs.  I'd rather use some standard way of traversing the PCI
hierarchy so it looks like other PCI code and the locking is easier to
verify.

I guess this is just blue-sky thinking, but thanks for fixing an issue
and also pointing out one of the sources of confusion.

Bjorn
