Return-Path: <SRS0=ZSe8=KN=h08.hostsharing.net=foo00@kernel.org>
Return-Path: <SRS0=ZSe8=KN=h08.hostsharing.net=foo00@kernel.org>
Date: Sun, 29 Jul 2018 20:02:30 +0200
From: Lukas Wunner <lukas@wunner.de>
To: Sinan Kaya <okaya@kernel.org>
Cc: Bjorn Helgaas <helgaas@kernel.org>, Oza Pawandeep <poza@codeaurora.org>,
	linux-pci@vger.kernel.org, open list <linux-kernel@vger.kernel.org>,
	Keith Busch <keith.busch@intel.com>, linux-arm-msm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH V5 3/3] PCI: Mask and unmask hotplug interrupts during
 reset
Message-ID: <20180729180230.GA11016@wunner.de>
References: <CAK9iUCM=zWexWow9TwkRfO186Hwr5WyGy0NHZF1vtXn3wbbZGQ@mail.gmail.com>
 <12fc8de5-ff03-cb00-52cb-25a43c71d03a@codeaurora.org>
 <20180708171418.GA11476@wunner.de>
 <CAK9iUCMcic5mzGiT20KNxgwPo6AuajHFsoj7GOjSht5SwrQevg@mail.gmail.com>
 <20180709160008.GA1490@wunner.de>
 <CAK9iUCMMVR114msKiMHu7ik0VK8T5j=LAYAKsEkdnocTqkdMjQ@mail.gmail.com>
 <20180720200123.GS128988@bhelgaas-glaptop.roam.corp.google.com>
 <2febe688-f973-5ff5-f61d-0451ad7d36ae@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <2febe688-f973-5ff5-f61d-0451ad7d36ae@kernel.org>
List-ID: <linux-pci.vger.kernel.org>

On Fri, Jul 20, 2018 at 07:58:20PM -0700, Sinan Kaya wrote:
> My patch solves the problem if AER interrupt happens before the hotplug
> interrupt. We are masking the data link layer active interrupt. So,
> AER/DPC can perform their link operations without hotplug driver race.
> 
> We need to figure out how to gracefully return inside hotplug driver
> if link down happened and there is an error pending.
> 
> My first question is why hotplug driver is reacting to the link event
> if there was not an actual device insertion/removal.
> 
> Would it help to keep track of presence changed interrupts since last
> link event?
> 
> IF counter is 0 and device is present, hotplug driver bails out
> silently as an example.

Counting PDC events doesn't work reliably if multiple such events
occur in very short succession as the interrupt handler may not
run quickly enough.  See this commit message which shows unbalanced
Link Up / Link Down events:
https://patchwork.ozlabs.org/patch/867418/

And on Thunderbolt, interrupts can be signaled even though the port
and its parents are in D3hot (sic!).  A Thunderbolt daisy chain can
consist of up to 6 devices, each comprising a PCI switch, so there's
a cascade of over a dozen Upstream / Downstream ports between the
Root port and the hotplug port at the end of the daisy chain.
God knows how many events have occurred by the time all the parents
are resumed to D0 and the Slot Status register of the hotplug port
is read/written.  That was really the motivation for the event
handling rework.

Thanks,

Lukas
