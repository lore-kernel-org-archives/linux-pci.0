Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 637DE3B9D99
	for <linux-pci@vger.kernel.org>; Tue, 30 Jun 2026 19:03:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782846219; cv=none; b=ioeArs69nSzDGVakmhsQbiKo88ZDpYOQlfUgNi3HY5e4qDqlmYJVPMpMDEQG+AaN53Dvzg+49kLPo7j9nk7+0pux1bXyDh6ZRnILqp7LXztRz+GcMgdCmlGSLQdaLpIfa2zEkKdMlkP5S2WoqHTh+dFVp6H7rYKL9FxI6AlllFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782846219; c=relaxed/simple;
	bh=G9NuEUCFVaxtY10oIrUXU0lQ2ELQ2IRw99bBy7IKbvQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=gClkqg15CpOrxY10Mftz1L7+JY1ZMTU9NqdR6/9dTOuiYVGcKijhbm/fmFtPSLG2x/+LxJcemwg/WpGaAbDu5od3jKaIRlaSUra0101RSA7vnzt7yVdTZN+8kcW2SZfUJjlDH/l2LYVkNNn4+VjAhGfKMfkmndLIw4A29Fcg1Xo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Y6134SpF; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=haa+EnNR; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Y6134SpF";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="haa+EnNR"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65UHl4EY2731310
	for <linux-pci@vger.kernel.org>; Tue, 30 Jun 2026 19:03:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	FV12mCo2AWWxRhbF4a82EfY6HMBsszJrd25mPZq5hTs=; b=Y6134SpF6Qu5ds8e
	ycmPM1I3ItOtsiuisnT600NgOocxPzStjEoleO9G00qfnKIZ4nifXQf8IGO1sSaE
	yRu4i94n27AyKOSwMdRKIzgje2UJ5Lv+9B6/jhOHPPaQpCUJQLCpaY3d+EFxCVRB
	CivxGrYcKJhLVuUqJz+Env3uqHWFwIj+4MnaqovUqL+VO6uTi9cYcU8l4xXg8hxd
	yd2Gy0a2B9NXHNjnN9Ww6L8urXi53GxDY4ExRUrZLEJxlz5tVXsGihgDa+e9ujuQ
	x+hBBtRqJ5zwqsXv7m1yyE2hoOF070udOnBa/qcBWD/hXPgDVsFgGRvA71l1RY49
	TcWVKQ==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com [74.125.82.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f4j99gf1s-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Tue, 30 Jun 2026 19:03:37 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id 5a478bee46e88-30ec59471a3so1045169eec.0
        for <linux-pci@vger.kernel.org>; Tue, 30 Jun 2026 12:03:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1782846217; x=1783451017; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FV12mCo2AWWxRhbF4a82EfY6HMBsszJrd25mPZq5hTs=;
        b=haa+EnNRvZzIrk/O7YlASG5jwvjG/2y4FjBR5lP/1m2Kd8RnAsqiWR6+DA488SGMIg
         BRsTkHYkDgUCdvXFQjBKxNmnyG8F3cVzQfaGtn3Z1ImfP6gmGUA+uElRceppj7DXFHqs
         HT3lcv4BPLz1dUVeUIpMRXPBkR1AnO5qulv0/FABnvOFdWHjQAJxSp4tRCGBEMHmyTJg
         KBr8o4YFtIIXR0tADK6fbTyACNYI3lmL+wIbYkcVQGl0AQ8w8C/e7iB7b/zWgApipg2Q
         lYLYMO+Js+dfB1tZ9p3Xsm83f0AxcHSple0aGKPD3B2ApgBhqnlOaccx6fQW4YDwtFEX
         oKiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782846217; x=1783451017;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=FV12mCo2AWWxRhbF4a82EfY6HMBsszJrd25mPZq5hTs=;
        b=HbSWSYXDksPjFgivpO42RqiWmGgg6kOJ1ctBVkbPNKG7vHi0ai2Wm560jc09BXF9ak
         3K2X3RJRJmX8JaSbZDpCxN3CedW76l2ngIPR3TymHrPvwviB8808rMkL5FrfHLWoueNW
         vMQCh5iw5sviQX2THn2uISfXJNDFMmn0UGwQ0jp9aNjEmozh7AicVLV2Uf31unZ2Z3Rb
         n6J69LMixd+Wx6PgBILxcqaX1VPj1xMykdlJTpA/3/PrdLonEIeNcfSfSxt5ajiHHKIL
         3AElhC4hjUn7jXGFTtA2ST0kTkc9r9LKhdBJFyzlyM/zEqckcUlkVjUrY8/ESbgnYgPI
         iIcw==
X-Forwarded-Encrypted: i=1; AHgh+RqRY3uRzf4WA7ep94AefO9WmSiIEwrjJOeQpMZOU4Tyaswb6vtv+nfTQnyYW4F19y57dMSerNVkwRc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyQeG4XuTUiLx7r+LGFw3yKFflq0SpiMush0gvHH9KSpgt96K2e
	z1cvJxMzVOec9+GDEXiio102n3i8nHqRiU6FrPTpJ9pZXBjowvoVwAul1ZH3lAdbHzFNOlmXOao
	5lDaSRbbG4I+Bd9wno8Bn27M8wl2h0ikAf/s6oHcoTIFbQicXAGoU1wQJG2YAfsk=
X-Gm-Gg: AfdE7cmhM6jHaAK61G28PgPXCa8iHI0ObcWYlgCePt5cnZLK5xip79YFBybmziNSv0Q
	xqMDID6XERWw3nqJt/DXtxVg/l/rvJRN34ywvLLQC8XvFIDdHkI5MTL/0+Wn42gqE75xCSV2CPI
	ZZqWHAPkbduylxHAbgb2zRbt7z51cebnbrKyN9/vwmRxuh+rmzAUROevUrXjqslmMsh/Iv5OAKA
	URlsEmdgns0Y2fCRlXSIOqEGFhLctuejfVeeQbRRCvFPWxaRQZgy1o6krkRkA+1xc/k02QoYpC5
	r7wP9RYoUMgHMtrR76cDBPGNB0fGeSRk6F7uuZUuvNUdM/gVcMtlcLI73zTHXjRx9ej/W0Eumg7
	0tTgHdIL+YU3xehkY2v1d97GeajJiMl+cTURWYBzoIDsWG+Y=
X-Received: by 2002:a05:7301:46a0:b0:30e:d6b3:ba54 with SMTP id 5a478bee46e88-30eea0fc2bdmr1565925eec.17.1782846216839;
        Tue, 30 Jun 2026 12:03:36 -0700 (PDT)
X-Received: by 2002:a05:7301:46a0:b0:30e:d6b3:ba54 with SMTP id 5a478bee46e88-30eea0fc2bdmr1565901eec.17.1782846216246;
        Tue, 30 Jun 2026 12:03:36 -0700 (PDT)
Received: from hu-sushruts-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30ee317095dsm14963815eec.15.2026.06.30.12.03.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2026 12:03:35 -0700 (PDT)
From: Sushrut Shree Trivedi <sushrut.trivedi@oss.qualcomm.com>
Date: Wed, 01 Jul 2026 00:32:45 +0530
Subject: [PATCH 3/9] dt-bindings: PCI: Add bindings for endpoint gpios
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260701-shikra-upstream-v1-3-e1a721eb8943@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1782846191; l=2200;
 i=sushrut.trivedi@oss.qualcomm.com; s=20251127; h=from:subject:message-id;
 bh=G9NuEUCFVaxtY10oIrUXU0lQ2ELQ2IRw99bBy7IKbvQ=;
 b=3iFkILvz6Ich1wFw6kF6CgoiNAp7GPTE7OmP5ZgStMcDSZdBrMyhCoLHdByPX06m3hNHkFaHw
 ICdc5q3F3b2AFGJIuEe4GmSzWB1iOK7nu3PyCCLt5wJMZN8on9w5JNO
X-Developer-Key: i=sushrut.trivedi@oss.qualcomm.com; a=ed25519;
 pk=OrUHTxBaSg1oY3CtCictJ5A4bDMNLRZS1S+QfD9pdjw=
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjMwMDE4MiBTYWx0ZWRfX4Ap0JgluNYHO
 WyP0I9tTN2M+bCFeE761GGuDldUxdpOS5DBx8B9a3V1OUR3pY5z9cF2eLxRUtVBrgqTn+Hs1fPQ
 PUlbCeSfsF01qhL8qsagqx3QzzdanEM=
X-Proofpoint-ORIG-GUID: lki3Sbm29x2d4IhEKNy2NV4nZsLeaNmH
X-Proofpoint-GUID: lki3Sbm29x2d4IhEKNy2NV4nZsLeaNmH
X-Authority-Analysis: v=2.4 cv=bNcm5v+Z c=1 sm=1 tr=0 ts=6a441309 cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=EUspDBNiAAAA:8 a=DMjCJHwfCTXkfbozVOcA:9 a=QEXdDO2ut3YA:10
 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjMwMDE4MiBTYWx0ZWRfX/x5cPdXY/X48
 CjTZb2hqs6Vn2SFWtG0FmqGfMt7A/DAQPgBILW388H4+foE1jIELznjHhVE06Yhm66WvSvZyPZP
 H3xTBAFKHSL35kmij0KIAslwbzlk8YNfvn0m9TuoUipmfr/RR+d2W6XU5nJvqo8kOHiW3QJUt1V
 RL8woqK2z7O/HHqo2h6BAf5MfiV8v1iYXepRPugNkFdAOLB7RN57PnOwO4r9m2kUvPbSFjXfyMV
 wgjU5rY4tzj5r8NE9VpaQNeVc/qUZAqpM9oaM4SIv4WF4XJFkhA1XMM2ihU8IVAr4YXZ5MVUNhO
 r7AE78KCEfHnkHOVnH2FGquUWzpyXWL5auTqf1CebCFUrp15yFTyFAIK2urtSOv/iJPYBtDxVGz
 mv2oM4EJDJw1Mofve/W2Qt7ikI6/h9luucdDT/SVEY5rv0vE+rbZplG7QPXVt89F3ft6zs9S8PI
 m5Mxmo65VyGjMzTHYvQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-30_04,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 adultscore=0 clxscore=1015 priorityscore=1501
 suspectscore=0 malwarescore=0 lowpriorityscore=0 phishscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606300182

Add devicetree bindings for TC9563 GPIO's which are
used to control endpoint power and reset.

Signed-off-by: Sushrut Shree Trivedi <sushrut.trivedi@oss.qualcomm.com>
---
 .../devicetree/bindings/pci/toshiba,tc9563.yaml    | 22 +++++++++++++++++++++-
 1 file changed, 21 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/pci/toshiba,tc9563.yaml b/Documentation/devicetree/bindings/pci/toshiba,tc9563.yaml
index b3ad05d90201..f9f71f28aa92 100644
--- a/Documentation/devicetree/bindings/pci/toshiba,tc9563.yaml
+++ b/Documentation/devicetree/bindings/pci/toshiba,tc9563.yaml
@@ -26,6 +26,11 @@ properties:
   reg:
     maxItems: 1
 
+  gpio-controller: true
+
+  '#gpio-cells':
+        const: 2
+
   resx-gpios:
     maxItems: 1
     description:
@@ -69,6 +74,17 @@ $defs:
     type: object
 
     properties:
+      reset-gpios:
+        description:
+          Specify the TC9563 GPIO used to reset the endpoint
+          connected to the particular TC9563 downstream port.
+
+      ep-pwr-en-gpios:
+        description:
+          Specify the TC9563 GPIO used for enabling power to
+          the endpoint connected to the particular TC9563
+          downstream port.
+
       toshiba,tx-amplitude-microvolt:
         description:
           Change Tx Margin setting for low power consumption.
@@ -104,7 +120,7 @@ examples:
         #address-cells = <3>;
         #size-cells = <2>;
 
-        pcie@0 {
+      tc9563: pcie@0 {
             device_type = "pci";
             reg = <0x0 0x0 0x0 0x0 0x0>;
 
@@ -120,6 +136,7 @@ examples:
                 device_type = "pci";
                 #address-cells = <3>;
                 #size-cells = <2>;
+                #gpio-cells = <2>;
                 ranges;
                 bus-range = <0x02 0xff>;
 
@@ -154,6 +171,9 @@ examples:
                     device_type = "pci";
                     ranges;
                     bus-range = <0x04 0xff>;
+
+                    ep-pwr-en-gpio = <&tc9563 2 GPIO_ACTIVE_HIGH>;
+                    reset-gpios = <&tc9563 5 GPIO_ACTIVE_LOW>;
                 };
 
                 pcie@3,0 {

-- 
2.43.0

