Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from smtp-out003.kontent.com ([81.88.40.217]:33228 "EHLO
	smtp-out003.kontent.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751268Ab2BIIyC (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 9 Feb 2012 03:54:02 -0500
From: Oliver Neukum <oliver@neukum.org>
To: Sarah Sharp <sarah.a.sharp@linux.intel.com>
Subject: Re: [RFC] xhci: Fix BIOS handoff failure on some Intel systems.
Date: Thu, 9 Feb 2012 09:56:22 +0100
Cc: linux-usb@vger.kernel.org, gregkh@linuxfoundation.org,
	Takashi Iwai <tiwai@suse.de>, trenn@suse.de,
	linux-pci@vger.kernel.org, Michal Marek <MMarek@suse.com>,
	Alan Stern <stern@rowland.harvard.edu>
References: <20120207233118.GA6947@xanatos> <201202081611.37097.oneukum@suse.de> <20120208214851.GA2669@xanatos>
In-Reply-To: <20120208214851.GA2669@xanatos>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Message-Id: <201202090956.22456.oliver@neukum.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Am Mittwoch, 8. Februar 2012, 22:48:51 schrieb Sarah Sharp:
> > > Can you test and make sure this fixes the issue on your test systems?
> > 
> > I've tested it and it works. Are you sure it is safe to enable a PCI device
> > at that point? If so, your patch is better than mine.
> 
> Jesse Barnes told me it's fine over IRC, so I'm just going to send this
> off, with your Tested-by line.

Very well, but then consequently you should do it for all HCIs.

	Regards
		Oliver

