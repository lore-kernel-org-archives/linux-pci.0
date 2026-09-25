Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010044.outbound.protection.outlook.com [52.101.46.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E2DD374E6D;
	Fri, 25 Sep 2026 15:24:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790349859; cv=fail; b=UnUCER9Iwu7cwOVm/GU34IRQb/1uQKLh32J3t4gAygJrmfgxleyZeL2KiZRRO4cJcx7c78/ITzw3H5vCbXM63fX0ncSitHve0Rjuts8I5UE/uigneNzdWstfIhYGaVnjQ4eh9zc3T7/FxqDQMMEEcXKfYRioJMi+wt94teTEo8o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790349859; c=relaxed/simple;
	bh=V61Q1/M8fccWI0w9s9Mw0olVHIdcGC1pTfbjgfzFc1Y=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ic5zv5k2wlWMEnT3hvcdVManNpFMo85Ilo+yJV1KfyWL6IR/TyU8Rt3M4YTKu23xfoXLiWuihbfnAnbWjYxIr2Woj97TLotU04nFiJOWbJNsnYgh6VK24+dkv8m/bGaLbgWbW6uAS66z4mji+tGZqWoIj6hpCXSAOlfF3pjpSlU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=SvqhGXlG; arc=fail smtp.client-ip=52.101.46.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="SvqhGXlG"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JlZPirRb14P8iEhPsMvyDcS/0r8C0J4Q9UcazSWnd44adK49ywYV1uhYlEc07MNRktQeFBUE2LAFBlAlD9kSPuOFx3qeh2utnP+hDD7X/6Ur+lWhCTuL4YrLB+rCzWG58ktqykb8gSKm/RfxNvdcHMmt276Wex2fzDy9psfKytLN+bS56SgPtiuemTJkyAnxBpwaqAw5CgmopaUiGcONgXx/Lq4bqlCK78ggaK/+8kTCTGGHXInWh0rlv2H27fz0Fthm+JKF6LKnssbcDS63egws2Zp3WBKvph1PsxmOVRlpY+fRJnOjBgmkkHIBpKw695bi5H6bMbyE8r00yWqpPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wFsRGbzTh9x1McXfLMb8NABCBjznJP8sRUMPZ3OsZ9U=;
 b=cdBxBkql3/tToD/KBT0NR/i3Z4IBzyVi1n5WRFK70V+UpjmygvTDh/3KZEfcoiArjeimWFn5xqHy7ukmEqT3KQsi4MYm6Hi0chHHBRMv7qladYYFCtvH0dygUZ0aWBqsT0FoHzGsav2meiifpShCjr6iJCTM20yeXIur52n5Ev07mGL2ysQqdMTnhNDjvNTb+BQzCgc0lb2Q1t2i4x/mmgmSG6ewruGYB2uDT7+aCbuupJDw4fE0/hh1LbMNyeSJXGA7aDbN9E6vO0xMQ79n0rb9DL2eRrW1U8mX2vyib8ynt/wTVX9dUm55vBMNSXgnL9JULlUR2LSPJQhbH7H2Tg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wFsRGbzTh9x1McXfLMb8NABCBjznJP8sRUMPZ3OsZ9U=;
 b=SvqhGXlG84ijUITV/Aq8lgiM7BoGt2oTczMtluXQPyeZs70mivpJ0AvBTQY+rdsSOF77ztUu6ZWDbw1e/6DVVyLVC6dlWhIkimjqAOmkDMJoChEBBGBDhWU5sr3HT7rQt/y/kud3WmvlAtdKWmqYsER2yngsHEtUohXh/eDwrmY=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH8PR12MB6914.namprd12.prod.outlook.com (2603:10b6:510:1cb::21)
 by SN7PR12MB8104.namprd12.prod.outlook.com (2603:10b6:806:35a::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.14; Fri, 25 Sep
 2026 15:24:13 +0000
Received: from PH8PR12MB6914.namprd12.prod.outlook.com
 ([fe80::2893:177a:72b0:6000]) by PH8PR12MB6914.namprd12.prod.outlook.com
 ([fe80::2893:177a:72b0:6000%7]) with mapi id 15.21.0451.014; Fri, 25 Sep 2026
 15:24:13 +0000
Message-ID: <7822cb02-f32b-4f02-ba65-4b90ebc42ce8@amd.com>
Date: Fri, 25 Sep 2026 10:24:09 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [BUG] PCI/USB4: AMD Phoenix 1022:14ef runtime suspend prevents
 JHL9480 downstream enumeration
Content-Language: en-US
To: Freeman Z <SHD-ISAC@outlook.com>,
 Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: "Kovacs, Alexander" <Alexander.Kovacs@amd.com>,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
 "bhelgaas@google.com" <bhelgaas@google.com>,
 "westeri@kernel.org" <westeri@kernel.org>,
 "andreas.noever@gmail.com" <andreas.noever@gmail.com>,
 "YehezkelShB@gmail.com" <yehezkelshb@gmail.com>,
 "rafael@kernel.org" <rafael@kernel.org>,
 "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
 "S, Sanath" <Sanath.S@amd.com>,
 "Natikar, Basavaraj" <Basavaraj.Natikar@amd.com>,
 "Martinez, Juan" <Juan.Martinez@amd.com>,
 "Chia-Lin Kao (AceLan)" <acelan.kao@canonical.com>
References: <f8b929da-b4ae-48ae-9667-3eb93aa0a4bd@amd.com>
 <TYCPR01MB10927E6DC71CDC3B39C26F35196832@TYCPR01MB10927.jpnprd01.prod.outlook.com>
 <BL4PR12MB9533BF5ABF7035E6DF151C0A9C832@BL4PR12MB9533.namprd12.prod.outlook.com>
 <eaaf891b-7b0b-4eea-b104-de2c0db7cb42@amd.com>
 <TYCPR01MB1092762E3E179C4A43874BBE696822@TYCPR01MB10927.jpnprd01.prod.outlook.com>
 <DS7PR12MB9550558C737D92A5762C3AAC9C822@DS7PR12MB9550.namprd12.prod.outlook.com>
 <TYCPR01MB109271EBFCFBEA8A8855D600496812@TYCPR01MB10927.jpnprd01.prod.outlook.com>
 <20260925052727.GV106095@black.igk.intel.com>
 <TYCPR01MB10927DEE310195FA62C67E9D296802@TYCPR01MB10927.jpnprd01.prod.outlook.com>
 <TYCPR01MB1092798A529672215ACC586BA96802@TYCPR01MB10927.jpnprd01.prod.outlook.com>
 <20260925115041.GX106095@black.igk.intel.com>
 <5d065dcb-a4b9-4e9d-aeee-8a9bd1d875d7@amd.com>
 <TYCPR01MB10927F1B586DACDC97FFB606A96802@TYCPR01MB10927.jpnprd01.prod.outlook.com>
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <TYCPR01MB10927F1B586DACDC97FFB606A96802@TYCPR01MB10927.jpnprd01.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH2PR03CA0019.namprd03.prod.outlook.com
 (2603:10b6:610:59::29) To PH8PR12MB6914.namprd12.prod.outlook.com
 (2603:10b6:510:1cb::21)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR12MB6914:EE_|SN7PR12MB8104:EE_
X-MS-Office365-Filtering-Correlation-Id: d50e6c30-2629-42df-50f6-08df1b190dad
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|23010399003|7416014|376014|366016|6133799003|10067099003|56012099006|4143699003|18002099003|11063799006|22082099003;
X-Microsoft-Antispam-Message-Info:
	OGXR/C+5oOQmMuFTKp7H1EhA1oa1KucgZuDph8BSaYkxQ/Z6L+zwkU9a8ZOC97B9OYSNVSrHtKY0XbXJWQ2S5Iteg4mQEa2eWlycmrmo1aS8+9mc6cJsCEQimey46r3zpwv5mszwsB9AeFgqS1iXZ46OUWLPAdkGJPjuuOjeuhjyS80xB89wtMJT6mUVXf2TOkToowQif1UHDya48UfubM8Wte5gpRn4EdbeUnhzCd+F/WlW4kThQYFJyrJK/i5rI1riPm9isG81tDdoRB1+2Nfg+u0d5x84BGBfvQKD+Gw+qd8yRJouFiWoouXaV2iRlShslPl7ef0xiFIM+Cuhotr+IRJJ+a9Lc4btIo285IxU9hfvm4SZdL7VGJZXugTsx6BScgOF3vi8PkyrAmkUr7rwxXJ4HjNZwgi8kvMQZjvaTQZGkZfrRsCz9NxlMokENh8Zoz0Qneb+1bJY72V7YrIEQb0yugGmweGJjKgJT8MJVF+5m1Ct3QorYxBKjLNM14G8ZKBY7E1gIVRPW0tEn3zz7apuNkLj2R3R0KsliJwsllZixpcdwneZ+vgCzBYhB7fMWDfHCKLznjPdZF/htYOJzNT1us3Keqfcsda1NzDWeB34YHjRmd6qBvJFwjF6Cg6WyeX31KpgDU/mMw14whYxhYGIjDr0lGk17foNcMw=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR12MB6914.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(7416014)(376014)(366016)(6133799003)(10067099003)(56012099006)(4143699003)(18002099003)(11063799006)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VXBHdkVzaGRUZWg1YVhJc0Z4aGk4Y1NiSnk1bkVDYk4xYXlOZ1RTMVgyMGVt?=
 =?utf-8?B?aEJxNjN5S0wxNkZDWVk0SkxPcUJDdHRsQ3Nsa25NU0h1V2RhNVphZVB5TzVY?=
 =?utf-8?B?aVlHbzV2amJVR0ZaSFdKVkR1aTMzS0tmVVIvbC90WVZuRmV3MkUxcmV4UGNU?=
 =?utf-8?B?TldvQlNCMFZiekdKZmJDWlBIdVBXbjlqWW5xTUJIOUJnbjY4akYrUmcxQmgw?=
 =?utf-8?B?VzNTOVZ1SVNRSkxzRU1ZMnpyaGFWdm56eXdkcSs1SzdlZnJpMTRVbnhFd2NY?=
 =?utf-8?B?UENFY3hGNDBZdFU4Zml6aWdVWkhWRzZCRjNqYTd4WFQ5YWhTRjFsTWZVaXBk?=
 =?utf-8?B?YXJKNlVsMUFtSytXQVFNek8rRUh1RW83bFE2TkFvZ1E4R0d1MUlMRlRHSU45?=
 =?utf-8?B?d1A5c0E5dGlqWjRWREZvcHpnTEFaRDM4bXl3ZzFtYVNWTFJFLzZsbkpTWVMx?=
 =?utf-8?B?ZlZ2ak1jd2pOb2JGSGdvcGtGenUxbnVWbG1GOTExYU5yZkQ4QkFubThwOGhm?=
 =?utf-8?B?eENiL3phdlV3RE1JRUlRaHUra1BaMTZ0eFZ0akF3S2gwMkUxRkNWYkZpc2Va?=
 =?utf-8?B?QjV2K3BkWVR1NDBtUHZPRlc0b0U0ZytHNW5hemoyczA0SWFjRThaM0svVzRO?=
 =?utf-8?B?ckRteldVRlY3STlNR1FENmVpOHA1Q2JvMk5KVlIyS3hyTXB4ZkQ5SjdOR2Zn?=
 =?utf-8?B?OGZVN0dwRy90R0tocEl1Y3RkS3hPREdsRWNEM0lXeGRDc2RDa0lVZnFFejRD?=
 =?utf-8?B?aGNjKzc1RGI5Rnp2MDJlWDQzYUpLYy9tMVlPb0hNV1Bsb3JwV01RR3Y2b0No?=
 =?utf-8?B?ZFBtbWQ2RmIyT0cxRXpFVzRpZFpUK04xWjFvTU5iMFBrNllYd00xaG02cmY0?=
 =?utf-8?B?Vm1pRkF0eDl0cnlNV1ZTVkl4b1lnZ2p5WGhxZGJlTDVUdGRkS2tsUTFLd25a?=
 =?utf-8?B?RmU5QWk0akw5dzRDSlhLRXIxQzc2NElqMTRLRitHd1FhVHZ1emtsZW52NVB2?=
 =?utf-8?B?UGhqcnIrcmd3ZEtpWmpaTVU2MFZNVDlWSURlZVlycEs2NHNmeTR4TVNRVlhz?=
 =?utf-8?B?eUVPeUlDaVcwVGkvRVBFWXlRVjRJRE4zMU5Hd0h1UXlFSkZEVHVqVDFEMkJy?=
 =?utf-8?B?RWZtUnJyZGFVMTA4K1NjOFFPZ1JNdS8zS0xJNHNjenBvSWJwV2JsVDMvN1BP?=
 =?utf-8?B?cmdiTVpMZjVERkVBNng2cnJoK0pHVHlLazNneS9YVTJ0UXJwK285aHplZGVN?=
 =?utf-8?B?OExrVW5PdVhyK3VENEdLOEt0UUtNT2dzYXFSVU1RZ0VlSkVweGxyWFFkQmZL?=
 =?utf-8?B?aytpa0tpZitIaGJ2WTBSemYyRXNubmlkcDdLUlMxWlZZOUlick1BYTFmMDZw?=
 =?utf-8?B?eUVlQ0dFc3lzQnhjUklBazVpb0YwZ21HenlCSmFsdlJxN3lYYUZUbi9xTk1U?=
 =?utf-8?B?ejRQZjJXOFhURWtzQ0dISWdzU0dUMWpkRjRyZUlzdk9lQVRDR2FBSm1TdFNG?=
 =?utf-8?B?bHRYS3lnbitRaUhLNHYyUkZYdWdmWkFqTGRRMVluWEVtTy83OExDYXZMQThI?=
 =?utf-8?B?cWJRNThPMEVReXowQmJnd0JLQlJ2R2NBWWw5dG9qRjY2UkFkcGVxN2wvV204?=
 =?utf-8?B?N21ETlduYmFmYkV0Zy9UWFdRc0g2WktyQzJUYmNsUnE1VGVJUmhiSG5TcUtQ?=
 =?utf-8?B?QzJFWm1kSTRkUlpLNDVmQ0cwd3UwV0hNZThzOWJMRUJyM1FHVExBaWRwbFR5?=
 =?utf-8?B?WmdVSm5YMzNWNksvQmZBMzhnTldSQVo1WEFVaFc5R0F1YXBrcVBQSitYSTNQ?=
 =?utf-8?B?ZXFGZ2RvMXdqMHA1VWM0LzZCc1A2a0JoSjF2b1QvSjVhTWdBQkp3eGE2M0lt?=
 =?utf-8?B?M3RlM29xeHM3K1Z4SEFpaDhqTmhTMzJFeUdvM1pKMXNlcEN0MkRIZG5rMjVv?=
 =?utf-8?B?UUlKUHRnTmxnTEZLN0V1UW1YdTRtS0dJL2ZQM0NMRnpudFhKSVF4VUNpcTJJ?=
 =?utf-8?B?RGkxaHJ1N0hHSS9taHZnNEh3c1dDMXNOUWJ6Rm5jWm5pWUR4OXU5TlRjWmg3?=
 =?utf-8?B?bkFNWnFKcktKN1lqa043Z09FZWlpOWRpSWN5a0pnRmVLVW9wM1plaDkyOGhT?=
 =?utf-8?B?SUtMT0dPRTZsM1BOT3VVcmNjVHNFbERVTTFhN2NUTkwvTnozSFgvSUU3cjJS?=
 =?utf-8?B?VU9NS1cwTWRGeVo4RlJyU1U0ZlQ3cU4vRkhKWTN5aEFhTUhOUHhHOGIrQ1FN?=
 =?utf-8?B?Q2Y1c2U4Uk8vMEd2MmRsQVNMWEI1YStHdC9YUE9ndG5ROXFPTHdpSHEzZlR4?=
 =?utf-8?B?dXhQczkzaDdZZzh0WFFJd0ZGY0owOFZhNi9OZkxCc2pOdzdpbndOUT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d50e6c30-2629-42df-50f6-08df1b190dad
X-MS-Exchange-CrossTenant-AuthSource: PH8PR12MB6914.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2026 15:24:12.9862
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: f8fyqsNCSf3bED92AOPi1kmB/Fx+tRNeofTCe/V6uHEdaPqQtM5sHVvP2Dm12D/ztyjBnkLKo3jQlW3fE8GnPA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8104

On 9/25/26 10:12, Freeman Z wrote:> Hi Mario, Alex and Mika,
> 
> Sure. Attached is the exact .config used for my unmodified Linus v7.3-rc4 test
> that reproduces the failure.
> 
> SHA256:
>      488899cc5a0b5f2de69466df2639e39769d40d90682f51690400399a549309c2
> 
> This is the final .config used after make olddefconfig for the v7.3-rc4 test.
> 
> The v7.3-rc4 delayed-rescan test that succeeded used the same configuration base.
> The patched kernel was distinguished with a different LOCALVERSION.
> 
> Please let me know if there are any other platform or configuration details that
> would help align the reference-board setup.
> 
Thanks.  Can you also look for a BIOS update on your side from the 
vendor in case it ends up being something unique to their BIOS?
