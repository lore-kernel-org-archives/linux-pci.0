Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AF9B3B840B;
	Fri, 16 Oct 2026 08:15:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792138508; cv=none; b=eFjErlVSbSbxBedb5Oof8rNY2zc9sHxYz/vrqyF0hHAEGRzkFimYzwlpToz4gvLn/0LIxbQs7hwU8xzHOYesi8HQitezVxDbsDoC5MpqfkucnihSrhxVsR12RROEGSF9vOfjxLdLObuCrj7JHWkvH0gfkgrWKuaNnkYrYLLB9u0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792138508; c=relaxed/simple;
	bh=yE3URZ4LSMCvfOHTLU90OfPc2FMggKfrDv0mgqN31aY=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=lWTfqoBsnsd60+Se6pK+sJMzJtdEFv5X2RKlxJ3d9zVqRu1aXpR9n/x2OSANE2IWNrQoB5sozW5r5AAX85itPe716BRb8rFqn7AGIKfAY7mGlV64l4P61vAzKKnp5ZUYstPZ9gOAjXr5C4Va+Aqq4JOCdfmPp/qcq7VmCEth8bk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=okLQqAE8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="okLQqAE8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E45B31F000C5;
	Fri, 16 Oct 2026 08:15:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792138506;
	bh=/bvCiLf6vBkMMBRNuJTrnlTfWU/nsPLGDPhU7Y1gras=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=okLQqAE8WESTLANfyyas5vOesaM6d77QUXYLF3JQKpwZN/rVoiVgv970tetV6toH7
	 s+Td6Yn5J+YVIY3mWDIBKtSZbLaoy6DUjnGCDLQAz7xxPy9p8psrTmCnZUZCnUhgVv
	 5UWEd0bJmdZubH2RgVhmtYfYD81We4I4OFupzUGQzEOhapIoaZSL86Rf4jSLO67DkU
	 Gh9+T6Fw7lWg9mMOxNW7co5HH50doju+3zCeK1H7ho2JOy2A0uIJ/tYfkgulIa8vhm
	 C0GShG2VyeN8HtLtsbWhwWd4AOlX5GcZI5TIBTtd9sSg4a72sYsn8z/o/z2HOwV3X3
	 RaFrOQVzK8osg==
Subject:
 Re: [PATCH net-next v2 2/5] net: enetc: Enable probing of version 4.4 devices
From: netdev-bot+sashiko@kernel.org
To: claudiu.manoil@nxp.com
Cc: netdev@vger.kernel.org, s32@nxp.com, linux-kernel@vger.kernel.org,
 bhelgaas@google.com, linux-pci@vger.kernel.org, kuba@kernel.org
Date: Fri, 16 Oct 2026 08:15:05 +0000
Message-ID: <179213850547.434549.3270982004598435479@kernel.org>
In-Reply-To: =?utf-8?q?=3C537a977b10b3d76c30b1f879f423bde4fd6f42f8=2E1791908?=
 =?utf-8?q?694=2Egit=2Eclaudiu=2Emanoil=40nxp=2Ecom=3E?=
References: =?utf-8?q?=3C537a977b10b3d76c30b1f879f423bde4fd6f42f8=2E17919086?=
 =?utf-8?q?94=2Egit=2Eclaudiu=2Emanoil=40nxp=2Ecom=3E?=
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

- [Medium] The patch enables ENETC v4.4 (S32N79) by adding ENETC_REV_4_4
  entries to enetc_info[], including { ENETC_REV_4_4,…

--

net: enetc: Enable probing of version 4.4 devices

This commit adds the ENETC_REV_4_4 revision define. It also adds
enetc_info[] entries for v4.4 devices, as found on S32N79 SoCs. Both PF
device IDs (0xe101 and 0xe110) map to enetc4_ppm_data, and the 0xef00
VF ID maps to enetc4_vf_data.

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
With this entry, v4.4 VFs probe with enetc4_vf_data and get
enetc_vf_ethtool_ops, which sets .get_ts_info = enetc_get_ts_info. Was the
second revision-keyed table in enetc_get_phc_index_by_pdev() in
enetc_ethtool.c meant to be updated as well? It only knows about the older
revisions:

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

On a v4.4 VF, enetc_vf_get_revision() computes si->revision as
(pdev->revision << 8) | ip_mn, which gives 0x0404. VFs have no OF node,
since the PCI fixup in this series only covers 0xe101/0xe110. So
enetc_get_phc_index() always falls back to the by-pdev lookup:

enetc_get_ts_info()
  enetc_get_phc_index()
    if (!np) return enetc_get_phc_index_by_pdev(si);
      default: return -1;
  goto timestamp_tx_sw;

As a result, ethtool -T on a v4.4 VF reports only
SOF_TIMESTAMPING_TX_SOFTWARE and no PHC, even with CONFIG_PTP_NETC_V4_TIMER
enabled.

enetc_hwtstamp_set() is gated only by enetc_ptp_clock_is_enabled():

	if (!enetc_ptp_clock_is_enabled(priv->si))
		return -EOPNOTSUPP;

So it still enables ENETC_F_TX_TSTAMP / ENETC_F_RX_TSTAMP on the same VF.
That leaves ethtool and the hwtstamp path disagreeing, and PTP userspace
has no PHC to pair with the hardware timestamps.

When REV_4_1 and REV_4_3 were enabled, each got a timer devfn in this
switch. Does the S32N79 NETC timer sit on the same PCI bus as the ENETC
functions?

If it does, should a REV_4_4 case with the right devfn be added here? If
it doesn't, should hardware timestamping be refused for v4.4 VFs, so that
ndo_hwtstamp_set and get_ts_info report the same thing?

The PFs use enetc4_ppm_data and enetc4_ppm_ethtool_ops, which have no
.get_ts_info, so the ethtool half of this does not apply to them.

>  
>  int enetc_get_driver_data(struct enetc_si *si)

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/cover.1791908694.git.claudiu.manoil%40nxp.com
