Return-Path: <SRS0=Cb4Y=R4=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79E70C4360F
	for <linux-pci@archiver.kernel.org>; Mon, 25 Mar 2019 19:44:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D3232075E
	for <linux-pci@archiver.kernel.org>; Mon, 25 Mar 2019 19:44:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hOiII7Aa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729626AbfCYToE (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 25 Mar 2019 15:44:04 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:40569 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729473AbfCYToE (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 25 Mar 2019 15:44:04 -0400
Received: by mail-wm1-f68.google.com with SMTP id z24so7164581wmi.5;
        Mon, 25 Mar 2019 12:44:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=9HC/hQLz+GaiTxBmVOJqYRfq5/MOf5kpL8Rlf691lgU=;
        b=hOiII7AaA3waKsd+5IQ98hHtonoIqFxIuXm6RvPaoIuc9ZG5UUobP7YZjmygKPfVZ0
         z1VFCLDnvHRCz/MerjhhXIIyEXwrwj0JTmbId+VPPAjEFDhX4I0j/ZRm1HQWRYAa2/GB
         VB4TEgf0YHt/7jZSgeDxi9YhUwYO7RfdG4d18V+YZkEh13IgEX+XM8Q+/GHzywzCBvsb
         7gMkenS0uPM9tZtaHRy0CJG4SwE05EGoi3AslRv6DV1CkNBq2a4FHa3Q5ADVmDnRo4ty
         Cg3nVTP8WsGxW/MUEemgP1qaBm1AFL4D6+UFM3qCVXfw22OCxaJLrLymWaVBuYQBxJ3y
         dk1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=9HC/hQLz+GaiTxBmVOJqYRfq5/MOf5kpL8Rlf691lgU=;
        b=HyczYSwVzMXjOTdN12tvqxNH+c4zEIfuW1//05GOjfCD7y8Ta0WN6xwt8vjy2TW82h
         BmxyLmxhh62AWStpRuljDH2JZkoZYCbWqiivngpXeEbPRAfb1DuCl5kxB24z85oqyDLE
         AN9ldZFElWKpot4UBdXcF9OABElCsyabyTh5UzplVJnYpa613S1tC3wnYbRO4nVzNWS9
         FdLMjyLDuMNSFCW4qWJ4ZTb5YWrPMRe5qBFbInYxoOAHHpQ1BPLTF7nceK7eEtYMVRtY
         y/S1BrcRgiSaoyyWauV/1ZQUpvUlzDfNDP46eJq3rVteHMaXX6EpGsevJfsK/mnJ/dlk
         wbGA==
X-Gm-Message-State: APjAAAWA45HK2ZFc7slYBU5Wg4AKSLmB4CUkNQzJvBinYc8QNyWpKS0v
        V9pg+F4B89WVFIxezSA8FhG1dWJm
X-Google-Smtp-Source: APXvYqyQcdPAq0lUG1/jPYInml+UxNE3/C6b/eVnLKs83b9qmatHAmNJS/Xckl7vAZv8DqMq4nT/Mw==
X-Received: by 2002:a1c:2b41:: with SMTP id r62mr12033897wmr.94.1553543042482;
        Mon, 25 Mar 2019 12:44:02 -0700 (PDT)
Received: from [192.168.1.4] (ip-86-49-110-70.net.upcbroadband.cz. [86.49.110.70])
        by smtp.gmail.com with ESMTPSA id f11sm22835606wrm.30.2019.03.25.12.44.01
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Mon, 25 Mar 2019 12:44:01 -0700 (PDT)
Subject: Re: [PATCH V2] PCI: rcar: Add the initialization of PCIe link in
 resume_noirq
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     linux-pci@vger.kernel.org,
        Kazufumi Ikeda <kaz-ikeda@xc.jp.nec.com>,
        Gaku Inami <gaku.inami.xw@bp.renesas.com>,
        Marek Vasut <marek.vasut+renesas@gmail.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Phil Edworthy <phil.edworthy@renesas.com>,
        Simon Horman <horms+renesas@verge.net.au>,
        Wolfram Sang <wsa@the-dreams.de>,
        linux-renesas-soc@vger.kernel.org
References: <20190217132441.15139-1-marek.vasut@gmail.com>
 <20190325165439.GA19135@e107981-ln.cambridge.arm.com>
From:   Marek Vasut <marek.vasut@gmail.com>
Openpgp: preference=signencrypt
Message-ID: <179c26e7-a7ad-6cca-eae7-9f5735dd159d@gmail.com>
Date:   Mon, 25 Mar 2019 20:44:00 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190325165439.GA19135@e107981-ln.cambridge.arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 3/25/19 5:54 PM, Lorenzo Pieralisi wrote:
> On Sun, Feb 17, 2019 at 02:24:41PM +0100, marek.vasut@gmail.com wrote:
>> From: Kazufumi Ikeda <kaz-ikeda@xc.jp.nec.com>
>>
>> Reestablish the PCIe link very early in the resume process in case it
>> went down to prevent PCI accesses from hanging the bus. Such accesses
>> can happen early in the PCI resume process, in the resume_noirq, thus
>> the link must be reestablished in the resume_noirq callback of the
>> driver.
>>
>> Signed-off-by: Kazufumi Ikeda <kaz-ikeda@xc.jp.nec.com>
>> Signed-off-by: Gaku Inami <gaku.inami.xw@bp.renesas.com>
>> Signed-off-by: Marek Vasut <marek.vasut+renesas@gmail.com>
>> Cc: Geert Uytterhoeven <geert+renesas@glider.be>
>> Cc: Phil Edworthy <phil.edworthy@renesas.com>
>> Cc: Simon Horman <horms+renesas@verge.net.au>
>> Cc: Wolfram Sang <wsa@the-dreams.de>
>> Cc: linux-renesas-soc@vger.kernel.org
>> ---
>> V2: - Use BIT() macro for (1 << n)
>>     - Since polling in rcar_pcie_wait_for_dl() uses udelay(), do not
>>       add extra changes to this function anymore
>>     - Make resume_noirq return early and clean up parenthesis therein
>> ---
>>  drivers/pci/controller/pcie-rcar.c | 20 ++++++++++++++++++++
>>  1 file changed, 20 insertions(+)
> 
> I applied it to pci/controller-fixes but the kbot barfed at it so we
> need to rework it.

Right, PMSR definition added, updated commit message retained, patch
resubmitted as V3.

-- 
Best regards,
Marek Vasut
