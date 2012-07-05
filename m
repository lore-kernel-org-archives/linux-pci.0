Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([193.178.161.156]:55188 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755539Ab2GEVzR (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Thu, 5 Jul 2012 17:55:17 -0400
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH] PCI: Quirk for ASUS S3 issue
Date: Fri, 6 Jul 2012 00:00:51 +0200
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	AceLan Kao <acelan.kao@canonical.com>,
	linux-pci@vger.kernel.org,
	" =?utf-8?q?=E6=B4=AA?=(Alex)=?utf-8?q?=E8=8C=82=E8=80=95?="
	<alex.hung@canonical.com>
References: <Pine.LNX.4.44L0.1207051727430.13212-100000@netrider.rowland.org>
In-Reply-To: <Pine.LNX.4.44L0.1207051727430.13212-100000@netrider.rowland.org>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Message-Id: <201207060000.51762.rjw@sisk.pl>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thursday, July 05, 2012, Alan Stern wrote:
> On Thu, 5 Jul 2012, Bjorn Helgaas wrote:
> 
> > I wish we knew more about what's really going on here.  I looked
> > through the bug reports AceLan dug up, and I don't get the feeling
> > that anybody really has a grand unified theory about why Windows works
> > but Linux doesn't.  But I'm willing to apply one of these patches if
> > you and/or Alan sign off on it.
> 
> His description seems to make sense, even if it may not be complete.
>   
> Windows sets the COMMAND register to 0 before suspending, so it doesn't
> trigger the BIOS bus.  Linux doesn't, so the BIOS tries to quiesce the
> EHCI controller.  This involves doing various MMIO accesses, which of
> course don't work if the controller is already in D3.
> 
> For obvious reasons, I'm in favor of my two-line change over AceLan's
> new PCI quirk.  So far there have been positive responses from a few 
> volunteers testing the patch.

The two-liner is good enough, I think, and tested.  We can always add a quirk
based on it in the future.

Thanks,
Rafael
