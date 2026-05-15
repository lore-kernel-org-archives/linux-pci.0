Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 837243A7593;
	Fri, 15 May 2026 14:23:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778854985; cv=none; b=JAdUlLe9TPPtsWV1mFHNHTKz3fODm3CgonmVLY2Xv/aKe7eukw2HA/FJMeTxBjQwgOwnVcSut63YyPm5ttIYZ0496o2ZnprRa4TULT6xlN7ijv8ZmyayOHO3OBlvDuoHOjKi88chCVDADO64vorsITGPkh743MrikG0b+86s3w4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778854985; c=relaxed/simple;
	bh=S4I6ZH4b/aezVLAu179Bv6f/dKyh1M8Z4R1vqZCaxvk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=SLz2LrSEHf0a7Kg1X5p+Adk6Asm4arHHkGReroZM43u4rQn3ZQRD3e7TW7bSvpp5M4q1ugB0aek00W+YiRPoMbXE5z9VHzvHq7x2+r9swZNVshB16CW6cJKujeHGchvtqyijxNfFP/pRA6mk2BSZNMRE3t9dn5fKmf7hK8su/9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=PmCOX4/0; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="PmCOX4/0"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64FBTiU64090474;
	Fri, 15 May 2026 14:22:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=ePXGiG
	32ePZCUq++ub2uUTWLQnF7fF/+KzdsGsly5x0=; b=PmCOX4/0aDo+7UG5tlvAVb
	cSqcZxIBQZOEiPJSh4+qXG6v2FjUarxGVwKQ5cXQR/8uewD8qIw+Vawiy84A8YHQ
	/qVHweI/4f4GY0s7Oq8hiqWnoXG3raQ7VcwH9r37S2nY7Wd6DfpBBPqFMbb9Oe/p
	IjU3wCZCTIra2FiLH2Uvdg7RBPQlEHAV4zh2MRE1yNqU55p4wGmvlnxOykpM9kcC
	mlbFYWEgSgeJAvhRmjCM2rv4EK2gbo/XIcVTlAXsULiSzDO954jQT6+MfqaiJO97
	1MxwZylCEliWo7BKTXmjUKmwnHO3O8Htri0k8j0q4DGJRrNY6c0+wdpR0QGRpylg
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4e5m93ukk5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 15 May 2026 14:22:31 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 64FE975D007100;
	Fri, 15 May 2026 14:22:30 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4e5kvcbvvb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 15 May 2026 14:22:30 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 64FEMRbE27722094
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 15 May 2026 14:22:27 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1B94120040;
	Fri, 15 May 2026 14:22:27 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id F10DC20043;
	Fri, 15 May 2026 14:22:25 +0000 (GMT)
Received: from [192.168.178.55] (unknown [9.87.148.246])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 15 May 2026 14:22:25 +0000 (GMT)
From: Gerd Bayer <gbayer@linux.ibm.com>
Date: Fri, 15 May 2026 16:22:05 +0200
Subject: [PATCH 3/5] powerpc/pci: Use official API to iterate over PCI
 buses
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260515-priv_root_buses-v1-3-f8e393c57390@linux.ibm.com>
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
X-Proofpoint-ORIG-GUID: FFfQU0OrTn0zzdD30lRJSC_3o5nA81Sl
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE1MDE0MyBTYWx0ZWRfX0MJB1F+swIDZ
 cDbREqzjGwweWu9LtDXzqRraaE00hp2HmBvfB4Hdb0TMN5q6RdAnSW4eAjeWA1X9W/H5swreQqp
 9L66gh7eZsV+DgyIZf/hOUx1xInEx3cLbpln7ZRsgL8MfywX2Wwq6hdlDJfAZppxDcNFMm30gpC
 zPDwRlo2T/Gf1oSUQV3Hp7AHmsDlX1Ft0OUUscMuas1Rz83PCQ7yRVGQ82Rg5M0DZkbwW8ybBfb
 8IKWlZ5qmxWgzgNOakRqpaQ/mYzWsmEZaq4Myj0x6NzuYeAfD5jKeMHH1oPKAMfwDSqSD9yGJ6C
 jBQxuEIyLd6LZf1dIfGW1L6mYWivyHAs5kFyht1FrSXycpTyfwdfRn/s7+SqkI68NpBXyTB4+r9
 a1agbgMlTSMm0jSzZoMts6TwiGLH4V2/Gr704LRE2nxwtEI3Y2schRKqyJBI23fEm4psOjl9YVa
 J1XDIe2C9Nm4pboY0Sw==
X-Authority-Analysis: v=2.4 cv=ZZEt8MVA c=1 sm=1 tr=0 ts=6a072c28 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8
 a=Nc3X6MLr1OvL3U8oulEA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: wCwM_yqRW6cn_hXtPnpJTdbPYVQduWPs
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-15_03,2026-05-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 malwarescore=0 bulkscore=0 impostorscore=0
 phishscore=0 spamscore=0 lowpriorityscore=0 suspectscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605150143

Replace iterating over pci_root_buses with the official
pci_find_next_bus() call provided by PCI core. This allows to make
pci_root_buses private to PCI core.

Signed-off-by: Gerd Bayer <gbayer@linux.ibm.com>
---
 arch/powerpc/kernel/pci-common.c | 7 ++++---
 arch/powerpc/kernel/pci_64.c     | 4 ++--
 2 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/arch/powerpc/kernel/pci-common.c b/arch/powerpc/kernel/pci-common.c
index 8efe95a0c4ff..1e0be7bcaa56 100644
--- a/arch/powerpc/kernel/pci-common.c
+++ b/arch/powerpc/kernel/pci-common.c
@@ -1417,10 +1417,10 @@ static void __init pcibios_reserve_legacy_regions(struct pci_bus *bus)
 
 void __init pcibios_resource_survey(void)
 {
-	struct pci_bus *b;
+	struct pci_bus *b = NULL;
 
 	/* Allocate and assign resources */
-	list_for_each_entry(b, &pci_root_buses, node)
+	while ((b = pci_find_next_bus(b)) != NULL)
 		pcibios_allocate_bus_resources(b);
 	if (!pci_has_flag(PCI_REASSIGN_ALL_RSRC)) {
 		pcibios_allocate_resources(0);
@@ -1432,7 +1432,8 @@ void __init pcibios_resource_survey(void)
 	 * bus available resources to avoid allocating things on top of them
 	 */
 	if (!pci_has_flag(PCI_PROBE_ONLY)) {
-		list_for_each_entry(b, &pci_root_buses, node)
+		b = NULL; /* Start all over */
+		while ((b = pci_find_next_bus(b)) != NULL)
 			pcibios_reserve_legacy_regions(b);
 	}
 
diff --git a/arch/powerpc/kernel/pci_64.c b/arch/powerpc/kernel/pci_64.c
index e27342ef128b..f816d063b984 100644
--- a/arch/powerpc/kernel/pci_64.c
+++ b/arch/powerpc/kernel/pci_64.c
@@ -227,7 +227,7 @@ SYSCALL_DEFINE3(pciconfig_iobase, long, which, unsigned long, in_bus,
 			  unsigned long, in_devfn)
 {
 	struct pci_controller* hose;
-	struct pci_bus *tmp_bus, *bus = NULL;
+	struct pci_bus *tmp_bus = NULL, *bus = NULL;
 	struct device_node *hose_node;
 
 	/* Argh ! Please forgive me for that hack, but that's the
@@ -248,7 +248,7 @@ SYSCALL_DEFINE3(pciconfig_iobase, long, which, unsigned long, in_bus,
 	 * used on pre-domains setup. We return the first match
 	 */
 
-	list_for_each_entry(tmp_bus, &pci_root_buses, node) {
+	while ((tmp_bus = pci_find_next_bus(tmp_bus)) != NULL) {
 		if (in_bus >= tmp_bus->number &&
 		    in_bus <= tmp_bus->busn_res.end) {
 			bus = tmp_bus;

-- 
2.54.0

