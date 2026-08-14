Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D801A478E2B;
	Fri, 14 Aug 2026 15:39:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786721948; cv=none; b=Jd3ssawF7BPr46KFUjpFBDgChSzumPt8G3iZkSrLFDregqcPPJzdhsuzbCuIaXgeBVnAyRtEIs1HemgAq7URBPdRD18xibnoL3FKLD3XphgDoMoUbTxemGk+oQaY1QgagjVcxQYK+CNLaPu81HkxCXQLjCLoQdHX+HNlogwsano=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786721948; c=relaxed/simple;
	bh=cr0ItS1bOQDJ4iswusIyAMVMxDx0rf3JWwgFnaiZU68=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=mgCGIH8Vfe5kYInu0dflYPJ2FNa63uBM7hZIUdTHrhnQdPwaLuGQMk3eY8KZsmNXL1SccvB+gCF01sfC6S7ZwgCQlChrlr/MgW4/q4TiP8Bo8MvJmzx4YNvKPM5l9/3GMdz6l0W2rgW7Y0EWDsyNOfkJ1VawQEjeEjjvoZAn4A8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LlDWnGSV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LlDWnGSV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5ABA1F000E9;
	Fri, 14 Aug 2026 15:39:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786721945;
	bh=A/aNaAtRtM7onUJ7+L0YX4rWr/xkMPvTWoC9iOCCeQM=;
	h=From:Subject:Date:To:Cc;
	b=LlDWnGSVai7zuvjVSqadKVYpSwgSttazPvSzXLMet8pODtd98liVrqrNZeii26Vxd
	 iDx8ll0FhV1Lue4fA4+KwFHdr5TOFg3/+35BgSrkqlFNY5YrFt4itxQLptmYzKW4mz
	 CHcMkfX5iURDSjqpiNa3cyjzdP5rh8lqkCDVIPMyb0lfxn18NQDsruBcLQMeVJYj62
	 HCk50lE7L+QYpAN940QI28lWPXfrm/4eZHwkPcTOHEYgA4q7wG3XEETumHVeyULV8v
	 7DAMf6XmGqMPJNRhNh2KYHqa8vpU5bok2Z4i2YpxRW7FwFFIIk7L/MN9wb++2nCvBY
	 rg89ruFgOK69Q==
From: Thierry Reding <thierry.reding@kernel.org>
Subject: [PATCH v10 0/5] PCI: tegra: Add Tegra264 support
Date: Fri, 14 Aug 2026 17:38:54 +0200
Message-Id: <20260814-tegra264-pcie-v10-0-05d08c592b05@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/4XS3U6DMBQH8FdZuLak5/R7V3sPY0yBw1Z1sLUMN
 cZ3twwT5rjwpqFNf//T0vNVJIqBUrHdfBWRxpBC3+UJ8IdNUR98tycWmrxQIEfNJUc20D561JK
 d6kCMBPcVoWg8N0U2p0ht+LgGPj7N83SpXqgeppBpxyGkoY+f14ojTPvmbAEONAfgJUL+VpIBG
 w6BYvwsIzWh2+9eKXb0VvZxX0zZI97oPKKSUpSoDDjk/2txqzUIZZUq0TgF0v2v5aLXf2WUjDM
 EQgLnrCG768bQBF/W/XHmauEK9T1XmVvpLYjKGdeYFdcL1+vqOnNqqrr1xhvb0oqbGw7mnpuJe
 zKenJYa3YrbhRtYHd5OdxekQFmH6KoVdwu3XN1zl3nrkRojFPcEf/j33FKRzpfcqsPcZ8WRUvL
 XTt1u5lNxw979K4V4fk6X06mPAxsB86tWUirRqqqundn1KZXni3/L0cdrfk6vfCI2LYRhu+noY
 2C/95S5+vcPoMIa6jADAAA=
X-Change-ID: 20260402-tegra264-pcie-e30abe23da07
To: Bjorn Helgaas <bhelgaas@google.com>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Thierry Reding <thierry.reding@gmail.com>, 
 Jonathan Hunter <jonathanh@nvidia.com>, 
 Karthikeyan Mitran <m.karthikeyan@mobiveil.co.in>, 
 Hou Zhiqiang <Zhiqiang.Hou@nxp.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 =?utf-8?q?Pali_Roh=C3=A1r?= <pali@kernel.org>, 
 Michal Simek <michal.simek@amd.com>, Kevin Xie <kevin.xie@starfivetech.com>, 
 Thierry Reding <thierry.reding@kernel.org>, Aksh Garg <a-garg7@ti.com>
Cc: linux-pci@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, Thierry Reding <treding@nvidia.com>, 
 Manikanta Maddireddy <mmaddireddy@nvidia.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=4607; i=treding@nvidia.com;
 h=from:subject:message-id; bh=cr0ItS1bOQDJ4iswusIyAMVMxDx0rf3JWwgFnaiZU68=;
 b=owEBbQKS/ZANAwAKAd0jrNd/PrOhAcsmYgBqfzaVKC4alm3XyUKh3VbmXIVRwaQR0KH2I+hvb
 TBSpZz89sSJAjMEAAEKAB0WIQSI6sMIAUnM98CNyJ/dI6zXfz6zoQUCan82lQAKCRDdI6zXfz6z
 oR5iD/0WXU1jSuqKcrA+DZoHX9c+R9BcM9T10ug+A+LDz3ZxdWf4LyP7WbU7ZfxS16VHCWRaDX3
 62cJ8G/xCHXwURBo1t07K4iGEe8esBgJY0HVXJCzr4sfZBHJs5iO+AzAGjDbE6obCd2yy5jQ6iU
 q+HZiYOgA6BT3HXpS24IL1Tuw4FzwRleGJfn4NpivqddQmFCBkXm9dQRf8sPMpRzlbX7Na8gSpJ
 luNk6/z2/SdUh70HKknHmxyurjco1q0Z9am7rMy7JZNckq0LCxU/v+B8vFH6QhUBFN1o62hIPTy
 7Gp2zeRnWo82pFnP8rvp00HlyjbGzG7+XwfVPGeolkeNiNgFKadiULZNzHwdTRhcc8siEivOmA+
 XEXNsnBWRzVoFqEJOuFK+7kJpklr2u88HSmylQ7KIHidpKlIQhzOu3bWNvjfbDYzT/+LIS28+ki
 +UEoZ5CPQEYn2SS437LNeDnwp37N9wJdjMrh08Zn73sdaW14MuNJAY9ZSlmLg/ZFUbXbyqqjjwr
 zbcXb5QPkmSC+cqSPPEPPtAbeBOEdtvu/uDpvBNfDB7uMc9vH+v6v/YLDG8Do2ZT07VCkLHkOMB
 abLW3pAAVgmoWLPKHqhSYToYRszA00k0U2tNmS2CXCDFclG1IWFNYOS/nrX8+sxMLFD20RwieaJ
 TIglzbR8Fq/NlhA==
X-Developer-Key: i=treding@nvidia.com; a=openpgp;
 fpr=88EAC3080149CCF7C08DC89FDD23ACD77F3EB3A1

Hi,

this series adds support for the PCIe controllers found on the Tegra264
SoC. There are six instances, one of which is for internal purposes only
and the other five are general purpose.

The first patch tweaks the DT bindings slightly to avoid new DT compiler
warnings that slipped through because they are now disabled by default
(-Wno-unit_address_vs_reg). The second patch references PCIe root port
bindings from the controller bindings, which will allow using the
standard WAKE# handling, among other things.

Patch 3 introduces the driver for Tegra264 and patch 4 reorders the reg
and reg-names property entries to match the bindings changes from patch
1. Finally, patch 6 adds the PCIe root port nodes required by the DT
binding changes in patch 2.

As previously mentioned, this depends on Krishna's PCIe WAKE# interrupt
support from here:

    https://lore.kernel.org/all/20260707-wakeirq_support-v12-1-b4453f5bcc97@oss.qualcomm.com/

Since it is only a runtime dependency, the series can be applied
independently, though.

I can pick up patches 4 and 5 into the Tegra tree, but there should be
no conflicts, so they should be fine to go in with the rest of the
patches. Either way works fine for me.

Thanks,
Thierry

Changes in v10:
- fix a bandwidth issue when the link down on probe
- Link to v9: https://patch.msgid.link/20260805-tegra264-pcie-v9-0-fa2ed7350ae1@nvidia.com

Changes in v9:
- remove suspend/resume support, it doesn't work on Tegra264 yet
- use pm_runtime_resume_and_get() instead of pm_runtime_get_sync()
- drop common wait times patch, it was applied already
- rename tegra264_pcie_check_ranges() for clarity
- remove unused header includes
- Link to v8: https://patch.msgid.link/20260716-tegra264-pcie-v8-0-23e51589229b@nvidia.com

Changes in v8:
- track hotplug support separately from link up state for clarity
- remove unneeded controller deinitialization, done by firmware
- fail probe if the link is down and not hotplug-capable
- select pinctrl sleep state on suspend for symmetry
- switch to PCIe root port bindings (new patches)
- add Reviewed-by and Acked-by tags
- add err_ prefix to goto labels
- use generic WAKE# IRQ support
- Link to v7: https://patch.msgid.link/20260617-tegra264-pcie-v7-0-eae7ae964629@nvidia.com

Changes in v7:
- fix build dependency on PCI_ECAM
- remove pre-silicon support code
- Link to v6: https://patch.msgid.link/20260602-tegra264-pcie-v6-0-edbcfa7a78fe@nvidia.com

Changes in v6:
- address review comments from Sashiko
- rebase onto v7.1-rc1, adjust DT bindings patch accordingly
- Link to v5: https://patch.msgid.link/20260526-tegra264-pcie-v5-0-84a813b979d7@nvidia.com

Changes in v5:
- address review comments for the PCI driver patch
- Link to v4: https://patch.msgid.link/20260402-tegra264-pcie-v4-0-21e2e19987e8@nvidia.com

Changes in v4:
- strip out dependencies that are going in through the ARM SoC tree
- revert bindings to oneOf construct so that we don't produce new DTC
  warnings
- Link to v3: https://patch.msgid.link/20260326135855.2795149-1-thierry.reding@kernel.org

Changes in v3:
- integrate PCI standard wait times patch into the series to maintain
  bisectability
- fix review comments from Mikko
- Link to v2: https://patch.msgid.link/20260320225443.2571920-1-thierry.reding@kernel.org

Changes in v2:
- fix an issue with sanity-checking disabled BARs
- address review comments
- Link to v1: https://patch.msgid.link/20260319160110.2131954-1-thierry.reding@kernel.org

Thanks,
Thierry

---
Thierry Reding (5):
      dt-bindings: pci: tegra264: Strictly distinguish C0 from C1-C5
      dt-bindings: pci: tegra264: Switch to PCIe root port bindings
      PCI: tegra: Add Tegra264 support
      arm64: tegra: Reorder reg and reg-names to match bindings
      arm64: tegra: Add PCIe root ports on Tegra264

 .../bindings/pci/nvidia,tegra264-pcie.yaml         | 109 +++--
 arch/arm64/boot/dts/nvidia/tegra264.dtsi           | 114 +++--
 drivers/pci/controller/Kconfig                     |  10 +-
 drivers/pci/controller/Makefile                    |   1 +
 drivers/pci/controller/pcie-tegra264.c             | 467 +++++++++++++++++++++
 5 files changed, 640 insertions(+), 61 deletions(-)
---
base-commit: 8306754e0e226390edafb50b0f2c85f7e703077d
change-id: 20260402-tegra264-pcie-e30abe23da07
prerequisite-message-id: 20260707-wakeirq_support-v12-1-b4453f5bcc97@oss.qualcomm.com
prerequisite-patch-id: 0f984d1bf11850bb8f833a26f6945ecf18a9a816

Best regards,
--  
Thierry Reding <treding@nvidia.com>

