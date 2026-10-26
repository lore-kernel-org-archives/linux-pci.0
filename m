Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793014724;
	b=2qX2Xn172PX5nQcELqoVeZ4Z2bbykh2tpamBdMCfiKw3Tkd5PAD1v7kQSTX+3UxCua6N
	 bnxeTut98cTywJXDFpyrexI3KNav5JKPsLDqnSBwVSLgmmw429MpetmdnrcUVLCPQKdJx
	 EPwdyJMHo1dFMeylgsAX17Krb95HiqixHp4Bg6clJyXBKu1pqdtf+vAGIGKJTdAgqcQRZ
	 oplqcDEG1Bt1drVdHnSv1dB0FOeIeWnT+YLZKXy9QKK12tnzAue9vPHBgESBGDRnIXwjy
	 S/YtMKPA1HBSh2g5chyWLwovYMub2E/0F/4sNYsHPJSw5DzFYBPrtYIbtWqJb03GenA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793014724;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer;
	bh=rmWzCzfSpt1rDCtVaLDN9FMHes3sH28/Mle8yGwChlY=;
	b=04T34LHttAkSfPG1gxnHEbNvECVahBt47h95Dj71Ef4eJ9dHT3P5g0wrcbRuNaX+7Ipb
	 BPJincVEmnTpnBZxkQ1C0TG7Ow/D5I/7OVTfA+0HySxifhlYiZZUuL95SJN4LwutFN0jx
	 OEzqYQM5VHbtE9XIfvor/P74FvNpO/iSXLExh2Q2/Q1dw6Gxe1li8qkw/RB9zLiEdudbL
	 wZ539Bhz7lXQiXIsLMgtj0StdH7wtTMDpQfgN+GiEdXaWWk/fWMcedbRUjha3hTgFr0JO
	 x6apdXFngtnhQoCHDs7ZfWzmx/XVg8+YDu6Z4USJJEgomzQOhG1vHIcMcbOACxPjctQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=imd-tec.com;
	spf=pass smtp.mailfrom=imd-tec.com;
	dkim=pass header.d=imd-tec.com header.i=@imd-tec.com header.a=rsa-sha256 header.s=google header.b="N+/aFAtt";
	arc=none smtp.remote-ip=209.85.221.52
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A300606A325
	for <linux-pci@vger.kernel.org>; Mon, 26 Oct 2026 11:38:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2A300606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=imd-tec.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=imd-tec.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=imd-tec.com header.i=@imd-tec.com header.a=rsa-sha256 header.s=google header.b=N+/aFAtt
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-48afcd7ba9bso1618848f8f.3
        for <linux-pci@vger.kernel.org>; Mon, 26 Oct 2026 04:38:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=imd-tec.com; s=google; t=1793014722; x=1793619522; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=rmWzCzfSpt1rDCtVaLDN9FMHes3sH28/Mle8yGwChlY=;
        b=N+/aFAttA7wTxM0/7LDeAzXgMIzcPEMVDQ7jPp7ixWrZDgJlJYT1Qhb2CUQSDuEZv8
         Z7tjPRXeq9kmXmL2mQwtAqFotnrpYWH/hXktftDr7u1b+VAbjt+ZFw9PlOyi600cfkNB
         9twYYrZi99rcUTsg5p07Z5cpv2idOP5looPy9Zesok2XZ2JR6Ysr/C4faeaZFkmXZCxw
         tmkrFu05bYotW/Mk/xoOJ83I5QqSVBhovvemo4jRv8HJfY2bN0Rz0dEdKTyd6NgHTrdV
         fxYjrhPMJ7blXzncrjaf89sB989y1ya/HATIn8yaGCV5hZjENniIgAo9vbauslHNWPvA
         tyUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793014722; x=1793619522;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=rmWzCzfSpt1rDCtVaLDN9FMHes3sH28/Mle8yGwChlY=;
        b=U9xdnaLDDUnh7OvOcUGyfc+DKjWNiQPVxQwzfx4ny7Ki3O3l4Pqx1DXdH6tbXPnvXU
         i6EsyJxAa1TakSiluSJjGUy+45aH8kZ3beww95dupuNl1IUPG+/3NJSHrTF3f//rH7u0
         S/vEVu/gH99F+2agAeiQjm81AlpCnmBz2rqKOqq95x9xviB2K6EZb2naoUqehHvvz4n3
         nO/Y8cFjwmMpN4n7ppI7ikmgHFM6mv3MgGbhUoUWoSuG+tdrE/2LftgZtARkc32dZXiP
         ohUZtwR6e9vfIKrR91T1OdkpgdmV0YUWDFa5FBNsnlyItR5QJzTsJdZ9XaZJbcpLnBXN
         3pKQ==
X-Gm-Message-State: AFq9FYLK0shLAWJffLPoGAXbnKwjbjCMKaHRfuO6a/T4gPx6ntipRNhi
	n7EBLCYVAFqc+7XGDzd5xkCib5jQ6VNZpMJBg/j28joR+UrvoNcaAz29JoRI4oVm04TIeHYWErN
	CttioqW8YyQ==
X-Gm-Gg: AYBFou1WmbfPeAUgZcrt6g1GjSNqkI5lCD0wOgpA/1Rstdp0IFjYbLwFmQfp+SFBwW4
	zrUHQcgQbFURqMT94MkOgXQFmrNL+Qiq+7fy+3NQXGha17B8jtVylY8ydMYZQShIY/DAZQvM4Fc
	0ji3MfBKtWXNemENcVDkU37d7+roM6zxgsLFEV7uY71i4Yqp2TMYlmRC7o8COcdanDBlgABzWaH
	6YlM2PgutBXeRRt5Hk9ihuCixBsFwWah6Klo82bN/t+wKMeSPHcDJ9knBB+qTzkDoFlLMp/og0r
	bbCn1GsEnglWHgXKkkAEgMQsmhfuEL0J29s1gRyDst86BoZuFnX6TTfL37/GlnfwKCgq8UWCOTu
	ngcHEkQtXWkNQ6nlH3Mujx5AVD+E1yFYGlpNMYpKe5AUWvgqtvTMeLJrf7jobXqvf5g9opFjItG
	gW3ouw9zOXVoOu24pVFnN4CwK6IopP7b4temLFRYHorf9gdBNEbvcDYjktHejZDRpFco3GxqJI1
	h5FXY6PyuQtVHCMDl8T2k1VeNkSNpe2/oinG2Daxvg0RE4cmLnP1zLEqHi+45v0FtmuLdkR1Sy5
	Kb56PCBqG4lo0oJpuE7KxaSuBPU6tgwgYg43sgjrzI9Er9s1j+567WFAvVUkP/zrdrtUHbDAb+J
	SK0E=
X-Received: by 2002:a05:600c:3acb:b0:4a1:992f:d0e7 with SMTP id 5b1f17b1804b1-4a35aca4fe1mr116576345e9.16.1793014722474;
        Mon, 26 Oct 2026 04:38:42 -0700 (PDT)
Received: from [127.0.1.1] ([82.71.135.85])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a35a04ad39sm503355405e9.1.2026.10.26.04.38.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2026 04:38:42 -0700 (PDT)
From: William Bright <william.bright@imd-tec.com>
Date: Mon, 26 Oct 2026 11:38:38 +0000
Subject: [PATCH] power: sequencing: pcie-m2: Drive the Key E SDIO_RESET#
 signal
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
Message-Id: <20261026-pwrseq-pcie-m2-sdio-reset-v1-1-02ecdafce518@imd-tec.com>
X-B4-Tracking: v=1; b=H4sIAL0732oC/yXMyw6CMBCF4Vchs3YS2iBBX8W4qO1Bh0SoM3hJC
 O9ulcVZfIvzL2RQgdGxWkjxEpNpLHC7iuItjFewpGLytW9dGee3Gh6co4Dvni3JxArDzLXbNwc
 fuqYNico/K3r5/Nun82Z7XgbE+Rekdf0Cc7Zl1X0AAAA=
X-Change-ID: 20261026-pwrseq-pcie-m2-sdio-reset-015492a846ad
To: Manivannan Sadhasivam <mani@kernel.org>, 
 Bartosz Golaszewski <brgl@kernel.org>
Cc: linux-pci@vger.kernel.org, linux-pm@vger.kernel.org, 
 linux-kernel@vger.kernel.org, William Bright <william.bright@imd-tec.com>
X-Mailer: b4 0.15.2

The pcie-m2-e-connector binding describes sdio-reset-gpios, but the
driver never requested it, so the line was left to pinctrl or to its
reset state.

Request it asserted, like W_DISABLE1# and W_DISABLE2#, deassert it once
the connector supplies are enabled and assert it again before they are
disabled. The card is then held in reset through power-up, and the
line is never driven high into an unpowered card.

Signed-off-by: William Bright <william.bright@imd-tec.com>
---
The pcie-m2-e-connector binding describes sdio-reset-gpios, but the
driver never requested it. This holds the card in SDIO reset until the
connector supplies are enabled, and asserts it again before they are
disabled, matching how W_DISABLE1# and W_DISABLE2# are handled.
---
 drivers/power/sequencing/pwrseq-pcie-m2.c | 20 +++++++++++++++++++-
 1 file changed, 19 insertions(+), 1 deletion(-)

diff --git a/drivers/power/sequencing/pwrseq-pcie-m2.c b/drivers/power/sequencing/pwrseq-pcie-m2.c
index cafa642a4b6b..5f5a116063da 100644
--- a/drivers/power/sequencing/pwrseq-pcie-m2.c
+++ b/drivers/power/sequencing/pwrseq-pcie-m2.c
@@ -39,6 +39,7 @@ struct pwrseq_pcie_m2_ctx {
 	struct notifier_block nb;
 	struct gpio_desc *w_disable1_gpio;
 	struct gpio_desc *w_disable2_gpio;
+	struct gpio_desc *sdio_reset_gpio;
 	struct device *dev;
 	struct list_head pci_devices;
 	struct mutex list_lock;
@@ -47,13 +48,23 @@ struct pwrseq_pcie_m2_ctx {
 static int pwrseq_pcie_m2_vregs_enable(struct pwrseq_device *pwrseq)
 {
 	struct pwrseq_pcie_m2_ctx *ctx = pwrseq_device_get_drvdata(pwrseq);
+	int ret;
+
+	ret = regulator_bulk_enable(ctx->num_vregs, ctx->regs);
+	if (ret)
+		return ret;
 
-	return regulator_bulk_enable(ctx->num_vregs, ctx->regs);
+	return gpiod_set_value_cansleep(ctx->sdio_reset_gpio, 0);
 }
 
 static int pwrseq_pcie_m2_vregs_disable(struct pwrseq_device *pwrseq)
 {
 	struct pwrseq_pcie_m2_ctx *ctx = pwrseq_device_get_drvdata(pwrseq);
+	int ret;
+
+	ret = gpiod_set_value_cansleep(ctx->sdio_reset_gpio, 1);
+	if (ret)
+		return ret;
 
 	return regulator_bulk_disable(ctx->num_vregs, ctx->regs);
 }
@@ -562,6 +573,13 @@ static int pwrseq_pcie_m2_probe(struct platform_device *pdev)
 		goto err_free_regulators;
 	}
 
+	ctx->sdio_reset_gpio = devm_gpiod_get_optional(dev, "sdio-reset", GPIOD_OUT_HIGH);
+	if (IS_ERR(ctx->sdio_reset_gpio)) {
+		ret = dev_err_probe(dev, PTR_ERR(ctx->sdio_reset_gpio),
+				     "Failed to get the SDIO_RESET# GPIO\n");
+		goto err_free_regulators;
+	}
+
 	config.parent = dev;
 	config.owner = THIS_MODULE;
 	config.drvdata = ctx;

---
base-commit: 1a0586064ee1fbcefe49b6382ee17a236c590879
change-id: 20261026-pwrseq-pcie-m2-sdio-reset-015492a846ad

Best regards,
--  
William Bright <william.bright@imd-tec.com>

