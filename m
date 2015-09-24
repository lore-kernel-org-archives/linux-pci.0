Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from ipmail06.adl6.internode.on.net ([150.101.137.145]:47881 "EHLO
	ipmail06.adl6.internode.on.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750855AbbIXF4z (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 24 Sep 2015 01:56:55 -0400
Message-ID: <560390A1.5060503@internode.on.net>
Date: Thu, 24 Sep 2015 15:26:49 +0930
From: Arthur Marsh <arthur.marsh@internode.on.net>
MIME-Version: 1.0
To: Jiang Liu <jiang.liu@linux.intel.com>,
	James Bottomley <James.Bottomley@HansenPartnership.com>
CC: Thomas Gleixner <tglx@linutronix.de>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Hannes Reinecke <hare@suse.de>,
	Ballabio Dario <dario.ballabio@emc.com>,
	Christoph Hellwig <hch@infradead.org>,
	Dario Ballabio <ballabio_dario@emc.com>,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-scsi@vger.kernel.org, x86@kernel.org
Subject: Re: [RFT v3] eata: Convert eata driver as normal PCI and platform
 device drivers
References: <20150916134211.GA21535@infradead.org> <1442907023-12709-1-git-send-email-jiang.liu@linux.intel.com> <5601D550.5000801@internode.on.net> <1442961929.15264.4.camel@HansenPartnership.com> <5601E5FE.7020706@internode.on.net> <56023771.5010006@linux.intel.com> <5602829C.5090500@internode.on.net> <1443019207.2240.27.camel@HansenPartnership.com> <56037C09.5050201@linux.intel.com>
In-Reply-To: <56037C09.5050201@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>



Jiang Liu wrote on 24/09/15 13:58:

> Hi James,
> 	Thanks for review. How about the attached patch which addresses
> the three suggestions from you?
> Thanks!
> Gerry

I've applied the patch, rebuilt the kernel and verified that it allows 
unloading of the eata module and reloading it, as well as a successful 
kexec.

Regards,

Arthur.
