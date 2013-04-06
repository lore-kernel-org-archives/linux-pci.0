Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:55129 "EHLO
	bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755608Ab3DFIos (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Sat, 6 Apr 2013 04:44:48 -0400
Message-ID: <1365237884.2787.2.camel@dabdike>
Subject: Re: [PATCH 3/3] PCI, scsi, ahci: Unify usages of 0x1b4b vendor ID
 to use PCI_VENDOR_ID_MARVELL_EXT
From: James Bottomley <James.Bottomley@HansenPartnership.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Myron Stowe <myron.stowe@redhat.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
	linux-ide@vger.kernel.org, Jeff Garzik <jgarzik@pobox.com>
Date: Sat, 06 Apr 2013 09:44:44 +0100
In-Reply-To: <CAErSpo77UWR3u+DfdaOW0hG6FXQv+ADsb24bjKQ3fJOR5SFBZg@mail.gmail.com>
References: <20130321043449.7229.81056.stgit@amt.stowe>
	 <20130321043509.7229.93525.stgit@amt.stowe>
	 <CAErSpo77UWR3u+DfdaOW0hG6FXQv+ADsb24bjKQ3fJOR5SFBZg@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-15"
Mime-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, 2013-04-04 at 12:23 -0600, Bjorn Helgaas wrote:
> On Wed, Mar 20, 2013 at 10:35 PM, Myron Stowe <myron.stowe@redhat.com> wrote:
> > With the 0x1b4b vendor ID #define in place, convert hard-coded ID values.
> > Also, unify the previous SCSI specific use of this vendor ID to the new
> > macro.
> >
> > Signed-off-by: Myron Stowe <myron.stowe@redhat.com>
> > ---
> >
> >  drivers/ata/ahci.c           |   10 +++++-----
> >  drivers/scsi/mvsas/mv_init.c |    6 +++---
> >  drivers/scsi/mvumi.c         |    4 ++--
> >  drivers/scsi/mvumi.h         |    1 -
> >  4 files changed, 10 insertions(+), 11 deletions(-)
> 
> Jeff & James, if you don't object to these, I can push them through my
> PCI tree along with the corresponding pci_ids.h addition.

Fine by me.  You can add my acked by if you need it.

James


