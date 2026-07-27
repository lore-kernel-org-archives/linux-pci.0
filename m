Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD24D3E0093
	for <linux-pci@vger.kernel.org>; Mon, 27 Jul 2026 15:47:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785167257; cv=none; b=ku/DQNpglNLesZvocSPF4FxW9BzUpTc6ZjVm+yzXcVBevTAgi0h0SuvE6Y0GlBj9Rhfn3C0WMCi4jPmFQdzoKknezaAi8amj7ez+sJNmVaymnqTGkMqishi9tEX96z+RksM78mUf4PUWdT7rvvw6x+rwHU/bQ7y+o8d/VkRqXS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785167257; c=relaxed/simple;
	bh=yMqnOQaDEEyw4WufS9r/vXZ36AgWvKFPth4a+uQU8BM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=HaRtMcC21c7zafBl3dsbrnHhd2ZvhFaLy654S8Mvzy6J3KLhYGgRe2WjRrwDUxucjEDa0j2E07N2TCL663b/FI6xmjPfOz6FfAOt2acPEFX/DxIch9XXGonEUYH0Ze1tTlGjo8ULdOuWp1SeHrCDWUYPeNZfnrHXac3WnfosCFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=J9ryUIsz; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=e8cYvecc; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="J9ryUIsz";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="e8cYvecc"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66RDlXlE855707
	for <linux-pci@vger.kernel.org>; Mon, 27 Jul 2026 15:47:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	DJP0NMWNGjYscw1h5aBWGeorJPmZjcfRElvC614KmrI=; b=J9ryUIsz+9lBziPT
	gMQxIPU0LWpFNuKmdmY48fh6G7nkavc4cPDli1knc7SAqnDFSX3DirXNlI9SF6os
	avDLUrSgInuHSCuwxDGf9InPVHygDtLlic4T9oBm8Gf6PPGtMz98hqq8DMAN3Vrj
	vlLrXs41Twmr3K+7OUgT6dsEz45zrpzb0yOFk4jwZSCnCAJ0QyKLIZ9ggbCeKJyD
	+W+QWaL95MMjPvzbmhwWW8UnMf+xDr5jITGSoyUfLrJgJU+DHK/8E5vr5WBTm2Xl
	QDeql2pxNcjGueyhlQzwb9kTnsYJ4A6fagqHMbTDnP++fHfBP/kIHWNzGh1Te17A
	JTjQUg==
Received: from mail-yw1-f200.google.com (mail-yw1-f200.google.com [209.85.128.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fny9wju4v-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Mon, 27 Jul 2026 15:47:35 +0000 (GMT)
Received: by mail-yw1-f200.google.com with SMTP id 00721157ae682-81e6bb29581so73587137b3.2
        for <linux-pci@vger.kernel.org>; Mon, 27 Jul 2026 08:47:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1785167254; x=1785772054; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=DJP0NMWNGjYscw1h5aBWGeorJPmZjcfRElvC614KmrI=;
        b=e8cYveccByvfV2aDWv92DJIbmuIBlujAEvam3dhZ/+kovDHTP7EPO7dicIipqrn3Jh
         QaKsVfY2B4wOmUiG/r4bNkc/MV83DpvlZARARvttgq9o14x2sXqOjJtxIfVUDQLdhSqG
         5NxJjkMpw/8kUVaT2dXDZ+AeLXmmSZC2xjQtU0eU3c07NA9r9+Cx1RxsYSA5inpzFQ1s
         ppfBvtN4gwG2AW3ydzUlxkakcFYAu20XT6//r4vI/+Z7rH+iC9WN6YlRB2O5b2bMUnoe
         qdSFfD2fAzRBh3ORw5+HumDVZ2cbOwoEiTCoIh0XBjWcxroEOQSXh3wPvD5FWsuVx/EL
         yBEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785167254; x=1785772054;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=DJP0NMWNGjYscw1h5aBWGeorJPmZjcfRElvC614KmrI=;
        b=jxzxfCKFJNqm3LCJvSTRTICa+9AQoZy9a+5jc6UXRDZqR0cBr866PWFG41TyFNiCQC
         Dq0LQ69pLxAHYDzUe9e2797vB/pR2/HHcdRc6OBl30m4j9G8MZrKhk94drMnC7RhzMs/
         1M5gqLyJTRQbk0Ofa4tYSNpYlhUyGmuF01trrloLYsJvCDZm511e88Y2YEtd9IFGLfta
         6uyFqmaZqyJKqFIx1toO8FSolJqBYETeXdg/lCE0/gM6W+mqn47RnBMvhjicz8u6dn/x
         yADvEWiBHfwhxKBE03zeWrLVeKwODoGvGCO3fApKdDikUzGesAaCVI+00bJcESUYxEXF
         WJdA==
X-Forwarded-Encrypted: i=1; AHgh+RpIeW9JPhj8c7JREWwsiMlT7MBAAAz9Mak4SsWPBe0xKufcHnAgZdZmUkwx+gofnnuiUv+fIr3FRlg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwTyH9ODVzMqaAmPaOTK51/rvgPs6gNGGhUY0MbHB38g4lwlMnE
	hR16ki8lQsnG9rypMw7MIHlkd2RLtkglCctSi1Q9cYwTdLLXWU227LXEsZm7hFNh4zqhhuxL1Cf
	fmcXNRUcjrri7FyUPBVzcSjdA3psqJ9iw54zylcgG0ck9DkCuOswk7c+MBFbgXUw=
X-Gm-Gg: AR+sD11eL+8EpAbLu7ASS7gOEwiNW9ND7KcvsFGePVPESF6f29Ed0p14XwrQhFsYOHg
	/YzhqOAQ8Z/uMJJXrlN4sffRYaMh2QCT/F1cS41jlgIsX7U1AGwNAAG5GKQEbR4V4TAhBicoCNy
	9J0cCPIY2YMuZSEPKWijAJNOQmCGIdbNi1NRvWYBCvKNo/BQv5g71svTtWA88vvc6bU1SideTG7
	Ft6zHAoCOSyccl4xhSx+n3CaF5VudTHeEiKf1yHlzqXALWLvq6k13NmfOEIyhM+utjwKdKcAnyB
	MoNflPM2d051IVDNljyF73dEIZGUue8Uhz4GwpqB2pHsW3cYfZVB/k4zmBkQPtT30Erd4ZTdQPd
	ti648/a0sf0dbjh1Te6G6fudezsqI3A==
X-Received: by 2002:a05:690c:b9c:b0:81e:cc9f:3dfe with SMTP id 00721157ae682-81f93935c11mr489977b3.1.1785167254278;
        Mon, 27 Jul 2026 08:47:34 -0700 (PDT)
X-Received: by 2002:a05:690c:b9c:b0:81e:cc9f:3dfe with SMTP id 00721157ae682-81f93935c11mr489677b3.1.1785167253763;
        Mon, 27 Jul 2026 08:47:33 -0700 (PDT)
Received: from hu-samana-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-81f657c727asm33307617b3.19.2026.07.27.08.47.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jul 2026 08:47:33 -0700 (PDT)
From: Rahul Samana <rahul.samana@oss.qualcomm.com>
Date: Mon, 27 Jul 2026 21:15:04 +0530
Subject: [PATCH v2 4/6] arm64: dts: qcom: qcs6490-rb3gen2: label BT PMU and
 M.2 PCI node
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260727-rb3-industrial-bt-uart-v2-4-2d100f30e202@oss.qualcomm.com>
References: <20260727-rb3-industrial-bt-uart-v2-0-2d100f30e202@oss.qualcomm.com>
In-Reply-To: <20260727-rb3-industrial-bt-uart-v2-0-2d100f30e202@oss.qualcomm.com>
To: Bartosz Golaszewski <brgl@kernel.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Balakrishna Godavarthi <quic_bgodavar@quicinc.com>,
        Rocky Liao <quic_rjliao@quicinc.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: Rahul Samana <rahul.samana@oss.qualcomm.com>,
        Bartosz Golaszewski <brgl@bgdev.pl>, linux-arm-msm@vger.kernel.org,
        linux-bluetooth@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-pm@vger.kernel.org, quic_mohamull@quicinc.com,
        quic_hbandi@quicinc.com, quic_anubhavg@quicinc.com
X-Mailer: b4 0.15.2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI3MDE0OCBTYWx0ZWRfXwnVrDwHk545C
 u/yhIsnihNh7WUxrWXj0nkZa7USg1eq8HwnzLm3nQUwoTRqaXUavDAMVBKPNwSNH/AYTuNPPaat
 Oiu2yxcuQqT5gI7FLRnhAt1X5SetD9l7rjMJpH3IiVd5bDzQSxNnNtgJfg83YoS5EIks1s608sW
 DTC7OLvbjez0ijThpS98VnEWnP9I/7649FvlRck/tkZHksK/MRYWDSbSrrJUW26CXI5DFCYaCX/
 Venu43L2sqN0bYCRYxlA6iaexneOXQE5kjx2IrSF37XCEMXlKof4LUJMk3TqmlqIoI0BKEhgRC6
 wTLIUJMPyUSa/uM4WGX5ICuBTYB4bi1az3IUwTi1tvvywEvXzIGzvOcr/0BY/BJJJ+Pbr8RQeAZ
 cDwh4AYGRPQxvO2Ps0JbJiDh/Lv+EOkFH0DAW1h6FcNIuOzt09ThoZzi5Vye07IvKSVQlbc87lf
 unEj/UhwBoj4A2mQl6w==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI3MDE0OCBTYWx0ZWRfX9i4tPfp34wtC
 9h8igChw8aSKP8HRKwR0NLtNoYZ8OSJUJC97UFn18sT8nYySM96uuWGUYADVSPzMN1BHF74hYf2
 sXQ9ZZROvMUMk/8UdNNddFUFZC2p3QQ=
X-Proofpoint-ORIG-GUID: vBq5c_7Mbu504--P3odiZWPUtTRzSIwZ
X-Authority-Analysis: v=2.4 cv=E4b9Y6dl c=1 sm=1 tr=0 ts=6a677d97 cx=c_pps
 a=NMvoxGxYzVyQPkMeJjVPKg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=EUspDBNiAAAA:8 a=5vclj9FtNX7zLWCMXg0A:9 a=QEXdDO2ut3YA:10
 a=kLokIza1BN8a-hAJ3hfR:22
X-Proofpoint-GUID: vBq5c_7Mbu504--P3odiZWPUtTRzSIwZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-27_04,2026-07-24_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 priorityscore=1501 impostorscore=0 bulkscore=0
 lowpriorityscore=0 adultscore=0 suspectscore=0 malwarescore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607270148

The reworked RB3 Gen 2 Industrial BT UART overlay needs to disable the
on-board WCN6750 PMU and add a graph endpoint to the M.2 PCI node.

Label the exact WCN6750 PMU node and PCI child node connected to the M.2
E-key slot so the overlay can patch them directly instead of using a full
path or reconstructing the nested PCI hierarchy.

Signed-off-by: Rahul Samana <rahul.samana@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts b/arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts
index 37a3b51323ce..b2b6fd29880f 100644
--- a/arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts
+++ b/arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts
@@ -325,7 +325,7 @@ vdd_ntn_1p8: regulator-vdd-ntn-1p8 {
 		regulator-enable-ramp-delay = <10000>;
 	};
 
-	wcn6750-pmu {
+	wcn6750_pmu: wcn6750-pmu {
 		compatible = "qcom,wcn6750-pmu";
 		pinctrl-0 = <&bt_en>;
 		pinctrl-names = "default";
@@ -901,7 +901,7 @@ pcie1_switch0_dsp1: pcie@1,0 {
 			bus-range = <0x3 0xff>;
 		};
 
-		pcie@2,0 {
+		pcie0_m2_e: pcie@2,0 {
 			reg = <0x21000 0x0 0x0 0x0 0x0>;
 			#address-cells = <3>;
 			#size-cells = <2>;

-- 
2.34.1

