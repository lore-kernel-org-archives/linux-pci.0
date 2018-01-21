Return-Path: <linux-arch-owner@vger.kernel.org>
Subject: Re: [PATCH v11 6/9] LPC: Support the LPC host on Hip06/Hip07 with DT
 bindings
To: John Garry <john.garry@huawei.com>,
        mika.westerberg@linux.intel.com, rafael@kernel.org,
        lorenzo.pieralisi@arm.com, rjw@rjwysocki.net, robh+dt@kernel.org,
        bhelgaas@google.com, arnd@arndb.de, mark.rutland@arm.com,
        olof@lixom.net, hanjun.guo@linaro.org, dann.frazier@canonical.com
Cc: benh@kernel.crashing.org, linux-kernel@vger.kernel.org,
        linux-acpi@vger.kernel.org, linuxarm@huawei.com,
        linux-pci@vger.kernel.org, minyard@acm.org,
        devicetree@vger.kernel.org, linux-arch@vger.kernel.org,
        Zhichang Yuan <yuanzhichang@hisilicon.com>,
        Zou Rongrong <zourongrong@huawei.com>,
        Gabriele Paoloni <gabriele.paoloni@huawei.com>
References: <1516537647-50553-1-git-send-email-john.garry@huawei.com>
 <1516537647-50553-7-git-send-email-john.garry@huawei.com>
From: Randy Dunlap <rdunlap@infradead.org>
Message-ID: <cabc1ed6-18e3-8685-82b7-ae1d7dd2348a@infradead.org>
Date: Sun, 21 Jan 2018 09:54:40 -0800
MIME-Version: 1.0
In-Reply-To: <1516537647-50553-7-git-send-email-john.garry@huawei.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 01/21/2018 04:27 AM, John Garry wrote:
> diff --git a/drivers/bus/Kconfig b/drivers/bus/Kconfig
> index 57e011d..91debe4 100644
> --- a/drivers/bus/Kconfig
> +++ b/drivers/bus/Kconfig
> @@ -65,6 +65,14 @@ config BRCMSTB_GISB_ARB
>  	  arbiter. This driver provides timeout and target abort error handling
>  	  and internal bus master decoding.
>  
> +config HISILICON_LPC
> +	bool "Support for ISA I/O space on Hisilicon hip06/7"
> +	depends on (ARM64 && (ARCH_HISI || COMPILE_TEST))
> +	select INDIRECT_PIO
> +	help
> +	  Driver needed for some legacy ISA devices attached to Low-Pin-Count
> +	  on Hisilicon hip06/7 SoC.

Hi,
Why is this config symbol bool instead of tristate?

thanks,
-- 
~Randy
