Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mailout4.samsung.com ([203.254.224.34]:48020 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757543AbdAEI7x (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 5 Jan 2017 03:59:53 -0500
Subject: Re: [PATCH V2 4/5] PCI: exynos: support the using PHY generic framework
To: Jaehoon Chung <jh80.chung@samsung.com>, linux-pci@vger.kernel.org
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org, bhelgaas@google.com,
        robh+dt@kernel.org, mark.rutland@arm.com, kgene@kernel.org,
        krzk@kernel.org, kishon@ti.com, jingoohan1@gmail.com,
        vivek.gautam@codeaurora.org, alim.akhtar@samsung.com,
        cpgs@samsung.com
From: "pankaj.dubey" <pankaj.dubey@samsung.com>
Message-id: <bf937878-04a0-77cb-4c0a-cecf1bc20a2e@samsung.com>
Date: Thu, 05 Jan 2017 14:31:14 +0530
MIME-version: 1.0
In-reply-to: <20170104123435.30740-5-jh80.chung@samsung.com>
Content-type: text/plain; charset=windows-1252
References: <20170104123435.30740-1-jh80.chung@samsung.com>
 <CGME20170104123436epcas1p1651443c5fe13f67006864aed2f70fa9d@epcas1p1.samsung.com>
 <20170104123435.30740-5-jh80.chung@samsung.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Jaehoon,

On Wednesday 04 January 2017 06:04 PM, Jaehoon Chung wrote:
> This patch is for using PHY generic framework.
> To maintain backward compatibility, check whether phy is supported or
> not with 'using_phy'.
> 
> And if someone use the old dt-file, display the "deprecated" message.
> But it's still working fine with it.
> 
> Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
> ---
> Changelog on V2:
> - This patch is split from previous PATCH[1/4]
> - Maintain the backward compatibility
> - Adds 'using_phy' for cheching whether phy framework is used or not
> - Adds 'DEPRECATED' message for old dt-binding way
> 

Reviewed-by: Pankaj Dubey <pankaj.dubey@samsung.com>

Thanks,
Pankaj Dubey
