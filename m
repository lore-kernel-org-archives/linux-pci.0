Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795719596;
	b=jvD/PJ6NH66H0iwOqnakKX7TxmJBVphwFhU5Bq5EhOpRZTVfIa/CyK5tYsSLU9+S3whd
	 3NUnFKHG7lRO6zF72wNSt05EXrXlHl63m/mZgc57Ra6N1fPlJRD4BEypqpqoQ31fuksmS
	 mdufNM/KoNjHl5ZAGAeB9S8OuTq/NsXXxYEZPFMbpbtDB6WdcQquWrH0JZlumfRuAu1/z
	 hrNlnYZg+Z9vNGJk0gVVSHX1VboO+AVl9XnRARU1RSR7AscwQUuwcpzpviT6NEekKt9MD
	 YoRaEAYstA1K5jtO/5TYKvBoPVHUO0sFAs6kIIVhcotScc4XrnnGq4Ubn++l12qxaTQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795719596;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Authority-Analysis:X-Proofpoint-Spam-Info:X-Proofpoint-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=/00NqReDgsN7DpEOL6VOh9ns6kcq/8uBglgUysJara0=;
	b=oXfNQEIr83qskNHI+CQDBquu2gwN9vREFZ/OoCTLW3x2eJjkmeeID3jToKhAOnCx6rf3
	 0W+OrY7IbHy188odNXB+3vPRFuetX1OjYwS/d6qCMK77Nek0vzTd+uuGdS+YeF0bAtc/K
	 BhDKvTc7NOij2lGtDbgjMSROzEB86e0lkjJ/5U52vHekmzdyQpqhZsVMat6JiFevK5W2m
	 cDIqkDUuTKn8PeCharLgZ+cTEvF8KDZWsOqY/2x37WzQeW7qGoQLbLCzAgUn9XMISzulG
	 VpqtA0E1qIkde7J9q9Ev09GUnTDWeEkUGIyQ2wGITvnPrOiTMtdV0ZnxRILeLm5cVSg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=EuCqEniA;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=acmWy3sq;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC3CF606A31C
	for <linux-pci@vger.kernel.org>; Thu, 26 Nov 2026 18:59:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CC3CF606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=EuCqEniA;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=acmWy3sq
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AQGc3nJ596445
	for <linux-pci@vger.kernel.org>; Thu, 26 Nov 2026 18:59:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	/00NqReDgsN7DpEOL6VOh9ns6kcq/8uBglgUysJara0=; b=EuCqEniAuaycpS+j
	QAyhLkuo95LaWZ1vhIxVcP96OjX57gFDo+foNWMeoJQlj5vjDv/WKuOlh7xvDlVD
	3Iy2f4BnNeIOnXjudnz1p+CmNnTuT2tKhQQN/H7ORm6kgASgScdB2f/eHJTmTDaT
	5tGBhEqmfaow4nB9bd7Mi1GkGOeEj11gv4+Ga8v1u7qSwku337TrNk/m/YMXaZtE
	OY1xY8Thz67zyEtZsF6jj9B1GKlrT0kn+m8tLhvgTSSZzsiFhMS2/11XgexFWiVw
	mTAJJ0rHOFQeSqQHM54PkN1bKCqMcPDIKxD1S/eB2NfTX16C0RylWND3gdSbPJ/K
	UxMdMQ==
Received: from mail-dl1-f72.google.com (mail-dl1-f72.google.com [74.125.82.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j6rf90dd1-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Thu, 26 Nov 2026 18:59:55 +0000 (GMT)
Received: by mail-dl1-f72.google.com with SMTP id a92af1059eb24-1b3b45597c7so3601183c88.1
        for <linux-pci@vger.kernel.org>; Thu, 26 Nov 2026 10:59:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1795719594; x=1796324394; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/00NqReDgsN7DpEOL6VOh9ns6kcq/8uBglgUysJara0=;
        b=acmWy3sq5XAUOhSRIvAKpjUEuXIVAdv96s9ET7FVYcn8yRWVuapaFnGkFUNXAAzLbU
         lt1KG3ZAo1OW51krIM2BltPE6OURiMKW+u5Z9NAhTNJmZR1hVKUbDO0AGHtf0edC++0g
         cmIrR3eHPdPaBCFkBcpuCuEr7pSa6aYXCaULgPoHUxmmOdFg63EqwpRmSsJ0jxG8PlBn
         TViUEFD54aRIhz4OnHthgM6lvDXvrN948YbeJ8xLOc8WnkPWvI7+2y9EnaXZ+MGLiF+F
         b24yiNLLtdUMEJSsDCKhQ4QjiSt3YOxOvrP5arqL2pOzRRb+Q3DlMcepCqYfgZejxZkW
         i1ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795719594; x=1796324394;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/00NqReDgsN7DpEOL6VOh9ns6kcq/8uBglgUysJara0=;
        b=Id2ctEVvY1Yf17Fdj4Lbc+i+2RhxJXOpEao/L6YGuJH9nggqqsAZ+Ilknbbl1wsg49
         gs0XZMDwCyLa7CyqiGSI/iCwQHGVCb5TslYs3fIma5qFdgxHsQjB3mlRSqLbTltZyq6B
         MZFYB0ESHQpCxxJd8zmePymTIvM3oQP2+XmcTQ53OSmOGQ12iT4msPcK9xaJeNn6fsVn
         eAKp1mBgQgwkIt3KEgopL5I+A5wRUBailJvg08mHhdQ6Ri7k10akEer/JaI1/zD5hyUY
         E3iKNJwA0k5sopODcM28hqlT5Kz+5Ap53Zh6J9PTW2RLMSubNNeOPg+7DDvOPv3UCj7b
         RChQ==
X-Forwarded-Encrypted: i=1; AL+hErF+KK9UmgsYMnbruL8JNgEQK1TCO/Q8Rdqzm+GehlPBQRQC7+Unt0uAYGN+5XxDxNK3gbvCpoglABw=@vger.kernel.org
X-Gm-Message-State: APuU4Z8LgQdj+JKT4W/FsHY7X12V+fQWQfXLrRqelLBDx2ESHaaOD7Vf
	CvKIx12byT7Fm0yWCUjEvuc6L6PvtFuAlTWsJO2AxUjzhGNqq5vzhnLG1209MrE4QJsScdYj8z2
	N729mJSv6Hm5fD13OCtk5QyH7mtpNNCL3oyo5oBZqcaj0g/x6YWo4ksETkEbbkp0=
X-Gm-Gg: AZFdTZcUlsVLDIe0QBwiwY+ehpfg9f+J8ctidP20WbJStLP7LLMdooUPLXc972EPQ2H
	epCWyjekONuQXosyObnmUdZ+rXhS6MrOHiw0yLNDRj3gLPmkFbBilsnfZX8RUYyje1z2+V8SGV8
	zSZHGF2PBHhxO9ifrFywlbKWN1u4pNZCUZBEkPlj5Ppr38iqC8lbvHAt2PqVBGH22DfiKWM0lRI
	SxiGjufakr6/ZJESiyS6YIiVlal5SsIpteVpLjtiqCwCfYJaAJ7UxD5aPsrKSBMjWdlBs1FT1v8
	QGQyjZcsqKdsyMKDbTlgpnKszUpLT/2QrzKCXx+6kztWY5vsqwS2LWT94M2fXxr/ed0RNju1FMQ
	n19yMiN45JRWT7ZPBDtXSaRmO2/kXTXxeBd7yxSycxc2HbxQPAKNF5OXi3eHJvqhxsEJKTm4Fn/
	NyZLBn
X-Received: by 2002:a05:7022:1583:b0:1b3:a9c6:b293 with SMTP id a92af1059eb24-1b5568c0198mr23679994c88.25.1795719594270;
        Thu, 26 Nov 2026 10:59:54 -0800 (PST)
X-Received: by 2002:a05:7022:1583:b0:1b3:a9c6:b293 with SMTP id a92af1059eb24-1b5568c0198mr23679971c88.25.1795719593789;
        Thu, 26 Nov 2026 10:59:53 -0800 (PST)
Received: from hu-jkona-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b5567ffa8csm60868190c88.7.2026.11.26.10.59.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Nov 2026 10:59:53 -0800 (PST)
From: Jagadeesh Kona <jagadeesh.kona@oss.qualcomm.com>
Date: Fri, 27 Nov 2026 00:27:10 +0530
Subject: [PATCH 2/8] clk: qcom: gcc-glymur: Register set_hwmode_dev
 callback for USB, PCIe GDSCs
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
Message-Id: <20261127-usb-pcie-gdsc-suspend-v1-2-485a08ffdc6f@oss.qualcomm.com>
References: <20261127-usb-pcie-gdsc-suspend-v1-0-485a08ffdc6f@oss.qualcomm.com>
In-Reply-To: <20261127-usb-pcie-gdsc-suspend-v1-0-485a08ffdc6f@oss.qualcomm.com>
To: Bjorn Andersson <andersson@kernel.org>, Abel Vesa <abelvesa@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>, Brian Masney <bmasney+clk@redhat.com>,
        Jerome Brunet <jbrunet+clk@baylibre.com>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Vinod Koul <vkoul@kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
        Ulf Hansson <ulf.hansson@oss.qualcomm.com>
Cc: Ajit Pandey <ajit.pandey@oss.qualcomm.com>,
        Imran Shaik <imran.shaik@oss.qualcomm.com>,
        Taniya Das <taniya.das@oss.qualcomm.com>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-usb@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-pci@vger.kernel.org,
        Jagadeesh Kona <jagadeesh.kona@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Proofpoint-ORIG-GUID: vjwsSZ6prGct4sysCDPaUf1EJNEaGd3o
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI2MDA3NCBTYWx0ZWRfX9WfRpr8BwqAA
 wqdH3tk6Ch+7MLMPZePLGlVMOMcXaiJWTKWa9XwvGyf99KzfeWdLJXdEE+u+j98vMtEqQdH0LnT
 SEBqahPb3/10Ygo6zcFItKs4NCYZkFEmvzAwsSAoJNVWQmtF3xS4uAp6pNHEjr6ycNsbO7wUC25
 6GhoMiK/Aj94Eo3fedNKwM6boZ3Off0mODBanSJk0/ivtk+aYF1Tjuft+y3K+YQBavWxPipxN5/
 aH+RGIYaK3vl3I6+aEGe3iMVScIMj3sjnW5XhOi66hjpB9EPJnMIwu3sZpKV5LHvyQ3wd+S8/vm
 4TYBBBgHH/qCZbnjKFKAGou7LJwIzDc6U4sSayBZB1f5+aEZWmtTRVSUr2fs2Peou2nx1ERv9II
 OgmFaKwF0d5GM56UJeZA/acCo539+a5n9ZUP5JqfDw86wi+NDYCDxi9sZJuQrg+5QBAm8KEiRDO
 5pgCx72j1D39eTxBaPw==
X-Authority-Analysis: v=2.4 cv=cpkOAF4i c=1 sm=1 tr=0 ts=6b0881ab cx=c_pps
 a=bS7HVuBVfinNPG3f6cIo3Q==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=EUspDBNiAAAA:8 a=DIGDBJpTELtvEum99LgA:9 a=QEXdDO2ut3YA:10
 a=vBUdepa8ALXHeOFLBtFW:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI2MDA3NCBTYWx0ZWRfXxgnQc1stvqQf
 OnrMuDG6RaMD6ETnPa/dCG5Cty2HUvzpkPs9Ura5xniA5cMJO7hpaL5L6/vHevXP9saT6C1NVNG
 VALnx1Uyn7EE0GrevisTbZ8lF71C3zk=
X-Proofpoint-GUID: vjwsSZ6prGct4sysCDPaUf1EJNEaGd3o
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-26_04,2026-11-26_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 adultscore=0 priorityscore=1501 spamscore=0 phishscore=0
 suspectscore=0 malwarescore=0 lowpriorityscore=0 impostorscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611260074

Register gdsc_set_hw_stay_on as set_hwmode_dev callback for USB & PCIe
GDSCs to allow the USB & PCIe consumer drivers to keep the GDSC ON based on
the requirement in USB host mode and PCIe non-D3 cold usecases. Also drop
the PWRSTS_RET_ON flag for USB GDSC's.

Signed-off-by: Jagadeesh Kona <jagadeesh.kona@oss.qualcomm.com>
---
 drivers/clk/qcom/gcc-glymur.c | 46 +++++++++++++++++++++++++++++++++----------
 1 file changed, 36 insertions(+), 10 deletions(-)

diff --git a/drivers/clk/qcom/gcc-glymur.c b/drivers/clk/qcom/gcc-glymur.c
index d8d33eff419eeb9885f8560c2c7c71d542371658..73013133fa27cf0b908a8e5552a6fe981ab197d4 100644
--- a/drivers/clk/qcom/gcc-glymur.c
+++ b/drivers/clk/qcom/gcc-glymur.c
@@ -7557,6 +7557,7 @@ static struct gdsc gcc_pcie_0_tunnel_gdsc = {
 	.collapse_mask = BIT(2),
 	.pd = {
 		.name = "gcc_pcie_0_tunnel_gdsc",
+		.set_hwmode_dev = gdsc_set_hw_stay_on,
 	},
 	.pwrsts = PWRSTS_OFF_ON,
 	.flags = POLL_CFG_GDSCR | RETAIN_FF_ENABLE | VOTABLE,
@@ -7571,6 +7572,7 @@ static struct gdsc gcc_pcie_1_tunnel_gdsc = {
 	.collapse_mask = BIT(1),
 	.pd = {
 		.name = "gcc_pcie_1_tunnel_gdsc",
+		.set_hwmode_dev = gdsc_set_hw_stay_on,
 	},
 	.pwrsts = PWRSTS_OFF_ON,
 	.flags = POLL_CFG_GDSCR | RETAIN_FF_ENABLE | VOTABLE,
@@ -7585,6 +7587,7 @@ static struct gdsc gcc_pcie_2_tunnel_gdsc = {
 	.collapse_mask = BIT(3),
 	.pd = {
 		.name = "gcc_pcie_2_tunnel_gdsc",
+		.set_hwmode_dev = gdsc_set_hw_stay_on,
 	},
 	.pwrsts = PWRSTS_OFF_ON,
 	.flags = POLL_CFG_GDSCR | RETAIN_FF_ENABLE | VOTABLE,
@@ -7599,6 +7602,7 @@ static struct gdsc gcc_pcie_3a_gdsc = {
 	.collapse_mask = BIT(4),
 	.pd = {
 		.name = "gcc_pcie_3a_gdsc",
+		.set_hwmode_dev = gdsc_set_hw_stay_on,
 	},
 	.pwrsts = PWRSTS_OFF_ON,
 	.flags = POLL_CFG_GDSCR | RETAIN_FF_ENABLE | VOTABLE,
@@ -7613,6 +7617,7 @@ static struct gdsc gcc_pcie_3a_phy_gdsc = {
 	.collapse_mask = BIT(5),
 	.pd = {
 		.name = "gcc_pcie_3a_phy_gdsc",
+		.set_hwmode_dev = gdsc_set_hw_stay_on,
 	},
 	.pwrsts = PWRSTS_OFF_ON,
 	.flags = POLL_CFG_GDSCR | RETAIN_FF_ENABLE | VOTABLE,
@@ -7627,6 +7632,7 @@ static struct gdsc gcc_pcie_3b_gdsc = {
 	.collapse_mask = BIT(6),
 	.pd = {
 		.name = "gcc_pcie_3b_gdsc",
+		.set_hwmode_dev = gdsc_set_hw_stay_on,
 	},
 	.pwrsts = PWRSTS_OFF_ON,
 	.flags = POLL_CFG_GDSCR | RETAIN_FF_ENABLE | VOTABLE,
@@ -7641,6 +7647,7 @@ static struct gdsc gcc_pcie_3b_phy_gdsc = {
 	.collapse_mask = BIT(7),
 	.pd = {
 		.name = "gcc_pcie_3b_phy_gdsc",
+		.set_hwmode_dev = gdsc_set_hw_stay_on,
 	},
 	.pwrsts = PWRSTS_OFF_ON,
 	.flags = POLL_CFG_GDSCR | RETAIN_FF_ENABLE | VOTABLE,
@@ -7655,6 +7662,7 @@ static struct gdsc gcc_pcie_4_gdsc = {
 	.collapse_mask = BIT(10),
 	.pd = {
 		.name = "gcc_pcie_4_gdsc",
+		.set_hwmode_dev = gdsc_set_hw_stay_on,
 	},
 	.pwrsts = PWRSTS_OFF_ON,
 	.flags = POLL_CFG_GDSCR | RETAIN_FF_ENABLE | VOTABLE,
@@ -7669,6 +7677,7 @@ static struct gdsc gcc_pcie_4_phy_gdsc = {
 	.collapse_mask = BIT(11),
 	.pd = {
 		.name = "gcc_pcie_4_phy_gdsc",
+		.set_hwmode_dev = gdsc_set_hw_stay_on,
 	},
 	.pwrsts = PWRSTS_OFF_ON,
 	.flags = POLL_CFG_GDSCR | RETAIN_FF_ENABLE | VOTABLE,
@@ -7683,6 +7692,7 @@ static struct gdsc gcc_pcie_5_gdsc = {
 	.collapse_mask = BIT(8),
 	.pd = {
 		.name = "gcc_pcie_5_gdsc",
+		.set_hwmode_dev = gdsc_set_hw_stay_on,
 	},
 	.pwrsts = PWRSTS_OFF_ON,
 	.flags = POLL_CFG_GDSCR | RETAIN_FF_ENABLE | VOTABLE,
@@ -7697,6 +7707,7 @@ static struct gdsc gcc_pcie_5_phy_gdsc = {
 	.collapse_mask = BIT(9),
 	.pd = {
 		.name = "gcc_pcie_5_phy_gdsc",
+		.set_hwmode_dev = gdsc_set_hw_stay_on,
 	},
 	.pwrsts = PWRSTS_OFF_ON,
 	.flags = POLL_CFG_GDSCR | RETAIN_FF_ENABLE | VOTABLE,
@@ -7711,6 +7722,7 @@ static struct gdsc gcc_pcie_6_gdsc = {
 	.collapse_mask = BIT(12),
 	.pd = {
 		.name = "gcc_pcie_6_gdsc",
+		.set_hwmode_dev = gdsc_set_hw_stay_on,
 	},
 	.pwrsts = PWRSTS_OFF_ON,
 	.flags = POLL_CFG_GDSCR | RETAIN_FF_ENABLE | VOTABLE,
@@ -7725,6 +7737,7 @@ static struct gdsc gcc_pcie_6_phy_gdsc = {
 	.collapse_mask = BIT(13),
 	.pd = {
 		.name = "gcc_pcie_6_phy_gdsc",
+		.set_hwmode_dev = gdsc_set_hw_stay_on,
 	},
 	.pwrsts = PWRSTS_OFF_ON,
 	.flags = POLL_CFG_GDSCR | RETAIN_FF_ENABLE | VOTABLE,
@@ -7749,8 +7762,9 @@ static struct gdsc gcc_usb20_prim_gdsc = {
 	.clk_dis_wait_val = 0xf,
 	.pd = {
 		.name = "gcc_usb20_prim_gdsc",
+		.set_hwmode_dev = gdsc_set_hw_stay_on,
 	},
-	.pwrsts = PWRSTS_RET_ON,
+	.pwrsts = PWRSTS_OFF_ON,
 	.flags = POLL_CFG_GDSCR | RETAIN_FF_ENABLE,
 };
 
@@ -7761,8 +7775,9 @@ static struct gdsc gcc_usb30_mp_gdsc = {
 	.clk_dis_wait_val = 0xf,
 	.pd = {
 		.name = "gcc_usb30_mp_gdsc",
+		.set_hwmode_dev = gdsc_set_hw_stay_on,
 	},
-	.pwrsts = PWRSTS_RET_ON,
+	.pwrsts = PWRSTS_OFF_ON,
 	.flags = POLL_CFG_GDSCR | RETAIN_FF_ENABLE,
 };
 
@@ -7773,8 +7788,9 @@ static struct gdsc gcc_usb30_prim_gdsc = {
 	.clk_dis_wait_val = 0xf,
 	.pd = {
 		.name = "gcc_usb30_prim_gdsc",
+		.set_hwmode_dev = gdsc_set_hw_stay_on,
 	},
-	.pwrsts = PWRSTS_RET_ON,
+	.pwrsts = PWRSTS_OFF_ON,
 	.flags = POLL_CFG_GDSCR | RETAIN_FF_ENABLE,
 };
 
@@ -7785,8 +7801,9 @@ static struct gdsc gcc_usb30_sec_gdsc = {
 	.clk_dis_wait_val = 0xf,
 	.pd = {
 		.name = "gcc_usb30_sec_gdsc",
+		.set_hwmode_dev = gdsc_set_hw_stay_on,
 	},
-	.pwrsts = PWRSTS_RET_ON,
+	.pwrsts = PWRSTS_OFF_ON,
 	.flags = POLL_CFG_GDSCR | RETAIN_FF_ENABLE,
 };
 
@@ -7797,8 +7814,9 @@ static struct gdsc gcc_usb30_tert_gdsc = {
 	.clk_dis_wait_val = 0xf,
 	.pd = {
 		.name = "gcc_usb30_tert_gdsc",
+		.set_hwmode_dev = gdsc_set_hw_stay_on,
 	},
-	.pwrsts = PWRSTS_RET_ON,
+	.pwrsts = PWRSTS_OFF_ON,
 	.flags = POLL_CFG_GDSCR | RETAIN_FF_ENABLE,
 };
 
@@ -7809,8 +7827,9 @@ static struct gdsc gcc_usb3_mp_ss0_phy_gdsc = {
 	.clk_dis_wait_val = 0x2,
 	.pd = {
 		.name = "gcc_usb3_mp_ss0_phy_gdsc",
+		.set_hwmode_dev = gdsc_set_hw_stay_on,
 	},
-	.pwrsts = PWRSTS_RET_ON,
+	.pwrsts = PWRSTS_OFF_ON,
 	.flags = POLL_CFG_GDSCR | RETAIN_FF_ENABLE,
 };
 
@@ -7821,8 +7840,9 @@ static struct gdsc gcc_usb3_mp_ss1_phy_gdsc = {
 	.clk_dis_wait_val = 0x2,
 	.pd = {
 		.name = "gcc_usb3_mp_ss1_phy_gdsc",
+		.set_hwmode_dev = gdsc_set_hw_stay_on,
 	},
-	.pwrsts = PWRSTS_RET_ON,
+	.pwrsts = PWRSTS_OFF_ON,
 	.flags = POLL_CFG_GDSCR | RETAIN_FF_ENABLE,
 };
 
@@ -7833,6 +7853,7 @@ static struct gdsc gcc_usb4_0_gdsc = {
 	.clk_dis_wait_val = 0xf,
 	.pd = {
 		.name = "gcc_usb4_0_gdsc",
+		.set_hwmode_dev = gdsc_set_hw_stay_on,
 	},
 	.pwrsts = PWRSTS_OFF_ON,
 	.flags = POLL_CFG_GDSCR | RETAIN_FF_ENABLE,
@@ -7845,6 +7866,7 @@ static struct gdsc gcc_usb4_1_gdsc = {
 	.clk_dis_wait_val = 0xf,
 	.pd = {
 		.name = "gcc_usb4_1_gdsc",
+		.set_hwmode_dev = gdsc_set_hw_stay_on,
 	},
 	.pwrsts = PWRSTS_OFF_ON,
 	.flags = POLL_CFG_GDSCR | RETAIN_FF_ENABLE,
@@ -7857,6 +7879,7 @@ static struct gdsc gcc_usb4_2_gdsc = {
 	.clk_dis_wait_val = 0xf,
 	.pd = {
 		.name = "gcc_usb4_2_gdsc",
+		.set_hwmode_dev = gdsc_set_hw_stay_on,
 	},
 	.pwrsts = PWRSTS_OFF_ON,
 	.flags = POLL_CFG_GDSCR | RETAIN_FF_ENABLE,
@@ -7869,8 +7892,9 @@ static struct gdsc gcc_usb_0_phy_gdsc = {
 	.clk_dis_wait_val = 0x2,
 	.pd = {
 		.name = "gcc_usb_0_phy_gdsc",
+		.set_hwmode_dev = gdsc_set_hw_stay_on,
 	},
-	.pwrsts = PWRSTS_RET_ON,
+	.pwrsts = PWRSTS_OFF_ON,
 	.flags = POLL_CFG_GDSCR | RETAIN_FF_ENABLE,
 };
 
@@ -7881,8 +7905,9 @@ static struct gdsc gcc_usb_1_phy_gdsc = {
 	.clk_dis_wait_val = 0x2,
 	.pd = {
 		.name = "gcc_usb_1_phy_gdsc",
+		.set_hwmode_dev = gdsc_set_hw_stay_on,
 	},
-	.pwrsts = PWRSTS_RET_ON,
+	.pwrsts = PWRSTS_OFF_ON,
 	.flags = POLL_CFG_GDSCR | RETAIN_FF_ENABLE,
 };
 
@@ -7893,8 +7918,9 @@ static struct gdsc gcc_usb_2_phy_gdsc = {
 	.clk_dis_wait_val = 0x2,
 	.pd = {
 		.name = "gcc_usb_2_phy_gdsc",
+		.set_hwmode_dev = gdsc_set_hw_stay_on,
 	},
-	.pwrsts = PWRSTS_RET_ON,
+	.pwrsts = PWRSTS_OFF_ON,
 	.flags = POLL_CFG_GDSCR | RETAIN_FF_ENABLE,
 };
 

-- 
2.56.0

