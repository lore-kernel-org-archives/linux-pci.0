Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 017A23AFD0D
	for <linux-pci@vger.kernel.org>; Thu,  9 Jul 2026 06:35:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783578935; cv=none; b=M1qo7khgngf9xzTx6KzX0xbZoa1qGGqCGnAWnyNjMvR/UfsE+tEEnICGuJmsLMo+lTUsj8gPvZguotcat9+zij5qTGVPnPHoomrdIzV5+k/4V+FPOIz4if/BWx6z8/DOYV8klfE2KCshWQLJd8bdTDqPfDLvKfYXs93BxQjY/JA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783578935; c=relaxed/simple;
	bh=sF+5+mlvT40t4Oa7kCgpbppxkmIb7GFh+GBtlhUHWg0=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=bsNI7UL53ib1iM4h/pUrojlgopXVlQdRPjzZT5ZIeZrzfQlizkN604mx3OPfrkE+W+G9mEd/KsBYF6/nOJbvVG4Q8KkNMLZCgn2kAJa/YFuWxRiBF6pJDjTev6PZ9YOIHjgYvha7OMpiiLQU62a3WoAGqHJI141g4jGeV0F+lJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=bmslssIa; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=YY+NvwZ3; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="bmslssIa";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="YY+NvwZ3"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 669603vN794145
	for <linux-pci@vger.kernel.org>; Thu, 9 Jul 2026 06:35:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=VWOut9Y+gjUFIHIxTYgSGy
	NQ1g4rRooiLUtEV7k3qB4=; b=bmslssIawUWwwQYrjm4vV5J6Jbd++0vXyO4tuX
	K1NsLSUDti/yC4Xr3wSVUwD4c8KLevWZPkYsW03qsoH01zAMIBkixNJMR/CGg6Ap
	TNNk1tG+dx8+6ABSyYhcx66+EzQbCo1ExqrUSmR8gRQuxLvAsZU3cR/F7uhLmAHC
	oal5KLU0xUoaVJPM7qDfe9zWeLEmxEDYZzGr2eR3oyOxdI5YZQfkjJlpnKcS0chW
	O3a1zostOgz6zUth5+QwMkxacYVA+68YWiissBGEJxmNeL08nU2G6KxbH5UkS8KJ
	Gcg1Fv4tAshS2TScvOQ8tCd3HnJIb6S1wx3ATK4jXTL+o1Pg==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fa1yds1b0-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Thu, 09 Jul 2026 06:35:33 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-ca124bf0189so503742a12.0
        for <linux-pci@vger.kernel.org>; Wed, 08 Jul 2026 23:35:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783578932; x=1784183732; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=VWOut9Y+gjUFIHIxTYgSGyNQ1g4rRooiLUtEV7k3qB4=;
        b=YY+NvwZ3lLCkfOyHIsIKGev4m981G2jwA6w41MCWhGzs2TZY+sawY+PKLLLSNi1F7d
         0cMovQAsGvbP38xAS7H55qo/+ckBEsPclSOPI/7e4jfMyQn3kTlM/pwDjKHopO7IS/nk
         0cgA4LI1BCAYRrLMn2xQRejIUCaE4KF+d9CoEljpDXz5I91NgGsBu5YgDmBgBT8EhBrP
         gp12u6Kr6yYsChjcuSYhb5AYTsSVm9xImGlvGcCW/RqNfPjmN+7Rhf+kNwHJdfPilmBd
         6fxOKqzRJwasrNDyykrt77Xqj+4tHN8Ia/AU8FO/+9L2dHerKv0wbN4DI2dS04+mTjxf
         epZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783578932; x=1784183732;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=VWOut9Y+gjUFIHIxTYgSGyNQ1g4rRooiLUtEV7k3qB4=;
        b=MsSsULCvBn6+MhnZB61lWBxkYMBqQuixhayLxsuet/nARHYwbW1dilo6P3TVD7SXIF
         vqh6UFXL1eiF+tEyA03VMJ9XZ9zty1eI7tD6g8qbqBD9Gyp1ksFrGxq0gBnYsOiV7dGx
         7+UuOZ/GUz2HnDhllHlqJhHQM1t8QRwKsmtUZknWpd5bVw/LNA5O1EIBjEjoX0lBe4dr
         f1DxPWUPhBfyWfmyLqgUo55P+rYSkmbrNTbADB3uNeC0NU02lZORs3wux5YIYzeRR6bZ
         zXQL+8WGHNjd2juNMuqowxrbdsMXCNyQNp8ReJjd5mPu/09BMcwKTaY5ppDqO0wQY/Oo
         wrxA==
X-Forwarded-Encrypted: i=1; AHgh+RoWm/yZ1lLmXijNT5OdMeOrWi3VtI6qXex2PbrguparNpdIUNosRIhpvM+VUEmnq6cIyBUkhHgGToA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzFhEshKgOhrSP0DKqTI6JlYo7Ll3shDzev673H33f3w6iwxrOh
	OYGO/c0hXXka8cA+bczEW87vkc7srwiUOgdmF98HH5i4q9vT3otiANXJIvdAxZQo6yevbbkt2n9
	zeCkkfnDpfYfYKeahrAyPkAtGxFtxz9L4eMTuYA9/3pC6wmLUi6uuTA/hIyPXgEc=
X-Gm-Gg: AfdE7ck9jhTP9yL56BIWlz+WftKnYF+ucOFKmKWpiDTKaNyFzUPxHSHUub5X9wnUSbZ
	X7TiFoTrB6jgOqLl3QHPp0aWLitKIy4ZovKErNI3fxrV5hBUXlqimf2DjzzKcGFfPYrQK6FpEC1
	rEGoB23Jnc3/s6K0NKog3YJ/dqw7BRH8n93g1lTsM5XT8ByU887cYnLYqVqxoX4/CZdZPo9yGIv
	88l4goLA4FyJD9hR5qXrklGbd7s7zvMajtNTWWmWj4h2Y/O+N2lPo7OZx5LkrbH8XSvag+PMJsl
	jBW3jerBV34frsOgjNr4B7ppo79ZUxWooENhFlLsNfgA0nqdXu0CngHCuzU/p0J3AwJxupctpFm
	JuBAwdOteOjEOIyeWixzcBsTQdxxiRemXzMpKn6wRmPpjrQ==
X-Received: by 2002:a05:6a20:a10a:b0:3a0:c246:bb98 with SMTP id adf61e73a8af0-3c0d6b91578mr2421118637.29.1783578932503;
        Wed, 08 Jul 2026 23:35:32 -0700 (PDT)
X-Received: by 2002:a05:6a20:a10a:b0:3a0:c246:bb98 with SMTP id adf61e73a8af0-3c0d6b91578mr2421065637.29.1783578931952;
        Wed, 08 Jul 2026 23:35:31 -0700 (PDT)
Received: from hu-krichai-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-31174a56848sm28304294eec.16.2026.07.08.23.35.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jul 2026 23:35:31 -0700 (PDT)
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Subject: [PATCH v3 0/4] PCI: qcom: Add link retention support
Date: Thu, 09 Jul 2026 12:05:15 +0530
Message-Id: <20260709-link_retain-v3-0-81a9d187bb61@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIACNBT2oC/23OSwqDMBCA4atI1o1MYjSxq96jlOJjrKGatIkNL
 eLdG90UoZuBf2A+ZiYenUZPjslMHAbttTUxskNCmr4yN6S6jU048JwBMDpoc786nCptaMcUy0C
 WQqIg8eLhsNPvTTtfYvfaT9Z9Njywdbs6BTAod05gFKjEQirOM+hEfbLep89XNTR2HNM4yMoF/
 iNyvn8l8EiAwlYIVYNizR9iWZYvOcJmwPAAAAA=
X-Change-ID: 20251001-link_retain-f181307947e4
To: Vinod Koul <vkoul@kernel.org>, Neil Armstrong <neil.armstrong@linaro.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Jingoo Han <jingoohan1@gmail.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>,
        Abel Vesa <abel.vesa@oss.qualcomm.com>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Qiang Yu <qiang.yu@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783578926; l=3032;
 i=krishna.chundru@oss.qualcomm.com; s=20230907; h=from:subject:message-id;
 bh=sF+5+mlvT40t4Oa7kCgpbppxkmIb7GFh+GBtlhUHWg0=;
 b=4WF8KeneP5kDFrwQawQN2JEQpi2M5tVjiuO/q/KkGovSi6O5wQNu7o/BGrMJ7isY9467o2KyL
 GQouKH0G4YnBmpJvPbT8rxsoCS3EE3Prt7deLSEjjmwPAIHqfDXmQm0
X-Developer-Key: i=krishna.chundru@oss.qualcomm.com; a=ed25519;
 pk=10CL2pdAKFyzyOHbfSWHCD0X0my7CXxj8gJScmn1FAg=
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA5MDA2MCBTYWx0ZWRfXynGvMdOfaw2Y
 aoeIl4gFJh/UZgerCzewoC2B8Es5smynEB7yIvzCSEddkL5ulvFQBM+/oBChYc/uc+YnAY+T1qs
 gw58JfU8PNXeEVLW8OmqR5/fEqe7GEk=
X-Proofpoint-ORIG-GUID: deoYMBMVYFH98SHLkXrAJOZSv29DJzzc
X-Authority-Analysis: v=2.4 cv=cOLQdFeN c=1 sm=1 tr=0 ts=6a4f4135 cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=bC-a23v3AAAA:8 a=EUspDBNiAAAA:8 a=VwQbUJbxAAAA:8 a=fuwIWhs0SkhWFt5P5XoA:9
 a=QEXdDO2ut3YA:10 a=bFCP_H2QrGi7Okbo017w:22 a=FO4_E8m0qiDe52t0p3_H:22
X-Proofpoint-GUID: deoYMBMVYFH98SHLkXrAJOZSv29DJzzc
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA5MDA2MCBTYWx0ZWRfX1FzsqDTlLC5g
 gDQtSYs/mT+1cXB5JsJbcR3aPlimsYgnLAgOuPoLW2h0GhEWZJKNXCbUJyMhvokyhkHTVgBDPHx
 KXRzrbUoKeKgZXfNLDJdXqK3Qd7MQrTOIMVLFgDkNYsX0qWidPzUzVXCcTKUcijzx+xjFcmmcJM
 h/yOLZysISoAe2FBgMcOsA+67JjMr6m40phUZa+qutA3GcgoLn1JoWaDLijVtznlJGlIYAFsAUM
 XPLvjYOFbT+0rBQ4paK/9EJVqjhjRloPlSfrPc5nx3QFGZ2Dx7I2jTVgo0Z5fdV1I9N9Fm1Z8hZ
 bhPqxAVC0H01m2d1a4p7H8MQFfhC5gYIG5qF5yL54f/mSkIIP393qjNqLzcoJ7jbnPervmKVJAn
 hynk7y9h/fsEu8tzZ1kVA8/Ytb6FV3pV38Wc8q14hjD+wTQlzsEAbqRWWQ5kSJJHz2MBRdh5znn
 0zqs1ub3yWWGm112OPA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-09_01,2026-07-08_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 clxscore=1015 priorityscore=1501 bulkscore=0 spamscore=0
 lowpriorityscore=0 phishscore=0 suspectscore=0 impostorscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607090060

This patch series introduces support for retaining the PCIe link across
bootloader and kernel handoff on Qualcomm platforms, specifically
X1E80100. The goal is to reduce boot time and avoid unnecessary link
reinitialization  when the link is already up.

We are not enabling link retantion support for all the targets, as there
is no guarantee that the bootloader on all targets has initialized the
PCIe link in max supported speed. So we are enabling for hamoa & glymur
target only for now based on the config flag.

If the link is up and has link_retain is set to true in the
ithe driver config data then enable retain logic in the controller.

In phy as we already have skip init logic, the phy patch uses same
assumption that if there is phy no csr and bootloader has done the init
then driver can skip resetting the phy when phy status indicates it is
up.

Problem:-
1) As part of late init calls of clock the framework is disabling all the
unvoted resources by that time and also there is no sync state to keep
them enabled till the probe is completed. Due to dependencies with
regulators and phy, qcom pcie probe is happening after late init which is
causing the resources(clocks) to be off which causes the link to go down.
To avoid this we need to use this kernel command line argument
(clk_ignore_unused) to skip disabling clocks as part of late init for
initial version. Once it is resolved we can avoid those kernel command
line argument.

Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
---
Changes in v3:
- Updated the max link speed and current link speed logic for link
  retain.
- Fixed l1ss_support & probe deffer fix as pointed by sashiko.
- Link to v2: https://patch.msgid.link/20260521-link_retain-v2-0-08ed448b081c@oss.qualcomm.com

Changes in v2:
- Rebased with latest changes
- GENPD/power domains are not longer getting turned off with the latest
  kernel, only issue is with the clocks.
- Removed the patch [2/5] PCI: dwc: Add support for retaining link during host init
  as we are not seeing much difference with this or without this (Bjorn).
- couple of nits in commit & prints (Mani).
- Remove skip_reset for the long term (Dmitry).
- Link to v1: https://lore.kernel.org/r/20260109-link_retain-v1-0-7e6782230f4b@oss.qualcomm.com

---
Krishna Chaitanya Chundru (4):
      phy: qcom: qmp-pcie: Skip PHY reset if already up
      PCI: qcom: Keep PERST# GPIO state as-is during probe
      PCI: qcom: Add link retention support
      PCI: qcom: enable Link retain logic for Hamoa

 drivers/pci/controller/dwc/pcie-designware.h |  1 +
 drivers/pci/controller/dwc/pcie-qcom.c       | 80 +++++++++++++++++++++++++---
 drivers/phy/qualcomm/phy-qcom-qmp-pcie.c     | 31 +++++++----
 3 files changed, 96 insertions(+), 16 deletions(-)
---
base-commit: ce1f20ceb245f81cc147bf4fd570c09f9f720ab2
change-id: 20251001-link_retain-f181307947e4

Best regards,
--  
Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>

