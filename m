Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794821746;
	b=U/6JBU293XsLJgE1QGRDml4x3/faqyo/QUXEiVY+a0hhnF2Wr7KssWfnwpX0pxwQIotB
	 h5EHikNwemP/GTfWL6IxjH/6gQfztyFmwqVKJZAEGeed9EJgeemV+4RP1TPNZOZ/ZD1Rn
	 sDJZEQe4DeTezOfExeg4Eggxc4y+TiIZb2gdXlVsnnDLwge1yPRE+RETjpOzUS2fl/4rG
	 9eilGhToqWPnRiQnPynUKxxZLhlTEOb5hPpEMWFsIzl4PoNjuh6j3DLhEs6cxKCveaH9X
	 rmbRxAFjGdbEGLXCXf+gF0vLBn9EAECEkPn/8yVE7UhRtK1chzfFYn7818wy49epNqQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794821746;
	h=Received:DKIM-Signature:Received:From:Subject:Date:Message-Id:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Endpoint-Received:X-Original-From:Reply-To;
	bh=67t8X9YkkIO4lw48UIdCWlUnsRh72tPEIwgW229HRC4=;
	b=BEfCW6r6IDn4Wq4kUnwFoYiMlrYp6aGClF8EkTwayexuQJbKkf6HDmFQLIy8XXHUU5s2
	 F3GC3j+TaokvBKD+0h4sNDGg3KiHMor6pW5bWbPNjcvuqOVbnx7D/7718CVqzRYcKVM0C
	 wKg3Lf5jxY9DgVg9A6AwGmVmoltWwQXUtNmKm7ifkSpk/3B3GtRjjGIk51SjWc973ZYA8
	 nD0LirK1UgLLGSSBSDWkTD/v3ZPP00FyWHhOAS9Ya/dQHYLF10/J6O1cNy66JAdW8K+Hn
	 f5PdjT9HjIvvbunVuI06UH8vx1o4cO1W+jl3YAhz4SWRMUhhxuZkjyQy/R2dTCfjgaQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=i016sYou;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCFAE606A32C;
	Mon, 16 Nov 2026 09:35:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=i016sYou
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794821746;
	b=tVNWDSAgNFcmLbCMGc5M0HvVlbaW6JLapa9Tg/23EY/HxVCIarVZHpNoFbtsBVzwC5q9
	 aEeidaErhdWL6HdoG30Mhp3C2gGhpW/nxwrOnYNjvsIXYuS8h19+D9op3pZwy83AO9zyU
	 2E73F7iePVTotppI9D8+2AVDfrdol0JdRU6vYRGU8MBbXqelrCb+WpDmX+FAfnCu2CGtY
	 ZNgT2WNGGVEUXIKKkwq0RNpjeVp3GpRcjnaNY0WlOC5aWs8+SPLW2MiDaC0SUeulOFPub
	 zoR+NCaWO3msnKxAqhy4jwQXwspBKbyhL0YpMpMFTVC1KGrJKb3dAdhp/QMuhcOdLMQ==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794821746;
	h=DKIM-Signature:Received:From:Subject:Date:Message-Id:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:
	 Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To;
	bh=67t8X9YkkIO4lw48UIdCWlUnsRh72tPEIwgW229HRC4=;
	b=xcSK0fVWhswHrC+fz6zQqi4pSxp9KSU3liom8DQWZiH/DeyenSW/Gs6ghuNQhuSGEdv8
	 NDjlMuzzg5TjNd/iq6x6DO+K/7eYsLza2YpEPg9gn8zsttESUQ/yLKXFZQmjhdWqaP79/
	 I5IuP5VQBlyR4G6nj8BLnXcRk+AP25qGkseKFbYLhhCbRenkZWArcky4PD8ZLhzSzHfkB
	 BCW2EvSxhBM346GRi9mwI0QwlUn4wzp50SsRjidejcGPM/9H7ySPKEnHvKMSrqr5RfCrq
	 0V/APLOExjKj74+X2Acvcz6JlZ+nTqRaGOcAjdrWh8AR+JTLIpbqfdeYFLK2VpB72/Q==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id D0E491F000C5;
	Mon, 16 Nov 2026 09:35:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794821746;
	bh=67t8X9YkkIO4lw48UIdCWlUnsRh72tPEIwgW229HRC4=;
	h=From:Subject:Date:To:Cc:Reply-To;
	b=i016sYouLfI6zFT99kapTmxvyKJ/1WuIVdUs8wbVThCiOPU8HsI28rRQ8xcncu8yR
	 58PdaDxq6GQO/+CnHls+S1TmUVdaplxbuhj7mi0AMyDDgZJb+3ybVfuvIIbTGElD9q
	 vXgOAVCGDNNOirMsU8Xhco0Gm/kSwSj8eKIFZRF28OteSKboMO1J6GHewFWsUgABVJ
	 wLNrbXjYlY2cixcKPDfYVsMaUMSXdiNVhsf/zxtbDMk8j8SXH6VFuiB8OrXifj7VA4
	 52iLjxYJl+y+5l3Zxn/oa7VZ1OHUKBtW7Cimops6hfK+uVJN54gw79lwVmsRDQpnnG
	 WKjk4JQN+S4Lg==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 3011F4A3FE;
	Mon, 16 Nov 2026 09:35:45 +0000 (UTC)
From: Matt Thompson via B4 Relay <devnull+matt.boondocker.io@kernel.org>
Subject: [PATCH RFC v3 0/6] PCI: rockchip-host: Handle unavailable
 downstream config space
Date: Mon, 16 Nov 2026 02:35:42 -0700
Message-Id: <20261116-rfc-b4-v3-0-0bf052b68f2a@boondocker.io>
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
X-B4-Tracking: v=1; b=H4sIAG7O+moC/22NzQrCMBAGX6Xs2Ug2bSLxJAg+gFfx0PzURqGRp
 Aal9N1N4614/JaZ2QmiDc5G2FcTBJtcdH7Io95UoPt2uFniTN7AKBOIWJPQaaIaItROcsVrYWQ
 LGX4G27l3CV3gfDrC9XeML3W3elwSC9a7OPrwKe8SFnhdTkgoURKNVpwyxulBeT8Yrx82bJ0v4
 cT+qyyrRihsOsk1GrFW53n+AqD9x87yAAAA
X-Change-ID: 20261113-rfc-b4-6b795b536d9a
To: Shawn Lin <shawn.lin@rock-chips.com>, 
 Bjorn Helgaas <bhelgaas@google.com>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 Manivannan Sadhasivam <mani@kernel.org>, Heiko Stuebner <heiko@sntech.de>, 
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>
Cc: Rob Herring <robh@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 linux-pci@vger.kernel.org, linux-rockchip@lists.infradead.org, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Igor Velkov <iav@iav.lv>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794821744; l=3925;
 i=matt@boondocker.io; s=rk3399-rfc-20261113; h=from:subject:message-id;
 bh=32ugxZ9YhRZmQLH1EfOQDSlBHTw79cq4a8bA5dFZ1lQ=;
 b=UODUueP6aJsGykruLNX++bgYLoLqRjAPAex3aYOzj24x9UodGmKQ8UXcyoxw5Mh6O/Yl2msMi
 /dH+q0SZmyqBqj1VV4NU71XxHOkZAw/HjjWqqymrT9IF6aa4iJvbc6t
X-Developer-Key: i=matt@boondocker.io; a=ed25519;
 pk=WMnh3kwFFRkrqamL/FbDcdl1/9rBF2uT03VdvGGP40k=
X-Endpoint-Received: by B4 Relay for matt@boondocker.io/rk3399-rfc-20261113
 with auth_id=1517
X-Original-From: Matt Thompson <matt@boondocker.io>
Reply-To: matt@boondocker.io

On a RockPro64 v2.1 with a Kintex-7 FPGA endpoint, a downstream vendor
ID read during a PCI rescan raised a synchronous external abort
(ESR 0x96000210). The rescan task exited with IRQs disabled and the
watchdog reported a lockup.

Patches 1 through 3 retain the downstream link check, the guarded
arm64 read fixup, and the AXI link-down latch handling. The fixup
handles current-EL synchronous external read aborts at the annotated
instructions.

Testing repeated re-enable, retrain, and rescan exposed three further
failures:

- PCI runtime resume replayed a saved Link Disable bit after userspace
  cleared it. Patch 4 resumes the port before a sysfs write to Link
  Control while holding the configuration access runtime PM reference.
- The PHY could reach L0 while the data link stayed in initialization.
  Patch 5 retains an early retrain request and issues it once if a
  later downstream access finds initialization still pending.
- The Rockchip PCIe client correctable-error interrupt fired at about
  one million interrupts per second on CPU 0 and starved RCU. Patch 6
  masks that controller-local notification. The standard AER service
  remains on the root port's separate interrupt.

Validation used upstream commit 97d73c825122, these six patches, and
Igor Velkov's separately posted probe and resume retry patch [1]. The
combined source matches the audit branch [2]. The clean kernel
completed 600 disable, re-enable, retrain, and rescan cycles with
runtime PM set to auto. Each cycle found the FPGA without a driver
rebind or a second userspace retrain request. The board stayed on the
same boot, the client IRQ count remained zero, and the kernel logged
no stall or SError. This test did not reproduce the asynchronous SError
that Igor reported on Helios64 [3].

[1] https://lore.kernel.org/r/20261116-rockchip-pcie-resume-v2-1-a633e279be97@iav.lv
[2] https://github.com/boondocklabs/linux/commit/bb7c4f9ee7ed33fc32832060fdecb9115c8e9630
[3] https://lore.kernel.org/r/20261116-rockchip-host-rfc-v2-test-1@iav.lv

---
Changes in v3:
- Add the Fixes tag to the downstream link-state check.
- Resume a suspended downstream port before sysfs Link Control writes.
- Defer early retrain requests when the PHY is still training.
- Mask the Rockchip client correctable-error interrupt.
- Record the 600-cycle RockPro64 test with Igor's separate patch applied.
- Link to v2: https://lore.kernel.org/r/20261113-rfc-b4-v2-0-d6b14f95c1d6@boondocker.io

Changes in v2:
- Restrict the MMIO read fixup to the SEA path and exclude its
  exception-table type from user-access classification.
- Look up the guarded instruction once on the SEA path.
- Use the standard arm64 register-number encoding helpers in
  the exception-table macro (Sashiko review).
- Link to v1: https://lore.kernel.org/r/20261113-rfc-b4-v1-0-b91dcb502250@boondocker.io

---
Matt Thompson (6):
      PCI: rockchip-host: Skip downstream config access while link is down
      arm64: Allow synchronous abort fixups for guarded MMIO reads
      PCI: rockchip-host: Recover downstream configuration access
      PCI: Resume downstream ports before sysfs Link Control writes
      PCI: rockchip-host: Defer retraining during initial link training
      PCI: rockchip-host: Mask the client correctable error interrupt

 arch/arm64/include/asm/asm-extable.h        |  15 ++++
 arch/arm64/mm/extable.c                     |  20 +++++
 arch/arm64/mm/fault.c                       |   4 +
 drivers/pci/controller/pcie-rockchip-host.c | 119 +++++++++++++++++++++++++++-
 drivers/pci/controller/pcie-rockchip.h      |   4 +
 drivers/pci/pci-sysfs.c                     |  16 ++++
 6 files changed, 176 insertions(+), 2 deletions(-)
---
base-commit: 97d73c8251226cf27cc6656b4c542869bb8c69fa
change-id: 20261113-rfc-b4-6b795b536d9a

Best regards,
--  
Matt Thompson <matt@boondocker.io>


