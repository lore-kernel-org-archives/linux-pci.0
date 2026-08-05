Received: from mx0a-0002e601.pphosted.com (mx0a-0002e601.pphosted.com [148.163.150.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1660422531;
	Wed,  5 Aug 2026 10:55:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.150.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785927305; cv=fail; b=J58ddrNegvnkIEtI2dWREl+Hx9CrWBG+j9KvVGe3ifg/2i2qYcTMPKxDf/HAm+KpsGKbzKb3WyCEFJhvROU2AByPeRw/3o0QLuZU+avM2rG5LiSv7YYFmsYKJocCua5/MbZpnF2U3dozFc0hv67xEGlM8Ek/2h3h+PasLWCYxQ4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785927305; c=relaxed/simple;
	bh=PNTirG8Ba17KUyDTO/1KPiLMECf6OXz3H2fY5gvuUg8=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=u5vlEg+tP7uGXZO/VA5dmq9USYaRm7RlBY34yKBXvnD2R5V2BYpyEqTwHfljoU1gZZeiisF12JH3QmscXqR3z3bOVd+MRUeAdgBg7Zri32BS0FStZu/yaJ5mojBr6Ooiftn51HI0sTT0/pQ7AVMt8CzsyvCpbyzkvh74Be/+OM4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b=Prq7sLo3; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=HyqS6Kpz; arc=fail smtp.client-ip=148.163.150.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b="Prq7sLo3";
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="HyqS6Kpz"
Received: from pps.filterd (m0380145.ppops.net [127.0.0.1])
	by m0380145.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 6758dVrw869749;
	Wed, 5 Aug 2026 05:54:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	proofpoint-05-2026; bh=v5MO8RE53DzyVvAAC6Q5dsTDIEU32HojBSEbRAksW
	UM=; b=Prq7sLo3wZHm7qRDZuWwgncbD7EOojxVXJggRF3b0NHJhMNeh88wntJiz
	unY70IJsGDmLn9AV4KzknczSPubHhwmX5/8+qTHoLdPjolRDT8EfJG0XH8XNtufR
	C335/wM8iI1FpfCp8s66tXEWg6Ay2rhyvjj4hEUgab+TWmqhaDdmTXzo0JkUboeA
	5gdbVbTKto+ATSoe7hgk+qEYrIIZV6OvtqSB4Qwg8HZZg33RwaxdsBvvTgXS7Dtp
	h5g2vgbekp3vVMzhAgTfjd/d01mlZngQdblvZgTonA1wnr1iRrYn8RKyPLjTCmTP
	MShORL0qUF8kpwaJX+l7DuZiZt0hA==
Received: from sa9pr02cu001.outbound.protection.outlook.com (mail-southcentralusazon11013030.outbound.protection.outlook.com [40.93.196.30])
	by m0380145.ppops.net (PPS) with ESMTPS id 4fux6u2bx7-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 05 Aug 2026 05:54:45 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nVnabYYbHH3a7ppkZpznhHj5w48hVoEWa8AlSiOT1SJKDPrD0DGsmcR3HzvVd0qDBxsODhxB2w/mxV7HiCMBykjFpvROuR9ctJsZFQ3JgQiwzCUMKmbkk2TuDVeMg/CnvRw9WTF8SbZKgSqPhxpzUwEYN0KFW4qe8wl0sXWHt8XNhv4dH3mh5lk1gWgTVubcFt4K5tfvla6v79Reel41/psnLLcg85Eed1nkF3Q0sDiPFtCKtDMEw5lfnkcg3weUi27yWEcr6ciFOjcxXciwEcykrsfe4/4fKF+lUUlaInQ7WjulwTuRriA6+tD4c7FAPO56Xu7Qk3HUP/xNbwksEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v5MO8RE53DzyVvAAC6Q5dsTDIEU32HojBSEbRAksWUM=;
 b=yIQ4DlJ7LNzDq/LDsgSj8Vvimxv6/kTPkloxwTiJYPVa36kD4EPPMHRXgmK/9+0Rf1Q5Pvdwu0Q+k1cosJTkOdlgH7/yKMiI3YgeeHzcSBCgce58XzQ0xVxG6RBkUCjsF9oV3GnqLRq3Gqj4PB9J+wK+yj7TRfSqIPMkANe4D0qVgk+n5uT6Q16t4l0cC/hvhRaSINMAAWYeJG6cXjQNm/MMIq8doLKpXh1P2ch0iz6jjp6J0XdbT/HFA2gCGCBjfhUZzDcnFLqXa5I/ltFlbqC3vCNxxVI4N6S8Qs9K9qaPSvtEtyUta1EyMj01Er4OWB0PFrx5YjDVKZX7PuSgNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.194) smtp.rcpttodomain=cadence.com smtp.mailfrom=ti.com; dmarc=pass
 (p=quarantine sp=none pct=100) action=none header.from=ti.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v5MO8RE53DzyVvAAC6Q5dsTDIEU32HojBSEbRAksWUM=;
 b=HyqS6Kpz7rpfZPaXSay+eNtjsjRjJVBzkE4l32cKPAyReJAaX1GMqrCXY51iEQw+Gi7JyVJZILjd/aWlH05pIg9WBuoJ2sGPJGqHjeLbQRzoJ+VBZ0cr3R//a6gHTmjV5qYnjbueG/sD8DFx2LwafYGxh12ZzxrPeV9gvxw7CwU=
Received: from PH7P220CA0178.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:33b::17)
 by SJ5PPFA7D84DD83.namprd10.prod.outlook.com (2603:10b6:a0f:fc02::7c0) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.18; Wed, 5 Aug
 2026 10:54:41 +0000
Received: from MW1PEPF0001615E.namprd21.prod.outlook.com
 (2603:10b6:510:33b:cafe::11) by PH7P220CA0178.outlook.office365.com
 (2603:10b6:510:33b::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.292.16 via Frontend Transport; Wed, 5
 Aug 2026 10:54:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.194; helo=flwvzet200.ext.ti.com; pr=C
Received: from flwvzet200.ext.ti.com (198.47.21.194) by
 MW1PEPF0001615E.mail.protection.outlook.com (10.167.249.89) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.315.0 via Frontend Transport; Wed, 5 Aug 2026 10:54:40 +0000
Received: from DFLE212.ent.ti.com (10.64.6.70) by flwvzet200.ext.ti.com
 (10.248.192.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Wed, 5 Aug
 2026 05:54:37 -0500
Received: from DFLE214.ent.ti.com (10.64.6.72) by DFLE212.ent.ti.com
 (10.64.6.70) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Wed, 5 Aug
 2026 05:54:37 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE214.ent.ti.com
 (10.64.6.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37 via Frontend
 Transport; Wed, 5 Aug 2026 05:54:37 -0500
Received: from [10.24.68.129] (a0507033-hp.dhcp.ti.com [10.24.68.129])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 675AsXuu2021582;
	Wed, 5 Aug 2026 05:54:33 -0500
Message-ID: <849b0837-e3c3-4dc5-9e6f-b8b0ff48ed83@ti.com>
Date: Wed, 5 Aug 2026 16:24:32 +0530
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: linux-next: Tree for Jul 30 (pci/controller/cadence/)
To: Bjorn Helgaas <helgaas@kernel.org>, Randy Dunlap <rdunlap@infradead.org>
CC: Mark Brown <broonie@kernel.org>,
        Linux Next Mailing List
	<linux-next@vger.kernel.org>,
        Linux Kernel Mailing List
	<linux-kernel@vger.kernel.org>,
        <linux-pci@vger.kernel.org>, Takuma Fujiwara
	<t-fujiwara1@ti.com>,
        Hans Zhang <18255117159@163.com>, Pengpeng Hou
	<pengpeng@iscas.ac.cn>,
        Manivannan Sadhasivam <mani@kernel.org>, Yao Zi
	<me@ziyao.cc>,
        Felix Gu <ustc.gu@gmail.com>,
        Siddharth Vadapalli
	<s-vadapalli@ti.com>,
        Manikandan K Pillai <mpillai@cadence.com>
References: <20260804211756.GA1938423@bhelgaas>
Content-Language: en-US
From: Aksh Garg <a-garg7@ti.com>
In-Reply-To: <20260804211756.GA1938423@bhelgaas>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW1PEPF0001615E:EE_|SJ5PPFA7D84DD83:EE_
X-MS-Office365-Filtering-Correlation-Id: ca5e3bc9-7580-4285-827d-08def2dff33c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700016|23010399003|376014|7416014|1800799024|13003099007|56012099006|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	nDMkqgQ0vHsZUy1D1dwRwpmBIYW4QSU8lT+XP94a0zhfHKg+gE78E0JesF+7FEts0J/vz1annX6T8bN12io1dV+fGLRJTPc1+Wpeg5wDCJOfERqhFvVvVOqFbOwntsS0VMsoG6mxjfRZL0GwwT/bSXQreN2sijq5Vv8WB2Wv1r0s5VycWhebX2JCKI3Gj43n0XqyAskzXKSLV/W76pjkkmWEcNr7J8hWxZZqJrde5gX8TZ/3GN2MjV7xPXRpYS0ZzB5OQQVSXMFgkf2syh5IiPg1Yo1FJ4Kt0cEEDXv5cH2XVrWIu21V14CEcTiBszBcwjBToZcDPgePAzB8P6cSMzUgVye8FFq+zbfB4pJNaJxieQgelooSc121YZxyoxgZHIvwWvXUHbJDzB46QIRRlXxG++PKOrGG/5bdW5XUq61HwL9Uk7J0f23F0msZCK1VxyDHxr2a76miWT/0tYCd63waasVmVYRLPzsYIbRRN5vW0ZXXsz/HVMo/TfPzcJv2QxDRSPQKOoqKsC1wscJ9LiHixqpOwuUUc2S1YjHauPUPSnkHFFD2dDLnhl9qfviYhgSCSGxbiz0vmc0pJz7adltwByr081N5/ucL+CJuMNb469UEJQ4jGJrDQyZNUg/Fekl5bCXsTRsvKOyuZ6G7q7QwTQ30KeNQCcDS8J8AQlBcRpMZ/8htk64A2oAztrk1FrcE1pBAfudfybbGaSuv+g==
X-Forefront-Antispam-Report:
	CIP:198.47.21.194;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:flwvzet200.ext.ti.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(82310400026)(36860700016)(23010399003)(376014)(7416014)(1800799024)(13003099007)(56012099006)(10067099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	FJnirA9QwAbiuU8MyTEUGatkh+rXPaAW24VxUnNQ+/2v4WQWaRePj6W+7ZtMT0TJz2sYM6uWvt/DLy+qiH8chH6U6rWq6Fgi+8xCQgS90cXWsGZfjIFt7IZiPO513eoxHCKfglUekIs7c/Z+x0XWFzfLvZHdVCQ/fX0PDaGPCE6TfCYb1M/4jFRFhR1WvouO54fZlY7qph8ZbrorRL/kdbIO3Au51VXoA+NTL1JvjSrW76nURoPPS5RIRnlMRrDNrUGeLd/Nk7csROyjgkcJn184g5Qn/FS+abaqqYb4L0AZ2N04jrNC1efcfWjMT6DNeMFd7AuLUxLrd1aXurUwCvyAHKKFJqMDBhXszNguUvdNzMDPyJMMI0p/D8GvGM+u/If+FMBq2GObH68Jchw9gCmOxPvBiGxseWXro9uwvveuFSrIyqLT7Zt/xctjgEDo
X-Exchange-RoutingPolicyChecked:
	H6u+PCP3+6sf8WmjQIqjO1zPEoVj096XMBbaiL9sqcVeIHglFK7LnPW7LsunEANazTXwEMIO3hz2h3ktDo4CE5ek9ILu3PPD6BUt+Y3VoNLVxw0HcVbgPns4l7F/cKLUBJjKxNxTmubH1js0qKVt9JHBXG3k9xtY5KsvqvCuPQclm8QgI8xw9YnwQ9EBAT8okyLERBobpqgyMjY1Q72UGVsUXDpJQL0JeBlYlTXT6KWjCIt1SApaPlntxPPfGcu3j4wEFMAuQXjxXYy2+JxMp7guDcPnFID1lUvGPvr9EmUgvSFM2IH7fLJdJkLTxA5//7Z2sPBTX7/uykZBonmYdQ==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2026 10:54:40.4368
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ca5e3bc9-7580-4285-827d-08def2dff33c
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.21.194];Helo=[flwvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MW1PEPF0001615E.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPFA7D84DD83
X-Proofpoint-GUID: KIOnv7ygopapiVwsrN32q6HmZ3R5W3el
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA1MDA4NyBTYWx0ZWRfXxCufMsCNckM4
 Ak2HMNvCiU4ORHnthoM/uOmq1I04YG2cNE+H2T/Lb5NWBiPI8voHPA2kCYQKHRsgk4rO+31v9Ew
 1TsvRctU9XU/mKZbLJ/Zyx4u+P5vIAr3ZYGy+TewdQcFBNDwcdWNqEztRt0980gtzMQBoe0VJ3P
 oKCb4kj7hEYUGinMxk/eOuwba/PTr8u0XCBtFQUfPSbrXWqfoO6JHH+G2vSOBCYPqqZTHyhSrvC
 Oaf+JC3iNxoRqi28h0MSCFXB3YW5tRDQ1PX059qwosz2iLGv0FRdKfN7xBBSBqmGOaNlQpzj2gv
 LppDvDqdzUO076E/CWPLJG8csNtAmGPS0P5WlSm/1qlB1GqQejPrBRg2GlYgtyqK28/lJwjLRF4
 I6kTkY8mR8phr+Q0qw/Ppi6sxJs9MACd3ktHGxI9lWXLI92nyD64icvXAY8Ssazh7KvUksbkvQy
 BQiNa9X8wHOdL3+JurA==
X-Authority-Analysis: v=2.4 cv=X9Zi7mTe c=1 sm=1 tr=0 ts=6a731675 cx=c_pps
 a=Ky5N4DqHy2xmpABslddG/A==:117 a=iwqwCZQqcuTv3JOpYdM7/Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10
 a=V5UXEbMT0ywA:10 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22
 a=gO1vWkAQAl3rybz1DQOp:22 a=VwQbUJbxAAAA:8 a=JfrnYn6hAAAA:8 a=sozttTNsAAAA:8
 a=dd2aNVyslHAJAqqMqhkA:9 a=QEXdDO2ut3YA:10 a=1CNFftbPRP8L7MoqJWF3:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA1MDA4NyBTYWx0ZWRfX92YOw/FxIPow
 ha7nNMHugO+nY7884GU1B4fTsmtS4UTCLcsqK4/kNDRfekuF6wr2Sa7wOSDvQuKdJi8Tokqty44
 b6HJ7JMIOQjlNzXyYdT2zD/8l7LohUI=
X-Proofpoint-ORIG-GUID: KIOnv7ygopapiVwsrN32q6HmZ3R5W3el
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-05_03,2026-08-04_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 clxscore=1011 priorityscore=1501 lowpriorityscore=0
 suspectscore=0 impostorscore=0 bulkscore=0 spamscore=0 phishscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608050087



On 05/08/26 02:47, Bjorn Helgaas wrote:
> [+cc recent committers in drivers/pci/controller/cadence/]
> 
> On Fri, Jul 31, 2026 at 05:12:03PM -0700, Randy Dunlap wrote:
>> On 7/31/26 2:41 PM, Bjorn Helgaas wrote:
>>> On Thu, Jul 30, 2026 at 07:27:42PM -0500, Bjorn Helgaas wrote:
>>>> [+cc authors of everything on pci/controller/cadence; I haven't
>>>> triaged this at all, sorry, and don't have time right now to drop that
>>>> branch from pci/next]
> 
> Thanks, Randy, I reproduced this problem on v7.1 in an x86_64 build
> with the config-r1495.gz you posted at
> https://lore.kernel.org/all/b99bef0f-7694-4aff-949e-d289d8ddb10e@infradead.org
> 
> Per MAINTAINERS, drivers/pci/controller/cadence/ is orphaned.  If
> anybody cares about this, please take a look and fix this issue.
> 

Hi,

I have posted the fix at:
https://lore.kernel.org/all/20260805105014.3952686-1-a-garg7@ti.com/

Regards,
Aksh Garg

>>>> On Thu, Jul 30, 2026 at 04:06:44PM -0700, Randy Dunlap wrote:
>>>>>
>>>>>
>>>>> On 7/30/26 8:02 AM, Mark Brown wrote:
>>>>>> Hi all,
>>>>>>
>>>>>> Changes since 20260729:
>>>>>>
>>>>>
>>>>> (1) /usr/bin/ld.bfd: drivers/pci/controller/cadence/pcie-cadence-plat.o: in function `cdns_plat_pcie_probe':
>>>>> pcie-cadence-plat.c:(.text+0x2f8): undefined reference to `cdns_pcie_ep_setup'
>>>>>
>>>>> In this case, a builtin driver attempts to call into a loadable module:
>>>>>
>>>>> #
>>>>> # Cadence-based PCIe controllers
>>>>> #
>>>>> CONFIG_PCIE_CADENCE=y
>>>>> # CONFIG_PCIE_CADENCE_DEBUGFS is not set
>>>>> CONFIG_PCIE_CADENCE_HOST=y
>>>>> CONFIG_PCIE_CADENCE_EP=m
>>>>> CONFIG_PCIE_CADENCE_PLAT=y
>>>>> CONFIG_PCIE_CADENCE_PLAT_HOST=y
>>>>> CONFIG_PCIE_CADENCE_PLAT_EP=m
>>>>> # end of Cadence-based PCIe controllers
>>>
>>> I was unable to reproduce this issue, so I didn't do anything.  I
>>> didn't figure out how to make CONFIG_PCIE_CADENCE_EP=m; the config I
>>> used was:
>>>
>>>    CONFIG_PCIE_CADENCE=y
>>>    # CONFIG_PCIE_CADENCE_DEBUGFS is not set
>>>    CONFIG_PCIE_CADENCE_HOST=y
>>>    CONFIG_PCIE_CADENCE_EP=y
>>>    CONFIG_PCIE_CADENCE_PLAT=y
>>>    CONFIG_PCIE_CADENCE_PLAT_HOST=y
>>>    CONFIG_PCIE_CADENCE_PLAT_EP=m
>>>
>>>>> (2) /usr/bin/ld.bfd: drivers/pci/controller/cadence/pcie-cadence-plat.o: in function `cdns_plat_pcie_probe':
>>>>> pcie-cadence-plat.c:(.text+0x11f): undefined reference to `cdns_pcie_host_setup'
>>>>>
>>>>>
>>>>> This is similar, just a different driver is =m in the failure case.
>>>>>
>>>>> #
>>>>> # Cadence-based PCIe controllers
>>>>> #
>>>>> CONFIG_PCIE_CADENCE=y
>>>>> CONFIG_PCIE_CADENCE_DEBUGFS=y
>>>>> CONFIG_PCIE_CADENCE_HOST=m
>>>>> CONFIG_PCIE_CADENCE_EP=y
>>>>> CONFIG_PCIE_CADENCE_PLAT=y
>>>>> CONFIG_PCIE_CADENCE_PLAT_HOST=m
>>>>> CONFIG_PCIE_CADENCE_PLAT_EP=y
>>
>> I have reproduced it several times in cases that were
>> generated by 'make randconfig'.
>> I am attaching the 2 failing randconfig files (both for x86_64
>> and linux-next).
>>
>> -- 
>> ~Randy
> 
> 
> 

