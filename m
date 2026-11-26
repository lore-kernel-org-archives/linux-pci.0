Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795719603;
	b=juNoPOdSkzqxRmPMTb20W8xdbOoL2Ky2xUQCMfT7bqN6ESI70x82Gn/NlCiaey+Cy6tW
	 WSKhC0OTm5ZKG1OqS1m44IW043kb+/+mEfqR3zjyonJxfC8H9itpuTCMl1gJuqjzoNT/j
	 Xbs7/s1q/+KLl13p1QfomQXILArvMrDB16tjau9kG5b9Y7mstyAstoCtFpSarxIztDE68
	 DM8thFTRqqaZY1w+fxO0jJlgkUXDxsP7hsZlmCB5PG0+C6qXH6s8a4rntmgnwZf+xkcxP
	 0tV7CCM5yf3PNGub7HR9timilg8dZfyebQQxdGvZ7HLuCoC3/7MwFSoUJlrCdnAuJ2w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795719603;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:X-Authority-Analysis:
	 X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=NII0+L88Wv3q4wyUgO6D17Ai3ObjNTZatzOLfgRo1vg=;
	b=b+84KJu4RiRI44diYcH1D6khJlrkPzw9SN+Kf3eh5Ve39saUBZQlkLKOFG5WdXj2Znfh
	 uLExmePzzzGNf0Oi3VbXyPESBaK9WNuC7+eKO/fXFnD+S1Xyja8Q1xGVLnEzKvt/s1UMN
	 dW2+WH10iU5Pf8KNbopQXchGacDeAQMcKuhMoMHp10U3MtRPxDRKOonhVItMgSwNs7wIi
	 DqkDSeCTlqwbFaJCId3dfopc53+C8J5ub+p2iUHC3f43xF7CacuQTHLKz47Yi2yF7P7LS
	 fvP0kY24lAa/dt7+1cxRmyR6UAMaJqLY8ITh3Z8lx5n5cGMYt2IZrTk3zmVQA1JUzsg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=PTCW4Tav;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=NH1TwMI8;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25A7C606A326
	for <linux-pci@vger.kernel.org>; Thu, 26 Nov 2026 19:00:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 25A7C606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=PTCW4Tav;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=NH1TwMI8
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AQH3JOw3470978
	for <linux-pci@vger.kernel.org>; Thu, 26 Nov 2026 19:00:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	NII0+L88Wv3q4wyUgO6D17Ai3ObjNTZatzOLfgRo1vg=; b=PTCW4Tavs8sEGIGD
	sz8/fOge8yOQMouJw4pYBniAonjpd3qi1v40dZYuOZsWJDzyNco7HZjpzaTemJGB
	lfyX9S15RhwnPg0fUXshot5FEWJ3byCuw1fItJyIVgWbqjeC0gSevY6mTBrg+Xb7
	shXxmBvYar5xERAy+pUrE1hjJ6zJOl9JvvjTf9leLKLRDm+TKW4iFCcbdFy9tZDz
	4FshGmPhoCGlot+2Ps5Cq3gJ6lID+4jnHm1DFq3LwROaYunKW0hqRYfPMhznD0PF
	Z7ASnAYCXpmzd+MxqnEWJbJduT0y7YbG9fSFeEi/XXgR3foa3FPt3ddcUr92mFOW
	IxA9hw==
Received: from mail-dl1-f71.google.com (mail-dl1-f71.google.com [74.125.82.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j6ru38978-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Thu, 26 Nov 2026 19:00:02 +0000 (GMT)
Received: by mail-dl1-f71.google.com with SMTP id a92af1059eb24-1b592e9841bso1629116c88.1
        for <linux-pci@vger.kernel.org>; Thu, 26 Nov 2026 11:00:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1795719602; x=1796324402; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=NII0+L88Wv3q4wyUgO6D17Ai3ObjNTZatzOLfgRo1vg=;
        b=NH1TwMI82IuzS1guyMzUrgl2mrgU0bWmFE44bTBK5903QRYOT36rjsxOrQQakSUybD
         M3l8k2su/LDWxghCi74POyzNBJ6BGtFrfIHIXChzfCha0cVzhOU4qnOw3e+Xlz4t446F
         vYQq+kcKvLT9c7FZm9GPfVeXpEjkchytgZi17bZeHusEb/KuCZagAgz6o9uSaBAGhfRI
         MSrEOaeFQ8pWr/rejhJ41t+NGIR6qpaQydDZOR5cIzpybLQQrdsQ8fSUQM1TVVmoFVho
         ImE/dioYefl0vndC+QPicyiGCQUTSqvG/MhLQcALteyC4ICp5sdLtTwQVm9eAvYuJmMc
         mftg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795719602; x=1796324402;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=NII0+L88Wv3q4wyUgO6D17Ai3ObjNTZatzOLfgRo1vg=;
        b=Dm02VK5Vo2qASGtJItuXB6ALW1ku3w4PNJSAJ45MOMMJ4v0Li9UHGfvNbKmP5ZurGh
         EY3w6wFY52FIyS4ixR3DDxxPUJEBVWZtsMPd+nJbiOPIguFkUUnqfLZIjMW5itT2Q5dl
         F6BnMwLlwGUBOSsOo61UC2Wy3z4p2hECegdWxaOFHrRfDYslEsCS2CrBaa0LsAnLJxfI
         rNVzyGxw/YYQdqnQLYWdvl9xUZ2XP+cMMDP7yq4B1cVCYAMZOaP5JaPXI3jlRusmRJAG
         1e8dpyqfCn+GbvQFShKi2DccheC7ymrfXyczt4vApQkCNx2ddXwJ2335sPmyHjl/geg2
         79hw==
X-Forwarded-Encrypted: i=1; AL+hErHVPEmsUajwF7khCG+VjaUJs5VYwLvRNT0hU6MxNDjX7PgPgFjQO4Add/y+nr3vSBQXxTYKZlW9U0k=@vger.kernel.org
X-Gm-Message-State: APuU4Z9ddxZL8X1y+t9VIYX6qrgBx8XCG/1W3Zuw2r0Fg0q3A9nlY7kx
	jYkzNKMpqi6KhoBa5YebUVcRW/WzHE8TMlVK9Dves8xOtiSYytQGWNcs3R1Mo1DsgXdqLk8iJhx
	fGnC7/UnSaexgJNpAe2HrZKL48LTajQXVVVC49m7sn3nkyC/Syi22mn9O8EvPySQ=
X-Gm-Gg: AZFdTZe94Yt7bcPE8gnwHgYVQQzrQ/fuqZFJoqibWIsAbfg1rWkJ+bYAGvEdj2YUrHs
	jRVo7quzRLXCw0Sv5i7CxqGBGH9pGcmANpxkTN5MBU3leXaGzfdsB+J+gTYVR5nNXI9Z9fpwPnt
	r/N8EGxQ1jtP0yUriZayJ/JN6VI4C+G8i/uY34X8iq+w2R8p0q7ZxR56l4c628bAwpeIjPPI6sj
	3xnrt9+yMyMf7Iv4Mtcy9RHG98zrXEdwRyGtUktlq08EG+mh3HuA8LLr3ezoo3pvEE2zE6beDuT
	ETqd5HDhsNgL7CCZUsCoU8WYtNjCgHuHcpQ2l6ePyDKzFIimppsjOPudGhUgB+O8beq5DZz7L9A
	BDB1svK0aoPawIEjwImv7+7ykrwRC5QDrd36+ZIzg9j9ZT1ID66bYPPbTrJM7960HMPDYpbAnLQ
	5YhOIt
X-Received: by 2002:a05:7022:1701:b0:1a4:c892:b130 with SMTP id a92af1059eb24-1b55feaa6a4mr19781266c88.15.1795719601454;
        Thu, 26 Nov 2026 11:00:01 -0800 (PST)
X-Received: by 2002:a05:7022:1701:b0:1a4:c892:b130 with SMTP id a92af1059eb24-1b55feaa6a4mr19781239c88.15.1795719600868;
        Thu, 26 Nov 2026 11:00:00 -0800 (PST)
Received: from hu-jkona-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b5567ffa8csm60868190c88.7.2026.11.26.10.59.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Nov 2026 11:00:00 -0800 (PST)
From: Jagadeesh Kona <jagadeesh.kona@oss.qualcomm.com>
Date: Fri, 27 Nov 2026 00:27:11 +0530
Subject: [PATCH 3/8] clk: qcom: gcc-qcs615: Register set_hwmode_dev
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
Message-Id: <20261127-usb-pcie-gdsc-suspend-v1-3-485a08ffdc6f@oss.qualcomm.com>
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
X-Authority-Analysis: v=2.4 cv=cOF1IVeN c=1 sm=1 tr=0 ts=6b0881b2 cx=c_pps
 a=JYo30EpNSr/tUYqK9jHPoA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=EUspDBNiAAAA:8 a=zroWNzDgHOBiqxzc7EQA:9 a=QEXdDO2ut3YA:10
 a=Fk4IpSoW4aLDllm1B1p-:22
X-Proofpoint-GUID: xWALVKpO76GPug8Eh9MblWXbydU2kNsG
X-Proofpoint-ORIG-GUID: xWALVKpO76GPug8Eh9MblWXbydU2kNsG
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI2MDA3NCBTYWx0ZWRfX5vH6sSVVChW5
 0noht+J4Bqg3Ib8JB02s9Ly6YubkHmbAPOZVsXq7/ZLP3OPxENbCdhNKNMcTP6DXXu/EES2AGtv
 LHjCzaInRsAP60wiuxa9Av3N9rXGRg39H+Qxwp+Gr9ufZL2xeWdX6HAkh9kG3c0AL09LFCjXpu+
 9mlQJ0r2MZdDHVeyyH/ZNJa0nUQMHIXv1wvez0q6ockzoLxOi1KKu1guUPdhrc8fhbZuQJdtW6l
 h/pXPw1pAofvvpHYBu7u8/seySUzNNN1sBbrFSX/Kjq27CLv4HS0datifvRdIl9OT5IcOXmj4ou
 a9Bg/v7xbsvaYLxeEGWmV5S0AXiLHuDNJqvb/QO3M081GURH/mI8X7HtFnY9F6l61zsT81WGfxm
 wevxTQXS+ZRPiwq4TTddGIDcfel3c9qjdyAWhlPAcUXEJAjgfP+TzWbnbFHY61xVEp+naFJI+Ry
 TdwLPdMnsYltHc+Lwog==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI2MDA3NCBTYWx0ZWRfX4w7YFpLGr5uT
 H0+o5OTSOt1w5Rpkbt2tvTFJLJ2kQbZqMCB7nSjvgXpWJroVTrBdKmz98veVrs9/mB1EbVa/Ph0
 ODjubpS3FwQMyRMtUal3yuVi/WHxpM8=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-26_04,2026-11-26_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 priorityscore=1501 impostorscore=0 phishscore=0 bulkscore=0
 adultscore=0 spamscore=0 suspectscore=0 malwarescore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611260074

Register gdsc_set_hw_stay_on as set_hwmode_dev callback for USB & PCIe
GDSCs to allow the USB & PCIe consumer drivers to keep the GDSC ON based on
the requirement in USB host mode and PCIe non-D3 cold usecases.

Signed-off-by: Jagadeesh Kona <jagadeesh.kona@oss.qualcomm.com>
---
 drivers/clk/qcom/gcc-qcs615.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/clk/qcom/gcc-qcs615.c b/drivers/clk/qcom/gcc-qcs615.c
index f205de3a936170413b21173c7af9668c14495369..76d835346632ed672e0cfd896723b84c185de270 100644
--- a/drivers/clk/qcom/gcc-qcs615.c
+++ b/drivers/clk/qcom/gcc-qcs615.c
@@ -2654,6 +2654,7 @@ static struct gdsc pcie_0_gdsc = {
 	.clk_dis_wait_val = 0x2,
 	.pd = {
 		.name = "pcie_0_gdsc",
+		.set_hwmode_dev = gdsc_set_hw_stay_on,
 	},
 	.pwrsts = PWRSTS_OFF_ON,
 };
@@ -2676,6 +2677,7 @@ static struct gdsc usb20_sec_gdsc = {
 	.clk_dis_wait_val = 0x2,
 	.pd = {
 		.name = "usb20_sec_gdsc",
+		.set_hwmode_dev = gdsc_set_hw_stay_on,
 	},
 	.pwrsts = PWRSTS_OFF_ON,
 };
@@ -2687,6 +2689,7 @@ static struct gdsc usb30_prim_gdsc = {
 	.clk_dis_wait_val = 0x2,
 	.pd = {
 		.name = "usb30_prim_gdsc",
+		.set_hwmode_dev = gdsc_set_hw_stay_on,
 	},
 	.pwrsts = PWRSTS_OFF_ON,
 };

-- 
2.56.0

