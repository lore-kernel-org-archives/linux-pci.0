Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010055.outbound.protection.outlook.com [52.101.61.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 391263EC822;
	Wed,  2 Sep 2026 20:57:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788382672; cv=fail; b=BeVdSXn4vkIuQa66Qe1U4H1f5BWvmN8C4CHzU3UWSexF42lrNqeK+1G4M4ZDNk8/Q/QNCLvHP61O+svqRYkHSRpTSmi2HQ+tG43r+VU8KfDGdPC0Rls2zNTRX1McqeGlwyrghl82tVeIBoWrLnv1+eVvnGAnVBRSNBZjYeiC/to=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788382672; c=relaxed/simple;
	bh=0L7EoNBXSm09DDDRP/UBedG62Fa7GRMCHsuHLf4Ql9I=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:CC:References:
	 In-Reply-To:Content-Type; b=DeyifBO2mLPjIGGjrYfaJQEZ5nhuN28OZYeveARZ4GTw7x5tyXyePBs9ctz2XTMfX2hhO/tMd5csUo2ILDTRsM1CQw2qpWZCPuN7tCwb9HIz+JbwoFvMiSsueHEmWhPT4OktCbOFGLnz4v8yXg59GtYN/BSmF2b6WQK0CC0h0GQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Gru/t7ls; arc=fail smtp.client-ip=52.101.61.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Gru/t7ls"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=u5XvzYPXSX+Ie67Pv/AV3eTYG/E+orabiP9uRhmaoVAc0skZgArWSxg58tVs+edQ5Kx4s8ocMZLTvoszOWXRAK8M5QYuOaZDSo8ncgwzWW1vUO/ZkHOz7TjhlWd4P4/d/wddeU/lyExOf3dePqVoo29WiFQQdVXaXVP5EtHl/IckaNQUq4LzU+J8lgfIQKWdu5RT/kblMgzjPf4/l3yYrCGd0ylv5Dq8VmHaVl5WcyJSdUzjjrZF9RYblA5pcY3ITUUzwzsL92zilQyyQflgsQrOD5VmsqH6ENgtv/BWn9Frwz/Ul+1xDrLPGaakYkGXBZ1kk5Z/bFq3u2NIgASOMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V8uzunimIgv+OM1IR9f/5KU3rMm0KFNzUX71Kx53d5w=;
 b=pIreHVAYBF8DfD2n1LKAPfEWLW/wNSbSF3vU9rJ1lvlFsEywfqGraKam7wVHoZb9TeRUxOLrLvRGyvdyuFbxn8GIUCM89Q7uQgCOfszWA6B1AzaJIyfwieIehrQT4IVXqRkTGzqwg2tpUP2Exp+oiAl+x/WxdgdvzCpa/HrEpVUtmuvpSZbLfGO9Q2b52919nRfjdBRSJUc+fDn0aqjis5ZM7ULFV8fA6Y2z71SFDjegqnx16mzHDDptm3q5YzvQ5uvqWUZosBt6IFEyo2nSq/gVCnd4iaJSPRtCuMOV4cN82d/frtCMi+FRZmp0U1b5l9j1WJ9H3z2S9Rk4thKm9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V8uzunimIgv+OM1IR9f/5KU3rMm0KFNzUX71Kx53d5w=;
 b=Gru/t7lsi3VcLdTFICwq6jOvemwpDSYUIV9A2t0B73xfdBydei2r4NqXdweKTMNn3GrCREUThwlGj+4wzQQTSCTVWucBL8xqMh55XlWvB+TvBJUuMjuG3eeiBAMk/2SB/2iRU01NlkDlTzOxeCROprTe49cbJZVmig5QrIjmuFQ=
Received: from CH0PR03CA0414.namprd03.prod.outlook.com (2603:10b6:610:11b::32)
 by IA0PR12MB8907.namprd12.prod.outlook.com (2603:10b6:208:492::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Wed, 2 Sep
 2026 20:57:39 +0000
Received: from CH1PEPF0000AD83.namprd04.prod.outlook.com
 (2603:10b6:610:11b:cafe::4c) by CH0PR03CA0414.outlook.office365.com
 (2603:10b6:610:11b::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.11 via Frontend Transport; Wed, 2
 Sep 2026 20:57:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH1PEPF0000AD83.mail.protection.outlook.com (10.167.244.85) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.382.8 via Frontend Transport; Wed, 2 Sep 2026 20:57:38 +0000
Received: from [10.236.189.59] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Wed, 2 Sep
 2026 15:57:37 -0500
Message-ID: <2df10ab6-5bb9-461e-8aab-c53daf11368e@amd.com>
Date: Wed, 2 Sep 2026 15:57:37 -0500
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: "Cheatham, Benjamin" <benjamin.cheatham@amd.com>
Subject: Re: [PATCH v20 8/9] PCI/CXL: Mask/Unmask CXL protocol errors
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
 <20260902133933.2992457-9-terry.bowman@amd.com>
Content-Language: en-US
In-Reply-To: <20260902133933.2992457-9-terry.bowman@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD83:EE_|IA0PR12MB8907:EE_
X-MS-Office365-Filtering-Correlation-Id: e7fd451f-fce8-453b-0789-08df0934d2a7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|82310400026|23010399003|1800799024|7416014|376014|10067099003|56012099006|4143699003|11063799006|3023799007|22082099003|18002099003|921020;
X-Microsoft-Antispam-Message-Info:
	lMhZoYGBncaVH4jENNxmnC4F37rE1gPYsnp42vXNdLrr2NJoci9CrUNUuVosbZ2XYgE+Eh2vNrnJJZfRnGqPUlDuP468IOHTQCdnAcBFQcOamjr/NpFE3xFJoWKh6nH82JdLYIPIuKitinfk8vXbVPl0Io9bKo30GUBKEJwypJAh1GcZHbblzLLuGBdD6lujBLxyoeETs16dnGwa2goGNdFeQci0ddyY/eVzTREqWlf2FwcRiZp1CWkGtfqYe3rs+pmZTmhROe3+PhAnI3Zvc1Wh+90F5s6spJ7FdnvEIh2kK6BsisGDmhP6fcFR7gQo/cHg0xGyqIJ3exkjJMsVLlsBv78WNG4RQ0ZFF0RFyjZqy/SFZ0kNM6Q6T0tXeoVNLw1H7v/pMdA/YWnKm2X+txDz/tpRvWAiPiS/qmwNz8tMLQq6fpRakXMZiK1VKFtKWCcFRPUe2MNXLfIkyB2De+7gAVklNqj23s47Q13ZblZwCCYiKSSK6tz8JQrw4Q/4pd6oRsIZYry/hcIy08awQYOO3/cXG7jPS7OnRQ0RmU5RMgKyyyxLcS7ize1mcNPJfGvMTLatvMDwpllaUSay/lfh9K7+tddfrepukb6w/yQRnUsaTv2LMU+2q3huHlUC4S/lsUlgqX6jBQK6vAiHRg64sDR89GuqxHOH6ZLaC4smlpkP86/xXkXR0OS3gN5lE5UGhATXdeCNZj+b+Uuwi4MgmJGqIvHbgXPox0Kv0Y4=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(82310400026)(23010399003)(1800799024)(7416014)(376014)(10067099003)(56012099006)(4143699003)(11063799006)(3023799007)(22082099003)(18002099003)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	W4ihaijCP8nR0gWFJAZBowZLyFmWH1W8P2AGoij9/6q9UtLeXg2aYpHe/oIFjgEFqY1ilCipnYR+9AHJRYgyk7j6Tvv4g9gSJU4gyzeRfd0pHYS50KjArh5BWF43wBhX7wMbCWarw/gmMLdAel93VbRttJjgrKseUaQ1WdCsnNhZpgEYV/SjHJ27rZCZduSGzheDZSgWz9SBVQ4OBgLOJj0N6BKEf3yQmF8HhwblFVW5fIZsjAoau5pTe9PixQqJspWJoW+HsL68K22bdy2J+7A3HPYYFXTAEK5kFpmtEW3EPqsszLY06foCry6xRArZZebr/mf/6DBTK1sPiCF6Af6GqmRzsejwomSOTOXyn4wO/alLwrZ8+Jd937Ie5mTLtwg2ITjaKG+B5xuzc8U9j2KETkZmRPaeAS05jjUOd8RQNhWNj79MY7Z8dT2ggNjY
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2026 20:57:38.6472
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e7fd451f-fce8-453b-0789-08df0934d2a7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000AD83.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8907

On 9/2/2026 8:39 AM, Terry Bowman wrote:
> CXL protocol errors must be unmasked to be reported. Add
> pci_aer_mask_internal_errors() as the symmetric counterpart to
> pci_aer_unmask_internal_errors() and export both for cxl_core.
> 
> Unmask CXL internal errors in cxl_dport_map_ras() and
> devm_cxl_port_ras_setup() after the RAS register block is
> successfully mapped. Register a devm action to restore the mask
> on teardown. The unmask/mask helpers gate on dev_is_pci() and
> pcie_aer_is_native() internally so callers need no special-casing.
> 
> Remove the dev_is_pci(dport->dport_dev) guard in
> devm_cxl_dport_rch_ras_setup(). On RCH systems dport->dport_dev
> is the pci_host_bridge device which is not on pci_bus_type, so
> this guard blocked real hardware. The caller already gates on
> dport->rch.
> 
> Co-developed-by: Dan Williams <djbw@kernel.org>
> Signed-off-by: Dan Williams <djbw@kernel.org>
> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
> Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> Reviewed-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
> Reviewed-by: Alison Schofield <alison.schofield@intel.com>
> 
> ---

Reviewed-by: Ben Cheatham <benjamin.cheatham@amd.com>

Thanks,
Ben
