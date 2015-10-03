Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from ipmail05.adl6.internode.on.net ([150.101.137.143]:26241 "EHLO
	ipmail05.adl6.internode.on.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751807AbbJCLO3 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Sat, 3 Oct 2015 07:14:29 -0400
Message-ID: <560FB882.5050107@internode.on.net>
Date: Sat, 03 Oct 2015 20:44:10 +0930
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
References: <20150916134211.GA21535@infradead.org> <1442907023-12709-1-git-send-email-jiang.liu@linux.intel.com> <5601D550.5000801@internode.on.net> <1442961929.15264.4.camel@HansenPartnership.com> <5601E5FE.7020706@internode.on.net> <56023771.5010006@linux.intel.com> <5602829C.5090500@internode.on.net> <1443019207.2240.27.camel@HansenPartnership.com> <56037C09.5050201@linux.intel.com> <560390A1.5060503@internode.on.net> <56063AB7.9030309@internode.on.net> <560F8DB0.8030704@linux.intel.com>
In-Reply-To: <560F8DB0.8030704@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>



Jiang Liu wrote on 03/10/15 17:41:

> Hi Arthur,
> 	The above results suggest that we need to shutdown eata
> controller for kexec. So could you please try to apply the attached
> patch upon the previous two patches?
> Thanks!
> Gerry
>

Hi, I still get kexec shutdown errors like this with the 3rd patch applied:

http://www.users.on.net/~arthur.marsh/20151003566.jpg

I can still unmount filesystems, modprobe -r eata and modprobe eata to 
get things into a state where a kexec reboot works.

Regards,

Arthur.
