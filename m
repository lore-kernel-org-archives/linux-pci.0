Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794616131;
	b=tOcBg6mmNQZIZM0tvqAJyLJ7HD9x1lrLyPHfWR+Ljj9r/zO1EMwZ3Q4HLrpuUDhWOA/v
	 sqvsWHRveQGY5YB4hKkZ/KqfiYC+BS22bfk3NKBVQgKDHN0zFgU4kG7W8//kVd/K0vWHH
	 DrWAri1nEfJxTHNvluxHpKkgsLknCi7HDZvw7PfhtiDKk/sTKzvUCK0q+/wUd6xzN9owi
	 TKVSRLaHLJstSnlXqaGgEWz+vPgzbeMA/AaIaSLLhZiDTwJAcMI9ITZYHaHZS7SCuECCn
	 Js3yDkp0M1JB0G9T4YyVriB7D93CB+FhazsWET4jay0dTPKAuZtkbQWi+tAZY9dd+yw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794616131;
	h=Received:DKIM-Signature:Received:From:Subject:Date:Message-Id:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Endpoint-Received:X-Original-From:Reply-To;
	bh=a3dOC7IM/J9MOb41ZczbXOtg6Erx7oHExSHGxrl93Vg=;
	b=Pw1bCO2vGiCpld+eZl9zP7PUTQq+HlIcUhSvxZWZxzfweGB3bXd0RuvX00yUCKnI04+S
	 ezam21ILIXel8v6ZHWFDPbzB9KMNA+tRpNJllkpSBH3yo5SHt/r7zO91EDbJCeLo9ze0d
	 szn43IkI53EqydlGo9bNRV3wQEa3ZbB5r1SYrdMkvr0eRpyr6QMrsli4pWeQSl4o8lXuA
	 w8KPdZ7p9Bpmfm10fNFZCta8y4vpoNYvpiARtPIWuOFPffZAqlutxeTRZjNdEQlp+YJ3L
	 2p1ZR35keJko2ReBN5+9TKBR5DXFd1xCqn9lT6S9kaSv37W+3tgQwNZ+8Lp9YPQT2Vg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GAJ92nS9;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4DA4606A32D;
	Sat, 14 Nov 2026 00:28:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GAJ92nS9
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794616131;
	b=fVRXdj2iRGAwGdOqPk6HUxtFGD2aeoGuzmjYWOwTBT2w97PJmOHt9GXW9JN7QU7LLQAh
	 QgKLKxXOuuE1708fM1EWZzyLBXilR53V5c0wS+zYIznTA/l/AsK74a6vBSSDU1SLOE2i6
	 WizG3DOrJiuk+oqXZyaS9bDse2Be12l8ElTX0JQ36IfWfemzFTsTUOnCZfVkocoAg52HX
	 jbEq09k8acv/J/Ux0dENSzR6OCWHukReVVWjvbEk/ve8NPR4ayePQw7VLWsdkDsFX7UvE
	 16c/Oz7dno8IrPbGYgp+LkMxKFpF5ybhFC2ucffhZ+BU70CHdQsvbXyZme2wjCEdVqg==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794616131;
	h=DKIM-Signature:Received:From:Subject:Date:Message-Id:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:
	 Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To;
	bh=a3dOC7IM/J9MOb41ZczbXOtg6Erx7oHExSHGxrl93Vg=;
	b=10vvNfbq4zEQwY1bUCfKQuJ8fxP3MVQeQPmu9eDbNecBMmQgsWdUSi69dbownCBgLpt5
	 6APcE5xGJKfNhvm/KjLfei8MOiAmMJ0vPxIbkbqCNL9gnyiTWu5R31h+W71iZDnjBkukJ
	 djZCbUmnqFzX+wjYuHuwzZYV8BJ9MeeT2lzLCq9NmdlgPc8NYaWSm4S0R77UmL/RVJSDi
	 LQe20AJNg4KXLWkWVCd5IEmavKaIZxmrqJZv8d6o6sdbXPZ+cd6BQyemD2P5Beno5PqFJ
	 MdpKlu8NyuTtcnl71Q5pJB7DuSsVYWkIIggUhWkuu8k4L1ZbdwpX6LccL17XYzQmcxA==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 9D04E1F000C4;
	Sat, 14 Nov 2026 00:28:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794616131;
	bh=a3dOC7IM/J9MOb41ZczbXOtg6Erx7oHExSHGxrl93Vg=;
	h=From:Subject:Date:To:Cc:Reply-To;
	b=GAJ92nS9mlMhHmlFozv1/5Vnu2ruyn/Ymv9h4icba+tONJ00ZUFdDmbpC75ED2Af5
	 +YiAHafnPEefLArrvZ7uOMeus2yzsGVO8rUKIegOQWUy2KDWiNxmkNAiaL/x4qfLa6
	 phtihDcBd1EGxYCDBB+qyWIefShbThCnhSqlot9T+3N6Z+MdiwpyngU9fota1KwqUe
	 Cw72F+ESC3hOSzcJCp+p7DjDFbXo/erWnxJZh2jxJwfqBT6nVpM8OQ5AAdVM08bzB1
	 DhZMgr73SwTJDHwg1DLOUMTdnqDzap6up37mfVGyEuCwy30zN33ZhiiLtnx1IK5BiO
	 KTaDMzZqA+03w==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 2AE6A49BDF;
	Sat, 14 Nov 2026 00:28:50 +0000 (UTC)
From: Matt Thompson via B4 Relay <devnull+matt.boondocker.io@kernel.org>
Subject: [PATCH RFC 0/3] PCI: rockchip-host: Handle unavailable downstream
 config space
Date: Fri, 13 Nov 2026 17:28:48 -0700
Message-Id: <20261113-rfc-b4-v1-0-b91dcb502250@boondocker.io>
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
X-B4-Tracking: v=1; b=H4sIAECr92oC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzNDQ0Nj3aK0ZN0kE12zJHNL0yRTY7MUy0QloOKCotS0zAqwQdFKQW7OSrE
 QweLSpKzU5BKQEUq1tQDuAOiObwAAAA==
X-Change-ID: 20261113-rfc-b4-6b795b536d9a
To: Shawn Lin <shawn.lin@rock-chips.com>, 
 Bjorn Helgaas <bhelgaas@google.com>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 Manivannan Sadhasivam <mani@kernel.org>, Heiko Stuebner <heiko@sntech.de>, 
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>
Cc: Rob Herring <robh@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 linux-pci@vger.kernel.org, linux-rockchip@lists.infradead.org, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794616129; l=2536;
 i=matt@boondocker.io; s=rk3399-rfc-20261113; h=from:subject:message-id;
 bh=hJTcfTu09wCmC3nbBjFL8A2h4aeAyl+zKDrvafc3W0g=;
 b=Wrbv/DxX6/CcK1kGw5KAZv4ngfmBYI0xgnWa6Hh1DHmljEanXeUthQA5Oz/06+fRdc+zyaY0u
 PL67CUK6M+HAHQeXCvoW6JrSYjcIojnkyKaBvh8zvovMwkPZldqRGTT
X-Developer-Key: i=matt@boondocker.io; a=ed25519;
 pk=WMnh3kwFFRkrqamL/FbDcdl1/9rBF2uT03VdvGGP40k=
X-Endpoint-Received: by B4 Relay for matt@boondocker.io/rk3399-rfc-20261113
 with auth_id=1517
X-Original-From: Matt Thompson <matt@boondocker.io>
Reply-To: matt@boondocker.io

On a RockPro64 v2.1 with a Kintex-7 FPGA endpoint, a downstream
vendor-ID read during a PCI rescan raised a synchronous external
abort (ESR 0x96000210) in rockchip_pcie_rd_conf(). The rescan task
exited with IRQs disabled and a watchdog lockup followed.

The first patch skips downstream config accesses while the controller
reports the link unavailable. The remaining patches handle synchronous
external aborts on explicitly annotated arm64 config reads, including
when the link changes after the status check. The final patch also
clears the AXI link-down latch before downstream config accesses
once the controller reports the link ready.

The arm64 change is limited to marked load instructions. Asynchronous
SError, BAR accesses, and config writes that race a link change are
outside that recovery path. Feedback on the exception-table interface
and whether the controller can handle absent completions directly is
welcome.

A related discussion covers an RK3399 endpoint that trains but fails
to answer config requests:
https://lore.kernel.org/linux-pci/20261024-rockchip-pcie-resume-v1-0-58e54a5cf5f1@iav.lv/

Validation: applied these three RFC patches to upstream commit
97d73c8251226cf27cc6656b4c542869bb8c69fa and booted the resulting
7.4.0-rc2 kernel on a RockPro64 v2.1. The test config enabled Rust
and built in the required board drivers.

Three test cycles completed on that kernel. Each removed the FPGA
from Linux, disabled the link and rescanned, then re-enabled the link,
requested retraining and rescanned. The FPGA stayed absent in each
disabled scan and returned at 01:00.0 after each retrain without a host
driver rebind. The log showed no synchronous external abort or
watchdog lockup. The test did not establish whether the arm64 fixup ran.

---
Matt Thompson (3):
      PCI: rockchip-host: Skip downstream config access while link is down
      arm64: Allow synchronous abort fixups for guarded MMIO reads
      PCI: rockchip-host: Recover downstream configuration access

 arch/arm64/include/asm/asm-extable.h        |  9 ++++
 arch/arm64/mm/extable.c                     |  1 +
 arch/arm64/mm/fault.c                       | 11 +++++
 drivers/pci/controller/pcie-rockchip-host.c | 69 +++++++++++++++++++++++++++++
 drivers/pci/controller/pcie-rockchip.h      |  1 +
 5 files changed, 91 insertions(+)
---
base-commit: a72c40386d63746568fb027900faaa8ec0054127
change-id: 20261113-rfc-b4-6b795b536d9a

Best regards,
--  
Matt Thompson <matt@boondocker.io>


