Return-Path: <SRS0=GqAx=SG=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E4AFC4360F
	for <linux-pci@archiver.kernel.org>; Thu,  4 Apr 2019 17:44:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1FBBF20855
	for <linux-pci@archiver.kernel.org>; Thu,  4 Apr 2019 17:44:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Lqez6s/Y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728683AbfDDRoe (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 4 Apr 2019 13:44:34 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:41463 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726698AbfDDRnj (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 4 Apr 2019 13:43:39 -0400
Received: by mail-pg1-f195.google.com with SMTP id f6so1579564pgs.8;
        Thu, 04 Apr 2019 10:43:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Rw59mnYBwE31EofwCYWp9fHG8pJWkdccXV+StBpDPoU=;
        b=Lqez6s/YMN02xFVk9qKTLxa93b73yf9hM64lzjxls1ik8P5VXssRCJbAW+CBANPK1D
         fuyukaWIPBDPyji9nOn3OX7a0HIDxgdLYZdh6e69Xbiyw3W9TcjiXPmAcl7Si70zJS2m
         pqhgtICWrnRx/fOVvWSpZBqsC9v6keYsFYvxe4aqCPnervQfnRARknhguPM+yLNm4m9T
         0FFAwL+JTTJpBnb7euz+cBoIoujwm0nPhvHAZDFaIQ9iwr6uCtUThprcGfYCLyw2fvUt
         9w3bCmke+/fwXfmgYmpD7ll6n2eNVrZ7OctLg4QB8v/xLlhx4JWgzbhyZLNa1YnRKaHV
         0jbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=Rw59mnYBwE31EofwCYWp9fHG8pJWkdccXV+StBpDPoU=;
        b=B1ZkI99sfKsNPWXmXOPj7EBY985Dot589QbuVunraBgmd5IQIPTENPr+ompyob6vgJ
         ykrdbir36sDKk/G2YDKitS2kylk4RPm1kgw04s7QS1TcCoDEJX/Eo/zxUDdQhDNuDcja
         +NHcCTgVmLD22KcjTKtQbfMntV9BK+iknO7ki4AwgkBUOAH361YBaRUN7HOMh8xsTj8c
         BDdzPUt1yie7t9kK5GRpMnZXdHlr07KH8Z2A7gCLQ7PSQTwqGXvrTq5qgJBOGIfBI2lN
         B5RoBHV3RWXzRmAnBRW7ab91GnH4EFQKAuWbb/FqGuPtFMq83zqBr6+FuIludACujCxH
         mpvw==
X-Gm-Message-State: APjAAAVfJ3iLP2Y7cjZKzFnOQL4LpPRhpAwiF00hQ33K2qhtDasrKt2v
        yiNTHKCtMkV5UnN71e3+0U4=
X-Google-Smtp-Source: APXvYqz7MwIFyvMSGvcA9434eYuYKMo3uh2ZGK5fwvVxHPwTD0XUCVDbtU5ueCgJr049b2q+L7LpNA==
X-Received: by 2002:aa7:8282:: with SMTP id s2mr7296745pfm.7.1554399819049;
        Thu, 04 Apr 2019 10:43:39 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id m23sm29760901pfa.117.2019.04.04.10.43.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 04 Apr 2019 10:43:38 -0700 (PDT)
Date:   Thu, 4 Apr 2019 10:43:36 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     John Garry <john.garry@huawei.com>
Cc:     bhelgaas@google.com, rafael@kernel.org, arnd@arndb.de,
        lorenzo.pieralisi@arm.com, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, bp@suse.de, wangkefeng.wang@huawei.com,
        linuxarm@huawei.com, andy.shevchenko@gmail.com,
        linux-arm-kernel@lists.infradead.org, catalin.marinas@arm.com,
        will.deacon@arm.com
Subject: Re: [PATCH v3 3/4] lib: logic_pio: Reject accesses to unregistered
 CPU MMIO regions
Message-ID: <20190404174336.GA10404@roeck-us.net>
References: <1554393602-152448-1-git-send-email-john.garry@huawei.com>
 <1554393602-152448-4-git-send-email-john.garry@huawei.com>
 <20190404164130.GA12203@roeck-us.net>
 <24cc8006-0f0d-6b20-a466-e4a32a0bb656@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <24cc8006-0f0d-6b20-a466-e4a32a0bb656@huawei.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Apr 04, 2019 at 05:52:35PM +0100, John Garry wrote:
[ ... ]
> >>
> >>Note that the f71805f driver does not call request_{muxed_}region(), as it
> >>should.
> >>
> 
> Hi Guenter,
> 
> >... which is the real problem, one that is not solved by this patch. This may
> >result in parallel and descructive accesses if there is another device on the
> >LPC bus, and another driver accessing that device. Personally I'd rather have
> >request_muxed_region() added to the f71805f driver.
> 
> Right, we should and will still fix f71805f. If you recall, I did have the
> f71805f fix in the v1 series, but you committed that it was orthogonal, so I
> decided to take it out of this work for now.
> 
> And even if we fix up f71805f and other known drivers which don't call
> request_muxed_region(), we still need to police against these rogue
> accesses, which is what this patch attempts to do.
> 
Do we ? I am personally not convinced that LPC accesses _have_ to occur
through PCI on any given system.

I won't object to this series of patches - not my area. I do mind, though,
if one of the drivers I am responsible for is cited as reason or argument
for this series. I would prefer for those drivers to get fixed.

Guenter
