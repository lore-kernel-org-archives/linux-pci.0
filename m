Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013015.outbound.protection.outlook.com [40.93.196.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CC6AEADC;
	Mon, 23 Feb 2026 07:31:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771831863; cv=fail; b=Kp3ZVE73IOMrWtgJ9vsxTJVH8YPUNibiaeJKTsRlCnDpAy/eD+4Kqj3igx2tamG/DGR3cr7JXhnrDrz41zs03vk4WPlp4mh88VDFxGRhrabO/hbN7WKLUhkEJPMz9pwLkoO79yS64vDJqJDIeerlOjmfGSd3MfSj3wnmgQRtrSA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771831863; c=relaxed/simple;
	bh=VZEGRRWSYjJ7cxUFUPYYtON5JtDMFq4nA8smObtsYFY=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=QwSxjIAHwtHZdldlS23/L1CTTV+nw69dyavfGV0bBiWN04M9h0jE+ekd7SNHXg8WmaR+3IWANGTirmQQ0/PPLxCk7y5iuwc44mh9XDTKO+eM5uRDXCXaDUVJD9EcZlrEkeO10er/Ery3KHCg+ESXUvVzJoyCb7FeTOCRjfddIv4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=uUJvOuuV; arc=fail smtp.client-ip=40.93.196.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="uUJvOuuV"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aKWdZEaKYfDMkyCKZi+ZQXV7jkn/27TQQVkmyM+6shWqtwewVEp0wygG24ZEzefFYyCrW8oUffSHJIH2fDF8qhU6Zlenj6HQUCdZlUYJJTIkecQYvpApFV2tugLjVDhzygSyRkNWEwMIcI0JpOtEgtxr+JBiAse2PLTwaVYb9hPv2OfITdFDPeqosDSaR2NjAI5+DzfLnBJYVvTxlxqJfb0Ud8JcKSb1wAyecibFqMwzTvuyVOq11/ynwJ5+QMvaLmvb410ZJv3XSsRmlAPhkdZn6elIJnsBu89ptUDXWu3u99R/olwKsAeY5Cr2YmTQyq3dcgrFZReOVs3zpHgOEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2MUw6flSrEAg+rKxtZqcV8oreP988NH7i1MO3PxCyHo=;
 b=lCBXp2fVwgKrMfxFa0c2dsQd0/XVD75KuKQqQ6dLdtfDRxsxs3AmiVTq7ZInClVWg3csFC7+W/QVED09D8zgpEEbUtwQEDG9T9Q2kmA/hNf4bnxCH4+puEIrk+AO5EKaYyBbjzfMG7JBZruOCADvfv2eOsEc2p4+StVGKXplrCFNacGgt8CCz7xZgTPYB70PwDyazPN0WJbp/z0JHbzQ9jQP2bCK5CDCybfUOgJ+piyTu2jj/q8dJwMbgU6L0HpvTPVwQSEmzS2P9CmNlS/8GE7fJQ2QWzQspWUWuKrER1PbYNo4QvYdOeLdEYGxF7z2f6ncnlvLsPxm5l++BjMWaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.195) smtp.rcpttodomain=lists.infradead.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2MUw6flSrEAg+rKxtZqcV8oreP988NH7i1MO3PxCyHo=;
 b=uUJvOuuVLxN1kUbHOCG9hzWeH1Ykl5gra04seUxuWbjIP6kncWz0BM6oPpLRW/K6C/GTNe1UenHLiyputYCnPsrakuBxOsaP17tW5pO2pAu0ftMUxUrtpT1dM45IGbHlZsmR9BNedhi+6rLWefDn9dXVHaqC7ezSnEUeNnfOfGI=
Received: from BL0PR05CA0011.namprd05.prod.outlook.com (2603:10b6:208:91::21)
 by BLAPR10MB4946.namprd10.prod.outlook.com (2603:10b6:208:323::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.21; Mon, 23 Feb
 2026 07:30:59 +0000
Received: from BN3PEPF0000B074.namprd04.prod.outlook.com
 (2603:10b6:208:91:cafe::1c) by BL0PR05CA0011.outlook.office365.com
 (2603:10b6:208:91::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.21 via Frontend Transport; Mon,
 23 Feb 2026 07:30:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.195; helo=lewvzet201.ext.ti.com; pr=C
Received: from lewvzet201.ext.ti.com (198.47.23.195) by
 BN3PEPF0000B074.mail.protection.outlook.com (10.167.243.119) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.12 via Frontend Transport; Mon, 23 Feb 2026 07:30:59 +0000
Received: from DLEE205.ent.ti.com (157.170.170.85) by lewvzet201.ext.ti.com
 (10.4.14.104) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 23 Feb
 2026 01:30:59 -0600
Received: from DLEE202.ent.ti.com (157.170.170.77) by DLEE205.ent.ti.com
 (157.170.170.85) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 23 Feb
 2026 01:30:58 -0600
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE202.ent.ti.com
 (157.170.170.77) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Mon, 23 Feb 2026 01:30:58 -0600
Received: from [172.24.231.225] (a0507033-hp.dhcp.ti.com [172.24.231.225])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 61N7UtFE381313;
	Mon, 23 Feb 2026 01:30:56 -0600
Message-ID: <e096fab2-53ad-44e9-9185-496ff763d3ec@ti.com>
Date: Mon, 23 Feb 2026 13:00:54 +0530
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 2/4] PCI/DOE: Move common definitions to the header
 file
To: Lukas Wunner <lukas@wunner.de>
CC: <linux-pci@vger.kernel.org>, <linux-doc@vger.kernel.org>,
	<bhelgaas@google.com>, <corbet@lwn.net>, <cassel@kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<s-vadapalli@ti.com>, <danishanwar@ti.com>, <srk@ti.com>
References: <20260213123603.420941-1-a-garg7@ti.com>
 <20260213123603.420941-3-a-garg7@ti.com> <aZr-RMZlgO0eEM8n@wunner.de>
Content-Language: en-US
From: Aksh Garg <a-garg7@ti.com>
In-Reply-To: <aZr-RMZlgO0eEM8n@wunner.de>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B074:EE_|BLAPR10MB4946:EE_
X-MS-Office365-Filtering-Correlation-Id: d321d2ae-9a68-48e3-b48e-08de72ad7da4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700013|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?OFJ0U1RIeVlwUG5qR2kyU1orQy9UN2U5eFN2a014SkQydXN6emx4ak02TDQz?=
 =?utf-8?B?aTNIMXhJeGZCcjlsVnMvNkRMQWdDQ1djWWI2aWNUS1IyOXMwdHRLTGp6dXJN?=
 =?utf-8?B?bEl4YllPS3o4T0dQQ1ZtTkVHY0pUZytBa0c0UW5MZEpjRDJrSGNNUGY4Z3h2?=
 =?utf-8?B?MkgxZzBEMzBkMzFZMjFJZHB5ZUp0ZW5oTUtQNTBJQzYzb0Y0KzVvOUZWVWJQ?=
 =?utf-8?B?c1pxWWtRbEpndDhsTWtzb0g3R2REWDJvR1Vwa0ZUSVNndklPUHdPSlluZnVK?=
 =?utf-8?B?MWZGeWhQcXI5dkxLc1M4L2xobUNDdGlQZHJnZDhmRTJqdE94Nm4xWkVNVkhR?=
 =?utf-8?B?Z0hTSk4vWTQrellJKzdpdjdwM3ZjN3JJc0Y3TGV4cllZTnJSQ0RrOWxBWFVS?=
 =?utf-8?B?TnpEdEtwY2xRVEdlSTdkZlMxV2daODh0MmErMTl5SUZ4eXg4SlhxZGNlb1ZR?=
 =?utf-8?B?V2EzbXZlcHJHOWJsckRLcW42YStHRUNvREZoMFRzTXlRSHZydmhlQjhyWm9H?=
 =?utf-8?B?c3N3c2xxOHloZm9DNllmcTJwSm9MeHBuZGFJQk0vTDZvVWJtdDE1NUJBR2JG?=
 =?utf-8?B?ZllhYlR1ZnY1WmVscnhZTGVTK2had0RpQS9BbHFERnZVQWdoSTd1MmlpdW8w?=
 =?utf-8?B?WGlvUHQ1Mk1TTExjMTNVTXlDbXBleTVJL0lCSVVLZjA2WFNMc0NzUmgrQmFC?=
 =?utf-8?B?K2lJbVZ6YWdOTmlCMGkzK3lVMVZ1dHk1Q2J5YTF4ZmVFN3g0NUd1Y2tqY29h?=
 =?utf-8?B?Ny93N1FUUk9zb3VhTkJJQTNoQWl0U3R3UWE3Q2JVS3pGZXZGejZScktEWDZ1?=
 =?utf-8?B?TjltSCtJdWJQVjJ6dzkyZ3lGRVJYUjF2bjdEMW9IOEg4NzY1b0VOWnM1Wk9a?=
 =?utf-8?B?azIrelVyMnNVRHhtamg3c0xNcUthTXQzcWhtajE0MTR4ekZheGxZU1lqcjhK?=
 =?utf-8?B?WllNdnBTL1JBUkFJK0w5T3NIclpZSUNkc0NpUngxWXNqVlhSTC9iU3lHSC94?=
 =?utf-8?B?VVJnZlIvWFFOTkRnUk1jSWxRMDZzNXQzeGFpMUtLTUFPV1hySk8zV1g1MVUx?=
 =?utf-8?B?VE5OQUhka29VMFNvVFVOV1ZIY0VQNHFCNmRGYUZOczJqWGpxVlBuRFhZT0VX?=
 =?utf-8?B?TDRQbkttVC9Ia2tKS21pdHRlT1podlVTNkhLeUt5TCtCQTl5Ylpsa1FmWUNW?=
 =?utf-8?B?TTVoYW1CVlJqM3YvNTB6a0NMbWI0VE9iRk9iaTRhbE53K1ZOdW5SQk1rUWVM?=
 =?utf-8?B?RkdOZkFmV09NRWJ1TW5LOHJ6dkQ3Tld4NXJxMFdGNHdBek5WbkhWN0kzTmRD?=
 =?utf-8?B?OUl6M3lZS1BoNDdMaTBVMHVhY0l5UjlxK1hoYXlHR1FyS3hZU2gwVk1ITzJB?=
 =?utf-8?B?djlhY0RyRE1GZ2k2K1BRL3BlV3JIbGlFYzBLcTkvSDdpeDQ1TnVVMm5QUk96?=
 =?utf-8?B?VFd6ZVl0dzZ5Ri9oVWJnZUgwUDN2d09yM1diQzRyQ2I4aFgxaEliNmVSWTFs?=
 =?utf-8?B?c0loMHV4NkN4RnArd1hDN3BnMmNuVHJUdkU0ZjE1cmxzQjdCazhzODZRWVRI?=
 =?utf-8?B?eXAweFh3YlRpOWFPcngzcC9WS2xWUFVjOVZ4MVFhZFZwVHlLNVo3RjdwVlU5?=
 =?utf-8?B?RnBONVVvMTYwVG5qL0JISXkzaTBiMVJmb2FnalM5T2UvNzVWWE9NUFc1UTNl?=
 =?utf-8?B?clkrWEdjWUpVTUN4a1p0WmkzN3d2cVpJb0E5T29qbXQwRGNvOFdoMlJwRHlp?=
 =?utf-8?B?K3lxWEFuSmlYbkJTN3J2VkpjMWtHUGRnZGdNaGRGL1dpQUhkV1lvemk3dDZT?=
 =?utf-8?B?MytNbUxrYXhxcmxYbGlMYjJpU3AzSXdGZi9DQXNwNVMzU3VCQ0s2OFR1bVpF?=
 =?utf-8?B?cXNOS3JxQWJrTm9SazlzbENZbDVLM1M3ZTU0K3ZFM0lsN0oxRm9YcHI4NW1C?=
 =?utf-8?B?elRIdEJSemoyOFU0bncwNkFqME9jbGozb2ZUSE43TkFORmtHOER6U0NWRmY0?=
 =?utf-8?B?Q29PUjd1MWtINmRRSlhwQzhNZkdCTWlzOFErZlhlQ25xUHZqZzl2eGVZdnQv?=
 =?utf-8?B?amF5WmpkeVRwbUVUVVQ5aFJlSEFYb0FycDZoSHVMQUxUZ00yYTBOazR2ODAr?=
 =?utf-8?B?TW5RNXV1MWdETGtWVGlMUW9aaUVOVzYwYXM4ZkFvdE9YWjhHYmF3dlVjVjNB?=
 =?utf-8?B?WVlVcVB2WHRPRjRWa2Faa3hwWVdleko3K1lXQmhBOUxSUDlNc3JXOVpGYXJ3?=
 =?utf-8?B?bnZMaHFCNlhKMHFzUEdJbmlibHd3PT0=?=
X-Forefront-Antispam-Report:
	CIP:198.47.23.195;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:lewvzet201.ext.ti.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	j/xzeLk8c0WV0DVKHNE20QjnaCcToKP2lCe6t0STazQ+lBNnHi2DFtHROASavab1s+K3dh/n2ArWREQuaU/q+/NhiNW6T6wFmX4A8Jpblc1sJUTvStWXlfbVUjs6YwKpwwxnOKITvW6G85E1IyzIKA4XR59yrxNCuQY5xUcPPPSb5K2mdjpEsvFVMW2iu95LEWOJ8eRiJmdqp+4PNr5qRBiEXIz1zxa6iMKpSoLdAHcm6xTaf7hOsG6N2hMwdlvH+45oRCwkp5Ag2w/Ee8lOCSyCpX5gOeOPaHdcECtf7U+5fJtqe+tziqOkiWF3n2OEy8V0sNR5/aB2QtWXmkE8lvA8ylOF/jzxQMwZn0wVIRkcmnhCXHsQeTWehn3JpZi4mJBttbRY+gZPPAAj+gRlQtchFOb/BkeD+zZsqPJkipK5i6I+Ps8UgANG90dHJMF9
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Feb 2026 07:30:59.4863
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d321d2ae-9a68-48e3-b48e-08de72ad7da4
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.23.195];Helo=[lewvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B074.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB4946

Hi Lukas,

On 22/02/26 18:31, Lukas Wunner wrote:
> On Fri, Feb 13, 2026 at 06:06:01PM +0530, Aksh Garg wrote:
>> Move common macros and structures from drivers/pci/doe.c to
>> include/linux/pci-doe.h to allow reuse across root complex and
>> endpoint DOE implementations.
> 
> Please use drivers/pci/pci.h for declarations that need not be visible
> outside the PCI core.
> 
> There are users of pci_doe() & pci_find_doe_mailbox() outside the
> PCI core, that's the (only) reason the declarations are in
> include/linux/pci-doe.h.
> 

Thank you for the feedback. I will follow this convention in the future
patch series.

>> Also add CONFIG_PCI_DOE guards around the root complex DOE APIs to
>> maintain proper conditional compilation.
> 
> It's not clear to me why these empty inlines are needed, please drop
> them or provide an explanation in the commit message.

I added the guards for the users who might not 'select PCI_DOE' in their
config. I missed the fact that all the current users of these functions
have 'select PCI_DOE' in their config, hence these inlines would not be
required and can be dropped.

Regards,
Aksh Garg

> 
> Thanks,
> 
> Lukas

