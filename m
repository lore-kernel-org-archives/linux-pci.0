Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E34E33ACA61
	for <linux-pci@vger.kernel.org>; Thu, 14 May 2026 04:13:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778731997; cv=none; b=DN9gUxyI016WpTbiMDGoegLOgKYQ/xXYsONX7YLLPyyY/NmTjcDBizob1pI5qcz4psdtsfoaPTYnzQ21NvKK1awzkUMbirxD6a9aervEmxH7DydMtIinX+3ou3kvjtkp8xnmk6MOa3pklFg6lJM0KzFT0Tt+l8xtMIJcSDqtvP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778731997; c=relaxed/simple;
	bh=JwW41K8IdkdgFGE2IHpnYGuhMsXkm8hjOGtwlDbRcpM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=YIqcTB6UTlHN9O7+V2o9K8cAFi4357x3nItsgccvKcTLUzF8+6aPFVl7ZsdbWVLv2Xp9ih5Kc6riR8rTQgqJ1lU3vMNKCYt6sxZEYpx145nxA8d18KkeHJN0xU5MAvtaytey4FIoYIXu8lZU3DGkSPtdoCx4d4O4OpKlu8VrWGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Qxs3bZch; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=LeMuY62y; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Qxs3bZch";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="LeMuY62y"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64E3c3SC3430137
	for <linux-pci@vger.kernel.org>; Thu, 14 May 2026 04:13:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Drn7srxvV0vFK1yAhzD7aPenQzPVdFLlBpIYOLOBz4A=; b=Qxs3bZchewyCJxYh
	kqnp+jnlp3WTeHVJq3hIiuQkRYsZ1bsFMXkISbWRq9UivlByFhCYRP1jVdZcXidF
	zJ+pWWFrm2vABIsGELi1B5Sd7RbqtO4pxeXkawKuBSQcdLm7RKjFdmWrzezoFbgh
	np5AkAUyA0g6xKGLtQ5LfkcMzZr5FtS92p98PV/5ru1qeKLN6YTZPis/ozz7RBtR
	pZKjTHLlhPs4E02rr4mm9qwPvtMe0rq9MxBB4xMIcd59JJFsThq0oVB1GIzg29ad
	AaudpBZAJAcKIsgV5q1O0Oa0sl2Q7EEM8Uv22T+8HP5QV4AEK6ZQLDnRQjVl0XyJ
	xpkD6A==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e4qmckjxq-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Thu, 14 May 2026 04:13:14 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-836d0184333so7338238b3a.0
        for <linux-pci@vger.kernel.org>; Wed, 13 May 2026 21:13:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1778731994; x=1779336794; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Drn7srxvV0vFK1yAhzD7aPenQzPVdFLlBpIYOLOBz4A=;
        b=LeMuY62yfCol4oJe9gOSCg/zDkagssZ4sL87I9SKRByqgYAepiPHWT/Dv++pZyjXx9
         NTLFRHjzq6tthfCIskSgsDMrdvhOZi2jZt9UWhUQxpGP9MASwX5wchAnUF73tx/AsP+5
         YbM/pLpaRDLeAIy5smpGrKbkPQmpocZ4mzDLDkxdhGIDEzrRQYYTjsg95H8dqvIzLx4x
         gWuZw8b+/gTGgkuwk5bbRYJCPxe6kADrqrlgZMDv3+y39Wg99uQSMy147t/Gb63sm9S1
         yDKsgEP1SNbu4a9bYhQ8VCwsuTST8UdJZx0kAohZNWY5UGsCNbejXALYNlKQhUSujUFn
         YeuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778731994; x=1779336794;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Drn7srxvV0vFK1yAhzD7aPenQzPVdFLlBpIYOLOBz4A=;
        b=UHk8oj5+R1Dm8+Xdl4FopNvvcueWytq1W6AsSh0tIxzBFRbbhys15bCgllm3UsBBmz
         yyO55s6ehVrB3xrBb5T2GTkoIDaR3CdtFWF4cZpXoaafWGIV/vkcmsevsCAC1NhmVTYZ
         5PCVZePOlZ00rE7G2bquo2eSViIBPs50l4AQw7tPePQEXLeYqWWwXkOHVUVr9LRnGHgc
         vZOvmEqXgq9PHi4z8aaYOXoyGRNafvjyI3JFUpCjHjonHzZTJcOvfHLg/yPctLyEoyn1
         ieJSkNYPFNqwfAyU113GJCi+MRTcieeFcY+5Qfmjjv8+sWXhLMElgEN/TxTsAGxzznfc
         0crw==
X-Forwarded-Encrypted: i=1; AFNElJ80+05ShC6/0ti+Xh0ZGeO0fFKOyesPw3td3vIDjDo1k2pai6nv+lla1ZDK6Puz1FqBaWwSPgRWdt8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxNwi0DsB/aZGeglVGkchazK7nBXX4DlUEUxcxfr3LPGzEs6Uth
	0xrCVSDY6+qA7MxxL+Hz1TL0aGbBL7yrqvgkmFe988sIUYRzGjpgAgE+h0bsc2nEGQZp0SitSo1
	Ls/DWvGVLHRQ4mplqoKYfcyN2VU2zwm60HB3VVYVDSrgMLh/mab32S4j4U1Fd5W+CzfXvTi0=
X-Gm-Gg: Acq92OEWjEhtr0yl03DZV4qDOmkJhiLE7NHMUUShrVl8/sYT7+oFBMw5V5EjxzQipqO
	SjeOT0FmpZEfqUsB/M3hiv4d/1sUMQNDQzc2tq6l0+tfi8MsOWK3/mAvfhlzxYy67Ld56aXywCA
	xjFzfBYIttYkEOmHbU+THShCgOFLgo1xYc8g6dttMEuKVKvIHzh6PU0Q4wNbcQcm/PfY5jxpbCc
	T4DpdkkWj4vY8CfAaga1FPbn3l+336fJnxyIzv5CH4ELLi9IJS0wqsxpZIbJaXKH2KXbQNM8OJ3
	ioubb370xJ9kBZtbRTeoR/VYAU6rgaxhG4L7Ib1pe/4acfGq+sovvyS1ykemYqI25OZjfqzo50/
	+Tz675b2A+Fn5Xf+FM0TaiMHUkyeLgP23Su6L5uzJE1r4kQG74ZIhATWrMqPa5CqwrQmVuKKcKQ
	W8TSfHJtkInC6z2HTbhk2RMRdf7yXWr6qyFX6gsRgVzvWECGFLceY=
X-Received: by 2002:a05:6a00:909f:b0:835:532a:3468 with SMTP id d2e1a72fcca58-83f0546e833mr6386249b3a.20.1778731993982;
        Wed, 13 May 2026 21:13:13 -0700 (PDT)
X-Received: by 2002:a05:6a00:909f:b0:835:532a:3468 with SMTP id d2e1a72fcca58-83f0546e833mr6386211b3a.20.1778731993466;
        Wed, 13 May 2026 21:13:13 -0700 (PDT)
Received: from hu-varada-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-83f19c5be71sm1075432b3a.39.2026.05.13.21.13.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 May 2026 21:13:13 -0700 (PDT)
From: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
Date: Thu, 14 May 2026 09:43:01 +0530
Subject: [PATCH 1/2] dt-bindings: PCI: qcom,pcie-ipq9574: Document the
 ipq5210 pcie controller
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260514-pci-ipq5210-v1-1-a09436200b35@oss.qualcomm.com>
References: <20260514-pci-ipq5210-v1-0-a09436200b35@oss.qualcomm.com>
In-Reply-To: <20260514-pci-ipq5210-v1-0-a09436200b35@oss.qualcomm.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Proofpoint-GUID: kU3jDShBIeS520hGWmem1DhL1JVHlzic
X-Authority-Analysis: v=2.4 cv=Hu5G3UTS c=1 sm=1 tr=0 ts=6a054bda cx=c_pps
 a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=QcxusUPE0xsQWomV07wA:9 a=QEXdDO2ut3YA:10
 a=2VI0MkxyNR6bbpdq8BZq:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE0MDAzOCBTYWx0ZWRfXx15yzD3NZaEK
 mm0v3ihP9osy2ExUPwgyFj5IU87gW2IX/PtayP8m7CIQQ0aTDCc+Juee5S07JAfxCHnxUeH51rH
 Re8lC+G36s3LU84CIiiYbpqvs1p2TemcNMlcGhDMtxUwZv7uUpPcb6MvcFe46yRH06WI08ZoHu0
 A8Mbec1LKssdB+Gr1Py9FFiZumSwmq8arih5JuymRrbvzJqd88qNloHYbrVnL5ZQDGN0fRZbNVM
 QdImwQyXyXeiw4YvXb4Ko87hGWavqq06O/CBhWzIagEhOX54wuEyutwl8RxuQnDASS+tS9/HOoO
 wKo9wolbZRtG05CD19u6O9N+uAElr96YQNDhY7wwJJZDmzfhV3p6/dksAzsRn38qxgZ1xdhin0F
 1GvrX7PrqEn1XqYcpergaLDIJxX0fyj/sAPtXIb3yx4cMQFHxioGY+d+G5YNB4LStdFYhX4xgiY
 VDaeU1H94rZsVwyaZUg==
X-Proofpoint-ORIG-GUID: kU3jDShBIeS520hGWmem1DhL1JVHlzic
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-14_01,2026-05-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 impostorscore=0 priorityscore=1501 spamscore=0
 clxscore=1011 bulkscore=0 suspectscore=0 adultscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605050000 definitions=main-2605140038

Document the ipq5210 PCIe controller using ipq9574 as fallback compatible.

Signed-off-by: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
---
 Documentation/devicetree/bindings/pci/qcom,pcie-ipq9574.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/pci/qcom,pcie-ipq9574.yaml b/Documentation/devicetree/bindings/pci/qcom,pcie-ipq9574.yaml
index 4be342cc04e1..a75ff554c283 100644
--- a/Documentation/devicetree/bindings/pci/qcom,pcie-ipq9574.yaml
+++ b/Documentation/devicetree/bindings/pci/qcom,pcie-ipq9574.yaml
@@ -17,6 +17,7 @@ properties:
           - qcom,pcie-ipq9574
       - items:
           - enum:
+              - qcom,pcie-ipq5210
               - qcom,pcie-ipq5332
               - qcom,pcie-ipq5424
           - const: qcom,pcie-ipq9574

-- 
2.34.1

