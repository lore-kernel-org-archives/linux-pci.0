Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE5DC572693
	for <linux-pci@vger.kernel.org>; Wed,  9 Sep 2026 14:57:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788965824; cv=none; b=rQFKt98wqRmJK7k8kIjy1V6Lw9PWjeMVTuFegx+G9ydKHzlxi6HsQ62dAuYZe0ZvqNPQCIk1EZvV0BdgOXo7CpmazbCwGQA2Ku/eUbrnlKeNYtAWwJNJqGYMy9cYU0a5KOYlidt5HPwnolmMbAbcBHjdz5K2j+GA9Mj26RXHBcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788965824; c=relaxed/simple;
	bh=XggMInr4p/kOChUVji0s69UYgrNeKmtuSko7TtQpILo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=VBWTBSQW9OO+j0RWAYeC4ljG1KRaa2HueS0iYG8+fkn4CbzmBYjrzt6qz9GCpduB+0tjImYRpOzof9OAeMPcuxSYNS1BDHE7jOzmYVpmczJh+9s8VB38fa/gHIzxiVdm3Vx9g30ne/w37i8JRLU2j+nRFqn4aJr4xeeblg2o9v0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=DYCibMWJ; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=T9zLqX3t; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="DYCibMWJ";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="T9zLqX3t"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 689CChwo1400887
	for <linux-pci@vger.kernel.org>; Wed, 9 Sep 2026 14:57:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ZCGZQ+i6grmulaXko8drMOvUQkeNLsh39m6O+zc/IiY=; b=DYCibMWJFOOBEBJF
	/M2Nt3jUPp8Z3fcoPwUf1odz4T/m4p7+MjViPRiLjGSU4Lt4Voe5zHqSJn5iszVu
	M5C+iiohVOFBVStNKBrjJVek6RhoaehRDax9e06tmUAUbQX287THCYey8xORRIWU
	7MBxQOJ/atxJWCzpxCyZARpksoNc/D8mMrK7f5CDRyyb+EJwDqAzjUxyLqgnZXUM
	TNv4vW2LN44FADMf1gaXv/ymezqoVS58h3RcjptzniyAN40NbAJz9wz2mUBxoIeI
	rsNmP+ZlJXIaJEV8wXmdDDoQKYexIZKrTMHoG7jIIg3zd+ZZxCcFETQ+D3RNYkqN
	Bq0TfA==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gk78x0qxq-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Wed, 09 Sep 2026 14:57:01 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-92e820609d9so950892285a.2
        for <linux-pci@vger.kernel.org>; Wed, 09 Sep 2026 07:57:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1788965821; x=1789570621; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ZCGZQ+i6grmulaXko8drMOvUQkeNLsh39m6O+zc/IiY=;
        b=T9zLqX3t5RhuJ+FPwEhHw8i2bdGlJ3gcTiyu65/ryaGev1q1XwHFlFlx17Y0tjfcd6
         K7Q8uG6LJsEUuh5WRwm02lIn93owENPCpiqtgQa//uCqHGaB6+u1nJEkG9NH0re9D4+1
         E+TPkVawaY3DNF2U09Hzr6dad4IZ4cELRNz44t/rfTrwZXM3QQLAiHlMZLS0QUh1ywye
         VpHBnehzTe3+d91w3didGzx6VIfQR4nE3Mfa3BdXJJU6UIzf2YCBbACj+/9of4356UWZ
         lO2OFgK/KCQWoilni6u7IgfpRrb1mhH62M+UKnHElBpE/RfKzXL943VCq6mkq1PQVkvk
         89/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788965821; x=1789570621;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ZCGZQ+i6grmulaXko8drMOvUQkeNLsh39m6O+zc/IiY=;
        b=S8uzVPQT1nKE86fnclp8fASw32knPZSl7/mHGedvuB3wHndD29XtCeHkfnv6TolwJN
         0cjBDKvR48AGsnW+I3YhPcoqkRx7NFSMxQrMdKnYkqx07kd8mhqP5T++eIt1M0MQLqF9
         FLO1OMlJS33biSB3UizljBeQA/sKGYW8bn/WQxESpSnyObz/EhSh8kMvluWdU3g8+0QR
         l7YLEHLR7f79HYK7gLjs4sa0fwT1uN2HE0SnWTuyQdVX0Zp377eWUQHF7A/N4IwxXtb5
         Z3tnDscfyBErqzQNk9qKWT+qWOqgtFwXd0l8n+FnUw5T74rzmz/iwomEZ7SM09rlx8in
         PG+w==
X-Forwarded-Encrypted: i=1; AKwUvByxFVkeihvI668rlAkj3zFME7DrE6A06sjImG3M7yhJYIYj65vDElddb/It3EhRTjjLS5AC8OJhA/w=@vger.kernel.org
X-Gm-Message-State: AFuF++nEcR9axE+SxvT1RyKbrVGzf8yPVQyZ49iZtTZfcEMlFMwzxtFD
	EiP9Ss2OkZTtoCuebgoAoU+pm/P7w+5gvE+G68XkQguHIn0zDcgIDdQ01Lh0n/CEhs+XPT71+j1
	F7BHHnFKeWtT18iY/KjHo8OfswZxNMdod6XTCOjHZoOBAQ3YUPMT6EqeM5oC2Mj9iq5wZXwA=
X-Gm-Gg: AYBFou2Eu2pm39uZUiAXa4rDM70gfLZHrtloab8UYfjdynSzbGj99SYThXDS+laEyG1
	wUqyHgCf1Dps8/rXekCoNzCLfCOpRobgafhmkiEDE9owaKLjklcsZkHwgxLKtDr50cQJRHgfN5B
	LEVJ0R7pNUl/CzqsFHfVmKlgO2djDUvCNTcZXC4xsSeD8oXUZtIwUqYahTZK6ycuhyHSfslhqMT
	4KikYUrQAEtgCLqkRhE6dLJGjsk4L7vlsUOSvsuWts0bMkIF/GYJfCN9fFHZuZku0CdKzdcfI20
	QBL71MLJdziBrlGjvlf2C85a5Xg1DKFGhRub/eBfpxywXxYCaW9ayjnzN6TDZf6k6g9bj4+pF/A
	AoEJDlGyK+D7mxA==
X-Received: by 2002:a05:620a:4449:b0:939:3626:558b with SMTP id af79cd13be357-939d4924cdamr256989885a.5.1788965815807;
        Wed, 09 Sep 2026 07:56:55 -0700 (PDT)
X-Received: by 2002:a05:620a:4449:b0:939:3626:558b with SMTP id af79cd13be357-939d4924cdamr256984485a.5.1788965815365;
        Wed, 09 Sep 2026 07:56:55 -0700 (PDT)
Received: from localhost ([188.216.77.92])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-485883acd33sm44453692f8f.18.2026.09.09.07.56.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2026 07:56:54 -0700 (PDT)
From: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
Date: Wed, 09 Sep 2026 16:55:53 +0200
Subject: [PATCH v5 1/5] dt-bindings: PCI: toshiba,tc9563: Document embedded
 GPIO controller
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260909-pci-tc9563-aux-v5-1-c9b33f56c8d3@oss.qualcomm.com>
References: <20260909-pci-tc9563-aux-v5-0-c9b33f56c8d3@oss.qualcomm.com>
In-Reply-To: <20260909-pci-tc9563-aux-v5-0-c9b33f56c8d3@oss.qualcomm.com>
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
X-Proofpoint-ORIG-GUID: VYSVr7aOXp-sA6E4MPgKwOu7P44ocAWU
X-Proofpoint-GUID: VYSVr7aOXp-sA6E4MPgKwOu7P44ocAWU
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA5MDE2NyBTYWx0ZWRfX5CBLIAQ0TvIm
 as7RSfPW7HV7Jqu8ehlgqugnA+mQidoD5wetvrBKS+/eUxwkKS3o+8eCUVvtra5wdpET9p7DuJ/
 fQciE78z3HAqsV6d7AsqnY+bBZZ9wME=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA5MDE2NyBTYWx0ZWRfX5hX/HU0LKnfc
 0oSJfUR6H901RehvwjrlD4zOTmS/vZt7GhgNIncB7LodEzrL8YuTJPX3JijMn+HKfDlAn6T+0Pz
 ZXoWri8IA9hUW0gvpz8n4SrVYcVuK317rAKZJURJpPmPX3DifKXXNmpFkFB5A97TbkLFSAL/FTQ
 ViWrJ9XS3rWVqUKQQ+rWZHyAYIyFvXidikHf3e3821M/VlHFSjm7ZKOisVCC+dWaJAdhyyl4a87
 RZw6Hlevda/v3uLsg0x+S0DOz6fctO3oCyg17IRTDh8ehApZxE6WGavdtTWeiTlyRLimeAqZeuK
 l6KLgZLvpNPsEuON2h6SaqDhL+yjjlz2NS4tCjDtvLeqMPtz6Ro9vg2IWJT28MncyJL3XxtLUN8
 1b3YoGqyW0kDTQPhGA/Vh8fgvO17bGdxTjf/jmOfm/2mkFf1dzKJQycC5deNUYE0NBqGhIVQp6B
 /Z2yAWK7LecWXuICQCw==
X-Authority-Analysis: v=2.4 cv=SvWgLvO0 c=1 sm=1 tr=0 ts=6aa173bd cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=WpTaRW6qxYHRGzLzQsVYzg==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=EUspDBNiAAAA:8 a=eKs96njmx7wsaJQT5x4A:9 a=QEXdDO2ut3YA:10
 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-08_03,2026-09-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 phishscore=0 bulkscore=0 malwarescore=0
 adultscore=0 priorityscore=1501 lowpriorityscore=0 suspectscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2609090167

The TC9563 PCIe switch embeds a GPIO controller providing 37 GPIO
lines, accessed through the switch's I2C interface.

The controller is integrated in the switch rather than being a separate
device, so expose it by adding the gpio-controller and #gpio-cells
properties to the switch node itself, and extend the example to show
the downstream ports' reset-gpios being driven from those lines.

Signed-off-by: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
---
 Documentation/devicetree/bindings/pci/toshiba,tc9563.yaml | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/pci/toshiba,tc9563.yaml b/Documentation/devicetree/bindings/pci/toshiba,tc9563.yaml
index f084830c6d0c..c4ebb99f50c3 100644
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
@@ -128,7 +133,7 @@ examples:
             ranges;
             bus-range = <0x01 0xff>;
 
-            pcie@0,0 {
+            tc9563: pcie@0,0 {
                 compatible = "pci1179,0623";
 
                 reg = <0x10000 0x0 0x0 0x0 0x0>;
@@ -149,6 +154,9 @@ examples:
 
                 resx-gpios = <&gpio 1 GPIO_ACTIVE_LOW>;
 
+                gpio-controller;
+                #gpio-cells = <2>;
+
                 pcie@1,0 {
                     compatible = "pciclass,0604";
                     reg = <0x20800 0x0 0x0 0x0 0x0>;
@@ -158,6 +166,8 @@ examples:
                     ranges;
                     bus-range = <0x03 0xff>;
 
+                    reset-gpios = <&tc9563 2 GPIO_ACTIVE_LOW>;
+
                     toshiba,no-dfe-support;
                 };
 
@@ -170,6 +180,8 @@ examples:
                     ranges;
                     bus-range = <0x04 0xff>;
 
+                    reset-gpios = <&tc9563 3 GPIO_ACTIVE_LOW>;
+
                     toshiba,tx-amplitude-microvolt = <10>;
                 };
 

-- 
2.55.0

