Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.251.105.195
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793885594;
	b=TMUYcKf5Pt7IJXnZWNOi5ZbOCMqCwSJmvSSbzsP9nY1kAUsnu+FT9rGp3t6jQ3L/CSHA
	 JlvtoZiKBsD716IVxzLmlFn0BVIoA0EWMKU0o8v6CI1wiLOnzi/DEUIu37pWD4Yu3ytT0
	 HxkaKympt6irUA8T5MEByLAEohKlVWDO9n7J8S5Ok/iK6TxJiwKCsRA6d/h6B7WumCn7z
	 q+76PkApOzqfuE2Z0wQrwwpZ76NGzmT4soQ2wk/Jzq9lrJq5HAZbc16T2Q+Xbz0AAjIBm
	 9N200J7SnX2cDWka8tGEMsX92fc9zBfwabbGJ19tEv95IS1IhgcMFcNuxmcMD9Bn9hw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793885594;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:Subject:Date:
	 Message-Id:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:
	 X-Developer-Key;
	bh=/kTUWvbbS7oOfCvpAGx8DdSdoqKYmjtNzBizovmycW8=;
	b=WuokIXSIWIjawr0+40SaZt6/Vr/hwVQUiFicTOEgqtyEraZ3nZVIpTidSOHCLBYgQ9kK
	 BUDfrjEAqGsrv762mUDNHeT4joxgSgQ+ieDeYe5gcY2y5ae5YOLTO2pvEIXLNDeAjlsp4
	 P0BAlF5vpscGAPMk/OPWtAaD6BmBbDgoljUZ70ze7CuLjSN54ORigAGB2UQaesYc1waTo
	 H9IS+VxXIUCn4q6XS/at/OBBdiBbVrKBd9Aba+kEJdBVskW9D3GfbF7Wtmbc/oILVKhip
	 dzIK6a0lIdW1J1UoYtSujqIswiX/jop9ecXd/rLLpITseomGPYkGKodCIL54gTn7ogw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=collabora.com;
	spf=pass smtp.mailfrom=collabora.com;
	dkim=pass header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=mail header.b=C+uuyiXp;
	arc=none smtp.remote-ip=148.251.105.195
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57E3F606A32C;
	Thu,  5 Nov 2026 13:33:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 57E3F606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=mail header.b=C+uuyiXp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1793885591;
	bh=SlOPpm8kK/5pxMNxXSQz/Ok2a4P2lFsyKlHv5oSFTIc=;
	h=From:Subject:Date:To:Cc:From;
	b=C+uuyiXpsN1uxl03m3IqapTxXjaPKdPuSnhN5cSCm5odRK72OEw3W4l9jKaRznnKn
	 My5BHDnuNkohdkQI4kh9up5+JROEkhSwmM8t0QixrU87Hy1dI0vpWpOMtUOKpbbFtn
	 JKDSgNeX9DdSWr1Sww7YW6NgxnHW6B5K5B4gj3xrOkw5qtmsniaHjEEtV3956Rb3cs
	 +HMsDjlgy3xzaA8uVdfR8qOeV8kBU+YSaCPGdWsa6dSB64g/olWgthBd68Keodr4xH
	 tG0kVkNFob91uq4g6pFhU4ZS/Yxggw7H4Uu4urb9eJ6uKHFrVYmGiM2G/9QcQ12X+M
	 17ZO+vdcD7kew==
Received: from jupiter.universe (unknown [100.64.1.62])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: sre)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 3EE8917E07EC;
	Thu, 05 Nov 2026 14:33:11 +0100 (CET)
Received: by jupiter.universe (Postfix, from userid 1000)
	id E0E0248002B; Thu, 05 Nov 2026 14:33:10 +0100 (CET)
From: Sebastian Reichel <sebastian.reichel@collabora.com>
Subject: [PATCH v9 0/9] PCI: dw-rockchip: add system suspend support
Date: Thu, 05 Nov 2026 14:33:08 +0100
Message-Id: <20261105-rockchip-pcie-system-suspend-v9-0-a2e55846649e@collabora.com>
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
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/4XPy2rDMBCF4VcJWldF90tXfY+ShTQe16KJZaTUJ
 AS/e5VA2lJMvfxn8Q3nSiqWhJW87K6k4JxqymML/7QjMITxHWnqWhPBhOZMOFoyfMCQJjpBQlo
 v9YRHWj/rhGNHnYGeuWCjEJ40YirYp/Odf9u3HlI95XK5f5vV7fqA/f/wrCijgAJ5ZMaLTrxCP
 hxCzCU8Qz6SGz7rB2iY5GYD1A3UMerQSdsZJddA8wN6tjF9Ng3sY4gAwXvB4xpov0HOmdoAbQN
 NQOOs9tKH1cnuN6g3QNdApqSKqpdWRvgLLsvyBaodZLEQAgAA
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=7822;
 i=sebastian.reichel@collabora.com; h=from:subject:message-id;
 bh=SlOPpm8kK/5pxMNxXSQz/Ok2a4P2lFsyKlHv5oSFTIc=;
 b=owJ4nAFtApL9kA0DAAoB2O7X88g7+poByyZiAGrshZaYBRY5ag4iFYH9clMah0zoc9Bx+j/gZ
 KJFQP/qxRsvaYkCMwQAAQoAHRYhBO9mDQdGP4tyanlUE9ju1/PIO/qaBQJq7IWWAAoJENju1/PI
 O/qaS0QQAJIFZ1r0616ZNUBxyLsD1T9dRrgmmam4RfX8vjlyLR/qYrXdT/HfDiHiJ8Tjk3FkQb6
 LoaS0ukmAUTK6NB6IToBhjVxWrEGN0rIBCCygsgpS7qyq2WZwApvzrlhgAoztrOJw7vP6Nbpvx0
 M+AqNyZNfw0g9rhbDiPYZH3mxpB7m252F2EYGD1kV/jpZe7fGrkPssi2AmQVSI4PgVqb5q/2fSZ
 3sxMfm11AAWjwSXf7iN8/rhdWAkNvtnmHg3pc5bo1QMkW5y1mKUEEaFDXOJYMS4BPYopv/IW4gF
 xIXD2ijAAccDz82m63/IsKCzKr1Enr8SsJKo+aC2WW2Z2QzlVXZIFvj08fMKag3zhfZIkZ1cCDd
 z8TGi4qnOxeFMvRw/8ISkmvmg6k8Iiwt/m7myeUtKrZ2oxHaH3hA7P0pG3emMksUfZb8sSC2QL/
 NGLeh87ZdgQwUtakWSN5QCb1gsl0dAEGW9RDVaYUA/mvJTeiIiK9dacg1VizA6nijnRNR6fbJyT
 tf5xq/2h873x5vTr1x4fz4SIeW7ZAQotykaRJUxtnD4CIwbLhdra1dI1rh8VisULqI0Be81yxyW
 8c+g/cDo4/4Ncu+aCXUfqaBfgb0ynSB0OYWDQ/bagVbk70t8ZxyZn68CeSNoGuWNJ8Ng34vVu0Q
 wPIkbh+jfUFg3cbvQtrUvZw==
X-Developer-Key: i=sebastian.reichel@collabora.com; a=openpgp;
 fpr=EF660D07463F8B726A795413D8EED7F3C83BFA9A

I've been working on fixing up at least basic system suspend support on
the Rockchip RK3576 platform. This series is a follow-up for Shawn Lin's
series with feedback from Niklas Cassel and Manivannan Sadhasivam being
handled as well as some of my own changes fixing up things I noticed.

Tested boards:
 * Sige5 (RK3576)
 * Rock 4D (RK3576)
 * RK3588 EVB1 (RK3588)
 * ODROID-M1 (RK3568), Igor Velkov (previous version)

Somewhat related, RK3588 also needs [0] to fix PCIe IOMMU issues after
resume. Additionally RK3588 runs into SError on resume due to a USB2 PHY
problem, which is fixed via [1]. RK3576 does not use PCIe IOMMU and does
not run into the USB2 PHY problem (at least Sige5 and Rock 4D), so this
series can easily be tested standalone on that platform.

[0] https://lore.kernel.org/all/20260929034510.2023173-1-praan@google.com/
[1] https://lore.kernel.org/linux-phy/20261105-phy-rockchip-inno-usb2-clock-fix-v3-0-b20608c08b94@collabora.com/

Changes in v9:
- Link to v8: https://patch.msgid.link/20261105-rockchip-pcie-system-suspend-v8-0-0434b4f373bc@collabora.com
- Collect Reviewed-by tag from Shawn Lin for pme_turn_off patch
- Ignore suggestion from Shawn Lin to make pme_turn_off return error
  codes as out-of-scope. I think it is sensible, but should be done
  in a separate series as it will touch all glue drivers. (Shawn Lin)
- Update rockchip_pcie_rc_reset_root_port() to also use the
  rockchip_pcie_set_controller_mode() helper (Sashiko)
- Update DLL IRQ unmask helper to also handle instances not involving
  PCIE_RDLH_LINK_UP_CHGED (Sashiko)
- Move INTx caching after dw_pcie_suspend_noirq() to avoid a race
  condition (Sashiko)

Changes in v8:
- Link to v7: https://patch.msgid.link/20261104-rockchip-pcie-system-suspend-v7-0-6ae6875939a2@collabora.com
- Drop the final debug patch; I took that over from Rockchip's vendor
  tree as it seems useful for debug purposes. Using it involves reading
  the register via /dev/mem. It's not directly tied to actual system PM
  support itself, so it can be submitted separetely. It's not worth
  fighting Sashiko for it.
- In LTSSM control mode patch also replace one occurance that I missed
- In system PM support patch add guard not suspending an already
  suspended PCIe devices, which can happen when resume failed following
  the example of UltraRISC (Sashiko)
- In the same patch replace 0xffff mask with PCIE_INTR_MASK to avoid
  overflow issue; the new mask is not functional equivalent as we just
  work on the lower 8 bit now. The following 8 bit are reserved on
  RK3588 and RK3576 anyways, though. Thus this effectivly better
  documents the purpose of the cached value. (Sashiko)
- Drop incorrect custom PERST# handling in the resume handler (Sashiko)
- Modify interrupt masking to follow RC instead of EP logic (Sashiko)
- I've not picked up the Tested-by tag from Igor Velkov on v7
  as there are some changes (even though I'm fairly sure they
  don't matter), which add RK3568 to the tested SoC range.

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
Sebastian Reichel (9):
      PCI: dw-rockchip: Fix LTSSM set functions
      PCI: dw-rockchip: Restore vpcie3v3 regulator handle
      PCI: dw-rockchip: Move devm_phy_get out of phy_init
      PCI: dw-rockchip: Add helper function for enhanced LTSSM control mode
      PCI: dw-rockchip: Add helper function for controller mode
      PCI: dw-rockchip: Add helper function for DLL interrupts
      PCI: dw-rockchip: Add pme_turn_off support
      PCI: dw-rockchip: Set broken L1SS resume flag
      PCI: dw-rockchip: Add system PM support

 drivers/pci/controller/dwc/pcie-dw-rockchip.c | 283 +++++++++++++++++++++-----
 1 file changed, 228 insertions(+), 55 deletions(-)
---
base-commit: 6628e7d4c6b25c8d18f1345e3a20d21829aae7e4
change-id: 20251028-rockchip-pcie-system-suspend-86cf08a7b229

Best regards,
--  
Sebastian Reichel <sebastian.reichel@collabora.com>

