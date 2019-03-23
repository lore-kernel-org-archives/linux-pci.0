Return-Path: <SRS0=AkHN=R2=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93507C10F03
	for <linux-pci@archiver.kernel.org>; Sat, 23 Mar 2019 01:54:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E84720896
	for <linux-pci@archiver.kernel.org>; Sat, 23 Mar 2019 01:54:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b2prGjXI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728256AbfCWByn (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 22 Mar 2019 21:54:43 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:40721 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727994AbfCWByn (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 22 Mar 2019 21:54:43 -0400
Received: by mail-wr1-f68.google.com with SMTP id t5so4198757wri.7;
        Fri, 22 Mar 2019 18:54:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=9qWWh9ZJFYNR/5LD4fn0UrOmpUtvZ4ux6rBII0fA2IE=;
        b=b2prGjXIrtloPn0KlZnXxDmhOir+rSA+VuFy2qYLCx+dizMyPuJLUPfl4Ax8FEc0F6
         f3CNRLdghipSo51HIBfWCoMHqONP7j+EyaXlbl7rDnA9fMzqwnXy9VcIYkC4kp4IELFv
         jReZU3K3YdoarFMEPhUnNfAloRC3Bn3CvjxpXsMWjFzCOLjawPh+mitKb8aGWKBM/QDL
         YU+HhU8lIaMjPjqbM4VLT24iiED+WeVbWrq85T27LjHHtOCEUXDSwuHnx9U3nc0u46L3
         23cxy77xBdOn06DFy7xSqzd+jrGJIraM9I+3tTgTR8jjHDQETBim5gQNkzqjIzt5cN45
         kNlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=9qWWh9ZJFYNR/5LD4fn0UrOmpUtvZ4ux6rBII0fA2IE=;
        b=Oac+aKtieLlesSjzuO2UWb/Zg4yjMg11gvzZh3nM5oJwXTvqfee3kC72aup2VefDeq
         JbPPCJ6UdxIv3WVLIxMG7edOFvhN84WJzSSXR5xvFXbH3NivBqoTlKZutbctzNgSHurK
         WzAlJP28zRy/f1ASm07BtVGlYNU0+5dY7VeD6OVjRCmQ78cLtxR9/AnjUAtGfl/uQoh+
         jSWk3BXDM3Ue/FC61a98V+BzwdAeYnXH8RYLP7kELjnHOX7XSs1u/EE2L9Xi4eVWmk1a
         K3GKPQ+gIJP0+SZYN6b5v7xQzvSgfM3JMs5rr7icKBytgvpqMi8OtIvIVN9R+7Ei4cqR
         dBdQ==
X-Gm-Message-State: APjAAAUtZuiym+1OBxE0hOmQ/YWAKWNPzGIexUOTBZ1VrcTaG6NZmp/P
        jXAXZP/VtbQjTAMtOp9edpy26PZ1
X-Google-Smtp-Source: APXvYqwV9Z28T6m1ybzCs/hleovszN9ROAFjyykO/iEmKZWoZVivsAzVXsTYHDsR2wlZw/mPM3Eciw==
X-Received: by 2002:adf:fb0c:: with SMTP id c12mr8604500wrr.123.1553306081563;
        Fri, 22 Mar 2019 18:54:41 -0700 (PDT)
Received: from [192.168.1.4] (ip-86-49-110-70.net.upcbroadband.cz. [86.49.110.70])
        by smtp.gmail.com with ESMTPSA id u7sm11426260wrn.44.2019.03.22.18.54.39
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Fri, 22 Mar 2019 18:54:40 -0700 (PDT)
Subject: Re: [PATCH V2 6/6] PCI: rcar: Allow 64bit MSI addresses
To:     Wolfram Sang <wsa@the-dreams.de>
Cc:     linux-pci@vger.kernel.org,
        Marek Vasut <marek.vasut+renesas@gmail.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Phil Edworthy <phil.edworthy@renesas.com>,
        Simon Horman <horms+renesas@verge.net.au>,
        linux-renesas-soc@vger.kernel.org
References: <20190322023844.18574-1-marek.vasut@gmail.com>
 <20190322023844.18574-6-marek.vasut@gmail.com> <20190322083411.GH1005@kunai>
From:   Marek Vasut <marek.vasut@gmail.com>
Openpgp: preference=signencrypt
Message-ID: <f7fe9f4a-b9b5-4f54-5f3c-e3b6556df07c@gmail.com>
Date:   Sat, 23 Mar 2019 02:52:05 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190322083411.GH1005@kunai>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 3/22/19 9:34 AM, Wolfram Sang wrote:
> 
>> -	rcar_pci_write_reg(pcie, 0, PCIEMSIAUR);
>> +	rcar_pci_write_reg(pcie, base >> 32, PCIEMSIAUR);
> 
> Seeing the in-depth discussion between you and Geert, I'll leave this to
> you guys :)

I think this fix is clear, the discussion is now rather about whether we
should allocate the reserved page with GFP_DMA32 and keep it in 32bit
address range or not.

I'll reword the commit message though.

-- 
Best regards,
Marek Vasut
