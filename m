Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mailout4.samsung.com ([203.254.224.34]:48965 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S967700AbdAECWd (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 4 Jan 2017 21:22:33 -0500
Subject: Re: [PATCH V2 2/5] phy: phy-exynos-pcie: Add support for Exynos PCIe
 phy
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        bhelgaas@google.com, robh+dt@kernel.org, mark.rutland@arm.com,
        kgene@kernel.org, kishon@ti.com, jingoohan1@gmail.com,
        vivek.gautam@codeaurora.org, pankaj.dubey@samsung.com,
        alim.akhtar@samsung.com, cpgs@samsung.com
From: Jaehoon Chung <jh80.chung@samsung.com>
Message-id: <666cecb2-0b38-51ba-be5c-086a709c6e48@samsung.com>
Date: Thu, 05 Jan 2017 11:22:17 +0900
MIME-version: 1.0
In-reply-to: <20170104175257.yte3ntw6nyvh47xt@kozik-lap>
Content-type: text/plain; charset=utf-8
References: <20170104123435.30740-1-jh80.chung@samsung.com>
 <CGME20170104123436epcas1p1a729583c3c2307d8539a186f1050ea98@epcas1p1.samsung.com>
 <20170104123435.30740-3-jh80.chung@samsung.com>
 <20170104175257.yte3ntw6nyvh47xt@kozik-lap>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 01/05/2017 02:52 AM, Krzysztof Kozlowski wrote:
> On Wed, Jan 04, 2017 at 09:34:32PM +0900, Jaehoon Chung wrote:
>> This patch supports to use Generic Phy framework for Exynos PCIe phy.
>> When Exynos that supported the pcie want to use the PCIe,
>> it needs to control the phy resgister.
>> But it should be more complex to control in their own PCIe device drivers.
>>
>> Currently, there is an exynos5440 case to support the pcie.
>> So this driver is based on Exynos5440 PCIe.
>> In future, will support the Other exynos SoCs likes exynos5433, exynos7.
> 
> I have troubles understanding this. Please, work on the commit message.
> 
> For the code itself:
> Acked-by: Krzysztof Kozlowski <krzk@kernel.org>
> ... but commit message is really important to understand why/what was
> done.

Will update the commit-msg. Thanks for comments.

Best Regards,
Jaehoon Chung

> 
> Best regards,
> Krzysztof
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 

