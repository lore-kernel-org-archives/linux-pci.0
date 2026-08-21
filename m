Received: from mx0b-0002e601.pphosted.com (mx0b-0002e601.pphosted.com [148.163.154.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E13946EC66;
	Fri, 21 Aug 2026 10:25:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.154.28
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787307954; cv=fail; b=IT6RS634qxyUa4gCgEgpcMZOz6YiN6vnojFnwQhnVBoyQ1zFWSjp2p/VhnEK828juNGysVZRVqGeY2LjrQNiyBqswsWJiXmNCmDXfvMXeXo0IOpdgL3iEG/fo9TbQkHq1RVUWRfHbyt1jH3bnR68jrEGk75JVE5X2E67KzpmfI4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787307954; c=relaxed/simple;
	bh=DGHK/tJDSkxZF2vYg+nD/RQUbXikZcgdX5PNhd5A9UY=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=nGSA5hAJmJEbS7a+HFtSYW4BTgdsjc5Nv8IULIbrII+X9jRKbI0+ripSb94G2w2ZQCKIPV8xophLH7aq6jNkjZPs4R1ZbBnkhQjaY7B0c4h4sz875kIAL/KjGn8FqDSrAsyStH18a4F4RVE/t44m6qw2KlYAR8zoCNJAxD1OoDQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b=pXHX4RQW; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=gpOCthsX; arc=fail smtp.client-ip=148.163.154.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b="pXHX4RQW";
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="gpOCthsX"
Received: from pps.filterd (m0374956.ppops.net [127.0.0.1])
	by mx0b-0002e601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67L9Kn2R3056099;
	Fri, 21 Aug 2026 05:25:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	proofpoint-05-2026; bh=NokXLevyOO89hSIdVGKMn//nz3ixLczYlpnsvkf1o
	dU=; b=pXHX4RQWW/koqc3sWUL7LypWhl+xet7YG1ehY7vqkA/FCIjORBZY6M7Mp
	hhC/qnxFiXmg1FnJXP/xNRRGIHV2BezUFZFEZuOmXs3PC/QFXXN2o6cUgsomBWT3
	EZ5S1/n78tQGDv1ucCSrLA5oNh/JyoEVHOwmYpKRqA3XBCvbAdCsG938p+buvymr
	efE4DlvfBVYcfmMrc7r8EDJcBV3RA4IPGmGc6gfxn8Mxnq13do+EEzJ5abjxTm/l
	P2NlnUdjthJU36+VKNOVTRiHqV27A3NgeCDYcMiVhsdsGXCYcCs0VkFbE7YQXUSJ
	aAsXPSo0IH+x12xt9+F5uGDetd3/w==
Received: from ph0pr06cu001.outbound.protection.outlook.com (mail-westus3azon11011067.outbound.protection.outlook.com [40.107.208.67])
	by mx0b-0002e601.pphosted.com (PPS) with ESMTPS id 4g6c9c2g5t-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 21 Aug 2026 05:25:30 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pukVfsyIEZyc4/jjI3b7s1TdmTBBO3zAxKrA1+A1fo3sFgn8jsGX/LD2BGclI/WfqSfUeWUgsubfnHrP0orHGqpUBZ9TPt+zn7WL5hfnBmv/2esyy/HOWLocBtVO/Oekey1bgAogWaLq6uwd9jBXs6v09wUDSmWiEMHARbhw7igwqiPJAFkhkdhuaG7PUcAltOteqtvFAwiACkRpui4kxQN8PrONQ0BRaIWdduOP0I1NQq37r24xsq1gak1cDcMbI6hcPE+e/2fArilgCTj9WvTrorUeLR1f7CVgWlBu1HkzZfXGEKwexsOOTDMAzT3HtSAM47DXfxWyLbbs5vQ5pA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NokXLevyOO89hSIdVGKMn//nz3ixLczYlpnsvkf1odU=;
 b=DyrsFddmmPJdF0H1GrsktVSizjI7Id9KYSnLruvL0Da99bLK3pdrq5EL6qwZ0yHtnBAIAEqoMG+RNP5tld/99yT/yfPd3bED02ZvT13KDCm5fe2JoGh1GNgh7MDxCuIoPUlJEIDd9NIJOtOFTDs0253Xm3QuFDYhf4kVGQMGyHFurQCuh7npWATPT7K+96vtDzHi/r8khQu+YYVMzfvmpR40SkdofgY2ZhR0kpLEZVBbxUStp5c5eVeXq3COcQe23tc9i852q6NiL+rLdgNekKz+kplX0KFm2JyoBWqrxf08v6pHApX0eSWXitiHz0Ee9Nno1wqsFDcq0PO6/D1/1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.195) smtp.rcpttodomain=intel.com smtp.mailfrom=ti.com; dmarc=pass
 (p=quarantine sp=none pct=100) action=none header.from=ti.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NokXLevyOO89hSIdVGKMn//nz3ixLczYlpnsvkf1odU=;
 b=gpOCthsXtCQNbEx+PhTc1+ZDsRhZO4r17UTdED3WSPDj55hnUpGPogxyUYabmXbfHCC16FPK2j/h2UOMuWIs/QK7v6v4QPy86CDxybnbE2b2eBx4POit/OgcE/7UpTSG1HTqug9I+iYwqwAMRp83AMjp6/u3sSKnIQhjZnNArJI=
Received: from BN0PR04CA0047.namprd04.prod.outlook.com (2603:10b6:408:e8::22)
 by LV8PR10MB7944.namprd10.prod.outlook.com (2603:10b6:408:208::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.8; Fri, 21 Aug
 2026 10:25:15 +0000
Received: from BN5PEPF00046989.namprd02.prod.outlook.com
 (2603:10b6:408:e8:cafe::8d) by BN0PR04CA0047.outlook.office365.com
 (2603:10b6:408:e8::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.339.11 via Frontend Transport; Fri,
 21 Aug 2026 10:25:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.195; helo=lewvzet201.ext.ti.com; pr=C
Received: from lewvzet201.ext.ti.com (198.47.23.195) by
 BN5PEPF00046989.mail.protection.outlook.com (10.167.245.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.3 via Frontend Transport; Fri, 21 Aug 2026 10:25:15 +0000
Received: from DLEE204.ent.ti.com (157.170.170.84) by lewvzet201.ext.ti.com
 (10.4.14.104) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 21 Aug
 2026 05:25:14 -0500
Received: from DLEE208.ent.ti.com (157.170.170.97) by DLEE204.ent.ti.com
 (157.170.170.84) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 21 Aug
 2026 05:25:14 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE208.ent.ti.com
 (157.170.170.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45 via Frontend
 Transport; Fri, 21 Aug 2026 05:25:14 -0500
Received: from [10.24.68.129] (a0507033-hp.dhcp.ti.com [10.24.68.129])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 67LAPBMV1916103;
	Fri, 21 Aug 2026 05:25:11 -0500
Message-ID: <0da45b1d-fce9-4291-9eb0-26cd9427a29d@ti.com>
Date: Fri, 21 Aug 2026 15:55:10 +0530
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] PCI: cadence: Fix enum type mismatch warning in LTSSM
 debugfs
To: Hans Zhang <18255117159@163.com>, <bhelgaas@google.com>,
        <lpieralisi@kernel.org>, <kwilczynski@kernel.org>, <mani@kernel.org>
CC: <robh@kernel.org>, <mpillai@cadence.com>, <s-vadapalli@ti.com>,
        <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        "kernel test
 robot" <lkp@intel.com>
References: <20260820232305.80596-1-18255117159@163.com>
Content-Language: en-US
From: Aksh Garg <a-garg7@ti.com>
In-Reply-To: <20260820232305.80596-1-18255117159@163.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN5PEPF00046989:EE_|LV8PR10MB7944:EE_
X-MS-Office365-Filtering-Correlation-Id: 2e6c8e29-8dd9-4c11-f3f9-08deff6e7db2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|1800799024|23010399003|82310400026|7416014|376014|56012099006|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	CZ1vCSBLZInsqsHSQ2KDrPvvxJ9Bp6KMR2z+Z53rYjtH3c9bD4ceXG9gm4u/O8Zvqvu3Ay+l69PpZareUfFRjLYiWSOb0jl6bGK9j9pJ3pL5X0QGRoLZ5tuvvs4FxMf/I9PRyKM+1w9f1A0rxR97FAlRABzxjFjXzi/rnhksxP2wJa2giMOxccmXq8SvM+8AXTrUUh2CVpbUJlbwvumgsGA/aNx/xQWZJpTUZjQcXPJa4tKl+pz2zAsJfaRvmwMwVwygf+wtoGd54FDDFZa3rp4T4EI0nrmwenEiiGtTq2AZ4mT844i2d+n7m9acUUUPmg7SU/0PT6CErEwlCHzTO7QrbKaToydD7HiwLhDmIwuLpI2MJLeAgwcKqoYnhSEwzdak7Ew/xyJCV8NADQbPLr2tYCR2ybwgLOWCsVun4qD7DfwxJIvTJJcVUxgrk4bj7FiWVIV/tBLJipVjsvzwKSmZ7iTe+Qu8PN6I85G71lvvNWP3Xk5lb80qwe7Miaz9FEmUGRor52iqIp/z6Nycw9ostwXdE5ZtgRux+8QlC7TcJsyg4laZwZd6QlYwNIkRMhLigozeYvWpneo5rog4gsb7ZtSkR3jhq0oxD7d6zqns4MnRnrjEqCxBkA0EwLqBaLdOUfxPF2B9EPo3e9Ct7S5nOHT5qFg6fngFsqpgoANnIcCqIf2o+NCgdAIKthpQHOGKUekP49Y5MI+z2Y+Bhw==
X-Forefront-Antispam-Report:
	CIP:198.47.23.195;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:lewvzet201.ext.ti.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(1800799024)(23010399003)(82310400026)(7416014)(376014)(56012099006)(10067099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	MfBAiw+xRK+osg4yu8n+75zjNhFRwwx7cKOXbzPyahYJVs/0uIjZgZtJVB0HDla/54eTaTPSLkfAZK5H7YX+uwZo5vLeTtCRsMVqHfCDBzxOh7Nd9lf2zkCuWb630yv6QxPt3Z35WoM6uOWg5YKWIvznAVZnYQYrvvapBJTs6GQScrnXdQhkcgNWn5RXozOxsWDSZ8N8GzxPeZQ8MGiglBUBkYIX85fts1R8SrVNN9lvFLRtRh5ilv+RdZcjHehWyfURLs05CiRHt1wFGWsChLskcuc3SK4kqZOSeOOpE/X+zT9w0wj+lD9IAP6Gwwx7qXgNe5JnzJnLFq9YPcBhHVIV5M7pMwcevMvuX1lLGtfaKj+aw17yGIamsldsOAtPtOYPWeLlXMfB3DnY6f3dWkiBhoNtHTKqrLzPIB9I0wFhWHGzMt2oOqCn8jxyYmAM
X-Exchange-RoutingPolicyChecked:
	eN30ufkdtcDCAsaLaDmbk6n2PdweUdRVNdKtUUsrwLpkK3hSW6XVV29y5QrpkRCXP3ixKYUCe/RW42BRXRYMZ40cRuEtR47E7eSONeSHW6ZtG2JNsqlwPBpNTUoVsFdu3HtnfAwYl7im7TW2ak8ZqBvPiDxy5+1l9Qs/dngtnjsNRiXEqk2r26KdIYBD0s+b9xCp08U+s4hJvfCYc2TtlWx/V05S3lKtiAzNMwDfBLRPwjR1liDilgCMwxlZzElztZv3WOGEdBxPz6FzUy4WIbk1L2qVyZqRkuTnI1g7GGTVU2Oxte4Zi5E9HSRJHQq+cumC4X+0J7oRhPyU5U0nAA==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2026 10:25:15.2326
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e6c8e29-8dd9-4c11-f3f9-08deff6e7db2
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.23.195];Helo=[lewvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN5PEPF00046989.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR10MB7944
X-Proofpoint-GUID: c3DizhMEupmUa9NcLw4oiB2cdxiOgULM
X-Proofpoint-Spam-Info: AW1haW4tMjYwODIxMDA3OCBTYWx0ZWRfX2B7FwBqFa4/G
 GOGdOkJRMbJITpVqMwE+IHNApW4WzS8fwHk0IXOHmu7elktc6JdbSuxhyDWzhPA/jkG+nBzIrDG
 zgYrUG7rlo10jxkrG2MesYpy8mruv9Y=
X-Authority-Analysis: v=2.4 cv=eqjvCIpX c=1 sm=1 tr=0 ts=6a88279a cx=c_pps
 a=hqbemJ87bpGpMWfnijcotQ==:117 a=f+v6EHfkeJbVwR46tk4DMg==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10
 a=s63m1ICgrNkA:10 a=V5UXEbMT0ywA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Z8NIEmU8O1QQgoT56wFK:22 a=jwouBfj2j3NM8CExmVVE:22 a=VwQbUJbxAAAA:8
 a=QyXUC8HyAAAA:8 a=Byx-y9mGAAAA:8 a=sozttTNsAAAA:8 a=DlKPeNhWaP9xIYIfZ00A:9
 a=QEXdDO2ut3YA:10 a=ZXulRonScM0A:10
X-Proofpoint-ORIG-GUID: c3DizhMEupmUa9NcLw4oiB2cdxiOgULM
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODIxMDA3OCBTYWx0ZWRfX6czDU7B+Df3j
 RjbyyEPgsSKYG5XJqiCnqKH00YPdcSYO4wUuqpRuEyBdbjdfb8DjkRkMhA9XGaLNiE+2GlDHztX
 KsB4toxhfd8qF7uQW9Lvf3o7la8NtUypqg38jRhfGYcgvcTboXn4DE8Sd3uCZFGWOQeF0S89OBN
 VtRQUx+GAfUabm9GcCJdl364ep/SAnjJaT0r4so3gCdGeTvw1PLyqGZAG4rtUdYm2xxGKcOHmfP
 dv69Ui1dKWgQ6MXnP3f/BYNmMvZ0BgoedUXZD9iFAp77EMaeLSgNTb4WpSNf2T9q0KhhpaCtaj6
 SQWO88+9rLojtMk4fI2DOi3WvIPWBVzu/6nuzCtmxJh97mMRn2NMVUPxcKOuFgTfubcmB1CBwf8
 +k9lV5XwXgvduaeQNLlAbPGmXtlaF9m5/yXNryTJvOWKX1kfhpWfzzVApHxHw9+wIjUv3O2koTl
 nFQC+/xef1uHJwuddlw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-21_03,2026-08-21_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 impostorscore=0 suspectscore=0 phishscore=0 spamscore=0
 adultscore=0 clxscore=1011 lowpriorityscore=0 bulkscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608210078



On 21/08/26 04:53, Hans Zhang wrote:
> Fix Clang -Wenum-compare-conditional warning by using a single u32
> variable to hold the LTSSM status value, replacing two separate enum
> variables of different types.
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202608201933.w2579mwx-lkp@intel.com/
> Fixes: d70e964dc099 ("PCI: cadence: Add LGA IP debugfs for LTSSM status")
> Signed-off-by: Hans Zhang <18255117159@163.com>

Reviewed-by: Aksh Garg <a-garg7@ti.com>

Regards,
Aksh Garg
