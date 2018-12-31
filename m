Return-Path: <SRS0=55Kx=PI=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD85AC43387
	for <linux-pci@archiver.kernel.org>; Mon, 31 Dec 2018 10:37:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A8A320828
	for <linux-pci@archiver.kernel.org>; Mon, 31 Dec 2018 10:37:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bp5/JVYw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727119AbeLaKha (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 31 Dec 2018 05:37:30 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:42155 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727078AbeLaKha (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 31 Dec 2018 05:37:30 -0500
Received: by mail-wr1-f68.google.com with SMTP id q18so26159323wrx.9
        for <linux-pci@vger.kernel.org>; Mon, 31 Dec 2018 02:37:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=17bac9zIVtLfhjqb5cnVpMDnR9vKVKuEefOyVqycJ6c=;
        b=Bp5/JVYwyi7LS4sdCu0H89rG0INop8XXmTjrxpoxkJ4H21qhLNEu+RmCJ9NgcHPj0n
         TGM/3+3LtFMezUt3wRoIlLtB28Jc52Wefj3LGhy87SbdXRlGadji1ZJ5BypOhc2JrtQj
         LQNZc5BJPA8WWKmvnUmgJPE3yVMES6jhis9V25Yj3oJcFx4yRHAxFSNZcYXSKFl99jnF
         9Qvl8Ui6aZnzftRDhvJLcTAOa9IdekOoiBzFadY4j/Smbp5r2+Gx5/gQUp+XxDIDwEQF
         KjvgdbeiYdcE16D4M0pptVsO5sBcr6+L18tYwR+gCarvNaiLYuUefFvw9JwJwRuc0eJo
         n5Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=17bac9zIVtLfhjqb5cnVpMDnR9vKVKuEefOyVqycJ6c=;
        b=T9R6ZIjtrqxvwiD9IdM+S1t/4K1lP/0KByVPoSGacP5CrWVNv7pq7PIyBETnAqJ0+s
         4+UV8J54GtIZglGky40NmOf0gIQ2iIo2/InzgKePf9O8awEe0LdGXOXWVzmLBuO0fkJ5
         p3faG3NQEhCzLnpKeV84qJ8hisXhn4W+0+rKth8xKPx/XiLWqy+SS18zDsj8NJRjCRmi
         FAjnFB24pBPYIXVUOGrosh6/WBq1g6n1WyDhnFKvec3bfxTfZnd6RtyfBlr5N7x/rtsm
         C9twG+tXs+r+Rhr/xgb+U8S+6KAPkk2il49twajDP5FSHrjkCOpm/PHexWoj7ZDVjNBU
         XLZg==
X-Gm-Message-State: AJcUukd4koOiTAUlUU9SM0cdw8k9Xn15G0clV2GNecOX8DGbAOP5OZ78
        IUFvZW+Y0JUzLJtgSp6OoMQBadhz
X-Google-Smtp-Source: ALg8bN6rYeBn1cufWDfMWDuICQYCKBuESw6Yc/Vw8jdfi2bojWsUeqR1KM43dmY68g4JeUvMF/9w4w==
X-Received: by 2002:adf:8506:: with SMTP id 6mr23464097wrh.128.1546252647469;
        Mon, 31 Dec 2018 02:37:27 -0800 (PST)
Received: from ?IPv6:2003:ea:8bcf:e300:6421:56a6:bc87:a188? (p200300EA8BCFE300642156A6BC87A188.dip0.t-ipconnect.de. [2003:ea:8bcf:e300:6421:56a6:bc87:a188])
        by smtp.googlemail.com with ESMTPSA id c15sm22427681wml.27.2018.12.31.02.37.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 31 Dec 2018 02:37:26 -0800 (PST)
Subject: Re: [PATCH RFC] PCI/PME: fix PME runtime PM handling
To:     Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
References: <1e0c3baa-c2bb-0a91-19ca-65f4784b1424@gmail.com>
 <20181231093207.GZ2469@lahna.fi.intel.com>
From:   Heiner Kallweit <hkallweit1@gmail.com>
Message-ID: <2ac489b3-a091-bfce-32f1-b6fc86f3337c@gmail.com>
Date:   Mon, 31 Dec 2018 11:37:20 +0100
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
> 
> Can you file a kernel bug about this on bugzilla.kernel.org? Then attach
> there acpidump and output of 'sudo lspci -vv'.
> 
> Thanks!
> 
After reading again your commit message for adding the PME runtime PM
callbacks: It seems that you focused on root ports only when adding
this functionality. Should there be a check whether port is a root port?

Heiner
