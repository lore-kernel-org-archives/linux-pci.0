Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794617543;
	b=jcmsnH7G3x57X+7miS5E+5S2e9xe72GPbZkT8MrBCmPICeie4TAC43OcrL8zhHmq5YLK
	 A8xuZSe3qki2tTTHOmuZZCmY2ho5uziO9anAOAGynTG6w2tg6su8RsHha+mmfPANc9cPM
	 IYHzIZeDF6/ynUXU0WEMSnF9B/bjI1ayZ0qwUd7vQNoS8LlJmUS9Ot1HJSgWrQOpNpiLv
	 Qo0//j6lUcqMgGwHBLCHKi8sBlXTdW5UHOYaiNVcoDXjsv/mJ36llichQqY75cJ9X9ikV
	 bmJ7XILjaqF1eNZzGmAQeUgBZs+33CPOXnbBlmCBTI36I86jkt8fBS/lDnZGl/lyShA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794617543;
	h=Received:DKIM-Signature:Received:From:Subject:Date:Message-Id:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Endpoint-Received:X-Original-From:Reply-To;
	bh=aIqvjGY2BoJa1S5k5OTFxK2lNEFIunzD8NJXeg3oTac=;
	b=nFawInxEqYgLp2mrWCcYOUop2u3D/KDMtRA0EopfSqnLvrJOChCn6A8d+0R+i0631xPq
	 e/wh8fHbcokh/DYREb9pqnca+aaFLv8zbuzTRM0iVTecwdBslILeYnn1D9jKUFPNvCAt5
	 kLfdPijx8IQIZH3pgj0RAlAuFRZbOGh1tZJWxWQNH9VPV752z8h2or2ZldmV9nWsou2wa
	 0VPgO55CNEXWmVBW4LZHCehlbgFENT6ZD5tRhYfSmJhaGAXWShJHn7/mbCq77Tr9TDYMv
	 YtICHS5TzxO72cGGgt3BlGy29MnFb0Udz69pM+LQhp8RZFMbk35SwFwrdsJLMAoO+dA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OGJFZfGa;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E7F1606A336;
	Sat, 14 Nov 2026 00:52:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OGJFZfGa
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794617542;
	b=mfv6AL4QWkLJEKcJfF1GBJEYxqi5/vXinZ2zRdZ6tSjd/97o2RB336dEqC20lSWZXAub
	 a1xgUvKBEb6wLUkDI51V2sYiCzbo9ah+wQ/CJvKcwwvcM+Wggw/KnWbQJbZB33f+7KNqp
	 LFY5uY8HuYjjiQGwBs1FwMAvhJY4PgH/wRSFcfprtnh3uftmLp95MxvGF6TMr37uY9ht7
	 OwcRSHjBNYDo1JatmspLuPnY5RSp4ZHSgHE8BZjefN7ZK/tHwDi58nb/ZDi6gru7OEzEH
	 4GOweK0sh0DRn2Im7hmCND2S/qk99lF1NaPSyDWicKSAkFh/GYRhcyKACKAJQ41ehxA==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794617542;
	h=DKIM-Signature:Received:From:Subject:Date:Message-Id:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:
	 Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To;
	bh=aIqvjGY2BoJa1S5k5OTFxK2lNEFIunzD8NJXeg3oTac=;
	b=tIzeRN0QZO7ryl7igEKIt6Kg60YoBQsLMPko/JFGQtatnfkCoMtLwz1DvwXXIQf71FIB
	 qbOcOXQJQK+OGYcfu7JRtqaJxG5oKxjLK9Lsn9NGIIa9R1kS65mbMvpsRQRWZitPfQGzQ
	 1PaObryS6Fw/BrZGpMo24nOphlQi5sYeHa4YKxK+Fih07b+4/3itJp59e5rYMu59SbvBS
	 L6Fv5lRHTTHC09BODEEAFaz8N3l9PYUmzV4k881pg/JMMbj9p7UiaDq/I6useJ/LvQ2Xw
	 jmSgVIkhe4IaLXnjtZJXCPLVIIfs1K55BPiYo8dEOdDW2EohJbsCc2SXUUfpFHNjtow==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id C3A641F000C7;
	Sat, 14 Nov 2026 00:52:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794617542;
	bh=aIqvjGY2BoJa1S5k5OTFxK2lNEFIunzD8NJXeg3oTac=;
	h=From:Subject:Date:To:Cc:Reply-To;
	b=OGJFZfGaI/tVHwgR02sk458tfXsBuwXXT0O59DGnA7hoQou36k7xObWhVV7VXfvoc
	 J9UywouKkFD0BSpMXSi3XkxAwqwGiZpH91+vzuogpg8hP51NtYPzUP7hUCvvMS0Z0H
	 p0s42oysYGB6hPmLhS6yPV2Z+Xx3x6Y0GVsqbs89MHdZEugobpWiM6ZFU7vQCQTmoA
	 h6P3w0VhRIb5j1R6XtfNbjdiGj0ZLd0F3noNu7pRIwGNWeS4reY2exhT/DcGn/dUnQ
	 0CzUph5b7DGbAqyeUtISax08Va+yb/l93AqwH6ybGk1vqI1haXZ7OcSCipBWDedNM7
	 D+oL7BV+DXxPQ==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id C711449BF4;
	Sat, 14 Nov 2026 00:52:20 +0000 (UTC)
From: Matt Thompson via B4 Relay <devnull+matt.boondocker.io@kernel.org>
Subject: [PATCH RFC v2 0/3] PCI: rockchip-host: Handle unavailable
 downstream config space
Date: Fri, 13 Nov 2026 17:52:18 -0700
Message-Id: <20261113-rfc-b4-v2-0-d6b14f95c1d6@boondocker.io>
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
X-B4-Tracking: v=1; b=H4sIAMOw92oC/12NQQrCMBBFr1JmbSRJTaWuBMEDuJUuOsnUjkIjS
 S1K6d1N487l+zzenyFSYIpwKGYINHFkPyTQmwJs3w43EuwSg5a6UkqVInRW4E5UuK8NmrJydQt
 Jfgbq+J1DV7icT9D8xvjCO9lxTaxaz3H04ZPvJpXl//KkhBRYK2fRSK2NPKL3g/P2QWHLHpplW
 b4RYmE+twAAAA==
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794617540; l=2945;
 i=matt@boondocker.io; s=rk3399-rfc-20261113; h=from:subject:message-id;
 bh=u8NC1h2UFOo1v6PYckTyaAJW66VhB2jXXpyJT0WEzzE=;
 b=OwCULHv2DTo7iZm5pH4MrnKZdJGHc4Pm+X0UKcVZOeVooF2AHEUEMn0dyo3IqMpyHEB/nI9pb
 OIJlGYE7jVmDKXVtsSqLepnrFpddKUXdTrx7bzBJffKITc/dqVy1lzq
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

Three test cycles completed on the v2 kernel. Each removed the FPGA
from Linux, disabled the link and rescanned, then re-enabled the link,
requested retraining and rescanned. The FPGA stayed absent in each
disabled scan and returned at 01:00.0 after each retrain without a host
driver rebind. The log showed no synchronous external abort or
watchdog lockup. The test did not establish whether the arm64 fixup ran.

---
Changes in v2:
- Restrict the MMIO read fixup to the SEA path and exclude its
  exception-table type from user-access classification.
- Look up the guarded instruction once on the SEA path.
- Use the standard arm64 register-number encoding helpers in
  the exception-table macro (Sashiko review).
- Link to v1: https://patch.msgid.link/20261113-rfc-b4-v1-0-b91dcb502250@boondocker.io

---
Matt Thompson (3):
      PCI: rockchip-host: Skip downstream config access while link is down
      arm64: Allow synchronous abort fixups for guarded MMIO reads
      PCI: rockchip-host: Recover downstream configuration access

 arch/arm64/include/asm/asm-extable.h        | 15 +++++++
 arch/arm64/mm/extable.c                     | 20 +++++++++
 arch/arm64/mm/fault.c                       |  4 ++
 drivers/pci/controller/pcie-rockchip-host.c | 68 +++++++++++++++++++++++++++++
 drivers/pci/controller/pcie-rockchip.h      |  1 +
 5 files changed, 108 insertions(+)
---
base-commit: a72c40386d63746568fb027900faaa8ec0054127
change-id: 20261113-rfc-b4-6b795b536d9a

Best regards,
--  
Matt Thompson <matt@boondocker.io>


