Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013018.outbound.protection.outlook.com [40.93.201.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CBBA259C80;
	Fri,  3 Jul 2026 22:05:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783116351; cv=fail; b=ON+VjnaKO4rfrm45EEz46Yue0yTIzrb1Axh9/qBgx3e5mpY7Us0rsY8NJ814QQ9EAZ9YEl4TlB7ukn1wMJz+w6uGdvIYj3lvJJiPnJwKLOBt+m21WGDYS4S7oAQxkMlswsYb2yOvm/JaeTbV4N8hZxeNOdqFOi7G9Pln7AHneN0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783116351; c=relaxed/simple;
	bh=ivKvlEgicFpxh3qE/x6KYYoq55Saf/rXicwl14O4hRY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=icv1msDHLHiBMs81sGB9YV9FUFKgPFJZLEwcXhyMeOYBq937wLwQcfDRgaJArvKOf8iXKTNS7U+yDO1jHxZvr7j8wNOsffIpJlSL7dCFgLqnRt7SgIerjegmNHhGoI7EFpxyjQKOKNbpQiYTQRqeNzTxb+8iMzNkDdaYvUV/q6c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=AhOvHWKG; arc=fail smtp.client-ip=40.93.201.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="AhOvHWKG"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oxUKXmg01QEzplioFWQmwo10OlddUoDqBdd+NVvtrzGu7iCciaQtKxu4QzTVVCZUDaG5eupmo0HwKeSzQVWEB0bDNWDJxOti3OJaj+Sgi5n+hqI/5CjNAdjzzrquvhEaZAyxyhGGIL5vwCk2toSbt+EMQvWqYFzWMWB4weEiviN7inbGEj1MwookKGaBDqPpGr0zurLV18zx8mDn8xjUUxMQvzBmqFENWKHI626mKEDJQ2z2Y0H5P3j5O4G2L85otbFh9ME90Pqa1Foz/78tFc9edCN8GfIJPyGZCGIGx9vAhofpp4F5w2UD+2kqEb4k1oRKnJs7uSr8eS6RTOL+JQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sukQT0g8XLNpMPtPjIh+IRNZp5P6uO49+L3ytbvnw3I=;
 b=r7/InOdeRiPoqtZYl63HBdQ2xkflSUOjviNsCC1vbGzykMXUwNcA8ESb1wLomD8OiPD2+QuktQBQ2+j7f3UHvFmRHm7ed/Q1q0kZpf3qWctF8AYHPSOtb/TvdlxOo+4TM56FGywOXCjyti3GZ5QP2dS5cXoVoIV7LBlXXDzJ2BwMWSgAn+GVTOO9uFQKlxEzriZ5ulMsr6hxeCvKuRkjyRXUCL7FJMniQv1FcDyVoHK+45O+9P1ej9y4PA/4mmi8oCCu6V81P+Hga5JHovvYIfx27MrIDYeU6fVw9tK0mI+LTC4+87nqPomyB30J7s1vWSIrq24NHG/+aw3vlCWA1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sukQT0g8XLNpMPtPjIh+IRNZp5P6uO49+L3ytbvnw3I=;
 b=AhOvHWKGciriT/K3V6Mjpa2Cw8B/nOub/UYeYHJTcKsBJ8gX8D/8VJ7bDvpEN5NodBECtOJEJz4+gDSy51v9iGfc2UXdy6hsjXz3Up9JzkI+iGrBs2vUFI8Is4WHErnD6RFZg6dwqlPQ5j+ZSlvlIXZsFC5dY+tKDYEpI1tbPo6djX1lgLhySESJyRrAWcuwh71gtQJVr2vX0tgcuybT6XXqWKg7L0cvpwBur98yIkz+4ZBF9bFCH5GM3JU+t/ulkbfr/PSNqxkwCnvh1uYktxd3/2Jq/EUg0sQkA/q5IPvq520D7FZYsCjNWb0/Mybzpqlx2Cq+mlkUfELyNO0Xwg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9474.namprd12.prod.outlook.com (2603:10b6:8:252::17)
 by PH0PR12MB7470.namprd12.prod.outlook.com (2603:10b6:510:1e9::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.8; Fri, 3 Jul 2026
 22:05:36 +0000
Received: from DS7PR12MB9474.namprd12.prod.outlook.com
 ([fe80::31ad:931:ef07:8ad7]) by DS7PR12MB9474.namprd12.prod.outlook.com
 ([fe80::31ad:931:ef07:8ad7%6]) with mapi id 15.21.0181.009; Fri, 3 Jul 2026
 22:05:36 +0000
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
	Dan Williams <danwilliams@nvidia.com>,
	Sai Yashwanth Reddy Kancherla <skancherla@nvidia.com>,
	Vishal Aslot <vaslot@nvidia.com>,
	Manish Honap <mhonap@nvidia.com>,
	Jiandi An <jan@nvidia.com>,
	Richard Cheng <icheng@nvidia.com>,
	linux-tegra@vger.kernel.org,
	Srirangan Madhavan <smadhavan@nvidia.com>
Subject: [PATCH v8 10/10] Documentation/ABI: Document CXL Reset PCI reset method
Date: Fri,  3 Jul 2026 22:05:08 +0000
Message-ID: <20260703220508.546528-11-smadhavan@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260703220508.546528-1-smadhavan@nvidia.com>
References: <20260703220508.546528-1-smadhavan@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY3PR05CA0025.namprd05.prod.outlook.com
 (2603:10b6:a03:254::30) To DS7PR12MB9474.namprd12.prod.outlook.com
 (2603:10b6:8:252::17)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9474:EE_|PH0PR12MB7470:EE_
X-MS-Office365-Filtering-Correlation-Id: 83e35378-fa4a-45ef-74a9-08ded94f35ba
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|1800799024|7416014|23010399003|22082099003|18002099003|11063799006|56012099006|921020;
X-Microsoft-Antispam-Message-Info:
	DfsNfzihYPgXPv1hnP2mRzbx55SM5Xs48toiUh5WbH2YpIpWFDeWJUKhy2/h/RXs1Nzd7MsLmKDtCX4icgD6bD2/A9jZBVDw6j4XX+GX4vWgpSbPUI9XYCtPzbszRDxVbDuew3M0z8R2Xxsunm6ER7h9YBkYe6gX+Z8TLt9i6/que4/rCQxw7aoCEp47L1y1xI4c7w2PnH9GGm/WicwiGSBzb+5Oy63t1JZ28GEjr6ZezA3NmSxaYok892qn+BXh8p7lhWVPka2I6GAlgyhZljlPCbMV0ofbKXtGNKJi98t9cQ0h7FFybEArwNpK6B+UpiIgPRrozU9ltsJkDYjM4PbAwkZsPO7iFBulr9e7xzbwjEYNdoowbuzQlfmqrtnJUthUv6NISvwzMMZlkqp0/N1uMN++cA/5z+HM6IXqNoPYpe5OjbT3AXecl612h5CDGogOKuHYmU/lhk43lUehbGFP94+q/90k8uCU5UeakTxnt4r/fa6zBOk5OytVbtv9BTc9zR+lkx3UCA3Xj971/VcJg2lJztpmeqKGFac0fjwbFfgO2n9E1ZWyEU9QFtjQ3omKAaoqf50jckp09bpydTEOdUUnZ6jSEOLTTZMl6yf0A0Wglxbmq1ojSAvif/Djdipy6qsXDvPkU44IHJXsQWUzsrIEdekZF/3fA1AOwfUhNlmFErcszWkk9uiE0Vh/UulU58zuVKjsJHVu3bYePw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9474.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(7416014)(23010399003)(22082099003)(18002099003)(11063799006)(56012099006)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?z7LdOBIg9nvk1MQQ2Rc8Nldkv0TKAUoi1lWH7GPmOqtH+lzo+4HvGaxTyzVg?=
 =?us-ascii?Q?dmFJdhZ/oKudpovY2yEOHHTmeKpzAjHPyZ/kWlfyZY1sSd/n74GfghCpfnWX?=
 =?us-ascii?Q?a2nFvgHlK/gY2MTkvxCUiGkIYSptBUs3PYsxxW8kznomLR6SP0+nr2rQQNKj?=
 =?us-ascii?Q?QUWiwoHl3PvOwraZYiLqYTFOLJnhbwf49vr8izQAPqiUGSvcGWawA9S2csFD?=
 =?us-ascii?Q?qhTYj2GcqPJa/I3RfLH82wTQgRaa2Rpab/BRwyDBXLzRCN5r7kOTmyyRTbDb?=
 =?us-ascii?Q?f5plwatxBsDBuG369Oe/1rCc1EfIdiX4c0WRw74sfSZlsfGpkTsMFHMzQtKm?=
 =?us-ascii?Q?taabzin0+gL0n6coN1Mhl7bpphYnPmEP9rrK9N/2lvsDG+yvQkBDL5Hqz9NY?=
 =?us-ascii?Q?397CsFSGV7CDwZe5X0BByDbybWcnLMcuOtXznmnx4NZ2m1h//vw8+HnjrduB?=
 =?us-ascii?Q?ZefM4ivboS4NvgC/GtRJXK5KV+RxcsguNKdOEplkV3f7lrI5Wna73G+4nN+s?=
 =?us-ascii?Q?4I+tK/jtJotMnMFEHqvZsf27axPMpdvK/wVA6AzBupJVROfSAjW8flT/SSQ2?=
 =?us-ascii?Q?jmeSch2NL5Vm/WABpNmiRDnBSZbEw/X9Sz2pW+S97y3IPEgEKxzLcrGqP1AF?=
 =?us-ascii?Q?RIamuAgbXibkvfNFHrEisZc+9/Y68EhBNinPy4CaHRXuvc62hFfCjVUI9NIA?=
 =?us-ascii?Q?NUYoTonLly1FQfnV9FQ4JHnifZKnTwSk2PXX4d1QiY2wlel/yvb9/m6qUOsL?=
 =?us-ascii?Q?HSocEfTiPJxgwE8/aZN2GXLq1A3PXqPnCfNPFcuQpfmhI/Vlf+uYwO/x56Wk?=
 =?us-ascii?Q?DYVjIRODTmcFNTRCLdxVJqOHf4lvody2cfXi5YC5BAa3VFJNQk/5jy8tSF9R?=
 =?us-ascii?Q?n5anLu862h4u9yYKIa1IGdOJB4ue4EPr5JIN86Y6I7nlPpmT7Hh/WFqVT9pk?=
 =?us-ascii?Q?GlDIumCFf0K9XRT8q8ayqxdGzrdVX8Ww+vRiheoWg9agQD76IqUw1tIYJXI4?=
 =?us-ascii?Q?jmVk0H/ipmCxCJD3UXM66seu6cMeL3P+9oMxNbEZ2UawQSL0LqqIZJ0wzYsc?=
 =?us-ascii?Q?uHLtwEJ0+N8SR8eCY0iS3kRmz2v5eDW/R4EG63WQYHC3n3jtaLtIIL7G8dPO?=
 =?us-ascii?Q?plX9tUqGLpi/ELEgoo1iXWOnY+Ea/Uyh/IsIuQ3kOOqKbE7nImrtYYn7+0zd?=
 =?us-ascii?Q?M+e8VCbp89WAqPbNOT6aCpK61oDgqgPdCTlv+s4KHzH6MpWND/FyRT4n/cqQ?=
 =?us-ascii?Q?VMfHDTZQPSJ4HFTb7JG7TfKyBY/RCgR5iIH0w0WX5KSZkJocxMvwE85rwBVm?=
 =?us-ascii?Q?x2rkxAPy8GkeYoQxxkDRmKRpER+VXyOLl77KyPvpnSOCCmW7/fULi4Tru8ns?=
 =?us-ascii?Q?4a/P4d3Pai22dDldWAK/s6ISA+9wiBLUMLAbYEvoF+1IwYH4hdMBI7QVNM6D?=
 =?us-ascii?Q?HJObQ4QLW1p1qJoevRLa8zM+6yLVPc4chOiV5L59WsqLER2Gr5GsssZ5Mm/i?=
 =?us-ascii?Q?AI0VJVnd/nybU7Yvqm7Zl2yBna3V+8T3AKBqCbCpws+2yhENC7xeEdhRjaiv?=
 =?us-ascii?Q?I8ULN0tgSnbkosh9jg0z/JON+Axy6HiQFyv39b7RXenkYPJGuAHwHHj6dtvr?=
 =?us-ascii?Q?cZjqKGNZloQHiAe4LRbABYjQdysSwve/k+ZitlIrII8hNAd9x/SmgsV6dECP?=
 =?us-ascii?Q?VKsugk2o8brfxj+iIqoO1EtWs24r/NDOHKGJCE0MFYMw1hvCV5TCsXdUt/dw?=
 =?us-ascii?Q?i8tcXSModQ=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 83e35378-fa4a-45ef-74a9-08ded94f35ba
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9474.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2026 22:05:36.1541
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: plMcDsY68QmKH7ctZSLR/IBtP9KBBIfJic9ExdlyX392U0kmmEqAd/ssQV85BHQUS0CkG9SyId5wIgCIwPyjvg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7470

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

