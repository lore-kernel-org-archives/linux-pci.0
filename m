Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from stargate.chelsio.com ([67.207.112.58]:32541 "EHLO
	stargate.chelsio.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753266AbaKRAfs convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 17 Nov 2014 19:35:48 -0500
From: Casey Leedom <leedom@chelsio.com>
To: Anish Bhatt <anish@chelsio.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Venkat Duvvuru <VenkatKumar.Duvvuru@emulex.com>
CC: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Hariprasad S <hariprasad@chelsio.com>
Subject: RE: [PATCH v1] pci: Limit VPD length of Emulex adapters to the
 actual length supported.
Date: Tue, 18 Nov 2014 00:35:43 +0000
Message-ID: <4985EFDD773FCB459EF7915D2A3621ADB1F7A8@nice.asicdesigners.com>
References: <1f6d7b6c-7189-4fe3-926b-42609724cab9@CMEXHTCAS2.ad.emulex.com>
 <20141023154054.GA7137@google.com>
 <BF3270C86E8B1349A26C34E4EC1C44CB3E860095@CMEXMB1.ad.emulex.com>
 <CAErSpo7_9xxtBmHOCgxsHeVLbKUeMVhLF6Q9OyFkz11EZbtJCA@mail.gmail.com>
 <BF3270C86E8B1349A26C34E4EC1C44CB3E862DC6@CMEXMB1.ad.emulex.com>
 <CAErSpo7KKka6-nHWnVbqVW3hx-E=4x6cEjeEGEAWz32za6xCGQ@mail.gmail.com>
 <BF3270C86E8B1349A26C34E4EC1C44CB3E87A6A7@CMEXMB1.ad.emulex.com>
 <CAErSpo5xx2QAN1rZqnknAX7xF+5SjpGvEvvVWGuqF_bTh5xRhA@mail.gmail.com>,<525DB349B3FB5444AE057A887CB2A8D8D82D10@nice.asicdesigners.com>
In-Reply-To: <525DB349B3FB5444AE057A887CB2A8D8D82D10@nice.asicdesigners.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

  First, we never read more than 1KB.  So this issue doesn't affect us.  Second, each of the Phycical Functions on out adapters (T3, T4 and T5) actually has 2 1KB VPD regions.  The first region at Offset 0x0 contains a copy of our VPD values but is reserved for OEM partners if they want to put special VPD values there.  The second region at Offset 0x400 contains Chelsio's VPD and it's the one which the Host Driver and on-chip firmware read.

  Our VPDs, both at Offset 0x0 and Offset 0x400, do conform to the PCI VPD format specifications.

  So for our needs, as long as any new API allows us to continue reading our Chelsio VPD starting at Offset 0x400 instead of fixing things at Offset 0x0, we're okay.

Casey


________________________________________
From: Anish Bhatt
Sent: Monday, November 17, 2014 4:06 PM
To: Bjorn Helgaas; Venkat Duvvuru
Cc: linux-pci@vger.kernel.org; Hariprasad S; Casey Leedom
Subject: RE: [PATCH v1] pci: Limit VPD length of Emulex adapters to the actual length supported.

CC'ing Casey, who would be able to answer this much better than me.

> -----Original Message-----
> From: Bjorn Helgaas [mailto:bhelgaas@google.com]
> Sent: Monday, November 17, 2014 3:32 PM
> To: Venkat Duvvuru
> Cc: linux-pci@vger.kernel.org; Anish Bhatt; Hariprasad S
> Subject: Re: [PATCH v1] pci: Limit VPD length of Emulex adapters to the
> actual length supported.
>
> [+cc Anish, Hariprasad (cxgb4 maintainers/contributors)]
>
> Anish, Hariprasad, here's the problem:
>
>   - pci_read_vpd() currently tries to read as much data as the caller asks for
> (up to the 32K limit imposed by the PCI_VPD_PCI22_SIZE in
> pci_vpd_pci22_init()) .  It does not look at the data, so it doesn't stop if it sees
> an End Tag.
>
>   - Some devices have buggy firmware that can't handle 32K worth of VPD
> reads.  But their VPD data is in the format laid out by the spec (PCI r3.0, sec
> I.1), and it does have an End Tag.
>
> The proposal is to make pci_read_vpd() interpret the data into tagged items
> (only when it starts reading at offset 0), and make it stop if it encounters an
> End Tag.
>
> On Mon, Nov 17, 2014 at 8:12 AM, Venkat Duvvuru
> <VenkatKumar.Duvvuru@emulex.com> wrote:
> > Sorry for a delayed response.
> >
> >> -----Original Message-----
> >> From: Bjorn Helgaas [mailto:bhelgaas@google.com]
> >> Sent: Tuesday, November 04, 2014 11:05 PM
> >> To: Venkat Duvvuru
> >> Cc: linux-pci@vger.kernel.org
> >> Subject: Re: [PATCH v1] pci: Limit VPD length of Emulex adapters to
> >> the actual length supported.
> >>
> >> > In this case when the host reads 32k space, the adapter gets around
> >> > 8K
> >> interrupts and sometimes gets overwhelmed with the interrupt storm.
> >> This could cause the adapter to stop functioning properly.
> >> > Limiting the VPD read to 1K causes only 256 interrupts (on the
> >> > adapter) and
> >> the problem never seems to occur.
> >> > This has been the main motivation behind my patch.
> >> > I do agree that the timeout could still occur even when reading the
> >> > 1K
> >> implemented space, but I feel it's highly improbable.
> >>
> >> OK.  I would guess that something like
> >>
> >>   while /bin/true; do
> >>     cat /sys/devices/pci0000:00/0000:00:00.0/vpd
> >>   done
> >>
> >> could still overwhelm the adapter, even with the 1K limit in place.
> > Correct.
> >
> >>
> >> > As an alternative solution, would you be open to a fix in PCI -core
> >> > to stop
> >> reading after the End-tag is detected?  (This logic is used by
> >> pci-utility (ls-
> >> vpd.c) while reading VPD data.)
> >> > I now feel that this is the *right* solution than my pci-quirks patch.
> >>
> >> That's a possibility, and if we were implementing VPD support from
> >> scratch, I'd probably do it that way.
> >>
> >> My only concern with changing now is that it could break existing
> >> users for devices where the VPD content doesn't have the structure
> >> specified by the spec.  There aren't *too* many users of
> >> pci_read_vpd() in the tree, so it might be feasible to just ask the
> >> bnx2x, tg3, cxgb4, sky2, and efx folks whether they think it's safe.
> >>
> >> I took a quick look at those drivers, and it actually looks like most
> >> of them look for the tag structure, e.g., by using pci_vpd_find_tag()
> >> or doing something similar.  So maybe it actually would be safe to do
> >> this.  Maybe you could have a more thorough look at them and see if
> >> you agree?
> > If the devices doesn't follow the spec for the VPD contents, pci-core may
> endup requesting 32k data which probably will not break existing users.
>
> The case I'm worried about is a device that doesn't follow the VPD format
> spec, but its VPD contents include data that matches an End Tag.  If we make
> pci_read_vpd() stop when it sees an End Tag, we may stop reading data
> prematurely.
>
> > I looked into all the pci_read_vpd users (drivers) and they seem to be
> doing pci_find_vpd_tag or pci_vpd_find_info_keyword to find a specific
> tag/keyword and not all the tags/keywords.
>
> I agree, with one exception:  I am concerned about eeprom_rd_phys() in
> cxgb4.  In that case, we use the VPD data to implement the
> ethtool_ops.get_eeprom() method, and that path doesn't look at the actual
> data at all, so I have no idea what the format might be.
>
> Maybe Hariprasad or Anish can comment on this?
>
> > A safer approach probably is to look for the end tag in pci_read_vpd, if
> offset is "zero" because some drivers are doing "pci_read_vpd" with a non-
> zero offset.
>
> Yes, I think you can only look for the End Tag if you start reading at offset
> zero.  If we start reading somewhere in the middle, we'll be out of sync and
> may interpret data as an End Tag.
>
> Bjorn

