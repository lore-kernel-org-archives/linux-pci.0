Return-Path: <SRS0=Emu/=SZ=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	TVD_PH_BODY_ACCOUNTS_PRE,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B1F8C10F03
	for <linux-pci@archiver.kernel.org>; Tue, 23 Apr 2019 16:03:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B85020811
	for <linux-pci@archiver.kernel.org>; Tue, 23 Apr 2019 16:03:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="u18xq3oM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727180AbfDWQDI (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 23 Apr 2019 12:03:08 -0400
Received: from mail-it1-f196.google.com ([209.85.166.196]:55532 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726655AbfDWQDI (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 23 Apr 2019 12:03:08 -0400
Received: by mail-it1-f196.google.com with SMTP id y134so1005743itc.5;
        Tue, 23 Apr 2019 09:03:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=YNgfvaet4//5KCvC7rrD4VLrG69zAetrkMFWkNlVCxI=;
        b=u18xq3oM2aned0Grvi71+rh18cs4rTkfEeN9L14PCWY1wTvGhOMno8lFiOnIxqPgyt
         rS1QHrMjPI/FWX51A7pftsXl7tJnkcTdNxaG6FlwCFeJSM3xP8xniLLDwubsmcGqRDWu
         GoLxyqchn0QdSBSAYNgTms67H1Q92+EQ3k5SZcpaPcTBpyqgjMEaUI1JjWWzyY5jPEJ4
         /v4wDWiM35dFv+9zDXbimdczYIdOWDSp2hoAX35R+mkTEQ04HTbAzDGw7i7Z2qJtsbPX
         O3lt1hfd22diYtSy11f3fWx0Pi7GI8p6AQwFDugXg+TvO2lvTwaJZGSAkosmS4qLHlGC
         5IBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=YNgfvaet4//5KCvC7rrD4VLrG69zAetrkMFWkNlVCxI=;
        b=Vk1whSzf/6NyKQPruga8q1PKHnTXZvvDcGr2QdSNYepHmHyF8OjXAlOZXOtvnKC8Ha
         bqeW3JeS9zIezgdhQZvzUEMYwh2bs/42GBY27kzm/Rq7SgvEkb3QksjolwhKzwgf6fUJ
         n4T2PmimK3Vtpuxf0AkMzY9xBgLazWxyS0F574qo9BPKlVXXJ9FCJypNAt1wBbc3VnXz
         wC22oW4gKiIgmZ8c5jShBH/aWth696nKrFbXOs1czPqrsROPiuwzcmSODzKoWXkBdSxw
         4fbuzZE+BMS43pT5o2QSZPY5LDNk/47jPT0jdrRPs5/8ePYw1D38aw0lePPX+FZ4MsTN
         VXgQ==
X-Gm-Message-State: APjAAAULaG5VckcOSq7Bg2dfswYlU1YIIDagMEVV/hHA5E+dfEjtCdq/
        IILd5o/iMVY5o7KyGcvbJ3Ch6JM03GA=
X-Google-Smtp-Source: APXvYqwnV50h5unrBdqpgcrAwZQ28giHx6QIA9dcUMPR86ybntenQ45ERVq7zLxguxqO0nCUcebTLQ==
X-Received: by 2002:a24:70d5:: with SMTP id f204mr2620550itc.32.1556035387070;
        Tue, 23 Apr 2019 09:03:07 -0700 (PDT)
Received: from nukespec.gtech ([2601:2c1:8501:182d::6fe])
        by smtp.gmail.com with ESMTPSA id t67sm7814688ita.35.2019.04.23.09.03.05
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Tue, 23 Apr 2019 09:03:06 -0700 (PDT)
Subject: Re: [PATCH] PCI/LINK: Account for BW notification in vector
 calculation
To:     Alex Williamson <alex.williamson@redhat.com>
Cc:     bhelgaas@google.com, helgaas@kernel.org, linux-pci@vger.kernel.org,
        austin_bolen@dell.com, alex_gagniuc@dellteam.com,
        keith.busch@intel.com, Shyam_Iyer@Dell.com, lukas@wunner.de,
        okaya@kernel.org, torvalds@linux-foundation.org,
        linux-kernel@vger.kernel.org
References: <155597243666.19387.1205950870601742062.stgit@gimli.home>
 <d1126250-14e0-192c-f219-f143f62c9cdd@gmail.com>
 <20190422183347.51ba522c@x1.home>
 <84300da7-9bbd-4f32-c7fa-23724db60b88@gmail.com>
 <20190423093408.16b07efc@x1.home>
From:   Alex G <mr.nuke.me@gmail.com>
Message-ID: <88bd2962-bce4-8259-c38f-1a7e9fdde300@gmail.com>
Date:   Tue, 23 Apr 2019 11:03:04 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190423093408.16b07efc@x1.home>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 4/23/19 10:34 AM, Alex Williamson wrote:
> On Tue, 23 Apr 2019 09:33:53 -0500
> Alex G <mr.nuke.me@gmail.com> wrote:
> 
>> On 4/22/19 7:33 PM, Alex Williamson wrote:
>>> On Mon, 22 Apr 2019 19:05:57 -0500
>>> Alex G <mr.nuke.me@gmail.com> wrote:
>>>> echo 0000:07:00.0:pcie010 |
>>>> sudo tee /sys/bus/pci_express/drivers/pcie_bw_notification/unbind
>>>
>>> That's a bad solution for users, this is meaningless tracking of a
>>> device whose driver is actively managing the link bandwidth for power
>>> purposes.
>>
>> 0.5W savings on a 100+W GPU? I agree it's meaningless.
> 
> Evidence?  Regardless, I don't have control of the driver that's making
> these changes, but the claim seems unfounded and irrelevant.

The number of 5mW/Gb/lane doesn't ring a bell? [1] [2]. Your GPU 
supports 5Gb/s, so likely using an older, more power hungry process. I 
suspect it's still within the same order of magnitude.


> I'm assigning a device to a VM [snip]
> I can see why we might want to be notified of degraded links due to signal issues,
> but what I'm reporting is that there are also entirely normal reasons
> [snip] we can't seem to tell the difference

Unfortunately, there is no way in PCI-Express to distinguish between an 
expected link bandwidth change and one due to error.

If you're using virt-manager to configure the VM, then virt-manager 
could have a checkbox to disable link bandwidth management messages. I'd 
rather we avoid kernel-side heuristics (like Lukas suggested). If you're 
confident that your link will operate as intended, and don't want 
messages about it, that's your call as a user -- we shouldn't decide 
this in the kernel.

Alex

[1] 
https://www.synopsys.com/designware-ip/technical-bulletin/reduce-power-consumption.html
