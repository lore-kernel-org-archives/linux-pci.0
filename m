Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from ns.mm-sol.com ([37.157.136.199]:38510 "EHLO extserv.mm-sol.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S965426AbeEIXLC (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 9 May 2018 19:11:02 -0400
Subject: Re: [PATCH] Kirin-PCIe: Add kirin pcie msi feature.
To: Shawn Guo <shawn.guo@linaro.org>,
        Bjorn Helgaas <helgaas@kernel.org>
Cc: Yao Chen <chenyao11@huawei.com>, songxiaowei@hisilicon.com,
        wangbinghui@hisilicon.com, lorenzo.pieralisi@arm.com,
        bhelgaas@google.com, xuwei5@hisilicon.com, robh+dt@kernel.org,
        mark.rutland@arm.com, catalin.marinas@arm.com, will.deacon@arm.com,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        dimitrysh@google.com, guodong.xu@linaro.org,
        Jianguo Sun <sunjianguo1@huawei.com>
References: <1525763028-107417-1-git-send-email-chenyao11@huawei.com>
 <20180508125658.GK161390@bhelgaas-glaptop.roam.corp.google.com>
 <20180509045151.GA24899@dragon>
From: Stanimir Varbanov <svarbanov@mm-sol.com>
Message-ID: <058ea1c5-6be1-43ec-0bfe-08231717b7e1@mm-sol.com>
Date: Thu, 10 May 2018 02:10:58 +0300
MIME-Version: 1.0
In-Reply-To: <20180509045151.GA24899@dragon>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi,

On  9.05.2018 07:51, Shawn Guo wrote:
> Hi Bjorn,
> 
> On Tue, May 08, 2018 at 07:56:58AM -0500, Bjorn Helgaas wrote:
> ...
>>> +			return ret;
>>> +		}
>>> +	}
>>> +
>>> +	pci->pp.root_bus_nr = -1;
>>
>> Setting root_bus_nr looks like an unrelated change that should be in a
>> separate patch.
>>
>> But I'm not sure why you need to set root_bus_nr at all, since
>> dw_pcie_host_init() always sets it.
>>
>> Some other callers of dw_pcie_host_init() do set it:
>>
>>    exynos_add_pcie_port()
>>    imx6_add_pcie_port()
>>    armada8k_add_pcie_port()
>>    artpec6_add_pcie_port()
>>    dw_plat_add_pcie_port()
>>    histb_pcie_probe()
>>    qcom_pcie_probe()
>>    spear13xx_add_pcie_port()
>>
>> But I don't see *why* any of these need to set it.  If they don't need to
>> set it, they shouldn't.
> 
> Mostly it's a blind copy of unnecessary code.  I tested histb driver
> by dropping the line, and did not see anything broken.  I will cook up
> a series to remove the code from all above drivers, and copy
> corresponding driver owner to comment.
> 
>> And it would be nice if histb and qcom followed the structure and naming
>> conventions of the other drivers, i.e., they should have
>> histb_add_pcie_port() and qcom_add_pcie_port().
> 
> I can create a patch for histb driver, but will leave qcom one to
> Stanimir to decide.

Thanks, will see what can be done.

regards,
Stan
