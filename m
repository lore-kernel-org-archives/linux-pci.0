Return-Path: <SRS0=wh2u=NR=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1465EC32789
	for <linux-pci@archiver.kernel.org>; Tue,  6 Nov 2018 10:32:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BCA2720862
	for <linux-pci@archiver.kernel.org>; Tue,  6 Nov 2018 10:32:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C0L7hlRy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BCA2720862
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387472AbeKFT5V (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 6 Nov 2018 14:57:21 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:45226 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387532AbeKFT5U (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 6 Nov 2018 14:57:20 -0500
Received: by mail-wr1-f67.google.com with SMTP id k15-v6so9881329wre.12;
        Tue, 06 Nov 2018 02:32:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=iN0aG3OOqq5FvUhm/IS5rTfns4YtsA6Kw9pNKDt/S3g=;
        b=C0L7hlRylWktptgPgb3mQBKvKzdg0c8A/1pd3aiZErEejtwPuSxTvMqzvKBB/TilEI
         5pMvWvPC6SeYBPBP5VzNCTuTm8PLBkg676AN9mRziLEA7oxThAUcelzu6tmtnHEDxIkj
         kqEdd3XDVt9okGcJWA3/B0yE+GKUYr9RQjDoJYFW0zKqs51twyue+/FbDbgCUJpp3Lbu
         ckxpEGAJGaZ87nh8qiE+zi4lRAsaEC3UL8LK1RNAso5Fpmm0M7uwZ5E/dCpakKirYV9n
         sSg+ZRK+E3poUUR2hdKgFaxWFSlHIJ3yKn49jFVVz/U+h3R2Vv1wWM/PnULyr4/4AEc5
         e39g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=iN0aG3OOqq5FvUhm/IS5rTfns4YtsA6Kw9pNKDt/S3g=;
        b=maR8Fm8HFBXFKQF8wWCDOKGVWMQmxUoJKa7RFB4HUYYU7xlmggA0DeFLS/7mDUI1iV
         FFBdSQB6qHdx4dohRzlwFX/5ZezAQ1kzxQC0AQnntqzTU3/JHe3lvPXfQcuPVeukJoc9
         fcXnttj9zKeWIO8qRNaPIGNBw5UkhMtLnclVkgas4l8ipzPrGvvDwM1wldJrxwDVftzp
         ciu165A9Pc7nBZmL/0ZLv3pr3/TQhzJG/tOe6AEU3HVHCaj4JPldPWw/TkQuq6iHF/HE
         GAzu+erZIs0Fxl8xillirPhaFpKO0leZZrCfnwXAAhivnosgpGvqQOK6fIbzBoXLAPa4
         LteQ==
X-Gm-Message-State: AGRZ1gIjfA+BjW8939J/97KCPNFvZcIUjQ1xhbTjLJyTgjWW9XMC8rYH
        tCQaF1398jqTFHqt0haQybQ=
X-Google-Smtp-Source: AJdET5exziMl+H1MN6MBhnW3gxlATr1BDpZ6Y7O/ApAeBNmnnDPVtGMBwS9Lm8SQ7IIN0q6FlZaCpQ==
X-Received: by 2002:a5d:650c:: with SMTP id x12-v6mr23805517wru.150.1541500365677;
        Tue, 06 Nov 2018 02:32:45 -0800 (PST)
Received: from [192.168.1.4] (ip-86-49-110-70.net.upcbroadband.cz. [86.49.110.70])
        by smtp.gmail.com with ESMTPSA id j4-v6sm10954301wrp.68.2018.11.06.02.32.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 06 Nov 2018 02:32:44 -0800 (PST)
Subject: Re: [RFC][PATCH] PCI: Avoid PCI device removing/rescanning through
 sysfs triggers a deadlock
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     linux-pci <linux-pci@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        tho.vu.wh@rvc.renesas.com
References: <20181105232500.19146-1-marek.vasut+renesas@gmail.com>
 <CAMuHMdX2WKtVnzhfWTTXamXgWvtYhvJjAE1bBz9vd8UHK2rO6g@mail.gmail.com>
From:   Marek Vasut <marek.vasut@gmail.com>
Message-ID: <4a7ae74e-fc86-cce1-8b99-bb9b825df590@gmail.com>
Date:   Tue, 6 Nov 2018 10:45:27 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <CAMuHMdX2WKtVnzhfWTTXamXgWvtYhvJjAE1bBz9vd8UHK2rO6g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 11/06/2018 09:13 AM, Geert Uytterhoeven wrote:
> Hi Marek,
> 
> Thanks for your patch!
> 
> On Tue, Nov 6, 2018 at 12:25 AM Marek Vasut <marek.vasut@gmail.com> wrote:
>> From: Tho Vu <tho.vu.wh@rvc.renesas.com>
>>
>> This patch fixes deadlock warning in removing/rescanning through sysfs
>> when CONFIG_PROVE_LOCKING is enabled.
>>
>> The issue can be reproduced by these steps:
>> 1. Enable CONFIG_PROVE_LOCKING via defconfig or menuconfig
>> 2. Insert Ethernet card into PCIe CH0 and start up.
>>    After kernel starting up, execute the following command.
>>    echo 1 > /sys/class/pci_bus/0000\:00/device/0000\:00\:00.0/remove
>> 3. Rescan PCI device by this command
>>    echo 1 > /sys/class/pci_bus/0000\:00/rescan
>>
>> The deadlock warnings will occur.
>> ============================================
>> WARNING: possible recursive locking detected
>> 4.14.70-ltsi-yocto-standard #27 Not tainted
>> --------------------------------------------
>> sh/3402 is trying to acquire lock:
>>  (kn->count#78){++++}, at: kernfs_remove_by_name_ns+0x50/0xa8
>>
>> but task is already holding lock:
>>  (kn->count#78){++++}, at: kernfs_remove_self+0xe0/0x130
>>
>> other info that might help us debug this:
>>  Possible unsafe locking scenario:
>>
>>        CPU0
>>        ----
>>   lock(kn->count#78);
>>   lock(kn->count#78);
>>
>>  *** DEADLOCK ***
>>
>>  May be due to missing lock nesting notation
>>
>> 4 locks held by sh/3402:
>>  #0:  (sb_writers#4){.+.+}, at: vfs_write+0x198/0x1b0
>>  #1:  (&of->mutex){+.+.}, at: kernfs_fop_write+0x108/0x210
>>  #2:  (kn->count#78){++++}, at: kernfs_remove_self+0xe0/0x130
>>  #3:  (pci_rescan_remove_lock){+.+.}, at: pci_lock_rescan_remove+0x1c/0x28
>>
>> stack backtrace:
>> CPU: 3 PID: 3402 Comm: sh Not tainted 4.14.70-ltsi-yocto-standard #27
>> Hardware name: Renesas Salvator-X 2nd version board based on r8a7795
>> ES3.0+ with 8GiB (4 x 2 GiB) (DT)
>> Call trace:
>> dump_backtrace+0x0/0x3d8
>> show_stack+0x14/0x20
>> dump_stack+0xbc/0xf4
>> __lock_acquire+0x930/0x18a8
>> lock_acquire+0x48/0x68
>> __kernfs_remove+0x280/0x2f8
>> kernfs_remove_by_name_ns+0x50/0xa8
>> remove_files.isra.0+0x38/0x78
>> sysfs_remove_group+0x4c/0xa0
>> sysfs_remove_groups+0x38/0x60
>> device_remove_attrs+0x54/0x78
>> device_del+0x1ac/0x308
>> pci_remove_bus_device+0x78/0xf8
>> pci_remove_bus_device+0x34/0xf8
>> pci_stop_and_remove_bus_device_locked+0x24/0x38
>> remove_store+0x6c/0x78
>> dev_attr_store+0x18/0x28
>> sysfs_kf_write+0x4c/0x78
>> kernfs_fop_write+0x138/0x210
>> __vfs_write+0x18/0x118
>> vfs_write+0xa4/0x1b0
>> SyS_write+0x48/0xb0
>>
>> This warning occurs due to a self-deletion attribute using in the sysfs
> 
> used
> 
>> PCI device directory. This kind of attribute is really tricky,
>> it does not allow pci framework drop this attribute until all active
> 
> to drop
> 
>> .show() and .store() callbacks have finished unless
> 
> finished, unless
> 
>> sysfs_break_active_protection() is called.
>> Hence this patch avoids writing into this attribute triggers a deadlock.
> 
> and trigger a deadlock.
> 
>>
>> Referrence commit 5b55b24cec4c ("scsi: core: Avoid that SCSI device
>> removal through sysfs triggers a deadlock")
>> of scsi driver
>>
>> Signed-off-by: Tho Vu <tho.vu.wh@rvc.renesas.com>
> 
> You forgot to append your own SoB?
> 
>> --- a/drivers/pci/pci-sysfs.c
>> +++ b/drivers/pci/pci-sysfs.c
>> @@ -470,12 +470,22 @@ static ssize_t remove_store(struct device *dev, struct device_attribute *attr,
>>                             const char *buf, size_t count)
>>  {
>>         unsigned long val;
>> +       struct kernfs_node *kn;
>> +
>> +       kn = sysfs_break_active_protection(&dev->kobj, &attr->attr);
>> +       WARN_ON_ONCE(!kn);
> 
> What's the purpose of the WARN_ON_ONCE? Just copied from the SCSI solution?
> Can this ever happen?

I sent the patch as-is from the BSP after a short discussion with Bjorn
on IRC, mostly because it contains the description of the problem. I
don't think this is the right solution, it feels more like a hack to me,
which is why I flagged it as RFC.

Or do you think this is the correct way of solving the problem ?

-- 
Best regards,
Marek Vasut
