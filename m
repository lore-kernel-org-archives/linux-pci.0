Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792777191;
	b=pC+tK5QkUTGcWNLOCnSWLwxxvh3vgqlYETZ7crPxz94BwrFR6Ct4CkmkM6ObeZB2sO6F
	 K4DGVhfVarkh4AGKygXMd956Ce5af2mXm9ZMNLaZBI6XlOi7V9Ri/ZzCvwpQZjuOYiirV
	 SrrMPOe4xcJfgpyNbA6lfDU0sitRYG0pNa4jIEij1bDWeueqtwoJ6JqlrzaEbkKoEA4TP
	 qWRz+5XbT7Oy3C6SJRU+bx6tvUIXMz5QJh+FG6DRi3prQFdw6ru3bf9TY/mc4FTSLetOx
	 H6tHEjYplprRBZKZ32O1VFdVwEnjbvXAGgj4zZwxZ+weQM7J1mcW1pjPDCY5/oc+jfg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792777191;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=waB3ovVdlrOaRg5kwbOJtqiQowW1jAyrixqhCwCH4EM=;
	b=XdBwRaFV5Rli3r39VZwDrAEWLhYEmn+djBNcW7puQwQoAYsKNrf+uRS9pbZFj/4bC2sB
	 Zg/L8sAyvbp4/KMPtrjyA64rWbvYvUv4OU9KccN2t0jQtwrEwtneE4XpOs098vbhiTVoa
	 3nD+svOrWPDqLMwZijVr99ufCLJWT5kT2VaiUlGQrbky3ILXtDG/OZmVH9uKYsKED/UlC
	 vIQM6zoYNbL8gvbM8nbNwQyQn//TVHg9x3NZNpdAcSzeDBVIYntzCJEpegp4iYVgzM4qn
	 CQ0I+ycISWPHRQtaq5SwG3IJTuTCcMnjiVx9x62Kh2gn6WvxyVX1GqzWSgPBqwcIntQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AXejTeFP;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75E93606A31B;
	Fri, 23 Oct 2026 17:39:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AXejTeFP
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1792777191;
	b=KYAgd2nZRfLkXZCyEm3RprqHCgCudBBAFlbBtsCcDRQ3CjvhqJsVohCAMxPJcpg8Y8xN
	 tjxb2GLnJke5H0etawm8+K6eWnp7amCqBfRmm5GnyPBKBjqnLCgn1oq5Y+90dnZyywSEu
	 lhIwmIfZHzayC0Wacd/QGmuaamcjtvMfS6iO62q8VEwHbXkR7cSLTSlSPjtoQU+dS34tS
	 s0ly7VoyjU8CEXeaWkCK8+i97lzG0cqU0SabkGL40Pade7zZKWxVaZkt3zow12EDhpPV1
	 LNQVQw0cOeyBXwvQfTuLsBpE43Fff68qHG4sOfAHiq+PXDY+BjabZQs1SlvhaQU454Q==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1792777191;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=waB3ovVdlrOaRg5kwbOJtqiQowW1jAyrixqhCwCH4EM=;
	b=SsVJ+akbXzgOeTGxAHviosfcQQpr0LdjHbEtB+LU+tivksiyfh4bfN6SdE5DITVnCq9d
	 vwLaRZ4lSPR4w/eMtA/1998hH/n8GjByrlQqj3/gW/fzdPmRMfGfMsPRQT8ikyrJxDSKn
	 zf4JBGemZHTwFrI+DIxZNp0i6RU87EfzELJERVi005bFVuhV011POZdO2vtoJPUf/nCmO
	 u5mrZd7pkoRPEsm9UUWs8EtR3BVSjnnTU1kAHw+9v9z649zgB4fUs1WS8o6TdeX4OBPqM
	 SQDI/Xzpvb+/HXRxTV2wSMH64q+D48X17GfrEK1nQpivRMj73mDU9ZywNjfKCS+oNQw==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 8E33C1F01825;
	Fri, 23 Oct 2026 17:39:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792777191;
	bh=waB3ovVdlrOaRg5kwbOJtqiQowW1jAyrixqhCwCH4EM=;
	h=From:Date:Subject:To:Cc:Reply-To;
	b=AXejTeFPl2g76hjcjwYj23tvvyPiO2O9fBFqIp0gibOAKU3RTySfEdImOH2NSaLTB
	 v8WFO75gZAkCnXocqPuOOGzye3Tq7ejCrodL8fRfD039dKiMobU4snQwLW2FoHV6Uy
	 g7g6glNTejVPw8vTK+WvuAKeIthwOqINFFXA4gHUt3cCGo3dH4wmqQbgOdb+MmrwiS
	 U/ptzDjsmG8ZWm61OkPsXm+yqzFFquvLT4u8yABzqlU1RxspiInevzYju4mVsPjHg8
	 eWbYj2WG3AkCnD6XSKwROyREjI+mmWpqCisrIXL4HsXdTCbd78pJyjwZ/BYscPFcsc
	 r4644y498UWWQ==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id E6F0944568;
	Fri, 23 Oct 2026 17:39:48 +0000 (UTC)
From: Anthony Ruhier via B4 Relay <devnull+aruhier.mailbox.org@kernel.org>
Date: Fri, 23 Oct 2026 19:39:35 +0200
Subject: [PATCH] PCI: Disable LTR on Qualcomm WCN7850 [17cb:1107] to allow
 ASPM L1.2
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
Message-Id: <20261023-quick-wcn7850-v1-1-9a139b9b2c8e@mailbox.org>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzNDAyNj3cLSzORs3fLkPHMLUwPdRHNLI0szi+RkI9M0JaCegqLUtMwKsHn
 RsRB+cWlSVmpyCcgQpdpaAMlxQMFxAAAA
X-Change-ID: 20261023-quick-wcn7850-a792968cc25f
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Anthony Ruhier <aruhier@mailbox.org>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2159;
 i=aruhier@mailbox.org; s=2026; h=from:subject:message-id;
 bh=qVemxmolshXeAK74vDQvvG7KPXw1hF5ybwiK/r2mOek=;
 b=owGbwMvMwCV2okp4cvOBsLOMp9WSGLJuz37Cz7ZBaGX46ad/bsqxTZD6LcNw0ZBnqkJrwdacm
 1pPv7ct6JjIwiDGxWAppshywbLg8eNb0ZO762y6YOawMoEMkRZpYAACFga+3MS8UiMdIz1TbUM9
 QyBDx4iBi1MApnpDKMP/xMmyzmsuPG+6cth1W+oN4UOPFToOlfhzH0tV85ppVFDLzshw57/Enfl
 ZHiY5m8+oif48uOj39EBP86wX+2UXXYyvvi3JAQA=
X-Developer-Key: i=aruhier@mailbox.org; a=openpgp;
 fpr=F4A378DD8D494AE48EBA554CB00FBC7D08D231D9
X-Endpoint-Received: by B4 Relay for aruhier@mailbox.org/2026 with
 auth_id=1292
X-Original-From: Anthony Ruhier <aruhier@mailbox.org>
Reply-To: aruhier@mailbox.org
Content-Transfer-Encoding: 7bit

From: Anthony Ruhier <aruhier@mailbox.org>

The WCN7850 Wifi/BT card, found in several Snapdragon X laptops, never
enters ASPM L1.2 when LTR is enabled. Its firmware reads the
LTR_L1.2_THRESHOLD set at enumeration and reports an LTR value just
below it, so the L1.2 entry condition is never met and the link stays in
L1.1.

Windows does not set LTR Mechanism Enable for this device (verified by
dumping the ACPI tables), and the link idles in L1.2 normally.

Replicate the same behavior: clear PCI_EXP_DEVCTL2_LTR_EN for WCN7850 at
enumeration and again on resume, as the LTR state is restored there.

On a Lenovo Yoga Slim 7x (X1E80100) this allows the link to reach L1.2
and reduces idle power by about 70 mW.

Signed-off-by: Anthony Ruhier <aruhier@mailbox.org>
---
 drivers/pci/quirks.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index 1aa87a3ef9ed..374c505981a0 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -3795,6 +3795,20 @@ DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_QCOM, 0x1103, quirk_no_bus_reset); /* WCN
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_QCOM, 0x1107, quirk_no_bus_reset); /* WCN7850 */
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_QCOM, 0x0308, quirk_no_bus_reset); /* SDX62/SDX65 */
 
+/*
+ * The WCN7850 firmware reports an LTR just below the LTR_L1.2_THRESHOLD it
+ * sees at boot, preventing it to ever enter L1.2.
+ * With LTR disabled the link idles in L1.2, similar to what Windows does.
+ */
+static void quirk_wcn7850_disable_ltr(struct pci_dev *pdev)
+{
+	pcie_capability_clear_word(pdev, PCI_EXP_DEVCTL2,
+				   PCI_EXP_DEVCTL2_LTR_EN);
+}
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_QCOM, 0x1107, quirk_wcn7850_disable_ltr);
+DECLARE_PCI_FIXUP_RESUME_EARLY(PCI_VENDOR_ID_QCOM, 0x1107,
+			       quirk_wcn7850_disable_ltr);
+
 /*
  * Root port on some Cavium CN8xxx chips do not successfully complete a bus
  * reset when used with certain child devices.  After the reset, config

---
base-commit: 7be4bc52fd9e0e55dc9a2e0232b89427d2c4b614
change-id: 20261023-quick-wcn7850-a792968cc25f

Best regards,
--  
Anthony Ruhier <aruhier@mailbox.org>


