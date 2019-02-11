Return-Path: <SRS0=XN0A=QS=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28D14C282D7
	for <linux-pci@archiver.kernel.org>; Mon, 11 Feb 2019 07:41:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E2A3A214DA
	for <linux-pci@archiver.kernel.org>; Mon, 11 Feb 2019 07:41:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549870907;
	bh=a3ot5/4+RnkUVxI5+HTCvnv3chTgcSs4+C7t6TrAu9s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=YgjjANKSoxXl0WwFJ5ZSiqQ1h0sE8q9B7Abdpb4w7hhSaurX51jQ28eWzn1bWwFDj
	 UYi/r+MCZrCStlOSdh2tbHWyGNZ7rmROMUqLLRtaMK1Au/AWsFdEnsmuCa7J5rcD3A
	 aaxZtI7husVuYq2XhC7t2h/wxPzOX6Uj9wBHtR0c=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726025AbfBKHlq (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 11 Feb 2019 02:41:46 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:40659 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725951AbfBKHlp (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 11 Feb 2019 02:41:45 -0500
Received: by mail-wm1-f68.google.com with SMTP id q21so14962986wmc.5;
        Sun, 10 Feb 2019 23:41:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=1+SiEUMJe3itEB9pavdt/Mrwkq8kfBFGEm8QB6Sr0TM=;
        b=gvAgSc5fQVT1eXrxaKFex8XrK07f8DhxiNk5YRsGG/3QNaYBNxmVyUzPkY5Ku+cf7F
         v/xmmGzgEqJ69Y8v2uWvFkYXFJb3OT+N10IEHUgBH+Hx5a9SzlLauR2Vhl93KTrNjTsA
         ZV5q3TlMCrzrAQeK17lHm/qV0Kse5u29BI/kzpyIojEfRUI5ZpCXdxrdzCG/3G9CwxE0
         6uyYOYdbTFXdXobktmBnwAKJa7+lRqZkMI5jMeohFRRCuhBzphWFoXSNjx4o5JcMWCn6
         QmdWRkHRZk5T9gShvAe4ILj2A+ePc3M1wICQlAKYo2DOsxMwU5QmP3XJX7SO/viqh7OM
         ddXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=1+SiEUMJe3itEB9pavdt/Mrwkq8kfBFGEm8QB6Sr0TM=;
        b=meer9xaGiKQx4gYh4xt6Zan0S+CIC+9nfpytf9JVy7y1kIp4s3eQhWmYwJjBqC08uk
         53btAacZ8NOMpVYTTtsa2To4P9Yt+OHTgfmWTbBxVlPlmhwmolruRNFlSu9LjGtVSle1
         60rPCv8l4gibdama4o0o0zJxoqaZCyPSTvASzcGjQgUu2TyOlwTCC0zfDUOSJPBrvmwC
         9ZyIMmqGVvqpIf1l0a9bz8igApT4niydizaY4xj6t1sCk4tvymxBwojd1pyE3o4eecz0
         HNz7FJvRvfeZV2ZBWxRDL0rYoGKnEcrft/wvcfCL5fSB9gq1xPkRsYPOMrpEjt/1g4iu
         U8Eg==
X-Gm-Message-State: AHQUAubYwuhxjn1bP+TRBoN5Y9ZYoOR8hWTw+GrhriRBJ2tsw1gKD0GZ
        f9C3m2UG2pFSkvWiArN2ceM=
X-Google-Smtp-Source: AHgI3IZAhIuw2pNaovEh62rnUpxkEcyKdImxdHRMhmz5sf6S4tGtJNdS5HPmUQVqEgZ1BV34LEhEvg==
X-Received: by 2002:a7b:c0c5:: with SMTP id s5mr7780119wmh.56.1549870903881;
        Sun, 10 Feb 2019 23:41:43 -0800 (PST)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id i20sm7286229wml.9.2019.02.10.23.41.42
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 10 Feb 2019 23:41:43 -0800 (PST)
Date:   Mon, 11 Feb 2019 08:41:41 +0100
From:   Ingo Molnar <mingo@kernel.org>
To:     Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, x86@kernel.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Subject: Re: [PATCH v2] PCI: Fixup the RTIT_BAR of Intel TH on Denverton
Message-ID: <20190211074141.GA49295@gmail.com>
References: <20190207133005.67328-1-alexander.shishkin@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190207133005.67328-1-alexander.shishkin@linux.intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


* Alexander Shishkin <alexander.shishkin@linux.intel.com> wrote:

> On Denverton's integration of the Intel(R) Trace Hub (for a reference
> and overview see Documentation/trace/intel_th.txt) the reported size of
> one of its resources (RTIT_BAR) doesn't match its actual size, which
> leads to overlaps with other devices' resources.

Note that in the latest kernels it's Documentation/trace/intel_th.rst, 
not .txt.

Thanks,

	Ingo
