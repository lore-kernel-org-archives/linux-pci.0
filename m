Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91FFD560AC3
	for <linux-pci@vger.kernel.org>; Tue,  8 Sep 2026 15:29:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788881364; cv=none; b=XsEdjXfvfJjOURxKyM7ct0Fh5vBzd+SoWMGmO3HWEYP4ltFvXskaaUBBRSMi5hRPOpJNZzOgVvFcuiNJNvy7ngzru73JPF1K/P3tCHIOYLv4v2TQey3j5CHKU+OeKqfA9+8tCm3WmdyVekPNBlLsHDBDzJ5SP8Ym/PT/EFKBzCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788881364; c=relaxed/simple;
	bh=CzyCd22h+UcT3XIVw/21U2yEWnTC3R4PdEx0GghfeW0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=C1jI/8fMZFa54oSyjm6fJSSSdW0aR5b7jKTosvnNaDQZ/3RosT4FjVsmwWRLYR5ums0+4jPuH9QupaSGn1f2hB/vsdfvB8GF0tmodlVpGP7hZkCkzKcC4ee/xc6h9cxdKSsqxnb1Xn3gZRJmRiTHaXR2MwBBcdqGfAfXvPnT02w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Sgn/I7ND; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=OT0+cu/I; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Sgn/I7ND";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="OT0+cu/I"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 688FOZwY2703994
	for <linux-pci@vger.kernel.org>; Tue, 8 Sep 2026 15:29:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	nd2TADxUcG+kC9QAG2vl3J88xwd9WsYil8D60fAvOK0=; b=Sgn/I7NDYQCXSzdb
	u31qVaiEmRCQD37sS8mE781+eqBRWX2GCXB25uTASHT+cZMUAoFsEnKjGw2DEqG0
	7UNlHiyqPHdHEnT4Ziq3uvWBjgWG6hHKu4CmZTlVf8GTrSY7Gdm2SiFOFHI8nn/C
	Cj5MBzCQPPwIqUr5RLjNMlCJM0lYYZfXePb2h4x0MUP/mtcUls5s+pNoY/QyeJiY
	NtaX3sayONL69SiAicb9ThBHIOuc/+6PeM/XsSs+H4HXGqHC+AzHSd7LqqO/Mzup
	RlXPmHr5kp2qYtJmGNh/TBAAXrTj8a82AyWl05IZgOQBTtVqMCRKHD+6vAmFpmD9
	HiKf2Q==
Received: from mail-ua1-f72.google.com (mail-ua1-f72.google.com [209.85.222.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gjatjjud5-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Tue, 08 Sep 2026 15:29:09 +0000 (GMT)
Received: by mail-ua1-f72.google.com with SMTP id a1e0cc1a2514c-97c3796d17dso226519241.2
        for <linux-pci@vger.kernel.org>; Tue, 08 Sep 2026 08:29:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1788881348; x=1789486148; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=nd2TADxUcG+kC9QAG2vl3J88xwd9WsYil8D60fAvOK0=;
        b=OT0+cu/InShulRi5vqeIh5aomPmTxD1Yq6HUfkDChsNrCbspagtvq3ukULTxfLvcdb
         P6hFewXvSTbwKwbDhkJzUh8LPkqqfntvaWFyt+G5yBaR4Ac4NbGktG1aAYRtxbqM/mlJ
         D0v1zy+NLkx9bsjCaBncGnZO6L3G31mLl7GMYAEqY5zSik8oBHRZ8EYrvf7BOZXkO6g5
         ievHLTU25dBDjaE7LG8uybrjamOCHjU8vejtsJ+F9rNdp4C27WsSx3yIeUbeM3Wd6uVN
         TiCXpiOAxb1G3IbbT+Bf7YZ/sArDZLot5C50/OsFDVIGnzj+p+NmGq4doemWSP1tuKwP
         5HVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788881348; x=1789486148;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=nd2TADxUcG+kC9QAG2vl3J88xwd9WsYil8D60fAvOK0=;
        b=GkXIRuLc67VlRjOL+XFB5pqgmTO4SyBwhyVReN5BMMlpdhIZIQCCkN1+aFno8ZmwOP
         5U3bUXbujqNxdhULc6x1yZF3W0zlEfPO48X1cNXOJdYmpacTAqLH9uV+nmUzQZ1jo4/t
         s0J2xKPpxw1gi/wz6FIWB08v/8Rb1caN2U43Gjy8QjcMXi0MpQ++LtBjkGcQZiYVRBdS
         96D/HhLEsEtqq89IuevD6jQuDvOplfMHbsHGP1JrhHMXu2o7XTFjG6gUawqZsryA29mC
         F65FPwJsXWJX6HVNhUNNvLKgFGjdwuBFEZix8c8v4iAhb1CQo4ZASUupDftUN8fvB4Al
         +E0g==
X-Forwarded-Encrypted: i=1; AKwUvBw3eL5wBGdepbhGmFjB1cLoO3r/CVvnq1E9Sy5/5n0aK3812EIEIXhRtMAO4soFhUsnIVyLdbiA0Jg=@vger.kernel.org
X-Gm-Message-State: AFuF++mdKyh8UHSS1OFhkjBB7U2szlw7bh5QtN2Sy0iw3TPxuu/JwUST
	R2XU+0/8LWgpzTVx07gNoyMxjFxVL4erp5oQgdboXMZghv9l2SJ3Naz+O7d+2s8nkT1krCFT8k9
	bKBCzNCaWev3dSVU8WzzemCG91wev0gmSw2Ju3EXi5h9hSyqRO6CVGdd0fP3KExM=
X-Gm-Gg: AYBFou0+wPaQ+FthWPebkeySer+ywj0Nvzb+PJOoqAjlFx34/iAWQ6DZwe0EDU4H+T/
	hva0kjBd5HFKu4iReWLt+2gIJzXdE91pqAwwAcMJl8QXZJ0AXj20j+rLqtY2hGZoDffqAAiziXf
	BNUC0HFlOczDDrsRV9TnnDhRoE91csCjTMvkqty1a1aF5w9VXFGdRo4Cj+uFEif7T0+2SdjXBkK
	Ap09CcFhuuL5xGtFVxM8Y18gGcMMlW/hMwM19RJysxWIANqNVBJARg13vt5zfujg73MV+wTgsAN
	YpBJp/XCZif9xxZz2MTbDxuLtxTRedoTJnuqMrZJBvje2Ir/dg66Y+K4KqqAZXwp91iSHRD3ohQ
	wuL9DnQ12HdPsyA==
X-Received: by 2002:a05:6102:fa8:b0:778:71e5:45d3 with SMTP id ada2fe7eead31-78a5cf4f050mr9383759137.9.1788881348144;
        Tue, 08 Sep 2026 08:29:08 -0700 (PDT)
X-Received: by 2002:a05:6102:fa8:b0:778:71e5:45d3 with SMTP id ada2fe7eead31-78a5cf4f050mr9383683137.9.1788881346961;
        Tue, 08 Sep 2026 08:29:06 -0700 (PDT)
Received: from localhost ([188.216.77.92])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49ce831af89sm338907305e9.1.2026.09.08.08.29.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Sep 2026 08:29:06 -0700 (PDT)
From: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
Date: Tue, 08 Sep 2026 17:28:34 +0200
Subject: [PATCH v4 1/5] dt-bindings: PCI: toshiba,tc9563: Document embedded
 GPIO controller
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260908-pci-tc9563-aux-v4-1-c7fc7778292b@oss.qualcomm.com>
References: <20260908-pci-tc9563-aux-v4-0-c7fc7778292b@oss.qualcomm.com>
In-Reply-To: <20260908-pci-tc9563-aux-v4-0-c7fc7778292b@oss.qualcomm.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>,
        Linus Walleij <linusw@kernel.org>,
        Bartosz Golaszewski <brgl@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Michael Walle <mwalle@kernel.org>
Cc: Alex Elder <elder@riscstar.com>, Daniel Thompson <daniel@riscstar.com>,
        Sushrut Shree Trivedi <sushrut.trivedi@oss.qualcomm.com>,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA4MDE2NyBTYWx0ZWRfX6vHYjccbNeVH
 aTewW+1qTzNY9Ul+l5DpmIVPL2XJyCjo1d8g3Wu0o9//nf6YBFgpcI3aO9pxtYQWJl7l7HRnb8S
 Ciul1CkhbAErwdrsoWXCjmF93/Tns6g=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA4MDE2NyBTYWx0ZWRfX2yeVubV3lXen
 EoZAyiRSgiou0UEuKoBiOkZ5mQ/Oi1atOyzL6j+fpc9/q9k9+FI2LC2z6SJ+vFyuC1v+S9eNMV6
 LMsbihLI6ZgYslbc05N+255P01aS+kY/Q5qFjSHoahBnhyITD500B2+ODgKGC0Gp79AfygX1zqF
 DRvj2dawTCOtEJnS5ljo0W5OrnlZ8ynCKenxmjLtxhDooRacRXiRhXaScI6yqggdkOVHqwmfPzS
 wmGUZPbsoxVHEaufRmhtW5YQ5YWfxkMZ7hu5Ax0DachKtEVtD99NvTisCiOaiKIojiEEO9hjBOt
 8Y4TvhlCU64K6/LDaLLZs/HNK1iGJN26Ok3Dac9QQmkzFL5FRFmRviGCe+qPCbgnnWFXlC1bFG4
 W/wIupTRLyWN825lTmHTyuoTFTynwJ56AvjuOHgNTGBV9gUC/TQ8hmheWMiLA7t0GJrw5VQP5b3
 Z9whHGUx2ctvdd/3Rbw==
X-Proofpoint-ORIG-GUID: NfLCWLl-fhQLKekmSPT7PlZlb_D21n8z
X-Authority-Analysis: v=2.4 cv=QrduG1yd c=1 sm=1 tr=0 ts=6aa029c5 cx=c_pps
 a=ULNsgckmlI/WJG3HAyAuOQ==:117 a=WpTaRW6qxYHRGzLzQsVYzg==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=EUspDBNiAAAA:8 a=l4L6Kd7NaPjElzNrcykA:9 a=QEXdDO2ut3YA:10
 a=1WsBpfsz9X-RYQiigVTh:22
X-Proofpoint-GUID: NfLCWLl-fhQLKekmSPT7PlZlb_D21n8z
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-08_03,2026-09-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 bulkscore=0 adultscore=0 malwarescore=0 lowpriorityscore=0
 impostorscore=0 spamscore=0 priorityscore=1501 phishscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609080167

The TC9563 PCIe switch embeds a GPIO controller providing 37 GPIO
lines. Describe the switch node itself as the embedded GPIO controller
and document the per-port reset-gpios property.

Signed-off-by: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
---
 .../devicetree/bindings/pci/toshiba,tc9563.yaml       | 19 ++++++++++++++++++-
 1 file changed, 18 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/pci/toshiba,tc9563.yaml b/Documentation/devicetree/bindings/pci/toshiba,tc9563.yaml
index f084830c6d0c..2f03e4e45114 100644
--- a/Documentation/devicetree/bindings/pci/toshiba,tc9563.yaml
+++ b/Documentation/devicetree/bindings/pci/toshiba,tc9563.yaml
@@ -31,6 +31,11 @@ properties:
     description:
       GPIO controlling the RESX# pin.
 
+  gpio-controller: true
+
+  '#gpio-cells':
+    const: 2
+
   vdd18-supply: true
 
   vdd09-supply: true
@@ -59,6 +64,11 @@ patternProperties:
       child nodes describing the internal downstream ports of
       the tc9563 switch.
     type: object
+    properties:
+      reset-gpios:
+        maxItems: 1
+        description:
+          GPIO controlling the reset line connected to the downstream port.
     allOf:
       - $ref: "#/$defs/tc9563-node"
       - $ref: /schemas/pci/pci-pci-bridge.yaml#
@@ -128,7 +138,7 @@ examples:
             ranges;
             bus-range = <0x01 0xff>;
 
-            pcie@0,0 {
+            tc9563: pcie@0,0 {
                 compatible = "pci1179,0623";
 
                 reg = <0x10000 0x0 0x0 0x0 0x0>;
@@ -149,6 +159,9 @@ examples:
 
                 resx-gpios = <&gpio 1 GPIO_ACTIVE_LOW>;
 
+                gpio-controller;
+                #gpio-cells = <2>;
+
                 pcie@1,0 {
                     compatible = "pciclass,0604";
                     reg = <0x20800 0x0 0x0 0x0 0x0>;
@@ -158,6 +171,8 @@ examples:
                     ranges;
                     bus-range = <0x03 0xff>;
 
+                    reset-gpios = <&tc9563 2 GPIO_ACTIVE_LOW>;
+
                     toshiba,no-dfe-support;
                 };
 
@@ -170,6 +185,8 @@ examples:
                     ranges;
                     bus-range = <0x04 0xff>;
 
+                    reset-gpios = <&tc9563 3 GPIO_ACTIVE_LOW>;
+
                     toshiba,tx-amplitude-microvolt = <10>;
                 };
 

-- 
2.55.0

