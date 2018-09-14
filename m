Return-Path: <SRS0=PQBU=L4=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,T_DKIM_INVALID,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 793ECECE560
	for <linux-pci@archiver.kernel.org>; Fri, 14 Sep 2018 20:36:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3369B20881
	for <linux-pci@archiver.kernel.org>; Fri, 14 Sep 2018 20:36:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Ah5MuoBN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3369B20881
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728139AbeIOBvV (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 14 Sep 2018 21:51:21 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:49774 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727716AbeIOBvU (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 14 Sep 2018 21:51:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=VbBHMVEyJI1lGgMge03sxnARe40m8CUxZGs5+O/1YWA=; b=Ah5MuoBNmEA4BLkku0YZio3kn
        DAVGqIPUQWoBI9uhXleLpEL6JkuzH97OKLlZXbNGHdqk5o+SDPGjpWQoJAFfHRttYrzyAPEoAsWg4
        L25NruAhikuc+3fGwc9iwwe/EmHiqL+cXEdpbCSrk/yTN/7bz0FXKPzbA3i0mn+uB6XjA0Ut2v1Lu
        vcYTE3a7uq8oB+aivhjrxeSKr7N7i8F0rR4UlMm2j+8b9R8itFBPrBV0SOwqHJAT0DeDJqekdQ+U3
        o6Q7uecIHrRLCUbVhVQ3c9o5XPYsSI2T89+VEIErp/3qxvoaTtGKNTv1xQDldcGdQCkQ6ROOtQDMJ
        9pBT4saZA==;
Received: from dvhart by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1g0uo1-00073o-GL; Fri, 14 Sep 2018 20:35:09 +0000
Date:   Fri, 14 Sep 2018 13:35:06 -0700
From:   Darren Hart <dvhart@infradead.org>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     viro@zeniv.linux.org.uk, linux-fsdevel@vger.kernel.org,
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
Message-ID: <20180914203506.GE35251@wrath>
References: <20180912150142.157913-1-arnd@arndb.de>
 <20180912151134.436719-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180912151134.436719-1-arnd@arndb.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org
Message-ID: <20180914203506.-ERQETHGg1qisomP10viT0U1LHeDhxzbBPw-O1FE5u0@z>

On Wed, Sep 12, 2018 at 05:08:52PM +0200, Arnd Bergmann wrote:
> The .ioctl and .compat_ioctl file operations have the same prototype so
> they can both point to the same function, which works great almost all
> the time when all the commands are compatible.
> 
> One exception is the s390 architecture, where a compat pointer is only
> 31 bit wide, and converting it into a 64-bit pointer requires calling
> compat_ptr(). Most drivers here will ever run in s390, but since we now
> have a generic helper for it, it's easy enough to use it consistently.
> 
> I double-checked all these drivers to ensure that all ioctl arguments
> are used as pointers or are ignored, but are not interpreted as integer
> values.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
...
>  drivers/platform/x86/wmi.c                  | 2 +-
...
>  static void link_event_work(struct work_struct *work)
> diff --git a/drivers/platform/x86/wmi.c b/drivers/platform/x86/wmi.c
> index 04791ea5d97b..e4d0697e07d6 100644
> --- a/drivers/platform/x86/wmi.c
> +++ b/drivers/platform/x86/wmi.c
> @@ -886,7 +886,7 @@ static const struct file_operations wmi_fops = {
>  	.read		= wmi_char_read,
>  	.open		= wmi_char_open,
>  	.unlocked_ioctl	= wmi_ioctl,
> -	.compat_ioctl	= wmi_ioctl,
> +	.compat_ioctl	= generic_compat_ioctl_ptrarg,
>  };

For platform/drivers/x86:

Acked-by: Darren Hart (VMware) <dvhart@infradead.org>

As for a longer term solution, would it be possible to init fops in such
a way that the compat_ioctl call defaults to generic_compat_ioctl_ptrarg
so we don't have to duplicate this boilerplate for every ioctl fops
structure?

-- 
Darren Hart
VMware Open Source Technology Center
