Return-Path: <SRS0=9smm=S2=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5E90C10F11
	for <linux-pci@archiver.kernel.org>; Wed, 24 Apr 2019 22:04:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7675C21773
	for <linux-pci@archiver.kernel.org>; Wed, 24 Apr 2019 22:04:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gigaio-com.20150623.gappssmtp.com header.i=@gigaio-com.20150623.gappssmtp.com header.b="H+yn0QsM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730600AbfDXWES (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 24 Apr 2019 18:04:18 -0400
Received: from mail-wr1-f45.google.com ([209.85.221.45]:40941 "EHLO
        mail-wr1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727393AbfDXWES (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 24 Apr 2019 18:04:18 -0400
Received: by mail-wr1-f45.google.com with SMTP id h4so27231437wre.7
        for <linux-pci@vger.kernel.org>; Wed, 24 Apr 2019 15:04:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gigaio-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pFUAvLQvna4p2TYpVycS/ismfztBxifkj27pSRnA4Gc=;
        b=H+yn0QsMfV6ADS9a+b01cZZypKkMqAusmHHEBgw+UdEd28LwRQuvuaTMB90347E/9r
         /KbN8OkhpE02jAymfcAfC/p4K/SYTyBlTHR1ZHbdmbsHm7A+WUf5wT7QtFoDVet/bS2E
         w71j7YSh8wL3j4pK4/ICFbjyZX6c1Pco3RNScrnsMVGV87CxBMC5tTcfJQ4p6229wMgM
         x2Qs+KceZWmstk9+qP/nGmzNIehuJ9hvdd1tOYbpraZn5vsVRaBEKX9gXq9gEfOhsNVZ
         Z4qK2kvsnBfp20Wt6Tg/oqo6senZ9Da8xvk8uo12f9w8qF+Sz5dw7ffHZsCkQYxzLnsg
         RM0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pFUAvLQvna4p2TYpVycS/ismfztBxifkj27pSRnA4Gc=;
        b=RC7wn74MpW/Oo0NPIodmLcIyCAli6lY1JqVTSOwu7sQrt/7sOliLFSL6TG8AcOGbpY
         eegRT9J4t07H6g6Rml1xqPoHbOwNZeHJxUdU4gIrwqk2u41alZrXnr6YAZmiLY06FDpM
         oWIq0WqHK8xlhmSvzQzoxtxlWz1dH/JDIgV/1PmhW9Tm4uHRWquy3U5RbJq/m6gEPqql
         QHDPRRXWxpiKJj6o+1hn+oNMVLdgR93YQAuvLFUrLakel7CJqJ4a+UFZygx+Jbx1QWwf
         vvm/CzuFYCwso7srSrglKZgYDbFJGXN7D0xcER5kF7P8e2Ioh6B7u4hGrNEE7vSoYRg2
         nIrg==
X-Gm-Message-State: APjAAAX8F5fnmaAW8+RVxnC9NmFUjywdRYM/50u6kV8PX0h59DYe2G+r
        JndseMi1rKR/ut+eZnsOd9fn+gGh4WJyTvQbjh2FIr+B
X-Google-Smtp-Source: APXvYqw6nQrnyPgx28EbjzSmYciEK0CTWqSkwBjelWmMmiGVN6rWpgRJwd0C6xlo38mF4/4t0VLjbT+9aiqTd/NBPrk=
X-Received: by 2002:a5d:6604:: with SMTP id n4mr358443wru.42.1556143456612;
 Wed, 24 Apr 2019 15:04:16 -0700 (PDT)
MIME-Version: 1.0
References: <CAOQPn8sX2G-Db-ZiFpP2SMKbkQnPyk63UZijAY0we+DoZsmDtQ@mail.gmail.com>
 <CAADLhr49ke_3s25gW11qZ+H-Jjje-E00WMHiMDbKU=mcCQtb3g@mail.gmail.com> <cdcd00e9-056b-3364-cfbc-5bcb5bcff91e@amd.com>
In-Reply-To: <cdcd00e9-056b-3364-cfbc-5bcb5bcff91e@amd.com>
From:   Eric Pilmore <epilmore@gigaio.com>
Date:   Wed, 24 Apr 2019 15:04:05 -0700
Message-ID: <CAOQPn8sQ+B97UptHpxJgdmcMxBZrqGynQR8qTc3q77fAODRH-A@mail.gmail.com>
Subject: Re: Fwd: AMD IO_PAGE_FAULT w/NTB on Write ops?
To:     Sanjay R Mehta <sanmehta@amd.com>
Cc:     S Taylor <staylor@gigaio.com>, D Meyer <dmeyer@gigaio.com>,
        linux-ntb <linux-ntb@googlegroups.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Apr 23, 2019 at 4:00 AM Sanjay R Mehta <sanmehta@amd.com> wrote:
>
>
> > AMD-Vi: Event logged [IO_PAGE_FAULT device=23:01.2 domain=0x0000
> > address=0x00000000fde1c18c flags=0x0070]
>
> the address in the above log looks to be physical address of memory window. Am I Right?
>
> If yes then, the first parameter of dma_alloc_coherent() to be passed as below,
>
> dma_alloc_coherent(&ntb->pdev->dev, ...)instead of dma_alloc_coherent(&ntb->dev, ...).
>
> Hope this should solve your problem.

Hi Sanjay,

Thanks the for the response.  We are using the correct device for the
dma_alloc_coherent(). Upon further investigation what we are finding
is that apparently the AMD IOMMU support can only manage one alias, as
opposed to Intel IOMMU support which can support multiple. Not clear
at this time if it's a software limitation in the AMD IOMMU kernel
support or an imposed limitation of the hardware. Still investigating.

Thanks,
Eric
