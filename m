Return-Path: <SRS0=Hy4z=SU=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 802EAC282DD
	for <linux-pci@archiver.kernel.org>; Thu, 18 Apr 2019 10:53:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 52010217D7
	for <linux-pci@archiver.kernel.org>; Thu, 18 Apr 2019 10:53:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nexedi.com header.i=kirr@nexedi.com header.b="h2wL38Wj";
	dkim=pass (1024-bit key) header.d=mandrillapp.com header.i=@mandrillapp.com header.b="covDdKVM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728074AbfDRKxG (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 18 Apr 2019 06:53:06 -0400
Received: from mail18.wdc04.mandrillapp.com ([205.201.139.18]:3074 "EHLO
        mail18.wdc04.mandrillapp.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1733049AbfDRKxG (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 18 Apr 2019 06:53:06 -0400
X-Greylist: delayed 901 seconds by postgrey-1.27 at vger.kernel.org; Thu, 18 Apr 2019 06:53:03 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; s=mandrill; d=nexedi.com;
 h=From:Subject:To:Cc:Message-Id:References:In-Reply-To:Date:MIME-Version:Content-Type:Content-Transfer-Encoding; i=kirr@nexedi.com;
 bh=s2hRcSwFUvQsNR/yGPxb1QZbHGTF/4YJ2/Jzco8Y2IU=;
 b=h2wL38Wj/vbTbVnKs7SNDJhgetoe/PD2/axicqFX8M8//i/utI4wpT9TQZkjgoXeGJJy8vl4Pnx/
   Fzgrm8VxWD9f6AWunwayiVOc3YKd++nvBZO/iQzgifD/lKPc4lV67crLtlpvjNmmhAP4GhkNWExt
   smFC8bZweviNe6H5JCU=
Received: from pmta08.mandrill.prod.suw01.rsglab.com (127.0.0.1) by mail18.wdc04.mandrillapp.com id hn1bh21jvmgk for <linux-pci@vger.kernel.org>; Thu, 18 Apr 2019 10:38:02 +0000 (envelope-from <bounce-md_31050260.5cb8538a.v1-e50f7faae52143f88afb262b8c6b77da@mandrillapp.com>)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mandrillapp.com; 
 i=@mandrillapp.com; q=dns/txt; s=mandrill; t=1555583882; h=From : 
 Subject : To : Cc : Message-Id : References : In-Reply-To : Date : 
 MIME-Version : Content-Type : Content-Transfer-Encoding : From : 
 Subject : Date : X-Mandrill-User : List-Unsubscribe; 
 bh=s2hRcSwFUvQsNR/yGPxb1QZbHGTF/4YJ2/Jzco8Y2IU=; 
 b=covDdKVM5fbeH1FhZlGk6sJNeQS6OLg1YV2hbO0CFA6xNJPBj72nwT0yqY4ym/ySmZSuxY
 UQsvf893OIwTqB1BjjVPmUawoBcuS0vqIZFBaykOHWCuH3UVfh9P9HjpWxfG2NMFsnhme2l1
 Zcr7u2r8ZLIAoVHgQks+nHXPKjV68=
From:   Kirill Smelkov <kirr@nexedi.com>
Subject: Re: [PATCH] pci/switchtec: fix stream_open.cocci warnings (fwd)
Received: from [87.98.221.171] by mandrillapp.com id e50f7faae52143f88afb262b8c6b77da; Thu, 18 Apr 2019 10:38:02 +0000
To:     Julia Lawall <julia.lawall@lip6.fr>
Cc:     Bjorn Helgaas <helgaas@kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        <kbuild-all@01.org>, Kurt Schwemmer <kurt.schwemmer@microsemi.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Message-Id: <20190418103755.GA14294@deco.navytux.spb.ru>
References: <alpine.DEB.2.21.1904131849350.2536@hadrien> <20190417215420.GV126710@google.com> <alpine.DEB.2.21.1904180728420.8144@hadrien>
In-Reply-To: <alpine.DEB.2.21.1904180728420.8144@hadrien>
X-Report-Abuse: Please forward a copy of this message, including all headers, to abuse@mandrill.com
X-Report-Abuse: You can also report abuse here: http://mandrillapp.com/contact/abuse?id=31050260.e50f7faae52143f88afb262b8c6b77da
X-Mandrill-User: md_31050260
Date:   Thu, 18 Apr 2019 10:38:02 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Apr 18, 2019 at 07:31:02AM +0200, Julia Lawall wrote:
> 
> 
> On Wed, 17 Apr 2019, Bjorn Helgaas wrote:
> 
> > On Sat, Apr 13, 2019 at 06:50:57PM +0200, Julia Lawall wrote:
> > > Hello,
> > >
> > > Kirill will explain about this issue.
> > >
> > > julia
> > >
> > > ---------- Forwarded message ----------
> > > Date: Sat, 13 Apr 2019 11:22:51 +0800
> > > From: kbuild test robot <lkp@intel.com>
> > > To: kbuild@01.org
> > > Cc: Julia Lawall <julia.lawall@lip6.fr>
> > > Subject: [PATCH] pci/switchtec: fix stream_open.cocci warnings
> > >
> > > CC: kbuild-all@01.org
> > > TO: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> > > CC: Kurt Schwemmer <kurt.schwemmer@microsemi.com>
> > > CC: Logan Gunthorpe <logang@deltatee.com>
> > > CC: Bjorn Helgaas <helgaas@kernel.org>
> > > CC: linux-pci@vger.kernel.org
> > > CC: linux-kernel@vger.kernel.org
> > >
> > > From: kbuild test robot <lkp@intel.com>
> > >
> > > drivers/pci/switch/switchtec.c:395:1-17: ERROR: switchtec_fops: .read() can deadlock .write(); change nonseekable_open -> stream_open to fix.
> > >
> > > Generated by: scripts/coccinelle/api/stream_open.cocci
> > >
> > > Fixes: 8a29a3bae2a2 ("pci/switchtec: Don't use completion's wait queue")
> > > Signed-off-by: kbuild test robot <lkp@intel.com>
> >
> > Based on Kirill's subsequent email saying this is already queued to
> > the merge window, I assume I need to do nothing here.
> >
> > I think a signed-off-by from a robot, i.e., not from a real person, is
> > meaningless, and I don't think I would personally accept it.  It's
> > certainly OK to indicate that a patch was auto-generated, but I think
> > a real person still needs to take responsibility for it.
> >
> > Documentation/process/submitting-patches.rst says it must contain a
> > real name (no pseudonyms or anonymous contributions), and I don't
> > think a robot fits in the spirit of that.
> >
> > I see that
> > https://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-rt-devel.git/commit/?id=8a29a3bae2a2
> > (mentioned below) does have a good signed-off-by from Sebastian, but
> > that's not *this* patch, so I don't know what's what.
> 
> Normally, for these robot generated patches, when I approve them, I put my
> own sign off, but under the robot one, since the robot has put a From
> line.  In this case, I handed the problem off to Kirill, so I didn't do
> that.  I agree that it would be good for Kirill to sign off on it.

Just for the reference: I have put my signature on the mass converstion
patch as well as ack's that were received:

https://lab.nexedi.com/kirr/linux/commit/edaeb4101860

I plan to refresh that patch and post it to mainline when merge-window opens.

Appologize if I missed something. I'm not a kernel developer and don't
have much know-how in this land.

Kirill


> > > ---
> > >
> > > tree:   https://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-rt-devel.git linux-5.0.y-rt-rebase
> > > head:   794c294ae4483c240429c25a0d18e272e92c94de
> > > commit: 8a29a3bae2a2dfb0116cd8791d9700515d6e765e [154/311] pci/switchtec: Don't use completion's wait queue
> > > :::::: branch date: 7 hours ago
> > > :::::: commit date: 7 hours ago
> > >
> > > Please take the patch only if it's a positive warning. Thanks!
> > >
> > >  switchtec.c |    2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> > > --- a/drivers/pci/switch/switchtec.c
> > > +++ b/drivers/pci/switch/switchtec.c
> > > @@ -392,7 +392,7 @@ static int switchtec_dev_open(struct ino
> > >  		return PTR_ERR(stuser);
> > >
> > >  	filp->private_data = stuser;
> > > -	nonseekable_open(inode, filp);
> > > +	stream_open(inode, filp);
> > >
> > >  	dev_dbg(&stdev->dev, "%s: %p\n", __func__, stuser);
