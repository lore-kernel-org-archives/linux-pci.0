Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from eu1sys200aog114.obsmtp.com ([207.126.144.137]:42572 "EHLO
	eu1sys200aog114.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751305AbaHCJD4 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Sun, 3 Aug 2014 05:03:56 -0400
From: Eli Cohen <eli@mellanox.com>
To: Gavin Shan <gwshan@linux.vnet.ibm.com>,
	Amir Vadai <amirv@mellanox.com>
CC: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"alex.williamson@redhat.com" <alex.williamson@redhat.com>,
	Yevgeny Petrilin <yevgenyp@mellanox.com>,
	Peter Paneah <peter@mellanox.com>
Subject: RE: [PATCH v2] PCI: Mark broken INTx masking for Mellanox devices
Date: Sun, 3 Aug 2014 08:57:39 +0000
Message-ID: <CFE9BFE80FFE4D4892AA5D31387E310F014FC1968B@MTLDAG02.mtl.com>
References: <1406868871-350-1-git-send-email-gwshan@linux.vnet.ibm.com>
 <53DDE9EC.5040303@mellanox.com> <20140803082046.GA8962@shangw>
In-Reply-To: <20140803082046.GA8962@shangw>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

>>
>>What is the problem with masking the interrupts with the PCI command 
>>register? I'm asking because I want to understand in which devices we 
>>have the problem, and if it could be fixed by firmware guys.
>>What are the implications of having the quirk?
>>

>The way to mask the interrupt through PCI command register isn't taking effect on IBM power platform. So we have to have the >quirk so that the interrupt could be masked from interrupt controller side with function disable_irq_nosync().
>
>If the interrupt can't be masked properly, we detect interrupt storm reported from host/guest when passing through those devices >via VFIO without suprise.

Hi Gavin,
Does it have any effect on performance. Also, can you tell in which cases interrupts need to be masked?
