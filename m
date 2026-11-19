Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.43.2
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795082991;
	b=0EVB9mXt77ClcUuraM7oaOq8Rwr41obx+Pk9e28at09YPpk2TOCMQrw262L9TjhuyYQv
	 Zwx7fGKYvpyZJyU3C2MYpnVgt72E4B+u3fcw9iu3QtUrNDmJTQzdWZWB6enbZIhDuwRNx
	 /z/MCKz9QqTKdYzojNYs8dYwitbtPpGmgNvI7ptdbm48QglRQoQSD4jSogM4sl0hPOiOR
	 TZ///e944HsFQKJnL/+0UZGJsy2bEs2DNytWZzG/CFewGngjaKYPbymgw3E9wNP4HT8MJ
	 IbeDtfKvQ6hL6SfBKQ2NNET5TY4VrIrjy3RbYFqVP/d+l6afNzDw+1zg4BZ9jhUbo5Q==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795082991;
	h=DMARC-Filter:DKIM-Signature:Received:Received:
	 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
	 Received:From:To:CC:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:MIME-Version:X-NVConfidentiality:Content-Transfer-Encoding:
	 Content-Type:X-Originating-IP:X-ClientProxiedBy:
	 X-EOPAttributedMessage:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=2gAG09SVoHhktNXkb+QEyXcuy5u3Jv69cCyeeApT1SU=;
	b=p2e1cT6ldZueBkgMjrkfZGZGJw3zV+kdNtTduema1yLhUsi8eMBtMVDDVTtb0QFr2ViO
	 aD49eCz9TR2x9y51GzJxVus4uBACPiGA+c8u+fLj+Z+DsRkKu/A77n6AM7IcWU5n/6CgG
	 zZzg8jIsYJ7zi9Lt9EY3n+cQX4tEl93dXybWufoCIOwW48f4TOnWRVFPrcq8zBv9MtmOu
	 OTo6m2XIdOLDvM0IAsBX7Kld9x5Z6xdNLEy+Gjx0GJiVE4hxr8CMuCzhiKz+QDF1qBAzJ
	 xTOLds8wYvCLGbmCT4n+jrB9CvMlNgt4QGCBTnhHbsDbeMSl+Rqi1HlBaLfLp6smn8g==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b="PA5/7BsF";
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.43.2
Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012002.outbound.protection.outlook.com [52.101.43.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B5CB606A333;
	Thu, 19 Nov 2026 10:09:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7B5CB606A333
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=PA5/7BsF
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IHadW5whvdIcNuTnXt9l3Rmef6mBaYr5ahhyQKlZqyJ1fkNcAc54P4H2dcBFJuNUehJknjhEAUQ7Aa1c6TTmOmEtMkqFFMBXTI9t+5I7SkmkrQ/yDSQTnkGeDf26Y5zYNARcvS+phcnYGO/wtRmhCxBHBF1wiDd/0pe9SJ7sfDhrzqN4Q1cxpQyXb7CIBmK6a10gKO0iV07ZvIc4F9hCYyThvfK6ZmFdAjTmIi/+Px4GAJzTiSX5xIj7BcT+PEYO5+6LEFB1qNfpiQuxF6ZZHIgMF7IuYmPTeTez1ZPJMbd7mZjc25Q835atJ97r50kmCQjvK0CgmxHX4pp0YqvR1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2gAG09SVoHhktNXkb+QEyXcuy5u3Jv69cCyeeApT1SU=;
 b=QVBFUjyr3MmYHh8jB0oC/W7+sQtdYrwhHRECrxIy44WI9NVhZSYwJp89jSMK2DJwIiYpsxFfGDfWK97+R9n35SSY7sPBR1rYl35SEjiZKAisnj9nzI/exxEpT6khZK3yMFhRdUKe2i4RQ8W1JX0rvHmjaK82QHDWPAA+f7YwgyjNIS05CdgEmraIg57r8LEPX06SZH3vprwyb6sLymcQ0L7K9lHBz8GfHrLUW7Bf1veuD4c6cDJRrteJ2IuEtJORfNFhHfclY+1NwGVxRGSpWl79PKcPpbTv4wPA+ZfqaD4NRj0WOR9AYQFPhJmN9rF1gAugJXS3zoUY6Gh+MIsKxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2gAG09SVoHhktNXkb+QEyXcuy5u3Jv69cCyeeApT1SU=;
 b=PA5/7BsFQSFDyPahtTLeRkLmTrD2YHzrksLlZW5i/7HhHGC+zfMMPt2rrez+m4jgm/G4B5pl/CZqJa4IUFfNFK10T6PgQQp1YuJfrQDLlPTjoclF1K3DSbyp/tatjI3HwfIiuYHbFUGwnuRA6iwqdqxGg1uPylKszI0jbks2M6eJ7+6eNA/tGMPUDK9t4hvCaXcA1B/QmqSSmgUsEhofRdhk8u/VDrgCHs771KwxvyLXI5if/VSPBSh+IlChKktNGiy7wvxtQ6mP/M3qXvx+rRSRvhAgwQpUS9kxjDwyoWrOfVVQZAlE1/1PXc1B+0I1Jv6M3SSHygciZKA+le6m9Q==
Received: from CY5PR17CA0039.namprd17.prod.outlook.com (2603:10b6:930:12::13)
 by PH7PR12MB9149.namprd12.prod.outlook.com (2603:10b6:510:2ea::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Thu, 19 Nov
 2026 10:07:45 +0000
Received: from CY7PEPF000000F7.namprd05.prod.outlook.com
 (2603:10b6:930:12:cafe::c) by CY5PR17CA0039.outlook.office365.com
 (2603:10b6:930:12::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.639.10 via Frontend Transport; Thu,
 19 Nov 2026 10:07:44 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.117.160) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CY7PEPF000000F7.mail.protection.outlook.com (10.167.247.155) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.639.5 via Frontend Transport; Thu, 19 Nov 2026 10:07:44 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Thu, 19 Nov
 2026 02:07:29 -0800
Received: from vidyas-server.nvidia.com (10.126.231.37) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.57; Thu, 19 Nov 2026 02:07:24 -0800
From: Vidya Sagar <vidyas@nvidia.com>
To: Bjorn Helgaas <bhelgaas@google.com>, Dan Williams <djbw@kernel.org>, "Dave
 Jiang" <dave.jiang@intel.com>, Jonathan Cameron
	<Jonathan.Cameron@huawei.com>, Joerg Roedel <joerg.roedel@amd.com>, Jason
 Gunthorpe <jgg@ziepe.ca>, "Nicolin Chen" <nicolinc@nvidia.com>, Kevin Tian
	<kevin.tian@intel.com>
CC: <vsethi@nvidia.com>, <kthota@nvidia.com>, <mmaddireddy@nvidia.com>,
	<kumarahul@nvidia.com>, <sagar.tv@gmail.com>, <linux-pci@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Vidya Sagar <vidyas@nvidia.com>
Subject: [PATCH V1 4/4] PCI: Re-check function 0 reset methods after scanning its slot
Date: Thu, 19 Nov 2026 15:36:28 +0530
Message-ID: <20261119100628.1948990-5-vidyas@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261119100628.1948990-1-vidyas@nvidia.com>
References: <20261119100628.1948990-1-vidyas@nvidia.com>
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY7PEPF000000F7:EE_|PH7PR12MB9149:EE_
X-MS-Office365-Filtering-Correlation-Id: 62a0f35d-f7be-478f-c55d-08df4624f4a9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|23010399003|82310400026|7416014|376014|1800799024|261022113327099003|10067099003|11063799006|56012099006|261026130827099003|261026140227099003|261028144727099003|261026135527099003|261022075727099003|261021133027099003|261021135927099003|261022105027099003|261021121427099003|261022115727099003|261021130227099003|261026121527099003|261021123027099003|261102123227099003|22082099003|261009223027099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	gGW7esICUzZIby6fthzqq+KR7jktuRE55y9fWHL9hJwZ4YhDii9VHSHqBhr1ddk6glPjsoEodd+/ikYjsnZbh6GejUoMISGsjlkT2zx0VnnT44C3SnbzIStbHWmHK6dy0C4EfTMRfogeAyQSHzQ2mD8AyG99DrU/boQVISDoYbB/Fjn7b+8EcrhcIXH/HUmMHHisVE54OxE5v56X+snB31THwaYgzusFl4C4FiEImbmMuCd7eR0xYpL9rbJumXwNSb+zCQbTklC5lXq+LAlOFZoKlJ4abtMmoew9xYeG7tyLalJHIzrsSD6uSOPDW+hr5IFAZ6Tnd01cpRzRmktHw7f4Hr0hUp2PoWu+dQZD505NrBNhfHbIyVeGGWVOMapqCxx0MvvsMfKk83pobDHWL1Gzzg56vKo581dG0jx16J2xs7LO+ecl0w4ScpWAGHc6YblI897oENHPBm/qwsV37uxUKPzCqR4Oht/x5J6r/rXLJqFKmci2L7g5yqr1rljoNmDDGgSfaob7TCYGXUJvh95Y1bZznvfAOWVzPoedjoXrRGU6HIRVP/wQPHNvFl4LaXmRZ1HaOxJgxIvi3TuELDZx3UsDQnRuwM+HhAE99bgsb5TeMlmqwcbz6/8/clp8pNVEIdqFKCu8mX5HDWDXc6VyBys67WPRWr/oJsfS8y4ZUjL1segRBEriV7nPpNMNLG3BHbikFM0pM89q+PJFcw==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700016)(23010399003)(82310400026)(7416014)(376014)(1800799024)(261022113327099003)(10067099003)(11063799006)(56012099006)(261026130827099003)(261026140227099003)(261028144727099003)(261026135527099003)(261022075727099003)(261021133027099003)(261021135927099003)(261022105027099003)(261021121427099003)(261022115727099003)(261021130227099003)(261026121527099003)(261021123027099003)(261102123227099003)(22082099003)(261009223027099003)(18002099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	TAgXdMgDFu5rdyQ1hKoZmuypYSjLHBOyR82zHWlkU2nIwKeGQjavgYfS1K3dZBGokwClFkIOYJ5A+X30dkCNJSlgGBSNyejMX8yzit0QFLnDbMwvB8pFAoUcDpFhKn+drfJiblyLDKZiD24ipx1QwEmPU0sSHwAlLti7TQ2eP6JsZLZ04dW/n8R7PyE8x/Srwh6mRD5r3vPaJeJ+1iD+pp1XOsxSF5x8KAGxavjMMbWOv/tskEZnh7L8N0JQrAKsxMJo+DtWN5qSf6untnWaqA5eKOmrww5HZlmte/2HNtAgvJC3egYkvcYeMNC/pG2ElCgcRAgWgN1GmHJXla3Ib0SuZk73AFKggvv/F4qlNgV0N0uj7xlOpkHrErmJ4OHpUSq2wDU76CZhCpcuF4BtT/cnqgOtSQBsVukHlOW734K4DJ4Z74YQA8u7xutdGUL7
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2026 10:07:44.6425
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 62a0f35d-f7be-478f-c55d-08df4624f4a9
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY7PEPF000000F7.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB9149

pci_device_add() probes a device's reset methods before it adds the
device to bus->devices.  pci_scan_slot() adds function 0 first, so when
function 0 is probed it is still alone on its bus and the "bus" probe,
which refuses a bus reset if other devices share the bus, succeeds.  Once
the other functions are added, the same check refuses the reset, so
function 0 of a multi-function device lists "bus" but can't use it.  For
example, on function 0 of a 4-function ConnectX-8:

  # cat /sys/bus/pci/devices/0002:01:00.0/reset_method
  flr bus cxl_bus
  # echo bus > /sys/bus/pci/devices/0002:01:00.0/reset_method
  bash: echo: write error: Invalid argument
  # echo default > /sys/bus/pci/devices/0002:01:00.0/reset_method
  # cat /sys/bus/pci/devices/0002:01:00.0/reset_method
  flr

The other functions are probed after function 0 is on the bus, so they
are not affected.

At the end of pci_scan_slot(), if the scan added function 0 and other
functions, probe each of function 0's reset methods again and drop the
ones that now fail.  By then device_add() has already created function
0's "reset_method" file and sent the "add" uevent, so userspace may have
changed the list already.  Add pci_prune_reset_methods() for this: unlike
pci_init_reset_methods(), it only removes methods and keeps the order of
the rest.  Hold the device lock while doing so.  reset_method_store()
takes the same lock, so a write can't land between reading the list and
storing the result.  pci_bus_add_device() takes this lock later in the
same scan, for device_initial_probe().

No driver can bind to function 0, and its runtime PM is not enabled,
until pci_bus_add_device(), which runs after the slot scan.

Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
---
 drivers/pci/pci.c   | 35 +++++++++++++++++++++++++++++++++++
 drivers/pci/pci.h   |  1 +
 drivers/pci/probe.c | 16 +++++++++++++++-
 3 files changed, 51 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 918a4d95f914..d9b26208a76c 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -5306,6 +5306,41 @@ void pci_init_reset_methods(struct pci_dev *dev)
 	dev->reset_methods[i] = 0;
 }
 
+/**
+ * pci_prune_reset_methods - drop reset methods that no longer work
+ * @dev: PCI device to check
+ *
+ * Probe each of @dev's current reset methods again and remove the ones
+ * that fail, keeping the order of the rest.  Unlike pci_init_reset_methods(),
+ * this never adds a method, so a list set through sysfs is kept, except for
+ * methods that can no longer work.
+ *
+ * Context: The caller must hold the device lock of @dev, which serializes
+ * this against resets and writes to the "reset_method" sysfs file.
+ */
+void pci_prune_reset_methods(struct pci_dev *dev)
+{
+	u8 methods[PCI_NUM_RESET_METHODS] = {};
+	int m, i, n = 0, rc;
+
+	might_sleep();
+	device_lock_assert(&dev->dev);
+
+	for (i = 0; i < PCI_NUM_RESET_METHODS; i++) {
+		m = dev->reset_methods[i];
+		if (!m)
+			break;
+
+		rc = pci_reset_fn_methods[m].reset_fn(dev, PCI_RESET_PROBE);
+		if (!rc)
+			methods[n++] = m;
+		else if (rc != -ENOTTY)
+			break;
+	}
+
+	memcpy(dev->reset_methods, methods, sizeof(dev->reset_methods));
+}
+
 /**
  * pci_reset_function - quiesce and reset a PCI device function
  * @dev: PCI device to reset
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 77efa4c5c960..6e82c82acdb6 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -242,6 +242,7 @@ int pci_mmap_fits(struct pci_dev *pdev, int resno, struct vm_area_struct *vmai,
 
 bool pci_reset_supported(struct pci_dev *dev);
 void pci_init_reset_methods(struct pci_dev *dev);
+void pci_prune_reset_methods(struct pci_dev *dev);
 int pci_bridge_secondary_bus_reset(struct pci_dev *dev);
 int pci_bus_error_reset(struct pci_dev *dev);
 int pci_try_reset_bridge(struct pci_dev *bridge);
diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 9a178e0e5f7f..a36bf679c393 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -2874,7 +2874,7 @@ static int only_one_child(struct pci_bus *bus)
  */
 int pci_scan_slot(struct pci_bus *bus, int devfn)
 {
-	struct pci_dev *dev;
+	struct pci_dev *dev, *dev0 = NULL;
 	int fn = 0, nr = 0;
 
 	if (only_one_child(bus) && (devfn > 0))
@@ -2887,6 +2887,8 @@ int pci_scan_slot(struct pci_bus *bus, int devfn)
 				nr++;
 			if (fn > 0)
 				dev->multifunction = 1;
+			else
+				dev0 = dev;
 		} else if (fn == 0) {
 			/*
 			 * Function 0 is required unless we are running on
@@ -2899,6 +2901,18 @@ int pci_scan_slot(struct pci_bus *bus, int devfn)
 		fn = next_fn(bus, dev, fn);
 	} while (fn >= 0);
 
+	/*
+	 * Function 0's reset methods were probed before the other functions
+	 * were on bus->devices, so a bus reset looked possible then.  Its
+	 * "reset_method" file already exists and userspace may have changed
+	 * the list, so only drop the methods that can't work now.  The device
+	 * lock keeps a write to that file from landing in the middle.
+	 */
+	if (dev0 && !pci_dev_is_added(dev0) && nr > 1) {
+		guard(device)(&dev0->dev);
+		pci_prune_reset_methods(dev0);
+	}
+
 	/* Only one slot has PCIe device */
 	if (bus->self && nr)
 		pcie_aspm_init_link_state(bus->self);
-- 
2.43.0

