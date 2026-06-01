Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39A96399892
	for <linux-pci@vger.kernel.org>; Mon,  1 Jun 2026 09:47:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780307236; cv=none; b=JL8M+BxR1Up3NXI5MkIOpBFO6EiMgz79bZE6IoYi/AJqQrSLMx+fpD/7OEJLW6Yo3o8faCQ5heqfNyaE/lql5AWAb+cBMp3ORE/8o6cUDPbS5YPon/VCZ2OC4JrvPuzpWn30QcQ+hdfEXLhwrFaTL2Ivx5XTaBhR7d0hZc+2VEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780307236; c=relaxed/simple;
	bh=QjvgCxT4cjyfExqVSl23BqemGzEEeOq4tGjsEdwhVAA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mu7so48bIPLB6Z1/MbIn4xkuGo0x3QxbEo03a4+54re2plK1890LbozFHoMZaLdptPVi1mfIVj8QQzE1b5/7cqytkOZyp4SZhrEsLTXgrsDjv6lxOXOSRbGoxYxO0qPGMD+2p6Ufz8tLlNr/qtxIyY5+QPfyh7lyp3+2079Xgvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=QkqXE7X/; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Xa9PDqir; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="QkqXE7X/";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Xa9PDqir"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6518fBsH2740445
	for <linux-pci@vger.kernel.org>; Mon, 1 Jun 2026 09:47:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	iAynyGPj/m6HlAQLnycghU+jkG7FRJqT7laanFnpBMc=; b=QkqXE7X/qkvx0ziN
	ZALrVq4dwcXffYJ+sMpIvKYY9Nv7bZqBzuA9+RdGdBlaM/yKprK+rmLiAUBPAV0I
	Bz8vxf8EYMmTT/Vz4RCtMo8ZNWmalfy52aN07DqUw3FDgjy3pqLEEUmcPzemeOqk
	tNP6viGbB6yro6tlx02KMgzCkgcohEVIzC8jkd/TKN/wQnrBhWweMX9OzLpZxMi7
	EsQR16u4DxHCyDsObMgi8+DULFdaY797NileZiifPDByLSkeitOLgTcgq/3Kp7EN
	YQG6ivI/AlDKzoVTOFma0oZGZhAplOJ6LgDlu+B2akIROsTODgB8zjSkMGCmWd6R
	emW/4Q==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eh6sqg97a-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Mon, 01 Jun 2026 09:47:04 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-516d1a8a6c8so138685941cf.2
        for <linux-pci@vger.kernel.org>; Mon, 01 Jun 2026 02:47:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1780307223; x=1780912023; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iAynyGPj/m6HlAQLnycghU+jkG7FRJqT7laanFnpBMc=;
        b=Xa9PDqirXFpL0UVJASlvEmEmiZw/T6O6Bg6tSIgFonEaq/acMfw/bAFkEeSzR85Hx7
         VrpVlHeh7tyqU92BDn/ziTXz0tAP2ghXLrxw6UpMYNIRYveLmAxSi1gLqc2dVFHvrMP/
         wLEFYHiQY217i8esn+YcYLk10w90wEpV14HW+GodhwRtS0m2Z1UgbIMU0VuynS0/hb4V
         Oo3075xBfxY4FeqnT7zvkXISs//7iudAelbTqonDRf1UkGkTMsAYxFRIxMMFpqTsmdfo
         y8zIWLP+9bwBe1oKCslVmDu17XBg7xBPcF8OzcdGC7GJpK3gBGWjrqeZ4mIPw+kuF7aw
         UB4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780307223; x=1780912023;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=iAynyGPj/m6HlAQLnycghU+jkG7FRJqT7laanFnpBMc=;
        b=OuprxTV0spwuTxGaGoRl+ba6cpe4xCmI+mduzNl/7tsFvLp//zdxqYx5ybeQnnxKqY
         PlfyMtYaczbDEq/qXWj4xrqjF3VUJvlDpZthWuOjo6mVjLB/3SxmTwOeJD4dAhBqC2Wo
         1dyrtWPp/kFbyCXCw/u9qy0OIQ0AmW5aOuNH/k0rJz4K0FHncvDU1XPT4KiG7LjeKdbc
         3ToeLuX0qMkckNaMD/zrEbEQTWs+IQ9M1OZEhYITlHsN076fMirjnSj8MUOp0BTwb0SY
         Ir4wM97imCd2gNcNvB4dDiB3ebADCwvvHPbGbUND300RaqeXHrpZfORBvxBOcuWtaL+T
         /itQ==
X-Forwarded-Encrypted: i=1; AFNElJ/OFenijAf8ruchfTBBm13yZH9ziG6M1bOYGl15c272NcKUMztt5ZMGHmg3T+A+UGe7ks8CCXGANDg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzuDtwKx3sdx7OL3D42en12b5T3m2gjB6hDC/e71pjb+0wdRnNg
	+klpqEOxhy+ToHC1u8HT/+jI+wnWDOptAe5ei5Eo3840TjbZRd+6DRHfHQCIAH/kRIfssJlk0MO
	67ZjEegzHyz4+cMtBGjUtTP4ixEVqEUYrbXvMFqiL6ZsCLl9vTlmuA8uYhUZ2/zk=
X-Gm-Gg: Acq92OHu05VR3wdwDn4T00aUfJNP0Wp4+lbuUlVZm8ygL4Ic3xFgPYxV+4+7nGTOMGh
	1Gxa7XvvvS4zGlN0L9My1R1L6jreshNSQMUMYsp1gg6Srpcejp0xlEbR1JfOJsz3+bS/qr+4G2j
	yxGcGpQNiei21h/Vm6Kx1m3Qw1WhU0oU+h97YktU6W2NMuaQPjbI2RADVBAw0aJtHpNhDGo+bJi
	W4YkaAyvXHMiwdri0a5GIo7w+b9Y2OFLUrzbxL/N/whLD7UTSE/7r1OqEzRC3qjmiD8Hj/X8qdV
	qHitv55qUdiYFtL90XbU/tZSrk4bBfAOKUFcu4rg/TtB1574zy/Y4Wofo+sNUadmAsDbC571sz0
	CWyt+UM/FBioy6E8fer3L4dCA3K16qMMSkXJsmikOAB+hVIrJgrW0/LPs9fJjRTl9Y/yJgGrsWq
	eagDaB1Gp/7kXY6jItHvr9HNoLd+yAeilC2HB2usr6MWS8/g==
X-Received: by 2002:a05:622a:2289:b0:516:e833:64f2 with SMTP id d75a77b69052e-5173a61b308mr155830571cf.12.1780307223359;
        Mon, 01 Jun 2026 02:47:03 -0700 (PDT)
X-Received: by 2002:a05:622a:2289:b0:516:e833:64f2 with SMTP id d75a77b69052e-5173a61b308mr155830221cf.12.1780307222934;
        Mon, 01 Jun 2026 02:47:02 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-39672802651sm15355201fa.1.2026.06.01.02.47.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jun 2026 02:47:01 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Mon, 01 Jun 2026 12:46:53 +0300
Subject: [PATCH 5/7] arm64: dts: qcom: sm8350: expand UART18 to 4 pins
 config
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260601-sm8350-wifi-v1-5-242917d88031@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=873;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=QjvgCxT4cjyfExqVSl23BqemGzEEeOq4tGjsEdwhVAA=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBqHVULL9vA98gnb1vk5P6BUKdenYE36uwUMwczc
 eklc7UGkxeJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCah1VCwAKCRCLPIo+Aiko
 1TcCB/9Ju6oFg8fhJQdx/b+0NIq/nalsJ7rHRSaj0cfCy6j/WB4c7RAbf/wVgPTuKG9aqavA9he
 9Nbn6yvgwTHTPX1HC1rY46piFDOkAlpOnmMj6vV+vSkCbzEDFaQpDXnUwouZ7MadIGG0ST/sXAW
 /sMDmu1f2KiaeB5VoyLAhuJZ/iNtUmEQPCDwzQskxbLE2UB/crRkEUVEa0sml95PLW2IULVYOOU
 bbrFoaVy7Y5JAFPN7FWkVZ2m5oWPVrZqPe/nMM4P85MGVfoIuq5RbXZdXLYGf+o1iJBWZVtFnaD
 ioQ09vSKsf7vxhefn0Ual5WTrmsIHgB0S5G7Lw0P/Gfdrtp3
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-ORIG-GUID: 2n6Zed7i08q3IKBhJyoN0oGDlZbAcNsf
X-Proofpoint-GUID: 2n6Zed7i08q3IKBhJyoN0oGDlZbAcNsf
X-Authority-Analysis: v=2.4 cv=eqnvCIpX c=1 sm=1 tr=0 ts=6a1d5518 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22 a=EUspDBNiAAAA:8
 a=GNmHCbt0ONPBLg8daWUA:9 a=QEXdDO2ut3YA:10 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjAxMDA5OCBTYWx0ZWRfX8fO+jxPHmPVb
 M2K8TmuW4aZRuUe+/VzcEY1xb4LKjLJK+OOma3rfsjUjL7RUXRJIMcf1HThXyHOO5kP/1Nb7v7I
 l5QNkuT+jhP0QpbMt9/hWYFvpwAZxqzGd825eqyLAoWyI8P1F3x7Q9j4j7pUNkFf+RNu5oBxWkV
 k57MXCjs8aMIKeccrEAOQjnUtXXeFNHeaYe9Vii1+41wpVWwmJ2eVYJha75hUyLPSs2akmQKjnf
 CppOlM2hq1NeopU/P9k2DUxK1e56SXetSbPu5rKcrDK8snwyy3s2gwyyMpM/AhmOiMY9GU7sRMj
 QlLuHduCybHhnuQqY+Wr7dVyWPPAkJ25XeMs6AGlOLb6sKUvUEXH9LLTvDivTGtwWrx1neeDOxA
 mkKfCdt1CBwr/dHt7Ur5P6ANK9ZIQjr9wgdkvow3GhNEBWSRAFk1vsQNxjE3BbtIml3fUDl1ZEI
 DSLt5RaScTlZH3hPGxA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-01_02,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 impostorscore=0 spamscore=0 malwarescore=0 priorityscore=1501
 suspectscore=0 adultscore=0 lowpriorityscore=0 phishscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606010098

On SM8350 platforms the primary use of UART18 is a 4-pin UART (targeting
Bluetooth or other similar applications). Add all 4 pins to the default
pinctrl entry for the UART.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/sm8350.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/sm8350.dtsi b/arch/arm64/boot/dts/qcom/sm8350.dtsi
index c830953156ec..eb2a795d8edb 100644
--- a/arch/arm64/boot/dts/qcom/sm8350.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8350.dtsi
@@ -3309,7 +3309,7 @@ qup_uart6_default: qup-uart6-default-state {
 			};
 
 			qup_uart18_default: qup-uart18-default-state {
-				pins = "gpio68", "gpio69";
+				pins = "gpio68", "gpio69", "gpio70", "gpio71";
 				function = "qup18";
 				drive-strength = <2>;
 				bias-disable;

-- 
2.47.3

