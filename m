Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A5632C11EF
	for <linux-pci@vger.kernel.org>; Mon, 27 Jul 2026 14:02:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785160971; cv=none; b=T6pMYfIyxol7D6kHmMmu9aj+GUrEzs4bhGcPfnX5jEUagXlBsNQJJA2RxcIu0ASXucRs5Mz9S7EMwdZqRuG97bmBXii1qEvdrjoRGOatamqQs4qi1nGkF6RI3yHRJVY+kbLAZ8b9Q+dnlM7PaPUhz7bDFUMkOqZTjK2YhyrOkts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785160971; c=relaxed/simple;
	bh=5kN/cRMAAFpyxM5YEI12/i1t4RGTZoCvjXWtffoPOCQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=bMmLKK41UZjk678/WGXp24iXL4CB1v3KXTy3JjrDxt6V2GNC9BbGEb9M5fx+t34vB+WCJ7W03UfizyMN8CaqENnPNbiR506hcgjYmgx8vfpyNwisPK380XfCI5jLw+tNiXd7ZyJHwBfFwYJdHVADvoNVRwjLxfzsBd33T2TzjCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=dVlECa0X; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=hX7Ot8iD; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="dVlECa0X";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="hX7Ot8iD"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66RDlsKr4035522
	for <linux-pci@vger.kernel.org>; Mon, 27 Jul 2026 14:02:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	27qbWhE1JX4wnfcS0SKlSz8jUlC1ot/dXb0VTxIWKwU=; b=dVlECa0XB1O56tab
	WeRsguDjWyKMyWdPX9CAWOn+3rQbHqiI5NYE7dn3aXEBqU+Prw1Ne/jiwcXvjhF5
	fENVzBNX4HscW5xYz4/d4c6/dET+0rZth9etKiq6j3fmdKPZ+U/9uJ59OoK1pfNU
	Dqc+XKO9FxO8HAji7oo76b+AyCUaL19GMTG5oWgGzt0KK45Lg7xWOjT8GivKnk+Z
	kEausv7pKJxvv0N5awZbyEGIbZMPmTw6jdIIWA5xIfGJo2ng2NcsWk8Yf9fhCQPs
	G7abd3IbmClANQ/MbOgjEbK/IpLU4dW8VGVqJpX547KljRidGKzirNdag1Vb2l0R
	vMwKMA==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fp30g1j0f-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Mon, 27 Jul 2026 14:02:48 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-c9fe4c5eb39so1852234a12.1
        for <linux-pci@vger.kernel.org>; Mon, 27 Jul 2026 07:02:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1785160967; x=1785765767; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=27qbWhE1JX4wnfcS0SKlSz8jUlC1ot/dXb0VTxIWKwU=;
        b=hX7Ot8iDGPfT3aDAr97nM8l01vrOnrGGZlRDPQ5C8uQlGip6KhRCKy2yU4skkaFaXI
         YffmLWAKo4pfUfYkrAQ0ACVJ5cpok1Jc9qGAoHlMgJ2nVtkuJ3A/iGnZkuls0fbXdlab
         9mMnhoovB7RHaI36A0KnzSMkMuwmRKD6WZ92PXsiNKDMhQg53AwsmISHfXzWJubdH1hU
         7YMWklc6DfCZPbgbmzIR9fQ8TdcOw6WPgu0ZJZuM4DpSq47K8cLmT/nB4LFW803OAq8k
         XKs4EPYAWNyqQEPCkJ77Nxp+TCIjbxr5JOp9DHyhicZ5yrBnRJ7TWGE1wRDL0q1isYPC
         Dn1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785160967; x=1785765767;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=27qbWhE1JX4wnfcS0SKlSz8jUlC1ot/dXb0VTxIWKwU=;
        b=dLRAx45WYOlJP3x6MfsMUL+exnuXLTVYuzQ1KyxGrY37LKUcXxZqKCRKTUtj0DzqTQ
         yFqtquILjuzTwT64WEmNRSLDPWQfj/ytRXzF7mfVMPnJr3sf8eHyeB6hBkHrkjDl5shd
         Z8tkb9v3N/3gCC8Z1yXtl5tgGy8Id89QyACFuWAlwWGW69+ZAvtEXCTd357WJwM9muvW
         +A+RWutKuTsgXxz34q95rmph8DjGfC+QxCQI9TQLweGk5nVkDKGMsgAETKZCSg9MCyFD
         6xw8fG1DNBoN8mTFlhBv5ANEX+vPHYZjc/9xgf8nUJz1R7SUwBqFSyo+pqphdMniYlsR
         fBiw==
X-Gm-Message-State: AOJu0Yy7p2m3t7f0WGyTHI4bH7kOL1XnXJNKonUSKJt6e+KeMnXXUouq
	RvlLx7L2Mq+9s/P/uhNWtxGHLmaNNarcr3ZhgGn/u18MhefoMa1QL1/2wq8ZZFoKv6qS9rH67ca
	kQESeQJIJwuINrVw2uFUAfCMoLSz+TbqfFhhXwejOtJPHae+CUyh+BgryZtdOwZQ=
X-Gm-Gg: AR+sD12ZZx76r5nUIFHrHb2uJIPbNWWAG8OMFuWIYOPq6O8JfeldG+4ttg2j4isWDZA
	TMynu3+GCUIH2sFIwLip41zHuF3FVWYlnpThzvO55rUWgIS6+dztVysxn0vi6doRh5TncOMhyN7
	zfkq7weJ/a2shgSMiTdL1sZ0GcjRK4hpdotFaTyzdCcgmwMct+Ab2ZBSVsaOwxkFqd4MltSHNGc
	bNA4hhgplGgjmatwjfKoahFSn8bv4ARIJ2jxcwcLmHqWKLElSf//SbbA+nBGRHMdZknVK1WIVvg
	eChzzf/2fxcxjcbKX/kh6NDAGaSX8HXsuLqNbhspyl629Qa5uTKSOAWkCaw02Cn1ECSW5ZuC5sh
	8dyT2sAamdVwN1QlBX8ut6h6HRjUCs0kI2OI=
X-Received: by 2002:a05:6a20:d4c:b0:3b2:924c:566e with SMTP id adf61e73a8af0-3c67ddeb79emr7772662637.36.1785160967480;
        Mon, 27 Jul 2026 07:02:47 -0700 (PDT)
X-Received: by 2002:a05:6a20:d4c:b0:3b2:924c:566e with SMTP id adf61e73a8af0-3c67ddeb79emr7772592637.36.1785160966728;
        Mon, 27 Jul 2026 07:02:46 -0700 (PDT)
Received: from hu-krichai-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13e6054598asm13789423c88.1.2026.07.27.07.02.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jul 2026 07:02:46 -0700 (PDT)
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Date: Mon, 27 Jul 2026 19:32:36 +0530
Subject: [PATCH v6 1/3] PCI/ASPM: Use pcie_capability_clear_and_set_word()
 for ASPM disable/restore
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260727-aspm-v6-1-2ebb3ee7ef71@oss.qualcomm.com>
References: <20260727-aspm-v6-0-2ebb3ee7ef71@oss.qualcomm.com>
In-Reply-To: <20260727-aspm-v6-0-2ebb3ee7ef71@oss.qualcomm.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, mani@kernel.org,
        Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1785160961; l=2676;
 i=krishna.chundru@oss.qualcomm.com; s=20230907; h=from:subject:message-id;
 bh=5kN/cRMAAFpyxM5YEI12/i1t4RGTZoCvjXWtffoPOCQ=;
 b=4GOCWJbQHpYIId+8VEYwA7FBmNIjW/+fervHcg2C40d0V35DVp8HOGQ2pC/h06BK3TGcBYHWQ
 oyZbqhrv2YGBrv6KZMDPEtZVIP0IQTUPXMLxAkAVxAgNGdJZDhrxWgj
X-Developer-Key: i=krishna.chundru@oss.qualcomm.com; a=ed25519;
 pk=10CL2pdAKFyzyOHbfSWHCD0X0my7CXxj8gJScmn1FAg=
X-Authority-Analysis: v=2.4 cv=Wac8rUhX c=1 sm=1 tr=0 ts=6a676508 cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=wuQQqu7ThqwHlQwkt1oA:9 a=QEXdDO2ut3YA:10
 a=_Vgx9l1VpLgwpw_dHYaR:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI3MDEzNCBTYWx0ZWRfX4ATXBI4G7JQV
 DPSwinvRs85RgPOmvDCpKwsJivcvgv7D1vJNf+vXR6kTY0w7j95aAVqN1ZxYitiBGzKHnA0e3nn
 zyDF/ufRoZyzyPA/uBCMvsacPVoHmDY=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI3MDEzNCBTYWx0ZWRfXx1pACixvJCEb
 jEIVIbZi0LAiMzKlrtpzVvvODtk5kzfWtNm6tks3iWLIShk0aeDhLyILF+awbSr17/udl7KyJOa
 0fHawb4fUH33+Bv0vE5ocO1al/dXiKlQiHZ5dGSPcQ/My8FcORfYlcSu8ZAPfkLlY9SjBDkftog
 hzcHzMXgYsai0WZzEHVjxY2Q+UYXH+aTx7yci4ogi8AKbkqn7rNjF1dXhH16gecWcPlU1ZgWECb
 axkOLPpQ4+CG6SzVKAcSd9XjhbazvgD3A7926v/Fa5j6AfUqG3zdisaTylJnjeik5tVg5Q5PEea
 ltBFfEqYouBIQM0q6oE9G4gdAep1+aAJ/6kNGwBVZ2PZGBo+UmPLclThLxJPSz+MEoY4dSU/IUe
 wzhuRO6LHMGXKbX4i5cf0tohdonuuR089LNE/o5zSrkBCRHW3L61O2/vLSEyAJNqipJkLUH3QBZ
 iGcAPtUPIwMNH21qQ7w==
X-Proofpoint-GUID: yQGntUA5midduNyABDxL3RKQzO2UNRAd
X-Proofpoint-ORIG-GUID: yQGntUA5midduNyABDxL3RKQzO2UNRAd
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-27_04,2026-07-24_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 suspectscore=0 malwarescore=0 spamscore=0 priorityscore=1501
 bulkscore=0 impostorscore=0 lowpriorityscore=0 clxscore=1015 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607270134

pcie_aspm_cap_init() disables ASPM L0s/L1 on both ends of the Link
before touching L1SS config, then later restores the LNKCTL state
that was in effect beforehand. Both steps use raw
pcie_capability_write_word() calls: the disable step computes the
new value by hand from a snapshot taken earlier in the function, and
the restore step writes that same snapshot straight back.

Switch both steps to pcie_capability_clear_and_set_word(), masked to
PCI_EXP_LNKCTL_ASPMC, matching the accessor pcie_config_aspm_dev()
already uses elsewhere in this file for the exact same register. This
does a live read-modify-write of just the ASPM Control bits instead of
relying on a stale snapshot for the rest of the word, and is
consistent with how the rest of the file already touches this
register. No functional change.

Fixes: 7447990137bf ("PCI/ASPM: Disable L1 before disabling L1 PM Substates")
Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
---
 drivers/pci/pcie/aspm.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
index 172783e7f519..3f9c0f9a1cc7 100644
--- a/drivers/pci/pcie/aspm.c
+++ b/drivers/pci/pcie/aspm.c
@@ -894,10 +894,10 @@ static void pcie_aspm_cap_init(struct pcie_link_state *link, int blacklist)
 	/* Disable L0s/L1 before updating L1SS config */
 	if (FIELD_GET(PCI_EXP_LNKCTL_ASPMC, child_lnkctl) ||
 	    FIELD_GET(PCI_EXP_LNKCTL_ASPMC, parent_lnkctl)) {
-		pcie_capability_write_word(child, PCI_EXP_LNKCTL,
-					   child_lnkctl & ~PCI_EXP_LNKCTL_ASPMC);
-		pcie_capability_write_word(parent, PCI_EXP_LNKCTL,
-					   parent_lnkctl & ~PCI_EXP_LNKCTL_ASPMC);
+		pcie_capability_clear_and_set_word(child, PCI_EXP_LNKCTL,
+						   PCI_EXP_LNKCTL_ASPMC, 0);
+		pcie_capability_clear_and_set_word(parent, PCI_EXP_LNKCTL,
+						   PCI_EXP_LNKCTL_ASPMC, 0);
 	}
 
 	/*
@@ -927,8 +927,12 @@ static void pcie_aspm_cap_init(struct pcie_link_state *link, int blacklist)
 	/* Restore L0s/L1 if they were enabled */
 	if (FIELD_GET(PCI_EXP_LNKCTL_ASPMC, child_lnkctl) ||
 	    FIELD_GET(PCI_EXP_LNKCTL_ASPMC, parent_lnkctl)) {
-		pcie_capability_write_word(parent, PCI_EXP_LNKCTL, parent_lnkctl);
-		pcie_capability_write_word(child, PCI_EXP_LNKCTL, child_lnkctl);
+		pcie_capability_clear_and_set_word(parent, PCI_EXP_LNKCTL,
+						   PCI_EXP_LNKCTL_ASPMC,
+						   parent_lnkctl & PCI_EXP_LNKCTL_ASPMC);
+		pcie_capability_clear_and_set_word(child, PCI_EXP_LNKCTL,
+						   PCI_EXP_LNKCTL_ASPMC,
+						   child_lnkctl & PCI_EXP_LNKCTL_ASPMC);
 	}
 
 	/* Save default state */

-- 
2.34.1

