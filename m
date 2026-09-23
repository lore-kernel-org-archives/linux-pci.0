Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012039.outbound.protection.outlook.com [52.101.43.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86096480DE9;
	Wed, 23 Sep 2026 20:30:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.39
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790195458; cv=fail; b=oxJKSdR+2hxweN3nAnJQQvt/Ja7GCZmHqP2lHUIG+Efvl5/kaWM6VvwickBI1i+A2bMG3HbFd7246MQw/anmviJ5jL1A1DGcJueNKDivvpgo8r/MjyNjqejgFDURIYTrIG7NUuWafM8/d6rOJFncd14cHC0g9BDFkcLxGqTawNs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790195458; c=relaxed/simple;
	bh=AOPSHLxUljLtI7oIj58FoBcM2Me/jSYwbuR11bVMAkk=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RTtZOxoNMsvbW+cZwrkQPBKr9ZmdA1VJfluKtR81Y6AWYyQf8/nwAHobsvq+h1mfUrnPdF3Aw0AAnNHwWMH9aTXHiMTq7TjpFzmxW3x4GH02IiNZbjQwJTfMknt+IJ/Mi7S1G50GfUqUYnr7LdMlG7rg/v7tU4PVycJiN7MDgSg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=UE8Ye6Au; arc=fail smtp.client-ip=52.101.43.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="UE8Ye6Au"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hta4Yjk63Dl1sEzIWlFxuoBHS/Vt0R2M1UdrEBmL+MLxFAN10g/OruY4tbE1kvvhmcZnHCmK++Bd7plQQWaa2R2jB+fGRR0+hvvkpj4SnV8OhibTrblfpBXNMLpw/MlKhJnGC7qw0hx6GC4ZJKiV7lf1+JQsIUIy7QfjIe0I1nDaFJdDuU+CpCB6Dmuq+TCuU9DnC/WVkGqTpeQwkH9Etd6n+Lhoxgn4gb95MjiqfzjCQc6HV02WTNvsrevEOYAnpZ9QRPDIQT1Ib082PuzWTgySMIaT344c9RHcELXoyrSHoRpDe+kNxSPxMnwwy8gMHVIru27WgFHgR9c2k5bngQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Oi3DPSy2gh1RXrU8sKFzdLt5IsUjzxUby0+jZeaMF5o=;
 b=SgLeEl2Q+6vufyrrF8sEealP1HLIDRacq81LEfzE3lIkb3Xu6cpimBFWFs8pSXZR3vK3BCPcmD+rRtToUD+oypf+p281L4sR3eHEdmBykOVx3xMtEXSeZiiAfvqJA5Z3FjOZaoCO3aI+hP5fPRFpnfMxPI8PlSVrZmQYHHTlToqJcFj26bG93SEilkOjLswpJQ65kOYvY0uDGN/2GMNgYFmoeaGBXN6OGx9XO4iwSZA0wt5icWl2rVXQxdwzazh13KVF/FYHTVtxSoD/BpxdSwkaQa2sIIbkUFBnJDCDYtNJv1kq129Zr403a0rsH8uAywt/18REw1q9/t7b9RHx3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Oi3DPSy2gh1RXrU8sKFzdLt5IsUjzxUby0+jZeaMF5o=;
 b=UE8Ye6AuDgL0AaiBhpvvsoxM0xRGj9scPmmsCAyemHI5I6qhvQ+HTmZXONfsbWGXd/0ybR5fGwQ5wfa8FoRWZHMIQOnAME+Lkwv7+cTfwjJR6KyGkGaO63vJfTWwKBq14V8t6Rhv6EdfcoLXKdI5rknTI39gNYThRRDJoBHFz5TmGmR39Hdwj2panY0YgWI8Wl7r1IUOmbnPmcKhc9RErVpSEDB1Vk2KzIDQdIHJrE7tZE0W390sxmxNGLu42nQLjqRJPyjZbsaUWFJdGZpVpFbhzt7IcEdYvxwWdryQN+o5U0WMzxZ6F/Ud9kzZXBy6MyPyV02u9HfsJL6EA8AUpQ==
Received: from SJ0PR03CA0190.namprd03.prod.outlook.com (2603:10b6:a03:2ef::15)
 by CH3PR12MB297944.namprd12.prod.outlook.com (2603:10b6:610:367::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.16; Wed, 23 Sep
 2026 20:30:48 +0000
Received: from SJ5PEPF000001CF.namprd05.prod.outlook.com
 (2603:10b6:a03:2ef:cafe::e) by SJ0PR03CA0190.outlook.office365.com
 (2603:10b6:a03:2ef::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.451.14 via Frontend Transport; Wed,
 23 Sep 2026 20:30:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SJ5PEPF000001CF.mail.protection.outlook.com (10.167.242.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.8 via Frontend Transport; Wed, 23 Sep 2026 20:30:47 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Wed, 23 Sep
 2026 13:30:22 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Wed, 23 Sep
 2026 13:30:22 -0700
Received: from nvidia.com (10.127.8.12) by mail.nvidia.com (10.129.68.6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49 via Frontend
 Transport; Wed, 23 Sep 2026 13:30:20 -0700
Date: Wed, 23 Sep 2026 13:30:18 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Will Deacon <will@kernel.org>
CC: Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>,
	"Bjorn Helgaas" <bhelgaas@google.com>, Jason Gunthorpe <jgg@nvidia.com>,
	"Rafael J . Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
	"Pranjal Shrivastava" <praan@google.com>, Mostafa Saleh
	<smostafa@google.com>, Lu Baolu <baolu.lu@linux.intel.com>, Kevin Tian
	<kevin.tian@intel.com>, <linux-arm-kernel@lists.infradead.org>,
	<iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
	<linux-acpi@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<linux-cxl@vger.kernel.org>, <vsethi@nvidia.com>, Shuai Xue
	<xueshuai@linux.alibaba.com>
Subject: Re: [PATCH v6 06/17] iommu/arm-smmu-v3: Don't rb_erase() a
 never-inserted stream node
Message-ID: <arQ22ocIlWep6TS1@nvidia.com>
References: <cover.1790188510.git.nicolinc@nvidia.com>
 <76c5f9dde30269995ef842a12a3a5e1ebaa3e6df.1790188510.git.nicolinc@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <76c5f9dde30269995ef842a12a3a5e1ebaa3e6df.1790188510.git.nicolinc@nvidia.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001CF:EE_|CH3PR12MB297944:EE_
X-MS-Office365-Filtering-Correlation-Id: c598d242-1095-4431-e461-08df19b18d59
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|7416014|82310400026|23010399003|36860700016|10067099003|4143699003|56012099006|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	5V67SyCkkYjwrQ9XLMUVjbGwn/MHSbuPzr/5RLE/gUEjwADJ+EL5NYmQlAHMSjI/KViW7tSK/e6IfDm+v5stXoki/TqbrJgyB8TrRW0Fs+KpFmBkoAUMvJizgRMW5p+5u/qUjn6QLuI0EH9xnZI3PdbRhDITAd84gf5d9k8A+5tFaMTdtH2NoUadxwzAgQt73ypQkLfyA0DIfaZN3uHY9tQ1GdLEcrhZfEiH03NrHDh2SRD64KI9GJQ0dBvRt0e1zxPtsJDMPXFuNAJPxQqXW7HBlsyIu7+iQLZ8NdEPDL8LuZbOo3jKBWJKJXjHcVyQ9VuWhQOxghpWStuwqBx5tzcWLCtrfHtuROHYYQdKylWrSxo/gapGfa9R/C6wn8PUL153tg1UN3dJ7A7NLgdNt2/6dbT4+AhGp02YDokKPeHq/oZOHmDsyt2YKATED+mIofTlcnPYbzAyGnzNxECsZwqrPf3G8n1QIII9lcz09IMCNnCuA5ZfBPIExniOyXRrDPY921U2Yy4jYSSfBBhTUX4+Aytnr9WNLlb+yAYonsCSK4Wc9fvD8Sc2Bav2UfvC3rYqDhkIc12X+/rfSzFxawBXP5/fSHqX97QOvH3ryDLMJwtzKIJ/+6HdO44URpGUB+tzuKV3oXht7Ab14tPITJH2CWcPDX0s6YkXFzTF6+NJMxCW1th0JZ9NGNkQUcSKHCWJaM0znQwdEWy0A526KQ==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(1800799024)(7416014)(82310400026)(23010399003)(36860700016)(10067099003)(4143699003)(56012099006)(11063799006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	eNOtmTz8a4ertg5ibH8Uaa8LCuQrAkDF4qJThWc5fukbHYq7SWe5oVYGfTAoww4AFXIf9tmJYNdcQ5woU+N1BgGLuPIlLYOLDHCW/XjdJyfM85FVqtfd0XG1GBMh5MP5QW3RRw8cYXTdlPNIZsElSZW+Js0iO1kvhOCITEenEmztgsEgR93cMnaXGmZv4+kpf/mBtwkVbPF6p2Yx7t18gTdGUgCrM6yqtUp8olV53JVVxRthVaHlf0qhpnAB7XG1EWM8nc8p61JA/JGQ/3MVTkwa2i6sb8GWDZ374wjCEgQv4GW6GRlNgHaISM8Nkk8lf7YPc6MZ5kDbhuWP8F5vYYtv94wjxmITdzQ2P1LpI6gNUMteIq85oqfQB74NoaHmJiLn+eLJ25netPvA3q1XsXfI7EyBDFDMNbYmQQm9WAF4nO5u10Ad49v674BTu9vz
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2026 20:30:47.9979
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c598d242-1095-4431-e461-08df19b18d59
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001CF.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB297944

Hi Will,

On Wed, Sep 23, 2026 at 01:11:25PM -0700, Nicolin Chen wrote:
> arm_smmu_insert_master() skips inserting a stream whose StreamID duplicates
> one the same master already owns (bridged PCI devices can present duplicate
> IDs), leaving that master->streams[i].node zeroed and unlinked from the
> smmu->streams rb-tree.
> 
> Both the insert error-rollback loop and arm_smmu_remove_master() then call
> rb_erase() on every master->streams[i].node unconditionally. rb_erase() on
> a zeroed node sees a NULL parent, treats the node as the tree root and sets
> root->rb_node = NULL, silently emptying the whole SID tree and breaking SID
> lookups (and DMA) for every other master on the SMMU.
> 
> Mark each node with RB_CLEAR_NODE() after sort_nonatomic() reorders the
> array, since sorting relocates the entries and would leave the earlier
> self-referential RB_CLEAR_NODE() pointer stale. An un-inserted node then
> stays RB_EMPTY_NODE() and is skipped in both erase loops; inserted nodes
> are linked by rb_find_add() and erased as before.
> 
> Fixes: b00d24997a11 ("iommu/arm-smmu-v3: Fix iommu_device_probe bug due to duplicated stream ids")
> Assisted-by: LLM
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>

There have been two other versions of this fix being sent by other
developers in this cycle; both of them were seemingly for the same
Sashiko finding as this one.

To avoid more versions sent by more folks, maybe we can prioritize
this patch considering that this series might need more time going
through the reviews?

Thanks
Nicolin
