Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67B843D567E
	for <linux-pci@vger.kernel.org>; Wed, 29 Jul 2026 07:15:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785309343; cv=none; b=B+eFq4sbFdKp/9t+1vEz+CINZp7I7jjtLQwTeJm1g54DSk8kwnbzcL+50h2Ah2V3ZtQO+4VZws0LHA1GNMhE+adHO2N6fOwn2vE2fzc4NCxUxZvIfzf9FOJmd5vTPRjXFetXAe5lf0vbFZWkK8fBw9R4anntkZglCE0Z2nH0KRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785309343; c=relaxed/simple;
	bh=f/NoF0J/puFoSGNkinciqYDc32AwFK9acqYt7RkPbN0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qVnLk0sxEB6RO6W3PoQdJbki5d0XXKB34vsPELorRV3o4w6gV+a/SPR7WeHWJe/OEVDrvWp33cWir/Gyi+ekK/HiZvFqLec9XRnhI8RJagM7NMP6jQ9Y1w8huPTjjyWDur2wgVOXrBtnIX+PRa4eCMHQ83NUM5Je1gHpuMhvTxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=bELPaZH+; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=UZ3tJSXN; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="bELPaZH+";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="UZ3tJSXN"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66T5hHU5912631
	for <linux-pci@vger.kernel.org>; Wed, 29 Jul 2026 07:15:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=mAxpooPoRyHSYPqcZa8JxZWJc5IpMf0V4Jd
	fUOMMUZE=; b=bELPaZH+DzgtPkYxE8/Rrpmr0JN1HgGjAzvjvFVMq5B/HPdhzuZ
	GGb3VrZIP9Eh9KuGq3NDfURabBgJA9sJKmZu3sQU1jLvJJHTEe1Rdh98wdA1d69D
	X815vFAf863Nq20B2Bh/2en+KMgpGMZTL9qPw/SJzHZxVL1nmJOGYG+U2DIaS0rd
	jOt0mljKUMkYMwYn2i5gW6sPzvjorDtiKgVPjFoh5PldHv1QuySK4WhQBrUgzRYB
	A62CfWv1pTIfj7Skas3iW+lJ953JJux2hTLeLBnmk7sIGsQr5neQsufQipG081yP
	aTJxyeHBDYDpzwmjbbYK9yLsuMEKs69/XvA==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fqbmcrbeb-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Wed, 29 Jul 2026 07:15:36 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2cf1c86963bso17884595ad.0
        for <linux-pci@vger.kernel.org>; Wed, 29 Jul 2026 00:15:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1785309335; x=1785914135; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=mAxpooPoRyHSYPqcZa8JxZWJc5IpMf0V4JdfUOMMUZE=;
        b=UZ3tJSXNXyGvj0a3LA5pG4PHoG8c9jbpQnttQhBzgqGcSW2dyLG7Y7FTgHEsW53CpJ
         4eBp3Ol0ZhfOQdSXoi6lG+r7Xb5VWM3ti1KPLkEL/wPZ3Va1rdEf51eTiZvRUtXpPrRP
         1uMY84C/4SXPjEuMojip/UeRIVpBLs8PNYBQpWpacsTP/NfVdgpzKseKGGJ77P2dcEyI
         Inu3hEAh91fMGj80qi6HBpQgmv5Usz7iezp5EPwzmnCybFIhto6jkhw2uiY6dcEWORYe
         JuZAt7EWLNtR01XfGoBPAZjFG5X4zYIG+fs++0NqVsbeNihFHreAch4P/oaYsIgaLb6G
         StYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785309335; x=1785914135;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=mAxpooPoRyHSYPqcZa8JxZWJc5IpMf0V4JdfUOMMUZE=;
        b=jB8GrkOxwvxn2x899bzs9/Lcz9diC56OFOAnvKm8dnJXEvZAjWc28tyAEjbRNxrw3a
         FlL1sDZGXdZOicc5RbxR6hIujhYU3CibYozkaI0aKBX7HHOEE6HFW0aJREuC/Y7yUBXF
         z20YIFmZJiXjd9IAhnr80T53C1qwd5dKEr/HPSDp4dT4qJDhSJXZqrYWx32WA/Yv2a3E
         AuCN7uOzXC3mRZKJBIW8p7Utw3PJL5qSwGnf983K+81z7Pmtpx6qROUW/QSIG9k+xM9W
         tQy34uyQ5ml+/q5bLJAI+/3GMaD1i4k/2/SH9dgbzxHgJjEWMWJ01eKFEdUGQb+R6cpo
         D8Fw==
X-Gm-Message-State: AOJu0YwPQH6NyrTUSRi56rZunskvhVjO0CL8UGh78cHIfrNbyvZLIUho
	24XcPqCOnCaZ1vS0uq39f7cyHpOPmRha9tXe2g7H5J5T7YgOo4Z+Cgw5fsZcXtLIRKgyStFVXMm
	g/3LbW6zN8+ehDz2l2JrQFR67KxAAQTOVbw03r6jc3wTpKJ9HZ+LD/ysD0hj20Dc=
X-Gm-Gg: AR+sD13K611kCcRb6dnyvfaNv9Y0vAZrxb2aedw73/2NgSiwJSg6V+QnzXaBisaH7lB
	IXXZFPqa3bto90i7sBnnvmGhW/iviW6pr1KPbtoCQjauaYJeJM4q1HyQyxR9uJjgrNqvkNvOgmr
	/xXx27crat46yh2H923KHkMTJrNXB7+bVFkgmw+s+NrGKPUZokUVpXBGmzvuBUASGhfB1nVk9Ce
	/iIYDqZTJEeWujUextyDywrUYuTqw5OxlDYhduCB/SIsz1HjQK9+EjgnFcYiqwgONcBg85PeNMY
	8ZHxAG60zqKfxJBmFRjbNVyYik28ZeoeQOWHjGTe4vhP/85mw09Ru2pUdFETSYmpaD1CVe8qJbw
	WvI33A6HX2GIQsLAdcUriMTS2hWZtrTNfH79vuKH0Mjq0tb8BTWE=
X-Received: by 2002:a17:902:da8a:b0:2cf:bbdb:425d with SMTP id d9443c01a7336-2d0267423e5mr12836195ad.18.1785309335305;
        Wed, 29 Jul 2026 00:15:35 -0700 (PDT)
X-Received: by 2002:a17:902:da8a:b0:2cf:bbdb:425d with SMTP id d9443c01a7336-2d0267423e5mr12835835ad.18.1785309334802;
        Wed, 29 Jul 2026 00:15:34 -0700 (PDT)
Received: from QCOM-IvKeorbwK5.na.qualcomm.com ([182.59.222.122])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-31504cc9dffsm6834639eec.14.2026.07.29.00.15.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jul 2026 00:15:34 -0700 (PDT)
From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lukas Wunner <lukas@wunner.de>, mani@kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
Subject: [PATCH] PCI: Allow D3 for native Hotplug capable Root Ports on DT platforms
Date: Wed, 29 Jul 2026 09:15:14 +0200
Message-ID: <20260729071514.859778-1-manivannan.sadhasivam@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI5MDA1NyBTYWx0ZWRfXzqGo+Fe91BIn
 ZFAOayg1DEHIWCI6XYp5cRdt8Bdv2r639ErRhbIoQ3fzcIaoAbhsS5TXr/UXp8TclnbjKEHGPU3
 nH09Om1RAqCYvIptiYufAbpaFzOrEgnoLLaWjdzrM7DSNQHxaMlnuRx6AT/5nx2Giqew4Pz15wu
 NWMr0Dm2JYPPLwifVP0CjdTCeFaFkrlJenilyj0NcznklC4fLqTRpGObU5yDw4U84e9hYOL9qXB
 mbYFg0qcYSP+ouLa87CascVCSurfdoMywGsOlrJqQmlc7ueu/9aPDa4qGFn4EWH6C4EbUe3FFWK
 p22YyGtPxwQzq/dvKxNZwTYlTdCqoZrDR4U0W7l00JLZ/JGOEABREYlnYdb5vk/GMHMxrSO4TVs
 ZiJsau5Nh134c7vby1IleViLjkxogW6a8hZ88XjtipvwezaKWC9d3J7iixNgzo9zvAhVhA3YWfl
 fEOEQVKy8DD0cqI8Dig==
X-Authority-Analysis: v=2.4 cv=HP3z0Itv c=1 sm=1 tr=0 ts=6a69a898 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=wS5FDIiCEuKSh903GF72vA==:17
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22 a=EUspDBNiAAAA:8
 a=g3ONwz1doXcTvSXYVIEA:9 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-GUID: WwUhllOJ3SwnKH0KsubbC_ERI8ujmYV2
X-Proofpoint-ORIG-GUID: WwUhllOJ3SwnKH0KsubbC_ERI8ujmYV2
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI5MDA1NyBTYWx0ZWRfX7GQZeQ5hJrsA
 ZGwYe7TlBMe6nfrb9rCSEmQdf/95IWCaDy3vZxI3SVda8+SBHPrQ6N8I2WORTzlTpGQ3UatOuat
 2KsaZu4jzTdHlFnTaTx6oqV/PAavNDI=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-29_02,2026-07-28_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 spamscore=0 adultscore=0 impostorscore=0
 clxscore=1015 lowpriorityscore=0 bulkscore=0 phishscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607290057

Commit eb3b5bf1a88d ("PCI: Whitelist native hotplug ports for runtime D3"),
prevented native Hotplug capable Root Ports from entering D3 citing issues
on old Intel SkyLake Xeon-SP platform.

But there is no reason to restrict D3 for native Hotplug capable Root
Ports on DT platforms. We recently enabled D3 on non-Hotplug capable
Root Ports on non-x86 platforms (specifically for DT platforms) in commit
a5fb3ff63287 ("PCI: Allow PCI bridges to go to D3Hot on all non-x86"). So
do the same for native Hotplug capable Root Ports as well.

To honor the above platform_pci_bridge_d3() check, allow passing this check
only for DT platforms, unlike a5fb3ff63287, which used !CONFIG_X86 check.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
---
 drivers/pci/pci.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 77b17b13ee61..d5038bb13837 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -3020,11 +3020,11 @@ bool pci_bridge_d3_possible(struct pci_dev *bridge)
 			return true;
 
 		/*
-		 * Hotplug ports handled natively by the OS were not validated
-		 * by vendors for runtime D3 at least until 2018 because there
-		 * was no OS support.
+		 * Do not allow D3 for native Hotplug ports on non-DT platforms
+		 * as they were not validated by vendors for runtime D3 at least
+		 * until 2018 because there was no OS support.
 		 */
-		if (bridge->is_pciehp)
+		if (bridge->is_pciehp && !of_have_populated_dt())
 			return false;
 
 		if (dmi_check_system(bridge_d3_blacklist))
-- 
2.43.0

