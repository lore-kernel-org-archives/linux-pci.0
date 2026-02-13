Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011006.outbound.protection.outlook.com [40.93.194.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AA1516CD33;
	Fri, 13 Feb 2026 12:36:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.6
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770986174; cv=fail; b=DucI6/NRt+YTj53EWP2ZAOEIaSyeMNhGWfnVvnbPzNTVUxDDXSV4/ulI2x043duES+eo0AwrF22Y82X4Ief9WPaaMByUXWnEQtTR2Q7n+TiwbVRY9dxyvarpImm5HXWMXIEPTZU4BiRQ4XjwL+yv5I8NWJA2pwMAixlkpUZnO9c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770986174; c=relaxed/simple;
	bh=jNwDU/Oyr43JVZkSZka7LuRN4Rf6Movx2qxGRIZnP8I=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=gRtFfhSAcsEPizp8qHnL9mhV8bG3Zqj88OktiBrvIyxKwSbC4thvwyk0lcx+noZtD4MwxJacQIBNrE0cFKmNwUMr1EeU5L+6CUJk9AwXj+LF9+9N78dFQafcJSVBSkkvAodthO6eY3yT8OV7JQvkVdAIDymoL8jjbLkiMueTvFo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=aWanimx4; arc=fail smtp.client-ip=40.93.194.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="aWanimx4"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=o9NdCgVy4wTRgh18lwgjHvF6/3Z+Pq/1KWn8SmrU9rgGy52DUjoi4MZRyQ7eIf6GBD8mAehCDg0SLLzAv4thmui1IJfQvZvfzRoyBoKf3kkGQgKps9F/upHJ23/hczi0bI9BoYPfzkWEI5T2xSbsCESEzII4N36/9HQpe9WX7/d9BEV72cApoMYMZwc4MwZu9ehzH6xbyZQxVMNRcTQ1pgr6eCLjIQGk3jL6tGDRvb6RPopgQuNcP9nnlFS/O/IliPF360lF3ReC7Rmg6HftbqeLzIicQDyb6OukMmOgP5Oy9ja2VH8xJyfwgXksX2w9QM4oy8tHQHC+a/pT0Zx8TQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KxOQJRW615k/5FMHwG7V99pt/BTJm5/XlpmsucldVQE=;
 b=suKUJHVgSEUpxF/96KRJCissaVko2G9wQuc/0LS2ivWoOj0ZXv3W+XgFtcnu2f5mARljhKdlyc8J56CUN7xSQliBX4TrXSx6NccSzECgwdgOyLcRTfeGHOSqKs9zbAHW/ozQ3SPj8iBCEsw6K5KtVW1ezvjlQGQumjyJLqrePeIRfqtak9k8WgTI7U98jZV2eqENbZKbuZ7PSGFuQk16/mNv3VtSLQEleA96GXTGPPY40BZ9wJR+15+JjOgq2blRz6etBr63Nm0sV2bMKL0voxxHPQGOFuVB0xWquBLufZK/i97oEZ2q45OWB/FdIPxnsRIXdQjr1oKX2IP5Udz6Ew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.194) smtp.rcpttodomain=lists.infradead.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KxOQJRW615k/5FMHwG7V99pt/BTJm5/XlpmsucldVQE=;
 b=aWanimx4kk/vu6gMtkLrFKFbRQ70nGJQVSKwwu00vrktMY2tnv0I1nntBY9kLzdWg9sSxJOX+IpBo0uLq4BzhgQ1mlkFZ+j2+gV6B0L/E6m4oQrNzU/k9uywl6kHoaSLDB63APF9ZTlJ3tzsmwJOWckDHt2KqqhtCoFng3bHTH4=
Received: from MN2PR18CA0007.namprd18.prod.outlook.com (2603:10b6:208:23c::12)
 by BLAPR10MB4932.namprd10.prod.outlook.com (2603:10b6:208:325::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.13; Fri, 13 Feb
 2026 12:36:11 +0000
Received: from BL6PEPF00020E61.namprd04.prod.outlook.com
 (2603:10b6:208:23c:cafe::38) by MN2PR18CA0007.outlook.office365.com
 (2603:10b6:208:23c::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9611.13 via Frontend Transport; Fri,
 13 Feb 2026 12:35:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.194; helo=lewvzet200.ext.ti.com; pr=C
Received: from lewvzet200.ext.ti.com (198.47.23.194) by
 BL6PEPF00020E61.mail.protection.outlook.com (10.167.249.22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9611.8 via Frontend Transport; Fri, 13 Feb 2026 12:36:10 +0000
Received: from DLEE212.ent.ti.com (157.170.170.114) by lewvzet200.ext.ti.com
 (10.4.14.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 13 Feb
 2026 06:36:10 -0600
Received: from DLEE201.ent.ti.com (157.170.170.76) by DLEE212.ent.ti.com
 (157.170.170.114) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 13 Feb
 2026 06:36:09 -0600
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE201.ent.ti.com
 (157.170.170.76) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Fri, 13 Feb 2026 06:36:09 -0600
Received: from a0507033-hp.dhcp.ti.com (a0507033-hp.dhcp.ti.com [172.24.231.225])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 61DCa6A6751418;
	Fri, 13 Feb 2026 06:36:06 -0600
From: Aksh Garg <a-garg7@ti.com>
To: <linux-pci@vger.kernel.org>, <linux-doc@vger.kernel.org>,
	<bhelgaas@google.com>, <corbet@lwn.net>, <cassel@kernel.org>
CC: <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<s-vadapalli@ti.com>, <danishanwar@ti.com>, <srk@ti.com>, <a-garg7@ti.com>
Subject: [RFC PATCH 0/4] PCI: Add DOE support for endpoint
Date: Fri, 13 Feb 2026 18:05:59 +0530
Message-ID: <20260213123603.420941-1-a-garg7@ti.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF00020E61:EE_|BLAPR10MB4932:EE_
X-MS-Office365-Filtering-Correlation-Id: 1b62315b-e88f-429a-4ff3-08de6afc77c4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|376014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?UyXZWNA4B2EpI+S7+ZC1ikGneANrmPSTjF79VgFXd6WGbOWtbrYtLM2dkinz?=
 =?us-ascii?Q?auROBcLbo2TrYkT4DzzS+NpIt/n+lvludZbSup0Lbqj56bqLKOMgIeXe4vIt?=
 =?us-ascii?Q?JMTi7qd30XEF5GB+Ojh3sRINF9Ol1d+u0i2vDASHrKU6KfBP6lYccKHzV71f?=
 =?us-ascii?Q?rmux8z/OS6EJ7p40WzrWHHVyMAY+ml68Sy+v6OlocWFErYNlfdHC1Csq8W7x?=
 =?us-ascii?Q?w+dDd8WeFpzdT/p7h6zqjgTrSHZGl/dCknjpS3l1wvrYGJgAGbg7Br4shmPT?=
 =?us-ascii?Q?EoBVZXqRD+Tbj4kic+cfIWzbUGbfH2R9eaow86R8klLgMr1CBwGORS2wh7ri?=
 =?us-ascii?Q?tzev6sr81G4c7wjsy8dfnDT9be/zfLRhjp32uY8UZnZeZ4sCtp/bxCDZ4SMT?=
 =?us-ascii?Q?zVg/yP3WH3XPPFIh2bMuEVr31N4IKZrTt2l053eZ7EEybWwCxwg0F1NJf73y?=
 =?us-ascii?Q?dhqrwlnihRsFZ/Rsu65+nokDhhbMDYsUIclSyxK8vq8I2VUsPfGzGq0hYCZf?=
 =?us-ascii?Q?RKLGy2sl0CljfxTWcrbwhB/HjLPzA1SiVbb8glxmb0t8OA8+zoUtgbSEJIuI?=
 =?us-ascii?Q?OFkKQXqhitPKpWug1U0cNtjORibUKQWLJXS6tcY7W/5zxSYThO3b0AhIbKxx?=
 =?us-ascii?Q?0Nu/QolzTfwCiSL62ybvYFdECv3jSqKcxho3p4gNtfUKwHyBq2KnRzoFBmkM?=
 =?us-ascii?Q?8ZvKDFEaff1oidQpCc1yd6h3pqiI2i+lo7QLb447FZ9n+Kr/6zJctEXNBEuW?=
 =?us-ascii?Q?F8VC5pG93AW5XUiJnjnxB+PyU0NmV50gwQLds+m5uk2T5yaV2G10Gvsb3jnh?=
 =?us-ascii?Q?yapK7YwhR+LjAH6MVGa2jLKjNt0TlKH3mDPbfcOuS/2X1Wozh9UJNiG3jdvd?=
 =?us-ascii?Q?E+l+mG5kPeHUS1FqYyAVkm5Bkx/DprHpyc6ZAHiqr2eaO+T2ATs5CEORY2YI?=
 =?us-ascii?Q?x3ExatqtWtmBQDWk4YT+os3e1D7SuZ7a8N2+c7WTFpQndyl/C186366+DhL5?=
 =?us-ascii?Q?vklHxkMNqWDaMeZM5R3KkIZfv5T1coUgboMV1LH42l4KJH4mA4MHJ/bQRuIj?=
 =?us-ascii?Q?ProWFqQFwqQap/L1VRXI4acJjeOJCkrf1H5Rg4Ov155EqPxUn5b3fFxipVdR?=
 =?us-ascii?Q?QsxvQNVYzKaeF4SHlHSLGhq/19FMiEx4ac0nnvUDvVc/XJg+Hm883n2xjtRl?=
 =?us-ascii?Q?si15BL0FMltTzI3LP3T/x6NIF+o4caDSPLLXTRlW78zqhpgjmqt4kiQZbvPp?=
 =?us-ascii?Q?VKci+qq/C/f4ml4voh6SHEqX15Qn1eCrcYuraaEs/U9AY3uEVw/dm+IAVRGE?=
 =?us-ascii?Q?hwZT0bFj+0y0+w9Q8CZPFNi8Mbn9lqojmx5WiKjGaKReVmKDabFUGSVAvsp/?=
 =?us-ascii?Q?KX9ZyvU325CwLZpFNpg4Vzzfvq2NbJIjZ+3xnxPcrBkEDj2xAOns2lt2/tZM?=
 =?us-ascii?Q?BkfbLNgtXAItZMDvrHxEMUQFgOI/L+bwNzQVjlvFprVFReoGa4lacNJwh3Fp?=
 =?us-ascii?Q?Esmw0u1cWLk9r7ePWF3O/4D54vrc8ksXUpOL45Cd6fwWuFnDt91G57CO25Ad?=
 =?us-ascii?Q?a67qaJhfAyRBQctsaEpjiVbhHFGACED78Be3J0t6pOeHfNMHI+pXbM2TVPXf?=
 =?us-ascii?Q?QzlQWFL1UjKF5KOH55E0C1v6fC6mVDXB6KMbG91wZycs8Od89Muh1g0NJU4U?=
 =?us-ascii?Q?vIQxow=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:198.47.23.194;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:lewvzet200.ext.ti.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(376014)(36860700013);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	CgYulBTRSExbJcXq9c4CW3ktq0DG/hZdUfXkgxKfV6+JzT3jQllim9PIm4utE5rs4C/iPrmxfgPhkJmWQBKsSDy2XoFMnSyzq9TCgwrW8z5Pb6EaMAduPPU+EqSmCfG8k/5Lql1SVfzPObbET5Avi5hx2bMBGteJnhjcWVz/xbbYw+tb4tUbJg8yQ90vTKOeuP+9ZJhgkKuapQwFvZDZcVDXtNEW3GEfx5K914F7CDMlznJKCjwLHufj2Of9EyIEnJEGmcQ1f6HVHZ9u2X6frng8EaFok2JMTKkMhr418DaXc9SJuioB8M+SZVmwevMKye3OALqcwKM86CKHnK9gcL4EdZp4sr+HOe9lhjwXJ+vBrDR3qkCRVVBJgoTMEctZXWLuuJrd8NmK2jVNl17ljjPOtd/uo34u7O+uL+pvBsnJ5eYMZRA8JdWgL6AuIssE
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2026 12:36:10.5665
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b62315b-e88f-429a-4ff3-08de6afc77c4
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.23.194];Helo=[lewvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF00020E61.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB4932

This patch series introduces the framework for supporting the Data
Object Exchange (DOE) feature for PCIe endpoint devices. Please refer
to the documentation added in patch 1 for details on the feature and
implementation architecture.

The implementation provides a common framework for all PCIe endpoint
controllers, not specific to any particular SoC vendor.

Posting this as an RFC patch series to get feedback on the design and
implementation.

Aksh Garg (4):
  PCI: Add documentation for DOE endpoint support
  PCI/DOE: Move common definitions to the header file
  PCI/DOE: Add DOE mailbox support for endpoint functions
  PCI: Document APIs for endpoint DOE implementation

 Documentation/PCI/index.rst      |   1 +
 Documentation/PCI/pci-doe-ep.rst | 297 ++++++++++++++
 drivers/pci/Kconfig              |  14 +
 drivers/pci/Makefile             |   1 +
 drivers/pci/doe-ep.c             | 671 +++++++++++++++++++++++++++++++
 drivers/pci/doe.c                |  11 -
 include/linux/pci-doe.h          | 107 ++++-
 include/linux/pci-epc.h          |   4 +
 8 files changed, 1090 insertions(+), 16 deletions(-)
 create mode 100644 Documentation/PCI/pci-doe-ep.rst
 create mode 100644 drivers/pci/doe-ep.c

-- 
2.34.1

