Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F167234F247
	for <linux-pci@vger.kernel.org>; Thu, 30 Jul 2026 04:49:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785386953; cv=none; b=tVFDhkzN0E0Yv71U/RfpyVJBilGUjHMvC1ghi4BbIsc3o/E/uZ9FycwkZzN4nsyr8dUNSkwd64dryP0plvCPL40bdGNMfVat8ejnxsXt813LhnA3DYGhj25JN6V7WM1nYgLQtJgHd3cX7xOOMaL/63D3d9xsZX9SaN7Qr5cZG94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785386953; c=relaxed/simple;
	bh=VZJXh43ij+6wvEZ9BoY5kUezW782iYppxl1ls6FH3Fo=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=pQBwC9mMx+c5tl8YIHITAQJ1u1+POmVafepaWk9+EGGxjAei+97LZ+cNN8nHC9GvBIwNDQteu8UuFbyb8M8zLgGbgXzffaBJLEK6G0Dfvpq8bH/eHODV9kG9eXlbHE0UPPBYgiQMsoLthPXjYuBO5bfEFFQP58FV2/JdmztLJ30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=FDvBnjZJ; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=S9NzzOA1; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="FDvBnjZJ";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="S9NzzOA1"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66U4ZlYw3459380
	for <linux-pci@vger.kernel.org>; Thu, 30 Jul 2026 04:49:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=RRv8WoojXtJXS2tAE77IAi
	WJVFbG8DsJeoMpD+E8Wbc=; b=FDvBnjZJw+jhQEs+aY+dvx6sLKhEXjn02yRgmx
	lLwq4MZW5Njt5TPKEDi8d1K/gEl5A7PHQOXsm1a63ea0yFITq+44lvVn/PylHsx+
	Ljz+Ioj+w5biMAOehI7dc/8Yp0ObSiS7fL1UXFjqbumjzwyGM0GFAd191b+YuHCn
	qWWSZ+nPGcw4mOpB4VRnH+pjTLrwXI97+S3vf9/adfMNJ8BHi3VxVm7dXpiwWx/a
	0fYGFJJ8m/5srMEUwAWWXYHkbTn89oy4ms3gkQIRUOlfresmyG+3ukFHaB9tMLGs
	i3CG3oHsuOwAkq1e8htWyz7/f0tgs1WIDAgY0kHuRqIcE2wA==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fqyqn81hu-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Thu, 30 Jul 2026 04:49:10 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-c89704da8c7so2668544a12.0
        for <linux-pci@vger.kernel.org>; Wed, 29 Jul 2026 21:49:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1785386949; x=1785991749; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=RRv8WoojXtJXS2tAE77IAiWJVFbG8DsJeoMpD+E8Wbc=;
        b=S9NzzOA1h32SMsqOuuJEC81der0lagG/ae62Y/Pteu1n2bWU4xKUebcu88sz+8u5sJ
         SjOphPbc6ig21tIeDxk9/WMPUeiG/HcYqXBmipGY6GGdZRJGEYbNzoeyzoejRPkSvJd7
         ucfKL35yCy3LGgwwypP+eyjav42G2pNHtlbni3+pYrjC/hGazdbLAAIDr0piZWhIdOgz
         WwhthYCYx5DNL/RoD0HCGihId3k1yV4DcvN5aZWW8MwmDynPdB14kmT39+ZIW1SGUR4N
         ZWkCZuAgw02XZpcaZ5D38EBaFm6LdT2Lt+AsgqCj+EkaN4g1VrZK0QH+TO71Kedlw8ZB
         CSAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785386949; x=1785991749;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=RRv8WoojXtJXS2tAE77IAiWJVFbG8DsJeoMpD+E8Wbc=;
        b=i2d8AoUlO/1qPgpAOxXBBdIL1ESRckMbUYBGfd+c+kvFxjnv3C1jsyIviV/wpqlH5r
         0udvHkje1AUx8i4rz/8xZDOss1RZok+xdGdVW+g9bSm2oyYyfH4FqwPqI4NZdVujhAbY
         l2N5tPfpZ7us+hoeihx+s+jTK8/Ql8an7hRWN/5tNX0w/roqY/V74CLwMK9nRHCMUn6z
         IirM0iJSn5LjW/ho9mxqZmppiH9ut4JsqEZpJ3FgY9VJrAxDjGmRDt3cSxpCDQpbqiK4
         VkSDxr9CSuHfHdDF6qtTZCtBhpsVqusqNnGzzS5Sqliz/egChLVXIzDrqLwqmVipCT3H
         oKWA==
X-Forwarded-Encrypted: i=1; AHgh+RrsuP02M0lT2hUlrZKzouuN+V3BxwrMRPc4kPUVBj/N6p5x0Uxjja6sW/lo7TcExwlZ6YzJBKqGU80=@vger.kernel.org
X-Gm-Message-State: AOJu0YxC70T66OwHnTyEqOecR7xAKTw6ZWE57HWcnlNTYZ9/zQi4/kxE
	INDJzY9zA4j9UgZ5rLeoZ3jvAXxhMh8DS0sSYqUSusNrkTMkh9rZKvhPglSRW+xho46lD324Z5M
	rvoc9FGesHwAt0dYSG+ug33YOgiamY7FF1kMRdITiCT/ANA81mSsIm7I1wWC8P0g=
X-Gm-Gg: AR+sD11Q1KtPCibhPuLfCxJQ1ML4G79vTEvuBAc9SqEUKWSX4NulghL3Cu7+5wjhflH
	3IBXq+7ejM1Yq8AVoh3aWNpxwkpNTkrrW2A7Sf22ukUYeVC5129ZOJyzGRLRbqI0dl09WDBX0R/
	qoIZGiemlZsbmyJUB9ZmfvxZND+cn6ph9tQUrleyG8TxrLEqNiuzRAl7Rq8N7fA2IgXP38UAyPJ
	d2AqrGPZiTGEBoXTZcg39kySPlrwRZTUeDrmIIVNTYjjl4iLCwl74PbH0vOwGV6Ey5iKx0CA6xW
	Ev4NgI1L+GLsgk96M4XuWCWG+cLSoJlOH2qxABeGi+sAxIjJWk+E48SQALSDg3i+M40DACaQWyn
	x5N0ZDfjt5qmY6cz7ke+1mGnkCXykzdUjxQ0=
X-Received: by 2002:a17:902:d2c6:b0:2c6:9f66:d573 with SMTP id d9443c01a7336-2d035bee57dmr11587515ad.2.1785386949307;
        Wed, 29 Jul 2026 21:49:09 -0700 (PDT)
X-Received: by 2002:a17:902:d2c6:b0:2c6:9f66:d573 with SMTP id d9443c01a7336-2d035bee57dmr11587335ad.2.1785386948856;
        Wed, 29 Jul 2026 21:49:08 -0700 (PDT)
Received: from hu-krichai-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-31504cc9dffsm17740241eec.14.2026.07.29.21.49.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jul 2026 21:49:08 -0700 (PDT)
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Subject: [PATCH v6 0/3] arm64: dts: qcom: eliza-evk: Enable PCIe0 and PCIe1
 with M.2 and TC9563 switch
Date: Thu, 30 Jul 2026 10:18:52 +0530
Message-Id: <20260730-eliza_evk-v6-0-40ece2d33114@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIALXXamoC/3WS3W7bMAyFX8Xw9VRQ/1YwDHuPYRgkkWq81U1iO
 cbWIu9e2h4GF11uBFDg+Q51qNe20thTbQ/NazvS3Nf+9MyF+9S0+RifH0n0yHWrQDlwKgh66l/
 iD5p/CVc0uM4l6WRpuf88Uul/r6xv37e6XtNPytMC+Nsx0uXKJtPW1p7jlI9scWgCScCSSDsIR
 maMGTRAjEU6LU3w1garStic/qkK5UwgPWgrUywAOVFXXNKgUCIVgyGkVPJ7VfAZXU4m2IIoAwu
 QPHsbS0UrMtHpjnJYVQPVGtcYDs3nLQUNAqcqLvk0bHGIYTqLJZKIKM5Dn6uYpZCiGMZB8bnr0
 tdTrQ+Xa3xi1fDAx5eFnmIlsdz006HBbAOZQjFg1y4JHvs6ncY/63JmuQa2TsDP3e2BrUB4p4w
 xkNA7/GC1wma1B3R7gGIAewdlXKYU5R2A3gGU3AM0A4JKEkB3Rep7E5g94N0EhgHIu/SFLE9Bd
 wB2D9j/xdkywEgfINqoDP4PcLvd3gB4kVcf7wIAAA==
X-Change-ID: 20260629-eliza_evk-6f30686b161f
To: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Bartosz Golaszewski <brgl@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-pm@vger.kernel.org,
        Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
        Abel Vesa <abel.vesa@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1785386943; l=3461;
 i=krishna.chundru@oss.qualcomm.com; s=20230907; h=from:subject:message-id;
 bh=VZJXh43ij+6wvEZ9BoY5kUezW782iYppxl1ls6FH3Fo=;
 b=0lKAQgskhw1e8uBRucCRgynMWN1r3x/DurUgL8ZVXIPg7Cfv6WmKrOPaSkrQPiTyqoPHrIkvn
 BbWKKVESGH9CWHqwJ+ZL7nC6gWQXbHozOzjrNILGySwC0kUF/ujtJSs
X-Developer-Key: i=krishna.chundru@oss.qualcomm.com; a=ed25519;
 pk=10CL2pdAKFyzyOHbfSWHCD0X0my7CXxj8gJScmn1FAg=
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzMwMDAyOSBTYWx0ZWRfXw9QFfwY77hVY
 pKlluvh/EYZvp8vVOr4L1zYneiS+8+7RRR6V/KYt/INpLOUGq1L9XGQahSzz/tryIaomUB0SrOI
 IuH/bNzdyF0AVTSSGg9jyZqmBZz//1g=
X-Proofpoint-ORIG-GUID: QsQ4H_4_czh_8vh4Yn2qb0hUdV2hps8L
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzMwMDAyOSBTYWx0ZWRfX+Y8nSEpfyaaC
 OneCUH2SvvdEvGo/VJIV11kfUvOanQxKHKY1SK09JD2tUMlt0ci7GVW+lv09y37JP6HCysYJa55
 h7jyaprbTQpMdhx38oha0V/6MDqnp6WWaJ+RLaNUOzqmtJGdj6XjqUzrHpzQfr6pvdnOP5e4L6S
 2UBkuUS4ptpsg8RhGwSXqvA5/8gAh4TvWOAckoCN8duMy6Z6jQXHQeDJv7Z83WezZRkgGZqCd9N
 +zwYQIjHj+4nsnrOCDhb0Bz0xl9I7ttCHVyjvlHP9shu39bMJmjuzK+13tjFJFEdpME26gDSzsd
 wnwgLJJp6ue73u3EeVFh7kHQbF5UiEO2zWalLLkcbbnBPS1YpizaxflncrYR/IG1u9zjNGZKJNn
 LnYcrknDTYMPPS6BVS0eLIWrg7aZnDR1yNXHsiZCoEQWE1CQioOxrVB6eMT5wdzASIy3+q75cb/
 BVrs2NFzYBC/KxUsMRA==
X-Proofpoint-GUID: QsQ4H_4_czh_8vh4Yn2qb0hUdV2hps8L
X-Authority-Analysis: v=2.4 cv=QdRWeMbv c=1 sm=1 tr=0 ts=6a6ad7c6 cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=bC-a23v3AAAA:8 a=0uohWpJSiqPYzphn-GwA:9
 a=QEXdDO2ut3YA:10 a=_Vgx9l1VpLgwpw_dHYaR:22 a=FO4_E8m0qiDe52t0p3_H:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-30_01,2026-07-29_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 impostorscore=0 malwarescore=0 spamscore=0 bulkscore=0
 clxscore=1015 lowpriorityscore=0 phishscore=0 suspectscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607300029

This series enables PCIe for the Eliza EVK board (CQS SoM on EVK carrier).

The Eliza EVK exposes two PCIe ports:

- PCIe0 drives an M.2 E key connector. The 3.3V supply is GPIO-controlled
  via a TCA9538 I/O expander on I2C4. The slot hosts a WLAN module
  (connected over PCIe) and a Bluetooth device (connected over UART5),
  modelled with the pcie-m2-e-connector binding.

- PCIe1 (8GT/s x2) connects to a Toshiba TC9563 PCIe switch, whose
  management interface sits on I2C4 (address 0x77). The TC9563 RESX# and
  PERST# lines are OR-ed internally; reset is driven via a TLMM GPIO on
  the RESX# pin. The iommu-map covers all downstream switch ports
  (SID range 0x1400-0x1408).

The M.2 WLAN module carries a Qualcomm QCC2072 Bluetooth chip. A device-ID
entry is added to the M.2 power sequencer so the serdev node for the BT
UART interface is created on PCI enumeration.

This seris Depends-on:
  https://lore.kernel.org/all/20260630-eliza-dts-qcs-evk-v4-3-18cbbdba6e7e@oss.qualcomm.com/
  https://lore.kernel.org/all/20260630-dts-qcom-eliza-mtp-evk-add-pmics-v1-1-f4f320f7c88b@oss.qualcomm.com/

Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
---
Changes in v6:
- change 0 to 0x0 & remove num-lanes property (Mani)
- Link to v5: https://patch.msgid.link/20260729-eliza_evk-v5-0-41790a5a24de@oss.qualcomm.com

Changes in v5:
- change from pci to pcie for subnode names (konrad)
- Link to v4: https://patch.msgid.link/20260728-eliza_evk-v4-0-decc7fe5246e@oss.qualcomm.com

Changes in v4:
- Added new line and used pcie port names as pcieN_portM (Konrad).
- Link to v3: https://patch.msgid.link/20260721-eliza_evk-v3-0-92b10038f13d@oss.qualcomm.com

Changes in v3:
- Clubbed pcie nodes to this series (Bjorn A)
  (https://lore.kernel.org/all/20260708-eliza_dt-v2-1-e6281da26408@oss.qualcomm.com/)
- Added comment for PERST (Mani).
- Extended ranges property for pcie1 (Konrad).
- Link to v2: https://patch.msgid.link/20260708-eliza_evk-v2-0-c599246ceba1@oss.qualcomm.com

Changes in v2:
- Drop patch 3, as this is already applied
- Rebase on top of https://lore.kernel.org/all/20260708055017.A90C91F000E9@smtp.kernel.org/
  and remove pincntrl as pincntrl is added in the eliza.dtsi patch and also remove
  pinctrl for resx as this is covered in pcie1_default_state as perst gpio.
- Link to v1: https://patch.msgid.link/20260703-eliza_evk-v1-0-7624440bd76d@oss.qualcomm.com

---
Krishna Chaitanya Chundru (3):
      arm64: dts: qcom: eliza: Add PCIe PHY and controller nodes
      arm64: dts: qcom: eliza-evk: Add PCIe0 with M.2 E key connector
      arm64: dts: qcom: eliza-evk: Add PCIe1 with TC9563 PCIe switch

 arch/arm64/boot/dts/qcom/eliza-evk.dtsi | 229 ++++++++++++++++++
 arch/arm64/boot/dts/qcom/eliza.dtsi     | 413 +++++++++++++++++++++++++++++++-
 2 files changed, 640 insertions(+), 2 deletions(-)
---
base-commit: dc59e4fea9d83f03bad6bddf3fa2e52491777482
change-id: 20260629-eliza_evk-6f30686b161f
prerequisite-patch-id: 9e10dfbe360941cdac0300aaf163149755952f9f
prerequisite-patch-id: fecce0170351baf00cbe8f6b302d1def4d99bbfc
prerequisite-patch-id: 97cd6cb495fdd198f6de7fbe45ef32e4a638ec9c
prerequisite-message-id: <20260630-dts-qcom-eliza-mtp-evk-add-pmics-v1-1-f4f320f7c88b@oss.qualcomm.com>
prerequisite-patch-id: f3615b5c1e2222a2491f862a7fba3994058ecc53

Best regards,
--  
Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>

