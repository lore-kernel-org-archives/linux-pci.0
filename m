Return-Path: <SRS0=v2Vw=SP=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F36DBC10F11
	for <linux-pci@archiver.kernel.org>; Sat, 13 Apr 2019 17:24:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C19222054F
	for <linux-pci@archiver.kernel.org>; Sat, 13 Apr 2019 17:24:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nexedi.com header.i=kirr@nexedi.com header.b="hb+JmiKv";
	dkim=pass (1024-bit key) header.d=mandrillapp.com header.i=@mandrillapp.com header.b="WZEzwXqE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727580AbfDMRY6 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Sat, 13 Apr 2019 13:24:58 -0400
Received: from mail18.wdc04.mandrillapp.com ([205.201.139.18]:4245 "EHLO
        mail18.wdc04.mandrillapp.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728634AbfDMRYw (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 13 Apr 2019 13:24:52 -0400
X-Greylist: delayed 907 seconds by postgrey-1.27 at vger.kernel.org; Sat, 13 Apr 2019 13:24:51 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; s=mandrill; d=nexedi.com;
 h=From:Subject:To:Cc:Message-Id:References:In-Reply-To:Date:MIME-Version:Content-Type:Content-Transfer-Encoding; i=kirr@nexedi.com;
 bh=xGZrTYz6TLSvmvz29N6wq5H2asSjQwMgO6zBIVD6hNM=;
 b=hb+JmiKv5KZdNWZL94U4wAxILt/fTaM377m4sX9X3b7bW+xc4OsCwQoIZR7AnlTr9bUPLu81PbWt
   ZHqCypByVv/jN8iYCNh8WnMDWFVv2VSKL+oQxg8FwzfiDqjNqU/SkCfC2tR35lIVfPvDl09EmXce
   /hIdClUvlBNLNQqK3Ak=
Received: from pmta08.mandrill.prod.suw01.rsglab.com (127.0.0.1) by mail18.wdc04.mandrillapp.com id hm8dm61jvmgp for <linux-pci@vger.kernel.org>; Sat, 13 Apr 2019 17:01:00 +0000 (envelope-from <bounce-md_31050260.5cb215cc.v1-05bb9d3adb964dc7bea46112a3e30aad@mandrillapp.com>)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mandrillapp.com; 
 i=@mandrillapp.com; q=dns/txt; s=mandrill; t=1555174860; h=From : 
 Subject : To : Cc : Message-Id : References : In-Reply-To : Date : 
 MIME-Version : Content-Type : Content-Transfer-Encoding : From : 
 Subject : Date : X-Mandrill-User : List-Unsubscribe; 
 bh=xGZrTYz6TLSvmvz29N6wq5H2asSjQwMgO6zBIVD6hNM=; 
 b=WZEzwXqESmNCNoApFpwdNIxnRggE7oCWhQ9r3vxSLQisGqUWjOT55s5diX2Ylq6wNacauP
 oINZ2dMCMLMy8movoHD0Ms4uOG0wWZG2viwsvAaHHI/Wo+K1mVW9+pErI1i6jDE5nTslQ73k
 G+URIkvDVPa7/jc7ytyx1SEoqwj3E=
From:   Kirill Smelkov <kirr@nexedi.com>
Subject: Re: [PATCH] pci/switchtec: fix stream_open.cocci warnings (fwd)
Received: from [87.98.221.171] by mandrillapp.com id 05bb9d3adb964dc7bea46112a3e30aad; Sat, 13 Apr 2019 17:01:00 +0000
To:     Julia Lawall <julia.lawall@lip6.fr>
Cc:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        <kbuild-all@01.org>, Kurt Schwemmer <kurt.schwemmer@microsemi.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Bjorn Helgaas <helgaas@kernel.org>,
        <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Message-Id: <20190413170056.GA11293@deco.navytux.spb.ru>
References: <alpine.DEB.2.21.1904131849350.2536@hadrien>
In-Reply-To: <alpine.DEB.2.21.1904131849350.2536@hadrien>
X-Report-Abuse: Please forward a copy of this message, including all headers, to abuse@mandrill.com
X-Report-Abuse: You can also report abuse here: http://mandrillapp.com/contact/abuse?id=31050260.05bb9d3adb964dc7bea46112a3e30aad
X-Mandrill-User: md_31050260
Date:   Sat, 13 Apr 2019 17:01:00 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hello everyone,

On Sat, Apr 13, 2019 at 06:50:57PM +0200, Julia Lawall wrote:
> Hello,
> 
> Kirill will explain about this issue.

pci/switchtec switching to stream_open is already queued to merge
window and it was acked by Logan Gunthorpe:

        https://lore.kernel.org/lkml/CAHk-=wgqgN5j1ZWnyVLqqoyU=CCWTYOko3MDyU8L_5e21KvHAg@mail.gmail.com/
        https://lab.nexedi.com/kirr/linux/commit/edaeb4101860

( there are too many Cc's in that patch and email with it and reply-all to
  it did not get into mailing list probably due to being considered as spam )

stream_open.cocci was issuing only warning for pci/switchtec, but after
8a29a3bae2a2 ("pci/switchtec: Don't use completion's wait queue") they
started to use wait_even_* inside read method and, since
stream_open.cocci considers wait_event_* as blocking the warning became
error. Previously it was completions there, but I added support for wait
events only for simplicity.

I can handle pci/switchtec switching via big nonseekable_open ->
stream_open change at next merge window, or, alternatively please feel
free to switch pci/switchtec now on its own. The change is correct - I
was manually reviewing all changes that stream_open.cocci produces and
pci/switchtec was there.

Kirill

> julia
> 
> ---------- Forwarded message ----------
> Date: Sat, 13 Apr 2019 11:22:51 +0800
> From: kbuild test robot <lkp@intel.com>
> To: kbuild@01.org
> Cc: Julia Lawall <julia.lawall@lip6.fr>
> Subject: [PATCH] pci/switchtec: fix stream_open.cocci warnings
> 
> CC: kbuild-all@01.org
> TO: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> CC: Kurt Schwemmer <kurt.schwemmer@microsemi.com>
> CC: Logan Gunthorpe <logang@deltatee.com>
> CC: Bjorn Helgaas <helgaas@kernel.org>
> CC: linux-pci@vger.kernel.org
> CC: linux-kernel@vger.kernel.org
> 
> From: kbuild test robot <lkp@intel.com>
> 
> drivers/pci/switch/switchtec.c:395:1-17: ERROR: switchtec_fops: .read() can deadlock .write(); change nonseekable_open -> stream_open to fix.
> 
> Generated by: scripts/coccinelle/api/stream_open.cocci
> 
> Fixes: 8a29a3bae2a2 ("pci/switchtec: Don't use completion's wait queue")
> Signed-off-by: kbuild test robot <lkp@intel.com>
> ---
> 
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-rt-devel.git linux-5.0.y-rt-rebase
> head:   794c294ae4483c240429c25a0d18e272e92c94de
> commit: 8a29a3bae2a2dfb0116cd8791d9700515d6e765e [154/311] pci/switchtec: Don't use completion's wait queue
> :::::: branch date: 7 hours ago
> :::::: commit date: 7 hours ago
> 
> Please take the patch only if it's a positive warning. Thanks!
> 
>  switchtec.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> --- a/drivers/pci/switch/switchtec.c
> +++ b/drivers/pci/switch/switchtec.c
> @@ -392,7 +392,7 @@ static int switchtec_dev_open(struct ino
>  		return PTR_ERR(stuser);
> 
>  	filp->private_data = stuser;
> -	nonseekable_open(inode, filp);
> +	stream_open(inode, filp);
> 
>  	dev_dbg(&stdev->dev, "%s: %p\n", __func__, stuser);
