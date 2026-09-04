Received: from mx0a-0002e601.pphosted.com (mx0a-0002e601.pphosted.com [148.163.150.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2C3540F742;
	Fri,  4 Sep 2026 05:02:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.150.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788498174; cv=fail; b=jrlBGm+Htq/Yd7xJqC2dCqsboMlRNQUyv4FloZ1vV8sntrDLSHY9L38MfxcfOaU/5gmHRXFDj22ChxSePjElkgC/SCUnjvALTzgvUeGAf7LayBj5T1RTav4XR0BUvCpRZHgSDctA2OgRjrBOCSE3881Y8S4ePBNs7UxOqVLnpLw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788498174; c=relaxed/simple;
	bh=vWX0rUOPmbeShUrrKPZXV3rlQuAiWnirb8mo8afZxO0=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=rbFHtzE2uiyN2pJqXiwEonetULu5f14H5d4Wg5ZYSX1jR5cUYRYa8qo/XodhskFC2JQxMraSoUlhHPMJeIOT+IpfSJAEQFwSehkb6c5QNoqvbA493yvUHCkiOl4Ba/8RvU/SYF6otE0EqktacBG+WSLax6BhrPEM50MbbpIjhXE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b=SWjr1Uhx; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=dGeMJFXq; arc=fail smtp.client-ip=148.163.150.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b="SWjr1Uhx";
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="dGeMJFXq"
Received: from pps.filterd (m0380145.ppops.net [127.0.0.1])
	by m0380145.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 6842sPQ52586766;
	Fri, 4 Sep 2026 00:02:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	proofpoint-05-2026; bh=dOyv+KC3xWrq0w8WGkkvbKEhj5WIJPN2fjEbQUyW3
	H8=; b=SWjr1Uhxxg8+oiY8UPeQWT/LEXiPUs5tCKhBaRP3Jc4Bwi4DcQK3FWYSK
	0pQduS4vCmgf/VY6I7ggdpI0glSIAPVCtFL11+Nh8QR+vmLYwYZBq535pnBdhVUR
	Ggy8efPyREjhr1OJzKgeJOkf0nzjFFGYEuAloCRCxNsl3MJDqOvSnuA5gaFplYxd
	jeQWaCPv0LK2qS7h4OdNMdD5Cbgd6FdwfCXgdc3LpU3qe/2g0U/g3xAFZ/XoW2vf
	6M5nTzQOu/TB7hs+hKVQUyuvIOvWsv1m1jua7y2rPKuCLI3O++FI8Yu0BVesDzKb
	z08x2Mvk0AM0vLfuU2Xq4Ut+IVd8g==
Received: from sj2pr03cu001.outbound.protection.outlook.com (mail-westusazon11012058.outbound.protection.outlook.com [52.101.43.58])
	by m0380145.ppops.net (PPS) with ESMTPS id 4gfk4xsc85-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 04 Sep 2026 00:02:24 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Xx6LUwwrlenUxYtXeeg7jXjeNvC8WVsO+h+M0MvJLmzfXjPfWP3lWSfv13Yte2r4e1i9Jmvj9yHkOEZEx0yxnohqnyxIdNPQFPru2+SDXJw6QJCwBUA7WXtYb9UmrCHvI+GFXsWKr6Yvs2WbMDUusgiRC6HRYiuHdMSBHx5Gca/bHahljgDxAKjhID31139pbZnaZK1W5W9pdMzhu3vBqGRUgyvjT5+PQcjDf9I47UZqJvBfnLTPbnQfqScdtk2w+xJRUxBvHXXACceCXAUnwEcT0E4YV4FH7faQRcrb4gFv93XmYSRGBKhgwndGWBNG/Lh5ozVJYuTultsSBnONWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dOyv+KC3xWrq0w8WGkkvbKEhj5WIJPN2fjEbQUyW3H8=;
 b=THmCCBf25067DWE/vZwhWC7kIq47WVenlH0QjAZl2tbJrA20dc5J+1EJ46wy33Cdt2sEwtgftxh2oqz0l9CCZO8tB2C9QC402z4dtktgeOict8QKW9KYq1pFecHbbVnTfnVg4gEQghla2rXBu7MOknqwf4e0FHumEOeZx9JEVJPqtRUP1N16O7XBPMm8VxfbRVBH4LYejgYhEl09UCwns4EbusyLmMG7r7dIs2aTRRTHZy28TQashwQiDqSDU+QiEnipiAEozai+7WduqC4/kq7R4rmJQcTPaSvQlw9vowqf2au5jJPlHg8hziXuwISJ/KQOzEqyu0HDuUuMAKG9bQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.194) smtp.rcpttodomain=google.com smtp.mailfrom=ti.com; dmarc=pass
 (p=quarantine sp=none pct=100) action=none header.from=ti.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dOyv+KC3xWrq0w8WGkkvbKEhj5WIJPN2fjEbQUyW3H8=;
 b=dGeMJFXqwYxldc0ujiyrXrGP9lLv/4I6QGqafEHXKahO9GUKNkEFpbuEU7/QIDe0eW5r1kEhPcucnx+Y7xVl3+FCsxkslxtC36nW4WaLAGWyzrocicbBfkm5UlkKgzSa30QHskkH8eYSTY9N4vjl0DrYn/j4rEBOrbiBF74XnKw=
Received: from BN1PR12CA0014.namprd12.prod.outlook.com (2603:10b6:408:e1::19)
 by IA0PR10MB7604.namprd10.prod.outlook.com (2603:10b6:208:48f::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.10; Fri, 4 Sep
 2026 05:02:17 +0000
Received: from BN3PEPF0000B372.namprd21.prod.outlook.com
 (2603:10b6:408:e1:cafe::16) by BN1PR12CA0014.outlook.office365.com
 (2603:10b6:408:e1::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.12 via Frontend Transport; Fri, 4
 Sep 2026 05:02:17 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 198.47.23.194) smtp.mailfrom=ti.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.194; helo=lewvzet200.ext.ti.com; pr=C
Received: from lewvzet200.ext.ti.com (198.47.23.194) by
 BN3PEPF0000B372.mail.protection.outlook.com (10.167.243.169) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.406.1 via Frontend Transport; Fri, 4 Sep 2026 05:02:17 +0000
Received: from DLEE211.ent.ti.com (157.170.170.113) by lewvzet200.ext.ti.com
 (10.4.14.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 4 Sep
 2026 00:02:02 -0500
Received: from DLEE210.ent.ti.com (157.170.170.112) by DLEE211.ent.ti.com
 (157.170.170.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 4 Sep
 2026 00:02:02 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE210.ent.ti.com
 (157.170.170.112) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45 via Frontend
 Transport; Fri, 4 Sep 2026 00:02:02 -0500
Received: from [10.24.68.129] (a0507033-hp.dhcp.ti.com [10.24.68.129])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 68451uYI3871532;
	Fri, 4 Sep 2026 00:01:57 -0500
Message-ID: <6930c5ad-c2de-4cf2-b96e-61079f07e455@ti.com>
Date: Fri, 4 Sep 2026 10:31:55 +0530
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 16/21] lib: rspdm: Support SPDM negotiate_algorithms
To: <alistair23@gmail.com>, <linux-pci@vger.kernel.org>,
        <Jonathan.Cameron@huawei.com>, <djbw@kernel.org>,
        <rust-for-linux@vger.kernel.org>, <lukas@wunner.de>,
        <alistair@alistair23.me>, <jic23@kernel.org>,
        <linux-cxl@vger.kernel.org>, <bhelgaas@google.com>,
        <akpm@linux-foundation.org>, <linux-kernel@vger.kernel.org>
CC: <gary@garyguo.net>, <ojeda@kernel.org>, <benno.lossin@proton.me>,
        <a.hindborg@kernel.org>, <wilfred.mallawa@wdc.com>,
        <tmgross@umich.edu>, <boqun.feng@gmail.com>,
        <bjorn3_gh@protonmail.com>, <alex.gaynor@gmail.com>,
        <aliceryhl@google.com>
References: <20260901010347.2614656-1-alistair.francis@wdc.com>
 <20260901010347.2614656-17-alistair.francis@wdc.com>
Content-Language: en-US
From: Aksh Garg <a-garg7@ti.com>
In-Reply-To: <20260901010347.2614656-17-alistair.francis@wdc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B372:EE_|IA0PR10MB7604:EE_
X-MS-Office365-Filtering-Correlation-Id: ec2a35b7-8621-4cc3-75f2-08df0a41b158
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|23010399003|82310400026|36860700016|18002099003|10067099003|56012099006|4143699003|6133799003|22082099003|921020;
X-Microsoft-Antispam-Message-Info:
	A1WffLDWpANrbSjLnjWj97YguJV4ecyOEaq326rm+kta4avUjbQV33EZsE0MLyKKAbGQJwRTBELKASht1HsuDKqxj/zfviuWaRffFLyc17EGHnm7WfEqHsjZpC0Q8cpZyMo6a53gpU/CgulzppzyTSb+JYbrLMqivTEWd4vamzv+Cb5M0exfPmeC2TKlfJMVirJlpbifJ5aWlRVTOS9f4ehDOboGhfbys4kqAPWqOrgGIvYDhMa7BvnOYNBQ6cqGS98SrqI0veEkjx6ztPSnwi7dYIYo/Cx50J6m1APRuLa1IktWQUvouMEQ9slJ9z2QM6RCkLic+pFqG56q+1O2dBsC/vkJgixXLe5r4TSAjHIB5v83PBuWl6IJpkoZw9Y4Tow1XQN33iFZ8B1QgqrzQJMQNMsP83TgM7CCNgpJ4Iqq3g4EEfC4WriJRy8KHGhFhWczsi8CtcM3+9hHuzV9u2tCiT8KOLZd6bpVS8Aq2eeH2ly4ANzRZzP8y4dIqLzdUh9HWdfUqb8VpPzHowCdlRGeB+r88oXrH43WV5HgJq9LkZF1VBaPDW1wsFKkFfIprrErwrYbDRhmX//kqjeZvAbS4+6AnnB6n9L5Njsc4cji++k2EgADdMkYM3RXAwkyGQSMp7rzu1JrvKIgITHm8FId4kZswti3xoqR6cuWRzQmHENnjB8ZbQRDODbk9vxLQ9/qMf3iGPe6YYgnaItW5+8yY7f+2vYhwMBlSMLcdUF6PBXrBtP85gSnXNsmoHlb
X-Forefront-Antispam-Report:
	CIP:198.47.23.194;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:lewvzet200.ext.ti.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(23010399003)(82310400026)(36860700016)(18002099003)(10067099003)(56012099006)(4143699003)(6133799003)(22082099003)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	uKKMYpNG0sB7RGYPvDSqDDtyJzPmx4LR9/mmwmXpCRJWr1X8uER4LB5kK06o7jQCHoFdy2S88EGSUTHTXhkE+v32BGAMFilUnJhxjVykH7wjskjmGNpiD6sJI3qBSAIuis0PdKaXjk1izh7cxCRLszYkDOoVmHEIqtQo7Kk1Dc4PEQH+PacN5DZSty1rYSplxo9Y5nfsWzw1IJwObMXlrSN+xVfU/2EzacSCcOwgzLEWHXbSeHlF687RMovQSUi7zjFf17QlTwdm0TFbpRr+3WCMaSZnG7WK18n2ovmsu19IQ1tu1WJ84epNMlI+fiorpCbpx7dwFX/c3+efsr8vMzclV7k2HSiCftdeIF8Qfv5AUzwqU6jrQH3W0c5qfZIrK9pk8X/vRQbr7m8tMwA7UO3dbM8/nhXrHwoh9iT0GB8rlIEBXReh3qRhHwk0uOGZ
X-Exchange-RoutingPolicyChecked:
	M3HuarPLyj1/qwJv/C0DTn67C513TvBIznpkF4oNPFjakcc0RwHNwYuVho8rJ9veua1AtMu7ZdADC99thkflDR+H/izmT/lU1wvdUDKueqv+gxNsfEtv35vy/ftu8JWPDEq+VSPj9r0B6XbcJUR8VAoA9cTdRDoeDUGcsp4/GjjQa6VFh4Muye2oJHkF0gk97Rv3QY2ifD0+3gzbdb6Dya8ZbEK1S20MTfbl32C8XVAkqD7i7a3Pye+jcg9SQbn5qb6+/eTkughVT3QesSJoLRPKbqa4aR6VZPU3ZxC7+h+X/ucV9gr3T3eBs48GW/xKSM9sHCfHAxNFPgj2t4DV2Q==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2026 05:02:17.3202
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ec2a35b7-8621-4cc3-75f2-08df0a41b158
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.23.194];Helo=[lewvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B372.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR10MB7604
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA0MDA0MyBTYWx0ZWRfX17UxH6P4ZCJk
 bOf0Z3K957Ta/r+y1Qjvdh81Ft4fosmrKJXevTO8lCJ+FaUi+L24XOzFCVo2Um+xD7JmbPbOWzY
 KHDnQI88EkWfcZ9vKH2pllq5ouqlUbQ=
X-Authority-Analysis: v=2.4 cv=TKd1jVla c=1 sm=1 tr=0 ts=6a9a50e0 cx=c_pps
 a=8P36fUQdMjs6HQlwNDQNwg==:117 a=WotqVVQAdb04rnGuttW3Kw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10
 a=s63m1ICgrNkA:10 a=V5UXEbMT0ywA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Z8NIEmU8O1QQgoT56wFK:22 a=gO1vWkAQAl3rybz1DQOp:22 a=pGLkceISAAAA:8
 a=06fhUilGo_L1Qh5vMrgA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: KTcx-3WqzsMlukKl6CpLqYGJ4Gm0XvFN
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA0MDA0MyBTYWx0ZWRfX1xWJ8BsNFy9L
 lCdNeW86ptAJ4qh2Kd7W+SzLHu1OX8LarR7tT735S1ZprEXbQd4kVnz6c+5bm/b+Rdotz891MMP
 V7vYeN42HCeISmd8V+XEl9v3mDHpoX5r0AVx6Nfluf8Lp4uZI1XceUBirvUk3Kz3Ps3SBjpXhZv
 xrnPko/6LO59skrNuHQBpqxS6OQwLGAkNfJ+fp1Iv539/yDIKWchup7rikPE6ywfKL4gPTvuOEh
 pAR1jq08tnSJfQaN8Jk034+TjRWY6x0jIrlrKFxjYwNfSHU0M1HYThpPKL5VksYz/cF/poQFNlW
 ddhu0Nixu83IBw1RNzUjXl30tqrH0nbULCJfjTKcyUd2JfJnI4FvnumS9qDnnRneaFFG87Su0eE
 RCAlOaIHYbpG7Ibh+/lcktvG3J6Y9jtCv9XvZhnCVcU5lXwY9tWIsx8Sc3FH/tZDdRBPomG0pA7
 scxuyCW8b580CMcqJVg==
X-Proofpoint-ORIG-GUID: KTcx-3WqzsMlukKl6CpLqYGJ4Gm0XvFN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-04_01,2026-09-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 impostorscore=0 spamscore=0 bulkscore=0
 suspectscore=0 clxscore=1011 phishscore=0 lowpriorityscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2609040043



On 01/09/26 06:33, alistair23@gmail.com wrote:
> From: Alistair Francis <alistair@alistair23.me>
> 
> Support the NEGOTIATE_ALGORITHMS SPDM command.
> 
> Signed-off-by: Alistair Francis <alistair@alistair23.me>
> ---
>   lib/rspdm/consts.rs    |  56 +++++++++-
>   lib/rspdm/lib.rs       |   9 +-
>   lib/rspdm/state.rs     | 243 ++++++++++++++++++++++++++++++++++++++++-
>   lib/rspdm/validator.rs | 110 ++++++++++++++++++-
>   4 files changed, 412 insertions(+), 6 deletions(-)

[...]

> +
> +    pub(crate) fn negotiate_algs(&mut self) -> Result<(), Error> {
> +        let mut request = NegotiateAlgsReq::default();
> +        request.version = self.version;
> +
> +        if self.version >= SPDM_VER_12 && (self.rsp_caps & SPDM_KEY_EX_CAP) == SPDM_KEY_EX_CAP {
> +            request.other_params_support = SPDM_OPAQUE_DATA_FMT_GENERAL;
> +        }
> +
> +        let req_sz = core::mem::size_of::<NegotiateAlgsReq>();
> +        let rsp_sz = core::mem::size_of::<NegotiateAlgsRsp>();
> +
> +        request.length = (req_sz as u16).to_le();
> +
> +        // SAFETY: `request` is repr(C) and packed, so we can convert it to a slice
> +        let request_buf = unsafe { from_raw_parts_mut(&mut request as *mut _ as *mut u8, req_sz) };
> +
> +        let mut response_vec: KVec<u8> = KVec::from_elem(0u8, rsp_sz, GFP_KERNEL)?;
> +
> +        let rc = self.spdm_exchange(request_buf, response_vec.as_mut_slice())? as usize;
> +
> +        // The transport must report a length within the buffer we provided.
> +        if rc > response_vec.len() {
> +            pr_err!("Overflowed capabilities response\n");
> +            return Err(EIO);
> +        }
> +        response_vec.truncate(rc);
> +
> +        let response: &NegotiateAlgsRsp = Untrusted::new(response_vec.as_slice()).validate()?;
> +
> +        self.base_asym_alg = u32::from_le(response.base_asym_sel);
> +        self.base_hash_alg = u32::from_le(response.base_hash_sel);
> +        self.meas_hash_alg = u32::from_le(response.measurement_hash_algo);
> +
> +        if self.base_asym_alg & SPDM_ASYM_ALGOS == 0 || self.base_hash_alg & SPDM_HASH_ALGOS == 0 {
> +            pr_err!("No common supported algorithms\n");
> +            return Err(EPROTO);
> +        }
> +
> +        // /* Responder shall select exactly 1 alg (SPDM 1.0.0 table 14) */
> +        if self.base_asym_alg.count_ones() != 1
> +            || self.base_hash_alg.count_ones() != 1
> +            || self.meas_hash_alg.count_ones() != 1

Hi Alistair,

As per the SPDM spec v1.4.0 Table 25 (ALGORITHMS response message
format), description of the field 'MeasurementHashAlgo' states "If the
Responder supports measurements (MEAS_CAP=01b or MEAS_CAP=10b in its
CAPABILITIES response) and if MeasurementSpecificationSel is non-zero,
then exactly one bit in this bit field shall be set. Otherwise, the
Responder shall set this field to 0".

Currently, the code unconditionally checks for exactly one bit. If a
responder does not support measurements, it will legitimately set this
field to 0, which causes the current check to incorrectly fail.

A change somewhat similar to the diff shown below might help here:


              return Err(EPROTO);
          }

+        let meas_hash_valid = if self.rsp_caps & SPDM_MEAS_CAP != 0
+            && response.measurement_specification_sel != 0
+        {
+            self.meas_hash_alg.count_ones() == 1
+        } else {
+            self.meas_hash_alg == 0
+        };
+
          // /* Responder shall select exactly 1 alg (SPDM 1.0.0 table 
14) */
          if self.base_asym_alg.count_ones() != 1
              || self.base_hash_alg.count_ones() != 1
-            || self.meas_hash_alg.count_ones() != 1
+            || !meas_hash_valid
              || response.ext_asym_sel_count != 0
              || response.ext_hash_sel_count != 0
              || response.param1 > request.param1

Regards,
Aksh Garg

> +            || response.ext_asym_sel_count != 0
> +            || response.ext_hash_sel_count != 0
> +            || response.param1 > request.param1
> +            || response.other_params_sel != request.other_params_support
> +        {
> +            pr_err!("Malformed algorithms response\n");
> +            return Err(EPROTO);
> +        }
> +
> +        self.update_response_algs()?;
> +
> +        Ok(())
> +    }
