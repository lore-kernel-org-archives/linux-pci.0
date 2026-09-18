Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012062.outbound.protection.outlook.com [52.101.53.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2402A4FD281;
	Fri, 18 Sep 2026 14:57:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789743426; cv=fail; b=cSNmFoiK8EGRKeKtqXrpE0PzqA1Skt0jSOFJg0bpIcmnIAOzV8K+4PhL7YjGZ7s1Kt/kd4KkMbZnBMXKt54YwYxx9Fm1XG88Gu3pBhDODszTIOu1tHziU+ebUWAeuJ9uydgiZ5su8Z1zavx1H/4Cauy1FgOVd8xewTgJGl5e68o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789743426; c=relaxed/simple;
	bh=ABlfQmlNy4VsTWgtyfmUTNEoxIA+Z+g75wcAXFRwA7Q=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FudJncVDnosIV0jDUj55LxWhv+aDR5sogvpxdtOjKOI/i1JbpJ31dWpS1Q9PacpLmlW2IZ0MHILk+epEdXbesmcEcE4dButokfCB/nKAQo0gRDmt/iIBuYTipargyLbcs2phW15UJkPjKdSEoPXVjELxYKorMWLWNU6mrp8KFLI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=NoQx8YPc; arc=fail smtp.client-ip=52.101.53.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="NoQx8YPc"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PTcW2RQY/ly1tXX38odVWzjYfDdD4Szdc44AilUhmTUnm1QLGUwm4DwSGFxrpyc2E8sETHBfaIBEkdgoiWY44fpTM079BJEN7TziGczQgBuOekC8wmn0Y/b0euEsTxdpSGsLn1A5ex/gBngRT9hVUz2H6d062jPPkMgevmRxIr/JIhHwT5b3a1051qxEYKovgRXcuQMnXOD7oZW+VZOq1/0WdfnklHiSa0BGoSXh39kwLrChQDmGRWc6GS19tAt2N2tHaUeb9eiVsvm2e0tXjfQHtM60N/D0UqSZBlh0Lz72GQp5Smg25uQn//BCQEH125TCY47FE1kZblxLlI22rQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yniPFnsrsXiNU7/1KIm+Tdr2jVAFwyvuEOJNXY9JFrk=;
 b=Hdggj0XOd8W541MqAoN1W92RPN6VBmSX+3qZgyt9fOyWlsOJPB7r17U98mM+Ajk02bEAOqBnEec8Na7brU9oM+XIddO+jC50Npjk8FB20x7//n1OpyrkmEbU1zJNzfx+PNwxu5otS8h2pov3YjQuMl7QIGsq11x8J46P5fGOx+lTs43CLIGp/jS/n9qx6sZ+lYB+oxtSF8yTTiA1UAGH73ca36v8Yz7xsWXLmgoRi6u1UkAN8G2jWQG+LtjfYGwUnpP7NSjUTKT+Pncid2B0++hIHaYwQE+wJdhTV6io/XbQvEv04cZPumzC1c5AB/x45nkvFsmuwFVkf5jK5JkbAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yniPFnsrsXiNU7/1KIm+Tdr2jVAFwyvuEOJNXY9JFrk=;
 b=NoQx8YPc46HbvjWFG+zgl7y8z3r285i139AgLL/LRGNiNmHYd+ZzMaCd5yXhhuY523JShtzIeqp0luX6o0qe8MhWsc/bAHhCh8qVNazw6L4p8ek+E7h5NamkQ+HxBMfd8ptL59w7nkuFrrNU89k6h2QnMBI4mYo2fNlHJwYBGa0=
Received: from CH2PR15CA0021.namprd15.prod.outlook.com (2603:10b6:610:51::31)
 by SJ0PR12MB7474.namprd12.prod.outlook.com (2603:10b6:a03:48d::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.12; Fri, 18 Sep
 2026 14:56:52 +0000
Received: from CH2PEPF00000145.namprd02.prod.outlook.com
 (2603:10b6:610:51:cafe::20) by CH2PR15CA0021.outlook.office365.com
 (2603:10b6:610:51::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.428.12 via Frontend Transport; Fri,
 18 Sep 2026 14:56:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH2PEPF00000145.mail.protection.outlook.com (10.167.244.102) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.8 via Frontend Transport; Fri, 18 Sep 2026 14:56:51 +0000
Received: from quartz-7b1chost.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Fri, 18 Sep
 2026 09:56:50 -0500
From: Yazen Ghannam <yazen.ghannam@amd.com>
To: <linux-pci@vger.kernel.org>
CC: <linux-kernel@vger.kernel.org>, <linux-acpi@vger.kernel.org>,
	<linux-edac@vger.kernel.org>, <bhelgaas@google.com>, Yazen Ghannam
	<yazen.ghannam@amd.com>
Subject: [PATCH v2 04/10] PCI/AER: Hide the "aer" sysfs directory when AER is unavailable
Date: Fri, 18 Sep 2026 09:56:12 -0500
Message-ID: <20260918145619.3016889-5-yazen.ghannam@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260918145619.3016889-1-yazen.ghannam@amd.com>
References: <20260918145619.3016889-1-yazen.ghannam@amd.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF00000145:EE_|SJ0PR12MB7474:EE_
X-MS-Office365-Filtering-Correlation-Id: 6d4a8700-cfbe-4d3f-5725-08df159512da
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|82310400026|376014|23010399003|1800799024|11063799006|10067099003|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	Mw5I0XdhsZdSV4YOgysVgXMwv2Meh/P0YnbUm8U2yLdgdaAwsWHD6VOs8YLkZbbiNly/XG4Zp2jX8qjxEmxpoaVMLNUAxq44YefOOgGyTGpRp1uvedckSc/65/gvUarHZMnY67+VJt/w5ClXndp6l2C6k5mlpAF6/w9zFXNCyiX7xNeew0VDf4RqisDqbw0WazsenI3FWY96E54xNgm3gbQ5q3i+xidTM2qVskRQfoxeMlrPhCOK5+C7Qtp+H5ANQahyUjKrrwsHg2eClDUwqOdFaMmxhR6W1MV4/1X62389/bRzifNfEU/9SgaCDQIgax/tS2ACrjVzcPFaECLn7AAaM4GffUg5vTmjq50Yg+OOegGVbD8yUkKG+ZfjX3csRoiFGRttf7gHFmwbwStwJqZrhZ0voFywnFB6oLPyx8Mfb/mzF8TcEOvpVd+fzJWKqni1arT6pqiqWn2VaAWcpmjq66QD3ZFyDf+71yU0kucLr1FMqHrKjGzPbwaSVpzRI+oB1TnjWJVCxf7AcPTfpVGiNDp/8LQknivibBAep0hMUczGHf2zBTrOJlPTYtnmhOhXccnN0Vr8CCfD4VTf9YVCKmaGw4cN2Hd4DjRRBGeUv0Q+qFia2BMvggSptZLz/Pp6c3LsQOP8wpzcCSjdV7iAtGiwOV/zThRB62mP2YCboDe7ofT35p9kmg5Ka7WHLWsE53PZMUQyI14cuNJ6ag==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(82310400026)(376014)(23010399003)(1800799024)(11063799006)(10067099003)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	/2YrywH+wsXj6uaRRmm6F9envQZlawgjlrSsmNw9FXpVdL33IC61Lh8JG1/pG0sYJRMokElkJGJENafLC5S4YI616cfcdDhb1IXo21LrOrCTkweXewysrjCLzLAsAHl8GdYRHE0JsH2CdmQ8+7HDJCB0nZHWnVkItznn+LiYZTOPqSmL4l0Zz/+8pWSKH+Rd9HD2udD8eDhXjSSUmxPx2TstmTIIjUUtrdjSyFrjHiG6H1qwz2TMFbz2zixuJsZi4TjB0TiM9k+NsFF/KC2YVx+ICu17zaUGkFafC8wf+Q5QacSA5hnB+v67mFKCrMc9ZxpJ5S0uzCn4jeJoGUPgk0PiYJQ9Y0I/EmPJUfXl1tY8aQLJlDDIklDG6m+UC4GZ8uec11zUobi7tiMdNeeAOWpnU0NczxNBHTGkOTHx4wQFuW2q4WJ7mFhN4aCI1EDm
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2026 14:56:51.9949
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d4a8700-cfbe-4d3f-5725-08df159512da
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF00000145.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB7474

aer_attr_group is a named group, so sysfs creates an "aer" directory for
every PCI device. aer_attrs_are_visible() hides the attributes when the
device has no aer_info, but internal_create_group() only skips the
directory when is_visible() returns SYSFS_GROUP_INVISIBLE for the first
attribute. The result is an empty /sys/bus/pci/devices/*/aer/ on every
device without AER.

Switch to DEFINE_SIMPLE_SYSFS_GROUP_VISIBLE(), which returns
SYSFS_GROUP_INVISIBLE when the group predicate is false. Drop the
per-attribute callback, since all four attributes share one condition.

aer_stats_attr_group is unnamed and creates no directory, so it is left
alone.

Fixes: b4fe7398def6 ("PCI/AER: Add sysfs attributes for log ratelimits")
Reported-by: Sashiko <sashiko-bot@kernel.org>
Closes: https://lore.kernel.org/linux-pci/20260714191826.BA81E1F000E9@smtp.kernel.org/
Assisted-by: LLM
Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
---
 drivers/pci/pcie/aer.c | 15 ++++++---------
 1 file changed, 6 insertions(+), 9 deletions(-)

diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
index 5498fc605556..91d73bd2ca7c 100644
--- a/drivers/pci/pcie/aer.c
+++ b/drivers/pci/pcie/aer.c
@@ -777,22 +777,19 @@ static struct attribute *aer_attrs[] = {
 	NULL
 };
 
-static umode_t aer_attrs_are_visible(struct kobject *kobj,
-				     struct attribute *a, int n)
+static bool aer_group_visible(struct kobject *kobj)
 {
-	struct device *dev = kobj_to_dev(kobj);
-	struct pci_dev *pdev = to_pci_dev(dev);
+	struct pci_dev *pdev = to_pci_dev(kobj_to_dev(kobj));
 
-	if (!pdev->aer_info)
-		return 0;
-
-	return a->mode;
+	return !!pdev->aer_info;
 }
 
+DEFINE_SIMPLE_SYSFS_GROUP_VISIBLE(aer);
+
 const struct attribute_group aer_attr_group = {
 	.name = "aer",
 	.attrs = aer_attrs,
-	.is_visible = aer_attrs_are_visible,
+	.is_visible = SYSFS_GROUP_VISIBLE(aer),
 };
 
 static void pci_dev_aer_stats_incr(struct pci_dev *pdev,
-- 
2.43.0

