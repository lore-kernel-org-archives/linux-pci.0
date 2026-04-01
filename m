Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2584F367F5B
	for <linux-pci@vger.kernel.org>; Wed,  1 Apr 2026 07:07:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775027274; cv=none; b=aFva579kfr+uNtHx7AHUzDyyHJ+W7UpO35Vs09Hmi3aQGllBKES+e3R99l7IQ1MZQDFKMyXoMyKdFVr3YYeppEF478Q1aksvU6xyZ+uK7BBVVVTKwSGlxziv9U7pBnOdVZ58g4rV4aQdaU0SlEznF8SSN2XG0uJdhVE5yPd7qsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775027274; c=relaxed/simple;
	bh=2vEu0FMYjbU3hCQR7oBHMixia2zkpzxyg0rkOUGp7fs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XyiJu0Ov600p2IXCM77REiinwGwFUbWfc91PrB56FMHmGhPsO3KtiUBWnlEKFq2gW6t1gaHTqRzaVtevz7xYRA4EUa0OsEMsLGNedhX2vf4jywhvGYWOy+IJnqaO+3RNYZ5Hcd+mNzOgxFviSRqZMdIpwBgYJaRNToqD/2wIm1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=NxQCeHfe; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Emo7kXVK; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="NxQCeHfe";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Emo7kXVK"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63144Cs41579572
	for <linux-pci@vger.kernel.org>; Wed, 1 Apr 2026 07:07:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=22A+Sj5chUc1iyVqke9i/KwfXM4BVovOzih
	XMiqpqQI=; b=NxQCeHfeNLOCx9istPa04KOfV0L7++Z5drnpxa+rK4BKxN/bo8L
	MdvhBKm7g7YIW9OrBZKF0BR9Ns5JhDmZthaJPrdZpRNrMqTlpNinCGfB7F8BXkt3
	OTeosUc1hjaef7vOFG015DdKMbsCoHNhgasgjX+Qcdsg9kKY5O+AizQMU+Encrvz
	/wJh+AJRkYipbyGjvzAIfwIP+/rnXspi7NPCCEC6qfifqB8hF5z1qTHVhWko6aZH
	Y18R+jUrlpN3CG79JXt0UVWR3XzdH0sPtoomVgRRQk+LDfgmDprOxamLkJe1Nipm
	vj7Nv76PULg8AEXv5lCkgQOsoECjts4iTvQ==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d8mr2t931-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Wed, 01 Apr 2026 07:07:51 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-358e425c261so8099024a91.3
        for <linux-pci@vger.kernel.org>; Wed, 01 Apr 2026 00:07:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1775027268; x=1775632068; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=22A+Sj5chUc1iyVqke9i/KwfXM4BVovOzihXMiqpqQI=;
        b=Emo7kXVKHfGIvuTymLrps6hca5bKSk69ZSbyJji3VX34sayeIRytZ+p9rBWiC9NKbk
         oGXfOE950RjgBhSRuAIje9GwipCh31heEg/xtCOq0TKC5/IWmzNDy5jbfiZqhpjXo/ZQ
         Hzysh8o66NPEFYmYMDgz+1qQwhcgJm1n7yN1G826youEebOYb6PcF1qc/pizjXU4YkpR
         EoUR/oQYiAquZzU1OYTQDlmEzGiE7GvwSOoiqG0lUPpwsKjOjTAZImQqQZWWHTo1q9pd
         +JHN9a7VrboEM6TiQVuJuJZGDFJj9YkO65ptBCav8hZ3N71tb3H5aCUUaFA0iy44QXe8
         eDVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775027268; x=1775632068;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=22A+Sj5chUc1iyVqke9i/KwfXM4BVovOzihXMiqpqQI=;
        b=S6xJOT8OUH+9PfSwCrLC6O0QzmDglC7W9Oq23QZXpykpaDL1+RuAPJMFNNjlXz5Xtn
         V1ARfoC/cDXQKw6PwlHONV105+pvx/yWcDrZI8yUSUuevyWfCjVtqyoMo+MFKOjXYWTp
         XQYF2uWkVAbW+dcDU74yzH6RTxifpbjnOGcu5RP8vZCDLkP4A9cXO9x4v8Lw9vEez5B2
         O9HOMECW5WTEYnUOfJtaKmUsFBz0pIxYQy+fFUBUNTHyiY8j+ruo8j/p7PZp6QgCwqLL
         0vNMrbsH/PmOxY+/yTmnTmG+R3FHdN+KB2n06mK6cwiaDnkaQgTkUAWLEdgndC0fXj0N
         cm0w==
X-Gm-Message-State: AOJu0Yz0YZ6e1uoKEDR7GmMT3eGKmiIhRGxQ/cVO75O6JEPXUZhMmnuj
	ZsVG+SGl3uIa9UqZqlb0wswNSdBijmaDZiOnyyRM8IitNoXbRaQMQz572YDchJtiUan2E/I9rvC
	IEnapUWBc0wKhl83cCTD1XgjtYmVTIJPNTDdXcYc0dUb6TWJxkkIrQ4Ev9VvQsqg=
X-Gm-Gg: ATEYQzze2ymTdUBx8O47/gqOSq1+VYu/NSQLMPpCK9k9gYuZ+sV1O9X4s713Xkyb3qr
	mP3ER1Z1sla1P7zaTFwjXG0fuk+/nzHwAd6iS0skGJl3LrIB0rJKKSAc6hFhbvO0p7HvyMTKPz5
	F1HBi5fFtTKEev4TjmtXnBVoUKmSDi/62eR03yeRNTzMrwCPSoTi3w8M/NpG74nHjYA9/+ABkzE
	qH/9TkpAEUSSrzVlx+8vcQhTYYvOMQZ4c6miOP7CyySlxIZk/++Z6gAjwLYZM5FBsdT0yX/ceV6
	06qP5TiQbq7jKkQ+MTyuW+QFOpPBJZZ9fbIO7Y4jh8ssQzzqYUY9pKSrGC/+5celiL5LX/C1VuW
	TmnvdUvzaRGjpsPZp94fvxvkRfUOxzL/mF+/p
X-Received: by 2002:a17:90b:33d2:b0:35b:e4d8:bb10 with SMTP id 98e67ed59e1d1-35dc6fae012mr2416067a91.14.1775027267917;
        Wed, 01 Apr 2026 00:07:47 -0700 (PDT)
X-Received: by 2002:a17:90b:33d2:b0:35b:e4d8:bb10 with SMTP id 98e67ed59e1d1-35dc6fae012mr2416032a91.14.1775027267407;
        Wed, 01 Apr 2026 00:07:47 -0700 (PDT)
Received: from work ([120.60.63.102])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35dbe6e2fc9sm3956464a91.15.2026.04.01.00.07.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Apr 2026 00:07:47 -0700 (PDT)
From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
To: brgl@kernel.org, robh@kernel.org
Cc: linux-pci@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        mani@kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
Subject: [PATCH 0/3] Pwrseq/serdev fixes
Date: Wed,  1 Apr 2026 12:37:32 +0530
Message-ID: <20260401070735.107162-1-manivannan.sadhasivam@oss.qualcomm.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=B+O0EetM c=1 sm=1 tr=0 ts=69ccc447 cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=zTATW481NYPnotdwU90osA==:17
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22 a=fsC5vgmolQPFgTpzX2QA:9
 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-ORIG-GUID: RYCWVpfquvzi__S4Q0axygaIoqTDkk-X
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDAxMDA2MSBTYWx0ZWRfX4FKnGPoMka+a
 A3/4NsowrPX3FWq8UNrTmUiDpt0MsHZQk6YPTVWrJ7BMPzqZr8FLy9KCbP1gruLxqOakXDRr15/
 qpkF+1PuP94xzk8OGFBa7/fc8J8FX/tzZvGrrUMkgoPqGHULcH8Tr7L6GG+bMGsynlK6XLOkKLk
 hi0euyAny0LZo3L4rmaobJuzfsg7iuQChoLGyCGrc8O6ZzJebgcFdV0d66P2qciM/D/3RN64hUd
 wyepQ79nacwSkydTXf3004YgO4TZx3PZGlZfi47s9Z39x+Bo2Pzusnm9/nc9MjTdJyQUuWXTyDM
 r/9IJ21Z+xQnoEzaMowIQbtAMQ9aUiADl+AZGaQfD+msDQR9M9GZFxbHZlUCNtJXPi03gYLDqFP
 0vWxpMl0oJ/sp9YpSIh5WoRUjRnPV8zZ4iJK0PgVGyf59D5xSHVCMTqaZ9RCQUtJRpoutbcSm44
 deGe/kVRgVZSqCDyPow==
X-Proofpoint-GUID: RYCWVpfquvzi__S4Q0axygaIoqTDkk-X
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-01_02,2026-03-31_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 adultscore=0 malwarescore=0
 lowpriorityscore=0 spamscore=0 clxscore=1015 suspectscore=0 phishscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2604010061

Hi Bartosz,

This series fixes build issues reported by kernel test robot on the recently
merged M.2 Key E pwrseq series.

Patches 2 and 3 can be squashed with offending commits, while patch 1 should be
applied separately.

- Mani 

Manivannan Sadhasivam (3):
  serdev: Add missing stubs for serdev APIs when CONFIG_SERIAL_DEV_BUS
    is not selected
  serdev: Add CONFIG_SERIAL_DEV_BUS guard for
    of_find_serdev_controller_by_node() API
  power: sequencing: pcie-m2: Guard the helper functions making use of
    PCI bus notifier

 drivers/power/sequencing/pwrseq-pcie-m2.c |  9 +++++
 include/linux/serdev.h                    | 46 +++++++++++++++++------
 2 files changed, 43 insertions(+), 12 deletions(-)

-- 
2.51.0

