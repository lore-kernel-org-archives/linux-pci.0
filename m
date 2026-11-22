Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795329973;
	b=X2TQ2T3a5jiSK1Mi/y8B2sTWVvEad+z5cb8f1EDhUctkx97SC0fotmpZCfTIHQ1X7V2+
	 875sUO+YW97GTkf6rUt9f8MIecG78nhnJjulODrT5wjjCAb8Kk1+NvViRJzH1Po2jmcfL
	 1CldQXz0NgNFNM2Lwd/QfBsL0B5rNm3zDKzc2v12NJVwdDHNKE+C4pZNuqozh40EPbzMP
	 A2yLgaD4fFX9Ku2VqimWxG3UKySgOJIyTe7SXOewoxpFi9djiRuLulI+dqWM01t00yIPN
	 FVkTvoEyr9VdKmhZycLpzsbhOOj1Bs62eawF/KA8oSol4H+SKLrJq/qgo1j1Ed9SDjw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795329973;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Proofpoint-Spam-Info:
	 X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:X-Authority-Analysis:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=/HxRaZR7J9ru1hz+OIfLQCN5TXx4eWOdESZp+/f6pr4=;
	b=0OnH60wN53Ig+RF4Ljla5lMcVSj17GOLFlyz6srQ366lQWkwncQXGRQmRA9piIQtRh1h
	 IOZcAeZ62niL5Y+THnczFlUQ2yd3qFYaP5qzOG6LBoMo0M8+tuhT1vqxrMdgDiH3XpriG
	 g9qL22M3fyhn/nEPnK7wUse8guS9O8SngyxJl6yanQmddBOhjLYo18jxCpoJ3GPwX6WYl
	 pbB2GnMWGiLXGAlcyxIlJUa+RcIwiQe1otAy83fsTTX5yTj9ogaq+Tp0yOccQJwF2VA3D
	 pqjrkLgR7sRu3AeHNwfH1VEukaTOX1VZqelNimOR2OaM8UdZ5MJM5RzaERI+xZT+Deg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=cd4Iy+tU;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=iS5zRebj;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D72C606A684
	for <linux-pci@vger.kernel.org>; Sun, 22 Nov 2026 06:46:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8D72C606A684
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=cd4Iy+tU;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=iS5zRebj
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AM3jqjO2610381
	for <linux-pci@vger.kernel.org>; Sun, 22 Nov 2026 06:46:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	/HxRaZR7J9ru1hz+OIfLQCN5TXx4eWOdESZp+/f6pr4=; b=cd4Iy+tU+oopdkBT
	NqLPb6HhNInALg/+FgEC+4luWYkoQFWvXQoTGQrGLYK6deAKCNU3w0+seictRbbX
	Du53AixtxwckMWyS+cfpZvvvoX4GIToFZa2ZE76g21SBS3gT8yYcWiwxVdCuGerq
	HoN/ruNE1aM3n+uIeCiuzGBlPYCF/BmITjICv+cQz3HmH/KY+3Cll4ry4UV47P5B
	+jzSmLkNJ4J4T08VsZaIARtccUS+VnVByrGshKaw28LrUfXtezh5QbbWcyrzBlvV
	fkwnos13o9t8guFnv4Y5QjC3bCAQCajs+LGVhP0udIXYuCFgUbwLowJNbEmN5LRR
	O0e7ag==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com [74.125.82.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j328ru11w-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Sun, 22 Nov 2026 06:46:11 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id 5a478bee46e88-384c78aa0dbso3291446eec.0
        for <linux-pci@vger.kernel.org>; Sat, 21 Nov 2026 22:46:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1795329971; x=1795934771; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/HxRaZR7J9ru1hz+OIfLQCN5TXx4eWOdESZp+/f6pr4=;
        b=iS5zRebjQnEWcTaiTvzf033ZczVAen+bnqsKObIP4uEOLInDc1PWczQT5XBpEr+m+v
         26byVcKgBvraDEK9WSFxbUB2fZx99T/iQBrtU57bZAgFPyfWGGXykIFAw0+mtmm0BX3K
         taP//dC5re3EMECbv3XCZUw/aO4YLb/NY9068T9nIWmTBbso0ulbM2kl0Ra/6B+Xu8z/
         lsg58THY7d0TSAnFtKKnKwjUMHGlCvzU0tu8mov2rsuoolxW2CkNDe7ka0T/Nwos072N
         R3l3gKZQu8iWyBQshacl4MMissbXgmENvxi3/UeqL9Gi+Lf5XbYwEBc0z767yrAuFlQu
         vX9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795329971; x=1795934771;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/HxRaZR7J9ru1hz+OIfLQCN5TXx4eWOdESZp+/f6pr4=;
        b=a4UXm1t7o7Rso9CrZH3kACOUCP4hlNOel5FrZQzMdcpM4fNssS1JNLXkDSrVIvlPS9
         UsEMkQTgqePMArGufjW6mUX4MHFhR9F7zaIfs4NDQfNcLnhcTBuKgUcqNIWHZy0U1k3r
         33YDcdGJNm5HVYLXhYDzCWJs1xhvZc0TD47D+lBiDdnn3D4NrHkIbuL91x5yscHpbwBc
         kAOWzQkVa6/In3z4302HbmJzI3u2WBz2af7Za/qVJExaZFzQIoaNQTxlJu2OfBoEA7O7
         jeUbIdN3xvdIFZXBR0Y3tBnwulNjiL4eMlxa5iUG8+sOq9V3YZur4b/xbyc6DxtZaFqr
         Gf/Q==
X-Forwarded-Encrypted: i=1; AL+hErGJDd+1JeibOQrPNjhX/bbmJBjxaPCLqZ2pzilLsd7HLEQ9fnlmD5ZUbrPwGEqHwOBJnKLBpuWm0V0=@vger.kernel.org
X-Gm-Message-State: APuU4Z81VJyfG2zqcvemIG1nYGUsnEyT+EPP1xiAhsY940IH/fvjc99i
	e+8LayeUzfm9x+XFRCdp33b2rTt93ZTHOHqvgvXKwBgECuv51RuNtUcOgxl6xj5LOk7ka6nUPnS
	R//IPBxfiuzh/38WBvJAbzWdudCq/mDq8Fs6dFbX2GK13tqaaURiTA37W1bnQQNo=
X-Gm-Gg: AZFdTZcQwyLA4H+3a9blrsTtOA9YQKLqx4MLk3VYd8ZKoXHw0IkZ2neh+ytqe9RhUlt
	wAFJA/0zlWT7xO2+HEyv6IwtMEyZxSk3M7kFbPsYUdKrLVFKZBX4RMP0BbTnLH5sTkkylHBrpsn
	h49EV+qq6pcRTZxwJ6p833WKEM+3O/BWQMgswYOf+Tc0kOHzH4OYs188m0rrzORFUGnbI/gTvuS
	YTr0i90Nnl6887Pn9ukcqemIqB05e3wITWg17bN5USEilJdD8TGzVyFcQmYKIbZWjmBPSzWu03W
	VKPkV2E6j03Vpt2WR+FkiRVf1ec+3ABD6FGXKpXEU81KHzRphF6o/nFikvXChSDBPaPFypw6hqX
	9BjdhlV00Qzrk24tujpxuvcnDEp8AGWeyJEBnr5x52VD4w6gP5O3BGmMQhuhFk/QBupbngHcScV
	cuBUpXQ/47
X-Received: by 2002:a05:7301:85cb:b0:381:edba:caba with SMTP id 5a478bee46e88-3856fd5cceamr9129724eec.17.1795329970939;
        Sat, 21 Nov 2026 22:46:10 -0800 (PST)
X-Received: by 2002:a05:7301:85cb:b0:381:edba:caba with SMTP id 5a478bee46e88-3856fd5cceamr9129689eec.17.1795329970317;
        Sat, 21 Nov 2026 22:46:10 -0800 (PST)
Received: from hu-krichai-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-38566cd40c5sm27598615eec.10.2026.11.21.22.46.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Nov 2026 22:46:10 -0800 (PST)
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Date: Sun, 22 Nov 2026 12:15:52 +0530
Subject: [PATCH v2 2/4] power: sequencing: pcie-m2: Add support for PCIe
 M.2 Key B connectors
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
Message-Id: <20261122-pcie6_fix-v2-2-2e0fe615d90b@oss.qualcomm.com>
References: <20261122-pcie6_fix-v2-0-2e0fe615d90b@oss.qualcomm.com>
In-Reply-To: <20261122-pcie6_fix-v2-0-2e0fe615d90b@oss.qualcomm.com>
To: Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bartosz Golaszewski <brgl@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: Abel Vesa <abelvesa@kernel.org>, alchark@flipper.net,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795329955; l=4982;
 i=krishna.chundru@oss.qualcomm.com; s=20230907; h=from:subject:message-id;
 bh=GERyXG9kT+rvE2z4g19ttsfCKGC8K9XHB/CHtubzrro=;
 b=EZVbgnjTMa6pM0iZgLGu7RxcsQSbI+fK1plh3pLB9BzCaNYo7+zdadU8O+5so2n6TyGSe3gIS
 kE/RMafil4/BqLXxL5kBq+LUwAiN/df4ANGXn1ZNKOOq/rs9O91bBdt
X-Developer-Key: i=krishna.chundru@oss.qualcomm.com; a=ed25519;
 pk=10CL2pdAKFyzyOHbfSWHCD0X0my7CXxj8gJScmn1FAg=
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTIyMDAyNiBTYWx0ZWRfX6+hiNkHN4EfQ
 70gqoJLB3DguxZQU6A9eyMotigwjkP+AUV/Ert9XGYANYGMLFULc1x/NjtXgmUG+uB/k9Q35VW3
 6Fkf6ZyMf1kzmOSg4DVdPVrKO8PkUWI=
X-Proofpoint-GUID: 5AoQB4cEBNS7sVfEL8aClwcILMgsynOk
X-Proofpoint-ORIG-GUID: 5AoQB4cEBNS7sVfEL8aClwcILMgsynOk
X-Authority-Analysis: v=2.4 cv=c9w+0h9l c=1 sm=1 tr=0 ts=6b028fb3 cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=EUspDBNiAAAA:8 a=1YR4yFrG3nAziPXzX-cA:9 a=QEXdDO2ut3YA:10
 a=PxkB5W3o20Ba91AHUih5:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTIyMDAyNiBTYWx0ZWRfXzsHLs4muuJfp
 BN+jz36Mbvjn2dx2RrZkUsg3IQRrzlzVKLL/OUfITkFv6KbbO051h4XTAZ4Exd8poDC0dj+hAOJ
 GeVEPSQdkQLwHh4wHjxHrALxfD57EsCh0OM3bt/fxsnCG18mfBwzrpFQcc5V3sD48h2iEXku86U
 jHSmxqgzOUJQtHTvp+y74c6sFFcMEOlA3wNVUoa0A+x6maSoJD0LAGRWteYHIVQX2k+eXGx7Gg/
 Qygd40WxtpM+qbRWgD/UB+hC2Na9EG4sp4/wf5KskXlLOzRsUPsizpbLoxRjNQmjlQOHX7rEXzz
 FCCe7c5IaI53l6YPNkAHqDRM24EDv6A5e2iDWYSY89SnSU1SQ7mBk0SnypScprltl2I++BDPyJp
 7lv+nAsPcUqeJa/vJYQSh9cIHiTMkQMGiM/sFORQZyYhwkLvPcjGb24fIImBepkVmQsyhSYcPQm
 auTS9olbdW83KCip4qg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-22_01,2026-11-19_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 phishscore=0 adultscore=0 bulkscore=0 clxscore=1015
 suspectscore=0 malwarescore=0 impostorscore=0 priorityscore=1501 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611220026

Add support for handling the power sequence of the PCIe M.2 Key B
connectors. These connectors are used to attach WWAN Adapters to the
host machine over interfaces such as PCIe, USB3.1 Gen1, SSIC, or USB
2.0.

Currently, this driver only supports driving the 3.3V/VBAT power
supply along with the FULL_CARD_POWER_OFF#, RESET#, and W_DISABLE1#
GPIOs as a single "pcie" target, since Key B Adapters expose only a
discoverable PCIe/USB interface and no non-discoverable bus (unlike
Key E's UART-attached Bluetooth device), so no serdev creation is
needed. The other signals described in the binding are not supported
yet.

Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
---
 drivers/power/sequencing/pwrseq-pcie-m2.c | 70 +++++++++++++++++++++++++++++++
 1 file changed, 70 insertions(+)

diff --git a/drivers/power/sequencing/pwrseq-pcie-m2.c b/drivers/power/sequencing/pwrseq-pcie-m2.c
index 56c5d51293c1..8af4a059b596 100644
--- a/drivers/power/sequencing/pwrseq-pcie-m2.c
+++ b/drivers/power/sequencing/pwrseq-pcie-m2.c
@@ -39,6 +39,8 @@ struct pwrseq_pcie_m2_ctx {
 	struct notifier_block nb;
 	struct gpio_desc *w_disable1_gpio;
 	struct gpio_desc *w_disable2_gpio;
+	struct gpio_desc *full_card_power_off_gpio;
+	struct gpio_desc *reset_gpio;
 	struct device *dev;
 	struct list_head pci_devices;
 	struct mutex list_lock;
@@ -135,6 +137,45 @@ static const struct pwrseq_unit_data pwrseq_pcie_m2_e_pcie_unit_data = {
 	.disable = pwrseq_pci_m2_e_pcie_disable,
 };
 
+static int pwrseq_pci_m2_b_pcie_enable(struct pwrseq_device *pwrseq)
+{
+	struct pwrseq_pcie_m2_ctx *ctx = pwrseq_device_get_drvdata(pwrseq);
+	int ret;
+
+	ret = gpiod_set_value_cansleep(ctx->full_card_power_off_gpio, 0);
+	if (ret)
+		return ret;
+
+	ret = gpiod_set_value_cansleep(ctx->reset_gpio, 0);
+	if (ret)
+		return ret;
+
+	return gpiod_set_value_cansleep(ctx->w_disable1_gpio, 0);
+}
+
+static int pwrseq_pci_m2_b_pcie_disable(struct pwrseq_device *pwrseq)
+{
+	struct pwrseq_pcie_m2_ctx *ctx = pwrseq_device_get_drvdata(pwrseq);
+	int ret;
+
+	ret = gpiod_set_value_cansleep(ctx->w_disable1_gpio, 1);
+	if (ret)
+		return ret;
+
+	ret = gpiod_set_value_cansleep(ctx->reset_gpio, 1);
+	if (ret)
+		return ret;
+
+	return gpiod_set_value_cansleep(ctx->full_card_power_off_gpio, 1);
+}
+
+static const struct pwrseq_unit_data pwrseq_pcie_m2_b_pcie_unit_data = {
+	.name = "pcie-enable",
+	.deps = pwrseq_pcie_m2_unit_deps,
+	.enable = pwrseq_pci_m2_b_pcie_enable,
+	.disable = pwrseq_pci_m2_b_pcie_disable,
+};
+
 static const struct pwrseq_unit_data pwrseq_pcie_m2_m_pcie_unit_data = {
 	.name = "pcie-enable",
 	.deps = pwrseq_pcie_m2_unit_deps,
@@ -166,6 +207,11 @@ static const struct pwrseq_target_data pwrseq_pcie_m2_e_pcie_target_data = {
 	.is_controllable = pwrseq_pci_m2_e_pcie_is_controllable,
 };
 
+static const struct pwrseq_target_data pwrseq_pcie_m2_b_pcie_target_data = {
+	.name = "pcie",
+	.unit = &pwrseq_pcie_m2_b_pcie_unit_data,
+};
+
 static const struct pwrseq_target_data pwrseq_pcie_m2_m_pcie_target_data = {
 	.name = "pcie",
 	.unit = &pwrseq_pcie_m2_m_pcie_unit_data,
@@ -177,6 +223,11 @@ static const struct pwrseq_target_data *pwrseq_pcie_m2_e_targets[] = {
 	NULL
 };
 
+static const struct pwrseq_target_data *pwrseq_pcie_m2_b_targets[] = {
+	&pwrseq_pcie_m2_b_pcie_target_data,
+	NULL
+};
+
 static const struct pwrseq_target_data *pwrseq_pcie_m2_m_targets[] = {
 	&pwrseq_pcie_m2_m_pcie_target_data,
 	NULL
@@ -186,6 +237,10 @@ static const struct pwrseq_pcie_m2_pdata pwrseq_pcie_m2_e_of_data = {
 	.targets = pwrseq_pcie_m2_e_targets,
 };
 
+static const struct pwrseq_pcie_m2_pdata pwrseq_pcie_m2_b_of_data = {
+	.targets = pwrseq_pcie_m2_b_targets,
+};
+
 static const struct pwrseq_pcie_m2_pdata pwrseq_pcie_m2_m_of_data = {
 	.targets = pwrseq_pcie_m2_m_targets,
 };
@@ -577,6 +632,17 @@ static int pwrseq_pcie_m2_probe(struct platform_device *pdev)
 		goto err_free_regulators;
 	}
 
+	ctx->full_card_power_off_gpio = devm_gpiod_get_optional(dev, "full-card-power-off",
+								 GPIOD_OUT_HIGH);
+	if (IS_ERR(ctx->full_card_power_off_gpio))
+		return dev_err_probe(dev, PTR_ERR(ctx->full_card_power_off_gpio),
+				     "Failed to get the FULL_CARD_POWER_OFF# GPIO\n");
+
+	ctx->reset_gpio = devm_gpiod_get_optional(dev, "reset", GPIOD_OUT_HIGH);
+	if (IS_ERR(ctx->reset_gpio))
+		return dev_err_probe(dev, PTR_ERR(ctx->reset_gpio),
+				     "Failed to get the RESET# GPIO\n");
+
 	config.parent = dev;
 	config.owner = THIS_MODULE;
 	config.drvdata = ctx;
@@ -641,6 +707,10 @@ static const struct of_device_id pwrseq_pcie_m2_of_match[] = {
 		.compatible = "pcie-m2-e-connector",
 		.data = &pwrseq_pcie_m2_e_of_data,
 	},
+	{
+		.compatible = "pcie-m2-b-connector",
+		.data = &pwrseq_pcie_m2_b_of_data,
+	},
 	{ }
 };
 MODULE_DEVICE_TABLE(of, pwrseq_pcie_m2_of_match);

-- 
2.34.1

