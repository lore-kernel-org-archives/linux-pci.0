Return-Path: <SRS0=Y6al=NC=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B748C004D3
	for <linux-pci@archiver.kernel.org>; Mon, 22 Oct 2018 19:44:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 52DDB2064C
	for <linux-pci@archiver.kernel.org>; Mon, 22 Oct 2018 19:44:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 52DDB2064C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726575AbeJWEEH (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 23 Oct 2018 00:04:07 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:54020 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726574AbeJWEEH (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 23 Oct 2018 00:04:07 -0400
Received: from mail-qt1-f200.google.com ([209.85.160.200])
        by youngberry.canonical.com with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
        (Exim 4.76)
        (envelope-from <gpiccoli@canonical.com>)
        id 1gEg7Z-0005hv-Fz
        for linux-pci@vger.kernel.org; Mon, 22 Oct 2018 19:44:13 +0000
Received: by mail-qt1-f200.google.com with SMTP id l6-v6so48976634qtc.12
        for <linux-pci@vger.kernel.org>; Mon, 22 Oct 2018 12:44:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=eUyIlQGhTyvcafDt/dNn2m1jS+3rFpyqLdPQF4hAjOQ=;
        b=qtKK2ctqdKYXVqKKLQfTIje00s1v6LR4CYQ13JMfjrofR1u5/Q3369G3RcxjVFEn1l
         SHtNO/sq6VBzXjG9qEkRk9t7DsaV9Kdr4LFzQotyjwPEZBvtTqm64xUluhSa990YyNnA
         U9OPDLtBcznQwZl8tXVIzLHUVjt7EwISsyXo4EWW7rK0CXDJlKFpSGR+q2mr2CCz41Nm
         hjhrIB9uXJ2K2CjTXoHSATZPXpPJ7gVQ4vV3XhC8c0ioF5dg7rSTYxtw7H25yB0LMzcZ
         0mpEau/o7scnINnHwMPjRHJ8v1ChiQR1RcKIkCs7rB7jjPtVYbC+Bt7lNXi8FGiXcduH
         1TpA==
X-Gm-Message-State: ABuFfogrFn2GYAzaT4USJ5pubvLuUMNXpzgN1qayoqMqGPbv/nAbj2P/
        DzsJhqxns1idYc1e4HCg6nPuKx3PvjDLAWuO/s6/umUpK505Fu3Uvxyrl5WiMStMWUNcNs2kHvJ
        ygnHV5EsGk5b6dIeBn1cY22pbxkUFejEsV9YnrQ==
X-Received: by 2002:aed:31c6:: with SMTP id 64-v6mr3583801qth.247.1540237452657;
        Mon, 22 Oct 2018 12:44:12 -0700 (PDT)
X-Google-Smtp-Source: AJdET5dSBZCETYQYFgm8Wg8VFA6LxzOyYH/MlaGZvJlmmEA7/rzQ/rdkRXSZ9uYl40ig27Z77UvTqw==
X-Received: by 2002:aed:31c6:: with SMTP id 64-v6mr3583786qth.247.1540237452498;
        Mon, 22 Oct 2018 12:44:12 -0700 (PDT)
Received: from [192.168.1.109] ([191.8.5.68])
        by smtp.gmail.com with ESMTPSA id x34-v6sm23935484qth.86.2018.10.22.12.44.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 22 Oct 2018 12:44:11 -0700 (PDT)
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
 <12d6175b-7f09-872a-61c4-700e905579c7@canonical.com>
 <50d84d48-eebf-ed91-8148-be727f76883f@kernel.org>
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
Message-ID: <92dc24c9-0963-e894-66fe-ad74bdbc0ac3@canonical.com>
Date:   Mon, 22 Oct 2018 16:44:04 -0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <50d84d48-eebf-ed91-8148-be727f76883f@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 18/10/2018 17:30, Sinan Kaya wrote:
> 
> AFAIK, all shutdown (not remove) routines are called before launching
> the next
> kernel even in crash scenario. It is not safe to start the new kernel while
> hardware is doing a DMA to the system memory and triggering interrupts.

Hi Sinan,

I agree with you, it's definitely not safe to start a new kernel with
in-flight DMA transactions, but in the crash scenario I think the
rationale was that running kernel is broken so it's even more unreliable
to try gracefully shutdown the devices than hope-for-the-best and start
the kdump kernel right away heheh

Fact is that the shutdown handlers are not called in the crash scenario.
They come from device_shutdown(), the code paths are as follow:

Regular kexec flow:

syscall_reboot()
  kernel_kexec()
    kernel_restart_prepare()
	  device_shutdown()
	machine_kexec()
	
Although if CONFIG_KEXEC_JUMP is set, it doesn't call device_shutdown()
either.


Crash kexec flow:
  __crash_kexec()
      machine_kexec()

There are some entry points to __crash_kexec(), like panic() or die() in
x86, for example.
To validate this, one can load a kernel with "initcall_debug" parameter,
and performs a kexec - if the shutdown handlers are called, there's a
dev_info() call that shows a message per device.


> Shutdown routine in PCI core used to disable MSI/MSI-x on behalf of all
> endpoints but it was later decided that this is the responsibility of the
> endpoint driver.
> 

This may be a good idea, using the pci layer to disable MSIs in the
quiesce path of the broken kernel. I'll follow-up this discussion in
Bjorn's reply.

Thanks,


Guilherme
