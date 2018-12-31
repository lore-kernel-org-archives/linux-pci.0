Return-Path: <SRS0=55Kx=PI=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21532C43387
	for <linux-pci@archiver.kernel.org>; Mon, 31 Dec 2018 09:48:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D63DD20B1F
	for <linux-pci@archiver.kernel.org>; Mon, 31 Dec 2018 09:48:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ULp/qZpx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726461AbeLaJs1 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 31 Dec 2018 04:48:27 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:36802 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726359AbeLaJs0 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 31 Dec 2018 04:48:26 -0500
Received: by mail-wr1-f67.google.com with SMTP id u4so26071719wrp.3
        for <linux-pci@vger.kernel.org>; Mon, 31 Dec 2018 01:48:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=tbKZs4xGgJmJb9efH133pY2sJspWlcdZdK6EI0ePdhE=;
        b=ULp/qZpxIgokSGifbDfQ1TV7hm3IPDEFO4a43c+eDwX6F4PfrrlyFGTcxd/mUd+xqX
         XD0SihIRy3wz5vB60TtAbqC+ChnTIkaTWmJq5JXXmXfcLKwLcoTjg7njXEF0YX2xlmkO
         KTGT4QbzFM8VaG/HcvL286ulk2NXQ3Ftz4kIXgYSZQMen7e7y++Efh4kX5kexUykkUgP
         Fwco0rZRStvAzrEefAZ1S8/fkjhJL1uliu7XQfrmeAjb/9eE38KUHKTu/AuPrKZobiY5
         BEYR+Uup21yfN/3ojSEGot+IXXy79jxSEr7hGoC96MRk6YqSMFvyHbJLHZIELLA/w55d
         fllw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=tbKZs4xGgJmJb9efH133pY2sJspWlcdZdK6EI0ePdhE=;
        b=N4UMTYE6mqtYHN26lwx/VG1mbPWo/F0+ncnHnYTKXxgVOMBQ5gP5ky717/x2IMnlEG
         cWC6AP4HccMvBS5LB4VQMJEkj0w4pgEA1Znlt+O0lKrdpR/QEwYF8yIQnam9P+fhFk0e
         /PK4VIb+mZZKIpZxL6I1xjAbMWtWQyF64pZSuG/y8DMwLkrrzqfPC+r0E2y50gyUKSHS
         SmI6Tu1R4Qn/UMBp/K6ZeBI9grUEwDjZwZZe5kieVk9fGBHprQEhgO0DR6Ar6K0BF2/0
         X4bl3LIGqxbjCYcHGxYQCDz3jF7Gvt1HkJPdHx3xmQuE9oYQZB4pZPEImTvpKDBGcLnZ
         zOfQ==
X-Gm-Message-State: AJcUukewy6DQDJ8tcES1emw+RQJBr2ApUgZF8xc2xL6GwTPedwGIRMKJ
        8xXXGbZswBWBTzUCNqQoCV0MmylR
X-Google-Smtp-Source: ALg8bN5OQ5EzunZ8faPUScXoO+vTCibMkvwouqhtWjctHWNTr4pF5006J5920iCfM245HqOQphnRMA==
X-Received: by 2002:adf:ffca:: with SMTP id x10mr34369932wrs.289.1546249704812;
        Mon, 31 Dec 2018 01:48:24 -0800 (PST)
Received: from ?IPv6:2003:ea:8bcf:e300:6421:56a6:bc87:a188? (p200300EA8BCFE300642156A6BC87A188.dip0.t-ipconnect.de. [2003:ea:8bcf:e300:6421:56a6:bc87:a188])
        by smtp.googlemail.com with ESMTPSA id j8sm87557286wmd.0.2018.12.31.01.48.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 31 Dec 2018 01:48:24 -0800 (PST)
Subject: Re: [PATCH RFC] PCI/PME: fix PME runtime PM handling
To:     Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
References: <1e0c3baa-c2bb-0a91-19ca-65f4784b1424@gmail.com>
 <20181231093207.GZ2469@lahna.fi.intel.com>
From:   Heiner Kallweit <hkallweit1@gmail.com>
Message-ID: <a67aa9ee-556e-6968-cc5d-1abfe4a1c809@gmail.com>
Date:   Mon, 31 Dec 2018 10:48:18 +0100
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
Thanks Mika, that's the link to the filed bug report:
https://bugzilla.kernel.org/show_bug.cgi?id=202103

Heiner

