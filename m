Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50E1B32D438
	for <linux-pci@vger.kernel.org>; Sun,  1 Mar 2026 08:36:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772354167; cv=none; b=LZ0KV3UoYCM/fHUycJ3UU10/1uvKG/YgcOwEoan2b4RcmEKdctYmGsbvCE6p3y34aXlb2yV+rOBZWyjx9bMke/XKKuU7YIZgBEqeJehddGvZ5+SxbtyiBo09bK/kKs/6BrbUc0C2OxxZrt/E1IgMTHrmOOyFXmHUfhSVA3yt/Sw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772354167; c=relaxed/simple;
	bh=H6nPK0TK5n+SrUMyTi0tJArgcayT5+iAOxNLWT6jD+I=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=U8cRS60R4d4Wo/FNWdZkxees3TJ5RrlmbI1ulRL7MJZ43CDpOK000swFuJaeOdF4HbR7g695xgdZ9zRvVceXHObGPvWxLiIpq9dlZrSRJWi4yzAp7reOrdboTq8PtoXjEVZDTWIoC/3ER5r+EF7gF15UvXnYTvh9l/qM2cvpyfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Soibzn4N; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=hV49jt0B; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Soibzn4N";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="hV49jt0B"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61SMt1Xk2907742
	for <linux-pci@vger.kernel.org>; Sun, 1 Mar 2026 08:36:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=h/J87S3x56AlWUvhsWA468
	cx/T1N6JOg3YVREGRvJqA=; b=Soibzn4N/ZkM5J3qoqIornB47kjVSoW4OSYFdA
	JxHI+jCEFG5AvcKA6uqJnh2JesMWopy+nx3HDqBpTUvNGDuFejcPfcLe9Wzv31dL
	lZmPlWfTua+C1ln4pDhPH3wO0uF/KAKlbaurOU0Lyvb/HT3LlRYDU5RicRjeIINR
	QpXTC9yyk0HMnRkljCIyNpxDx3575VsDL+yiy4jgj2xHmPPD5HbYk9UXvz0mnraL
	sorBjyjDTyJXLHZLUZX9b2mC5nbJ0Wy1mT6ghkzAsD2FR+BQU64qTD44WcqMK0f9
	o5vQEB9V06sSulMdm2F48Z6RTI7ze1Qmdf4VUiOntKatRtgg==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cksn42egy-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Sun, 01 Mar 2026 08:36:05 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-c6e24ee93a6so2482970a12.0
        for <linux-pci@vger.kernel.org>; Sun, 01 Mar 2026 00:36:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1772354165; x=1772958965; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=h/J87S3x56AlWUvhsWA468cx/T1N6JOg3YVREGRvJqA=;
        b=hV49jt0BHaObO9vwHhtjmEzLeB3NhILOEYGTEs9LtTWb8+39jp2lgwT0bJm6DnOT+e
         i8IGfzRanmOJdb73lVqy41cDYc5Os1TFX2LXIzJ5CgcmRAb1ZLTce39KD9uJD+6oAXSh
         0ZUethJyMCHf/KxHItaQlOLn7SRLWWmgGr6XLY3j+exWCPxepsQ0EXRvMMw71NVBods3
         HRjpmkGa29zvIso6eaO0N9yGHbIvgcCwc7K8fMH0IwsDD1A+VXB5/BVHmV7o6tNCthCw
         26eSOHl1xAJYhBqfZpKSaDon7d5sdVCPMwIiZMwlYbfd2ZKndRF36y9Coxic3148ucV7
         GlZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772354165; x=1772958965;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h/J87S3x56AlWUvhsWA468cx/T1N6JOg3YVREGRvJqA=;
        b=nZL9sZqwEEz/kg8JufMG+SgikkQ0S9NGz2stR1RLR4poZzZLZcWiTzq+Ze9hRKR5Qo
         br40xQgR4RrEo3gg8rlVmsiDIaKAbV50pyqxqkyoj9SaRw0j/8Lf4OA9bhLmwG9SF+on
         1Z8+nMYJAF2U5gCiHW/8LQpsAS5hFY7imzkVrpXFLvo7sx/eMBYHl+T29njwjh3yVIl9
         ofp78NAWs+7yRrPXCVjQET3xOHwRD2iQdv6+GFGgfVY9TxGRfNg+n6khc+3nnPyENlO1
         YUw+yPHAoGT6zhUnnXjLt+vr2E6o8lUoc+7G872cjo9RJdO86UIkhGtiRqA5g8I6P8Qr
         3ZEg==
X-Forwarded-Encrypted: i=1; AJvYcCUVIFBKLSH/SrqavFbyFikMeLDupHmOEntWSrw9c5NDGibUjo1XkeYyHigyxixd0vF9NIHjxinEXx8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyTWdiFetz5cKqf00TfLQ309xlyXCmaX++N0y6zOhXTGdMVYfPW
	7O8HX4ILgzdWZU+0ZCHc37wUUhFmGUcxIG4jjHdgMj6zwQig8WqkxDDsn9eCkbCdfB/erzlBRar
	yBTBS2nO12Rxnjvvhw03uBsZUfsDfxN1vdkMYd5YhtTe/eHHgQwUoYGmaXmDH9NM=
X-Gm-Gg: ATEYQzwLm9BwtpsokdydYqayJ8kd135gVwM+Vh7xTAFEdYutD8gkVsN5/e2Wc8cR5u8
	0ndC9ge4Z+k2W4BO/Bb4SgaCBjcZd77CIDmhvCQTpXIIuGX5zqCX1MK2Wtyv9kcUeqbSQM/6Y4D
	TJpOQ8R2gR/EA+9vqgcvMgC1woLuZmpp7vYXiYqhf6U9jG5dGjDTNHk9xkFNIES17S3I8MCr4nJ
	rDFIL851Hu14duZmY1LvxjTqe97LlqAlbf0o6C56FYj67UW7BCD4R2adtf2BYNFwyDhwa8PZIPR
	sUt9gtHcVD2/I77Uo/1zjHtJHqVf/ZAXacJeDX325R6IwiC9D7gMsn7E8LsWWvfV8dzxNekeBXu
	ltg9oARxTfXyR7afI0owHMVo6xRgu9w+5sXsds2prA+KNjt/YKYvOVmid
X-Received: by 2002:a05:6a00:1d14:b0:823:1444:7873 with SMTP id d2e1a72fcca58-827398630afmr9488158b3a.32.1772354164692;
        Sun, 01 Mar 2026 00:36:04 -0800 (PST)
X-Received: by 2002:a05:6a00:1d14:b0:823:1444:7873 with SMTP id d2e1a72fcca58-827398630afmr9488110b3a.32.1772354164035;
        Sun, 01 Mar 2026 00:36:04 -0800 (PST)
Received: from hu-vjitta-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c70fa82dd09sm9177300a12.28.2026.03.01.00.35.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Mar 2026 00:36:03 -0800 (PST)
From: Vijayanand Jitta <vijayanand.jitta@oss.qualcomm.com>
Subject: [PATCH v9 0/3] of: parsing of multi #{iommu,msi}-cells in maps
Date: Sun, 01 Mar 2026 14:04:18 +0530
Message-Id: <20260301-parse_iommu_cells-v9-0-4d1bceecc5e1@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAr6o2kC/x3MTQqAIBBA4avErBM0ob+rRIjZVANq4VAE0d2Tl
 t/ivQcYEyFDXzyQ8CKmPWZ0ZQFus3FFQXM2VLKqpZZKHDYxGtpDOI1D71kop3VTtxanyULujoQ
 L3f9zGN/3A61zjrxjAAAA
To: Nipun Gupta <nipun.gupta@amd.com>, Nikhil Agarwal <nikhil.agarwal@amd.com>,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>, Marc Zyngier <maz@kernel.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Thomas Gleixner <tglx@kernel.org>, Rob Herring <robh@kernel.org>,
        Saravana Kannan <saravanak@kernel.org>,
        Richard Zhu <hongxing.zhu@nxp.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>, Frank Li <Frank.Li@nxp.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>, Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>,
        Rob Herring <robh@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Prakash Gupta <prakash.gupta@oss.qualcomm.com>,
        Vikash Garodia <vikash.garodia@oss.qualcomm.com>
Cc: linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-pci@vger.kernel.org, imx@lists.linux.dev,
        xen-devel@lists.xenproject.org,
        Vijayanand Jitta <vijayanand.jitta@oss.qualcomm.com>,
        linux-arm-msm@vger.kernel.org,
        Charan Teja Kalla <charan.kalla@oss.qualcomm.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1772354153; l=4172;
 i=vijayanand.jitta@oss.qualcomm.com; s=20260301; h=from:subject:message-id;
 bh=H6nPK0TK5n+SrUMyTi0tJArgcayT5+iAOxNLWT6jD+I=;
 b=0138PH3DyBpH6CTf5Gshrd2F5CdUzVc0F0MxX4wX0mhvTjGvGhC4k9OE5ekOV5Mibl6bnxqrt
 Gf0jdcWnaG7Anf+I2c3nVSolMIhssmbuOeaTts0urN2JZSagf5VqNQT
X-Developer-Key: i=vijayanand.jitta@oss.qualcomm.com; a=ed25519;
 pk=Lpi7Cs3wHe8KZtqvyci7FTOLzsKpEHKGCaPNZw+1zRI=
X-Authority-Analysis: v=2.4 cv=Tq3rRTXh c=1 sm=1 tr=0 ts=69a3fa75 cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=VwQbUJbxAAAA:8 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8 a=NEAV23lmAAAA:8
 a=hUMMoPFcHhpVZiwYRzIA:9 a=QEXdDO2ut3YA:10 a=_Vgx9l1VpLgwpw_dHYaR:22
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: Dzyc5efDMlnN_Ua8WCQDm87J-ercvyUo
X-Proofpoint-GUID: Dzyc5efDMlnN_Ua8WCQDm87J-ercvyUo
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzAxMDA3NiBTYWx0ZWRfX3lJzaFMLRtw0
 zjnQjoayjMaC3ajZqiZU9ty4Ve7G5RQPs2mXQS3k/uqVG8guNHCQn7ZzjAIEjoeq8tUtz+rI3su
 bdTGwX4gEeN7TgbSKEkEQ4vGOA3aEr3tsgGOPcKaPDx1l3qXPrjlKAFqWEau5K3zIkDHZImgdTf
 dZtIClB2EpAHpxLU15gpXUlx9/CxWhIveMcxX4QM8Aobfz6Oi6DsuBZapYy2ZEcOqSs2gbTdbi7
 +W4PVdrfKqH74OSrdQNx7s5CZToxRW+jlC+4yH7MaTixnpu7+oes1qvMNC1zg5Me2e1u5Wh033i
 gmoNYyHh1aKckNYC9j24uROYG/m/RXb84rohY+XE3vqavn6VZIqmlGxAnTIUgBnz+fk91eAnz7x
 MHCQ8w8/2y7z9UmiZVVu6Ytw3M/DF3vGYT9ehtYTqgZnyh9cpvv0KBwImTeXPalZosXLdQy8Elw
 NUkD+HaRhglTDVcQkew==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-01_01,2026-02-27_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 bulkscore=0 suspectscore=0 impostorscore=0 lowpriorityscore=0
 adultscore=0 priorityscore=1501 malwarescore=0 phishscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603010076

So far our parsing of {iommu,msi}-map properites has always blindly
assumed that the output specifiers will always have exactly 1 cell.
This typically does happen to be the case, but is not actually enforced
(and the PCI msi-map binding even explicitly states support for 0 or 1
cells) - as a result we've now ended up with dodgy DTs out in the field
which depend on this behaviour to map a 1-cell specifier for a 2-cell
provider, despite that being bogus per the bindings themselves.

Since there is some potential use[1] in being able to map at least
single input IDs to multi-cell output specifiers (and properly support
0-cell outputs as well), add support for properly parsing and using the
target nodes' #cells values, albeit with the unfortunate complication of
still having to work around expectations of the old behaviour too.
							-- Robin.

Unlike single #{}-cell, it is complex to establish a linear relation
between input 'id' and output specifier for multi-cell properties, thus
it is always expected that len never going to be > 1. 

These changes have been tested on QEMU for the arm64 architecture.

[1] https://lore.kernel.org/all/20250627-video_cb-v3-0-51e18c0ffbce@quicinc.com/

V9:
  - Updated TO/CC list based on feedback to include all relevant
    maintainers.
  - No functional changes to the patches themselves.

  Link to V8:
  https://lore.kernel.org/all/20260226074245.3098486-1-vijayanand.jitta@oss.qualcomm.com/

V8:
  - Removed mentions of of_map_args from commit message to match code.

  Link to V7:
  https://lore.kernel.org/all/20260210101157.2145113-1-vijayanand.jitta@oss.qualcomm.com/

V7:
  - Removed of_map_id_args structure and replaced it with
    of_phandle_args as suggested by Dmitry.

  Link to V6:
  https://lore.kernel.org/all/20260121055400.937856-1-vijayanand.jitta@oss.qualcomm.com/

V6:
  - Fixed build error reported by kernel test bot.

  Link to V5:
  https://lore.kernel.org/all/20260118181125.1436036-1-vijayanand.jitta@oss.qualcomm.com/

V5:
  - Fixed Build Warnings.
  - Raised PR for iommu-map dtschema: https://github.com/devicetree-org/dt-schema/pull/184

  Link to V4:
  https://lore.kernel.org/all/20251231114257.2382820-1-vijayanand.jitta@oss.qualcomm.com/

V4:
  - Added Reviewed-by tag.
  - Resolved warnings reported by kernel test bot, minor code
    reorganization.

  Link to V3:
  https://lore.kernel.org/all/20251221213602.2413124-1-vijayanand.jitta@oss.qualcomm.com/

V3:
  - Added Reviewed-by tag.
  - Updated of_map_id_args struct as a wrapper to of_phandle_args and
    added comment description as suggested by Rob Herring.

  Link to V2:
  https://lore.kernel.org/all/20251204095530.8627-1-vijayanand.jitta@oss.qualcomm.com/

V2:
  - Incorporated the patches from Robin that does the clean implementation.
  - Dropped the patches the were adding multi-map support from this series
    as suggested.

V1:
 https://lore.kernel.org/all/cover.1762235099.git.charan.kalla@oss.qualcomm.com/

RFC:
 https://lore.kernel.org/all/20250928171718.436440-1-charan.kalla@oss.qualcomm.com/#r

Signed-off-by: Vijayanand Jitta <vijayanand.jitta@oss.qualcomm.com>
---
Charan Teja Kalla (1):
      of: factor arguments passed to of_map_id() into a struct

Robin Murphy (2):
      of: Add convenience wrappers for of_map_id()
      of: Respect #{iommu,msi}-cells in maps

 drivers/cdx/cdx_msi.c                    |   3 +-
 drivers/iommu/of_iommu.c                 |   6 +-
 drivers/irqchip/irq-gic-its-msi-parent.c |   2 +-
 drivers/of/base.c                        | 148 ++++++++++++++++++++++---------
 drivers/of/irq.c                         |   3 +-
 drivers/pci/controller/dwc/pci-imx6.c    |  12 ++-
 drivers/pci/controller/pcie-apple.c      |   5 +-
 drivers/xen/grant-dma-ops.c              |   3 +-
 include/linux/of.h                       |  33 +++++--
 9 files changed, 152 insertions(+), 63 deletions(-)
---
base-commit: 3fa5e5702a82d259897bd7e209469bc06368bf31
change-id: 20260301-parse_iommu_cells-1c33768aebba

Best regards,
-- 
Vijayanand Jitta <vijayanand.jitta@oss.qualcomm.com>

