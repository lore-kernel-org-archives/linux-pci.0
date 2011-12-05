Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from iolanthe.rowland.org ([192.131.102.54]:36962 "HELO
	iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S932372Ab1LEUdk (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 5 Dec 2011 15:33:40 -0500
Date: Mon, 5 Dec 2011 15:33:39 -0500 (EST)
From: Alan Stern <stern@rowland.harvard.edu>
To: Jesse Barnes <jbarnes@virtuousgeek.org>
cc: linux-pci@vger.kernel.org
Subject: Re: Xorg intel server not finding the graphics device
In-Reply-To: <20111205113021.7841a4b2@jbarnes-desktop>
Message-ID: <Pine.LNX.4.44L0.1112051444570.5138-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, 5 Dec 2011, Jesse Barnes wrote:

> Hm, afaik the 865G should still work, maybe Fedora blacklisted the
> kernel support for it in newer bits?  If so, you'll need to use the
> vesa driver instead of the intel driver...

Never mind, I found the problem.  For some reason the Fedora installer 
added "nomodeset" to GRUB's kernel command line, and that prevented the 
intel driver from registering with the DRM infrastructure.  I changed 
it to "video=VGA-1:640x480" and now X is working.

Alan Stern

