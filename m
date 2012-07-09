Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:51094 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752203Ab2GIQrZ (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 9 Jul 2012 12:47:25 -0400
Received: by pbbrp8 with SMTP id rp8so19493854pbb.19
        for <linux-pci@vger.kernel.org>; Mon, 09 Jul 2012 09:47:24 -0700 (PDT)
Date: Mon, 9 Jul 2012 09:47:20 -0700
From: Greg KH <gregkh@linuxfoundation.org>
To: "Rafael J. Wysocki" <rjw@sisk.pl>,
	Alan Stern <stern@rowland.harvard.edu>,
	Bjorn Helgaas <bhelgaas@google.com>,
	AceLan Kao <acelan.kao@canonical.com>,
	=?iso-8859-1?Q?D=E2niel?= Fraga <fragabr@gmail.com>,
	Javier Marcet <jmarcet@gmail.com>,
	Andrey Rahmatullin <wrar@wrar.name>,
	Oleksij Rempel <bug-track@fisher-privat.net>,
	Pavel Pisa <pisa@cmp.felk.cvut.cz>, linux-pci@vger.kernel.org,
	USB list <linux-usb@vger.kernel.org>
Subject: Re: [PATCH] PCI: EHCI: fix crash during suspend on ASUS computers
Message-ID: <20120709164720.GA15994@kroah.com>
References: <Pine.LNX.4.44L0.1207091106430.1954-100000@iolanthe.rowland.org>
 <201207091850.24550.rjw@sisk.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <201207091850.24550.rjw@sisk.pl>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Jul 09, 2012 at 06:50:24PM +0200, Rafael J. Wysocki wrote:
> On Monday, July 09, 2012, Alan Stern wrote:
> > Quite a few ASUS computers experience a nasty problem, related to the
> > EHCI controllers, when going into system suspend.  It was observed
> > that the problem didn't occur if the controllers were not put into the
> > D3 power state before starting the suspend, and commit
> > 151b61284776be2d6f02d48c23c3625678960b97 (USB: EHCI: fix crash during
> > suspend on ASUS computers) was created to do this.
> > 
> > It turned out this approach messed up other computers that didn't have
> > the problem -- it prevented USB wakeup from working.  Consequently
> > commit c2fb8a3fa25513de8fedb38509b1f15a5bbee47b (USB: add
> > NO_D3_DURING_SLEEP flag and revert 151b61284776be2) was merged; it
> > reverted the earlier commit and added a whitelist of known good board
> > names.
> > 
> > Now we know the actual cause of the problem.  Thanks to AceLan Kao for
> > tracking it down.
> > 
> > According to him, an engineer at ASUS explained that some of their
> > BIOSes contain a bug that was added in an attempt to work around a
> > problem in early versions of Windows.  When the computer goes into S3
> > suspend, the BIOS tries to verify that the EHCI controllers were first
> > quiesced by the OS.  Nothing's wrong with this, but the BIOS does it
> > by checking that the PCI COMMAND registers contain 0 without checking
> > the controllers' power state.  If the register isn't 0, the BIOS
> > assumes the controller needs to be quiesced and tries to do so.  This
> > involves making various MMIO accesses to the controller, which don't
> > work very well if the controller is already in D3.  The end result is
> > a system hang or memory corruption.
> > 
> > Since the value in the PCI COMMAND register doesn't matter once the
> > controller has been suspended, and since the value will be restored
> > anyway when the controller is resumed, we can work around the BIOS bug
> > simply by setting the register to 0 during system suspend.  This patch
> > (as1590) does so and also reverts the second commit mentioned above,
> > which is now unnecessary.
> > 
> > In theory we could do this for every PCI device.  However to avoid
> > introducing new problems, the patch restricts itself to EHCI host
> > controllers.
> > 
> > Finally the affected systems can suspend with USB wakeup working
> > properly.
> > 
> > Signed-off-by: Alan Stern <stern@rowland.harvard.edu>
> > Tested-by: Dâniel Fraga <fragabr@gmail.com>
> > Tested-by: Javier Marcet <jmarcet@gmail.com>
> > Tested-by: Andrey Rahmatullin <wrar@wrar.name>
> > Tested-by: Oleksij Rempel <bug-track@fisher-privat.net>
> > Tested-by: Pavel Pisa <pisa@cmp.felk.cvut.cz>
> > CC: <stable@vger.kernel.org>
> 
> Acked-by: Rafael J. Wysocki <rjw@sisk.pl>


Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

