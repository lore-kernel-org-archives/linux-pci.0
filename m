Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-la0-f41.google.com ([209.85.215.41]:33064 "EHLO
	mail-la0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751372AbbHaME3 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 31 Aug 2015 08:04:29 -0400
Received: by laboe4 with SMTP id oe4so43314925lab.0
        for <linux-pci@vger.kernel.org>; Mon, 31 Aug 2015 05:04:27 -0700 (PDT)
Message-ID: <55E442C7.7060509@linaro.org>
Date: Mon, 31 Aug 2015 14:04:23 +0200
From: Tomasz Nowicki <tomasz.nowicki@linaro.org>
MIME-Version: 1.0
To: Bjorn Helgaas <bhelgaas@google.com>
CC: Hanjun Guo <hanjun.guo@linaro.org>, Arnd Bergmann <arnd@arndb.de>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will.deacon@arm.com>,
	"Rafael J. Wysocki" <rjw@rjwysocki.net>,
	Jiang Liu <jiang.liu@linux.intel.com>,
	Liviu Dudau <Liviu.Dudau@arm.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Yijing Wang <wangyijing@huawei.com>,
	Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>,
	Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>,
	Mark Salter <msalter@redhat.com>, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org, linaro-acpi@lists.linaro.org
Subject: Re: [PATCH 02/11] x86, pci: Clean up comment about buggy MMIO config
 space access for AMD Fam10h CPUs.
References: <1432644564-24746-1-git-send-email-hanjun.guo@linaro.org> <1432644564-24746-3-git-send-email-hanjun.guo@linaro.org>
In-Reply-To: <1432644564-24746-3-git-send-email-hanjun.guo@linaro.org>
Content-Type: text/plain; charset=windows-1252; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 26.05.2015 14:49, Hanjun Guo wrote:
> From: Tomasz Nowicki <tomasz.nowicki@linaro.org>
>
> - fix typo
> - improve explanation
> - add reference to the related document
>
> Signed-off-by: Tomasz Nowicki <tomasz.nowicki@linaro.org>
> Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>
> Tested-by: Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>
> ---
>   arch/x86/include/asm/pci_x86.h | 9 ++++++---
>   1 file changed, 6 insertions(+), 3 deletions(-)
>
> diff --git a/arch/x86/include/asm/pci_x86.h b/arch/x86/include/asm/pci_x86.h
> index 164e3f8..eddf8f0 100644
> --- a/arch/x86/include/asm/pci_x86.h
> +++ b/arch/x86/include/asm/pci_x86.h
> @@ -154,10 +154,13 @@ extern struct list_head pci_mmcfg_list;
>
>   /*
>    * AMD Fam10h CPUs are buggy, and cannot access MMIO config space
> - * on their northbrige except through the * %eax register. As such, you MUST
> - * NOT use normal IOMEM accesses, you need to only use the magic mmio-config
> + * on their northbridge except through the * %eax register. As such, you MUST
> + * NOT use normal IOMEM accesses, you need to only use the magic mmio_config_*
>    * accessor functions.
> - * In fact just use pci_config_*, nothing else please.
> + *
> + * Please refer to the following doc:
> + * "BIOS and Kernel Developer's Guide (BKDG) For AMD Family 10h Processors",
> + * rev. 3.48, sec 2.11.1, "MMIO Configuration Coding Requirements".
>    */
>   static inline unsigned char mmio_config_readb(void __iomem *pos)
>   {
>

Hi Bjorn,

Can you please consider to pick up this one patch?

Regards,
Tomasz
