Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FF7C365A17
	for <linux-pci@vger.kernel.org>; Wed,  8 Jul 2026 06:17:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783491452; cv=none; b=d/NhvGjJqjs1M+AeznSLDetax/wek3T6o/hLMS0SfuKJYTAoQxQNUh/QiQ4YTGuK1MzYyYR43WZYF1TXlGWZheXKkOcHuA7gPht7o04uaf1K+yK88pO6NHaXnT/9stDfkTkySJIphZtpMcdqq9kUVvL8iCOszcXJf7LgMARO42g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783491452; c=relaxed/simple;
	bh=Zohy3CZoCN1/nHkUVNpwSuSIgHeegT4Kt43f2cRqiQs=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=hf1c9Y351mrJ0394NkIKIepu9EDTk5d163Rqh77V11kTqdD8pQZr2sdVUsMd5K+s9m4XcG1rv1Pt8ZiHv4vd3FWm4knLa6iSZbZk0KnZoozYLotKoYqAvLQXEcOOYmcugipubqdlrhVIO0U05GE3dU64fBL+km/zP1YbX8TvZw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=CM/SyB5L; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Fmn2EeJP; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="CM/SyB5L";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Fmn2EeJP"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66842hDF1625072
	for <linux-pci@vger.kernel.org>; Wed, 8 Jul 2026 06:17:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=PuuKoCf05X2ogdbUrP958b
	gw+5RgexsiWyGIOVrjGbY=; b=CM/SyB5Lgh1yNMKuGaEIuKO3nro1VkSJBg8F6m
	OfQxIH+Oh4pG496bmI+3seFeTeOVnvGK6y+N+xeF6GzthkIMD5ROhGZn15x6RSnB
	UiM4v3wV03cEMT72mWwuEa+CBkrJtFEotQQH5bXrQnvksLMxHrEsQhB+ZOV7DO1f
	dYqixsaTfpVXtsUjmER/0RmfTUz3ogdXmY3E0/9vd1+oahOe1rp8kT2TzC/VaNep
	16NNOSXngOueyiepMgA1WQTeKM7XsXgFFB44PPM2uPyJOqXCcZUQ3Zbl5p8A5KaN
	Gu3f3CA5QdZzKpOGEXNBDlwAdwKf0dwCasmf+aRitB38dyRw==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f95fd2ytm-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Wed, 08 Jul 2026 06:17:29 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-c85798977dcso599692a12.0
        for <linux-pci@vger.kernel.org>; Tue, 07 Jul 2026 23:17:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783491448; x=1784096248; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=PuuKoCf05X2ogdbUrP958bgw+5RgexsiWyGIOVrjGbY=;
        b=Fmn2EeJPz1W9ykhqKST7GuMGkYCpfaON94c/0B1PyskCbHD9y960/CsIWIJzyCxKCz
         G2hayBOVr9OXQDstdpwujWqLsTUTWZx9URoKZUmqbmDwhl8Dpsw3icPHtC9Bomt7n8wz
         E/tbMyshys9Fukx+C4HF9on4aKUGHUf9F5SIvXgMmPHdX8XCKARGVtZlzhFHRgAhrtFP
         WOhYjPCJpkZRoVmkdymmOU6Y/KAlVlyd6mwCQLLpQL5UzHj5deVOgr7W5RtILokwiXIK
         54mX6krH1W7knjpKOc4lkVK/DRprDwFzmxZmYhKx3wGeE7mYUV87yf+EyzkNv67slxFr
         KQiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783491448; x=1784096248;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=PuuKoCf05X2ogdbUrP958bgw+5RgexsiWyGIOVrjGbY=;
        b=AFpQQkuB4AMI7LyL31tPDEUtST8LJfBbEBGSvoPY+wNzinAvFWrYnGeJCX/7TOLTHq
         QnSxlhnTPRUolqxCkvl37Q2sEF3mehb7A+kmRPGVCdtA+fJcTw1x1aWDIC191vZ6Yy11
         57bZJkbhPG2t9WU9YnK4O1VNZj73FwjMMy2w2TikQyqch+tkzgFXZp/agoqSDTqikYz3
         v9F4d3bAyUHzY918k6PWIpua5e8GO9yqAC6Trhr6S78qwResj+/pGmj/bZ/4GgyGdJjb
         3Za4Vw2NpDGiGUiKVgQ/Xw/P8FkXOsraVjSnJN/ojLJuBd8zxWQ1g+Lg1+mf91nwbgPf
         n/TQ==
X-Forwarded-Encrypted: i=1; AHgh+Rpult04YcAvPpChPoFwn9isNqyWog1ixexS1/98qy+2w1nUsMmBDZcOAvgw6TS+Vb46Yqlp8gpCDpI=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywlc2EMh4nJ/j6b51ELKRSgRQT/sdZHCQnLqbvIOh0RnRyuA0f6
	ZXlMogw/F1UCerEGtXngN8Kx939+RDk/u/P2eq1ZgRNlj6dBl2fzQdg7UaLnzI+nBnOym3i4tkt
	kNjCL26hfcIgeDgdzxrLZBDl10faJttkQO+JWM5ZnWxFyti+ofM2HuOz+SJfLgPnsVjdM/F4=
X-Gm-Gg: AfdE7clCFkKHvpbenmF7FdJae8tt6uSCmwOMD8bq6LzMqK41x+FIlh2JL2lTxDxP93C
	hmRqiLzsVmAs1evgiDh5N603EiHOs9SC975zb/uqY95X3SCAz4XZmt0Qm64+Gb2mUNDXa+q/+Nh
	+zg24gA3tDusPf4nJ85w1dA9JPOlaJnnW/+NcjBETQXM0+FNq4/TQUwBqr846I16pF9URfJ3nQj
	JGpMUC3v3KkSuDPi9jYHbeWi65RUnr5EAy94kGoC5ivcB5+qEl/bpDlw84Na0RsTxqTbY7A+ZGr
	/bjVb1G9wicWuKohBoN6MPT//G+aMbyqTgOz73uP00R9K05a6uBAgVPLWNMceDrVaznaagdbGvo
	8l8YL49VeEBz8nb3+pneRNpTe1RurtilfLL5WzeFPIMuiFA==
X-Received: by 2002:a05:6a21:7018:b0:3b4:8818:fd20 with SMTP id adf61e73a8af0-3c0bcf50032mr1235353637.8.1783491448411;
        Tue, 07 Jul 2026 23:17:28 -0700 (PDT)
X-Received: by 2002:a05:6a21:7018:b0:3b4:8818:fd20 with SMTP id adf61e73a8af0-3c0bcf50032mr1235311637.8.1783491447994;
        Tue, 07 Jul 2026 23:17:27 -0700 (PDT)
Received: from hu-krichai-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3117483941csm17028221eec.7.2026.07.07.23.17.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2026 23:17:27 -0700 (PDT)
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Subject: [PATCH v2 0/2] arm64: dts: qcom: eliza-evk: Enable PCIe0 and PCIe1
 with M.2 and TC9563 switch
Date: Wed, 08 Jul 2026 11:47:15 +0530
Message-Id: <20260708-eliza_evk-v2-0-c599246ceba1@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAGzrTWoC/22R3U7rMBCEX6XyNUbrnzh2hRDvgRCyvbvUQGgbp
 xE/6rvjpr04B7ixNNbufJqdL1FpLFTFevUlRppLLdu3JvTVSuRNfHsiWbBpoUE7cDpIei2f8ZH
 mF+nYgPMuKadYtPndSFzeF6/7h7Ouh/RMeToZXCZG2h8aZDqPiYFqjQtkvbpZGD34CwMnOWupJ
 DntFUbtLPi7ba3X+0N8zdthuG7P7eIbp7xZPAIpQE5kHASrMsYMBiBGVs4oG/quC53mwP9vMeV
 MoHownUqRAXIizy4Z0KiQ2GIIKXH+weozupxs6BhRhbaA1De27YiNJhud8ZTDsvU7pzMgcapy3
 0KcA8th2snTYSOi3A0lVzmrlp9tswPus/fp7/wpVpKnnzKtV5i7QJYpBvTi1MOm1Gk7fiwVz2o
 5++XS5p82Gwpk77S1FhL2Dn+hxMPxePwG6/W4rjECAAA=
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
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783491443; l=3188;
 i=krishna.chundru@oss.qualcomm.com; s=20230907; h=from:subject:message-id;
 bh=Zohy3CZoCN1/nHkUVNpwSuSIgHeegT4Kt43f2cRqiQs=;
 b=7te/FsCW21EKCkeDRRyy+yu9bx7vQa7WB1AlbFXL7pgPFtU+VNv3M9LatZbGfoc2qOknIjvy3
 RDHtP30HUmFDjyByJt8AbdNe3Qy+KhfS/cItf5nFkHQwTQi+0KBu/UE
X-Developer-Key: i=krishna.chundru@oss.qualcomm.com; a=ed25519;
 pk=10CL2pdAKFyzyOHbfSWHCD0X0my7CXxj8gJScmn1FAg=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA4MDA1NiBTYWx0ZWRfX7R15NZ2320+V
 +mTPx0i11b3AzczLHpCXUxtWjf3n0IoMqTXN1ZLg+Njb7369LlowoU47nOlPJUg3Rt6J8siFeGO
 AZ0OPQBk5b4UiT/LKDhIW/Htz9UREllVsS7wz7zk581JtomWOVDGxLQ6+OX8WpjmojJLdtWwqmt
 2YwVIsXW6Qox5zPWTxVhNidSYvBncVsbEq+EUHxIgxfSgor+jQYWx9W/eyN21aE1G6C2BUKM9Oo
 rf+2x1ziZU185xXRsAjcAUBcyU379Z9BItuuDWJDEQ4QClLKb9+flIp7czgl2D+7C7WRkbMF8Yu
 0DfNAK9PQZCnpXEZ8ZoCwywhjA0kpje/JEpvAFWrjij68cVhbPYlBFzvYfAcwCxv0KPQVnmHA4Y
 p1N7qmZXXiZ5nCY1Xdi7dVHJnUj/DKLcKcPHsKYWy16SOzNs/5mVya9qsNtdJylAYXQWuWWAc4n
 oAl3qwpaBsnW8KV0XjA==
X-Authority-Analysis: v=2.4 cv=VZLH+lp9 c=1 sm=1 tr=0 ts=6a4deb79 cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=bC-a23v3AAAA:8 a=KH93JrovTcJc50lypuwA:9
 a=QEXdDO2ut3YA:10 a=x9snwWr2DeNwDh03kgHS:22 a=FO4_E8m0qiDe52t0p3_H:22
X-Proofpoint-ORIG-GUID: tlrHeH7I1oumDvKM1VOfPHQvEr53EpN_
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA4MDA1NiBTYWx0ZWRfX8yXfrXseF1Rh
 lXSUR5liq2bmqrtvSU6oGIf3pJIVIqOFvZ6vKZwoRa3DL03pX8BK4w5tsYsvuNxLxI5u7EjDJ/4
 dJMxmNloH1qc9bW28cU+PgJPPvhTdE0=
X-Proofpoint-GUID: tlrHeH7I1oumDvKM1VOfPHQvEr53EpN_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-07_06,2026-07-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 bulkscore=0 priorityscore=1501 suspectscore=0
 lowpriorityscore=0 spamscore=0 malwarescore=0 adultscore=0 clxscore=1015
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607080056

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

Bluetooth is enabled with this patch https://lore.kernel.org/all/20260529175822.3366535-1-yepuri.siddu@oss.qualcomm.com/

This seris Depends-on:
  https://lore.kernel.org/all/20260610-eliza_dt-v1-1-7bb72b75fc5b@oss.qualcomm.com/
  https://lore.kernel.org/all/20260630-eliza-dts-qcs-evk-v4-3-18cbbdba6e7e@oss.qualcomm.com/
  https://lore.kernel.org/all/20260630-dts-qcom-eliza-mtp-evk-add-pmics-v1-1-f4f320f7c88b@oss.qualcomm.com/

Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
---
Changes in v2:
- Drop patch 3, as this is already applied
- Rebase on top of https://lore.kernel.org/all/20260708055017.A90C91F000E9@smtp.kernel.org/
  and remove pincntrl as pincntrl is added in the eliza.dtsi patch and also remove
  pinctrl for resx as this is covered in pcie1_default_state as perst gpio.
- Link to v1: https://patch.msgid.link/20260703-eliza_evk-v1-0-7624440bd76d@oss.qualcomm.com

To: Bjorn Andersson <andersson@kernel.org>
To: Konrad Dybcio <konradybcio@kernel.org>
To: Rob Herring <robh@kernel.org>
To: Krzysztof Kozlowski <krzk+dt@kernel.org>
To: Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org
Cc: devicetree@vger.kernel.org
Cc: linux-kernel@vger.kernel.org

---
Krishna Chaitanya Chundru (2):
      arm64: dts: qcom: eliza-evk: Add PCIe0 with M.2 E key connector
      arm64: dts: qcom: eliza-evk: Add PCIe1 with TC9563 PCIe switch

 arch/arm64/boot/dts/qcom/eliza-evk.dtsi | 228 ++++++++++++++++++++++++++++++++
 arch/arm64/boot/dts/qcom/eliza.dtsi     |   2 +
 2 files changed, 230 insertions(+)
---
base-commit: dc59e4fea9d83f03bad6bddf3fa2e52491777482
change-id: 20260629-eliza_evk-6f30686b161f
prerequisite-message-id: <20260708-eliza_dt-v2-1-e6281da26408@oss.qualcomm.com>
prerequisite-patch-id: 7654ff4f899ac0094a2e791e7f208998fcc7d5fa
prerequisite-patch-id: 9e10dfbe360941cdac0300aaf163149755952f9f
prerequisite-patch-id: fecce0170351baf00cbe8f6b302d1def4d99bbfc
prerequisite-patch-id: 97cd6cb495fdd198f6de7fbe45ef32e4a638ec9c
prerequisite-message-id: <20260630-dts-qcom-eliza-mtp-evk-add-pmics-v1-1-f4f320f7c88b@oss.qualcomm.com>
prerequisite-patch-id: f3615b5c1e2222a2491f862a7fba3994058ecc53

Best regards,
--  
Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>

