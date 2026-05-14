Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C14EC36404B
	for <linux-pci@vger.kernel.org>; Thu, 14 May 2026 06:50:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778741442; cv=none; b=bJ+G0hhOWa1H3Yv8CW0FoLBZ98rtVX8KvJNsg8kkEtl2+cmC65CxOPoaWtZKV8AAUi4GSWuab6XDjNdGtfq39IQ9tVYKau1POiOmUBZ+fU+hr60FA5U0Qv2KmfqkHJGcP6p/EgQje5hzClH0Tujc+Fzh2f/ioNAPw+qV/4f52gY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778741442; c=relaxed/simple;
	bh=3TLOQXX5xKiM2sGIzt1EUEymlZ7tO3evZhBnWPIL1Xk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tg8MqGuPY8Qf2+krBTIPiCaH0FMeqoaaK8xw1CbuhkXX7uWCHoUtMtAO9igtIgrPy+DU9JBYrYMShqSBcBgmzWYYopvdss7NbpYPbOQ0euyEZYIuwFbR+nJJd1fzjwF5WRuto36bzdIyTa/R8e15NmPIkGpyn/pt/oVuSfj5ZxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ZHy54+hk; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=j7Go09ZQ; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ZHy54+hk";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="j7Go09ZQ"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64E4gNqU3013560
	for <linux-pci@vger.kernel.org>; Thu, 14 May 2026 06:50:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=1Bz191QtM3OT7TlZvkr4oqTeTL59KBQ6RMy
	9k++fGU4=; b=ZHy54+hkJxbwZo1XUdhhhFjHXSoJJwPjfIo5MEbYrqvBbk6qjL8
	1iYydyvUnJtPGYzXkVeB/a6BuA1SazqANU+SnAi5sZbXswAqW8/3SWq1Q1wAlnVl
	sWn+gBfaln4WpT1ItVnekAY6/H/Yg9Z5Sux7Ly7evrMfuP5z0jV9vWbPI/LBrvAR
	Gm9sa6/KhMm32jAQ5sV23+cRbIphr29rGgSlwAcFox+UanLk8wcZZKp7O7S3noZF
	VCGXVydV0Hk9A+D6zexF455Ad/WlO35mwZ2BsoQ5PByuAHTpRa2KUeqrs6BGLY98
	TxSc1CDb/7O4y+z9rT6S6p9FL5cUQWUD61A==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e57ksrc92-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Thu, 14 May 2026 06:50:40 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-36781927b4dso10937590a91.0
        for <linux-pci@vger.kernel.org>; Wed, 13 May 2026 23:50:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1778741440; x=1779346240; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1Bz191QtM3OT7TlZvkr4oqTeTL59KBQ6RMy9k++fGU4=;
        b=j7Go09ZQdYRYQmDy8wj/ZzwsCWYMxKm9p6TLazSugt0iAWbDPUUjMVj51Mw/NWmgSb
         8bVKYxvGf8eWDl9j2jaVMc2Hdm24JWdbHHtIY+iSRwJpPvhX/q0bR0t6Myw0Dk2otP2o
         KpRN1CmPN4Z7WYwih+HmT0jpoKgDAr6LGBvdun8ekFYhU3jr3NlM/pIOnWDmg/CQxS5l
         6tisuX7chh4ppIApTM/zbXpkczyK1D7XcVNQz6emsB+4D90NrAFFWB4/scli0yHzNe41
         +Zxb+gAfsofyedN5qTsAZraFEqHzuR/KIQ6NtTVkvrZhSKSSTwpY9rtDXK3lanm+4xv1
         9Kzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778741440; x=1779346240;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1Bz191QtM3OT7TlZvkr4oqTeTL59KBQ6RMy9k++fGU4=;
        b=BOFXOAMFPTDr68uiKQeCscg1XrN6iDFeNKFwdfjw+HvJkE3hyylFhwhqtj2TqoYys7
         QiAQ3xbUrKX/BZZBlUvGi3p8j6fJhYS9RPBvlTNQ5/wkpFdum7nRTaGfT/TLqWcTnyde
         WMrUak0MoXYanQFOk9nhXky+gNSrhr6GlUYzK7OyL1ncvri3O7dxKuc1mQVQgPwaKt3R
         Lzofxg6GVNjaEqqPcTQUGdiAb3Amgd8+IsrrEE4yT0wTZdORPYUgYO4VvDgpePrrxe0A
         ETQ/AOV80cT0au58KWgxBAtV0bqvMoaCHuIygeBGwZsb5+DngDOOLM7Kjo8uTgMy9fQu
         eWow==
X-Forwarded-Encrypted: i=1; AFNElJ/jrXaPOaSOf5CraXTnxxQt5d/eUv2VqHdCbaIol+6tq/ZAY+fEcwOWcXdDdbe9gXhzWdcEGKEzVes=@vger.kernel.org
X-Gm-Message-State: AOJu0YwXgZUerB6ZAfJr8OAPal4dX39KPOvv94O2q7AO3kh5AIdwhhwe
	jV1KTdhtieYy8/9Gtia+uMNxNl2BGFtwEZQN/ehs2QSXgz/wkw1rOrQHAKo7Aj6569zs0yQNmGU
	yomVXqDS/M2qpE0QhkoTS40THYhE1Gb19LKFC7Mmoe4lq8kYcxtT/iXc40RP73YQ=
X-Gm-Gg: Acq92OEZry3+k0o17o61gUKca2frOCOxDQU1n5cQwQUpe+V9QMKz/4odjNoWa7CXYdN
	Zz7yRDFjWyicgtJOvk5ilayacf5xrMAVbZp6xsYV4+c0zwUC0nJX18d42QJQHhT/hZ1z1ymqWAS
	MJfAvtb+t5dv2uiJlqHrjL6FmJZEl5/nvmh9wctUdBulMI4ubriErT6kTXU3C1UVscovuHNLlHp
	688iXYPCifCicuKRT4iocweuzKWOZaccECGF3sXSgbJBSIrAp06zncxSOmCZGlfzqTjseSAROEl
	PQKFzEFJ24klJdGM7pruNIPq2fObqJx2u3s9qzm8bpLLzBgEHbzcbAAduepEJmKI0RMpsDwDoKQ
	IZ+RA1lm8QS0S7NgZ/1G798BAATZEKLfWQExW
X-Received: by 2002:a17:90b:554d:b0:368:a297:bd3a with SMTP id 98e67ed59e1d1-368f780eb3bmr6656760a91.8.1778741440106;
        Wed, 13 May 2026 23:50:40 -0700 (PDT)
X-Received: by 2002:a17:90b:554d:b0:368:a297:bd3a with SMTP id 98e67ed59e1d1-368f780eb3bmr6656732a91.8.1778741439587;
        Wed, 13 May 2026 23:50:39 -0700 (PDT)
Received: from work ([120.56.195.42])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-368ede20a50sm5400043a91.3.2026.05.13.23.50.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 May 2026 23:50:39 -0700 (PDT)
From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
To: soc@lists.linux.dev
Cc: bjorn.andersson@oss.qualcomm.com, konradybcio@kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-pci@vger.kernel.org, wenst@chromium.org, arnd@arndb.de,
        mani@kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Subject: [PATCH v3] arm64: defconfig: Enable PCI M.2 power sequencing driver
Date: Thu, 14 May 2026 12:20:17 +0530
Message-ID: <20260514065017.11305-1-manivannan.sadhasivam@oss.qualcomm.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: B9a_Q2vvMVS0A8xqzCMMSWwWQ2cRh6ac
X-Authority-Analysis: v=2.4 cv=KZbidwYD c=1 sm=1 tr=0 ts=6a0570c0 cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=QkUiPtlOeBxfVnO1KVo74A==:17
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22 a=EUspDBNiAAAA:8
 a=Mt3aZHS-KmEbwue0ZEsA:9 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE0MDA2NSBTYWx0ZWRfX9q/6U7M/g00m
 gFvHznOBn0oyjxGxeHaS3SJqzAbl27lW14DTgz5DM5cE1gs4VFW0Td8INBB8xWjSn7S8oMOoZdR
 uQOZn4PMVBEJvxbEzRUfLPKVxSYjSg4RXRRZDlnftN8jTSny51V1CmSrX7ZBXwv70obc7xtxa5t
 GsmydlEvniOnGA0aM9bhzJNs2n5LK/vF0e0h3EXSGJAoOvn8WqCMSnKEZY7UxjIKnA5lSZ+Hr/R
 sBDobO3MgcsuwTOzpCWN1BVT75MFhzKp1HGq7P2vCG3Sv7B3YqX4NuUDERmDIakUmsXwmyqKYGA
 aPeGqTZILDfk/OV45VYMJbA9YbRmhVd8Taiv7UzYHAEsK/GDQfc9AgGNM/hWbkPp8pCqx3EKHqx
 MavlhIKpJ9mTHzXQv9EGlX/yxaPbeMw9sVM3bQKxD1GEBRe6R7PrP0YptNic+h/p9z5DQ3NQodl
 pUzEhzSTylpIsZZ5tUg==
X-Proofpoint-ORIG-GUID: B9a_Q2vvMVS0A8xqzCMMSWwWQ2cRh6ac
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-14_01,2026-05-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 bulkscore=0 impostorscore=0 phishscore=0 lowpriorityscore=0
 priorityscore=1501 adultscore=0 malwarescore=0 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605050000 definitions=main-2605140065

POWER_SEQUENCING_PCIE_M2 driver handles power supply to the PCIe M.2
connectors and is required on wide variety of ARM64 platforms such as
Qcom Snapdragon X Elite laptops and Mediatek Dojo Chromebooks.

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
---

Changes in v3:

* Picked the reviewed-by tag
* Sending it to SoC list as Krzysztof suggested

Changes in v2:

 * Dropped PCI_PWRCTRL_GENERIC change since it was already applied
 * Reworded commit message to include ARM64 platforms making use of this driver
 * Added R-b tag

 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index d905a0777f93..96ce783f24e7 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -260,6 +260,7 @@ CONFIG_PCI_ENDPOINT=y
 CONFIG_PCI_ENDPOINT_CONFIGFS=y
 CONFIG_PCI_EPF_TEST=m
 CONFIG_PCI_PWRCTRL_GENERIC=m
+CONFIG_POWER_SEQUENCING_PCIE_M2=m
 CONFIG_DEVTMPFS=y
 CONFIG_DEVTMPFS_MOUNT=y
 CONFIG_FW_LOADER_USER_HELPER=y
-- 
2.51.0

