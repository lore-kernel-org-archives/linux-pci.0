Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010070.outbound.protection.outlook.com [52.101.193.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C56D73563E7;
	Fri, 13 Feb 2026 12:36:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770986193; cv=fail; b=hjRrWTkKJhNK4HI7wyAgIRb+0PoZiuhISJryvPGBukm6KecY4Ivp0RBHV7lBR+8ygkVUVon1cCaGJPqH6Nnk7HWL8R1vf9wkwl24H4e+c5Js40K+NRgkCqrFiT2/oVx7KsOZa2kpDGA1Ej5ryIUve9+z8IOuDyg9yFhXvg5m10w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770986193; c=relaxed/simple;
	bh=AzmZAW++67rqdChyas5ozMLmWUbb56G0aSiAFZ8opwY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZpqiBl4Ocat0feHGL2ULrldHJnzTm7BJcUtonINDyqPj0Mf6zTW11J4V3SkqA3yTh0Z7z7cx1tf++yC3ga3ZXcc15Qgan1dSrJoCpP+oXPzlh6Q+6MuY6JVjsb/kvuAsfm4nopKJ03935yBXF4kCpF8Zc3K5YNx2wr6tDxQExEg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=Z4YduCNH; arc=fail smtp.client-ip=52.101.193.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="Z4YduCNH"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oCKegmPt03JVnDljGhCxC/7adMggqxsOAX7Cg4l+ogC3sOI0idVjmbH+vQD6AUAuT+iNF+nohfzu03wrFT+WXL5/sKvLT0i9ka5lN8P5vR0R7g0PXXs0oMvpM82/jlJwXtx+m2XOnPPYP8oGOjLXgeEq6VwQEpKpXfUlaqZwk0LOMV+oPu0ET7aLIQ3XYpiJ970Ot5lkfUi5zXNZHxNpMkTkJTQ95Yi+KPqAzZoV16Q3/I7Tu4CZfzygUbNzAUwfzcwn+aNjkK8TceQxILmsSDaz2LdG9L2Fl8LfhOyqAOXF7qinK2hVRf/Pawkc3M/v9y6FTT6Als68Dl2AEBjjXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jNK6Kpu0ksbxtIA5SSFIOF9em/02Hdn7xKhRs+Tu5Ik=;
 b=KA0LOawlQyqAxrpELuYppY6gOwlWuKwWlP8bRjWVYbIN9BSDb5kCrkXHLDseXQkjRpfYf/gHeF8OQJEry3MOvGt2RGHLl/pRe9AWH/hWmdE9HeW8wvLxecbF/JVAnex+LDAu47NOW736GBm83256t1Y4osng5UmG0BGhQvdU7TVRzOMeHT0IH8GXIpr2H/xZ4nelY2EWs962/pkcS4OEAQ66rY64HogzjuA4bDQDS542VJrUl9hQjimx4wadl+HgArujsj04cQ0X3J4kNzmmw1AcniXbTVonSjOuu4Z4Fc24AC3hdCSzUZ1GdBYBN9siIf8XQuilcDTZBtAgxBEW6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.195) smtp.rcpttodomain=lists.infradead.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jNK6Kpu0ksbxtIA5SSFIOF9em/02Hdn7xKhRs+Tu5Ik=;
 b=Z4YduCNH1iFcz08P8qEjmGYopRo7qtVKMg5ldP8ZTkqWl9vVdEC7z0oxrH8Ps6I+UrrcnJmpYhSFxGh/L9Xn1yyiyOTjaWjljR4fTxMJRRf9RC9sg/kafnVoM85LCwvBxUh2ZZ9z71I96PwMT7ucwQLG0aw3xpFAnk4xVb5LX3s=
Received: from CH5P222CA0019.NAMP222.PROD.OUTLOOK.COM (2603:10b6:610:1ee::20)
 by CY8PR10MB6562.namprd10.prod.outlook.com (2603:10b6:930:5a::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.13; Fri, 13 Feb
 2026 12:36:29 +0000
Received: from CH3PEPF0000000A.namprd04.prod.outlook.com
 (2603:10b6:610:1ee:cafe::46) by CH5P222CA0019.outlook.office365.com
 (2603:10b6:610:1ee::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9611.14 via Frontend Transport; Fri,
 13 Feb 2026 12:36:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.195; helo=flwvzet201.ext.ti.com; pr=C
Received: from flwvzet201.ext.ti.com (198.47.21.195) by
 CH3PEPF0000000A.mail.protection.outlook.com (10.167.244.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9611.8 via Frontend Transport; Fri, 13 Feb 2026 12:36:28 +0000
Received: from DFLE200.ent.ti.com (10.64.6.58) by flwvzet201.ext.ti.com
 (10.248.192.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 13 Feb
 2026 06:36:24 -0600
Received: from DFLE213.ent.ti.com (10.64.6.71) by DFLE200.ent.ti.com
 (10.64.6.58) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 13 Feb
 2026 06:36:23 -0600
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE213.ent.ti.com
 (10.64.6.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Fri, 13 Feb 2026 06:36:23 -0600
Received: from a0507033-hp.dhcp.ti.com (a0507033-hp.dhcp.ti.com [172.24.231.225])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 61DCa6AA751418;
	Fri, 13 Feb 2026 06:36:20 -0600
From: Aksh Garg <a-garg7@ti.com>
To: <linux-pci@vger.kernel.org>, <linux-doc@vger.kernel.org>,
	<bhelgaas@google.com>, <corbet@lwn.net>, <cassel@kernel.org>
CC: <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<s-vadapalli@ti.com>, <danishanwar@ti.com>, <srk@ti.com>, <a-garg7@ti.com>
Subject: [RFC PATCH 4/4] PCI: Document APIs for endpoint DOE implementation
Date: Fri, 13 Feb 2026 18:06:03 +0530
Message-ID: <20260213123603.420941-5-a-garg7@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260213123603.420941-1-a-garg7@ti.com>
References: <20260213123603.420941-1-a-garg7@ti.com>
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
X-MS-TrafficTypeDiagnostic: CH3PEPF0000000A:EE_|CY8PR10MB6562:EE_
X-MS-Office365-Filtering-Correlation-Id: b5cb4383-96c4-4e5c-587a-08de6afc822e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?M5X7l1GlDMeAoHlh5gu5fOcm1lRqoS7vYQIXg9rfQklaF/e55RKt9vLvqEhw?=
 =?us-ascii?Q?Oismgtq1Ay1CVB81h1dZ2+XbWGW2wFqjfRW62H2wifxoLWqHNAlT+NFTnHR3?=
 =?us-ascii?Q?pIvwFwEjV7AGlx9slfue24BYl4awyIW4I+6SmNLS1FcX1mdWQM4D7Cv7ofNn?=
 =?us-ascii?Q?nT6C0PMdcxD5gfgzFY3rrnhFAjYDfvn6nEY+9YTCZXHYUKOa5BHzs0TKrWfF?=
 =?us-ascii?Q?CC6O+doUKEaY4wTkMcRVyrpwuY/huKJ/xH29SboyLKH0OvgDWeg56ZHhCacl?=
 =?us-ascii?Q?BitmhuT+XyIQgEbuNWIkWi/PWJDK6TlSBypYUwtjmHeJgS/QO9hnuzKiVdt8?=
 =?us-ascii?Q?PAMR0WdctCVniAdtoIGDwy3ASPh+q1IcxuJmRaUIhzrw3/Gm10obXJCNzd8o?=
 =?us-ascii?Q?78ymIIfC+pWxi/lcCn5YYI/kBwAW1xJzxVq2n/fIexzObvgLXuiBrCrTjaOy?=
 =?us-ascii?Q?KDzeikeN6qEbMOKVhAa+ZLZEFBfUXsOlE/Aw41or7GCN/my5EL+65r41v4lz?=
 =?us-ascii?Q?g1fMCrIVtRC0en/wIHtREluIskav/TJCM52iSyeiXPpaxDQ1R8NVW1njrvs8?=
 =?us-ascii?Q?bW/GhsZSkv9tSxUpJoBvdePCuZG6y/ESv9nHTc4RGNEkwbNk2OCuAaog2Rlg?=
 =?us-ascii?Q?y6d65XspN8hvkvN60GvuPpMtTh5ACa19bqtszqapEG11efTseE30dNF0GsKu?=
 =?us-ascii?Q?dauCzYZUrjpk/Y8hTASB+OTGuYrAetEjp+U18tAjznJn1pHV2EbT6HDvpfQP?=
 =?us-ascii?Q?Nyc78Dbmq5QgdcUTql+MjiCmkSgYmt6TB2Bk0c/PHzjhAnb+MG4fekrSzA86?=
 =?us-ascii?Q?aGBl2mLB11jhn/xPVdBctZ9RJJkayzGDvZLzWsWZ0dzHz++rcxz7ZvBmU09m?=
 =?us-ascii?Q?LxIDfk4oIFBkwfp3+Rgh9grMReeF+4F+wsrzVwKfgreYvPUm4v9+49RXnc8x?=
 =?us-ascii?Q?EpYhSGgAn6p2Wj5ehBGF3pWXpMEoxRnGNjVprAOCk5BOCdDY2Zdju/wB5V8X?=
 =?us-ascii?Q?0m6awxs5T/jO4+2mVCPsvQ3dihfbQMjUjDj7CfQTcwyL5doVB7iIqUDib8wg?=
 =?us-ascii?Q?BNrWRl7Ip7/PGHAeu9WFdhmY61LTHadbIbMQe9vzOzmw5+7V3oUvYiQihYfI?=
 =?us-ascii?Q?YTBgpSKSkPEoom0/VWQsWT90+xmLAoAkl+dw0l6IcVFs4UBR6e8pq8cI7nMV?=
 =?us-ascii?Q?D5baAnxhAFhwTMpLe6Iwg8jmtW7pkjgU3IqLOfhTRQriTYBq0zvB64UTRzaq?=
 =?us-ascii?Q?/6fTKUJ4RlQdm2nHRJNzhBaKIuQ51FCrg8lTJVss/uOUjGj622yDvy0PRgC2?=
 =?us-ascii?Q?522Cxn/LIUum/jLsiundDKyOzxOB8AdaBkx6SeWJeKdYRpWGEqHmxSr0AUqF?=
 =?us-ascii?Q?1WHHiKHjGY+05cs37f85pIqQ1JOOS2mxLwt0zEeKQLANOs1J7AuS00AQ+DiR?=
 =?us-ascii?Q?aZPl6dqO0k+0I6lk3VG7a3imRG+gNmK8CbOBAnip/XUBzkBBAXCGpJ8ZCJuA?=
 =?us-ascii?Q?ux5V3ze6+gUdiCakvTGvpg+EHOW8WmtA5J+2BfxIQE6Cbqu1UawbLP2rd6OU?=
 =?us-ascii?Q?1QutfyfqJZsDZuYSjcJhlQG4YsXr+4UhP7bF/SFXy/Bd0JgTO1vz+WinRyvO?=
 =?us-ascii?Q?Yf55mZDh69WZ8Eis4EqOUiZwweHWysRZHDKdUw5sN7jmx5jKTbEplRuc/8wY?=
 =?us-ascii?Q?ZCM+4A=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:198.47.21.195;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:flwvzet201.ext.ti.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	y4AlUS4IXcqk9IUDJH9OzWAynkolZvOVN2twjpi4V2nYFhj3Wqb0xYG0aKFfhXwv1wjb9XzeQwHzVJR1nhRBk0p05CVnTcMj47jjvPE45cj12x/J0ALN84NkEgKt61qU6ni7M75S16xG2ZegTNPzUpH91UgfAtWeJGTtOiZRDu0GxhfdWfCALktwf+Tn/lZowBNq5qqN+gPWSPMrGlauuO8bM6l7VWJGh849hGWcuRUmG+ZAKSse2GkVA7ZzuIjkKvH8YrGBaYXgwbb9iFQfC3pv5OrGy7fkAy8AkPiboQdnW8qgre4PC1aXxIG8F+9YnrslcCpkIDjm9fsqyn92Nw6Qi60R2VmgWGt+m7YNUNI055/8YnaH2TUSe6L8YtIxS0DGaUy1xo4w+SuYyva0s/e47CvUT2RyYo+ITKaBw8G8qH2S8xyupsWBAdgDvlDM
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2026 12:36:28.0647
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b5cb4383-96c4-4e5c-587a-08de6afc822e
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.21.195];Helo=[flwvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH3PEPF0000000A.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB6562

From: Aksh Garg <a-garg7@ti.com>

Add kernel-doc API reference section to the DOE endpoint documentation,
documenting the exported functions from drivers/pci/doe-ep.c for use by
endpoint controller drivers and protocol handler modules.

Co-developed-by: Siddharth Vadapalli <s-vadapalli@ti.com>
Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
Signed-off-by: Aksh Garg <a-garg7@ti.com>
---
 Documentation/PCI/pci-doe-ep.rst | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/PCI/pci-doe-ep.rst b/Documentation/PCI/pci-doe-ep.rst
index d6715944c117..6ad064e838e7 100644
--- a/Documentation/PCI/pci-doe-ep.rst
+++ b/Documentation/PCI/pci-doe-ep.rst
@@ -289,3 +289,9 @@ When the controller driver receives an error code from
 ``pci_ep_doe_process_request()``, it sets the ERROR bit in the DOE Status
 register instead of writing a response to the read mailbox register,
 and frees the buffers.
+
+API Reference
+=============
+
+.. kernel-doc:: drivers/pci/doe-ep.c
+   :export:
-- 
2.34.1

