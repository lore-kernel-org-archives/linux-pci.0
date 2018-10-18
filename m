Return-Path: <SRS0=PAID=M6=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5376ECDE43
	for <linux-pci@archiver.kernel.org>; Thu, 18 Oct 2018 20:16:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7815021476
	for <linux-pci@archiver.kernel.org>; Thu, 18 Oct 2018 20:16:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7815021476
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727497AbeJSESk (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 19 Oct 2018 00:18:40 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:36227 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725751AbeJSESk (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 19 Oct 2018 00:18:40 -0400
Received: from mail-qk1-f199.google.com ([209.85.222.199])
        by youngberry.canonical.com with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
        (Exim 4.76)
        (envelope-from <gpiccoli@canonical.com>)
        id 1gDEfZ-0004y8-OY
        for linux-pci@vger.kernel.org; Thu, 18 Oct 2018 20:13:21 +0000
Received: by mail-qk1-f199.google.com with SMTP id d1-v6so32189299qkb.11
        for <linux-pci@vger.kernel.org>; Thu, 18 Oct 2018 13:13:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=pY9fF3y7ko3CIeAy09wuBj7o7o7f3GDfrsn6c5L5guo=;
        b=Lpw94A+4bY7PHD/EYsTlv1m33QnqmpMxhYd9+uYNwxEcQgB2Uk86W8FFnrLB9wPUNK
         p4QBv1qrtIY9bPt6ShrSPl0B3nn+1iZbNBOFCD5rjCAQ1n01BPty+ejqcSOnpql7/Tex
         mWgkJrzYJu1BD8LROcGXDG6EBKpAHmiCO2w8AU6ZMQyGdCg6Zo6WYVIxsQmlQV5Sl7ec
         9F/NEpLhVL6uEenQM15B7lAs7tM+N5J2443ULg8swr6R2vUkFI1cI2YqURY1itj0UDuz
         LUH1r/caCwjHDUOHRgWmlPqJjj/PIjjKIBzeOdQRBYMkP+3dZQ4t4M7J3TvueV8FhAwL
         dJmw==
X-Gm-Message-State: ABuFfoiueT3LBZTl9mEa0d3HJYToFZpVhFPAwQJVcM4m3jGu25+999mg
        tt0LzKKtHF1efHjEY5PTkNh2fZohU9paeSr7Qh1M55nhzihnZCuJiIJm0giO9D3Lu/EPDJ6zVvZ
        8kix3idCu/OgirjtBb6Ge8yo5l2Gr0E+6A0qV3Q==
X-Received: by 2002:a37:1a59:: with SMTP id a86-v6mr30906909qka.191.1539893600914;
        Thu, 18 Oct 2018 13:13:20 -0700 (PDT)
X-Google-Smtp-Source: ACcGV62jyxwztALP3yEzT5cAV0FFHYF3NQLYwrF0wgOzUxriUhBjLA4ZdRzDHTKev4tlGCWPJszzwQ==
X-Received: by 2002:a37:1a59:: with SMTP id a86-v6mr30906878qka.191.1539893600744;
        Thu, 18 Oct 2018 13:13:20 -0700 (PDT)
Received: from [192.168.1.109] ([179.225.132.84])
        by smtp.gmail.com with ESMTPSA id y124-v6sm12594882qke.22.2018.10.18.13.13.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 18 Oct 2018 13:13:19 -0700 (PDT)
Subject: Re: [PATCH 3/3] x86/quirks: Add parameter to clear MSIs early on boot
To:     Sinan Kaya <okaya@kernel.org>, linux-pci@vger.kernel.org,
        kexec@lists.infradead.org, x86@kernel.org
Cc:     linux-kernel@vger.kernel.org, bhelgaas@google.com,
        dyoung@redhat.com, bhe@redhat.com, vgoyal@redhat.com,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
        andi@firstfloor.org, lukas@wunner.de, billy.olsen@canonical.com,
        cascardo@canonical.com, ddstreet@canonical.com,
        fabiomirmar@canonical.com, gavin.guo@canonical.com,
        jay.vosburgh@canonical.com, kernel@gpiccoli.net, mfo@canonical.com,
        shan.gavin@linux.alibaba.com
References: <20181018183721.27467-1-gpiccoli@canonical.com>
 <20181018183721.27467-3-gpiccoli@canonical.com>
 <6fd4e2d2-c0ac-b26d-9a14-0379b4421679@kernel.org>
From:   "Guilherme G. Piccoli" <gpiccoli@canonical.com>
Openpgp: preference=signencrypt
Autocrypt: addr=gpiccoli@canonical.com; prefer-encrypt=mutual; keydata=
 xsBNBFpVBxcBCADPNKmu2iNKLepiv8+Ssx7+fVR8lrL7cvakMNFPXsXk+f0Bgq9NazNKWJIn
 Qxpa1iEWTZcLS8ikjatHMECJJqWlt2YcjU5MGbH1mZh+bT3RxrJRhxONz5e5YILyNp7jX+Vh
 30rhj3J0vdrlIhPS8/bAt5tvTb3ceWEic9mWZMsosPavsKVcLIO6iZFlzXVu2WJ9cov8eQM/
 irIgzvmFEcRyiQ4K+XUhuA0ccGwgvoJv4/GWVPJFHfMX9+dat0Ev8HQEbN/mko/bUS4Wprdv
 7HR5tP9efSLucnsVzay0O6niZ61e5c97oUa9bdqHyApkCnGgKCpg7OZqLMM9Y3EcdMIJABEB
 AAHNLUd1aWxoZXJtZSBHLiBQaWNjb2xpIDxncGljY29saUBjYW5vbmljYWwuY29tPsLAdwQT
 AQgAIQUCWmClvQIbAwULCQgHAgYVCAkKCwIEFgIDAQIeAQIXgAAKCRDOR5EF9K/7Gza3B/9d
 5yczvEwvlh6ksYq+juyuElLvNwMFuyMPsvMfP38UslU8S3lf+ETukN1S8XVdeq9yscwtsRW/
 4YoUwHinJGRovqy8gFlm3SAtjfdqysgJqUJwBmOtcsHkmvFXJmPPGVoH9rMCUr9s6VDPox8f
 q2W5M7XE9YpsfchS/0fMn+DenhQpV3W6pbLtuDvH/81GKrhxO8whSEkByZbbc+mqRhUSTdN3
 iMpRL0sULKPVYbVMbQEAnfJJ1LDkPqlTikAgt3peP7AaSpGs1e3pFzSEEW1VD2jIUmmDku0D
 LmTHRl4t9KpbU/H2/OPZkrm7809QovJGRAxjLLPcYOAP7DUeltvezsBNBFpVBxcBCADbxD6J
 aNw/KgiSsbx5Sv8nNqO1ObTjhDR1wJw+02Bar9DGuFvx5/qs3ArSZkl8qX0X9Vhptk8rYnkn
 pfcrtPBYLoux8zmrGPA5vRgK2ItvSc0WN31YR/6nqnMfeC4CumFa/yLl26uzHJa5RYYQ47jg
 kZPehpc7IqEQ5IKy6cCKjgAkuvM1rDP1kWQ9noVhTUFr2SYVTT/WBHqUWorjhu57/OREo+Tl
 nxI1KrnmW0DbF52tYoHLt85dK10HQrV35OEFXuz0QPSNrYJT0CZHpUprkUxrupDgkM+2F5LI
 bIcaIQ4uDMWRyHpDbczQtmTke0x41AeIND3GUc+PQ4hWGp9XABEBAAHCwF8EGAEIAAkFAlpV
 BxcCGwwACgkQzkeRBfSv+xv1wwgAj39/45O3eHN5pK0XMyiRF4ihH9p1+8JVfBoSQw7AJ6oU
 1Hoa+sZnlag/l2GTjC8dfEGNoZd3aRxqfkTrpu2TcfT6jIAsxGjnu+fUCoRNZzmjvRziw3T8
 egSPz+GbNXrTXB8g/nc9mqHPPprOiVHDSK8aGoBqkQAPZDjUtRwVx112wtaQwArT2+bDbb/Y
 Yh6gTrYoRYHo6FuQl5YsHop/fmTahpTx11IMjuh6IJQ+lvdpdfYJ6hmAZ9kiVszDF6pGFVkY
 kHWtnE2Aa5qkxnA2HoFpqFifNWn5TyvJFpyqwVhVI8XYtXyVHub/WbXLWQwSJA4OHmqU8gDl
 X18zwLgdiQ==
Message-ID: <12d6175b-7f09-872a-61c4-700e905579c7@canonical.com>
Date:   Thu, 18 Oct 2018 17:13:10 -0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <6fd4e2d2-c0ac-b26d-9a14-0379b4421679@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 18/10/2018 17:08, Sinan Kaya wrote:
> On 10/18/2018 2:37 PM, Guilherme G. Piccoli wrote:
>> We observed a kdump failure in x86 that was narrowed down to MSI irq
>> storm coming from a PCI network device. The bug manifests as a lack of
>> progress in the boot process of kdump kernel, and a flood of kernel
>> messages like:
>>
>> [...]
>> [ 342.265294] do_IRQ: 0.155 No irq handler for vector
>> [ 342.266916] do_IRQ: 0.155 No irq handler for vector
>> [ 347.258422] do_IRQ: 14053260 callbacks suppressed
>> [...]
> 
> These kind of issues are usually fixed by fixing the network driver's
> shutdown routine to ensure that MSI interrupts are cleared there.


Sinan, I'm not sure shutdown handlers for drivers are called in panic
kexec (I remember of an old experiment I did, loading a kernel
with "kexec -p" didn't trigger the handlers).

But this case is even worse, because the NICs were in PCI passthrough
mode, using vfio. So, they were completely unaware of what happened
in the host kernel.

Also, this is spec compliant - system reset events should guarantee the
bits are cleared (although kexec is not exactly a system reset, it's
similar)

Cheers,


Guilherme
