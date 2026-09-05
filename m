Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3F4D2D9797
	for <linux-pci@vger.kernel.org>; Sat,  5 Sep 2026 00:49:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788569346; cv=none; b=sSMisY23appE1RamVNFzp3zmmRvLb788hq21evUVcJL/o3yUAbErlycHS27JjmjOuoqinL6oDm5U/ak6/0K3IkeWO2In8IIfCWiqNdWJvhzRwgprLyqSP/NMSgPNgDz39zlyy9IckWrad68T7rA12H7BybiQMaHR0EnHJfZefY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788569346; c=relaxed/simple;
	bh=gAOxe8D8ezjmPkGY8tlvbx/ZaBc1qPDs3SKHe4rDs94=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=gDBxPqRIweDwJuumZy8btHOGs5HB0V28MffVv0YQJ6n317JjRkqC5xl3UN/sDExABZnBJI+SdV7nCT81OhhM3mLNo2ZGSOhqfwJaGRJ44zfEE6r486Rs1j9HHf1ROiQ4mbfWpjlmPILSSrE9avHWyHHRwHSvFUqdCJp/8Wo9Qpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ZztJZyze; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=IMXwZNLZ; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ZztJZyze";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="IMXwZNLZ"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 684Kbni7731764
	for <linux-pci@vger.kernel.org>; Sat, 5 Sep 2026 00:49:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=qtJXCSE3Y81SmSYRcrf9Q3
	T7wUHCMX8Om07mHZ9jbNU=; b=ZztJZyzeLhZtF2sNDed9th4ba6HwB+fiHa+/M/
	hcdKDIwBtjBtbFmTnzZcBAME4SWm/dIqQrjcFThOAfd07HpPWI02N9m0tJap6hdo
	BSfTjLq9cu7OkSB9wHbCDb2+bIBsBaPA3Sq970l87t1IfaFX/rbAVCwuRVJfSE3S
	FozhQ/m3E5336V/gL79AXzyKDEEFEcwNQVV0KWUMZxkLRgD2kpXe0L2grh3ydZxU
	l4qIqbxHxKQmcagz4kFpM9pjVxVh2IfeXs79JAVXAygRklfkznN/Sqs5Ixl/Ih2J
	zI0LuxNbDjEYPZzqu05GWOFIN0uQCaXfGk7GLRR3F7xu2rsQ==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gg011js5m-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Sat, 05 Sep 2026 00:49:01 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-38f5ac7416eso1882617a91.3
        for <linux-pci@vger.kernel.org>; Fri, 04 Sep 2026 17:49:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1788569340; x=1789174140; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=qtJXCSE3Y81SmSYRcrf9Q3T7wUHCMX8Om07mHZ9jbNU=;
        b=IMXwZNLZcYqvHPruF6Yx9/fEO3aaqUQmUUhxiLdRGa3LhyuuMSACDCjclO2FI8LKAC
         i3U6WWubZnI6wDR1EycQdT4E4FtUWV9cCduYHRxalm/R/tPszc2TLTrTvwY8CWGBbGJU
         poEBLK3PQaTHOCG6IQghldXVjChB6r5DxHs7vm982/JZU+tr8EfKnL3m0N6l7SILD+TU
         W74z3q5t5avQYifuO5Lbsa/hkm48jFkL2W4KlYfQt9J45rKc/yJEiUlnpVu4s5dKp/z7
         DHJ64wJYm0rH0zmtzFtFW+q+hHStoI03AKJwuGmgRxpr1FUby5hrCfRVtF6rqSw4alOI
         9FsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788569340; x=1789174140;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=qtJXCSE3Y81SmSYRcrf9Q3T7wUHCMX8Om07mHZ9jbNU=;
        b=s/7IfR+FE5bxlhGyxlFZgofGvleKAKGZNy7m/b82Fs4KjZcafUEOI+jLScjSOYZRnA
         fI7knMmNZaFEP01RbciqL6bIydDcf9cECXYvgbdJo3a6gpo33j8PhKF49we6XleF3bVq
         xu3rn4JSmfLgxc3hvYdAHiYFEXoCV8MRysMCGr9UNFc8MN+3PTo/hCi3Jgs+/CP1G9EV
         RPo0vjQ4nNJxQyYKwwKt97Cl477cgjD4do7iqpp9gaC6Oc09hdrIDorxTkVB6tzhx1Y6
         Nul40dMCfwBvMv2GFgUcULHY9+2du1oXrhYk92Hr40Iceey6cIHKZEXVBBlZfQs/ymOK
         b6Xw==
X-Forwarded-Encrypted: i=1; AKwUvBzmA8guhv0CMBOU6VB7jrrBdycptD0tcfqPNhy5kvRezhnNJG//6JaIzFy3pyDw94ziUN5kRpth1pQ=@vger.kernel.org
X-Gm-Message-State: AFuF++nCO78cFx0xSnyx1g2ezyRP1a2TSNvIgvjhLEe8/wagcJXiWym7
	15A37THq9O4FrvWicUHTA9zvpuql6mp0UacXvuj60mEXl3tMpi6RCFdhBn3vapTq0bYCYJ44K0s
	eNRRpop9yjFTfl4IS0Kv93b0Ajta/oiwzvEvmPnfs3RtKUZFrfGS02rq0VgTCNHg=
X-Gm-Gg: AYBFou3Wwb2H3Nbhd8B53PbiBWBawhezL5UB8IxxnF+XjpI8fVqu7fYNpG8XcZ/Lkm5
	YASZW9xA/5xA3NGvY7ElM/F3hDHXx1KzaO6kiMe5Aqxsc5Ihb/Z8JyzTpCP/OTr32MTOYpE57Bd
	VKEpx8ZzQuPJpc+royomDpLxLcFlr0FzjVvVk5R30O8JxxDDS2ZEiIiOPWt7lHdRO8vRkngGSy6
	W6qYGpMfoj04b7MImVeHE2+NCb6DO+/vAE0eBrYVbPYlNSXU0ZwYa7YjECdhN+cVBotcmmhrcft
	1wHAYmRX/4V8ONU2jsJzZn3gcXrZ+CmfMvS4c+pa3Qla22jQTBUF7/pUb9ZB32f23wy8Z2Ri4HK
	yvFUUkXx6jpW5x/UkIpTHLAGK05L2RTMPYoE=
X-Received: by 2002:a17:90b:264e:b0:398:9bd1:3215 with SMTP id 98e67ed59e1d1-39b262e28cdmr14885660a91.22.1788569340004;
        Fri, 04 Sep 2026 17:49:00 -0700 (PDT)
X-Received: by 2002:a17:90b:264e:b0:398:9bd1:3215 with SMTP id 98e67ed59e1d1-39b262e28cdmr14885615a91.22.1788569339556;
        Fri, 04 Sep 2026 17:48:59 -0700 (PDT)
Received: from hu-krichai-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1432441f5f2sm10843907c88.15.2026.09.04.17.48.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Sep 2026 17:48:59 -0700 (PDT)
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Subject: [PATCH v5 0/3] PCI: qcom: Implement shutdown() to avoid SMMU/NoC
 errors on reboot
Date: Sat, 05 Sep 2026 06:18:47 +0530
Message-Id: <20260905-shutdown-v5-0-f0c6bafa1d4f@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAO9mm2oC/3XNyw6CMBAF0F8hXVtCS8vDlf9hXPQxlRqhSgE1h
 H+3xQ0L3Exyk3vuzMhDb8GjYzKjHibrretC4IcEqUZ0V8BWh4xoRousohT7Zhy0e3XYQEXyWht
 DZYlC/dGDse916nz5ZT/KG6gh+thorB9c/1l/TTT2dmYnijPMaSaKyhDJBD8579PnKO7KtW0aD
 orrU771bOPz4CuiCJOyFESYP55tfbHxLHiQ3ECtGWcCdvyyLF8E27jHOQEAAA==
X-Change-ID: 20260822-shutdown-fe8139dff2b7
To: Jingoo Han <jingoohan1@gmail.com>, Manivannan Sadhasivam <mani@kernel.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>
Cc: konrad.dybcio@oss.qualcomm.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>,
        Manivannan Sadhasivam <mani@kernel.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788569335; l=2726;
 i=krishna.chundru@oss.qualcomm.com; s=20230907; h=from:subject:message-id;
 bh=gAOxe8D8ezjmPkGY8tlvbx/ZaBc1qPDs3SKHe4rDs94=;
 b=njcM+UUOTSrby2bBOepOz/PKp3zIo/GeDnLZ310hLzkNc29wVOFVA2XfcHiuWX0MzWEcAGiyB
 WsiMC5K7eS1BdMGLf+9+a2HPyoD9UgJUxtIZea9dUJ83+9tztVNkB7b
X-Developer-Key: i=krishna.chundru@oss.qualcomm.com; a=ed25519;
 pk=10CL2pdAKFyzyOHbfSWHCD0X0my7CXxj8gJScmn1FAg=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA1MDAwNCBTYWx0ZWRfX/bQeG6ItruWo
 A+FVjXKhpebw20sfRv/Cez/7i0OJnySTbSLT4gIVrs0ZfJSAcBAJ7MlM1thyRp8/utx7t2uMwrE
 bbYadnkXkTw9B9+6UwAKqjdKowZ3PJdz0Gq3hZDOclCx0mXsRHw2jC6oyzUuWmLgm7L9o9RaE8P
 Ed2ha5flDCUZRso7ICT7PVjNqIk20Sco3UEDnih7NTt/LHxI0mE6bjLVte+pyjEAdP/EHyxUNvT
 fExosG+f/AmAnj1jEiB6K3CYcb9oBNNfbuvGm1iIhOn3hfZlqBuOLkNxIhOtz2r8oa/mg5O3C1s
 WVUa+FaKwZ/OX7V4wFijIS4B+avJBRvZORkd0nf/13b2FJ9Jzr2nIrfVx2Xru9yUqb5N6Sihk08
 CvaiDd6Z/gYr8zh0GIFzQOVCxSsL8BNkznUMIVaAMASB7rqE3AezvLtz90nXQBV1PTQtvbdvvIS
 fUdvUprdiRN9Cb9c7SA==
X-Proofpoint-GUID: fRVZBodgLJnr2zsppbQaLbxX58sr6wcF
X-Proofpoint-ORIG-GUID: fRVZBodgLJnr2zsppbQaLbxX58sr6wcF
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA1MDAwNCBTYWx0ZWRfX41YdDcO1PGWS
 HHVmsNDWxOpP1kPoJbgDlCqUYi7WKif+U3Hch3uWHy0sdQvYCjlv37QiALmx6r8m53V71x3eJXH
 UGaP6LQKzQ6lcmUPRpjWDefUeT2v2y4=
X-Authority-Analysis: v=2.4 cv=Ibi3n2qa c=1 sm=1 tr=0 ts=6a9b66fd cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=bC-a23v3AAAA:8 a=EUspDBNiAAAA:8 a=VwQbUJbxAAAA:8 a=act9oNzqP66NUailJEwA:9
 a=QEXdDO2ut3YA:10 a=mQ_c8vxmzFEMiUWkPHU9:22 a=FO4_E8m0qiDe52t0p3_H:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-04_06,2026-09-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 priorityscore=1501 spamscore=0 bulkscore=0
 phishscore=0 clxscore=1015 adultscore=0 suspectscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609050004

During system shutdown/reboot, power/clocks to the PCIe controller get
removed regardless of link state. If the link is still up when that
happens, it can trigger SMMU or NoC errors.

This series adds a shutdown() callback to the Qualcomm PCIe host driver
that forces the link into L2/D3cold before shutdown proceeds, reusing
the existing suspend_noirq() path.

Patch 1 fixes pci_host_common_d3cold_possible()'s underlying bus walk,
which aborts as soon as it finds a device outside D3hot and can
therefore miss a later PME-capable device -- something that becomes
common once patch 3 starts forcing D3cold entry during shutdown while
endpoints may still be in D0.

Patch 2 adds a "force_d3cold" flag to struct dw_pcie_rp that callers can
set to make dw_pcie_suspend_noirq() force L2 entry during shutdown/
reboot, skipping the D3cold capability check that can otherwise leave
the link up if any endpoint hasn't suspended yet.

Patch 3 adds qcom_pcie_shutdown() and wires it up as .shutdown.

Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
---
Changes in v5:
- use a flag/parameter Instead of poking the system states (Mani)
- Fix pme_wakeup issue by walking through entire bus (Sashiko)
- Fix Irq free issue by using dwc free msi API (Sashiko)
- Link to v4: https://patch.msgid.link/20260826-shutdown-v4-0-eb5fe9d454ae@oss.qualcomm.com

Changes in v4:
- removed goto d3cold, (Konrad & Sashiko for PME error)
- Disabling MSI IRQ's (Sashiko)
- Link to v3: https://patch.msgid.link/20260824-shutdown-v3-0-81c14bb7a1af@oss.qualcomm.com

Changes in v3:
- Added null point check and use pm_runtime_put_sync (Sashiko).
- Link to v2: https://patch.msgid.link/20260822-shutdown-v2-0-520a68f1b4a5@oss.qualcomm.com

Changes in v2:
1) don't remove the endpoint pci dev's only keep link in D3cold.
Link to v1: https://lore.kernel.org/all/20250401-shutdown-v1-1-f699859403ae@oss.qualcomm.com/

---
Krishna Chaitanya Chundru (2):
      PCI: host-common: Fix early bus-walk exit in d3cold_possible()
      PCI: dwc: Force L2 link entry on shutdown/reboot without D3cold check

Manivannan Sadhasivam (1):
      PCI: qcom: Implement shutdown() callback

 drivers/pci/controller/dwc/pcie-designware-host.c |  5 +--
 drivers/pci/controller/dwc/pcie-designware.h      |  1 +
 drivers/pci/controller/dwc/pcie-qcom.c            | 38 +++++++++++++++++++++++
 drivers/pci/controller/pci-host-common.c          | 17 +++++-----
 4 files changed, 49 insertions(+), 12 deletions(-)
---
base-commit: 39ee38a9fa2eaeff030a6c865abb244597c091eb
change-id: 20260822-shutdown-fe8139dff2b7

Best regards,
--  
Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>

