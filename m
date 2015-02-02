Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-qc0-f171.google.com ([209.85.216.171]:59066 "EHLO
	mail-qc0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933530AbbBBUqo (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 2 Feb 2015 15:46:44 -0500
Received: by mail-qc0-f171.google.com with SMTP id s11so32291637qcv.2
        for <linux-pci@vger.kernel.org>; Mon, 02 Feb 2015 12:46:43 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20929701.uenxAK52C7@hydra>
References: <1561014.NTLJeH8lPH@dabox> <CAErSpo68--PsYC8+E6c27mRtEKtNsNRNLUDdqTqfiExCiPhauw@mail.gmail.com>
 <20929701.uenxAK52C7@hydra>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Mon, 2 Feb 2015 14:46:23 -0600
Message-ID: <CAErSpo5TC3dXTbSFQdSo8mZ1PZDRiBCVcLuD_iXNrZWRc1jWrA@mail.gmail.com>
Subject: Re: [PATCH] 3.19-rc7: add quirk for 1c28:0122 (rev 14) SATA controller
To: Tim Sander <tim@krieglstein.org>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"alex.williamson@redhat.com" <alex.williamson@redhat.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Feb 2, 2015 at 2:15 PM, Tim Sander <tim@krieglstein.org> wrote:
> Hi Bjorn
>
> Am Montag 02 Februar 2015, 08:55:33 schrieb Bjorn Helgaas:
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
> Basically its the same issue as the linked bug report, so reporting this twice
> seems a little backward to me?

If you'd rather just attach the dmesg/lspci info to the existing
bugzilla, I'm OK with that.  But obviously it is a different device
than for the existing quirks, and it's always nice to have more
complete information in case it turns out that we think it's the same
problem today, but tomorrow we learn about a slightly different issue
that only seemed to be the same.

>> Also, since the vendor and device IDs are used only once, we probably
>> won't add them to pci_ids.h (see the comment at the top of the file).
>> Just use the bare constants in the quirk.
>
> Mh, thats what i had first. For patch submission i created the header entries
> as it seemed cleaner as you can deduce the manufacturer from the names.
> But then its really not that important.

It's not a big deal, and I could make that change myself.  I think the
convention is left over from a time when there were unnecessary merge
conflicts on pci_ids.h.

Bjorn
