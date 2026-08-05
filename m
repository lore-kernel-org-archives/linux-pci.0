Received: from mx0a-0002e601.pphosted.com (mx0a-0002e601.pphosted.com [148.163.150.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AFD13CB2E0;
	Wed,  5 Aug 2026 10:50:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.150.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785927054; cv=fail; b=hBiYVgJTeKOwND4b96HHzyNVne2piRRsslmdEIxVbGSZvRMf7+OYrPzdDpiYaHKmalEeLRN9jO6AXOMHj5T0pIRyu+8qH8VWSzYnDanDC18vB74UoilZLA+/UB7eHkxGOlp211s02VabEaDbXKZt0Pcl14knGA3/LuTpqxLHjhU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785927054; c=relaxed/simple;
	bh=WBhT/aRwydqj4meOWrOeWj2EIYx45aefE7C8CpM7iW4=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=blcbZUcIha5VHCjd6AEJivjdhLzmy7jalr988QWfT6AwWlcawP8jFxoOt/jtPM6HKt61TllWVLTk0VoKJOXs6f7a1X4ac7dvwTvg0tpLPZ8QNWTuLZIvNy9GoHOyU/Xb1AbUQ3YTHMndpO6EIEdaqD1S4YhpiXr+mIcb8NHPWOQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b=oBczXfR4; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=eFRALH40; arc=fail smtp.client-ip=148.163.150.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b="oBczXfR4";
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="eFRALH40"
Received: from pps.filterd (m0384305.ppops.net [127.0.0.1])
	by m0384305.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 6758dd9c1847099;
	Wed, 5 Aug 2026 05:50:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=proofpoint-05-2026; bh=LdEn8oE4JMtm5
	K3DrrplrsVup9dHgVHMweshSC6WYQU=; b=oBczXfR4sI0XqQ5iZJr0DmpdABeap
	HNNjWu864K3xDwYfKrLTQdi3/PlBos2hOe/pW0lRR++zzGFg1dOMheWcleKr6yiG
	fqUfVhzmUEEZrz4WoNBPfdqWRx58u+BswXuLfZmAwPApevhFCj41WEiyiz9WKbEn
	R8HMt7YHuMNgRyiAS1Lve1ByrhJO4RBzW7o5I1s/g+gqN3FQH0RdAn7ZPTNAXJZC
	cP7E07kU48DFcMP15q6UAXRcK/GwcPe34EPR9Bx+Bf3nk+NYVObYXaYwX92FsNkk
	sGOqMu+0H1/wFv/Qycaldow/EtDpnI8MPKyydRRKWxT+qOuKbqO5LlQcA==
Received: from sa9pr02cu001.outbound.protection.outlook.com (mail-southcentralusazon11013054.outbound.protection.outlook.com [40.93.196.54])
	by m0384305.ppops.net (PPS) with ESMTPS id 4fuuxtu75x-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 05 Aug 2026 05:50:26 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TTjZmodKdC3CwdDd4HaAwT3llFJjGbHT4nPsg62kqUzto7zCwopSWis2zVTOnNuRZEBvLEEbkgx6Aan0h2zlqbcTwwSSqBa2dD5q659and+C+e1r4SHkEUoVEHn9/e9JexuTaph0gtwpETfVF/eY2Z3y4+J1vcAHguQpYoiXtBUe9BRP21ggMifvl1aTOXqbunW4wi9t7FXfdf4EdflcOT2rfkVUJt6b47MGNu+JdPtTURwTJBn122Xgy2NnApXQEpRoplSBjdu9ngf9Igjs1s9bx+SQoW1lNqN1PjOOKaaDbU6Ukj6b7/9d72VBzJoRLNIzSBe696UNuCW+xxDH4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LdEn8oE4JMtm5K3DrrplrsVup9dHgVHMweshSC6WYQU=;
 b=W2WL52Ys2zRYmAierMa69sxaabqcAc1folBHWf/vfJoNSiaK317YLTrAq7j5ox5uEjBG0REQiCj6/XosEiQysZxJF7e1LMx24AdiW+SWeUDOYa6SmPLi1W1gK2F9Af4JO3mi9WI9yOntssE6G3/5EwasLFtLabQs3QeKYKK1AD3U40rwIzePIvIZFM78TmrBPW1Uzd5gdY5X7X3jQ3+4RPxbYVOdPPXtf6WlleIV2wbANQXFdhbJEp0L3s8iJG1l/R35qIUSWSKu8JIM+SaTJI2eIlUftM9jzUL2lRLG2Cr5J8WTsT2non7BM8MilYCUekZBZNMfWz0Abd7y+Pk6xQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.195) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LdEn8oE4JMtm5K3DrrplrsVup9dHgVHMweshSC6WYQU=;
 b=eFRALH40mhOpY4KLKZc5LBidfjNnRmWMRxdHikchTTTs8sHFwRV9TbAP0Whh+kf5vpuw+IutMG8rAv49wr9MNCoU8K4y4fwUshnm/kB4Z2nC/wC91xvI+JsNP4LrjKBnIEJZpq6Ww3f2rU6FEK1rjJIfJWocPoyNsmvVXGiTBH8=
Received: from CH2PR07CA0058.namprd07.prod.outlook.com (2603:10b6:610:5b::32)
 by PH3PPF0C5C46881.namprd10.prod.outlook.com (2603:10b6:518:1::789) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.15; Wed, 5 Aug
 2026 10:50:22 +0000
Received: from DS2PEPF00003444.namprd04.prod.outlook.com
 (2603:10b6:610:5b:cafe::75) by CH2PR07CA0058.outlook.office365.com
 (2603:10b6:610:5b::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.292.16 via Frontend Transport; Wed, 5
 Aug 2026 10:50:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.195; helo=flwvzet201.ext.ti.com; pr=C
Received: from flwvzet201.ext.ti.com (198.47.21.195) by
 DS2PEPF00003444.mail.protection.outlook.com (10.167.17.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.292.8 via Frontend Transport; Wed, 5 Aug 2026 10:50:21 +0000
Received: from DFLE211.ent.ti.com (10.64.6.69) by flwvzet201.ext.ti.com
 (10.248.192.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Wed, 5 Aug
 2026 05:50:19 -0500
Received: from DFLE209.ent.ti.com (10.64.6.67) by DFLE211.ent.ti.com
 (10.64.6.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Wed, 5 Aug
 2026 05:50:19 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE209.ent.ti.com
 (10.64.6.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37 via Frontend
 Transport; Wed, 5 Aug 2026 05:50:19 -0500
Received: from a0507033-hp.dhcp.ti.com (a0507033-hp.dhcp.ti.com [10.24.68.129])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 675AoEuh1269457;
	Wed, 5 Aug 2026 05:50:15 -0500
From: Aksh Garg <a-garg7@ti.com>
To: <linux-pci@vger.kernel.org>, <lpieralisi@kernel.org>,
        <kwilczynski@kernel.org>, <mani@kernel.org>, <robh@kernel.org>,
        <bhelgaas@google.com>, <mpillai@cadence.com>, <rdunlap@infradead.org>,
        <18255117159@163.com>, <unicorn_wang@outlook.com>
CC: <linux-kernel@vger.kernel.org>, <s-vadapalli@ti.com>, <danishanwar@ti.com>,
        <a-garg7@ti.com>
Subject: [PATCH] PCI: cadence-plat: Fix host/endpoint dependencies
Date: Wed, 5 Aug 2026 16:20:14 +0530
Message-ID: <20260805105014.3952686-1-a-garg7@ti.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003444:EE_|PH3PPF0C5C46881:EE_
X-MS-Office365-Filtering-Correlation-Id: 421f57e8-2b3d-4acd-cd91-08def2df58a9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|32650700020|23010399003|7416014|376014|82310400026|1800799024|13003099007|921020|56012099006|10067099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	qN60iV9M/CX3GtbYnMJDZDjSFTyekaz2otCd4beI2s7LC6kxf8qGwzMqTZeIhNUkqs4odyRUhZEsoakGvbBScosi5V5p2wS6ujurUePDe+ABC0ui/l0nDgdo1GZkNQAM3nQjaOUPW5hI+emdmQYBQLJqq65iYRY9SI/1w9PxXLi/SLyOSmrbd2koUfNaC862YoY2xksgJfhj2KeSRkxs9Ug86Z1D9NIUeZGbvMOo9begV67Syl7IAS+uCb1XTGEmhbR9Z98jr/dwD/FzPHGst3s9z5RS3qvWZeD3OZr6L9UX6ApG4Nmb4FA3tM8End9gfX87SGy5kgEee/BcANswC1BuWd4p+TNhtaDQgVrEIrNr5lEZbL01R8ZW+X7dgZglQyqVY/wpJj9DZdvTbhpLYfbjgDpO8rdFFn6n32Wa1q6P+VApIZ8Mq/f+QOuWt5CQooYYNgaBfg2nFOysaACkQ1UKCC9UwCVNpA0DGExpUx9TPN8Cr4jJ9nWy9yJT5k9i96W0WWr0hqRV417hYdfZ3nzRnPt2yGddigQS/3evd2TjCCgnYhapjhaxJHZGXl7rbm9dQuXyMHTcLd5xc5GkqrYhtY+FysX1Q0MLtxdnYYyIg3QpB66lSjCeTOmvIDuUbZEGCUiL4NVHGmLcfRpTPHHJTN4wG+p1me8LrkrgjdEwt+zbXM7wTAj3qHrGXKdf9YMFQAHT3I1FS6Quxonc7CqGZCHKZA24EKYHtGrL2/lIzx+cvOYfExR4/YU5MGMA
X-Forefront-Antispam-Report:
	CIP:198.47.21.195;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:flwvzet201.ext.ti.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(36860700016)(32650700020)(23010399003)(7416014)(376014)(82310400026)(1800799024)(13003099007)(921020)(56012099006)(10067099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	GXCxZ19g4KY2dDyT1jKFcWN9iNfk0wgYAKVDL8GxVS09CgSTwEo5x9I6ALbByvGKrADzvQ3sluU2W6iZWKo8MbTqDvh3mBa1K5H74tyHk9zn8YkJdrB4XG0QMsloWlqDxBXIDwso0Ap0pnZfm3nO70m9PbQeTG5rV4AhwqATZqHr+TWWx3yAT97f3gWbc8JprG0S3XLMoxQqGaHj23Czxas0Ru4fwRjVt6tVyNTQa738X2MOXS5eBmgWj90jgOEuQEdEGct4Es6hBJdwfwXrVd6bFAT39Nl23sv7YNkIWZlPunP+htPCWlVtDq4lYpKh4WoxcVfq9YesQfqUkCIw3LePDD2fS4tAe2jFNKnVV9QnD4ScVWOrPW8gWpi3OwpZ11708RQzu06P7PB/9wrC22tBLlq6NtT8kXQ8zmryvS+5I3kd7A2OVbFhtRRBKMsD
X-Exchange-RoutingPolicyChecked:
	E+fZ0K6khETkPBwqiDJPqWji1OdMlLlQhaJlTr5mnQ96KDUZrsbF9vhYR+DxlfKF+oqBI+tLYf2iIsXtz+BHt9q6n8Z36DWX25cp+kyJauNPBha5ThEm2gyKv4c9DtrsF0aP4U8Dd8q4DvLnUQyfs4RQAOWw7a+6lv8YNKwV40H8LnJNxJoffvghxRieUCAnGOW/eqCIRITrZfriMr6ICHfIibQxSJJeS6Z5n07wI9Wl+nzGphZDclIlQjaGIPxdXx9nZ4Hx0UsuHGxUm/ZRKDzDjC1OnvNvH5BKvyI68l5ZqRZyN2IeTXAiEIzHAprYDKWx1UHl0Lnatgmtmk5jkw==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2026 10:50:21.1424
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 421f57e8-2b3d-4acd-cd91-08def2df58a9
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.21.195];Helo=[flwvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS2PEPF00003444.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH3PPF0C5C46881
X-Proofpoint-ORIG-GUID: cWt1V4u1HXpanB9ePWnGSdSg5otKHRBZ
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA1MDA4NiBTYWx0ZWRfXxdG13d7ArHG5
 nW8HbNNc4GXgRJsK88Z2bVArwuG+eV8mGIk1Udt/JzYOjkWNGABFijCu48GLxT06twMNFdmy6IT
 qUesPG/Z8nYwTXdRdpdTXGzuYKaoHC4=
X-Proofpoint-GUID: cWt1V4u1HXpanB9ePWnGSdSg5otKHRBZ
X-Authority-Analysis: v=2.4 cv=fZKdDUQF c=1 sm=1 tr=0 ts=6a731572 cx=c_pps
 a=S/uo/C2bPHUhgLefKkPNaQ==:117 a=tJyPKKxUohctrY4NYmUjkA==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=Sv0fKeRqtYgA:10 a=V5UXEbMT0ywA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22 a=taLDd7a_hP9WKsMzeGRc:22
 a=VwQbUJbxAAAA:8 a=JfrnYn6hAAAA:8 a=sozttTNsAAAA:8 a=Am7_wLxxUhO668IP2vAA:9
 a=1CNFftbPRP8L7MoqJWF3:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA1MDA4NiBTYWx0ZWRfX4EUNj5knvu1k
 NObJfUiB+j/vXAc/O4reI5dtVlx5AFibaiFSma2wdPWyH+mZL4kbyMmEpCypQ+xAXZ/BxABBECF
 hPPQcJz7+FfXtT60QxsO9nDfm0IQGdRaHKT+rX9Zbr1yzSdw/9UHk+ITTcWzc2SZeolTusIFieo
 +vpOPp7JVKycHAFfnWLn6szgD0h1UjYIZTHE2zjnxqJ999Tner+5D05jG2Sqnly2RIabCeBktkE
 LcZXrTXN4uceHeARBK1TRGXffLNJN9kUmEJZtoY/eeB10PKY3tXlR16SjPUF25uzEciFWRAXeOz
 t+GTh6U/CUcNcW+Gd/5TCq4nfb67dKWxtbAVu2gmKtrWppWgpodru1DWdQ+n4XFS2wzWfWUCfnj
 EMh61kq16qnrVtWQwmDofQSuGNv6zwgffqaBXOPsy6qpkw+j+Vrj+FBzFkGDpQEACuUzDU107nY
 SJguWPpG4E6oOcKsi1g==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-05_03,2026-08-04_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 lowpriorityscore=0 adultscore=0
 malwarescore=0 clxscore=1011 bulkscore=0 spamscore=0 impostorscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608050086

The cadence-plat driver has a single platform driver that can be built-in
or a loadable module, but it calls two separate backend drivers depending
on whether it is a host or endpoint.

If one of the mode is build as built-in and another as loadable module,
we end up with a situation where the built-in pcie-cadence-plat driver
tries to call the modular host or endpoint driver, which causes a link
failure:

  ld: error: undefined symbol: cdns_pcie_ep_setup
  >>> referenced by pcie-cadence-plat.c
  >>>               drivers/pci/controller/cadence/pcie-cadence-plat.o:(cdns_plat_pcie_probe) in archive vmlinux.a

  ld: error: undefined symbol: cdns_pcie_host_setup
  >>> referenced by pcie-cadence-plat.c
  >>>               drivers/pci/controller/cadence/pcie-cadence-plat.o:(cdns_plat_pcie_probe) in archive vmlinux.a

Fix this by moving the 'select' of PCIE_CADENCE_HOST and PCIE_CADENCE_EP
from the individual PLAT_HOST/PLAT_EP symbols into the common PCIE_CADENCE_PLAT
symbol, conditioned on which backends (modes) are enabled.

Fixes: 611627a4e5e4 ("PCI: cadence: Add module support for platform controller driver")
Reported-by: Randy Dunlap <rdunlap@infradead.org>
Closes: https://lore.kernel.org/linux-next/589ea512-93c6-4e1c-83d7-ba45a0b35843@infradead.org/
Signed-off-by: Aksh Garg <a-garg7@ti.com>
---
 drivers/pci/controller/cadence/Kconfig | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/controller/cadence/Kconfig b/drivers/pci/controller/cadence/Kconfig
index 9e651d545973..fd704dec47dd 100644
--- a/drivers/pci/controller/cadence/Kconfig
+++ b/drivers/pci/controller/cadence/Kconfig
@@ -20,11 +20,12 @@ config PCIE_CADENCE_EP
 
 config PCIE_CADENCE_PLAT
 	tristate
+	select PCIE_CADENCE_HOST if PCIE_CADENCE_PLAT_HOST != n
+	select PCIE_CADENCE_EP if PCIE_CADENCE_PLAT_EP != n
 
 config PCIE_CADENCE_PLAT_HOST
 	tristate "Cadence platform PCIe controller (host mode)"
 	depends on OF
-	select PCIE_CADENCE_HOST
 	select PCIE_CADENCE_PLAT
 	help
 	  Say Y here if you want to support the Cadence PCIe platform controller in
@@ -35,7 +36,6 @@ config PCIE_CADENCE_PLAT_EP
 	tristate "Cadence platform PCIe controller (endpoint mode)"
 	depends on OF
 	depends on PCI_ENDPOINT
-	select PCIE_CADENCE_EP
 	select PCIE_CADENCE_PLAT
 	help
 	  Say Y here if you want to support the Cadence PCIe platform controller in
-- 
2.34.1

