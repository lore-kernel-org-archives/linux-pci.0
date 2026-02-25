Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD3662798E5
	for <linux-pci@vger.kernel.org>; Wed, 25 Feb 2026 16:24:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772036660; cv=none; b=Jyzaxjk4kFvcju1zHD1sxtgr3pweLlIU6cG5ocrP6Zt9Q/lObqlTtH0qANQ0I2jCIFJLzufEn4HKPNWwK2f+cyPuJrztPLmy2RafxkTBhYxq/MQq5SSm3ego0okhrlCGDnzwwBdzzYV6vmLhjalnURMxqYQA/Nb67PnSZ88RKoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772036660; c=relaxed/simple;
	bh=OnAuwuDAn4JNmt6nlJBWAsbx5rUhDyU5/zoK9uZ1KKM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Gl1qfN/LVQY50f66Wmy+JCO/nIzrHRd/1tuG3Wgk2umEEeNQS/uQ04/rG1DpJcpzthsVN/VAjhjKoipENKw4/pvs0WTiNWMZP995s62KWpYfwMWK5mXTetTemMzfscG9ZB+mGyd4BUkKPTqWy8wYZQyKROQ8yUAk6Kvu1A8mrDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=duio2Jl/; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=BaTmxvZB; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="duio2Jl/";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="BaTmxvZB"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61P9SIGk1363608
	for <linux-pci@vger.kernel.org>; Wed, 25 Feb 2026 16:24:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=5yb5yc2XqWZmCyxSLHrH8s1QgfV8dMzPG6b
	rBBJFJ3k=; b=duio2Jl/4tDLNMBZzO2c/SuRJG1PIXMC6QpyA1noM+0BbyZr6pM
	zQOg+n1XSKqdt7C3r1iZW6RFLx9gognM6S1ceodK1SWy2e+RU8B+905MrhivyO5N
	mdv+re2vFxMg6vgSJjhyvnwa3Zt5rVaronTcNwWywl61dfeI5i37u9y1/3qtNaBB
	A43Zvv4vTk5KrSmk3KuBsWgujnurCzGHk4qC2lM2kLpeTa6TdOa+wIdgWCStZSx8
	D56csf4Ebj9OjLiNw60RydNJnnbZ/Ar9+Pz0jgq5YLK6RfEmZuOy/5pjLr4G8l3B
	0ppeQvFDvW21EOYUqgzLFhYeMdSYFgpJw7A==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4chp15apjq-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Wed, 25 Feb 2026 16:24:18 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-c6e74e55d35so4481216a12.3
        for <linux-pci@vger.kernel.org>; Wed, 25 Feb 2026 08:24:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1772036658; x=1772641458; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5yb5yc2XqWZmCyxSLHrH8s1QgfV8dMzPG6brBBJFJ3k=;
        b=BaTmxvZBk3odd4j1XGY2llteOLset17E9VhGohbVHIqu+VrVRHa1k7wlcBNiIZCZJs
         Faipusc9nDlxFsRULpiNAkjHm6JgoaAN+W8hXZpWA6g6erJahwKiRc2m5Ytfmc+IUb79
         E0YugjwJEsLGupFX4YMlm/u94BkALNpBtzBK8OYgmP4CDTj6/iLYSHVWDG2et9C9VBkK
         RlvbPLFyGh/ba0M1VhiK77q1HUAcVJ8zeTfD3jtRuhAHH2GIQe7nbCxJUnm2tvSDi4Xf
         oLWwIkfkoXN4z4Y3ULxmShS18aen1uNMhnx9OB5GpLAkrDDbLqv7hVVMGm45JIZavMAj
         4DAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772036658; x=1772641458;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5yb5yc2XqWZmCyxSLHrH8s1QgfV8dMzPG6brBBJFJ3k=;
        b=wI5Jsk+KzNmGhlon0uhQyXUtR8rThYJla814PuPTddroy77ZcUkqlWTovb3jAO+caf
         8ZE49SoLMJHSqXtoRKjoycL7UJHheURyxS0BUWv7x5gWmr723linCkekJIFMqRgj33Tu
         02NebCkMAD15PnkEqVqGNx2eql7EJ+PqYa8P23pPucZCHQa9zF+wOyQG/ZxoXFGCVQCj
         jthZLStOTxPIrN8CaAvUhbo0gkVt7jW17KHYhy70LxC/PDtLKb7gGvgMao43r8q+hlSz
         Gyktxsoz0xPV6LjK4OImNTyWShEBJ1BhnExyNdeFacW+iu6H8eZBschdFcxMhJBIVOuz
         NPdg==
X-Forwarded-Encrypted: i=1; AJvYcCVArAfSi77RY1/vjFuhpI0p2u5AISg3zdoszLelx6xqMFHWY9w3XJsH8igH/RrIouLVRtmztNidJ40=@vger.kernel.org
X-Gm-Message-State: AOJu0YzP4Za8Gx9DsH5tuldirVqoUnDCp6TYZr4Hoc2TB1npmRq+rID7
	dmklnYRRtqfnbHjxsz7ejV2ecdBB821KxrPlxbk9ouE1FwQRO+ToNS+2yFGqN9k7BysEyMWPD7Z
	6a96Qbj0EfeYa14DZuIbWgCyH4ToqO1EWPZgjmgBQxtaEphSejJSBzfb0e3Wv9Hg=
X-Gm-Gg: ATEYQzwz2YcHPgy1DAi2yzuAkNjX+talINWl/W8phTXSxc1mqe0mPjePHtTUsd2g6R5
	tFQRkifOhwvOiF7ifG5ijM9n2WnNXOJWZywR7x/9Z6TvDbCceLyR71sc17qniD8soUxIQ0iBnMP
	1Wus2o9ivCB9sLtTE+gJZmk2BI2+X1NtVfSB4lKuLE/jNWeOSkyWVg/K0Lwl3vstlxfbCn9GQgX
	1PonSbEYJTfUZf+URbynVIMDZNvbXM5U0Q80PBLaJHI2pKnd1sSOKDlaHG6VTwIcZQzfioKnHcw
	DzPzO+PwSjzsDxh34AO1a/uFzXcmLTC2rH4xvpEFna9XnVXKu/Gi5OXYZVw3IlZcu+2NpwzBlks
	ZGzAuVVgRf6mb7vfUIPlbREZcs9DFxYAKm4V1Z+Nx0g==
X-Received: by 2002:a05:6a20:94cf:b0:35f:68d:430e with SMTP id adf61e73a8af0-39545e50a02mr13415407637.9.1772036657488;
        Wed, 25 Feb 2026 08:24:17 -0800 (PST)
X-Received: by 2002:a05:6a20:94cf:b0:35f:68d:430e with SMTP id adf61e73a8af0-39545e50a02mr13415371637.9.1772036656880;
        Wed, 25 Feb 2026 08:24:16 -0800 (PST)
Received: from work ([2401:4900:8fe5:3076:4038:f293:b188:d52d])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c70b71a735csm12822380a12.12.2026.02.25.08.24.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Feb 2026 08:24:16 -0800 (PST)
From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
To: jingoohan1@gmail.com, mani@kernel.org, lpieralisi@kernel.org,
        kwilczynski@kernel.org, bhelgaas@google.com
Cc: robh@kernel.org, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        cassel@kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
Subject: [PATCH 0/2] PCI: dwc: ep: MSI/MSI-X checks
Date: Wed, 25 Feb 2026 21:53:57 +0530
Message-ID: <20260225162359.116000-1-manivannan.sadhasivam@oss.qualcomm.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjI1MDE1NyBTYWx0ZWRfX6kgP7msZaDaB
 DN3FWObbPJX5X55F7XgVQd0WGEM+VvwkZRX8cJDtj7blyGpD9SpQIG5UY7wx281vnrVAMPzXB3m
 Tyl+ajw/dK9pIShAUF3aAqNAgD18EFEIWBsf1JbLlLSo1DUkE5WmscpCO2NAFrs5Re9rKIQlYlS
 65nuT1cKCVx3aZLY9R1bIx/PnjmHXBZdHburS+2ixO0l9KwJBuU8Ovm8H4JWxAL2ngn9HEkSG4e
 8yoeFBId9vLuQ0B2BPZlwUfo87GsKAT6eF8MiwDizMMoYaZn7wRuOApkIxNN/biUw3cNUm2o58M
 WgKEjJ2UBIrdtIzM+fCErREfXLuaaNgvaLLE7UFPh/mV3XkFy1eZkz71x0BoHMwWZ3NuWCe0uJu
 XvJL8EKumHSe85j9McO6+5EBpuZxBCJJQ3BYyEKfNmUtuACyuz3p6KrxrRA4kFGAYHLIV0UOsoT
 YNlB6g8FXLSf+0AyYBg==
X-Proofpoint-GUID: SslJm9q4yMBclrzKnThpCjgyVFFq7f0_
X-Proofpoint-ORIG-GUID: SslJm9q4yMBclrzKnThpCjgyVFFq7f0_
X-Authority-Analysis: v=2.4 cv=etXSD4pX c=1 sm=1 tr=0 ts=699f2232 cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=xqWC_Br6kY4A:10 a=HzLeVaNsDn8A:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=yx91gb_oNiZeI1HMLzn7:22 a=9dj_KKastReSFRWJUqsA:9 a=3WC7DwWrALyhR5TkjVHa:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-25_02,2026-02-25_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0 malwarescore=0
 suspectscore=0 bulkscore=0 phishscore=0 spamscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2602250157

Hi,

This series adds checks mandated by the PCIe spec before raising MSI and MSI-X
from the DWC EP driver.

Note: I've compiled tested this series only. It'd be good if someone with EP
hardware can test it and report back.

- Mani

Manivannan Sadhasivam (2):
  PCI: dwc: ep: Add MSI Enable checks before raising MSI to the host
  PCI: dwc: ep: Add MSI-X Enable checks before raising MSI-X to the host

 .../pci/controller/dwc/pcie-designware-ep.c   | 52 ++++++++++++++++---
 1 file changed, 46 insertions(+), 6 deletions(-)

-- 
2.51.0

