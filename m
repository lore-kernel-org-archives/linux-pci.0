Received: from smtp-8faf.mail.infomaniak.ch (smtp-8faf.mail.infomaniak.ch [83.166.143.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B44C63F1AC4
	for <linux-pci@vger.kernel.org>; Fri, 31 Jul 2026 12:22:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.166.143.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785500569; cv=none; b=bkVktJywVPZL1Spq8y64UEzZVjw/2ejCk9le47HRatjcD8gRip0e9ZOMqX3ETGuwIZ3/qwTKw9lPieUN0iCRHBv7nGduUkDRxvmDgMBa/eEP6ncp5gY1OuqV0wLMjysTnNuhsHTQ9rSzf6QNrfD8yEDjQ+DoGaoIjZxGZj811u0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785500569; c=relaxed/simple;
	bh=B3gbOU1609xgQfTraAjHyxGAmIN+X3B+HfT1WcROsgs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Km1M36IqWzVHf7pvG+sdsp5B1YRgXGGnbykp8XYYGoj3axzZHZWXplG81mmHIkiK3E+TKZRbUruQyZYp/hHdUKLo6xW8BEY+hJc/386btA0fFyQh5TTpve/t/TsuNvN66Ed93nvR6np7kwzYXRczh5udMyoymHemFmo1qvsLaV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=humanlearning.ch; spf=none smtp.mailfrom=humanlearning.ch; dkim=pass (2048-bit key) header.d=humanlearning.ch header.i=@humanlearning.ch header.b=B+ttijuO; arc=none smtp.client-ip=83.166.143.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=humanlearning.ch
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=humanlearning.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=humanlearning.ch header.i=@humanlearning.ch header.b="B+ttijuO"
Received: from smtp-3-0000.mail.infomaniak.ch (smtp-3-0000.mail.infomaniak.ch [10.4.36.107])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4hBQFC6SHNzHym;
	Fri, 31 Jul 2026 14:22:39 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=humanlearning.ch;
	s=20250828; t=1785500559;
	bh=qm9TKB413pUdh/ietlgH5F8e6i++Iz+1hU9IMjGeM2U=;
	h=From:To:Cc:Subject:Date:From;
	b=B+ttijuOv/F66fc14/JgbO4BIxjao9QnJhkFp0ej07xqHbm2P7VdBJwLQgsQnk9+P
	 ne4rBOWNTV6W0oyANioi8EZWEX4oZhR2BoxEuaY52ACAYOnSEQ67nSnSNnjaOHvfjA
	 XtZAnr05RCyNIwp4Oq/6k183q5lbHmHCf70Z6gideGQuhpP3vHqzLxg8h1t80X0vPE
	 Tqy9oXt8pcotJ414ZusAMqUeOu45QpA/wuMSU+jUdn8WyqmiZKk3M8ihXLQaqIgbNq
	 GAlQlK6fc1s83uNdfHq0DQFRhmCBrpCpI2WE7jtK3oI9E3jzpShx2P4RKgP5NUpNFX
	 Y2flfzZtH8xSg==
Received: from unknown by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4hBQFB4F1pzkWR;
	Fri, 31 Jul 2026 14:22:38 +0200 (CEST)
From: franzelverbier <info@humanlearning.ch>
To: Manivannan Sadhasivam <mani@kernel.org>,
	Bartosz Golaszewski <brgl@kernel.org>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof Wilczynski <kwilczynski@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	regressions@lists.linux.dev,
	linux-pci@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	franzelverbier <info@humanlearning.ch>
Subject: [REGRESSION] PCIe/qcom: on-board WCN7850 link stuck in Polling on X1E80100 (Surface Pro 11)
Date: Fri, 31 Jul 2026 14:22:25 +0200
Message-ID: <20260731122233.18345-1-info@humanlearning.ch>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Infomaniak-Routing: alpha

Hi,

On a Microsoft Surface Pro 11 (Snapdragon X Elite, X1E80100, board
x1e80100-microsoft-denali-oled), the on-board WCN7850 Wi-Fi PCIe link
no longer trains on linux-next. It works on 6.17.

  Good: v6.17
  Bad:  next-20260721, next-20260723

#regzbot introduced: v6.17..next-20260721
#regzbot title: PCIe/qcom: WCN7850 link stuck in Polling on X1E80100

The device sits behind PCIe controller 1c08000.pci (pcie4,
qcom,pcie-x1e80100, gen3x2) and has no PERST# GPIO -- it is
power-sequenced via wcn7850-pmu / pwrseq.

Symptom
=======

  qcom-pcie 1c08000.pci: Device found, but not active
  qcom-pcie 1c08000.pci: PCI host bridge to bus 0004:00

dw_pcie_wait_for_link() finds the LTSSM in POLL_ACTIVE/POLL_COMPLIANCE
and returns -EIO. The endpoint 0004:01:00.0 is never enumerated, ath12k
never probes, and there is no wlan interface. On 6.17 the same
controller trains at ~0.6 s and ath12k probes normally.

Ruled out: the chip is powered, and power control is bound
==========================================================

- Bluetooth on the same WCN7850 (UART) comes up fine, so the PMU and
  regulators are on.

- pwrseq_qcom_wcn is loaded, and pci-pwrctrl-pwrseq is bound to the
  platform device 1c08000.pci:pcie@0:wifi@0 (compatible pci17cb,1107 is
  present in pwrseq_pwrctrl_of_match[]). The vddaon-supply
  validate_device() check passes.

Ruled out: not a device-tree regression
=======================================

The wifi@0, &pcie4 and &pcie4_phy nodes are equivalent between the 6.17
and 7.2 device trees -- same supplies, same compatibles. The only
difference in wifi@0 is "disable-rfkill;" (6.17), which is
post-enumeration ath12k behaviour and cannot affect link training.

What changed
============

qcom_pcie_host_init() was reworked around the pci-pwrctrl framework,
and qcom_pcie_start_link() now calls qcom_pcie_common_set_equalization()
-- absent in 6.17 -- before enabling the LTSSM.

Finding 1: Gen3 equalization prevents link training
===================================================

Forcing the port to Gen1 makes the link train and ath12k probe:

  &pcie4 { max-link-speed = <1>; status = "okay"; };

  qcom-pcie 1c08000.pci: PCIe Gen.1 x2 link up
  ath12k_wifi7_pci 0004:01:00.0: Wi-Fi 7 Hardware name: wcn7850 hw2.0

qcom_pcie_common_set_equalization() only programs GEN3_EQ_* for speeds
>= 8GT, so max-link-speed=<1> skips it entirely, reproducing the 6.17
behaviour of no EQ programming.

Note this is not a wrong preset value. The presets come from DT via
of_pci_get_equalization_presets() and are applied by the DWC host core.
In hamoa.dtsi:

  pcie4  (pci@1c08000, gen3x2, on-board WCN7850)
    eq-presets-8gts = /bits/ 16 <0x5555 0x5555>;

  pcie6a (pci@1bf8000, NVMe, gen4x4)
    eq-presets-8gts = /bits/ 16 <0x5555 0x5555 0x5555 0x5555>;

Both use the same per-lane preset 0x5555. The NVMe port trains at Gen4
fine; only the WCN7850 port fails. So the WCN7850 endpoint specifically
cannot complete Gen3 equalization with these presets on this
controller, while an NVMe SSD on the same SoC can.

The board DTS (x1-microsoft-denali.dtsi, also in mainline) leaves
&pcie4 as status = "okay" with no per-port override, so it inherits the
SoC preset.

Finding 2: an LTSSM re-kick does not recover the link
=====================================================

Even at Gen1, the link does not train on the first attempt at boot
(~4 s); in one instance it only came up much later via a pciehp slot
event. An experimental retry in qcom_pcie_start_link() toggling
PARF_LTSSM.LTSSM_EN (clear/set) for up to 30 s never recovered the
link.

That suggests the endpoint needs a full power/reset re-sequence
(pwrseq) to leave the failed state, not just an LTSSM restart -- i.e.
the pwrseq power-on may be racing link bring-up at boot for PERST-less
on-board devices.

When the link does come up late (fragmented CMA, tight PCI windows),
secondary symptoms appear that are absent on a clean boot-time
bring-up:

  ath12k ... qmi dma allocation failed
  BAR 0 ... failed to assign
  rfkill ... Hard blocked: yes

Questions
=========

1. Are the qcom_pcie_common_set_equalization() Gen3 EQ presets expected
   to be safe for a gen3x2 PHY driving an on-board WCN7850? They
   prevent link training here, and skipping them (Gen1) works.

2. Is pci-pwrctrl/pwrseq power-on racing link training at boot for
   on-board devices with no PERST# GPIO, such that the endpoint is not
   ready on the first LTSSM attempt and cannot be recovered by an LTSSM
   re-kick?

I have not bisected to a single commit yet -- the range above is v6.17
to next-20260721. I am happy to bisect, test patches, or dump any
register on this hardware; rebuilding is a short loop here.

Environment
===========

linux-next next-20260723, CONFIG_PCIE_QCOM=y, CONFIG_CMA_SIZE_MBYTES=128,
ath12k, board x1e80100-microsoft-denali-oled, Arch Linux ARM (aarch64).

Thanks,
franzelverbier
