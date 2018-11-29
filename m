Return-Path: <SRS0=ChyX=OI=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3D5CC43441
	for <linux-pci@archiver.kernel.org>; Thu, 29 Nov 2018 14:36:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 79F82213A2
	for <linux-pci@archiver.kernel.org>; Thu, 29 Nov 2018 14:36:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U23WiSdA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 79F82213A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387983AbeK3BgU (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 29 Nov 2018 20:36:20 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:40858 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388288AbeK3BgT (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 29 Nov 2018 20:36:19 -0500
Received: by mail-pf1-f196.google.com with SMTP id i12so1094386pfo.7;
        Thu, 29 Nov 2018 06:30:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=kdzKz3ui18WvBy/HfDYaNC9+FBWk622avJo1sOZ9ERY=;
        b=U23WiSdAPsYw3HM3lNbTh7jvwfwmyyDmwV0wo+kbEx1yhY8M4AMupHuNPVG2zbVUza
         dC/mba7q6MjW6YUrFt6OvX6bY7FQcR1YtSlbu2qeQhxXUT1NOiFreIDyh3u96NGrin18
         8+hO6CiyrhWNB+bXTHofi4AdsIQj04gNv9JTJEBTgT8+CtGzwUjPPK+RTkRYCYD6ApqG
         CF8KU9uY+mp+UV10PJsRFfgUjcKrxNtumwTtY31aqTZZDPcWFQHJynmZXX21m9hOwISY
         vbxZFh+p1Ogwx1I44UJrIp2Ps5m2zeKtTh6ZboYha/AxVJO+k9pOPHaJEB60WuBZWleM
         58yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=kdzKz3ui18WvBy/HfDYaNC9+FBWk622avJo1sOZ9ERY=;
        b=TGwxUXjmbR5KK6A4oXw5CTygeqO4sVtVsqSkyQ2kf+FZKNm4tLFY/JqZJaYAIsDCG6
         pB7OuMUrUUML9hs7KAPgZOxcp53p+pcmZtO+HBVYyuJ1iOClXCPM3SrjEusO4wjeas0I
         b8ercOvm/74Ojsc4LIOVjzftNBJauKJoaLt0asttu23pee9IR7XGU4ARLt8GVVlgRebi
         fFq9ivD6pat2DmchXEI0W5Oiid1hZXSOD8gtmx3/12tnJ9ZbHIuUH5X1m33Vdb0AVBn9
         kVVqaoBlvHzdohzzAse55veONlfzDdougGjc9a5JTYyTWRci2INq/DltZ8yHwbkecGP4
         35mA==
X-Gm-Message-State: AA+aEWZ8+FT/T61oq/OO/hMopqiX5c0+axC2oumwGzkYVOlHrkYxAkXs
        BktxWpyudkiwUQ0f9KmN+juusMvEzdQ=
X-Google-Smtp-Source: AFSGD/XQ8ZamKadZ2Rt8BLItkJBGoK4cYkryZ3STAu3oeHZcouJvMGnezBT88Bmw/bZmcII8p1VZ1A==
X-Received: by 2002:a63:8d44:: with SMTP id z65mr1436603pgd.57.1543501846379;
        Thu, 29 Nov 2018 06:30:46 -0800 (PST)
Received: from localhost.localdomain ([104.238.160.83])
        by smtp.gmail.com with ESMTPSA id 186sm3873997pga.36.2018.11.29.06.30.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 29 Nov 2018 06:30:45 -0800 (PST)
Subject: Re: [RFC PATCH v3] genirq/affinity: Create and transfer more irq desc
 info by a new structure
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Kashyap Desai <kashyap.desai@broadcom.com>,
        shivasharan.srikanteshwara@broadcom.com,
        Sumit Saxena <sumit.saxena@broadcom.com>, ming.lei@redhat.com,
        Christoph Hellwig <hch@lst.de>, linux-pci@vger.kernel.org
References: <20181128164503.6194-1-douliyangs@gmail.com>
 <CAErSpo5NCy6C7xqaWUNnC2uY+RRpZnbpOJUQxrz0aER-g6+XqQ@mail.gmail.com>
From:   Dou Liyang <douliyangs@gmail.com>
Message-ID: <b6f3cbb6-60b7-1425-9bff-0ac4565f56a7@gmail.com>
Date:   Thu, 29 Nov 2018 22:30:22 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <CAErSpo5NCy6C7xqaWUNnC2uY+RRpZnbpOJUQxrz0aER-g6+XqQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Bjorn,

on 2018/11/29 4:00, Bjorn Helgaas wrote:
> [+cc linux-pci]
> Since you mention reports, are there URLs to mailing list archives you
> can include?
OK, I will add it:

https://marc.info/?l=linux-kernel&m=153543887027997&w=2

>> -       entry = alloc_msi_entry(&dev->dev, nvec, masks);
>> +       entry = alloc_msi_entry(&dev->dev, nvec, affi_desc);
> 
> Can you split this into two or more patches?  Most of these changes

Yes, next non-RFC version will do.

> are trivial and not very interesting, and the fact that they're all in
> one patch makes it hard to find and review the interesting bits.  For
> example,
> 
>    1) Rename all the local variables while keeping the type the same
> (or just leave the name the same; I think "affinity" would be a fine
> name, and I would be OK if we ended up with "struct irq_affinity_desc
> *masks" or "struct irq_affinity_desc *affinity").  This patch would
> obviously have no functional impact and would remove a lot of the
> trivial changes.
> Oops, how stupid I am !

>    2) Add "struct irq_affinity_desc" containing only "struct cpumask
> masks" and irq_create_affinity_desc() (or leave the name as
> irq_create_affinity_masks() and adjust the signature).  This would
> also have no functional impact and would be a fairly trivial patch.
> >    3) Add "flags" to struct irq_affinity_desc and the related code.
> This is the real meat of your patch, and with the above out of the
> way, it will be much smaller and it'll be obvious what the important
> changes are.
> 
I see, :)

Thanks,
	dou
