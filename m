Return-Path: <linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89DBDC433EF
	for <linux-pci@archiver.kernel.org>; Wed, 15 Sep 2021 01:23:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6F08F60EE9
	for <linux-pci@archiver.kernel.org>; Wed, 15 Sep 2021 01:23:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231607AbhIOBYm (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 14 Sep 2021 21:24:42 -0400
Received: from mail-lj1-f169.google.com ([209.85.208.169]:39529 "EHLO
        mail-lj1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229548AbhIOBYm (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 14 Sep 2021 21:24:42 -0400
Received: by mail-lj1-f169.google.com with SMTP id q21so2184848ljj.6;
        Tue, 14 Sep 2021 18:23:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=E5DtuXDkIx/JZIO78nFiru8su07OSjoiOTQuZskOqv4=;
        b=lbSDgMaY7TeVevm/nbO17L8lRoj3s7WMprCxH/AETv/QDkkexROt5N+aXe8PshY9d0
         aOTw2Yz81USy/ai870wUqGkOImHDW0eqj3kndIm5vFWHBYoKmsL+HLmF1t5PEWShFaWN
         U2Xjk4Z8A+TNAzYkM1GdkQN2NveqveAYCmOyx+g4YnRU2NGsfgspbBsvexP6pcqzGJOQ
         9wXY5Ti8E53KcbaO4TTvfmzepYFb05ZJmVoJLgWWj/5mFTYcn7H94OIxVauQ0VITp4SL
         UQns4QQoyZQEKr9EzhhWrfwPxVpbP8vORqa4lW2zzBLNIO2jcKKq9ZGPMAW1Nh8fJBA9
         BQnA==
X-Gm-Message-State: AOAM533GOqU58+LofESTS5V7cjAkaskvS4yCZPZzlvbil4FlaLj+FoN5
        ekcX4nM4b4wAqZXlTd+79+p18aK2KLFvDg==
X-Google-Smtp-Source: ABdhPJzF7iVZCkXFvTvzk1q6t0KOZj+BiZ4WNEH8FwlfgGQ1rFn6sJzZSAWLYvRe0qJIiMWfawLxTA==
X-Received: by 2002:a2e:988f:: with SMTP id b15mr18426710ljj.454.1631669002597;
        Tue, 14 Sep 2021 18:23:22 -0700 (PDT)
Received: from rocinante ([95.155.85.46])
        by smtp.gmail.com with ESMTPSA id w9sm1621256ljo.36.2021.09.14.18.23.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Sep 2021 18:23:21 -0700 (PDT)
Date:   Wed, 15 Sep 2021 03:23:20 +0200
From:   Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To:     Colin King <colin.king@canonical.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: Remove redundant initialization of variable rc
Message-ID: <20210915012320.GC1444093@rocinante>
References: <20210910161417.91001-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210910161417.91001-1-colin.king@canonical.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Colin,

> The variable rc is being initialized with a value that is never read, it
> is being updated later on. The assignment is redundant and can be removed.
> 
> Addresses-Coverity: ("Unused value")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>  drivers/pci/pci.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index ce2ab62b64cf..cd8cb94cc450 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -5288,7 +5288,7 @@ const struct attribute_group pci_dev_reset_method_attr_group = {
>   */
>  int __pci_reset_function_locked(struct pci_dev *dev)
>  {
> -	int i, m, rc = -ENOTTY;
> +	int i, m, rc;

Thank you!

Reviewed-by: Krzysztof Wilczyński <kw@linux.com>

	Krzysztof
