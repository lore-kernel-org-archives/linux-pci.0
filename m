Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012028.outbound.protection.outlook.com [52.101.48.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AF063A3E6F;
	Thu,  9 Jul 2026 01:04:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.28
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783559047; cv=fail; b=Gz9MayoBvjGp+bZeRkWi6MhcD/qbjpDnqRsKQkUcaCwH8bGSVowVRWnHFPXsl+85hMR1+zmGfkf/nf6y2TqpgdRETpk/qOXreCrhufDlUnzuWm1TMSMZuZe7eb+QFppLh5wAQIGnGOXxZ2AiNwrc/zPxLLkzztZHAE7EUqXo7JQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783559047; c=relaxed/simple;
	bh=ivKvlEgicFpxh3qE/x6KYYoq55Saf/rXicwl14O4hRY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=dw4/azX3NveultWbqEKBmyxHQbpKGurr+FmMDSdVU1dcNB1UA4+RI6o+Hyhnzko7GBh4PA/AJWXmQqvJXFx62+gvDu8poqxCPKLWR01tHuQ9xaE9Y401AwtZdXsEo6LW1wZiJUapE3yZlAIKbrA5OY41X8OYRkyH4B0Snshl9pE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=DhXmkZCN; arc=fail smtp.client-ip=52.101.48.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="DhXmkZCN"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iUa6Y1kFeR0ab9qYW0JpOvBsre5TdGFWwAsIP3ZW5BLSdwcpeQ6pyhVfutOB9XkNG+kdWXfqKPL0AnE7/Az4cluMJygtr6OwlpEb/npc/ZL/8BqUIAok3ZgXw+4/pl98kxnWfnQgRsuHAyOL8ZmrMbInIEorjkKzZtfG24Ckuq7daqra+YASLuCcEzwIarnqTShWhZTZWfcMmnX5eVeVOp88gFPZdyGNZ3PEyPTv2y3F/FZbA2MlA3UmZ844M8UJG4tf2H1HPgd8R7Ubi0Gcizf28brnRK3PjshQAGSNop7o+pFk569oCs6NoDXi9St1mRjAzfLkQlaEab4AzQ4+6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sukQT0g8XLNpMPtPjIh+IRNZp5P6uO49+L3ytbvnw3I=;
 b=HEbaaucvCATw5THMj6/YPLEAy0ixQyv+aYwvOLB0NE/XXPs85MS/QUO4YD88pZ+CM7y9mXXgR33t9UJpI94OekeKi2wmmDq9GObGRRPWMKPVinJiQE07E3lpcZCtL1sK2fwH7TV74bcAq6vQG28IAtrYGWx7VWK6P+xYlpbuO94tboeomw9MuSURqhJrU9kGxB9m8ujrurxNwTTae0fUUCc8Erd9PnNb2ggxLcxB8w9g9vDs5HH8ccY7iQbhMh90GtuGrFiGubAMO+robMZPQnQ8wSKSha9utZJ24yB8ajHXHg3m5p3ODpCZC11Gjq+oYWdkoB+CBG3VmijGOn07Yg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sukQT0g8XLNpMPtPjIh+IRNZp5P6uO49+L3ytbvnw3I=;
 b=DhXmkZCNGVbGUN2CcDBXUjrv+KDn+7l+AmC3SP9OYaTRPAIHqt45HVn7OSMPW5bL1icCHhkXMsHkjuy6njpG5KjDQKXtTvucUspz9vEQYAGZNDvhgsZgIykysVK35yCmagE0eeUf/mh8pnuRGdZAzIvSjiZOo224YBJW104MzkkWfmgYrN1w6Ibimna5KmKNfflD1TyPD3I9quGKvFeRw1yoK/SP26SMoJmpzl0zCpkfqruP+cX3NTH8teqHEspbPAUjk7hVmA76JEt6BdmMUKvu0qInz+GvrEPAftsrvh8Ob55wKLwAfKcPZnGlAmTEzqaR1BnKxKF0LOAdheBkFw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9474.namprd12.prod.outlook.com (2603:10b6:8:252::17)
 by LV2PR12MB999071.namprd12.prod.outlook.com (2603:10b6:408:352::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.10; Thu, 9 Jul
 2026 01:04:02 +0000
Received: from DS7PR12MB9474.namprd12.prod.outlook.com
 ([fe80::31ad:931:ef07:8ad7]) by DS7PR12MB9474.namprd12.prod.outlook.com
 ([fe80::31ad:931:ef07:8ad7%6]) with mapi id 15.21.0181.009; Thu, 9 Jul 2026
 01:04:02 +0000
From: Srirangan Madhavan <smadhavan@nvidia.com>
To: Alison Schofield <alison.schofield@intel.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Dan Williams <djbw@kernel.org>,
	Dave Jiang <dave.jiang@intel.com>,
	Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jic23@kernel.org>,
	Vishal Verma <vishal.l.verma@intel.com>,
	linux-cxl@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
	vsethi@nvidia.com,
	alwilliamson@nvidia.com,
	Dan Williams <danwilliams@nvidia.com>,
	Sai Yashwanth Reddy Kancherla <skancherla@nvidia.com>,
	Vishal Aslot <vaslot@nvidia.com>,
	Manish Honap <mhonap@nvidia.com>,
	Jiandi An <jan@nvidia.com>,
	Richard Cheng <icheng@nvidia.com>,
	linux-tegra@vger.kernel.org,
	Srirangan Madhavan <smadhavan@nvidia.com>
Subject: [PATCH v9 10/11] Documentation/ABI: Document CXL Reset PCI reset method
Date: Thu,  9 Jul 2026 01:03:03 +0000
Message-ID: <20260709010304.680422-11-smadhavan@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260709010304.680422-1-smadhavan@nvidia.com>
References: <20260709010304.680422-1-smadhavan@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR05CA0137.namprd05.prod.outlook.com
 (2603:10b6:a03:33d::22) To DS7PR12MB9474.namprd12.prod.outlook.com
 (2603:10b6:8:252::17)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9474:EE_|LV2PR12MB999071:EE_
X-MS-Office365-Filtering-Correlation-Id: e056b2e8-be91-4fe8-4b25-08dedd55f718
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|7416014|23010399003|376014|11063799006|56012099006|18002099003|22082099003|921020;
X-Microsoft-Antispam-Message-Info:
	xHnvB//xTTU8kVSPBT8BDTH+pp7WXUQgPtXQeEMWpa0/q6rfiUYpyCaLDe2BQnhp24xfreWDOA2rbf+dvlZcqghlOyPCzk1nxnaVxUHE8eUaXu7rz7Jhv8Jl0S+1Iahxz6tcPmkV0TF/SUBAaejQIwJZFv9+ftf6zZsKs9UnONYlxBzNyBBaWx6XPy1bBt7ALExGAvisgIqwHf27RoigzUIN/bMsL2HrUzkD1bWROHJRs9TDD1oIWhdiv6Ek0MC9Vr0zowVsyit3a1PWqmVAnSqpCyfFqT+7XQ6pP/OTvvwxl36/vd0UK54hHZxpEcBKoJASGt74dx5Mjba+SxsP8T5kJqXbzcW8nYzAzDQIUuX8ftX+BVpuXYbYVuS1bdUJ6uiiBNgGIS9fTwg/r5j1Kltc5sER5dtNkbb7G0rOYDH5iQyVuxY6JYz3xSw05PpasY5AqvOZmvZT+PNMcsJnqB6Ogo0ouTB12Kep2oJnH8UOQi6BBVI3cI7nUPxT4ME8Gl6j4GtmLi+HSzh+m5/iL5cf+AVT6EOBrcY+QDRmfdmfM4sP3b1Scsl2MzwJvagkMF9wJi7uXGxLJUes1N4L0bDosRZmGf6US0uXyvgfQnCefFnojlcoHnHyOtpFcz/ZwNwV1aYjla8Lb34TPOQ+7OWnOyJp76kSf0cf0JTHkZK5iV4P8TeENtwlb/iWKWQsbKGZOkQrPonrlicMzFOezQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9474.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(23010399003)(376014)(11063799006)(56012099006)(18002099003)(22082099003)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Cf7Ot47FCH87P+7FXaNWvcGyiqk7Ukdk/8xeHZz/PboyMx1opuVNmyzFXDsJ?=
 =?us-ascii?Q?PUgvpdTyfVcCleR4j6jkoOBudNdEak8oP2ywZ0Dj26egS2ehnN4fym9ey0FI?=
 =?us-ascii?Q?6tLTXXoRrCbc1UNprqVujPY5W1JcNKTndyuKuCdv4sTsLVqjPp0/terldSA7?=
 =?us-ascii?Q?N5SYib0GswHKJg7rnkAYodC/M1EHRNwQZZoO1ki9G0jWHhQAkBYh2Sis2MSP?=
 =?us-ascii?Q?jSd6ek8ToectogksdMaiDla+Aji2/HP0EN35b9M0v+NUyW9E+S6X7+mMq7rE?=
 =?us-ascii?Q?64+dzgO1fX9o3Jf3aLqyFBwq5091bKWTA+XBAAX7tJJ4twmZE8EodU+03Z4p?=
 =?us-ascii?Q?HHvMv4/VzCAhKN5mSsqyBAtrqYDKX5igfbe+sVw7GsYwXhNKyF9x92ZYzhWF?=
 =?us-ascii?Q?NZo17DHP6gGLNf2bmPFUyiVVoeWaniJM//A4r73HYLD52fyW7CQsusRxOVSz?=
 =?us-ascii?Q?oGCtSD+8QYgh47XUTdy2V1qe3wOtgUs0pCDfYvWhHSpiZ4S1EKj75P2vo8EV?=
 =?us-ascii?Q?Uily6AA9FPXnU5AquERbNyAvWzyoHC7Z4HfPXyqBn1ir8Rxz91Rg3tyTdHFN?=
 =?us-ascii?Q?ec3fT/NQ4e5v7dK0pzoEbA+9DSExGjqAG1diGwPirtkR5Gk7XAyChSUEYYIy?=
 =?us-ascii?Q?gZIxzEk0qZwJdWHq/yHRlx4jHa5bjoA+7gB98NRXOUW52XQzzJC06+EK3xEO?=
 =?us-ascii?Q?exLGDg+CkrGtIC9Hf9DDZYrBV0PPB7jsm7rH8vxuHysfHlOFHTr1jv7WGhqE?=
 =?us-ascii?Q?4jyxzE5AdfZVDdli9hDrgmLyICYv8RR3PB4P46+92sYDn+4Y1gdtb4x+f9+h?=
 =?us-ascii?Q?Gj1OWZiFUyIxlQHLUXCrYNviilYa6r95UYPfvIeetXplDePacaoNsd7U7UzP?=
 =?us-ascii?Q?qjFE/UxAkKY6rrX2rQjUvvGIeR4D3P9lkCPU+S5oMZlX61/yEW700KK+ViYF?=
 =?us-ascii?Q?XYn80w/sJvz8CwbTYca68c/1JgcLBt71WP31Hp4APs0+Jr98ydFpExLZzIZB?=
 =?us-ascii?Q?zj2sv5d3prBUdBCTCYeux1iPERbb60pcrIylcGPu7Fan5ozNvif6B6E4hvM+?=
 =?us-ascii?Q?wTQUhNS+/Mfg2LF6EvAuxdKUX9idevYpsheZfWNtWVgoey7198xYxmAZ3Wzr?=
 =?us-ascii?Q?AQ50G5uEQg5LBu86obXeNPZBQ8cFrMb/fNFbbcBnhxQunFjTJYX/lphgmI9x?=
 =?us-ascii?Q?zCYHWZ81M0BLoLMx09L262RvYTC/PQAkdPqIL3V6VkIjCKpTQ3Rmts8afPwP?=
 =?us-ascii?Q?smIlaN0D5PjnVenuy0dzQMo9XszYT65Pn4KWkxRbB+Ro+IfDhQuRCHfc/1Oh?=
 =?us-ascii?Q?ioAYZxmNOc6AAA7epQyZBhGQS84l8e5Mch4L3bQwAO25LkHgLkp1aoSXIefd?=
 =?us-ascii?Q?0S7JSm7FITpk6Ki8b5HGZEvpv3tdUfkN+o2AtD3m7AQ6AL1NTtLtucz5EZ+f?=
 =?us-ascii?Q?4OWNx+ZWtwrHbNGmhZvQnQWEJLeMn8894lpRQh2x9DUPMt56tLJjVdsM44mN?=
 =?us-ascii?Q?m3kRZlOWH/STJ5NzAxwXHkTWmX1wTpBAdHhL0jRd+4uU8UpFkuUuWeK3gD7N?=
 =?us-ascii?Q?P90VQRcMedKWPkksLhhIYz5vvZMsFjWAUOIF/zEXzzpAetYUQSDkF8ihRwIo?=
 =?us-ascii?Q?UAaRsykfEW1rmbbVorqHqiePecIiFKQzAmVtaX47D2dAXZU/8OZOCXHRiIh2?=
 =?us-ascii?Q?0W7vau8xf/C2AsFQLHf7Q2WqqW4ECf5BYfVrv1/VI44g0p9nWql9853kh8YB?=
 =?us-ascii?Q?88feLZL4UQ=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e056b2e8-be91-4fe8-4b25-08dedd55f718
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9474.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2026 01:04:02.2316
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IBsutH9viL9Kjw3Gx1JsdHKsmpQ7ltjY5xiFxbjmYVXBV5LQCXVfni3tYFnoT5i5v9PBZqbsfDsUQQjbpScGyQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB999071

Document the "cxl_reset" PCI reset_method value for Type 2 CXL devices.
CXL Reset is device scoped, requires affected memory to be idle,
invalidates CPU caches, restores cached HDM decoder state, and does not
request Memory Clear.

Signed-off-by: Srirangan Madhavan <smadhavan@nvidia.com>
---
 Documentation/ABI/testing/sysfs-bus-pci | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-bus-pci b/Documentation/ABI/testing/sysfs-bus-pci
index b767db2c52cb..5ab46a4340ae 100644
--- a/Documentation/ABI/testing/sysfs-bus-pci
+++ b/Documentation/ABI/testing/sysfs-bus-pci
@@ -153,6 +153,20 @@ Description:
 		"default" enables all supported reset methods in the
 		default ordering.
 
+		If present, "cxl_reset" selects CXL Reset for CXL Type 2
+		devices that advertise CXL Reset support and whose reset scope is
+		limited to the selected PCI function.  The method is not listed
+		when CXL Reset would affect another CXL.cache or CXL.mem function.
+
+		Before issuing CXL Reset, the kernel quiesces the PCI function,
+		rejects the operation if cached HDM state is unavailable or
+		affected CXL memory is busy, invalidates CPU caches for enabled
+		HDM ranges, disables CXL.cache, and initiates cache write-back
+		where supported.  After reset, the kernel restores PCI config
+		state needed to access HDM MMIO, restores cached HDM decoder
+		state, and completes PCI reset recovery.  "cxl_reset" does not
+		request CXL Reset Memory Clear.
+
 What:		/sys/bus/pci/devices/.../reset
 Date:		July 2009
 Contact:	Michael S. Tsirkin <mst@redhat.com>
-- 
2.43.0

