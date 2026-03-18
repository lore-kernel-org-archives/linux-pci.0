Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011024.outbound.protection.outlook.com [52.101.65.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D43F127603A;
	Wed, 18 Mar 2026 14:47:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.24
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773845226; cv=fail; b=KFvJtMr5PE62DWozTcQwjdHJNzYaSEQKq/wj7kHUKUuetzVzJ6cqosYR49cbvuRFKUVRBv/gpe5WMr3MK7M983U3Avjb6MgJx8CId8kd6cvZK6MTcSBX4haaQWiXzhR+cSfhAuX0by1Fb8UPSG4TvL8/2lURE79EXyuYzAvjcDk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773845226; c=relaxed/simple;
	bh=HDfzV83izxwxA4SSN/JCi0s1YAc66E/fd128abtyAx0=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type:To:CC; b=kMp5/JNUmSr1zLz7Wzb78m5JQ5mfhwU6RLl1weeIp6xSVKDSiduLuEaZpJCx09dXnMITrLl5i0mKeZ4fHkwkTzV/HWJu6iThnqYDm7WtrxoVcLbk6IREgAQIHPRtX12ZNH0e9TeHqUBbomDFBw0U7xlPlc9+uoUGZnQ4UFH0IBo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=izICruxK; arc=fail smtp.client-ip=52.101.65.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="izICruxK"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=i7Fnt248bocsJNTLCF8VpFQ38bZVEl9vS7d4D3Zout7LTMXlNIGnQKJnU1j9anE8c7mBK9Q2Qh8Z/qMMZabdpvYK17aHvrYgf1r5HXlFFIfFcfaqnjMZ9WQIbwUK9SHUwbt0cMFttWNvEO+2EL2Kh6AyewDtyhibsTdBIv7yngBkZmQsr7LAmCDX8GeU3QBH265Fb0XaPQGPTBjP6eIJvw72+a4FlI/M6HNPnRtA6Hqf4KyHhunlWXjM4+54WAVfXiESFDL9YJ+gzUIC/ytBIqFVsCM93DdZCxQZCId7Ycm+jQ2uWPzzg2ZS5KedPy2Di3BD2PtnGDuBwImgoUTSXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xoLRyyx035Zq2sobJ/PlAsBg6NZY6QdYEYQ0DyUE5NA=;
 b=q0UxfIQE310LPExopTph3NNxtAsPKLw+RbnNJNYTcXae/Z+5iJns8QKsoXLuWI92UrMMf4o7Ry0uBqnJ6XEwTCgEqqkMDk1arHX/nANMZIhE6u+1IC5CrwV9dWUo9HaLlOlmP7hPtk8aor+LfQh7zV96Z2X5fs3ty86mlGicaZdyjEn4DLXllSlkdMwDJtUdmAg5r7UFnDKNX/9gTuyqz2K2P8fG/OUrgbFgQjxC/H3VeF7bhklKkfJKPRyjBBExGak4X5snGD+n7y+bq/iHBnECaa2gudYLtgQHaho+11eTFBxcfVHHrYb0HmkRFoHBuA8t1WG8pV8Ihjn3s7dGZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.59) smtp.rcpttodomain=arndb.de smtp.mailfrom=foss.st.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=foss.st.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xoLRyyx035Zq2sobJ/PlAsBg6NZY6QdYEYQ0DyUE5NA=;
 b=izICruxKDBerPclZsxj4jOkbQXg7hKExMSmTO74b1vnAQXGe/1PDwf283+L+Owjet5JBzLgTU6sqUl+0iDlWzqi0XIysDSgL2amh5gwZko5lTlMmwk4HE9iAPXjOcQJBh0Mir3D42U9dUoVDhGUYeCSdoF4j7uFrjlHzfsia7PMLJZ35j2d+97PYckMhi9TpsR8ooyGumtySwjuN/ksLDkSDvURmqGutqWK5+VwuElitfl70AJU9+x5aLQPLtB4LTmJRio6Ij6CsgGa9K8hDTzyN0dhxND3wkGgZeVuBOPOB1bmJeSpCe1z02TeL1qZzT1o6a+tg1GaMqyuxxwc65g==
Received: from AS9PR06CA0248.eurprd06.prod.outlook.com (2603:10a6:20b:45f::18)
 by VI1PR10MB3229.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:803:132::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.19; Wed, 18 Mar
 2026 14:46:54 +0000
Received: from AMS1EPF00000049.eurprd04.prod.outlook.com
 (2603:10a6:20b:45f:cafe::51) by AS9PR06CA0248.outlook.office365.com
 (2603:10a6:20b:45f::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9700.27 via Frontend Transport; Wed,
 18 Mar 2026 14:46:46 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 164.130.1.59)
 smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.59 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.59; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.59) by
 AMS1EPF00000049.mail.protection.outlook.com (10.167.16.133) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9700.17 via Frontend Transport; Wed, 18 Mar 2026 14:46:52 +0000
Received: from STKDAG1NODE2.st.com (10.75.128.133) by smtpo365.st.com
 (10.250.44.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.29; Wed, 18 Mar
 2026 15:49:24 +0100
Received: from localhost (10.130.77.120) by STKDAG1NODE2.st.com
 (10.75.128.133) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.29; Wed, 18 Mar
 2026 15:46:49 +0100
From: Christian Bruel <christian.bruel@foss.st.com>
Subject: [PATCH 0/3] Skip subrange map tests on DWC iATU allocation failure
Date: Wed, 18 Mar 2026 15:46:26 +0100
Message-ID: <20260318-skip-bar_subrange-tests-if-enospc-v1-0-f1a49534ebea@foss.st.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAMK6umkC/x2NQQqEMAwAvyI5G6gtiOtXRKTW1A1CLYnKgvj3L
 R4HhpkblIRJoa9uELpYeU8FmrqC8PVpJeSlMFhjW+OaDnXjjLOXSc9ZXuEgPRQ5IqVdc8Bg22i
 ccR19LJROFor8ex/D+Dx/I+Vs+3MAAAA=
X-Change-ID: 20260318-skip-bar_subrange-tests-if-enospc-c26f03038e92
To: Manivannan Sadhasivam <mani@kernel.org>,
	=?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, "Kishon Vijay
 Abraham I" <kishon@kernel.org>, Shuah Khan <shuah@kernel.org>, Bjorn Helgaas
	<bhelgaas@google.com>, Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>, Koichiro Den <den@valinux.co.jp>, Niklas Cassel
	<cassel@kernel.org>
CC: <fabrice.gasnier@foss.st.com>, <linux-pci@vger.kernel.org>,
	<linux-kselftest@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Christian
 Bruel" <christian.bruel@foss.st.com>
X-Mailer: b4 0.14.2
X-ClientProxiedBy: ENXCAS1NODE2.st.com (10.75.128.138) To STKDAG1NODE2.st.com
 (10.75.128.133)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMS1EPF00000049:EE_|VI1PR10MB3229:EE_
X-MS-Office365-Filtering-Correlation-Id: 04e6b2b3-daeb-4784-6a7f-08de84fd31ac
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|7416014|36860700016|1800799024|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	DAW7FxdrtX2fGlPXGOLmP1j7yLJo8td9Sh+PgYFTuFf0dvXREQLwSXmXWZ9nnXp31BIR2M8TeiytKG3UsexWf0pxxATJSv4DoLXLW0bwya2bS16KMDXsHMUawukEurT5R8pY4U8XtDb3Q7AnFpqkZCJL7zn4+iFu7gy5T9sxH1bUSRvF/Lum7kB3lT56e39h2xUjAysidR8Oqvy7DLgk73ikalAg92VJNoBtZaatHjkCewAPtk6HUMlDdmxaperKxkQMcJHhjkxzIM1ccyuPAPU4IaJ+Ghws+jkY/lElBIFnwoLX1cbiHIQ4zrJuWYxn4B5tgExZ/IGswcL74ip9obbSvPrgfHpVsJfViru4DeRsaToYz/cpXfAYP9eUT3n5v0zPru5+U96bkqZwBDO03VaibhIxHQywWsJRnd/FuSixVq4AqAxSdsI9sL76nQDPm65BFwuG03Dcxhyx+kQQhBGcFh88rz7dGfdCpOhAg7qskVsumm/jEwMQ5UEe94r92wpvHwBt8Dps7s/xePxX8tiQ/kj1vuLsSCN2BAdXrLO2EN4NFu7MRiY5YTEutvMutIcwRfrEbxQE7UBlM7GsrYegLeAG4QdXhsqW6mZhpeZ8rkyJXfsw7Ef55JSHg0/ASdedxs72vmfzUMwIZ1kRs+TdkaDhSgk6IKtfJ4yI0cX/RH4f0tPB+4T+P4qy/Pl2oHDr5ulQR1MkjRsjv2QhinGBj+9CVNa0vNE2oc0UoEq6L86rHJzqiRipLzx+g6NYfa8cIx9+rYY/nVq5NhhfoA==
X-Forefront-Antispam-Report:
	CIP:164.130.1.59;CTRY:IT;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:smtpO365.st.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(82310400026)(7416014)(36860700016)(1800799024)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	MmxpHlynku/GMyeB1aweVoiMG6yeCvEnitk8tskZn52Bnr9dT+ZlMQpCl96O9yI3zw+hjWoU7VYwhaHqUzIt6hkdRwnK4WnIuaBvaax/71ZNvYMn3tRlPQcSGsvqUWevl9dG3Gltlieef/Lep33GdAB696oyS5ruX6l5fEZTGI1gG572AMinNqmMAph2a9mw8l63FNCsoILpFxDM1eUG4bO2OUCkB5x6rohQQeXabQ0gvv1vgFIqK1/2B+LkDi1NgSVI1EgV7WdVT9jirg0h7+7W/EMLWFSBZxjkKYz6YBiAwyBiaxB0nKGHDcQScoTsXT0G3k1CS7zkKg/q8k+aCX9vQUosDd1p9btzf9IJfCggoldVffuaPh3dYOQbNxz9TZBQ6dUkKnKBGCiEWzK8rb0bCZVEb1MPU3K00E2NO4SxlKBTDl4O4RoN+L0vGH96
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2026 14:46:52.7362
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 04e6b2b3-daeb-4784-6a7f-08de84fd31ac
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f;Ip=[164.130.1.59];Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AMS1EPF00000049.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR10MB3229

For platforms with a limited iATU inbound window entries, pci_epc_set_bar()
might fail to allocate the ATU entries for subrange maps requiring more
than 1 slot.
For the dwc controller, this failure is reported with -ENOSPC in
dw_pcie_ep_set_bar(). In this case, the epf test cannot be run and needs
to be skipped.

For other controllers (Rockchip, RCar, Cadence) the .set_bar functions do
not use this error.

Signed-off-by: Christian Bruel <christian.bruel@foss.st.com>
---
Christian Bruel (3):
      selftests: pci_endpoint: Skip subrange map test if iATU allocation fails
      PCI: endpoint: pci-epf-test: Handle -ENOSPC in subrange map test
      misc: pci_endpoint_test: Handle -ENOSPC in subrange mapping test case

 drivers/misc/pci_endpoint_test.c                         | 6 +++++-
 drivers/pci/endpoint/functions/pci-epf-test.c            | 3 +++
 tools/testing/selftests/pci_endpoint/pci_endpoint_test.c | 2 ++
 3 files changed, 10 insertions(+), 1 deletion(-)
---
base-commit: 8e5a478b6d6a5bb0a3d52147862b15e4d826af19
change-id: 20260318-skip-bar_subrange-tests-if-enospc-c26f03038e92

Best regards,
-- 
Christian Bruel <christian.bruel@foss.st.com>

