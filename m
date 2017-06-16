Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-lf0-f68.google.com ([209.85.215.68]:33105 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752452AbdFPRi7 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 16 Jun 2017 13:38:59 -0400
Date: Fri, 16 Jun 2017 20:39:03 +0300
From: Serge Semin <fancer.lancer@gmail.com>
To: Logan Gunthorpe <logang@deltatee.com>
Cc: Allen Hubbe <Allen.Hubbe@dell.com>, linux-ntb@googlegroups.com,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        'Jon Mason' <jdmason@kudzu.us>,
        'Dave Jiang' <dave.jiang@intel.com>,
        'Bjorn Helgaas' <bhelgaas@google.com>,
        'Greg Kroah-Hartman' <gregkh@linuxfoundation.org>,
        'Kurt Schwemmer' <kurt.schwemmer@microsemi.com>,
        'Stephen Bates' <sbates@raithlin.com>,
        Sergey.Semin@t-platforms.ru
Subject: Re: [RFC PATCH 00/13] Switchtec NTB Support
Message-ID: <20170616173903.GB15472@mobilestation>
References: <20170615203729.9009-1-logang@deltatee.com>
 <000001d2e6a7$dfc719a0$9f554ce0$@dell.com>
 <daa95888-a786-b6d4-5e56-b9ac5b38a181@deltatee.com>
 <000101d2e6b6$0fcc2880$2f647980$@dell.com>
 <6c2b819d-d000-38e2-29ee-d532f92909d2@deltatee.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <6c2b819d-d000-38e2-29ee-d532f92909d2@deltatee.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Jun 16, 2017 at 10:47:21AM -0600, Logan Gunthorpe <logang@deltatee.com> wrote:
> 
> 
> On 16/06/17 09:34 AM, Allen Hubbe wrote:
> > In code review, I really only have found minor nits.  Overall, the driver looks good.
> 
> Great, thanks for such a quick review!
> 
> > In switchtec_ntb_part_op, there is a delay of up to 50s (1000 * 50ms).  This looks like a thread context, so it could involve the scheduler for the delay instead of spinning for up to 50s before bailing.
> 
> Good point. If I were to change this to msleep_interruptible would that
> be acceptable?
> 
> > There are a few instances like this:
> >> +	dev_dbg(&stdev->dev, "%s\n", __func__);
> 
> > Where the printing of __func__ could be controlled by dyndbg=+pf.  The debug message could be more useful.
> 
> Ok, I'll change that.
> 
> > In switchtec_ntb_db_set_mask and friends, an in-memory copy of the mask bits is protected by a spinlock.  Elsewhere, you noted that the db bits are shared between all ports, so the db bitset is chopped up to be shared between the ports.  Is the db mask also shared, and how is the spinlock sufficient for synchronizing access to the mask bits between multiple ports?
> 
> Well, there are 64 doorbells that are shared between ports but each port
> has it's own in and out registers for the doorbells. So triggering
> doorbell one on one port's ODB actually triggers it on every ports IDB.
> So these are shared only in the sense that each port needs to know which
> dbs it cares about. Seeing each port has their own registers they don't
> have to worry about synchronization.
> 

It's exactly the way the IDT hardware works. There is Global doorbell
registers, directly connected to doorbell registers of each port, unless
doorbell routing isn't configured differently by global switch configuration.
Each port has got it's own in and out doorbell registers as well as the
doorbell mask preventing the corresponding doorbell bit from generating
interrupt.

> 
> The mask is only protected by a spin lock seeing multiple callers of
> db_set_mask and db_clr_mask on the same port may step on each others
> toes. So if two processes try to mask different bits they both must get
> masked in the end and therefore some kind of synchronization must be
> involved.
> 
> > The IDT switch also does not have hardware scratchpads.  Could the code you wrote for emulated scratchpads be made into shared library code for ntb drivers?  Also, some ntb clients may not need scratchpad support.  If it is not natively supported by a driver, can the emulated scratchpad support be an optional feature?
> 
> Hmm, interesting idea. A few pieces could possibly be made common but it
> depends mostly on hardware having the resources to make use of it.
> Switchtec has extra LUT memory windows that made this possible. Unless
> you object I'm inclined to leave it as is and I'd be happy to work with
> the IDT folks to create a common solution in the future.
> 
> Logan

Alas there are no IDT folks here. It's only me for now, who was responsible
for NTB API alteration (together with much of help from others NTB guys) and
IDT NTB driver development fitting that API.

Regards,
-Sergey
