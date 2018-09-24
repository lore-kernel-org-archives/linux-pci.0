Return-Path: <SRS0=+fdl=MG=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4329CECE560
	for <linux-pci@archiver.kernel.org>; Mon, 24 Sep 2018 16:32:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA5662087A
	for <linux-pci@archiver.kernel.org>; Mon, 24 Sep 2018 16:32:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PuCYmlel"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DA5662087A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728054AbeIXWfT (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 24 Sep 2018 18:35:19 -0400
Received: from mail-wr1-f48.google.com ([209.85.221.48]:41455 "EHLO
        mail-wr1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726400AbeIXWfT (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 24 Sep 2018 18:35:19 -0400
Received: by mail-wr1-f48.google.com with SMTP id j15-v6so16265919wrt.8
        for <linux-pci@vger.kernel.org>; Mon, 24 Sep 2018 09:32:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XGpr1NGBBpHgvutxIt8Lxxn+OfANQ96PTqkALPDCmHU=;
        b=PuCYmlel80HT1b49Rp/GTngSjPRmwO/KPZZuOciLfzLK0fWART960JQLaSuVOZZrhG
         lIIB19b6w54RUppa7dgy0ENllfiDbcasuKiu+jg97JdY5mu006smT1/QfxI3MjcJ5QrS
         XX1NYfju4o/BUmLiBtyp6G5I7bDdTKx19zxvsv0jykrqSIvrsJ1movO8faowgn4jjI2d
         to45VesmHwXexWcUWSP4f0YkK1kkFtHBzBRVqkf+jcYXQt8MSw8aaxwTjJV81qsRHVTn
         Q46cgtjiSxupaOTUJg4RSYeON2pKp6Uh7wdilc4bSwBtdCcQ2li05OJvBPIs6jy7gPJy
         YKbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XGpr1NGBBpHgvutxIt8Lxxn+OfANQ96PTqkALPDCmHU=;
        b=brgfro9zgJgBOExgDRi0JFyPGKHuJi3eLvevwRn+CgeFOhtbtBVkNC/6SndXSuFFoH
         GF9aZsh83CTgc9XEjEnMBN0A71kRehi+fVrARFjmS91wbenEPoZ+pNXh2UTStNzgR9dP
         j6+sNfarUMFNZcocCszN7qJuDWJMQFc0Af63LzSoto4O0q8A6XcVBxX+MKqnWw6oZhwW
         dGR1hiSYinQ1knrqvhx/JHYYi1/OtuJzoWqxAoiVyF0k1JzNdFGZ/sL5dDxctiolQZQi
         Pq49UxggRoqqPteQLGgjMTBbMLTsVW7TTZ1ZPVWU8jPQ40YgKuRvvQTsgWTKrXXAo+O5
         j4mQ==
X-Gm-Message-State: ABuFfoghpwJyvxBnGeKMc3ZQDRpJhLw9FJ2jzwEB9RTL+RcSY1epLlPn
        /dc7Daj9DJyl8egkoKdhCwD4lAy3PkVZBP1sedVXeQ==
X-Google-Smtp-Source: ACcGV63+twm++ybHv0zSRf9SKgLPKMbQ8iLs/ual6Sy/WZSZF7S1ia6y9I/KMQUhrIwUX7QjdTJ4INr1U66l8T/LYjk=
X-Received: by 2002:a5d:6051:: with SMTP id j17-v6mr4779964wrt.265.1537806739633;
 Mon, 24 Sep 2018 09:32:19 -0700 (PDT)
MIME-Version: 1.0
References: <CAN7O0+L1cg9qRMqTN3KwyP=O19HcqCHM0Md89PKp1+LwHKRD8Q@mail.gmail.com>
 <CAN7O0+LpJUtmEZEjg8XoZRZcWP_3wR3i8=MdamudF=NYjc9ZBA@mail.gmail.com>
In-Reply-To: <CAN7O0+LpJUtmEZEjg8XoZRZcWP_3wR3i8=MdamudF=NYjc9ZBA@mail.gmail.com>
From:   vidya sagar <sagar.tv@gmail.com>
Date:   Mon, 24 Sep 2018 22:02:07 +0530
Message-ID: <CAN7O0+JsL9xxjRtZUxxjrOS_7FvS_1cyhFk+tOi=fMU31ywhiA@mail.gmail.com>
Subject: Re: Need information w.r.t PCIe end point framework
To:     kishon@ti.com
Cc:     bhelgaas@google.com, treding@nvidia.com, swarren@nvidia.com,
        NManikanta <mmaddireddy@nvidia.com>, kthota@nvidia.com,
        linux-pci@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Kishon,
Could you please help me with the below questions?

On Tue, Sep 18, 2018 at 12:43 AM vidya sagar <sagar.tv@gmail.com> wrote:
>
> Hi,
> I have following queries w.r.t PCIe endpoint framework in kernel in
> the context of a DesignWare core IP.
> -> Since the PCIe spec says that the endpoint should have stable
> REFCLK before it observes PEX_RST from host, endpoint's LTSSM in a way
> depends on arrival of PEX_RST from host (there by locking endpoint's
> internal PLLs to incoming REFCLK from host, followed by core
> programming and finally enabling LTSSM of endpoint). But, IIUC, the
> endpoint framework starts LTSSM based on writing '1' to 'start' in epc
> device's config-fs entry. What is the rationale behind it? Why is
> starting LTSSM in endpoint decoupled from PEX_RST toggle?
> -> Also, kernel documentation says that the sequence is first creating
> EPF device followed by EPC device and linking it with already created
> EPF device and finally going for link up. This implicitly assumes
> that, programming of core registers is happening in the absence of
> REFCLK from host. Does it mean, there are internal clock sources
> available for DWC core programming (dbi registers programming) before
> REFCLK is available from host, and, finally when PEX_RST is observed,
> switch clock source from internal clock source to external REFCLK?
>
> Thanks,
> Vidya Sagar
