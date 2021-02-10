Return-Path: <linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D5A1C433E9
	for <linux-pci@archiver.kernel.org>; Wed, 10 Feb 2021 16:15:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 31F5F64E66
	for <linux-pci@archiver.kernel.org>; Wed, 10 Feb 2021 16:15:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231959AbhBJQPL (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 10 Feb 2021 11:15:11 -0500
Received: from mail-wr1-f47.google.com ([209.85.221.47]:38356 "EHLO
        mail-wr1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231897AbhBJQPK (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 10 Feb 2021 11:15:10 -0500
Received: by mail-wr1-f47.google.com with SMTP id b3so3224984wrj.5
        for <linux-pci@vger.kernel.org>; Wed, 10 Feb 2021 08:14:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=OnlbgraGzC4hCP68Xu38F2W2XjSz5SvRGJPH+IYRmPI=;
        b=OLi9EjnTnN5i1ClJuWSugHe2cZ0HjP5Fivun2XFvu2Fmv7PgNy/yTM/fbyFEau35LJ
         TMMO2OvRcVoJuQ9MRbmwZjl5bKsX6YO94vOy48MWf0q4I7bdimldWh3rT3xcuJBfuyFJ
         p05HqSsWenX2xt41m9kqqvVr4Wgh+yu1TsK9AMXQPnDApX7k+AMHb0UAeNwmPcJLOBL+
         A1WtKVScO84ErNtjvvWZ6ahadHSm6ZHFxsIQW/Fj2inmUbb0DsWkWEPYbi9a2m7IkA5V
         oUxJ94394SNUIpShAhOGe3z0rgiGJSlWk1w1rhZl2bnrJuRJlM7N4rlOId3t3ufDnAS7
         IHNQ==
X-Gm-Message-State: AOAM53177Bb0Th3652bCrdkzmZsZBYKWe3lHgciLCm4gg0qzFKabUszc
        hbsu5a+Olo948MRe4Ip9ats470o6tLksDg==
X-Google-Smtp-Source: ABdhPJw83DESV9rw6GXjp4Yd1sH+R7+41YC88aaulaX0u1XJFS8h5xDAzzS/HS9bNyMFF9768tSe8g==
X-Received: by 2002:a5d:4391:: with SMTP id i17mr4492600wrq.57.1612973668234;
        Wed, 10 Feb 2021 08:14:28 -0800 (PST)
Received: from rocinante ([95.155.85.46])
        by smtp.gmail.com with ESMTPSA id f7sm3879600wre.78.2021.02.10.08.14.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Feb 2021 08:14:27 -0800 (PST)
Date:   Wed, 10 Feb 2021 17:14:26 +0100
From:   Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To:     Keith Busch <kbusch@kernel.org>
Cc:     linux-pci@vger.kernel.org, Bjorn Helgaas <helgaas@kernel.org>
Subject: Re: [PATCH] PCI/ERR: Fix state assignment
Message-ID: <YCQGYu/7jywLktlw@rocinante>
References: <20210210151604.2678236-1-kbusch@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210210151604.2678236-1-kbusch@kernel.org>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Keith,

[...]
>  	if (new == pci_channel_io_perm_failure) {
> -		dev->error_state == pci_channel_io_perm_failure;
> +		dev->error_state = pci_channel_io_perm_failure;
[...]

Ouch!  Nice catch.

Reviewed-by: Krzysztof Wilczyński <kw@linux.com>

Krzysztof
