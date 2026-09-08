Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AD70556B9A;
	Tue,  8 Sep 2026 14:51:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788879117; cv=none; b=kOiLElFGqPzRG4t+AdwYKsbHUuh2RSCDh/mnGs8Ov1U2GyZ04c2RjVXcgHabUPT2SA6pSGq+xcYIKFBjM+qCXinGvDKpDRY0sXY5SAEkLBY04o0lBfPaO2dRelwj4m8+Cd+Ejb78WB3hxVR0FkHTFVllsN1ewpfMwbCZQIYvy3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788879117; c=relaxed/simple;
	bh=mw+ZZFpY0CwtuUCkiFx/dEH98jsQ+ra9TZNRzdkH4zc=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=oONZ53MjST/a9cDVT9/nWMiAvsHsHT7HGzrnp9F6lB4VOsjpZqg59uZDkjCr643+vfgohy9AMyCaQKCYNnouw3n61cu9M3CiAyrkQwflSPHnEVQPD09D912YK3xFsnG75j+lka/gXhKEIgB4RHo34Yesf8SYBLsXw/VwfokkqFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=G4oXSMMA; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="G4oXSMMA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1788879100;
	bh=mw+ZZFpY0CwtuUCkiFx/dEH98jsQ+ra9TZNRzdkH4zc=;
	h=From:Subject:Date:To:Cc:From;
	b=G4oXSMMAfnL9UCufRSgmnMT2vLwqgws5d2WQqM57hG9dQ7Wdcj2JAbEeNXOjm3p/o
	 idhxiWcqS1lYN/yu7c80rZlqosKTRoJIOUfMjvvD8nsJ5fZSu+NzJ8+DCENPQDKcLj
	 8tPvDHKP2dfawQp8v25iyzkTxhEtJ85zx/feDNkP9eF/6ZA27znlKA+9KB/+Mhd77T
	 GfvFcLsrIJm10olPgFx0xXkZ+1IAetA38nnXEwTZJLwG+BRGAn8785MzwP3UkcinHw
	 +oT2l2t38h9sBtJ8Wsj9B+9kFIiiJTHCbJJejmaTIOObVhCn+jRekZ8aMpUAS0KVW0
	 xv32K59MkUYhA==
Received: from jupiter.universe (unknown [100.64.1.62])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: sre)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id D5A8117E0945;
	Tue, 08 Sep 2026 16:51:40 +0200 (CEST)
Received: by jupiter.universe (Postfix, from userid 1000)
	id 8C5C548002B; Tue, 08 Sep 2026 16:51:40 +0200 (CEST)
From: Sebastian Reichel <sebastian.reichel@collabora.com>
Subject: [PATCH v6 00/10] PCI: dw-rockchip: add system suspend support
Date: Tue, 08 Sep 2026 16:51:18 +0200
Message-Id: <20260908-rockchip-pcie-system-suspend-v6-0-fbabcca9921b@collabora.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/4XNvQ6DIBiF4VsxzKVBFNROvY+mAz+flVSFgCU1x
 nsvmrh0aMf3DM9ZUABvIKBLtiAP0QRjxxT8lCHVifEB2OjUiBLKckJr7K16qs447JQBHOYwwYD
 DKzgYNa65akktKklpgxLhPLTmvfO3e+rOhMn6eX+L5bYecPMbjiUmWAGFXBLeUE2vyva9kNaLs
 7ID2vDIDpCTIud/QJZAJiUTuqg0L4tvcF3XD/guwdsdAQAA
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=4379;
 i=sebastian.reichel@collabora.com; h=from:subject:message-id;
 bh=mw+ZZFpY0CwtuUCkiFx/dEH98jsQ+ra9TZNRzdkH4zc=;
 b=owJ4nAFtApL9kA0DAAoB2O7X88g7+poByyZiAGqgIPz0KGzDOsP3sJYdDpGo90PlMBtZv3iqH
 bzRU2COqGOFy4kCMwQAAQoAHRYhBO9mDQdGP4tyanlUE9ju1/PIO/qaBQJqoCD8AAoJENju1/PI
 O/qaEbUP/382SDlzN7H+uPAg+eOuaSTURpg51A5pPv8X1zs2dr+eDyczi+CFWbcy0cLCpML7N6x
 4KR3RclKFpjsfyR0Lg7kVx6JlWShhHc/U5rumaxArELOWSyE2Xt3iSai5ZVS0PUZ6xgfWTn8BLU
 0mTJzsdxf9A3xFrC4b5MSDIY3wanIzLc/p28IWw2q3TJGSKzZCGp1auE0tXJA/55mpK028v0I0Z
 jM2D+1nUrKESGoAWp7UlRMlCMn/6tSbvL+SjHupQAvxKwugkWeB4cIjQMMVK2W8V+S5bFgyMZnt
 XThFbWsBQdqZFHr39AWF7nrLlnI3Mrh9c+YSdm4ugCqCGlrxWHmuVk7L81XcvBoEQi0Y2jXLeVY
 kaMIhPF5xZFa1AOfAwxnFswPZKpmCWAbo7M7LokflCiISQ3CAKndt1QMUCrckzuyiIbOtLcJ1iL
 +MsgTrGYm2qFW626wYNJG1AmKXUa5z7qMRXFJb+jPzhvL77fwNA2R2njqat/MxmzYZ2K8qpuVQ7
 t/6esCFRGqNhfqYVvDAoGAVU7V+OiMVlhTIDjL0wcBq37n6xkPTWJiF7F+vhI7M9vTfb+EW0s57
 V5crEhZiHcVsQUENeAtHleI5CKoKKzChkuZZ7SVJYnPgD2/Pwe7aKwcSsJw/ZKcQ9Yi26+IeLD2
 baxeI8atcuyIv3LolPRwn7Q==
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

Changes since PATCHv5:
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

Changes since PATCHv4:
 * https://lore.kernel.org/r/20251029-rockchip-pcie-system-suspend-v4-0-ce2e1b0692d2@collabora.com
 * rebase to v7.0-rc1
 * Add an RFC patch at the end with some bits I found in the Rockchip vendor kernel;
 * Made some tests on Rock 5B+ (RK3588); with this patch series suspending works
   when setting pm_test to devices. A full system suspend fails in a later step,
   but that is independent of PCIe.

Changes since PATCHv3:
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

 drivers/pci/controller/dwc/pcie-dw-rockchip.c | 274 ++++++++++++++++++++++----
 1 file changed, 235 insertions(+), 39 deletions(-)
---
base-commit: 39ee38a9fa2eaeff030a6c865abb244597c091eb
change-id: 20251028-rockchip-pcie-system-suspend-86cf08a7b229

Best regards,
--  
Sebastian Reichel <sebastian.reichel@collabora.com>

