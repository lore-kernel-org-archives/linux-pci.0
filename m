Return-Path: <linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 698D4C2B9F8
	for <linux-pci@archiver.kernel.org>; Tue, 25 May 2021 18:01:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4419D613CC
	for <linux-pci@archiver.kernel.org>; Tue, 25 May 2021 18:01:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230253AbhEYSCt (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 25 May 2021 14:02:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230115AbhEYSCt (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 25 May 2021 14:02:49 -0400
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31DC7C061574;
        Tue, 25 May 2021 11:01:18 -0700 (PDT)
Received: by mail-pg1-x530.google.com with SMTP id e22so7627297pgv.10;
        Tue, 25 May 2021 11:01:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=TeZYAdDGyeDzBK7Uuv/anEpUix43foa4wq1t/9j/4P4=;
        b=tc9XCw/ZfgHw6v7ftwy7iXxVMRvj7anVsw36rlhGgg5C0rN840cbzeo3fmshnMKYoy
         g2vr4Du4LPEYINszDH0vePK7wD6kJe4s4AqQ5rMIXo767wMZjPuYW3Aot9jH93I7YYW7
         d9YDXqXSexoLZXf2EXgVt6ifojwzrE58f2tpGdS4jvxDo3MUnH6yc/ImJAsthF+kYTJb
         oemW7v1fmh/m41kn1V0xgy2kNx1yDW9mj10FtqJknVjQTy7oO0LguJ88zMG5d+2Izf/2
         1kkUkn+9Rwvxxa/vXC5B5KGZjm1LjfPXR1qLkTOTNzLZ1zsdWRf2bo5xHbIQb26OBufU
         sGUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=TeZYAdDGyeDzBK7Uuv/anEpUix43foa4wq1t/9j/4P4=;
        b=ROxmWVUYB43GQ4tVL/PzwYrBS0rErvQiNhVW+StEHO/rtyTG9zO15fVkLBDa8erAto
         T6fmC0O7QYF/RuLI6Rj4ea0h1B0W+McKsV4crFM/rjwFGgsSF1RoYGvJGtSvCM42jg5w
         w6+xpwZOjnr7xWaVpQJAEXFsN1nyM2+fRRhFnRKjWbV89VzSC7mItenJRGPahCeJ9oyt
         8Tbhljp/oqiz7ZaEPgcKtBlssqajCoePygA4+APlY3jwAIE1t/V00GXyhZn8w3N+TAbd
         4yS6kxmQu+PPWsgL8vrH4rH3kwFqhem7OGDyyX23jVDM71sc0AXrHiAfYTP6yDFhJfiT
         ZxQQ==
X-Gm-Message-State: AOAM530OD7VzompfnfbWEsuenDFsQmXpiqCguPA35T/URCAUpdEInIa6
        Ie4luN9Z/LTpPpfJYYhA/rA=
X-Google-Smtp-Source: ABdhPJyFDBlGvpriCvPY+gmay8POd1PRwgmeT0FvVlnp26Q3E3JF651h8GFqBFVkgjJEXrTdsnFBWg==
X-Received: by 2002:aa7:84d9:0:b029:2e4:e5d3:7eae with SMTP id x25-20020aa784d90000b02902e4e5d37eaemr23223138pfn.29.1621965677643;
        Tue, 25 May 2021 11:01:17 -0700 (PDT)
Received: from [10.67.49.104] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id q24sm14692569pgk.32.2021.05.25.11.01.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 May 2021 11:01:17 -0700 (PDT)
Subject: Re: [PATCH v1 0/4] PCI: brcmstb: Add panic handler and shutdown func
To:     Jim Quinlan <jim2101024@gmail.com>, linux-pci@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>,
        bcm-kernel-feedback-list@broadcom.com, james.quinlan@broadcom.com,
        nsaenz@kernel.org
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Jim Quinlan <jquinlan@broadcom.com>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-rpi-kernel@lists.infradead.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>
References: <20210427175140.17800-1-jim2101024@gmail.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <447c8997-c197-faa9-a3c2-0f89cd64b5e8@gmail.com>
Date:   Tue, 25 May 2021 11:01:14 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210427175140.17800-1-jim2101024@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 4/27/21 10:51 AM, Jim Quinlan wrote:
> v1 -- These commits were part of a previous pullreq but have
>       been split off because they are unrelated to said pullreq's
>       other more complex commits.
> 
> Jim Quinlan (4):
>   PCI: brcmstb: Check return value of clk_prepare_enable()
>   PCI: brcmstb: Give 7216 SOCs their own config type
>   PCI: brcmstb: Add panic/die handler to RC driver
>   PCI: brcmstb: add shutdown call to driver

Bjorn, Lorenzon, are you satisfied with these commits, any chance to get
get them reviewed and queued up?

Thanks!
-- 
Florian
