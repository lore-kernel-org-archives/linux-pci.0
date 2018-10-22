Return-Path: <SRS0=Y6al=NC=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30C35C004D3
	for <linux-pci@archiver.kernel.org>; Mon, 22 Oct 2018 20:35:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4918620651
	for <linux-pci@archiver.kernel.org>; Mon, 22 Oct 2018 20:35:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4918620651
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728435AbeJWEzV (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 23 Oct 2018 00:55:21 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:54872 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726082AbeJWEzV (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 23 Oct 2018 00:55:21 -0400
Received: from mail-qt1-f199.google.com ([209.85.160.199])
        by youngberry.canonical.com with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
        (Exim 4.76)
        (envelope-from <gpiccoli@canonical.com>)
        id 1gEguz-0000eZ-Ey
        for linux-pci@vger.kernel.org; Mon, 22 Oct 2018 20:35:17 +0000
Received: by mail-qt1-f199.google.com with SMTP id o55-v6so18697318qto.0
        for <linux-pci@vger.kernel.org>; Mon, 22 Oct 2018 13:35:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=njm/2+k+jEm9TR+BsqHPmCGy6hpvgwIP/tX25dj+aqI=;
        b=GmL2yc0zvDQuVa2DcLTG99UhGa5gWVjZWT3mF3N/j+vLZinjUzR4HhAG8HHUPdvgQT
         tfGcCjRh0S3/AbPw6x40r5VETFLc74BOLIEQqMLxshA9G9gEa27FkImMQnxsMhSZQs1d
         f83MOueCZQyVwYZYeVL5A+kD64AVNqxhmEm09f0ks65Ympw3rM+Ai7Ue82V5ZlVjhyvQ
         k0LFWPYO/NkC8lB8zB/gCgL6qp6pYRZgRzwu7PsoywzPhfM9nkhNbYxCy95TzqIT+3Si
         TZ9uzrYEiOZvf8AgtiZvTuJwVX5eSzR2yD8ukwHVdXVedrhT8yZLveeBnOYloieX8qUa
         crSQ==
X-Gm-Message-State: ABuFfohfOulez73EqAx4kiGgZBKcQRZqoSW0BEqMB3Ij06X7EHqwPPvB
        xU8T8juO+4+yntnTr2yE40WL9YLUkoclt3WfsGai1Tx3PvMYHNAOmRxcp2/cMgrc37KHJy5gARB
        27GiGrBVLAGuJrsUNSGcAeY/DPw6hN/NFGeQPYg==
X-Received: by 2002:a37:f42:: with SMTP id z63-v6mr41535263qkg.132.1540240516580;
        Mon, 22 Oct 2018 13:35:16 -0700 (PDT)
X-Google-Smtp-Source: ACcGV60JV7hwPSNQWIMclog+tTFkwAIBMPPdTYh44l+JpWt+TsDLSwBtla0c6qXWecWh7KuMWOZJmA==
X-Received: by 2002:a37:f42:: with SMTP id z63-v6mr41535241qkg.132.1540240516297;
        Mon, 22 Oct 2018 13:35:16 -0700 (PDT)
Received: from [192.168.1.109] ([191.8.5.68])
        by smtp.gmail.com with ESMTPSA id s17-v6sm26293856qtj.31.2018.10.22.13.35.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 22 Oct 2018 13:35:15 -0700 (PDT)
Subject: Re: [PATCH 1/3] x86/quirks: Scan all busses for early PCI quirks
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org, kexec@lists.infradead.org,
        x86@kernel.org, linux-kernel@vger.kernel.org, bhelgaas@google.com,
        dyoung@redhat.com, bhe@redhat.com, vgoyal@redhat.com,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
        andi@firstfloor.org, lukas@wunner.de, billy.olsen@canonical.com,
        cascardo@canonical.com, ddstreet@canonical.com,
        fabiomirmar@canonical.com, gavin.guo@canonical.com,
        jay.vosburgh@canonical.com, kernel@gpiccoli.net, mfo@canonical.com,
        shan.gavin@linux.alibaba.com, gpiccoli@canonical.com
References: <20181018183721.27467-1-gpiccoli@canonical.com>
 <20181018221538.GN5906@bhelgaas-glaptop.roam.corp.google.com>
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
Message-ID: <d4e10c8d-aa39-7577-fbc8-0430ac44ba54@canonical.com>
Date:   Mon, 22 Oct 2018 17:35:06 -0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181018221538.GN5906@bhelgaas-glaptop.roam.corp.google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 18/10/2018 19:15, Bjorn Helgaas wrote:
> On Thu, Oct 18, 2018 at 03:37:19PM -0300, Guilherme G. Piccoli wrote:
> [...] 

> I don't want to expand the early quirk infrastructure unless there is
> absolutely no other way to solve this.  The early quirk stuff is
> x86-specific, and it's not obvious that this problem is x86-only.
> 
> This patch scans buses 0-255, but still only in domain 0, so it won't
> help with even more complicated systems that use other domains.
> 
> I'm not an IRQ expert, but it seems wrong to me that we are enabling
> this interrupt before we're ready for it.  The MSI should target an
> IOAPIC.  Can't that IOAPIC entry be masked until later?  I guess the
> kdump kernel doesn't know what MSI address the device might be using.
> 
> Could the IRQ core be more tolerant of this somehow, e.g., if it
> notices incoming interrupts with no handler, could it disable the
> IOAPIC entry and fall back to polling periodically until a handler is
> added?

Hi Bjorn, thanks for your quick reply.
I understand your point, but I think this is inherently an architecture
problem. No matter what solution we decide for, it'll need to be applied
in early boot time, like before the PCI layer gets initialized.

So, I think a first step would be to split the solution "timing" in 2
possibilities:

a) We could try to disable MSIs or whatever approach we take in the
quiesce path of crash_kexec(), before the bootstrap of the kdump kernel.
The pro is we could use PCI handlers to do it generically. The con is
it'd touch that delicate shutdown path, from a broken kernel, and this
is unreliable. Also, I've noticed changes in those crash paths
usually gain huge amount of criticism by community, seems nobody wants
to change a bit of this code, if not utterly necessary.

b) Continue using an early boot approach. IMO, this would be per-arch by
nature.
Currently, powerpc for example does not suffer this issue due to their
arch code performing a FW-aided PCI fundamental reset in the devices[0].
On the other hand, x86 has no generic fundamental reset infrastructure
to my knowledge (we tried some alternatives, like a Bridge reset[1] that
didn't work, or zeroing the the command register, which worked), but if
we go with the IOAPIC way of handling this (which we tried a bit and
failed too), it'll be even more arch-dependent, since IOAPIC is x86 concept.


After discussing here internally, an alternative way for this MSI
approach work without requiring the change in the early PCI
infrastructure is to check if we're in kdump kernel and perform manually
the full scan in that case, instead of changing the generic case as
proposed here. This would still be x86-only, but again, it's difficult
if not impossible to fix all archs using the same code here.

Finally, about multi-domain PCI topologies, I've never saw it on x86, I
wasn't aware that such things existed in x86 - but if required we can
quickly extend the logic to contemplate it too.

Thanks again, looking forward for you suggestions.
Cheers,


Guilherme

[0]
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/arch/powerpc/platforms/powernv/pci-ioda.c#n3992

[1] Based in https://patchwork.kernel.org/patch/2562841, adapted to work
in early boot time.
