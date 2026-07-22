Received: from mx0a-0002e601.pphosted.com (mx0a-0002e601.pphosted.com [148.163.150.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17037389459;
	Wed, 22 Jul 2026 04:42:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.150.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784695336; cv=fail; b=swBooTX70Zw203FZYB7P4aEWLY7VeU0bu48B2vn5Q+XQBl/ub3zEGIncbcXVHGq/FdSPWik6SIRZR7+pkz7+TFa92vfwkSvQ4A5guZaCUGk/zour6Tbg6kkgepFt/C77pcQejLgTwPq2YC7k/7ldKuEnkaHuJT8lO42MppOBS6k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784695336; c=relaxed/simple;
	bh=E0hpd/ZzASyNLHpxP2yhrr7Qd8Au8lSbJc5oDo1HjZE=;
	h=Message-ID:Date:MIME-Version:CC:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=B3yw0EBY/pGeGigC0lNu1fk+ZIV/tKoaIQQGcwIVrTvy1kInt6PuU2sTKVW3oqP+7kyxkWrOEKE9HGHtklG+g90fOoepC/kPRRWULxYibUqN5gCbPBzZukStsLkXuD+irN452bLGNm6Co31RCEmXe+aeYb7WOqih4DlvMdWFPNA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b=WKY8jeBj; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=WNG40siC; arc=fail smtp.client-ip=148.163.150.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b="WKY8jeBj";
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="WNG40siC"
Received: from pps.filterd (m0380145.ppops.net [127.0.0.1])
	by m0380145.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 66M1EqKV2369191;
	Tue, 21 Jul 2026 23:42:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	proofpoint-05-2026; bh=NOqA35cjN5v4HEhdb5FUASaRphDo/4ElJRhVBlLYR
	p8=; b=WKY8jeBjyAGnX2rDER1ewKS/9kOsYh0CUYQCqBY7bB6VKZxs2F7pX9yCF
	33qhsQB6VgpmnKVy56mIQB3glrxW0HllJLWq60fbVe3gPeZrzb+9+rBbktakrUme
	mTldv2QQc6VSbUgY6stNlYDSMlQdpQvdyyQO/aoYnUBYeJeGNbs1V1X0eArizJmN
	MTd0/4c+LMWqVfwQk4OImd0OGhIfqZWviYDj+cOEvR5b4gStqCVJZ9u+0tzJxAkS
	GQtnWSVQudQQPgwVq4my43BKen+TGROO95vlYF1smTchI2wE66ga3VbduphcPlpS
	kE6mS6CkevZme2GWB3J4weUMlDjog==
Received: from ph0pr06cu001.outbound.protection.outlook.com (mail-westus3azon11011059.outbound.protection.outlook.com [40.107.208.59])
	by m0380145.ppops.net (PPS) with ESMTPS id 4fjhyrsfup-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 21 Jul 2026 23:42:06 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IESSYXShpmZ+QSA/DKtyWP+gbggOxfno0RGHky60NuhPL8Unsgj/IAYjRnvM3z/h0UkuDzsFS9ShDjFIgau59Oo8YmvCoQCBY3l6+CMOGNxzBHTAAmgeb8QAumgwhBXdxIkQsknooonVGNFZAkgtGBr20SexAc/rM5IbfvWr4ItEjVIu874nFXJQ1N/ttEWfapR8LBWTNfFZ5YLXChruI8PRg3UsaI6SddNwi3RmMMeexO1rwMvWfyB0UVi69R6MK0ddrlSPfWeKXD3puSxuvKQkdyus5biB9lM0KQxL5cLmDJYqAgabpyyTpn7ZL2QOs/ucYZpPEaZ+hRNNLFTFvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NOqA35cjN5v4HEhdb5FUASaRphDo/4ElJRhVBlLYRp8=;
 b=uim5/aTTDnXlCAfHj4azTGlEfVC0o645rATqc75/8gbRAPmfJzy54dbZRzAuJwUqS7sbrTEOFQ0iFiJu07S4+ec+lsudAWlPT9EkjMCJ5dNZCiCD6efOrPoZFBoJyFjii+PtAmRHMv/Ebpvf9F/D80edLBidaRloX0q46SuTPBBlKgEnODOpShBPTDp4MmxmH+L2blZsofComcG9pUGNBO3k3RXXeMteSb+ouGipkey1R+LDJmg9V8eW+J28l1TG38JP48Yb6uLb+9mJma7eJveMvaYwgutXNjO2m8jwWWIx4LZgAWwI+AU3hgKyefKECj/r5wYmF0nZfGIoyxZ9XA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.194) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NOqA35cjN5v4HEhdb5FUASaRphDo/4ElJRhVBlLYRp8=;
 b=WNG40siCFL4RCDuiZmaFV62tsWvezxNBL8jpuZP+p1KtVy29D1RrTvMlOMtq172kCyH7x2UMWtipMklOQSfy4k7kQ9bnMh9+IHmg+UsP14PBIhJek2aiIixyE2wUHQM4yAdrSgydQo34yx0F1rZaOj//F4a/YWDiWniH+Qnhcm8=
Received: from SJ0PR13CA0097.namprd13.prod.outlook.com (2603:10b6:a03:2c5::12)
 by DSVPR10MB997961.namprd10.prod.outlook.com (2603:10b6:8:3ad::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.10; Wed, 22 Jul
 2026 04:42:05 +0000
Received: from CO1PEPF000066E6.namprd05.prod.outlook.com
 (2603:10b6:a03:2c5:cafe::2e) by SJ0PR13CA0097.outlook.office365.com
 (2603:10b6:a03:2c5::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.245.10 via Frontend Transport; Wed,
 22 Jul 2026 04:42:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.194; helo=lewvzet200.ext.ti.com; pr=C
Received: from lewvzet200.ext.ti.com (198.47.23.194) by
 CO1PEPF000066E6.mail.protection.outlook.com (10.167.249.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.245.5 via Frontend Transport; Wed, 22 Jul 2026 04:42:04 +0000
Received: from DLEE204.ent.ti.com (157.170.170.84) by lewvzet200.ext.ti.com
 (10.4.14.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Tue, 21 Jul
 2026 23:42:03 -0500
Received: from DLEE209.ent.ti.com (157.170.170.98) by DLEE204.ent.ti.com
 (157.170.170.84) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Tue, 21 Jul
 2026 23:42:03 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE209.ent.ti.com
 (157.170.170.98) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37 via Frontend
 Transport; Tue, 21 Jul 2026 23:42:03 -0500
Received: from [10.24.68.110] (uda0492258.dhcp.ti.com [10.24.68.110])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 66M4g0VJ2994440;
	Tue, 21 Jul 2026 23:42:00 -0500
Message-ID: <fa22b4e3-4df5-4088-b867-fa4f0030d1cf@ti.com>
Date: Wed, 22 Jul 2026 10:15:10 +0530
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
CC: <linux-pci@vger.kernel.org>, <bhelgaas@google.com>,
        <lpieralisi@kernel.org>, <kwilczynski@kernel.org>, <mani@kernel.org>,
        <vigneshr@ti.com>, <linux-omap@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <s-vadapalli@ti.com>
Subject: Re: [PATCH] PCI: j721e: Fix incorrect max_lanes for J7200
To: Takuma Fujiwara <t-fujiwara1@ti.com>
References: <20260721155743.3347659-1-t-fujiwara1@ti.com>
Content-Language: en-US
From: Siddharth Vadapalli <s-vadapalli@ti.com>
In-Reply-To: <20260721155743.3347659-1-t-fujiwara1@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000066E6:EE_|DSVPR10MB997961:EE_
X-MS-Office365-Filtering-Correlation-Id: 581c038f-72d8-470d-346e-08dee7ab942e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|23010399003|376014|1800799024|82310400026|56012099006|10067099003|6133799003|18002099003|22082099003|13003099007;
X-Microsoft-Antispam-Message-Info:
	WN3FAB/xhuYSpUxnemHKisytarwFi6y/3pXaWcdSoAzk5gCH5Y1o121oBeWEt8epNC59G2QfPyPJMB2LpVpBcs+x5N32K7ld1pkZtX3pqvpBLYop86KWHIM4aXM75sAyqdM/J4UDzEr0bFJ4hazaU+GAB3PdvEnLX1L3G4t1qNjmwgMkaOgCfkEobnOxkC+26zGt0Vtzl+rF0J1IHHuiZyOuBa30988NtBsjV6Qs4fLMBZk3AYG6AKJ3uGz3ZdQ74OpvVrxMCIehrJDVSd36RvmMPnPoeMKjqEsOnW5rSc/LPvhps92ZbnXQhsoutqNjjoSeaZy3+oem1t/DhaYGVhGzvDk7EM+afM3qYuj1BhjLIJIZPtt16s+PYy/WpoALuYyFa0O+H2gJhAw3xVk11dBM1klAkmidtVHLn8gWkTARPdYvaHoaRhMh/PROfNQz/x/16mkpKjcjYaHvPtgfOn4T756Q7joWfdNLRomo2VyBowBvpOupr2GtNhEfayMPwfIrJ2GVreq7BmrS4GTcRGbszJnibKeCKnmwGPuDOMpHHr1c6LYiC0oBBbo8KUeen/52xHOjI+wYHdhkISm1gBAG8vgd6z4Jfcmg5CjFuSbpZUbijkbB7FypMfDuzuhXsJHNwdc15FJoTU5M/c5h8uGJWw5s6gREf7Z3VBcLvBrX7Wx0gD/UusXnywOshRVRwWEE3sp6//aaVi8Fgxa9kg==
X-Forefront-Antispam-Report:
	CIP:198.47.23.194;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:lewvzet200.ext.ti.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(23010399003)(376014)(1800799024)(82310400026)(56012099006)(10067099003)(6133799003)(18002099003)(22082099003)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	TdCY/sRM6sJ2jCD0VqFVJfkB8FHctqm18HrP2ULEZ9sMMu0OGDb/AfNcBP1pgggFsjcPpaifTMD9K+2/10jGDOgyru7Q/6DGiDkDlaN8wwi/jmw9VNMGZb8FQuU6l+zENtbw0/NVtKJ9ZP+tiJfklyzfc6qJXKgG8ouHD0jyavPSiWLCdXJQf5NmMqBBhAw41IGQVsYIEHaZEEtjN5Rk+zR/+oLE5BwsXEI4tZA0IzXbTn4Dc4lPeqtHppgjpKrg8BW5piZ+RkYbSZHhuBKPn5ZHXgzMGxk6ey/LXZJxkKgeThLJ5DjIX/fUFOMsUqt/qdHSu0XTVdeoO2nx7l3pNFrSHrgxw04hLSUUrmBOSaggfbqHvAbS3XHjoZP07wQTxDz99eOUusqw1NWoMz0z0yWg+eSWodExTVdVUcsJRqwwaPeNsVzObNri7D2fNVnm
X-Exchange-RoutingPolicyChecked:
	eHjdQFbm8jVnXHeABdsJtZS7sMFxQ57qmdnyGZ6BpLO1kOrBw8/J+j5JqPfrTus3WOCWAW4YpNEKXuy4pItFndI4sthpY3wvKc62jFbi5wyagAv95Rcm4yQ4q5vzgUL5805bgIfqjIoYroJXwhxe2uLvSbnPTRZO1Fx1Rhl427eH3PGR9mekXtx8SOPgT4oAYdRVHRN0SOcNEm9YenXYdUVvb8aPYgxEHmDyZxbZsI0mxgi/+UUvUWzcw3nw1BA6GNPsboP0gkrr3A4H+Cj3TAoFwyP6mjFkOVQ1KXWIEphDhqWtUQLudWDreAMT6DsbhVKv1RmbP0RQZG4xSTaLVg==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2026 04:42:04.3394
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 581c038f-72d8-470d-346e-08dee7ab942e
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.23.194];Helo=[lewvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000066E6.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DSVPR10MB997961
X-Authority-Analysis: v=2.4 cv=AemB2XXG c=1 sm=1 tr=0 ts=6a604a1e cx=c_pps
 a=mhFp5NV/8UFWlOcEKiO6Eg==:117 a=WotqVVQAdb04rnGuttW3Kw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10
 a=s63m1ICgrNkA:10 a=V5UXEbMT0ywA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Z8NIEmU8O1QQgoT56wFK:22 a=gO1vWkAQAl3rybz1DQOp:22 a=sozttTNsAAAA:8
 a=kPIsrOBxfzZrCd9i_NkA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIyMDA0MCBTYWx0ZWRfX47BzZpj5JKMF
 DHUjv/dufguvxV0Pluf3dmxAWAUl3rRoVJ91TLHTlyDoPiZLyNBMi2+3qTJTYK28Eyaf7ymfA4E
 WxicOmb4lUXWmSdZUQ86m5Mvg5KB1Ham9P9Tdu13KlEhs70qMDkZJDrZDJulqMoTtXH0hXCz52E
 +LASD5yRfHjN2Xh//la7fms0+XawDdhUz1XBPo1g40pKsz+JbKs8m26M2YI0NCa6+ZEFFl0wYCp
 awl+NdkjBjMz5JEkbihSYAMHc+dU8HsTzByUtc0Ck1vqOp5fRQac+eXRQfMEuTANerUFF/qyKTm
 03wL1tGRjEpI7XPXiCS0vGfuWHe+EESArHgaFg9Bg5tVsQlgdygqqcGqXsim8mLZn6Qjvvp6dy6
 TKyq/dbHEtYlBAP80QHi39TnruCIFsOmU0aMrutXxSjO5/uQX+aax7lyofMyGv2H7aqnY9GPnPH
 bGchT9pyk+luSb+UUUg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIyMDA0MCBTYWx0ZWRfX07cEkDWcBSJj
 QMEY3KHvsEqGY/NpIfw8L1p8o6z2x4mRMZRYvvLmivPew9jM7Gzf5sGkhASu4MN2g5+NDYgfU80
 0J0xN5jv/XkSHjSzhWTZUz/57DHjnlc=
X-Proofpoint-ORIG-GUID: lWAQjtYgNP9CIofMI_m20iXE6A2AFXxW
X-Proofpoint-GUID: lWAQjtYgNP9CIofMI_m20iXE6A2AFXxW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-22_01,2026-07-21_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 adultscore=0 priorityscore=1501 suspectscore=0
 bulkscore=0 clxscore=1011 lowpriorityscore=0 spamscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607220040

On 21/07/26 21:27, Takuma Fujiwara wrote:
> The PCIe Controller in the J7200 SoC supports a 4-lane configuration.
> However, j7200_pcie_rc_data and j7200_pcie_ep_data incorrectly set
> .max_lanes = 2, limiting operation to fewer lanes than the hardware
> supports.
> 
> Set .max_lanes = 4 for both j7200_pcie_rc_data and j7200_pcie_ep_data to
> match the hardware capability.
> 
> See J7200 Technical Reference Manual (SPRUIU1D), section 12.2.3.1.1
> for further details: https://www.ti.com/lit/pdf/spruiu1d

Thank you for identifying and fixing this.

> 
> Fixes: 3ac7f14084f5 ("PCI: j721e: Add per platform maximum lane settings")
> Signed-off-by: Takuma Fujiwara <t-fujiwara1@ti.com>

Reviewed-by: Siddharth Vadapalli <s-vadapalli@ti.com>

> ---
>   drivers/pci/controller/cadence/pci-j721e.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pci/controller/cadence/pci-j721e.c b/drivers/pci/controller/cadence/pci-j721e.c
> index b29a35fbfb5f9..a029c4e9c05f6 100644
> --- a/drivers/pci/controller/cadence/pci-j721e.c
> +++ b/drivers/pci/controller/cadence/pci-j721e.c
> @@ -381,7 +381,7 @@ static const struct j721e_pcie_data j7200_pcie_rc_data = {
>   	.quirk_detect_quiet_flag = true,
>   	.linkdown_irq_regfield = J7200_LINK_DOWN,
>   	.byte_access_allowed = true,
> -	.max_lanes = 2,
> +	.max_lanes = 4,
>   };
>   
>   static const struct j721e_pcie_data j7200_pcie_ep_data = {
> @@ -389,7 +389,7 @@ static const struct j721e_pcie_data j7200_pcie_ep_data = {
>   	.quirk_detect_quiet_flag = true,
>   	.linkdown_irq_regfield = J7200_LINK_DOWN,
>   	.quirk_disable_flr = true,
> -	.max_lanes = 2,
> +	.max_lanes = 4,
>   };
>   
>   static const struct j721e_pcie_data am64_pcie_rc_data = {

Regards,
Siddharth.

