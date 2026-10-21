Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792590699;
	b=e1xVKRlMCXjoV6rt0XlXkUjPzU3MX2k9e+MWWSG38jNBdGDR6JbXhGsfBLxqYLb/YqYo
	 YX4SbreKiGioWYEr2nCeEfejZdmvf3aNRikfAKD6F4qf1xsjDznC87BeZd99wWXT9nB/r
	 iOkD/yT5LpSP60n1go5pGu7m0g7wFuOzbl8gfYpNgiaujK1T50SzrfWOOw0Ct+1EH8nmT
	 FZuvyScnpWCyd4lIgXT/MX6Ov2T2veWCptnA67LwVd5JS5l91yCzYVEHXon2mFFen2OrD
	 l/DG0A/2zGMfCfGbUbpzickb/07ldLauoH5nSBFFQ0CIdWEt4b07Kao/LLr7UwFYqUw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792590699;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:X-Received:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Proofpoint-Spam-Info:X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:
	 X-Authority-Analysis:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=eqzxsVu9ygVnO09BxDlCxM52wOxdPkt+JaIEaVUrlbc=;
	b=AwSsLDLCOlSkrZdMX4k36qkzJ/b7VnijAUMDhpQeyXvtUHC8qBTb0PDLehjxz1Scc5T5
	 WKHwicCJMtMmuDV7rQi4rEiOr0Ri93UQPDndslULYBM7cYybGTx72DgN+AnjBaaEXa+rM
	 a7grloav01jfcomOhN4Bty+XRymwHmhlHEWPyXmNkXi5V9D++neHkEkqGypWmULpWevV9
	 z4QwlZaFK9tW66lK7C4DYyiK8eTHl2u+zU11sjSaGhRDZGaG+3jxqcJfDx+X3i5JPqI2W
	 xKJx0ZCO/xr7kK5GYQB5YAEbuQwbGR4+xZk1fdFiTAK2+p0nmlaHwx/uVVMZIb1Hg4g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=m624ddMk;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=W5rXR1QQ;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FB51606A333
	for <linux-pci@vger.kernel.org>; Wed, 21 Oct 2026 13:51:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2FB51606A333
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=m624ddMk;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=W5rXR1QQ
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69LDHRfK4038182
	for <linux-pci@vger.kernel.org>; Wed, 21 Oct 2026 13:51:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	eqzxsVu9ygVnO09BxDlCxM52wOxdPkt+JaIEaVUrlbc=; b=m624ddMk77lyR6LV
	Tr4BtUsxeTVQZZ7+weRwMyhScK7JyI6BY6JEQ6Z8dH3GDGSAq+a70ZzuvkB0lEwi
	bbM/eE4v2OTqCfLPVj7FZaxkJwpfA42aqO+cxinzaIuYprBZG6JNC9YWdRlRB7X1
	ybjOyObS5XiYeGVbijtbQsFbF5v+7AeBggp2W0RwFUVcTv55tSs2+jjvyw8bvURG
	GcOyT5OEarfrxjXl4CujBHv7wiRAhLmfa95YhSqnzde3Xc7smRJxcDk6N9gzpVX7
	4KaEbGkHtJic7ddYZ9rIZaPBWf6thpVBCRAGgRqdlSD63oAzn4gZx+UMQgD7b3T8
	/goIeA==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com [74.125.82.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hex5884ra-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Wed, 21 Oct 2026 13:51:38 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id 5a478bee46e88-35cbea41088so1397312eec.1
        for <linux-pci@vger.kernel.org>; Wed, 21 Oct 2026 06:51:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1792590698; x=1793195498; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=eqzxsVu9ygVnO09BxDlCxM52wOxdPkt+JaIEaVUrlbc=;
        b=W5rXR1QQ4P1brtJ5mPczVOt233PiA+qOpjx5BLiAEtMSv5AawrUkpf3A+0N5vFhxEB
         PfmOx/vDlrq7YjG/zAZKI7l62qQaILTOHb/trCPbqRr8WegLv0PvLQ3dpRHlWn3cuxNU
         ur8izxXZHvjjYnmOkn8Ekge7wp/pjWBHwYNedtFV40gnhxiZukhND6pjrph/+toDcIDb
         /EJ6wlYgOHGdd9GM/jwr9TYgtCekeuHkHHwLW2u3TPr9gWi2ghP3OVnrDMQFveizGyf4
         8aV7b+J7O5/Pa4dYxwV+F2M8VecGh7h8AkTvd0mHgyU/fjOITYOnPY2b5BHcfJnR3rwt
         LNvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792590698; x=1793195498;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=eqzxsVu9ygVnO09BxDlCxM52wOxdPkt+JaIEaVUrlbc=;
        b=n2QIDOWCuGCTTI8QuJSrAJLYYbQj2IEWvdcnwnGdSKv+lClSH59IhP9qdkfNZaczpw
         1K878aZpmDcAGiSJgygxBle26W+mEHem4SnuT6WITzNit4Ry9202kTLX4jEhDarpwEHX
         tu8lWNwWRDqA1X/EPeZxgWHPWxk5KJpUcX/FyFTY23UftVoa3N1Njq33c8jorGMtIRqd
         3qGWxknebaprEaEB1bQyA6C7tA9SHUopoQ+nFrYEsVkxhjREP4scbhLDMHdHF1apsMCh
         GcVK9F+QmoxYEg5leyQBVI0d4fzLxtXzGzyvFqBBn2evWZhrttxsUuF3lLWycgcLlofI
         YWMw==
X-Gm-Message-State: AFq9FYKMGkv5ZeZeMjFJyZPb7xznmxahjq0yTJsKW58Y6iVoaZaqZO1J
	gGxJsGLALkghyx8P9/CbtxCsaRi55orY+vnaHFHuW8fNa/QhY8cjW8/Jzyl5Xugnu4XGjX5X6MF
	uy0sit1wrWmQLBydu4RtHanBjPLB+z5nqhLhVcoSaNAFV5ASGsaC/DrZuIXP206J+tP5pIgU=
X-Gm-Gg: AYBFou2smv7cShU6t74/cs6TZFrlVa7kM6Ms1CvKrFNi46aSX/0VMk/mitDB25jT6nk
	h78EQ5U7PPOCP8R4r3Kw9d9u7560KCB+4kzqAP28JgdNXx6r5G3f8wHAJpJH8/+nVzTtrGA9aW6
	G8Q9GrD0FNabwPJDsO3Y1DL96ooFUuYvy5SQDdi9p/IgXzTeMfWGaUijLK5WVm98fUdoNRIgzR5
	7rz/AEaDpALThwmDHNTuSN7UgiHTVnflS8yio/tY7DHaPxBWP4ERaNQyU4s7jTS8M4sLKmGjWwB
	WApFqDr+P9C/z2ImK6tyJLA4X8HaGMCoiiT1rAUznO5iRt/xqdz+97DPsysx7gWZT1cIM89SAS7
	SCEAzVcnrHbsJwUsZ8qdb+jluWxo+Bm7obw==
X-Received: by 2002:a05:693c:20c3:20b0:35e:60ca:81e9 with SMTP id 5a478bee46e88-3674d047291mr3705149eec.21.1792590697464;
        Wed, 21 Oct 2026 06:51:37 -0700 (PDT)
X-Received: by 2002:a05:693c:20c3:20b0:35e:60ca:81e9 with SMTP id 5a478bee46e88-3674d047291mr3705116eec.21.1792590696844;
        Wed, 21 Oct 2026 06:51:36 -0700 (PDT)
Received: from hu-krichai-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36740cc848fsm7534332eec.13.2026.10.21.06.51.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Oct 2026 06:51:36 -0700 (PDT)
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Date: Wed, 21 Oct 2026 19:21:22 +0530
Subject: [PATCH 1/3] dt-bindings: connector: Add PCIe M.2 Mechanical Key B
 connector
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
Message-Id: <20261021-pcie6_fix-v1-1-ad37134c35a3@oss.qualcomm.com>
References: <20261021-pcie6_fix-v1-0-ad37134c35a3@oss.qualcomm.com>
In-Reply-To: <20261021-pcie6_fix-v1-0-ad37134c35a3@oss.qualcomm.com>
To: Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bartosz Golaszewski <brgl@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792590686; l=6589;
 i=krishna.chundru@oss.qualcomm.com; s=20230907; h=from:subject:message-id;
 bh=Hcd8AhF5neUwdC/MlSlABuWRJC+I82zW/2oPCsLOsTo=;
 b=BDqVkQfSgirwVpNSh1XjiN+Moh+pk78Elv4J7qPXubw9pEpimWukRbglPMWE3LkhDGIvOex67
 9GsLG0RrSIzCM1br9Eask63qy/vFOezwJySTUIP9QdUriHMvnKxrlRa
X-Developer-Key: i=krishna.chundru@oss.qualcomm.com; a=ed25519;
 pk=10CL2pdAKFyzyOHbfSWHCD0X0my7CXxj8gJScmn1FAg=
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIxMDA1NSBTYWx0ZWRfX3eAZ89kMzS5g
 Wvg+saxACEfC99Da/WubDOhlNKDtcQV1nQKBh6IHC8y4me7SxtUMk0cwhQ3RiUAoy3QX/qm4b/Y
 /cO1kM9UZ5LPNVQ3QnL0q+A3Frvt6cc=
X-Proofpoint-GUID: QzUqKkzTeAnXlLisJmQLmJj_hiQnje0e
X-Proofpoint-ORIG-GUID: QzUqKkzTeAnXlLisJmQLmJj_hiQnje0e
X-Authority-Analysis: v=2.4 cv=Ku7YSmWN c=1 sm=1 tr=0 ts=6ad8c36a cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=gEfo2CItAAAA:8 a=EUspDBNiAAAA:8 a=VwQbUJbxAAAA:8 a=nzPhZw1G-5J1C4WXyrkA:9
 a=QEXdDO2ut3YA:10 a=6Ab_bkdmUrQuMsNx7PHu:22 a=sptkURWiP4Gy88Gu7hUp:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIxMDA1NSBTYWx0ZWRfX23uqGsCDNDn0
 E/uNU040GeVqaCw9jF68ZywRhY+8hPWRUvDr7U8uJAU8zeZqIAV7rsS0pcXcPdzD2sIIYQvyRMS
 Vhu9ER3umAGHwO2y2ogGB0/6nmeX5XSFSkY0EjsVs05+BstPAPnI3AQ4+D6nU9CujM5VC339OX/
 fKQKFU1oMn2E/Q4Puw5sm5YzUIngN6eZrdKRd4dnhObQUqRjSE1UMGTwtA9fxe9n4L9eDYTRnVS
 3/e4kHsoKc9uUJEK/DZZvVj5iiI29OhzW+stnE9PjnRN+d2kzNK45zWdT8AHn4DpAjsAxZwCHba
 nhIbL6iCIl6ljRg20VRZze7//d+5LBpGQDpdEuDRog3vlY28Nn3kl2UBakmDu7e7zxrHo2jgsFM
 59MPBn0xHdZCThtewyFPklLfOXrZkVsCzmiR8k5WZvwxFfhxQbaAbbCdR12R5TdiBWS9DRkuYKK
 RObw5kOBeVCHLZBE/xQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-21_03,2026-10-21_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 impostorscore=0 malwarescore=0 adultscore=0 clxscore=1015
 priorityscore=1501 spamscore=0 phishscore=0 bulkscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610210055

Add the devicetree binding for PCIe M.2 Mechanical Key B connector
defined in the PCI Express M.2 Specification, r4.2, sec 3.2.19.1. This
connector is used to attach WWAN Adapters to the host machine over
interfaces such as PCIe, USB3.1 Gen1, SSIC, or USB 2.0, selected by the
Adapter's configuration pins.

The connector provides a primary power supply of 3.3V/VBAT, along with
optional GPIO signals for WWAN-specific power/radio control:
FULL_CARD_POWER_OFF#, RESET#, W_DISABLE1#/2#, WAKE_ON_WWAN#, and DPR.

Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
---
 .../bindings/connector/pcie-m2-b-connector.yaml    | 146 +++++++++++++++++++++
 MAINTAINERS                                        |   1 +
 2 files changed, 147 insertions(+)

diff --git a/Documentation/devicetree/bindings/connector/pcie-m2-b-connector.yaml b/Documentation/devicetree/bindings/connector/pcie-m2-b-connector.yaml
new file mode 100644
index 000000000000..a7f4bcbc5119
--- /dev/null
+++ b/Documentation/devicetree/bindings/connector/pcie-m2-b-connector.yaml
@@ -0,0 +1,146 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/connector/pcie-m2-b-connector.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: PCIe M.2 Mechanical Key B Connector
+
+maintainers:
+  - Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
+
+description:
+  A PCIe M.2 B connector node represents a physical PCIe M.2 Mechanical Key B
+  connector. Mechanical Key B connectors are used to connect WWAN devices to
+  the host machine over interfaces like PCIe, USB3.1 Gen1, SSIC, or USB 2.0,
+  selected by the Adapter's configuration pins.
+
+properties:
+  compatible:
+    const: pcie-m2-b-connector
+
+  vpcie3v3-supply:
+    description: A phandle to the regulator for the 3.3v/VBAT supply.
+
+  full-card-power-off-gpios:
+    description: GPIO output to FULL_CARD_POWER_OFF# signal. This signal is
+      used by the host system to turn off the entire Adapter. Refer, PCI
+      Express M.2 Specification r4.0, sec 3.2.13.1 for more details.
+    maxItems: 1
+
+  reset-gpios:
+    description: GPIO output to RESET# signal. This signal is used by the
+      host system to place the WWAN Adapter into a power-on reset condition.
+      Refer, PCI Express M.2 Specification r4.0, sec 3.2.13.2 for more
+      details.
+    maxItems: 1
+
+  w-disable1-gpios:
+    description: GPIO output to W_DISABLE1# signal. This signal is used by
+      the host system to disable the WWAN radio on the Adapter. Refer, PCI
+      Express M.2 Specification r4.0, sec 3.1.12.3 for more details.
+    maxItems: 1
+
+  w-disable2-gpios:
+    description: GPIO output to W_DISABLE2# signal (default function of
+      GPIO_10). This signal is used by the host system to disable a second
+      radio on the Adapter. Refer, PCI Express M.2 Specification r4.0,
+      sec 3.1.12.3 for more details.
+    maxItems: 1
+
+  wowwan-gpios:
+    description: GPIO input to WAKE_ON_WWAN# (WoWWAN#) signal. The Adapter
+      asserts this signal to wake up the host system. Refer, PCI Express M.2
+      Specification r4.0, sec 3.2.13.3.6 for more details.
+    maxItems: 1
+
+  dpr-gpios:
+    description: GPIO output to the Dynamic Power Reduction (DPR) signal.
+      This signal is provided by a host system proximity sensor to the
+      Adapter to trigger a reduction in the radio transmit output power to
+      meet regulatory SAR requirements. Refer, PCI Express M.2 Specification
+      r4.0, sec 3.2.13.4 for more details.
+    maxItems: 1
+
+  clocks:
+    description: 32.768 KHz Suspend Clock (SUSCLK) input from the host system to
+      the M.2 card. Refer, PCI Express M.2 Specification r4.0, sec 3.1.12.1 for
+      more details.
+    maxItems: 1
+
+  ports:
+    $ref: /schemas/graph.yaml#/properties/ports
+    description: OF graph bindings modeling the interfaces exposed on the
+      connector. Since a single connector can have multiple interfaces, every
+      interface has an assigned OF graph port number as described below.
+
+    properties:
+      port@0:
+        $ref: /schemas/graph.yaml#/properties/port
+        description: PCIe interface for WWAN
+
+      port@1:
+        $ref: /schemas/graph.yaml#/properties/port
+        description: SSIC interface for WWAN
+
+      port@2:
+        $ref: /schemas/graph.yaml#/properties/port
+        description: USB 2.0 interface for WWAN
+
+      port@3:
+        $ref: /schemas/graph.yaml#/properties/port
+        description: USB3.1 Gen1 interface for WWAN
+
+    anyOf:
+      - required:
+          - port@0
+      - required:
+          - port@1
+      - required:
+          - port@3
+
+required:
+  - compatible
+  - vpcie3v3-supply
+
+additionalProperties: false
+
+examples:
+  # PCI M.2 Key B connector for WWAN with PCIe interface
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+
+    connector {
+        compatible = "pcie-m2-b-connector";
+        vpcie3v3-supply = <&vreg_wwan>;
+        full-card-power-off-gpios = <&tlmm 121 GPIO_ACTIVE_LOW>;
+        w-disable1-gpios = <&tlmm 122 GPIO_ACTIVE_LOW>;
+        wowwan-gpios = <&tlmm 123 GPIO_ACTIVE_LOW>;
+
+        ports {
+            #address-cells = <1>;
+            #size-cells = <0>;
+
+            port@0 {
+                reg = <0>;
+                #address-cells = <1>;
+                #size-cells = <0>;
+
+                endpoint@0 {
+                    reg = <0>;
+                    remote-endpoint = <&pcie6_port0_ep>;
+                };
+            };
+
+            port@2 {
+                reg = <2>;
+                #address-cells = <1>;
+                #size-cells = <0>;
+
+                endpoint@0 {
+                    reg = <0>;
+                    remote-endpoint = <&usb_hs_ep>;
+                };
+            };
+        };
+    };
diff --git a/MAINTAINERS b/MAINTAINERS
index 7b5cab72d851..22cfd2b72e1a 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -21794,6 +21794,7 @@ PCIE M.2 POWER SEQUENCING
 M:	Manivannan Sadhasivam <mani@kernel.org>
 L:	linux-pci@vger.kernel.org
 S:	Maintained
+F:	Documentation/devicetree/bindings/connector/pcie-m2-b-connector.yaml
 F:	Documentation/devicetree/bindings/connector/pcie-m2-e-connector.yaml
 F:	Documentation/devicetree/bindings/connector/pcie-m2-m-connector.yaml
 F:	drivers/power/sequencing/pwrseq-pcie-m2.c

-- 
2.34.1

