Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010060.outbound.protection.outlook.com [52.101.201.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 297E3355813;
	Wed, 23 Sep 2026 07:19:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790147964; cv=fail; b=FZN0ICr4cRKMsLVSnREZ1hq/iehxoTYHcq3wfjLjHK1bwqzjq66vbm3zAB5oc9shphntUJ8EEgSeF7lpkEIJW8uILvOwTbLsit4QgAQoJEMFMRBl69xI08VC035uPmhlCDV0jT0esHRRROE7UV1ivMAbPCogB4QRe4/nHofo7ME=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790147964; c=relaxed/simple;
	bh=+8ZyDKNaCjxv1CtjHAQXHGXX1ynr8fmFLe6FwTZpVdk=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=pR9qbAUVarJMDwG2lVBrGNRnnhl+fg2F7kv3kQPJwtZVuatfkMPVBGDvJ/k5oazTg6+3xsoLHdisaswCm2BggupRsmr1Eqbci53FebewKE0hSRP+OomMBFs18sDJKJvbyutnIkcSiMvE/n0sXOJYqrl7TEwdOIdvblqeetPeWxc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Wvm8hNT7; arc=fail smtp.client-ip=52.101.201.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Wvm8hNT7"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KLDSLhT9AVfxySMjuwU4+awIJX1puMXx0DL41akwEHRu5QuiWKk3wRs4YUpr/DFn6qb5aRGRnVgoDwsQwuIgJzNUYhdZMc8EdPKHiobhCLz9zRkRZkMQ3IA0DoiH6X7rxdjokchJerhYEgFKpwJaPnf6oRAU6bvTNMy69+Os/JFf9bfb+O6f8ImdroUep52aSFIzMqX/5iGLGlgtazPeIBhhzP6aRMO9pS8J7FxE8SD6nchXjlhOsEKcKamBNPjZcXt8+kyYSdqEI0cmriZj2VLbSw07kbJoQbKBhJWloUYST6Oi1JwlBISPArfsTNscYmaMFWIX6CRSzAST6ZZJcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ufXIfqoyytwHusXrcLoKxMGBZ7IAawRImXMYPV7fzlQ=;
 b=QsOTiU3c3AqrxDLRgoOlDeJTTbTJlSVUpKqP5/Q3D/ZaZAznPG450nM3BLbIUcnJotCqaPNuy7OlU9BmjrqkcExK3i4tj/e6WPLZ0G7I33SaLTO9l8RBN9m3FcxfEtjJy++zA+9jrSEi68tGbXXzo8hGrce0/pXPP7sbwiKkEXGBT1Nd1rvaQUU8RCYGepLbPAvmhbksmKGn+E3LHhC6ykX0AOs2Pv/RQL7vu6o/Wos7McEThGKgXYihpCUfEBXTwlvIXoEnaC90RiopvEzERnuTAfH7ltTBWlL3gx6cKZAF+9wKZu7lJPtj5sQOBltI51iF6dTQbr3WmxI212pL5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ufXIfqoyytwHusXrcLoKxMGBZ7IAawRImXMYPV7fzlQ=;
 b=Wvm8hNT7ja+PO0C4qs7h+enNmHIwtu9wP8RuFleOOZUloesNiwJzXwRLilx87M3k5OoPoqaqMkvqnoYLFGeK8AQ50dTRrHPzMljuvwm5Zn4Md1T9wt1o3qrawONX8evnetfG7QhlM/ewBxmVomGi+94tojoc+OsXa50d5YzBfq2Zs9f/5I+BNrFdK+umLVIBT28xRxwf5KPeCFYMT7kYnD3DlS33mnoKoxXdwcG/3kFvME1/391IuoDVOpKz+xuai49ewlNU2/H8E1BugMuDk2ob13qc1iGis6vWvKLs/V+dwQqy2O9XcZiPVfeegBI2USeAvVd92xNLSWnywB6ruQ==
Received: from SJ0PR03CA0339.namprd03.prod.outlook.com (2603:10b6:a03:39c::14)
 by PH7PR12MB5997.namprd12.prod.outlook.com (2603:10b6:510:1d9::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.14; Wed, 23 Sep
 2026 07:19:19 +0000
Received: from SJ5PEPF000001F3.namprd05.prod.outlook.com
 (2603:10b6:a03:39c:cafe::30) by SJ0PR03CA0339.outlook.office365.com
 (2603:10b6:a03:39c::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.451.16 via Frontend Transport; Wed,
 23 Sep 2026 07:19:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SJ5PEPF000001F3.mail.protection.outlook.com (10.167.242.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.8 via Frontend Transport; Wed, 23 Sep 2026 07:19:19 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Wed, 23 Sep
 2026 00:18:58 -0700
Received: from mmaddireddy-ubuntu.nvidia.com (10.126.231.37) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Wed, 23 Sep 2026 00:18:53 -0700
From: Manikanta Maddireddy <mmaddireddy@nvidia.com>
To: Jingoo Han <jingoohan1@gmail.com>, Manivannan Sadhasivam
	<mani@kernel.org>, Lorenzo Pieralisi <lpieralisi@kernel.org>, "Krzysztof
 Wilczynski" <kwilczynski@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	<linux-pci@vger.kernel.org>
CC: Rob Herring <robh@kernel.org>, Thierry Reding <thierry.reding@kernel.org>,
	Jonathan Hunter <jonathanh@nvidia.com>, Vidya Sagar <vidyas@nvidia.com>,
	Niklas Cassel <cassel@kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-tegra@vger.kernel.org>, Manikanta Maddireddy <mmaddireddy@nvidia.com>
Subject: [PATCH 0/5] PCI: dwc: Clean up RAS-DES and register field handling
Date: Wed, 23 Sep 2026 12:47:01 +0530
Message-ID: <20260923071706.1134320-1-mmaddireddy@nvidia.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001F3:EE_|PH7PR12MB5997:EE_
X-MS-Office365-Filtering-Correlation-Id: bf4466c5-c5fb-4bb7-1dc4-08df1942fbb6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|82310400026|23010399003|36860700016|11063799006|10067099003|56012099006|18002099003;
X-Microsoft-Antispam-Message-Info:
	I/pPrfutos5TjoXsIYsIjE4nsZyxvjAniUD+6dK/LcTZup2rD4EQOpuZDgHJo08RzIHj5ud26CVgjmqLcQqxrQJBJsFKohyRpt9kO/tpsHZ20ZC/bJljHMUnZaj6ehx1WE023zbDBkA7OiNcK0JvSSEqFbN5UetrieiqV3bcGfaBZoQ2brpfpnIoRBEk26m+UsMZehS4DjUKonAsrD+giF25fv/Ri54UzYtv9/FRKvTXAhzs9mmZ5KTKcDmEFYxJA9mMGKgyEdydm/nGk+/qUPB5c1vI9yi8Q4PLrYW+unZ8rJVaEpwRTJCCDiNbakYMfgULmX4oGoYVVXdmPWvRhqKSaruMSkHRzG3Bt4FOLZD79OXnhj/ZilebuM6Fm9gjXVAxvnDqjtQj1YcK/4tvADkgxyF7lAJGTA22Avcfwm6w/qgpTM39p04fKUi1QALOBlSa6pVrdd0aOsbssglbI8yt71rLhsOj+GG2IYgKfXAOmOHzZhJvJN6dkQLs7UERcXgbQNB54wyD0+ZlSkkl8hngdk0MAjRwYwHx3PQ8gglQxV4wH9eNFN4eCpGbVKh7s/D5vF2jR0FQUzfR8PIQ5Cf0Z9jtaAxRXWItKA2vBb3NT+Itq0/OqLoWNpMrIjKF/sWBxDmoJUd82YtB0Cagj7nijm+RPDxL7UtBsjXQeJ6Yd4gMUW+Xni1VnDdxFDo720fqJ4rRGwnctccpFtjzPA==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(82310400026)(23010399003)(36860700016)(11063799006)(10067099003)(56012099006)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	auSzpI+DR2IhZoGIH9p132RO80prNJrp3RU/ra3GrjZt4qvbbuZ3XsjxVscMKDqJFUTioMInR0l/gG3dpesAOQq3yjsOsZzEiEYnJi4A3sv+7SVs3mAVBnq4vZM9vfjJJvUDsrHCMY+sB4aLVWGxvic6lz91Oan605e4jvsuRgEzSe3HMr7sJG3d2nDiklETQtSGhvobenk/QLrdl9+02jHu3TZVursIea41VU7etfz8EQCU/Kk8vOeKnFe+L1ePM+7dyAONPLhKHv9/eJolzZ/KFPrzjZmthS0wjuqFwB2mdMqj/ABV6yY4FtGP1JdkPSnk9Dkj7BgjGWodFbMDVO7u6Q1tLPsNVIEJ5FnwS6YvOHvv6Nd4G35cPDY/wvchw4f1bGzjn9Gj7nAaxLNiiS2ktPOFnJ4U1ilqCqYY6fIB1aqf4F1pmMaRjtbEXqaH
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2026 07:19:19.0208
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bf4466c5-c5fb-4bb7-1dc4-08df1942fbb6
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001F3.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5997

This series addresses review feedback around register field handling in the
DWC PCIe code and the Tegra194 PCIe driver.

The first patches add shared masks for the RAS-DES event counter fields,
convert Tegra194 register programming to FIELD_PREP()/FIELD_MODIFY(), and
drop shift macros that become unused after the conversion.  The final
patches make Tegra194 use the common RAS-DES selector definitions and
consolidate the event counter field definitions in the DWC header.

There should be no functional change intended beyond making the
bitfield programming explicit and keeping the shared RAS-DES definitions in
one place.

Manikanta Maddireddy (5):
  PCI: dwc: Add RAS event counter field masks
  PCI: tegra194: Use FIELD_*() for register fields
  PCI: dwc: Drop unused shift macros
  PCI: tegra194: Use standard RAS event selector mask
  PCI: dwc: Consolidate RAS-DES event counter fields

 .../controller/dwc/pcie-designware-debugfs.c  |  56 ++++---
 drivers/pci/controller/dwc/pcie-designware.h  |  10 +-
 drivers/pci/controller/dwc/pcie-tegra194.c    | 145 +++++++++---------
 3 files changed, 106 insertions(+), 105 deletions(-)

-- 
2.34.1

