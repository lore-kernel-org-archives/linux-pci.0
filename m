Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A424839A07B
	for <linux-pci@vger.kernel.org>; Mon,  1 Jun 2026 09:47:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780307241; cv=none; b=gZc3rJdc/hK5CI//hrYjQOk1H5KEqWcxtHXNOUc1AKzvmL93BpjOwoU/f3MAKFZco62Ilshh2RnsBLfNN3eLjhRdONpdlar9F0uHi3HDcysGQseIAzNeXqQYu8voLConYV6gQnhkld+fhVXoamUXmv9TXpIH1DPU+wuJ3/a1PB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780307241; c=relaxed/simple;
	bh=p/vEWXfWcfITuHPO9mfDyXFqaiM3ASW/1cHspYUnUG4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=uYp9xDeEY9qChWPTlo8lVE8CchnS3KaCA8gIGa6u+t5tFce0e1EeYnkjyFCpiieiSdK8FJj/6TqljRQiUJqBmcRMeuqFSn3SE2Q9kqB7gPVLJ/Hx2OreoLL0/kZMfYq+fxw20/+xzlHfW2WHoKWbQojTFni/DtrC2YizomeOB0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=iq3Eq1uJ; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=IeSG4yNS; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="iq3Eq1uJ";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="IeSG4yNS"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6518fllc4066038
	for <linux-pci@vger.kernel.org>; Mon, 1 Jun 2026 09:47:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	32iMDaQ3qO7lDTIoDuzY5zW3z4FbD3aMPXHmlVvtKpA=; b=iq3Eq1uJy5sqIyaB
	HEeTyGysoJFEbltXLV4EGShG2OY1eXw99X6JDSbw21wY57+Ry8w7iqhCG+9pc7e3
	WTNa9kgWHeLANCjlgSA1mPJQUkFMOPzJShC78ifs1DNraLkHfqEAVLiBMbtFVrCq
	ZPUxTEi1AVKlWjoHniamktcwbrcGahmyziNw/5CF6V68ltzeyxDo9VU7bydmkJGs
	dqBtOwayhiZokYmcjfP1rmTJ+DbSWLcZKPAR8nOfV4y6IDrpD68FV/UAsTQVp9ex
	zcGpwK3XS2dGoXKO+/0lV7vqhQ4y8b1210ygEdjfdIcPyydmQRfh79lAKR+taZiK
	LTRoAA==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eh6swr9fm-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Mon, 01 Jun 2026 09:47:07 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-51760f997fdso1792431cf.2
        for <linux-pci@vger.kernel.org>; Mon, 01 Jun 2026 02:47:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1780307227; x=1780912027; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=32iMDaQ3qO7lDTIoDuzY5zW3z4FbD3aMPXHmlVvtKpA=;
        b=IeSG4yNSeqImHHiYB/YQ3mjNpOKrAVvbqGFOKQrHJ0AtUj82M1Rp14aiAuprhD+f/S
         39I4qB07aZ3kxWHBXzSYojF5yr3A7qIvzu9pEi4HvQo3DA4CeEuWN2nxk5ITZ7qqw4ly
         SUVwcLgNQoOFirj65IjXxfrs/S7aDYnjaqGnCjGkMUcI1uTLMOdwVtRq8VJg/rqODnBC
         fTFTsJ/K+SJ3DjOOTZl4bsW8JQigPO/vd2REf+F7yNN4lvnZsx57QPTkFhq+q7uEOiX8
         qALLO42aLMVs2uLgekRzrkMHr4gJgco3VZc5aWE/Ev2cp3eWXSxlZ/5JSmTsVc44VnTI
         zTcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780307227; x=1780912027;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=32iMDaQ3qO7lDTIoDuzY5zW3z4FbD3aMPXHmlVvtKpA=;
        b=dJlrxQzBB9fG+bogSIU3g6mTmljMw/ppvCBw4axUSVyAtEoDcb3bXepdsrsokZsmPW
         /L2rGwJOdrOCtf6mgSxn4fBZyG91kYJ3NUXe6qMJrbYFNGAznGuxlnKs32sd47eB+R+O
         o0Q0WP24ene4puDnbRDuNsjed87jRYtLbKMeJ8dnPROW6ZGqle328gEhaAgJuR3Hwoat
         L3V2F3YTa+65sHR8LhXQ3krhCRRxWO4qJmncpqvZZuEBWI8A9EiBwSn0C4bTsMqkEhfw
         lyRVQKyRq/EMwU0PrFMl+rtbKllbWDYyyBSnmotBgJbD/DCA06L62FKOSnieMQhbDyFb
         g8hw==
X-Forwarded-Encrypted: i=1; AFNElJ9Ih1BFuzshObhTajQ8T6Tk4gqkfI8yv/mlGVX3Lu0HpWdAGD6dqvOVbmCMlVEY3ewbhTgI+feqLeA=@vger.kernel.org
X-Gm-Message-State: AOJu0YztzK5X9i+Sa/KBi8iuy+M6epI/+XebwJl6vH8CCb8Cc5k0BzFo
	+aOJiTOveksrAELbz8dDDE177syiYGPzhLWTXxtwzDWYDlCleRbEyl42nSvKrfi3fLKXYHK485O
	QRUCq3iS8fkb5uJm7If/bz2h2TFjiKkAUByrU7QMli5ZXuGw62SolblFT/UvWD/Y=
X-Gm-Gg: Acq92OE+DFGZr8eK6RanScFodFkMQil4WwZfunWOqkhZZbuSA9fCx7TDpbu+49+jboG
	v0m4+a+UkNuLS+UiBBjowW/erJUetDDYIvY4sv5uQCtFZu3QAJGUJABRkGfPwqvCIkF5hkEApif
	FIM1zxiBf2Agye4DOTQfIgBtBCfm/r6G8l249b4ulLtjpTcnAJqXauM9o6eZKVZc3jMx2mOSgJX
	agw+/SIPlTh5WpbxCGoTw7kVWTY3YcywkM/1Uf7feefZB/3BXwxmv8kFwgAZBNDyWehaH3PXqCD
	RsPhsy5sgQd0N6EccSAwheZcs/NN43OqewIkF/BysFMCS+vLPdLcV1iblg65PLXm9amuFN/jFEz
	/kx4H7tic29B+9iY3CvnSILNMZ6pE/Rh+cAO3g3FzdrfUrvi0ittEjHi8XRqpIsoTag29g8GMex
	CK4dvEtGYvHXrqxr01xg4e5Yhk8tZ8u2RIriV9Jn0Uq6b/yA==
X-Received: by 2002:a05:622a:299b:b0:517:58f6:29c3 with SMTP id d75a77b69052e-51758f642edmr25765741cf.32.1780307226583;
        Mon, 01 Jun 2026 02:47:06 -0700 (PDT)
X-Received: by 2002:a05:622a:299b:b0:517:58f6:29c3 with SMTP id d75a77b69052e-51758f642edmr25765361cf.32.1780307226184;
        Mon, 01 Jun 2026 02:47:06 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-39672802651sm15355201fa.1.2026.06.01.02.47.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jun 2026 02:47:05 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Mon, 01 Jun 2026 12:46:55 +0300
Subject: [PATCH 7/7] arm64: dts: qcom: sm8350-hdk: describe WiFi/BT chip
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260601-sm8350-wifi-v1-7-242917d88031@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=6120;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=p/vEWXfWcfITuHPO9mfDyXFqaiM3ASW/1cHspYUnUG4=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBqHVULHknQTeqgXWLpTQtoBAPOcZ8nrUprloMHR
 HJqLRInYkSJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCah1VCwAKCRCLPIo+Aiko
 1aswB/wLWeCDt7fqtyhpWQItLB5x948RgkF3AfS0s+K8vCNS5F6wN12TNHhnvx6N92e7SeuS4/O
 pbuLBC4kiL5kaoUWP2Y2zQ3KSWOUJWD+rWVtpA48mrHt41PQJIlx4L+YFCCLVPhZYsJwM9AsJFq
 0Z0rXdQuurtvBjuJbjkZEra7j+3bJMC6mOC+vkVWFisrSPB8txE20LJCRlZ+T8zT0MxTNw+g4Mv
 f9qnmUd5tW+23KQEPL/PK8+GbLTgxdPT7RqFbxhnPP+v+txO1Ku6VgmYnPSDBsruBI0FWtzcq3q
 EtcYzFmbprwQUCgBkP1sBKeckGK9uTFw4M3HA2jL2HVKUFn/
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Authority-Analysis: v=2.4 cv=Z4Hc2nRA c=1 sm=1 tr=0 ts=6a1d551b cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22 a=EUspDBNiAAAA:8
 a=o9ryCBrv46mMSQ48XGcA:9 a=QEXdDO2ut3YA:10 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-GUID: 5knheuZlAJgrU2SKuQI-uy4_h40Q-ziC
X-Proofpoint-ORIG-GUID: 5knheuZlAJgrU2SKuQI-uy4_h40Q-ziC
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjAxMDA5OCBTYWx0ZWRfXxVoF6RNfAeRe
 6E80ncwPkBmp2Xk+K1tNSkZzIQME7X1Y5q0ewkVhICyh/G09JKV23xkaY/34NXQ5WUhPnUNa4dX
 tsBrw6fwCDnCKVLtN9tyPeDpkF/riOZ6sI0dekUeuCt2xgvEkkh0uVYB04GuArZLkj29UmTkcFL
 vLoH0YOmkZBKmIRt+CIXsJ+GllQisp58FIJRvW/HoCnUGFRujfiDeMa6+oY+J7ktxd9kfBSrwas
 yKY1ZKSsQBkwcQpf0zSGQ8GoUM6Iv2skXR0dpePiQsiyIE+wY6U0u/n8ytfjhn6kD7a3QIi5+z7
 hy7yzmitMpzbNFSif+C6gxJgwin27xTcnLW7dLZRouIkLPC1GG6lYDqrGx6omIkFypccsxKLuUd
 nY0MDJ2Mof0ND10zjhnMIlu0r+Di/BjhCmOP8XzRV8w1b14NmXhA86R4ggm0GGgdKyIuV8cwXFa
 yzuRg/FInu6ZTmwzfvQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-01_02,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 bulkscore=0 adultscore=0 phishscore=0
 impostorscore=0 lowpriorityscore=0 malwarescore=0 spamscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606010098

The SM8350 HDK has onboard WiFi/BT chip, WCN6851. It is an earlier
version of well-known WCN6855 WiFI/BT SoC. Describe the PMU, BT and WiFI
parts of the device.

The firmware isn't (yet) available as a part of linux-firmware, so it
was verified with the firmware files from the vendor-supplied package
(wcn prefix was applied to Bluetooth firmware files to make them follow
upstream driver changes, vendor provided hpbtfw10.tlv and hpnv10.b06).

Bluetooth: hci0: QCA Product ID   :0x00000013
Bluetooth: hci0: QCA SOC Version  :0x400c0110
Bluetooth: hci0: QCA ROM Version  :0x00000100
Bluetooth: hci0: QCA Patch Version:0x00001017
Bluetooth: hci0: QCA controller version 0x01100100
Bluetooth: hci0: QCA Downloading qca/wcnhpbtfw10.tlv
Bluetooth: hci0: QCA Downloading qca/wcnhpnv10.b06
Bluetooth: hci0: QCA setup on UART is completed
Bluetooth: hci0: HFP non-HCI data transport is supported

ath11k_pci 0000:01:00.0: BAR 0 [mem 0x60400000-0x605fffff 64bit]: assigned
ath11k_pci 0000:01:00.0: MSI vectors: 32
ath11k_pci 0000:01:00.0: wcn6855 hw1.1
mhi mhi0: Requested to power ON
mhi mhi0: Power on setup success
mhi mhi0: Wait for device to enter SBL or Mission mode
ath11k_pci 0000:01:00.0: chip_id 0x0 chip_family 0xb board_id 0x6 soc_id 0x400c0110
ath11k_pci 0000:01:00.0: fw_version 0x110c80c8 fw_build_timestamp 2021-05-25 21:43 fw_build_id WLAN.HSP.1.1.c3-00200-QCAHSPSWPL_V1_V2_SILICONZ-1
ath11k_pci 0000:01:00.0 wlp1s0: renamed from wlan0

For the reference, the driver looks for the board data for
bus=pci,vendor=17cb,device=1103,subsystem-vendor=17cb,subsystem-device=0108,qmi-chip-id=0,qmi-board-id=6,variant=QC_8350_HDK

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/sm8350-hdk.dts | 126 ++++++++++++++++++++++++++++++++
 1 file changed, 126 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sm8350-hdk.dts b/arch/arm64/boot/dts/qcom/sm8350-hdk.dts
index 4973a3eb11b5..8e35216e4272 100644
--- a/arch/arm64/boot/dts/qcom/sm8350-hdk.dts
+++ b/arch/arm64/boot/dts/qcom/sm8350-hdk.dts
@@ -115,6 +115,70 @@ lt9611_3v3: lt9611-3v3-regulator {
 		regulator-boot-on;
 		regulator-always-on;
 	};
+
+	wcn6855-pmu {
+		compatible = "qcom,wcn6851-pmu", "qcom,wcn6855-pmu";
+
+		pinctrl-0 = <&bt_en>, <&wlan_en>, <&swctrl>;
+		pinctrl-names = "default";
+
+		wlan-enable-gpios = <&tlmm 64 GPIO_ACTIVE_HIGH>;
+		bt-enable-gpios = <&tlmm 65 GPIO_ACTIVE_HIGH>;
+		swctrl-gpios = <&tlmm 153 GPIO_ACTIVE_HIGH>;
+
+		vddio-supply = <&vreg_s10b_1p8>;
+		vddaon-supply = <&vreg_s11b_0p95>;
+		vddpmu-supply = <&vreg_s11b_0p95>;
+		vddpmumx-supply = <&vreg_s2e_0p85>;
+		vddpmucx-supply = <&vreg_s11b_0p95>;
+		vddrfa0p95-supply = <&vreg_s11b_0p95>;
+		vddrfa1p3-supply = <&vreg_s12b_1p25>;
+		vddrfa1p9-supply = <&vreg_s1c_1p86>;
+		vddpcie1p3-supply = <&vreg_s12b_1p25>;
+		vddpcie1p9-supply = <&vreg_s1c_1p86>;
+
+		regulators {
+			vreg_pmu_rfa_cmn_0p8: ldo0 {
+				regulator-name = "vreg_pmu_rfa_cmn_0p8";
+			};
+
+			vreg_pmu_aon_0p8: ldo1 {
+				regulator-name = "vreg_pmu_aon_0p8";
+			};
+
+			vreg_pmu_wlcx_0p8: ldo2 {
+				regulator-name = "vreg_pmu_wlcx_0p8";
+			};
+
+			vreg_pmu_wlmx_0p8: ldo3 {
+				regulator-name = "vreg_pmu_wlmx_0p8";
+			};
+
+			vreg_pmu_btcmx_0p8: ldo4 {
+				regulator-name = "vreg_pmu_btcmx_0p8";
+			};
+
+			vreg_pmu_pcie_1p8: ldo5 {
+				regulator-name = "vreg_pmu_pcie_1p8";
+			};
+
+			vreg_pmu_pcie_0p9: ldo6 {
+				regulator-name = "vreg_pmu_pcie_0p9";
+			};
+
+			vreg_pmu_rfa_0p8: ldo7 {
+				regulator-name = "vreg_pmu_rfa_0p8";
+			};
+
+			vreg_pmu_rfa_1p2: ldo8 {
+				regulator-name = "vreg_pmu_rfa_1p2";
+			};
+
+			vreg_pmu_rfa_1p7: ldo9 {
+				regulator-name = "vreg_pmu_rfa_1p7";
+			};
+		};
+	};
 };
 
 &adsp {
@@ -373,6 +437,13 @@ vreg_l7e_2p8: ldo7 {
 			regulator-name = "vreg_l7e_2p8";
 			regulator-min-microvolt = <2800000>;
 			regulator-max-microvolt = <2800000>;
+
+			/*
+			 * This is used by the RF front-end for which there is
+			 * no way to represent it in DT (yet?).
+			 */
+			regulator-boot-on;
+			regulator-always-on;
 		};
 	};
 };
@@ -499,6 +570,23 @@ &pcie0 {
 &pcie0_port0 {
 	reset-gpios = <&tlmm 94 GPIO_ACTIVE_LOW>;
 	wake-gpios = <&tlmm 96 GPIO_ACTIVE_HIGH>;
+
+	wifi@0 {
+		compatible = "pci17cb,1103";
+		reg = <0x10000 0x0 0x0 0x0 0x0>;
+
+		vddrfacmn-supply = <&vreg_pmu_rfa_cmn_0p8>;
+		vddaon-supply = <&vreg_pmu_aon_0p8>;
+		vddwlcx-supply = <&vreg_pmu_wlcx_0p8>;
+		vddwlmx-supply = <&vreg_pmu_wlmx_0p8>;
+		vddpcie1p8-supply = <&vreg_pmu_pcie_1p8>;
+		vddpcie0p9-supply = <&vreg_pmu_pcie_0p9>;
+		vddrfa0p8-supply = <&vreg_pmu_rfa_0p8>;
+		vddrfa1p2-supply = <&vreg_pmu_rfa_1p2>;
+		vddrfa1p8-supply = <&vreg_pmu_rfa_1p7>;
+
+		qcom,calibration-variant = "QC_8350_HDK";
+	};
 };
 
 &pcie0_phy {
@@ -763,6 +851,20 @@ &tlmm {
 		"HST_WLAN_UART_TX",
 		"HST_WLAN_UART_RX";
 
+	wlan_en: wlan-en-state {
+		pins = "gpio64";
+		function = "gpio";
+		drive-strength = <16>;
+		bias-disable;
+	};
+
+	bt_en: bt-en-state {
+		pins = "gpio65";
+		function = "gpio";
+		drive-strength = <16>;
+		bias-disable;
+	};
+
 	pcie0_default_state: pcie0-default-state {
 		perst-pins {
 			pins = "gpio94";
@@ -815,12 +917,36 @@ sdc2_card_det_n: sd-card-det-n-state {
 		drive-strength = <2>;
 		bias-pull-up;
 	};
+
+	swctrl: swctrl-state {
+		pins = "gpio153";
+		function = "gpio";
+		drive-strength = <16>;
+		bias-disable;
+	};
 };
 
 &uart2 {
 	status = "okay";
 };
 
+&uart18 {
+	status = "okay";
+
+	bluetooth {
+		compatible = "qcom,wcn6851-bt", "qcom,wcn6855-bt";
+
+		vddrfacmn-supply = <&vreg_pmu_rfa_cmn_0p8>;
+		vddaon-supply = <&vreg_pmu_aon_0p8>;
+		vddwlcx-supply = <&vreg_pmu_wlcx_0p8>;
+		vddwlmx-supply = <&vreg_pmu_wlmx_0p8>;
+		vddbtcmx-supply = <&vreg_pmu_btcmx_0p8>;
+		vddrfa0p8-supply = <&vreg_pmu_rfa_0p8>;
+		vddrfa1p2-supply = <&vreg_pmu_rfa_1p2>;
+		vddrfa1p7-supply = <&vreg_pmu_rfa_1p7>;
+	};
+};
+
 &ufs_mem_hc {
 	status = "okay";
 

-- 
2.47.3

