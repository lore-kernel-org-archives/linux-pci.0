Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B60F3126D6
	for <linux-pci@vger.kernel.org>; Sat,  4 Apr 2026 08:53:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775292798; cv=none; b=HdFXPlns7xZ5jjGuS6J8B/1HrJSAl3eb7fLY3aWqrU/m5EU0PasPjYjld4/opHdJCMISc7kVA+tIoibLJNzrRey4J8nDYKG/Y3i0I4oPdOjRNlcByFh9aEG0l+Jfc+aIZK6e10w34coF2qd7+D7Lfx504ZfTgCvjYtPn2gaGsVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775292798; c=relaxed/simple;
	bh=9OJ4UNKQcRb8Ws8QLo61/dvK/QzgaBZThrXn5UYtEf8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=e00D5Avzrltan31DXgDQ0ltjrPDGxMgRNqlrh0ymFm76dWi9RiskZBFVw6BZcjhITXyFu2iIumYgPYU8WTrVCecLIpJRLcbU5k1pt737Dd+j1v8in4UiPJ65OPgBA+Iki40YW1UIpvBPWDzlTuiTZSX9vSf35+2brhFXQeuwvHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=m70sZ2tN; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=iJfLKY3w; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="m70sZ2tN";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="iJfLKY3w"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6340KOiv1310266
	for <linux-pci@vger.kernel.org>; Sat, 4 Apr 2026 08:53:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	euurnDdp2gg95lsunKzyUav3a4dM9U326nl7pdJ2T68=; b=m70sZ2tN0SNU37Zx
	LwlhVXTw8AEzLK6eDxWuy8FKGfignt3zfYfb8EgicZDPXmVGi43xJUfnRGfap0iK
	oAgPobK6Ix8Igb0LfcjBRcG4GG5X94cr91Q7YOGn1ncnZ1nSY8X1ak6nMvqKe/XP
	IeDPnLZQ6OwUZ16ODSSE7F2x3EpY/gbIMy8xAqvISQ/qr4eYfS+zUrrVbDCIosPt
	64TyLsVl3o4vSGzya/x46Gvr75pGvrVOwB2lAq9SuRGbMaeAP7DPYDW/UkHP512R
	TxM6L/Y/OPtP+UiREgRHvrq+ZK07SCgd2NX32Xc0zQyJ+Prdh1+XWOyuYxZLRJ3I
	75hxsQ==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dar0mgs0f-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Sat, 04 Apr 2026 08:53:15 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2b0b57e192bso20248635ad.1
        for <linux-pci@vger.kernel.org>; Sat, 04 Apr 2026 01:53:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1775292794; x=1775897594; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=euurnDdp2gg95lsunKzyUav3a4dM9U326nl7pdJ2T68=;
        b=iJfLKY3waIjvvJgHDFHO2itJp7X/Pk28sMAyjE0Qf7pPVI9mlqggLdgTPkod3gNVZl
         YZaQFzuo0hcP0ZFCQNiyQCiyIBtcDBgCSKeqHjvP0u+kRLUIS95o6lDNhoHgn0scWQSu
         EZ9oxPgfLOoco6bVv7/EkM8sCI6sPd+7K1ZuMlqGUsncp5vEs4OtH9A3WYyhrTqjFjLE
         lUqAfUi4Nx3kxORgKJ9LeQg3bb0SCaAiORz5zOPnwmXbGANs054xCK+dgZnPGoF3mZaR
         PWE/WT9OQkhxh7maa+m3bf+aGNBJFdQjk/8BKwClB49g9PIEFZlALYuPWJpq/tg7Rp13
         R3PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775292794; x=1775897594;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=euurnDdp2gg95lsunKzyUav3a4dM9U326nl7pdJ2T68=;
        b=oIw3X0z+hDCBO6+8i/HTFi/aRd2T9MQvpQFpfPqP0n/YS5fkIPT1ip8gwJFZJrrCzg
         rYKQ2sJmFkaqvHOUXySrRVRlRAIcRidtxEd6MyEsLlCQd2/4yZvH9+EBstTtqa+KBOz6
         rV3yPwuw3S95mwJK/Xcx8xb4HhzLShVkLCc9k5C60qG7X6GB8LlB8Ci7HaPsp8MBFnz2
         aftSJrf0Od8iBYXYwzS+Og2LdujPIzGhkt2GJzp7OCZWfuNhQHtBdaU8mCXd/lUhJJL2
         0QuHHzHEapZmoE0vc40B3VK9I8txNo2lPwFpoSJJ7ZNeHlkWbwg+UMIQljn8wrWjhLBE
         zhCA==
X-Gm-Message-State: AOJu0YztStLANggryTVvocOjVAAxQK610DjkfgPk132CqoHshs1R3OT4
	0eijkGQAQlHvq2+bawQkdjCIHNE4mGGR7I1aT0wyj9SoVT2kZNKly4u6+Rh08jbZ3M5xlBdXM/E
	Y2OE3A/TN4S211FgNqGUr2YtBN1LWhwmaxPcvqt13ZLIBA60BSQyH/1cIib2zIlPlQaqAKJo=
X-Gm-Gg: AeBDietJuFVdw+TSHhuzpINdL00ZETixPlEi33vkHirjXcpbgrcokLK8DPfr29HpsvS
	vhjzi3nKw56P63HRE59TcX0eEuidjhL5QHkeYCAkGImkZxRjaaa3OSwSyeMB48XAvlwMciOG+/B
	5N5/s219KZi6ToQu9JDC11D99V7KaLGvbF1XzaiZGSQqCxW5pk/zEuOOZlU8A6EhndKR+7rqu9q
	2FCiqpu2kvoRM5y0Tnm4a4lds2WbqhiaI4JqpHr/7iBl8tFklBsJc08ya2sbp2qLRnAdqiEUDPG
	QSb/5g1PcH687Rq1rMIVDP5zhwhnlgVQElM7VlrHI+RiBc7+AmCPY6H+Pb6mFtTKiBwv76Eqx8U
	cSL+vaJQGrZrPScrJo52bj5DpkuswHT7ttXXypf5fPt+d6VClcTWfD9WM
X-Received: by 2002:a17:903:18a:b0:2b0:9c2b:641d with SMTP id d9443c01a7336-2b28164c170mr64609705ad.2.1775292794142;
        Sat, 04 Apr 2026 01:53:14 -0700 (PDT)
X-Received: by 2002:a17:903:18a:b0:2b0:9c2b:641d with SMTP id d9443c01a7336-2b28164c170mr64609525ad.2.1775292793610;
        Sat, 04 Apr 2026 01:53:13 -0700 (PDT)
Received: from hu-krichai-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b2749e2e97sm106883085ad.82.2026.04.04.01.53.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Apr 2026 01:53:13 -0700 (PDT)
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Date: Sat, 04 Apr 2026 14:23:00 +0530
Subject: [PATCH 2/2] PCI: Fix NULL pointer access in
 pci_store_saved_state()
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260404-fix_pci_access-v1-2-416f32c6f7ec@oss.qualcomm.com>
References: <20260404-fix_pci_access-v1-0-416f32c6f7ec@oss.qualcomm.com>
In-Reply-To: <20260404-fix_pci_access-v1-0-416f32c6f7ec@oss.qualcomm.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
        manivannan.sadhasivam@oss.qualcomm.com
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1775292785; l=2834;
 i=krishna.chundru@oss.qualcomm.com; s=20230907; h=from:subject:message-id;
 bh=9OJ4UNKQcRb8Ws8QLo61/dvK/QzgaBZThrXn5UYtEf8=;
 b=YtTtpgacAWIa6+gDdtLCAfY+uvhDy3uUYQ8KKTtVJGF3HsC2IxyafsNdiEwAqgCcH7zPAiSfy
 YWoi4GOcxT2C8FXP8HmGN2DjGb8ZVujMMY3bMfMJJ1gASRpVQR/yfdW
X-Developer-Key: i=krishna.chundru@oss.qualcomm.com; a=ed25519;
 pk=10CL2pdAKFyzyOHbfSWHCD0X0my7CXxj8gJScmn1FAg=
X-Proofpoint-ORIG-GUID: V7BrWV825S4sGiaRPVfkQmBm19ZAFEty
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA0MDA3OCBTYWx0ZWRfX+r58W11jnVre
 FfOYdISkj0HXtBIgefGsQqpatpIMM+NjNI3XwDYpcTMSy2iuuYLFcPJ6di5/3o/j/WcNmTI+HQQ
 AyMLdUSzJJhRGjazfP4UzqZ7XJVNp7QTxae2W/64bFKYzYG110YITesm2xevu6eKgnFa1VMHTbg
 N4pKgdegfOQaSZfk17BR7AaPISIYom96Njj+wX6OFeVWkewkGrqO0WNpJX7KA6sX7pUqeXvb9yp
 KU23W9uaXwr5GKHS6scKNnu3a4IEnDq5aSg9PJJ32ChNhv/lH4g1lnefVTq5IveabUBabO7GZW9
 TOPo6ZHoQsrceP+vB0AYMhzzSilk+KISjstSyanYyZq9POLevfTo6dEFg4CHs6uvNzzfouYJoHq
 q5z3SyieOwjbRyCvWPbPGV+gbV2TkkPCDZOalGFKJdM0Ka0dNLgoUEjcOz1fDf/m7MymPMViQHA
 8pesJi3Od0ImVsrvnjw==
X-Authority-Analysis: v=2.4 cv=PpaergM3 c=1 sm=1 tr=0 ts=69d0d17b cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=EUspDBNiAAAA:8 a=SbfQo5s_ALff5BtGSsgA:9 a=QEXdDO2ut3YA:10
 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-GUID: V7BrWV825S4sGiaRPVfkQmBm19ZAFEty
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-03_07,2026-04-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 phishscore=0 lowpriorityscore=0 bulkscore=0
 suspectscore=0 priorityscore=1501 malwarescore=0 impostorscore=0 adultscore=0
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

The call stack of the issue as follows.

[ T1634] Unable to handle kernel NULL pointer dereference at virtual address 0000000000000013
[ T1634] Mem abort info:
[ T1634]   ESR = 0x96000005
[ T1634]   EC = 0x25: DABT (current EL), IL = 32 bits
[ T1634]   SET = 0, FnV = 0
[ T1634]   EA = 0, S1PTW = 0
[ T1634]   FSC = 0x05: level 1 translation fault
[ T1634] Data abort info:
[ T1634]   ISV = 0, ISS = 0x00000005
[ T1634]   CM = 0, WnR = 0
[ T1634] user pgtable: 4k pages, 39-bit VAs, pgdp=00000000ac2ed000
[ T1634] [0000000000000013] pgd=0000000000000000, p4d=0000000000000000, pud=0000000000000000
[ T1634] Internal error: Oops: 0000000096000005 [#1] PREEMPT SMP
[ T1634] Dumping ftrace buffer:
[ T1634]    (ftrace buffer empty)
[ T1634] pc : pci_store_saved_state+0x40/0xd8
[ T1634] lr : cnss_set_pci_config_space+0x54/0x100 [cnss2]
[ T1634] Call trace:
[ T1634]  pci_store_saved_state+0x40/0xd8
[ T1634]  cnss_set_pci_config_space+0x54/0x100 [cnss2]

Fix this issue by bailing out early from pci_store_saved_state() if link
is not active and also make saved_state = false.

The link state check here is racy since the link may transition at any
time. This is a best-effort attempt to avoid saving PCI state when the
link is already down.

Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
---
 drivers/pci/pci.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 1488c93d4e22371480165cb55afc7a0c3cae238e..06bd6b7d62ec1a41bd12af2ab47ecd2b77665c7e 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -1875,6 +1875,16 @@ struct pci_saved_state *pci_store_saved_state(struct pci_dev *dev)
 	if (!dev->state_saved)
 		return NULL;
 
+	/*
+	 * The link state check here is racy since the link may transition at
+	 * any time. This is a best-effort attempt to avoid saving PCI state
+	 * when the link is already down.
+	 */
+	if (!pcie_link_is_active(dev)) {
+		dev->state_saved = false;
+		return NULL;
+	}
+
 	size = sizeof(*state) + sizeof(struct pci_cap_saved_data);
 
 	hlist_for_each_entry(tmp, &dev->saved_cap_space, next)

-- 
2.34.1

