Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011059.outbound.protection.outlook.com [40.93.194.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3A87448CEC;
	Fri, 11 Sep 2026 19:18:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789154325; cv=fail; b=DLFP3A7O1fOYTK6767HqJqbLWreIvWYMp288LON1sqPXuPlcNwy0pUTm7TWp5vvKJuEr7Gj8NIGIIZ0CSl6omXlTnukg6lv2HDtQIZ7DbMB+zZiRxyhUg1QdU3d4uRCflVq6EOjpPhxOQhtTypIZzsFFdTfzWi/778FmpYk4kiQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789154325; c=relaxed/simple;
	bh=X3ECnAwlSyYrNt64nIL+zAcU/xEUMDGDagUBIkklTMw=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Fik2uZn+fHD/n6jnvssBlvSD88zgiT6KEmzU5WAgryaurITVWzz8EXf4WCDDGUeoClPOZZlScVYj8dsdMCuOhDxSk6GatQALnstrWuot67ukzj6m1bT/9kBfsJOqWeHhk2CNDdImS8fHTKVBE5D4xhV8LIx4ZamzewC5MSdk+b8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ydSOlzI4; arc=fail smtp.client-ip=40.93.194.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ydSOlzI4"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HCexXnHyUpaorMYk5zv1t8HxKe3ZsM6qAWNB/UotA0YRU44D45sxsu8EfQqikxiSCnD6Xzf9t0bpZOGwUN7WZ8DizhE8xxpJY6EPtow1Xvqu9cbVhm2vfmUyyK2yOAkiiLT40e3AKg+1umkrH2ZuPuUJbcKZz8WR8ixartwBh+4p3WfwOJDd8474f1ons+qYufPDXQkECLvNQhgr7yYMA0cLyDvghlp3W+rgLzhKQNDlMwDYUtPmUZqHCq43J06wu2jQhyO0Sx46mz4MrsqG5sU4qeEB/rIU4oHnv5ZSll0IikNHEZvPfW4jZwfpbvm/gWZRWkfIpISk5GOnHj/4Iw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9HVxpi21Zdb+L/LqDEgwvSnEkqK/24kF5nZiUSmhXVk=;
 b=d4UBmQHNujh779m3dUvKVx6Z1aJ9HMxinwMB1B0DQ3shK9tXd3fcig5bR843/BVBNvOkjaXfg9hSQ4GTvvTzmYK8ihayf5B7cgHYg1kf+MJHhEe0x8l/VZEz/eYcqYsX94ofSUymDRucN858t4a16paThRP2C3g1nNfcpjkQy33yVlQQngBrsSiW6X7+YE6xW+6kiWuE1tRHu4BtnlYExf5a+nze3E9lympNa0s4nP9o0WczmTgh+j8ItptXXUXca6GMPfjsdUrmP+hv8YloyZd/NOkYJkdZbMtNzzvGW8dpnn4/KvUAs8yW6gPTEkxk6ZIthm475RvSeECwBieayg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9HVxpi21Zdb+L/LqDEgwvSnEkqK/24kF5nZiUSmhXVk=;
 b=ydSOlzI421ZhY8FQ5fqPA3bJpK1fh7ga0yaBSul/PXVyf1eNheg71NJ054hA3j8Fk5rLcXvmRt+4iD6+KlpM3ww1bLrrrG/AtQZlpgv9DaKFPzYPtDf85yNkF0mXHjQv4rrLMSbiKBhuj6QbtxKSZhPL3I55c7p4CIIiePZZA6Q=
Received: from CH2PR15CA0018.namprd15.prod.outlook.com (2603:10b6:610:51::28)
 by DM6PR12MB4075.namprd12.prod.outlook.com (2603:10b6:5:21d::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.9; Fri, 11 Sep
 2026 19:18:26 +0000
Received: from LV8PEPF0000005F.namprd02.prod.outlook.com
 (2603:10b6:610:51:cafe::12) by CH2PR15CA0018.outlook.office365.com
 (2603:10b6:610:51::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.406.9 via Frontend Transport; Fri, 11
 Sep 2026 19:18:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 LV8PEPF0000005F.mail.protection.outlook.com (10.167.245.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.406.5 via Frontend Transport; Fri, 11 Sep 2026 19:18:26 +0000
Received: from aus0006770c4n-lx01.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Fri, 11 Sep 2026 14:18:18 -0500
From: Mario Limonciello <mario.limonciello@amd.com>
To: <bhelgaas@google.com>, <clemens@ladisch.de>, <linux@roeck-us.net>
CC: Mario Limonciello <mario.limonciello@amd.com>,
	<linux-hwmon@vger.kernel.org>, <linux-pci@vger.kernel.org>
Subject: [PATCH v2 0/2] hwmon: (k10temp): Add 0x1ah/80h
Date: Fri, 11 Sep 2026 14:17:12 -0500
Message-ID: <20260911191803.1522358-1-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PEPF0000005F:EE_|DM6PR12MB4075:EE_
X-MS-Office365-Filtering-Correlation-Id: 4e7415f2-d738-434e-6801-08df10397481
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|23010399003|376014|82310400026|36860700016|10067099003|11063799006|56012099006|18002099003;
X-Microsoft-Antispam-Message-Info:
	vvW9fQmEGjajS463wA0iRM6SQ0wueMsfUtTswfh6zQ09UY+RoYdCNG1D25UO+jPoP9RwsedfQ12llSEDHMeVqPIT6068yWyxnJhRNq8221NlW1QYKjn6e+pg7LfDJagRRCSuBBh7MAXeH+v8wW+C7gVsHEG7Y3ke1Jqywr/ddQETVjW9GWrtTat9qBH5fDmEnUPq/eMPUCIqqQASApjDArEz3iP8e3bdFag2LVd8Wcyao6VnLe0sNTporb3yz7kZsvFEs7Oj1QcytJh60QVir7qN2ViSoNX3d4E3awMqcJLVRlYHL2NdxCPJku++MWprCn2L1FCtSecj3bySBZeS+nQfFjTXyCAtl2h+OFI5xcMM4iFBUM4eP4OpLlK7Hlt+Lu3ocaMRGDK+ser+iTOtkpM6mYCVBhIPKjmhiYHLWyjj8foN7AwwFKnhjFPznFKhCA69YTFUrWO47nIT9wouteDno7wOWwzwwtqaSJUr+hOk7fb4ndHTUy41UICfNeGeRHO4awfKqOjh76wqw5UYDNFCpNXH/xLTq/T8Q3Pg2bI3Sf3Vbh2Vdz38zitIimwpVOpiY4+Xrt+FireYB2mPJOhjyVo0YoSTo6ALG/p1BtakYZ9uGL8ULrFUphAOi/ZneE4CW7UA1+GbE4ladq6ZySn9kyfROiv5degmid5Qp5N7F9dagrswIKGi+QtyvBojsdlwbSmtBbhgxE+D/c0QiA==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(376014)(82310400026)(36860700016)(10067099003)(11063799006)(56012099006)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	FalmDs0addEWgHL4oJ6on7qouAUuupe/nxD1T5RRWhR4aFNHPAuc3YE5UWL2pnjLJEUzmpb9ULb8sUXI3weowjiE5G/MS6ADpjKJQ3gTA+BcO2VMshwz29QzKPec5+XMtQGTX9bxUIiMCH/SofzWS++GbT7IZc9iC8K0WSD6XAvG7zWtWjknXwM6c3g8uinL6o1+sLaYxMUoW56P1pYnjnBN+SKkRJ40pMYD0UL4UcHZrKibyNmwHB8QFiwcmmLTo4KGv5T6wJig98e0s5w8Gy36nPQ+vPy//OCGQd+Jjj+H/IKVr6nTFPe5aP2Xd3MQWDVABXJkGXGi94hhCGmijBBq3s/lF7ENx1Fl+Vur7f0QV/sqzQIgS27xs/VH7G6WLrPJ3WjENSAMRxmpYr6jCVJvXW3GvzgzWS2pZRhW+DMVGzz2bPfb3ymC/Ipd73fV
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2026 19:18:26.2665
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e7415f2-d738-434e-6801-08df10397481
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	LV8PEPF0000005F.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4075

Add support for more systems.  Documentation changes would come
later after systems launch.

While at it, move some single use IDs into k10temp.

Mario Limonciello (2):
  hwmon: (k10temp): Add support for 1ah/80h
  hwmon: (k10temp): Define unshared PCI device IDs locally

 drivers/hwmon/k10temp.c | 32 +++++++++++++++++++++++---------
 include/linux/pci_ids.h | 20 --------------------
 2 files changed, 23 insertions(+), 29 deletions(-)

-- 
2.43.0

