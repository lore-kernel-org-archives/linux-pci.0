Return-Path: <SRS0=ZQeV=OV=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B980C67839
	for <linux-pci@archiver.kernel.org>; Wed, 12 Dec 2018 23:57:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 365B220835
	for <linux-pci@archiver.kernel.org>; Wed, 12 Dec 2018 23:57:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kudzu-us.20150623.gappssmtp.com header.i=@kudzu-us.20150623.gappssmtp.com header.b="XWJry75D"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 365B220835
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kudzu.us
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726790AbeLLX5e (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 12 Dec 2018 18:57:34 -0500
Received: from mail-io1-f67.google.com ([209.85.166.67]:33326 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726278AbeLLX5e (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 12 Dec 2018 18:57:34 -0500
Received: by mail-io1-f67.google.com with SMTP id t24so212125ioi.0
        for <linux-pci@vger.kernel.org>; Wed, 12 Dec 2018 15:57:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kudzu-us.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DSObcjHaK4sHxqigYcCt9BycM8y1WzOo4LLf84PPirw=;
        b=XWJry75DcdVgls8MHcOr54pbpvRqX2LmkjqqDy3GEmpRoM7utd+msU3Gj+OuozMzxG
         6oxDlgDhP/J9IAAZsrG5XHAh+BWlUgYBAUIb2dzcTthszirnLohighZHM15v2xrQLavH
         MX+YIl0e0LiSNzWB21TmNcq9ik83sQUiv1upa0Pyi3zEVVtRC20umwWGjbchgfOYr76h
         G/obelxW+Qx6ivxy56dbLDqIZRMeRtqi1ONkgeYTkMpyp5pv6id7IxaTFoCQjqSjWS8Y
         cjpBEpj39b5y9+pI7PtFsfQz7y/mx+rs4GArBDNk/aTye21avGgF9/ZxzVoCo8C4qeqm
         eQRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DSObcjHaK4sHxqigYcCt9BycM8y1WzOo4LLf84PPirw=;
        b=WJYXpq2OxAJycoAfDRotr7CwRWFhqDk1hFNuBCKq1WkjTGmvlG6+iy1rD1dj/pxSlr
         1bMVvppzuiISQJl5AzwzKNB8N+oFOuS3l4cU+tTkC83dXpuqNvTKyDDadOl0LQawxVO/
         LKt6q3daKBlT//Qw1DvE3QktoPBsmLsC734LjKT664CSu2ITeBel1ZiRLc6Ggmhql2zT
         wsTasTC0Mtqmfxrtfd0Tya7H+6mIjlG3NRC0DR5H3LMBy99Cr7wl5Pme48oVR8TlJFS5
         JK8JxySdZ/SxY1Y8PgPkyy4fsg0y2xfSvIKAB7ua/n7EuPoekv2z3VU0veSw8UaL2Q4E
         nEAA==
X-Gm-Message-State: AA+aEWaz+EQh/kzGPneFuLfv6RqOCFfGiKLdOUEpNcPuQn460HIhX+Ho
        U6ywATK6x7XxFrBkGkPG1AvT5s5S3cUKBETtj3Ba2Q==
X-Google-Smtp-Source: AFSGD/XFcP01DdFPAuB+wWxf9u3vlLm18jVbluTVrciyM0o0GbCMP/0lTPSVdGHYsmx9wRXIoGNqnP0ftM/uj5lEmuo=
X-Received: by 2002:a5e:d501:: with SMTP id e1mr20856742iom.291.1544659052843;
 Wed, 12 Dec 2018 15:57:32 -0800 (PST)
MIME-Version: 1.0
References: <1544103052-28191-1-git-send-email-wesley.sheng@microchip.com>
 <CAPoiz9yN9zHXxyuwmopfSwBLGr39bQ1SJjGq_ku-w_b9V13OFQ@mail.gmail.com> <f22b6112-920b-37f1-68fe-f43164a18f05@deltatee.com>
In-Reply-To: <f22b6112-920b-37f1-68fe-f43164a18f05@deltatee.com>
From:   Jon Mason <jdmason@kudzu.us>
Date:   Wed, 12 Dec 2018 18:57:21 -0500
Message-ID: <CAPoiz9xesBdtgVg1UGF8LuD28tjMp6VpVuHVjdwcWJq93Phi3w@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] ntb_hw_switchtec: Added support of >=4G memory windows
To:     Logan Gunthorpe <logang@deltatee.com>
Cc:     wesley.sheng@microchip.com,
        Kurt Schwemmer <kurt.schwemmer@microsemi.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Allen Hubbe <allenbh@gmail.com>, linux-pci@vger.kernel.org,
        linux-ntb@googlegroups.com,
        linux-kernel <linux-kernel@vger.kernel.org>,
        wesleyshenggit@sina.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Dec 12, 2018 at 6:42 PM Logan Gunthorpe <logang@deltatee.com> wrote:
>
>
>
> On 2018-12-12 4:00 p.m., Jon Mason wrote:
> > So, you based your patches on a series of patches not in the
> > ntb/ntb-next branch?  Please don't do this.  I see nothing in these
> > patches which requires that series, which makes this even more
> > unnecessary.  Since these are fairly trivial, I'm taking them and
> > pushing to the ntb-next branch to give these more time to be tested
> > (due to not being tested on the proper branch).  I would really
> > appreciate you testing the ntb-next branch as a sanity check.
>
> The NTB test tools don't work with switchtec hardware without that patch
> set, so there's no way to test the changes without that branch.

Then let's get those patches in.  IIRC, I asked you to split up the
patch series to be bugfixes and features (or at least reorder the
series so I can split it up that way in my branches).  Also, I think
Serge had some comments that may/may not need to be addressed.  Could
you please reorder and resend (and Serge can comment as needed on the
resend)?

Thanks,
Jon


>
> You're right that there is no compile-time dependency.
>
> Logan
>
> --
> You received this message because you are subscribed to the Google Groups "linux-ntb" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to linux-ntb+unsubscribe@googlegroups.com.
> To post to this group, send email to linux-ntb@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/linux-ntb/f22b6112-920b-37f1-68fe-f43164a18f05%40deltatee.com.
> For more options, visit https://groups.google.com/d/optout.
