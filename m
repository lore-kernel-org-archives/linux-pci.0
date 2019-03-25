Return-Path: <SRS0=Cb4Y=R4=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C62E1C10F06
	for <linux-pci@archiver.kernel.org>; Mon, 25 Mar 2019 11:36:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 949782085A
	for <linux-pci@archiver.kernel.org>; Mon, 25 Mar 2019 11:36:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Lr2ZUsum"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728563AbfCYLgt (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 25 Mar 2019 07:36:49 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:35753 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728869AbfCYLgs (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 25 Mar 2019 07:36:48 -0400
Received: by mail-wr1-f65.google.com with SMTP id w1so9744013wrp.2;
        Mon, 25 Mar 2019 04:36:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=6NmsYx14C2iuKGoSkyOzZFB1s44OGH6NVmqpG1tHguc=;
        b=Lr2ZUsumSLuLJeX9HtncXGb3EnGFv6SYAa0ycGgKUelYHGok9jJKIxXd81qXQ7Zmo5
         6D70XdIKVXnK12uo2/hM9OaeVzYlYRtgd/PIs8zCEBcxisTMjhU49QEbgdRm0PzZG4dr
         PlCJUtlkncsw3mlRLTNlHhpZxN8tVagtoamVwdasKiRUqIN3R0gjXZlDMiRG9iPD2EEY
         U/Ex0XTqId029c3Bgf2GgKRoGqqACZmSwDdCRFq5oZPcNc1+ojJXTYrcy26FDWxwUwHH
         LOGe9sNw22JOS3CazneM4PyuoOVjCwRCsg0K8oxnt7p8Sec1lOIQEZ4WDdlpIK9C0y+D
         mTOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=6NmsYx14C2iuKGoSkyOzZFB1s44OGH6NVmqpG1tHguc=;
        b=PQHeFJu/huU4Y8jF91jSljeUw7390UOYfXkV3HzjGRMBOLbsKUoC1TkYDkNSY9V7rB
         xM4+MR5/AJUaF1ycvD2FkNpAkWU6vE2v9xf4f+X/8UTHiLcaJUbf2dsbjjkZO/TWoQeQ
         1wnwHlGyu8tBKPgCSKwns4M6PjbwkPRUCV3tebpgEK2956GkSF9lCvcI7by/LMV6PCl6
         Vj6t6CFqHIZ89NTd1dG733BT4TCnrDmc07nTCi+7HJDb+PBwg3u9DWU0h3/GWA4PbPhg
         obaH/9SYYep3bXc/M9/6kOPjSkIqxR3k2m8Xn6+S7ONkdEMV9NSwxKHGlKqFfhVkL6wA
         0VnQ==
X-Gm-Message-State: APjAAAWAUg7eNFwcRDMwueh3zqG9tICNqtHwO+Ug+3sJeSK7Gzj2bTcC
        YxmpeW04kXzDNlAxXVHvcao=
X-Google-Smtp-Source: APXvYqxgkKXAIxf2LhFRLhwdXAiTZspTQEg/WtGjuEs9dbAmWCU9SnN39JuRmVHvY+bkZ7ieBYgxIA==
X-Received: by 2002:adf:f1c7:: with SMTP id z7mr16160750wro.274.1553513806887;
        Mon, 25 Mar 2019 04:36:46 -0700 (PDT)
Received: from [192.168.1.4] (ip-86-49-110-70.net.upcbroadband.cz. [86.49.110.70])
        by smtp.gmail.com with ESMTPSA id z7sm6319360wml.40.2019.03.25.04.36.45
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Mon, 25 Mar 2019 04:36:46 -0700 (PDT)
Subject: Re: [PATCH V3 4/6] PCI: rcar: Replace (8 * n) with (n << 3)
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     linux-pci <linux-pci@vger.kernel.org>,
        Marek Vasut <marek.vasut+renesas@gmail.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Phil Edworthy <phil.edworthy@renesas.com>,
        Simon Horman <horms+renesas@verge.net.au>,
        Wolfram Sang <wsa@the-dreams.de>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>
References: <20190323015359.7231-1-marek.vasut@gmail.com>
 <20190323015359.7231-4-marek.vasut@gmail.com>
 <CAMuHMdUCWHR9zLz0Ru41860UhpUdjRvDBxDFoA5CdaAFrONJmQ@mail.gmail.com>
From:   Marek Vasut <marek.vasut@gmail.com>
Openpgp: preference=signencrypt
Message-ID: <42898ac5-1385-cdad-6abc-f32096c8e74d@gmail.com>
Date:   Mon, 25 Mar 2019 12:34:46 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <CAMuHMdUCWHR9zLz0Ru41860UhpUdjRvDBxDFoA5CdaAFrONJmQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 3/25/19 9:26 AM, Geert Uytterhoeven wrote:
> Hi Marek,
> 
> On Sat, Mar 23, 2019 at 2:54 AM <marek.vasut@gmail.com> wrote:
>> From: Marek Vasut <marek.vasut+renesas@gmail.com>
>>
>> Replace (8 * n) with (n << 3) to make bit shift operations consistent.
>> No functional change.
>>
>> Signed-off-by: Marek Vasut <marek.vasut+renesas@gmail.com>
> 
> Thanks for your patch!
> 
> Where is the inconsistency? The driver consistently uses
>   1. multiplications for bit offset calculations,
>   2. shifts for bit field extraction or insertion.
> 
> While technically equivalent, I think your change makes the code harder
> to read: the values are multiplied by eight to convert from number of
> bytes to number of bits, so IMHO "BITS_PER_BYTE * n" would be more
> readable.

Sure

-- 
Best regards,
Marek Vasut
