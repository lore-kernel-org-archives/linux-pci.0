Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012037.outbound.protection.outlook.com [52.101.53.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5878B3E5A14;
	Wed,  2 Sep 2026 20:57:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788382662; cv=fail; b=HgHOImDSssT8hQQ1EMycHl8V4+NoVDFEiImpK0VVD/Xyet0g6RAN1XZnalzIS1FWc79U0HTHH4cZnUVNhi2GazwjplU801qFwsZ1wugBfBRbAlB2UtPK6kgA5q56FsPVWZW2sAjYAhuK446CsTbCDB9MY28nJhlXafCBtaIhkyg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788382662; c=relaxed/simple;
	bh=lZ9kLABRqVlpaHolO8Gwtp9M8viMV7GQednDR5vvtVc=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:CC:References:
	 In-Reply-To:Content-Type; b=vAJqoAz7bpldMFrls+jUtL6GnYnt2QulBdw3wHHoaUwo0WBdwI0APYq6UVpMaFjgTFp8j87WqyEhpqEfwHJXVFidAN9ujIiTxnsL918eOEJANKCuh3YZsvwUl+kyrFg3WPVVF8coRryRy7m9qxcWwfN4rUFE2Ldpfkg8kdMmsXw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=VWrPU9Eo; arc=fail smtp.client-ip=52.101.53.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="VWrPU9Eo"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TqA3E03lwa4uChs2Hd9DByB9jcN+cLRa+9D12Zw7neqaw4+76YaMn459ZMRioKg2vKpyGHYjYxEU0jzlhno0ckx+s8DccUPi3bVwg0ryIgBxxnAvkSjah/6pS5ATQjADiIe9lRLe3g7FsKQ5aiU8O+xvib7v0jQ4yWVm+A7lTLR/GKq4vhdqI64FO6xkiAdnEo8Ap7a3uQ/ZkYtGfrRaU+IriUDRpBObNbvUIv0VbIC9e06T+hx58z3VBm+3EuOPDcKdcExgRWWfwzgKYs+pW3K5A/qqAaduZQ1ldXRtOQsGOLR/szPmHj+OgbmTPJ1hk/nPSeJrUqZcPVfGFrSsIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BoEXQXc1gaHYVmO9SMdq7jkRkA11BaCj6/edFisX38g=;
 b=HsBGnf5Wvp1BrkVpemJUy6GyoLHL3cdiSLKKPRRNzi2z+lRZ3A01b21jycJNWePBpPAQbyqoJjBRmY/VXelSI1citriWS9ReIQzBfSTLP5BP5RIPhmFVI9zu8pXNdjCmskSIihHEfF3+fg0A1OPrCbQDoqyAiDkUjpTm6QyCrXUZFejSI5+IRV9bsFAjKnzv7qJhJm7xk3u9oV0L+ROVUbifs2Rvxxq+sBG7SOSq5X1/eY2skNYNQ9k4EDRNBVCPS7TSw72wwugDQzQE1hTgexo3aI36o8ozm1eilERHlcme3cT+r3+nR5TPyqKhzqkW4raWf+AQzG/uS+mW/9dDzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BoEXQXc1gaHYVmO9SMdq7jkRkA11BaCj6/edFisX38g=;
 b=VWrPU9EoJwHLMc8Jr6Bg5EzGJawg56xt4Mf+vhrOJvSxTYB965JBXHN+Sx0FBQWo3t0GFhf5KoktBlh6xjCD6IAovnNmAUiQSFZwXr9jKqZX0qPFEta8LuVcts2BUTGXt9Mqo+VxmyubT3Xs0FmpnRQ0g6L2GyLR03/22zIjd04=
Received: from CH0PR13CA0023.namprd13.prod.outlook.com (2603:10b6:610:b1::28)
 by CY8PR12MB8265.namprd12.prod.outlook.com (2603:10b6:930:72::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Wed, 2 Sep
 2026 20:57:21 +0000
Received: from CH1PEPF0000AD80.namprd04.prod.outlook.com
 (2603:10b6:610:b1:cafe::3e) by CH0PR13CA0023.outlook.office365.com
 (2603:10b6:610:b1::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.10 via Frontend Transport; Wed, 2
 Sep 2026 20:57:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH1PEPF0000AD80.mail.protection.outlook.com (10.167.244.90) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.382.8 via Frontend Transport; Wed, 2 Sep 2026 20:57:19 +0000
Received: from [10.236.189.59] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Wed, 2 Sep
 2026 15:57:17 -0500
Message-ID: <71a925a8-2ba5-45e4-bfec-86873deda90c@amd.com>
Date: Wed, 2 Sep 2026 15:57:17 -0500
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: "Cheatham, Benjamin" <benjamin.cheatham@amd.com>
Subject: Re: [PATCH v20 3/9] cxl/ras: Handle RCH correctable and uncorrectable
 errors in one pass
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
 <20260902133933.2992457-4-terry.bowman@amd.com>
Content-Language: en-US
In-Reply-To: <20260902133933.2992457-4-terry.bowman@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD80:EE_|CY8PR12MB8265:EE_
X-MS-Office365-Filtering-Correlation-Id: 2fe9e51d-a6a3-4da7-60fe-08df0934c6fb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|82310400026|1800799024|23010399003|376014|7416014|18002099003|22082099003|56012099006|10067099003|4143699003|921020|11063799006;
X-Microsoft-Antispam-Message-Info:
	+eY7xEl87ekxJKVEdhFhmRVTFusahgLmvSLM/Gk9WKdw9vMt7uj8Aok3qC2MVAG6BG6Ms8WDFur5NG/gNHncUq5Kxm9tlN+zou8K/CSMcRY8y+QMyxfgk4SL83yeEtPTlihdTR1GVneeCXFAJDwegJCe3+7L2s/Pas3RLtAKAnJnqhkiY8AAAUySoQR17orRja66tgPvntvVpJp73mj63m6+ka3C/GV6PYyVbN0XRoWO5BeUWJAtFUeiZKb2kRJy7vhKGj6AtJodM6sHf9c92Kp+tO7VC/cpDsPJnbd3Ds3A+ASj9KLlkCPYR9lKj1S/ByNDvUASBd79Zm1jbOyxP3mzco9odXQ7Dqk39XfVeJv5TWiycvMVUGHv8EdncvLX8Pkt54J3W/xuxY10y7yiy78K014tLCaWqmZD/HSOcmvcKOJM4mh5IxiKQqTEQCNbkK/xBQDMEsO2m9skyu73KhfikwDBnG+lo4jLifXhPjMg80Mz9sZn2FB3uoDhXq5CiFPxMJuJur3M4tydCLb1zjc/ft0hd0cA/Hd5iVYilB/IF5QFdhMnYw32ZoJ+tCJODMdiPQJogUV5ar2gJT3FpZa1GiDn9pZMobT5qnl2e2wQ5sxNEWPpT5/PTgks7tALhAVBYdQ4VmwRLtw2liCbiwX98aGzx+GwtspkK/pOWV75qxLNPSmtdsRvBCO4m4DxeYQZ9mrAy7Q8+6CtC5TDq6jBalMnTzs+X4hd2u+EZ9iGcA8lypOubN6feosoYJOb
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(82310400026)(1800799024)(23010399003)(376014)(7416014)(18002099003)(22082099003)(56012099006)(10067099003)(4143699003)(921020)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	NCNwPUlycy+aBVbXbKD2tyjlAe/3Smmc4NFtsiLVj6sYZYflT0iVljUvnzoDC+RI4z5R1XcZgfZ9tZ6tAMpMEU4EXsAo+kdZ5TVeDk5t3zl6dioWdKdiWCcPfEOpVWOmx58Gpl855DaoAZywy+SeVHemq9jw9PhsXXtqkB1Kdl8aWOu49a/hJr58uVsyIGxcgbCQyCi5wDnZpVeimmUsi4n1aj4CdX/3n4X9lelZtja+8F+RcwbG5qxsgrSyX1CC5F3zV10E51BT3wg2AamAeQ3TMQ3WyqZhEVxOH5G0KzoTXgnSOhXNecbOn36sXukDvf1tiD//ZrFq6sx65BrO3Twn8TEg57HdXk1qijZj5cF6GiPdymEoKiwgGQLbkD8JOuezzfnwSUPc19fqY/8icBQ5Is2hqilNIrkxfVsUaPhfy5aFj3I5sHOhTdu7LAMh
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2026 20:57:19.0574
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2fe9e51d-a6a3-4da7-60fe-08df0934c6fb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000AD80.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8265

On 9/2/2026 8:39 AM, Terry Bowman wrote:
> cxl_rch_get_aer_info() reads and clears both the correctable and
> uncorrectable AER status registers in a single pass. The previous
> severity decode returned after the first matching class, so when a
> correctable and an uncorrectable error were logged simultaneously the
> correctable event was cleared in hardware but never traced or handled.
> 
> Handle both classes independently: dispatch cxl_handle_cor_ras() when
> correctable status is set and cxl_do_recovery() when uncorrectable
> status is set. Remove the now-unused cxl_rch_get_aer_severity() helper
> and decode the uncorrectable severity inline.
> 
> Log the uncorrectable status unconditionally. __pci_print_aer() only
> logs it via ANFE recursion when aer_compute_anfe_status() is non-zero.
> A conditional skip could drop a fatal or non-ANFE record once the
> hardware status is cleared.
> 
> Reported-by: Sashiko <sashiko-bot@kernel.org>
> Link: https://lore.kernel.org/linux-cxl/20260803222923.517B11F00A3A@smtp.kernel.org/
> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
> 
> ---

LGTM:

Reviewed-by: Ben Cheatham <benjamin.cheatham@amd.com>
