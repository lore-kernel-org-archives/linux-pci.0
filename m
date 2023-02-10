Return-Path: <linux-pci-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0D0BC636D4
	for <linux-pci@archiver.kernel.org>; Fri, 10 Feb 2023 22:22:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233416AbjBJWWm (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 10 Feb 2023 17:22:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233131AbjBJWWl (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 10 Feb 2023 17:22:41 -0500
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1A7A7534C
        for <linux-pci@vger.kernel.org>; Fri, 10 Feb 2023 14:22:39 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id n28-20020a05600c3b9c00b003ddca7a2bcbso5064188wms.3
        for <linux-pci@vger.kernel.org>; Fri, 10 Feb 2023 14:22:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=7tI/5EvoUb2b1YfGjLvZOx2cuiGfB7/qRUXmljsRRQ8=;
        b=UKX/8zPK15fwrWSudAEfFDY2yxRysZDG/CowOUCO2ThMPb0xgBfuhbUugHcCyV/iKS
         nthIkxz6MKN2FMCOvv3oH4NG0wZ0K6sDC1NRfKqI37lqFApAm+ZIKMk02JdRAwoUxKD4
         zA4HBIqc/tNsJMylZB9TEpU2xNIIA/79Xy/cU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7tI/5EvoUb2b1YfGjLvZOx2cuiGfB7/qRUXmljsRRQ8=;
        b=1kN8BXtxvJgVsLkaq2tK02ZxHw0xwhjxF7KXbXtRQIHSy3Q7dzLliKPshOwp/tHUGy
         b7eZrB5wnz7vd6rVPpAHOu75XiPSRqTQdftYTcx5ScVCaRq1Px5uD27tOz1K43jo2JT/
         jUvi5yqnPw4sfbo07A2TYDFrUc4cmbVMkrifJSHdmnmxG3lo8JvKRUtfE8e1oqA0nSlo
         Mp6cOjbAzZ55JR1s4h2OEot7fNe3W8FInwFy95x26Mzs+bGfRDxbrR9FUf4nviJnIyB7
         L9BSqG8GItAyp10FbVlr75b0rvf36MRZVrppa4SAY1KhceY0uxb8wpxMe2GfQ4tH4Myp
         SegQ==
X-Gm-Message-State: AO0yUKWpXDoyFhNh6tlj6p2lkSGKp9aDQ1LDX5Ba98RYHTOgz+aFOq4q
        Hrs/WgRTnDDwS0M7sqDcnUwQS+ci7Ea+riXzTr8=
X-Google-Smtp-Source: AK7set8cG08WUIqdnG1VnThO0R2x+eKf2v9eGyo4sw5Zfm83DebY9KR9onWHOsKFI8ChVwURQbK+Ig==
X-Received: by 2002:a05:600c:2b46:b0:3df:f7db:9cdf with SMTP id e6-20020a05600c2b4600b003dff7db9cdfmr14128697wmf.0.1676067757963;
        Fri, 10 Feb 2023 14:22:37 -0800 (PST)
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com. [209.85.218.45])
        by smtp.gmail.com with ESMTPSA id l19-20020a05600c2cd300b003dfefe115b9sm7187434wmc.0.2023.02.10.14.22.36
        for <linux-pci@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Feb 2023 14:22:37 -0800 (PST)
Received: by mail-ej1-f45.google.com with SMTP id qb15so17325920ejc.1
        for <linux-pci@vger.kernel.org>; Fri, 10 Feb 2023 14:22:36 -0800 (PST)
X-Received: by 2002:a17:906:f749:b0:8af:2ad9:9a1d with SMTP id
 jp9-20020a170906f74900b008af2ad99a1dmr1661134ejb.0.1676067756680; Fri, 10 Feb
 2023 14:22:36 -0800 (PST)
MIME-Version: 1.0
References: <20230210215735.GA2700622@bhelgaas>
In-Reply-To: <20230210215735.GA2700622@bhelgaas>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 10 Feb 2023 14:22:20 -0800
X-Gmail-Original-Message-ID: <CAHk-=wi_W2OzOoZ4P2GuPV89UoQuFdbsaz5YQcGJdaMEzoOCdQ@mail.gmail.com>
Message-ID: <CAHk-=wi_W2OzOoZ4P2GuPV89UoQuFdbsaz5YQcGJdaMEzoOCdQ@mail.gmail.com>
Subject: Re: [GIT PULL] PCI fixes for v6.2
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
        Thomas Witt <kernel@witt.link>,
        Vidya Sagar <vidyas@nvidia.com>,
        Tasev Nikola <tasev.stefanoska@skynet.be>,
        Mark Enriquez <enriquezmark36@gmail.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Feb 10, 2023 at 1:57 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
>
> Note that we're moving PCI development to a shared git tree, so this
> pull request refers to the new tree.

Yeah, I saw the linux-next note, so I knew to expect it.

But thanks for the clarification regardless - the fewer surprises I
have in pull requests, the happier I tend to be ;)

               Linus
