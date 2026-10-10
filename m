Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A971A286D5E;
	Sat, 10 Oct 2026 13:13:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791638040; cv=none; b=nxVkOD2FG2v1gDd9vgt0PcSDw7hxUOAXdoj1qAuA8GCuLXhiuiJyZlHUvnvkRGJnqBxAQn8SIuwZU5fXtjhgn0AQI6VZEitmrlRovvmwU0Y8Wr/PeMfrAVHHyRq9FKFzN7asDZw94tlvPEwOLLpgxpBiXzOQY3Fpg8Gz8Wtucyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791638040; c=relaxed/simple;
	bh=HW4bC4+ACzcaJTz7eEGMVRQs/aH5ZmU2w2SnDvawczo=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=f8n8HGCbB3L/amDYqnd5YbSyALrCoVbfmYFZhXurUAJObGG6VtLcHkK8g0cSNHTAUIUZiZjfU5AoWMzH5BQPZfH+kC5S72HazA3D3f2qD09maZeM85O3lL6trZ4OEiFY65mpkOVDSvDgxemMy64b9AmrE2GjwQZFXBhIiBifxCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f6CI7VAQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f6CI7VAQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE3A41F00893;
	Sat, 10 Oct 2026 13:13:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791638039;
	bh=G4DurIPQU9bL4Z78zsuNIKfFmKPXzDLFqR1vOt72FdA=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=f6CI7VAQDRHZlRidqmrARNyPTAlwt9+sPmt3Zc1PS+mP2Hiz7/MkpypfVQ6sBldqi
	 z+qlHQB59rfyFM2YekAZZi4/DHT+qL10kIaYsuethBW41IkM24yJhQGCLrepC8tw0q
	 EPAtP38tEycNGXW6Ex5CuNtgKHSX+i/CEe4jDSkoIxjEaXUw0Lsb7Rvo8Dof+5Fesl
	 K3gGzJWfQHlthNren1Lj/MTGoosabQaPnHtMWdUQQYyuD5hfUebknsyienNoH/nqCD
	 Hw3IMiHsJ1FMWCS1UL8NNskT5QWy3WIAJV68tvigs0RGREUj4gXVUeIAWiKTlEJnld
	 UkvP6vJKsAA2Q==
Subject:
 Re: [PATCH net-next v1 2/5] net: enetc: Enable probing of version 4.4 devices
From: netdev-bot+sashiko@kernel.org
To: claudiu.manoil@nxp.com
Cc: netdev@vger.kernel.org, s32@nxp.com, bhelgaas@google.com,
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, kuba@kernel.org
Date: Sat, 10 Oct 2026 13:13:58 +0000
Message-ID: <179163803841.434549.16289353134448452747@kernel.org>
In-Reply-To: =?utf-8?q?=3C701f38d08f9ea371877645223e6ac919af7870b5=2E1791548?=
 =?utf-8?q?316=2Egit=2Eclaudiu=2Emanoil=40nxp=2Ecom=3E?=
References: =?utf-8?q?=3C701f38d08f9ea371877645223e6ac919af7870b5=2E17915483?=
 =?utf-8?q?16=2Egit=2Eclaudiu=2Emanoil=40nxp=2Ecom=3E?=
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 1 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 1 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] The patch "net: enetc: Enable probing of version 4.4 devices"
  adds ENETC_REV_4_4 entries to enetc_info[] in…

--

net: enetc: Enable probing of version 4.4 devices

This commit adds ENETC_REV_4_4 and new enetc_info[] entries so that the
v4.4 ENETC devices on S32N79 can probe. The PFs (0xe101 and 0xe110) use
enetc4_ppm_data and the VFs (0xef00) use enetc4_vf_data.

> diff --git a/drivers/net/ethernet/freescale/enetc/enetc.c b/drivers/net/ethernet/freescale/enetc/enetc.c
> index c6571b5cc8425..be7795d4e0c66 100644
> --- a/drivers/net/ethernet/freescale/enetc/enetc.c
> +++ b/drivers/net/ethernet/freescale/enetc/enetc.c
> @@ -3862,6 +3862,18 @@ static const struct enetc_platform_info enetc_info[] = {

[ ... ]

> +	{ .revision = ENETC_REV_4_4,
> +	  .dev_id = NXP_ENETC_VF_DEV_ID,
> +	  .data = &enetc4_vf_data,
> +	},
>  };

[Severity: Medium]
With v4.4 VFs now probing, does enetc_get_phc_index_by_pdev() in
enetc_ethtool.c also need an ENETC_REV_4_4 case? Right now its switch
only covers the older revisions:

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

enetc4_vf_data uses enetc_vf_ethtool_ops, which has .get_ts_info set to
enetc_get_ts_info(). On S32N79, enetc_vf_get_revision() sets
si->revision to 0x0404. enetc_ptp_clock_is_enabled() only looks at
CONFIG_PTP_NETC_V4_TIMER for non-rev1 parts, so the VF continues into
the PHC lookup:

enetc_get_ts_info()
  enetc_get_phc_index()
    enetc_get_phc_index_by_pdev()   <- no OF node or no "ptp-timer" phandle
      default: return -1

The netc_iep18 node in s32n79.dtsi has no child nodes, so the VF cannot
get a ptp-timer phandle from DT. enetc_get_ts_info() then jumps to
timestamp_tx_sw and reports only SOF_TIMESTAMPING_TX_SOFTWARE with no
PHC.

enetc_hwtstamp_set() still accepts HWTSTAMP_TX_ON on the same VF,
because it only checks enetc_ptp_clock_is_enabled(). So what ethtool -T
reports and what ndo_hwtstamp_set accepts would not agree.

When v4.3 was enabled, a devfn case was added to this switch alongside
it. Is there a NETC timer function (0x1131:0xee02) on the S32N79 IEP
bus that should be listed here? If not, would it make sense to note
that in the commit message, and to also keep enetc_hwtstamp_set() from
accepting hardware timestamping on these VFs?

The v4.4 PFs don't seem to be affected, because enetc4_ppm_ethtool_ops
has no .get_ts_info callback.

> diff --git a/drivers/net/ethernet/freescale/enetc/enetc_hw.h b/drivers/net/ethernet/freescale/enetc/enetc_hw.h
> index 2c9d9042eb0bb..64789bd0f33ed 100644
> --- a/drivers/net/ethernet/freescale/enetc/enetc_hw.h
> +++ b/drivers/net/ethernet/freescale/enetc/enetc_hw.h

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/cover.1791548316.git.claudiu.manoil%40nxp.com
