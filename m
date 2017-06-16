Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from ale.deltatee.com ([207.54.116.67]:33626 "EHLO ale.deltatee.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750798AbdFPQrl (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 16 Jun 2017 12:47:41 -0400
To: Allen Hubbe <Allen.Hubbe@dell.com>, linux-ntb@googlegroups.com,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20170615203729.9009-1-logang@deltatee.com>
 <000001d2e6a7$dfc719a0$9f554ce0$@dell.com>
 <daa95888-a786-b6d4-5e56-b9ac5b38a181@deltatee.com>
 <000101d2e6b6$0fcc2880$2f647980$@dell.com>
Cc: 'Jon Mason' <jdmason@kudzu.us>,
        'Dave Jiang' <dave.jiang@intel.com>,
        'Bjorn Helgaas' <bhelgaas@google.com>,
        'Greg Kroah-Hartman' <gregkh@linuxfoundation.org>,
        'Kurt Schwemmer' <kurt.schwemmer@microsemi.com>,
        'Stephen Bates' <sbates@raithlin.com>,
        'Serge Semin' <fancer.lancer@gmail.com>,
        Sergey.Semin@t-platforms.ru
From: Logan Gunthorpe <logang@deltatee.com>
Message-ID: <6c2b819d-d000-38e2-29ee-d532f92909d2@deltatee.com>
Date: Fri, 16 Jun 2017 10:47:21 -0600
MIME-Version: 1.0
In-Reply-To: <000101d2e6b6$0fcc2880$2f647980$@dell.com>
Content-Type: text/plain; charset=utf-8
Subject: Re: [RFC PATCH 00/13] Switchtec NTB Support
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>



On 16/06/17 09:34 AM, Allen Hubbe wrote:
> In code review, I really only have found minor nits.  Overall, the driver looks good.

Great, thanks for such a quick review!

> In switchtec_ntb_part_op, there is a delay of up to 50s (1000 * 50ms).  This looks like a thread context, so it could involve the scheduler for the delay instead of spinning for up to 50s before bailing.

Good point. If I were to change this to msleep_interruptible would that
be acceptable?

> There are a few instances like this:
>> +	dev_dbg(&stdev->dev, "%s\n", __func__);

> Where the printing of __func__ could be controlled by dyndbg=+pf.  The debug message could be more useful.

Ok, I'll change that.

> In switchtec_ntb_db_set_mask and friends, an in-memory copy of the mask bits is protected by a spinlock.  Elsewhere, you noted that the db bits are shared between all ports, so the db bitset is chopped up to be shared between the ports.  Is the db mask also shared, and how is the spinlock sufficient for synchronizing access to the mask bits between multiple ports?

Well, there are 64 doorbells that are shared between ports but each port
has it's own in and out registers for the doorbells. So triggering
doorbell one on one port's ODB actually triggers it on every ports IDB.
So these are shared only in the sense that each port needs to know which
dbs it cares about. Seeing each port has their own registers they don't
have to worry about synchronization.

The mask is only protected by a spin lock seeing multiple callers of
db_set_mask and db_clr_mask on the same port may step on each others
toes. So if two processes try to mask different bits they both must get
masked in the end and therefore some kind of synchronization must be
involved.

> The IDT switch also does not have hardware scratchpads.  Could the code you wrote for emulated scratchpads be made into shared library code for ntb drivers?  Also, some ntb clients may not need scratchpad support.  If it is not natively supported by a driver, can the emulated scratchpad support be an optional feature?

Hmm, interesting idea. A few pieces could possibly be made common but it
depends mostly on hardware having the resources to make use of it.
Switchtec has extra LUT memory windows that made this possible. Unless
you object I'm inclined to leave it as is and I'd be happy to work with
the IDT folks to create a common solution in the future.

Logan
