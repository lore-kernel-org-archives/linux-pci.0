Return-Path: <linux-kernel-owner@vger.kernel.org>
Message-ID: <555F73FC.1030102@codeaurora.org>
Date: Fri, 22 May 2015 11:22:52 -0700
From: Stephen Boyd <sboyd@codeaurora.org>
MIME-Version: 1.0
To: Stanimir Varbanov <svarbanov@mm-sol.com>,
	Rob Herring <robh+dt@kernel.org>,
	Kumar Gala <galak@codeaurora.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Grant Likely <grant.likely@linaro.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Kishon Vijay Abraham I <kishon@ti.com>,
	Russell King <linux@arm.linux.org.uk>,
	Arnd Bergmann <arnd@arndb.de>
CC: linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
	linux-pci@vger.kernel.org,
	Mathieu Olivari <mathieu@codeaurora.org>,
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: Re: [PATCH v2 5/5] ARM: qcom: Add Qualcomm APQ8084 SoC
References: <1430743338-10441-1-git-send-email-svarbanov@mm-sol.com> <1430743338-10441-6-git-send-email-svarbanov@mm-sol.com>
In-Reply-To: <1430743338-10441-6-git-send-email-svarbanov@mm-sol.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 05/04/15 05:42, Stanimir Varbanov wrote:
> This adds Snapdragon 805 ARM-based SoC as multiplatform
> compatible platform.
>
> Signed-off-by: Stanimir Varbanov <svarbanov@mm-sol.com>
> ---
>  arch/arm/mach-qcom/Kconfig |    7 +++++++
>  1 files changed, 7 insertions(+), 0 deletions(-)
>
> diff --git a/arch/arm/mach-qcom/Kconfig b/arch/arm/mach-qcom/Kconfig
> index 2256cd1..9cfebee 100644
> --- a/arch/arm/mach-qcom/Kconfig
> +++ b/arch/arm/mach-qcom/Kconfig
> @@ -22,4 +22,11 @@ config ARCH_MSM8974
>  	bool "Enable support for MSM8974"
>  	select HAVE_ARM_ARCH_TIMER
>  
> +config ARCH_APQ8084
> +	bool "Enable support for APQ8084"
> +	select HAVE_ARM_ARCH_TIMER
> +	select MIGHT_HAVE_PCI
> +	select PCI_DOMAINS if PCI
> +	select PCI_MSI if PCI
> +
>

Can we move these PCI selects up to ARCH_QCOM directly? Let's try to
avoid adding more SoC specific options under ARCH_QCOM.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project

