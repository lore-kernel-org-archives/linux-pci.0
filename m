Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.251.105.195
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793836144;
	b=GANPIEz5amt3pk0WJAFrye+QQ/67B01gDqqikWPl3zI5rO3WJXdAf81q3B5Q0v/rNsDi
	 nycHyPc5GENY8Zf2OFP5sB0v/7i4TRPD/13wbYbk1qT9g/rXGL9keRp81G+NpuKHTholf
	 cHelcgV7mZtocQmHiOqWBqzaNLyDSp+Izb0OclNtkpDOtGN3C/jxNuS52lSEVEaP01nAQ
	 1j8c2cnenMoyGuCpmN0UFOJMBhkltMUejnt2n2gmKmWwlUHV/s8rlR/qP+3IXHL9iidH/
	 lGHNl0NuP14OwsYiN7IB5Wbkz3II8eOFqY2Oaz7kfiLn5ubU93kR2tH0yMSn5VS7C7Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793836144;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
	 X-Developer-Key;
	bh=y70xh6Dm7wUw47WQ5EyKcGy1qtu5xknyvmKhrddb0cQ=;
	b=QjzCBoarqMl9VQ1L6RRGDdTzPMYSXDLrrDOVzanT0xHnUjG0IhAnG4gIRK4lsCWKr14n
	 3+GQjPAFRqM5poKo6ql9jOrqMD/nvZf/1c6RKB98ZmsnpwBRoj6g/Kfil+4/00UqcTIWB
	 MemQrZ98WF7ARbEBgxqJnJIRtvx8GgsOD4a6b4v62uOOQR1BwqrnK2dZz5fMR8rZv8T8a
	 V1chbw8C3KRJLMDMezkey68Frk/TXEgOhC9+RWpBgKOgzeZcAWKMstjOfrqklfx1InlzH
	 IEyFAWCRDuwNZjaAz68f45nXShNWicYhyqV1kbnm66eP5vzcrjOJKXMQVldiPUZDJ1w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=collabora.com;
	spf=pass smtp.mailfrom=collabora.com;
	dkim=pass header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=mail header.b=nr8st++T;
	arc=none smtp.remote-ip=148.251.105.195
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 940D9606D802;
	Wed,  4 Nov 2026 23:49:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 940D9606D802
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=mail header.b=nr8st++T
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1793836139;
	bh=LYbxaxyZ5Tcz6Rw2Y/EPOS/4B9CTHK9PDNSNUfs1tbk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=nr8st++TE6fMfn2xUniMFXm/Ev2ztgzgFOCq8GuIQCbkN0u2CzUGJ6MDywb6xkrUn
	 WZ7u6Rvft2UPxIVIIBzr3jVDOHdVhMNYd75MunHYGQPrgQ/rh5A5aL2ro/ED25BhCQ
	 65eJGVPX2bCGPBemvE8qRIE8RJ/IhdHwCwv/7vCTZWQIek/Ox4wvZW+jt5FQlm8u0P
	 5N3w6lIZCyNhOM0HwCWfV0kA5v9bwZX2vz1Z6YPud9Mpm2/Su7CPOTvR4OdRDG5mtz
	 bPTlmwnM3bnN21vCX4QZoX9Hug/biQB+jgY38LW0DmJ9G/RxiQS06aptukKIBkyi0n
	 cSlGysAOOJIjg==
Received: from jupiter.universe (unknown [100.64.1.62])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	(Authenticated sender: sre)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 811B517E0D69;
	Thu, 05 Nov 2026 00:48:59 +0100 (CET)
Received: by jupiter.universe (Postfix, from userid 1000)
	id E8A9648003A; Thu, 05 Nov 2026 00:48:58 +0100 (CET)
From: Sebastian Reichel <sebastian.reichel@collabora.com>
Date: Thu, 05 Nov 2026 00:47:08 +0100
Subject: [PATCH v8 7/9] PCI: dw-rockchip: Add pme_turn_off support
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
Message-Id: <20261105-rockchip-pcie-system-suspend-v8-7-0434b4f373bc@collabora.com>
References: <20261105-rockchip-pcie-system-suspend-v8-0-0434b4f373bc@collabora.com>
In-Reply-To: <20261105-rockchip-pcie-system-suspend-v8-0-0434b4f373bc@collabora.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3089;
 i=sebastian.reichel@collabora.com; h=from:subject:message-id;
 bh=LYbxaxyZ5Tcz6Rw2Y/EPOS/4B9CTHK9PDNSNUfs1tbk=;
 b=owJ4nAFtApL9kA0DAAoB2O7X88g7+poByyZiAGrrxGpSLd/MhFImW6B1IFBahdG3jwPzVVzqG
 73EUhmfJJ0ZMIkCMwQAAQoAHRYhBO9mDQdGP4tyanlUE9ju1/PIO/qaBQJq68RqAAoJENju1/PI
 O/qaflkQAJxZLiVP8p8Of0HbmN00pkuJvGUR1n961C4rA+6/zER0DD9ntOXx1zelUF9M+LZy0Lz
 2WCKd+PC0YSjW4dIaQO3YxeMkaGnHrBqOKwh28scfhkiig4J2sUh81lfkaAnhkTSFN6gYnWJJEN
 Pk0Ulw+I/b7wOym1O0hre+tbYywRDd8vfeBGG19nvZyyEsCpnk7QgC0tT3I7lzGzRNqu3z38xm4
 XvWbq9+iSRzPUIeLMrNNCazhWyUcWXIAoJV9pCBlJFGa7Fs9WvM9VpX4CbXaRJ0HC3TINaOjr+n
 UPuzowvfaLFDZHLyPqoBfRqI4Oqt5xM/GYiLy3Vj2Rv5ASWvKO2VqVLyh3nO69hgRiZ3Tk24JdP
 qaqt0WP7D6HuLwzBwS20jGYFdHdNXPYQGXNKjs4gXIvoeIUkN7oWaWdW7rN6ewizW9QSm1qyBg5
 kxmySoXEMjTMIzJrJu8XSQ+/yqhHcZIQkCx0iAqCYzUvhNteG4LAl2ZHYUXNhlBYN6qvJyxyY8u
 hgz95ZVWm0L6ZMBF0bFbD6rUrE0By2j60f3t+d5/JWq9mldhuCLdsiGADaXrBTm7kjNGTq6WY68
 Ue4NHVzBW+L0cQsFlcosA2q2C/l/h3DCHlMWv8QjEVQEAtTKjqrMu4PX5RAR4q/bmAAMBDIIeAO
 lbuZlJh0ZH3kdLD6o1gwtJg==
X-Developer-Key: i=sebastian.reichel@collabora.com; a=openpgp;
 fpr=EF660D07463F8B726A795413D8EED7F3C83BFA9A

Prepare Rockchip PCIe controller for system suspend support by
adding the PME turn off operation.

Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
---
 drivers/pci/controller/dwc/pcie-dw-rockchip.c | 47 +++++++++++++++++++++++++++
 1 file changed, 47 insertions(+)

diff --git a/drivers/pci/controller/dwc/pcie-dw-rockchip.c b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
index 0e26abc50920..7933c50df340 100644
--- a/drivers/pci/controller/dwc/pcie-dw-rockchip.c
+++ b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
@@ -47,6 +47,10 @@
 #define  PCIE_CLIENT_ENABLE_LTSSM	FIELD_PREP_WM16(BIT(2), 1)
 #define  PCIE_CLIENT_DISABLE_LTSSM	FIELD_PREP_WM16(BIT(2), 0)
 
+/* Interrupt Status Register for Received Messages */
+#define PCIE_CLIENT_INTR_STATUS_MSG_RX	0x04
+#define  PME_TO_ACK			BIT(9)
+
 /* Interrupt Status Register Related to Legacy Interrupt */
 #define PCIE_CLIENT_INTR_STATUS_LEGACY	0x8
 
@@ -71,6 +75,11 @@
 #define  PCIE_CLKREQ_READY		FIELD_PREP_WM16(BIT(0), 1)
 #define  PCIE_CLKREQ_NOT_READY		FIELD_PREP_WM16(BIT(0), 0)
 #define  PCIE_CLKREQ_PULL_DOWN		FIELD_PREP_WM16(GENMASK(13, 12), 1)
+#define  PME_READY_ENTER_L23		BIT(3)
+
+/* Message Request Register */
+#define PCIE_CLIENT_MSG_GEN		0x34
+#define  PME_TURN_OFF			FIELD_PREP_WM16(BIT(4), 1)
 
 /* RASDES TBA information */
 #define PCIE_CLIENT_CDM_RASDES_TBA_INFO_CMN	0x154
@@ -439,8 +448,46 @@ static int rockchip_pcie_host_init(struct dw_pcie_rp *pp)
 	return 0;
 }
 
+static void rockchip_pcie_pme_turn_off(struct dw_pcie_rp *pp)
+{
+	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
+	struct rockchip_pcie *rockchip = to_rockchip_pcie(pci);
+	struct device *dev = rockchip->pci.dev;
+	u32 status;
+	int ret;
+
+	/* 1. Broadcast PME_Turn_Off Message, bit 4 self-clear once done */
+	rockchip_pcie_writel_apb(rockchip, PME_TURN_OFF, PCIE_CLIENT_MSG_GEN);
+	ret = readl_poll_timeout(rockchip->apb_base + PCIE_CLIENT_MSG_GEN,
+				 status, !(status & BIT(4)), PCIE_PME_TO_L2_TIMEOUT_US / 10,
+				 PCIE_PME_TO_L2_TIMEOUT_US);
+	if (ret) {
+		dev_warn(dev, "Failed to send PME_Turn_Off\n");
+		return;
+	}
+
+	/* 2. Wait for PME_TO_Ack, bit 9 will be set once received */
+	ret = readl_poll_timeout(rockchip->apb_base + PCIE_CLIENT_INTR_STATUS_MSG_RX,
+				 status, status & BIT(9), PCIE_PME_TO_L2_TIMEOUT_US / 10,
+				 PCIE_PME_TO_L2_TIMEOUT_US);
+	if (ret) {
+		dev_warn(dev, "Failed to receive PME_TO_Ack\n");
+		return;
+	}
+
+	/* 3. Clear PME_TO_Ack and Wait for ready to enter L23 message */
+	rockchip_pcie_writel_apb(rockchip, PME_TO_ACK, PCIE_CLIENT_INTR_STATUS_MSG_RX);
+	ret = readl_poll_timeout(rockchip->apb_base + PCIE_CLIENT_POWER_CON,
+				 status, status & PME_READY_ENTER_L23,
+				 PCIE_PME_TO_L2_TIMEOUT_US / 10,
+				 PCIE_PME_TO_L2_TIMEOUT_US);
+	if (ret)
+		dev_err(dev, "Failed to get ready to enter L23 message\n");
+}
+
 static const struct dw_pcie_host_ops rockchip_pcie_host_ops = {
 	.init = rockchip_pcie_host_init,
+	.pme_turn_off = rockchip_pcie_pme_turn_off,
 };
 
 /*

-- 
2.53.0

