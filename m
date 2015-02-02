Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from lvps176-28-13-145.dedicated.hosteurope.de ([176.28.13.145]:48573
	"EHLO lvps176-28-13-145.dedicated.hosteurope.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753260AbbBBUPe (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 2 Feb 2015 15:15:34 -0500
From: Tim Sander <tim@krieglstein.org>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"alex.williamson@redhat.com" <alex.williamson@redhat.com>
Subject: Re: [PATCH] 3.19-rc7: add quirk for 1c28:0122 (rev 14) SATA controller
Date: Mon, 02 Feb 2015 21:15:22 +0100
Message-ID: <20929701.uenxAK52C7@hydra>
In-Reply-To: <CAErSpo68--PsYC8+E6c27mRtEKtNsNRNLUDdqTqfiExCiPhauw@mail.gmail.com>
References: <1561014.NTLJeH8lPH@dabox> <CAErSpo68--PsYC8+E6c27mRtEKtNsNRNLUDdqTqfiExCiPhauw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Bjorn

Am Montag 02 Februar 2015, 08:55:33 schrieb Bjorn Helgaas:
> [+cc Alex]
> 
> On Mon, Feb 2, 2015 at 5:29 AM, Tim Sander <tim@krieglstein.org> wrote:
> > The long name for this device is
> > Lite-On IT Corp. / Plextor M6e PCI Express SSD [Marvell 88SS9183] (rev 14)
> > 
> > Background: the error description on bugzilla
> > https://bugzilla.kernel.org/show_bug.cgi?id=42679
> > inspired me to check if my brand new m4 pci ssd could work with a quirk.
> > Its device representation is not visible before this patch.
> > After this patch it appears as a normal device. Formatting
> > and mounting worked so far.
> > 
> > Signed-off-by: Tim Sander <tim@krieglstein.org>
> 
> Hi Tim,
> 
> Thanks a lot for the patch.  Can you open a new report at
> http://bugzilla.kernel.org and attach the complete dmesg and "lspci
> -vv" output without this patch, and also a dmesg log *with* this
> patch?  I like to keep a little documentation around in case we
> restructure this code in the future.
Basically its the same issue as the linked bug report, so reporting this twice 
seems a little backward to me?

> Also, since the vendor and device IDs are used only once, we probably
> won't add them to pci_ids.h (see the comment at the top of the file).
> Just use the bare constants in the quirk.

Mh, thats what i had first. For patch submission i created the header entries 
as it seemed cleaner as you can deduce the manufacturer from the names.
But then its really not that important.

Tim
