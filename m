Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from zoneX.GCU-Squad.org ([194.213.125.0]:36651 "EHLO
	services.gcu-squad.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751927Ab3FBIQ0 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Sun, 2 Jun 2013 04:16:26 -0400
Date: Sun, 2 Jun 2013 10:16:08 +0200
From: Jean Delvare <khali@linux-fr.org>
To: Tejun Heo <tj@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Shane Huang <shane.huang@amd.com>,
	linux-i2c <linux-i2c@vger.kernel.org>, linux-pci@vger.kernel.org,
	linux-ide@vger.kernel.org
Subject: Re: [PATCH v2 3/3] i2c-piix4: add AMD CZ SMBus device ID
Message-ID: <20130602101608.37cd1661@endymion.delvare>
In-Reply-To: <20130602080232.GC8286@mtj.dyndns.org>
References: <1369987950-2894-1-git-send-email-shane.huang@amd.com>
	<20130531081623.GB17241@mtj.dyndns.org>
	<CAErSpo4A_tuhsyErPOae5QgBdnUFK4f9kMitH0xUSnV6mYWYrA@mail.gmail.com>
	<20130602080232.GC8286@mtj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Sun, 2 Jun 2013 01:02:32 -0700, Tejun Heo wrote:
> On Fri, May 31, 2013 at 01:24:57PM -0600, Bjorn Helgaas wrote:
> > On Fri, May 31, 2013 at 2:16 AM, Tejun Heo <tj@kernel.org> wrote:
> > > On Fri, May 31, 2013 at 04:12:30PM +0800, Shane Huang wrote:
> > >> To add AMD CZ SMBus controller device ID.
> > >>
> > >> Signed-off-by: Shane Huang <shane.huang@amd.com>
> > >
> > > All three patches look good to me.
> > >
> > >  Reviewed-by: Tejun Heo <tj@kernel.org>
> > >
> > > Both 2 and 3 are dependent on the first patch, so it probably would be
> > > a good idea to route them together (probably w/ stable cc'd).  Who
> > > wants these?  Bjorn?
> > 
> > The pci_ids.h change is fine with me.  I don't care how they're
> > routed.  If you want me to pick them up, maybe Shane could collect up
> > the acks & reviewed-bys and add the appropriate stable tags and resend
> > the series to me.
> 
> Yeah, let's go through Bjorn's tree and preferably with stable cc'd
> and targeted for for-3.10-rcX.  Shane?

Fine with me.

-- 
Jean Delvare
