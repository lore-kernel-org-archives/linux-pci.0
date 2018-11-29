Return-Path: <SRS0=ChyX=OI=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9E0BC04EBA
	for <linux-pci@archiver.kernel.org>; Thu, 29 Nov 2018 14:50:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A088B21019
	for <linux-pci@archiver.kernel.org>; Thu, 29 Nov 2018 14:50:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E7fH5QFW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A088B21019
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732863AbeK3Bzl (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 29 Nov 2018 20:55:41 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:38572 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729849AbeK3Bzk (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 29 Nov 2018 20:55:40 -0500
Received: by mail-pf1-f195.google.com with SMTP id q1so1123968pfi.5;
        Thu, 29 Nov 2018 06:50:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=7IY4PCbx+jKRZfVBI1NFUIWCeB4wk5A8ndVGppWY2kU=;
        b=E7fH5QFW9ebWfVhe1ZDewI1KoULUrMkViOzOmotG515XOiwg5UDqe2GCxIiPrs2XqJ
         W/275a0OjMBHB126SeUaEi197WN5c1STQGvTDQ8WpSJL8PL8pgUJgJAkA2d+0lfKM3Oq
         a3pf24OWvz3YMA2uSNMwEiWwRqPP7I19Betu2MA9gJ/uO4fnxNJqYAgq1YsNfEU5HmUt
         9SE4jtxoM7F5KNO+Sj//lSAEEmhIgGEmInwwTHSsSv5L9P063DjCoZ7Ab9VGRPJmNcIm
         huwgQS8oD5Jyhd4TooTQ2+7cEQ93DmE+VN/D3YYXKp6aGfTsagc4TjAChMwr4zPTmuOJ
         pXSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=7IY4PCbx+jKRZfVBI1NFUIWCeB4wk5A8ndVGppWY2kU=;
        b=eLIHVGNYS08/R9y40ZdvaFdNROTFgDj2udvJL/i0jgZLJtZW77N+1icFjaiHon+mUQ
         F4PJCTGpBNThWi1+2xzyTccQ101noSDxp5kCKazzRmFXDOOQrokzqZ6sSm0mUPstrXoC
         A4FfkpwEBMsMFFPSgyuA+PvPc5Ss2Gz27mkCJl1WOfb0BP8TlGX8qbKBFzl2JZisLOYJ
         4DMGymG4pJ5+4CxyXlxdBgs8We0Tr98D4fdwOQpwabAPeKlz4TweIO3ELg+t5QqbttQP
         K3ypAkUs05bEIFP7qIfGEeln2ZRl2RSuoLqGGFiYz9h0XsxyTaGPEzoef3BPFfrYcdIR
         dxPw==
X-Gm-Message-State: AA+aEWYQAvvHOnwnzDOKViO/tGmejj3cw5HknYN8clNjOiRVIv6F0qNX
        cM0oU5EewDWHJgY1/clWqFW/t350XyI=
X-Google-Smtp-Source: AFSGD/UG7x5Rl0rX0uIRQPcACX6vuPIiKYoenQwUI//Ft9MZ1grUKjwwou939PtpNPqQUO0+iapUcA==
X-Received: by 2002:a62:1709:: with SMTP id 9mr1622568pfx.249.1543503004092;
        Thu, 29 Nov 2018 06:50:04 -0800 (PST)
Received: from localhost.localdomain ([104.238.160.83])
        by smtp.gmail.com with ESMTPSA id g26sm3247649pfh.61.2018.11.29.06.49.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 29 Nov 2018 06:50:03 -0800 (PST)
Subject: Re: [RFC PATCH v3] genirq/affinity: Create and transfer more irq desc
 info by a new structure
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>, kashyap.desai@broadcom.com,
        shivasharan.srikanteshwara@broadcom.com, sumit.saxena@broadcom.com,
        ming.lei@redhat.com, Christoph Hellwig <hch@lst.de>,
        bhelgaas@google.com, linux-pci@vger.kernel.org
References: <20181128164503.6194-1-douliyangs@gmail.com>
 <alpine.DEB.2.21.1811282228570.1879@nanos.tec.linutronix.de>
From:   Dou Liyang <douliyangs@gmail.com>
Message-ID: <0aaa0eeb-2c8e-71e2-bf92-87103735b2b6@gmail.com>
Date:   Thu, 29 Nov 2018 22:49:54 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.1811282228570.1879@nanos.tec.linutronix.de>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Thomas,

On 2018/11/29 6:03, Thomas Gleixner wrote:

>> +		affi_desc = kcalloc(nvec, sizeof(*affi_desc), GFP_KERNEL);
> 
> Why do you want to do that separate allocation here? Just let

I thought the irq_create_affinity_desc() also can be called by other 
functions which may convert cpumasks to irq_affinity_desc, such as
__devm_irq_alloc_descs().

Now, I know I was wrong, will modify it.

> irq_create_affinity_masks() allocate an array of affinity descriptors and
> use that. There is no point in copying that stuff over and over. Setting
> the flag field can be done in the existing function as well.

> Can you please change the function signature and fixup the callers, if
> there are any of them? Copying this over and over is horrible.

I have searched, no one calls __devm_irq_alloc_descs, it may be called
by some users' own modules or drives.

yes, I will change it.

> struct irq_affinity_desc {
> 	struct cpumask	masks;
> 	unsigned int	managed : 1; > };

yes, BTW, If the following is more fit for irq_affinity_desc:

s/masks/mask/
s/managed/is_managed/

> 

> You can spare a lot of pointless churn by just keeping the 'affinity' name
> and only changing the struct type. The compiler will catch all places which
> need to be fixed and 'affinity' is generic enough to be used with the new
> struct type as well. As Bjorn said, even 'masks' is fine.

Yes, I see

Thanks,
	dou
