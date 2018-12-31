Return-Path: <SRS0=55Kx=PI=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D268C43387
	for <linux-pci@archiver.kernel.org>; Mon, 31 Dec 2018 13:30:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3369421019
	for <linux-pci@archiver.kernel.org>; Mon, 31 Dec 2018 13:30:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G4TVrzXu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726045AbeLaNay (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 31 Dec 2018 08:30:54 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:39010 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726012AbeLaNay (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 31 Dec 2018 08:30:54 -0500
Received: by mail-wm1-f65.google.com with SMTP id f81so24350922wmd.4
        for <linux-pci@vger.kernel.org>; Mon, 31 Dec 2018 05:30:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=tpZCNUMW+y11/CoKQbqF8COwkAYmrKfxvKlIqty0DH4=;
        b=G4TVrzXuOHTw8la+AoI+7DwffviigMSbEXghJxIapdZvilfHQ8J1+cSKRayb8jSTcP
         PG4VnygqFgZ/KeBI/lJrRtuGV8U/J2KW/FuEWtrVRTspHGYUlEglUIJ8cBeOTD767PAE
         1o3JeVM5qKg6D6TFFdaCbReHJ1TvJhUHtRoLBgwGedWJaKWD99mTAN8Kq5myZTjR2K8l
         TBN6yVSZymF+zs60ov+/ilF/6wouOscumvGWJizBL+YLsaUPYQXL/yxahml7B+KxOtgu
         gLr9EPaqgu6QAcKTti7ejreDCAApdb4NS/4ydxYv3nbrlRSQKCqZM7Dk7iAS2HHwzJrb
         n9lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=tpZCNUMW+y11/CoKQbqF8COwkAYmrKfxvKlIqty0DH4=;
        b=dXhknoDrDFFM6wCMFFxI//d02v5NBUWrkqj55obKl7H6Q1vZS8OTlNu33G713LUd9c
         Abnw8u4rfc/ZorsfBZgKZ7bGiluJbzyyS47p+fgeyKczXGBn7oyVwuZ52GmNjlRxaMAU
         Knl1W1BpLilWN6W3WYp5NWVB03IqhMSpAwYB/vIdzSbE9FHwJO58YKnjUxn8ifGWPAv+
         ckpRPlaZ32ELRfp4P9wz3a8/mLtiAivB6Z2TJGamU19nMK5V/JuYH9KqMZOntGuRgE26
         WRWeO9ZNdBxzJ7U+83YeLMlVFZNza2eho3N2fWBhK7RpSzamFgj90DI31VrPvj5PYJFa
         mmzA==
X-Gm-Message-State: AA+aEWZpv7k4YUDtixMhShM5qwaNNBL2vjDkSsubd0Xvhy1KZq2XvYEP
        F6FWN3u3CXeM/2Xqr077yKeK/dfr
X-Google-Smtp-Source: ALg8bN5GAgl3vVI+GIxsiUyWWVQfq7baOrynIx043oKqSKWZNnQAkPfNA//7gyPLeCn6V1AeWHZC/g==
X-Received: by 2002:a1c:2d4b:: with SMTP id t72mr28940774wmt.99.1546263052062;
        Mon, 31 Dec 2018 05:30:52 -0800 (PST)
Received: from ?IPv6:2003:ea:8bcf:e300:6421:56a6:bc87:a188? (p200300EA8BCFE300642156A6BC87A188.dip0.t-ipconnect.de. [2003:ea:8bcf:e300:6421:56a6:bc87:a188])
        by smtp.googlemail.com with ESMTPSA id d11sm5773962wrw.25.2018.12.31.05.30.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 31 Dec 2018 05:30:51 -0800 (PST)
Subject: Re: [PATCH RFC] PCI/PME: fix PME runtime PM handling
To:     Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
References: <1e0c3baa-c2bb-0a91-19ca-65f4784b1424@gmail.com>
 <20181231093207.GZ2469@lahna.fi.intel.com>
From:   Heiner Kallweit <hkallweit1@gmail.com>
Message-ID: <5460d602-30bf-3970-4add-57cf2cca9626@gmail.com>
Date:   Mon, 31 Dec 2018 14:30:44 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20181231093207.GZ2469@lahna.fi.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 31.12.2018 10:32, Mika Westerberg wrote:
> Hi Heiner,
> 
> On Sun, Dec 30, 2018 at 12:06:14PM +0100, Heiner Kallweit wrote:
>> I face the issue that no PME is generated if the network cable is
>> re-plugged. To explain that in a little more detail:
>> r8169 driver enters runtime suspend 10 seconds after cable is detached.
>> LinkUp detection is armed and device enters D3hot. When the cable is
>> re-plugged Linkup should generate a PME and device is resumed.
>> But system receives no PME from the device.
>>
>> Wake-on-LAN from S3 works perfectly fine and generates a PME.
>>
>> After checking the pcie pme code and some experiments I found that
>> the following fixes the issue for me. Now system receives the PME
>> and properly runtime-resumes the network device.
>>
>> But I'm no expert in PCIe and PME, therefore I'm not sure whether
>> the fix is correct. Please advise.
>>
>> Adding also Mika as author of 0e157e528604 ("PCI/PME: Implement
>> runtime PM callbacks").
> 
> The root port cannot trigger an interrupt when it is in D3 (hot or cold)
> so there needs to be a way to "wakeup" the hierarchy first which is
> typically done by using sideband signal called WAKE#. Once the hierarchy
> is brought back to communicating state the PME message is propagated to
> the root port and the interrupt triggers (now the root port is in D0).
> For some reason this does not seem to happen in your case and to
> understand why we would need to gather a bit more information.

One more thing I just found, not sure whether it may be relevant.
The WAKE# signal seems to be used only when device is in D3cold.
In D3hot the device sends the PME message directly.

-----------
This is the standard behavior.  Please refer to PCI Express Base
Sepcification Revision 2.0, section 5.3.3.2 Link Wakeup.  In D1, D2
and D3hot state, PCIe device can transit the link from L1 to L0 state,
and send the PME message.  In D3cold, the main link is powered off,
PCIe device will use a STANDARD sideband signal WAKE# to signal wakeup
firstly, then platform (power controller in spec) will power on the
main link for the device, after main link is back to L0, the PME
message is send to root port, pme interrupt is generated.  So in
theory, the wake up process can be divided into platform part (which
power on the main link) and PCIe part (which send PME).
