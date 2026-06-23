Received: from mx0a-0002e601.pphosted.com (mx0a-0002e601.pphosted.com [148.163.150.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3410367B8A;
	Tue, 23 Jun 2026 09:52:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.150.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782208343; cv=fail; b=HCZvHNYrsKlHohYLGJZDf6rR3UiXJxa2GokBywiW2F0l717YyjKfRSp6/Xr/M07yp3x69/ZG05I4LC3JxPrXP7yXmYR2TiNHyAeHsCsSZZDT64IQaJzfhVc9cwJn+FRtK3x9D0P+gpdBaiEYzfq3GHMf8Lo0wXrp3RNQbwlL/IQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782208343; c=relaxed/simple;
	bh=8iKSMJfz4WTve1oOoWcCbXP845ngzQG1xJ+bOtI+4ZE=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=jvU2XOaFpngEW9gSHvA6hTx6R+7Vqz4VWl/t8yfD5aOsAitHxwplS9Aosmn7zpL4y88WoLccJqFHCT1qVV5yuO0WLn9IoNEUFghDYPOR9K7/Bi4B2hj4uWGlGrUc0yh0u8uMB/O/+NQQwNJQdShP+KlEndCetC/eAQwYOqtiRyY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b=NE/YMra1; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=j5qY8/Yd; arc=fail smtp.client-ip=148.163.150.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b="NE/YMra1";
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="j5qY8/Yd"
Received: from pps.filterd (m0384305.ppops.net [127.0.0.1])
	by m0384305.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 65N8dE9S3725160;
	Tue, 23 Jun 2026 04:52:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=proofpoint-05-2026; bh=fPyM7g+E0qXme
	niYD2vhqFAZ9Z7LRnfcObOr3BuAJZY=; b=NE/YMra1NMegwtYEraDY0XHBefQax
	QlHbsSwmnp/La5PspFdzvO3XJ+3RHXTptG7mX90cSNTcc7i6KLy/oRNvM3gmFy+t
	Bool+occnuPeRWOI4efNfU2Vv7qnvP+DRirIv4j/dJGyoa2F1B5/3XeH7rRykK0M
	UQWTMdNQwOJ639zwWULxdzXac4vMIs9WMFg+hVtAgrR6GE7rYJZuzpvSNotgiZQx
	OYDx98ri0uWopZkGou4l1NY+mK6h0ITD3IBqq/Znla2CC2oyYY3c2VsKAZ1+jOQB
	BQaXy/wYTuoDA0tpJr5cskclES22k+UnElFyF8g1q9vce4ytexZYvrokw==
Received: from sn4pr2101cu001.outbound.protection.outlook.com (mail-southcentralusazon11012040.outbound.protection.outlook.com [40.93.195.40])
	by m0384305.ppops.net (PPS) with ESMTPS id 4eyptt8bj1-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 23 Jun 2026 04:52:02 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Q+SnRyWg8ZfEVdel0wV2WKfBOS70E2rxAaIzqCZR2CO5pNAUcIsYTSdaUHA/JvVu2vXEUyi+eSRNg7QxemSmwJbzJPspltO3ZXqC1UzsGA3iVl8rG26BW2mQTUMYIPhxFvXt1Iks/7ZFMPfqcaSo1kx82+0c0EtZyGHShMtE1UxYWM+vjEFSaso0cXiothIIX/zpwxdHJFejSyAdQp3oLAFPmuyCWM9KqfDbMhA1tKJm6SD2KG1u3cs0JOxFfyFv4cCm1oREpZ3CzZrKi4TI7u2BaM3uhOuifBr0X06HyloA34hGwho2PD3aSwsf5X3+4P2RLLJdte5lC+rl3Ul99w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fPyM7g+E0qXmeniYD2vhqFAZ9Z7LRnfcObOr3BuAJZY=;
 b=E/6wJHfZk0c8Cpj4jKOr/qtIApXgWsISlJTU/JWUlbx7gzsaviskj73SdEQ2SMN0taDkOwW636dVQgsYxw2TorU7hRHFyH1+hQSJI8uLhdI86g16Hw9zxP8PE1ubjiuXpge6u6/sielXB1tcJwvyodRbZoXZOiDuzZ3to0pDemH29NOzrR4LCOqd38NZsum+CAxs0oq48P2w7QMCafcHE/F0m7zXK7nBbuxLN4bqYDx3PtoP4FeeXJ22dgEl7i/TKbqexmL2UEljNkdb7ck3UsqIlXkXukMLNuP8Dzextt5Oezu08BwHPJKoa3Qp0Q/Ewh5o5iZTUtGxwhEH/+/ZpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.195) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fPyM7g+E0qXmeniYD2vhqFAZ9Z7LRnfcObOr3BuAJZY=;
 b=j5qY8/YdLVedE1JagnR4wUowtcx1BZB040THb/W+Oyed76/XGC2CS4XPc2+xhpiWEmNQ0JqKBhXodY4Icl1mv7MsNQraqmskDvnC5IHeppbKyPtUuZqLqULT52Jf2lKfQvko5sTBKu2mBUhb5HtmYITRFSXYeHCVxugrfqe/g20=
Received: from MN0P222CA0020.NAMP222.PROD.OUTLOOK.COM (2603:10b6:208:531::23)
 by DM3PPF0275307EB.namprd10.prod.outlook.com (2603:10b6:f:fc00::c06) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.20; Tue, 23 Jun
 2026 09:51:57 +0000
Received: from BL6PEPF0001AB59.namprd02.prod.outlook.com
 (2603:10b6:208:531:cafe::aa) by MN0P222CA0020.outlook.office365.com
 (2603:10b6:208:531::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.139.20 via Frontend Transport; Tue,
 23 Jun 2026 09:51:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.195; helo=lewvzet201.ext.ti.com; pr=C
Received: from lewvzet201.ext.ti.com (198.47.23.195) by
 BL6PEPF0001AB59.mail.protection.outlook.com (10.167.241.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.159.10 via Frontend Transport; Tue, 23 Jun 2026 09:51:55 +0000
Received: from DLEE201.ent.ti.com (157.170.170.76) by lewvzet201.ext.ti.com
 (10.4.14.104) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Tue, 23 Jun
 2026 04:51:54 -0500
Received: from DLEE215.ent.ti.com (157.170.170.118) by DLEE201.ent.ti.com
 (157.170.170.76) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Tue, 23 Jun
 2026 04:51:54 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE215.ent.ti.com
 (157.170.170.118) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37 via Frontend
 Transport; Tue, 23 Jun 2026 04:51:54 -0500
Received: from a0507033-hp.dhcp.ti.com (a0507033-hp.dhcp.ti.com [10.24.68.129])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 65N9pnXQ1999592;
	Tue, 23 Jun 2026 04:51:50 -0500
From: Aksh Garg <a-garg7@ti.com>
To: <linux-pci@vger.kernel.org>, <vigneshr@ti.com>, <s-vadapalli@ti.com>,
        <lpieralisi@kernel.org>, <kwilczynski@kernel.org>, <mani@kernel.org>,
        <robh@kernel.org>, <bhelgaas@google.com>, <mpillai@cadence.com>,
        <unicorn_wang@outlook.com>, <me@ziyao.cc>, <18255117159@163.com>
CC: <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <danishanwar@ti.com>, <a-garg7@ti.com>
Subject: [PATCH v2] PCI: cadence: skip the link polling when endpoint not connected
Date: Tue, 23 Jun 2026 15:21:48 +0530
Message-ID: <20260623095148.721206-1-a-garg7@ti.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB59:EE_|DM3PPF0275307EB:EE_
X-MS-Office365-Filtering-Correlation-Id: 0f30e822-de55-4b4e-c73e-08ded10d0f25
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|32650700020|376014|7416014|36860700016|82310400026|23010399003|1800799024|921020|56012099006|13003099007|18002099003;
X-Microsoft-Antispam-Message-Info:
	OjTDbjmOisq8sptb+r9/4ZNCGGwo3gRfxqAm0gp6l+gGeBNfgZIsy44T31IytE2U2+b8cFEItALFpRVNXjmDEnvVK6OGdlDeVxH+mZdwNOd1VWg8cD5TM0kNNkrDgkvrT4firx1LM8+afRpWzP19C5Nb27475gs4qu0I5ON8Y2nByCt0gk59ODIt/EPYBiMjyvwYPkhSu94TDTa62E64wyqQYfi8cnVW3Iyc7vAFVMcK26Ih8C014CSU6LWhKSl9T+J7FJ0d93Jea4vnvQtk4rABbhSJsxu5K7mO0Q3elZ7cuGkE/w252zS62BTWdUXyvMQwj8cFExrV2FWNFAfDPnMjYr8Jlrz11mIgiViTyj0qJheDhxpkz/HPGUjE54guJXsTLG2AP7JDL8sMAUYxoitYT4L2l1duS4sVrV8pIAePS2dH/WbQKg7JryuSZigt2ELXTTi/VTdeALqoh40kdqsUHMSzcx1YQQQNmpjLH3P+S5enU4euTNLRqArVIDJejqXSjBqPAwWQXJYVPWgEdl++U4ZgjuMTTHa2vrOxxrb47zqWs8CZFXnRe+utAIP+FycLzOsZAFcLo4OTIZqeo/mZeZNjHYozp5FE6Nybo6OJSws7Lk1VOgbaHh4nAx1nWMrQmBwj2lbDqDyMQ4KnMFG75/YtSSW/4tsWXFKIQt1q+3z/Ds9KWvoCarf0KafeZEzHsdJGkh4gj0/z0NDHRAlO7D+IlT2fUkG4LstQ1+WNNNn0Bqi7oBIGqx1EcZY1
X-Forefront-Antispam-Report:
	CIP:198.47.23.195;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:lewvzet201.ext.ti.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(32650700020)(376014)(7416014)(36860700016)(82310400026)(23010399003)(1800799024)(921020)(56012099006)(13003099007)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	Pi++htOfinm7j9zh2RKOLUHAFwIidg0Qx4J7XiLnHKA3pqv4C08ga/hWzZzfz593zEWtXssPV6JiycfwX8OSfnWVNzOp0f9NDA7+0QsBIq9sIIRJ84vgGXPA/wID9MvD5O4o+gATMrja/7GKWsQhc2nRe94iDxaJ+ko64k+lWkxD0o2EgkBElMhEd3U2+mEsIFOiBTVE5SCe1STFbCT5uwUztrdjMrFSfRIYOstMYt+ljWg8oZ/aKn9kYpJYL/2PdRlpHfUtvmrflMVTVqYVz92e8a9sGBxd0umwOyh46uE9N2Q156pYJM5uBhcY3c5YHFA/QNuu440qotL644NtLFX0pkTZFsxpRx+XdCou64/WoN2UkOlQwtRbJf9RLdofEMtsuYgoFwvnlYdZsJz6+VrNhysxRkkvomWbgf46AuagAkZL15R6hNrPF4CMtDnC
X-Exchange-RoutingPolicyChecked:
	B05c8ymlu5Gp16Gcc0xHiJWkLG4EKU2o/7bCWoOL34URvMJ2bDNwAukvB138Dlak4iqdI5SzL2A9iwm5B5amTCNBK1oZOx09COqFwuuYSD6eZUDIc9w9D0wOo4xvEbKmybopMo0Wrp9RcDhxnAcJ9RmJzk0Zd0LtXMpYw1gi+djgchhW1Thf350rUsPFrVa81QQZRVSXAgXI8JNxeXEhWcJeyIzaKYUooegNyZfe8k7CQP7yCmkkDj75EyzPEORJdWdbnn/tt6dMSdWPsX7BXzOsosEH/kAumkbcg1G2NheVfJHErZbaKJNejG+1XatnTCA8IH0HsfuluAZJmNO3UA==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2026 09:51:55.0932
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f30e822-de55-4b4e-c73e-08ded10d0f25
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.23.195];Helo=[lewvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB59.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PPF0275307EB
X-Proofpoint-GUID: enmzvRZSvfMSg7A2MenrMOHExuJ-Gl4w
X-Proofpoint-ORIG-GUID: enmzvRZSvfMSg7A2MenrMOHExuJ-Gl4w
X-Authority-Analysis: v=2.4 cv=EPo2FVZC c=1 sm=1 tr=0 ts=6a3a5742 cx=c_pps
 a=zWRuVz0++A3eh/KBGeICZg==:117 a=f+v6EHfkeJbVwR46tk4DMg==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=FelO9ux0wxsA:10 a=s63m1ICgrNkA:10
 a=V5UXEbMT0ywA:10 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22
 a=taLDd7a_hP9WKsMzeGRc:22 a=VwQbUJbxAAAA:8 a=sozttTNsAAAA:8 a=UqCG9HQmAAAA:8
 a=T70fTAANueMimqjG8Y8A:9
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjIzMDA3OSBTYWx0ZWRfXxJQdDVp4v6X8
 FWaGx5kSvs/9eVCXyxFrxmGxw40AR10KQDJlplC6mY5hvPsM3M5rpsyGn4AzOuJ+t9rDBROzdkn
 r1yJahfzd66R1I0IiQy4w5svQioGiwg=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjIzMDA3OSBTYWx0ZWRfX9C7JrIK4Pnzd
 mnXMGlyNtsHevHoFKB3K1cCR8FvbqZZ0XqvA8SMZbjzVcZFJwZ/E5HXAhOWatVC3xzF8zsHPwXv
 DGSqbkrnjNvMkv9USgvhEr/8C9yx60kx/OQdMjVlKRQsdhXcV6fq4lLCiMk+E3qU0P5FMQ8Ci/j
 dBjxw3DjCSI+vuFm9bGZKGv7Z1qLpp2XeqDdbg9T7wMwBybFYeMLpiWNaeFP4FowjchI52dulBH
 sKq0xWQvs2wydyDS0KdK66FflvZA3YRrz+mY8xYBLiFtSeAtr4tmzAret5rdOqujv5uiAlNNv4j
 5QQKwG5V3K9eGd4aT1uiigy/j0o/CqjZRZCpO7gneSM0D3/TxzhFXJcdXiFbN1xYrqev9vUv4Ad
 NPyo7kr8PVhEP/sFKFYX+1Z5RBppjA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-23_02,2026-06-22_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0 suspectscore=0 malwarescore=0 lowpriorityscore=0
 phishscore=0 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2606230079

cdns_pcie_host_wait_for_link() polls on link-up for 10 retries with a
delay of 90-100ms each (~1 second). A call to cdns_pcie_host_link_setup()
during the resume operation blocks the resume operation unnecessarily for
~1s even when no endpoint device is connected.

Add link_down_no_hotplug flag to track link state across suspend/resume
cycles (for the platforms that do not support hotplug). If link was
down before suspend in such platforms, skip the expensive polling in
resume since no endpoint was present.

Reviewed-by: Chen Wang <unicorn_wang@outlook.com>
Reviewed-by: Siddharth Vadapalli <s-vadapalli@ti.com>
Signed-off-by: Aksh Garg <a-garg7@ti.com>
---

Changes from v1 to v2:
- Updated the flag name from 'skip_link_polling' to 'link_down_no_hotplug'

v1: https://lore.kernel.org/all/20260605071922.1724499-1-a-garg7@ti.com/

 drivers/pci/controller/cadence/pci-j721e.c             | 5 +++++
 drivers/pci/controller/cadence/pcie-cadence-host-hpa.c | 3 +++
 drivers/pci/controller/cadence/pcie-cadence-host.c     | 3 +++
 drivers/pci/controller/cadence/pcie-cadence.h          | 3 +++
 4 files changed, 14 insertions(+)

diff --git a/drivers/pci/controller/cadence/pci-j721e.c b/drivers/pci/controller/cadence/pci-j721e.c
index bfdfe98d5aba..48db7a6cf754 100644
--- a/drivers/pci/controller/cadence/pci-j721e.c
+++ b/drivers/pci/controller/cadence/pci-j721e.c
@@ -686,6 +686,11 @@ static int j721e_pcie_suspend_noirq(struct device *dev)
 	struct j721e_pcie *pcie = dev_get_drvdata(dev);
 
 	if (pcie->mode == PCI_MODE_RC) {
+		struct cdns_pcie_rc *rc = cdns_pcie_to_rc(pcie->cdns_pcie);
+
+		/* If link is down before suspend, skip polling in resume */
+		rc->link_down_no_hotplug = !j721e_pcie_link_up(pcie->cdns_pcie);
+
 		gpiod_set_value_cansleep(pcie->reset_gpio, 0);
 		clk_disable_unprepare(pcie->refclk);
 	}
diff --git a/drivers/pci/controller/cadence/pcie-cadence-host-hpa.c b/drivers/pci/controller/cadence/pcie-cadence-host-hpa.c
index 0f540bed58e8..31cf50cff8f8 100644
--- a/drivers/pci/controller/cadence/pcie-cadence-host-hpa.c
+++ b/drivers/pci/controller/cadence/pcie-cadence-host-hpa.c
@@ -301,6 +301,9 @@ int cdns_pcie_hpa_host_link_setup(struct cdns_pcie_rc *rc)
 		return ret;
 	}
 
+	if (rc->link_down_no_hotplug)
+		return 0;
+
 	ret = cdns_pcie_host_wait_for_link(pcie, cdns_pcie_hpa_link_up);
 	if (ret)
 		dev_dbg(dev, "PCIe link never came up\n");
diff --git a/drivers/pci/controller/cadence/pcie-cadence-host.c b/drivers/pci/controller/cadence/pcie-cadence-host.c
index 0bc9e6e90e0e..50abc657a871 100644
--- a/drivers/pci/controller/cadence/pcie-cadence-host.c
+++ b/drivers/pci/controller/cadence/pcie-cadence-host.c
@@ -352,6 +352,9 @@ int cdns_pcie_host_link_setup(struct cdns_pcie_rc *rc)
 		return ret;
 	}
 
+	if (rc->link_down_no_hotplug)
+		return 0;
+
 	ret = cdns_pcie_host_start_link(rc, cdns_pcie_link_up);
 	if (ret)
 		dev_dbg(dev, "PCIe link never came up\n");
diff --git a/drivers/pci/controller/cadence/pcie-cadence.h b/drivers/pci/controller/cadence/pcie-cadence.h
index 574e9cf4d003..1561022c1a8b 100644
--- a/drivers/pci/controller/cadence/pcie-cadence.h
+++ b/drivers/pci/controller/cadence/pcie-cadence.h
@@ -117,6 +117,8 @@ struct cdns_pcie {
  * @no_inbound_map: Whether inbound mapping is supported
  * @quirk_broken_aspm_l0s: Disable ASPM L0s support as quirk
  * @quirk_broken_aspm_l1: Disable ASPM L1 support as quirk
+ * @link_down_no_hotplug: Skip link polling during resume on no-hotplug
+ *			  platforms when link was down before suspend
  */
 struct cdns_pcie_rc {
 	struct cdns_pcie	pcie;
@@ -131,6 +133,7 @@ struct cdns_pcie_rc {
 	unsigned int            no_inbound_map:1;
 	unsigned int            quirk_broken_aspm_l0s:1;
 	unsigned int            quirk_broken_aspm_l1:1;
+	unsigned int		link_down_no_hotplug:1;
 };
 
 /**
-- 
2.34.1

