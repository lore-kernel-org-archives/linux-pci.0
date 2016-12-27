Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mailout2.samsung.com ([203.254.224.25]:40947 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753728AbcL0KSh (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 27 Dec 2016 05:18:37 -0500
Subject: Re: [PATCH] PCI: exynos: refactor exynos pcie driver
To: Alim Akhtar <alim.akhtar@samsung.com>,
        Pankaj Dubey <pankaj.dubey@samsung.com>,
        linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org
Cc: krzk@kernel.org, kgene@kernel.org, jingoohan1@gmail.com,
        bhelgaas@google.com, sanath@samsung.com,
        Niyas Ahmed S T <niyas.ahmed@samsung.com>,
        CPGS <cpgs@samsung.com>
From: Jaehoon Chung <jh80.chung@samsung.com>
Message-id: <a4200793-19dd-3727-505c-5840a8ec72bb@samsung.com>
Date: Tue, 27 Dec 2016 19:18:33 +0900
MIME-version: 1.0
In-reply-to: <58620B5A.1060900@samsung.com>
Content-type: text/plain; charset=windows-1252
References: <CGME20161223105411epcas1p3727f726e757ec6c6d7bff04a9af40077@epcas1p3.samsung.com>
 <1482490587-13611-1-git-send-email-pankaj.dubey@samsung.com>
 <e1f37a59-b633-7b9d-cc79-dbbb00a24cda@samsung.com>
 <5860E6F7.2090703@samsung.com>
 <79b89c49-a9de-3daa-9afa-b8f36304a226@samsung.com>
 <5861CE23.9060202@samsung.com>
 <6de4bc5b-05fb-793f-d3ab-b1c6ee19cfeb@samsung.com>
 <58620B5A.1060900@samsung.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Dear Alim,

On 12/27/2016 03:34 PM, Alim Akhtar wrote:
> Hi Jaehoon,
> 
[snip]
>>
>> Ah. Right..And i'm doing the refactoring to reuse the current pci-exynos.c.
> There is a nice refactoring patch posted by Pankaj recently @
> https://lkml.org/lkml/2016/12/23/73
> I would suggest you to rebase your work on this top.

Well, i don't think so. Pankaj's patch might be good way..but i can't agree about a few point.
If based on Pankaj's patch, it's more complex..

why put the ops callback for getting clock and mem resource?

If PHY generic framework is used, it's unnecessary. because it needs to get elbi and dbi resources.
clock resources("pcie" and "pcie_bus") are general things.

If Pankaj's patch is applied, also need to make the exynos5433_pcie_* callback functions?
It doesn't make sense.

I want to know maintainer's opinion..we can just touch a little for supporting All Exynos SoCs.

Best Regards,
Jaehoon Chung

> 
>> Maybe..Today or Tomorrow..I will send the patches..At that time, could you also check them?
>> Any comments might be helpful to me! :)
>>
> Will wait for you patches :-)
> 
>> Best Regards,
>> Jaehoon Chung
>>
[snip]

