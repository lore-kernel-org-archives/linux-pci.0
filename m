Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793963404;
	b=WkXIalcOteZb12/QbyyLh1qy8fgeW57sGjt+YMoEK/p02MpJFfgbL9ulX5cpCtYYoRlp
	 gX/cVO9ErbXwvYIoWF+NH7mihUFbH8/lcOks4t2lQ7+yfmcVAcwwS5dYW0/qvMZcZlVkw
	 IVJFTSsPvYmb2oRxUKXJtevC9jaDgL/Yf/7Xk0biX0GTm+MN3gh7req+sZZJlAliHa7ED
	 9HNXVj2X2UU1j57SvJddQJevBThBbUYb1kkIlYewF1cIWJooUfs6u0E7Ab7k1vfHCJqLy
	 IvCeph5DkFSI3By2q5mDZ5XqdqEIadgKglM9FZXj0U9u8Oy2BEKq1/xAG+4PwHCq2Vg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793963404;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=g/leEMY3T0xFKOpb94XgJ/IAKICADBoapFLrHWlkHIg=;
	b=WrnbjhWEM0Oob2q8ia2H9RBbVcw9N+4twZjxOyn9kLzhJQlxeQ8cIwtK+RJJIv3qMc1a
	 EE/32yKMk79kLmTc9VQTjME21YU209c3ub+/zCSVi7Se9oJfbDawZvdkhVb1NCdZw0e6v
	 2UtbOaI1EPJkKLe7Pb6Cyn5Sbw9nWoA12k1nQhLqwL1Wd6ySjHmogVWzJI+J3Zjo3ygsb
	 rMRaWV9kKrtp3e3+478iZ83TB2/qrR9PUGzeU8wzY8AKgQqRCt+Fs+l8H/2mevURMsyu4
	 nzMdHHiZl1pwytt0p8B8TWRm8B6vjiZ9b6ZrvGrbICV/tvqcRJBE8elptmNIKe50eTw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FxRTYJ9k;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3658C606A329;
	Fri,  6 Nov 2026 11:10:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FxRTYJ9k
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1793963403;
	b=CX6PPLW49MfBKCrNO7mKZV1k21IV1fOGlaaV/QGsox3Gyd2vYKRgTnhBt3v9M8fXNdVB
	 0tggfwdfyKKQ1uEDhhd02pACpNKFz6q3hcfS2Wfo4RxpwGKu+S1xOqGRGPTPBMM3/cBa/
	 SRGXuKPCCVGmrkriQe2sB12OTJJeba7GpSmbWnEHgCDGasOQa3UpBCp01WOPQn4MTPw9h
	 1BVlegeS1FhSGOflNlCN/EiDP+mMl9uu2N12r3geYMyli8se/UDGdt8N7KqHyDuSg7p9p
	 hzh9geTVpfKB4O7pqLDlyPalXqzzcDRIEkCsWrH4ezO/9s67Bn402Veg1r2K9JcqRjg==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1793963403;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=g/leEMY3T0xFKOpb94XgJ/IAKICADBoapFLrHWlkHIg=;
	b=EyDX9e1f9jM7gO5bEF21VC5Y0Gmo9tBaHz7g7u90AqXBLUxcO6+xWaBleo+RVgp9SEjA
	 v2+qoQZkec3rKznPalNP8jqMXfoitoyhCnU35ibTfmfy/0BfTxc6TsdP+7DeuI55b5Vs0
	 PBHXzE2w5Xy0/4JjQDXGSBvruv+48uL4O9gqj1hWabwgtYEriJI1fset6qTu071YqydOz
	 b4ws1GupYg3c9xTtuVuoTBeyyaogs+glJxjetyEU1AI2NpYTOSdCrpqekGruixx7zCHsn
	 KfFkuQ1/QGmLdPdiszTF4/Kyvz0akKnBKpM68GE0+bEHOwZOeBBfmicISfuextii31g==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 482DB1F0089F;
	Fri,  6 Nov 2026 11:10:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793963403;
	bh=g/leEMY3T0xFKOpb94XgJ/IAKICADBoapFLrHWlkHIg=;
	h=From:Date:Subject:To:Cc:Reply-To;
	b=FxRTYJ9kF0QZwkNeH12mJldeUPKLJJDeCRkaU7b0vG2kCuC1lg5IGkRRaExVX2o5L
	 ySYae0muusyxHfnRxTesRP26XtbVoM2DdC/olow8iU5eR49eJ9Qu+FyA9pf2VfgZ13
	 mVmSaX8bl9WkGTaJH8D4J1IULqflNWjb8hiP1ygP+2vl7y8Jq/kskWaka6CJx3gm9E
	 dtqYLRWfkK7Xi4jMTCF0Td5+gGX4BLJvhIpLb1sA/yYdg60AGFm1pNom9fweO+uu2N
	 KbhPe/jisy227Eww+d/gR8VC8dTv8/iFSh7HF9+ZjvNQFy9tnPVONPWftcbbrDaC2t
	 6Y/Th0hD2KFpw==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 92DDF45CF0;
	Fri,  6 Nov 2026 11:10:02 +0000 (UTC)
From: Jens Glathe via B4 Relay <devnull+jens.glathe.oldschoolsolutions.biz@kernel.org>
Date: Fri, 06 Nov 2026 12:09:59 +0100
Subject: [PATCH RFC] power: sequencing: pcie-m2: stop requiring subsystem
 IDs for WCN6855/WCN7850
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
Message-Id: <20261106-pwrseq-bt-subsystem-v1-1-11fb09f63c93@oldschoolsolutions.biz>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzNDQwMz3YLyouLUQt2kEt3i0qTiyuKS1FxdIxPLZHOLVAsDo+QkJaDOgqL
 UtMwKsKnRSkFuzkqxtbUAp1bYMWoAAAA=
X-Change-ID: 20261106-pwrseq-bt-subsystem-249c78e802cb
To: Manivannan Sadhasivam <mani@kernel.org>, 
 Bartosz Golaszewski <brgl@kernel.org>, Wei Deng <wei.deng@oss.qualcomm.com>
Cc: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>, 
 linux-pci@vger.kernel.org, linux-pm@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Jens Glathe <jens.glathe@oldschoolsolutions.biz>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793963402; l=3002;
 i=jens.glathe@oldschoolsolutions.biz; s=20240919;
 h=from:subject:message-id;
 bh=t5UII2v99mLuMKVxGQklvEBJsKKUJFSN4tb1ImMhs0k=;
 b=w/e8/FRzz6dIH+oxyAlLxQfsWrqcdJm7iFVI1QuyVeFH6PoCpRsMpGN4qOtU3cdHjsY+ll4Dk
 DkK+mUkRAs6AXl5Gv9xCUltGGe9clDlEvEBWvC18dFgvMdomfojfkol
X-Developer-Key: i=jens.glathe@oldschoolsolutions.biz; a=ed25519;
 pk=JcRJqJc/y8LsxOlPakALD3juGfOKmFBWtO+GfELMJVg=
X-Endpoint-Received: by B4 Relay for
 jens.glathe@oldschoolsolutions.biz/20240919 with auth_id=216
X-Original-From: Jens Glathe <jens.glathe@oldschoolsolutions.biz>
Reply-To: jens.glathe@oldschoolsolutions.biz
Content-Transfer-Encoding: 7bit

From: Jens Glathe <jens.glathe@oldschoolsolutions.biz>

Commit a39ac4651e3b ("power: sequencing: pcie-m2: Match WCN6855 and
WCN7851 UART BT variants by subdevice ID") narrowed the PCI match for
the WCN6855/WCN7850 family from PCI_DEVICE() to PCI_DEVICE_SUB() in
order to avoid creating a UART serdev on USB-BT variants that share
the same device ID.

The practical result is that every legitimate UART-BT board must now be
explicitly listed. Missing entries (e.g. Lenovo T14s Gen 6, subsystem
17aa:e0e9) silently prevent serdev creation even though the DT graph
already describes a UART link on the connector.

The graph link is the reliable signal that a UART BT interface exists.
Once it is present, the vendor + device ID is sufficient to select the
correct compatible string for the dynamically created node. A pure
USB-BT card simply has no UART graph endpoint, so no serdev is created.

Keep a single PCI_DEVICE_SUB() entry for the QCA2066 (which shares the
1103 ID but needs distinct BT driver data) and fall back to bare
PCI_DEVICE() matches for the rest of the 1103 and 1107 families.

This removes the growing OEM subsystem-ID catalog from the critical
path while preserving the one case that actually needs a subsystem
distinction.

Fixes: a39ac4651e3b ("power: sequencing: pcie-m2: Match WCN6855 and WCN7851 UART BT variants by subdevice ID")

Signed-off-by: Jens Glathe <jens.glathe@oldschoolsolutions.biz>
---
 drivers/power/sequencing/pwrseq-pcie-m2.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/drivers/power/sequencing/pwrseq-pcie-m2.c b/drivers/power/sequencing/pwrseq-pcie-m2.c
index 56c5d51293c10..72c721149dfae 100644
--- a/drivers/power/sequencing/pwrseq-pcie-m2.c
+++ b/drivers/power/sequencing/pwrseq-pcie-m2.c
@@ -217,15 +217,9 @@ static const struct pci_device_id pwrseq_m2_pci_ids[] = {
 	  .driver_data = (kernel_ulong_t)"nxp,88w8987-bt" },
 	{ PCI_DEVICE_SUB(PCI_VENDOR_ID_QCOM, 0x1103, PCI_VENDOR_ID_QCOM, 0x0108),
 	  .driver_data = (kernel_ulong_t)"qcom,qca2066-bt" },
-	{ PCI_DEVICE_SUB(PCI_VENDOR_ID_QCOM, 0x1103, PCI_VENDOR_ID_FOXCONN, 0xe105),
+	{ PCI_DEVICE(PCI_VENDOR_ID_QCOM, 0x1103),
 	  .driver_data = (kernel_ulong_t)"qcom,wcn6855-bt" },
-	{ PCI_DEVICE_SUB(PCI_VENDOR_ID_QCOM, 0x1103, PCI_VENDOR_ID_QCOM, 0x337e),
-	  .driver_data = (kernel_ulong_t)"qcom,wcn6855-bt" },
-	{ PCI_DEVICE_SUB(PCI_VENDOR_ID_QCOM, 0x1107, PCI_VENDOR_ID_QCOM, 0x337c),
-	  .driver_data = (kernel_ulong_t)"qcom,wcn7850-bt" },
-	{ PCI_DEVICE_SUB(PCI_VENDOR_ID_QCOM, 0x1107, PCI_VENDOR_ID_LENOVO, 0xe0e9),
-	  .driver_data = (kernel_ulong_t)"qcom,wcn7850-bt" },
-	{ PCI_DEVICE_SUB(PCI_VENDOR_ID_QCOM, 0x1107, PCI_VENDOR_ID_FOXCONN, 0xe0ee),
+	{ PCI_DEVICE(PCI_VENDOR_ID_QCOM, 0x1107),
 	  .driver_data = (kernel_ulong_t)"qcom,wcn7850-bt" },
 	{ } /* Sentinel */
 };

---
base-commit: ddfe51b0a0f5dc9e415cc2c8ad8db17532dd426b
change-id: 20261106-pwrseq-bt-subsystem-249c78e802cb

Best regards,
-- 
Jens Glathe <jens.glathe@oldschoolsolutions.biz>


