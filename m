Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F377939B969;
	Tue, 18 Aug 2026 11:13:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787051600; cv=none; b=XLuqcKzkTH0l3jKVb1fBEtaq21HF824pNlgjUCrMJZkKT4c+SniAkPIe5qvEJtJmdIttn6Y0ZB2TZHE92slgCrBeX8VhkOG4J/G3619XONe3PTD1tXRk0j8H7e1fdDQxMkOzLYee541LMdrS5h3tQpkZKyzv1iIYnqSWOHAgn+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787051600; c=relaxed/simple;
	bh=gUn4byAmS2EuYYChdIynLkqxwQqZ6D7Ox5zwblzUUeA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HaMqI9FJmrb5UKhwwXSLWDDz5cRQ3AtHvOJIgTDGD2nNBgJ74azW5IWvSQbLvaxQtLPWvFogXUvYg8S8pdWY1ZEaJk2kR8Ty+yqN6OtTORvkm+836uV8dYqE9Ji/BQJjb59ZGMrCRpTDVPuuIcekVoyibUzrmvTcsDKjKL1nnRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EWa7Azdq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EWa7Azdq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ACDA91F000E9;
	Tue, 18 Aug 2026 11:13:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787051598;
	bh=ZV8xZlaRYypc1He8B0YhELCdCPtH9qIJS9d0JlWHnAQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=EWa7AzdqXrvVjqCJ7/AZuAd4k8Q5V6nqskZhq6JkU8s8l9g0hSH9d7ELwUbsFkbif
	 8jDBd2P7EMQLnKV5RAdg35z+K4e/asH5I966hZeaOEk3+tvp9K0R8ZJDGADLkkvzyh
	 hjkkVTQ9nDYX7DvQkEvLALNjL4ZzwtYrGbEADZPh+qhc9X3G9mLJgHCNr/2czgy9jX
	 PPagM8aJ58wlASqKS3M8Il4kIgcaUaVCyTO/bQ2FNLTeD2yvtEOLvJN3I33h2sr78O
	 ggbDAlRK4xKEjYCz82DJ9wOMZrewIo1ViZRTJ1PaInGYfAvGtVSVp2Fvcnwy783t35
	 SP8+SCvThXeVA==
Date: Tue, 18 Aug 2026 13:13:10 +0200
From: Manivannan Sadhasivam <mani@kernel.org>
To: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>, 
	franzelverbier <info@humanlearning.ch>
Cc: Bartosz Golaszewski <brgl@kernel.org>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, Krzysztof Wilczynski <kwilczynski@kernel.org>, 
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, regressions@lists.linux.dev, 
	linux-pci@vger.kernel.org, linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [REGRESSION] PCIe/qcom: on-board WCN7850 link stuck in Polling
 on X1E80100 (Surface Pro 11)
Message-ID: <qgol7nv7vrhdwt6sofbxip3dat3kag4xgoamgp6li25rkbn4oa@ie5dhaswmxbt>
References: <20260731122233.18345-1-info@humanlearning.ch>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260731122233.18345-1-info@humanlearning.ch>

+ Krishna

- Mani

On Fri, Jul 31, 2026 at 02:22:25PM +0200, franzelverbier wrote:
> Hi,
> 
> On a Microsoft Surface Pro 11 (Snapdragon X Elite, X1E80100, board
> x1e80100-microsoft-denali-oled), the on-board WCN7850 Wi-Fi PCIe link
> no longer trains on linux-next. It works on 6.17.
> 
>   Good: v6.17
>   Bad:  next-20260721, next-20260723
> 
> #regzbot introduced: v6.17..next-20260721
> #regzbot title: PCIe/qcom: WCN7850 link stuck in Polling on X1E80100
> 
> The device sits behind PCIe controller 1c08000.pci (pcie4,
> qcom,pcie-x1e80100, gen3x2) and has no PERST# GPIO -- it is
> power-sequenced via wcn7850-pmu / pwrseq.
> 
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
> >= 8GT, so max-link-speed=<1> skips it entirely, reproducing the 6.17
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

-- 
மணிவண்ணன் சதாசிவம்
