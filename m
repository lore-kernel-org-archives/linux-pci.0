Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from tx2ehsobe003.messaging.microsoft.com ([65.55.88.13]:52997 "EHLO
	tx2outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750976Ab3LJWA0 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Tue, 10 Dec 2013 17:00:26 -0500
From: Guenter Roeck <groeck@juniper.net>
To: Yinghai Lu <yinghai@kernel.org>
CC: Rajat Jain <rajatjain@juniper.net>,
	Ethan Zhao <ethan.kernel@gmail.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: RE: [PATCH] PCI, pciehp: Turn on link a while to workaround
 presense detection
Date: Tue, 10 Dec 2013 22:00:18 +0000
Message-ID: <fba39f7e78494e6a87b528d2726e1250@CO1PR05MB523.namprd05.prod.outlook.com>
References: <1386361357-7767-1-git-send-email-yinghai@kernel.org>
	<CAErSpo5BnfmRJjXBqM7pWrMgvUt60hfC9oRbGy7=h6+Gftepqg@mail.gmail.com>
	<aaaa948b964642859fa142779846211f@DM2PR05MB671.namprd05.prod.outlook.com>
	<CABawtvPMSGc+7HqqtE9NXxCo11Vp-Yu+feF6UqS18k+jwPxoVw@mail.gmail.com>
	<c2a37fdd0e654fa3adccb0bcc38adb09@DM2PR05MB671.namprd05.prod.outlook.com>
	<CAE9FiQU7gM3gQkhWMXCTrJUqL137TW2TBL_gW=N2s3cbHr+5EA@mail.gmail.com>
	<8833f61075af4c97895aadc42c3f7335@DM2PR05MB671.namprd05.prod.outlook.com>
	<CAE9FiQXCpqFjCQhWCmK=pJGoef4nBRZtxJuufPSoG9OLjoKLNg@mail.gmail.com>
	<0a097fcaf4624bc997fc113baae9b3d1@CO1PR05MB523.namprd05.prod.outlook.com>
 <CAE9FiQXTumAr_0jVFnZXuEQF2PvVn2JgK73u-LO=zPnRdVJg7w@mail.gmail.com>
In-Reply-To: <CAE9FiQXTumAr_0jVFnZXuEQF2PvVn2JgK73u-LO=zPnRdVJg7w@mail.gmail.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>



> -----Original Message-----
> From: yhlu.kernel@gmail.com [mailto:yhlu.kernel@gmail.com] On Behalf Of
> Yinghai Lu
> Sent: Tuesday, December 10, 2013 1:44 PM
> To: Guenter Roeck
> Cc: Rajat Jain; Ethan Zhao; Bjorn Helgaas; linux-pci@vger.kernel.org;
> Kenji Kaneshige; stable@vger.kernel.org
> Subject: Re: [PATCH] PCI, pciehp: Turn on link a while to workaround
> presense detection
> 
> On Mon, Dec 9, 2013 at 4:34 PM, Guenter Roeck <groeck@juniper.net>
> wrote:
> >> > Actually there are situations where the presence detect signal
> does
> >> not make much sense, because the card is not really plugged out
> >> physically. For e.g. how do we deal with PCIe end points that may be
> >> on the board itself, but say come out of reset after the bootup? Or
> >> go down during a firmware upgrade and again come back up after the
> >> upgrade?
> >> >
> >>
> >> That is driver's job.
> >> mpt2sas driver does diag_reset.
> >>
> > Possibly, but quite frankly, after looking into that code, it seems
> > quite dirty to me. Of course, that is my personal opinion only. It
> may
> > suggest, however, assuming that the mpt2sas driver's resent handler
> > causes a link down/link up sequence of events, that there is a valid
> case for the boot option.
> > I don't entirely understand, though, how that driver manages to reset
> > its PCIe interface without the need to re-initialize it, but maybe I
> > am just missing something.
> >
> > There are a number of other problems with the in-driver approach.
> > For example, it would require the driver to re-program the chip's
> PCIe
> > configuration space, as it will be 'vanilla' after the reset. Not
> even
> > sure how this can work, since that includes the chip BAR registers
> and
> > various other configuration registers which are normally set by the
> > PCIe subsystem. I'd rather handle this through the PCIe subsystem
> > instead of kludging around the problem in the driver.
> >
> > Another problem is resulting boot delays. If link up/down is handled
> > through the PCIe subsystem, we can have the driver return
> > -EPROBE_DEFER in the initial probe, and everything just works
> > automatically like magic. Waiting in probe for the chip to
> > re-initialize itself would add substantial delay to the boot
> sequence. With several such chips in the system that can add up to a
> lot.
> >
> > Even if we manage to implement all this, we still didn't solve our
> > other problems, which include chips which are activated after initial
> > PCIe scan, chips which (unfortunately) tend to hang up themselves
> > without notice, and real OIR devices which don't implement "correct"
> PCIe OIR handling.
> >
> > Rajat's patch solves all those problems, and in my opinion it does so
> > quite elegantly.
> 
> According to your description, i think you can do them with scripts in
> user land and your driver.
> Your driver should have provide interface to load fw.
> Have a scripts and load fw, and from /sys stop and remove related pci
> devices.
> then rescan corresponding bridge later.

The FW itself is accessible through an eeprom and can be updated that way.
To load it we need to set a flag in the device PCI memory space which causes
the entire chip including its PCIe interface to reset.

Sure, we can handle rescan from userspace. However, that is quite vulnerable
and messy (eg don't try to initiate a rescan without first explicitly removing
any devices which have since been reset, removed, and/or reinitialized).
Do anything wrong, or in the wrong sequence, and the PCIe data structures
in the kernel are completely messed up. This may be ok for experimental code,
but I would not want to ship it to a customer.

Besides, it still doesn't solve all problems such as to detect hung devices.
Handling it in the kernel is much more straightforward and cleaner.

Guenter


