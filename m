Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from ipmail05.adl6.internode.on.net ([150.101.137.143]:11871 "EHLO
	ipmail05.adl6.internode.on.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752469AbbJEI3t (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 5 Oct 2015 04:29:49 -0400
Message-ID: <561234F6.6050805@internode.on.net>
Date: Mon, 05 Oct 2015 18:59:42 +1030
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

>> If I do a normal boot which includes eata being loaded, the disk
>> attached to the DPT2044W controller having its filesystems checked and
>> mounted, then attempt a kexec reboot, I get the reboot pausing after the
>> "synchronizing SCSI cache" messages as before.
>>
>> If I un-mount the filesystems on the disk attached to the DPT2044W
>> controller after start-up and try a reboot I get the same problem.
>>
>> If I do modprobe -r eata after un-mounting the filesystems on the disk
>> attached to the DPT2044W controller after a start-up kexec *works fine*.
> Hi Arthur,
> 	The above results suggest that we need to shutdown eata
> controller for kexec. So could you please try to apply the attached
> patch upon the previous two patches?
> Thanks!
> Gerry
>

To clarify, if the eata driver gets loaded once and stays loaded, at a 
kexec reboot attempt the "Synchronising SCSI cache" message is missing 
for the SCSI disk attached to the controller using the eata driver and 
eventually other error messages appear as seen in screen images that I 
have previously posted.

If the eata driver is loaded, unloaded via modprobe -r, then reloaded, a 
kexec reboot shows 2 "Synchronising SCSI cache" messages for the SCSI 
disk attached to the controller using the eata driver and the kexec 
reboot is successful.


Arthur.
