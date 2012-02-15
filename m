Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:37546 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757625Ab2BOIpj (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Wed, 15 Feb 2012 03:45:39 -0500
From: Oliver Neukum <oneukum@suse.de>
To: Sarah Sharp <sarah.a.sharp@linux.intel.com>
Subject: Re: [RFC v2] USB: Fix handoff when BIOS disables host PCI device.
Date: Wed, 15 Feb 2012 09:48:07 +0100
Cc: linux-usb@vger.kernel.org, gregkh@linuxfoundation.org,
	Takashi Iwai <tiwai@suse.de>, trenn@suse.de,
	linux-pci@vger.kernel.org, Michal Marek <MMarek@suse.com>,
	Alan Stern <stern@rowland.harvard.edu>,
	Jesse Barnes <jbarnes@virtuousgeek.org>
References: <20120209150823.GA5232@xanatos> <20120209201354.GA6709@xanatos> <20120214203311.GA8485@xanatos>
In-Reply-To: <20120214203311.GA8485@xanatos>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Message-Id: <201202150948.07115.oneukum@suse.de>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Am Dienstag, 14. Februar 2012, 21:33:11 schrieb Sarah Sharp:
> Hi Oliver,
> 
> Have you gotten a chance to test this patch on your test system?  I'd
> like to get it out, but I want to make sure it fixes your problem.

Did I forget to answer? Anyway, yes it works. However it seems a bad idea
to me to unconditionally disable the device, on second thought.

	Regards
		Oliver
