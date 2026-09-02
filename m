Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012049.outbound.protection.outlook.com [40.107.209.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1541B3E7174;
	Wed,  2 Sep 2026 07:28:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788334121; cv=fail; b=bTxHTQjF0i81erPdQ4VATybTOaMeGUz1NT8qDjT0UjPp48gaM4C77NndkI1j5MC1w51fWXYElnfmMllGISp284MXB3BY1zBnUf1oSqBfaoBa+Wt4q7qQABAChwXzR+uiVH9mRy6f8YZJzr43QKLdYL3/RHwkZxKpOcieR/nRI2A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788334121; c=relaxed/simple;
	bh=Zy0DXGbUHAyuiPve4y8XdLLjeOyCs/d0S9W60WyI1VU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Wso2qTOGH4d6EZiEFSoB8VJcEHcXzKMUygAQ2bgfB546jpWwo52kHjGLOZZIw7JvNqCuRgmqUuw/Kfi2m5NDM6NGjyu0dfn+JK0VCqdHThHiKTCLpEUJAv/Htx0rIdJlAQpvq/MFBdDGN+FttgvN5Il0NoOLStY2Tw9xuqbMc5Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=juViI0PK; arc=fail smtp.client-ip=40.107.209.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="juViI0PK"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZlGjYfd/LbkLUXqW1skawMgO5V0BKm1H5u7m8ZbgcKvD8+VQZeJDtDPTqEEbknHsuO4Rw8/L8rJe+3kRrPjZ3VrMs0wnRvkhlAXITGi8+68SJzS8fIHMK7jQ9omEJa/w2grqvuiDxxTteXaN4j+7P+zQMXcefyWcWC0sIzutkSeEYCS0T4HAS9NzbgyXeoiyja0p3z8yKgbJtFUGYXaOFSRU/qmV4U+7xyGdfdCT64YkKshslCaze06UeJWuuW0Kmm+nGVdKmnkgoV5DHHjopI5GHr9eEVeFNQJN4hGc4JfdZeYww3xyAQIcAGYUQqPfy50t7y5e8wwX95MTIkn1KA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/oT3yceTU/FQHxL5hn5POhtNPJy74tbEqew4T0bS5qs=;
 b=gKGdfROWv7lqlU9OmYiRZes7h2NU9GoSViKdmnmPHatUwZIRcj3lshjPj9eKJjwqlFoCoHqNTQEgJOKyEzgUeus1jar5BS0KoOs+9ks0siblBfeionD3aALblMDusj3zQ7wEbF7d/tTeAZx7XRHunWMNDVMTNnKSupJ52fdDivLGA0WBlx+oFcVFl41ngzLBqYQIE8LDZQCqo44Wwmgr9kFqsPR+sePAsS7JS3dkYM96I8xSAEY2BLOq4mhHhdiGHHaEv+79Nb4bwIfHKRcgx5fkHK7LcOxWSrDBcwjizF5tRvtvgekbM46mSDADX5tMQhr3ftpZuSqyROnN3pieBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/oT3yceTU/FQHxL5hn5POhtNPJy74tbEqew4T0bS5qs=;
 b=juViI0PKcBp+9Be5GxwDv4gmqcLwECH6N0s6zwd5RqNd1jk3ae+/CQGGZoEIYg7Y5i5H9LxWvGB3srbfoY5lUgjuLPkRg5j+7GUyAGpFMzzaJbwzoIXFShaYiILPTyoB2K2+YxpNCn+calo4a6+lVNcAcpf5xXgWto+I/MyS3j9ZzLXUwUoEXYgXdcbv//uJQMCXHMFZt1p+w9fN+bGu3yjvbg9ytVFzrslsYR2mKscgwmlyyFySTCcN5Il66tX9HH5COseSHJdeIlbhYH/OZJ0ni8a7Id2cYS0bQEEOYxixll7WeFsmqRqEXoFfCZSGrYxBuk7OKOgVPXnz6877XA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9474.namprd12.prod.outlook.com (2603:10b6:8:252::17)
 by BY5PR12MB4257.namprd12.prod.outlook.com (2603:10b6:a03:20f::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.10; Wed, 2 Sep
 2026 07:28:37 +0000
Received: from DS7PR12MB9474.namprd12.prod.outlook.com
 ([fe80::31ad:931:ef07:8ad7]) by DS7PR12MB9474.namprd12.prod.outlook.com
 ([fe80::31ad:931:ef07:8ad7%4]) with mapi id 15.21.0360.008; Wed, 2 Sep 2026
 07:28:37 +0000
From: Srirangan Madhavan <smadhavan@nvidia.com>
To: Alison Schofield <alison.schofield@intel.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Dan Williams <djbw@kernel.org>,
	Dave Jiang <dave.jiang@intel.com>,
	Davidlohr Bueso <dave@stgolabs.net>,
	Ira Weiny <ira.weiny@intel.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Vishal Verma <vishal.l.verma@intel.com>,
	linux-cxl@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
	vsethi@nvidia.com,
	alwilliamson@nvidia.com,
	Sai Yashwanth Reddy Kancherla <skancherla@nvidia.com>,
	Vishal Aslot <vaslot@nvidia.com>,
	Manish Honap <mhonap@nvidia.com>,
	Jiandi An <jan@nvidia.com>,
	Richard Cheng <icheng@nvidia.com>,
	linux-tegra@vger.kernel.org,
	Srirangan Madhavan <smadhavan@nvidia.com>
Subject: [PATCH v11 11/12] Documentation/ABI: Document CXL Reset PCI reset method
Date: Wed,  2 Sep 2026 07:28:03 +0000
Message-ID: <20260902072804.665639-12-smadhavan@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260902072804.665639-1-smadhavan@nvidia.com>
References: <20260902072804.665639-1-smadhavan@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW4PR03CA0064.namprd03.prod.outlook.com
 (2603:10b6:303:b6::9) To DS7PR12MB9474.namprd12.prod.outlook.com
 (2603:10b6:8:252::17)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9474:EE_|BY5PR12MB4257:EE_
X-MS-Office365-Filtering-Correlation-Id: 2e77b915-4028-4d75-a8e9-08df08c3cd9c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|23010399003|366016|7416014|376014|10067099003|6133799003|18002099003|22082099003|56012099006|11063799006|921020;
X-Microsoft-Antispam-Message-Info:
	rmAEHlLUXPH0AgTEVBS+C9iWerWQ8rX/wFbH1uzUfduMRaGEc4KigSjPRcAB5jVuRXkn/dMyXioUIxCYuA39CKGOMFAR+yNBsEi+mfjRJHt7zh0v71KX3lvWVm38K5OAP3Z9rHvWeL/PUiPuQl+b/7VCwIMF22zuPainotujrbQCdEJXnijwnAQIWjzfs9AIb42T7ndXPmGXTG1LgTuDqg4SsDuOg4P3XWQvX5R3pljeVLtG0cxM/41oqCF4xDbzAs1mwaieswg2HMnF0X2UdvoUJijdaT8f9PVfaFmWm0TpWrYH4xl37kZfjNbrYePfr2Pwlsyx+wb/7Kzx50nA2YTOTEIjKvjX1MYpXI3tCxeV459hWcJiVV4mUF9axqr8++w6bAiLmfacW9EZiktNUVBZAXKXN/RM//r4/lLIDxUHHcHCo781KoySyEFIRHYCVK3c2MsWn7WrNu7F8fI9ubeu244ivk1rzI+07AkenYSSg22lA2fT7Mw4MCQhsc4k+dW9fXtgm7QCvVSAlpORJzdrIeBPDYAma5PVllIdzBF0b+mR3mA8MZU4mr7W6f5rpR+BZbQAjTvt+bN7gBjkE0muqg53bCIQxiw7pWhsxCAFwW3wb1KONdTF4VAXxmLDj53SYIwaedSuHoaAz9qasueEVTMxkTqjjBl5ul4fZJ/0mXdDwXkHCR23LFPS4NtK0CR5cVagzlVM5zWudfhgPw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9474.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(366016)(7416014)(376014)(10067099003)(6133799003)(18002099003)(22082099003)(56012099006)(11063799006)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Y/ODY6a55lUbTmX2pF/rbpqLzQyulcrmilx/YyLg2Uf8dT7WuRHLBU6kIA49?=
 =?us-ascii?Q?+sKboqWOi9O7lYHmp/Wv/fIjKVpGlLywmGqFPECRnRxGSzrwjnnMj/yB4gE9?=
 =?us-ascii?Q?CKIjL7lwRFhJIqb98iFrEZFMYdWoQniejFyAuHLgyMWQWMtmlNijzcnHa8ZI?=
 =?us-ascii?Q?NHnPBh352EutpLpSxOQKgEAU5YUmhqQ+jx6DJYWOSIZMvUhhRVBl0eZd5Nm7?=
 =?us-ascii?Q?EvPoeuI4DpIhJ4h7GRrzzflR5FE+eAe3tcw2dflKkPZLEar82pb/Lpz/4BVx?=
 =?us-ascii?Q?S+mBSfKzbuibOlrAEuxiXazRNi6vLJaP4tgrapVhY0VvNDWsk0GNSbU+GTse?=
 =?us-ascii?Q?VOn7FNfJUpJT3/srnf5Afc/oJJcha9WfsM8TPKXx13gCBkG2SXKoNJf/ONCo?=
 =?us-ascii?Q?HN0mn1rAot7YiRcm4iGs1ykwjX3RL0ZfFO4iFi9pmfQKsiO80m+rItyJOdQx?=
 =?us-ascii?Q?VIvfI7N0PHjteh4jEHSYn2kPaqda6gpVvCPRLHzYcHHiD7PpKDjqbaGC8zha?=
 =?us-ascii?Q?lTveHacMPt860Vc17qDDUzG3aNV/PsX1IWYXWtLgiJ93TUtwkSvNdJP2GeWK?=
 =?us-ascii?Q?ymrJVQ+NDuxcC3Xag5WwGnxWKRoCb90XsaD+ynHeCTfyQSNcZ2aefXYdf1Bk?=
 =?us-ascii?Q?qSmkGX95WY60Ozn2FbQ2NbLya58B+mtTq4aeK1S7ECDtRAzQXcmkSSmIGTFX?=
 =?us-ascii?Q?3sryPxtmqOmXHv9Ku6d7r+UdsayZHM+3Vmq+wV93P1tD5pk77rg+0p/ULw2N?=
 =?us-ascii?Q?Ydb4ML1oYSbMPvUaG+3//OBvBDkK88vf0ZxHeR8gpehBAk6I7DhQyrG66CJ4?=
 =?us-ascii?Q?Bs+QLP8qaNHFX3D1GsdocYghHmGpEKA5GoIHSSFzevj9sdlBUnFLFhSvZ3He?=
 =?us-ascii?Q?+WMxC5ujAGQ7Fx1odgK9gwS2hlhMJzHGUVr4s0ruVc1Jfg1GyR+agSjg/ISm?=
 =?us-ascii?Q?pIw3uITgXnQsh+w8XPKgPrnp0BITiL5ZqwZQp1FR8debmTUoV5iUfUSIn6Ec?=
 =?us-ascii?Q?dEfxLQvEXYy7yxTB0CwMcUTJ1KocAMyxDDHksh2JAcldSQHL5mK4bLQ6teeA?=
 =?us-ascii?Q?cg+rJhRm4GzKrLPdr26x1NPd7oCADJSjVpd4eIqTDwBr5+gocnjuK1VIt0GP?=
 =?us-ascii?Q?KftUEfRVWvOopvp19iJZ9ngO5VRKUWQ2FJapGZaqeLZ73vtxqT/azrokqSDT?=
 =?us-ascii?Q?xQZIklslGuiO8ZvnSKTF5RVcJoqvQAXEwygd9mMnVzmX9bI4DbfvyP7bEh2u?=
 =?us-ascii?Q?agb38d8SZGMFOMAwGlk8wr+X9fv4b3halOYSN9pBvl3AZl7boO4zr8HRYUsj?=
 =?us-ascii?Q?jHZ9xQC68wIzK4GGHrrfAnPCvxFcf/iUfS0pvruwRoaegp2e7/YrbypYZefh?=
 =?us-ascii?Q?vITAckHsQP8lV9HcM3hXEPVEVLhabc1q0tSrJlh2AhX7y7KmsJPIpiGM7OD9?=
 =?us-ascii?Q?gs5nSqmrrAwWqbWIS63Bj+JniYIHmWoTedfmQiOKrQIaKigbzkEmjTBQb8UI?=
 =?us-ascii?Q?WfKHsqSeVGK1h8OKsP3Y4KaJrT8fCmieXWDQVumXG5biVyReME/95en0SSAV?=
 =?us-ascii?Q?vapCBR8GVXHs8IDyzRDXXmsQ4evTsgUZxhpc/RD0EV0n2y0kR8ADEdhkGdpX?=
 =?us-ascii?Q?rM+Af7biVGRWdvvuko4oqkFEyI/q+AYc33YCv7JtWgBjraZi8T1FUAGH4nOV?=
 =?us-ascii?Q?XzJu7Ei88R4d+6qPnpgXJSWafq5Qb58M9WnLXoycvyc1t4gEYA9Dq0w8E6Av?=
 =?us-ascii?Q?dZhXqHc7ZQ=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e77b915-4028-4d75-a8e9-08df08c3cd9c
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9474.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2026 07:28:37.2072
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PlKhQY02R6kF0o91XoApWQbEG0OziyKdV/G6L6ZLQ/oj10VvM5XGC+pYcfTMzUJ9bIzd/Qmu7nr2EiEUMcBZUw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4257

Document the "cxl_reset" PCI reset_method value for Type 2 CXL devices.
CXL Reset is device scoped, requires affected memory to be idle,
invalidates CPU caches, restores cached HDM decoder state, and does not
request Memory Clear.

Signed-off-by: Srirangan Madhavan <smadhavan@nvidia.com>
---
 Documentation/ABI/testing/sysfs-bus-pci | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-bus-pci b/Documentation/ABI/testing/sysfs-bus-pci
index 55ea1db749a1..bfab0a14e8c9 100644
--- a/Documentation/ABI/testing/sysfs-bus-pci
+++ b/Documentation/ABI/testing/sysfs-bus-pci
@@ -153,6 +153,21 @@ Description:
 		"default" enables all supported reset methods in the
 		default ordering.
 
+		If present, "cxl_reset" selects CXL Reset for CXL Type 2
+		devices that advertise CXL Reset support.  The method is only
+		listed for single-function devices so CXL Reset is not exposed
+		when the reset could affect another PCI function.
+
+		Before issuing CXL Reset, the kernel rejects the operation if
+		cached HDM state is unavailable or affected CXL memory is busy.
+		It reserves affected HDM ranges and, where supported, explicitly
+		invalidates CPU caches for those ranges.  The kernel then disables
+		CXL.cache, initiates cache write-back where supported, quiesces
+		the PCI function, and issues CXL Reset.  After reset, the kernel
+		restores PCI config state needed to access HDM MMIO, restores
+		cached HDM decoder state, and completes PCI reset recovery.
+		"cxl_reset" does not request CXL Reset Memory Clear.
+
 What:		/sys/bus/pci/devices/.../reset
 Date:		July 2009
 Contact:	Michael S. Tsirkin <mst@redhat.com>
-- 
2.43.0

