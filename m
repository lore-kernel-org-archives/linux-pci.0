Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-gw3-out.broadcom.com ([216.31.210.64]:37126 "EHLO
	mail-gw3-out.broadcom.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752683AbbGNVLh (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 14 Jul 2015 17:11:37 -0400
Message-ID: <55A57AF2.8000903@broadcom.com>
Date: Tue, 14 Jul 2015 14:11:14 -0700
From: Ray Jui <rjui@broadcom.com>
MIME-Version: 1.0
To: Catalin Marinas <catalin.marinas@arm.com>
CC: Will Deacon <will.deacon@arm.com>, Arnd Bergmann <arnd@arndb.de>,
	"Bjorn Helgaas" <bhelgaas@google.com>,
	Hauke Mehrtens <hauke@hauke-m.de>, <linux-pci@vger.kernel.org>,
	<bcm-kernel-feedback-list@broadcom.com>,
	<linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH 3/4] arm64: Add Broadcom's North Star 2 support
References: <1436837955-26279-1-git-send-email-rjui@broadcom.com> <1436837955-26279-4-git-send-email-rjui@broadcom.com> <20150714091406.GC13555@e104818-lin.cambridge.arm.com>
In-Reply-To: <20150714091406.GC13555@e104818-lin.cambridge.arm.com>
Content-Type: text/plain; charset="windows-1252"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>



On 7/14/2015 2:14 AM, Catalin Marinas wrote:
> On Mon, Jul 13, 2015 at 06:39:14PM -0700, Ray Jui wrote:
>> This patch adds support to Broadcom's North Star 2 SoC in the arm64
>> Kconfig and defconfig files
>>
>> Signed-off-by: Ray Jui <rjui@broadcom.com>
>> Reviewed-by: Scott Branden <sbranden@broadcom.com>
>> ---
>>  arch/arm64/Kconfig           |   12 ++++++++++++
>>  arch/arm64/configs/defconfig |    2 ++
>>  2 files changed, 14 insertions(+)
>>
>> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
>> index 318175f..6c5c279 100644
>> --- a/arch/arm64/Kconfig
>> +++ b/arch/arm64/Kconfig
>> @@ -162,6 +162,18 @@ source "kernel/Kconfig.freezer"
>>  
>>  menu "Platform selection"
>>  
>> +config ARCH_BCM_IPROC
>> +	bool
>> +	help
>> +	  This enables support for Broadcom iProc based SoCs
>> +
>> +config ARCH_BCM_NS2
>> +	bool "Broadcom North Start 2 (BCM5871X)"
>> +	select ARCH_BCM_IPROC
>> +	help
>> +	  This enables support for Broadcom NS2 (BCM5871X). NS2 is in
>> +	  the iProc family of SoCs based on the ARMv8 architecture
> 
> Do you really need the second config option? Just leave the one covering
> the family as we do for most of the other family SoCs on arm64 (apart
> from ARCH_TEGRA_123_SOC which I plan to remove and use ARCH_TEGRA
> instead).
> 

ARCH_BCM_NS2 helps in cases where a NS2 specific driver may just default
to ARCH_BCM_NS2 in its Kconfig, so those NS2 drivers got turned on
whenever ARCH_BCM_NS2 is turned on.

If the plan is to allow only one ARCH flag per family of SoCs for ARMv8,
I can go ahead and remove ARCH_BCM_NS2.

Thanks,

Ray
