Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pd0-f169.google.com ([209.85.192.169]:34221 "EHLO
	mail-pd0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753040AbbGOWNH (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 15 Jul 2015 18:13:07 -0400
Message-ID: <55A6DA84.8070504@gmail.com>
Date: Wed, 15 Jul 2015 15:11:16 -0700
From: Florian Fainelli <f.fainelli@gmail.com>
MIME-Version: 1.0
To: Ray Jui <rjui@broadcom.com>, Hauke Mehrtens <hauke@hauke-m.de>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will.deacon@arm.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Mark Rutland <mark.rutland@arm.com>,
	Bjorn Helgaas <bhelgaas@google.com>
CC: linux-kernel@vger.kernel.org,
	bcm-kernel-feedback-list@broadcom.com,
	linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH v2 3/4] arm64: Add Broadcom iProc family support
References: <1436935343-4437-1-git-send-email-rjui@broadcom.com> <1436935343-4437-4-git-send-email-rjui@broadcom.com> <55A6D673.1040908@hauke-m.de> <55A6D8C8.6030901@broadcom.com>
In-Reply-To: <55A6D8C8.6030901@broadcom.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 15/07/15 15:03, Ray Jui wrote:
> 
> 
> On 7/15/2015 2:53 PM, Hauke Mehrtens wrote:
>> On 07/15/2015 06:42 AM, Ray Jui wrote:
>>> This patch adds support to Broadcom's iProc family of arm64 based SoCs
>>> in the arm64 Kconfig and defconfig files
>>>
>>> Signed-off-by: Ray Jui <rjui@broadcom.com>
>>> Reviewed-by: Scott Branden <sbranden@broadcom.com>
>>> ---
>>>  arch/arm64/Kconfig           |    5 +++++
>>>  arch/arm64/configs/defconfig |    2 ++
>>>  2 files changed, 7 insertions(+)
>>>
>>> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
>>> index 318175f..969ef4a 100644
>>> --- a/arch/arm64/Kconfig
>>> +++ b/arch/arm64/Kconfig
>>> @@ -162,6 +162,11 @@ source "kernel/Kconfig.freezer"
>>>  
>>>  menu "Platform selection"
>>>  
>>> +config ARCH_BCM_IPROC
>>> +	bool "Broadcom iProc SoC Family"
>>> +	help
>>> +	  This enables support for Broadcom iProc based SoCs
>>> +
>>
>> Is this working correctly if we have ARCH_BCM_IPROC under ARM and ARM64?
>> They are guarding the same SoC line, which now uses ARM64 CPUS.
>>
> 
> Yes, since the "ARCH=" parameter from the compiler helps to route it to
> the right directory, arch/arm or arch/arm64, and you cannot compile both
> in a single image. Same case for other SoCs, e.g., tegra (ARCH_TEGRA),
> exynos (ARCH_EXYNOS), and etc.
> 
> The benefit of sharing the same arch flag is that the device driver that
> exists in iProc family of SoCs (both arm32 and arm64) can be guarded or
> enabled properly.

Yes, I like that as well, better maintain a single symbol across two
architectures than multiple across multiple architectures.
-- 
Florian
