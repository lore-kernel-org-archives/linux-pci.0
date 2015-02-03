Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-qg0-f50.google.com ([209.85.192.50]:38143 "EHLO
	mail-qg0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965848AbbBCQUo (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 3 Feb 2015 11:20:44 -0500
Received: by mail-qg0-f50.google.com with SMTP id j5so3204825qga.9
        for <linux-pci@vger.kernel.org>; Tue, 03 Feb 2015 08:20:43 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <2624799.cDSRma3dVE@dabox>
References: <1561014.NTLJeH8lPH@dabox> <CAErSpo68--PsYC8+E6c27mRtEKtNsNRNLUDdqTqfiExCiPhauw@mail.gmail.com>
 <2624799.cDSRma3dVE@dabox>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Tue, 3 Feb 2015 10:20:22 -0600
Message-ID: <CAErSpo6_Rmu2W0snM5EAT1=OjcQvremBkv93PEBrB18MTFur+Q@mail.gmail.com>
Subject: Re: [PATCH] 3.19-rc7: add quirk for 1c28:0122 (rev 14) SATA controller
To: Tim Sander <tim@krieglstein.org>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"alex.williamson@redhat.com" <alex.williamson@redhat.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Feb 3, 2015 at 3:27 AM, Tim Sander <tim@krieglstein.org> wrote:
> Hi Bjorn
>
> Am Montag, 2. Februar 2015, 08:55:33 schrieb Bjorn Helgaas:
>> [+cc Alex]
>>
>> On Mon, Feb 2, 2015 at 5:29 AM, Tim Sander <tim@krieglstein.org> wrote:
>> > The long name for this device is
>> > Lite-On IT Corp. / Plextor M6e PCI Express SSD [Marvell 88SS9183] (rev 14)
>> >
>> > Background: the error description on bugzilla
>> > https://bugzilla.kernel.org/show_bug.cgi?id=42679
>> > inspired me to check if my brand new m4 pci ssd could work with a quirk.
>> > Its device representation is not visible before this patch.
>> > After this patch it appears as a normal device. Formatting
>> > and mounting worked so far.
>> >
>> > Signed-off-by: Tim Sander <tim@krieglstein.org>
>>
>> Hi Tim,
>>
>> Thanks a lot for the patch.  Can you open a new report at
>> http://bugzilla.kernel.org and attach the complete dmesg and "lspci
>> -vv" output without this patch, and also a dmesg log *with* this
>> patch?  I like to keep a little documentation around in case we
>> restructure this code in the future.
> I have not opened a bugreport yet, it seems in between there has been some
> change in the 3.19-rc release process which made this disk work?
>
> I bumped the rc version while creating and testing the patch as i wanted to be
> on the latest release kernel. Maybe there has been some fix along these
> releases. Do you have an idea what fix that might be? I *think* i have been on
> 3.19-rc2 and i know that it has not been working there.
>
> <snip>
>
> Attached a dmesg of the successful case as i fail to reproduce the
> unsuccessful part even without the patch :-/. Will investigate later.

Strange.  The only PCI quirks change between v3.19-rc1 and -rc7 is
c3e59ee4e766 ("PCI: Mark Atheros AR93xx to avoid bus reset"), which
shouldn't be related to the problem you're seeing.

Bjorn

>> > ---
>> >
>> >  drivers/pci/quirks.c    | 4 ++++
>> >  include/linux/pci_ids.h | 3 +++
>> >  2 files changed, 7 insertions(+)
>> >
>> > diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
>> > index e52356a..fad7383 100644
>> > --- a/drivers/pci/quirks.c
>> > +++ b/drivers/pci/quirks.c
>> > @@ -3540,6 +3540,10 @@ DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_TTI, 0x0642,
>> >
>> >  DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_JMICRON,
>> >
>> >                          PCI_DEVICE_ID_JMICRON_JMB388_ESD,
>> >                          quirk_dma_func1_alias);
>> >
>> > +/* https://bugzilla.kernel.org/show_bug.cgi?id=42679 */
>> > +DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_LITE_ON,
>> > +                        PCI_DEVICE_ID_PLEXTOR_M6E,
>> > +                        quirk_dma_func1_alias);
>> >
>> >  /*
>> >
>> >   * A few PCIe-to-PCI bridges fail to expose a PCIe capability, resulting
>> >   in
>> >
>> > diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
>> > index e63c02a..1607b20 100644
>> > --- a/include/linux/pci_ids.h
>> > +++ b/include/linux/pci_ids.h
>> > @@ -2487,6 +2487,9 @@
>> >
>> >  #define PCI_VENDOR_ID_ASMEDIA          0x1b21
>> >
>> > +#define PCI_VENDOR_ID_LITE_ON          0x1c28
>> > +#define PCI_DEVICE_ID_PLEXTOR_M6E      0x0122
>> > +
>> >
>> >  #define PCI_VENDOR_ID_CIRCUITCO                0x1cc8
>> >  #define PCI_SUBSYSTEM_ID_CIRCUITCO_MINNOWBOARD 0x0001
>> >
>> > --
>> > 1.9.1
