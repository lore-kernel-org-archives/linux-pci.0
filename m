Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from esa4.dell-outbound.iphmx.com ([68.232.149.214]:55043 "EHLO
        esa4.dell-outbound.iphmx.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750827AbdFPSJT (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 16 Jun 2017 14:09:19 -0400
From: "Allen Hubbe" <Allen.Hubbe@dell.com>
To: "'Logan Gunthorpe'" <logang@deltatee.com>,
        <linux-ntb@googlegroups.com>, <linux-pci@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Cc: "'Jon Mason'" <jdmason@kudzu.us>,
        "'Dave Jiang'" <dave.jiang@intel.com>,
        "'Bjorn Helgaas'" <bhelgaas@google.com>,
        "'Greg Kroah-Hartman'" <gregkh@linuxfoundation.org>,
        "'Kurt Schwemmer'" <kurt.schwemmer@microsemi.com>,
        "'Stephen Bates'" <sbates@raithlin.com>,
        "'Serge Semin'" <fancer.lancer@gmail.com>,
        <Sergey.Semin@t-platforms.ru>
References: <20170615203729.9009-1-logang@deltatee.com> <000001d2e6a7$dfc719a0$9f554ce0$@dell.com> <daa95888-a786-b6d4-5e56-b9ac5b38a181@deltatee.com> <000101d2e6b6$0fcc2880$2f647980$@dell.com> <6c2b819d-d000-38e2-29ee-d532f92909d2@deltatee.com>
In-Reply-To: <6c2b819d-d000-38e2-29ee-d532f92909d2@deltatee.com>
Subject: RE: [RFC PATCH 00/13] Switchtec NTB Support
Date: Fri, 16 Jun 2017 14:08:52 -0400
Message-ID: <000201d2e6cb$9f4f4e50$ddedeaf0$@dell.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Logan Gunthorpe
> On 16/06/17 09:34 AM, Allen Hubbe wrote:
> > In code review, I really only have found minor nits.  Overall, the =
driver looks good.
>=20
> Great, thanks for such a quick review!
>=20
> > In switchtec_ntb_part_op, there is a delay of up to 50s (1000 * =
50ms).  This looks like a thread
> context, so it could involve the scheduler for the delay instead of =
spinning for up to 50s before
> bailing.
>=20
> Good point. If I were to change this to msleep_interruptible would =
that
> be acceptable?

I would be satisfied.

>=20
> > There are a few instances like this:
> >> +	dev_dbg(&stdev->dev, "%s\n", __func__);
>=20
> > Where the printing of __func__ could be controlled by dyndbg=3D+pf.  =
The debug message could be more
> useful.
>=20
> Ok, I'll change that.
>=20
> > In switchtec_ntb_db_set_mask and friends, an in-memory copy of the =
mask bits is protected by a
> spinlock.  Elsewhere, you noted that the db bits are shared between =
all ports, so the db bitset is
> chopped up to be shared between the ports.  Is the db mask also =
shared, and how is the spinlock
> sufficient for synchronizing access to the mask bits between multiple =
ports?
>=20
> Well, there are 64 doorbells that are shared between ports but each =
port
> has it's own in and out registers for the doorbells. So triggering
> doorbell one on one port's ODB actually triggers it on every ports =
IDB.
> So these are shared only in the sense that each port needs to know =
which
> dbs it cares about. Seeing each port has their own registers they =
don't
> have to worry about synchronization.
>=20
> The mask is only protected by a spin lock seeing multiple callers of
> db_set_mask and db_clr_mask on the same port may step on each others
> toes. So if two processes try to mask different bits they both must =
get
> masked in the end and therefore some kind of synchronization must be
> involved.

Thanks for clearing that up.  Now I understand, each port has its own =
independent set of mask bits.  So, while the doorbell numbers are =
assigned globally, the registers themselves are per port.  For the mask =
bits, the mask behavior only affects the local port.

>=20
> > The IDT switch also does not have hardware scratchpads.  Could the =
code you wrote for emulated
> scratchpads be made into shared library code for ntb drivers?  Also, =
some ntb clients may not need
> scratchpad support.  If it is not natively supported by a driver, can =
the emulated scratchpad support
> be an optional feature?
>=20
> Hmm, interesting idea. A few pieces could possibly be made common but =
it
> depends mostly on hardware having the resources to make use of it.
> Switchtec has extra LUT memory windows that made this possible. Unless
> you object I'm inclined to leave it as is and I'd be happy to work =
with
> the IDT folks to create a common solution in the future.

Alright.  I'll leave it to you to find and reconcile common =
functionalities of the drivers.  What about making spad emulation =
optional?

>=20
> Logan

There was a comment on irc.oftc.net #ntb wishing for patch v2 to be =
fewer patches.  Something like, 1/2: prep the existing switch driver, =
2/2: introduce the ntb driver.
