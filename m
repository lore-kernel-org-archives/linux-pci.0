Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795719612;
	b=RmsYBDlt4niWvCvrHF0ASbzrLnb3BeQVH/JQPbKGWdJLRJMmww3DiF0Ax6QcH33ARxtS
	 2qW0QtThezM7G2mBAu4N5ZSKpO3xz1WSVCR91YYOIBpHTvmfKej8pxi4gGxcqOdIkxmzu
	 etK5mZoOfkf3OflYkW4cCjoHcv0LqLjEFF3Z5CJUwngslOSkcCdDdZPREQY8efD/TEkei
	 Ni258/EyqXCnz/GtwhQo/DUKo2XsIGVyu6qgrnI5GSxPcHKz/jN1z/Vt9dJAws6NUoMtA
	 Atr1i5LkhSjDXJ3WS5DwPdyQxd+wBZfgsmrBSpMkiDYpUCoEYIBYv/3rKEVi02qUFIw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795719612;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:X-Authority-Analysis:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=pDb1bViDSMIyx76M0CQL8Q8fh+r/vAHy8VyY0ktLyHE=;
	b=O7GC9JyplYtbfvyjY1RAlBKvg6FALE6tBWYkjvBLD3gBcZttTRDhdRITyAIPOdNHIL7U
	 NnLT8WQzLyPuXtr9PskLUwC4IqxAbTrwdEC0/gIfeIRcINChgNd8fLijidv8Q84VVLjYi
	 +vjOkiDDe3o6HFjxoNLM+yas/TsX/i/WQjBcuJ9SCJjnN7YxocvhLQJHFUILfkMMiBFxw
	 9RSHbheDgq8cexsAs5ZbXfSLytbIls+9VyEh2XM70/pMxo9IphIqIIQr5UXruVmF33seB
	 bBznr/Xh/XXT7NFACBqG0vCknO0Zybwa43hlayUun1hLf95rBFHKXDwmcB+vQgWhujw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=T5xT4EpZ;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=TavMYgxr;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEBFF606A6A2
	for <linux-pci@vger.kernel.org>; Thu, 26 Nov 2026 19:00:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DEBFF606A6A2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=T5xT4EpZ;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=TavMYgxr
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AQFu9ch3484266
	for <linux-pci@vger.kernel.org>; Thu, 26 Nov 2026 19:00:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	pDb1bViDSMIyx76M0CQL8Q8fh+r/vAHy8VyY0ktLyHE=; b=T5xT4EpZWtvAT+SZ
	blTm/3lR53uV5o3B97RR96hZ71sYYPLk25oxDULtBk38KbnqSzZ1bKHTqA3bkSXV
	Rj2bMCPVuSoMu9/KIqp34RQz6BIoN4jc8NDiSABcMfB3FyFaPI+Ts+Qv5R1y4tdc
	BI4NE2Q+IBsA1mchp9rcavH7fa5G1semK7BH2JjOiwlPmj4Zra45XYAHVTrZvccQ
	n+0fbe6+82PIsFJUfiGh3YY1+kOAhsk+jQmuUk/jHJtpU6wTLQ2FLtjTS+Ey+M7r
	mm5TzxqVysAntcmm54DI3RGrLFkf9QTpLST7xeVbB4o+j9CAF2XXBwO4ZEcuSbGH
	V90XoA==
Received: from mail-dl1-f72.google.com (mail-dl1-f72.google.com [74.125.82.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j6ak03gdn-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Thu, 26 Nov 2026 19:00:09 +0000 (GMT)
Received: by mail-dl1-f72.google.com with SMTP id a92af1059eb24-1b592e9841bso1629405c88.1
        for <linux-pci@vger.kernel.org>; Thu, 26 Nov 2026 11:00:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1795719609; x=1796324409; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=pDb1bViDSMIyx76M0CQL8Q8fh+r/vAHy8VyY0ktLyHE=;
        b=TavMYgxr0MylSuoQpSpfhZbVzcpnQraaz5xt5LSFtALfyBBPTgKIo2D5cmSHyKHFri
         Rkw+u3vaC0so21PBGM1D2qrXDYOzZDnxQMpYPgnuiA1vo4lAk6P3ISykmB2NsigrNS4/
         8rhMN4GUl1G/fjWQt3HIYYIYFLfTIPZuXIxHbmJ9veVOdhOK9d6OCoZAm1vd3AtOOmLZ
         9UoroSvOF7O1VlSp0CN8uYypB3FSi9BdT7K0LZywF9/zk2GCJc+n2NnrhFBNe6uZPJFi
         8JWnQrbL3kc6kIomJ6Khl0D8si3QtkTS4nUqAAPjFxfBZZfqGMOT7snWvKKYnH/zUyFI
         d2uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795719609; x=1796324409;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=pDb1bViDSMIyx76M0CQL8Q8fh+r/vAHy8VyY0ktLyHE=;
        b=EATMHeG0mxllEF7PRWZ4eg/TRQe0ydyohcoNy0Cbfa5XcGY8CgoBHh36sKXJSxEn37
         KCjZNmM/br/9lvn28762lEtdiWRCBCpjO7mTL/HTgIlYK+yi9QSEn5wEn4jmRedMo45w
         BViD3hIm8ff0P11HH9X5pEuZlmhOVgvCv9Jk3/7ivfwB1LsUngf3KZx0fm9PI8ei9o8k
         e+sdDKY+DkEUA/ovTeeqx1QRvwyNyYz/oPVqRwvzbMmOt8VtpozRUMv/5PupZjLqgtjA
         QPMsycP171Q9CL//N0PNtRybRnxlHx5uVP7VvVoXCjOB53t5jZXfu8H1LCuyXD7n3DtR
         ypZw==
X-Forwarded-Encrypted: i=1; AL+hErGe1WksRrehzFYbwtd70/aOnDDsWmGfXSU6Xx+KmtWo4B9UgHpG/YSl5R6lG+xWm7ycu4nxUNFLPgM=@vger.kernel.org
X-Gm-Message-State: APuU4Z9izN3XQIEZduwBVdFIPz6rIft3kAMgJ4kWbX1T8WTU9le0rAW+
	6JS8iI/d0yJcsO2+z2CPw0wNhIuI7JAwqhU4deRqy323nIl1+LvWDuHPL1tsMraRZ9ydgZ4BIox
	h2X0yDyqok/PUQ46XJ44OerehP3IjHWG1Jnt/mk68iY5wIRGvw0UBIJEH2cJuE8U=
X-Gm-Gg: AZFdTZf1oGjeFV25J+TjgnbPoGq+2Kuaa51zGPRNsu6CeHdpIg5sCqfIL5ecRTRHD70
	tZK6HC+0Aay/dD6yfvQpdP0aBKUO316AoF7nXcR8d5uQFWaZ4eY1x+oVdckErwAv+ZzgIpncFwh
	3SeF9c3DLOrBEsGlMFWhL819kou2MMqZ2CZhkZgTuRipD9Hef80nSRE7rXBwZ7dYgoyGlHZ4tRM
	0ZQPr/zFOKwGVWPQhcKAVYhuHnwRenDeirygZ87vULjTY5uVULJWSvoBv0i5aB3gAgrNwAXBkil
	x44ZHTL+22zINHc50nARFp6V3EIdmnSOrQ74/pTOC+8g9Qlq2UilLAvQpaOuf4HcuWLUCClJczY
	MTHY5X8lTnQ6Zt62M5Ngz8KwUh7pV0XQRgeo6g18uGwc9LOI/oPWV+s43RAsIIXKF1Wt9pexg8a
	G+wDgA
X-Received: by 2002:a05:7022:4181:b0:1b0:4272:4282 with SMTP id a92af1059eb24-1b5568ba440mr34051534c88.17.1795719608726;
        Thu, 26 Nov 2026 11:00:08 -0800 (PST)
X-Received: by 2002:a05:7022:4181:b0:1b0:4272:4282 with SMTP id a92af1059eb24-1b5568ba440mr34051461c88.17.1795719608015;
        Thu, 26 Nov 2026 11:00:08 -0800 (PST)
Received: from hu-jkona-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b5567ffa8csm60868190c88.7.2026.11.26.11.00.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Nov 2026 11:00:07 -0800 (PST)
From: Jagadeesh Kona <jagadeesh.kona@oss.qualcomm.com>
Date: Fri, 27 Nov 2026 00:27:12 +0530
Subject: [PATCH 4/8] clk: qcom: gcc-shikra: Register set_hwmode_dev
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
Message-Id: <20261127-usb-pcie-gdsc-suspend-v1-4-485a08ffdc6f@oss.qualcomm.com>
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
X-Authority-Analysis: v=2.4 cv=T4oZ3PKQ c=1 sm=1 tr=0 ts=6b0881b9 cx=c_pps
 a=bS7HVuBVfinNPG3f6cIo3Q==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=zroWNzDgHOBiqxzc7EQA:9 a=QEXdDO2ut3YA:10
 a=vBUdepa8ALXHeOFLBtFW:22
X-Proofpoint-ORIG-GUID: fPbVe5b2C3HuzvAANBGwehgOsQfUjJve
X-Proofpoint-GUID: fPbVe5b2C3HuzvAANBGwehgOsQfUjJve
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI2MDA3NCBTYWx0ZWRfX/JCeNElx0Cn/
 4yQZlwzpVYJXc4tUWKdaZg/gFU2Y3pnUaCDRFVr5XXjIY07W4DJ0xeENtVVtmdTzkmA0VaQOZxp
 MMAtfS9zW4frcSs9rFTg3A5RVP9FrIDtXL1GBFgWqdgO1292dbYd8V28w3SHMywHOzHMuOJx86B
 prJq5iniACQbk/IhducHW7ycrvgdNqWhHzeItkp3P1yjPnf97i3RnhlqyLnIpRnD+ckpE7TBn0+
 Fb9J+y2WvR0mgzanQfGt0tnYhlbOx/YqyoLelUvMSjA+DTXftx0D2JQkbxjdRw0Hi7gw4cQRBGt
 855cvzq3e5YS2ry66mOiQoHUyEH4nnmwWXvxwnuZ04x56AfiALMUx894mP5v2wTydR7r2zO7Y1p
 QmSwu1+jUJMzIinQdX2pqyBt43ndNgEbRp8KnxKLlvWgjjs7kSMbkYTK7wiO8pzMTQNMZiMqDc2
 NLLRb0VF5n6GLAxTX2A==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI2MDA3NCBTYWx0ZWRfX3mi0zFAeLw4g
 epQuUiM0+HH5SZwZMpVt6SECe9a2X/IHmRdAhK9b9AU6geFMklQPgZGY6pUfTItus7rQXNjE9FL
 MPQ7hIW8ocMGbjt0kY0EVf7R7xKvjpQ=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-26_04,2026-11-26_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 priorityscore=1501 spamscore=0 suspectscore=0 phishscore=0
 lowpriorityscore=0 bulkscore=0 malwarescore=0 impostorscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611260074

Register gdsc_set_hw_stay_on as set_hwmode_dev callback for USB & PCIe
GDSCs to allow the USB & PCIe consumer drivers to keep the GDSC ON based on
the requirement in USB host mode and PCIe non-D3 cold usecases.

Signed-off-by: Jagadeesh Kona <jagadeesh.kona@oss.qualcomm.com>
---
 drivers/clk/qcom/gcc-shikra.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/clk/qcom/gcc-shikra.c b/drivers/clk/qcom/gcc-shikra.c
index 13c99a883e29877d9a929f26ca0b3b04b1ea0b11..075a9a5e503d0a1aa9ea2c772216a19f0feb16b5 100644
--- a/drivers/clk/qcom/gcc-shikra.c
+++ b/drivers/clk/qcom/gcc-shikra.c
@@ -4036,6 +4036,7 @@ static struct gdsc gcc_pcie_gdsc = {
 	.clk_dis_wait_val = 0xf,
 	.pd = {
 		.name = "gcc_pcie_gdsc",
+		.set_hwmode_dev = gdsc_set_hw_stay_on,
 	},
 	.pwrsts = PWRSTS_OFF_ON,
 	.flags = POLL_CFG_GDSCR | RETAIN_FF_ENABLE,
@@ -4048,6 +4049,7 @@ static struct gdsc gcc_usb20_gdsc = {
 	.clk_dis_wait_val = 0xf,
 	.pd = {
 		.name = "gcc_usb20_gdsc",
+		.set_hwmode_dev = gdsc_set_hw_stay_on,
 	},
 	.pwrsts = PWRSTS_OFF_ON,
 	.flags = POLL_CFG_GDSCR | RETAIN_FF_ENABLE,
@@ -4060,6 +4062,7 @@ static struct gdsc gcc_usb30_prim_gdsc = {
 	.clk_dis_wait_val = 0x2,
 	.pd = {
 		.name = "gcc_usb30_prim_gdsc",
+		.set_hwmode_dev = gdsc_set_hw_stay_on,
 	},
 	.pwrsts = PWRSTS_OFF_ON,
 	.flags = POLL_CFG_GDSCR | RETAIN_FF_ENABLE,

-- 
2.56.0

