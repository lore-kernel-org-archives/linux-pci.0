Return-Path: <SRS0=Hy4z=SU=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C164C10F14
	for <linux-pci@archiver.kernel.org>; Thu, 18 Apr 2019 14:42:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 31ECC217FA
	for <linux-pci@archiver.kernel.org>; Thu, 18 Apr 2019 14:42:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nexedi.com header.i=kirr@nexedi.com header.b="E2bPLc6w";
	dkim=pass (1024-bit key) header.d=mandrillapp.com header.i=@mandrillapp.com header.b="Tlt1bTgz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388070AbfDROm1 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 18 Apr 2019 10:42:27 -0400
Received: from mail18.wdc04.mandrillapp.com ([205.201.139.18]:10913 "EHLO
        mail18.wdc04.mandrillapp.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2388392AbfDROmZ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 18 Apr 2019 10:42:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; s=mandrill; d=nexedi.com;
 h=From:Subject:To:Cc:Message-Id:References:In-Reply-To:Date:MIME-Version:Content-Type:Content-Transfer-Encoding; i=kirr@nexedi.com;
 bh=Vja9J+rviwQ640U9SB3zs3yDI0ULoZ4Pnzv2AfWAzFU=;
 b=E2bPLc6wWRSD54LDk3G7PScdDZP89ig5rhDzFzDprNn4LuPJKhYJrYgn0NAGcLpWgLDvuea86zME
   KHhpPDCcNymXuKc6PWu+1e/kjk4MOCEYg/AYBPn6ILxt88+O5Aj/WC2dCxbYBn6LrYnarktBTREK
   Y5sSSmKxrWGPuzERBfY=
Received: from pmta08.mandrill.prod.suw01.rsglab.com (127.0.0.1) by mail18.wdc04.mandrillapp.com id hn26d01jvmg4 for <linux-pci@vger.kernel.org>; Thu, 18 Apr 2019 14:42:22 +0000 (envelope-from <bounce-md_31050260.5cb88cce.v1-b9966977cc1d4277abeb204e22619330@mandrillapp.com>)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mandrillapp.com; 
 i=@mandrillapp.com; q=dns/txt; s=mandrill; t=1555598542; h=From : 
 Subject : To : Cc : Message-Id : References : In-Reply-To : Date : 
 MIME-Version : Content-Type : Content-Transfer-Encoding : From : 
 Subject : Date : X-Mandrill-User : List-Unsubscribe; 
 bh=Vja9J+rviwQ640U9SB3zs3yDI0ULoZ4Pnzv2AfWAzFU=; 
 b=Tlt1bTgzNPHhzQXDYCE1O+1ioNvc+IS+7ZYA6GiXnhHS/pNZEusT0J+jKofl3eTXe0r805
 /rHYWJN7xJ8vqlM6kbZE6z1NsNEZF1zDYXLJ195367y4lv9dqLZYsvfUOSAdk/X9NBvfJBqo
 fkoYUm5lYi6viTvCOmx8MnSGIevnM=
From:   Kirill Smelkov <kirr@nexedi.com>
Subject: Re: [PATCH] pci/switchtec: fix stream_open.cocci warnings (fwd)
Received: from [87.98.221.171] by mandrillapp.com id b9966977cc1d4277abeb204e22619330; Thu, 18 Apr 2019 14:42:22 +0000
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Julia Lawall <julia.lawall@lip6.fr>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        <kbuild-all@01.org>, Kurt Schwemmer <kurt.schwemmer@microsemi.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Message-Id: <20190418144215.GA25178@deco.navytux.spb.ru>
References: <alpine.DEB.2.21.1904131849350.2536@hadrien> <20190417215420.GV126710@google.com> <alpine.DEB.2.21.1904180728420.8144@hadrien> <20190418103755.GA14294@deco.navytux.spb.ru> <20190418123730.GX126710@google.com>
In-Reply-To: <20190418123730.GX126710@google.com>
X-Report-Abuse: Please forward a copy of this message, including all headers, to abuse@mandrill.com
X-Report-Abuse: You can also report abuse here: http://mandrillapp.com/contact/abuse?id=31050260.b9966977cc1d4277abeb204e22619330
X-Mandrill-User: md_31050260
Date:   Thu, 18 Apr 2019 14:42:22 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Apr 18, 2019 at 07:37:30AM -0500, Bjorn Helgaas wrote:
> On Thu, Apr 18, 2019 at 10:38:02AM +0000, Kirill Smelkov wrote:
> > On Thu, Apr 18, 2019 at 07:31:02AM +0200, Julia Lawall wrote:
> > > On Wed, 17 Apr 2019, Bjorn Helgaas wrote:
> > > > On Sat, Apr 13, 2019 at 06:50:57PM +0200, Julia Lawall wrote:
> > > > > Hello,
> > > > >
> > > > > Kirill will explain about this issue.
> > > > >
> > > > > julia
> > > > >
> > > > > ---------- Forwarded message ----------
> > > > > Date: Sat, 13 Apr 2019 11:22:51 +0800
> > > > > From: kbuild test robot <lkp@intel.com>
> > > > > To: kbuild@01.org
> > > > > Cc: Julia Lawall <julia.lawall@lip6.fr>
> > > > > Subject: [PATCH] pci/switchtec: fix stream_open.cocci warnings
> > > > >
> > > > > CC: kbuild-all@01.org
> > > > > TO: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> > > > > CC: Kurt Schwemmer <kurt.schwemmer@microsemi.com>
> > > > > CC: Logan Gunthorpe <logang@deltatee.com>
> > > > > CC: Bjorn Helgaas <helgaas@kernel.org>
> > > > > CC: linux-pci@vger.kernel.org
> > > > > CC: linux-kernel@vger.kernel.org
> > > > >
> > > > > From: kbuild test robot <lkp@intel.com>
> > > > >
> > > > > drivers/pci/switch/switchtec.c:395:1-17: ERROR: switchtec_fops: .read() can deadlock .write(); change nonseekable_open -> stream_open to fix.
> > > > >
> > > > > Generated by: scripts/coccinelle/api/stream_open.cocci
> > > > >
> > > > > Fixes: 8a29a3bae2a2 ("pci/switchtec: Don't use completion's wait queue")
> > > > > Signed-off-by: kbuild test robot <lkp@intel.com>
> > > >
> > > > Based on Kirill's subsequent email saying this is already queued to
> > > > the merge window, I assume I need to do nothing here.
> > > >
> > > > I think a signed-off-by from a robot, i.e., not from a real person, is
> > > > meaningless, and I don't think I would personally accept it.  It's
> > > > certainly OK to indicate that a patch was auto-generated, but I think
> > > > a real person still needs to take responsibility for it.
> > > >
> > > > Documentation/process/submitting-patches.rst says it must contain a
> > > > real name (no pseudonyms or anonymous contributions), and I don't
> > > > think a robot fits in the spirit of that.
> > > >
> > > > I see that
> > > > https://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-rt-devel.git/commit/?id=8a29a3bae2a2
> > > > (mentioned below) does have a good signed-off-by from Sebastian, but
> > > > that's not *this* patch, so I don't know what's what.
> > > 
> > > Normally, for these robot generated patches, when I approve them, I put my
> > > own sign off, but under the robot one, since the robot has put a From
> > > line.  In this case, I handed the problem off to Kirill, so I didn't do
> > > that.  I agree that it would be good for Kirill to sign off on it.
> > 
> > Just for the reference: I have put my signature on the mass converstion
> > patch as well as ack's that were received:
> > 
> > https://lab.nexedi.com/kirr/linux/commit/edaeb4101860
> 
> Looks good, thanks.  Feel free to add my
> 
>   Acked-by: Bjorn Helgaas <bhelgaas@google.com> [drivers/pci/switch/switchtec]
> 
> to the https://lab.nexedi.com/kirr/linux/commit/edaeb4101860 patch.
> 
> It looks like maybe the commit log could use
> 
>   s/and the reset were/and the rest were/

Bjorn, thanks for feedback. I've added your ack and fixed that typo.

> It also mentions "the previous patch" a couple times, which may lose
> some of its meaning depending on how things get merged into git.  If
> that previous patch has already been merged, a SHA1 reference would be
> more specific.

Good point. Initially those patches were coming together, but the
first one landed to master while the conversion is only scheduled to be
done. I've changed this reference to 10dce8af3422 ("fs: stream_open -
opener for stream-like files so that read and write can run
simultaneously without deadlock").

> I would personally split that into two patches: one to avoid the
> potential deadlocks and a second to do the "safe to change to
> stream_open" changes.  It seems like the first is more serious and
> urgent while the second is more of a cleanup.  Then you could
> streamline the commit logs by including a single diagnostic and
> omitting the entire list of files.

I was contemplating how to split this too. And one of the way was to go
with separate patch for every subsystem. However I still hope to do the
mass conversion all at one conversion, because otherwise it would be
many patches and it will take my time to propagate them all / ping
maintainers etc.  About splitting deadlock / just safe:
stream_open.cocci does not have complete coverage for detecting whether
a .read() blocks, and as pci/switchtec case shows there are indeed other
cases that might be deadlocking but are not currently detected as such.
I would thus prefer not to split the conversion.

I've added the following note to the patch:

    and the rest were just safe to convert to stream_open because their read and
    write do not use ppos at all and corresponding file_operations do not
    have methods that assume @offset file access(*):

    <long list>

    ...

    (*) This second group also contains cases with read/write deadlocks that
    stream_open.cocci don't yet detect, but which are still valid to convert to
    stream_open since ppos is not used. For example drivers/pci/switch/switchtec.c
    calls wait_for_completion_interruptible() in its .read, but stream_open.cocci
    currently detects only "wait_event*" as blocking.

hope it is ok.

> But that's all bike-shedding and I'm totally fine with this as-is.

Thanks. Your input was useful. The updated patch is here:

https://lab.nexedi.com/kirr/linux/commit/a34a8a9cb2d7

as well as related patches to tighten stream_open semantic and
corresponding FUSE bits:

https://lab.nexedi.com/kirr/linux/commit/47ee8df337a9
https://lab.nexedi.com/kirr/linux/commit/1b4636172835

Kirill
