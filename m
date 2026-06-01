Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C28E39A054
	for <linux-pci@vger.kernel.org>; Mon,  1 Jun 2026 09:47:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780307238; cv=none; b=rlI9X6rBXDVO4UHjnYHKIclHWy5cMFfeOKtT5CQoN/f1r1BDlk73edc84hxUJRUIekCyToomJTpJSsIN/vRgJCbifsLfmur3TLHEAcs3dHlIcYEJ0f47JnZAZ2/KZIIJG/UB6VG7frB2axWnzHqNexDh+4Z8Iklaj31NtXCpxCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780307238; c=relaxed/simple;
	bh=docfPpUXnI1XHz/OPdL2Yqjd7jogAI8PSdedpaSUSzg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=FMf2kUI5iL2JllepeugXm0MKik4WUTHqEnIyEfAI8u/rwnsaAwRZHIvk8+d9OvBUEyOF5OpS0osI+wRrBg9mPIZV/VSzMYlqn2N49q1F1Shbr38idVDmxP/ZUUbC2frTecMfW2+HgB5JCjNnfvf5Q1uuSfwh1KGKGfY1bYJ20xc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Z9ryOJh4; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=PaIFQwc6; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Z9ryOJh4";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="PaIFQwc6"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6518SGJm600453
	for <linux-pci@vger.kernel.org>; Mon, 1 Jun 2026 09:47:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	60CRMLwoH22MNuhk43vWwIeN3bSXwFAvh1cnlrI6z9M=; b=Z9ryOJh4vNQVtmxk
	JR2e68TNAyMQEm5TZPX7E7YplmiBGGLi6PwgQ/PDDpjdSpLRZAM/VvS/KNAMwJWq
	/eis4SPu9oITqsZjztQfNgp2TaJ20ODaKiUAyy8uwbXfAbRJU5LARuQOvGkGACnk
	S0yPiK4M9rHcOTWZerssJMFEFUoCeRp+dyihmrRZ129epv7LoaA9vUs9ynnQ5Ixn
	N8K+ZkrO/xVFKiHXkVBSv9FmUTs+2PwRp98qRhfjyjRgRVtAnzEH4QKgGSorkjRS
	L0TtUqkh3X/FV4Pd2xWiWdFHghHcE/Ttpl8tAClYl49R+4jDUxz33SKNSrxLS/eT
	O1tEfA==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4efq7ff0vx-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Mon, 01 Jun 2026 09:47:05 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-517600719a9so1898411cf.2
        for <linux-pci@vger.kernel.org>; Mon, 01 Jun 2026 02:47:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1780307225; x=1780912025; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=60CRMLwoH22MNuhk43vWwIeN3bSXwFAvh1cnlrI6z9M=;
        b=PaIFQwc65lakYkb3a2ZeDTi5sWSIC4QQangAXzlo18b+GOtiVNaA8V90/FhaLWUJl8
         y8bkGV/kgxRJnIhZXiTHkzzPKzuVvq0wWe2VzfRlz0Fk0fUSdStpYKzWqORmN883sTQk
         0wUkTihNuQ9Rt3KiNKdMbMBf30p1AN2dfPg29v1cywVf6rT+qQFtJzsV+GR+FpXo78bQ
         hCTG/Tp/WKITW2+3FFfciRWI6C6zW3kgf86UBOu35DGWpAao82FJQnpwH+s1BcSs6hgC
         NXN2/UnZXm6pzQn9rcqHdjm3CTehs38ttBDJzaYOBhO6CUahkA38TFF1tNENPa0/XNeW
         XidA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780307225; x=1780912025;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=60CRMLwoH22MNuhk43vWwIeN3bSXwFAvh1cnlrI6z9M=;
        b=fdRxy+R84LbZeCpmoa21ccVsh8ooAjaBNKA9txW6fRStToS9nlxxfFtytRfb3SGgNa
         ltDnnsYvMdrZ0AuEGHqTjUmOaM2ORbHP0rOoZAq7xZwyvhpBKqdyJ2pXKJHLNLdmaES5
         OWGQyYf5ZhF+l9/PKmLbstpmetEgWgJCcYQjO2+4xkW/N4mLQYzY9nNJpTANoowXWKCY
         b2e+QuLFIKFVYzNCchUj/YwqCZqLYXRI9RNW4ovFygRZ0xMmjZGOq3XF2jkyy2WM3KsO
         Bp0KXp+lPL/FXfGyxgKKcDE6chq0E8CtJeNCGFDOGXHX4tkTYsFu4JWQU7BLeyMZ566h
         hXHw==
X-Forwarded-Encrypted: i=1; AFNElJ86F8pTTmM9G9OcG5OB1C0GFLfhHrHSChsJ8aWv1nJkkjAcBUbv1sNw7T6Fui2yIbGJ0XkaUen+3rE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyLk50WxVXdGBu9GPj1KUaZ/icxl/ypqj0ipuzjnw287HqF0rRn
	E8mJzsIukRqID8YjjVkYNV7JFN79g/DuwUYoLg3bunDcpHdCffnkZbqCNgfToefCDZY+2OfiNww
	Srg2rkCIe6FwCf8LPpO4rbJRKN7G5XXlQGFFWKxszkXKPKfTQ8fL6qYqxa2jucfs=
X-Gm-Gg: Acq92OEnXwMPzL1vBAOJj4B43awGRBwYJtk6JKKdtmKiGsnEeJOKMXB5sgi8NhL02UL
	xKlsferAGHP0wbcN38PiijxZnw29TjX/rNIdPmSqGbnsKP8JEFMtNCqz313rcuoepIr+xVJMXxL
	vE4zbuaLE4kOsykrZMpQwwTD3f/cbP8Q+FswdYrRSLDSWaA0S0B5YVxZBjeb8EZfQlj6FLfLj7p
	aT89pewbONrWMU0yka1sIjG6bRjxOsYu7fZG29jgZklWzZrkaVKml6JdnLsU8gP2GjJCQ6QDdzF
	r0stlCv0CUz93JCvXKowh6lW1k/phvx413G+FYjxZxVX4Lu9rl3HRt3GGXp7w6y8q6yQq1++wc3
	Nr4Qu0s642NhKpEhYyZtdDYze0kCn0M5LvcH7jFRIAqwIlGBJL8NnRdlntSQ14eK8X/s3xAEwZ/
	3DbVhE7Y/IE2+gWUVE+GNj2DOebKJOlmQ1e5tpMT4j6RwOmg==
X-Received: by 2002:a05:622a:356:b0:509:44c3:5ffa with SMTP id d75a77b69052e-5173a99136bmr153697821cf.52.1780307225003;
        Mon, 01 Jun 2026 02:47:05 -0700 (PDT)
X-Received: by 2002:a05:622a:356:b0:509:44c3:5ffa with SMTP id d75a77b69052e-5173a99136bmr153697521cf.52.1780307224560;
        Mon, 01 Jun 2026 02:47:04 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-39672802651sm15355201fa.1.2026.06.01.02.47.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jun 2026 02:47:03 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Mon, 01 Jun 2026 12:46:54 +0300
Subject: [PATCH 6/7] arm64: dts: qcom: sm8350: modernize PCIe entries
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260601-sm8350-wifi-v1-6-242917d88031@oss.qualcomm.com>
References: <20260601-sm8350-wifi-v1-0-242917d88031@oss.qualcomm.com>
In-Reply-To: <20260601-sm8350-wifi-v1-0-242917d88031@oss.qualcomm.com>
To: Manivannan Sadhasivam <mani@kernel.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Qiang Yu <qiang.yu@oss.qualcomm.com>,
        Jeff Johnson <jjohnson@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bartosz Golaszewski <brgl@kernel.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Balakrishna Godavarthi <quic_bgodavar@quicinc.com>,
        Rocky Liao <quic_rjliao@quicinc.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org,
        ath11k@lists.infradead.org, devicetree@vger.kernel.org,
        Bartosz Golaszewski <brgl@bgdev.pl>, linux-bluetooth@vger.kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2793;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=docfPpUXnI1XHz/OPdL2Yqjd7jogAI8PSdedpaSUSzg=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBqHVULFMkz7B2KUaWzp0dMD3c4J4pOVHVAE9ivW
 I1u0vWVJ3yJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCah1VCwAKCRCLPIo+Aiko
 1YjxCACZ15J4fbUYzTAR/V7VUO95cRXGAnVEZVcCy9aRNacj+oQUbM8ZeOdKuCyhJJWAlezStTf
 Z40uMUE31aH7GftcJ8ijLYgXo6cpShIy05Ukm2kP5bvkratPZlxmtFGeLP43Cly2zxsyomVS2Nt
 hsYRkrNvAPlOYmc6PBoZw+kumrbJ6D6kzmrTEkm0PtFWENsETv6++fKoWLE1bmNlrywi/VQYzX2
 OnV3ImkPvtNEo3RjpvwaKkwCWfepEYablX98ZLwpNK924P9pAs0lUbrsnnV8FmViAKO6VLIu44g
 MCP4Q8gomOSy+Bsgcu1i5McYOgaT7JFoBDMf+XZ5Zc1OI0eG
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-ORIG-GUID: t_Bct5fHxqMSZhlzQ5glO_kquM0nY4uN
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjAxMDA5OCBTYWx0ZWRfX2umufQ41G8OC
 FLf52ijsZ1diGF2oW/Xa8JFMQDGMv4zEdYCDdF9mdU3T6urH1XuYIdgr39La0pDiH2rG1WUar9a
 ZNLde9Zt0DV3dJEPbJbr0KOcSsCsdHtbgIh4r2VAr9kZSmrzYZIeDgr2WJz+uiluswH8IkcvAPt
 3McXONXUmDWGgo0EemROUl6QB1Ltbd1VnRAqw1gbCyfcqv6QRGcIwWIw635cRt5P8aO0Uab4dN5
 2H7hHwc2WG5EeME3ZWEC7N8fWKfK4qd4kI5R1bQf/3a7gYXAe9yf3/culIbodDXV/I4lu/8Xde1
 iNkQEqJrtTLpXbJegW9TiqtwiEk51SzrMbeoev5hm94Yrgvj+Dn9QZdODt/wiAp1xZiMgjpn+c9
 VLxJOzSI4qv0U1JcyxpFP6hiyEn9YTYFTsZYbATWBlHlzcdDqnzQzP+kN4uTFmekSc67RScFU8G
 heuL18/KvtshGJTJfaw==
X-Proofpoint-GUID: t_Bct5fHxqMSZhlzQ5glO_kquM0nY4uN
X-Authority-Analysis: v=2.4 cv=XqzK/1F9 c=1 sm=1 tr=0 ts=6a1d5519 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22 a=EUspDBNiAAAA:8
 a=a-LFHBoeUMMLBGfzAX8A:9 a=QEXdDO2ut3YA:10 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-01_02,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 bulkscore=0 adultscore=0 clxscore=1015 phishscore=0
 impostorscore=0 lowpriorityscore=0 priorityscore=1501 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605210000
 definitions=main-2606010098

The recent suggestion is to have PERST# / WAKE pins and PHYs in the PCIe
port rather than RC device. The kernel recently started warning about
the older style of DT. Modernize DT for SM8350 platform by moving the
entries under the root port device node.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/sm8350-hdk.dts | 18 +++++++++++-------
 arch/arm64/boot/dts/qcom/sm8350.dtsi    | 12 ++++--------
 2 files changed, 15 insertions(+), 15 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sm8350-hdk.dts b/arch/arm64/boot/dts/qcom/sm8350-hdk.dts
index 5f975d009465..4973a3eb11b5 100644
--- a/arch/arm64/boot/dts/qcom/sm8350-hdk.dts
+++ b/arch/arm64/boot/dts/qcom/sm8350-hdk.dts
@@ -493,12 +493,14 @@ &pcie0 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pcie0_default_state>;
 
-	perst-gpios = <&tlmm 94 GPIO_ACTIVE_LOW>;
-	wake-gpios = <&tlmm 96 GPIO_ACTIVE_HIGH>;
-
 	status = "okay";
 };
 
+&pcie0_port0 {
+	reset-gpios = <&tlmm 94 GPIO_ACTIVE_LOW>;
+	wake-gpios = <&tlmm 96 GPIO_ACTIVE_HIGH>;
+};
+
 &pcie0_phy {
 	vdda-phy-supply = <&vreg_l5b_0p88>;
 	vdda-pll-supply = <&vreg_l6b_1p2>;
@@ -507,15 +509,17 @@ &pcie0_phy {
 };
 
 &pcie1 {
-	perst-gpios = <&tlmm 97 GPIO_ACTIVE_LOW>;
-	wake-gpios = <&tlmm 99 GPIO_ACTIVE_HIGH>;
-
-	pinctrl-names = "default";
 	pinctrl-0 = <&pcie1_default_state>;
+	pinctrl-names = "default";
 
 	status = "okay";
 };
 
+&pcie1_port0 {
+	reset-gpios = <&tlmm 97 GPIO_ACTIVE_LOW>;
+	wake-gpios = <&tlmm 99 GPIO_ACTIVE_HIGH>;
+};
+
 &pcie1_phy {
 	status = "okay";
 	vdda-phy-supply = <&vreg_l5b_0p88>;
diff --git a/arch/arm64/boot/dts/qcom/sm8350.dtsi b/arch/arm64/boot/dts/qcom/sm8350.dtsi
index eb2a795d8edb..136daa444865 100644
--- a/arch/arm64/boot/dts/qcom/sm8350.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8350.dtsi
@@ -1583,12 +1583,9 @@ pcie0: pcie@1c00000 {
 
 			power-domains = <&gcc PCIE_0_GDSC>;
 
-			phys = <&pcie0_phy>;
-			phy-names = "pciephy";
-
 			status = "disabled";
 
-			pcie@0 {
+			pcie0_port0: pcie@0 {
 				device_type = "pci";
 				reg = <0x0 0x0 0x0 0x0 0x0>;
 				bus-range = <0x01 0xff>;
@@ -1596,6 +1593,7 @@ pcie@0 {
 				#address-cells = <3>;
 				#size-cells = <2>;
 				ranges;
+				phys = <&pcie0_phy>;
 			};
 		};
 
@@ -1692,12 +1690,9 @@ pcie1: pcie@1c08000 {
 
 			power-domains = <&gcc PCIE_1_GDSC>;
 
-			phys = <&pcie1_phy>;
-			phy-names = "pciephy";
-
 			status = "disabled";
 
-			pcie@0 {
+			pcie1_port0: pcie@0 {
 				device_type = "pci";
 				reg = <0x0 0x0 0x0 0x0 0x0>;
 				bus-range = <0x01 0xff>;
@@ -1705,6 +1700,7 @@ pcie@0 {
 				#address-cells = <3>;
 				#size-cells = <2>;
 				ranges;
+				phys = <&pcie1_phy>;
 			};
 		};
 

-- 
2.47.3

