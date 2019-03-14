Return-Path: <SRS0=NdPK=RR=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60EB1C43381
	for <linux-pci@archiver.kernel.org>; Thu, 14 Mar 2019 17:05:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D57C21855
	for <linux-pci@archiver.kernel.org>; Thu, 14 Mar 2019 17:05:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X0Xf8zoD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726699AbfCNRFi (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 14 Mar 2019 13:05:38 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:35521 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725992AbfCNRFi (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 14 Mar 2019 13:05:38 -0400
Received: by mail-pf1-f195.google.com with SMTP id j5so4277716pfa.2;
        Thu, 14 Mar 2019 10:05:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=PbRwO4bTo46IUBcANVEXyYvr4JJT9mh+sEJE9ITj3xc=;
        b=X0Xf8zoD9wAOlgjd4II2gRWCdetyfOckBfQE6vMZahGWW4F48E2D/YrCse5PuCUgys
         U0Q810JTLcVmF2mtrDmnbTN5or2AIU1Hq4OANLwuhr9m3y+NRshAb8gpYc2C71hfXpaE
         367oGOs2j7pvA5Hmhh3RoRkw0xBkvlVz742FAamSuoePprvQzHsBsSn6DeGQTOGz4lCX
         Gbxekdg6Vb+I4cav9beRCneBayQqCMmPhdm6/jhuT8wffxrO/RJruoRM46LdOoP+ZYuS
         G6LMFdv/Pq4JCJ+CdHKtiCrJWpBHTW6rqFSYYhuXDpSv6FwPgq02CE3CLvmgAcHDS9cw
         zjUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=PbRwO4bTo46IUBcANVEXyYvr4JJT9mh+sEJE9ITj3xc=;
        b=oVVwNGMcr0XuT6VnP+adns++LHBI0FEjCxFn4vkh0qYTsOXD+ew0ckThR20GYVKsqk
         xVMyEW3yruL+qWhTCAtzchA032nxMW2l5IyCK2cxg1RdtJVQ1KESXPrJ4TN9LDElJwrq
         lO3g1VkdzAoBYXD+Bg9a0UVvILXTpED1DQgBygoLjkNV2Wdib8rln4O053wpiKAARlZf
         dJYdfRu7A+I3In409CBG0FkIfu+fLPtBvuO3al8hBlEjmSVTWuU6OOWG8CRgJp4eUQTj
         kBRxQgt8/4b72o9vrvhjCpLhvCL+u7lHX2EXLk2ytXF+z8vNH8EIRJ7ApEqv6Y9UAEia
         6SHA==
X-Gm-Message-State: APjAAAXWfFo8OdjIeyL74m6TdybWgm7KFODXrLdO7eVYM3FjHodDEez0
        3QVC3btHugL9YaF4dl4WyCxUkuhe
X-Google-Smtp-Source: APXvYqzcsXHeJnk6CamJjkFG5oHz6TxyKz84oe8rFqM7hWa/ReOwaxU46jCNigWnR5xJDkCSAkxxWQ==
X-Received: by 2002:a17:902:2e01:: with SMTP id q1mr5909887plb.253.1552583136770;
        Thu, 14 Mar 2019 10:05:36 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id l2sm20668782pgj.64.2019.03.14.10.05.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 14 Mar 2019 10:05:35 -0700 (PDT)
Date:   Thu, 14 Mar 2019 10:05:34 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     John Garry <john.garry@huawei.com>
Cc:     jdelvare@suse.com, bhelgaas@google.com, rafael@kernel.org,
        arnd@arndb.de, lorenzo.pieralisi@arm.com, bp@suse.de,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, wangkefeng.wang@huawei.com,
        linuxarm@huawei.com
Subject: Re: [RFC PATCH 2/2] hwmon: (f71805f): Use request_region() in
 f71805f_init()
Message-ID: <20190314170534.GB14159@roeck-us.net>
References: <1552582516-70855-1-git-send-email-john.garry@huawei.com>
 <1552582516-70855-3-git-send-email-john.garry@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1552582516-70855-3-git-send-email-john.garry@huawei.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Mar 15, 2019 at 12:55:16AM +0800, John Garry wrote:
> Currently the driver does not call request_region() prior to
> accessing IO port regions in f71805f_init(), so add it.
> 
> Signed-off-by: John Garry <john.garry@huawei.com>
> ---
>  drivers/hwmon/f71805f.c | 13 ++++++++++++-
>  1 file changed, 12 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/hwmon/f71805f.c b/drivers/hwmon/f71805f.c
> index 73c681162653..910082c7f184 100644
> --- a/drivers/hwmon/f71805f.c
> +++ b/drivers/hwmon/f71805f.c
> @@ -1617,10 +1617,21 @@ static int __init f71805f_init(void)
>  	int err;
>  	unsigned short address;
>  	struct f71805f_sio_data sio_data;
> +	struct resource *res;
> +	size_t size = 0x4e - 0x2e + SIO_REG_ADDR + 4;
> +
> +	/* Request the whole 0x2e - 0x4e region */
> +	res = request_region(0x2e, size, "f71805f");

request_muxed_region() would be a better choice here since it doesn't
bail out immediately if the region is temporarily busy.

Thanks,
Guenter

> +	if (!res)
> +		return -EBUSY;
>  
>  	if (f71805f_find(0x2e, &address, &sio_data)
> -	 && f71805f_find(0x4e, &address, &sio_data))
> +	 && f71805f_find(0x4e, &address, &sio_data)) {
> +		release_region(0x2e, size);
>  		return -ENODEV;
> +	}
> +
> +	release_region(0x2e, size);
>  
>  	err = platform_driver_register(&f71805f_driver);
>  	if (err)
> -- 
> 2.17.1
> 
