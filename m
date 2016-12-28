Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-lf0-f68.google.com ([209.85.215.68]:32978 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750705AbcL1DNd (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 27 Dec 2016 22:13:33 -0500
MIME-Version: 1.0
In-Reply-To: <3335251.c58Y1Zf7PB@amdc3058>
References: <CGME20161223105411epcas1p3727f726e757ec6c6d7bff04a9af40077@epcas1p3.samsung.com>
 <1482490587-13611-1-git-send-email-pankaj.dubey@samsung.com> <3335251.c58Y1Zf7PB@amdc3058>
From: Pankaj Dubey <pankaj.dubey@samsung.com>
Date: Wed, 28 Dec 2016 08:43:10 +0530
Message-ID: <CAGcde9HCrcjW5FC3Bh=2er=AVFNpraf_iP9kL7jWTTq_G6a39w@mail.gmail.com>
Subject: Re: [PATCH] PCI: exynos: refactor exynos pcie driver
To: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: "linux-arm-kernel@lists.infradead.org"
        <linux-arm-kernel@lists.infradead.org>,
        linux-kernel@vger.kernel.org,
        linux-samsung-soc <linux-samsung-soc@vger.kernel.org>,
        linux-pci@vger.kernel.org, Jingoo Han <jingoohan1@gmail.com>,
        Niyas Ahmed S T <niyas.ahmed@samsung.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Jaehoon Chung <jh80.chung@samsung.com>,
        Kukjin Kim <kgene@kernel.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Bjorn Helgaas <bhelgaas@google.com>, sanath@samsung.com
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Bartlomiej,

On 27 December 2016 at 19:05, Bartlomiej Zolnierkiewicz
<b.zolnierkie@samsung.com> wrote:
>
> Hi,
>
> On Friday, December 23, 2016 04:26:27 PM Pankaj Dubey wrote:
>> From: Niyas Ahmed S T <niyas.ahmed@samsung.com>
>>
>> Currently Exynos PCIe driver is only supported for Exynos5440 SoC.
>> This patch does refactoring of Exynos PCIe driver to extend support
>> for other Exynos SoC.
>>
>> Following are the main changes done via this patch:
>> 1) It adds separate structs for memory, clock resources.
>> 2) It add exynos_pcie_ops struct which will allow us to support the
>> differences in resources in different Exynos SoC.
>>
>> No functional change intended.
>>
>> Signed-off-by: Niyas Ahmed S T <niyas.ahmed@samsung.com>
>> Signed-off-by: Pankaj Dubey <pankaj.dubey@samsung.com>
>
> I would also like to see the explanation for 1) (as already
> requested by Jingoo).  Otherwise it all looks fine to me:
>
> Reviewed-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
>

Thanks for review and Reviewed-by tag.

In other thread as a reply to Jaehoon, I have explained reason behind
point no 1, I hope this reason is sufficient to separate these
resources from main exynos_pcie structs.

Thanks,
Pankaj Dubey

> Best regards,
> --
> Bartlomiej Zolnierkiewicz
> Samsung R&D Institute Poland
> Samsung Electronics
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-samsung-soc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
