Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18D493D1CB0
	for <linux-pci@vger.kernel.org>; Thu, 21 May 2026 12:57:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779368227; cv=none; b=m5XFpNlP6EY4NMlSh6DeUESpUUPpGObAR//XoyhfgRqgSXuA0qJFq+kA30byPVxEOIiv1J+z46TaPyx3mGGMQzSZreSRORe405Wvr68+PnRnhUcLrAEiSxFl//zff4Heu7tj1P/QrI9khnYbgi5fRjgMp6/to7Y3/9IaOnt8uc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779368227; c=relaxed/simple;
	bh=wmvKp9NRJ4GvSqBTeqBv04c7mvtTpO9keDXQfKRmU+0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KgVcUkcGgYF1bktIMXmpEOiLalVZMQwBAAlyDy1lYwT0rKlSM9y4Kot1+1Pw0Lv67csvjliUJw1iliI/sAMcwz9PZRcmFzBB3uFyk9Wnz7KvG1r6+tIczXjxMIewVn4zM6FP9nkRdBKK+rvflz5eKXQreg5O7zx3nNlotEvi2OQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=hcXwfnik; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=gSceX91l; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="hcXwfnik";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="gSceX91l"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64L99oTE3343551
	for <linux-pci@vger.kernel.org>; Thu, 21 May 2026 12:57:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	xSZqspbgJj2wWqFY7lxfq9p3U8n82NjVy/UhrKbC7e0=; b=hcXwfnikVkwwZWP3
	LwYdjKBaLM2rOYgIVywl4i+Hp+jUMGbQBWpcvRMkANwpLlSOxyFwRRnc/0pr3drx
	IfUV95/zJwvm99t/WA4Mb5No80/GDWM1X2BFXYWtZuVziaup2/qhoyfyuMAfQbRh
	XGwtDLjUFW66aGnPQfUgmBo22qIsDS2HFOUsbr3DCHUVhIS8hiwy2v293b0n1dle
	VV/+TQ9ql5dKD+Wqe6Y+VyEhp4aEzVlXK3hJfhmFzDxQf4B3sn9TQJJYQusoMkKy
	yJ6HwaB/gvUls/RcChQY52Z5q2oCh/9eYoPkvq60LR3FjCARHqk8lZc2MfnkaEY+
	mJFBXQ==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e9wahscdh-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Thu, 21 May 2026 12:57:05 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-36781927b4dso7513445a91.0
        for <linux-pci@vger.kernel.org>; Thu, 21 May 2026 05:57:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1779368224; x=1779973024; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xSZqspbgJj2wWqFY7lxfq9p3U8n82NjVy/UhrKbC7e0=;
        b=gSceX91lfbn61nm/3oPbv2Yg65gxLOuJ5EdQFP9ZiBxCiADyUyMbrdWVctTFbEUG+i
         Kn5LZmGwNrntlsBtVAKTaecQnKnRqvoDkTmQBXUeWPT7Z1zl6J7hIsaZBSb4mJOBzeah
         M8+aO8pupso92HysOlEQ7Azv3Od0aXUzBuozE3iIH/VBQI5BOE/NvVi55ACxEnUzWkJB
         b3ri9REmZ4nZsVCEK6/fTPfkDAeb1lF0FfxPtofk+PuGqnBGVZgOP0idetInXToA/Mmt
         uh9w3Nz5fpY4LrXwE4HjJ0YwdDLn3C+PiqoyTVt2fDfQ3abd6AoKJy2qW6wK9+gDn8td
         gJjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779368224; x=1779973024;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=xSZqspbgJj2wWqFY7lxfq9p3U8n82NjVy/UhrKbC7e0=;
        b=Ysn+tk8EplragPZpt2YXsFzrAliW8Kzgy7PxMTtuzi6eQ0MorYlhIm3hnRtfdeH56F
         oO8p3mXhYZfP894kOjfK34UoAdJgshKiDctMoEJlBGWKuoP6cjAruX1WjwN3NpI1R5WQ
         h82GhH8aAvaBLMBl2GUWhBL2ZZP3N+ePwq3c0QsqKDLN5brGyyR6dQ17k19YOHKu5kHg
         LnhsgjmmtbUUe0wH4euL90VF74/WmOwtj3d69tG+CF16M6z6hyt4oI0BzXwqoq56UpXM
         bE18zhZFBjzuAUHncWy3rx13SngBN95P+AJeF5kxN51i8IdOaoloCECUbWUPhe+mH4Q9
         IF0g==
X-Forwarded-Encrypted: i=1; AFNElJ8VXoWSHVgKM+WCuOr3SYLLWMTD3HsXXTwY+Uq2IP536NFsb4jU+G8pwVJd7OGWjCwz/sq2u7egdEk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6cyAA8DtQeUVBxuKZXhSLoexjCD5vWhGTMOGJbndKz3t9QN6c
	u/k2CeqNEHJN9wk/PZkkFmaNIJjO5RyIJe4sqtmNIEU8WaqfNbSOeK9+3IJCw+dsS1AFk5ICv3d
	iF8ThiEDeO1j4flCCuegRZOoHiDrDZo+/j2r2DXeo/9Tl1rBeIgRmcNd/eTq5zcw=
X-Gm-Gg: Acq92OFtOoaHXCvyeo+Is//A/iHLW/BkOpVluDnFRO8xX2dvFPT13C6aTuSdxtvL5WA
	/CtbKBYouFrduKJGjMjRYUJnt5DswTIwRNEx6AALGTOLY7iss9oLDfhor3K/IhfERcneWeYnPi2
	x0eJAypTlpAHGYx/vt8gFlmktky+7pwYVljoQfgnwBPfJQ8wupiP9xBH3M1Sj+8kGJMZuyrWBBt
	4syg2fyH7I2a52VoaVzo5303N3ff3eXBCNMMzWFcqOtLjdEcOBP2UHUn7b6hRGXboHmlOVWY9TN
	9W0Kd/f9pZ6lAqRGmWnJdQOj9leN9GGi8R/UEhA3nDIeqf8kl2zhVPhj+7Dd13bg3Bx3gOtidXc
	niYGqHn9oaE70e1FFO2CQuod178/vFyJA1DW8Oad8CRCbBDTQ2tT+vnFa
X-Received: by 2002:a05:6a20:a11b:b0:3b3:216b:2743 with SMTP id adf61e73a8af0-3b3216b2a24mr341049637.4.1779368223931;
        Thu, 21 May 2026 05:57:03 -0700 (PDT)
X-Received: by 2002:a05:6a20:a11b:b0:3b3:216b:2743 with SMTP id adf61e73a8af0-3b3216b2a24mr341003637.4.1779368223478;
        Thu, 21 May 2026 05:57:03 -0700 (PDT)
Received: from hu-krichai-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c85198f508bsm357984a12.20.2026.05.21.05.56.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 May 2026 05:57:03 -0700 (PDT)
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Date: Thu, 21 May 2026 18:26:33 +0530
Subject: [PATCH v2 1/4] phy: qcom: qmp-pcie: Skip PHY reset if already up
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260521-link_retain-v2-1-08ed448b081c@oss.qualcomm.com>
References: <20260521-link_retain-v2-0-08ed448b081c@oss.qualcomm.com>
In-Reply-To: <20260521-link_retain-v2-0-08ed448b081c@oss.qualcomm.com>
To: Vinod Koul <vkoul@kernel.org>, Neil Armstrong <neil.armstrong@linaro.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Jingoo Han <jingoohan1@gmail.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>,
        Abel Vesa <abel.vesa@oss.qualcomm.com>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Qiang Yu <qiang.yu@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1779368212; l=3603;
 i=krishna.chundru@oss.qualcomm.com; s=20230907; h=from:subject:message-id;
 bh=wmvKp9NRJ4GvSqBTeqBv04c7mvtTpO9keDXQfKRmU+0=;
 b=Lf5uPP6lOdqiH810K/fw8fjljnmWCoHzlhfhROpoten0D8FfUgTOR63Bj90b2vp9nPzDzp4UR
 m+XYTpuKfxdCCpgUM+pbX8d2k+C/lm4qaCbjxROZxZYEJfo23MmH5VE
X-Developer-Key: i=krishna.chundru@oss.qualcomm.com; a=ed25519;
 pk=10CL2pdAKFyzyOHbfSWHCD0X0my7CXxj8gJScmn1FAg=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIxMDEzMCBTYWx0ZWRfX3wEdN+0E5JIz
 QhQIL+JvML6MnM+Jsu1GABcYsJutX4R8GQD2CrQdOxmhOcqnDBTlmCSUdU8Ia7f3y8zyoTIN7rt
 jbh+m0bHrX16Z5qgEbyz/Vm39xbBo8jClQj+arz0a9hASfn6ITFAmVmN9JO2z/uy0vVbs6Kvqf4
 MJMbbw0lfYLN+dOhADNRX8ue9JUkwzYv7tE3RZRO1E0e4y5ZuXNUPIzz1o/omEXaXZxX9qBlsK4
 VhuCJNVYdhibPeF4yY6t5odGH+KR7jcq6iXNBMYvY/qD7cK1kl/0QGV5V0Fh2bKQVatjGk1hVEE
 KXoVGkLoAbROvMnsDC1lbZBxFdIYRQ0rc0LevV/03jxv62HkSkaaEUNWmO+/7FxPyHQvPWo7/uI
 H+V7Xrekc/JmOnLLqgDNdyxMlIrcB1M9y+khvPqlfSz1l5MWtBjrRw9MC6aqc+Hjo6VTFCXEJF0
 aeL69G0+5w2nXZR6sOQ==
X-Proofpoint-ORIG-GUID: fkXS726crwcJW_S5qdA7nCXyZLtcpw8B
X-Proofpoint-GUID: fkXS726crwcJW_S5qdA7nCXyZLtcpw8B
X-Authority-Analysis: v=2.4 cv=H8LrBeYi c=1 sm=1 tr=0 ts=6a0f0121 cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=opHQ60H3MKUy9uz0bH4A:9 a=QEXdDO2ut3YA:10
 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-21_02,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 adultscore=0 suspectscore=0
 lowpriorityscore=0 spamscore=0 impostorscore=0 malwarescore=0 bulkscore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605130000
 definitions=main-2605210130

If the bootloader has already powered up the PCIe PHY, performing a
full reset and waiting for the PHY to come up again adds unnecessary
delay during boot.

Extend the existing skip_init handling by introducing a skip_reset
condition. When skip_init is active and the PHY status indicates that
the PHY is already operational, skip asserting and deasserting the
no-csr reset while still enabling the required resources during
power-on.

This allows reusing the bootloader-initialized PHY state and avoids
redundant PHY reinitialization and PCIe link retraining, which can
add hundred's of milliseconds of delay.

This relies on the assumption that when skip_init is enabled and the
PHY is reported as up, the bootloader has already configured the PHY
correctly and the link is in a usable state.

Reviewed-by: Abel Vesa <abel.vesa@oss.qualcomm.com>
Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Tested-by: Qiang Yu <qiang.yu@oss.qualcomm.com>
Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
---
 drivers/phy/qualcomm/phy-qcom-qmp-pcie.c | 31 +++++++++++++++++++++----------
 1 file changed, 21 insertions(+), 10 deletions(-)

diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c b/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c
index fed2fc9bb311..1458ac1478c7 100644
--- a/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c
+++ b/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c
@@ -4729,6 +4729,7 @@ static int qmp_pcie_init(struct phy *phy)
 	struct qmp_pcie *qmp = phy_get_drvdata(phy);
 	const struct qmp_phy_cfg *cfg = qmp->cfg;
 	void __iomem *pcs = qmp->pcs;
+	bool skip_reset;
 	int ret;
 
 	/*
@@ -4744,6 +4745,9 @@ static int qmp_pcie_init(struct phy *phy)
 		qphy_checkbits(pcs, cfg->regs[QPHY_START_CTRL], SERDES_START | PCS_START) &&
 		qphy_checkbits(pcs, cfg->regs[QPHY_PCS_POWER_DOWN_CONTROL], cfg->pwrdn_ctrl);
 
+	skip_reset = qmp->skip_init && !qphy_checkbits(pcs, cfg->regs[QPHY_PCS_STATUS],
+							    cfg->phy_status);
+
 	if (!qmp->skip_init && !cfg->tbls.serdes_num) {
 		dev_err(qmp->dev, "Init sequence not available\n");
 		return -ENODATA;
@@ -4767,13 +4771,15 @@ static int qmp_pcie_init(struct phy *phy)
 		}
 	}
 
-	ret = reset_control_assert(qmp->nocsr_reset);
-	if (ret) {
-		dev_err(qmp->dev, "no-csr reset assert failed\n");
-		goto err_assert_reset;
-	}
+	if (!skip_reset) {
+		ret = reset_control_assert(qmp->nocsr_reset);
+		if (ret) {
+			dev_err(qmp->dev, "no-csr reset assert failed\n");
+			goto err_assert_reset;
+		}
 
-	usleep_range(200, 300);
+		usleep_range(200, 300);
+	}
 
 	if (!qmp->skip_init) {
 		ret = reset_control_bulk_deassert(cfg->num_resets, qmp->resets);
@@ -4823,8 +4829,11 @@ static int qmp_pcie_power_on(struct phy *phy)
 	void __iomem *pcs = qmp->pcs;
 	void __iomem *status;
 	unsigned int mask, val;
+	bool skip_reset;
 	int ret;
 
+	skip_reset = qmp->skip_init && !qphy_checkbits(pcs, cfg->regs[QPHY_PCS_STATUS],
+							    cfg->phy_status);
 	/*
 	 * Write CSR register for PHY that doesn't support no_csr reset or has not
 	 * been initialized.
@@ -4848,10 +4857,12 @@ static int qmp_pcie_power_on(struct phy *phy)
 	if (ret)
 		return ret;
 
-	ret = reset_control_deassert(qmp->nocsr_reset);
-	if (ret) {
-		dev_err(qmp->dev, "no-csr reset deassert failed\n");
-		goto err_disable_pipe_clk;
+	if (!skip_reset) {
+		ret = reset_control_deassert(qmp->nocsr_reset);
+		if (ret) {
+			dev_err(qmp->dev, "no-csr reset deassert failed\n");
+			goto err_disable_pipe_clk;
+		}
 	}
 
 	if (qmp->skip_init)

-- 
2.34.1

