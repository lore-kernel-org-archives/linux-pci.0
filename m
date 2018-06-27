Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:33913 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S965286AbeF0NfV (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 27 Jun 2018 09:35:21 -0400
From: "Patel, Mayurkumar" <mayurkumar.patel@intel.com>
To: Mika Westerberg <mika.westerberg@linux.intel.com>,
        Lukas Wunner <lukas@wunner.de>
CC: Bjorn Helgaas <bhelgaas@google.com>,
        "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>,
        "Raj, Ashok" <ashok.raj@intel.com>,
        "Busch, Keith" <keith.busch@intel.com>,
        Yinghai Lu <yinghai@kernel.org>, Sinan Kaya <okaya@kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        Greg Kroah-Hartman <greg@kroah.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>,
        Stefan Roese <sr@denx.de>, Rajat Jain <rajatja@google.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Andreas Noever <andreas.noever@gmail.com>
Subject: RE: [PATCH 00/32] Rework pciehp event handling & add runtime PM
Date: Wed, 27 Jun 2018 13:35:15 +0000
Message-ID: <92EBB4272BF81E4089A7126EC1E7B28478B99444@IRSMSX101.ger.corp.intel.com>
References: <cover.1529173804.git.lukas@wunner.de>
 <20180621121955.GZ2558@lahna.fi.intel.com>
In-Reply-To: <20180621121955.GZ2558@lahna.fi.intel.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>



>-----Original Message-----
>From: Mika Westerberg [mailto:mika.westerberg@linux.intel.com]
>Sent: Thursday, June 21, 2018 2:20 PM
>To: Lukas Wunner <lukas@wunner.de>
>Cc: Bjorn Helgaas <bhelgaas@google.com>; Wysocki, Rafael J <rafael.j.wysocki@intel.com>; Raj, Ashok <ashok.raj@intel.com>; Busch,
>Keith <keith.busch@intel.com>; Yinghai Lu <yinghai@kernel.org>; Sinan Kaya <okaya@kernel.org>; linux-pci@vger.kernel.org; Greg Kroah-
>Hartman <greg@kroah.com>; Thomas Gleixner <tglx@linutronix.de>; Patel, Mayurkumar <mayurkumar.patel@intel.com>; Kenji Kaneshige
><kaneshige.kenji@jp.fujitsu.com>; Stefan Roese <sr@denx.de>; Rajat Jain <rajatja@google.com>; Alex Williamson
><alex.williamson@redhat.com>; Andreas Noever <andreas.noever@gmail.com>
>Subject: Re: [PATCH 00/32] Rework pciehp event handling & add runtime PM
>
>On Sat, Jun 16, 2018 at 09:25:00PM +0200, Lukas Wunner wrote:
>> Rework pciehp to use modern, threaded IRQ handling.  The slot is powered
>> on and off synchronously in the IRQ thread, no indirection via a work
>> queue anymore.
>>
>> When the slot is enabled/disabled by the user via sysfs or an Attention
>> Button press, a request is sent to the IRQ thread.  The IRQ thread is
>> thus the sole entity enabling/disabling the slot.
>>
>> The IRQ thread can cope with missed events, e.g. if a card is inserted
>> and immediately pulled out before the IRQ thread had a chance to react.
>> It also tolerates an initially unstable link as observed in the wild by
>> Stefan Roese.
>>
>> Finally, runtime PM support is added.  This was the original motivation
>> of the series because runtime suspending hotplug ports is needed to power
>> down Thunderbolt controllers on idle, which saves ~1.5W per controller.
>> Runtime resuming ports takes tenths of milliseconds during which events
>> may be missed, this in turn necessitated the event handling rework.
>>
>> I've pushed the series to GitHub to ease reviewing/fetching:
>> https://github.com/l1k/linux/commits/pciehp_runpm_v2
>>
>> Please review and test.
>
>I've tested this series on every native PCIe hotplug system I have here,
>including one non-Thunderbolt (just hotplugging NVMes) and I did not
>observe any issues. There are few minor comments for few patches but in
>general this is really nice cleanup.


I have not found any issues with this test series on my test setup related to PCIe hotplug.

Intel Deutschland GmbH
Registered Address: Am Campeon 10-12, 85579 Neubiberg, Germany
Tel: +49 89 99 8853-0, www.intel.de
Managing Directors: Christin Eisenschmid, Christian Lamprechter
Chairperson of the Supervisory Board: Nicole Lau
Registered Office: Munich
Commercial Register: Amtsgericht Muenchen HRB 186928
