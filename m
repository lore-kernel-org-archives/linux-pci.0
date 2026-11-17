Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794930911;
	b=QAWJCA9fDoujX+TeYH8+eNf4zp/nwFimK6q8Yqqgs7Hv4WNDGDlWPcPMO/x6kdFCndtX
	 YDdONHmmSjF5dYcocdQvk8w6lAQCreuHMrkiLImGDkhD3asLw/Uv49pGVi62e92AK+Rdt
	 9OyyoZzKRVD1fxk6ycjqmFqYxggOS0thm0gDUfnYrdUJ3AqOvnD4OP9zKbYGVgXEkcOsi
	 68qw7IjvGwin8Qs4ZE6aLBuCAh+FRdj6kJH6M7tgbMHJmceHBEhh/tYRPrakxmogqT+Y8
	 mXCviCNeYprrdKZp/eTkSn/irrKWZ9v2f/kQWTigi7xPdCCTEIgKFi/nP1MBTBBtA3Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794930911;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=JjXoxd40XZCM2J7imHc+xCLCgdNEwbxkjgF0ryjpVlA=;
	b=FyfaHAyPmxHd9atqWdIO9LVnPXXjqDOq++jY1T+aZQMPVfyi9qiwgxcEqjAxU0zA1tlV
	 B7fsHlzVejcnEJcwclP3VMIGhSspDicafgFIyuo/W2Ylib/lVUJ8eGJvBsFKlT+3GBiTr
	 IypQclhGLwN/jH0FA8rHVpYjYYQBDCruB1/DQA+d8beejltMbXR51mcOny269Dx4XDPVy
	 e5fPOKtCdbGJZTQJgBsjlBVLr0KmOW+Eu5anHMNFrcDU7y5NQMphPiXXNFE8ZaHlsdD90
	 8xxURmAfXsAE88Sm6jGxJNSmjEhtV1Z2ySEBvBpbHmT5DPkbxeos7j/fy/AVIouHeeQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aP8BaIh4;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA026606A332;
	Tue, 17 Nov 2026 15:55:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aP8BaIh4
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3194B1F000C7;
	Tue, 17 Nov 2026 15:55:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794930911;
	bh=JjXoxd40XZCM2J7imHc+xCLCgdNEwbxkjgF0ryjpVlA=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=aP8BaIh4sP4CnWtehw0gVhPcmNcGR4lQ4G+wP2mbhujNlC3TafX+BIajd7bAM1hXc
	 C1J8tstlQsf99ilWORjsZ+H6yRsD+ohfcqH4fmdDAa2z1DU7s0TkMlhVi0u+Oijp7W
	 Lw03Of3eOFxNNEN8dQE6nMiQqOFz121SCbf1P1xAH9K514S1jcYsRZ/HkOznRP72r1
	 CHBnwic1sgSQ4plsvNjLNRzffzgDR4QWLBAlbfRH053KABJIduTXvJKNl/x3jx1xuz
	 UQS1E0XvBTr2TMQnneDs/XhJMlsOmFe08lzNRat7kize5kLd7vh1UKmVMPTDwn+u8Z
	 gy/lV/oJq4xVw==
Subject:
 Re: [PATCH net-next v4 3/6] net: enetc: Enable probing of version 4.4 devices
From: netdev-bot+sashiko@kernel.org
To: claudiu.manoil@nxp.com
Cc: netdev@vger.kernel.org, s32@nxp.com, bhelgaas@google.com,
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, kuba@kernel.org
Date: Tue, 17 Nov 2026 15:55:10 +0000
Message-ID: <179493091076.3136.7730860553084197808@kernel.org>
In-Reply-To: <d783ccebf4b38bfd1e2ede44c36682269a5bc68e.1794581338.git.claudiu.manoil@nxp.com>
References: <d783ccebf4b38bfd1e2ede44c36682269a5bc68e.1794581338.git.claudiu.manoil@nxp.com>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 2 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 2 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] This patch adds ENETC_REV_4_4 entries to enetc_info[] so that
  S32N79 PFs (0xe101/0xe110) and VFs (0xef00) now probe.
- [Medium] When an ENETC v4 VF cannot get the IP minor revision from its
  PF over the VSI-PSI mailbox, enetc_vf_get_revision()…

--

net: enetc: Enable probing of version 4.4 devices

This commit adds driver data and platform info entries for the ENETC v4.4
PF and VF devices on S32N79 SoCs. These run with a 500 MHz system clock.
The PFs use the 0xe101 or 0xe110 device ID and the VFs use 0xef00.

> diff --git a/drivers/net/ethernet/freescale/enetc/enetc.c b/drivers/net/ethernet/freescale/enetc/enetc.c
> index 855b2d3b87182..e3aa117d323d5 100644
> --- a/drivers/net/ethernet/freescale/enetc/enetc.c
> +++ b/drivers/net/ethernet/freescale/enetc/enetc.c
> @@ -3840,6 +3840,20 @@ static const struct enetc_drvdata enetc4_vf_data = {

[ ... ]

> +static const struct enetc_drvdata enetc4_s32n79_vf_data = {
> +	.sysclk_freq = ENETC_CLK_500M,
> +	.tx_csum = true,
> +	.max_frags = ENETC4_MAX_SKB_FRAGS,
> +	.eth_ops = &enetc_vf_ethtool_ops,
> +};

[Severity: Medium]
Can an S32N79 VF end up with the 333 MHz drvdata instead of this one?

The VF gets its minor revision from the PF over the VSI-PSI mailbox. If
that query fails, enetc_vf_get_revision() falls back to 4.1:

drivers/net/ethernet/freescale/enetc/enetc_vf.c:enetc_vf_get_revision() {
    ...
	ip_mn = enetc_vf_get_ip_minor_revision(si);
	if (ip_mn >= 0) {
		si->revision = (si->pdev->revision << 8) | ip_mn;
		return;
	}

	si->revision = ENETC_REV_4_1;
    ...
}

The query can fail in several ways:

- -EIO when the mailbox is busy
- -ETIMEDOUT after the 200 ms poll
- an error status returned by the PSI
- -ENOMEM from dma_alloc_coherent()

S32N79 VFs use the same 0xef00 device ID. So in that case
enetc_get_driver_data() matches {ENETC_REV_4_1, NXP_ENETC_VF_DEV_ID} and
selects enetc4_vf_data, which uses ENETC_CLK_333M. enetc_vf_netdev_setup()
then copies that value into priv->sysclk_freq.

Before this patch every v4 platform ran at 333 MHz, so the fallback made no
difference. On a 500 MHz platform, wouldn't enetc_usecs_to_cycles() program
the default 600 us tx_ictt, the DIM rx_ictt and the set_coalesce values at
roughly 0.67x the requested timeout?

enetc_get_coalesce() converts back with the same clock. So ethtool -c would
still show the requested values while the hardware fires about 1.5x sooner.

Should the fallback change now that v4 platforms don't all use the same
clock frequency?

> @@ -3870,6 +3884,18 @@ static const struct enetc_platform_info enetc_info[] = {
>  	  .dev_id = NXP_ENETC_VF_DEV_ID,
>  	  .data = &enetc4_vf_data,
>  	},
> +	{ .revision = ENETC_REV_4_4,
> +	  .dev_id = NXP_ENETC_PPM_DEV_ID,
> +	  .data = &enetc4_s32n79_ppm_data,
> +	},
> +	{ .revision = ENETC_REV_4_4,
> +	  .dev_id = NXP_ENETC_PF_DEV_ID,
> +	  .data = &enetc4_s32n79_ppm_data,
> +	},
> +	{ .revision = ENETC_REV_4_4,
> +	  .dev_id = NXP_ENETC_VF_DEV_ID,
> +	  .data = &enetc4_s32n79_vf_data,
> +	},

[Severity: Medium]
Does enetc_get_phc_index_by_pdev() in enetc_ethtool.c also need an
ENETC_REV_4_4 case? It has its own per-revision table for the timer devfn:

drivers/net/ethernet/freescale/enetc/enetc_ethtool.c:enetc_get_phc_index_by_pdev() {
    ...
	switch (si->revision) {
	case ENETC_REV_1_0:
		devfn = PCI_DEVFN(0, 4);
		break;
	case ENETC_REV_4_1:
		devfn = PCI_DEVFN(24, 0);
		break;
	case ENETC_REV_4_3:
		devfn = PCI_DEVFN(0, 1);
		break;
	default:
		return -1;
	}
    ...
}

enetc4_s32n79_vf_data uses enetc_vf_ethtool_ops, which provides
enetc_get_ts_info(). SR-IOV VFs have no OF node, so enetc_get_phc_index()
always takes the per-pdev path. For a v4.4 VF the call chain is:

enetc_get_ts_info()
  enetc_get_phc_index()
    enetc_get_phc_index_by_pdev()
      default: return -1

enetc_get_ts_info() then jumps to timestamp_tx_sw. It reports no PHC and
only SOF_TIMESTAMPING_TX_SOFTWARE.

enetc_hwtstamp_set() and enetc_hwtstamp_get() still accept hardware
timestamping configs, because they only check
enetc_ptp_clock_is_enabled().

Would ptp4l and similar tools then fail to find a PHC on S32N79 VFs?

The v4.4 PF uses enetc4_ppm_ethtool_ops, which has no get_ts_info, so this
seems to affect only the VFs.

The code doesn't show whether a NETC timer is reachable on the VF's PCI
bus on S32N79. If PTP is intentionally left unsupported on v4.4, could the
commit message say so?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/cover.1794581338.git.claudiu.manoil%40nxp.com
