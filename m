Return-Path: <linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72801C71155
	for <linux-pci@archiver.kernel.org>; Mon, 30 Nov 2020 21:29:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1EA5D20857
	for <linux-pci@archiver.kernel.org>; Mon, 30 Nov 2020 21:29:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cVFQMyZc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387431AbgK3V3E (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 30 Nov 2020 16:29:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387413AbgK3V3D (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 30 Nov 2020 16:29:03 -0500
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAAC0C0613D2;
        Mon, 30 Nov 2020 13:28:17 -0800 (PST)
Received: by mail-pl1-x643.google.com with SMTP id u2so7205613pls.10;
        Mon, 30 Nov 2020 13:28:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=3gZIy7ZN9UMClLXLuA5LSLxZFm86PnDw+gWbncdJfRY=;
        b=cVFQMyZc6D9fnuH6se/RGaFK9RkmzedqswLV1RB83OzejGCiqec883Iq0qBRuiPwVA
         fNN1UPocvlglPMoaRVFNaJXAzFeHERWMqV8IXrNwS20ud7tBvAsBmuW/gfFxBobeK09A
         CG1ob+o+NbQhAA0SZT6CIys6HTl1cJpHYESH1rYn7EVEAoEugHKB2mJbnyzWBggY+G8s
         uTDAmOIThgOhwsS3v1iWLt9QItXZCsHjHuqpfKbGBh8sgJv8ba3Wn5mT8L3nYI3BcyWi
         FX0XI4nCOWkko7Iq6BZTVzkoG3LeEaEN+01gbheG1eW48WcqH51z3vuZW/VNfaT/wbPZ
         MIiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=3gZIy7ZN9UMClLXLuA5LSLxZFm86PnDw+gWbncdJfRY=;
        b=qqUBHQCfsh9JPR9eDKAnxZBXZnVfPz9VOOWoUBNM7H4yAlHzwtX3rh72IxvHNBGnYm
         vm+/kvcIILwJjWC3s0/xyIwwdeeEi6+yBNdHuhOkA9w+Vz21nHR4DoZv4BHIzOjN7+QO
         kqrdmCLjFFi20GztEnnRcfnEJ4yIqWsNArJTIpRFoMemH9MpYanz8vdsZihdJPwt0yvQ
         otZgTKxIV/P4eGI35qw1mUQ+6hzlk3tjYkQXp1wKHIIiPi6zMwZOT42M/BfPBv5vqach
         I91txtgnVoeGAKt+G6basIF0omkBV+VCrXrHZ1gPlObSVyX6D4BpgVDe/4NJEaxkl7QD
         z26Q==
X-Gm-Message-State: AOAM532mvFq3XDV8RBT2DR+tar4FVrsldTtIKnneTK0KDx27uT+wkYMc
        5vsmFEevTxwp6eENUpSOzsDYW1nVxIQ=
X-Google-Smtp-Source: ABdhPJz6vsodHX3BmBSQGJ2DsTWhyGuhWqagcnHGAf9BOucDywcnurPDOhoAW5ufYwkwg/Npudu/RA==
X-Received: by 2002:a17:902:a9c7:b029:d9:d985:55b1 with SMTP id b7-20020a170902a9c7b02900d9d98555b1mr20529983plr.59.1606771697074;
        Mon, 30 Nov 2020 13:28:17 -0800 (PST)
Received: from [10.230.28.242] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id u4sm1107904pgg.48.2020.11.30.13.28.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Nov 2020 13:28:16 -0800 (PST)
Subject: Re: [PATCH v2 5/6] PCI: brcmstb: Add panic/die handler to RC driver
To:     Jim Quinlan <james.quinlan@broadcom.com>,
        linux-pci@vger.kernel.org,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        broonie@kernel.org, bcm-kernel-feedback-list@broadcom.com
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-rpi-kernel@lists.infradead.org>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20201130211145.3012-1-james.quinlan@broadcom.com>
 <20201130211145.3012-6-james.quinlan@broadcom.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <8117e3d5-eac7-d686-98d8-7854c77c142e@gmail.com>
Date:   Mon, 30 Nov 2020 13:28:13 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <20201130211145.3012-6-james.quinlan@broadcom.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 11/30/2020 1:11 PM, Jim Quinlan wrote:
> Whereas most PCIe HW returns 0xffffffff on illegal accesses and the like,
> by default Broadcom's STB PCIe controller effects an abort.  This simple
> handler determines if the PCIe controller was the cause of the abort and if
> so, prints out diagnostic info.
> 
> Example output:
>   brcm-pcie 8b20000.pcie: Error: Mem Acc: 32bit, Read, @0x38000000
>   brcm-pcie 8b20000.pcie:  Type: TO=0 Abt=0 UnspReq=1 AccDsble=0 BadAddr=0
> 
> Signed-off-by: Jim Quinlan <james.quinlan@broadcom.com>

Acked-by: Florian Fainelli <f.fainelli@gmail.com>
-- 
Florian
