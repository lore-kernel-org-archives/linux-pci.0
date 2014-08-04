Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from e23smtp05.au.ibm.com ([202.81.31.147]:49103 "EHLO
	e23smtp05.au.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751974AbaHDAer (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Sun, 3 Aug 2014 20:34:47 -0400
Received: from /spool/local
	by e23smtp05.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pci@vger.kernel.org> from <gwshan@linux.vnet.ibm.com>;
	Mon, 4 Aug 2014 10:34:45 +1000
Received: from d23relay03.au.ibm.com (d23relay03.au.ibm.com [9.190.235.21])
	by d23dlp01.au.ibm.com (Postfix) with ESMTP id 6192F2CE8050
	for <linux-pci@vger.kernel.org>; Mon,  4 Aug 2014 10:34:43 +1000 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
	by d23relay03.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id s740YAJw24969420
	for <linux-pci@vger.kernel.org>; Mon, 4 Aug 2014 10:34:10 +1000
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
	by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id s740YgWk008199
	for <linux-pci@vger.kernel.org>; Mon, 4 Aug 2014 10:34:42 +1000
Date: Mon, 4 Aug 2014 10:34:38 +1000
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: Alex Williamson <alex.williamson@redhat.com>
Cc: Gavin Shan <gwshan@linux.vnet.ibm.com>,
	Eli Cohen <eli@mellanox.com>, Amir Vadai <amirv@mellanox.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Yevgeny Petrilin <yevgenyp@mellanox.com>,
	Peter Paneah <peter@mellanox.com>
Subject: Re: [PATCH v2] PCI: Mark broken INTx masking for Mellanox devices
Message-ID: <20140804003437.GA4039@shangw>
Reply-To: Gavin Shan <gwshan@linux.vnet.ibm.com>
References: <1406868871-350-1-git-send-email-gwshan@linux.vnet.ibm.com>
 <53DDE9EC.5040303@mellanox.com>
 <20140803082046.GA8962@shangw>
 <CFE9BFE80FFE4D4892AA5D31387E310F014FC1968B@MTLDAG02.mtl.com>
 <20140803143007.GA4692@shangw>
 <1407078486.14674.5.camel@ul30vt.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1407078486.14674.5.camel@ul30vt.home>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Sun, Aug 03, 2014 at 09:08:06AM -0600, Alex Williamson wrote:
>On Mon, 2014-08-04 at 00:30 +1000, Gavin Shan wrote:
>> On Sun, Aug 03, 2014 at 08:57:39AM +0000, Eli Cohen wrote:
>> >>>
>> >>>What is the problem with masking the interrupts with the PCI command 
>> >>>register? I'm asking because I want to understand in which devices we 
>> >>>have the problem, and if it could be fixed by firmware guys.
>> >>>What are the implications of having the quirk?
>> >>>
>> >
>> >>The way to mask the interrupt through PCI command register isn't taking effect on IBM power platform. So we have to have the >quirk so that the interrupt could be masked from interrupt controller side with function disable_irq_nosync().
>> >>
>> >>If the interrupt can't be masked properly, we detect interrupt storm reported from host/guest when passing through those devices >via VFIO without suprise.
>> >
>> >Hi Gavin,
>> >Does it have any effect on performance. Also, can you tell in which cases interrupts need to be masked?
>> >
>> 
>> Eli, more code needed to be run for masking the LSI from interrupt controller
>> side than from PCI command register.
>> 
>> I was passing through Mellanox devices from host to guest with VFIO, and I
>> designated to use LSI in the guest side. More details could be found in
>> drivers/vfio/pci/vfio_pci_intrs.c::vfio_intx_handler()
>
>INTx is relatively high overhead already for device assignment since the
>interrupt is level triggered and needs to be masked on the host while
>the guest is processing it.  The more important restriction imposed by
>marking broken INTx masking is that the device needs an exclusive
>interrupt line in order to be assigned to a guest.  That may be common
>practice on IBM power, but on x86 it can make it much harder to
>configure the system for this use case.  Thanks,
>

Power platform has the similar situation: Each PCI controller has 4
LSIs shared by all child devices attached to the PHB. It would be
racy if one LSI is shared by 2 or more devices. So masking LSI with
PCI command register is the preferred mechanism. Unfortunately, it
doesn't work on those 2 Mellanox devices. With the quirk, it's workable
at least.

Thanks,
Gavin

>Alex
>
>

