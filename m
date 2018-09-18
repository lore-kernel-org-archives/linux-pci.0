Return-Path: <SRS0=7uyK=MA=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F1E0C433F4
	for <linux-pci@archiver.kernel.org>; Tue, 18 Sep 2018 17:51:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD46120C0E
	for <linux-pci@archiver.kernel.org>; Tue, 18 Sep 2018 17:51:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="O3Vk1jaP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CD46120C0E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730395AbeIRXYz (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 18 Sep 2018 19:24:55 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:55438 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730164AbeIRXYz (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 18 Sep 2018 19:24:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=PHUQ07ed9xp9jvUdHqj2DKxydAvJWFf2ooCl5h8dLB4=; b=O3Vk1jaPDFAWqLgRRpy0dLhRa
        kepWYVppxUQRTLI895nv6s1tUDjyAvLQB9rJqCX3S32kGZff4O47CkEUK6DZNfR75ifEH+RHYu5ED
        juSKcjAjVvI4uS67YSWC+6+2zIpWRQHpF33A1ZVjqKHmbd1O+eXyBWS/RauK4McZuMJKvYiSnhHgU
        wVlhy2DWzUVDzfBssOpv+rUDAP9cUO7HZOP2E/DGA1RG7REyCAzerXbnSc0lEDI4gNpB+xFJZxPvQ
        FvQAYVClDlXu2BYOUW0zz4fF9VIf0U4cdjEMhWBs6XJw3dQDWKw4YxGjTiRTnqFd/8/rN9AXBxR+z
        ueePCM/Mg==;
Received: from dvhart by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1g2K9V-0000Ga-EJ; Tue, 18 Sep 2018 17:51:09 +0000
Date:   Tue, 18 Sep 2018 10:51:08 -0700
From:   Darren Hart <dvhart@infradead.org>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Arnd Bergmann <arnd@arndb.de>, linux-fsdevel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "David S. Miller" <davem@davemloft.net>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        qat-linux@intel.com, linux-crypto@vger.kernel.org,
        linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linaro-mm-sig@lists.linaro.org, amd-gfx@lists.freedesktop.org,
        linux-input@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-rdma@vger.kernel.org, linux-nvdimm@lists.01.org,
        linux-nvme@lists.infradead.org, linux-pci@vger.kernel.org,
        platform-driver-x86@vger.kernel.org,
        linux-remoteproc@vger.kernel.org, sparclinux@vger.kernel.org,
        linux-scsi@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-fbdev@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-btrfs@vger.kernel.org, ceph-devel@vger.kernel.org,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH v2 05/17] compat_ioctl: move more drivers to
 generic_compat_ioctl_ptrarg
Message-ID: <20180918175108.GF35251@wrath>
References: <20180912150142.157913-1-arnd@arndb.de>
 <20180912151134.436719-1-arnd@arndb.de>
 <20180914203506.GE35251@wrath>
 <20180914205748.GC19965@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180914205748.GC19965@ZenIV.linux.org.uk>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org
Message-ID: <20180918175108.JBSBHOHQ4nlA2fCXqS2ZJ-mFtpXlNAKy1E_hpGnoPQk@z>

On Fri, Sep 14, 2018 at 09:57:48PM +0100, Al Viro wrote:
> On Fri, Sep 14, 2018 at 01:35:06PM -0700, Darren Hart wrote:
>  
> > Acked-by: Darren Hart (VMware) <dvhart@infradead.org>
> > 
> > As for a longer term solution, would it be possible to init fops in such
> > a way that the compat_ioctl call defaults to generic_compat_ioctl_ptrarg
> > so we don't have to duplicate this boilerplate for every ioctl fops
> > structure?
> 
> 	Bad idea, that...  Because several years down the road somebody will add
> an ioctl that takes an unsigned int for argument.  Without so much as looking
> at your magical mystery macro being used to initialize file_operations.

Fair, being explicit in the declaration as it is currently may be
preferable then.

-- 
Darren Hart
VMware Open Source Technology Center
