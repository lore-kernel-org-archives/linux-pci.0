Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795442187;
	b=Yh0fZSuqIJ2tXvEMhrInB7GDdqCZQqP2jfXrWxX1R5hh7A2kLVqDCWNVAanc2PJUfe8L
	 z+5q6JwHx9BRmD0DF/glfTM1ek3mNwxZyxbfTQ5d+iW0SrJww2QHGE58pm8gRiooPdhef
	 ZI6Ag6boI5hnvPnTWqWbwB8dNA+N9H59AXLJUcLuHbonWDvuAOfNjp89lrfLNxkj8xw1n
	 1Q30KWq2ZIW0EOq8Hzzb2WqrjwdH+sJqE1TDU2AVPLokfFhrGOKRXCRRQQUU6sNGYm6MM
	 l3ee2KGGeP3yeGo7Fy5KVZwjmUsdqTvptib/9iUVeUHCbt1z6Ba5zjuz6o6H4Ai+oFg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795442187;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:X-Received:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-ORIG-GUID:X-Authority-Analysis:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=fdPleMKS2IC93aynK6NEkJ3p446vokYhvbwvmK8b/Kk=;
	b=r5RmBf9dUqZaANUE18M5HZg3ovzXdxXM25yQKHWk0uYxsPs9Z60NpICBvdbZj6QDgBOu
	 OWvPdLf+hgZ4csUGqhco4znvQtgI6DqsN2DfQ1PgJrZ3B1dpL+ESWVmNzD8BFJyqI+ziA
	 MivnWIbZ6JfvtZaaXzmJVDHfhUf0aX4oaxRmjHuiwNxePLt0ZvYFstP4RykJ0nvkKF4ez
	 wsVp2uMVDfwkV/v5+xtoAyjGkqqCAOa8Jm4sFaWA6eMW5jaukEjenTsp+OFz6sH4oifwZ
	 u7njHcA8F4RUBbrzs45rYQrytVY1OWF+NEAlXHnZzPTZyPU39bQBHI26/MVC4epNWxw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=abTfYYKd;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=DmpkH3NC;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54745606A33B
	for <linux-pci@vger.kernel.org>; Mon, 23 Nov 2026 13:56:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 54745606A33B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=abTfYYKd;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=DmpkH3NC
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6ANDL1kb2086021
	for <linux-pci@vger.kernel.org>; Mon, 23 Nov 2026 13:56:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	fdPleMKS2IC93aynK6NEkJ3p446vokYhvbwvmK8b/Kk=; b=abTfYYKdVVxr89hG
	gG7xas1cvb2O9ZkTi3giz7uXwF+Wl/+Sa0ez4lSmOqUee6+Ouh+3ZhMPOYSoFL5H
	NnZTTBtSE15Gxh6LGjXJDDTw7TF5FNfsXC/Uy3ufbPn/PZ6bqQiXyoFqCeJDo44M
	4GJVH05GJvJS0KACNC4YSisoic9I2dpZKVEsxEiMztK3gNtCHXhELui7pQzOuLNI
	A4wnVzBtjZQnOMF4F18mDhRPKtbEMqS6rvmellhk6GMgL4qZmNz5HQphOUUd+IbY
	+S6cp1fIcIG9Gm8UembnMBIog2Kz+J4gLllY7nVXw6xBEtRxGLm3sAlfkS6OxGVN
	RMDvww==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j4fy01nq8-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Mon, 23 Nov 2026 13:56:26 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-934963b2bc0so629790185a.3
        for <linux-pci@vger.kernel.org>; Mon, 23 Nov 2026 05:56:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1795442186; x=1796046986; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=fdPleMKS2IC93aynK6NEkJ3p446vokYhvbwvmK8b/Kk=;
        b=DmpkH3NCBuuRUnlyNwToYClpWU8Fij3c4cxS9TEoMctX6+TJPycE368lwVpDZS++IL
         lTuPhzwR71zgAE+NMzHh9utJh265CjYOqTjCOVgahIuoQkltX7BZBZzCrGJK3RePKr1i
         f9/05QAV6CKVAcQjygXZr3rBqd5k9V4cFSHOys6G33G/nMiHrwfM6SZSQb0oPiH6PPxB
         El7PslY+/s95FZlEYR+cW/asEj8VqS38D69+UJbLluh6uiyQJwFJJmwmm27HZ4jZ7pGl
         1h3ykO3MQGBmaPszg2wavS0j3u6Dj7Nz6otnSW3GYfo+ntw1Or0Z8JeU8Huv1oEgET98
         vTsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795442186; x=1796046986;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=fdPleMKS2IC93aynK6NEkJ3p446vokYhvbwvmK8b/Kk=;
        b=o7PJL7s4uPuui6+FwgEGo9f58cmQUCPReu09JzpEgvEOc+AX1HsdOGHxUfd2f+layC
         XmcnwGSaGiwfK4hLwOg2tzuXzbTYlOp6q/65EA58DG9+IzeTtyDRlr7eYwZSzEJBMXr3
         RrYEvWgIeAlFAjR4eO8HWpoW4Qhm7OGQyrC0O0C2LJWEvgdx0y7x7GzNm95oqlrtXlls
         avjR4qGG49EgiIbPLV8ySaDFaKmB0RYncOGqsdsUmaRLwr/yUZRhWhMpdORLl1BbrEO6
         QD4FMse9l/yc4BiKx0H3GlBYgz7dVKjy7ysF3eHaucqc6h2owu0cF7/6u4GrdUzvOgc2
         SKew==
X-Gm-Message-State: APuU4Z98WNTNVrJj8IeF2VK8RmBrFsErLQ4SWHAOqnR9w5b39pCMaxfl
	wzndQtMho1FNh/yhaVNS0wdKLuw/Y+CUwLq4cxKWLDBUXXKjrGGni94Fmiq7jjo3FX01MJqiJE9
	cLE5325qNIPV7aA/Oh/bjDz23ekH0lo7mmzCH1NhxiTne2Mm23tUmd6BzQZ3tE98=
X-Gm-Gg: AZFdTZcwTOqQXXuySehDWkJP4fL6AmJORkq6QhOQICf50B9wT5+D+O/uksgZhECOj+w
	8G8gq5VDmb/pGLIGbAler7EdeSQfTIFGldDlYbY6OvmktvWiZg026Cbne0X1c0mYihbhXcju/zc
	qu3VXUlaZ26bl5TKlhVZJaRz6aZNv6iS3vlC3wxUTURdKg5EmcxfK6HuoLJih777w6I9xgpjLSa
	M07F9Rs06Fp54dTQ7lzxkYrQdJrOeCMixiCelSxv1efcNnQcXbx4qQ2LEh74jsZGKrpBiXKChsM
	d1MUfhWW6HlGBmI93HGHqolTw4QRHvpEPmZ8coor2xGgDwLZhn9XDkW39aOKAfPCaN7thxxuFk0
	GXw+VBmWhISIsJ3Ht+eMZJSA2kDsBpDeB3oXV8TWm/A/Jd6jTe2zqq5e5y0AKGhNOfK6kOXY4ng
	cW4kHiSnCn8tlYWmMus7gajC2tZhG4f7/teHkYDwN2T+Oqts4TYzjkeNiXPQFjSbC/OCcIle42g
	teW6zqQ5twm1DFFDTQTX1MepTGm
X-Received: by 2002:a05:620a:4688:b0:949:b7e9:5d18 with SMTP id af79cd13be357-949ba9c4c88mr2022360885a.16.1795442185681;
        Mon, 23 Nov 2026 05:56:25 -0800 (PST)
X-Received: by 2002:a05:620a:4688:b0:949:b7e9:5d18 with SMTP id af79cd13be357-949ba9c4c88mr2022355285a.16.1795442185001;
        Mon, 23 Nov 2026 05:56:25 -0800 (PST)
Received: from QCOM-eG0v1AUPpu.na.qualcomm.com ([2a01:e0a:830:450:6c6b:1e5a:79dd:a527])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4ab6c4353d6sm21724625f8f.56.2026.11.23.05.56.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2026 05:56:24 -0800 (PST)
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Mon, 23 Nov 2026 14:56:14 +0100
Subject: [PATCH v9 7/8] dt-bindings: connector: pcie-m2-e: Add vendor LGA
 connector compatible
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
Message-Id: <20261123-monza-wireless-v9-7-450d7d764aea@oss.qualcomm.com>
References: <20261123-monza-wireless-v9-0-450d7d764aea@oss.qualcomm.com>
In-Reply-To: <20261123-monza-wireless-v9-0-450d7d764aea@oss.qualcomm.com>
To: Manivannan Sadhasivam <mani@kernel.org>,
        Bartosz Golaszewski <brgl@kernel.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc: linux-pci@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-bluetooth@vger.kernel.org, devicetree@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>,
        Loic Poulain <loic.poulain@oss.qualcomm.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTIzMDA1NSBTYWx0ZWRfX7yUluqVf3MSj
 aCakFXTgNh/n+saMlrIg8owBn8KAI87fsTSCTf4LEH5UgmcHZpW3Of2fLTbKOkqDD0CmATYyq6V
 cWB89DaArR5qcorwB3NS/bRRfN+JkqDTg8Qg+EWPsiiUpyO7dX3Fjy+dwIk6UyrC57w3j0MS/Sf
 sZH06b0qVVLdoit3IgvNZbChqbi4PLdG/O/hywhWNs8w538sfXOAED5DDzofaQ01LlvNWL/6u1V
 Y22+dZh/NIDHlHZm/G2jPsVuLn8s9OXgPMVBe5RXb4ir92Ipf5NjpDsGTwbDU/juAGkyfiL17k2
 hRydDqsJ2pc4bCoXMHGTB8G9MGG9kTtSR3gNNBqv3rUa9jwc41W1ilNdoOc5DJg8t3HPvm0IXBb
 dvntX2lIMgQ5/dDbED2bBiVFjsc9l1JD9bblkj4xhktcOzDdMqkifePDVvJyXRdfhdfSaqcGUwf
 G1w1P2f0DjnqP4DhEfQ==
X-Proofpoint-ORIG-GUID: ojecUzleG45k9rInrgEkDpaaCpGC3RKB
X-Authority-Analysis: v=2.4 cv=QrXLTlyd c=1 sm=1 tr=0 ts=6b04460a cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22 a=EUspDBNiAAAA:8
 a=VwQbUJbxAAAA:8 a=M8sXMW5dAYDte-7YvdsA:9 a=QEXdDO2ut3YA:10
 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-GUID: ojecUzleG45k9rInrgEkDpaaCpGC3RKB
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTIzMDA1NSBTYWx0ZWRfX7Olr36Np32rB
 7NaPqcpIGV3EbnanyrT4xQSrcpKtV7awtq9dyx13R6v+R+oksQyfcDeyPtYoiIDdIkS7AhehbEQ
 vGgZUM83iHwzKRTY1Lty+24WrioHSJ0=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-23_03,2026-11-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 suspectscore=0 phishscore=0 spamscore=0
 lowpriorityscore=0 adultscore=0 clxscore=1015 malwarescore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611230055

Some modules (e.g. the Qualcomm QCA2066/QCNFA765) expose the same M.2
Key E interface signals but are physically soldered as an LGA package
rather than plugged into a real M.2 Key E connector socket. Such designs
are not actual M.2 Key E connectors, so describe them with a dedicated
vendor-specific compatible while keeping "pcie-m2-e-connector" as a
fallback for the shared signal semantics.

Add "qcom,pcie-m2-1418-lga-connector" for the M.2 LGA 1418 found on
Arduino Ventuno Q (Monaco Monza).

Add "qcom,pcie-m2-1620-lga-connector" for the M.2 LGA 1620 found on
The Lenovo Thinkpad T14s.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Reviewed-by: Manivannan Sadhasivam <mani@kernel.org>
Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Signed-off-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
---
 .../devicetree/bindings/connector/pcie-m2-e-connector.yaml        | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/connector/pcie-m2-e-connector.yaml b/Documentation/devicetree/bindings/connector/pcie-m2-e-connector.yaml
index f7859aa9b63469cb43919c0b5719c18694c5364d..ce6173a0ec41cfe8ab4a5780940999c18674ab7e 100644
--- a/Documentation/devicetree/bindings/connector/pcie-m2-e-connector.yaml
+++ b/Documentation/devicetree/bindings/connector/pcie-m2-e-connector.yaml
@@ -17,7 +17,13 @@ description:
 
 properties:
   compatible:
-    const: pcie-m2-e-connector
+    oneOf:
+      - const: pcie-m2-e-connector
+      - items:
+          - enum:
+              - qcom,pcie-m2-1418-lga-connector
+              - qcom,pcie-m2-1620-lga-connector
+          - const: pcie-m2-e-connector
 
   vpcie3v3-supply:
     description: A phandle to the regulator for 3.3v supply.

-- 
2.34.1

