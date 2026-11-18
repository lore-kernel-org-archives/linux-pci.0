Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=2 smtp.remote-ip=52.101.83.33
ARC-Seal: i=3; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795014760;
	b=c5rAqIP8GKsOaxWs2m+JOaFzhccnwTDqHJn1z96mWb6S642MX9MzwESdg2WGMdUlmvtr
	 CEBTUBEJ9zHQQMCb4JE0wLyRqiXgTRVeRzuVwmYueDdgPB2wFJ2W6RxD1hWlF+cqS60kH
	 KO4pxtjpFw6dCg5nic4fS8yCA1Syc5axSK5VL7ePl8qkIDgUjIJbv7AiVYCswL9VcLSWO
	 s3+rOt3IQ3AL8dcX/91GYu0dLV9BwQOilcUYdqoUaVm37n+rNl6wKEuNw438RakiAcPRO
	 tbgLujnMem+oaRTFQMLZ+b0q1E1xLUq9KaBqaEMw65nwZyCX5rnvO2jEpeH6yx8IsEg==
ARC-Message-Signature: i=3; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795014760;
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
	bh=Pha9tbSdRKfgpjUDHUYtcRE07gJa9ivPICLHiYMtGOs=;
	b=o5s7zr9nGaY5Fgz3u/HM/9dnT/y0KiS5vIUBTejfLW5m+nmsSUNTfVBoHn2g/FnhH1ek
	 0EzalQWdQR3+dioakfwGHiBtcJEYSdhdm6a1pCWWPwDhMc2Eo56LAZBvsDZuL8BK+rpEs
	 J1dJa/u9apGhZYYnPH5WEMsUND1U189sl4kB7PHc1/XEoZmHeea4bi7X+gHYxx87H7JCH
	 flvmKtEtHDadoRRxILn+j3uKDw9zA6GYYe1KSbjJaEC/pz4TUz2Yu/IyYvD1my4UKvnou
	 +Z8D9fcHXX/GXa/oU/DixOek0akicC+HCf4VsVgqGo7zg/jaeM99K6I4V5KZ3r7EM1w==
ARC-Authentication-Results: i=3; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arm.com;
	spf=pass smtp.mailfrom=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=selector1 header.b=CRQzH2lp;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=selector1 header.b=CRQzH2lp;
	arc=pass header.oldest-pass=2 smtp.remote-ip=52.101.83.33
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013033.outbound.protection.outlook.com [52.101.83.33])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B0DB606A320;
	Wed, 18 Nov 2026 15:12:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9B0DB606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=selector1 header.b=CRQzH2lp;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=selector1 header.b=CRQzH2lp
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=ADPC7r/poFbVCFhLFcWVb1YBkvhW8UxYsLj7h59OwlXpsLG9Qr9nCqpEPSkTIl92Q73gf24wNfjjWJJEdwKfIcsG3wdI1mFzoZF1B/gjgZ/ZxScj8cILunJ88+eIL97DnbXKH0i7Y/tEh8dnsLTGXx+h/MNyVCXjmbxvdwVJqZZazEU8TbgLVlwIH4yt3fF0AZQFPFfJoURGOfchDOPwqg8wpq8NxNh4oQhaAh83AgDHczLrB2S/UfKzU4af/RMsqwQ2DIv7xycz7yQdkThp/OhMqmBuGwcGh70BuHqV9C1TToTZIg/mHAyQcjZDSGOJY9ngbxbb5E4dOkwfMo5AVg==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Pha9tbSdRKfgpjUDHUYtcRE07gJa9ivPICLHiYMtGOs=;
 b=fa7lMN6tJTf6vuXhXgyfKwkzCyay8PNo5jUZEYPN1b5aBfUpgXfC5zbk2AuIcrOvhE+IEeg4ktVjdO4eir2p8e8Uglcjju60qhXCO0tNxL73Z/1R2yTodakcDaa1tzpF3hewr4R5DtE/LE9G0+panTNerUjZKWYgSxC0IPHg2bRtqEcd5sugaPyRixdw/pyyfYOEZefv8LNeaYXOj25rz5RE+cdl+8Z0MykQw2u4O22HWEFT4EJBvaT9WEsRpbuMpJXEFVH3lwGQ4AJNSSUc96yP+55IJzAJzCcGg0jpzWhdwAH2Sp5gmA5nF5mM3MiogUCGC/E+vURlTFbh+WMOWg==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=linux.intel.com smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Pha9tbSdRKfgpjUDHUYtcRE07gJa9ivPICLHiYMtGOs=;
 b=CRQzH2lp0UDHbInqPaYpYXjNkkD0zixXdxIL/MTRQ+bfSBHsLiSJbpj0wHLzyCeDEFtqLGLmdwqJwSQNhAyU8EOsV99+88b8qd+lHZUD2mb90Y59VxF7jroIP2XAWCC0fGaoYgs6R6v+rEqAIJAx01gwSaREuvo7E5Oj1B/QyLI=
Received: from DU7P190CA0005.EURP190.PROD.OUTLOOK.COM (2603:10a6:10:550::22)
 by GV2PR08MB8272.eurprd08.prod.outlook.com (2603:10a6:150:b7::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Wed, 18 Nov
 2026 15:12:30 +0000
Received: from DB1PEPF000509FB.eurprd03.prod.outlook.com
 (2603:10a6:10:550:cafe::75) by DU7P190CA0005.outlook.office365.com
 (2603:10a6:10:550::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.14 via Frontend Transport; Wed,
 18 Nov 2026 15:12:28 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 4.158.2.129) smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 DB1PEPF000509FB.mail.protection.outlook.com (10.167.242.37) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.4
 via Frontend Transport; Wed, 18 Nov 2026 15:12:27 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CmDitTVJBwgwZK9QoUNtyZWdN0E6mxVQXzEj9F6HKZs5ucmPOsj7r60f1UQYJbnSDJhc1Ea1Nv8v3B5Y9iUNMs7Bfe/TwEsq9HDTnqXj3cX11uSgx1NGTcDZ7a5Lbqi7MHluzwz3EyKJq5hPU5/ptfJv7OGHCgpP5jJdVmTLjrru75JIgmD+O+dW5eTLXJUEGV0t+ZWKsP6bazMbhmG4GuJWv+uIKdPlp9NFibJMhl817lm419WZwzVCByX6wymyQOYSJUINHqrgnVfS4XVwnjLRzWwa5nr9nRZcDuNLL1HBLEc8axNABgAbDy9EQ4Nr8C5jT5XSgTceJRKXLXCdoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Pha9tbSdRKfgpjUDHUYtcRE07gJa9ivPICLHiYMtGOs=;
 b=uJ8BWFMB1dmfcftVDP1vkWqfpoc5z1cBhnk6IlWjdhgEulWV3QAWtppDHeHwyKULLUdBJOkgXct5m5VvSG2net9tROkL/wRJgYW1nDs4TKTCu28/BPA7vz4OLhW0tDkpae2tQ4auNrAUsoavuADH0lpJRdT3Xywb0LlYKubRscqteMs2N79HNUHudG5mLJwMxEVsLYZ3rToyGgSte+M44OZWxRiJRl5fA2j4zZKtWi0OipSQHEVa1eBLpzzTcz6lFtTilRr2q8dYK5V/AWGyXqzH812LoA5cFYNCfCFHl8kNhK3hdPaL6z8Cs7ZHlw3beJZYBJGnZztIfdsLVeIyog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Pha9tbSdRKfgpjUDHUYtcRE07gJa9ivPICLHiYMtGOs=;
 b=CRQzH2lp0UDHbInqPaYpYXjNkkD0zixXdxIL/MTRQ+bfSBHsLiSJbpj0wHLzyCeDEFtqLGLmdwqJwSQNhAyU8EOsV99+88b8qd+lHZUD2mb90Y59VxF7jroIP2XAWCC0fGaoYgs6R6v+rEqAIJAx01gwSaREuvo7E5Oj1B/QyLI=
Authentication-Results-Original: mx.microsoft.com 1; dkim=none (message not
 signed) header.d=none;dmarc=none action=none header.from=arm.com;
Received: from BESPR08MB999898.eurprd08.prod.outlook.com
 (2603:10a6:b10:109::23) by PAWPR08MB9638.eurprd08.prod.outlook.com
 (2603:10a6:102:2e0::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.10; Wed, 18 Nov
 2026 15:11:51 +0000
Received: from BESPR08MB999898.eurprd08.prod.outlook.com
 ([fe80::d62a:5300:bc89:9f62]) by BESPR08MB999898.eurprd08.prod.outlook.com
 ([fe80::d62a:5300:bc89:9f62%6]) with mapi id 15.21.0615.013; Wed, 18 Nov 2026
 15:11:51 +0000
Message-ID: <ba5f649c-f338-40d1-9e85-b666590835ca@arm.com>
Date: Wed, 18 Nov 2026 16:11:48 +0100
User-Agent: Mozilla Thunderbird
From: Pierre Gondois <pierre.gondois@arm.com>
Subject: Re: [PATCH v1 19/19] PCI/ERR: Avoid NULL bridge pointer
To: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>,
 Lukas Wunner <lukas@wunner.de>
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
 Yazen Ghannam <yazen.ghannam@amd.com>, Qiuxu Zhuo <qiuxu.zhuo@intel.com>,
 Avadhut Naik <avadhut.naik@amd.com>, Radu Rendec <radu@rendec.net>,
 Jonathan Cameron <jic23@kernel.org>, Dave Jiang <dave.jiang@intel.com>,
 Kai-Heng Feng <kaihengf@nvidia.com>,
 "Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com>,
 Breno Leitao <leitao@debian.org>, Terry Bowman <terry.bowman@amd.com>,
 linux-acpi@vger.kernel.org, linux-edac@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-pci@vger.kernel.org,
 acpica-devel@lists.linux.dev
References: <20261117111444.4185512-1-pierre.gondois@arm.com>
 <20261117111444.4185512-20-pierre.gondois@arm.com>
 <avw_daENKPcY7_04@wunner.de>
 <28da8229-99f9-47c7-b2d6-d301ae34253f@linux.intel.com>
Content-Language: en-US
In-Reply-To: <28da8229-99f9-47c7-b2d6-d301ae34253f@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PR1P264CA0155.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:346::15) To BESPR08MB999898.eurprd08.prod.outlook.com
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
	BESPR08MB999898:EE_|PAWPR08MB9638:EE_|DB1PEPF000509FB:EE_|GV2PR08MB8272:EE_
X-MS-Office365-Filtering-Correlation-Id: c579ec23-26f5-46a4-c3e9-08df45865b8d
X-LD-Processed: f34e5979-57d9-4aaa-ad4d-b122a662184d,ExtAddr,ExtAddr
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|10070799003|23010399003|1800799024|376014|7416014|366016|261026121527099003|261028144727099003|261026140227099003|261022075727099003|261021121427099003|261022105027099003|261102123227099003|11063799006|4143699003|56012099006|10067099003|18002099003|22082099003|261009223027099003;
X-Microsoft-Antispam-Message-Info-Original:
 W+7n+e6m56fbB6bew/cCRno6YMiiGygjWcrs/qRbkCCqJAv5kMCJNwi4YrOGPePbgsXdY4kIaYS/JCdDTni+MxfCu+DPFBU/IcQggQXzcvdKQh0YqAmZbvMWWv+bg4WFXi+8fgrZQfkAHWUA4J9FV2pAyAiXqJ02FHIAS+tK0cMYgUtaXnQecH693WlX6HE9TZGDvAwy/DGyE71hOL1lvN0gnZJsXD80Nc1FngyUK+SH7Fqn8Oep6rG1+DMC0IOPG2NJniKJ2HY7JwK5nHfNxNSl9vbXwAMPAEtl95Eo5UNnWN3E1A+F6Whzg4Ro26h2DtZOXcFnIzvMYFMv4JegfWB9E/7n5n/0i9kMovrdi5z/VqcwpEsANAHJLQfHxvwiXt9GB///BdwBmH0nPsJZh0NHuNE+5tyZmSMWuu7EJXWwBriCLAvun7kQkzgpVInyuikFUnKKfbU5CiwwLw3GPRDT9N7GM+vilL676+xwTeAJit94TlTXwZWgQfmRjhFNnmo4hBiqxGPA/So8YFFwc+2sNi2lUhl4bhktdnLuBFAv85BnPRunSicky9pKP+/KBK6uATo/2v0ppw41rYQSsCEJ6zcsqG9A6K2nQuLEF2Y1iyWFZvXwuIyLjqBLHcyVQCXi+TgDpUgAx12dpZd+Mc+BbGdzMvz+ztnKOg9NaBg=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BESPR08MB999898.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(23010399003)(1800799024)(376014)(7416014)(366016)(261026121527099003)(261028144727099003)(261026140227099003)(261022075727099003)(261021121427099003)(261022105027099003)(261102123227099003)(11063799006)(4143699003)(56012099006)(10067099003)(18002099003)(22082099003)(261009223027099003);DIR:OUT;SFP:1101;
X-Exchange-RoutingPolicyChecked:
 GhXQf9JwSEIdH+6oMzMxV65DCOvjDhjCqpOjyubFHiI2323vnidoieiJLWb1GH4NwO5vEK6oliNmBe4DcYVWnZJuGM2kSegvbpptPfCrZLBEduddFbX6sBerpfEC7SQ/LD9FAhA/jjeoop9TD1i+fgwJm8tg1Ut0S6x/iY+2YsdPDh8GLxi0yBBD6br0LeUX/wBpYMnvGMIlFAf6yPKZoGx9HnFNNhZMK0jQyHV7JuchSDoZjomyX3mGJ1OfFu0p3Sljn9CXydgPYL1W1+zFsKMaUtoMjqGIEdTmTPAo3odrKt1TiEcP+lpMKh/hM+Smj+2GMk0SLboFvXBqtJLVoA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR08MB9638
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 DB1PEPF000509FB.eurprd03.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	10e21c6b-3ba7-416e-153b-08df458645aa
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700016|7416014|376014|23010399003|14060799003|35042699022|1800799024|18002099003|22082099003|4143699003|11063799006|56012099006|261026140227099003|261022105027099003|261028144727099003|261026121527099003|10067099003|261021121427099003|261009223027099003|261102123227099003|261022075727099003;
X-Microsoft-Antispam-Message-Info:
	XJLUQf5mhuNCl9AZSqFWC9gye9MYlRiOVbXx4jcvicpqc8UVjbyy7G1pdobrW/df6R4QIaxYCgQCJXaeiPE829u06PtbMLBVLVUU4dwjm4oLwBnPgdlh2U+Ds2IjwPuNSJi2GYoVvmeP+2o2Lx+D3Gp/uYz7J3wqhI5JKuzDBj7itR9Vwb/vOon03PE8jfTd2Fc95d/zH3QOZhhCxOhpLmiPhiADF5GFiLzaQWlAkmZYCc4Y/EFc/QkHQ4idUK2bg1Yw7hEt1VuGHcCoYEQ/Mxw4kGJ7jC2+xWRVblOjS2wYZkxc9HMshD4w7VUYTzr6EUx/O5W4GuV4lDfc6I0nG/R1r+BJk8wa33HTMaN77WMWhwlHwLy+ffa1tttcV6YqwkNN77ipygmhTLwXhJ/YUIKxJ1kEKDDrAInzXdGUjzwvLR+ZltOaLLcQDOO2GewnSBfRrbGlEJTUfd/KDRXhPZ9eDnXe/Um47pnMP6E7ZX+PW0ea2if3zp+Qv4FCwnYcwYMlvP2XTEgUbEUYZ0Zv9dinl9ZimErycDpDl1OMnvT/HjCNNUf8JYpHpuKSlzq7jSbqZvhiBcc1ndvNIXzPLVaOT0eOrYbMJttHr+lvTxsBTAY9/ajqBluqHcaNwOR6U4iFeyWGWeysBhoO4YeNA3LdRxDRAjf2TLKaQtulLw28mmOi+2awChQQfRZwiYjHFc/QqWqfJAJh06XiOiddLg==
X-Forefront-Antispam-Report:
	CIP:4.158.2.129;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:outbound-uk1.az.dlp.m.darktrace.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700016)(7416014)(376014)(23010399003)(14060799003)(35042699022)(1800799024)(18002099003)(22082099003)(4143699003)(11063799006)(56012099006)(261026140227099003)(261022105027099003)(261028144727099003)(261026121527099003)(10067099003)(261021121427099003)(261009223027099003)(261102123227099003)(261022075727099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	G1hdvVrpH39STmB78ax+IPB+ZddtytOrW0MfXuMX2sMltPgJM1l/Q3tR+ixPRy+cOTWypF5NL9T9QIeiPbQ+3+aahA/ueY1Q6uiuk5DgPv5F0s0L1PBeJ23wnX+6L/qcCnU6v767H8qTOUWkBY/NDXtCqRK+C3+S1U2NLGbH+J2Jm4p6lFm9cOWWwQPRE2gq2qUDeGJcyVzt+l5qkMu8nNVM1dfYxC8mSrvHQgYZ6opxmWBtC7hUTVr5DA7i6rTk/wqmZcvT6eSYA1U72i66N/YEomVgKCGzzZ9ngjSxaDqdbg5ogvhg+o2keXoNtwPb/CJDC9ezFsoardANYdSWUpjI+E0yssjFbeT53M1vfce4s+Y3yp6erhsFIbUu4Qd1q37siVCptz26iBVLDrrnU6s4kdpeaMwFg46pY9IdBX3sxO5lsy+AQcUq1emPnoiA
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2026 15:12:27.3070
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c579ec23-26f5-46a4-c3e9-08df45865b8d
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[4.158.2.129];Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB1PEPF000509FB.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR08MB8272

Hello Lukas, Kuppuswamy,

On 11/17/26 19:57, Kuppuswamy Sathyanarayanan wrote:
>
> On 11/17/26 03:50, Lukas Wunner wrote:
>> On Tue, Nov 17, 2026 at 12:10:29PM +0100, Pierre Gondois wrote:
>>> Return PCI_ERS_RESULT_DISCONNECT when no upstream bridge is available,
>>> avoiding a NULL pointer dereference in pci_walk_bridge().
>> How can that happen?  If it can happen (which I doubt), why isn't this
>> patch tagged for stable?
> One way I can see is a device without a PCIe capability on a root bus.
> pci_pcie_type() returns 0, which is PCI_EXP_TYPE_ENDPOINT, and
> pci_upstream_bridge() returns NULL. Native AER never gets there. Only
> firmware-first can, through aer_recover_work_func(), and only if
> firmware reports a PCIe error section for such a device. If that is
> the case, skipping recovery for !pci_is_pcie(pdev) in
> aer_recover_work_func() seems a better fit than a check in
> pcie_do_recovery().
>
>> Why is it at the end of this series?  Does the series somehow make it
>> possible that there's no upstream bridge?  Which patch does that?
>> If the preceding patches are not the cause of a potential NULL
>> pointer deref, why isn't this patch submitted separately from the series?

To test this serie, I generated and injected synthetic CPER records.
The PCI device referenced in some synthetic CPER records did not
actually exist. In such case, the kernel crashes due to a NULL
pointer deferencement.

This use case is indeed slightly unsusual and unlikely to happen
in the real world. The patch was still included in the serie.

Please let me know if the patch should be either dropped or better
documented.
