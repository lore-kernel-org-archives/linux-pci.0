Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 797B927B359;
	Wed, 11 Feb 2026 15:01:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770822077; cv=none; b=gBQnMpbhXgVpgdYL2TTaUX81p6YOw+AsN9ovpiuskLa1RrwdcjLuZ00jEml3EmejMvcuqJD18xfg+vL0dVCPO4mxYBUUyi7uMyj+W+ow9RhPty6UkyLxXWO0zeeYcYyAgcV+LyK71d2+uZMw67oFBbODgIgHPvpgBXpraB8lOW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770822077; c=relaxed/simple;
	bh=4/QK+ww/DDKk2YLZPkE3vkzbbCbbK3sc8GFTt3kGHB8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pq3M3VcCskg8Rv5isWqhVpb8meiXNpjoG1HNu6AkDqZ5TvyXzck5UfI28S49Wxu9o/ubIbDs5OSTofx4FZ+9lKDJEsv5wf2w1m/JOwdB7ar77t88Vx5DRbFXcrvRnBABqtcsPHos5zXMWjy1u3Ro04PmjkwybdiCwpE6DaVN40Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [141.14.220.42] (g42.guest.molgen.mpg.de [141.14.220.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id 319014C1A25A02;
	Wed, 11 Feb 2026 16:00:18 +0100 (CET)
Message-ID: <589746b5-0519-47d9-b583-89f4d81573a7@molgen.mpg.de>
Date: Wed, 11 Feb 2026 16:00:17 +0100
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Intel-wired-lan] [PATCH] igc: Add PCIe link recovery for
 I225/I226
To: Harshank Matkar <harshankmatkar1304@outlook.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
 tony.nguyen@intel.com, davem@davemloft.net, kuba@kernel.org,
 pabeni@redhat.com, edumazet@google.com, linux-kernel@vger.kernel.org,
 Bjorn Helgaas <helgaas@kernel.org>, linux-pci@vger.kernel.org
References: <20260210203332.23200-1-harshankmatkar1304@outlook.com>
Content-Language: en-US
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20260210203332.23200-1-harshankmatkar1304@outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

[Cc: +Linux PCI folks]


Dear Harshank,


Thank you for your patch. Just a note to please version your patches. 
`git format-patch` has the switch `--reroll-count` or `-v` to do this.

Am 10.02.26 um 21:34 schrieb Harshank Matkar:
> From: Harshank Matkar <harshankmatkar1304@outlook.com>
> 
> When ASPM L0s transitions occur on Intel I225/I226 controllers,
> transient PCIe link instability can cause register read failures
> (0xFFFFFFFF responses). Implement a multi-layer recovery strategy:
> 
> 1. Immediate retries: 3 attempts with 100-200μs delays

Why were these delays chosen?

> 2. Link retraining: Trigger PCIe link retraining via capabilities
> 3. Device detachment: Only as last resort after max attempts
> 
> The recovery mechanism includes rate limiting, maximum attempt
> tracking, and device presence validation to prevent false detaches
> on transient ASPM glitches while maintaining safety through
> bounded retry limits.

It’d be great if you added the test setup and case.

> Signed-off-by: Harshank Matkar <harshankmatkar1304@outlook.com>
> ---
>   drivers/net/ethernet/intel/igc/igc.h      |   6 +-
>   drivers/net/ethernet/intel/igc/igc_main.c | 155 ++++++++++++++++++++--
>   2 files changed, 149 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/igc/igc.h b/drivers/net/ethernet/intel/igc/igc.h
> index a427f05814c1..2ef488b279b9 100644
> --- a/drivers/net/ethernet/intel/igc/igc.h
> +++ b/drivers/net/ethernet/intel/igc/igc.h
> @@ -346,6 +346,10 @@ struct igc_adapter {
>   	struct mutex led_mutex;
>   	struct igc_led_classdev *leds;
>   	bool leds_available;
> +
> +	/* PCIe recovery tracking */
> +	unsigned int pcie_recovery_attempts;
> +	unsigned long last_recovery_time;
>   };
>   
>   void igc_up(struct igc_adapter *adapter);
> @@ -422,7 +426,7 @@ enum igc_rss_type_num {
>   	IGC_RSS_TYPE_MAX		= 10,
>   };
>   #define IGC_RSS_TYPE_MAX_TABLE		16
> -#define IGC_RSS_TYPE_MASK		GENMASK(3,0) /* 4-bits (3:0) = mask 0x0F */
> +#define IGC_RSS_TYPE_MASK		GENMASK(3, 0) /* 4-bits (3:0) = mask 0x0F */
>   
>   /* igc_rss_type - Rx descriptor RSS type field */
>   static inline u32 igc_rss_type(const union igc_adv_rx_desc *rx_desc)
> diff --git a/drivers/net/ethernet/intel/igc/igc_main.c b/drivers/net/ethernet/intel/igc/igc_main.c
> index 89a321a344d2..f0daa3edbb79 100644
> --- a/drivers/net/ethernet/intel/igc/igc_main.c
> +++ b/drivers/net/ethernet/intel/igc/igc_main.c
> @@ -1411,9 +1411,8 @@ static int igc_tx_map(struct igc_ring *tx_ring,
>   	/* Make sure there is space in the ring for the next send. */
>   	igc_maybe_stop_tx(tx_ring, DESC_NEEDED);
>   
> -	if (netif_xmit_stopped(txring_txq(tx_ring)) || !netdev_xmit_more()) {
> +	if (netif_xmit_stopped(txring_txq(tx_ring)) || !netdev_xmit_more())
>   		writel(i, tx_ring->tail);
> -	}
>   
>   	return 0;
>   dma_error:
> @@ -1613,8 +1612,7 @@ static netdev_tx_t igc_xmit_frame_ring(struct sk_buff *skb,
>   	 * otherwise try next time
>   	 */
>   	for (f = 0; f < skb_shinfo(skb)->nr_frags; f++)
> -		count += TXD_USE_COUNT(skb_frag_size(
> -						&skb_shinfo(skb)->frags[f]));
> +		count += TXD_USE_COUNT(skb_frag_size(&skb_shinfo(skb)->frags[f]));

Unrelated.

>   
>   	if (igc_maybe_stop_tx(tx_ring, count + 5)) {
>   		/* this is a hard error */
> @@ -2524,7 +2522,6 @@ static int __igc_xdp_run_prog(struct igc_adapter *adapter,
>   		if (xdp_do_redirect(adapter->netdev, xdp, prog) < 0)
>   			goto out_failure;
>   		return IGC_XDP_REDIRECT;
> -		break;
>   	default:
>   		bpf_warn_invalid_xdp_action(adapter->netdev, prog, act);
>   		fallthrough;
> @@ -2791,7 +2788,7 @@ static struct igc_xdp_buff *xsk_buff_to_igc_ctx(struct xdp_buff *xdp)
>   	 * igc_xdp_buff shares its layout with xdp_buff_xsk and private
>   	 * igc_xdp_buff fields fall into xdp_buff_xsk->cb
>   	 */
> -       return (struct igc_xdp_buff *)xdp;
> +	return (struct igc_xdp_buff *)xdp;

Correct, but should be a separate patch.

>   }
>   
>   static int igc_clean_rx_irq_zc(struct igc_q_vector *q_vector, const int budget)
> @@ -3895,9 +3892,8 @@ static int igc_enable_nfc_rule(struct igc_adapter *adapter,
>   {
>   	int err;
>   
> -	if (rule->flex) {
> +	if (rule->flex)
>   		return igc_add_flex_filter(adapter, rule);
> -	}

Correct, but unrelated and I think cosmetic changes are not wanted.

>   
>   	if (rule->filter.match_flags & IGC_FILTER_FLAG_ETHER_TYPE) {
>   		err = igc_add_etype_filter(adapter, rule->filter.etype,
> @@ -6984,11 +6980,112 @@ static const struct net_device_ops igc_netdev_ops = {
>   	.ndo_hwtstamp_set	= igc_ptp_hwtstamp_set,
>   };
>   
> +#define IGC_REGISTER_READ_RETRIES	3
> +#define IGC_PCIE_RECOVERY_MAX_ATTEMPTS	10
> +#define IGC_PCIE_RECOVERY_INTERVAL_MS	1000
> +
> +/**
> + * igc_pcie_link_recover - Attempt PCIe link recovery
> + * @adapter: board private structure
> + *
> + * Attempts to recover a failed PCIe link by triggering a link retrain.
> + * Rate-limited to 1 attempt per second, maximum 10 attempts.
> + *
> + * Returns true if recovery was successful, false otherwise.
> + */
> +static bool igc_pcie_link_recover(struct igc_adapter *adapter)
> +{
> +	struct pci_dev *pdev = adapter->pdev;
> +	unsigned long now = jiffies;
> +	u16 lnksta, lnkctl;
> +	int ret;
> +	int i;
> +
> +	/* Rate limiting: no more than 1 attempt per second */
> +	if (time_before(now, adapter->last_recovery_time +
> +			msecs_to_jiffies(IGC_PCIE_RECOVERY_INTERVAL_MS)))
> +		return false;
> +
> +	/* Maximum attempt limit */
> +	if (adapter->pcie_recovery_attempts >= IGC_PCIE_RECOVERY_MAX_ATTEMPTS) {
> +		netdev_err(adapter->netdev,
> +			   "Exceeded maximum PCIe recovery attempts (%d)\n",
> +			   IGC_PCIE_RECOVERY_MAX_ATTEMPTS);
> +		return false;
> +	}
> +
> +	adapter->last_recovery_time = now;
> +	adapter->pcie_recovery_attempts++;
> +
> +	netdev_warn(adapter->netdev,
> +		    "Attempting PCIe link recovery (attempt %d/%d)\n",
> +		    adapter->pcie_recovery_attempts,
> +		    IGC_PCIE_RECOVERY_MAX_ATTEMPTS);
> +
> +	/* Check if device is still present on the bus */
> +	if (!pci_device_is_present(pdev)) {
> +		netdev_err(adapter->netdev, "Device not present on PCIe bus\n");
> +		return false;
> +	}
> +
> +	/* Check link status */
> +	ret = pcie_capability_read_word(pdev, PCI_EXP_LNKSTA, &lnksta);
> +	if (ret) {
> +		netdev_err(adapter->netdev, "Failed to read link status\n");
> +		return false;
> +	}
> +
> +	/* Trigger link retrain if link appears down */
> +	if (!(lnksta & PCI_EXP_LNKSTA_DLLLA)) {
> +		netdev_info(adapter->netdev,
> +			    "Link down, attempting retrain\n");
> +
> +		/* Read link control register */
> +		ret = pcie_capability_read_word(pdev, PCI_EXP_LNKCTL, &lnkctl);
> +		if (ret == 0) {
> +			/* Trigger retrain by setting RL bit */
> +			pcie_capability_write_word(pdev, PCI_EXP_LNKCTL,
> +						   lnkctl | PCI_EXP_LNKCTL_RL);
> +
> +			/* Wait for retrain to complete (up to 1 second) */
> +			for (i = 0; i < 100; i++) {
> +				usleep_range(10000, 20000);
> +				ret = pcie_capability_read_word(pdev, PCI_EXP_LNKSTA,
> +								&lnksta);
> +				if (ret == 0 && (lnksta & PCI_EXP_LNKSTA_DLLLA) &&
> +				    !(lnksta & PCI_EXP_LNKSTA_LT)) {
> +					netdev_info(adapter->netdev,
> +						    "PCIe link recovery successful\n");
> +					return true;
> +				}
> +			}
> +		}
> +	}
> +
> +	/* Give the link some additional time to recover on its own */
> +	msleep(100);

That’s quite a long delay. Is that according to some standard?

> +
> +	/* Check if device is responding now */
> +	if (pci_device_is_present(pdev)) {
> +		ret = pcie_capability_read_word(pdev, PCI_EXP_LNKSTA, &lnksta);
> +		if (ret == 0 && (lnksta & PCI_EXP_LNKSTA_DLLLA)) {
> +			netdev_info(adapter->netdev,
> +				    "PCIe link recovered after delay\n");
> +			return true;
> +		}
> +	}
> +
> +	netdev_warn(adapter->netdev, "PCIe link recovery failed\n");
> +	return false;
> +}
> +
>   u32 igc_rd32(struct igc_hw *hw, u32 reg)
>   {
>   	struct igc_adapter *igc = container_of(hw, struct igc_adapter, hw);
>   	u8 __iomem *hw_addr = READ_ONCE(hw->hw_addr);
> +	struct net_device *netdev = igc->netdev;
>   	u32 value = 0;
> +	int retry;
>   
>   	if (IGC_REMOVED(hw_addr))
>   		return ~value;
> @@ -6997,13 +7094,49 @@ u32 igc_rd32(struct igc_hw *hw, u32 reg)
>   
>   	/* reads should not return all F's */
>   	if (!(~value) && (!reg || !(~readl(hw_addr)))) {
> -		struct net_device *netdev = igc->netdev;
> +		/* Layer 1: Immediate retries with short delays (100-200μs) */
> +		for (retry = 0; retry < IGC_REGISTER_READ_RETRIES; retry++) {
> +			usleep_range(100, 200);
> +			value = readl(&hw_addr[reg]);
> +
> +			/* If we got a valid read, return immediately */
> +			if (~value || (reg && ~readl(hw_addr))) {
> +				netdev_dbg(netdev,
> +					   "Register read recovered after %d retries\n",
> +					   retry + 1);
> +				return value;
> +			}
> +		}
> +
> +		/* Layer 2: Attempt full PCIe link recovery */
> +		netdev_warn(netdev,
> +			    "All immediate retries failed, attempting PCIe link recovery\n");
> +
> +		if (igc_pcie_link_recover(igc)) {
> +			/* Recovery succeeded, re-read the register */
> +			hw_addr = READ_ONCE(hw->hw_addr);
> +			if (hw_addr && !IGC_REMOVED(hw_addr)) {
> +				value = readl(&hw_addr[reg]);
> +
> +				/* Verify the read is valid */
> +				if (~value || (reg && ~readl(hw_addr))) {
> +					netdev_info(netdev,
> +						    "Register read successful after link recovery\n");
> +					return value;
> +				}
> +			}
> +		}
> +
> +		/* Layer 3: All recovery attempts failed, detach device */
> +		netdev_err(netdev,
> +			   "PCIe link lost after %d retries and recovery attempts, device now detached\n",
> +			   IGC_REGISTER_READ_RETRIES);
>   
>   		hw->hw_addr = NULL;
>   		netif_device_detach(netdev);
> -		netdev_err(netdev, "PCIe link lost, device now detached\n");
> +
>   		WARN(pci_device_is_present(igc->pdev),
> -		     "igc: Failed to read reg 0x%x!\n", reg);
> +		     "igc: Failed to read reg 0x%x after all recovery attempts!\n", reg);
>   	}
>   
>   	return value;

The idea looks good, but maybe there is something in Linux’ PCIe core to 
achieve something similar?


Kind regards,

Paul
