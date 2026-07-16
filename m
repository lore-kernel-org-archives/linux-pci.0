Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A087376BCC
	for <linux-pci@vger.kernel.org>; Thu, 16 Jul 2026 16:18:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784218712; cv=none; b=LGcFsOGEe1nU097u9QNWqrilGvpAZRYF811mUYQKgPNspmf6f4Gx+17d+9X+u2m6AsVwYfDCb873JW5oIgHcWWdC0mFx++7Mly7CH84D/i9VBW5KVwvyZagj5FZ89wkaxNORcqY40WBDQiLUP6eKn4tuBliVcaa3y/fH8APkpeQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784218712; c=relaxed/simple;
	bh=nKSSqjQ1RPL6DEUk3dkrg5ebC3G5l0uX2VfsivKoSfA=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=Cj+UT5ObX3ECnYa8mpoSpIpWJlaSLh40/O2PhvyWMFhbFY5HOK7C6ElG3w2X2ghvSa0A3LwWYREZDfwh4eMNzEvZMl9qRYWDvheqzxyOiYvRGnue6O872i95g9Y3Qxp2vewOZkT87O/saCF0d97VU16WIQjqbyKWlIqjJmNn/zo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Mr/JX0pO; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=U1BgV/To; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Mr/JX0pO";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="U1BgV/To"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66GDJoll2734544
	for <linux-pci@vger.kernel.org>; Thu, 16 Jul 2026 16:18:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=l3Ygeb3T66TwieiyLUkouf
	a4XGR3kt1gi5YfLRJXmvE=; b=Mr/JX0pOSyNWskzx5zHQWkbKcRvgC/mW2OvT/E
	GrvSkgr6jxfuDZ0FML/6xswv0sVWSA3vBUHd0I5lQFUQQuZurN2+SR900RR/2yRb
	Xzdludk9IB8X2rpTYbZa77YHURgHnsWNZMeDzNt7+g0t7vU8mUf2DoNfT3HgSLTE
	6ezdx+1WlAXusxoS904Mcp/jV7b20ETAlxv1Vy5fDSXD1ep5xLpgZ1U9L0M9mvu4
	lqlGWQ8HQ8vPlm0t+u2YuVofu2UEkqcIrw0ERb65cIiwt4kBRYVdDfzxB5fzh+0Y
	yGG843xI8S27S4njYHdLWh+6PqLYD/dY3Lsf2Grsh9RVvEEg==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fevkv1uf3-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Thu, 16 Jul 2026 16:18:27 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-51bff5c7035so151028321cf.2
        for <linux-pci@vger.kernel.org>; Thu, 16 Jul 2026 09:18:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1784218704; x=1784823504; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=l3Ygeb3T66TwieiyLUkoufa4XGR3kt1gi5YfLRJXmvE=;
        b=U1BgV/TosqV4bimblwfzy8SyhiIWxcj5GZV0rMzkPG+Y8H7IGMrb8J2h42M6I8lss/
         PIbVeL+aDgOwld7KH8rcD5KknUFnl5mQaMFnI6ZVOTIOiFb/LQdIKJz7aPxqG9IDOpeW
         QvK2KwiPnJpSAZ2L2TacRffGw6JyDAxpZ3qEdl1xDkVDRBhy8P69BKoi/WuwPTunljn+
         T+9Cewp34/phd/mZxJ6OIVYvCHFmsrqUeAgW0ThSNTdkHDsjtyNOXgHffwgaqGCEeuL8
         LUmmtQAqAcTxfbEIVUeSjNI+FDpTlpsybWNaPOg8DBF3rh6qLZBYiccvEYT52hWl8tSi
         z2XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784218704; x=1784823504;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=l3Ygeb3T66TwieiyLUkoufa4XGR3kt1gi5YfLRJXmvE=;
        b=BR26+jJE+kom67sQGprwiRgP11Nny+Q2COBkDn/JmeZOhtUtPZ9OF3HZkQMRW8+Xo7
         e5K62gnoln5vW7iDdYNdVBBMEb+04o8wIddSAjHr+AqXo67rNjsc7B+kkqyyiDgPkcoD
         p0t/hEyEc9eKaANQsCin30wcqgSNNl6+uvBwCO4N2CMN2yFugQZQQndX5oCdyBMBz+xl
         RKCNZzInP6EYKG/3z9GOBfFy97QQTPhfwxGMe953gPYSV4rqOer3OvjzVvgXCTDzDSBO
         3VGulbcIP4TigNBgVdtJIA2l3iOf5Mn0xCv4gwwHwT0y2l8EtQ9GqflEP3C11RyTFoMi
         KXyw==
X-Gm-Message-State: AOJu0YzRlkfdOJXDf+WzqBPwlXpHvn4SXxmREZf3aCpS4ZEWKmQsbq5d
	jZa5in8LPUnHlO31QgPQeXVyIZTjKYRghHTJF+tm5TvJrLFB7mfZAtxYPSlNtNGz35tE/aehVg0
	hy7TbOdPVTmUAGFB/pQlll4VxN5RsCE140rsnqSFelNMyvQIrvxAGZqGKQ5WqodE=
X-Gm-Gg: AfdE7cn0WSRVDjmwSYWRUOLEj+0DJwWmOjtZu3phl+H8lUjYX9NVAUa86vM4ONT3bl/
	sj7yoLmHDa8jJyDzGuphldwmHHjskjs+AzMPDqgjtCSSoOHfBHIxyjerTBzLdVjrGJDNonpMf3a
	qVZowC2Ou4eKiy4J1MuYBq3BzI/6iek/OCcgRcgcPyPQlVKDdAkZYz18bkhPWxgICOlcWkOmLB5
	f0xLB4+zFtrCKVWWkatGSc8Hk9mmJdWfshFd1CZtxBPgleetwQiBHIE38zC9E0EWYBVoDGFIrtC
	rH9rwTUj12Jr2HqnZgbtymd5L7r28XmWrBPXOnIGB9Hpv8LsbLgF9s9y9YSTy86gQV54VkeAVwk
	oVBjXcrxShxanYve9sKx/GZVj+af/ql/iq+WQSNMoT0EXxZ6Z1r0edISGYKlIFDcI+Ns+fdb0AD
	4zrEMhbtLOA9V/oFZT6+EJaqyR9+tR+edF9nwwPx1YEl5c9nC5jXo=
X-Received: by 2002:a05:622a:1903:b0:517:9095:c31b with SMTP id d75a77b69052e-51e4f0a2380mr86436571cf.42.1784218703378;
        Thu, 16 Jul 2026 09:18:23 -0700 (PDT)
X-Received: by 2002:a05:622a:1903:b0:517:9095:c31b with SMTP id d75a77b69052e-51e4f0a2380mr86436211cf.42.1784218702934;
        Thu, 16 Jul 2026 09:18:22 -0700 (PDT)
Received: from QCOM-eG0v1AUPpu.na.qualcomm.com ([2a01:e0a:830:450:751c:d61c:c91:60dd])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c168744bdddsm257262866b.48.2026.07.16.09.18.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jul 2026 09:18:22 -0700 (PDT)
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Subject: [PATCH v4 00/11] arm64: dts: monaco-arduino-monza: Add support for
 LGA WiFi/BT module
Date: Thu, 16 Jul 2026 18:18:17 +0200
Message-Id: <20260716-monza-wireless-v4-0-9b02e6f549d7@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAEkEWWoC/3XPzW6DMAwH8FdBOc8o3wE0TXuPaYcAZo1UoCQ03
 Vbx7gtw2CTWiyVb8u9v30lA7zCQKrsTj9EFNw6pkU8ZaU52+EBwbeoJp1xTxSn04/Bt4eY8njE
 EQN2g6SgTnShIWrp47NznBr69773H6ZrceR+SPq3Zza2y552lBi43H3CCnkM9Q+RAgRlJ61aaQ
 onydQwhn6723Ix9n6fysmbVNiCsEzdXWTQ5A99IsqaeXJhH/7V9FdkW++iByFJW2elScsGoVuK
 QtYmR/yqG8oOyXmxqpZFbbXUrHyjij8KOt4ikSM2VUIWxnf5PWZblB9aykxm1AQAA
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE2MDE2NiBTYWx0ZWRfX3Y5ghmlJnJNC
 qLXdjUzspf40YCxF5FUDyMfqladnovqdKUUgQEUyROXkZrEKVQYWqjriXDNHKmidK5gpEJQ4GEm
 TrOVeoKfxowjkvzFObX5GORRzD05QtvO17yxsm0eiJ9u+yHbKbcwG2gjJps0yHLPEMlqwqqRM+v
 jMrNervgeShwGLs/6xcP2iRpe+qQ2Xtg4QwENN73+ArXD31RlQ5INT/5gqv19TkfxmGKYNiwSq/
 1XDefWDshcxvno5pJJzkm07s5p29WGcxZ34+8NTM8UhMSMtCQG8YjmPA352bEBbjtxFFUzdLD8f
 PepDAHo4ykPpiTQH0IqP9SYjlYqthZ0QAIB4BpBGqCGx8lBk9st1WPizhMx6wK94MxQqTDz8WEO
 o+V+YuOyLbLZ8xlryUl7uw0Gk1eUrJOLSFM4oFNdC5GI2wqK2RP6u7ImOVy8+CwS/0+1D42V28W
 l4DBCIpO8R8C1YhmRVw==
X-Authority-Analysis: v=2.4 cv=WrEb99fv c=1 sm=1 tr=0 ts=6a590453 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=SvWx0ZcHii_7YJoE2l4A:9 a=QEXdDO2ut3YA:10
 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-GUID: DMkaiW8oZPyPEtpnwMYXC4vr2l_bD6t0
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE2MDE2NiBTYWx0ZWRfX5vEP3CLSaJeW
 37WM5MjVbSusXnOmQm2fCY5KKMiy5CKq9cE/jwLwTVxx78nKiykLGBlc4tPDgrvnA5rj9kOLE8b
 rxLTU/EjgSHMIB0O+ugVnDLTrfyVvoE=
X-Proofpoint-ORIG-GUID: DMkaiW8oZPyPEtpnwMYXC4vr2l_bD6t0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-16_05,2026-07-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 clxscore=1015 spamscore=0 priorityscore=1501
 adultscore=0 malwarescore=0 bulkscore=0 lowpriorityscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607160166

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
 arch/arm64/boot/dts/qcom/monaco-arduino-monza.dts  |  64 +++++++++++-
 drivers/bluetooth/hci_qca.c                        | 109 +++++++++++++--------
 drivers/power/sequencing/core.c                    |  49 +++++++++
 drivers/power/sequencing/pwrseq-pcie-m2.c          |  28 ++++++
 drivers/power/sequencing/pwrseq-qcom-wcn.c         |  30 ++++++
 include/linux/pwrseq/consumer.h                    |   7 ++
 include/linux/pwrseq/provider.h                    |   8 ++
 8 files changed, 256 insertions(+), 47 deletions(-)
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

