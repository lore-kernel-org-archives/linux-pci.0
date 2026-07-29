Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 004FF4EA383
	for <linux-pci@vger.kernel.org>; Wed, 29 Jul 2026 16:50:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785343819; cv=none; b=AjY2vuv9JA9hevZTm6JAKN8sOKQxfW46OVh2NUveTLeGQ5IuK/ZtjTecf6L6Hrq6twe/9b5AJyKtYiss032DL/VhK9a5QAsjBhVcNEt133Mte3dmQ/+slzLJkBpi/eDK3TTz9C3Cc6UpM1hYA+rVgpy4t12vV0Bd9hY7j646LzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785343819; c=relaxed/simple;
	bh=UQwa13iaxzZkTRB0tA0vUGczWZQ/1fcqnVj64elJkaw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HZNfim8wU5Y5brBoQ4r4dkkdsLTVj1EOqYpi/1CCXCXbGCqaUFJJrCwF4jSXS4Fw1c915LsAAqoJfHBvrfNw9gssXOa57cUxUi2ztul5mxnq36eq4OyMVUdyo6hxi+DVo4lKIxv5L26XaQcE+B8P7tbkAAp7sv7kM9ncFFGNpXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ZBPTA97u; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=XQEkNala; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ZBPTA97u";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="XQEkNala"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66TF2ogq2357214
	for <linux-pci@vger.kernel.org>; Wed, 29 Jul 2026 16:50:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=MnAIjU1OkxLNBbDi46oo/MI63PiOxQ1YVDm
	JnZ7auZ4=; b=ZBPTA97u909JEXeSgUB4I5Tb+aN1kevwi1n+R34QHN63LF/Ttrm
	MLD9on5Tqt2B4KePpW/d7ee1EMwFLvf4VrQauDcGLFxRTjwtrmIntxarLO4j+3we
	p4bUJzAE3Ql02ZRgcxXeSBJXZb0U+G4+kEkScJU/0IVIj49xbSGrwfiXhQmBFsgx
	jwVMRjOg64Mlcr39Rd/pitl9XfJvP7CvkNQjDnIQG1A1LyJGX0Gdrbj3aXf9P/oD
	UfuCBKECv3iawPK214+kcGIOlc8feewmWJmo6Sw4MDMHG4jL6DfOK03TTm7holkD
	H6H0RTq0lhdmm7nGHqmgnI6Nc1pjQXpT1cA==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fqhe99eb1-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Wed, 29 Jul 2026 16:50:17 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-38f57e31b6eso1154396a91.1
        for <linux-pci@vger.kernel.org>; Wed, 29 Jul 2026 09:50:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1785343816; x=1785948616; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=MnAIjU1OkxLNBbDi46oo/MI63PiOxQ1YVDmJnZ7auZ4=;
        b=XQEkNalaPveVZWVuPdFVAhGtvurc9mbXhpZH02mLLeVev+tTtWxskeGHqWfa60Ccq2
         7kQV5YcEtlS3f0jo6W6+vEwdQ4/1/Jm5jeN1Ruq10jNrkFJ9w557zeWC7UrxB7G5Ihh2
         6ZRlHRAqZF3c5gWknnB0pUOU4k3pmiRrvZTNna+I80fL8DldjiXzGm4pFbI+UI7D10mM
         xSgQEP6BhUnz7oh9nbi1Op8qKLYTGTlgJOdZRguyknl9ur1zHa9OtP/I0XSO9Q7b3NnV
         6K5rFYtJ//tnAd1XD6sMwLehIhQmsTqK7fzHXRmJY+bYS5+QzKhUPwwnyRc0Jl3DLmJ9
         dcnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785343816; x=1785948616;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=MnAIjU1OkxLNBbDi46oo/MI63PiOxQ1YVDmJnZ7auZ4=;
        b=RdJePhAZnTBTnBT17SN4G2MQZa/cDP1/ZD0wmwu/3Zu4Z2PoQeUAkzdsmAAys4vuy1
         nTr8GrhbC0tx6USHe+Zd+2oM+xk24QMK3Nm43QP9hnjMwen+p3qO6WOIgSK1J647g2ax
         FtTDdsQNS2m2kswO2/tPg2qlE/u7uPschr2pUkwbnmY+kSr8wKWZRB12CYssmVz1IHpx
         lO4E3K+FQgXM4LKZaS2sE3vuJfdSRO962QvEsfCbQy+9Ucc5Ekmp9Eu3nqQnReWgATU3
         SUV0ja+Ay9ixoBNB69XIjbsc8bMcJcX9n78AkZwQkMBdjwD4y/RASrunKFU5I4thTcEx
         B3Aw==
X-Gm-Message-State: AOJu0YxV7jF0Uw2u9t4oNUATpxWYVdctUDlzuOmZLwtcn7xLBTtUsUIl
	uarpShMkjs3fTcQOtecKSZMovqrBiGPnQtS6vQJv/Kgl7yU7mWyXERVlTlH5EVPn2wipKnF+I5o
	LYV4N6ql51nAg/LUjs3LdKoTtn8rp3g6S+nKXwpTev/84VpKkZm0HW5Wq7UbzCVM=
X-Gm-Gg: AR+sD12Oh+D7zihbibdjFHEuEtbHM5ekwPKS1wETvWKHER25aleuBBYNi5IjGRzGwg2
	DiltZfZiGweNvhSGyaNpl+isyqG4YgOxbn6wZXbSWpjFWPC/uW/tRHkwZrCR6U1gGaW2+oAS/vm
	W3sLh14XzXr52Uflshq98Hay+zzHfCYVy78y3Fw26ghNIQ7QbqLekXnczAFhk/8fsGUpqEcLlJy
	wGIRrF1xMDtz+QBC+06Vox1aEK+FFEDY0L6IMLqGbI5Y/vNxhDc8B3FPCt7pLoWq+yoBfYDpuMj
	J/pCwUvrb7LB3eunDE2hdI12PS8Q5iIEf1eWiwktn54XUfsgqJIA/xUjnoRnRYHr2N2VBbZ3AWm
	d8aeMBR1uJnEhDush5E29/9eiZACt+9nHImBBy5QKCwDJ9vCHTA==
X-Received: by 2002:a17:90b:1d84:b0:37f:f8c5:93c2 with SMTP id 98e67ed59e1d1-38f6a439007mr7225193a91.21.1785343816021;
        Wed, 29 Jul 2026 09:50:16 -0700 (PDT)
X-Received: by 2002:a17:90b:1d84:b0:37f:f8c5:93c2 with SMTP id 98e67ed59e1d1-38f6a439007mr7225156a91.21.1785343815388;
        Wed, 29 Jul 2026 09:50:15 -0700 (PDT)
Received: from QCOM-IvKeorbwK5.na.qualcomm.com ([122.183.37.78])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-31504b124e4sm10742665eec.6.2026.07.29.09.50.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jul 2026 09:50:14 -0700 (PDT)
From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lukas Wunner <lukas@wunner.de>, mani@kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
Subject: [PATCH v2] PCI: Allow D3 for native Hotplug capable Root Ports on non-x86 platforms
Date: Wed, 29 Jul 2026 18:50:05 +0200
Message-ID: <20260729165005.896725-1-manivannan.sadhasivam@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI5MDEzMiBTYWx0ZWRfXx1SqUiSUCzOR
 DqWDnLfGTardradh2afLovXUpCmfosxAgbjlXoKhjR54l3chMF+H2tn4xp70bwY3jlZY8pSNkMm
 0JifPmbhw3ozfdd4xkjvq+y6jhJkSQK1bGB50lM4+fkb8O+ralINvkuU+PSs3hE9cqTEJx4Kf97
 KNdtedUP4DVEruVO36MdFbJZIKqcs4SuG94VzPBVDHTewjn4eAv3mI0GLGbyXTyz21p2zC06W1h
 iLPv8i70ZEoJUJnIsSQoqkyhENTdt6VeBYBLPD0LhuBbBY7Ql7G+KrkLv5N+OG5uk1IgG1+xQ5f
 HFuFrZJrYE9UwG8gZZHYXdEStGnmQxovrc3dHRl9CZakg9JjFZUy3ZENttWJ8XTjczp3LpW8WCB
 dDWIEZea4V21yq3JdZPK7hDHKZAjX3KjxFXK+S8gCD/ofMd7KIOtu8dCjF4CUWXnPwQKmo6L/jR
 aBrWfGHV75ENfUTGRyw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI5MDEzMiBTYWx0ZWRfX9LIW3AVaGapi
 ZsuWynUFg8i0VIXjAptVV0oQ3BylhpNQYFvk1pAkyikPOCr5EXANG0y4GOCmjHZXB1+ePdWJoJH
 5xnbSxda1MmW8wIJTIyT18gRNV4dEa8=
X-Proofpoint-ORIG-GUID: Dk3V8yEd1FuFZAvs2cw-aTvxOzAoY0fc
X-Proofpoint-GUID: Dk3V8yEd1FuFZAvs2cw-aTvxOzAoY0fc
X-Authority-Analysis: v=2.4 cv=EsriaycA c=1 sm=1 tr=0 ts=6a6a2f49 cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=6b9KTzF2XmyQjbB4y/5Z7w==:17
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22 a=EUspDBNiAAAA:8
 a=g3ONwz1doXcTvSXYVIEA:9 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-29_06,2026-07-29_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 bulkscore=0 malwarescore=0 adultscore=0 priorityscore=1501
 spamscore=0 lowpriorityscore=0 impostorscore=0 phishscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607290132

Commit eb3b5bf1a88d ("PCI: Whitelist native hotplug ports for runtime D3"),
prevented native Hotplug capable Root Ports from entering D3 citing issues
on old Intel SkyLake Xeon-SP platform.

But there is no reason to restrict D3 for native Hotplug capable Root
Ports on non-x86 platforms. We recently enabled D3 on non-Hotplug capable
Root Ports on non-x86 platforms (specifically for DT platforms) in commit
a5fb3ff63287 ("PCI: Allow PCI bridges to go to D3Hot on all non-x86"). So
do the same for native Hotplug capable Root Ports as well.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
---

Changes in v2:

* Switched to CONFIG_X86 check instead of of_have_populated_dt() as per comments
  from Lukas.

 drivers/pci/pci.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 77b17b13ee61..94f8a4da6009 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -3020,11 +3020,11 @@ bool pci_bridge_d3_possible(struct pci_dev *bridge)
 			return true;
 
 		/*
-		 * Hotplug ports handled natively by the OS were not validated
-		 * by vendors for runtime D3 at least until 2018 because there
-		 * was no OS support.
+		 * Hotplug ports handled natively by the OS on x86 platforms
+		 * were not validated by vendors for runtime D3 at least until
+		 * 2018 because there was no OS support.
 		 */
-		if (bridge->is_pciehp)
+		if (IS_ENABLED(CONFIG_X86) && bridge->is_pciehp)
 			return false;
 
 		if (dmi_check_system(bridge_d3_blacklist))
-- 
2.43.0

