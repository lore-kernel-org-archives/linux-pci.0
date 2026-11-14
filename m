Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794618822;
	b=YXMnE0NB/0/mrxRcRRb0guO638CqrO+J4xdYVOeUoRWyizPA2agjsx3avJ5Ik3QALVhf
	 oCCe3faArfCm72fEBvPAS8IvPrptk96UqowxOKIdgYPFAPnId8MeSl4MHnwkFN5SbkJ7C
	 ZhDdzn6cznjdqy47AmRoaZJ+f4xRxtbqf1mRCzU6iGBm5RyoOslIEYMFqfK6StQwh1pzJ
	 6eszqnS5O8ppvumfCeNtjSq0xEe4eNwFDhnIbELLV5AdqCYXmHt7zzNT9qtZAfUmAL84U
	 vcAciWxfPQ3xjLaKulzFBgYovBUH/CkeZQUSE3tuINIHvXbPo0aHm/GUW9HeBY13E8g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794618822;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Spam-Info:X-Proofpoint-GUID:X-Authority-Analysis:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=JuGhy0DKyNxM9PhxugC/t24NVoa+Yyv9Tqc8WSFHR84=;
	b=GFt8oOoxjA8S6Pj67YKKZ9vkNT5vWfK1QK2Egrx6cnM7uF2TGFt73UteGMHyOiO2lKg3
	 4HYcsKV6KbaM6KkSHoyEf1MANUcSsJZR4q9FaDaaG5EdDIlbNzDr78YaXn4qU3UpgvxxL
	 0ow3WhKJi85FhJdUb+UlQB8P7xzLjD+Ij5ISZ/RJRmEqwr8t8wdtDXQHip7MB1Zzt4AgU
	 uIQLFwc6LXuIPdhcaBH4nm9aAzZAtukDNSVUiNh5cCKHI1xyr0UoHRTouK0VwLWaLoTKg
	 vu0HLeCHqGzuJQY7A1eZYm3FLLVHJ0AUn4SWtRXCD8hW1K/M4zUN0o62rjjKaPfXo0A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=eKbRTLLa;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=dIKW+8vs;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 341BD606A89B
	for <linux-pci@vger.kernel.org>; Sat, 14 Nov 2026 01:13:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 341BD606A89B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=eKbRTLLa;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=dIKW+8vs
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6ADMbGGa2193413
	for <linux-pci@vger.kernel.org>; Sat, 14 Nov 2026 01:13:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	JuGhy0DKyNxM9PhxugC/t24NVoa+Yyv9Tqc8WSFHR84=; b=eKbRTLLaM/E7K72s
	RLRxu6Ew6BnHeVkKVdEae4DcWcxKoXXWqPgEDbg3ep0wV9sztd90HXvZnJ0GxWr6
	pJw1EKUwkowhHbftXlFG2Ln70U7OB5G0bCJinSx9U5stW7Re5nhPVA1CsvCGekgj
	HtULtv8K0+WbCFERa0Rrgdo0TpIsEL8Lr7ujCYvfQtaaXdd8CqBxcyqbTN+rJpZi
	TnOG516xdRz4DBZzbskEAIhMiD0+qSAq+qrBqVWDB74vag3TgoEm3zkrdIOYMH+r
	7GTMNX6vHbfgq4zWi6RMx/XoNqcvR8Gs/VFdJ7ze2ErMFz4fExNiICPHSM67DQvn
	d6xGgw==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com [74.125.82.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hx87ds76u-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Sat, 14 Nov 2026 01:13:40 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id 5a478bee46e88-30c0d568830so2083623eec.1
        for <linux-pci@vger.kernel.org>; Fri, 13 Nov 2026 17:13:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1794618819; x=1795223619; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=JuGhy0DKyNxM9PhxugC/t24NVoa+Yyv9Tqc8WSFHR84=;
        b=dIKW+8vsisI6eXbQaORZYY+50SEcbQHOXuuoeo4LlUlvv9M+x/RZT58ja92Q8EKU41
         6K+kz63iug3vZRULvROVLEUvCW8vftOFOI3IrqqYM9357WqAqEzi20tiuU/oCbAFiRAv
         BlaRGPxdjBzP2egC6XyfrgTR2lNGMf+Drc29n6/KD2igTOV8S7IiQlZ+fWVQks8kV78e
         OdoIZFo+epjYXPjiz6zZLuORPguv8zuhKYW42z2WBVBYjyEh5XXjHIlc89G55glptYuH
         WXTrrb6rJWBa8bdvZPWfORUGdzJNPwDS8M0GhGs+gPQgTyRnpDIF9coCnQZggjjIuqL2
         Dtgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794618819; x=1795223619;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=JuGhy0DKyNxM9PhxugC/t24NVoa+Yyv9Tqc8WSFHR84=;
        b=bK780qCcQnl5zayaWi1GqyTHk390AQYcO3dvF0CWB4lb1WTBWV9gOXbNQjGizi8Grz
         NELBH0Ldh9uCEEz9JS/+DYkibeW8TgkbOux18rbbRq2OBn0v1wY3SoRKGNEddyR8XSUH
         tUwYfxtAp01ZQxiC7XtuNjVX17ozlpMptFDJV/R4fgPIUBL86Q/gEaBPAEDrumnUyKW4
         NScHreg9cgspFHPj0QU1kMSiz4w3mfv7oeRhOIIxCrPeXzqDQ50MuM+HfMg7Bqk4FYSG
         YyAQ223Ur9PjyLHJeXqo6HvrZKcK0xR/8U6JHyZz8d6PsSW6kJr6SusBFTjEu9xNyKTS
         cPIQ==
X-Forwarded-Encrypted: i=1; AL+hErFXlg4Js+NO4dg0wiNJNWOK8Nfdh+L5rlQpwOvLxhd4nqeVIqAZqy84/H97xZSd1PD4vydZC7QKBk0=@vger.kernel.org
X-Gm-Message-State: APuU4Z+LYl5c2gcfJXNuUa2bjbRp3F6s3Ow3ab4vQhYp7jOFkZm0vcNJ
	TuKvjFi61s1Yf0hPc1Q3SHENmotmIcF0mJia/o/sizLf9Vr4uIuap0+5awi0exv1dmyT5Z+V5BI
	GAESG2rzOmhJbqnKPLVh2arXufQwv/4Kc6TrzUiZM3ls0XV21sOFV1hf+fw0bLsk=
X-Gm-Gg: AYBFou0d4cMM8giB1EuE+1+uTrPu6U3VSdpZqkqgIg79Ta3i06nETSRee0kqDjWpHCB
	uRVVOBKHWjY4OaD9lOXb6HqFSJ/jIlVB5OYW4HE/z1xoqHvsMP3NjGuZE2KvUUwy1o0oWRWPYw9
	o8yPgbjVtEQhgDD9eWDu5vKYi+/2oR+8zjTM683exQI80GGQ+57MTglEjUN+ZZCsRAmtsDD0j/3
	0lJPK4cqCsqfTYgR8gSlyPxBR2goDqcB626x6LJ8HISWqZCrfaPnTnQ45tLlkFGG69+lY0VRAFU
	OWLpfO7FeG4+zSDjuIf8pOGBMVX3j78f6u1+AC8NNcJgDFx5tgu+HDQ5901BoS9EPbvelL8SEfc
	rgSLFkSDLD6NEMviHrcJWPLsc2pWYMsfasNsE/AoeG0WCcGLamIPrikfXIrbvzbuhRsqaCbgnE0
	LJDEV3wQPK
X-Received: by 2002:a05:693c:4097:b0:372:7af9:b914 with SMTP id 5a478bee46e88-37967aeb603mr3618790eec.24.1794618818917;
        Fri, 13 Nov 2026 17:13:38 -0800 (PST)
X-Received: by 2002:a05:693c:4097:b0:372:7af9:b914 with SMTP id 5a478bee46e88-37967aeb603mr3618764eec.24.1794618818193;
        Fri, 13 Nov 2026 17:13:38 -0800 (PST)
Received: from hu-krichai-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3795378d7e5sm10952813eec.3.2026.11.13.17.13.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 17:13:37 -0800 (PST)
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Date: Sat, 14 Nov 2026 06:43:06 +0530
Subject: [PATCH v3 4/6] PCI: qcom-ep: Set initial interconnect bandwidth
 before enabling clocks
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
Message-Id: <20261114-monaco_ep-v3-4-7fe227cdfac0@oss.qualcomm.com>
References: <20261114-monaco_ep-v3-0-7fe227cdfac0@oss.qualcomm.com>
In-Reply-To: <20261114-monaco_ep-v3-0-7fe227cdfac0@oss.qualcomm.com>
To: Vinod Koul <vkoul@kernel.org>, Neil Armstrong <neil.armstrong@linaro.org>,
        Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org,
        Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794618790; l=2784;
 i=krishna.chundru@oss.qualcomm.com; s=20230907; h=from:subject:message-id;
 bh=JLeyQVRs1DLYCFaBm/u2gI+HZ0uJrg1UE3jfNR2noLs=;
 b=fvyspk0gNdaY7uQRp393/Q8fpriJSfofzij+hrmrJ3G/mBkegWv16IKlyLq3OaJRr1OYC4lEB
 VVVo8dduRzQB/08Em+w16e3U3EKALc9ZcitS9Kq/wPOJyXd6wwbEAjQ
X-Developer-Key: i=krishna.chundru@oss.qualcomm.com; a=ed25519;
 pk=10CL2pdAKFyzyOHbfSWHCD0X0my7CXxj8gJScmn1FAg=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE0MDAwNCBTYWx0ZWRfXwkaQV4nldfSQ
 VMeIPPdoP/ub/MX06af1HN3vzoAw+euwqxPbrbrZTY3wapvZPIZ3P7EgKGy8sZcXzudpI7lJNGc
 nINxoWDTnWoLVtb+hPMW3dtjyAjUlZKdLEzoOeaO6GCGBFcDUUXr3/c652xBnh2Tw8o3i+ITCIv
 REhhpbyUyMeqaoIVeO69f382ruUKL4dOkqmW22umQgUzHmyVlXjJf3JS+/ZJ3i5AWpei+JuAGZN
 NDqaiNlPmF1P4UnY5XCBwVkULM0WdYnNrU4URihCWiBktUGdYs6pmkhtSd/TjEBHYRpj+402zks
 JO1znptIZco1K0SrI/7OB7ZRXligssSyEre2AOgjTSYvmPQoIFlNqxHhWLRagjrS2vklcCTbbFW
 FMAI7PCUfAY96jbJmhDf5kmRmrSPzlcoTt3I3lKyOcajTgWDqJ/1rtxhtlDB0z3vkG7nGyYbQr4
 sfyfBU1YEdWnY2w3mLA==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE0MDAwNCBTYWx0ZWRfX9kHRX2izZScv
 BYkE4+DQZTNrJ2/FeH/KLaoQPz1yRunJiTlW3JtgQ7a7eGiiw3HqfMzhPfYDwfrJr7EcXi63oM1
 D20GNEg9RVSzKO1p6SP1CWfZIo4lJns=
X-Proofpoint-GUID: dci2Sh-nbXq5HK0mntF17l9LmxnOWN8n
X-Authority-Analysis: v=2.4 cv=BusIUoX5 c=1 sm=1 tr=0 ts=6af7b5c4 cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=kXhGf0cxdCgfIYue-YsA:9 a=QEXdDO2ut3YA:10
 a=bBxd6f-gb0O0v-kibOvt:22
X-Proofpoint-ORIG-GUID: dci2Sh-nbXq5HK0mntF17l9LmxnOWN8n
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-13_07,2026-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 lowpriorityscore=0 malwarescore=0 impostorscore=0 adultscore=0
 phishscore=0 spamscore=0 clxscore=1015 priorityscore=1501 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611140004

Some Qualcomm platforms require the interconnect bandwidth constraints
to be set before enabling the interconnect clocks, otherwise some
clocks get stuck in the off state.

Move the icc_set_bw() call before clk_bulk_prepare_enable() so the
bandwidth vote is in place first.

Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
---
 drivers/pci/controller/dwc/pcie-qcom-ep.c | 36 +++++++++++++++----------------
 1 file changed, 18 insertions(+), 18 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-qcom-ep.c b/drivers/pci/controller/dwc/pcie-qcom-ep.c
index 2d7ddf8d173f..a753d8870d10 100644
--- a/drivers/pci/controller/dwc/pcie-qcom-ep.c
+++ b/drivers/pci/controller/dwc/pcie-qcom-ep.c
@@ -332,9 +332,23 @@ static int qcom_pcie_enable_resources(struct qcom_pcie_ep *pcie_ep)
 	struct dw_pcie *pci = &pcie_ep->pci;
 	int ret;
 
+	/*
+	 * Some Qualcomm platforms require interconnect bandwidth constraints
+	 * to be set before enabling interconnect clocks.
+	 *
+	 * Set an initial peak bandwidth corresponding to single-lane Gen 1
+	 * for the pcie-mem path.
+	 */
+	ret = icc_set_bw(pcie_ep->icc_mem, 0, QCOM_PCIE_LINK_SPEED_TO_BW(1));
+	if (ret) {
+		dev_err(pci->dev, "failed to set interconnect bandwidth: %d\n",
+			ret);
+		return ret;
+	}
+
 	ret = clk_bulk_prepare_enable(pcie_ep->num_clks, pcie_ep->clks);
 	if (ret)
-		return ret;
+		goto err_disable_icc;
 
 	ret = qcom_pcie_ep_core_reset(pcie_ep);
 	if (ret)
@@ -352,28 +366,14 @@ static int qcom_pcie_enable_resources(struct qcom_pcie_ep *pcie_ep)
 	if (ret)
 		goto err_phy_exit;
 
-	/*
-	 * Some Qualcomm platforms require interconnect bandwidth constraints
-	 * to be set before enabling interconnect clocks.
-	 *
-	 * Set an initial peak bandwidth corresponding to single-lane Gen 1
-	 * for the pcie-mem path.
-	 */
-	ret = icc_set_bw(pcie_ep->icc_mem, 0, QCOM_PCIE_LINK_SPEED_TO_BW(1));
-	if (ret) {
-		dev_err(pci->dev, "failed to set interconnect bandwidth: %d\n",
-			ret);
-		goto err_phy_off;
-	}
-
 	return 0;
 
-err_phy_off:
-	phy_power_off(pcie_ep->phy);
 err_phy_exit:
 	phy_exit(pcie_ep->phy);
 err_disable_clk:
 	clk_bulk_disable_unprepare(pcie_ep->num_clks, pcie_ep->clks);
+err_disable_icc:
+	icc_set_bw(pcie_ep->icc_mem, 0, 0);
 
 	return ret;
 }
@@ -388,10 +388,10 @@ static void qcom_pcie_disable_resources(struct qcom_pcie_ep *pcie_ep)
 	if (pcie_ep->cfg && pcie_ep->cfg->firmware_managed)
 		return;
 
-	icc_set_bw(pcie_ep->icc_mem, 0, 0);
 	phy_power_off(pcie_ep->phy);
 	phy_exit(pcie_ep->phy);
 	clk_bulk_disable_unprepare(pcie_ep->num_clks, pcie_ep->clks);
+	icc_set_bw(pcie_ep->icc_mem, 0, 0);
 }
 
 static int qcom_pcie_perst_deassert(struct dw_pcie *pci)

-- 
2.34.1

