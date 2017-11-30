Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from hqemgate15.nvidia.com ([216.228.121.64]:11674 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750989AbdK3Sqp (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 30 Nov 2017 13:46:45 -0500
Subject: Re: [PATCH 04/10] ARM: tegra: EXPORT tegra_cpuidle_pcie_irqs_in_use()
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
CC: <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <robh+dt@kernel.org>, <frowand.list@gmail.com>,
        <bhelgaas@google.com>, <rjw@rjwysocki.net>, <tglx@linutronix.de>,
        <vidyas@nvidia.com>, <kthota@nvidia.com>,
        <linux-tegra@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-pci@vger.kernel.org>, <linux-pm@vger.kernel.org>
References: <1511538800-8275-1-git-send-email-mmaddireddy@nvidia.com>
 <1511538800-8275-5-git-send-email-mmaddireddy@nvidia.com>
 <20171130124149.GB12096@red-moon>
From: Manikanta Maddireddy <mmaddireddy@nvidia.com>
Message-ID: <cd5f005e-6723-efcd-bc95-ec4df58254fe@nvidia.com>
Date: Fri, 1 Dec 2017 00:16:31 +0530
MIME-Version: 1.0
In-Reply-To: <20171130124149.GB12096@red-moon>
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>



On 30-Nov-17 6:11 PM, Lorenzo Pieralisi wrote:
> On Fri, Nov 24, 2017 at 09:23:14PM +0530, Manikanta Maddireddy wrote:
>> EXPORT tegra_cpuidle_pcie_irqs_in_use() to allow Tegra PCIe driver to be
>> compiled as loadable kernel module.
>>
>> Signed-off-by: Manikanta Maddireddy <mmaddireddy@nvidia.com>
>> ---
>>  arch/arm/mach-tegra/cpuidle.c | 1 +
>>  1 file changed, 1 insertion(+)
> 
> You should find a way to remove this call and the corresponding
> drivers->arch dependency, not to export it by spreading it even
> further.
> 
> Lorenzo
> 
I will drop this patch from the series and will explore the possibilities of
removing the arch dependency. I will address it in next series of patches

>> diff --git a/arch/arm/mach-tegra/cpuidle.c b/arch/arm/mach-tegra/cpuidle.c
>> index 316563141add..7d7e6d3ce32d 100644
>> --- a/arch/arm/mach-tegra/cpuidle.c
>> +++ b/arch/arm/mach-tegra/cpuidle.c
>> @@ -57,3 +57,4 @@ void tegra_cpuidle_pcie_irqs_in_use(void)
>>  		break;
>>  	}
>>  }
>> +EXPORT_SYMBOL(tegra_cpuidle_pcie_irqs_in_use);
>> -- 
>> 2.1.4
>>
