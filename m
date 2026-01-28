Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F1872D73BD
	for <linux-pci@vger.kernel.org>; Wed, 28 Jan 2026 15:37:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769614657; cv=none; b=F1yAAtrCqvxN5F74YTy+LZMNfaniQFVSVS1vXmhP/wVQw/Zd955TjCgOiBf/l9/g13dAvdLy1K+/xcBj5w0n1eTYhTNsTD2LHWc8SUNenu7/r7s13mmrQPj7IP3V6NtW2aXNOcDvDzTmCFsCPLj2XCp8BAgwEe9CSbdu0NBBWlo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769614657; c=relaxed/simple;
	bh=e1WlYNh/pWVhKWNbh57QlsP4+dugrRMX3BWGXRpt2XQ=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=PJQt+YD1974fskNVrU82zvRc9dnbxKfGRyywlGm+DbeYmMf1SLlf5BQuQYn1vB/ddDW1JthMpOnoJaANaJHbyhimlBDrdILJ3NwcRN44WKw3ifhb9Chzqn7rsBd1SBQtXCyIaLXF5s571Z7YR4xRE+sf1cDF3b84F+TVZmhRmAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=jp2MGAnB; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=P1n8btmI; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="jp2MGAnB";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="P1n8btmI"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60SFaWTR3907679
	for <linux-pci@vger.kernel.org>; Wed, 28 Jan 2026 15:37:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=RtA0w/6aYVlp3RcomiX/gy
	KSJAyCmccZBEyOuoTT2xw=; b=jp2MGAnBpwwQSBom/fUk10u8MM3Cn2Ptdi7a7H
	tVACyIPHWY7WLJa5sZPd6QfT4dRAOT0iGzsKNc0/TtC+g9Imuh7hX53JaYuBy+PZ
	fzgPfF/wW9Lvm1KfkFvxqRAAQ2MJntZefx10Rls+JcTF9MUGG1ol/RVYen41r7PK
	zipZwRAi9DAyZhOehKX79qcrUrS8BiQCyvWR4Sg31JD5blr/PWTaV9oTLs9KfVHM
	z/58p9qKFqxsGPJsaOKbWrkdJnGpgPQahdi870902qpV3A+nbvmjDAGN15gpOy9F
	ZV8lsmjD7ZI0OMfsCPopZpTM9aIFLOqrxNL1ZkxbX93GMEpQ==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4by0g0cg3h-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Wed, 28 Jan 2026 15:37:34 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2a0f4822f77so162780105ad.2
        for <linux-pci@vger.kernel.org>; Wed, 28 Jan 2026 07:37:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1769614653; x=1770219453; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=RtA0w/6aYVlp3RcomiX/gyKSJAyCmccZBEyOuoTT2xw=;
        b=P1n8btmIM/2etA6TXc9W9CdvYApGr5ipa4GaLDG3untW9KCFOwnVHUr5YAv/3urXuN
         2thqLJ7sAKXX4Q4/+M54nLaK1bXgHlGoh1GWSYBV2AoT/4RV51eNTsZwAeL+HytGYIpQ
         yIdDv2a6mop02usXUPSf1GoueqXD72bmKSNF0KVMdwwxUPWv3WSbsqv9+lSZ8QU8vrLw
         lrdkv+vdrWaEMuKiSZ6jusUlvmmuj3NoDU4BHROO+OPwie9P8pm4XrNEed+nnuzROm4z
         b5rs1rrteCp/PJDKSEy7J/tfg/X+UQZlOyGpNBo97zo0dbmbjyGpfOeUrolDn9xdA9Ok
         vVKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769614653; x=1770219453;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RtA0w/6aYVlp3RcomiX/gyKSJAyCmccZBEyOuoTT2xw=;
        b=GU+qV2F5tFrkioZ/vrBh2OEpbZbL6oqlg8oowzKiOOTVhBKFy4yy1QWN+bqklKOrKm
         2Bz2gTqCWf2ACtAYdHJBVbNZHPiwHFU+fp3TfA/Z2/pCsByslfoUAIonasbjA2J5XGcS
         Y2oCrCScYbzi724H4GlwHlG8/zVHHOxt3rn91LKm43YVWXDJoRoWBjXm7x1uywh7xKgs
         fe6oWh+B4EtN+iPDgv2Dlwu9syF6LUXHnHjPPWQ1O1vAEVKuFaTeUb1GGoy6J2vXHbYG
         FGkBWj9JHdqoME06f0U++td+/MdIgqNqXZmPEbovmOLX+aSzgBbIwqj8+XPwO14R0zXY
         clFg==
X-Forwarded-Encrypted: i=1; AJvYcCXkbJDWqoS9TPcJs0lqXPUyr61PR7PIqL1geMuZwXY4vXB9nnGkK/cxSbO0k6ba56ucKSpLTgM35fE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxlnJ8+iyuqMAFTq0h/OMgwTMEUU7CpS+gKicJF3g21CXvv5jrM
	CvP3EVl4U79V5UMIBNaBVrWCNNvyX47kuiywKxJXgtozTvNkWizFPv3NDgaJIyld9a3ycKBR/5n
	wBC++Rm8Vq87clzngXl4z21/gUA2+K1Uv3eD0eg4Yq4GBe8cuGVfGbyZkkfAcNj4=
X-Gm-Gg: AZuq6aLeQX8z5RAdb+w6L3GIlmZHNU4XHrqEvqf6xVkwAt6sX5f0vjhzoyqF9MsbJ4q
	JPtQhLwZ8ZDz4Od+Q4JwRjRtS2E1dtv5Ac+rfOAtlaLsXMPwp0QN5qKw7RO6TKm3lL95Yc/CbZ/
	k/evDINpqUZq0P9qymnk4JeoiVc0g/jlc/lzLIMV+OHPN2bdOx8Z9hGyDh+L2Pcb3CMy7xGuwbQ
	JLuKplAfFF34OLxAYO267WLARBMKOno6jd1yYu5LUrL8GWZ4/HsOFaXB1ofD4JXCt6SERaAJ5T8
	ehNAmB2xbwjGyc1wrruIIeGkBLYtomYo4ZHEGQlOa96FVPrFdOg3Fy7KegWyb4Kkcyfp8MhzZok
	fWUD6g+y4G/2DOS1irLS7gAcgyFq9ro2QNNgxjA==
X-Received: by 2002:a17:902:c94f:b0:2a7:8088:371a with SMTP id d9443c01a7336-2a870dcba31mr65551935ad.35.1769614653081;
        Wed, 28 Jan 2026 07:37:33 -0800 (PST)
X-Received: by 2002:a17:902:c94f:b0:2a7:8088:371a with SMTP id d9443c01a7336-2a870dcba31mr65551325ad.35.1769614652459;
        Wed, 28 Jan 2026 07:37:32 -0800 (PST)
Received: from [192.168.1.102] ([120.60.55.34])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a88b3ee98fsm26371725ad.9.2026.01.28.07.37.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jan 2026 07:37:31 -0800 (PST)
From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
Subject: [PATCH v7 0/2] PCI: Add initial support for handling PCIe M.2
 connectors in devicetree
Date: Wed, 28 Jan 2026 21:07:14 +0530
Message-Id: <20260128-pci-m2-v7-0-9b3a5fe3d244@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIACotemkC/3XRyWrDMBAG4FcJOldGGq3Oqe9RetDaCOo4kRzTE
 vLulRO8HOqLYMR8/zDMHZWQUyjoeLijHMZUUn+uhXo7IHcy56+Ak681AgKCUsLwxSXcAVaSMcm
 oldEYVJsvOcT08wz6+Kz1KZWhz7/P3JFOv3OEmCNGignW3IpIIw0i6Pe+lOZ6M9+u77qmPmhKG
 mGr9aKh6qCt417ZyMHvaLbRsM5mVTsBmnAwwXC1o/mqAdbZvGohNddSW+JF3NFi1pJQohYtpr2
 pYl4bBZLTHS03GmDRcpqthDdtbBWw9h/9eB0kh+utHnR4XQVZUwKemtJwPIyyoS3Ojtbuxx+ds
 lndBgIAAA==
X-Change-ID: 20251103-pci-m2-7633631b6faa
To: Bjorn Helgaas <bhelgaas@google.com>,
        Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Damien Le Moal <dlemoal@kernel.org>, Niklas Cassel <cassel@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Stephan Gerhold <stephan.gerhold@linaro.org>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        linux-pm@vger.kernel.org, linux-ide@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=4206;
 i=manivannan.sadhasivam@oss.qualcomm.com; h=from:subject:message-id;
 bh=e1WlYNh/pWVhKWNbh57QlsP4+dugrRMX3BWGXRpt2XQ=;
 b=owEBbQGS/pANAwAKAVWfEeb+kc71AcsmYgBpei01TD+kPaUdeJGX5+hxzxq0t+gqOlI2EMd+K
 vD1QWGvmlaJATMEAAEKAB0WIQRnpUMqgUjL2KRYJ5dVnxHm/pHO9QUCaXotNQAKCRBVnxHm/pHO
 9TW+B/wM4zWirrq+IsxkDIeZc0omOwTANPU5mVymtb70UEiUMpeIpJ5bG0R/qMtVd5eVztH5Gp7
 qfhnCI90sPS1N10iIKvIUIQF3YO2n95g9W+mGF++cNiQduGrFnoUVxbMT86EQKHegj3C0SinbIA
 CXdFrGjeFYt8/UQsb/tnPBpnP9WIS/id5P9yiCjpYednJFoErCokTIcjntIMxqpZodKSOzdbTLg
 Sq8i90audchHqPvXx2wbgZP4I231ouG1CEonVibWPV+2vOf/Mb1z0sahEEvWMEXsLAY0wUvW9RO
 9+ULvwaL6G3O+vMPqyNodBIP4yMUAJFO0WRKUIvKOyTZPX32
X-Developer-Key: i=manivannan.sadhasivam@oss.qualcomm.com; a=openpgp;
 fpr=C668AEC3C3188E4C611465E7488550E901166008
X-Proofpoint-ORIG-GUID: hGG181opd4xEjRxHu9GHMBoPFaTLj7Sc
X-Proofpoint-GUID: hGG181opd4xEjRxHu9GHMBoPFaTLj7Sc
X-Authority-Analysis: v=2.4 cv=UPXQ3Sfy c=1 sm=1 tr=0 ts=697a2d3e cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=F3mjE3T3/ow0zpRzCzjSvA==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=NEAV23lmAAAA:8 a=EUspDBNiAAAA:8
 a=otkVNQseMVp4AOM4PXIA:9 a=QEXdDO2ut3YA:10 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTI4MDEyOCBTYWx0ZWRfX/gtf1fdoviwX
 6AXjTInJlTa7sxXqfHWI5jyV/DOzhqwM55naZzlzRf+KBEDLRDX+0KkSMEWyTwvXO3mqyioFUAL
 lv59CNUtHoLg4oKoauafZpVHPhReJt9vuMsVptPBi9wVhJHxxT1Q3sQuN2sXbvqKHcsPVriF2NX
 961va0008nCLoMJQ36/Ehf+xMldeNVb7wVU+rpp51788k0k5nQwOFjZDtdymVe/5J01UYSWzb6Y
 oLhOrLFvl5U7Ld64YmKlogW+4EoLDDDTcuLcloriiWRaCsqnkCGgIZQmO/UA9MUqnCgZYIU099y
 rDOL62n038BQblRsOHwuwH0w4ZsdPR+ZnXM0WQO4Lp+cMEiLFmdOQsP0pCGhSXj6ieY7BG6GA2X
 hgYF3OeC/yXON63U3xtO8AihYT21pE286dzQdcMjbcdzKa2c+75s2AF/XFVVkq6ykZmdyqFh8mU
 kWqTjxW8hhh8Fwb2tKg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-01-28_03,2026-01-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 clxscore=1015 priorityscore=1501
 suspectscore=0 spamscore=0 adultscore=0 impostorscore=0 bulkscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2601280128

Hi,

This series is an initial attempt to support the PCIe M.2 connectors in the
kernel and devicetree binding. The PCIe M.2 connectors as defined in the PCI
Express M.2 Specification are widely used in Notebooks/Tablet form factors (even
in PCs). On the ACPI platforms, power to these connectors are mostly handled by
the firmware/BIOS and the kernel never bothered to directly power manage them as
like other PCIe connectors. But on the devicetree platforms, the kernel needs to
power manage these connectors with the help of the devicetree description. But
so far, there is no proper representation of the M.2 connectors in devicetree
binding. This forced the developers to fake the M.2 connectors as PMU nodes [1]
and fixed regulators in devicetree.

So to properly support the M.2 connectors in devicetree platforms, this series
introduces the devicetree binding for Mechanical Key M connector as an example
and also the corresponding pwrseq driver and PCI changes in kernel to driver the
connector.

The Mechanical Key M connector is used to connect SSDs to the host machine over
PCIe/SATA interfaces. Due to the hardware constraints, this series only adds
support for driving the PCIe interface of the connector in the kernel.

Also, the optional interfaces supported by the Key M connectors are not
supported in the driver and left for the future enhancements.

Testing
=======

This series, together with the devicetree changes [2] [3] were tested on the
Qualcomm X1e based Lenovo Thinkpad T14s Laptop which has the NVMe SSD connected
over PCIe.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/arch/arm64/boot/dts/qcom/x1e80100-qcp.dts?h=v6.18-rc4&id=d09ab685a8f51ba412d37305ea62628a01cbea57
[2] https://github.com/Mani-Sadhasivam/linux/commit/40120d02219f34d2040ffa6328f0d406b1e4c04d
[3] https://github.com/Mani-Sadhasivam/linux/commit/ff6c3075836cc794a3700b0ec6a4a9eb21d14c6f

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
---
Changes in v7:
- Dropped the pwrseq and binding patches as they got applied
- Rebased on top of pci/pwrctrl branch
- Link to v6: https://lore.kernel.org/r/20260122-pci-m2-v6-0-575da9f97239@oss.qualcomm.com

Changes in v6:
- Used 'ports' to describe interfaces instead of endpoints in the binding
- Added GPIOs and USB to the example in binding
- Incorporated minor comments in the pwrseq driver
- Dropped the ata binding patch as it got applied
- Link to v5: https://lore.kernel.org/r/20260107-pci-m2-v5-0-8173d8a72641@oss.qualcomm.com

Changes in v5:
- used of_node_get() and devm_action to free regulators
- Link to v4: https://lore.kernel.org/r/20251228-pci-m2-v4-0-5684868b0d5f@oss.qualcomm.com

Changes in v4:
- Added graph property to SATA in this series and PCI to dtschema:
  https://github.com/devicetree-org/dt-schema/pull/180
- Used 'i2c-parent' instead of SMBus port
- Reworded the -gpios property description
- Rebased on top of v6.19-rc1
- Link to v3: https://lore.kernel.org/r/20251125-pci-m2-v3-0-c528042aea47@oss.qualcomm.com

Changes in v3:
- Changed the VIO supply name as per dtschema
- Added explicit endpoint properties to port 0 node for host I/F
- Used scope based cleanup for OF node in pwrseq driver
- Collected review tags
- Link to v2: https://lore.kernel.org/r/20251108-pci-m2-v2-0-e8bc4d7bf42d@oss.qualcomm.com

Changes in v2:
- Incorporated comments from Bartosz and Frank for pwrseq and dt-binding
  patches, especially adding the pwrseq match() code.
- Link to v1: https://lore.kernel.org/r/20251105-pci-m2-v1-0-84b5f1f1e5e8@oss.qualcomm.com

---
Manivannan Sadhasivam (2):
      PCI/pwrctrl: Add support for handling PCIe M.2 connectors
      PCI/pwrctrl: Create pwrctrl device if the graph port is found

 drivers/pci/pwrctrl/Kconfig |  1 +
 drivers/pci/pwrctrl/core.c  |  7 ++++---
 drivers/pci/pwrctrl/slot.c  | 31 +++++++++++++++++++++++++++----
 3 files changed, 32 insertions(+), 7 deletions(-)
---
base-commit: 3e7f562e20ee87a25e104ef4fce557d39d62fa85
change-id: 20251103-pci-m2-7633631b6faa

Best regards,
-- 
Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>

