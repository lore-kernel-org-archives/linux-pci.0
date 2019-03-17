Return-Path: <SRS0=Lify=RU=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAF70C4360F
	for <linux-pci@archiver.kernel.org>; Sun, 17 Mar 2019 23:39:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AAB0D20872
	for <linux-pci@archiver.kernel.org>; Sun, 17 Mar 2019 23:39:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LriUeb19"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727510AbfCQXjy (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Sun, 17 Mar 2019 19:39:54 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:40408 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727426AbfCQXjx (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 17 Mar 2019 19:39:53 -0400
Received: by mail-wr1-f68.google.com with SMTP id t5so15069363wri.7;
        Sun, 17 Mar 2019 16:39:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:subject:to:cc:references:openpgp:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=BkyFX2YMIYf0fmTEP85BnFQvg3moQrQUpPFR1cnvTAg=;
        b=LriUeb19+2OamfT1oF6pjAjuU0SE8PRnUL8mrcBZNuVnNmcgHQFV3xL7MbbMIEev6C
         a/QZBroYHqNpMiwtiw3dY9WcKWy/dEPZPcSI/WrnIzGU0d1Zjt9N7M8cB1zu69JgaiLa
         zDupdS2wAqhOLeT2l192yzlS93yaY8kj0yc9k1xjH5BkAd/EiCN7EEh98kR/QR5rfDdE
         SDk9030N2DEGuWufROJvEQc//WDxsL1LhIHsI0XMUHfiBl3Ri1rIXUMN073vfGGRgHqG
         imzhQa/r+kwj2pk82IO9AsogDF0qKgnG3t8b/87GfbnHiOMe7D3bE0wOjmvWWROcAl7p
         OBew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:references:openpgp:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=BkyFX2YMIYf0fmTEP85BnFQvg3moQrQUpPFR1cnvTAg=;
        b=GY2mSPtaMclWwSTX0zep6RA0fDRpsYCT5B7NvhE9p0wp6tBlvd+NJGadxYLoJBmYMt
         xoeHaA4C9Uec4iji7/t0eEgWHG3g1dbHBiS+2Esws07DEo7C/CuGz/pvgr4WdTLTaV8T
         hK1tHe5Gn/Qjt9OcriQGnM9w+1sPofl34JVqBb37Be0+H3E37H9kAjfU/rMSnTi0Z7of
         AJ2z6kvbD0LcDrcyusDUyPYXSuILV1oalFL7rp7ffXwo75P4dx+xSeIUBOP4Y/vDQ1iO
         jlbg0/ia3v3AZtTsniAyLDFGQrziLHoqgfjOJkpMEPTqOn5oG5mcQSeXGCrHPUGmIY3m
         SGeg==
X-Gm-Message-State: APjAAAUqrxH8etkXggOo1h8WKkYbTr7iq7Db1tCiZEKtDc8lMRt3AjmX
        lKzUXmZZ85KEZMlEpIBYxKlE9WTA
X-Google-Smtp-Source: APXvYqzEzKGZuneuQ571IkpyENnrb0ngk72NbW6ZfbVCIs5kp1RsqMVtAUUlHhrq0uL4849q1YzILw==
X-Received: by 2002:adf:da45:: with SMTP id r5mr9680900wrl.84.1552865991273;
        Sun, 17 Mar 2019 16:39:51 -0700 (PDT)
Received: from [192.168.1.4] (ip-86-49-110-70.net.upcbroadband.cz. [86.49.110.70])
        by smtp.gmail.com with ESMTPSA id q2sm19528453wrd.46.2019.03.17.16.39.50
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Sun, 17 Mar 2019 16:39:50 -0700 (PDT)
From:   Marek Vasut <marek.vasut@gmail.com>
Subject: Re: [PATCH 2/3] PCI: rcar: Allow 64bit MSI addresses
To:     Wolfram Sang <wsa@the-dreams.de>
Cc:     linux-pci@vger.kernel.org,
        Marek Vasut <marek.vasut+renesas@gmail.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Phil Edworthy <phil.edworthy@renesas.com>,
        Simon Horman <horms+renesas@verge.net.au>,
        linux-renesas-soc@vger.kernel.org
References: <20190317000608.24881-1-marek.vasut@gmail.com>
 <20190317000608.24881-2-marek.vasut@gmail.com> <20190317091228.GB2268@kunai>
Openpgp: preference=signencrypt
Message-ID: <940fd646-0049-890a-ac00-8bc9361b2431@gmail.com>
Date:   Mon, 18 Mar 2019 00:37:07 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190317091228.GB2268@kunai>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 3/17/19 10:12 AM, Wolfram Sang wrote:
> On Sun, Mar 17, 2019 at 01:06:07AM +0100, marek.vasut@gmail.com wrote:
>> From: Marek Vasut <marek.vasut+renesas@gmail.com>
>>
>> The MSI address can be 64bit. Switch the data type used to hold the
>> result of virt_to_phys() to phys_addr_t to reflect it's properties
>> correctly and program the top 32bits of PA into PCIEMSIAUR.
>>
>> Signed-off-by: Marek Vasut <marek.vasut+renesas@gmail.com>
> 
> Looks sane. Not being a PCI expert, I wonder: Were we just lucky to not
> hit a 64-bit MSI address before?

I wonder about that, virt_to_phys(__get_free_pages(GFP_KERNEL, 0)) would
happily return 64bit address, but with the cards I tested (a few intel
NICs [igb, e1000e], PCIe NVME SSDs and xHCI HCD), I am getting the MSIs
either way.

> Is this tied to our 32-bit limitation?

This might be a question for the HW team. I would be tempted to
cautiously say yes.

-- 
Best regards,
Marek Vasut
