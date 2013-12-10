Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from tx2ehsobe004.messaging.microsoft.com ([65.55.88.14]:33621 "EHLO
	tx2outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751065Ab3LJAfM convert rfc822-to-8bit
	(ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Mon, 9 Dec 2013 19:35:12 -0500
From: Guenter Roeck <groeck@juniper.net>
To: Yinghai Lu <yinghai@kernel.org>, Rajat Jain <rajatjain@juniper.net>
CC: Ethan Zhao <ethan.kernel@gmail.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: RE: [PATCH] PCI, pciehp: Turn on link a while to workaround
 presense detection
Date: Tue, 10 Dec 2013 00:34:58 +0000
Message-ID: <0a097fcaf4624bc997fc113baae9b3d1@CO1PR05MB523.namprd05.prod.outlook.com>
References: <1386361357-7767-1-git-send-email-yinghai@kernel.org>
	<CAErSpo5BnfmRJjXBqM7pWrMgvUt60hfC9oRbGy7=h6+Gftepqg@mail.gmail.com>
	<aaaa948b964642859fa142779846211f@DM2PR05MB671.namprd05.prod.outlook.com>
	<CABawtvPMSGc+7HqqtE9NXxCo11Vp-Yu+feF6UqS18k+jwPxoVw@mail.gmail.com>
	<c2a37fdd0e654fa3adccb0bcc38adb09@DM2PR05MB671.namprd05.prod.outlook.com>
	<CAE9FiQU7gM3gQkhWMXCTrJUqL137TW2TBL_gW=N2s3cbHr+5EA@mail.gmail.com>
	<8833f61075af4c97895aadc42c3f7335@DM2PR05MB671.namprd05.prod.outlook.com>
 <CAE9FiQXCpqFjCQhWCmK=pJGoef4nBRZtxJuufPSoG9OLjoKLNg@mail.gmail.com>
In-Reply-To: <CAE9FiQXCpqFjCQhWCmK=pJGoef4nBRZtxJuufPSoG9OLjoKLNg@mail.gmail.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>



> -----Original Message-----
> From: yhlu.kernel@gmail.com [mailto:yhlu.kernel@gmail.com] On Behalf Of
> Yinghai Lu
> Sent: Monday, December 09, 2013 12:20 PM
> To: Rajat Jain
> Cc: Ethan Zhao; Bjorn Helgaas; linux-pci@vger.kernel.org; Kenji
> Kaneshige; stable@vger.kernel.org; Guenter Roeck
> Subject: Re: [PATCH] PCI, pciehp: Turn on link a while to workaround
> presense detection
> 
> On Mon, Dec 9, 2013 at 11:35 AM, Rajat Jain <rajatjain@juniper.net>
> wrote:
> 
> > Actually there are situations where the presence detect signal does
> not make much sense, because the card is not really plugged out
> physically. For e.g. how do we deal with PCIe end points that may be on
> the board itself, but say come out of reset after the bootup? Or go
> down during a firmware upgrade and again come back up after the
> upgrade?
> >
> 
> That is driver's job.
> mpt2sas driver does diag_reset.
> 
Possibly, but quite frankly, after looking into that code, it seems quite dirty
to me. Of course, that is my personal opinion only. It may suggest, however,
assuming that the mpt2sas driver's resent handler causes a link down/link up 
sequence of events, that there is a valid case for the boot option.
I don't entirely understand, though, how that driver manages to reset its 
PCIe interface without the need to re-initialize it, but maybe I am just
missing something.

There are a number of other problems with the in-driver approach.
For example, it would require the driver to re-program the chip's PCIe
configuration space, as it will be 'vanilla' after the reset. Not even
sure how this can work, since that includes the chip BAR registers
and various other configuration registers which are normally set by the
PCIe subsystem. I'd rather handle this through the PCIe subsystem
instead of kludging around the problem in the driver.

Another problem is resulting boot delays. If link up/down is handled through
the PCIe subsystem, we can have the driver return -EPROBE_DEFER in the initial
probe, and everything just works automatically like magic. Waiting in probe
for the chip to re-initialize itself would add substantial delay to the boot
sequence. With several such chips in the system that can add up to a lot.

Even if we manage to implement all this, we still didn't solve our other
problems, which include chips which are activated after initial PCIe scan,
chips which (unfortunately) tend to hang up themselves without notice,
and real OIR devices which don't implement "correct" PCIe OIR handling.

Rajat's patch solves all those problems, and in my opinion it does so
quite elegantly.

Guenter


