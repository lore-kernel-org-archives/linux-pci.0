Received: from relay.yourmailgateway.de (relay.yourmailgateway.de [188.68.63.162])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6639416854;
	Mon, 24 Aug 2026 12:46:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.68.63.162
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787575616; cv=none; b=DoZnWRV6BdwmQIc2dU8cXyvU3Bpv+2p5BxHVe7aQIWZHQXCSYQXIWz0UZeL8OfihCwCqdVlY4UN7Mt30pHMyneksL5N+I/wh5uuP912Xy1VL5GCFiIUaYm/TBoVdwB5NQ9Ctu8TvGdsLxAXu5SSyG8QDwe7yIk+zYPlIvnqNMDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787575616; c=relaxed/simple;
	bh=0l2zeqrTdw9H+RHbIvbgxdX3SD9eSTkmI+cOQDy5rkw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TkNLh7NYyzHLKB2H8GfiGl+pb0DdFnh+SUszB7hUVJ0zvh06qvU58nrIlrG/WQC2iEozITiOaNM+JiAPsjIWa8DtwaUjHtr+xttdYmIFvXBGom6+blAXi3fpOE9IO8vjPT6aVXic/1VbDwOqosEwRrFT0gJ+0gkjeMcD5YiuD0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b=VgIg5y6m; arc=none smtp.client-ip=188.68.63.162
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b="VgIg5y6m"
Received: from mors-relay-8201.netcup.net (localhost [127.0.0.1])
	by mors-relay-8201.netcup.net (Postfix) with ESMTPS id 4hT9dw0Nymz3v7T;
	Mon, 24 Aug 2026 14:46:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=leemhuis.info;
	s=key2; t=1787575604;
	bh=0l2zeqrTdw9H+RHbIvbgxdX3SD9eSTkmI+cOQDy5rkw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=VgIg5y6mlw/AaxlzF0RPGz8GioiHOn6lHFB9iqmBro/bqlk5JayWLHiAGIVX4dVVh
	 SnYCdtI9o50EHgd+riNRziRCCdNT+zXJhzlZuoQ1a81QjY5nNwEqfCTjORTouw2oGm
	 fgJKE7CTyMglcHxF/5GRMyQhReqJpjMYPKG265N76xHGSW9MM2xSV4lZx60T7Wqohy
	 rYdK3YjnaC6TCpaW1OLI2eawqnC7YdYLYD9ItzCTl8nqTUEgKh2GVFszuV5GOueBLA
	 1oFxoeZIQcIJ8SXJuYqD7571sdT1PC+wTpvwHx8ZDPqB85vh5JPWaH4J3wCOO3eNqQ
	 g4YL4OeFGW7OA==
Received: from policy02-mors.netcup.net (unknown [46.38.225.35])
	by mors-relay-8201.netcup.net (Postfix) with ESMTPS id 4hT9dv6nmPz3rj5;
	Mon, 24 Aug 2026 14:46:43 +0200 (CEST)
Received: from mxe9fb.netcup.net (unknown [10.243.12.53])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by policy02-mors.netcup.net (Postfix) with ESMTPS id 4hT9dt6r4zz8sZP;
	Mon, 24 Aug 2026 14:46:42 +0200 (CEST)
Received: from [IPV6:2a02:8108:8984:1d00:a0cf:1912:4be:477f] (unknown [IPv6:2a02:8108:8984:1d00:a0cf:1912:4be:477f])
	by mxe9fb.netcup.net (Postfix) with ESMTPSA id E2E8D5FA38;
	Mon, 24 Aug 2026 14:46:37 +0200 (CEST)
Authentication-Results: mxe9fb;
        spf=pass (sender IP is 2a02:8108:8984:1d00:a0cf:1912:4be:477f) smtp.mailfrom=regressions@leemhuis.info smtp.helo=[IPV6:2a02:8108:8984:1d00:a0cf:1912:4be:477f]
Received-SPF: pass (mxe9fb: connection is authenticated)
Message-ID: <f64db45c-63f7-4f2e-aa10-e8ee5fd9accb@leemhuis.info>
Date: Mon, 24 Aug 2026 14:46:36 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [REGRESSION] PCIe/qcom: on-board WCN7850 link stuck in Polling on
 X1E80100 (Surface Pro 11)
To: Manivannan Sadhasivam <mani@kernel.org>,
 Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>,
 franzelverbier <info@humanlearning.ch>
Cc: Bartosz Golaszewski <brgl@kernel.org>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
 Krzysztof Wilczynski <kwilczynski@kernel.org>, Rob Herring
 <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
 regressions@lists.linux.dev, linux-pci@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260731122233.18345-1-info@humanlearning.ch>
 <qgol7nv7vrhdwt6sofbxip3dat3kag4xgoamgp6li25rkbn4oa@ie5dhaswmxbt>
From: Thorsten Leemhuis <regressions@leemhuis.info>
Content-Language: de-DE, en-US
In-Reply-To: <qgol7nv7vrhdwt6sofbxip3dat3kag4xgoamgp6li25rkbn4oa@ie5dhaswmxbt>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-PPP-Message-ID: 
 <178757559850.2729949.14311381177292394726@mxe9fb.netcup.net>
X-Rspamd-Server: rspamd-worker-8404
X-Rspamd-Queue-Id: E2E8D5FA38
X-NC-CID: wfs2Aj5DfQ4rH2iAQKmoymFkKFqLoPerQgMfpVmfTihTsK25VqQ=

On 8/18/26 13:13, Manivannan Sadhasivam wrote:
> + Krishna

Hmm, nothing happened here. Or did it and I just missed it?

Krishna, it seemed Mani thought you might haven an idea what's wrong. Do
you do by chance?

If not, I guess Franzelverbier might need to bisect this.

Ciao, Thorsten

> On Fri, Jul 31, 2026 at 02:22:25PM +0200, franzelverbier wrote:
>> Hi,
>>
>> On a Microsoft Surface Pro 11 (Snapdragon X Elite, X1E80100, board
>> x1e80100-microsoft-denali-oled), the on-board WCN7850 Wi-Fi PCIe link
>> no longer trains on linux-next. It works on 6.17.
>>
>>   Good: v6.17
>>   Bad:  next-20260721, next-20260723
>>
>> #regzbot introduced: v6.17..next-20260721
>> #regzbot title: PCIe/qcom: WCN7850 link stuck in Polling on X1E80100
>>
>> The device sits behind PCIe controller 1c08000.pci (pcie4,
>> qcom,pcie-x1e80100, gen3x2) and has no PERST# GPIO -- it is
>> power-sequenced via wcn7850-pmu / pwrseq.
>>
>> Symptom
>> =======
>>
>>   qcom-pcie 1c08000.pci: Device found, but not active
>>   qcom-pcie 1c08000.pci: PCI host bridge to bus 0004:00
>>
>> dw_pcie_wait_for_link() finds the LTSSM in POLL_ACTIVE/POLL_COMPLIANCE
>> and returns -EIO. The endpoint 0004:01:00.0 is never enumerated, ath12k
>> never probes, and there is no wlan interface. On 6.17 the same
>> controller trains at ~0.6 s and ath12k probes normally.
>>
>> Ruled out: the chip is powered, and power control is bound
>> ==========================================================
>>
>> - Bluetooth on the same WCN7850 (UART) comes up fine, so the PMU and
>>   regulators are on.
>>
>> - pwrseq_qcom_wcn is loaded, and pci-pwrctrl-pwrseq is bound to the
>>   platform device 1c08000.pci:pcie@0:wifi@0 (compatible pci17cb,1107 is
>>   present in pwrseq_pwrctrl_of_match[]). The vddaon-supply
>>   validate_device() check passes.
>>
>> Ruled out: not a device-tree regression
>> =======================================
>>
>> The wifi@0, &pcie4 and &pcie4_phy nodes are equivalent between the 6.17
>> and 7.2 device trees -- same supplies, same compatibles. The only
>> difference in wifi@0 is "disable-rfkill;" (6.17), which is
>> post-enumeration ath12k behaviour and cannot affect link training.
>>
>> What changed
>> ============
>>
>> qcom_pcie_host_init() was reworked around the pci-pwrctrl framework,
>> and qcom_pcie_start_link() now calls qcom_pcie_common_set_equalization()
>> -- absent in 6.17 -- before enabling the LTSSM.
>>
>> Finding 1: Gen3 equalization prevents link training
>> ===================================================
>>
>> Forcing the port to Gen1 makes the link train and ath12k probe:
>>
>>   &pcie4 { max-link-speed = <1>; status = "okay"; };
>>
>>   qcom-pcie 1c08000.pci: PCIe Gen.1 x2 link up
>>   ath12k_wifi7_pci 0004:01:00.0: Wi-Fi 7 Hardware name: wcn7850 hw2.0
>>
>> qcom_pcie_common_set_equalization() only programs GEN3_EQ_* for speeds
>>> = 8GT, so max-link-speed=<1> skips it entirely, reproducing the 6.17
>> behaviour of no EQ programming.
>>
>> Note this is not a wrong preset value. The presets come from DT via
>> of_pci_get_equalization_presets() and are applied by the DWC host core.
>> In hamoa.dtsi:
>>
>>   pcie4  (pci@1c08000, gen3x2, on-board WCN7850)
>>     eq-presets-8gts = /bits/ 16 <0x5555 0x5555>;
>>
>>   pcie6a (pci@1bf8000, NVMe, gen4x4)
>>     eq-presets-8gts = /bits/ 16 <0x5555 0x5555 0x5555 0x5555>;
>>
>> Both use the same per-lane preset 0x5555. The NVMe port trains at Gen4
>> fine; only the WCN7850 port fails. So the WCN7850 endpoint specifically
>> cannot complete Gen3 equalization with these presets on this
>> controller, while an NVMe SSD on the same SoC can.
>>
>> The board DTS (x1-microsoft-denali.dtsi, also in mainline) leaves
>> &pcie4 as status = "okay" with no per-port override, so it inherits the
>> SoC preset.
>>
>> Finding 2: an LTSSM re-kick does not recover the link
>> =====================================================
>>
>> Even at Gen1, the link does not train on the first attempt at boot
>> (~4 s); in one instance it only came up much later via a pciehp slot
>> event. An experimental retry in qcom_pcie_start_link() toggling
>> PARF_LTSSM.LTSSM_EN (clear/set) for up to 30 s never recovered the
>> link.
>>
>> That suggests the endpoint needs a full power/reset re-sequence
>> (pwrseq) to leave the failed state, not just an LTSSM restart -- i.e.
>> the pwrseq power-on may be racing link bring-up at boot for PERST-less
>> on-board devices.
>>
>> When the link does come up late (fragmented CMA, tight PCI windows),
>> secondary symptoms appear that are absent on a clean boot-time
>> bring-up:
>>
>>   ath12k ... qmi dma allocation failed
>>   BAR 0 ... failed to assign
>>   rfkill ... Hard blocked: yes
>>
>> Questions
>> =========
>>
>> 1. Are the qcom_pcie_common_set_equalization() Gen3 EQ presets expected
>>    to be safe for a gen3x2 PHY driving an on-board WCN7850? They
>>    prevent link training here, and skipping them (Gen1) works.
>>
>> 2. Is pci-pwrctrl/pwrseq power-on racing link training at boot for
>>    on-board devices with no PERST# GPIO, such that the endpoint is not
>>    ready on the first LTSSM attempt and cannot be recovered by an LTSSM
>>    re-kick?
>>
>> I have not bisected to a single commit yet -- the range above is v6.17
>> to next-20260721. I am happy to bisect, test patches, or dump any
>> register on this hardware; rebuilding is a short loop here.
>>
>> Environment
>> ===========
>>
>> linux-next next-20260723, CONFIG_PCIE_QCOM=y, CONFIG_CMA_SIZE_MBYTES=128,
>> ath12k, board x1e80100-microsoft-denali-oled, Arch Linux ARM (aarch64).
>>
>> Thanks,
>> franzelverbier
> 

