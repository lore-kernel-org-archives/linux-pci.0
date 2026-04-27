Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010042.outbound.protection.outlook.com [52.101.201.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A4B936606A;
	Mon, 27 Apr 2026 05:54:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777269275; cv=fail; b=IS64+t9kB7Hc8XnLZQRyhFYE7FxfQKc4MyD109GekFpx/xOpBAHjzJfKZnp2wzVXIzUqojR6lwvLwOc644OFTzbsAu5paknEN+AvST89pBptMaYGWLruVEJaIfH2tD98WWeOxgVgwlDLQQVv5vaoyqv+X9YsZE7yRLATBKKHZ+w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777269275; c=relaxed/simple;
	bh=kZlSlJ0fXO6DogNFKq1ka/GtAloIhrLwtO0cHcQndWc=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=LTXiwvhLG118L6Tc3a2FQ4tXuyZWxrjbNxEVtC1QOAn61YFErE3gRw/PaPCG/GBogihDAvexzvoMxTnwKHQlxTLwTrlfJjDfUtiR+IUxXf19uCZ4dFsweoE85Be00/QpZsU0VK8Dbaf2y4fMZkDLWSrIZbt5izFwL75buKDzwKQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=NbX+2/m6; arc=fail smtp.client-ip=52.101.201.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="NbX+2/m6"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MpKYXkqbryWenVlALi8Z7awgn8aKy1zy4U8uhe968g0jfuhoszE6uW4tVLbyzXqvA6FLVBGxFy8S7qUq+Ja/YBeGJSTNj4bGqVGvnOcFeenw99uxDlbd8xQSIeTzVb1pddFkWomVwCX0mHUrvaIAYOy0pR95cSiUcwTDnexUuqmUICO1BIHezUXdii0rDMgnDhDOy1ndTbXeguo+REGcYAcb8XSmqZcsP50o88ukhawL1lh/secsudaxkVAH/eR7x2l5CosWCPAU8ZxIE43aV4HyCS0Vj9iDUGmarEKisNFUqn6uaLeg4T/EpRqshtA5GomIakIUX/l3V5tdR7NMKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8uZsyzlJE9pH0xfDXTLUF7l3xylZBj3HrTveE3AJ1EY=;
 b=F9ucS7+DxM+D4zzAK0wFuzet1i9wMlLzuYpByCVvsOCv2KySN9UMq3IdJvbkqCsqcnBzKPzMj7lYfQqPyHus/4Xzwa/PDWdFKo9Xjv/SQE2ODjyJrx6VShPeiO3MRQj/QCE6glHtCQcPgyMpevt3AdgcDlEwR7MJobhtoQ4zit5Lms70aoGSepy0W07lD2mF0X4eDeJHVyMc2sEkCP44SegZKg62sB6hbbr8BqB0lGnppmHYoI/KPnJ/scAFLk1A8vsHQ5+HCdLxnzEglp1TiL511JQ81uvwMXhAx8C46r3equ0GckBvz636qR+rv6XJTqkhNAjmDKqWVQldH0T0qQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=huawei.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8uZsyzlJE9pH0xfDXTLUF7l3xylZBj3HrTveE3AJ1EY=;
 b=NbX+2/m6lKq8KvG/6Iadk/Zf1XxfrgGyQrXUaj9ZTqmsCb/mHgoTE8GvOIZqO1b6IC8y9xfTNg46dro37s848gDDyNuu+IFh/h46HosgetStdAZ0vyGNDonS+pdi8cZFTzYwxlBdpOEjR3vVFekCAEyJDm94epnd7VHiHtwQuKQAsHPeRcGlpRooXDw7LznNho6ynOlmQz9IClv0rkpXC9XRiY3Ecgm64ipblHHHFK8AXc4PW7DJcj6puxBP//kmy7cAxv8bGeRV7LXp8obWGWazjTp3iWK/ccfbuusv7JscIN32R8PFN11iVn0hz/aQZZ2/5weSqUEJpz885LkKhw==
Received: from CY5PR22CA0018.namprd22.prod.outlook.com (2603:10b6:930:16::30)
 by LVXPR12MB999198.namprd12.prod.outlook.com (2603:10b6:408:3dc::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.12; Mon, 27 Apr
 2026 05:54:30 +0000
Received: from CY4PEPF0000EE31.namprd05.prod.outlook.com
 (2603:10b6:930:16:cafe::7d) by CY5PR22CA0018.outlook.office365.com
 (2603:10b6:930:16::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9846.26 via Frontend Transport; Mon,
 27 Apr 2026 05:54:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 CY4PEPF0000EE31.mail.protection.outlook.com (10.167.242.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9846.18 via Frontend Transport; Mon, 27 Apr 2026 05:54:28 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sun, 26 Apr
 2026 22:54:19 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Sun, 26 Apr 2026 22:54:18 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.12) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Sun, 26 Apr 2026 22:54:17 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: <jgg@nvidia.com>, <will@kernel.org>, <robin.murphy@arm.com>,
	<bhelgaas@google.com>
CC: <joro@8bytes.org>, <praan@google.com>, <baolu.lu@linux.intel.com>,
	<kevin.tian@intel.com>, <miko.lenczewski@arm.com>,
	<linux-arm-kernel@lists.infradead.org>, <iommu@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<dan.j.williams@intel.com>, <jonathan.cameron@huawei.com>,
	<vsethi@nvidia.com>, <linux-cxl@vger.kernel.org>, <nirmoyd@nvidia.com>
Subject: [PATCH v4 0/3] Allow ATS to be always on for certain ATS-capable devices
Date: Sun, 26 Apr 2026 22:53:59 -0700
Message-ID: <cover.1777269009.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE31:EE_|LVXPR12MB999198:EE_
X-MS-Office365-Filtering-Correlation-Id: acda12f8-97e8-4edc-f167-08dea42171f3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|376014|7416014|1800799024|82310400026|56012099003|18002099003|13003099007;
X-Microsoft-Antispam-Message-Info:
	lL3glxw8X/PdngCLUJt6Yd1RI6LkDAE4Oaa7KEuG++kaOsL99H53zGClviLBR3EWOILaeSMSwgcys04WuiY7ifQUEpJR4XdHnjL+guvcRGtO5Rj0hQAS/QvPe3L9CSoS5FOTS2Deql/0isJ+/0h9THg4HrF4VFZLzoW8kgl6bhOcDbLXgYWrJVR8H1KEklo5NwVUolN72He0MGVNJHxO2AAcNLc11B1jvr9WXYfjpMTqdUdmWsT+RO/rhySSM9z/7ZgC5PgnlFGlcqyGEQWt5YwjJ91DqdPbh9oYUt3wtTM9Qvef6WA2YswaKiYiunGyCSFjITb4W8ydMT7MJp8sk4ahQQGWrVKZEbfJq9gHtQ/KrxN5DpPvPHOJ/+pO2bhk2jkeAVO6k3byMCy40WzXSqXwQR0JY0iuvn0IvIeAZezCK0dZxjA+zCwYv0CrVYHerSjasrfcZt+GIZ8vkeWZGxDsLibFuExiFLgKWDMDsrub05uGUnIg9TmG3Mz0EelhlKtqo+9pnTV2aJ7hTVh9/qGNtu6vZeyvDVysVLQcSwhUNyoG8fyWUZZ8HXmBLPP1KtvtEhjHa1Cdv25mS+bUUmrVkr6veFacDdwh5pxxrYsfS3rgbOtXiUF6eru+nhCYstQhab5Awa0u9HoytdqpCDA/cFQ2vTkGpLjpWT03Ll/5IZnbx26FCGKq5U+svbddXRnTwQEa54FxvTeQd2KOx5GqMqDww1ik/tLEgIE7QmUqLWac613aVLdqp36pyZ6iqQy5JFKQg8urNoo3fwFsHw==
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700016)(376014)(7416014)(1800799024)(82310400026)(56012099003)(18002099003)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	Qe6eQ+Z/QSwfP2BcxBTNXGUBBjx+bJpm+ZtNRrFveZaAGwbKIwf9odoIN5xJm8X/rF5MyBO7ryi8mnukAFaLE2CBY6zgOBvAFhcM2X7OIaFt246BZBf5tdWPlJL2iabKOhOydPmyGWzkdbCSgqqFXoxkiP8HpK1bsVya2FjieYUTvZKDLrtIvBak5Ajp8TJv9uW8+07PGo0vHNCTRHt5tkCZErBNFhpzBPKylzFzecZYXqOuL+AO8CuxCM0HyOQ2oLpbQNsBlRoimRX/9TivZ6Rfhr0pgzoGCQ0pcgn9nYT4DkQkqsFqnT6OemB044+4hgXknUrZ3VQnE1cBr8WndQ+S3tmT5bbUdX2hfsV4FBiL46ubBC8zyCmH2w9e8t9nQMWwHNot7yIiXZc/A8z61p299B+FRIADsJc2b6qdmjfMdwBpyiDIzdhWJc6UJrCR
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Apr 2026 05:54:28.4653
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: acda12f8-97e8-4edc-f167-08dea42171f3
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EE31.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LVXPR12MB999198

PCI ATS function is controlled by the IOMMU driver calling pci_enable_ats()
and pci_disable_ats() helpers. In general, IOMMU driver only enables ATS
when a translation channel is enabled on a PASID, typically for an SVA use
case. When a device's RID is IOMMU bypassed and its PASIDs are not running
SVA use case, ATS is always disabled.

However, certain PCIe devices require non-PASID ATS on the RID, even if the
RID is IOMMU bypassed. E.g. CXL.cache capability requires ATS to access the
physical memory; some pre-CXL NVIDIA GPUs also require the ATS to be always
on even when their RIDs are IOMMU bypassed.

Provide a helper function to detect CXL.cache capability and scan through a
pre-CXL device ID list.

As the initial use case, call the helper in ARM SMMUv3 driver and adapt the
driver accordingly with a per-device ats_always_on flag.

This is on Github:
https://github.com/nicolinc/iommufd/commits/pci_ats_always_on-v4/

Changelog
v4
 * Rebase on v7.1-rc1
 * Added Reviewed/Tested/Acked-by lines
 * Update commit messages and inline comments
 * [pci-quirks] Add range-based scan for NVIDIA GPUs
 * [smmu] Add missing arm_smmu_remove_master() in error path
 * [pci-ats] Don't init "cap=0"; check pci_read_config_word error
v3
 https://lore.kernel.org/all/cover.1772833963.git.nicolinc@nvidia.com/
 * Add Reviewed-by from Jonathan
 * Update function kdocs of PCI APIs
 * Simplify boolean return/variable computations
v2
 https://lore.kernel.org/all/cover.1771886695.git.nicolinc@nvidia.com/
 * s/non-CXL/pre-CXL
 * Rebase on v7.0-rc1
 * Update inline comments and commit message
 * Add WARN_ON back at !ptr in arm_smmu_clear_cd()
 * Add NVIDIA CX10 Family NVlink-C2C to the pre-CXL list
 * Do not add boolean parameter to arm_smmu_attach_dev_ste()
v1
 https://lore.kernel.org/all/cover.1768624180.git.nicolinc@nvidia.com/

Nicolin Chen (3):
  PCI: Allow ATS to be always on for CXL.cache capable devices
  PCI: Allow ATS to be always on for pre-CXL devices
  iommu/arm-smmu-v3: Allow ATS to be always on

 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h |  1 +
 drivers/pci/pci.h                           |  9 +++
 include/linux/pci-ats.h                     |  3 +
 include/uapi/linux/pci_regs.h               |  1 +
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 75 ++++++++++++++++++---
 drivers/pci/ats.c                           | 44 ++++++++++++
 drivers/pci/quirks.c                        | 38 +++++++++++
 7 files changed, 163 insertions(+), 8 deletions(-)

-- 
2.43.0

