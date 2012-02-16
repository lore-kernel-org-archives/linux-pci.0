Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from smtp-out003.kontent.com ([81.88.40.217]:35198 "EHLO
	smtp-out003.kontent.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752511Ab2BPOqY (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 16 Feb 2012 09:46:24 -0500
From: Oliver Neukum <oliver@neukum.org>
To: Sarah Sharp <sarah.a.sharp@linux.intel.com>
Subject: Re: [RFC v2] USB: Fix handoff when BIOS disables host PCI device.
Date: Thu, 16 Feb 2012 15:48:53 +0100
Cc: linux-usb@vger.kernel.org, gregkh@linuxfoundation.org,
	Takashi Iwai <tiwai@suse.de>, trenn@suse.de,
	linux-pci@vger.kernel.org, Michal Marek <MMarek@suse.com>,
	Alan Stern <stern@rowland.harvard.edu>,
	Jesse Barnes <jbarnes@virtuousgeek.org>
References: <20120209150823.GA5232@xanatos> <201202161115.48524.oneukum@suse.de> <20120216143321.GA9127@xanatos>
In-Reply-To: <20120216143321.GA9127@xanatos>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Message-Id: <201202161548.53556.oliver@neukum.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Am Donnerstag, 16. Februar 2012, 15:33:21 schrieb Sarah Sharp:
> > The BIOS might touch it. Are you really willing to say that there won't
> > be BIOSes that assume that what they enabled must stay enabled?
> 
> Once the xHCI PCI quirk handler runs, we've taken the host controller
> away from the BIOS with the BIOS/OS semaphore handshake.  (If the BIOS
> is smart enough to actually handle that.)  Any BIOS that touches the
> xHCI host controller after that point is just broken.  There is only so
> much we can do about the BIOS breakage. :)

What about S3 when the BIOS takes control?

	Regards
		Oliver
