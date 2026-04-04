Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3F9A3126D6
	for <linux-pci@vger.kernel.org>; Sat,  4 Apr 2026 08:53:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775292792; cv=none; b=LJ0H8FJSN1//PkoTjQxMF943hds1Oe5IJwygNgX4JCJaJJY/h5ZwY3GZQBJsKexkgM3Maiwf1c9gsJFpHGR3G1diV9uoeGvbUSv8SEO40DyU6/uPpqmSAMhdNdRYxLleEAKKmhh7zdHg/m4kpSZxBea9s5GFOoi3Mk+1rl825n4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775292792; c=relaxed/simple;
	bh=akcwv7FwYHslYB8DD2ESdGVUWQ9b/KqvjRHw6aenFWs=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=UlZpcMlK5o9jqEP7YQ8Xy8jriyCH0m5umhA1bJNQERNvKtiKMVSuZmDMbA1Kf9Vo+OrSrBkNPjsRF2wwUpYSlaV0s2Slu3lFmi0mPyFUa4SxaGegT1sOIpGYW4+9GB1nbdmIRdeqIcYGb07N923D1PRE6+sATCbf91Fgxgzq3tg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Jjmhkl2U; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=ezjESPQo; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Jjmhkl2U";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ezjESPQo"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6342BhQl4114075
	for <linux-pci@vger.kernel.org>; Sat, 4 Apr 2026 08:53:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=3hR3upw8WMAdZtDHAYAYDf
	zySf6SjjpZrsN+YGn4b58=; b=Jjmhkl2UWHJPGkiJDXqdzTePOgoB6SPtrNgdiC
	XwEMsHPKoTV8gUHxnsnvI6xf5rzPCYtkV4Olh04HDS/pWMolqthpOanTFaVoDwTh
	XrHxTyQE28PdOUrzce4BOadFZpWJ1gl95YggRIGjo2DIvYJrzLIukcS6fbfOlwfV
	QrfJBA9m5wAVyUyP1aywb28cmBuuPxHrqG80sAmNesr2JWjZ5QVbP+cdSpDSTE2M
	ggiqdZUVzs3lWweZlto917N+1LdTi+9u+CzfTKVKXiEgRovxFSy/5uWSv4jEWFeO
	TjbHPqhJqR7WP2ExWQBmY4DVzJp0L7Ifsr0USAJ1S5hpK+hQ==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dasn5rmk9-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Sat, 04 Apr 2026 08:53:09 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2b258636d16so24230725ad.2
        for <linux-pci@vger.kernel.org>; Sat, 04 Apr 2026 01:53:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1775292789; x=1775897589; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3hR3upw8WMAdZtDHAYAYDfzySf6SjjpZrsN+YGn4b58=;
        b=ezjESPQofYVAI4u8B+C0znAVG9BGZAs27yRXPGh1IC7CrVEpfS2McjWV/YTZHbE/6m
         WBIVvhlrk+6Y94X6XY6GjUHCJFt2/ysOJWidJuZz13kNSE2kHveOcOEcEq6qNeAYDkpe
         EPZBkfHRbvAKov40CnEQ9O/+RHOW5h2xqaNQJ9Mmx/XdzUJM4uw/2LLWrvF7ZOMDxqAB
         EjzERufiuzSBtrkBfTM2odwntOXKNVIL7v8tdsEkrAgVMK+21j6X9JOQJJKBEo8N4qRb
         LPEHjcSndF+D3bAeX5gw6wyYRBOaFZKNObQP/I7VrD8UbI1SFVNiI64HJvvD0MJYqIwr
         XH2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775292789; x=1775897589;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3hR3upw8WMAdZtDHAYAYDfzySf6SjjpZrsN+YGn4b58=;
        b=lxxyGipmXqi6yZsy3gJT+J3FzFTvcaqU/lpOeQaqKygFxcmEdqNeSIHC+ef4XHYyjD
         fIVUa6c7K3WYfQr+V20DlM4gKvU47aXBnDveIrwlZPTobE/iU1CQUl8TFZiXsjfdbvzi
         IG/zJFdznq/Pxmfl/rZXtuWNzR4rBW+I891Fr6POLg4wYp0wZtSkD78IErMSy4XXc6GK
         2kjrj5f/x3sBrbfS9Pf/ZySqxxIZqgXCJmSGCA8tUEE4Zy0SxZ2LotszpR7j3wiyNhUy
         TlHNri64URr6ySpX3VPHMAkbASe4AjoJE/uOtFXAz3skECtb7ms4DyJ2ZO7bsiY3Btsr
         RHQw==
X-Gm-Message-State: AOJu0YxhvF8SZNrYmWbBNSHn7CjNkuVQoJFGSoYqgmxKldHaeRu6mfEj
	Qbo6b1AgdGsFlzuGoQ2IQZBr2wBoxGK0FHY1oi7erEQ2QFZZzU73DP83MEvxJ17U8ZERI0NAdGH
	fJ3lwc3kjsiLROAP9mUD/jPvZT8Qo9tPL8OCWb4VK0EtJGmJHGgklzQJjdYWpS6kl7hK4iYI=
X-Gm-Gg: AeBDiev7jZ2BB2YuYuAgC6CA+IuaplmbUnJn31bj6PgtcpD0K3Ii7nLJ1XZ4cGaZ4iI
	dLHV55kTJGDyk23JJa/vMfA+isXJ3UH+E8T3x2V7DxOq3/luEzT3qYLx9F434+upiYLSAqDJUfW
	4yhEvTNKWjU0wr+Bh4iJVOdILo6uFY1m3/85hunqR3VgxZFEhAfRPysO/Bu6JtycOWpmCOCCAJY
	B02k6iLz6BxHD5eZ7Kk4ckWplnYXUpenPj83mTAIm5f8nnU5iU1jTgJpE84afMgGXgkW+/5RiuL
	6+BZ5D5KtK0kyb9o7Z+mfA+y1xr3puATCMpPYAqBWRziI40imiyFsareK6E410J28hgeQhp2aje
	glGDI60IbcDb7zEfPk3QimHJ4W1Rd4XNA2Bnh01BhCykLdS9VKhO1DaRP
X-Received: by 2002:a17:903:38d0:b0:2ae:c981:2a29 with SMTP id d9443c01a7336-2b2817ceaeamr59196255ad.2.1775292788486;
        Sat, 04 Apr 2026 01:53:08 -0700 (PDT)
X-Received: by 2002:a17:903:38d0:b0:2ae:c981:2a29 with SMTP id d9443c01a7336-2b2817ceaeamr59196025ad.2.1775292787974;
        Sat, 04 Apr 2026 01:53:07 -0700 (PDT)
Received: from hu-krichai-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b2749e2e97sm106883085ad.82.2026.04.04.01.53.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Apr 2026 01:53:07 -0700 (PDT)
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Subject: [PATCH 0/2] PCI: Fix NULL pointer access in
 pci_store_saved_state()
Date: Sat, 04 Apr 2026 14:22:58 +0530
Message-Id: <20260404-fix_pci_access-v1-0-416f32c6f7ec@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAGrR0GkC/x2MQQqAIBAAvxJ7TjAND30lQnLdai8mLkQg/j3pO
 DAzFYQKk8AyVCj0sPCdOkzjAHjt6STFsTMYbZy22qqDX5+R/Y5IIgq1DTa4OcaA0KNcqBv/cN1
 a+wD7g2LLYAAAAA==
X-Change-ID: 20260303-fix_pci_access-c03b3b64ddbc
To: Bjorn Helgaas <bhelgaas@google.com>,
        manivannan.sadhasivam@oss.qualcomm.com
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>,
        Shawn Anastasio <sanastasio@raptorengineering.com>,
        Timothy Pearson <tpearson@raptorengineering.com>,
        Lukas Wunner <lukas@wunner.de>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1775292784; l=1433;
 i=krishna.chundru@oss.qualcomm.com; s=20230907; h=from:subject:message-id;
 bh=akcwv7FwYHslYB8DD2ESdGVUWQ9b/KqvjRHw6aenFWs=;
 b=ASk8IWHZTKdMs+IDgdvapUGBUZTKJC6y7w88GlYDKhchbaaQCoYuktwiabsONwz/pyjMBBPl/
 nwxqvGxurrwC7U+kYJaUsMYPmMLNBV/DG+trnIg3i+xjaD9Xrg5qis2
X-Developer-Key: i=krishna.chundru@oss.qualcomm.com; a=ed25519;
 pk=10CL2pdAKFyzyOHbfSWHCD0X0my7CXxj8gJScmn1FAg=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA0MDA3OCBTYWx0ZWRfX9jqyFzaFSgP8
 eeV/GVyQKyIW0Q1BYHXZGyZx0mjtGbJ135FS7RLar4mnigsL8mX/Jp1puopr0Nye7fC+ayUkDFU
 Bm0QeULw/wy5zaf1NJXgyXl3qFVUamEF0EVA2Gw2WXx/RRWJfEShS29BJLN2a6KBXb2ls0aKTB1
 t1rptxLn9g4NMS05rHxmsbdO5t0JSaEiwQZKvQaZA+kzgSw0CLVKBfKeMEhF6nHx3KrSj2QCoKa
 FkWoAPzpX0jPIpDXQtQX5s5J3sMJIwaJFOxD2a2dZlj6xDefLK6roy09JTSUEYx2pqWdv7zOiCu
 2L4lBeGSYV39IpJQJtzmLeDnjiOL9h2T1KGfrzGHD0PZgK9KdK9e1qtvf0Vtr1F0vROyIA0JUUk
 eq8jm5056EQmqO6iNDCkzWVLzNiTxqMq+2ZaOLXK5ovpPIsjPi/96Vm7H+Y4ja3ak38FxDIMijy
 YZOict3HpocG1AaTTZQ==
X-Proofpoint-ORIG-GUID: t4clb4jdbNRYcUhGt8dgBvA2JZSet3kL
X-Authority-Analysis: v=2.4 cv=K9wv3iWI c=1 sm=1 tr=0 ts=69d0d175 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=EUspDBNiAAAA:8 a=ZZdOtCZIvBGHUYC86cEA:9 a=QEXdDO2ut3YA:10
 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-GUID: t4clb4jdbNRYcUhGt8dgBvA2JZSet3kL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-03_07,2026-04-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 suspectscore=0 bulkscore=0 clxscore=1015
 lowpriorityscore=0 impostorscore=0 adultscore=0 phishscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2604040078

If the PCIe link goes down while pci_save_state() is in progress, reads
from the device configuration space may return invalid values(all 0xF's).

This can lead to saving corrupted or inconsistent capability state and
subsequent memory corruption. The issue is not limited to a specific
capability type and may occur at any point during the save process.

One example is, while saving VC extended capability save path
(pci_save_vc_state() / pci_vc_do_save_buffer()) then interprets all-1s
capability fields as valid and ends up writing far beyond the allocated
pci_cap_saved_state buffer, corrupting the pci_dev->saved_cap_space list.

Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
---
Krishna Chaitanya Chundru (2):
      PCI: Add pcie_link_is_active() to determine if the link is active
      PCI: Fix NULL pointer access in pci_store_saved_state()

 drivers/pci/hotplug/pciehp.h      |  1 -
 drivers/pci/hotplug/pciehp_ctrl.c |  2 +-
 drivers/pci/hotplug/pciehp_hpc.c  | 35 ++++-------------------------------
 drivers/pci/pci.c                 | 38 +++++++++++++++++++++++++++++++++++---
 drivers/pci/pci.h                 |  1 +
 5 files changed, 41 insertions(+), 36 deletions(-)
---
base-commit: 7ca6d1cfec80ebe46cc063f3284c5896c344d9a1
change-id: 20260303-fix_pci_access-c03b3b64ddbc

Best regards,
-- 
Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>

