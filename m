Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:54772 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752691AbcAZWQR (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Tue, 26 Jan 2016 17:16:17 -0500
Date: Tue, 26 Jan 2016 16:16:14 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Jean Delvare <jdelvare@suse.de>
Cc: Borislav Petkov <bp@suse.de>, linux-pci@vger.kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>, john.ronciak@intel.com,
	tony.luck@intel.com, Thomas Renninger <trenn@suse.de>
Subject: Re: [PATCH] PCI: aer_inject: Log actual error causes
Message-ID: <20160126221614.GB26726@localhost>
References: <20160126095205.0e5923bd@endymion.delvare>
 <20160126101244.GB8475@pd.tnic>
 <1453811238.4772.124.camel@chaos.site>
 <20160126124901.GE8475@pd.tnic>
 <1453813554.4772.131.camel@chaos.site>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <1453813554.4772.131.camel@chaos.site>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Jan 26, 2016 at 02:05:54PM +0100, Jean Delvare wrote:
> Le Tuesday 26 January 2016 à 13:49 +0100, Borislav Petkov a écrit :
> > On Tue, Jan 26, 2016 at 01:27:18PM +0100, Jean Delvare wrote:
> > > But I'd say -EPERM is hardly better. The problem with -ENODEV is that it
> > > is already returned by this function for several other error causes.
> > > Also the aer-inject user-space tool will print the error message from
> > > the error code, and I don't think "No such device" is helpful in that
> > > case. What about -ENOTSUPP ("Operation not supported") or
> > > -EEPROTONOSUPPORT ("Protocol not supported")?
> > 
> > Makes sense.
> > 
> > > I can change it if nobody objects. I think the change can be included in
> > > this patch as it is quite related.
> > 
> > I'd do a separate patch but this is only my opinion. I guess that's
> > Bjorn's call.
> 
> I am almost always advocating for separate patches, but here it seemed
> like hairsplitting so I wasn't sure. I'm fine both ways really.

I'd prefer one patch to change the errno (only) and another to add the
printk logging.

I definitely prefer dev_* whenever possible.  The aer_inject user
knows the relevant device at the time, but dev_* makes the dmesg log
more useful later.

In fact, your patch only adds logging to some error paths.  I'd like
to have some indication in dmesg that aer_inject was used at all.
Maybe even a synopsis of the injected error, though maybe that's too
much if aer_inject is used in an automated way.  It would just be nice
to have a dmesg indication that subsequent AER events *might* be
injected rather than real errors.

Bjorn
