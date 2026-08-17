Received: from relay.yourmailgateway.de (relay.yourmailgateway.de [194.59.206.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C595C3DB321;
	Mon, 17 Aug 2026 11:56:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.59.206.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786967791; cv=none; b=jtAA4fBsXSFubr/cXuJKPbQUqkMO8zAenSe/HxM+3JmZcfLsE5SfN827yRScTQPK7XSb2s0U3se6Cwsg9I1tCQgY0o1uxEn52Cy8NNATPkyzHvPQWdYTRSbQ0lzmA1+M4bMx5k9D+9qXXAuRi3Rg1yTKnxCI4/85BsSKf30E/XE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786967791; c=relaxed/simple;
	bh=nIWviEoqVfdHGl2nHooTwDbJaeGi2ImR4FYnhOByGq8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XuqK1aiQw1mCfYDOxErGUlwQNQP8WS+S0p81Ugxm2czatLjQPN8xBuVcul+wUZWqMPKGtNiqkDNk79KpQbBfpUIBLfQ2fBCw3ZpSGllu2d0TotZN2/E+G2QU3vhUNca5h5DFNatOa6GJP5tjDO8WEw0a9fFbyIhUmzV9XmULCJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b=Ahng1e8K; arc=none smtp.client-ip=194.59.206.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b="Ahng1e8K"
Received: from relay02-mors.netcup.net (localhost [127.0.0.1])
	by relay02-mors.netcup.net (Postfix) with ESMTPS id 4hNrs12lc4z49ys;
	Mon, 17 Aug 2026 13:56:21 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=leemhuis.info;
	s=key2; t=1786967781;
	bh=nIWviEoqVfdHGl2nHooTwDbJaeGi2ImR4FYnhOByGq8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Ahng1e8KhkhEHQW0DFvBS7iqOWNcUt2BlInR0EkH4XNre9LI8XYxub6caBzR6H63U
	 x3/ShL6JgCHhNepdPeO8/z0evz/TPTVjrVzIxL6i5pbJHgZeE4Sz9GsXvBWsK4q6IN
	 WMZChnJkqeVQWxXsqGIhXpk0rnpboL5AWqmvtJgLkiKkke2YqyzZePcouomgAGSVSs
	 1UevJoJ5W7RGsV0NLhZvH7mQH3yO4w4rU1zrRv/QbAHA5qwX2iB3BQzFuW1PNwuAAQ
	 OdLLfFI8Y+CZROG7pzWCCQ/skCKnurv5eD0mW2onXp7Mwal60w9b8n5z4bIF2oS+FH
	 NIcAbmb05JjMQ==
Received: from policy02-mors.netcup.net (unknown [46.38.225.35])
	by relay02-mors.netcup.net (Postfix) with ESMTPS id 4hNrs121bWz7wr8;
	Mon, 17 Aug 2026 13:56:21 +0200 (CEST)
Received: from mxe9fb.netcup.net (unknown [10.243.12.53])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by policy02-mors.netcup.net (Postfix) with ESMTPS id 4hNrs02TCHz8sb7;
	Mon, 17 Aug 2026 13:56:20 +0200 (CEST)
Received: from [IPV6:2a02:8108:8984:1d00:a0cf:1912:4be:477f] (unknown [IPv6:2a02:8108:8984:1d00:a0cf:1912:4be:477f])
	by mxe9fb.netcup.net (Postfix) with ESMTPSA id 283235FABE;
	Mon, 17 Aug 2026 13:56:15 +0200 (CEST)
Authentication-Results: mxe9fb;
        spf=pass (sender IP is 2a02:8108:8984:1d00:a0cf:1912:4be:477f) smtp.mailfrom=regressions@leemhuis.info smtp.helo=[IPV6:2a02:8108:8984:1d00:a0cf:1912:4be:477f]
Received-SPF: pass (mxe9fb: connection is authenticated)
Message-ID: <5e5cd4c8-a14e-4a1e-9bb0-155fce40907d@leemhuis.info>
Date: Mon, 17 Aug 2026 13:56:14 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [REGRESSION] PCIe/qcom: on-board WCN7850 link stuck in Polling on
 X1E80100 (Surface Pro 11)
To: franzelverbier <info@humanlearning.ch>,
 Manivannan Sadhasivam <mani@kernel.org>,
 Bartosz Golaszewski <brgl@kernel.org>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>,
 Krzysztof Wilczynski <kwilczynski@kernel.org>, Rob Herring
 <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
 regressions@lists.linux.dev, linux-pci@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260731122233.18345-1-info@humanlearning.ch>
From: Thorsten Leemhuis <regressions@leemhuis.info>
Content-Language: de-DE, en-US
In-Reply-To: <20260731122233.18345-1-info@humanlearning.ch>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-PPP-Message-ID: <178696777569.7059.392972048148323957@mxe9fb.netcup.net>
X-Rspamd-Server: rspamd-worker-8404
X-Rspamd-Queue-Id: 283235FABE
X-NC-CID: v/BpDrIPtEd3eGjh2FQ0WbuG52drth+1EX67iBkhSxDdH9XKVEs=

On 7/31/26 14:22, franzelverbier wrote:
> 
> On a Microsoft Surface Pro 11 (Snapdragon X Elite, X1E80100, board
> x1e80100-microsoft-denali-oled), the on-board WCN7850 Wi-Fi PCIe link
> no longer trains on linux-next. It works on 6.17.
> 
>   Good: v6.17
>   Bad:  next-20260721, next-20260723
> 
> The device sits behind PCIe controller 1c08000.pci (pcie4,
> qcom,pcie-x1e80100, gen3x2) and has no PERST# GPIO -- it is
> power-sequenced via wcn7850-pmu / pwrseq.

Thx for the report. Nobody replied, so either the right people didn't
see this or they had no idea what's wrong. So I guess you have to
recheck if 7.2 and -next are still affected and then bisect.

FWIW, I see quite a few regression reports and none sounded related.
Only the following one a little bit (there is no fix for it yet afaik)
-- but I fear I might send you in the wrong direction, so you might want
to ignore that I mentioned it:
https://bugzilla.kernel.org/show_bug.cgi?id=221801#c14

Ciao, Thorsten


> Symptom
> =======
> 
>   qcom-pcie 1c08000.pci: Device found, but not active
>   qcom-pcie 1c08000.pci: PCI host bridge to bus 0004:00
> 
> dw_pcie_wait_for_link() finds the LTSSM in POLL_ACTIVE/POLL_COMPLIANCE
> and returns -EIO. The endpoint 0004:01:00.0 is never enumerated, ath12k
> never probes, and there is no wlan interface. On 6.17 the same
> controller trains at ~0.6 s and ath12k probes normally.
> 
> Ruled out: the chip is powered, and power control is bound
> ==========================================================
> 
> - Bluetooth on the same WCN7850 (UART) comes up fine, so the PMU and
>   regulators are on.
> 
> - pwrseq_qcom_wcn is loaded, and pci-pwrctrl-pwrseq is bound to the
>   platform device 1c08000.pci:pcie@0:wifi@0 (compatible pci17cb,1107 is
>   present in pwrseq_pwrctrl_of_match[]). The vddaon-supply
>   validate_device() check passes.
> 
> Ruled out: not a device-tree regression
> =======================================
> 
> The wifi@0, &pcie4 and &pcie4_phy nodes are equivalent between the 6.17
> and 7.2 device trees -- same supplies, same compatibles. The only
> difference in wifi@0 is "disable-rfkill;" (6.17), which is
> post-enumeration ath12k behaviour and cannot affect link training.
> 
> What changed
> ============
> 
> qcom_pcie_host_init() was reworked around the pci-pwrctrl framework,
> and qcom_pcie_start_link() now calls qcom_pcie_common_set_equalization()
> -- absent in 6.17 -- before enabling the LTSSM.
> 
> Finding 1: Gen3 equalization prevents link training
> ===================================================
> 
> Forcing the port to Gen1 makes the link train and ath12k probe:
> 
>   &pcie4 { max-link-speed = <1>; status = "okay"; };
> 
>   qcom-pcie 1c08000.pci: PCIe Gen.1 x2 link up
>   ath12k_wifi7_pci 0004:01:00.0: Wi-Fi 7 Hardware name: wcn7850 hw2.0
> 
> qcom_pcie_common_set_equalization() only programs GEN3_EQ_* for speeds
>> = 8GT, so max-link-speed=<1> skips it entirely, reproducing the 6.17
> behaviour of no EQ programming.
> 
> Note this is not a wrong preset value. The presets come from DT via
> of_pci_get_equalization_presets() and are applied by the DWC host core.
> In hamoa.dtsi:
> 
>   pcie4  (pci@1c08000, gen3x2, on-board WCN7850)
>     eq-presets-8gts = /bits/ 16 <0x5555 0x5555>;
> 
>   pcie6a (pci@1bf8000, NVMe, gen4x4)
>     eq-presets-8gts = /bits/ 16 <0x5555 0x5555 0x5555 0x5555>;
> 
> Both use the same per-lane preset 0x5555. The NVMe port trains at Gen4
> fine; only the WCN7850 port fails. So the WCN7850 endpoint specifically
> cannot complete Gen3 equalization with these presets on this
> controller, while an NVMe SSD on the same SoC can.
> 
> The board DTS (x1-microsoft-denali.dtsi, also in mainline) leaves
> &pcie4 as status = "okay" with no per-port override, so it inherits the
> SoC preset.
> 
> Finding 2: an LTSSM re-kick does not recover the link
> =====================================================
> 
> Even at Gen1, the link does not train on the first attempt at boot
> (~4 s); in one instance it only came up much later via a pciehp slot
> event. An experimental retry in qcom_pcie_start_link() toggling
> PARF_LTSSM.LTSSM_EN (clear/set) for up to 30 s never recovered the
> link.
> 
> That suggests the endpoint needs a full power/reset re-sequence
> (pwrseq) to leave the failed state, not just an LTSSM restart -- i.e.
> the pwrseq power-on may be racing link bring-up at boot for PERST-less
> on-board devices.
> 
> When the link does come up late (fragmented CMA, tight PCI windows),
> secondary symptoms appear that are absent on a clean boot-time
> bring-up:
> 
>   ath12k ... qmi dma allocation failed
>   BAR 0 ... failed to assign
>   rfkill ... Hard blocked: yes
> 
> Questions
> =========
> 
> 1. Are the qcom_pcie_common_set_equalization() Gen3 EQ presets expected
>    to be safe for a gen3x2 PHY driving an on-board WCN7850? They
>    prevent link training here, and skipping them (Gen1) works.
> 
> 2. Is pci-pwrctrl/pwrseq power-on racing link training at boot for
>    on-board devices with no PERST# GPIO, such that the endpoint is not
>    ready on the first LTSSM attempt and cannot be recovered by an LTSSM
>    re-kick?
> 
> I have not bisected to a single commit yet -- the range above is v6.17
> to next-20260721. I am happy to bisect, test patches, or dump any
> register on this hardware; rebuilding is a short loop here.
> 
> Environment
> ===========
> 
> linux-next next-20260723, CONFIG_PCIE_QCOM=y, CONFIG_CMA_SIZE_MBYTES=128,
> ath12k, board x1e80100-microsoft-denali-oled, Arch Linux ARM (aarch64).
> 
> Thanks,
> franzelverbier
> 

