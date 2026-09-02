Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010055.outbound.protection.outlook.com [52.101.56.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6DB536A364;
	Wed,  2 Sep 2026 20:57:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788382667; cv=fail; b=YOaW9YyRn1m41cHxBTWuXF348Fm1bT6AZ76LBashrwmQBFxWVlaXFl/0MOBv8dMPyiYqy4/zz62sBjfOoPXA9V7vHg9zRIQzU/DKf8xjVB5MQbo+KQ+pFx55p3cps2nP+AP9yODrcH4mb9/popU6J4V8EA2Be5keSDJYZfl9FTs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788382667; c=relaxed/simple;
	bh=MwCbPrncAu8qyIyQqf4IHd/jpGOm0v5S806feayeyqY=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:CC:References:
	 In-Reply-To:Content-Type; b=eEY3EEjDYKnzNTahsOFwfST/bs6tHGVNx+kwlYm/lMdLReK5dWq19wI+0Iu/5duNE6/hmacti0ejUIfoVkqDjB3k7M+Qx0at/Gujw8S57oIu1wwjDFGd7rgY8v8ClSyMwPHd9hPzIBVhqf8NnTr2p3bKt27DvroLPBzoVwrO5yk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=qU+5VFxx; arc=fail smtp.client-ip=52.101.56.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="qU+5VFxx"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AdjnmpRUR5BaNizXcPgRSIbhN0erKd64FWLfMfKyAhDaT3GqSd4TVnmc2egiYUWPdEAYSF/scLfSZR3jxSJBSzsM9gOuAoa1qPVOTWAyl9SEoBjvhREQW0zaQga/GcRUMpnxuVRlA3929nrD/EXj1LerAuo19TxY5Jpa+FK50zx2Xv7ybnKnuoECnT6jfsZxWsaQ+1bxZ/7SlbnzrnB+PatQw3ie/iPCyzJQdbEiwuDXIcQRDJXoDbOWiWxdKCd8S24i6RFRp1cHHWFji9gxJhWw/ZEBas4m4kk7nt6tuNzDh0oaI6CZ9M5VwWd3lIa5szbZ8AVbZRxqOSNd3Cdmsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0d5tGOj9tDLE5YpYyWX5ePHTRPJIp6LIseMeOrpowt0=;
 b=A6qPykM/z8x0kgZLmgzjZOledYXzgXU16rcpdRBtfnxwSEESShs0s48SJTMNJfkJup50MWmJ6tdCfIf+nacBgPhCucJThH4buWpXfFolNNfCXculHzVSFJMp1k2RODk+qL6EUL9lCwOhferwk0Sq8yWP1M8kk9yPXf+fCaUE8RoDPRmbx34aLUUBfjpSQyLa0ayt8HQXVbnq0Zy6+5g8vzpHvrDMcnSe5SxxqB7bXNRl0VW9aQWUXum50MWryt7rkPIev3X4beDDw0QNefcLEqs9mf5K2cv1T+BPjTXrPcrarLD592U/H99Qr8KXDkQB+XYzczZlHSfE35fLvGUTig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0d5tGOj9tDLE5YpYyWX5ePHTRPJIp6LIseMeOrpowt0=;
 b=qU+5VFxx5caXstL37XZQODb5AhamsJm38ncxcIhcoYqc6vx4xoHtXU7B81DF7WF83Dqjc+C+5UBlxY82756Ki/USJV/UPV2JhIJ+JGkn2Q4tXOFLydhA4WcgWpauBZZM04MzDVqtkdJGI6jQw9NLtEz9HoZEY4CAeRACRKWJhL4=
Received: from CH0PR13CA0009.namprd13.prod.outlook.com (2603:10b6:610:b1::14)
 by SJ2PR12MB7846.namprd12.prod.outlook.com (2603:10b6:a03:4c9::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Wed, 2 Sep
 2026 20:57:34 +0000
Received: from CH1PEPF0000AD80.namprd04.prod.outlook.com
 (2603:10b6:610:b1:cafe::7a) by CH0PR13CA0009.outlook.office365.com
 (2603:10b6:610:b1::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.11 via Frontend Transport; Wed, 2
 Sep 2026 20:57:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH1PEPF0000AD80.mail.protection.outlook.com (10.167.244.90) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.382.8 via Frontend Transport; Wed, 2 Sep 2026 20:57:34 +0000
Received: from [10.236.189.59] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Wed, 2 Sep
 2026 15:57:32 -0500
Message-ID: <0e931d5e-4290-4bcf-8ccf-eac643e4db99@amd.com>
Date: Wed, 2 Sep 2026 15:57:31 -0500
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: "Cheatham, Benjamin" <benjamin.cheatham@amd.com>
Subject: Re: [PATCH v20 6/9] PCI: Cache PCI DSN into pci_dev->dsn during probe
To: Terry Bowman <terry.bowman@amd.com>, Jonathan Cameron <jic23@kernel.org>,
	Dave Jiang <dave.jiang@intel.com>, Alison Schofield
	<alison.schofield@intel.com>, Vishal Verma <vishal.l.verma@intel.com>,
	Davidlohr Bueso <dave@stgolabs.net>, Bjorn Helgaas <bhelgaas@google.com>,
	"Dan Williams" <djbw@kernel.org>, "Rafael J . Wysocki" <rafael@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>, <linux-cxl@vger.kernel.org>
CC: Tony Luck <tony.luck@intel.com>, Borislav Petkov <bp@alien8.de>, "Hanjun
 Guo" <guohanjun@huawei.com>, Mauro Carvalho Chehab <mchehab@kernel.org>,
	"Shuai Xue" <xueshuai@linux.alibaba.com>, Len Brown <lenb@kernel.org>, Ira
 Weiny <iweiny@kernel.org>, Li Ming <ming.li@zohomail.com>, Shuah Khan
	<skhan@linuxfoundation.org>, Richard Cheng <icheng@nvidia.com>, "Robert
 Richter" <rrichter@amd.com>, Lukas Wunner <lukas@wunner.de>,
	<linux-pci@vger.kernel.org>, <linux-acpi@vger.kernel.org>,
	<linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20260902133933.2992457-1-terry.bowman@amd.com>
 <20260902133933.2992457-7-terry.bowman@amd.com>
Content-Language: en-US
In-Reply-To: <20260902133933.2992457-7-terry.bowman@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD80:EE_|SJ2PR12MB7846:EE_
X-MS-Office365-Filtering-Correlation-Id: 9efc16d7-2554-4552-953c-08df0934cfe9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|82310400026|1800799024|23010399003|7416014|376014|10067099003|6133799003|56012099006|11063799006|22082099003|4143699003|18002099003|921020;
X-Microsoft-Antispam-Message-Info:
	7D8bet726Q/EyWBPyj+IIkZ1Wzagkb7v9hcVs0SfqeJEH1S7ZVijcZkeA0Q4BsBCxbczaRHGZoTPO+ChtDa05Koukk+aeNGuYO46fCYS85FEz4LhIhvLmBVyzepOrWguOQztmHmmvCHCPeJ+tNgdxaZgN1yotxwssETGI3UAtfZUtQZX2AwgEb+WEbZjQMopqfAh8UcZzQqwA0gJttjJ4T6cEQwu2S6tHbJbKL+MsZrT+Qq5tZY7kAMXW1LXEfRHk66pnrgcoAuZCKZ0YnP4sL6B3mG+z3THNEJqDA6Ro7HqmtullJDqh+sKxcbtH0SWjarNp6sVFiTGx812g/YNEtO6NHQKBKj6Yd98dv4ppofvbc7GKUorP8txL5Lsyd6UiCohGteaMIhmuwdfKrGSc81EV0JM7qkGJvXATLROJMNQiKDOtpfkq3WNQBGt8HiJ5wAtS+jRMLoADNwEaCG+4ywSfst9os6SbHmifYN3iBekZ3oNUAZcUcsh4hjmvzOCwp6gRco2LKsEC68/dnX9uIAspB9b24GmYvTJHN3bqHs4bk6cU9gh+c/4unww+fHLYUEiLVvb3c6KEcWM1x4QkFmMCcIJwzXawO278EHfo+wgusKXtct/zbxqNxyO6oZHAhxQECrRCMEebvKdvA3otTFXX/wn6ph9n/t6FvgsMJjIXC/43f8ZAM6sLcnFQV5EUm6J4b5EOijkpv6+arA+sxP7InUKrl26Gk3eI2mGvmR7o2F1UseM76sbaEW8vCwa
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(82310400026)(1800799024)(23010399003)(7416014)(376014)(10067099003)(6133799003)(56012099006)(11063799006)(22082099003)(4143699003)(18002099003)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	E7DgWf6DTPOfSynjKxI1lCxrhI5vFUMIPzZpZSxfwbf4aFD3PqTpkxXUv4Q5peMt2AA5n/wtXWeqHXjMAqZUKOAhYYiMzruc1JQc0itTMIvDctiWnfXazeJDbwDvYAZtzpn3vI5sGtVXAZSCWjE/ypPfUzOqph2DxJyIhgOE2KBv6Ib/hPlhzv0BUmuykNrWzL1tJixaWzzdUZJX0IEMKdUbcJvfegBS/O0brHPhONFsy7Tie9lnY2Q6aNvUxdeKWmZZ84DiXnIgp124MmNuWC+ITNBA4ZXmSVoNT1irvyJcoTrdjZaJezq3Hq6brb/ZDnyevnDDrsY2dZcFJaJcoA6B203bBliAVbpiK2dZ9AF5lrDFU43LROVWK3SPh7Bml4WXf3EJgANRAqviHhqjqI1pZ2OeMWT6+3QJRH1rFN+RLcP72GfVat1E4dMqsn5t
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2026 20:57:34.0509
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9efc16d7-2554-4552-953c-08df0934cfe9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000AD80.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7846

On 9/2/2026 8:39 AM, Terry Bowman wrote:
> Subsequent CXL error-reporting code paths need to log the PCI Device
> Serial Number (DSN) as part of trace events emitted from interrupt or
> panic context. Computing the DSN there via pci_get_dsn() requires PCI
> configuration space reads, which are slow, can fail when the link is
> down or frozen, and may not be safe in some contexts.
> 
> Add a u64 dsn field to struct pci_dev and populate it from pci_get_dsn()
> during pci_init_capabilities() at probe time via pci_dsn_init(). Only
> write dev->dsn when the read succeeds. The zero initial value from
> pci_dev allocation already represents 'no DSN available.'
> 
> Remove the now-redundant dsn member from the pciehp struct controller
> along with its kernel-doc. Drop the pci_get_slot()/pci_dev_put() pairs
> in pciehp_configure_device() and pcie_init() that existed solely to
> read the DSN into ctrl->dsn. Use pdev->dsn in pciehp_device_replaced()
> for the device-replacement comparison.
> 
> pci_get_dsn() is not modified because it remains a pure config-space read
> with no side effects on pci_dev. The cache is written exclusively by
> pci_dsn_init() at probe time.
> 
> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
> Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> Reviewed-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
> Reviewed-by: Alison Schofield <alison.schofield@intel.com>
> 
> ---

Reviewed-by: Ben Cheatham <benjamin.cheatham@amd.com>
