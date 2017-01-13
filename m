Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Date: Fri, 13 Jan 2017 09:15:37 -0800
From: Tony Lindgren <tony@atomide.com>
To: Kishon Vijay Abraham I <kishon@ti.com>
Subject: Re: [PATCH 36/37] ARM: DRA7: clockdomain: Change the CLKTRCTRL of
 CM_PCIE_CLKSTCTRL to SW_WKUP
Message-ID: <20170113171537.GZ2630@atomide.com>
References: <1484216786-17292-1-git-send-email-kishon@ti.com>
 <1484216786-17292-37-git-send-email-kishon@ti.com>
MIME-Version: 1.0
In-Reply-To: <1484216786-17292-37-git-send-email-kishon@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: devicetree@vger.kernel.org, Joao Pinto <Joao.Pinto@synopsys.com>,
 Arnd Bergmann <arnd@arndb.de>, linux-doc@vger.kernel.org,
 Jingoo Han <jingoohan1@gmail.com>, linux-arm-msm@vger.kernel.org,
 nsekhar@ti.com, linux-kernel@vger.kernel.org, linux-arm-kernel@axis.com,
 linux-samsung-soc@vger.kernel.org, linux-pci@vger.kernel.org,
 Bjorn Helgaas <bhelgaas@google.com>, linux-omap@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

* Kishon Vijay Abraham I <kishon@ti.com> [170112 02:35]:
> The PCIe programming sequence in TRM suggests CLKSTCTRL of PCIe should
> be set to SW_WKUP. There are no issues when CLKSTCTRL is set to HW_AUTO
> in RC mode. However in EP mode, the host system is not able to access the
> MEMSPACE and setting the CLKSTCTRL to SW_WKUP fixes it.

I guess ideally in the long run we would set this dynamically based on
the selected mode, right?

Regards,

Tony

> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
> ---
>  arch/arm/mach-omap2/clockdomains7xx_data.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/mach-omap2/clockdomains7xx_data.c b/arch/arm/mach-omap2/clockdomains7xx_data.c
> index 6c67965..67ebff8 100644
> --- a/arch/arm/mach-omap2/clockdomains7xx_data.c
> +++ b/arch/arm/mach-omap2/clockdomains7xx_data.c
> @@ -524,7 +524,7 @@
>  	.dep_bit	  = DRA7XX_PCIE_STATDEP_SHIFT,
>  	.wkdep_srcs	  = pcie_wkup_sleep_deps,
>  	.sleepdep_srcs	  = pcie_wkup_sleep_deps,
> -	.flags		  = CLKDM_CAN_HWSUP_SWSUP,
> +	.flags		  = CLKDM_CAN_SWSUP,
>  };
>  
>  static struct clockdomain atl_7xx_clkdm = {
> -- 
> 1.7.9.5
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
