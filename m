Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B595449B20;
	Wed,  5 Aug 2026 11:57:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785931061; cv=none; b=HRrjP2pcb3QrEuG+cyl8Fhp7DVOgVCyvIZ96zTeRIC570kKCglasetfzcORbPMyl6Whgyk4rha8OCHnvmN9bX5QvlC8NIlqXG/H3DtHC39FR1Ki2SXb1e2h4/TVzrOQEYhjNrGeogAky/ecqq98dK3ptl+jE5DLhKkSiRGeEX4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785931061; c=relaxed/simple;
	bh=JxlEQYuD/RMUaMbTTKAWKthJxwX173QM/DF1i5aw3Fs=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=s7MG89pbPenoKLbCj44iC2m9dc6O843tEHsgoQlhm/hlixCe2SzOM4cBZQ+92Y7z8HY7fHZuFP7RXN99Y/kH3PelpboqyA1Mf4PrtuzibxZ6WgzzFqxebJFfR5ZvpRbVopvZyIfZ1vtLcmPsd5I6/2+XNf7izm7vGEdzXOyXq+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i+bopj1q; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i+bopj1q"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54CAB1F000E9;
	Wed,  5 Aug 2026 11:57:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785931059;
	bh=18CzF+TNYcC8Y8fgnqebRv8rsE1KTXFZ483SOTufpbk=;
	h=From:Subject:Date:To:Cc;
	b=i+bopj1q3cqmJQTG6AiyH02/P489Dk6RYPRaMU1z5dK6l/zqGlQnOAIAKOJd8DSlD
	 hjYN7JGqWjGFRY4KWMvWwY1Ac+5b9+oWCwGuW8eA/gdKcfam3ZwYfK7Zy2iz9OfBO/
	 qQjK2Hb9lFYUcb5AnQfRa0xe+wkL8srhBqM5MfPF6+rKVXFz0mxsfPjEVu9JXkU892
	 r4v8zQ98oEJv6AyS31ULdt67cLFaizRgVDEAdbU8JWHklj77bMJIJqMx7p5/i+Zxp9
	 z7pXaZ+r9QuipSCU2CLaqKhTWyDXgSESpmmS5B0mnaW0FeFULCkCBF1Rw8vRN26EH3
	 Fi6b27PwYvBug==
From: Thierry Reding <thierry.reding@kernel.org>
Subject: [PATCH v9 0/5] PCI: tegra: Add Tegra264 support
Date: Wed, 05 Aug 2026 13:57:19 +0200
Message-Id: <20260805-tegra264-pcie-v9-0-fa2ed7350ae1@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/4XSS26DMBAG4KtErGvkGb+zyj2qqjIwSdwmQGxCW
 0W5e02olLQsukEe5O8fY+ZSJIqBUrFeXYpIY0iha3PhnlZFvfftjlhocl0gR80lRzbQLnrUkvV
 1IEaC+4pQNJ6bIps+0jZ83vKeX+Y6nas3qocpZNqxD2no4tet4QjTvjlbgAPNAXiJkNdKMmDDP
 lCMX2WkJrS7zTvFlg5lF3fFlD3ig85PVFKKEpUBh/x/LR61BqGsUiUap0C6/7W86+WtjJJxhkB
 I4Jw1ZDftGJrgy7o7zlzduUL9l6vMrfQWROWMa8yC6zvXy+46c2qqeuuNN3ZLC24eOJi/3Ezck
 /HktNToFtzeuYHF4e307YIUKOsQXfWLX+eZiHQ651Eb5kEpjpSSv43aejXHcsM+/DuFeHpN577
 v4sBGwPxbKimV2Kqqrp3ZdCmVp7M/5OjjLT+nVz4Rm16EYb1q6XNgPweVufv1G+Sox8TwAgAA
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=4444; i=treding@nvidia.com;
 h=from:subject:message-id; bh=JxlEQYuD/RMUaMbTTKAWKthJxwX173QM/DF1i5aw3Fs=;
 b=owEBbQKS/ZANAwAKAd0jrNd/PrOhAcsmYgBqcyUrF3AVx3y+b0eqzDZgHBN8bJjaPFZjnLcd+
 1B1N5Kx4q2JAjMEAAEKAB0WIQSI6sMIAUnM98CNyJ/dI6zXfz6zoQUCanMlKwAKCRDdI6zXfz6z
 oQtyEACdiZrGuVJeUEYcnmvcJA8HWr9ZsqT2QOhDX7Rd8O0iJlnrzv53ckk6TcIkVydY24w1rtF
 4O+wf/jAZeQdMhcKPBqiliwJxtSMFgO1P3wFr6OHOfo2kHgy5Txnn30iltGHVhvHZBxZfsQL2KH
 vRNMB3aokcNigA6d0rBQq9v/QhBlSw0uhtOZO/LRO1BGIi4TSfe+PaqWZ+6Jgl7ukc8Ny6AB+fi
 V+N8fla2lh1rgIsFzDDIZvTpIFOdJv6cGPagG7qItSwIJCbOimoh9hHSN3G7U2u3xYY66UbOHvH
 rAYQ71dhGJG7fJUHw6YJns5TST25sjHlzhuJ+W6ztsPaDbfHmNGGBFVfHBOp2AnTUdOFDQoNjNj
 avq+fzfB+c8hQv+jm8QyWXb9W+ZQIE2QvH3AxzcgqjqJeeRmd1/2z/chNoDtF0kkVZZJZ9G7V1y
 A195MrRwlw4xmbOG60AyrS7xjmFbC3wJlJJ7lyuqhXMtYbxFlt/zQBgjMZn+riw31CRzHcfeSxo
 hG80ihmAtNt8o6gToD/GbhcViKfMWsHluuQgfB0a8jZTwD9GvUtWWAZTtFbxssB1X/MTBhCfhI8
 rwZpJSFSZzMuxEd5AriNNuyc3XfFzSjo4FG3d8pE0liRKndE3w22adzmtNVu96Fx2si3sBTzk2W
 SFFJEU1jKNoOkng==
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
 arch/arm64/boot/dts/nvidia/tegra264.dtsi           | 114 ++++--
 drivers/pci/controller/Kconfig                     |  10 +-
 drivers/pci/controller/Makefile                    |   1 +
 drivers/pci/controller/pcie-tegra264.c             | 450 +++++++++++++++++++++
 5 files changed, 623 insertions(+), 61 deletions(-)
---
base-commit: 8306754e0e226390edafb50b0f2c85f7e703077d
change-id: 20260402-tegra264-pcie-e30abe23da07
prerequisite-message-id: 20260707-wakeirq_support-v12-1-b4453f5bcc97@oss.qualcomm.com
prerequisite-patch-id: 0f984d1bf11850bb8f833a26f6945ecf18a9a816

Best regards,
--  
Thierry Reding <treding@nvidia.com>

