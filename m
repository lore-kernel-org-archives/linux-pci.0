Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5844638B14F
	for <linux-pci@vger.kernel.org>; Mon,  8 Jun 2026 06:59:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780901969; cv=none; b=sq5knN1BHnhQgpbPzJN07lT59r027FeQ3ASC6/oW8FVR2yvJ2oxelcNgeSyT7s2LAsdkVjZx9Mi7Vwr9AZU6DQUOyTqdFy4qK2kI8l7OntoVQUyfwY8Ox5hnLUSfAWSYRHk8Fx5FIQnbxy01OHZODto2YtThdZ4e7AVUXLTtxSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780901969; c=relaxed/simple;
	bh=kX8sQsZD7+GXxK6scrMwZsmWM36HVbnaMaQ+ChX05zw=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=upNUZvBaWYGsHtqrhsCDw6U1zf1jcgEHgqFJBVF417/EC/FeJs2HdwsB9ImXNPTk7ai9EjP8J9fNPgHgy4hhuMXOUxjFOQGCg0PuX/Q3NUPJg3wljAD64788PR0xiq6kxdWUOYTqD3bSbmYv5GMFLQuRcknudtk99FVjmSUjnYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Pd7Z+oYL; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Hrl0+v9x; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Pd7Z+oYL";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Hrl0+v9x"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6586Ovug2833010
	for <linux-pci@vger.kernel.org>; Mon, 8 Jun 2026 06:59:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=DoLbGeNFDGlHR+89QHRczU
	z9SK+zm6OjHb7++b63eUk=; b=Pd7Z+oYLLpo92FhhBgXxctOptCvzfHaK0jKa46
	z6i9ZA+O5LRmjVc+ab0pJYbzXpfeLXJS6p3WLmwOD8fx89qT6TaMtMCyb4e0jvt0
	OquOQG72MPLa3Jm2VhlUx/6R5Vq05nifGYP636KhjWDZMvv8kZCo8sbNJcA7e4KP
	uJuWwbNj+emnIwr7UmHWAqfU8GFLfkhLG0giwcvSA9rJYFukBGdvF6WMquUX/uAV
	C2mOd2utnUs0Ads10bV8h+o1sMAOQDG4XsgzTgCLF8i8Po5kMIL6F/TyQ+n011SG
	IR+g/PFb0F9zlBCqkbeFkkVg78CEMcdPKnhcYoTQ/V8mxkvg==
Received: from mail-vs1-f72.google.com (mail-vs1-f72.google.com [209.85.217.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4embmree8s-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Mon, 08 Jun 2026 06:59:27 +0000 (GMT)
Received: by mail-vs1-f72.google.com with SMTP id ada2fe7eead31-6ce6f8465a9so4916257137.3
        for <linux-pci@vger.kernel.org>; Sun, 07 Jun 2026 23:59:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1780901966; x=1781506766; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=DoLbGeNFDGlHR+89QHRczUz9SK+zm6OjHb7++b63eUk=;
        b=Hrl0+v9xAUcy0CULmPh4KiUmxLCYuXPh4mDAo15rThCe/2bup7Lpz6EBYsRBcb3RjT
         x9mglnB5O5Re/1Em1XRJw+qvEtR2gJ9p3orqYrpflZ5H0wM/087hL9tyO4GMcx9EMxFo
         aqIXD7y4Zb7Z9LMTRhCcRcHBMjjO4g2HshV/BtSmDXlXplNoUjxtjMd7+9Olc1IpqtOB
         zVWbfXKK9DCNhmFj42Ih0gWLY4lj/81Qhc/YRvsl3qCW4GGIAKwhS+CDXTW/xA/ERXQ8
         TpBU2hZ2cN+aYq52u/bwgBIOMe7HZ978/TwXYRRY02mO1D1p/33wHfluhR5jAnY0lvm6
         cqWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780901966; x=1781506766;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DoLbGeNFDGlHR+89QHRczUz9SK+zm6OjHb7++b63eUk=;
        b=st5Uz6KyVJx7xW/ImwW/RoybFfC/YZUgKL+XVipVJZb+bubqvUVcf6qXr9sOH4b4Bg
         6N2eqI4uFgYc9xvwmFiiLOMJ4YDBJG3wDCFCVbfuYa9XANuK+NbzlQRS/EourNIn9r1V
         yHbJXiUr1QUNDYzEKtjVjQ+qZzpPe+I7Bxb5l9fMgsyNmK+kFJFK+2ukJnYlgCC636nO
         zpqKIgjyLxP1aTxanrUtK2WyI1sSa7a8r4vtSZHBDKxNCI/s8KVG0oAQV2aaqqDJoyz1
         tOj0gZuELkGtCGW+ZnZZcN9m/NnYCX+0SxHry7VBvKgqDkkYqJbaItWmXKaSB1L51K58
         VSNw==
X-Forwarded-Encrypted: i=1; AFNElJ+0cQqPxuAPKcA7bZPj22Y1y6xBJS8uJRsTBlTEx2Byum3ynkgK3QfFBAUUaWmH4FpTUZP/yVVHhTY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxHL7v1UEwZzEoBYVLbhLFwWwMMvVTdv6shAg9ycTXZHPyz0j3r
	dLKkvTFmEQLhEh2TFMEj4P7p3QksvI4/4O6sBd6CRW9w4fOPiZliEjQPTYHux5j5APvjItOwUNN
	53TpllQ7MSgG2bet9MDj2+F5bYnO3t+1OzxR84w9jziQI6hLfBjN4g8pAdeWgTP8=
X-Gm-Gg: Acq92OEecPz2ajhMENq+GTMHySo2nR7pE/Lseb1ZMWghpq3rOue9/Wmb9obTDs1iJiS
	Mqli7C5HoF5CBRGEHzNGaOgBekgt+fpE9/SXQoIMY27p7rpTmwkc2UP8vFSmxUtcVuEF2u6cALZ
	mOLHvYOyloxtK3e6BaaaSU9Cf/W7xWTb3fmr+KOVsrvbSe/j6SHzcw0t8vkXX5I6H4m8K0Ql8Bf
	zCKabg+II31gPeseyAU0Fa2T9ISFiMcUGMUHDYeehHXo8J8qIv/MBrQ6StpgOOYoMJMDDkre3pt
	2Rc77JGSrkJ0QTgLomZmLeaxUivcDM3YjlDFbu/XRYJkAXtT1v89136A1teQec7k+Gfpm3PRHrf
	+3ZD/lZZQtPLRF1uPGTq9Pex4zglVclFQNzUc4DJrZY6TMXA6Lr70R+VPkYLdJGyjO7h8TQ6Ehy
	u0BT/6N17b3J4TgLAY2B1TO2FaHo8kvFi4IZSWX1Tm7SETPg==
X-Received: by 2002:a05:6102:148e:b0:633:8c42:183a with SMTP id ada2fe7eead31-6feff8177bemr7670990137.9.1780901966556;
        Sun, 07 Jun 2026 23:59:26 -0700 (PDT)
X-Received: by 2002:a05:6102:148e:b0:633:8c42:183a with SMTP id ada2fe7eead31-6feff8177bemr7670963137.9.1780901966202;
        Sun, 07 Jun 2026 23:59:26 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5aa7b8ed789sm3638621e87.3.2026.06.07.23.59.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Jun 2026 23:59:24 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Subject: [PATCH v2 0/7] arm64: dts: qcom: enable WiFi/BT on SM8350 HDK
Date: Mon, 08 Jun 2026 09:59:18 +0300
Message-Id: <20260608-sm8350-wifi-v2-0-efb68f1ff04c@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAEZoJmoC/1WNyw6CMBREf4XctSV9CBZX/odhAaXINUK1F1BD+
 u8WWLmZ5CQzZxYg69ESnJMFvJ2R0A0R5CEB01XDzTJsIoPkMueZEox6rTLO3tgiUzXPs6I2Qqs
 K4uLpbYufzXYtd6apvlszroq10SGNzn+3u1msvd2c83/zLBhn8igLcWq05kpcHFH6mqqHcX2fx
 oAyhPADyvkjMb8AAAA=
X-Change-ID: 20260531-sm8350-wifi-3b0659bc183a
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
        Bartosz Golaszewski <brgl@bgdev.pl>, linux-bluetooth@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1711;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=kX8sQsZD7+GXxK6scrMwZsmWM36HVbnaMaQ+ChX05zw=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBqJmhJ62EPLw2wHCOzmMHkygIyfRi3VNIwoeZ7n
 XMzCJgYxB2JATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCaiZoSQAKCRCLPIo+Aiko
 1aWWB/9q9FMl9zHtWaCN27mxlfW4OEuabIPIMZoM2/kXkQzi9TkoXEnIPjkwhXeEMPLRuJ89Vte
 lWl6jykC6bN6e0GDhye7fIZdmt8GIekDsZ/OzX5BxqoSsBgVSRlmlhP6rV6StRnkRhPb3peMVzn
 I9ErCOQyoxPtixjB4mVZAGqs8O/rTE2LAtdLQR2BhOpNnDxLL/S4al+KhAKzpoeLZxU0TteasLW
 gOVd2QDSqGUYmo6xTb5jbHNBMpvyVQKGlMnR6wjwHg5U5ra0vE54cneYutMDigJNxVR/xPlJeg9
 GA4vhuuZTwRz1aJNPRfnxuwDXYtGRAu0BNZP52BVtTj2KOof
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA4MDA2MiBTYWx0ZWRfX8hQ9aO8a3bNl
 PJJXN868F/LnC3RlmBYf7I0wqu2tPZoKdW5BHuSdsDt/hQgFJzw4zuvwD6T1xB9k8JMUPZhv8W9
 R9+hJC0OirmqKTxx+FFovKADqQUx5Bk++VViYDALjsOPN6G/jkzZKG0lUfOSBtC3TshEZ2YK5M1
 UCxPErGbeUszcqefuv+t8yqViSYiY/StrX3/+kHy6fcb9t9sNsujqA6aVISeYyDWWpcSPJTQFwy
 9KN9xI4l8yO/VsUyD6BR2ojFhik7/jQReag17j/rN2T3aLg/IWbn8TW/FRB38ItrvubmVXRtikn
 UbjnGl14UfZSX8AbFcjHljM6Pq0HvSpTlpR8DWs6LsfNz/Q4HQCS8K8H8vuby4mknXVma6QxZi9
 C/CVuGw35uQRnhHwFlCpEXGCZnIK9RV4vtYpWWHMot6Gfa9TuhvV5J1b1X0YZ/lA5LJjVlk6R9w
 lDKltEWr3wB+uP3ts6w==
X-Authority-Analysis: v=2.4 cv=B5eJFutM c=1 sm=1 tr=0 ts=6a26684f cx=c_pps
 a=DUEm7b3gzWu7BqY5nP7+9g==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22 a=bC-a23v3AAAA:8
 a=EUspDBNiAAAA:8 a=6KS0kTMdj-vf8_meW0gA:9 a=QEXdDO2ut3YA:10
 a=-aSRE8QhW-JAV6biHavz:22 a=FO4_E8m0qiDe52t0p3_H:22
X-Proofpoint-GUID: XfwGcXxDNhFzPC6C0cs7RN8_FbFqovjr
X-Proofpoint-ORIG-GUID: XfwGcXxDNhFzPC6C0cs7RN8_FbFqovjr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-08_02,2026-06-05_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 priorityscore=1501 spamscore=0 malwarescore=0 phishscore=0
 bulkscore=0 clxscore=1015 adultscore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606080062

The SM8350 HDK has an onboard WCN6851 WiFi/BT chip, which for a long
time was not supported. Bring up different pieces required to enable
this SoC.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
Changes in v2:
- Bumped num_vdevs to 4 to follow other similar devices (Jeff)
- Link to v1: https://patch.msgid.link/20260601-sm8350-wifi-v1-0-242917d88031@oss.qualcomm.com

---
Dmitry Baryshkov (7):
      PCI: qcom: fix parsing of PERST# in the legacy case
      wifi: ath11k: enable support for WCN6851
      regulator: dt-bindings: qcom,qca6390-pmu: document WCN6851
      dt-bindings: bluetooth: qcom,wcn6855-bt: document WCN6851
      arm64: dts: qcom: sm8350: expand UART18 to 4 pins config
      arm64: dts: qcom: sm8350: modernize PCIe entries
      arm64: dts: qcom: sm8350-hdk: describe WiFi/BT chip

 .../bindings/net/bluetooth/qcom,wcn6855-bt.yaml    |   8 +-
 .../bindings/regulator/qcom,qca6390-pmu.yaml       |   4 +
 arch/arm64/boot/dts/qcom/sm8350-hdk.dts            | 142 ++++++++++++++++++++-
 arch/arm64/boot/dts/qcom/sm8350.dtsi               |  14 +-
 drivers/net/wireless/ath/ath11k/core.c             |  92 +++++++++++++
 drivers/net/wireless/ath/ath11k/core.h             |   1 +
 drivers/net/wireless/ath/ath11k/mhi.c              |   1 +
 drivers/net/wireless/ath/ath11k/pci.c              |   9 ++
 drivers/net/wireless/ath/ath11k/pcic.c             |  11 ++
 drivers/pci/controller/dwc/pcie-qcom.c             |  25 ++--
 10 files changed, 275 insertions(+), 32 deletions(-)
---
base-commit: 6e845bcb78c95af935094040bd4edc3c2b6dd784
change-id: 20260531-sm8350-wifi-3b0659bc183a

Best regards,
--  
With best wishes
Dmitry

