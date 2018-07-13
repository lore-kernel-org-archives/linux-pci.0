Return-Path: <SRS0=STY/=J5=h08.hostsharing.net=foo00@kernel.org>
Return-Path: <SRS0=STY/=J5=h08.hostsharing.net=foo00@kernel.org>
Date: Fri, 13 Jul 2018 09:54:49 +0200
From: Lukas Wunner <lukas@wunner.de>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Ashok Raj <ashok.raj@intel.com>,
	Keith Busch <keith.busch@intel.com>,
	Yinghai Lu <yinghai@kernel.org>, Sinan Kaya <okaya@kernel.org>,
	linux-pci@vger.kernel.org, Greg Kroah-Hartman <greg@kroah.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Mayurkumar Patel <mayurkumar.patel@intel.com>,
	Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>,
	Stefan Roese <sr@denx.de>, Rajat Jain <rajatja@google.com>,
	Alex Williamson <alex.williamson@redhat.com>,
	Andreas Noever <andreas.noever@gmail.com>
Subject: Re: [PATCH 00/32] Rework pciehp event handling & add runtime PM
Message-ID: <20180713075449.GA27516@wunner.de>
References: <cover.1529173804.git.lukas@wunner.de>
 <20180712222816.GF28466@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180712222816.GF28466@bhelgaas-glaptop.roam.corp.google.com>
List-ID: <linux-pci.vger.kernel.org>

On Thu, Jul 12, 2018 at 05:28:16PM -0500, Bjorn Helgaas wrote:
> On Sat, Jun 16, 2018 at 09:25:00PM +0200, Lukas Wunner wrote:
> > Rework pciehp to use modern, threaded IRQ handling.  The slot is powered
> > on and off synchronously in the IRQ thread, no indirection via a work
> > queue anymore.
> > 
> > When the slot is enabled/disabled by the user via sysfs or an Attention
> > Button press, a request is sent to the IRQ thread.  The IRQ thread is
> > thus the sole entity enabling/disabling the slot.
> > 
> > The IRQ thread can cope with missed events, e.g. if a card is inserted
> > and immediately pulled out before the IRQ thread had a chance to react.
> > It also tolerates an initially unstable link as observed in the wild by
> > Stefan Roese.
> > 
> > Finally, runtime PM support is added.  This was the original motivation
> > of the series because runtime suspending hotplug ports is needed to power
> > down Thunderbolt controllers on idle, which saves ~1.5W per controller.
> > Runtime resuming ports takes tenths of milliseconds during which events
> > may be missed, this in turn necessitated the event handling rework.
> > 
> > I've pushed the series to GitHub to ease reviewing/fetching:
> > https://github.com/l1k/linux/commits/pciehp_runpm_v2
> 
> These patches all showed up in random order in my inbox, I think
> because they were sent with zero delay between them, which made them a
> bit of a hassle to read and apply via email.

I habitually use a 20 second delay between each message, but I got
unlucky and the mail servers delivered them in an incorrect order.

Since you're using Mutt, you can work around this problem by first
limiting the displayed messages to just this series by pressing the
"l" key and typing:
~f "Lukas Wunner" ~d 16/06

This will only show messages with a From header matching my name and
a Date header of June 16.  (You may need to type 06/16 depending on
your locale.)  You can go back to seeing all messages by pressing "l"
again and typing "." or "~a".

Now press the "o" key and then the "s" key.  This sorts by subject,
so you've got the order that you need to apply patches.  I think the
default is to order by reverse-date-received, you can go back to that
by pressing "O" (shift-O) and then "r".

FWIW you can verify my claim that the messages were sent out 20 seconds
apart by looking at the bottom-most Received: header.  (Press "h" to
see the full header in Mutt.)  This is the one of patch [00/32]:

Received: from localhost (unknown [redacted])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by h08.hostsharing.net (Postfix) with ESMTPSA id 8479E603E110;
	Sat, 16 Jun 2018 21:25:00 +0200 (CEST)

And this is patch [01/32]:

Received: from localhost (unknown [redacted])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by h08.hostsharing.net (Postfix) with ESMTPSA id 25AE9603E110;
	Sat, 16 Jun 2018 21:25:21 +0200 (CEST)

It was actually 21 seconds here, I guess the TLS setup took a little
longer.  Each subsequent patch is likewise spaced apart by 20 secs.


> If you repost these (I think I saw something about an issue with
> patch 3), can you use a second or two of delay between them?

Would you like me to resend the whole series?  The ones at the
beginning of the series (with the exception of patch 3) are probably
uncontroversial, I was hoping that you could maybe apply some of them,
or comment on some of the patches in the series so that I can rework
them before reposting, thereby avoiding spamming everyone with identical
patches a second time.

Thanks,

Lukas
