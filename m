Return-Path: <SRS0=17ui=7B=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEEA2C433DF
	for <linux-pci@archiver.kernel.org>; Tue, 19 May 2020 20:48:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7799B207C4
	for <linux-pci@archiver.kernel.org>; Tue, 19 May 2020 20:48:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R6RNR5Lp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726178AbgESUsO (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 19 May 2020 16:48:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726064AbgESUsO (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 19 May 2020 16:48:14 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49F5FC08C5C0;
        Tue, 19 May 2020 13:48:14 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id v12so847993wrp.12;
        Tue, 19 May 2020 13:48:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=xpflJiHU4zdLwZmN90LpEKHltXEDRGXrv+qECzfEDLY=;
        b=R6RNR5LpenqpOy8zl32M3K5RWFabYRpxWc+rJqjfraCKJBG/47W1hLMw/abkWqUKsC
         5dHXVYTgQYvDbF/9j9Kv07dSjMRUOUO0Es99q6bWoNHF+wZ5SHYuUjhLx/LbT5OL1CMt
         K2frgmRKnRl2VXK/4TCe56y6MeJ5wXXbm9fM4ZZeL7l1fGRndBjhcHyjv2r6+t7caXTg
         6HexwpWvXo+fFnJwGT/BHyDdq3Y51aNPa6EBnfC5TcQucYN2YX+Sqxb6t/M+eOI3E6QY
         muD8VhJwzJ11hqGozQ1GaW975jm9h9OkiGVIhJPIj3uCn1M1SJJBwDnV3ZryCd+DxJ6n
         zTbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=xpflJiHU4zdLwZmN90LpEKHltXEDRGXrv+qECzfEDLY=;
        b=uoXR2nOW7HRq86YQEh7xTm+OfOffvDS028SlYFRphC4rw5+bTsa2z4LHo3RDcSiJxK
         mIhIXREM+ECevDPZZVgpCcPjiDdusN8tRMIgYdAkbkFQLQsT7jj64/pgm9eRyh3MiCPp
         KMKES8Bdof3g6s9wHMpqQYF6qdck5bKUOKO83189P296lZGeKYoog7yrkdI1AyuH2BIL
         GPtNOSkQZ3ocuqx4D2ACpNLqJ/NPVoKvmZVftGA03bEegX0pIcZrfW0lD2vSpgnUDKr5
         f6lZ1pTVvtqbWTwUJ6cOnl2euuum4NJhppROe2clhs3Wa9JChpb+SGcCcy/hioa55ijW
         6ZvA==
X-Gm-Message-State: AOAM53024DrJ2XF8ZR2HzI6JBlH7FJfoc3gKmRyEupd4jR1Cd4GGfjch
        GoS9sXQgPOJaXqts2XZ6Z7kLNsX4
X-Google-Smtp-Source: ABdhPJzff/nSXmDRXjYiiCeSKwygMSzTnguy0cU8QBNRytDiAXTnUKP4QM/Pd3b8OU8/Z1xJr6eMlA==
X-Received: by 2002:a05:6000:128b:: with SMTP id f11mr705232wrx.227.1589921292548;
        Tue, 19 May 2020 13:48:12 -0700 (PDT)
Received: from [10.230.188.43] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id 77sm676543wrc.6.2020.05.19.13.48.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 May 2020 13:48:11 -0700 (PDT)
Subject: Re: [PATCH 01/15] PCI: brcmstb: PCIE_BRCMSTB depends on ARCH_BRCMSTB
To:     Jim Quinlan <james.quinlan@broadcom.com>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "open list:PCI NATIVE HOST BRIDGE AND ENDPOINT DRIVERS" 
        <linux-pci@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20200519203419.12369-1-james.quinlan@broadcom.com>
 <20200519203419.12369-2-james.quinlan@broadcom.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <0ad02f06-f191-4b69-322b-aa7733f700ae@gmail.com>
Date:   Tue, 19 May 2020 13:48:09 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Firefox/68.0 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200519203419.12369-2-james.quinlan@broadcom.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 5/19/2020 1:33 PM, Jim Quinlan wrote:
> From: Jim Quinlan <jquinlan@broadcom.com>
> 
> Have PCIE_BRCMSTB depend on ARCH_BRCMSTB.  Also set the
> default value to ARCH_BRCMSTB.
> 
> Signed-off-by: Jim Quinlan <jquinlan@broadcom.com>

Acked-by: Florian Fainelli <f.fainelli@gmail.com>
-- 
Florian
