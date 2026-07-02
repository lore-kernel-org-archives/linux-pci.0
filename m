Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3B043A5E6F
	for <linux-pci@vger.kernel.org>; Thu,  2 Jul 2026 10:46:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782989194; cv=none; b=O33OiF+oeqy7BVDKbhwbyoJFuKIunbBXh+WiI51S6FIl+WL41YDBANtYx75rqHrJs6tAtTqrVfCBs6ruYpvj0VgJtaDAS9TsCDKM86fgZTjPyKQlRqLQcXyiW0U66Ko5d5ftc2XHY8AtHW5PzGS6+4d62cV74nQFbf0X8dwkSWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782989194; c=relaxed/simple;
	bh=UuWiowSUkkLYBCFI2j5RmkjjfgRaPpYyPxsZlfvVpgQ=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=IvA0zj5RvXsP+dvZQve/K5uXF14W5sAt8ah28kQTs749vN5HEiT5WfROrJQvQm9G+WlRRL/hP0sFixRF95r0wIUaXQYHzvg/z0ayOZJPlxJnTHaYeyBPDZWysS2lumnotsXOQoRbl8f+ZFSNs/uA9slPc0UyJZWjPr0NhZTsLMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Qq56hS4g; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=EC9SQdI0; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Qq56hS4g";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="EC9SQdI0"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6629L8pZ4117610
	for <linux-pci@vger.kernel.org>; Thu, 2 Jul 2026 10:46:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=g3M8BKOQRB2G3U+jibgwRX
	tDt1cwkny9K4uSgSksDB8=; b=Qq56hS4gcggr6zWHP6OM19FMeMio98SPi+lUN3
	0H49UC4ZqoEwmDCGrNX/k9QoK3v4i3XhfJzTDwRVMU+BuYbDx8jHrchwuvxb6Spz
	5VUV8NA9IfrEJPSXgGnJ/fGviu8Ikc3xCbmO++G59wtZuuZpBM6Ab2BaWI8hELWh
	Q4UdntbVTg/3lM8WQ0tl4TnmOk68MQzlphGF89Q0GZD7nrXTaNiQTJp3OZSC8KUy
	ubrjCeoT1cPftRfxz7WhZk63woHcudBOjNEQbfnQi7XGvEKPPmcTSF9VIMW4eM+p
	VOOhYQKR8c6hPX8wyUlG7tUCOBnGgszIGkKWvLJ+koXKxxlw==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f5n9bgag4-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Thu, 02 Jul 2026 10:46:31 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-92e663c29f2so54654985a.0
        for <linux-pci@vger.kernel.org>; Thu, 02 Jul 2026 03:46:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1782989190; x=1783593990; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=g3M8BKOQRB2G3U+jibgwRXtDt1cwkny9K4uSgSksDB8=;
        b=EC9SQdI0cJA4R499RhF5eAxf5qlZ/lVlXvlIPrPgdzIsJGHJyfyFAj4hIryANDAmRp
         FclBZj5ucVZ0hy0+BAc+RNn9geUAfE4gCyyH2klPOtT4pMonhEiikAYxHNcJf8tBGAUn
         w6ZuDBJRQY+HtoFo1BNsAU5K9yadlsqctJlAvW2GdAuoG/9PKZX4pRD8rtd8f/CvxDEV
         x/bMYFYntxWcYtJ9fwcbFP+MmGbYc+E+Cg1xOUF6vOH9RLub1nagXT1PWIv40akbJiA5
         aAIIX6CEYek8xd8eYhK6lAUkOEy1KOc5ND8gs5aXyxMGV9OvLn2zBkwkze3WLvn0OBtY
         nNNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782989190; x=1783593990;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g3M8BKOQRB2G3U+jibgwRXtDt1cwkny9K4uSgSksDB8=;
        b=hkij9OGU2AYE4FM2s5oaDBKAHi3axRzSwVyBlA03mrg15r/uISZ3ITMpnffwIAdJTV
         1w/yS3268eIZzAhnwSMloAR6v28N6y9/p5bGNKK/3vUA38IEvUgcO9QL4jG50X1o4iFC
         sREZYhQLwJbarYUUMDWeT9GtyN2ulOcQEbKQ7sTmMJfpPoeNEkTJ3pLQpvHJ0mRdmcQ3
         5YulMumRtsU2K7DWv7H0LFnT7O87gwDg02hcP+BsxXyrReONLQFcHFOxPGxNT2V0RBvK
         WLxgnLf9l1fJUXyj1v8dE2sE2pl+6qoPrMjTeDFwVzscqZbLPa9DFQj4LLejrCNHWvdq
         FdtQ==
X-Gm-Message-State: AOJu0YwP/V2HZeI+JMtaopqwN7Q74VBCztJkc5VqVRrAgcIx8B+RJLP+
	NbfC5pyib+Tbu08DZr1Z3ZqlwhRWYtwQAtLm9/YW4DbDxWzAKZHdPFGKNPtTCXm86RtCEL9DZbu
	culUJTcPI4Aq+Xdiu2TrLfrcbneQmPwqfJTTi3trH6C2IK5H5Iba6oV+OQE1x+MvYA3c/3MNMaJ
	DL
X-Gm-Gg: AfdE7cnCsRGdPbMUuDG0T+Tw845TQFh6Z77ps3MvwQ0iFKqGcyIJRzV19lN6ViTWLVn
	vD7dsRrCW2nw29kcJDp7BfS+P+xacimRv/r70YdiamI1hmE7M2H++ZrWZKEnMC0dgpoWkXgsykj
	4Gv1DRBRyKOnUCKUmQVKAw5IGW512xmrrNP9gFlNXSTtpvr3qau96zKu047tEQH6SrrEJmSLy5X
	P4MOBKF+JP4T/PS4pY9u8GXtH6o5BbydxsogWgUPBT52r9g1jaCyv8GzNIwtjjKza702Xd74Wy9
	IY5tiR63vheEnuRd8ht+ohgzf0GhPKj/SNxDTyMq/vSChm/zFVsUn9bHcYmjcXQjTt4i85Vt9eW
	pXX/keoI/u9gGLdrpDakoF/WehB1KrI4/D8fxl1YxQMixFvvlvRG4aMIKgS/kGcP6UfcMvWxKlU
	/t6HOvZZQDIQwZXCgNoMQFm3JZj2YIBMdD/oouUjYdD/jXm32zPN8azqW0ASL9s3U=
X-Received: by 2002:a05:620a:178e:b0:92b:f1ba:5fad with SMTP id af79cd13be357-92e69821ad8mr1223563985a.37.1782989190100;
        Thu, 02 Jul 2026 03:46:30 -0700 (PDT)
X-Received: by 2002:a05:620a:178e:b0:92b:f1ba:5fad with SMTP id af79cd13be357-92e69821ad8mr1223561385a.37.1782989189650;
        Thu, 02 Jul 2026 03:46:29 -0700 (PDT)
Received: from QCOM-eG0v1AUPpu.na.qualcomm.com ([2a01:e0a:830:450:809d:5d56:19d9:ff8b])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c12b5ae4959sm109689666b.0.2026.07.02.03.46.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jul 2026 03:46:28 -0700 (PDT)
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Subject: [PATCH v2 0/4] arm64: dts: monaco-arduino-monza: Add support for
 LGA WiFi/BT module
Date: Thu, 02 Jul 2026 12:46:12 +0200
Message-Id: <20260702-monza-wireless-v2-0-7b56e2a6a6d4@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAHRBRmoC/3WP3YqDMBCFX0Vy3ZH8qKmyLH2P0otoxzbQmJqx6
 e4W332jXpbeDJwD5/uYFyMMFok12YsFjJasH1KQu4x1VzNcEOw5ZSa5rHgpOTg//Bl42oA3JAK
 sOtQ9F6pXe5ZG94C9/VmBx9OWA46PxJ22krk0Myu3yb42LNdwfwbCEZyEdoIogYPQBW/Phd6Xq
 j54onx8mFvnncvT+V5crSGEpbFTk0WdCwhdwRbr1dLkw+/6VRSr9tMDUSRX3Vd1IZXgVaneXOw
 0z/M/u6Q4vykBAAA=
X-Change-ID: 20260520-monza-wireless-e6ce7f013f38
To: Manivannan Sadhasivam <mani@kernel.org>,
        Bartosz Golaszewski <brgl@kernel.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc: linux-pci@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-bluetooth@vger.kernel.org, devicetree@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>,
        Loic Poulain <loic.poulain@oss.qualcomm.com>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Proofpoint-ORIG-GUID: ifXu3wWdsiZjNveJEsyPAUkpvc-JHVIC
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAyMDExMSBTYWx0ZWRfX2VBkGpoX5Okp
 8d8xI6spWP3Peq7usbZu1+jdB39VEAeHwR3doVbNjM6J2siaX6S4ZgZcdyoLqajDSpUSPAR4u+Q
 s9bGNDBM9QAb/LxvR+8twY2aZQ5Pz4M=
X-Proofpoint-GUID: ifXu3wWdsiZjNveJEsyPAUkpvc-JHVIC
X-Authority-Analysis: v=2.4 cv=bOom5v+Z c=1 sm=1 tr=0 ts=6a464187 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=fyB3VsXpRON8pw57WvEA:9 a=QEXdDO2ut3YA:10
 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAyMDExMSBTYWx0ZWRfXxAyota3+zcK1
 FUaXgjd0lOIVxTTgS8ufa9agGSd4tI/phQmDKq571clJ5VlTHSp/odBJP4Xo4B8NkfJjNbL2h0w
 hVFu4/sUsJ8LenwkIYFDKuzsGjRb5KA/lwZWgcThvEfhuMchRO4K1ZiZG+dJh4HGZ189bueDVbX
 iZnE4EeUs04lZtukQc6FMTGvJOfZcotGg1Y8DjNCMWuNJSO+MlS1vmhFHgQUlpZ9gaxMlbwtzo8
 KYB6n63ewrF2enbcm0AnyZseyWEIKClLSCmb6F8IfDOBH5wBfzjTaOU6udDIWmEfv9hXF5ObYJR
 D9OHmkv9B70kXIwYn52Me03lfKmgrmwM8YIezcEdNlSFNclTnAWO6FgYtc+/TMrrHlN038oKYeN
 i4snL31IBxlaBABAdMvUQGoXYd+UI55o34sa6S5CBTmhA0FxO7R2cirfaDJmSYPrJYahNdO/JUy
 qi1RSon7c6Yc5wGFeDw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-02_01,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 bulkscore=0 adultscore=0 clxscore=1015 suspectscore=0
 phishscore=0 priorityscore=1501 impostorscore=0 malwarescore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607020111

This series describes support for the onboard WiFi/Bluetooth module
present on the Arduino VENTUNO Q (monaco) platform.

The board provides LGA pads for a wireless module. On the VENTUNO Q
these pads are populated with an NFA725B module featuring the
QCA2066 WiFi/BT combo chip. While implemented as an LGA footprint,
the design is functionally compatible with the M.2 Key E.

The NFA725B exposes WiFi over PCIe and Bluetooth over a UART.
Both interfaces are gated through the W_DISABLE1# and W_DISABLE2#
signals, as defined by the M.2 specification and handled here via
the pcie-m2 power sequencer.

This series models the hardware using the existing pwrseq framework
and connector bindings, allowing coordinated PCIe and UART bring-up.

This series depends on:
https://lore.kernel.org/linux-pci/20260507-pwrseq-m2-bt-v2-0-1740bd478539@oss.qualcomm.com

Signed-off-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
---
Changes in v2:
- hci_qca: extract M.2 pwrseq into qca_serdev_get_m2_pwrseq() helper, called
  outside the SoC switch; drop duplicated of_graph logic and redundant
  bt_power NULL checks (Dmitry/Mani)
- dts/bindings: use qcom,pcie-m2-1418-lga-connector (fallback
  pcie-m2-e-connector) instead of the generic M.2 E-key compatible (Mani)
- Link to v1: https://lore.kernel.org/r/20260520-monza-wireless-v1-0-9f6942310653@oss.qualcomm.com

---
Loic Poulain (4):
      dt-bindings: connector: pcie-m2-e: Add vendor LGA connector compatible
      power: sequencing: pcie-m2: Add QCA2066 (QCNFA765) BT serdev ID
      Bluetooth: hci_qca: Support QCA2066 on M.2 connector via pwrseq
      arm64: dts: qcom: monaco-arduino-monza: Add QCA2066 M.2 WiFi/BT support

 .../bindings/connector/pcie-m2-e-connector.yaml    |  7 +-
 arch/arm64/boot/dts/qcom/monaco-arduino-monza.dts  | 64 +++++++++++++++--
 drivers/bluetooth/hci_qca.c                        | 81 ++++++++++++----------
 drivers/power/sequencing/pwrseq-pcie-m2.c          |  2 +
 4 files changed, 111 insertions(+), 43 deletions(-)
---
base-commit: aa61612ab641d7d62b0b6889f2c7c9251489f6e3
change-id: 20260520-monza-wireless-e6ce7f013f38
prerequisite-message-id: <20260507-pwrseq-m2-bt-v2-0-1740bd478539@oss.qualcomm.com>
prerequisite-patch-id: f4a7d1957c1776051608bf3d808b2786606c1ae2
prerequisite-patch-id: 6cd3c33583a9af16b3f6f71517b16b32d8155b7c
prerequisite-patch-id: 0550c57d69cf112fd4830e62f4388db6f8bf397c
prerequisite-patch-id: cc10d8079e37ef0ba0c33d0984c95d76361df9dd
prerequisite-patch-id: d7f4bb2bb4498ac619e67a94f8b59119a5caaf26
prerequisite-patch-id: c00ce9095b2d3a412229796194828b55642d3d96
prerequisite-patch-id: 09600595c2e80b12eda3aae39af192847d0f03d0
prerequisite-patch-id: a6118ed2894c176780ba933750e1068f2819fa4c
prerequisite-patch-id: 1dee41a33e032094e8dda74ac4e0bada928573d7

Best regards,
-- 
Loic Poulain <loic.poulain@oss.qualcomm.com>

