Return-Path: <SRS0=NdPK=RR=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34399C10F06
	for <linux-pci@archiver.kernel.org>; Thu, 14 Mar 2019 17:44:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0747E21855
	for <linux-pci@archiver.kernel.org>; Thu, 14 Mar 2019 17:44:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XLkdA9tI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726753AbfCNRoM (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 14 Mar 2019 13:44:12 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:35655 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726485AbfCNRoM (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 14 Mar 2019 13:44:12 -0400
Received: by mail-pg1-f194.google.com with SMTP id e17so4488582pgd.2;
        Thu, 14 Mar 2019 10:44:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=tYaxDGNFMUwYFraly5vXvXUYH0YyBkMh/ttyQ26pSI0=;
        b=XLkdA9tI7UZhk7oZYgWl0NipavHBwTyVMNuRWAJI4a0BHy+JhLwYhlRdk59n4QHlso
         w8yHxQ4Pp7wkOY95e9xIb+rXWquHzD0W//aDG96JdjHnw4EBoaillInrlmJJfGTBqJ3m
         XgNFTJEp7NJFLwoFrs7cNyXXoKKbMZF/TAPOcLUtJrM/1y8+wr9msUqsbpUFmr1SbKvL
         htVMG9uQM+kx8yVQv+p0LrM56QjHw34al2NdnjkxKfK8TSxKzn18KHtmnXdTtyq0rfVy
         wV/sTcd8VsrDoU7G4d6Wqli/JregAsK1CArw6Ghnao37FFRqJEcWYW8UCV8vfUaPXm4c
         RNIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=tYaxDGNFMUwYFraly5vXvXUYH0YyBkMh/ttyQ26pSI0=;
        b=fbAoYyAELbuHxZCX/v2uDkrppLrpoWVPkyDbgSluFaYYRnYqeKoGDuV3tqGwxPGvBu
         30Ck9Cb/GW/Gi7Pb9ZVgNTYG8BhhUd3MsuGhy00dSrOZzx9XYqxsMjI4unuVfxtKfBro
         haV4t4Pi6EvbEfe5QWAETBe3jet2f0I7Zurkf4SI7MmfUEX5bZcC181sKjJK+aKHDiNK
         zwE885FB4+hiW9CFaMUaIqObGaeTUoKGsQopbAlTj4fx2lO+ncVUDN+EcUhwuzm4Atu9
         Whpg4o/D2zqxDxXLo9/uV48bOHJTbNyu6xk1Uwsu/3m7elEC/SoiKSETrgwFw7Y5UXVn
         19JA==
X-Gm-Message-State: APjAAAWHHG9oWqjgeKtMPVPfZRBWtxUOc/9B0tvalEeL9mWMAR0mkgeK
        Cx8w8GxNGrTw/MAQMcvT8nM=
X-Google-Smtp-Source: APXvYqyBlgsw1+sWp1NwLU4/09HZjeKFYXJfYyzu81cveHz8GTXr7oTL7U7D2UKGmKuhptd808k3tQ==
X-Received: by 2002:a63:fd07:: with SMTP id d7mr45875465pgh.199.1552585451062;
        Thu, 14 Mar 2019 10:44:11 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id g2sm28399314pfm.144.2019.03.14.10.44.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 14 Mar 2019 10:44:09 -0700 (PDT)
Date:   Thu, 14 Mar 2019 10:44:08 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     John Garry <john.garry@huawei.com>
Cc:     jdelvare@suse.com, bhelgaas@google.com, rafael@kernel.org,
        arnd@arndb.de, lorenzo.pieralisi@arm.com, bp@suse.de,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, wangkefeng.wang@huawei.com,
        linuxarm@huawei.com
Subject: Re: [RFC PATCH 2/2] hwmon: (f71805f): Use request_region() in
 f71805f_init()
Message-ID: <20190314174408.GD14159@roeck-us.net>
References: <1552582516-70855-1-git-send-email-john.garry@huawei.com>
 <1552582516-70855-3-git-send-email-john.garry@huawei.com>
 <20190314170534.GB14159@roeck-us.net>
 <db84d2d3-cb16-7633-afeb-913096c86e8d@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <db84d2d3-cb16-7633-afeb-913096c86e8d@huawei.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Mar 14, 2019 at 05:21:32PM +0000, John Garry wrote:
> On 14/03/2019 17:05, Guenter Roeck wrote:
> >On Fri, Mar 15, 2019 at 12:55:16AM +0800, John Garry wrote:
> >>Currently the driver does not call request_region() prior to
> >>accessing IO port regions in f71805f_init(), so add it.
> >>
> >>Signed-off-by: John Garry <john.garry@huawei.com>
> >>---
> >> drivers/hwmon/f71805f.c | 13 ++++++++++++-
> >> 1 file changed, 12 insertions(+), 1 deletion(-)
> >>
> >>diff --git a/drivers/hwmon/f71805f.c b/drivers/hwmon/f71805f.c
> >>index 73c681162653..910082c7f184 100644
> >>--- a/drivers/hwmon/f71805f.c
> >>+++ b/drivers/hwmon/f71805f.c
> >>@@ -1617,10 +1617,21 @@ static int __init f71805f_init(void)
> >> 	int err;
> >> 	unsigned short address;
> >> 	struct f71805f_sio_data sio_data;
> >>+	struct resource *res;
> >>+	size_t size = 0x4e - 0x2e + SIO_REG_ADDR + 4;
> >>+
> >>+	/* Request the whole 0x2e - 0x4e region */
> >>+	res = request_region(0x2e, size, "f71805f");
> >
> 
> Hi Guenter,
> 
> >request_muxed_region() would be a better choice here since it doesn't
> >bail out immediately if the region is temporarily busy.
> 
> Are you saying that this region could be busy due to another driver
> accessing this same region (probably for the same purpose)?
> 
Depends on the definition of "same reason". To access the chip's
Super-IO configuration registers, yes, that can happen. I don't
see it used in the kernel today, but examples would be someone
adding support for the chips supported by this driver to gpio-f7188x,
or adding support for the F71872 watchdog to the f71808e_wdt driver.

Guenter
