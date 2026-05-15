Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9F1E13B293;
	Fri, 15 May 2026 14:23:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778854988; cv=none; b=dUymcKpG9H2lZiEIqyOijiWyQldpFGZbtuyjEFmiq3acUYS0SEIU9B0ouQqZ1EZa1BIHDAEQcxJLHfGBEkPJExiW4+HZB4NdUU5L8yoQ8rvBF3f5uhv7DWAkgxZRQSCiyYnsmeDddRUllZXBOArG8gQVwbHMA+v6HuZ4IskBZ3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778854988; c=relaxed/simple;
	bh=jG754/zg/fHezUR2cYNtwnmxswJdzLoXuU7aBjov3MA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DD7VRAPqA7TzcvE4qdYMvPEBjdoK+s8QWVWmtoMJst51wwRnGxTFapFzya1Cn5Qb7fUvJE+1MJnasgywiw5pjKjNNTqNrHzAgT0INDw2dXlX9aJy6nARs4qMqbGRkSY3l0WBSfx68TVp/UTHjtJHrHxX/WqyGaZpax4lo/HpAiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=hL1jKHGX; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="hL1jKHGX"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64FAJoFm3950834;
	Fri, 15 May 2026 14:22:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=g4KlT+
	/UVthpwbFx4JCvE3CshQl543UTHh+dqcaYI1g=; b=hL1jKHGXSQz1V1eIGPdpTN
	FmLAwL0Aw5KTNxeXy9eNEOjjXq2sjGdrY5fjYjiVXa658tvSKUTslNc2XTDe1zI3
	jWRHLmEbmPsW5TsLjEL/kuqyxJSBcFfPmXCBnETOsGuYt46LK0++jpkYjNIXq7vO
	BKPFqrNXVyVICXfbsJBZMtqJAVOFnCYaIWzreSEEe+TvkfGS1185TITWoZBuZMze
	tmSWTJh9IyEETuW8mJYh9hbOmOWCIzU//APNr+7Dnpz6VHA0IzMjIAookH42geDx
	yHC5+g0aYpyLePBy9gcyMdTCRS90E0xqI5Obul8rVbGGiIZKfB7zJ9AJ9EWuVahA
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4e5m8ybkf2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 15 May 2026 14:22:29 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 64FE9FLQ022661;
	Fri, 15 May 2026 14:22:28 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4e5kvcuvaq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 15 May 2026 14:22:28 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 64FEMOID51183890
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 15 May 2026 14:22:24 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id AB62B20040;
	Fri, 15 May 2026 14:22:24 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8935820043;
	Fri, 15 May 2026 14:22:23 +0000 (GMT)
Received: from [192.168.178.55] (unknown [9.87.148.246])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 15 May 2026 14:22:23 +0000 (GMT)
From: Gerd Bayer <gbayer@linux.ibm.com>
Date: Fri, 15 May 2026 16:22:03 +0200
Subject: [PATCH 1/5] alpha/pci: Use official API to iterate over PCI buses
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260515-priv_root_buses-v1-1-f8e393c57390@linux.ibm.com>
References: <20260515-priv_root_buses-v1-0-f8e393c57390@linux.ibm.com>
In-Reply-To: <20260515-priv_root_buses-v1-0-f8e393c57390@linux.ibm.com>
To: Richard Henderson <richard.henderson@linaro.org>,
        Matt Turner <mattst88@gmail.com>, Magnus Lindholm <linmag7@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>, Thomas Gleixner <tglx@kernel.org>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>
Cc: Yinghai Lu <yinghai@kernel.org>, linux-alpha@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linuxppc-dev@lists.ozlabs.org, linux-pci@vger.kernel.org,
        Gerd Bayer <gbayer@linux.ibm.com>
X-Mailer: b4 0.14.3
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: 0RQfFO6kd5Exaa6jtq8QmrD1ArL9TjLK
X-Authority-Analysis: v=2.4 cv=Os5/DS/t c=1 sm=1 tr=0 ts=6a072c26 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8
 a=A-J4sBJkw9dRCLvenqkA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: RLHuf12cEa_iVbnPUTeuyx704_HuHZBA
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE1MDE0MyBTYWx0ZWRfX+EkxOtPg5wrF
 y6D79rBTGioZOtYfV7Vzb8wg4gSXWdFSHE66cMnw5FXXd4CWOwMo1wa4T7dgAdjKsk3ifdHl0/u
 3BfpzTFh8GJFOBA00GHRgKoLmMWi3iCLh4txdMyd3E9wHWfJy0QOIaLyySkbhckG+Bt/qUwv85r
 kHNWXv9msrf1cU72WrlxXaDQoCbHraz8ls7fA2bnjpDa+ZgBXsSMjWz3iQvkX2wnWEVGvZ5rKmp
 wwtL5iOGCtu+RlKTAEd1CR2g/JjcSziPxAQdb0dLDN9gafYX7kfFUNUd7/fXFGmbBO2oxzdQg5U
 7s5LfePraJzqA29jPExj4L+RilK/LyadcF4834TJC5O/+7/FadlTYbOqd7mXHdXG3cErFc0UZjX
 5+AEpHssE4CYsFgSEYGfkDZ6YGthHFZKy6iDON38GFZvx+hUbgJ9g+lnjkPceVIuFeQ8qL0hwwH
 U697D83itNRMRPMw0cg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-15_03,2026-05-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 impostorscore=0 clxscore=1015 lowpriorityscore=0
 adultscore=0 malwarescore=0 priorityscore=1501 bulkscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605150143

Replace iterating over pci_root_buses with the official
pci_find_next_bus() call provided by PCI core. This allows to make
pci_root_buses private to PCI core.

Signed-off-by: Gerd Bayer <gbayer@linux.ibm.com>
---
 arch/alpha/kernel/pci.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/alpha/kernel/pci.c b/arch/alpha/kernel/pci.c
index 11df411b1d18..02ec4dbb3ac6 100644
--- a/arch/alpha/kernel/pci.c
+++ b/arch/alpha/kernel/pci.c
@@ -312,9 +312,9 @@ pcibios_claim_one_bus(struct pci_bus *b)
 static void __init
 pcibios_claim_console_setup(void)
 {
-	struct pci_bus *b;
+	struct pci_bus *b = NULL;
 
-	list_for_each_entry(b, &pci_root_buses, node)
+	while ((b = pci_find_next_bus(b)) != NULL)
 		pcibios_claim_one_bus(b);
 }
 

-- 
2.54.0

