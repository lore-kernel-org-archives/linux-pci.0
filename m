Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.251.105.195
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793836147;
	b=qLdQi4USfLQawnomADkgZJ++nsphlSf1jJx8BjD0GCfcamigNTRimxc2U00n90yW4wPn
	 Umf38VZxtre/bMXh2GopYMuJV73+1jCmm5AoTeyDTArQR8zBxzmGfsMV8PkvnUvJoW/2U
	 iCATEBJcI9GBo9ApR6XcMP+ymxvtzJQIbgxI8I6HL4uJTRJkweUgZnZceUC6/4evTikbG
	 htKhmbSmkTB5NLv/2MhQoNUp3JqXpyIDgj9/GQbvFl6IZwkrXSbFe2nLMJM9zCj3lo/pk
	 t/XnqqPCCNNPCRjp3brG/lLU2ob1P5qOA49sJOSMbZCj2gRHbGu6PYHztmIEHUPCHJQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793836147;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:Subject:Date:
	 Message-Id:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:
	 X-Developer-Key;
	bh=m1dkmcldC8pS++pzGm6xswfQROiXoCXlLYpleWR5Pvw=;
	b=HNVHpWX5Xk38sCs6vDgPvgACRisqRGVkd8/Y4/DzPJwyh5lGf33w7DLHedaZWLy7Iqdd
	 6aggX0A1W2+fZSe5hSc8By/ymriss7cPSTHfa6z2KFTyO2Y1YwJ6zs2u6iNYaJvRK2BUX
	 1/HmkteYvFCFCGEkW8W1jBk6MypIjqSuO4JgsIrP/7Xf9hcHG27eYyVsF4zRdkNoGZEzY
	 ZRhmZ4xX9zooTI12hramVg004H7IWpuHToQVMqsX4ru+o1B2/H89583uIn+Pr7tJVBdrz
	 cL88LqoaktOao+mqHZ802UhxcKR3ZLMXPohCNpWeEI6fl7BB+Jd/gxWDi3KO7BzyFAw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=collabora.com;
	spf=pass smtp.mailfrom=collabora.com;
	arc=none smtp.remote-ip=148.251.105.195
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0112E606A326;
	Wed,  4 Nov 2026 23:49:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0112E606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1793836139;
	bh=dtL04qPAz8o5teY7MsjxAf6ee93yJpOTM5INfoCSzPk=;
	h=From:Subject:Date:To:Cc:From;
	b=ckya8XXj2JrGbl23HonSZvDvkACSS4Efp1i1gf1zbr6cUFhzzaoE5GgD07cVe2ral
	 mI59Dr91UBRpgncbFYY7X+aPvxfl1AxEbMXEBpAavkasYgj5pvai2H1KmXIKUu53MW
	 n/K9pYIMc5gsusXMdLH7eXVOIdTcABC0lX2YCE/BYrJK/U5Mu4huLwJhSCuOXUfKuD
	 hsw4ouLSIvveaUVwC+q+olk73tueLfx2bkfJLRKVpqHiH/ya7CoVZJ4Vi0qnUVLyqd
	 FzaL82yK/Hr6o6Etc45SoOe/HBNEEOXKej7SycnhbJX18VqP0KUxkcuRkQqre0QLKE
	 +hC/ZhevKkUUg==
Received: from jupiter.universe (unknown [100.64.1.62])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	(Authenticated sender: sre)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 27CA917E078F;
	Thu, 05 Nov 2026 00:48:59 +0100 (CET)
Received: by jupiter.universe (Postfix, from userid 1000)
	id DCF4E48002B; Thu, 05 Nov 2026 00:48:58 +0100 (CET)
From: Sebastian Reichel <sebastian.reichel@collabora.com>
Subject: [PATCH v8 0/9] PCI: dw-rockchip: add system suspend support
Date: Thu, 05 Nov 2026 00:47:01 +0100
Message-Id: <20261105-rockchip-pcie-system-suspend-v8-0-0434b4f373bc@collabora.com>
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
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/4XPTW7CMBCG4asgr2tkO/EfK+6BurDHk8YqxJFNr
 SKUu9cgQRdFzfKdxTP6rqRgjljIbnMlGWssMU0tzNuGwOimD6QxtCaCCcmZMDQn+IQxznSGiLR
 cyhlPtHyVGadAjYKBGae9EJY0Ys44xO87f3hvPcZyTvly/1b72/UB2//h2lNGAQVyz5QVQewhH
 Y/Op+y2kE7khlf5ABXruFoBZQOl99KFTgfVd69A9QtatjK9qgYO3nkAZ63g/hWonyDnrF8BdQO
 VQ2W0tJ11fyYvy/ID7opajL8BAAA=
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=7061;
 i=sebastian.reichel@collabora.com; h=from:subject:message-id;
 bh=dtL04qPAz8o5teY7MsjxAf6ee93yJpOTM5INfoCSzPk=;
 b=owJ4nAFtApL9kA0DAAoB2O7X88g7+poByyZiAGrrxGbMGJunvqzDik/j8xW+rBF9q/ngW63/m
 gPOkwOnrJRr1YkCMwQAAQoAHRYhBO9mDQdGP4tyanlUE9ju1/PIO/qaBQJq68RmAAoJENju1/PI
 O/qaUYAQAJ2PSLway03WOMeW7fU2YT6tf4dGnvu5HZxW4XSR8Ob3vkxg8Xz027xl4B53BSbLbo/
 S9Z8lUuzQ+/Unz2KMOut/4jZb3KQvsroZbWBy9cSIxsWuw71LXlPEe4hhxvjkWkpz2NCWM/a9O3
 F8CGN9AwyCYAof9ej8MJ7ii7K9x3nJdNFoPUHhgQ5fO7CszCRfCUrXJ2+TVQnasyJA4fMZaAfe3
 AEfV1JJEyXshaeXF1oNckSvPQ2w+7M9xSUAVcqdScMyh52ZhWTZiLwchkprJ5rlit6O+MRhLy/F
 6cvxkeTY/C7wkgVLwshOppPfhTxJAtlka3czHlYGMNgPSdnKZE4cemADWQoDB9B6BN2tEjNMMKD
 p1SMWBA97JVlqRHaJevHumwy1/6AJaXjHnwSPhv3vQ+qFfvW9n//0TotbGyC+Z2ZodScB4ZXLt8
 rfUF/0rCnMorTFPWhw8LAMOovY6uQDiF75JQPF9jOgdiokL6aAhx+F0QnCK2FFCp5t3qVbD7JXz
 K9xLhTm4Pv1cRJajMAU6yJG/QpdTqrYjCWXyBNa4zTSmIBl3UqxBTi+qCHAYvTz28LFlsFKHjJz
 9bEualWFBP3hK8ujO4I0UibHVfxZD3zg4PVFmwjZTytTw0YTaHd2nAKf3aWeqDQ+/r6dJKOne8J
 u6ehtuGIZexAow7aI1Mw2SA==
X-Developer-Key: i=sebastian.reichel@collabora.com; a=openpgp;
 fpr=EF660D07463F8B726A795413D8EED7F3C83BFA9A

I've been working on fixing up at least basic system suspend support on
the Rockchip RK3576 platform. The last open issue is missing support in
the PCIe driver. This series is a follow-up for Shawn Lin's series with
feedback from Niklas Cassel and Manivannan Sadhasivam being handled as
well as some of my own changes fixing up things I noticed.

I've tested this on multiple RK3576 and RK3588 boards and things look
good to me on the PCIe side. Additionally Igor Velkov tested previous
versions on RK3568.

On RK3588, I also needed [0] to fix PCIe IOMMU issues after resume. I
consider this an independent issue. Additionally on RK3588 the system
will run into SError on resume due to a USB2 PHY problem. This problem
is also independent handled via [1] (needs new revision).

[0] https://lore.kernel.org/all/20260728210928.1050849-1-praan@google.com/
[1] https://lore.kernel.org/linux-phy/ar7QuTetvpLltrDT@venus/

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
      PCI: dw-rockchip: Add helper function for DDL indicator
      PCI: dw-rockchip: Add pme_turn_off support
      PCI: dw-rockchip: Set broken L1SS resume flag
      PCI: dw-rockchip: Add system PM support

 drivers/pci/controller/dwc/pcie-dw-rockchip.c | 267 +++++++++++++++++++++-----
 1 file changed, 224 insertions(+), 43 deletions(-)
---
base-commit: 6628e7d4c6b25c8d18f1345e3a20d21829aae7e4
change-id: 20251028-rockchip-pcie-system-suspend-86cf08a7b229

Best regards,
--  
Sebastian Reichel <sebastian.reichel@collabora.com>

