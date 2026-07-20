Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E67135959
	for <linux-pci@vger.kernel.org>; Mon, 20 Jul 2026 08:04:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784534650; cv=none; b=NelXCrUhFhBEKis0bT9uO7qAUR5wT6eQa8u2lTEkdJMl9OtxEHVSez4vENxceLYa62VGIOY0ae7pqk8/ZXx+AontE7akh9V6/X8xOT5ELnUSP2w6FdVKeuDf6/QAQbfMo6OLnph921rJT9UcIOwTvN3sZf/2lZiBkeAXFsyaIfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784534650; c=relaxed/simple;
	bh=NyGshDhSOP+FyPP+/FRsPhde+Zq9ypyg6v8tkKJh1Vk=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=cIbXo9umkUSn7Te78qK18WSPIt9PHwzBxyFPpaVAo7Ql9+VXfCfQPeE8wBcHU70b0q0C0FrRjciEETbAE7VJBCdxzrivmRu+GPDKWwM23BefBvo1aukh4tohqs9L3j1zBXP8FlTi3C5MwVuoIgd+S8CPJ4xOcmw+U75AeGCthcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=PP6//9/k; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=OURost/Q; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="PP6//9/k";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="OURost/Q"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66K7YDqw2043790
	for <linux-pci@vger.kernel.org>; Mon, 20 Jul 2026 08:04:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=mA/9eF9I1JPrPUibkb1flc
	XndUSGk/eBS96ssn1qFCo=; b=PP6//9/kI6cT01dIj50VzrvAZATxOD3cDU86nE
	FT+T9FX7qlENm2qVWy9BPXH5JFrwaRWc5wHlJVhs+5n4APnwOHBmKkwTTDtDwuLr
	DPNrddGPPQfzU5wOIJFUDLFzjbrlcqFb/AufCURzoSVdqr17lE8vVpyWgM6cWghb
	CH9PKcbOPUqNsOVkPlFm3pEREEPnE4R1svOEiN+uFBVqVxDIpYhwfAqCiaQcVl1b
	EJzSpn+x8t7EykXjE0l67l7WwM00NG1xDdlGWMwXucsCsbddJe7dm7N8AqCiv61L
	x8aAgw4CPMsH95vBShnNrR8gUc1aniCon33Wxh4BjkKaV5tg==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fhfdcg399-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Mon, 20 Jul 2026 08:04:08 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-51a8c689b5fso189250521cf.0
        for <linux-pci@vger.kernel.org>; Mon, 20 Jul 2026 01:04:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1784534648; x=1785139448; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=mA/9eF9I1JPrPUibkb1flcXndUSGk/eBS96ssn1qFCo=;
        b=OURost/QVfHsaVQfDxqyC7qX27m0DRsBA3OOR5bperu7Mxi2s+R0ay2jr20W0/Oihs
         adYc5l7s8nA9rGcXgqTCh8kFT/AmsYCWvqIBfhH0UOBjyd5/kfQrE/0WTxQ4Dapbs5H3
         kqz+NyV+cd5Li6g6k4KIo8zctCNN9djuFqsrmjimYSwbij5Lyqex7OUZ9B+cX/AALGjt
         OQb8bRVjjl6qCHPgb40WTpfz55mqp0s/DXRmQ7qxQ4sRPKro6Bmoe/pnU09C6u90BbQY
         guWWIkKfRyvCLiZG/924lMO7ceiHmquV2cBQpNWcI6m+uvlyckX3eUHOTx4anOuuTilo
         5Jyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784534648; x=1785139448;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=mA/9eF9I1JPrPUibkb1flcXndUSGk/eBS96ssn1qFCo=;
        b=DrHEqYD19tVZbAs/Ma4gOzMHBckJ7c3WI6mokvWigNFj31+H2S9DvHKblpTBvPwv3r
         EUrbMQZJ+Kfw4x/U+Hu2/pimTK4i5NacSdgRqevb6KWYERylGbhAqV1GMhxoRknHNqyy
         /DDg+XSASVZfjFWdQlB6NegfhHbu74So/FYRkwL4+eGwRrdJazoI0ESvR4Cg2r/kutwO
         aJDn1EGUhYYFzI7q604iTnuWGPGxVov+8umInwt9XsncU9RK06gsL94fVkywmlklP93e
         is8juuMBo/b6e502rKJpQ6itbij4zyiSRCZHkL6NEkaqieNrs/43UpGa5wkzRYDyrAvm
         m41w==
X-Gm-Message-State: AOJu0YxFcmyrHkLPSK7yG/9kwVlzUs/nTWSfqpMPNe2rOBgJGoFd43uF
	C2KB8d6DDDb93ljSSwFmdWplNiRO8Umm9AW/ZnLnn/Rpqxwa8X76KcS0C9ArMp1oAZcOkxx2UFL
	lpOLkD9IroOFs15ljDVBSHCpwHCIDHYwaMamze0YB8XtDj3J4zNkxXkr3UuTt5fw=
X-Gm-Gg: AfdE7cnyycm/57umIUeC0NQpWsg99hkoi6Tr4NJE+6t0EMNezAgZwSZ5cMahRboOHED
	wFEmYmZ6vNPdmjLYsdfwalwsEplSU4b2LWc813UAh5KYZ0mha/TpU28di2J3+gTJKAnITEjtsvJ
	rPcw5kShQETZwioZltC6SR6a+j4mKuAyRleo4yVvc9ibzI49LkUwwvywZgh8yvRwxDbtGkJNfVZ
	vcWMAJGqeDv1uolL7EjHLj/y3pM6WBqqp9gsXGG7Dby2ONYs+Ra5wmBT/1yAMGGNXEZg0xtXd9o
	3ly7R7jm6MIpI7FkIYh4eX8KH4GgULXkQgt4hHkprrVjq0XOJliFtwFYRDvDLBa7nrT9Ks3Re3x
	5YyaHEmlWuEC2P3cHYDFbkm+y8M1xA4RrLaYD3ZusuxOvaIImStaqMBy9ExGdVf/mKmgEFvxE4o
	9dibakuJIH6I2gdl6usJIvYFedgOz1/S2Ac+dQtrfEyOUoNcSB8Tg=
X-Received: by 2002:a05:622a:909:b0:51c:99b:d668 with SMTP id d75a77b69052e-5213e28f16dmr127865521cf.49.1784534647404;
        Mon, 20 Jul 2026 01:04:07 -0700 (PDT)
X-Received: by 2002:a05:622a:909:b0:51c:99b:d668 with SMTP id d75a77b69052e-5213e28f16dmr127865231cf.49.1784534646993;
        Mon, 20 Jul 2026 01:04:06 -0700 (PDT)
Received: from QCOM-eG0v1AUPpu.na.qualcomm.com ([2a01:e0a:830:450:751c:d61c:c91:60dd])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-69e7000c3e2sm4256542a12.30.2026.07.20.01.04.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jul 2026 01:04:06 -0700 (PDT)
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Subject: [PATCH v5 00/11] arm64: dts: monaco-arduino-monza: Add support for
 LGA WiFi/BT module
Date: Mon, 20 Jul 2026 10:04:02 +0200
Message-Id: <20260720-monza-wireless-v5-0-69ec6743543c@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAHLWXWoC/3XPzW6DMAwH8FdBOS8o3wFUTXuPaYcAzhqpQElou
 q3i3RfgsEqMiyVb8u9vP1AA7yCgKnsgD9EFN/SpkS8Zas6m/wTs2tQjRpgikhHcDf2PwXfn4QI
 hYFANaEsot7xAaenqwbqvFXz/2HoP4y250zZEXVozq1tlp40lGl/vPsCIO4brCUeGCaZakLoVu
 pC8fBtCyMebuTRD1+WpvC5ZtQmAl4mbqizqnGLfCLSknl2YBv+9fhXpGnv0QKQpq7SqFIxToiT
 fZa1iZH+KJmynLBfrWipgRhnVigOFPyl0fwtPilBMclloY9WRIp4VtVPE8lFNGCgrRdnqf5R5n
 n8BN5mLr/sBAAA=
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
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Wei Deng <wei.deng@oss.qualcomm.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Proofpoint-ORIG-GUID: kq72n2BZEr0fbIurGK1rZmDzkPLJ-xOx
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIwMDA4OCBTYWx0ZWRfX3lMrYaFKTdnC
 vmJkX7STPyhZR0H9vnTglzXuIyGaOAXEeeeV6goM7rsRbxPyp8kmkxEZwiW4V0t+PHr8QnzFbcY
 Bi/tH6ejZ7/uD7OOTr41YtvMz85R4UY8G7eioaNZmBJLh2NuIhmpR5nDdzHBOVRtiO624AXFeUk
 kW0U8ezuFoNrH9ByEhuLvMhZJNr39YuGfzp7VfVn7jg63k+iOydWp1aEna2dljoqdGyI8OWoVAO
 dSzYjkG6I9tStmNal3biTAGB9XXgg+nnwYNPwpgkqviOg9rAiqyLL/g9La+Yh0jejUf3D4Xque3
 hbh7pP6C5ZfM80+E5dAVgTU3ACuZirtOzs2Q9Fq9W2C8q9oEUXy0uP/cuNmrdLS0T1Qfe1P5sfv
 DT0BPZL59UrGYih6BrghyLNviGd0mrn/uToKBGbefo8ymUuGf/ypr1RHBe4sr6LUaM4e+2AROvB
 V8IUOtCiALaC2G/pQeg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIwMDA4OCBTYWx0ZWRfXxkDBUsXaK53G
 yarPzyGA+H9gBuUsTcjQlq1h1ofwI+5vk/8VrooIaFqTyCxbGcgwpHIrvV43e7qlICiaTTRiHnx
 imnKB3hbJ1AORkgH6z8j8OiSVcrWccI=
X-Proofpoint-GUID: kq72n2BZEr0fbIurGK1rZmDzkPLJ-xOx
X-Authority-Analysis: v=2.4 cv=bv58wkai c=1 sm=1 tr=0 ts=6a5dd678 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=ojWIPoK9sOC7OVCjIIkA:9 a=QEXdDO2ut3YA:10
 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-20_01,2026-07-17_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 bulkscore=0 priorityscore=1501 spamscore=0 malwarescore=0
 phishscore=0 lowpriorityscore=0 clxscore=1015 suspectscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607200088

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

Signed-off-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
---
Changes in v5:
- hci_qca: comment why the M.2 'uart' pwrseq lifetime is bound to the serdev
  consumer device instead of using devm_pwrseq_get() on the controller (Bartosz).
- hci_qca: note that dropping the always-on pwrseq handle is not a leak since
  the descriptor is still released by devres (Bartosz).
- Link to v4: https://lore.kernel.org/r/20260716-monza-wireless-v4-0-9b02e6f549d7@oss.qualcomm.com

Changes in v4:
- pwrseq: rename pwrseq_power_is_controllable() to pwrseq_is_controllable() (Bartosz).
- pwrseq: move the is_controllable() callback from the unit to the target (Bartosz).
- pwrseq: add might_sleep() and guard pwrseq_is_controllable() against
  concurrent provider removal with rw_lock, matching pwrseq_power_on/off() (Bartosz).
- pwrseq: clarify the pwrseq_is_controllable() doc (Bartosz)
- hci_qca: lifetime follows the Bluetooth device rather than the UART controller (ChenYu).
- dt-bindings: also add the "qcom,pcie-m2-1620-lga-connector" compatible (Mani).
- arm64: dts: monaco-arduino-monza: rename the 'pcie_bridge_ep' endpoint to 'pcie_ep' (Mani).
- pwrseq: reword commmit message (Mani)
- Link to v3: https://lore.kernel.org/r/20260710-monza-wireless-v3-0-46253587af64@oss.qualcomm.com

Changes in v3:
- Embed bt_power in struct qca_serdev instead of allocating it (Dmitry).
- Add generic pwrseq_is_controllable() API + per-target .is_controllable()
  callback; use it in hci_qca instead of peeking at the W_DISABLE2# property.
- Implement .is_controllable() in the pcie-m2 and qcom-wcn providers.
- Treat non-controllable BT power as always-on.
- Integrate the pending Bluetooth pwrseq patches from Mani.
- Link to v2: https://lore.kernel.org/r/20260702-monza-wireless-v2-0-7b56e2a6a6d4@oss.qualcomm.com

Changes in v2:
- hci_qca: extract M.2 pwrseq into qca_serdev_get_m2_pwrseq() helper, called
  outside the SoC switch; drop duplicated of_graph logic and redundant
  bt_power NULL checks (Dmitry/Mani)
- dts/bindings: use qcom,pcie-m2-1418-lga-connector (fallback
  pcie-m2-e-connector) instead of the generic M.2 E-key compatible (Mani)
- Link to v1: https://lore.kernel.org/r/20260520-monza-wireless-v1-0-9f6942310653@oss.qualcomm.com

---
Loic Poulain (9):
      power: sequencing: Add pwrseq_is_controllable() API
      power: sequencing: pcie-m2: Report power controllability
      power: sequencing: qcom-wcn: Report power controllability
      Bluetooth: hci_qca: Set 'bt_en_available' based on pwrseq power controllability
      Bluetooth: hci_qca: Embed bt_power in struct qca_serdev
      Bluetooth: hci_qca: Support QCA2066 on M.2 connector via pwrseq
      dt-bindings: connector: pcie-m2-e: Add vendor LGA connector compatible
      power: sequencing: pcie-m2: Add QCA2066 (QCNFA765) BT serdev ID
      arm64: dts: qcom: monaco-arduino-monza: Add QCA2066 M.2 WiFi/BT support

Manivannan Sadhasivam (2):
      Bluetooth: hci_qca: Add M.2 Bluetooth device support using pwrseq
      Bluetooth: hci_qca: Rename 'power_ctrl_enabled' to 'bt_en_available'

 .../bindings/connector/pcie-m2-e-connector.yaml    |   8 +-
 arch/arm64/boot/dts/qcom/monaco-arduino-monza.dts  |  64 ++++++++++-
 drivers/bluetooth/hci_qca.c                        | 117 +++++++++++++--------
 drivers/power/sequencing/core.c                    |  49 +++++++++
 drivers/power/sequencing/pwrseq-pcie-m2.c          |  28 +++++
 drivers/power/sequencing/pwrseq-qcom-wcn.c         |  30 ++++++
 include/linux/pwrseq/consumer.h                    |   7 ++
 include/linux/pwrseq/provider.h                    |   8 ++
 8 files changed, 264 insertions(+), 47 deletions(-)
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

