Return-Path: <SRS0=slvM=EL=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDAFDC55178
	for <linux-pci@archiver.kernel.org>; Thu,  5 Nov 2020 15:04:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 63859221FA
	for <linux-pci@archiver.kernel.org>; Thu,  5 Nov 2020 15:04:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aoPRiG/v"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730501AbgKEPD7 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 5 Nov 2020 10:03:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730465AbgKEPD7 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 5 Nov 2020 10:03:59 -0500
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CC7CC0613CF
        for <linux-pci@vger.kernel.org>; Thu,  5 Nov 2020 07:03:59 -0800 (PST)
Received: by mail-wm1-x32b.google.com with SMTP id d142so1907640wmd.4
        for <linux-pci@vger.kernel.org>; Thu, 05 Nov 2020 07:03:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zH8H7GohOzf7Wbgff+RQ/npK/mHWZToirSWPF9Fi540=;
        b=aoPRiG/vfyDBmkpPmXexhbaGe7euJ3QQ4seEbLt0Y8Z8WADP6yb5EB0kU1bE526WwD
         us2Na8SCWvD35jLYNVJT7wShEnY4eJ/N7FSzuuZ8eL1e93XTdwFdNJHyZrzYoo+QtJIZ
         KTKf0BQYVhQ/0b8slW8+Pm8bwt1pAmAaSdHObAklqVvWPbsU1B+yP7BkEOF5hbXKT7YF
         GYh75lg6Dqp/2su4GsEX1ijzJTcTsF2lhCnsJmO7Ys84emH2ygN0nguKHHjk3DG2imPb
         qDVoOByew3D2jE6CuPwhKYGbD/1Asywi8DKBSw6CjYLLkJHMjOsxK94Gh0VnrigU8Qwp
         ReTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zH8H7GohOzf7Wbgff+RQ/npK/mHWZToirSWPF9Fi540=;
        b=EqR4tr1H2pfk7oQbtcEpiJfJ3UsTlDRwzhozlRqbyU1wEslLX2QBcMHVExyUqo/QHt
         3k6FXt5WxFSQMZc/iCRPa/Tsku0V9spoD03Iu4HSYP1WqgDWFDgFCUSgeG4CpuIPVefT
         YIOwg7xgMVsx+lFT6l5BghpdqqNgJFmq4bID2C+N06rPaTRuC3C069s6L8mG1y2bucbo
         yav6JouPjMZfRwcKSHNlpsKsNRQNqcQ5R1CA/pTGvu5el3OxIcHP6ttv8OZSPIpNosli
         Z4ZG+DuUriahT2MA31AcKSHZN6j8v1+FKKM4i/9Y4kk9oeqgZS1NDLDoqPqucZd8CAgT
         2yjA==
X-Gm-Message-State: AOAM530yXdLx95Wj0QXq0Ib3v+UsKBRfYa3bRFo7TLm9UqS/Fpm7aBrA
        1mVV8AYwmtEd6mfjgoyHjSh3hmgxEECeA75AszHo+a95ia+iKxCB
X-Google-Smtp-Source: ABdhPJy2qO6RQ7IPthkKPKxCsHs0m6jdOdMZT1tNcwedx+Js2y4MiOnavayAHhOUcqvDFPDWGPzcI1cGVdFO6wA4XIo=
X-Received: by 2002:a1c:acc1:: with SMTP id v184mr3028920wme.63.1604588637718;
 Thu, 05 Nov 2020 07:03:57 -0800 (PST)
MIME-Version: 1.0
References: <CAFhCfDbh0uXpTPu1+PQwk3_mV0uqfETynu=5yywU-U3CyDJGvA@mail.gmail.com>
 <20201105144711.GA427563@kroah.com>
In-Reply-To: <20201105144711.GA427563@kroah.com>
From:   Jack Winch <sunt.un.morcov@gmail.com>
Date:   Thu, 5 Nov 2020 15:07:43 +0000
Message-ID: <CAFhCfDbCBHOnkqy1wuiAdfNy-QDs=GQD=Op4+ci35vais=5YAw@mail.gmail.com>
Subject: Re: PCI / PCIe Device Memory - Rationale for Choosing MMIO Over PMIO
 (and Visa-Versa)
To:     Greg KH <greg@kroah.com>
Cc:     kernelnewbies <Kernelnewbies@kernelnewbies.org>,
        linux-pci@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hey Greg,

> I think you should be talking to hardware people about this, as this is
> almost always due to hardware limitations/issues/design decisions.


To be honest, I anticipated a response along these lines (after
briefly speaking to another individual on this matter).  They
commented on how this decision was usually made and asserted by the
hardware engineer(s).

> The PCI-SIG should have a bunch of resources about this, have you looked
> into that?


I haven't as of yet, but I'll shift focus onto their resources next.
Do any specific resources of theirs spring to mind offhand?  No
worries if not - I'm not afraid to spend time searching them out.

Thanks for the quick response and your time. :)

Jack
