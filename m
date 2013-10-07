Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from out01.mta.xmission.com ([166.70.13.231]:48722 "EHLO
	out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751197Ab3JGWnF (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 7 Oct 2013 18:43:05 -0400
From: ebiederm@xmission.com (Eric W. Biederman)
To: Rajat Jain <rajatjain@juniper.net>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	"linux-pci\@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-hotplug\@vger.kernel.org" <linux-hotplug@vger.kernel.org>,
	Greg KH <gregkh@linuxfoundation.org>,
	Guenter Roeck <groeck@juniper.net>,
	"tom.l.nguyen\@intel.com" <tom.l.nguyen@intel.com>,
	"kristen.c.accardi\@intel.com" <kristen.c.accardi@intel.com>,
	"rajesh.shah\@intel.com" <rajesh.shah@intel.com>,
	"rajatjain.linux\@gmail.com" <rajatjain.linux@gmail.com>
References: <b13ea983a4154c7d9567b171e8316ca9@BLUPR05MB118.namprd05.prod.outlook.com>
Date: Mon, 07 Oct 2013 15:42:56 -0700
In-Reply-To: <b13ea983a4154c7d9567b171e8316ca9@BLUPR05MB118.namprd05.prod.outlook.com>
	(Rajat Jain's message of "Mon, 7 Oct 2013 18:58:32 +0000")
Message-ID: <87r4bwvh1r.fsf@xmission.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: Enhancing pciehp
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Rajat Jain <rajatjain@juniper.net> writes:

> Hello Bjorn / Eric / Folks,
>
> This is to seek suggestions about a problem I'm trying to solve.
>
> The problem
> ===========
> 1) My company makes routers that have hot-pluggable cards with PCI express interfaces on them. We need to be able to hot-plug those cards, however the cards or the slots do not have the fancy bells & whistles (hot plug elements like MRL, sensor, attention button etc), and hence the hot-plug signals from the PCIe switch aren't really connected.
>
> 2) In addition to the above, we have onboard ASICs that are reachable via the PCIe. However, as part of regular operation of a router (e.g. user wants to switch off some ports), the ASICs can be off-lined / on-lined via out-of-band HW pins. The result is that we could see the PCIe link go down or up to that ASIC. This can be thought of as a "virtual" hot-plug of ASIC devices. Since the ASICs are themselves on the board, there is really no slot, and the HP signals again do not make much sense in this case.
>
> What I found
> =============
> What I was looking for, was a way to hot-plug and un-plug based on link state changes (since that is pretty much what is available in my case). And I found this:
> http://www.spinics.net/lists/linux-pci/msg05783.html
> http://www.spinics.net/lists/linux-pci/msg05880.html
>
> My questions
> ============

> a) I was wanting to know if what is the latest on this, or if any
> progress was made on this? If useful, I am willing to volunteer to
> work on this. Do you think there is interest in getting this to work?
> I feel there may be many such systems that are in the same situation.

Agreed.  It appears this is a design that is likely to come up more than
once.

> b) If I wanted to make use of Eric's patch in a way that is useful to
> the community, what is the best way to move forward? Do you still want
> to enhance the pciehp to include this functionality? Or a separate
> service driver (what Eric already has) seems a better idea? I'd
> appreciate if you could please provide any guidance here.

Where I wound up was I unfortunately had not left time in my schedule to
completely rewrite what I had done and to merge that into pciehp.

I wrote pcielw simply because the pciehp driver did not and may still
not work with multiple layers of pci hotplug so I needed to do some deep
digging.  Dealing with all of the cases of physical buttons when I did
not have those was prohibitive for my poor schedule.

I work somewhere else now and I don't have this problem so I will not be
looking at this problem again any time soon.

I do agree with Bjorn that one driver that can handle everything is
doable and ideal.  So if you are willing to do that work it would be
great.  pcielw should certainly work as a proof of concept solution to
any of the problems, and time permitting I am willing to answer
questions of the what was I thinking variety.

Eric
