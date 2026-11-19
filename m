Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.52.63
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795082861;
	b=D2jT62Gyj5FQuULlrCaXsk9LuApHivrxWRfI4jlVSXw5+Yg6rhY+r2NQf1vr+XmoYd28
	 5uKligr6X0GCHKj6GqDSMI+9OilYwW0Nd5b55nEPX7KG3+ZlaK1ENMSNOYha0jF0PTQVa
	 sUwbNGWAjLCjBtAwJbSvoD1cLh+BSfC2yOPl/iq/cNPshRq/RmCQefZwZfxtRq35ciK/n
	 DI1RGdN0JdT5qmapW81ugA1K/25nN/MwBThKFpLDJ2NT827Gg8p5plaCnuoiy6PNWwezx
	 MsTraV18fNYnRxsFGIz89k3kPFFgpA+IVLw0vmeXtT8xhuoQWJB4KEXKje9OCCS5VkQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795082861;
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
	bh=wD7bEuhXrwsjV1lZ2tyKjZnnxFdsTKbNN7qIzRBULzE=;
	b=iT2+1QMOpQoKlZbD3qusjps8+uKyK2aZgw2+eoCMQkmZjhPi1ygFCOOoX2gSpxkkEg1E
	 REh7y92Nwd2Ik/dcA0UTnqrywh4wFLTIbtAAy20qnlVEEvfh6xK0J/wRJ0H3uIXuguQd+
	 TOrBsBPfmfNvuN+uiXJsOZ1t5Vwaig9mTCSf4S5yo/HoZ+FcDuauJrz55/4fKcHwhdpyW
	 CJkSwEcWIsehy5AHGGJR/3HRsZZ7qsSwPurX9x9Nzrls3JAQyoIhxKQyXOgoL0aYkZanV
	 WSghEdfSuui7AsuMXn26pVB/p1yFAa/7/HkQ8yxG5knLRh6A/Glz1eZPBcBIMaZKErQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=BDHoBLno;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.52.63
Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011063.outbound.protection.outlook.com [52.101.52.63])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5406C606A32F;
	Thu, 19 Nov 2026 10:07:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5406C606A32F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=BDHoBLno
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=j7wDMGSnK8MHXtl5WrZZ+mFb4tIdIxSN10bBvFKq2ZI5PVG5UadgIG9OUIo4dTXRAELLYgG645zn/kpmCEGuZChE9Waui8uQQs4R/v+qwMgn5Ly4TYDtPHrn2Iw9hR6oSFnoZvbX3VDuElGHfp2KAi9upcimlf6l/x/rN7sSfCgbXC6LO4DyRZVpnTRITY7fFp53iEdbimL4Xv66OSU6VzJt/AOS/i78EE2JPujlAu19j0KMZ+EpEBkIqk7nBE4uTdHyL4CRfPsy6lTsF2LmRecMCDQUw80D9dUDeRV/9sNPvKeI1PLJEuARZyz4erqraQMLADVB+A7GgwvDYxoiIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wD7bEuhXrwsjV1lZ2tyKjZnnxFdsTKbNN7qIzRBULzE=;
 b=UKz7OlOvWHhxDUINsxLSyJuH2IH/xkYEFupKym8oUfLWLIC0IMGjRGUsQcqfqBsManPAdLCn0fV8k6EC+w54vwGuu5R7I4mHf6WhCcAPS98IMD3Wb6IJbnohNOl8/SpFBjEcY0EmINi11cpyzfn1Ts2vddqB9jS6A1G/FCn5XxNZh9WZvAI2Dcy1+t/l+9QmDernrWJMXCGVcSOiYQ1vvSIXUvR8s5KDZLt7+01xmrdmaGc/0Nec8ukBx2l/tYb8DnucbBZxoxmMxPeAu3SN1k9vMgxzeLSgV1o8wmOEo1UELuecKHiSaZ4fxgfgsIRzrMsKn/dKBWBFZs4LHrxPEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wD7bEuhXrwsjV1lZ2tyKjZnnxFdsTKbNN7qIzRBULzE=;
 b=BDHoBLno29+El4jy1KHdLCGrj8LXmbiIt1ugInTLRYCljgs3/A3KCie8oRd6vjAjO6cRBqWWfU0xuGD9onEAfqHPWECFT7Vk4he16r5wjzSX/FkSUZRKRn2x9RZltQw73g9X+ZcJ8cn0vJqHXKfXrd0ngWMdse7eiYl4sJ67h24pdruofFr8B53rg/ZjzMZ6msGJDwNg0MdOHKo8xy0BfE+fknwx6RG2bh2XJwPiX3t4XoCBE6qvz9iP/G3diPXq4AtSawKEy+6rgFDvTf07XG6RRDRjPRVNnecjm6PO8D6KXk/cVbBj9Cotz3DpbGLqDUonVZa4ByGIBQd98FcVVQ==
Received: from CYXPR02CA0005.namprd02.prod.outlook.com (2603:10b6:930:cf::6)
 by BL3PR12MB6427.namprd12.prod.outlook.com (2603:10b6:208:3b6::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.13; Thu, 19 Nov
 2026 10:07:37 +0000
Received: from CY5PEPF00000E85.namprd05.prod.outlook.com
 (2603:10b6:930:cf:cafe::35) by CYXPR02CA0005.outlook.office365.com
 (2603:10b6:930:cf::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.14 via Frontend Transport; Thu,
 19 Nov 2026 10:07:37 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.117.161) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CY5PEPF00000E85.mail.protection.outlook.com (10.167.247.185) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.639.5 via Frontend Transport; Thu, 19 Nov 2026 10:07:36 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Thu, 19 Nov
 2026 02:07:21 -0800
Received: from vidyas-server.nvidia.com (10.126.231.37) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.57; Thu, 19 Nov 2026 02:07:16 -0800
From: Vidya Sagar <vidyas@nvidia.com>
To: Bjorn Helgaas <bhelgaas@google.com>, Dan Williams <djbw@kernel.org>, "Dave
 Jiang" <dave.jiang@intel.com>, Jonathan Cameron
	<Jonathan.Cameron@huawei.com>, Joerg Roedel <joerg.roedel@amd.com>, Jason
 Gunthorpe <jgg@ziepe.ca>, "Nicolin Chen" <nicolinc@nvidia.com>, Kevin Tian
	<kevin.tian@intel.com>
CC: <vsethi@nvidia.com>, <kthota@nvidia.com>, <mmaddireddy@nvidia.com>,
	<kumarahul@nvidia.com>, <sagar.tv@gmail.com>, <linux-pci@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Vidya Sagar <vidyas@nvidia.com>
Subject: [PATCH V1 3/4] PCI/sysfs: Take the device lock when setting reset methods
Date: Thu, 19 Nov 2026 15:36:27 +0530
Message-ID: <20261119100628.1948990-4-vidyas@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CY5PEPF00000E85:EE_|BL3PR12MB6427:EE_
X-MS-Office365-Filtering-Correlation-Id: 0b6ba213-4334-499c-da24-08df4624f015
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|7416014|36860700016|82310400026|1800799024|261102123227099003|261022075727099003|10067099003|261026121527099003|11063799006|56012099006|261026140227099003|261022105027099003|261021121427099003|261028144727099003|261009223027099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	uyX7h1G1eTUolAjGT548GujtnJPSFGe5gbFRmjKUY+nmDiM+W3znPu+3sMv53byP7SEdgXiJzAH3SdlJE3U+8RDCVJAmfrm3Tn7msmcF7fNvmeEdRX8Zj448BfDspCFtrEhrcRDqBvz70HYiCsfoQlEQuQsCIDMeQXh0q9tZfvwFvGnH6Sky6gqFXlYPwxZXroTcn4p1cx1OvjbyRhkmemUCEoxivy9Sj98K8DXol7ZTnhDb8/5zv/H8/ge+ADjv3LrQA85ezHVaAhOr0iKZoL5vML43G+qvotu7BoXu6KtsgmrLFR8JmO3npvfjtSUJz7ZRQ3dLtZxw55BaD1cpoCyJoNWEIrWfRgZddqgCYd7pMgz8spmtZPFoJSS+IOtALU0/IuqwhHjP/vhoxS0FvLVlg1Sp8qPFyD/GwRr2T+46gTorx2VjuBehf17luu7Nj2dlaKrhiDVnTB160Vs3yG6O25IwWEeBLfBPH84Fpm7U73SIzY39NXZu9XYA2GIU6TZknm1GniKPU8kFqVo+7BGlP9OYAdkd1YrscsohAaNqp/49NxruIeeeX39RtqCppsiQdSiCrEIzFVj7k0viwfwZWvF9rI5+eItNqm6oVYlHTj35ho4+0/1dpsxWzeVo+tjnqpx/yexkEFIoEgSjgjaBTFtJah+s2Nfr7CJ2AEhSwovTQCtO/c9vxxuFd9vJ8SqIiy+qb/oMYjk1mebYZg==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(23010399003)(376014)(7416014)(36860700016)(82310400026)(1800799024)(261102123227099003)(261022075727099003)(10067099003)(261026121527099003)(11063799006)(56012099006)(261026140227099003)(261022105027099003)(261021121427099003)(261028144727099003)(261009223027099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	DVIGvKXn9E+B5xyDZg4P6h/4jPkeyegag+fONNWnGZcW/Hq536Dko6iyBOOr0nEmPHmlNHznBlUJ/2WSj0DIrOnTjawULQl5rrus22QFhsTwGwVqmxrLJ8sjxGowMhehtRrC8ZCXBdT399qNVv8fIVGAYMM+Gt8rU2j/of4wxTVljm/6uZS+4SJAv5DFueGpeKp/rMhrNt6KkfxAcVHnrJeQoNMzTINVu420Ocquyzh0QHAdTJ0TZvEvWfX5wNjUJIMkYn2T2G8tLXu/7INVHgSB1PdtseVscOuw8ppZB8OTUnOFjq8iWlX/hz+Valn+4RGMKQE3psOHVMrR25EHAz0SrP+rPalyfcJ4JVFk5BVbPV4eOJJbbM7Id9OzggQF9JE3lcjbiU5BA5uR0iaBYPcMw2EI9USZCAzqjnYpHXPQ19kS0Sx3AzH+PIVhu6Ur
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2026 10:07:36.9704
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b6ba213-4334-499c-da24-08df4624f015
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY5PEPF00000E85.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6427

reset_method_store() updates dev->reset_methods without holding any
lock.  A reset can run at the same time: __pci_reset_function_locked()
walks the list one entry at a time while the write copies the new list
over it, so the reset may use a mix of the old and the new list.

Take the device lock in reset_method_store(), as
__pci_reset_function_locked() already requires.  This also serializes
concurrent writes.  The reset methods already run under this lock during
a reset, and probing a method does less than running it, so probing them
with the lock held is safe.  A write now waits while a reset of the
device is in progress.

Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
---
 drivers/pci/pci-sysfs.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
index 6669e9ad5bd3..dff3c2d9408c 100644
--- a/drivers/pci/pci-sysfs.c
+++ b/drivers/pci/pci-sysfs.c
@@ -1643,6 +1643,9 @@ static ssize_t reset_method_store(struct device *dev,
 	int m, n;
 	u8 reset_methods[PCI_NUM_RESET_METHODS] = {};
 
+	/* Serialize against resets and other updates of the list */
+	guard(device)(dev);
+
 	if (sysfs_streq(buf, "")) {
 		pdev->reset_methods[0] = 0;
 		pci_warn(pdev, "All device reset methods disabled by user");
-- 
2.43.0

