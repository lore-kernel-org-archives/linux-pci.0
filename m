Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from e28smtp05.in.ibm.com ([122.248.162.5]:36664 "EHLO
	e28smtp05.in.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750960AbaHCOaU (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Sun, 3 Aug 2014 10:30:20 -0400
Received: from /spool/local
	by e28smtp05.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pci@vger.kernel.org> from <gwshan@linux.vnet.ibm.com>;
	Sun, 3 Aug 2014 20:00:18 +0530
Received: from d28relay03.in.ibm.com (d28relay03.in.ibm.com [9.184.220.60])
	by d28dlp03.in.ibm.com (Postfix) with ESMTP id 254D31258017
	for <linux-pci@vger.kernel.org>; Sun,  3 Aug 2014 20:00:18 +0530 (IST)
Received: from d28av01.in.ibm.com (d28av01.in.ibm.com [9.184.220.63])
	by d28relay03.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id s73EWKFu64946428
	for <linux-pci@vger.kernel.org>; Sun, 3 Aug 2014 20:02:21 +0530
Received: from d28av01.in.ibm.com (localhost [127.0.0.1])
	by d28av01.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id s73EUFw5018142
	for <linux-pci@vger.kernel.org>; Sun, 3 Aug 2014 20:00:15 +0530
Date: Mon, 4 Aug 2014 00:30:07 +1000
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: Eli Cohen <eli@mellanox.com>
Cc: Gavin Shan <gwshan@linux.vnet.ibm.com>,
	Amir Vadai <amirv@mellanox.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"alex.williamson@redhat.com" <alex.williamson@redhat.com>,
	Yevgeny Petrilin <yevgenyp@mellanox.com>,
	Peter Paneah <peter@mellanox.com>
Subject: Re: [PATCH v2] PCI: Mark broken INTx masking for Mellanox devices
Message-ID: <20140803143007.GA4692@shangw>
Reply-To: Gavin Shan <gwshan@linux.vnet.ibm.com>
References: <1406868871-350-1-git-send-email-gwshan@linux.vnet.ibm.com>
 <53DDE9EC.5040303@mellanox.com>
 <20140803082046.GA8962@shangw>
 <CFE9BFE80FFE4D4892AA5D31387E310F014FC1968B@MTLDAG02.mtl.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CFE9BFE80FFE4D4892AA5D31387E310F014FC1968B@MTLDAG02.mtl.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Sun, Aug 03, 2014 at 08:57:39AM +0000, Eli Cohen wrote:
>>>
>>>What is the problem with masking the interrupts with the PCI command 
>>>register? I'm asking because I want to understand in which devices we 
>>>have the problem, and if it could be fixed by firmware guys.
>>>What are the implications of having the quirk?
>>>
>
>>The way to mask the interrupt through PCI command register isn't taking effect on IBM power platform. So we have to have the >quirk so that the interrupt could be masked from interrupt controller side with function disable_irq_nosync().
>>
>>If the interrupt can't be masked properly, we detect interrupt storm reported from host/guest when passing through those devices >via VFIO without suprise.
>
>Hi Gavin,
>Does it have any effect on performance. Also, can you tell in which cases interrupts need to be masked?
>

Eli, more code needed to be run for masking the LSI from interrupt controller
side than from PCI command register.

I was passing through Mellanox devices from host to guest with VFIO, and I
designated to use LSI in the guest side. More details could be found in
drivers/vfio/pci/vfio_pci_intrs.c::vfio_intx_handler()

Thanks,
Gavin


