Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ie0-f180.google.com ([209.85.223.180]:55194 "EHLO
	mail-ie0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755681Ab3JGUcA convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 7 Oct 2013 16:32:00 -0400
Received: by mail-ie0-f180.google.com with SMTP id u16so16917647iet.39
        for <linux-pci@vger.kernel.org>; Mon, 07 Oct 2013 13:31:59 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <b13ea983a4154c7d9567b171e8316ca9@BLUPR05MB118.namprd05.prod.outlook.com>
References: <b13ea983a4154c7d9567b171e8316ca9@BLUPR05MB118.namprd05.prod.outlook.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Mon, 7 Oct 2013 14:31:39 -0600
Message-ID: <CAErSpo4Yg-kUz3LHaWPVmzE1rGhdiqeJWuHwrM=-hxhP_zYH_g@mail.gmail.com>
Subject: Re: Enhancing pciehp (was: pcielw An alternate pcie hotplug driver)
To: Rajat Jain <rajatjain@juniper.net>
Cc: "ebiederm@xmission.com" <ebiederm@xmission.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-hotplug@vger.kernel.org" <linux-hotplug@vger.kernel.org>,
	Greg KH <gregkh@linuxfoundation.org>,
	Guenter Roeck <groeck@juniper.net>,
	"tom.l.nguyen@intel.com" <tom.l.nguyen@intel.com>,
	"kristen.c.accardi@intel.com" <kristen.c.accardi@intel.com>,
	"rajesh.shah@intel.com" <rajesh.shah@intel.com>,
	"rajatjain.linux@gmail.com" <rajatjain.linux@gmail.com>
Content-Type: text/plain; charset=US-ASCII
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Oct 7, 2013 at 12:58 PM, Rajat Jain <rajatjain@juniper.net> wrote:
> Hello Bjorn / Eric / Folks,
>
> This is to seek suggestions about a problem I'm trying to solve.
>
> The problem
> ===========
> 1) My company makes routers that have hot-pluggable cards with PCI express interfaces on them. We need to be able to hot-plug those cards, however the cards or the slots do not have the fancy bells & whistles (hot plug elements like MRL, sensor, attention button etc), and hence the hot-plug signals from the PCIe switch aren't really connected.

The elements you mention are optional per the spec (PCIe r3.0, sec
6.7.1).  The lack of them, by itself, should not be enough to force
you to write a new hotplug driver.  pciehp is used for ExpressCard
hotplug, and that's a similar situation where there's no MRL, no MRL
sensor, no interlock, no attention button, etc.

What connects the hot-pluggable card to the system?  PCI?  PCIe?
Something else?  If it's PCIe, it seems like you'd make your life
simpler by taking advantage of some or all of the hotplug support that
is likely in the PCIe Root Port or Downstream Port leading to the
slot.

> 2) In addition to the above, we have onboard ASICs that are reachable via the PCIe. However, as part of regular operation of a router (e.g. user wants to switch off some ports), the ASICs can be off-lined / on-lined via out-of-band HW pins. The result is that we could see the PCIe link go down or up to that ASIC. This can be thought of as a "virtual" hot-plug of ASIC devices. Since the ASICs are themselves on the board, there is really no slot, and the HP signals again do not make much sense in this case.

It doesn't really matter that there's no physical slot and the user
can't replace an ASIC with a different one.  You can still use the
hotplug signals that *are* relevant, e.g., it sounds like things
related to Hot-Plug Surprise, Presence Detect, and Data Link Layer
State would still make sense.

The current pciehp driver doesn't really do anything with the Data
Link Layer State Changed Enable bit (it looks like we *disable* that
notification, but never *enable* it).  It sounds like a reasonable
thing to add to pciehp, though.

Bjorn
