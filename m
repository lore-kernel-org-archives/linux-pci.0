Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from netrider.rowland.org ([192.131.102.5]:39497 "HELO
	netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1754114Ab2GEVdO (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 5 Jul 2012 17:33:14 -0400
Date: Thu, 5 Jul 2012 17:33:14 -0400 (EDT)
From: Alan Stern <stern@rowland.harvard.edu>
To: Bjorn Helgaas <bhelgaas@google.com>
cc: "Rafael J. Wysocki" <rjw@sisk.pl>,
	AceLan Kao <acelan.kao@canonical.com>,
	<linux-pci@vger.kernel.org>,
	=?UTF-8?B?5rSqKEFsZXgp6IyC6ICV?= <alex.hung@canonical.com>
Subject: Re: [PATCH] PCI: Quirk for ASUS S3 issue
In-Reply-To: <CAErSpo7OWHzfzLAKXpb4gRwCC+R0U6QrwAu8v97NA9phVTw5PA@mail.gmail.com>
Message-ID: <Pine.LNX.4.44L0.1207051727430.13212-100000@netrider.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, 5 Jul 2012, Bjorn Helgaas wrote:

> I wish we knew more about what's really going on here.  I looked
> through the bug reports AceLan dug up, and I don't get the feeling
> that anybody really has a grand unified theory about why Windows works
> but Linux doesn't.  But I'm willing to apply one of these patches if
> you and/or Alan sign off on it.

His description seems to make sense, even if it may not be complete.
  
Windows sets the COMMAND register to 0 before suspending, so it doesn't
trigger the BIOS bus.  Linux doesn't, so the BIOS tries to quiesce the
EHCI controller.  This involves doing various MMIO accesses, which of
course don't work if the controller is already in D3.

For obvious reasons, I'm in favor of my two-line change over AceLan's
new PCI quirk.  So far there have been positive responses from a few 
volunteers testing the patch.

Alan Stern

