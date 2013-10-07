Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from co1ehsobe005.messaging.microsoft.com ([216.32.180.188]:56330
	"EHLO co1outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752754Ab3JGS6i convert rfc822-to-8bit
	(ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Mon, 7 Oct 2013 14:58:38 -0400
From: Rajat Jain <rajatjain@juniper.net>
To: "ebiederm@xmission.com" <ebiederm@xmission.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-hotplug@vger.kernel.org" <linux-hotplug@vger.kernel.org>
CC: Greg KH <gregkh@linuxfoundation.org>,
	Guenter Roeck <groeck@juniper.net>,
	"tom.l.nguyen@intel.com" <tom.l.nguyen@intel.com>,
	"kristen.c.accardi@intel.com" <kristen.c.accardi@intel.com>,
	"rajesh.shah@intel.com" <rajesh.shah@intel.com>,
	"rajatjain.linux@gmail.com" <rajatjain.linux@gmail.com>
Subject: Enhancing pciehp (was: pcielw An alternate pcie hotplug driver)
Date: Mon, 7 Oct 2013 18:58:32 +0000
Message-ID: <b13ea983a4154c7d9567b171e8316ca9@BLUPR05MB118.namprd05.prod.outlook.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hello Bjorn / Eric / Folks,

This is to seek suggestions about a problem I'm trying to solve.

The problem
===========
1) My company makes routers that have hot-pluggable cards with PCI express interfaces on them. We need to be able to hot-plug those cards, however the cards or the slots do not have the fancy bells & whistles (hot plug elements like MRL, sensor, attention button etc), and hence the hot-plug signals from the PCIe switch aren't really connected.

2) In addition to the above, we have onboard ASICs that are reachable via the PCIe. However, as part of regular operation of a router (e.g. user wants to switch off some ports), the ASICs can be off-lined / on-lined via out-of-band HW pins. The result is that we could see the PCIe link go down or up to that ASIC. This can be thought of as a "virtual" hot-plug of ASIC devices. Since the ASICs are themselves on the board, there is really no slot, and the HP signals again do not make much sense in this case.

What I found
=============
What I was looking for, was a way to hot-plug and un-plug based on link state changes (since that is pretty much what is available in my case). And I found this:
http://www.spinics.net/lists/linux-pci/msg05783.html
http://www.spinics.net/lists/linux-pci/msg05880.html

My questions
============
a) I was wanting to know if what is the latest on this, or if any progress was made on this? If useful, I am willing to volunteer to work on this. Do you think there is interest in getting this to work? I feel there may be many such systems that are in the same situation.

b) If I wanted to make use of Eric's patch in a way that is useful to the community, what is the best way to move forward? Do you still want to enhance the pciehp to include this functionality? Or a separate service driver (what Eric already has) seems a better idea? I'd appreciate if you could please provide any guidance here.

TIA,

Rajat


