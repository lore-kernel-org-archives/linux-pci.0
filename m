Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.251.105.195
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793818610;
	b=pUI1nTME9cbfVlquzLORE06nHX9/X0C0QV30xdwnMQ8NMrbg6EtveHwu+u0ieVyXhf51
	 C+FgIGGwOgZPWjTChJXE6cmYfZBIxHMEovlBg2/BygnMpK50OueOMHXV4pO68iIK53hEb
	 k/1jZhuUBSAQkCAKt443pkQS0CG3PSDtzkPKcUeGJwJViiQGonbiDTMuZKrJaPepMaSpe
	 sCQ5XQKkXGeA0mVR5N0BYILodiG2w5uBIViM+bv72PxYm029qyYokLpT6r+7IexwP3IwI
	 KKI2RB4y1Ia7Dizu//KJlnWdPXFefEn1RkdK2I0CIStAmURPMBlaHvLbJC7M4mRwJOg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793818610;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:Subject:Date:
	 Message-Id:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:
	 X-Developer-Key;
	bh=T8rIgPmASaQ6EqBhG0uyatVrEBQDeLgoQ78+SrZDhks=;
	b=sGVoVHELa+FPWlr87oC8DTv4D6O/orFO6VOwOp6WnfC0kQWdtGsJoYy6xi+33xZiAXyE
	 EzRAaVhSaMAD9j895391CSBsg0NSUQw9jfCvvblo/IER9lBfWB1hcgzDp10c9bCZgRMeq
	 VJarJFBrdNQNsqCou8hESW9bk3tKLOuYz/6MGLxUNWGsmfGAKToHFJs72j8Ly5twrgMAi
	 X7GIPHTqz2f1wVTMM3x3pQ8YirN5rU86T+Vz8n4AP/3y6UWdxzEWENnurnRgE/mS47eM6
	 jIAL7PYfYD/8sEWBm8UXo8RjlgVRWoIDTSaAf3jStzMCUX3WbQhWgQg8UllqJkN6teg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=collabora.com;
	spf=pass smtp.mailfrom=collabora.com;
	dkim=pass header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=mail header.b=mDzpexrS;
	arc=none smtp.remote-ip=148.251.105.195
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02D2D606D812;
	Wed,  4 Nov 2026 18:56:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 02D2D606D812
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=mail header.b=mDzpexrS
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1793818601;
	bh=VB0xkskEXr7uqJo35Wl1R8zYHYMTLxuasxaQ51RUvEs=;
	h=From:Subject:Date:To:Cc:From;
	b=mDzpexrSowot73+Z/58SOaxzlhUwoo96xHMUX8Kb483vw9Rq4JU+a21VJgCS3Zk+K
	 clT3sRXuVRbHo2rO3SAMoRtGA3wo4+IIwj6jWzhQ40ildDAtNGvt3SgLTF1sHFAi60
	 zS6GkAXIJXW1iHKfWWnxgUMMCw5yz6oq5p8mXGi8BA/2UJsf0VOg4XCefJshd2SJlV
	 +Z5p/fvnzUdYg4pC1ej7Cbh3pcoAErxTFdJgasf8z1/NpRAfyopCA4NWJHAc8Q6cr9
	 JSK4BetmDt5wx6MV8dv7zrhu9Ds2UEsMan3w63iBpmz8LIRB0aV/1NX51lNRXUTzxa
	 iJ+/R3gsxudrQ==
Received: from jupiter.universe (unknown [100.64.1.62])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: sre)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 24BDE17E066C;
	Wed, 04 Nov 2026 19:56:41 +0100 (CET)
Received: by jupiter.universe (Postfix, from userid 1000)
	id D277748002B; Wed, 04 Nov 2026 19:56:40 +0100 (CET)
From: Sebastian Reichel <sebastian.reichel@collabora.com>
Subject: [PATCH v7 00/10] PCI: dw-rockchip: add system suspend support
Date: Wed, 04 Nov 2026 19:56:38 +0100
Message-Id: <20261104-rockchip-pcie-system-suspend-v7-0-6ae6875939a2@collabora.com>
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/4XPwarCMBCF4VeRrI2k0yZtXPke4iKZTG1Qm5JoU
 KTvbhREuFx0+c/iO8ydJYqeElsv7ixS9smHsUS7XDAczLgn7l1pBgJkJaDjMeABBz/xCT3xdEt
 nOvF0SRONjncKe9GZ1gJoVogpUu+vL367Kz34dA7x9lrLzfP6hvV3ODdccCSgygqlwcEGw/Fob
 IhmheHEnniWb1CJulI/QFlAaa00rm6daur/QPUBtfjxelYF7K2xiEZrqOxfcJ7nByE+G41uAQA
 A
X-Change-ID: 20251028-rockchip-pcie-system-suspend-86cf08a7b229
To: Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>, 
 Bjorn Helgaas <bhelgaas@google.com>, Heiko Stuebner <heiko@sntech.de>, 
 Philipp Zabel <p.zabel@pengutronix.de>, Jingoo Han <jingoohan1@gmail.com>, 
 Shawn Lin <shawn.lin@rock-chips.com>, Liam Girdwood <lgirdwood@gmail.com>, 
 Mark Brown <broonie@kernel.org>, 
 "Yury Norov (NVIDIA)" <yury.norov@gmail.com>, 
 Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
Cc: Alexey Charkov <alchark@flipper.net>, linux-pci@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, 
 linux-kernel@vger.kernel.org, kernel@collabora.com, 
 Sebastian Reichel <sebastian.reichel@collabora.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5866;
 i=sebastian.reichel@collabora.com; h=from:subject:message-id;
 bh=VB0xkskEXr7uqJo35Wl1R8zYHYMTLxuasxaQ51RUvEs=;
 b=owJ4nAFtApL9kA0DAAoB2O7X88g7+poByyZiAGrrf+gry4GSGGdQFVkjBcsBc5CWAMrAimJKe
 T0hGYpvy/WmGIkCMwQAAQoAHRYhBO9mDQdGP4tyanlUE9ju1/PIO/qaBQJq63/oAAoJENju1/PI
 O/qa/wsP/RxJbFRBWr6b93uiy+QRr2sviDM9pF86E9ZLEBi/POK8wCemmLSK/AKw1+z1N20xkXr
 opXm4rPh1i2zFKf1PfraIYPuGiIW5EsHkRBlcsnCtUwpiLL9zNH2lLHedjE3zIcRYUMCCyxANKn
 kwoRPckaLyVLjp3XjECOBN6DSBS/FPWxKCWyGRwLCX/PDdxuitT4KGz0hueMR5EEFg9o/EGHked
 h9FKediJyC99sTDfnJ0dQhHsrirBBLWTFbeUuntDrANee2NHsF8bRVSGDNTu8f9N4j1CQOYvEpx
 xETr0ubQ47gBvE4rYM6DAgQ0pQdhIl/PSSxZmOFPV3W26GLry/UqyINQEkm4/6Ofxu5Wkrty+E3
 j3nckm3nmQW7L/oa2yJU2RnGCqca3tNCfmnapu4gQig+cIUy5Z3wmsiwT3ClrwdAt+LV5oMi/HG
 5JRAV3DOx+2lyKsylnESEjG6CguJktyG1z7tswG9j9LlPAg4Q0RkhEngeT0xQTsXzVGoJoRi693
 t0D3o/rBCduXTw8klsTaJYIY+n7odPhqRE5xVWqqEdV1gepz297KO2d8If7xC2IkUqZcDva1Dhh
 ziQ3migXc2t5JWr8+icylUg0A3Ch8GzpfFUeOqRQGjsGxz9Ygy99rTuF962/vh+YeVPLIe3eQpr
 g8ENX4uXTJW6slgD+SiIuDQ==
X-Developer-Key: i=sebastian.reichel@collabora.com; a=openpgp;
 fpr=EF660D07463F8B726A795413D8EED7F3C83BFA9A

I've been working on fixing up at least basic system suspend support on
the Rockchip RK3576 platform. The last open issue is missing support in
the PCIe driver. This series is a follow-up for Shawn Lin's series with
feedback from Niklas Cassel and Manivannan Sadhasivam being handled as
well as some of my own changes fixing up things I noticed.

I've tested this on multiple RK3576 and RK3588 boards and things look
good to me on the PCIe side.

On RK3588, I also needed [0] to fix PCIe IOMMU issues after resume. I
consider this an independent issue. Also on the Rockchip EVBs the
brcmfmac driver fails to suspend. The WIFI card is connected via PCIe,
but the problem is with the driver/firmware and unrelated to PCIe
itself. I will send a separate workaround patch for that. Additionally
on RK3588 the system will run into SError on resume due to a USB2
problem. This problem is also independent and will be handled
separately.

[0] https://lore.kernel.org/all/20260728210928.1050849-1-praan@google.com/

Changes in v7:
* Link to v6: https://patch.msgid.link/20260908-rockchip-pcie-system-suspend-v6-0-fbabcca9921b@collabora.com
* Rebased to v7.4-rc1
* Collect Reviewed-by tags from Shawn Lin to (mostly) unchanged patches;
  I skipped some due to changes in v7
* Keep dev_err_probe() message for rockchip_pcie_phy_init in patch
  restoring vpcie3v3 regulator handling
* Avoid dynamic mask for extra flags in "enhanced LTSSM control mode helper"
  by just adding specific support for the extra flag needed. Apparently
  some compiler configurations don't like it.
* Avoid duplicated register define in In pme_turn_off patch
* Move bit defines to the correct register defines in pme_turn_off patch
* In broken L1SS resume flag patch move the explanation comment from the
  code to the commit message (FWIW this comment is not AI generated by
  me, but was copied from the Qcom implementation).
* In system PM support patch, set pp->suspend_poweroff to fix the issue
  identified by Igor
* In system PM support patch, just return 0 for DW_PCIE_EP_TYPE (Mani)
  to keep the status-quo (I've not tested this specifically).
* In system PM support patch, use the same init order as probe (Sashiko)
* In clear debug buffer patch, drop dw_pcie_dbi_ro_wr_dis(), which
  is already done by the core nowadays (Sashiko, Mani)
* In clear debug buffer patch, fix actual register write (Sashiko)
* In clear debug buffer patch, update patch description with
  better explanation about the register (Mani)

Changes in v6:
 * https://lore.kernel.org/r/20260316-rockchip-pcie-system-suspend-v5-0-5bb5ad37d643@collabora.com
 * Rebase to pci/next
 * Minor changes to make checkpatch happy
 * Update patch description of the last patch and drop RFC tag
   according to feedback from Shawn Lin
 * Prepend new patch, which fixes Nicolas Frattaroli's conversion
   to FIELD_PREP_WM16 accidently dropping a flag.
 * Add another new patch, which sets .broken_l1ss_resume to tell the
   PCI core that the controller is powered off during suspend following
   the Qcom example

Changes in v5:
 * https://lore.kernel.org/r/20251029-rockchip-pcie-system-suspend-v4-0-ce2e1b0692d2@collabora.com
 * rebase to v7.0-rc1
 * Add an RFC patch at the end with some bits I found in the Rockchip vendor kernel;
 * Made some tests on Rock 5B+ (RK3588); with this patch series suspending works
   when setting pm_test to devices. A full system suspend fails in a later step,
   but that is independent of PCIe.

Changes in v4:
 * https://lore.kernel.org/linux-pci/1744940759-23823-1-git-send-email-shawn.lin@rock-chips.com/
 * rename rockchip_pcie_get_ltssm to rockchip_pcie_get_ltssm_status_reg
   in a separate patch (Niklas Cassel)
 * rename rockchip_pcie_get_pure_ltssm to rockchip_pcie_get_ltssm_state
   in a separate patch (Niklas Cassel)
 * Move devm_phy_get out of phy_init to probe in a separate patch
   (Manivannan Sadhasivam)
 * Add helper function for enhanced LTSSM control mode in a separate patch
   (Niklas Cassel)
 * Add helper function for controller mode in a separate patch
   (Niklas Cassel)
 * Add helper function for DDL indicator in a separate patch
   (Niklas Cassel)
 * Move rockchip_pcie_pme_turn_off implementation in a separate patch
 * Rebase to v6.18-rc3 using new FIELD_PREP_WM16()
 * Improve readability of PME_TURN_OFF/PME_TO_ACK defines (Manivannan Sadhasivam)
 * Fix usage of reverse Xmas (Manivannan Sadhasivam)
 * Assert PERST# before turning off other resources (Manivannan Sadhasivam)
 * Improve some error messages (Manivannan Sadhasivam)
 * Rename goto labels as per their purpose (Manivannan Sadhasivam)
 * Add extra patch for dw_pcie_resume_noirq, since I've seen errors
   during resume on boards not having anything plugged into their PCIe
   port

Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
---
Sebastian Reichel (10):
      PCI: dw-rockchip: Fix LTSSM set functions
      PCI: dw-rockchip: Restore vpcie3v3 regulator handle
      PCI: dw-rockchip: Move devm_phy_get out of phy_init
      PCI: dw-rockchip: Add helper function for enhanced LTSSM control mode
      PCI: dw-rockchip: Add helper function for controller mode
      PCI: dw-rockchip: Add helper function for DDL indicator
      PCI: dw-rockchip: Add pme_turn_off support
      PCI: dw-rockchip: Set broken L1SS resume flag
      PCI: dw-rockchip: Add system PM support
      PCI: dw-rockchip: Clear debug buffer before entering L2

 drivers/pci/controller/dwc/pcie-dw-rockchip.c | 272 ++++++++++++++++++++++----
 1 file changed, 232 insertions(+), 40 deletions(-)
---
base-commit: 6628e7d4c6b25c8d18f1345e3a20d21829aae7e4
change-id: 20251028-rockchip-pcie-system-suspend-86cf08a7b229

Best regards,
--  
Sebastian Reichel <sebastian.reichel@collabora.com>

