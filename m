Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB6A63BF694;
	Wed, 22 Apr 2026 11:25:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776857112; cv=none; b=KRYi2DOQMftbX5Wo+WCy4lng40j4anXWztUKybpt37suPF9vOMtjbJDCADtuv7tpFSCIHASg3a4qqESWBocJp7p5bTsD6uxLg9f+bK34pkOHg26KjD6QGC9UMqwFgLH4LaE/Gu0OkrMr9vny0ReB08B0CUbCXW1WK5lyLsvU1PU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776857112; c=relaxed/simple;
	bh=zG3I57WWplMJcf/hk5ar7t1I+jzieYtwUyZKV6LKybs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=STqquz9zpNljHfwF7GUOn/lJgHrHoae9wDm/VTntzWF7lHXa74DhLKXsBYpE3GKsA9L84B6h6gq3RMN/QnYNhRykrELIpxlv+6m9jSu/n2f3QB+gATUl0nZn0p+uTRAVgsy/7QKRtynB18L1Gfo2eWMi+R35ZgGldl8aobfqrX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PqeJP+Bq; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PqeJP+Bq"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 84DDEC2BCB4;
	Wed, 22 Apr 2026 11:25:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776857112;
	bh=zG3I57WWplMJcf/hk5ar7t1I+jzieYtwUyZKV6LKybs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=PqeJP+BqAQNRVQ5d8J+yX9lmRAYBOZbzLhf3hOWPfj+bO9AVKYYEXiPKV3EdCL3j8
	 1WFnLPWWoDTPYJrcTyCbM+k9iYsAAzOBiCyVd9t+HHdyBUVXJXN9eHmOuMmtsRTLIP
	 suszwhALSNVKiK9HR3+4zydyaWaAIOIq3OScqwCB4THzRpNdGZ0jhcfi+m8ngAcgTJ
	 +59kJIneqwZPXn3wtFzvzWEK2UlXJ+8zPEzk/hGoZh1Z6KEH4SnEXufK35jtB2iTas
	 Ha7ZGLV9fOCo80LLw8QovqG3v/NCGG6+PcMiUxpJmwZr+f2/eK/nHbOLCsN8V53CHX
	 PH2ncJQMbXA9Q==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76381F5A8DD;
	Wed, 22 Apr 2026 11:25:12 +0000 (UTC)
From: Manivannan Sadhasivam via B4 Relay <devnull+manivannan.sadhasivam.oss.qualcomm.com@kernel.org>
Date: Wed, 22 Apr 2026 16:54:43 +0530
Subject: [PATCH 02/12] power: sequencing: pcie-m2: Add support for
 'is_fixed()' callback to 'uart' target
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260422-pwrseq-m2-bt-v1-2-720d02545a64@oss.qualcomm.com>
References: <20260422-pwrseq-m2-bt-v1-0-720d02545a64@oss.qualcomm.com>
In-Reply-To: <20260422-pwrseq-m2-bt-v1-0-720d02545a64@oss.qualcomm.com>
To: Bartosz Golaszewski <brgl@kernel.org>, 
 Manivannan Sadhasivam <mani@kernel.org>, 
 Marcel Holtmann <marcel@holtmann.org>, 
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>, 
 Shuai Zhang <quic_shuaz@quicinc.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-pci@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
 linux-bluetooth@vger.kernel.org, Wei Deng <wei.deng@oss.qualcomm.com>, 
 Luiz Augusto von Dentz <luiz.von.dentz@intel.com>, 
 Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
X-Mailer: b4 0.15.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1269;
 i=manivannan.sadhasivam@oss.qualcomm.com; h=from:subject:message-id;
 bh=KrtcCm7OcSv08XpTnM/lQ/uL0Jkw1/hkwY8pIBjRoGw=;
 b=owEBbQGS/pANAwAKAVWfEeb+kc71AcsmYgBp6LAUHpCgMluCaUwOrCltzrJ6ja/gcCe4jKxCe
 rrgJaYjXUOJATMEAAEKAB0WIQRnpUMqgUjL2KRYJ5dVnxHm/pHO9QUCaeiwFAAKCRBVnxHm/pHO
 9Q1fB/9YdhK57pITNVRy/bWS9zw1nLMkSCIl1c9LaHMyPWQl+jBVvrhgMJvyuGZVFrDFUdXjoDj
 mjyPROGFEv9J2oYrtv/9RRz96bujgr7l55UtBwkc3AykDGQEYw8c0wWVUrnhpDD9DhzwZxrYJlH
 UpNIj1l/cU8a7xyUzg1kn5IPEIPe8SnGxNPMz1uRIs853ozxAq885PAMZ82uxJSFVsiKiEVwMJQ
 gpR8Vbl1ep2SwszXzShwqEgqcK1QeRrOFgk0pZeVFnrmgzevKnn7RlAqOLEiet30EUiJ98f47O8
 Oir94HPSNehL9jijUIksuWgaYhLOLF5X1qHe3w0y9X7Rvlr4
X-Developer-Key: i=manivannan.sadhasivam@oss.qualcomm.com; a=openpgp;
 fpr=C668AEC3C3188E4C611465E7488550E901166008
X-Endpoint-Received: by B4 Relay for
 manivannan.sadhasivam@oss.qualcomm.com/default with auth_id=461
X-Original-From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
Reply-To: manivannan.sadhasivam@oss.qualcomm.com

From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>

Add support for 'is_fixed()' callback to tell the consumers whether this
power sequencer target 'uart' is fixed or controllable. This is decided
based on the availability of the 'W_DISABLE2#' GPIO in DT.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
---
 drivers/power/sequencing/pwrseq-pcie-m2.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/power/sequencing/pwrseq-pcie-m2.c b/drivers/power/sequencing/pwrseq-pcie-m2.c
index ef69ae268059..2b79f2e34079 100644
--- a/drivers/power/sequencing/pwrseq-pcie-m2.c
+++ b/drivers/power/sequencing/pwrseq-pcie-m2.c
@@ -121,10 +121,18 @@ static int pwrseq_pcie_m2_e_pwup_delay(struct pwrseq_device *pwrseq)
 	return 0;
 }
 
+static bool pwrseq_pcie_m2_e_uart_is_fixed(struct pwrseq_device *pwrseq)
+{
+	struct pwrseq_pcie_m2_ctx *ctx = pwrseq_device_get_drvdata(pwrseq);
+
+	return !ctx->w_disable2_gpio;
+}
+
 static const struct pwrseq_target_data pwrseq_pcie_m2_e_uart_target_data = {
 	.name = "uart",
 	.unit = &pwrseq_pcie_m2_e_uart_unit_data,
 	.post_enable = pwrseq_pcie_m2_e_pwup_delay,
+	.is_fixed = pwrseq_pcie_m2_e_uart_is_fixed,
 };
 
 static const struct pwrseq_target_data pwrseq_pcie_m2_e_pcie_target_data = {

-- 
2.51.0


