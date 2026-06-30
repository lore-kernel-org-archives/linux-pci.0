Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA10D46AF2E
	for <linux-pci@vger.kernel.org>; Tue, 30 Jun 2026 19:03:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782846241; cv=none; b=mVvAQaPmcHxkgwFvWH8jJXjZxVaIAVKD4rynI26pCk2dlLiw9ftJCbZkMxlQi2WYMZRAMB7EjxAlEGyvf1fS0L3QB7+LTsAySFmCfDB6rT208BjX/vgcEdCHwaCgNDyiAVnull9vxV2swkI77L1vWYgIUsDc6v9nZNQsuux6V0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782846241; c=relaxed/simple;
	bh=t3qExvvehHne3DGPiTuwj1nj3sEKbHg7NRpHscaXsag=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=g3hojUaTYecsZJdcWiKOYInOoEITrNjcPLDR1ZYjSM+DcTNNKVnhWVf48wp/A4DczOrYzkAe+9SA9jsPlm3dRqgu69qeBMngOW8Pcxjw9DHhkhUeelfXrK12K9bsEsOR1WXJzC4u/7wy3X1Vax5OD4wPllU9itPwBmX4VWdy8hs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=hCyjYy40; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=CICeiZTy; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="hCyjYy40";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="CICeiZTy"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65UItu3S2898093
	for <linux-pci@vger.kernel.org>; Tue, 30 Jun 2026 19:03:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	hoAFJhDFaoYNFe6KuyZHoEL7dGndbuJXxfS0b/1jpj0=; b=hCyjYy40zc/VSfH4
	KaddSYfOljjRIVy41oBDdSDdrQKYC38VeGR4ByBa5tAq+Ju5Ay1IzmMHNlpTTeoP
	6W7uJXIqb7OHwnveefHTOqgHUb913NR7bvFR/0EgXIuviy1f5ufFkSTJ9nqeVr5O
	sdETUcihsnC35xyvmWngYmXQCX8Kjcnid19suCLZYP4DHCB2TjOcCnk2zPrZ2XKe
	rpPKIYYbwuvyWB3OFhdhYIk/jZ+KAQRsYZmucKsg0PKYbSvjlaCI9utuU7DTBUA5
	/25wxMNcNCq3bjoRh1gOSzBSP6vyb9UHKrNVtCMgW7LE5EeoZLFRGf/6s+BbWN0j
	iPvxTg==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com [74.125.82.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f4kgw01t0-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Tue, 30 Jun 2026 19:03:57 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id 5a478bee46e88-30ba395b047so2545617eec.0
        for <linux-pci@vger.kernel.org>; Tue, 30 Jun 2026 12:03:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1782846237; x=1783451037; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hoAFJhDFaoYNFe6KuyZHoEL7dGndbuJXxfS0b/1jpj0=;
        b=CICeiZTyxoc5/qiVeCHi5Dsc1vff1YAFtjxxJFDGgk29woBGylRgVR6ABOtQ+mNEGO
         zgrngVgQXHGABZ5yRPTXBhm/UrHJyjU3Jg40MoTXwCMocVH8LOp7qyWxPxeGg2zRBKbP
         liYDa8vySADCvfNtzG+wx2Kq3ZspgBCGHq7gZNo5hpyHxtpyza1IN/dLA4LG3y91zNwu
         LXfXKrS1EBmkGHwtRoJOlqMzMFPwZft4Y97T0yfLD5zLDIBIpk/s4/YGFTSB00iHHYJV
         jy9Z0KTNzOBK8jpWFxW3vk0yIaFM1ijnZqsJmXqbzBbu48hzd50NE86wRIqTU9aILzGv
         1WmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782846237; x=1783451037;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=hoAFJhDFaoYNFe6KuyZHoEL7dGndbuJXxfS0b/1jpj0=;
        b=OL/IjNAUGhrN3zg7/YsTmfPEH8frbhYapRQCJLlQVqlh+WSFZ1HTacPkNYC65bCv64
         mAdemtE6mRfPyj98O63OHKWl/NDzbSzTALt2nrmfVidOGT8DO1hKA8mJ20vg8cSMjiCn
         3XlADvVYnZsU6KL5M2dTI0raUuMZ8fZX4cp8+a59bsy/+W9U4OzlvdIerdBjsfzt+/S8
         eOhLS2GE2xnr+0bz3XPLfXgjOFGDQHvXJ9vhrJkStm69YPUuC7mDbyB/nO7mhSLAPgfq
         InJDOHd/GwxFwBFAB08xfDS53gHCTuL8DOoS4Gy7s4d9QGRwXPAk3GQImf/p/sVNig0u
         2Pxg==
X-Forwarded-Encrypted: i=1; AHgh+RohrIZxfsZC4cWmVa7Y8arAiFGZSKR2vmqDWKA3Q9ASwzTNkmpf7WEV3dKLguURdc8e4ciBdMueqvE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzyzC+XCtd3T/JqHAnWiAJTXjZ7twMA8SyxtHnEvPC7/6Gr06sJ
	Od01pmBNhu5fzcyamplmsDvY8BXYU+CvcRjxytyUrHg7DdgS0mbbqvlPFzUpKTwuEoM3CkxCYqW
	caNPMnrUuP4mg3vD1weB8xvf4VbeAen1UAILm2UMkmoRc67jH7vEPFfjNT63tw7g=
X-Gm-Gg: AfdE7ck9fJuZh98aUf4uXhbK9UtoBIpLidXXwRZwjdg4K17YSE4p8wE6oeyf/Q6Mg/1
	WlbwXp/rkPVg/GOf7nS9vXxAUUm9C2WORqqFXcJskWDa3gpHYT8nL8bQXtn3RCKLvJpxprC72F/
	qMIL4vPosZyogBJGe/12KTr37swpG0FJUwcyswbgJrE3B7/Iyw/SsnBGfJrm7fG9n3KFfb3rYXy
	7Qw+BJ5GoqQlU5+cznshAbkvCcNKaxc/hm5uQppK8zwTGfgawESosU+QmXva81OwlMluMMQLYMN
	tMGU3FQDwrufZ/PmUrorI+gdHXBvM4ZF1fPmKYGa5zknahsnd98ww/kv0DoqllBvrVf5oW55sVb
	w1URewFF0laHkGWVqQdPt9Js2Isd8eR3JFo7hU5y02/K9OU0=
X-Received: by 2002:a05:7300:dc10:b0:30b:eb75:8a5a with SMTP id 5a478bee46e88-30ef0929c37mr1293384eec.25.1782846236296;
        Tue, 30 Jun 2026 12:03:56 -0700 (PDT)
X-Received: by 2002:a05:7300:dc10:b0:30b:eb75:8a5a with SMTP id 5a478bee46e88-30ef0929c37mr1293352eec.25.1782846235694;
        Tue, 30 Jun 2026 12:03:55 -0700 (PDT)
Received: from hu-sushruts-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30ee317095dsm14963815eec.15.2026.06.30.12.03.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2026 12:03:55 -0700 (PDT)
From: Sushrut Shree Trivedi <sushrut.trivedi@oss.qualcomm.com>
Date: Wed, 01 Jul 2026 00:32:48 +0530
Subject: [PATCH 6/9] PCI/pwrctrl: tc9563: Add API to control endpoint power
 and reset
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260701-shikra-upstream-v1-6-e1a721eb8943@oss.qualcomm.com>
References: <20260701-shikra-upstream-v1-0-e1a721eb8943@oss.qualcomm.com>
In-Reply-To: <20260701-shikra-upstream-v1-0-e1a721eb8943@oss.qualcomm.com>
To: Vinod Koul <vkoul@kernel.org>, Neil Armstrong <neil.armstrong@linaro.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>,
        Bartosz Golaszewski <brgl@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org,
        Sushrut Shree Trivedi <sushrut.trivedi@oss.qualcomm.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1782846191; l=7032;
 i=sushrut.trivedi@oss.qualcomm.com; s=20251127; h=from:subject:message-id;
 bh=t3qExvvehHne3DGPiTuwj1nj3sEKbHg7NRpHscaXsag=;
 b=P3CTnGwYJ+buMH2sHYEhz9nGYIDn5Yv1am9Vm73vD9wBO3z2k0en4IeOHe1HtqpW7+0hfc6Ou
 fe5OHRk9timDAw7nZq4NGYufhQQC+SnoycknfDSOly6itHJiSfQaN7d
X-Developer-Key: i=sushrut.trivedi@oss.qualcomm.com; a=ed25519;
 pk=OrUHTxBaSg1oY3CtCictJ5A4bDMNLRZS1S+QfD9pdjw=
X-Authority-Analysis: v=2.4 cv=Co2PtH4D c=1 sm=1 tr=0 ts=6a44131d cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=EUspDBNiAAAA:8 a=0i6Wl48qgBbC6S7HcagA:9 a=QEXdDO2ut3YA:10
 a=scEy_gLbYbu1JhEsrz4S:22
X-Proofpoint-ORIG-GUID: iKc69226Gg7Z9crn6Xu-b_0YyXMWan7I
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjMwMDE4MyBTYWx0ZWRfX/3nm/8MTXPHa
 VfCVtaagQ4fKEtIB31cLs5ycoakeHrrHyCwsW00JhkRLEWE1XjVHiUkTBckweP8XWdmzq4+98it
 1RwPFxVML8GPuXwrnyjdlIOM+/HArK8=
X-Proofpoint-GUID: iKc69226Gg7Z9crn6Xu-b_0YyXMWan7I
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjMwMDE4MyBTYWx0ZWRfX3cKhVlDfppYJ
 uoWHSHHbDsPlyVRP3o+YxMaFYbsiu898OGTLlCdLtXqsMiwK8eJ2GJmr3ZLEbYidhHILrDRLNlc
 3pUAObuDNEwIr0cgIks+aFSeU9xgKLHq+78RnAZ13LX4taV2SK06PTz0m6q++Cuv2yaDP8+2Yzs
 pqihvpDlCLlEzKYzFnNRVtg4xuYcOhlZWJTk2kP3bf5OFH0uOpv5NHYUZuzR3IuKgxeSMuGZDKj
 tNcLKRMSXgizq5uN2GhElpPGZ4y4gj6W22Gbn80389ksM0LvuGRKf7ICYQgxh1zFCfgD3USYhi/
 nGg7pV2J2RTfXg9kZ+d84zYBp1oGZGSO+l6+OL4+MCBCsUGf+WOMSKCng7A8hbSYbD/VPUQs+Fq
 ilmGT0IGKW18p+OcQsWjip+srCCPw+VJNDNnIvfd5h3QA2IFOuicvyAW5lBuKs/fgkUjrHbyRQ7
 4lSQu7ygekTvw8dX08Q==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-30_04,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 clxscore=1015 bulkscore=0 suspectscore=0 phishscore=0
 spamscore=0 lowpriorityscore=0 adultscore=0 impostorscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606300183

Some platform utilise TC9563 GPIOs to enable power and
control reset of endpoints.

This patch adds support to parse endpoint reset and power enable
gpios from each TC9563 port node in the devicetree. To configure
these GPIO's during the POWER ON sequence, two new API's are
introduced: tc9563_ep_pwr_en() and tc9563_ep_assert_deassert_reset().

Signed-off-by: Sushrut Shree Trivedi <sushrut.trivedi@oss.qualcomm.com>
---
 drivers/pci/pwrctrl/pci-pwrctrl-tc9563.c | 152 ++++++++++++++++++++++++++-----
 1 file changed, 129 insertions(+), 23 deletions(-)

diff --git a/drivers/pci/pwrctrl/pci-pwrctrl-tc9563.c b/drivers/pci/pwrctrl/pci-pwrctrl-tc9563.c
index 1555e8a9b3ca..de68b9836645 100644
--- a/drivers/pci/pwrctrl/pci-pwrctrl-tc9563.c
+++ b/drivers/pci/pwrctrl/pci-pwrctrl-tc9563.c
@@ -62,6 +62,8 @@
 
 #define TC9563_TX_MARGIN_MIN_UA		400000
 
+#define TC9563_GPIO_NONE		(-1)
+
 /*
  * From TC9563 PORSYS rev 0.2, figure 1.1 POR boot sequence
  * wait for 10ms for the internal osc frequency to stabilize.
@@ -91,6 +93,10 @@ struct tc9563_pwrctrl_cfg {
 	u8 nfts[2]; /* GEN1 & GEN2 */
 	bool disable_dfe;
 	bool disable_port;
+
+	int ep_reset_gpio;
+	int ep_pwr_en_gpio;
+
 };
 
 #define TC9563_PWRCTL_MAX_SUPPLY	6
@@ -256,6 +262,89 @@ static int tc9563_pwrctrl_disable_port(struct tc9563_pwrctrl *tc9563,
 					     ARRAY_SIZE(common_pwroff_seq));
 }
 
+static int tc9563_pwrctrl_ep_pwr_en(struct tc9563_pwrctrl *tc9563,
+				    enum tc9563_pwrctrl_ports port,
+				    bool enable, int ep_pwr_en_gpio)
+{
+	u32 ep_pwr_en_gpio_mask, val;
+	int ret;
+
+	if (ep_pwr_en_gpio == TC9563_GPIO_NONE)
+		return 0;
+
+	ep_pwr_en_gpio_mask = BIT(ep_pwr_en_gpio);
+
+	/* Set TC9563 GPIO as output */
+	ret = tc9563_pwrctrl_i2c_read(tc9563->client, TC9563_GPIO_CONFIG,
+				      &val);
+	if (ret)
+		return ret;
+
+	val &= ~ep_pwr_en_gpio_mask;
+
+	ret = tc9563_pwrctrl_i2c_write(tc9563->client, TC9563_GPIO_CONFIG,
+				       val);
+	if (ret)
+		return ret;
+
+	/* Toggle 0->1 to enable power */
+	ret = tc9563_pwrctrl_i2c_read(tc9563->client, TC9563_RESET_GPIO,
+				      &val);
+	if (ret)
+		return ret;
+
+	val = enable ? (val | ep_pwr_en_gpio_mask) : (val & ~ep_pwr_en_gpio_mask);
+
+	return tc9563_pwrctrl_i2c_write(tc9563->client, TC9563_RESET_GPIO, val);
+
+}
+
+static int tc9563_pwrctrl_ep_assert_deassert_reset(struct tc9563_pwrctrl *tc9563,
+						   enum tc9563_pwrctrl_ports port,
+						   bool deassert, int ep_reset_gpio)
+{
+	u32 ep_reset_gpio_mask, val;
+	int ret;
+
+	if (ep_reset_gpio == TC9563_GPIO_NONE) {
+		switch (port) {
+		case TC9563_DSP1:
+			ep_reset_gpio = 0x2;
+			break;
+		case TC9563_DSP2:
+			ep_reset_gpio = 0x3;
+			break;
+		default:
+			return 0;
+		}
+	}
+
+	ep_reset_gpio_mask = BIT(ep_reset_gpio);
+
+	/* Set TC9563 GPIO as output */
+	ret = tc9563_pwrctrl_i2c_read(tc9563->client, TC9563_GPIO_CONFIG,
+				      &val);
+	if (ret)
+		return ret;
+
+	val &= ~ep_reset_gpio_mask;
+
+	ret = tc9563_pwrctrl_i2c_write(tc9563->client, TC9563_GPIO_CONFIG,
+				       val);
+	if (ret)
+		return ret;
+
+	/* Assert-deassert endpoint reset */
+	ret = tc9563_pwrctrl_i2c_read(tc9563->client, TC9563_RESET_GPIO,
+				      &val);
+	if (ret)
+		return ret;
+
+	val = deassert ? (val | ep_reset_gpio_mask) : (val & ~ep_reset_gpio_mask);
+
+	return tc9563_pwrctrl_i2c_write(tc9563->client, TC9563_RESET_GPIO, val);
+}
+
 static int tc9563_pwrctrl_set_l0s_l1_entry_delay(struct tc9563_pwrctrl *tc9563,
 						 enum tc9563_pwrctrl_ports port,
 						 bool is_l1, u32 ns)
@@ -400,28 +489,17 @@ static int tc9563_pwrctrl_set_nfts(struct tc9563_pwrctrl *tc9563,
 					     ARRAY_SIZE(nfts_seq));
 }
 
-static int tc9563_pwrctrl_assert_deassert_reset(struct tc9563_pwrctrl *tc9563,
-						bool deassert)
-{
-	int ret, val;
-
-	ret = tc9563_pwrctrl_i2c_write(tc9563->client, TC9563_GPIO_CONFIG,
-				       TC9563_GPIO_MASK);
-	if (ret)
-		return ret;
-
-	val = deassert ? TC9563_GPIO_DEASSERT_BITS : 0;
-
-	return tc9563_pwrctrl_i2c_write(tc9563->client, TC9563_RESET_GPIO, val);
-}
-
 static int tc9563_pwrctrl_parse_device_dt(struct tc9563_pwrctrl *tc9563,
 					  struct device_node *node,
 					  enum tc9563_pwrctrl_ports port)
 {
 	struct tc9563_pwrctrl_cfg *cfg = &tc9563->cfg[port];
+	struct of_phandle_args args;
 	int ret;
 
+	cfg->ep_reset_gpio = TC9563_GPIO_NONE;
+	cfg->ep_pwr_en_gpio = TC9563_GPIO_NONE;
+
 	/* Disable port if the status of the port is disabled. */
 	if (!of_device_is_available(node)) {
 		cfg->disable_port = true;
@@ -436,6 +514,18 @@ static int tc9563_pwrctrl_parse_device_dt(struct tc9563_pwrctrl *tc9563,
 	if (ret && ret != -EINVAL)
 		return ret;
 
+	ret = of_parse_phandle_with_fixed_args(node, "ep-pwr-en-gpios", 2, 0, &args);
+	if (ret && ret != -ENOENT)
+		return ret;
+	else if (!ret)
+		cfg->ep_pwr_en_gpio = args.args[0];
+
+	ret = of_parse_phandle_with_fixed_args(node, "reset-gpios", 2, 0, &args);
+	if (ret && ret != -ENOENT)
+		return ret;
+	else if (!ret)
+		cfg->ep_reset_gpio = args.args[0];
+
 	ret = of_property_read_u32(node, "toshiba,tx-amplitude-microvolt", &cfg->tx_amp);
 	if (ret && ret != -EINVAL)
 		return ret;
@@ -478,18 +568,28 @@ static int tc9563_pwrctrl_power_on(struct pci_pwrctrl *pwrctrl)
 
 	fsleep(TC9563_OSC_STAB_DELAY_US);
 
-	ret = tc9563_pwrctrl_assert_deassert_reset(tc9563, false);
-	if (ret)
-		goto power_off;
-
 	for (i = 0; i < TC9563_MAX; i++) {
 		cfg = &tc9563->cfg[i];
+
 		ret = tc9563_pwrctrl_disable_port(tc9563, i);
 		if (ret) {
 			dev_err(dev, "Disabling port failed\n");
 			goto power_off;
 		}
 
+		ret = tc9563_pwrctrl_ep_assert_deassert_reset(tc9563, i, false,
+							      cfg->ep_reset_gpio);
+		if (ret) {
+			dev_err(dev, "Assert EP reset failed\n");
+			goto power_off;
+		}
+
+		ret = tc9563_pwrctrl_ep_pwr_en(tc9563, i, true, cfg->ep_pwr_en_gpio);
+		if (ret) {
+			dev_err(dev, "Enabling EP Power failed\n");
+			goto power_off;
+		}
+
 		ret = tc9563_pwrctrl_set_l0s_l1_entry_delay(tc9563, i, false, cfg->l0s_delay);
 		if (ret) {
 			dev_err(dev, "Setting L0s entry delay failed\n");
@@ -519,11 +619,17 @@ static int tc9563_pwrctrl_power_on(struct pci_pwrctrl *pwrctrl)
 			dev_err(dev, "Disabling DFE failed\n");
 			goto power_off;
 		}
+
+		ret = tc9563_pwrctrl_ep_assert_deassert_reset(tc9563, i, true,
+							      cfg->ep_reset_gpio);
+		if (ret) {
+			dev_err(dev, "De-assert EP reset failed\n");
+			goto power_off;
+		}
+
 	}
 
-	ret = tc9563_pwrctrl_assert_deassert_reset(tc9563, true);
-	if (!ret)
-		return 0;
+	return 0;
 
 power_off:
 	tc9563_pwrctrl_power_off(&tc9563->pwrctrl);
@@ -601,7 +707,7 @@ static int tc9563_pwrctrl_probe(struct platform_device *pdev)
 				port++;
 				ret = tc9563_pwrctrl_parse_device_dt(tc9563,
 								child1, port);
-				if (ret)
+				if (port + 1 >= TC9563_MAX || ret)
 					break;
 			}
 		}

-- 
2.43.0

