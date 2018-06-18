Return-Path: <linux-kernel-owner@vger.kernel.org>
Subject: Re: [PATCH net-next v3 2/2] r8169: Reinstate ASPM Support
To: Kai-Heng Feng <kai.heng.feng@canonical.com>, davem@davemloft.net
Cc: ryankao@realtek.com, hayeswang@realtek.com, hau@realtek.com,
        romieu@fr.zoreil.com, bhelgaas@google.com,
        acelan.kao@canonical.com, netdev@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20180615053219.14053-1-kai.heng.feng@canonical.com>
 <20180615053219.14053-2-kai.heng.feng@canonical.com>
From: Heiner Kallweit <hkallweit1@gmail.com>
Message-ID: <68ff8bbd-538a-e461-7862-2bf26dabc288@gmail.com>
Date: Mon, 18 Jun 2018 21:33:40 +0200
MIME-Version: 1.0
In-Reply-To: <20180615053219.14053-2-kai.heng.feng@canonical.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 15.06.2018 07:32, Kai-Heng Feng wrote:
> On Intel Coffe Lake platforms, ASPM support in r8169 is the last missing
> puzzle to let CPU's Package C-State reaches PC8.
> Without ASPM support, the CPU cannot reach beyond PC3. PC8 can save
> additional ~3W in comparison with PC3 on my testing platform, Dell G3
> 3779.
> 
The patch itself looks good to me.
Still I think the commit message should be improved. Currently it sounds
like the patch affects Coffee Lake systems only. But disabled ASPM
prevents the system from reaching PC states beyond PC3 on more than
one platform. You just tested on Coffee Lake only.

And it would be good if you mention the RTL8168 chip version of
the system you tested on.

Finally one smaller remark below.

> This is based on the work from Chunhao Lin <hau@realtek.com>.
> 
> Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
> ---
> v3:
> - Change commit message wording.
> - Rename the function to rtl_hw_aspm_clkreq_enable().
> 
> v2:
> - Remove module parameter.
> - Remove pci_disable_link_state().
> 
>  drivers/net/ethernet/realtek/r8169.c | 40 +++++++++++++++++++---------
>  1 file changed, 27 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/net/ethernet/realtek/r8169.c b/drivers/net/ethernet/realtek/r8169.c
> index 9b55ce513a36..269ac7561368 100644
> --- a/drivers/net/ethernet/realtek/r8169.c
> +++ b/drivers/net/ethernet/realtek/r8169.c
> @@ -5289,6 +5289,17 @@ static void rtl_pcie_state_l2l3_enable(struct rtl8169_private *tp, bool enable)
>  	RTL_W8(tp, Config3, data);
>  }
>  
> +static void rtl_hw_aspm_clkreq_enable(struct rtl8169_private *tp, bool enable)
> +{
> +	if (enable) {
> +		RTL_W8(tp, Config2, RTL_R8(tp, Config2) | ClkReqEn);
> +		RTL_W8(tp, Config5, RTL_R8(tp, Config5) | ASPM_en);
> +	} else {
> +		RTL_W8(tp, Config2, RTL_R8(tp, Config2) & ~ClkReqEn);
> +		RTL_W8(tp, Config5, RTL_R8(tp, Config5) & ~ASPM_en);
> +	}
> +}
> +
>  static void rtl_hw_start_8168bb(struct rtl8169_private *tp)
>  {
>  	RTL_W8(tp, Config3, RTL_R8(tp, Config3) & ~Beacon_en);
> @@ -5645,9 +5656,9 @@ static void rtl_hw_start_8168g_1(struct rtl8169_private *tp)
>  	rtl_hw_start_8168g(tp);
>  
>  	/* disable aspm and clock request before access ephy */
> -	RTL_W8(tp, Config2, RTL_R8(tp, Config2) & ~ClkReqEn);
> -	RTL_W8(tp, Config5, RTL_R8(tp, Config5) & ~ASPM_en);
> +	rtl_hw_aspm_clkreq_enable(tp, false);
>  	rtl_ephy_init(tp, e_info_8168g_1, ARRAY_SIZE(e_info_8168g_1));
> +	rtl_hw_aspm_clkreq_enable(tp, true);
>  }
>  
>  static void rtl_hw_start_8168g_2(struct rtl8169_private *tp)
> @@ -5680,9 +5691,9 @@ static void rtl_hw_start_8411_2(struct rtl8169_private *tp)
>  	rtl_hw_start_8168g(tp);
>  
>  	/* disable aspm and clock request before access ephy */
> -	RTL_W8(tp, Config2, RTL_R8(tp, Config2) & ~ClkReqEn);
> -	RTL_W8(tp, Config5, RTL_R8(tp, Config5) & ~ASPM_en);
> +	rtl_hw_aspm_clkreq_enable(tp, false);
>  	rtl_ephy_init(tp, e_info_8411_2, ARRAY_SIZE(e_info_8411_2));
> +	rtl_hw_aspm_clkreq_enable(tp, true);
>  }
>  
>  static void rtl_hw_start_8168h_1(struct rtl8169_private *tp)
> @@ -5699,8 +5710,7 @@ static void rtl_hw_start_8168h_1(struct rtl8169_private *tp)
>  	};
>  
>  	/* disable aspm and clock request before access ephy */
> -	RTL_W8(tp, Config2, RTL_R8(tp, Config2) & ~ClkReqEn);
> -	RTL_W8(tp, Config5, RTL_R8(tp, Config5) & ~ASPM_en);
> +	rtl_hw_aspm_clkreq_enable(tp, false);
>  	rtl_ephy_init(tp, e_info_8168h_1, ARRAY_SIZE(e_info_8168h_1));
>  
>  	RTL_W32(tp, TxConfig, RTL_R32(tp, TxConfig) | TXCFG_AUTO_FIFO);
> @@ -5779,6 +5789,8 @@ static void rtl_hw_start_8168h_1(struct rtl8169_private *tp)
>  	r8168_mac_ocp_write(tp, 0xe63e, 0x0000);
>  	r8168_mac_ocp_write(tp, 0xc094, 0x0000);
>  	r8168_mac_ocp_write(tp, 0xc09e, 0x0000);
> +
> +	rtl_hw_aspm_clkreq_enable(tp, true);
>  }
>  
>  static void rtl_hw_start_8168ep(struct rtl8169_private *tp)
> @@ -5830,11 +5842,12 @@ static void rtl_hw_start_8168ep_1(struct rtl8169_private *tp)
>  	};
>  
>  	/* disable aspm and clock request before access ephy */
> -	RTL_W8(tp, Config2, RTL_R8(tp, Config2) & ~ClkReqEn);
> -	RTL_W8(tp, Config5, RTL_R8(tp, Config5) & ~ASPM_en);
> +	rtl_hw_aspm_clkreq_enable(tp, false);
>  	rtl_ephy_init(tp, e_info_8168ep_1, ARRAY_SIZE(e_info_8168ep_1));
>  
>  	rtl_hw_start_8168ep(tp);
> +
> +	rtl_hw_aspm_clkreq_enable(tp, true);
>  }
>  
>  static void rtl_hw_start_8168ep_2(struct rtl8169_private *tp)
> @@ -5846,14 +5859,15 @@ static void rtl_hw_start_8168ep_2(struct rtl8169_private *tp)
>  	};
>  
>  	/* disable aspm and clock request before access ephy */
> -	RTL_W8(tp, Config2, RTL_R8(tp, Config2) & ~ClkReqEn);
> -	RTL_W8(tp, Config5, RTL_R8(tp, Config5) & ~ASPM_en);
> +	rtl_hw_aspm_clkreq_enable(tp, false);
>  	rtl_ephy_init(tp, e_info_8168ep_2, ARRAY_SIZE(e_info_8168ep_2));
>  
>  	rtl_hw_start_8168ep(tp);
>  
>  	RTL_W8(tp, DLLPR, RTL_R8(tp, DLLPR) & ~PFM_EN);
>  	RTL_W8(tp, MISC_1, RTL_R8(tp, MISC_1) & ~PFM_D3COLD_EN);
> +
> +	rtl_hw_aspm_clkreq_enable(tp, true);
>  }
>  
>  static void rtl_hw_start_8168ep_3(struct rtl8169_private *tp)
> @@ -5867,8 +5881,7 @@ static void rtl_hw_start_8168ep_3(struct rtl8169_private *tp)
>  	};
>  
>  	/* disable aspm and clock request before access ephy */
> -	RTL_W8(tp, Config2, RTL_R8(tp, Config2) & ~ClkReqEn);
> -	RTL_W8(tp, Config5, RTL_R8(tp, Config5) & ~ASPM_en);
> +	rtl_hw_aspm_clkreq_enable(tp, false);
>  	rtl_ephy_init(tp, e_info_8168ep_3, ARRAY_SIZE(e_info_8168ep_3));
>  
>  	rtl_hw_start_8168ep(tp);
> @@ -5888,6 +5901,8 @@ static void rtl_hw_start_8168ep_3(struct rtl8169_private *tp)
>  	data = r8168_mac_ocp_read(tp, 0xe860);
>  	data |= 0x0080;
>  	r8168_mac_ocp_write(tp, 0xe860, data);
> +
> +	rtl_hw_aspm_clkreq_enable(tp, true);
>  }
>  
>  static void rtl_hw_start_8168(struct rtl8169_private *tp)
> @@ -7646,7 +7661,6 @@ static int rtl_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
>  	mii->reg_num_mask = 0x1f;
>  	mii->supports_gmii = cfg->has_gmii;
>  
> -

This should go to patch 1.

>  	/* enable device (incl. PCI PM wakeup and hotplug setup) */
>  	rc = pcim_enable_device(pdev);
>  	if (rc < 0) {
> 
