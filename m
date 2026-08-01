Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 732153C1083
	for <linux-pci@vger.kernel.org>; Sat,  1 Aug 2026 19:55:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785614127; cv=none; b=idPUoZT2dy66mq0PYyDJBE8JwwmKdaAsr0XTvwu7RS+hsIPUAPUQn1VPK4kocDDuPYp5vlULzdk7uNn+Ne0T8AY6MEY9gN5vdG8nQI5Umq/wmqqUTJa0IG2c7c2Fp0t7bY+BkiCbiy2MTGPZrqYIKuvBE5t8u2ZdtKAfr9op8Kw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785614127; c=relaxed/simple;
	bh=mZHWAuSeKaFREk3s3TsCeBqYcHg010+ZFZVBB6WI64A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tRte0952/m7EfbSfItkeE+3OL84lTmldJQeglGQLdl7dec+yh7Mv3MrGJmxvUY8eWpgrkuJKbC4wQoN3HBpN35FpGw4Zmzy7LrjiHixzQfxlvAF6vHWaJrJkQAgp9XEjjEN7+HWjJNPnwbmN8PO+sWjZvwJN8db2zBRfMspy7Co=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=fS8+P9BR; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=YIpVbVoA; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="fS8+P9BR";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="YIpVbVoA"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 671J02Qi3847696
	for <linux-pci@vger.kernel.org>; Sat, 1 Aug 2026 19:55:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=hi7qwC9Ys33lceH7czkrRMTjgxXHEZVRfXr
	RqrzJ6fM=; b=fS8+P9BRkVoF4CeszARZydRmMHsGFpCDRysHyyvhuEqtNEaNgKk
	Pk4MIK75koHduD6b0/9SWn5zXBY6rMEBE2tlh2+M9hCmMgY/jpFO9BXke0wpWMAz
	D4mpk5LXuKNd1lk3BAClAjBTOFYYhZgmsLfAV6kcbCrXGAzzx/I/aezFi2t/xtSI
	1T330uvbYvyL5N0sEgXjIuMCy/W7AA1SuSEuliO6uJ1IxCciX+RG/G+mlxTBD5dk
	rOVzkJ6KKhZMYQlfZfeafTRA1btS1RJ0jbyTNqx9bXollh9GaNeq4ctHxSVfJjgw
	d95zyvN6ynxZtx0pMFP5c/K9r+7lqH7tGzg==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fs8vt9nde-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Sat, 01 Aug 2026 19:55:25 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-51c083f1818so20678841cf.0
        for <linux-pci@vger.kernel.org>; Sat, 01 Aug 2026 12:55:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1785614125; x=1786218925; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=hi7qwC9Ys33lceH7czkrRMTjgxXHEZVRfXrRqrzJ6fM=;
        b=YIpVbVoA4WMbFzCtCiJNdBSbmvJthJfZMZJjPEhdNwKmWbhuuoAfLXUaNInatnnqJI
         u+o6eHvJvWAV7w2tAwCJy32gF5+aOh9JGc7Nz+nId7O4z5Fl3cAAIpAcvjjvLVWNpqC9
         opVID9dIxaypQwl4YGmD7IXgXfLGzXI0uww9QuHbrEWgz0AeI67w15BkKgIBVzvT9/2m
         /ISvH1ahu+B1kYh0I5ild52TdcGNWm1c6ZlgGPSEY8g7rny4rNEdaP86gwZC7g6fp0Au
         cdDjTB99w/YBDndKnMdUeZ14sjEtc/NppIuGKHGA34Q3FHgmyT4aqeh1ikDt9qREQk4z
         8Fmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785614125; x=1786218925;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=hi7qwC9Ys33lceH7czkrRMTjgxXHEZVRfXrRqrzJ6fM=;
        b=iQtpKHbH2NradZ0eSUKY4UDLMnqui139y7Z4FMKha/AivDAWwrZ9tIi4WAioyJr19S
         ZgKqSQOCDsILGNIsxnnGKcEXujwuuF3cQQR6C5WkHx+20J+TJshTnkJzXYHKNa4t0sE9
         8UBAypK9xgAXBqpN3U7NvN8qqsakZRq1/+JCUaG7tqlgmJoL+nt5J3DB5+hOmqGtyI/4
         /7kd+qu6kTtfBVUjZweVfItoftUivPCdED0THkEnLFEaQ4dAoPYIbRG5jQJgJXN2RNkz
         AQfnMj8/X86mEgMEEafBgjDf8sHo2CAGa8NTIMhKdCf+jKRtzaMg1PEE+jlgfvQIBcfX
         vLdg==
X-Forwarded-Encrypted: i=1; AHgh+RqeBv78SeLG21JbHmC00ptrVjUbW1NDE+fq4Qb3pUrBnFtbr/cRGuIo5xGQd9pNZaECwS5nPI8m5p8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/UsAxRAXzeA22TKw5NhPKKaNvssUcPTijO5U/cV63dYSgmy9a
	YLAeaPOFmeth0LN2aPEtc6Ewhj3NUcR0InVToNYCc23Ud6HnWVBmQNJefTj84G5uDN8eS6b2UvF
	5b7s6U/WM9sYKJ5V2X4FZWZbgcJZUdDErzNsooscQPkq1FYaif+rBnW/vDyC0bwU=
X-Gm-Gg: AR+sD11m54W81epXoMQgQydWB7F3FoIBxpz2Dt0dktgPxLX5w9/9+AEgUPPKPdATWUd
	KejxJBpiPJ0a4DzMJFaNBJFLmZuJSTk6mCxIpW2f3DffXzG0pqmU6umDH4UzmXBZAXVGrYnm92n
	DT6/SiRqJb+MzZ5ExZMCBdhuAnpWN4/rwnGhOjt+u3KmFUfxzJLIq+Np8fNC2RvWhK0yrYDPexa
	rDW7cv5TpL5ZWJ0J+/bvpej3lRgGR1FNCxEt0iQEDfV2m+3h1icKDamteqfgxI/L55MNH5GO4Du
	3o8fVaThEv0CHWTkwyc80MwWHfsrmWfTkPHpbJ6f80V+XkF1MfQwsuNSzwD9CVFZSSTENNBPnoB
	WF5XKH7hM7U5LgV7u
X-Received: by 2002:a05:622a:4d0f:b0:51a:ee21:d342 with SMTP id d75a77b69052e-52b567522acmr111615921cf.20.1785614124682;
        Sat, 01 Aug 2026 12:55:24 -0700 (PDT)
X-Received: by 2002:a05:622a:4d0f:b0:51a:ee21:d342 with SMTP id d75a77b69052e-52b567522acmr111615461cf.20.1785614124198;
        Sat, 01 Aug 2026 12:55:24 -0700 (PDT)
Received: from quoll ([178.197.223.174])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49807b5f0c3sm74694415e9.5.2026.08.01.12.55.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Aug 2026 12:55:23 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
To: Jim Quinlan <jim2101024@gmail.com>,
        Florian Fainelli <florian.fainelli@broadcom.com>,
        Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Marek Vasut <marek.vasut+renesas@mailbox.org>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        Kishon Vijay Abraham I <kishon@kernel.org>, linux-pci@vger.kernel.org,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Subject: [PATCH] dt-bindings: PCI: Correct white-space style
Date: Sat,  1 Aug 2026 21:55:18 +0200
Message-ID: <20260801195517.235161-2-krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3897; i=krzysztof.kozlowski@oss.qualcomm.com;
 h=from:subject; bh=mZHWAuSeKaFREk3s3TsCeBqYcHg010+ZFZVBB6WI64A=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBqbk8lI71bPd+afSLiOOSgUBFK9QNKQ/CfX7jgg
 +ZIgESpx62JAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCam5PJQAKCRDBN2bmhouD
 1+giD/9UrL5r6rohmURssJaLdBSj35eMCF6Q1TlSBx0A/k8Xyn/QQd0NRXPEJ7nd3yWpo4KvjGW
 hew4ADAPDXJ7xADCHaR9enIQy3jUBzrdlwZgSoH55vZ3C26JJjza3AiWAGJ2zF5AY1X2WHa6dcN
 aUCyT70cH3Ya1EmjSmu8Hx1KZssBfRyfBpQ9NvlxyJsv/dAk8pyxnfb9f3UCHT1PHEoTMKFLnKZ
 4JR8wYnwuRHuokyEo1bJ/FdYdAbmm4URgjmuY1UuYSC8kYGHeBYj3dp2x6NuhGC9dKnqsL/Tuh3
 Y49QLumAhjBrIyvL7WtOSlEJ2IKpSBzC05MI3z1lZbfAvnSnmhOydMmjgaDpgRsbK/TIIMAOb8v
 LyI2/L1UH2zJ5b2OX1FgwH9TKiBuwJIGSmKIuYrre+HJKweoXXTP20LyikioNFwIFJRp0NTO6XC
 X7BG584MJOvN8rov/tkkeDv1hZmyjC0cSsaRCp1yEyYMdej5t/bPax/8CdWmOAhFt/zI47adrJQ
 htQE+Ybt4eRgpGACK2goN0+SKq/OvExKomF1z9P5yi8v4ckE/h8T8A6JSuUcBlssJXtnrd8Ktmz
 esoHVN33bXl0oLQw9Hpxz08GxnqVbyibDfRUF3tB9nVdSGreDv2hN/mkN+VPM+BxKpmETANXXOo k+2AaWGFfaR+dpg==
X-Developer-Key: i=krzysztof.kozlowski@oss.qualcomm.com; a=openpgp; fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwODAxMDE2MCBTYWx0ZWRfX25MNOQmtPwwR
 pUnfXdPfX3Obh5PHwwIkL21ny3wbK/R08N2P/zt8T9/3vhEU/XCbPb/X9outt6EhV8pPIbeEAuV
 YwIYNw8aH7CYzgIQkNAkPdOWjTOiMQU=
X-Proofpoint-ORIG-GUID: Pi8IB-BT4QQDrWHBAIvOdN2BJK_DGwCX
X-Proofpoint-GUID: Pi8IB-BT4QQDrWHBAIvOdN2BJK_DGwCX
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODAxMDE2MCBTYWx0ZWRfX+yhHHn+srlII
 g7ojIM9LE1utta05tlpXC7Uqtxvuv97RwSnm2cppL+gJ25OItKlrODdr5HtPTA5RVQy8OE/mHlO
 QJmeLdXWvz3uZCCRi3OH155HqS4R5Af5pqW1rGWclh1+evA3pM5Gu2wyXsCcw9VgLE2DsnEbtey
 IM6Rlmbi4trnk4RSuwU957+Lq82jqdTiILaG+s2pmqd8f0mMJHDXMqcwf8Cgtw0jKj2fTCB/bWd
 +wP3uRHcJROuhNQm8EKYKzil5BQsiFUdT2I4vtgnMz2nlYlVISfV4I50zzbxRRbqd0iX1QZSWfv
 dMAsiJFDODhi5f9LrSmJO1h36j3SoaHvjzcWulEBOpB6fKSc2ZyIvK706PY2kYk2WavUNqN3cLz
 mH26FN+KSN8Yxf8+j201BG180nkqN2Mt9Bvx98EouxPIPV7Ve2taTMa7K+RQazV5plfpSgJI0fk
 7Oc+Ey0s+RnRq939M7g==
X-Authority-Analysis: v=2.4 cv=fKMJG5ae c=1 sm=1 tr=0 ts=6a6e4f2d cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=N6niishs+lR9UBL1FN3Qrw==:17
 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22 a=EUspDBNiAAAA:8
 a=mxJljgaHxS3Sv8GYpwQA:9 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-01_03,2026-07-30_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 lowpriorityscore=0 priorityscore=1501 malwarescore=0
 spamscore=0 phishscore=0 clxscore=1015 impostorscore=0 bulkscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608010160

Correct a few white-space issues, like double space after '=' or before
bracket '{' characters, which will be flagged by dt-check-style.  No
functional changes.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
---
 .../devicetree/bindings/pci/brcm,stb-pcie.yaml       |  2 +-
 .../bindings/pci/renesas,pci-rcar-gen2.yaml          |  2 +-
 .../devicetree/bindings/pci/ti,am65-pci-ep.yaml      |  8 ++++----
 .../devicetree/bindings/pci/ti,am65-pci-host.yaml    | 12 ++++++------
 4 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/Documentation/devicetree/bindings/pci/brcm,stb-pcie.yaml b/Documentation/devicetree/bindings/pci/brcm,stb-pcie.yaml
index 812ef5957cfc..328b8156cd94 100644
--- a/Documentation/devicetree/bindings/pci/brcm,stb-pcie.yaml
+++ b/Documentation/devicetree/bindings/pci/brcm,stb-pcie.yaml
@@ -214,7 +214,7 @@ examples:
             dma-ranges = <0x42000000 0x1 0x00000000 0x0 0x40000000 0x0 0x80000000>,
                          <0x42000000 0x1 0x80000000 0x3 0x00000000 0x0 0x80000000>;
             brcm,enable-ssc;
-            brcm,scb-sizes =  <0x0000000080000000 0x0000000080000000>;
+            brcm,scb-sizes = <0x0000000080000000 0x0000000080000000>;
 
             /* PCIe bridge, Root Port */
             pci@0,0 {
diff --git a/Documentation/devicetree/bindings/pci/renesas,pci-rcar-gen2.yaml b/Documentation/devicetree/bindings/pci/renesas,pci-rcar-gen2.yaml
index 065b7508d288..1f0ab9ccd1dd 100644
--- a/Documentation/devicetree/bindings/pci/renesas,pci-rcar-gen2.yaml
+++ b/Documentation/devicetree/bindings/pci/renesas,pci-rcar-gen2.yaml
@@ -155,7 +155,7 @@ examples:
     #include <dt-bindings/clock/r8a7790-cpg-mssr.h>
     #include <dt-bindings/power/r8a7790-sysc.h>
 
-    pci@ee090000  {
+    pci@ee090000 {
         compatible = "renesas,pci-r8a7790", "renesas,pci-rcar-gen2";
         device_type = "pci";
         reg = <0xee090000 0xc00>,
diff --git a/Documentation/devicetree/bindings/pci/ti,am65-pci-ep.yaml b/Documentation/devicetree/bindings/pci/ti,am65-pci-ep.yaml
index 74195c1f5292..afde18c5a4fa 100644
--- a/Documentation/devicetree/bindings/pci/ti,am65-pci-ep.yaml
+++ b/Documentation/devicetree/bindings/pci/ti,am65-pci-ep.yaml
@@ -63,10 +63,10 @@ examples:
 
     pcie0_ep: pcie-ep@5500000 {
         compatible = "ti,am654-pcie-ep";
-        reg =  <0x5500000 0x1000>,
-               <0x5501000 0x1000>,
-               <0x10000000 0x8000000>,
-               <0x5506000 0x1000>;
+        reg = <0x5500000 0x1000>,
+              <0x5501000 0x1000>,
+              <0x10000000 0x8000000>,
+              <0x5506000 0x1000>;
         reg-names = "app", "dbics", "addr_space", "atu";
         power-domains = <&k3_pds 120 TI_SCI_PD_EXCLUSIVE>;
         ti,syscon-pcie-mode = <&scm_conf 0x4060>;
diff --git a/Documentation/devicetree/bindings/pci/ti,am65-pci-host.yaml b/Documentation/devicetree/bindings/pci/ti,am65-pci-host.yaml
index 98f6c7f1b1a6..db92125a2f2d 100644
--- a/Documentation/devicetree/bindings/pci/ti,am65-pci-host.yaml
+++ b/Documentation/devicetree/bindings/pci/ti,am65-pci-host.yaml
@@ -121,12 +121,12 @@ examples:
 
     pcie0_rc: pcie@5500000 {
         compatible = "ti,am654-pcie-rc";
-        reg =  <0x5500000 0x1000>,
-               <0x5501000 0x1000>,
-               <0x10000000 0x2000>,
-               <0x5506000 0x1000>,
-               <0x2900000 0x1000>,
-               <0x2908000 0x1000>;
+        reg = <0x5500000 0x1000>,
+              <0x5501000 0x1000>,
+              <0x10000000 0x2000>,
+              <0x5506000 0x1000>,
+              <0x2900000 0x1000>,
+              <0x2908000 0x1000>;
         reg-names = "app", "dbics", "config", "atu", "vmap_lp", "vmap_hp";
         power-domains = <&k3_pds 120 TI_SCI_PD_EXCLUSIVE>;
         #address-cells = <3>;
-- 
2.53.0

