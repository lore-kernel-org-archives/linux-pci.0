Return-Path: <linux-kernel-owner@vger.kernel.org>
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
References: <20170615203729.9009-1-logang@deltatee.com> <000001d2e6a7$dfc719a0$9f554ce0$@dell.com> <daa95888-a786-b6d4-5e56-b9ac5b38a181@deltatee.com>
In-Reply-To: <daa95888-a786-b6d4-5e56-b9ac5b38a181@deltatee.com>
Subject: RE: [RFC PATCH 00/13] Switchtec NTB Support
Date: Fri, 16 Jun 2017 11:34:34 -0400
Message-ID: <000101d2e6b6$0fcc2880$2f647980$@dell.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="utf-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Logan Gunthorpe
> On 16/06/17 07:53 AM, Allen Hubbe wrote:
> > See what is staged in https://github.com/jonmason/ntb.git ntb-next, =
with the addition of multi-peer
> support by Serge.  It would be good at this stage to understand =
whether the api changes there would
> also support the Switchtec driver, and what if anything must change, =
or be planned to change, to
> support the Switchtec driver.
>=20
> Ah, yes I had seen that patchset some time ago but I wasn't aware of
> it's status or that it was queued up in ntb-next. I think it will be =
no
> problem to reconcile with the switchtec driver and I'll rebase onto
> ntb-next for the next posting of the patch set. However, I *may* save
> full multi-host switchtec support for a follow up submission. My =
initial
> impression is the new API will support the switchtec hardware well.

Alright!

In code review, I really only have found minor nits.  Overall, the =
driver looks good.

In switchtec_ntb_part_op, there is a delay of up to 50s (1000 * 50ms).  =
This looks like a thread context, so it could involve the scheduler for =
the delay instead of spinning for up to 50s before bailing.

There are a few instances like this:
> +	dev_dbg(&stdev->dev, "%s\n", __func__);

Where the printing of __func__ could be controlled by dyndbg=3D+pf.  The =
debug message could be more useful.

In switchtec_ntb_db_set_mask and friends, an in-memory copy of the mask =
bits is protected by a spinlock.  Elsewhere, you noted that the db bits =
are shared between all ports, so the db bitset is chopped up to be =
shared between the ports.  Is the db mask also shared, and how is the =
spinlock sufficient for synchronizing access to the mask bits between =
multiple ports?

The IDT switch also does not have hardware scratchpads.  Could the code =
you wrote for emulated scratchpads be made into shared library code for =
ntb drivers?  Also, some ntb clients may not need scratchpad support.  =
If it is not natively supported by a driver, can the emulated scratchpad =
support be an optional feature?

>=20
> Thanks,
>=20
> Logan
