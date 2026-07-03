Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80CD83D34B9
	for <linux-pci@vger.kernel.org>; Fri,  3 Jul 2026 12:38:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783082326; cv=none; b=nJKupu+kpun9XNESbJzuV/fMxDbQnGpC/8Q0fBgDAljbqdi47V0yvBBiLWwnNB5lKqzPTIotzkm13twwU6SMHMtS7zLv4JEdnW71+LJy6TSxSk6GdvIypB4+PxM5JwEKvCgJqi+Diqn9SFQlPdG0Knp9UR8PirFOR6XehgOKyM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783082326; c=relaxed/simple;
	bh=S8MYJ0Gty39K24ANe2kgww56Fg/Is+/uFYmYQKcyo1g=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=eR3SnMuUYBbUqWB14h2ZW5gEfdgSMWwSiMJH0b+E68XluhhitusZwxHhT6mlH6Tbb2q4DPUTvn4NiYLjXI5HARAuHZK9BxLfs9zWxuAEk97eikZ5HzURSvMbBueSZZcu+7Mf0CHHjl+c/5EGZxTGGpJzIF8pjygV7riuIH6BT6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=op3LP88S; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=gVJT4RgA; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="op3LP88S";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="gVJT4RgA"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 663BJaHk3134744
	for <linux-pci@vger.kernel.org>; Fri, 3 Jul 2026 12:38:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=QklNaAE+SC0PdzUYHH/SaR
	KtSfulcJNOcVu4EBzPC5s=; b=op3LP88S5CT/HrkFoyk5BA3Sh+mRPWOl4vnAHt
	OSU8VKyFUulWLGC9g9/D26TNfqwNz9UC8dF2NRO/2uwz5Vh758yGzDMxLf/y2NiG
	aqHqYeaI/SJPmHBSiHG8OEBzknAYNNPJAtE+dWU4cZq3/JPOsBjsmDn2P2wrmtf7
	htPpeC5RBZQl7BiNNg04DgjqdSQbuyly9OTV4VC5aJRGFrIWJ+gXV6THEbxOU5y7
	Z3GHdUO4TCAK8rOxoNOJgEgteOk2lZwxIxJJi3RdU4eLzGVb5ZTPGivO67zVEC/S
	12K4FRoKvA6eilZ39xvdbjHPvEIk+QgSAZNZM+6kTL9uNayA==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f65qcj47s-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Fri, 03 Jul 2026 12:38:44 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-c860544c077so1417630a12.3
        for <linux-pci@vger.kernel.org>; Fri, 03 Jul 2026 05:38:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783082323; x=1783687123; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=QklNaAE+SC0PdzUYHH/SaRKtSfulcJNOcVu4EBzPC5s=;
        b=gVJT4RgAHzAY3dPMQPIIuihgumkfmF8H46ChiJ+Rd7g0ZsGDWUppqxkKMyk3A1UJQ4
         WR99Gsksqj9yDbycYxkEA2p7fKVD2o16ogYEWlzMQdh87rtozV31arC/tfB0rKAg9zcJ
         e1KWuVEz9ucEqCpGCPEBt0n7OdfVfQREU2Trzx+hAn/7GdaM9uogkqdY0/juk1Sy+EU8
         /4RIC7nB7Adj4roCJOHAvRlyia5RJWICSXR5BKso0IfXjN/yy7x2Pc5WwOxDkVnUGiYj
         s4DQNBySJJZZEwZqKpLsXsCgjevvEKVUth9gStaLT/CS/XoEhD5RN5H89EtmVlOyWmGR
         mOSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783082323; x=1783687123;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QklNaAE+SC0PdzUYHH/SaRKtSfulcJNOcVu4EBzPC5s=;
        b=psBOqw/XRI4+DgugcNz35plV9n7dycGAXDapmztZD4TVxYvtPg1sRBpHHZQDMeQUvS
         BqTDKvFzYWkypNeaVqRWRkBf5di5qbc3k+u/0sqPflA2tA1SI1UZggZdnN1fw/DgJYjJ
         l7VL0HQ2Tavvq09RBWKXlek1jdn6yFCQu33ZVzBBFeqXXnrn4G0nZVaXk3rKiR9M6u7t
         /igVfE1a/7EvcTbW7UozsoUnLxBuIaBVyhWNMkYdNiDAH+21VXBsC30Z2VuC3sEqeg3J
         Y+K/R79tA4/zYEEVp6dsRwY1u/39q2QC8V0ndy5UJlrOxn7J7eouEgDw/S/E+VXoxoNx
         8zyw==
X-Forwarded-Encrypted: i=1; AFNElJ8M3TkMJmYAj0vnsWjFNKIwzvYwqzAMr8CC7tpBHOhogUE2CYMkZTssYGgkx+R91NSIwy3Kln4r+kk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyXWIw9sqLtfxsuwAfNSylQpAqgoNpbshZaHHGjntB3iRaQyYCT
	IJmpLUzKs9dHC6w2JsjeXGaYRaKUy4BtXEfSzxDahaQy4VtQENnxs/R6F3gx8OSAqSD1iHMf8wy
	aDNXQmbhXJtnVlXSDbPR/T5JlvjWGoC/06/ScMCZ5TWsH2RSNyrC9Ga51I+9p348=
X-Gm-Gg: AfdE7cn8N7wE7jw1aK/09EfOZGwSHBxlzxhR/oUhOVrIe2kEphyI1/dQneLIYMwe7Yc
	5npoVlrHuwrRjCemQ9+9eEDKQX/BbxWs3G6ld3OMJG6+4ZfTQSLHkMHYPBgp6BHGGaEF5qHP9w+
	1tvE6YEFCp6bLp5qPxQaiuVbELwuKvSYW04rrljm9SC3pOGhz2EWjlrehDPcOpQNrhK9RvBfy/q
	r8OqlxDJM4EisD8t/qy43nRayjW8sIFMyr+2/fAVgJ7ybUgLhgteJTpsJ5KznmMZtdjA+tXKYE/
	4EBOcWi+uWMIuF7BPtYcoRHcvukGKtXo5rA/slpJ4bw6iRiFByA7vz0pfD5aXYZ46gmZtyjnA1L
	OuuJQ3RjwqE0UVMUf9QCg1p3d4zJxMk/LsDTHoCPdPE89Sw==
X-Received: by 2002:a05:6a20:5484:b0:3bf:6c08:2842 with SMTP id adf61e73a8af0-3bff42c92cdmr11762231637.49.1783082323470;
        Fri, 03 Jul 2026 05:38:43 -0700 (PDT)
X-Received: by 2002:a05:6a20:5484:b0:3bf:6c08:2842 with SMTP id adf61e73a8af0-3bff42c92cdmr11762156637.49.1783082322433;
        Fri, 03 Jul 2026 05:38:42 -0700 (PDT)
Received: from hu-krichai-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13b3c870effsm24356993c88.12.2026.07.03.05.38.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jul 2026 05:38:42 -0700 (PDT)
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Subject: [PATCH 0/3] arm64: dts: qcom: eliza-evk: Enable PCIe0 and PCIe1
 with M.2 and TC9563 switch
Date: Fri, 03 Jul 2026 18:08:29 +0530
Message-Id: <20260703-eliza_evk-v1-0-7624440bd76d@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAEatR2oC/3WQ20oDMRiEX6Xk2pRkc9oUEd9DiiT/wa52e9hsi
 1j67qa7vVH0JjBhZj7mv4hCQ0dFrBYXMdC5K91+V4V+WAjYpN0byQ6rFo1qvPJNlLTtvtIrnT+
 kZ6N867P2mkX1Hwbi7nPqelnPupzyO8F4K7g7BjqeKmScbaKnUtIEWS0eZ4ZWdwaO8qylliHn0
 OTgGFx+3peyPJ7SFvZ9v6zP09SbRthMHZG0Qs5kvIpWAyZQRqmUWHujbQzORddw5J8pJgBSOij
 jdE6sFGRq2WejGtRIbDHGnBl+sQKgh2yjY0QdawApVLZ1xKYhm7xpCeKU+mOnURLHIo91xDxY9
 uNB3g6bEOWh76DM+9nWOsUB2vaf/TkVkrefblwtEFwky5QitmJ9vX4DM5AhYuMBAAA=
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
        Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783082317; l=2586;
 i=krishna.chundru@oss.qualcomm.com; s=20230907; h=from:subject:message-id;
 bh=S8MYJ0Gty39K24ANe2kgww56Fg/Is+/uFYmYQKcyo1g=;
 b=eCnlEQQS/VPL+DBFFcnPgXI1ANDDRlsdaedBLxzYzGkRRCOvQ9Dh8rNik+0bkwNwbholgkcqO
 t4Q6+2fXqWVAo+j5d7BQK15YusyNeHniPLgw90lI9ICt6SYyWbaW/AJ
X-Developer-Key: i=krishna.chundru@oss.qualcomm.com; a=ed25519;
 pk=10CL2pdAKFyzyOHbfSWHCD0X0my7CXxj8gJScmn1FAg=
X-Proofpoint-GUID: m66VNyNRFxCokoCKHD4wRx4JcyTyX46z
X-Authority-Analysis: v=2.4 cv=Bb7oFLt2 c=1 sm=1 tr=0 ts=6a47ad54 cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=Fm6EAR0vVewXWd2bb8wA:9 a=QEXdDO2ut3YA:10
 a=_Vgx9l1VpLgwpw_dHYaR:22
X-Proofpoint-ORIG-GUID: m66VNyNRFxCokoCKHD4wRx4JcyTyX46z
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAzMDEyNCBTYWx0ZWRfXz9YXXZMwzJsJ
 jJlqzimrPREGalfLd/dwPVg04qcTnW8rTFl896OJRGI0EIFdFxpvSEKvJM5dPbY/2CDKbIZLlNv
 qBLt13vcHhYkMrmfrp/5zxeC5c9wwIMiFdOZhhCqdZZzTR4ZW9g7wOS57h3hPiTNqH1VDs4cejQ
 tMcSy0MjZmvmOdTSz3PnqOzkwceK1uxE0wMYPbLwbqxgi1So91yqC/qFrFR1/AjG10rviAbBlaM
 3LTUc1piEtCLSYz+wBh25hwuxUD962bANvBPJdatr4JPtA+CGfCAOkam6Mj3GfhnWVQIoUSGw43
 8d8nK/5SYcm1ALQQ3eAkuD8sJjaBrixcEyn44O2eIoyi5iPcQAw7eByfJHKdAOOygw4MmnaFUfl
 3gtQpiGjjkHPO4NJnMikn8XvESyIIsb0ngVESqEYEmVu/TvLU5/KRDHvu/tzAfO80Zxfw7Kk/2N
 TYuc1xiE9FUgm7yBGWw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAzMDEyNCBTYWx0ZWRfXxz8fs5Wnp4Zk
 jG/EwHgHtjIxYs9dLXWFRDo3Ts5K6M8UVrjkw6Gs56USr+FBT8j+9AmOPiRVSVBLA1jNwjA3+su
 yfQ0vrxUpGV9EfvL0Z09u9YVWpWOSUc=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-03_02,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 clxscore=1015 impostorscore=0 suspectscore=0
 phishscore=0 adultscore=0 priorityscore=1501 bulkscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607030124

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
Krishna Chaitanya Chundru (3):
      arm64: dts: qcom: eliza-evk: Add PCIe0 with M.2 E key connector
      arm64: dts: qcom: eliza-evk: Add PCIe1 with TC9563 PCIe switch
      power: sequencing: pwrseq-pcie-m2: Add QCC2072 BT PCI device ID

 arch/arm64/boot/dts/qcom/eliza-evk.dtsi   | 283 ++++++++++++++++++++++++++++++
 arch/arm64/boot/dts/qcom/eliza.dtsi       |   1 +
 drivers/power/sequencing/pwrseq-pcie-m2.c |   2 +
 3 files changed, 286 insertions(+)
---
base-commit: dc59e4fea9d83f03bad6bddf3fa2e52491777482
change-id: 20260629-eliza_evk-6f30686b161f
prerequisite-message-id: <20260610-eliza_dt-v1-1-7bb72b75fc5b@oss.qualcomm.com>
prerequisite-patch-id: b6c6123bc2cb3a5e6c309c1cfcca80f7f950d390
prerequisite-patch-id: 9e10dfbe360941cdac0300aaf163149755952f9f
prerequisite-patch-id: fecce0170351baf00cbe8f6b302d1def4d99bbfc
prerequisite-patch-id: 97cd6cb495fdd198f6de7fbe45ef32e4a638ec9c
prerequisite-message-id: <20260630-dts-qcom-eliza-mtp-evk-add-pmics-v1-1-f4f320f7c88b@oss.qualcomm.com>
prerequisite-patch-id: f3615b5c1e2222a2491f862a7fba3994058ecc53

Best regards,
--  
Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>

