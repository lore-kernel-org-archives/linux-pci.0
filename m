Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012024.outbound.protection.outlook.com [52.101.53.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E40532B99E;
	Mon,  2 Feb 2026 08:13:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.24
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770020036; cv=fail; b=qlJsDfrYw8XoSBf8ae+SYn2B2JhjpyCzP2hOSmCsOQzjaDhyvJllm/KvziXIKxLTnXJOyEiN8Nsf3pqnGZYoCCoalxGMSGASh3jVTuBef/4O2ddhDrHuKOtWPA1B92B4rQAW2AqfQrI+UG474PXcjxYFwedIHyK5QXHSE1TL100=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770020036; c=relaxed/simple;
	bh=rzE2Hku5WTNp7Lz1u1wmYFvLp/VwPqCr7RLy4WFgG+g=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=ANAL2quUrpqgDn0vbByBp1UYlWJw1idVagWGpeqA6R22taC9hgtvg8S8AHZEpe5lm28qhzwPRx1bQhc1lmWEX4k9jGnkCbon2H6ALofKOs/xK9n/86afElHpzissVj4kx1JViRa0UESXG9mkZgJf89FBmo2vFey1qvvgGwU47Rk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=OV25pgTJ; arc=fail smtp.client-ip=52.101.53.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="OV25pgTJ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MHZWTlJ7fFUDI3oC+WifUTcrhXkeDUAuEAh6grEBcbAq2R7BUTTn0fn1TWgEvaPMMl5cpf+1ReALk1ktz2RjUFuVJwN/Lsm9oA4D813TUmXNwA4aAAsptEFiAcZaeoCIpYPHp12m8cjLetCWB4lCKQEDpoLqq54ktfEAQilTskGEMuSWbxQ1RnKWXTpuI816fBpKNS7YArvzldbNLDuZPt67rDw5EaNnH+PMqwTpoNXG7BtjZmAvJNzMR5J8ntPRA+nkipxySmtLxQ+5+nFsuUqhNlpk1CEN7SW3WkZnO1kt2mI5OpGJcumU9aym7tr05uTrrW0p/lg7gHraqQvNiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GDgvOLh9GqN/5hFyj8uUysfDyxwPRORb2D5rgDAtfM8=;
 b=nDqe4NR5dpS9H1RsCUn4PKmrv+s8vZ5q7xDaPSQ+npArlHadSjogoxu9jTa0S2FSJVLrA1mAwD8+Ut4Dzv7/HMK20le8vBzSRadjMeJI2xsjAicliYeP5mXyM8lxRFBpixjKEmXYkpqiHQ1ZylDzGWzFYmWfNymFO3cmkkSNzXQhYMDFvrO1MEQFlPtuQsb4zvMS7UZ58YWTlcVwZZHYFW7Gp20mYkKiuMPItrvz3RacAhESpvEy2/FYicCyeLnZ2G0IKGQmA/nz+cIIBMM0KcdxQ8rn1Irx4wo32NGGUHEg17YMzvAldMNcIubZBdRj8cq8ettgUK31vpoTuXrXsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GDgvOLh9GqN/5hFyj8uUysfDyxwPRORb2D5rgDAtfM8=;
 b=OV25pgTJFDEogKmw1vWTQ27BmFr/6vhyXQmXgy86AxzjF2nelBvzsXeCt+yaO22IZJMv6LDFTgREgEQxbarlWVCmmPezzvtgyAN9VxW0d8DsgSil5V8ke2qLQC9SSSIYe++HIVMs1P2ExOd+CWZRt7GpgbhMuwsizD4bD3y/oVs04JatoxjbousFQmRMb7veh0KlvAHQSBcn1e3jnqMlsA0UZ85JzH++tkRSoW26WdyJ6HXVO6ycgX4+4AIE0GR2bfO2qtzH/1MCo0GW+NSiKDcTPAxpMsRtxIjny8kYXqIMHm3Q+3OpOFcqQHjxg83Q+JvXaXqWbXtRRNmpO9DE0A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by DS0PR12MB6416.namprd12.prod.outlook.com (2603:10b6:8:cb::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9564.16; Mon, 2 Feb 2026 08:13:27 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989%3]) with mapi id 15.20.9564.016; Mon, 2 Feb 2026
 08:13:27 +0000
From: Alexandre Courbot <acourbot@nvidia.com>
Date: Mon, 02 Feb 2026 17:13:02 +0900
Subject: [PATCH 3/6] rust: io: provide Mmio relaxed ops through a wrapper
 type
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260202-io-v1-3-9bb2177d23be@nvidia.com>
References: <20260202-io-v1-0-9bb2177d23be@nvidia.com>
In-Reply-To: <20260202-io-v1-0-9bb2177d23be@nvidia.com>
To: Danilo Krummrich <dakr@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
 Daniel Almeida <daniel.almeida@collabora.com>, 
 Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun.feng@gmail.com>, 
 Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
 Trevor Gross <tmgross@umich.edu>, Bjorn Helgaas <bhelgaas@google.com>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>
Cc: driver-core@lists.linux.dev, rust-for-linux@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, 
 Zhi Wang <zhiw@nvidia.com>, Lyude Paul <lyude@redhat.com>, 
 Eliot Courtney <ecourtney@nvidia.com>, 
 Alexandre Courbot <acourbot@nvidia.com>
X-Mailer: b4 0.14.3
X-ClientProxiedBy: TYCP286CA0364.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:79::8) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|DS0PR12MB6416:EE_
X-MS-Office365-Filtering-Correlation-Id: 696d5c80-1d80-442a-442e-08de6232f185
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|7416014|376014|1800799024|366016|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?amF3aHJrN1RjTGo3MUxtbVNydFdkQk1YaityRFIzNHduUzJORkpka0hIeE5D?=
 =?utf-8?B?NzgrWk50ZlpqaFlrdzdUTE53T1pNaU9lUHVWVlVUSFFrN2pXbkxXcUFxanlP?=
 =?utf-8?B?UVhtcWNwUDFoQk11QWljWVVQQWZhMTkwNUJrNTlTdU9ibWkwZHVwQVZSUmNC?=
 =?utf-8?B?cnFlMjAycVUzaTQyT0kyTDVReUhtT3hCMzZiNTkrb1B6aTR2ZDYzQ1JwYUtG?=
 =?utf-8?B?cWxFZjFzblRZOEx4UFltdzNWZG1RS1dGb0gyc1NMV3l0cG1jVTZZTHpJbnJB?=
 =?utf-8?B?aWorY1F0eGpIaGo2dkxXWVJRczdodUEzejB6MTZLWkhXTlZUazlBWTI2dEV2?=
 =?utf-8?B?d25BdEJCd2dDK1pZdzlOTE9nLzIvalQzRUVyTXQ4NS9CNFZYVlFiWmJOakdw?=
 =?utf-8?B?bTJCSktLYUx2amZYdWlDc3hhV3lwUUx1aEh5aUxJYlg3TGIySGxneEYwZmc0?=
 =?utf-8?B?UndCazlPZmdNQXFFQXpETmxtVmdoNUQ1THVSWVFPS3VsbjUxTHRLcnpFd1JE?=
 =?utf-8?B?Q2MzWEVLYkxpbkUyK083TW5oK0oyVVgzcVU1cnpjbmxFY1dUeVlYREVoTUVj?=
 =?utf-8?B?bEpJbWprdVRRSnZFR25WRGo2bTl4NjVPRWdJbE9qM0dLQUY4dnhCRnV6ZWRl?=
 =?utf-8?B?TkxkSmd1RGVuN0dOR3dyUjFoUUl6YUw2bmNWZmEzVWxyRHNrMjE1ZW5qbnlY?=
 =?utf-8?B?aGlnZWFOT2gzRXVVbEpmc2hhcFM0NDRPamhCQWpzWDk2RDlURGJOOHhUTmpx?=
 =?utf-8?B?aXFGR0xwaWUvODhveE5yblMzZkROOWRnRlVRdTM1VkVERUFuVVdycXc1ZXUy?=
 =?utf-8?B?QklHaHN6dTFaNmJlMFdSY2xWU3p5WDY0Y0NJbjRoZkRFVWhIK25yWndZK2t2?=
 =?utf-8?B?UERQYW53UVR6NWJzcXJhWDlCSzVna05TVlBWeENjc2I1N3BmaFRYeUVVVWVI?=
 =?utf-8?B?c3ZsTzVNbTR2OXBmdjBXNytDakNhMit4bUxyc1l6VnUzblhCMk95eDkramd2?=
 =?utf-8?B?M0pZQW52YzR0MFFXd21zNmdQNUwwdFZRdW42WVhCMUhvT3ZxdDF5SXlDZ2Ri?=
 =?utf-8?B?MkU3R1prdFpKZkk0QWxPTHd3Z0lGSjNWVlU2WVd5bUk2RTVwZ3h1TlJGMjZI?=
 =?utf-8?B?T2xoN2tpQWtLZDNVMmIyNnpqL05DZ0VqakF2Zmp6Wjd3VkNwb1Fnc2RGL2V6?=
 =?utf-8?B?TmI4MUl6dTlyNUJTaEozcjBTRitUL1JucDA3eldrYmxzc3ZDS1V1MlJvU0R1?=
 =?utf-8?B?bzdNVHJqRUV6SFduU3MydHkzOU9BQllmQ0NLRk9FTmJ3SHNEZEtHNS93MEpX?=
 =?utf-8?B?OGk5R0FCMEViZnlXbVlKeTUrWWxlaU11bWdOaWk1NkZoemFOdlNMR0NFZUdO?=
 =?utf-8?B?R2dmQUZRcjFJcVVlYUtUVExjclQxS08wK2RxZU8zRUN3M3lib0tNUlM0d3Nv?=
 =?utf-8?B?SUNmbForVWsvNlY1YXpuWlN6YkxNell6SVFFV1RkcXpiL1lNd2R2MFNWYk9L?=
 =?utf-8?B?M0MzRXJ6aG5yUFc4NUhhQ0IyOFd3Q2VBa3BYVkViMnZBNnBHSndRM2NZRkln?=
 =?utf-8?B?YjNRTW5NbTlOM1Nqa2YvcTZiNWh6WUd6bnVHZ1dmTnhkNVFtKy83ekl1WFFG?=
 =?utf-8?B?Qm43V20rVUtaWGZRajhybWg2M0pjUzdobTVwK3c1UDd2bkx0NXQ5OXd4amF5?=
 =?utf-8?B?dVFHU09aVDhXZ20vTHZxZWR6Tkd5V0lmWnExdXpBUVVZblBITmdjbFphcERm?=
 =?utf-8?B?SWRKV0ExdWl1OVBNZ29ldmtTVHc1dzlmQTdVcDM4dVoxNDZpajNQdFhLL2dn?=
 =?utf-8?B?S1BEYytoM1oxTmg2OVhBTDdwMHpmVHlkb3BRRjNtY296L0ljM1BLR2cwOUVa?=
 =?utf-8?B?Z3J6eTNROEpNODVHdC9samFkUG5wZ3dYaUhWS1M5QkhDSzBVQWZpcXBIalJL?=
 =?utf-8?B?cGViZldrV1NDd000V3hoczVHRlkya0lHWjl3TEpUcm9qckl2TytKZCtUZXV5?=
 =?utf-8?B?L1Y1TW9RRGZOcE4xN0I5RE1iYTFJNFl0RXJnb3RIbjdWdkVjaDJITk1jQ2E3?=
 =?utf-8?B?bHU2T2Y2OGhxdFNlcWFUQ3dVcXdBaEVsam13aUNBeC9EVGJmTmd1L3Y2Rzla?=
 =?utf-8?B?clZFOGZkRXB6VGhDWEV2dHFVVmoyU3kwVkt1WE85UUt3Y0VSMGZkQjByQVdh?=
 =?utf-8?B?QWc9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR12MB3990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(7416014)(376014)(1800799024)(366016)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Z01mUktoZHZ1cHR3MjQ1SkZiS1N3MTFuaFdPelFPeWl5Wm0wWXVzRlROOVBa?=
 =?utf-8?B?Vm1pMGpYdWZsODM2M3dXdU1nNWVQazVXdUQzYzNlekpsWXN2M2xVektETzht?=
 =?utf-8?B?Sm9DN3AraS9vN1NocnpVWXRhVXNmNlNNQ1pZdHhUWURNQ1M0dEJ5cEV1NCsx?=
 =?utf-8?B?OE5zdE9Ld09GMkJLSDZDY05MeG1pYXhGclJ2SUdHOVQxS3prZ2FpMmc5MkVF?=
 =?utf-8?B?TFBRQ01uZGZ3T3dpc3BDT0lzaWlKdXNjTUg0U0s2eVZSTUdjZmFZZXRlZE9C?=
 =?utf-8?B?RWF6TXg4V0o2djBXMWNBdk1CajdYVHVlN0FneEV6Sk03L1BGdjErZUdab05p?=
 =?utf-8?B?cHFzRmNDZnRXcVpnenJkY0VmVmpNaitSV1I5NVpMNllZNjdXU1IrRE8rbFB1?=
 =?utf-8?B?MkxIZ3A4eXhtS29OK2g3UmM4czhzbDhtRnpQQ0hlVlRjbFFsY3RCbGFWY3pu?=
 =?utf-8?B?U1A4cU9RWFhDVVRCVXZJeUVCTm5kRjlsMXk1UHU5amlBUktLY0FWTHJsYlZk?=
 =?utf-8?B?NWhnVlZtbE9xZFFaNk9oVUJGK1JWckdNWEd4eFJya0FNelFid3NyL0FvT014?=
 =?utf-8?B?UFhRTXdlNmp5a0lodWgzeUpOUmdPZmxKeTh3OEZTQTJXN3hLajlVbXJVd2Yy?=
 =?utf-8?B?R3pWbm50YmdPeTBhUUxzOTdZVWkzTERnWDByMHAwYkcwWmFobWJVc1loQzg2?=
 =?utf-8?B?QlBKS2IxeFBGNkRyZEhBWDIxdEdhT2JGSXljVm9jeHd5cDZlN1VqcWdqQnBW?=
 =?utf-8?B?MzdsZjAwakUweitFYk85T3BiUXlWM3h6MjRDbUl4dHl5ZmpIMFZicksyODlo?=
 =?utf-8?B?amJjblhWK3BibytaQmw1TUNnaGt3RlgyaGxobkdGWm5YMENpS1g3aTR6WWM1?=
 =?utf-8?B?Mkp1RUFqcWpIK0xkL2hkK1lKWmErSnpYWkJBVGtjTlFoVjZDTDJ4ZnhyS3E1?=
 =?utf-8?B?Ty9oMGNsZ0dORjZCRDBPQjVOVXFySFdzclcrZndlbnY3Rlo4ZEhTR1FHTGJl?=
 =?utf-8?B?UjlZWlJ1V1NYK0E1RUllRXRaMmc3SDByM3BMTnUrcjMxdHFVMzRyR0xKTTlV?=
 =?utf-8?B?NzRlQ3kxRk90NUY1SUlpS241YXZhUklOTlVxNHpnL21LVi83ZnlEcWl5RXBO?=
 =?utf-8?B?KzR3WHYxditkelBjNzBZcWxwSWJmdUlkR09rYktjUHM3UHdQS0UvRnJSaHdw?=
 =?utf-8?B?QXFzdFdlOTVIV0NOcUlPRGI3Z0xET21PUEluREgwU2IrTkQ4V2V4Z2xmUng0?=
 =?utf-8?B?SzFFc1d3bEl4bUVkSU4rbGM4YWcyMTV6TE01UDhnU2tXczRUeGVJYWNIdFd2?=
 =?utf-8?B?TWRtM0lobFI5VndsSVJBTCtIRkRqWTNXRHZJSkVSMWVFd3BvTXVOVUFJMFFy?=
 =?utf-8?B?cjVjejUyaVU3ZTBIK3o0L0tBL0srSlk5WHFSWHFaZ0tzT0g0Z1FTQ2J6VnA2?=
 =?utf-8?B?N2RhNGRuUDdETkVMUVV5TmJHcnUxOEVxTDZqbEdYcmR5UTU2NHl3K0JMYjhG?=
 =?utf-8?B?YU1RL0dFbWlTdklzZU5DYnp4RkRoSEJvODhDZ3VMamYyMEh3K0FqWE1uVlhv?=
 =?utf-8?B?Qk82ZUxLeFlIMWZkTGlVNEhSaktvc0hZbCtPcU95TVNDQjRnT1ZCWE5LSnhs?=
 =?utf-8?B?TTJHUkRiSUZxUmc0Mm1LRnVhNFRQSlU4TDhtZkF6d2NXVXZsbTNPZk5rWDBE?=
 =?utf-8?B?TlZEZXphVmc3U3RrQUVtWVFqbjdkeno2TWE4UVZMblJ6QVVsMzI4OGIzdTJZ?=
 =?utf-8?B?eXVwenhxVmJGNlhLeGVZdWY2bDMyM0ZTdDBjNnc4UUlNc252SWhFUUVXRmMw?=
 =?utf-8?B?Unl6R2RXL0s3LzlzaXpMaGJQdEErTjlaVW0xZkdMRjdIN0hPbTIwY3dTWHUz?=
 =?utf-8?B?aWhVQjJYd1hFeTNwZUZ6UDhzSHo1RTRTanp3MUJub0doeU41R0E4OEhjb2Fp?=
 =?utf-8?B?d2UyMkY5WFczcHUzTU45RExVbUQxdUdyWGpKU2hxS1IyZmVkZlR4cndXSVpT?=
 =?utf-8?B?VXdUaTRMVDRQQkxiemVEWXZVVEwvWUlXbXI3WlR3QWRXNU9JQnBJRmtQSXFz?=
 =?utf-8?B?VHkwZlJhR0NWNzBDbG1zR3JRV2lhZjlINDFuZjZkQUkxbzI2cUF2b3A0dTg4?=
 =?utf-8?B?VmJLNXVjRlhVTUNlenhleGh5SzBXVUZjNk13NUxJZ3hOYllERy9lc1FmZFRZ?=
 =?utf-8?B?ZXNmNUZ1SGt1cklJVlZlYTVDaUxkbTdHdzRNOXJ6SU5McmdyQW9mdHZ6c1Ji?=
 =?utf-8?B?M0pZQ3BJV2ZJbmkxeDcwYThoMDFONHVESDRCNUNxRkdXVk1taVVBZHk0Z2dJ?=
 =?utf-8?B?blhvMkVjWGw3UFl4dDltR2JPWnc1ekhFNHluVklHaTlNai9BcW5CWGEwUkhG?=
 =?utf-8?Q?SHJpipyN53yDSYVW9UnTmusfsX8SFpjAICCQby9XkIs5Z?=
X-MS-Exchange-AntiSpam-MessageData-1: BSfis+lnsgtTuQ==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 696d5c80-1d80-442a-442e-08de6232f185
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Feb 2026 08:13:27.4898
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9VQH3+8C+75lu2cm6LvMlvr244FA39f1UcR9pwYW05I5tNoKrWreuEvtKHcF/OqsK9JbRrlLat9VAjtLfmhBHA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6416

Relaxed I/O accessors for `Mmio` are currently implemented as an extra
set of methods that mirror the ones defined in `Io`, but with the
`_relaxed` suffix.

This makes these methods impossible to use with generic code, which is a
highly plausible proposition now that we have the `Io` trait.

Address this by adding a new `RelaxedMmio` wrapper type for `Mmio` that
provides its own `IoCapable` implementations relying on the relaxed C
accessors. This makes it possible to use relaxed operations on a `Mmio`
simply by wrapping it, and to use `RelaxedMmio` in code generic against
`Io`.

Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
---
 rust/kernel/io.rs | 66 +++++++++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 64 insertions(+), 2 deletions(-)

diff --git a/rust/kernel/io.rs b/rust/kernel/io.rs
index dc894a45bbcc..baa8d3baa20c 100644
--- a/rust/kernel/io.rs
+++ b/rust/kernel/io.rs
@@ -556,9 +556,15 @@ fn io_addr_assert<U>(&self, offset: usize) -> usize {
 
 /// Implements [`IoCapable`] on `$mmio` for `$ty` using `$read_fn` and `$write_fn`.
 macro_rules! impl_mmio_io_capable {
-    ($mmio:ident, $(#[$attr:meta])* $ty:ty, $read_fn:ident, $write_fn:ident) => {
+    (
+        $mmio:ident $(< $($generics:tt),+ >)*,
+        $(#[$attr:meta])* $ty:ty,
+        $read_fn:ident, $write_fn:ident
+    ) => {
         $(#[$attr])*
-        impl<const SIZE: usize> IoCapable<$ty> for $mmio<SIZE> {
+        impl<$($($generics),+,)* const SIZE: usize> IoCapable<$ty>
+            for $mmio<$($($generics),+,)* SIZE>
+        {
             unsafe fn io_read(&self, address: usize) -> $ty {
                 // SAFETY: By the trait invariant `address` is a valid address for MMIO operations.
                 unsafe { bindings::$read_fn(address as *const c_void) }
@@ -695,3 +701,59 @@ pub unsafe fn from_raw(raw: &MmioRaw<SIZE>) -> &Self {
         call_mmio_write(writeq_relaxed) <- u64
     );
 }
+
+/// [`Mmio`] wrapper using relaxed accessors.
+///
+/// This provides an implementation of [`Io`] that uses relaxed I/O MMIO operands instead of the
+/// regular ones.
+///
+/// # Examples
+///
+/// ```no_run
+/// use kernel::io::{Io, Mmio, RelaxedMmio};
+///
+/// fn do_io(io: &Mmio<0x100>) {
+///     let relaxed_io = RelaxedMmio::from(io);
+///
+///     // The access is performed using `readl_relaxed` instead of `readl`.
+///     let v = relaxed_io.read32(0x10);
+/// }
+///
+/// ```
+#[repr(transparent)]
+pub struct RelaxedMmio<'a, const SIZE: usize = 0>(&'a Mmio<SIZE>);
+
+impl<'a, const SIZE: usize> From<&'a Mmio<SIZE>> for RelaxedMmio<'a, SIZE> {
+    fn from(value: &'a Mmio<SIZE>) -> Self {
+        Self(value)
+    }
+}
+
+impl<'a, const SIZE: usize> Io for RelaxedMmio<'a, SIZE> {
+    #[inline]
+    fn addr(&self) -> usize {
+        self.0.addr()
+    }
+
+    #[inline]
+    fn maxsize(&self) -> usize {
+        self.0.maxsize()
+    }
+}
+
+impl<'a, const SIZE: usize> IoKnownSize for RelaxedMmio<'a, SIZE> {
+    const MIN_SIZE: usize = SIZE;
+}
+
+// MMIO regions support 8, 16, and 32-bit accesses.
+impl_mmio_io_capable!(RelaxedMmio<'a>, u8, readb_relaxed, writeb_relaxed);
+impl_mmio_io_capable!(RelaxedMmio<'a>, u16, readw_relaxed, writew_relaxed);
+impl_mmio_io_capable!(RelaxedMmio<'a>, u32, readl_relaxed, writel_relaxed);
+// MMIO regions on 64-bit systems also support 64-bit accesses.
+impl_mmio_io_capable!(
+    RelaxedMmio<'a>,
+    #[cfg(CONFIG_64BIT)]
+    u64,
+    readq_relaxed,
+    writeq_relaxed
+);

-- 
2.52.0

