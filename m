Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 194A2296BCF
	for <linux-pci@vger.kernel.org>; Mon, 27 Jul 2026 14:02:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785160968; cv=none; b=nTRcrVY02W2lQhagzI1hg+JrFQhEMjkA2BChX8m7e/hpTWrKYfJfBHuMNpjD8aVnz+rTQ3gfbogpVPi23dQkiQtuRu4lClgT/hSPUiPxiF890UchxWPqfQJXsS23Nge5x9xoMcv/o8G8bHEkTTDm2aLVBcYgXmXVlMSbpjUssUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785160968; c=relaxed/simple;
	bh=muDn1/9uo7JYqFeDrsdhPAX2awrYjcQQMFFKUzgMnVQ=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=VpiXzwe/Uy5ODrQMPmaujp/dcJhDQMaiOBD6grq2bxWEm24BZoRZo9aQAkkQ3LTN1XBCowBUd6OfZRY0c7wK7UKLOiMONkWA4vtTFRuK+bjT3aPlf0952cYwcBYx8xavuWrG0mCsluxueC+yj3t0Z4cDk1wJnE4EexS/h5jEQYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Yn3aix4X; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=BPJsLMAf; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Yn3aix4X";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="BPJsLMAf"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66RDm6or3788280
	for <linux-pci@vger.kernel.org>; Mon, 27 Jul 2026 14:02:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=P5fwzO7lvs2d0Ge71A9+cf
	VUd8QXGbuwbpCV+KZJQZ8=; b=Yn3aix4XK1/IA6ekrKB90e6OrrZhOH8ZMXVUuN
	KvFLC8E15hSsdoQ2y+7swzjNxODmF9UsGkrrosqWJIVns1Ug3/M69XlG/kHG4lt6
	1pwugH8zx7kTUa3vs/ZiMg2qg1/OfpolBPWurwW1iNIKMw4f05PbpMlFB439dRyt
	fl4vkbRT7+xCgMDzEDV8I5ts6jsOcr9VndGeCBb/C78zhw10cpgh5mwLD6YJXpgw
	6nTXz5V/OV37pC5JJ/xuy8Wycj6QocQ1fZaAoBiufftS+7APIWF+u4QbEuDTbQJ9
	U8Izd0TzgTdUgJDIy6PV7AjPPG37rtCcPIAmuQ2+5XFbGe0Q==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fp3v2h8hs-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Mon, 27 Jul 2026 14:02:45 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-38e8e864ef0so4771980a91.0
        for <linux-pci@vger.kernel.org>; Mon, 27 Jul 2026 07:02:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1785160965; x=1785765765; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=P5fwzO7lvs2d0Ge71A9+cfVUd8QXGbuwbpCV+KZJQZ8=;
        b=BPJsLMAfNPOWg8iwRjk6okGOpKyJUisXY4WCFO8wPMZfIIYJ15fws7NHeEpzTY3EnP
         di2MA5ZA2eF72ebSXApkG6AeVA/Lsp5Z2t7I4aAvCf6NK/uIIIgH5bMLcEeOTT+MQdU6
         mJQRQUWO8JnpqFCUNcxs3jQX9h4ITcxkHK1OQ1XUMXYKIj4UDdLEMavz2of+aJG0SJm4
         P6oTdcPLyYZCkd1Fd57aM0+SQZ6rYPRpyb5dQNmw4lvkrKY8rQsN3sDJEulBg4INMBqZ
         zwOs0Vrb1YvFWeeMjDAPfT1Wvsx4aoL5H0zWMld8Tsovhx928KLi7CIzt+acTK6pBCj3
         m5WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785160965; x=1785765765;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=P5fwzO7lvs2d0Ge71A9+cfVUd8QXGbuwbpCV+KZJQZ8=;
        b=a3wjFoiNtnj8kbE6vAduqNpttjU/Li8G300N9TscwUK9LwBhsGuZVJxCAIK/3jAAKv
         MXAwcdin+GxCCBFxj6AsuPojBy2918aklH6pNX5t6nQIAVllgRayZpmzF+B5lAfiwPvS
         jmebQ7QsNhYyVNyXrBXdPTuqLWEusAPLzZJ9tW/nSiLRgNPLfQMU+mwCl0Mbva2DmJhb
         SfVhtugElAhSv125E/+h+tj6nDJbZgE6UejkpD7xaSrT/rMyEqQ8TOT2gs9rNj6BfySm
         5nG8fzXnOd+J9yoKMPS25a2wEqkkW00vbk5l8xBLlPpqWPXGmgQWsNuf9j+6DxwSYMTL
         pEzg==
X-Gm-Message-State: AOJu0Yxf5HMkEgx3zJ55O/RvgGZdPVBUjXaHeGSjjYB8mcpE0+bJVlBZ
	zNbgF59jDkvqYqvVZ8yYkGBFnTApTbO7dSjlMLGOz92BKXogLqIfbvPuuyUHxqnL8cryLryGmHX
	PTWWbc4u6+NqIuAeH9uPmamREGXkskm/4HBvJSBaPI+6HoeKbiraatF5n9i2sPSk=
X-Gm-Gg: AR+sD12hv+tBHUG2j4vrsPRrO9/eRpgFtwR0E1wIk64qz+0qDvNnsJW10GmP6zbxzPQ
	/vgcPP2wtjvGgCpwOVuDbn4Nz+zsSldPlmJjb+F6ty4W4g9g4l9FqprWCH5mdMrENPB4dgvSYf+
	gRrrSpm1mp4cJQlHXi8JwjxJvpXPEdguSdHNrEIEQ2tOZg9L6HhkBvwEC3dBuvW5mTDh5OLECgy
	KG/LZObj5y0VNLgDFVgO4t0dujb3/AMsjQB9rIHgHAJMZgiCyeyVijsJw8XaaJRw04RaDYTKb85
	xfjNUO39P6WtvHZshPUZ+THU7w4SiH99MWIsmokvBOJjzvEwpqvDkasDkxHbm2f+nizls7nCja6
	5Q6qlc3gF/SS2YGfyptHsCeh7KMVyF/hkbZ4=
X-Received: by 2002:a17:90b:4b91:b0:37c:6910:5758 with SMTP id 98e67ed59e1d1-38f60487410mr887833a91.1.1785160964754;
        Mon, 27 Jul 2026 07:02:44 -0700 (PDT)
X-Received: by 2002:a17:90b:4b91:b0:37c:6910:5758 with SMTP id 98e67ed59e1d1-38f60487410mr887780a91.1.1785160964020;
        Mon, 27 Jul 2026 07:02:44 -0700 (PDT)
Received: from hu-krichai-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13e6054598asm13789423c88.1.2026.07.27.07.02.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jul 2026 07:02:43 -0700 (PDT)
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Subject: [PATCH v6 0/3] PCI/ASPM: Mask ASPM states based on Devicetree
 properties
Date: Mon, 27 Jul 2026 19:32:35 +0530
Message-Id: <20260727-aspm-v6-0-2ebb3ee7ef71@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAPtkZ2oC/3XPTW7DIBAF4KtErEsEY4afrHqPqosBQ0NVx6lJr
 FaR714cJ0oW9QbpSe97Iy6sxCHHwnabCxvimEvuDzXolw0Lezp8RJ7bmhkI0EKB41SOHW8JkVC
 BcVGxWj0OMeWf68zb+5LL2X/GcJrt3NjncuqH3+udUc69ZRKlXCZHySX3ilyKDjEk99qXsv0+0
 1fou25bHzYvj/CwGtTNQrVWCFISpaeGVmzzsEbcbVOtRAPSUEpGpxWrnq25WVVtq3Wy6A1YL1Y
 sPlm4/xerRWu1CMq2Iph/7DRNfz6QJNChAQAA
X-Change-ID: 20260429-aspm-da55a54279e4
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, mani@kernel.org,
        Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1785160961; l=2356;
 i=krishna.chundru@oss.qualcomm.com; s=20230907; h=from:subject:message-id;
 bh=muDn1/9uo7JYqFeDrsdhPAX2awrYjcQQMFFKUzgMnVQ=;
 b=Xlt5EkX9FX1sDk/u14H2hhmxKtobuHBiEZ5PLOSIHdzD6mk5m2ZCy+PQfYhLK56VrHd+aQ0Pt
 QzuBP94tFwAAOQ1LTQA9bWsjeSuf14NWkNdhDsIvjrsqG01pbkjvQwD
X-Developer-Key: i=krishna.chundru@oss.qualcomm.com; a=ed25519;
 pk=10CL2pdAKFyzyOHbfSWHCD0X0my7CXxj8gJScmn1FAg=
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI3MDEzNCBTYWx0ZWRfXz5B+ahys1DfI
 K8yXvskIjnfn9Pzq8TRT7EWg6DDvsgN7U6QwU0UMny34NvajejEFOmffFYhxL52DoUWaJBcAATJ
 vtthkschMiCDrTcj8PbITKB/JE4DBy0=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI3MDEzNCBTYWx0ZWRfX9iPUwqvR+IRw
 83LtCdkPu1MD8vVd4aLUsEGJPSQmrqPiWkgseVkwX17C11npTpJDqnYTKyU1Y1S9fzHmSJR+f71
 asF19Z1Jd11Y+MN1+BCs3E6KEMWlYoWCw1LPyzFs0kNCixhsLmlg55Ym37HXE9pZqqGYmpPQJts
 T1nWJOpdFYeKibXwhKu27y+yckGUvcrMt0owtXqQFH63Cel9lYX6tPv6mSLBOqny4VsPD0a58dr
 rYHpaV5hpoK+hNqlGsljA7GcOF1ZhACBKvfK5y7uBdj5P8GhHSO7SbAy96s1lT4/gNT38Wvu7PN
 himZos0QkfqBnd9gdb+kurcpC8XpiZafUSLjm3hxiWsbOeXAKxID9lZPJjEvBp+ekPpQpKrFj15
 dzD577xvGCZtrUv/k8XVZqZYcwyo4fWqq3BEZCynVbzjyqqqQfK9qXgCGQNmnyOwngXOJilfMM2
 7PSJ10XmPIUcdnY1efQ==
X-Proofpoint-GUID: 4_NX-I3q6077Az-cfXhS6i6iXa4QXgM2
X-Authority-Analysis: v=2.4 cv=KJ9qylFo c=1 sm=1 tr=0 ts=6a676506 cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=bC-a23v3AAAA:8 a=EUspDBNiAAAA:8 a=03P7oVhKTp4GzDZAmNsA:9 a=QEXdDO2ut3YA:10
 a=iS9zxrgQBfv6-_F4QbHw:22 a=FO4_E8m0qiDe52t0p3_H:22
X-Proofpoint-ORIG-GUID: 4_NX-I3q6077Az-cfXhS6i6iXa4QXgM2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-27_04,2026-07-24_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=0 malwarescore=0 clxscore=1015 lowpriorityscore=0
 phishscore=0 priorityscore=1501 suspectscore=0 bulkscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607270134

Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
---
Changes in v6:
- Disable/enable each function L0s/L1. (sashiko)
- Move from pcie_capability_write_word to
  pcie_capability_clear_and_set_word (Sashiko)
- Link to v5: https://patch.msgid.link/20260721-aspm-v5-1-58860c48d0c7@oss.qualcomm.com

Changes in v5:
- update all the child devices when enabling the ASPM back (sashiko).
- Link to v4: https://patch.msgid.link/20260707-aspm-v4-1-d66f85b728b0@oss.qualcomm.com

Changes in v4:
- Clear link->aspm_enabled alongside aspm_support/aspm_default when an
  ASPM state is masked, so it no longer goes stale relative to hardware (sashiko).
- Mask the LNKCTL restore snapshot against the post-override
  aspm_support so the restore step can no longer re-enable a state the
  Devicetree override just disabled. (sashiko)
- Link to v3: https://patch.msgid.link/20260704-aspm-v3-1-157217aff76f@oss.qualcomm.com

Changes in v3:
- Move pcie_aspm_override_default_link_state() call in pcie_aspm_cap_init() to
  before the "Restore L0s/L1" block. pcie_aspm_cap_init() disables L1 in
  hardware prior to aspm_l1ss_init() and re-enables it only in the
  restore block. Calling pcie_config_aspm_l1ss() while L1 is already
  disabled satisfies its precondition ("Caller must disable L1 first"),
  whereas the previous placement after the restore violated it (sashiko).
- Link to v2: https://patch.msgid.link/20260624-aspm-v2-1-800a4151ba3a@oss.qualcomm.com

Changes in v2:
- Disable L1ss when L1 is disabled as pointed by sashiko.
- Disable L1ss if bootloader enables them but we are disabling via
  devicetree pointed by sashiko.
- Link to v1: https://patch.msgid.link/20260511-aspm-v1-1-b4a9fe955cf9@oss.qualcomm.com

---
Krishna Chaitanya Chundru (3):
      PCI/ASPM: Use pcie_capability_clear_and_set_word() for ASPM disable/restore
      PCI/ASPM: Disable/restore ASPM on every function for multi-function devices
      PCI/ASPM: Mask ASPM states based on Devicetree properties

 drivers/pci/pcie/aspm.c | 149 +++++++++++++++++++++++++++++++++---------------
 1 file changed, 102 insertions(+), 47 deletions(-)
---
base-commit: f5098b6bae761e346ebcd9da7f95622c04733cff
change-id: 20260429-aspm-da55a54279e4

Best regards,
--  
Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>

