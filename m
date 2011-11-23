Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-qy0-f174.google.com ([209.85.216.174]:51975 "EHLO
	mail-qy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751434Ab1KWQ3o (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 23 Nov 2011 11:29:44 -0500
Date: Wed, 23 Nov 2011 08:29:37 -0800
From: Tejun Heo <tj@kernel.org>
To: Pratyush Anand <pratyush.anand@gmail.com>
Cc: linux-pci@vger.kernel.org, linux-ide@vger.kernel.org,
	Jesse Barnes <jbarnes@virtuousgeek.org>,
	Russell King <linux@arm.linux.org.uk>
Subject: Re: Crash with sata_sil24 driver
Message-ID: <20111123162937.GF25780@google.com>
References: <CAHM4w1kc+5aYWH-09BPTXZdo8+iguFjORKs7mMhG7hea2UU8yQ@mail.gmail.com>
 <CAHM4w1nZ7GgutiuDiTCKu9wUuphn8qOiWgmCYVXXvwW1q8CgoA@mail.gmail.com>
 <20111122150613.GA322@google.com>
 <CAHM4w1nsNTQmAL-0d76O9cYXjNbiq-0f60Y3emWO2yf7HyFWDg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <CAHM4w1nsNTQmAL-0d76O9cYXjNbiq-0f60Y3emWO2yf7HyFWDg@mail.gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

(cc'ing Russell, hello)

The original thread can be read from

  http://thread.gmane.org/gmane.linux.usb.general/54878/

On Wed, Nov 23, 2011 at 10:49:00AM +0530, Pratyush Anand wrote:
> Hello Tejun,
> 
> 
> On Tue, Nov 22, 2011 at 8:36 PM, Tejun Heo <tj@kernel.org> wrote:
> > Hello,
> >
> > (cc'ing Jesse)
> >
> > On Tue, Nov 22, 2011 at 04:40:40PM +0530, Pratyush Anand wrote:
> >> > I am using various PCIe card based on Silicon Image 3124/3132 to
> >> > test my PCIe host. This card is working with most of my host controler.
> >> > I use sata_sil24 driver to enable the card, with one modification of
> >> > commenting line [pcie_set_readrq(pdev, 4096);]
> >> >
> >> > I had sent a patch for it , which is still unanswered.
> >> > http://comments.gmane.org/gmane.linux.kernel.pci/10300
> >
> > Yeah, that's something lifted from proprietary driver and it's
> > likely to be wrong.  Jesse, is there a way to find out the safe
> > maximum value for readrq?  I'm a bit reluctant to drop it as pcie
> > variants of these chips are bottlenecked on the host bus pretty badly.
> >
> >> > Anyway, this mail is regarding another issue.
> >> >
> >> > I am still having problem when I use above driver (with above patch),
> >> > in following
> >> > situation.
> >> >
> >> > My SOC is having cortex-a9 dual core. When I work with CPU freq 500
> >> > MHz, it works
> >> > well. But with 600 MHz it crashes. Crash log is at the end of mail.
> >> >
> >> > I did further debugging. I found that if I put some delay after
> >> > calling of sil24_init_controller(host); in function sil24_init_one, it
> >> > works well.
> >> >
> >> > My question is.
> >> > does sil24_init_controller insure perfact initilization?
> >> > or we missing to check some status register which might be needed
> >> > before ata_host_activate.
> >> > ---------------------------------------------------------------------
> >> > Modules linked in:
> >> > CPU: 0    Not tainted  (2.6.37-lsp-3.2.2-rc-dirty #7)
> >> > PC is at sil24_scr_read+0x38/0x50
> >> > LR is at sil24_port_base+0x14/0x2c
> >> > pc : [<80255e10>]    lr : [<80255d44>]    psr: 80000013
> >
> > Hmm... this is weird.  All init happens in the same thread.  There's
> > no race condition involved here.  I'm not too familiar with arm.  Can
> > you please track down what is causing the crash?  ie. is it memory
> > access to kernel data structure or io region?
> 
> It  is accessing SATA Controller registers rather kerenl data struct
> at the time of crash.
> It crashes when it tries to read SCR_CONTROL register.
> Its really strage that same register become accesible if a delay of 10us is
> put after sil24_init_controller.

Weird, that basically means that somehow pci_iomap() isn't
synchronous.  ie. you need to way some time after pci_iomap() before
being able to access the mapped address.  Seems like arch / pci
weirdness.  Jesse, Russell, any ideas?

Thank you.

-- 
tejun
