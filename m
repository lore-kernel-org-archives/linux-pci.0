Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mailhub.stratus.com ([134.111.1.17]:37433 "EHLO
	mailhub4.stratus.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752570Ab3ASBHh (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 18 Jan 2013 20:07:37 -0500
Date: Fri, 18 Jan 2013 20:03:24 -0500 (EST)
From: Joe Lawrence <Joe.Lawrence@stratus.com>
To: Myron Stowe <myron.stowe@gmail.com>
cc: Joe Lawrence <Joe.Lawrence@stratus.com>,
	linux-pci <linux-pci@vger.kernel.org>,
	Matthew Garrett <mjg59@srcf.ucam.org>,
	Myron Stowe <mstowe@redhat.com>,
	David Bulkow <david.bulkow@stratus.com>, shli@kernel.org,
	shli@fusionio.com, kaneshige.kenji@jp.fujitsu.com
Subject: Re: PCIe ASPM crash on device removal
In-Reply-To: <CAL-B5D2k6RdRGbedgbSAZfMumWR9ypMcDwyEGTt9X1_eO=qQuw@mail.gmail.com>
Message-ID: <alpine.DEB.2.02.1301181946010.21091@jlaw-desktop.mno.stratus.com>
References: <alpine.DEB.2.02.1301181302260.31163@jlaw-desktop.mno.stratus.com> <CAL-B5D0+6uO7WDYR7inmZKdU0h8-bpkOs_CzbF0bD2b9i6=1ZA@mail.gmail.com> <alpine.DEB.2.02.1301181449440.31163@jlaw-desktop.mno.stratus.com> <CAL-B5D2-=x+Y-f9x+QyX+3j3F=CbfY6mRGE6mnmvuhM-zMKGnw@mail.gmail.com>
 <CAL-B5D2k6RdRGbedgbSAZfMumWR9ypMcDwyEGTt9X1_eO=qQuw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, 18 Jan 2013, Myron Stowe wrote:

> [+cc Shaohua and Kenji]
> 
> On Fri, Jan 18, 2013 at 4:15 PM, Myron Stowe <myron.stowe@gmail.com> wrote:
> > Joe:
> >
> > Thanks for the data.  So the downstream port of interest has ASPM link
> > capability but it's currently not enabled - see LnkCap and LnkCtl
> > above.
> >
> > I'm still do not understand if PCI Express links would even be
> > involved in a topology where all the devices connected below the
> > downstream port are PCI and not PCI Express.  Seems as if the ASPM
> > code is going to a lot of work to put link state structures in place
> > for all these devices that would not be capable of supporting ASPM.
> >
> > I'm still trying to come up to speed understanding ASPM so hopefully
> > someone knowledgeable can help clue me in.
> >
> > Myron

Scratch my earlier worry about link_state for a device without any 
subordinate devices for pcie_aspm_exit_link_state to clean up.  I forgot 
the check that pcie_aspm_init_link_state makes on the subordinate device 
list before allocating link_state.

What is confusing to me is the asymmetry between these two routines and 
how the pcie_aspm_sanity_check return value (blacklist, introduced in 
commit 46bbdfa4) is handled.  I wonder if pcie_aspm_init_link_state could 
simply skip any device who's subordinate device list contains no pcie 
devices.  (Actually one of the things that pcie_aspm_sanity_check looks 
for.)

Regards,

-- Joe
