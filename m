Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1E143002BB
	for <linux-pci@vger.kernel.org>; Sun, 19 Apr 2026 09:39:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776591588; cv=none; b=fBWBCaAHAyuH1jmBg3BbgtCgwCcYpjZ5CtP6q+7N6s0GAnyBSSwBrcszKbCb3B/VTjtcQKeRd31+C1ENepg214BIZc8athP5nRpT4rmGspFkaJOjsua4IvNhux3zikSQZjUoNXJd9YaYxHIvLlY1xsfcqp4OvMCc6Rjvjo9K63A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776591588; c=relaxed/simple;
	bh=ztP1FvEUzg47Co/oysoK5IQ0Bf6AGcNsGBRBQo2vdB8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=h//dd3OAir0QzZ84SEjznYkyo7ocdDgO0xg/yzt+wDexrRPjMcICFnq0lekruIghGAaSH5pw2cA2mm/aRpE8MWYwifdd3Yr6KqJi6+X9coL9GdqiCB4ushqatjiLFk7gtW43vNOdtCCB5RaJZyj9bsw6m+8ZoR+I+G3bhtFTtDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=hqnmo1PF; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=QnsSK5dJ; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="hqnmo1PF";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="QnsSK5dJ"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63J2EJln1947669
	for <linux-pci@vger.kernel.org>; Sun, 19 Apr 2026 09:39:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=+EAfVkrNrVRYBjRmUBhmAupr5gbmWAIddWR
	E3N5bkFY=; b=hqnmo1PF69wfhEXBJgijfVopoieDCgwCUWyOS5hc36CG8XYhZY3
	1kKvEWRUfXx9Po7QFeLeivUEVCsmK+b4JaviDFhbXltw4A6Vi2UkdFtjod/n/FsM
	COc+ulnZAcjlf1ajYXdiCX0SDn2EDvQgKaoH2jvqm72ebkiPRF0rVILoUR3UMYiz
	6MAvEyHuUtGanTJE7dxJhNwiQApPtxtK1Ap2L9MmYEJpVXJhe172zaGQ/QvaWgbA
	4Az6wYzBpXZIuHB7zOOim6vp7sKWanm3adM50r5Gy/ke6m5fBhxAL6DTCBLiZyJX
	9qRa7VXts0FF/tD4T/XVjcNs98vJtrANZSQ==
Received: from mail-dl1-f71.google.com (mail-dl1-f71.google.com [74.125.82.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dkyanjk99-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Sun, 19 Apr 2026 09:39:44 +0000 (GMT)
Received: by mail-dl1-f71.google.com with SMTP id a92af1059eb24-12c7169f3a9so1522590c88.1
        for <linux-pci@vger.kernel.org>; Sun, 19 Apr 2026 02:39:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1776591583; x=1777196383; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+EAfVkrNrVRYBjRmUBhmAupr5gbmWAIddWRE3N5bkFY=;
        b=QnsSK5dJrdpd1oLNNXim5z1IrOR2Lwe3CyOjqY5c3hwY1usFfDDgY6cTkYC4E3JeMG
         a+nMds/SkARSZeBMgY51cS+thEfPQkwfnofq6C02df2j0PzUQHhYCkqQiCyZ5kfv5X1q
         +g4ljn31SjVYie1fZFTDMax/azHsmuWzW11+PUeREo6mbEyrOlKt5NboBJnWnXR3yLLN
         KwoDBUVU3SAwJg6SnMlNzukWKO2aBHts9fkjxUwnTLzRsVIB2cdrfHrj1f2hwyhBgw2C
         6nob434Zo+1ZR5dqh6ZlaCxU5PCAeFYJG/5meVWqZ5arV9Ngfki5UVTQFQm8nnI78Zs0
         fXgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776591583; x=1777196383;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+EAfVkrNrVRYBjRmUBhmAupr5gbmWAIddWRE3N5bkFY=;
        b=jGJcKQlztPQulNHGHhFs2JgBv2nqLjOT47UwVjU6OMu6/eHPjrpWIG1IGjTj2ytP4x
         4H4UDH4uvNYMdm8Rr9NtRHGBb/mYHmw0J6F05elSV/kShKriYeopyKhh6kGYPu9Fu3o8
         0fq8Vj60Ci8dVVyG1VKDX4K+q8NwvHCKylvzdwpyzswMARRQ1Nn8uflMSo3sFvXS0avC
         NXSEJZcZhV8xGSPv+1uepeI9dQqTN6yD4Ktu8qqmX8Rn52PFpkWnfCnIWIJ/N3QzGQUY
         +UaBYX1RWHUH06MQgM9PQ2ZHm2V5WZqQLSwGjfciuLljWZrpSxYaetm3fFGDTbT0u/uI
         tu+g==
X-Forwarded-Encrypted: i=1; AFNElJ89t7LCNX/FBJ2lC/Z1G8lPr1TkSpr3pe7rksoS+0ptJb1tNhdmkLOg1KYARq1cUj797rDMn5EzDfk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwzCHd9cWisykK4SWjCIPXkk7pA70QDwiFLwP7jOCwYlzaVmB8G
	QkzVaIiXuhYxawQDk9IkEjLKkfnlr9LJZrEMFmv2Txs9lmALb5JNndRxh1GTsrblS+oy8aZXDji
	9lXEUnlnotfdA9FIa45cP3+0/bKvGmH+NLAgZuLuyCWQQOguWxx3onLqwLKIvyk0=
X-Gm-Gg: AeBDieugPtXYqszFdPh+z22Jw24G8MDiXxESfiElryR9esHQ66ttpu/MVcMUsgpnClM
	990qXqQHeuvcPVnDa3gHqDiWtpnwkF0dSmJTVHrO4Oeq/Y7q6Ii6lAyI/6c+BAniyuj9g38K4hp
	7rIVE7Mg2/Hd59+VR5T1Zv0nurk69+X/i6K46UrcvfHIYWE0fX1kmAdKahaRMUZJf0TgeVzGSr5
	6qkx/BA9Gwn/0LjYa/6AfctPyz1g0ceqGlwNpiCv2EdptY38p43sZgRFkzH8AmeovQc6Slv2Q9y
	FSkfRzhpbIRnE7kvC9JThadDPt2OtMHX41NhSbQYaxoNikSY3CL+BiHU0TwlBGesm5QyT/TpJin
	1z4NTvBkXTpftYarns5J+6UHcCKsyIEw/rzy7tpKZuV7/ROnfjihHBQ1qSVR7H/LqdhJrElDQ46
	bClNTrjgrPRdFkvIuo
X-Received: by 2002:a05:7022:1282:b0:128:d4be:7428 with SMTP id a92af1059eb24-12c73f97463mr4523461c88.19.1776591583057;
        Sun, 19 Apr 2026 02:39:43 -0700 (PDT)
X-Received: by 2002:a05:7022:1282:b0:128:d4be:7428 with SMTP id a92af1059eb24-12c73f97463mr4523439c88.19.1776591582472;
        Sun, 19 Apr 2026 02:39:42 -0700 (PDT)
Received: from QCOM-aGQu4IUr3Y.qualcomm.com (i-global052.qualcomm.com. [199.106.103.52])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-12c837f7feasm4775458c88.0.2026.04.19.02.39.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Apr 2026 02:39:41 -0700 (PDT)
From: Shawn Guo <shengchao.guo@oss.qualcomm.com>
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
        Qiang Yu <qiang.yu@oss.qualcomm.com>, linux-pci@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Shawn Guo <shengchao.guo@oss.qualcomm.com>
Subject: [PATCH] PCI: qcom: Disable ASPM L0s for SA8775P
Date: Sun, 19 Apr 2026 17:39:34 +0800
Message-ID: <20260419093934.1223027-1-shengchao.guo@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: Nj8jtWPVJQeM70iyxu5Pei6g02UyIRK3
X-Proofpoint-ORIG-GUID: Nj8jtWPVJQeM70iyxu5Pei6g02UyIRK3
X-Authority-Analysis: v=2.4 cv=SNFykuvH c=1 sm=1 tr=0 ts=69e4a2e0 cx=c_pps
 a=JYo30EpNSr/tUYqK9jHPoA==:117 a=b9+bayejhc3NMeqCNyeLQQ==:17
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22 a=EUspDBNiAAAA:8
 a=z6wLorOCBPHxKQej3YQA:9 a=Fk4IpSoW4aLDllm1B1p-:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDE5MDA5OCBTYWx0ZWRfXwH9CeKIgJgUr
 SfU5cajZ5vlyeBUZM5g3p5TUy+vXygow/DuhxEM/1KJdS8LVEev6BNPj9YbvvgridqrZwD7537N
 +YFSaczdfY4wLNgtgo71dmm/SDzCOKL2t0G/I6B0KdA9kPzHNRdNbNCmVlk11VTrsDPD3+5lQin
 CXHVQ/ZKaRTGWtPKrf3KJu8GJ+EwE8Dl/so7FI6izSzmWHvSTUV+OrKQ9oLnYwaSwwU6ax2OSEF
 vnv6JXumPoLq/Q8fAXQdrYq0pAvG+62W0hLTEwEC/c1b/CsO5nWt/Tn0uVcIYKsO2Q/bAudh3Ud
 e3lFw+qobgE/oOu0kolWv8ZOd1jCIA1yUutd0WtSlNA+o97LtdMIWwypkx9ZTO9pwhsHuiea64s
 zFsqdSwIVQdNCV67YhVYnKCCd6BR8QCDj/tDGjd9KExMLfVXJm0DWVdut+7tXyqV3zlBYe+79+5
 A9ECBe4HcK7IMiWNCIA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-19_03,2026-04-17_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 impostorscore=0 phishscore=0 adultscore=0 malwarescore=0
 bulkscore=0 suspectscore=0 lowpriorityscore=0 priorityscore=1501 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604070000 definitions=main-2604190098

Commit f5cd8a929c82 ("PCI: dwc: Remove MSI/MSIX capability for Root Port
if iMSI-RX is used as MSI controller") removed MSI/MSI-X capabilities
from the Root Port on platforms using iMSI-RX (including SA8775P, which
has no msi-parent/msi-map in DT).  This causes PME and AER service
drivers to fall back from MSI to INTx.

With INTx-based PME active, the QCN9100 modem endpoint sends PME messages
during D-state transitions early in boot.  The level-triggered INTx
assertion coincides with ASPM L0s exit sequencing on SA8775P hardware,
causing Data Link Layer Replay Timer Timeout errors on both sides of the
link.

[   13.069528] pcieport 0000:00:00.0: PME: Signaling with IRQ 332
[   13.082436] pcieport 0000:00:00.0: AER: enabled with IRQ 332
[   13.082447] pcieport 0000:00:00.0: AER: Correctable error message received from 0000:01:00.0
[   13.101347] pci 0000:01:00.0: PCIe Bus Error: severity=Correctable, type=Data Link Layer, (Transmitter ID)
[   13.111281] pci 0000:01:00.0:   device [17cb:1103] error status/mask=00001000/0000e000
[   13.111284] pci 0000:01:00.0:    [12] Timeout
[   13.111313] pcieport 0000:00:00.0: AER: Multiple Correctable error message received from 0000:01:00.0
[   13.130512] pcieport 0000:00:00.0: PCIe Bus Error: severity=Correctable, type=Data Link Layer, (Transmitter ID)
[   13.130514] pcieport 0000:00:00.0:   device [17cb:0115] error status/mask=00001000/0000e000
[   13.130516] pcieport 0000:00:00.0:    [12] Timeout

Fix the PCIe regression on SA8775P/Lemans platform by adding no_l0s = true
to cfg_1_34_0 for SA8775P, so that PCI_EXP_LNKCAP_ASPM_L0S is cleared from
the Root Port and ASPM L0s is prevented from being negotiated.

Fixes: f5cd8a929c82 ("PCI: dwc: Remove MSI/MSIX capability for Root Port if iMSI-RX is used as MSI controller")
Assisted-by: Claude:claude-4-6-sonnet
Signed-off-by: Shawn Guo <shengchao.guo@oss.qualcomm.com>
---
 drivers/pci/controller/dwc/pcie-qcom.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
index af6bf5cce65b..6a14b5091338 100644
--- a/drivers/pci/controller/dwc/pcie-qcom.c
+++ b/drivers/pci/controller/dwc/pcie-qcom.c
@@ -1473,6 +1473,7 @@ static const struct qcom_pcie_cfg cfg_1_9_0 = {
 static const struct qcom_pcie_cfg cfg_1_34_0 = {
 	.ops = &ops_1_9_0,
 	.override_no_snoop = true,
+	.no_l0s = true,
 };
 
 static const struct qcom_pcie_cfg cfg_2_1_0 = {
-- 
2.43.0

