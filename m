Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=2 smtp.remote-ip=40.107.130.50
ARC-Seal: i=3; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795014643;
	b=Y1W/7NOtLRAiC2v2wpku6PyQc6e/U/yhbjhPBLzfMuKi+Wx1kHgGID8hHKkqeL1/sZdM
	 Kg2cFbIngxKtCqkTILTwRwqBf/T4tEIeT8spq6i38Z70KChlYgO5R+2kAqms8Wm6fZWeq
	 CsK8+k5BNQ08aR92npx8W3wpvCk9IR/7pu6mU440/LVxUNB8EWN2z1JK1ID8eihpGHOTZ
	 icTPuidUMbArsQfAhnOuNQHB8gBSgv4gt7yDJQQJsrZQVW0RHgYVuWz0oWqiludxVIsSY
	 XcDLYD7EiQFAMucELcqApXhS88+rfrmQEK242f4iGkW/48Jq97Xl2op6wWWXefsPmfQ==
ARC-Message-Signature: i=3; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795014643;
	h=DMARC-Filter:DKIM-Signature:Received:Received:
	 X-MS-Exchange-Authentication-Results:Received-SPF:Received:
	 DKIM-Signature:Authentication-Results-Original:Received:Received:
	 Message-ID:Date:User-Agent:From:Subject:To:Cc:References:
	 Content-Language:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 X-ClientProxiedBy:MIME-Version:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-LD-Processed:
	 x-checkrecipientrouted:NoDisclaimer:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam-Untrusted:
	 X-Microsoft-Antispam-Message-Info-Original:
	 X-Forefront-Antispam-Report-Untrusted:X-Exchange-RoutingPolicyChecked:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:
	 X-EOPAttributedMessage:
	 X-MS-Exchange-Transport-CrossTenantHeadersStripped:
	 X-MS-PublicTrafficType:X-MS-Office365-Filtering-Correlation-Id-Prvs:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=bqO0NJgbVnGVIsCbCL/1KjTYCZJlT85noWqFeOw0LDM=;
	b=hp9Hm+6p6bwYqDfiYYuzoib/8r/LVsV+b3znlo80xzWpEZlYKR+GlIwy3zc9B7ovL2oI
	 1eLUyguvURaIH9FAU6oBystYeDo8xu6xFGwJuU3i4ofxROroQ5CBf5+B0WfFmQ1Tpqhgl
	 kN3Qz57JEtqfOe9nyzB5zHpZvtXhEun1udvaujVi7cr4IyaH2S2A3SQ9aOt1ALnmHyGaY
	 FBx4a89KDq9teAmI1PjOYxXJwCdVslDQX2cvwZFkAJH9htKAjRMzVLV6HWHCqzMuqMcN5
	 Bhwsz+B4rd/Snr7gLOjoAmvMdb78CIJpB7k+9inS+SHbUfYofgUumYN7bTRbdymWIjA==
ARC-Authentication-Results: i=3; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arm.com;
	spf=pass smtp.mailfrom=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=selector1 header.b=Huub3cJI;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=selector1 header.b=Huub3cJI;
	arc=pass header.oldest-pass=2 smtp.remote-ip=40.107.130.50
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011050.outbound.protection.outlook.com [40.107.130.50])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDC88606A31C;
	Wed, 18 Nov 2026 15:10:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DDC88606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=selector1 header.b=Huub3cJI;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=selector1 header.b=Huub3cJI
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=gwroTlVriPA8vVW2FzEq1PGACjg5Utuddf2BplgBJL88giNLjWXzX30m4bimevU1wajJIK/zTfEKVvSxTthDBv7z5B3uupTO7/X7wR3RHWgdw+P01Zp1bTNErqj+Glio9wuDPBIXvenLoIp3USNPraYHML4EDl1rKRljW1VAAxAdNUY5NReeA3IAor6KJSJ/4tMrYNgz6Uz4ZlRR0gbuCCt3DBaJPh2CxSWUBxgPxkt4n7I0zbm34efuEEfl+eGOK4ao3pBfmj50KN3QqSnoxV9pb9amtjwt5wzeNoGAHkTOHTtzw1XV4MWOtop093ZRl1aa1eivF8v6BXKiY0RWLA==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bqO0NJgbVnGVIsCbCL/1KjTYCZJlT85noWqFeOw0LDM=;
 b=olhhCqg3ab766+HM3kWQqQSlifWgtN3Yi7uUgwYGVA9VYKYAH5TOLf5XNsYxEyWPFL60HuV33h7Dx/cLdgPSJHjFOKQlxFHCOcjBOa20ET0BbFbZv4dUH+FUgdPgCtjhJk+Hk5/gZwK69fDitqsh+tnUDzNZL+Bu9sjH4g8O7VD4svqKKpG4xNItz0rhtf3FtRZ3Fj8Yf59qjzaEcT7Gyr6uQs9WCvYh/U4Or4lk3kghb6o1tCRq/97GezSvjyRUaccWtMlcQ0bG5Xo9ku8oO+yn+6J3VdCbydDAm4ln03XBQ100ygdle8zDMrIxW/I1oG7h/j6vtchywMP/ct4RFw==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=wunner.de smtp.mailfrom=arm.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=arm.com; dkim=pass
 (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bqO0NJgbVnGVIsCbCL/1KjTYCZJlT85noWqFeOw0LDM=;
 b=Huub3cJIecSkYz86rEQT0RZzsvjyJoGdFVtrvE7E/Q8TshJ2LNAWl9TUq3xzfEq2a66KYoJ8acYfgkIFvN2SAxq6PU17JPlcJHASKyIXs66ANNaiob5aIOSFOSPrC7v5MdMPAvbrmkj/o7OfeGRqXn9Lwyuck6WjZ5izDAa8jg4=
Received: from AM8P189CA0010.EURP189.PROD.OUTLOOK.COM (2603:10a6:20b:218::15)
 by AMDPR08MB041017.eurprd08.prod.outlook.com (2603:10a6:20b:748::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.13; Wed, 18 Nov
 2026 15:10:37 +0000
Received: from CPH1EPF00000521.eurprd05.prod.outlook.com
 (2603:10a6:20b:218:cafe::42) by AM8P189CA0010.outlook.office365.com
 (2603:10a6:20b:218::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.13 via Frontend Transport; Wed,
 18 Nov 2026 15:10:37 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 4.158.2.129) smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 CPH1EPF00000521.mail.protection.outlook.com (10.167.241.132) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.4
 via Frontend Transport; Wed, 18 Nov 2026 15:10:36 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hoKe8fTnGzQCNrdDdBnBxqk772v7HvCiqP+0/XS9L32oySVqNYCEpRpEn0YTG6adjRjmL5qZDdi26LYEO29kMZUFCMhwCsQthk5IyO/sTk9C/Cz6rg2kmjeOgZ18EG5wJVmgCh88jOXACEKskBSvoVVXDGJcRxJZoDbpCwx7Zf9/Rd5zMgrjN6HKfVbsTQcnu7mJlSg9BWwnmiiYuSvwe9RsY5QZLIXOD7mtng1RfCUjZO+f34kCojmDDwhNYhcKH5KCIH2Y2b+qMU2/T7SmuNxjvU8SIi+BlceRKM74iE+UKnkZYW4EJMSA4Uqv5xskqzgaJMp+TBcGU1oiAXS9ZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bqO0NJgbVnGVIsCbCL/1KjTYCZJlT85noWqFeOw0LDM=;
 b=x4KdfZdghI3oQW0atb8loqW6gvtRrnEpp6KinAYAwZflycyTEVk3AuNe4+8qQfGZIYJxo0AKEaLshXJBKO5Mly3JH4dTkKgyC7500cihcVlMUGWkFORP1h9M6UTqJ4ljv84yGiabxFNZYG5DWsmf3rKe1nz4uCTo1oWa4HxnjVkJ4Spf0kXq5Mn3S7vJD6QBCjTh2soT1RDOcSjKQ9w/txFldPOy9SHll71FQrXbMERqbeeaLogGNLRVHgeKF3Ezcgxk3fxMmnKq+B6yuTKQEAfsqXRMOGbi49Eramoe3EF0mkHpaYFd9JoEWC2xzUaEWXapBH01W8A/keXD9HN7Cw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bqO0NJgbVnGVIsCbCL/1KjTYCZJlT85noWqFeOw0LDM=;
 b=Huub3cJIecSkYz86rEQT0RZzsvjyJoGdFVtrvE7E/Q8TshJ2LNAWl9TUq3xzfEq2a66KYoJ8acYfgkIFvN2SAxq6PU17JPlcJHASKyIXs66ANNaiob5aIOSFOSPrC7v5MdMPAvbrmkj/o7OfeGRqXn9Lwyuck6WjZ5izDAa8jg4=
Authentication-Results-Original: mx.microsoft.com 1; dkim=none (message not
 signed) header.d=none;dmarc=none action=none header.from=arm.com;
Received: from BESPR08MB999898.eurprd08.prod.outlook.com
 (2603:10a6:b10:109::23) by CPH1PFE47673673.eurprd08.prod.outlook.com
 (2603:10a6:388::516) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.9; Wed, 18 Nov
 2026 15:10:04 +0000
Received: from BESPR08MB999898.eurprd08.prod.outlook.com
 ([fe80::d62a:5300:bc89:9f62]) by BESPR08MB999898.eurprd08.prod.outlook.com
 ([fe80::d62a:5300:bc89:9f62%6]) with mapi id 15.21.0615.013; Wed, 18 Nov 2026
 15:10:04 +0000
Message-ID: <fa6c1f8d-d372-4737-8c57-528a6470d2a7@arm.com>
Date: Wed, 18 Nov 2026 16:10:02 +0100
User-Agent: Mozilla Thunderbird
From: Pierre Gondois <pierre.gondois@arm.com>
Subject: Re: [PATCH v1 05/19] PCI/AER: Embed aer_capability_regs copy in
 struct aer_recover_entry
To: Lukas Wunner <lukas@wunner.de>
Cc: linux-kernel@vger.kernel.org, Ashok Raj <ashok.raj@oss.qualcomm.com>,
 James Morse <james.morse@arm.com>, Mark Brown <broonie@kernel.org>,
 Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
 Tony Luck <tony.luck@intel.com>, Hanjun Guo <guohanjun@huawei.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 Shuai Xue <xueshuai@linux.alibaba.com>,
 Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
 Oliver O'Halloran <oohall@gmail.com>, Bjorn Helgaas <bhelgaas@google.com>,
 Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>,
 Pawel Chmielewski <pawel.chmielewski@intel.com>,
 Yazen Ghannam <yazen.ghannam@amd.com>, Avadhut Naik <avadhut.naik@amd.com>,
 Jonathan Cameron <jic23@kernel.org>, Kai-Heng Feng <kaihengf@nvidia.com>,
 "Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com>,
 Dave Jiang <dave.jiang@intel.com>, Breno Leitao <leitao@debian.org>,
 Terry Bowman <terry.bowman@amd.com>, Dan Williams <djbw@kernel.org>,
 linux-acpi@vger.kernel.org, linux-edac@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-pci@vger.kernel.org,
 acpica-devel@lists.linux.dev
References: <20261117111444.4185512-1-pierre.gondois@arm.com>
 <20261117111444.4185512-6-pierre.gondois@arm.com>
 <avw-NChMgIjwFuv1@wunner.de>
Content-Language: en-US
In-Reply-To: <avw-NChMgIjwFuv1@wunner.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PR1P264CA0151.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:346::13) To BESPR08MB999898.eurprd08.prod.outlook.com
 (2603:10a6:b10:109::23)
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	BESPR08MB999898:EE_|CPH1PFE47673673:EE_|CPH1EPF00000521:EE_|AMDPR08MB041017:EE_
X-MS-Office365-Filtering-Correlation-Id: e5cf37e6-4e40-468a-0333-08df458619d0
X-LD-Processed: f34e5979-57d9-4aaa-ad4d-b122a662184d,ExtAddr,ExtAddr
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|366016|7416014|376014|10070799003|23010399003|1800799024|18002099003|22082099003|10067099003|261026140227099003|261028144727099003|261026121527099003|56012099006|261022105027099003|11063799006|261102123227099003|4143699003|261009223027099003|261021121427099003;
X-Microsoft-Antispam-Message-Info-Original:
 QKhrCj+VOr6slNXxUOg7LGyWeXaJRPu9tAq5PhCO+qu66AXxdgg9r70zxc58B2tWhG1s6uCPqhkT8W41UdDv91U3uWOsxQavkwbWarjXH4ccXqvpWO7L8IefFhTHMQ01RSIw2XtSFSFlf8c/v1kmn4aJMv8+k9bYWD1/VhOoCdqkV5Mi0LTtWpVQNcodD82ESeT6uadJBrTVyytqqaYeBaNPY82ZWareoqfouLJi0DF2hcLf40riUmR4Ia287T+6X+5YYwTDdNMD4ZxaNlPMe4jUqYyiTggIDcg1SPlEI44Dze6x2GIIAMOCAaW4XNzaJZTWu4ArkJFatUMOFgbn18AI7kjO2cTmesG9vo5TfxS3b1BSoGXFfVUqenQYX/76xVG2rsMiReqegwXUwikSMN54QilH0yAja2wRHbxhDJYS4n0ljMBscrcGTumep3NiDZTjAUN2cLrg6ZslIdehlItq2pZQAA7Q89cMEsY2LePoYgetEoeANHdjC0zD1KFckST7BBxag3UXciF6JVXr7AIE1eaEIMIx2ZMTO085TpzyAHsfi0Ft1JxSmm6JpNhxzHJzJ6ldE7/DTg1jDAMyDV4cRoVy+xO4lF7qtLpcp1UBeqz0USrOwi2S3M0jG4WXMs8IKQDNpBlayLYgOmn3ojTINL0LvzmrlVwjlr5D3e8=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BESPR08MB999898.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(10070799003)(23010399003)(1800799024)(18002099003)(22082099003)(10067099003)(261026140227099003)(261028144727099003)(261026121527099003)(56012099006)(261022105027099003)(11063799006)(261102123227099003)(4143699003)(261009223027099003)(261021121427099003);DIR:OUT;SFP:1101;
X-Exchange-RoutingPolicyChecked:
 YOtV/F3j3Pjq5MrBOtaksxFa4OZtJ4nGpb5g8wQz3r6TszU3XNDf4xsL82suby97BBzYg0ABqLGug+Aps9DqUbol1pBXu5hUaPUEGOm0KggJV1MWjPhNsM0t/5mJlq/o/2Lx0BlOFx0QE9OR4jqJ//gm02++UIRfFpDmelW1WmBxHAn82rL5aOT1pYqIEoc8TGj+1iZObGa5ySZ78IIcPKlJQQcTm9NeQXum+HVNGAczOPkDai1tClEAElxYQefYGmp+X6qLNOGFnKVy/R87zror1VORiRqezzGB4FYAzgXIhLJP0Yhk/dwxe2dY42ixxoN2fjXB8yt4Y90XPFI+tA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CPH1PFE47673673
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 CPH1EPF00000521.eurprd05.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	9f7ec9b5-2ffd-4c61-e62d-08df45860644
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|14060799003|82310400026|1800799024|35042699022|23010399003|376014|7416014|261022105027099003|261102123227099003|261021121427099003|261026121527099003|261028144727099003|11063799006|261026140227099003|4143699003|56012099006|10067099003|18002099003|22082099003|261009223027099003;
X-Microsoft-Antispam-Message-Info:
	hEY2TIuzolr91WAp7RzDyNjdV+CpheXHfWXNDdeGKlcr/f4X2uqf4xj24b1yFy30FzZIb2jebe8UMmF1uNX7WTBfsGVODqV3yPtnXxOmGfAWD5CQ8wAJ+A/2N0c9xAdzgNDJJT/2vdka0vI5C12od7782ACsjAl/8ch5b+xs7xP71pz9SrrtufkI5AEnhpqcsBXsGl4xWRKBkqpScQi0vItJktZlq1ebCmtBk/47bGnsOtXigUTcgHf1TOf1AKwsBpVAYwr5vNhCstKT/2tj+1GhmGmgGDWou1iMiI0tHCjOCk5BBMVFdo3TRCzabjSxwkXuyJ7mAHxrl10td5lZPbXdu360B+uvCJmVj3Zk6QPIABC58ozgo9+6qn4CdowM/VhK8u3jVJvaZOE0x7cDrQ14l9uPRdmSoT2ZpriHmkBkrXS03f6sMXIekf0dVQoi2QaKDzrp7by0KnAINGh5tucSA9334bnrAofnpm7UztDkWpBrIyp0xEBSIJYrqBZX1q36OHhkYc+e+O1ZAT05bCAbu3+f4oDSiEszXoXD4WhIL8pSKzk02CsYNRsP7OwoumGdxhfZN6MS+Yvt8uxXciv6s7NWtaIsAvJSMsqlFuPE+1v36symAtfobCvhaaQhjZNF4CFRhHEWw2zq/pYmQwbWw3oIat9BOChQG5XyZfYYjfhQ1KcubgJxaJDOQc2+YYOkgsI95Jo4zGiEAhtClQ==
X-Forefront-Antispam-Report:
	CIP:4.158.2.129;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:outbound-uk1.az.dlp.m.darktrace.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(14060799003)(82310400026)(1800799024)(35042699022)(23010399003)(376014)(7416014)(261022105027099003)(261102123227099003)(261021121427099003)(261026121527099003)(261028144727099003)(11063799006)(261026140227099003)(4143699003)(56012099006)(10067099003)(18002099003)(22082099003)(261009223027099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	90ZPLfljQ1ygSJmw+1VoLc4I3vGJZtGmfxzPB50YCDRoTaHbT4vuY8+WSTTqJvYiOv366bkxM3GeqrjgoQLyDMa92fKBDfXW+mZCLILquWwGQZnrxmO5QH3UKst/CMcmpnKLCBY91jhhkGxvKA8mpyt9r2rkMUZpkecIP4Fet57ec5ZAwJz5j6MXXwLedtsi7o1kVuZ9JpgB1CRWoOYeEIdS59J19VWvD7HopMMJQMYz2KIYu4GwZTjQNGrvK0j35bUfJ9NJfAoVtmJrjRkjvwkiAKqyz/MT/+tkza2DpHuF5kba7aJn3Dv/yhbAxASefR0WW1OKEFOYsibL5xAM3ar5qZpDooi/yHiJVsZZQV+n3CJgM2Zf8S1uGimdsSsumcO//PYt6bxpc88wP5l0KPn1i1CXmzCkZacFpYrbYU0NaVM4VPZiqV+thVQ09wre
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2026 15:10:36.9766
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e5cf37e6-4e40-468a-0333-08df458619d0
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[4.158.2.129];Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CPH1EPF00000521.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AMDPR08MB041017

Hello Lukas,

On 11/17/26 12:44, Lukas Wunner wrote:
> On Tue, Nov 17, 2026 at 12:10:15PM +0100, Pierre Gondois wrote:
>> commit e2abc47a5a1a ("ACPI: APEI: Fix AER info corruption when error
>> status data has multiple sections") passed to aer_recover_queue() a
>> newly allocated copy of pcie_err->aer_info instead of providing a
>> pointer to the ghes struct. This prevented corruptions of the ghes
>> record (in case the ghes record was re-used for a new error before
>> the previous error was logged).
> Since commit eddba19b8b5f ("PCI/AER: Support Advisory Non-Fatal Errors"),
> aer_regs is modified for a recursive invocation of __pci_print_aer().
> The copy is necessary because we don't want to modify a buffer owned by
> platform firmware.
>
>> +++ b/drivers/pci/pcie/aer.c
>> @@ -1352,7 +1352,7 @@ struct aer_recover_entry {
>>   	u8	devfn;
>>   	u16	domain;
>>   	int	severity;
>> -	struct aer_capability_regs *regs;
>> +	struct aer_capability_regs regs;
>>   };
> This increases stack usage significantly in aer_recover_queue(),
> which is not good.  A kzalloc() allocation may be better suited
> for such a large struct, instead of relying on the stack.
>
>> @@ -1374,24 +1374,14 @@ static void aer_recover_work_func(struct work_struct *work)
>>   					   PCI_SLOT(entry.devfn),
>>   					   PCI_FUNC(entry.devfn));
>>   		else
>> -			pci_print_aer(pdev, entry.severity, entry.regs);
>> +			pci_print_aer(pdev, entry.severity, &entry.regs);
>>   
>> -		regs = entry.regs;
>> +		regs = &entry.regs;
>>   		if (entry.severity == AER_CORRECTABLE)
>>   			err = regs->cor_status & ~regs->cor_mask;
>>   		else
>>   			err = regs->uncor_status & ~regs->uncor_mask;
>>   
>> -		/*
>> -		 * Memory for aer_capability_regs(entry.regs) is being
>> -		 * allocated from the ghes_estatus_pool to protect it from
>> -		 * overwriting when multiple sections are present in the
>> -		 * error status. Thus free the same after processing the
>> -		 * data.
>> -		 */
>> -		ghes_estatus_pool_region_free((unsigned long)entry.regs,
>> -					    sizeof(struct aer_capability_regs));
>> -
> So you're removing the call to ghes_estatus_pool_region_free() from the
> worker...
>
>> @@ -1441,17 +1431,18 @@ void aer_recover_queue(int domain, unsigned int bus, unsigned int devfn,
>>   		.devfn		= devfn,
>>   		.domain		= domain,
>>   		.severity	= severity,
>> -		.regs		= aer_regs,
>> +		.regs		= *aer_regs,
>>   	};
>>   
>> +	ghes_estatus_pool_region_free((unsigned long)aer_regs,
>> +				      sizeof(struct aer_capability_regs));
>> +
> ... and instead call it earlier, before even launching the worker.
> So where's the benefit?  You've traded less memory usage in the
> pool for higher stack usage.  How is that useful?

This patch is an intermediate step toward:
[PATCH v1 06/19] ACPI: APEI: Remove aer allocation in ghes_handle_aer()

The final goal of these 2 patches being to remove the dependency
of ghes_handle_aer() over the ghes_estatus_pool. Just using kzallac() should
work aswell I think.


