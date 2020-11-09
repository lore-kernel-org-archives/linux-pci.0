Return-Path: <SRS0=if19=EP=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EEF8C4742C
	for <linux-pci@archiver.kernel.org>; Mon,  9 Nov 2020 02:00:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C93B3206C1
	for <linux-pci@archiver.kernel.org>; Mon,  9 Nov 2020 02:00:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="onmQXo42"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728993AbgKICAr (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Sun, 8 Nov 2020 21:00:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728006AbgKICAr (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 8 Nov 2020 21:00:47 -0500
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12E0CC0613CF;
        Sun,  8 Nov 2020 18:00:47 -0800 (PST)
Received: by mail-pf1-x444.google.com with SMTP id 10so6546472pfp.5;
        Sun, 08 Nov 2020 18:00:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=M/sHCb58C+UKR7j7ExiS+JKwi2VJLyH2lrJ3bqK2Gik=;
        b=onmQXo42GH4QBPXq3aS2WWXLgb1MKDov2nWKuR1vw+Nqlex8CACmzk/QlKxG++KUid
         CJA7WJSPZEXJCq0ujAL37aCvtd3bJzVMqnRib+YvHXGHIYzlSqtlR4quJNzItzfXgCBL
         d+cO8T3QKbJanNEVf/B4EPcr1d6rDsKsrjcvD9bWNHmEZa0mZR4ypG8hcv9YQF5Y4mGE
         KJ87qn3gPziQuuKPpaoL1dPA4mVp4zjX45aMJey4TAnL/erlTxn9QnlUGxroiWBlO9yX
         X0PmPa/Pa9bpI2JrX99Rs0GJtaDE0U8514NYocm9F7skWCrh3wIRLYxW3EjSHtesCMLT
         N3AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=M/sHCb58C+UKR7j7ExiS+JKwi2VJLyH2lrJ3bqK2Gik=;
        b=UOWo/uiJlenzDNEhb5DnDevGEwi1g1de2+gGK2suBNSLd5fo2O2wj6cBNuhfl/omkr
         aDmowKyjuI5fwUx77MSHRCKheFnEMjd7HyhO461Ydt+KhBMJ+08XdSLZ1SN7FMcScgcT
         RWfeIwRKZEHkzfztWhbtlNgfHOsI9kAFM//HdlnjR2yIZx8A8/vLh5n3TDpRcSZBj/5W
         Yja7il9Q65dlR3bc5UKLfr0/CLabdFNiLnQbZYCc1Engv2vYco8xH17QFi7t9q0B0FI+
         QsVp5wFTQgBSGmuLlhyNp5rZ9Az8h5NwqCeR32fUS/y4tC8W1dGuUvdT4HHSrZ4ApgOi
         82tw==
X-Gm-Message-State: AOAM531j8ADpR9XDYW0LajVXLBwsG/c0wwCa0da33SrU7HsAhadTsvr6
        fU5lD/diXUZTjf+c/xlUjI8m8KZvQ+0=
X-Google-Smtp-Source: ABdhPJwsjUXczI5pQLNZEYEICG7A/fqZLAkG1tWOGAjdaTFRBrMn0njnEaj292o6jWFTgZrDMlhhTA==
X-Received: by 2002:a17:90b:1392:: with SMTP id hr18mr9783208pjb.116.1604887246258;
        Sun, 08 Nov 2020 18:00:46 -0800 (PST)
Received: from [192.168.1.3] (ip68-111-84-250.oc.oc.cox.net. [68.111.84.250])
        by smtp.gmail.com with ESMTPSA id x26sm9123491pfn.178.2020.11.08.18.00.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 08 Nov 2020 18:00:45 -0800 (PST)
Subject: Re: [PATCH] PCI: brcmstb: Remove irq handler and data in one go
To:     Martin Kaiser <martin@kaiser.cx>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Florian Fainelli <f.fainelli@gmail.com>
Cc:     bcm-kernel-feedback-list@broadcom.com,
        linux-rpi-kernel@lists.infradead.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20201108184208.19790-1-martin@kaiser.cx>
From:   Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <29cf71bd-197a-36e1-e931-9b7a60cf5830@gmail.com>
Date:   Sun, 8 Nov 2020 18:00:42 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.4.1
MIME-Version: 1.0
In-Reply-To: <20201108184208.19790-1-martin@kaiser.cx>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 11/8/2020 10:42 AM, Martin Kaiser wrote:
> Replace the two separate calls for removing the irq handler and data with a
> single irq_set_chained_handler_and_data() call.
> 
> Signed-off-by: Martin Kaiser <martin@kaiser.cx>

Acked-by: Florian Fainelli <f.fainelli@gmail.com>
-- 
Florian
