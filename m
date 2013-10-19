Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from co1ehsobe003.messaging.microsoft.com ([216.32.180.186]:37086
	"EHLO co1outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753027Ab3JSBHd convert rfc822-to-8bit
	(ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Fri, 18 Oct 2013 21:07:33 -0400
From: Rajat Jain <rajatjain@juniper.net>
To: Bjorn Helgaas <bhelgaas@google.com>
CC: "ebiederm@xmission.com" <ebiederm@xmission.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-hotplug@vger.kernel.org" <linux-hotplug@vger.kernel.org>,
	Greg KH <gregkh@linuxfoundation.org>,
	Guenter Roeck <groeck@juniper.net>,
	"tom.l.nguyen@intel.com" <tom.l.nguyen@intel.com>,
	"kristen.c.accardi@intel.com" <kristen.c.accardi@intel.com>,
	"rajesh.shah@intel.com" <rajesh.shah@intel.com>,
	"rajatjain.linux@gmail.com" <rajatjain.linux@gmail.com>
Subject: RE: Enhancing pciehp (was: pcielw An alternate pcie hotplug driver)
Date: Sat, 19 Oct 2013 01:07:23 +0000
Message-ID: <c713940b329e4c6584e173cb49aaa043@BLUPR05MB118.namprd05.prod.outlook.com>
References: <b13ea983a4154c7d9567b171e8316ca9@BLUPR05MB118.namprd05.prod.outlook.com>
 <CAErSpo4Yg-kUz3LHaWPVmzE1rGhdiqeJWuHwrM=-hxhP_zYH_g@mail.gmail.com>
In-Reply-To: <CAErSpo4Yg-kUz3LHaWPVmzE1rGhdiqeJWuHwrM=-hxhP_zYH_g@mail.gmail.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hello,

I'm working on enhancing the pciehp driver to allow link state changes to drive the hot-plug and un-plug. The idea was discussed here:

http://www.spinics.net/lists/linux-pci/msg25733.html

However, this is to invite ideas on how to handle a particular corner case I see. Let's say a PCIe link comes up and the pciehp driver calls pciehp_enable_slot() to start scanning and adding the devices on the slot. However, what to do if before that completes, the link goes down due to some reason? Can the pciehp driver call pciehp_disable_slot() before the call to pciehp_enable_slot() returns (with or without error)?

Essentially even without link state to driver the hot-plug, this problem can also be thought of as a problem that exists today. For e.g. for the slots that support surprise removal, the pciehp will initiate hot-plug and unplug based on the presence detection (as soon as card is inserted or removed). Now if a user puts in a card very momentarily, long enough for the hot-add process to get started (pciehp_enable_slot()) but removes it before it can be completed, the same problem can be envisioned. As the code exists today, I believe it would call pciehp_disable_slot() even before pciehp_enable_slot() returns. Is that the designed / correct behavior? 

Should I be following the same for link state change driven hot-plug?

Thanks,

Rajat

