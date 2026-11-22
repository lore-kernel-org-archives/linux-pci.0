Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795316222;
	b=xwKp/CntDuhE+5/awladmyAMeOjh/mbYzwmAdiaFIv62FKB5+27jPW1hG3rrg2uZIUGC
	 QU9QONo1daSF10cDUPuL2jB9VKyiBSNer72kUEyONZId45YX3wXsh9X3+QtMuS5l91urH
	 D7CxkrG+jXOGiI14CddGQI5GRoamJT6uvJ/egluSrlFm5LSDqv9X2LFDMSn69T2AI5w3b
	 CYxHUh23D5helMDHYtevMbgjCnmxqlUfKHrjkcL25Esh32mWcF4ReU/aNfMntcAsq0iOr
	 g8I+Xi+Pd6EdZvibaTFdgbUOWDkpAjwt2Acr4D7Oi2Cekvq2i99wOxGg7vY7Tpi4OKA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795316222;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Proofpoint-Spam-Details-Enc:
	 X-Authority-Analysis:X-Proofpoint-Spam-Info:X-Proofpoint-GUID:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=RpNdZRCvOUqczt/I6p/62SfdiYMe0geYQBIESrCqGvM=;
	b=IAsIelB3mDzaWFMf4S0VE9ZLanmP49FyFp4PMLAnxL/4TW6BOgDnOn2CTc2g0QD3kiJc
	 FcWurn093YdUcpivxzJcXwSGQwjipb3YJeigC5qlk4r4WI/O6Kg4w+6kjZHHKMCOZHWLy
	 9AThZEyiNueJonoo+VLA2o1weyGsMxf7a1s8z646jlx/CbqwswxQ2g4kbgkJYePnxsvkY
	 ZXCFhOyb8cuiH2zNCCwghnoui8tHG1Fq9z1S59yRIbbo6wmXdG2BNRxV/Qzbd23N5b+J2
	 75GgAv+5OPwyysfmb01/7qUkVpllfzm5WhNyqve/HWAMp8ElAeevOo50862M5MjY9cg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=K71w6Paw;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Nq6ghdv8;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDF39606A320
	for <linux-pci@vger.kernel.org>; Sun, 22 Nov 2026 02:57:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CDF39606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=K71w6Paw;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Nq6ghdv8
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AM083J31648632
	for <linux-pci@vger.kernel.org>; Sun, 22 Nov 2026 02:57:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	RpNdZRCvOUqczt/I6p/62SfdiYMe0geYQBIESrCqGvM=; b=K71w6PawdporSph0
	dnKuzUY4F29USvSCrf86yHj625sjEf14XoUba8J3V2lF1Jio/iZSLyE4RW2A5yUf
	PxRYAEkNM+mz2tiZ63EvyUC9At1Pl0PT6iJonVfQNJro4WxQ7Q6Hehu7XaoJA0HF
	tvr/AvbScps78NkPhtQsg6JKhuq1wXzVf0tp8pFadlU49zsFyEISoEqjNWyM/cqe
	p4IgsWcbjHjx9VlA3cajuYFZsoYMyktl96jPYtgvdgXqanrwyftNhOM90NqejHjs
	eBAJEXT5l05FJH5Fh8uQKUF0COBCkWxyDsUtkBJeGOiMypg7DCaTeCDt5zriihmI
	kalV0A==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com [74.125.82.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j32mgamfw-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Sun, 22 Nov 2026 02:57:00 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id 5a478bee46e88-33c35f5ca6cso3056493eec.1
        for <linux-pci@vger.kernel.org>; Sat, 21 Nov 2026 18:57:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1795316220; x=1795921020; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=RpNdZRCvOUqczt/I6p/62SfdiYMe0geYQBIESrCqGvM=;
        b=Nq6ghdv8MvY7aj7tfhoUEUAlZ5do7jEfscF4NkgVUuGFBs/MjxvLD7WQb7mMUSxsDl
         N/wAbQclsc/vxW/YpziH2bJhSkyvzjbEzkHm3YJ8rY/Gpd8b/KkPfylI1qMSh2hRWlNZ
         J01q/HBfQYo6xiyKbRLe+fOhBD1KUqJpOFZ2xbXw0hwvrN5lrPKE6kYpSz4Q8AJFkGd7
         uNu/jPH/cfX+aHZJz1jZf3mC1EsHWiBSiP2uYGNrARY/Fclql4LQk6IZ2E4XkSYupvne
         NpyBIDSEGtIp4r5e/X0mxeI6xuJ2uGV3E1fcrHna1kZqnLxQdcEaCeB4NM4CCRVouGi3
         670g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795316220; x=1795921020;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=RpNdZRCvOUqczt/I6p/62SfdiYMe0geYQBIESrCqGvM=;
        b=hig0GmJoI23pLFk4mJ0CrO+NrYBVZW3mqJAk4GpaeL0NLJj2OiqWjAda11DSgCbEWy
         icQKL/6cOp9kYlw1dsGD7wOvFCefpfrDdIUhIHDNmjjyMSbrtRRj8BklWaYMykQ1ZvfU
         oBy7dftpRAGNm2rO1QDro6/tFui4hdTFGwIEJ9Rm1tpf/sYpxWz6YN465dkoxzF4NnP0
         IGec28J7xJXBX0mD7DxtGe94ScqK8JKZ+HOE4U09yqbQXaeNq9yn8HlTf/2AAr08VUmp
         z0217jnha0M5Pa/CCbSpR8sbcjUfPEgFbibAdfj23SQ7VOzjbZX8geo/8junLxkkWgBV
         hmhg==
X-Forwarded-Encrypted: i=1; AL+hErGXp38rj++ad+ufvZp+g6XCoMh50bLjSmpWL1hk55oGw+0JfGHhCtVYfosGEpN30MkNTM08Juup4kc=@vger.kernel.org
X-Gm-Message-State: APuU4Z+D/CGQlKrtnxV3J7O3KUWfaG4tQC4wRXBeEKAFRe1867vK4sol
	PUanX5zDoyid2zJrEq7IBiAhh0dNFSSwqvCwIjfNsTOBXti6kM1t/Ho59WbSOj027EuYJQFUUVM
	tCI7A8i08bfOeA3YQi5PFJIevrxJYxrsLZ7htK582+N3Wm6Tuq3friaGJ0LOkcXc=
X-Gm-Gg: AZFdTZdbl0SniDcCtjALmjVg+D5CVGYkpA5mDES5n1Ini/pyVSyjMkvZA5pwgGVR9LS
	lPPgCfXdGyFtBjZW7BiIdnwtk/oraMyzgd16B0fdcbivGkfOyCv1USHJfJGsI326h01RsnZejYi
	pd69qeCP9GGi24c+B34B7VtD0mndWIYTukbnj6MSZoXEMK3aG4u6jqNFuWnlIaz0ipmotzLQCzI
	XPQzYEfZFbpLzPB0M8257Q1YPzeCFBA6QodlY/nDq5gXsDIcvfnjVvF4p638V0pj6tyaXuNvj+3
	EbZfMxS16lV3eJ7XjqXDVoPRv0gvixdzKBK6mOcRY4OAFNjOLA5X1y+V9M+g3wi2S3DxQmOPLrx
	PQ5hl/KRVHWnZx3pWgh/9Iqjpj+3jsKP1vystyQ3SzpG9AEiKjges36XlOeFgZ8KbK6HusiA8Zo
	pRzWT/3FxY
X-Received: by 2002:a05:693c:6010:b0:385:2057:eb95 with SMTP id 5a478bee46e88-3857073f2a3mr10087787eec.31.1795316219738;
        Sat, 21 Nov 2026 18:56:59 -0800 (PST)
X-Received: by 2002:a05:693c:6010:b0:385:2057:eb95 with SMTP id 5a478bee46e88-3857073f2a3mr10087748eec.31.1795316219213;
        Sat, 21 Nov 2026 18:56:59 -0800 (PST)
Received: from hu-krichai-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-386aaae4960sm312044eec.18.2026.11.21.18.56.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Nov 2026 18:56:58 -0800 (PST)
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Date: Sun, 22 Nov 2026 08:26:17 +0530
Subject: [PATCH 04/11] PCI: dwc: Preserve glue-provided eDMA HDMA channel
 separation
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
Message-Id: <20261122-nord_ep-v1-4-6d8839ffa9aa@oss.qualcomm.com>
References: <20261122-nord_ep-v1-0-6d8839ffa9aa@oss.qualcomm.com>
In-Reply-To: <20261122-nord_ep-v1-0-6d8839ffa9aa@oss.qualcomm.com>
To: Manivannan Sadhasivam <mani@kernel.org>,
        Jeff Hugo <jeff.hugo@oss.qualcomm.com>,
        =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Frank Li <Frank.Li@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
        Niklas Cassel <cassel@kernel.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Jingoo Han <jingoohan1@gmail.com>,
        Vinod Koul <vkoul@kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Abel Vesa <abelvesa@kernel.org>
Cc: mhi@lists.linux.dev, linux-arm-msm@vger.kernel.org,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-phy@lists.infradead.org,
        Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795316183; l=1310;
 i=krishna.chundru@oss.qualcomm.com; s=20230907; h=from:subject:message-id;
 bh=rD9zOfPOcAYlNN684/JsuvviV/gb5ok1TJTsrxdDyck=;
 b=/lOwFB1qjP7iTr8eSfhVpDz71Nc9Af2j4lHx6UdjaMj/dm9tVfScEt2jnKrs8S68TXY5KV5yF
 KEyzdXp8En6Dfq8cCoXNyUl6qyeeiGruxZavENr+qcudrrjvKu9e4aG
X-Developer-Key: i=krishna.chundru@oss.qualcomm.com; a=ed25519;
 pk=10CL2pdAKFyzyOHbfSWHCD0X0my7CXxj8gJScmn1FAg=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTIyMDAxMSBTYWx0ZWRfX/zooBkA5ax+c
 m4viFQLCREVyZQjH3PVKSd0ctbI3R3/Do5jG+4gyfGVBhxM20/VkPNcFwuNZqfuNdey3P6ExG8U
 x4d9lEx9euaeQ/D1FDe7LuxZvOxVbhZoD1ls7QjQLrQub0RjV4PEncyxgKm2NkhnkevHmur/6xX
 yDGiSvxiBJWILOHu+arn2E5ZIAD7b37U6oOqmCz3q273JrW/XnNQdj13Kv+gAPInmO0QD7VST+x
 pdu7l39TaJ/mxMHoTq+SbYKpTvwRU4SxSbdsGvrNyPQp+ovt4uvsda0Ep2eDT2nkn3M19wR3BXU
 0ZymzMtqCaGa9U4bsQFvQDhl4lbhWwDUr6rbQ7w9psdMG55nj21r/CH6B4VjmBNtKbStrcU1WIG
 4+eiStjKX0Dh9OzgptGyqmjMQhH/pvx/p+a362pnZcDyaFu/BySDqUYWLnvQpRZqHOuvB0WBYLr
 8IWDkRIsBZ83rctR7wQ==
X-Authority-Analysis: v=2.4 cv=OM+yTiaB c=1 sm=1 tr=0 ts=6b0259fc cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=Py5lcOcq67Lbq8UMOfUA:9 a=QEXdDO2ut3YA:10
 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTIyMDAxMSBTYWx0ZWRfX5oC0IqeYd3DX
 eG/xNHqKgvOx+d+4+UiEsAf8h13Ia6Rd0rmzsgeOizRUpnK9HVnt2im0Rq3Rl8ZOLSpofgK1OwH
 shtGnJXR/Hrhtmxi2tcSnOajkxURKSg=
X-Proofpoint-GUID: UW8iIs_UwK1WgTOo8EPCh3uuyOAteIUI
X-Proofpoint-ORIG-GUID: UW8iIs_UwK1WgTOo8EPCh3uuyOAteIUI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-21_06,2026-11-19_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 adultscore=0 impostorscore=0 bulkscore=0
 priorityscore=1501 spamscore=0 lowpriorityscore=0 malwarescore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611220011

dw_pcie_edma_init_data() unconditionally programs the HDMA channel
register space size (ch_space_sz) to 256 bytes. Some controllers space
their per-channel HDMA register blocks further apart, and a glue driver
knows the correct separation for its hardware.

Only apply the 256-byte default when the glue driver has not already set
ch_space_sz, so a glue-provided value is preserved. No functional change
for existing drivers, which do not set it.

Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
---
 drivers/pci/controller/dwc/pcie-designware.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
index 12f102f48d5d..d55d4213be33 100644
--- a/drivers/pci/controller/dwc/pcie-designware.c
+++ b/drivers/pci/controller/dwc/pcie-designware.c
@@ -1041,7 +1041,10 @@ static void dw_pcie_edma_init_data(struct dw_pcie *pci)
 		pci->edma.ops = &dw_pcie_edma_ops;
 
 	pci->edma.flags |= DW_EDMA_CHIP_LOCAL;
-	pci->edma.ch_space_sz = 256;
+
+	/* Default unless a glue driver programmed a different separation */
+	if (!pci->edma.ch_space_sz)
+		pci->edma.ch_space_sz = 256;
 }
 
 static int dw_pcie_edma_find_mf(struct dw_pcie *pci)

-- 
2.34.1

