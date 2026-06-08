Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEB393B388F
	for <linux-pci@vger.kernel.org>; Mon,  8 Jun 2026 08:48:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780908515; cv=none; b=TRgNgF8tbSVnHhqY7i05o/mC6/EDI2Q62BuhwPVIyQa812fUSj7Bz9Lu77/I2Usoc6UvfCJ6np886e2t4Dsd5KaKuTI+hvTKzT+cAvu1oGKABzMGfDAGmGsIUBQw4muK2fsd22wM9iB93mkPHiWFXrfjzrh3Wy0nCkhuejeN+LY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780908515; c=relaxed/simple;
	bh=yBHjoToyEmvpw9ZOHDr7MPJDwbB2Fu203G+gPC/yC/U=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=U2QRLy87ESqsxjS4CE2xQa9HHdH0ZoIuMYpn3m9M/mfZ5MpdReoWfYVDO8XKTxOvo45q7BkB5rM+zpUtKsZ47O+J1pdAWrmD+K7Rd2i8xCxbrdD7nGn3ULDc+/AUBH8SunntNmzAiNzuwu1D7kDn7McE/bYzt/+b7uOVHIdDZx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=UzFUuDSH; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=J/xiUZie; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="UzFUuDSH";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="J/xiUZie"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6586OmNI2317614
	for <linux-pci@vger.kernel.org>; Mon, 8 Jun 2026 08:48:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	jxRVdQ5578eayqXtMEmKyb3yUdHj+2MNMKPNvNzYGdA=; b=UzFUuDSHOKVTAHEX
	C3MQLfRoKXwN7wPbIUalvwzdpcV7Qo0tw3uzdOCRwgkUR/LCZMn1kWatXYEm9IhT
	4+0sxzeEhhrCRasemxBli/kPa5KnC6IjXByVMsVoAaKMe/Psyi0jUMXuCM6frzvE
	C598hFKYqkeytwU7cySJegBfVXziE8x8SUf90Xe074Vw7wH5UdsJnhNbY3ac76bN
	Gu4pf75slYDWpGPrnkQ1WuvzP4h4RAjPO23mcYCJrvQWw7u21zrxGFDWVldfc1Dz
	/yQB+DGqF6OisBAlUZtmbb8CwcKmpJNKPFTDGg6QduAHx2VgpFk8yR4uVSIO4s4A
	RA7Kcg==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4emcadxmuu-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Mon, 08 Jun 2026 08:48:34 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-36d98b828c8so5138305a91.2
        for <linux-pci@vger.kernel.org>; Mon, 08 Jun 2026 01:48:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1780908513; x=1781513313; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jxRVdQ5578eayqXtMEmKyb3yUdHj+2MNMKPNvNzYGdA=;
        b=J/xiUZiedk0BTeI6G+FhafGAXffPWv8mlEJyCnwctnRJxrfAFA2AAPbOrsaPazUJXb
         NLvG6xgsbc/JqAiWtRuCOHjHgXt5UGKuOohAtmw4gq2lfccErDzWKO1Nb7t+4obEH6bT
         GW7T3CorRx7ZbZ/NRQYaDs0F/Du/bMeNjtwp0n4u1UXocumkHqRd4CJUF428GBeEUoHX
         wj4z9hRhKZULDq2n6cF+qieB4sxC3TLIu/pz/fGjofQmULfLvyJlG8R9bg1zci8UsP6C
         36wz2nL+y5Ov4rF2leb/ossYCCDB/EEPIxXvtA9aQ6/1ewWvHopChU3CEAWvjc62Fpja
         6tXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780908513; x=1781513313;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=jxRVdQ5578eayqXtMEmKyb3yUdHj+2MNMKPNvNzYGdA=;
        b=q3X4JZo2GHolmsTAI5O4DgFFjrgES6ZmRA8/nfdXwILsJaE67bMv19kfGlBvJrgJo7
         aWSeu8Mu0tOQFNCSkmi3/ccnlkMdQ1mRTLJ/hR1sGkf/aZTzvLExvcjUzaLsw8KQr9hJ
         gD/g1NvMV+oCRT917ujIXeNGKzi19Ug1z+YT/O110ZL+xPIzVleVTTVNo3Gk/DiQnW+R
         FeqVlKBLZy8dIqTAJIDeESdzL7oM0qnogQJYGFIXjPCqD4YLThyRyWL3tBPtwX720MpE
         Ja+q+VhTwdfznBv5sm5AZG7n/U2WsosV58rDkfD9Z6YkzW8ZjIe7bEG3iq8xMS1tWvhN
         hWbQ==
X-Forwarded-Encrypted: i=1; AFNElJ/K1GxQIsXtM6AL/qSHOGAR1iI61TDEdtuxozW+mn/6JYImfXFmVsf9yZRBZMD9xvuOyYT7dVvJaeQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyZf/3XwIx8EVV/xcIaV5GvfYzrKWeIHybLJf0pG9ooXGgZ/SNc
	rg4G1Rt/dfGpZv1fvWW9Dylu9j9y+ZBto7Tr6ycz99luL4GO8U58KLCOJHc0ukCUwxw2gBKbPpr
	FWguvhBsRU/+/EB53JTkk8vwI68IIL3XPb5YxA9gJY5WZlo3tDNcLNW6YesRhSfo=
X-Gm-Gg: Acq92OEA0vM8qSeENGTGio+mqpzgvZm5H5yw7V3lrROoXbgEoZ1FtZef4SF8hkiJQlD
	frkt8B2eppiGT+IbQCDP5hWIkV/KY7TQLbpidoDiFyrw+aJtEeGdm9Y5exMp7YW2MYo5bAhPqYI
	MFf5Wt1yEmohWm6ZtZW6xn3mB8f+iBDXLvGL7QhxYY7KykUk60fbWceZ00jH5GJgj5I1GlgJyiN
	i8vLFZgYCQ5xvKeyjQNq6etItq9zdEP+TRbuwF3PI8R9yD/RrrkCcMFDk+p519pK5vk/M0IIGCt
	nkB99fzfuz3RCVHUFDM3vcQWML+KR71WiJGuoYSlJG3Ky5g4EJOEmz/JopjeijnBi5CsovV8sZy
	dLJgu3hfn5oM4urZATxX/NN0ZbZzn7zhMqYXkp6ruacsVZngpF+vfaFGraJ8i1YR3zmM=
X-Received: by 2002:a17:90b:394e:b0:36a:aeaf:ab2a with SMTP id 98e67ed59e1d1-370f0d4c33emr17913278a91.19.1780908513521;
        Mon, 08 Jun 2026 01:48:33 -0700 (PDT)
X-Received: by 2002:a17:90b:394e:b0:36a:aeaf:ab2a with SMTP id 98e67ed59e1d1-370f0d4c33emr17913246a91.19.1780908513113;
        Mon, 08 Jun 2026 01:48:33 -0700 (PDT)
Received: from hu-krichai-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-36f712de91asm15070198a91.16.2026.06.08.01.48.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jun 2026 01:48:32 -0700 (PDT)
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Date: Mon, 08 Jun 2026 14:18:14 +0530
Subject: [PATCH v3 2/3] dt-bindings: PCI: qcom,pcie-sm8550: Add Eliza
 compatible
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260608-eliza-v3-2-9bdeb7434b28@oss.qualcomm.com>
References: <20260608-eliza-v3-0-9bdeb7434b28@oss.qualcomm.com>
In-Reply-To: <20260608-eliza-v3-0-9bdeb7434b28@oss.qualcomm.com>
To: Vinod Koul <vkoul@kernel.org>, Neil Armstrong <neil.armstrong@linaro.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Bjorn Andersson <andersson@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org,
        Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1780908496; l=2136;
 i=krishna.chundru@oss.qualcomm.com; s=20230907; h=from:subject:message-id;
 bh=yBHjoToyEmvpw9ZOHDr7MPJDwbB2Fu203G+gPC/yC/U=;
 b=ja/5LGBZqLE+1Wu1sWlNlGqoDr6Lswt20oAcZyryoiw0HvM5vhjXHVza1wvnRC82kNBi3B9tV
 2OVNAra8hVGBs8SJerwHkz3+2x1CyINSKLNh7WzLfrR18UDw5xxuDYQ
X-Developer-Key: i=krishna.chundru@oss.qualcomm.com; a=ed25519;
 pk=10CL2pdAKFyzyOHbfSWHCD0X0my7CXxj8gJScmn1FAg=
X-Authority-Analysis: v=2.4 cv=DIa/JSNb c=1 sm=1 tr=0 ts=6a2681e2 cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=EUspDBNiAAAA:8 a=FC_8z62UfPBbNpSbB3cA:9 a=QEXdDO2ut3YA:10
 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-GUID: 9zUp-Souo2wVB3WdavkGJ3325miST6FP
X-Proofpoint-ORIG-GUID: 9zUp-Souo2wVB3WdavkGJ3325miST6FP
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA4MDA4MSBTYWx0ZWRfX91oxZ5sm5pUg
 QubWoadCUBndz8ievKbXcJxyR214H9GZ3zM+Ix6H7eNyzylg34SSFBRkI25oMjV4GriyKXGweu0
 zQyLbtPsTQVKnkEygfDX8BZv5Nf9Iq1LCaPMvq5aZ1zxLbhkLYDI5PcptNL/hUX7IXXZE7ExF57
 EM1R8j9kloNmXafWklYA8egu2Y2vfzg7vQy2Zbl0nToOssFUqz6vfuI7xYleLenhceTZzEPX7Ey
 peQkEOCvmZW2tfLOhMQnXQvzgMT9fojmYT9zTo5wttAq0sEsHAT0hFXcTCtW08cSG17HfFajMk6
 sHouEcnNUGee0MGYWXUgwFeY1LKrGttLEA8HwgpQLqKgMDxEqICyK1yw+uHA08E//yZv4nzB1ex
 nbJC4N/y5FIsnS1X1ENLp8LnUTNHu+4yjjDkzmeszBPg7NOeYsNznQQdvARe5uYKwV3y6EU0cXd
 wIXNAnK3uPWDeGnFkwg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-08_02,2026-06-05_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 priorityscore=1501 phishscore=0
 bulkscore=0 adultscore=0 malwarescore=0 clxscore=1015 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605210000
 definitions=main-2606080081

PCIe controller present in Eliza SoC is backwards compatible with the
controller present in SM8550 SoC. Hence, add the compatible with SM8550
fallback.

Eliza requires 6 reg entries, 8 clocks and 9 interrupts, so add the
corresponding allOf constraints.

Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
---
 .../devicetree/bindings/pci/qcom,pcie-sm8550.yaml  | 50 ++++++++++++++++++++++
 1 file changed, 50 insertions(+)

diff --git a/Documentation/devicetree/bindings/pci/qcom,pcie-sm8550.yaml b/Documentation/devicetree/bindings/pci/qcom,pcie-sm8550.yaml
index 3a94a9c1bb15..fb706b1397a3 100644
--- a/Documentation/devicetree/bindings/pci/qcom,pcie-sm8550.yaml
+++ b/Documentation/devicetree/bindings/pci/qcom,pcie-sm8550.yaml
@@ -20,6 +20,7 @@ properties:
       - const: qcom,pcie-sm8550
       - items:
           - enum:
+              - qcom,eliza-pcie
               - qcom,kaanapali-pcie
               - qcom,sar2130p-pcie
               - qcom,pcie-sm8650
@@ -91,6 +92,55 @@ required:
 
 allOf:
   - $ref: qcom,pcie-common.yaml#
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: qcom,eliza-pcie
+    then:
+      properties:
+        reg:
+          minItems: 6
+        reg-names:
+          minItems: 6
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: qcom,eliza-pcie
+    then:
+      properties:
+        clocks:
+          minItems: 8
+          maxItems: 8
+        clock-names:
+          minItems: 8
+          maxItems: 8
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: qcom,eliza-pcie
+    then:
+      properties:
+        interrupts:
+          minItems: 9
+        interrupt-names:
+          minItems: 9
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: qcom,eliza-pcie
+    then:
+      properties:
+        resets:
+          minItems: 2
+        reset-names:
+          minItems: 2
 
 unevaluatedProperties: false
 

-- 
2.34.1

