Received: from LO2P265CU024.outbound.protection.outlook.com (mail-uksouthazon11021075.outbound.protection.outlook.com [52.101.95.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F13E233134;
	Sat, 31 Jan 2026 16:16:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.95.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769876208; cv=fail; b=FCfuVfLtze5mlysdwV9R1L6yzOWnl9s7xdqIXxJCnPEqu5ax8yvD9pzNcDX0Mwb6K0tSQNx0zWz7iI6ly357CA+R04eaOh86VN+UUKV9wWWAG7qcEgAn+byebRTJ+UM1s8vA8pLAE4U9Swd88Jc6HWW13L/bF3bstoA/Pa765Hg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769876208; c=relaxed/simple;
	bh=ihoPljyaZAdmWgIP4luDJ4JOLiUbiUbXp5Pn+OqPeE8=;
	h=Content-Type:Date:Message-Id:To:Cc:Subject:From:References:
	 In-Reply-To:MIME-Version; b=BBerGarrNAmOvc7FUAxsftEFK4IenyL8VYRwdnYPDySH7iZ6pCzYOd9fiI9li/78imfTWJA+3pX5zOimYBtjbLJVqrz8b57d8YV3Ek9cctEiAu3TJ5Wt/Qss8yDQHCEiemxQKHtFsHoA22hPhZmcE9/XzQXwRPdx7T4jqnOu8R0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=AaXWTcav; arc=fail smtp.client-ip=52.101.95.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="AaXWTcav"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tnriAFLpCNsKHNlt/s923xSKtb5o3Ujl8T0YAXNpbCB5GHFPS1eIaeaQBvimx+DPGpJDGvnCy7f///If+b0dpJof97AHrgKx/CiCcKsceeVtiCp0O544bodCKJbAw2em8gRM3hunbCZ6F95t1B7+aYdvdVXoxL3zIqhXy68r6WIxh56kc6il8TwScvsCnB22SdPocahoohybiwY4/0WzqkHESUmv2i2rCARyCnFV30N2QJGQAW9dAv9yunlgqfktgbWS2QBuvj89fxpoihtf4HQ4NIQG+2YIWoUww1NygxAh9Dd5uCQNxYSHxoMDYRgkEaHcplOmMV7SxPGCB51a+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BGC1Ow+2rW6qs0d9JoL9PwDS60Pttw1LJOP8et8mvJQ=;
 b=bcmY6rzMtEHCSCm/ggA2fXYMK/FPalPykW9CgzvDyASMSWeWEc7rSnQc6pRW0l2ZjcETJnj3HMzpBHV82fg/iLurWWPMWwAeoxqw5aiM+FENFzeDNxRYXbZz9ZaJo54ebkpM8FIZq3OB+oxyYjlPx+4/st20A+jdqNkAYffwbCVYLrtdScN/zoTXKCDkN76030gAipDnvg9rWP1//YDkpKWGH31iNB6mSNWc565i14SMxElrA/qWygGc6MP7nEVCg4xWQGdYvdDEJDDg0FVSA60bhPQMDEx2SzdayrMR4oz2IyCgOEid/pVaFMxTxEZbmwisDAxotOn+FwzefiqIaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BGC1Ow+2rW6qs0d9JoL9PwDS60Pttw1LJOP8et8mvJQ=;
 b=AaXWTcavttRulGPUzrFJex8ar7HM/2OFhkyq9yTEJizKanXU9x14sFjPlfedOxbVMfwjN60CJIcDwPti5q6pC6d7t/q9YtXXgQ7Ql3el8EMEy286Pk9d1TKFGsp1gx/UXLwAJqEPydrG22LIRZOfANOnTUEu2fpcd1gdqSDOKDA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:488::16)
 by LOYP265MB2029.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:111::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.14; Sat, 31 Jan
 2026 16:16:44 +0000
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986]) by LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986%5]) with mapi id 15.20.9564.014; Sat, 31 Jan 2026
 16:16:44 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sat, 31 Jan 2026 16:16:43 +0000
Message-Id: <DG2WR3EOBWCY.DU3K4LRV4FUE@garyguo.net>
To: "Zijing Zhang" <zijing.zhang@ry.rs>, <dakr@kernel.org>,
 <linux-pci@vger.kernel.org>, <rust-for-linux@vger.kernel.org>
Cc: <acourbot@nvidia.com>
Subject: Re: [PATCH] rust: pci: export ConfigSpace
From: "Gary Guo" <gary@garyguo.net>
X-Mailer: aerc 0.21.0
References: <20260131040232.1243049-1-zijing.zhang@ry.rs>
In-Reply-To: <20260131040232.1243049-1-zijing.zhang@ry.rs>
X-ClientProxiedBy: LO4P265CA0107.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2c3::12) To LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:488::16)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LOVP265MB8871:EE_|LOYP265MB2029:EE_
X-MS-Office365-Filtering-Correlation-Id: df786afd-4407-4e1e-31ad-08de60e42011
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|10070799003|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?N1BSNm9NSW1FbHFpNW5CbE9EK0ZkNXVyak9GcXlVUXhiVmszSGhnRzR6RlZJ?=
 =?utf-8?B?bFJtWWc1U1ZrdzVYUVFjb04rcVA3WkZnWkNYRWp6Y1hLZ1h1bWxIVkk5QjYz?=
 =?utf-8?B?cHl0Z0ZBTm9sVGt0RHl2MTl6bmhQZ0tWeWZRRXd1WEgrQW52NCswaDMweFpC?=
 =?utf-8?B?VFRDcW5KZzBPQTNpMU5MYlNzMHJ1NXpNWHhTSytZc0RZempvRzUxVnVyUURR?=
 =?utf-8?B?bDlxZlhZd2pDbU8wNm1aaU94alkrakRjQmVCOW5CQTQrUmlpWjlhOFVKZXZO?=
 =?utf-8?B?a1RiNGZQeHdKTkNGZjRKTUdKNjlha21BdTV2MlBtQlRsSmVzQWk5NVArdHYz?=
 =?utf-8?B?OVl3c3B1dEhzSjVtMXQ4ZXZjY0VUMmg4V291OEFwMjNMVmhheHkyd1dTcjNp?=
 =?utf-8?B?SlVGUVlvS3JGVjRRdS9WeWFiN0kwU080czVFeWh3QVdaMnEycXdBazZRZ2hI?=
 =?utf-8?B?SURJdWdUZWZWaWlSM2ovaTNxVGl2ZkhBOUhiYkVhMjR6SDRiTllKUHUxYUJm?=
 =?utf-8?B?anJqRWVWbTA5cEtRcjFwTStGMTBDc3hIREFyRUdMZ0YrUGVXZ0VjK0xqUGhz?=
 =?utf-8?B?VFErNFF6dVhPbDF2TTA5RXoxcTRZVmc3YWVpZmNLcWE1RENSQXVxaEhmY2VV?=
 =?utf-8?B?VDFwaGZmSWhNcUoxN1NJd2FxdGlwK3ZJeXE4SlI0NVdJQWtRV0dHZ2lndy9L?=
 =?utf-8?B?UDdPR25HNmZnMFVDMXZYRHpwV1VXcDVjMUpWNEZrOFordTU3VENsODU1ek13?=
 =?utf-8?B?OTA0VytLM29kRGQwV3M3ZU4rTTI4Q3VGanhueFdQR0pUZHp4VnRKWlp2b0lJ?=
 =?utf-8?B?MVZlenZkajMrb01BNDdhK2hOalVMSnhwZWhyNGZiVHBnbjY1KzlNZEpXNjNw?=
 =?utf-8?B?OGg5aDRrd3NtczBjR2IzcjkrcmpKd3lPOGdJamR5YmFLelBTM3R0R09HOTJm?=
 =?utf-8?B?dzJ3T1A5UGpneEFBWEgrSFhUWGFVNENxUnpHZHNXNjFNdWtNcUZDblJoQ1gz?=
 =?utf-8?B?RzFuOFNWUGluaDlnT0pqM01DUW1YdVpTQTV5aDVWamVjbjB2RmVQWVJpL1hk?=
 =?utf-8?B?UjBiRWF4WXVvQmFiTklBOU9jRHpDbzRUSzdtT1E2VlVMc3B2eFdJK3AvUTdE?=
 =?utf-8?B?NjhBOHFTdUpROWN1RjJFQytuRGtFNUthd1ZubjY0b2N3RUxORHdXQnFRaTJV?=
 =?utf-8?B?UXpOS3NOZ3VnUm5HUGl3aURpNFpMWjZGUlFMYjZ2OVdVWEw3T3Nzb0orb1Fk?=
 =?utf-8?B?S0dSQks4MStJaEE2QXVSN2lSSnFxWWNmelFxU3gyaE8wWjZxd2JuV0Q4czQ3?=
 =?utf-8?B?bUp0MjR0NDJvbHU2ajZRYzRDM3pYOHZvK3FvM1IyQ2p6c3p6RXVueEMrbjRO?=
 =?utf-8?B?aDFtZzNJSm1lazBxRWlUSm5ncFdQUFRTd0RoeitsRUlpZVdYb0pYRndhazJa?=
 =?utf-8?B?OUwxQ1U5UUNSSUh4ZTdIQmtzd0N2M1h4dDF3dG1yNmJ4V2w5YXorZDhmVTM5?=
 =?utf-8?B?cWdyVWgyOVVsUE83UXU5Y3A4eVpaN1YySjJMSmRQTjdaT0NmVURhWi83ei9H?=
 =?utf-8?B?RkdFekxvSWduZW54VnpRQ21BVy9FdHlkZ1djYUgxOUljcUJveS8xaVp1R05r?=
 =?utf-8?B?Nzd6RUM3VTNudURiWjNWVXRyRVhPM2JqWHRIZWlHR3F6YVhxL0FYdkczRlVy?=
 =?utf-8?B?YW5VN3diWmxvMTUzQytDK0FsVWZjQWx0MU41emlnT0hCVnBpdjNIbWdPalhs?=
 =?utf-8?B?VG9LaUZUOFFYRUppWW9aQXE4VThDMmFvRTdVMHdsKytwRCt2SDdoWjJrRXdF?=
 =?utf-8?B?VjAxTk5Lbm11Nk12LzRBUHRhYVVFdDQyOUlHUDNpdUJ2UzQ5b2FSenFLZTA5?=
 =?utf-8?B?TUgzRlJGRWlYSXp2ZjlZTEEzU2pqRWpXc1NBUVgwSnRWbjVjUkdUQlpVRGRs?=
 =?utf-8?B?LzZPYlo4SlNlY3RySDErOGFpcUhSSmkyZVU1Vi9aSWkxQUI2Q1JTM1Y1QUlL?=
 =?utf-8?B?TEgyV0g2Y1FwUG01SlIrcC96ZlpRTWlScUtZN3YyOGlxNXpPS29WTFNwQi9n?=
 =?utf-8?B?WGhUbzF4RURlemZHU3BYQndQQ0pVZTczbFdKV1hyVVlGWUV4VS9BUHVjS1oz?=
 =?utf-8?Q?+rrn0IC9+YIgkHunSWukYKT3I?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(10070799003)(376014)(366016)(7053199007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NWhPczUzaTdtbTJwV05IbDRsUkY4Z0dPUStNMVdwSzBYVzVzYnByZm93RXdJ?=
 =?utf-8?B?cGJaaDB0U2toYkFoZlVkYkVuMnZRdDhrOStrQjRqT1U1YnRoUXc1eGRLL1d2?=
 =?utf-8?B?SnBlZW45NDY3UktTZGgrV0xWWW15eTBsck4xRXk2NWFKSHdmU1ZBR0I2UHM4?=
 =?utf-8?B?WVo3cWZJVDR5MFVEMUM0VTNQVTJhODlXbGROUjJSNHpJbHZyd1BnVXNQQk12?=
 =?utf-8?B?WUdOZG9xeklYVTkyOXZGQzVFSWZqZTZEcmV3alFETjUreVZmUnlzc0dURjQx?=
 =?utf-8?B?Szl6Mk1EeFVxMy9xbngwa01nZDJ6TjJxT2IvZXFUN1ZueWtHdlNVY1AxdE8z?=
 =?utf-8?B?TThkV1pUdEZSWVVIUU9obUplRmtlRkFrV1lIcm5LQTM3WWtpL1Jac0ZKYm1a?=
 =?utf-8?B?VzBUemlZUVZTaHQ4VzROZnRXczNjQWFGdjRpTkswSTRLZURnZVByNW1OTDFi?=
 =?utf-8?B?NCtDdnd2d0hzbU9BM1cwZm5uNjRHYWZCUC85MUVMU1BEN2R5aEUxOGU4YXpr?=
 =?utf-8?B?L2J0aXhrYWQzZmptN21Cck1xYW8xVUFqU3pkaE9LazhDcjZMOCtPbWEyRmZF?=
 =?utf-8?B?ajdxaS90Q3poSDBHbDN0WmZ5MTYxMis5NVA1aDRDUHlpVzM1SjllR3VzTWRR?=
 =?utf-8?B?T3YwZGVRbmorRzRGdDRXZk16VUtJOFBKNDhUWTljckpURXg0UTF3YUFWaG9n?=
 =?utf-8?B?K3p0akl5ZjB2YW9HaVA2aDFEUVhmL0d6WWJuYStLaFNXSW9wWkFvaUJLTmpr?=
 =?utf-8?B?UkRwdkJMOHVUNnc1Y29ZdXo3VktldDVEQXRtRzNXKzVvMGd1YkFOb2NNa2RX?=
 =?utf-8?B?b0Z0dWlQb2NMWGx3dGVORnlLTHlvMEprUUtQTENpVDRwT0wxdGswRmtONWUr?=
 =?utf-8?B?WjlqbTdGaWplQ2VzSHdoY0Z0cDBHZU15ZHhZVzh5Vk5FN2h6c3V2cU1pV2FI?=
 =?utf-8?B?eE96SU9wUnY1M05vYkw4QXFYVWx4bkl6N25BMHplSGtISVZVV25uZjB3VW1L?=
 =?utf-8?B?WGVHNTFSTGwvVWtGS1FhQ0phRzBSeStXWmtySkU4cksxMkExaHBFRDlHZ3p6?=
 =?utf-8?B?R29HdmxhelpvU0QwSDJOa3VXOTZtSXBGNzVaQzFkWmN1OFAzbHRaci8wSDhK?=
 =?utf-8?B?Tyt4cG8vWWpOVkFNVGNCUHY3V0J4NTJ0S3MxZ0NPQ2tJZ1gzeDlJNldrY0FO?=
 =?utf-8?B?NmpWN1lVUGdrSzdVeVRhMU1zTk15NjQyRkhGN2w5UHdUeURJYnpab1BXT3Iz?=
 =?utf-8?B?UytLbVA5bW9GWGZWZTRiSVFMSUlKclpkMVdhWkM3QlJ6dEZQVTVSUVlhcmdV?=
 =?utf-8?B?OUE4M0ZSSnhIZUVkV0RtazZndmFIRWRWRGhWUHcyNVkwY2h5SlVkY2RJVjly?=
 =?utf-8?B?QVhXckF6SlNDbWk5aWVwVzJZdGNyZDlmQmNvV1BrbHJkSVlDZU44RVQ3QW9n?=
 =?utf-8?B?NWVhNm40YWxsR3V5NFdWSGNmTlNkbGdZUEttK3NXZmcrbG9BZEljdXFtRk1h?=
 =?utf-8?B?bzN6T1NlUUZaa0ZQV3JPbU9wV3M3OVlLNUJuSGpxMnF2Q0M5Uld5L1g0eUgr?=
 =?utf-8?B?aDUyWDJtMnMwWDlicC9NOSs3am9kZzUxSzZMYk03RHlkT3hHTWtIWWVJb1l4?=
 =?utf-8?B?MDlQZThkM0JvdEFsTWNYMWRHYXliaFBpdG5XVnpSYWZHby8ySkdCaXJkQUlx?=
 =?utf-8?B?V0VBY29ISVpLYzFhYVJ4TDZzVmQ2bkw5OE11bmdHL1ZZMk5zdzgzSjVVQUVY?=
 =?utf-8?B?UXArTm9ZaGsxeDlZUXRHcFNUeGhxQm5lZkVvTDVTMlNOeTBCUENKNWNJK3J1?=
 =?utf-8?B?VDdIUmNRWWpZWTVlY2sxNzI4ME5DMUcwVzZXQVc0czVsdjJmdHdxYU1OTXZH?=
 =?utf-8?B?N2p6Sk1oUXRLWlZ1Y1NVc3dDZFQrWTJoTDFrNnVhQzl5WHB2dXpmUStxN1Uy?=
 =?utf-8?B?MmNSZGt1KzNBWnJCZ2pqWFBJcHRhVlVzWlFkN2RjdDN6R0RXcUhNdUx5TjN4?=
 =?utf-8?B?WTJUNGlZbGRNM0FCNHZyNm1CTmhUSnhFQXhXSjhqUEkxUlhYOVQ5VmJ0UnhM?=
 =?utf-8?B?eUtFRThKZlhJcklUR0dzTnl0MUsrdVFwN2NqQ3g1TjJnVnNCQXRJQTg0RW5G?=
 =?utf-8?B?SlJjUGlJR05PcC9BWEp2Z2Mrd2dHdDZQdHQ4OVNTditpQVZlbnJESlF0Z2w0?=
 =?utf-8?B?R1Fqak1QMXhvbG05NUNRaTlLNk5mV2NqNXhxVEpUNExpaXdJMnEyd0N4Kzlu?=
 =?utf-8?B?UnRPcmtmNGlZWlV0R1NzMGdoaGp5YkpzVFdrTUwxRFFKb2xpelAvaEhleVlI?=
 =?utf-8?B?REZPWVI5bHFZd1krTitUQit5NGg3UzBnTUt5bXErQk8zK0RFeUdPUT09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: df786afd-4407-4e1e-31ad-08de60e42011
X-MS-Exchange-CrossTenant-AuthSource: LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jan 2026 16:16:44.0555
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0uzoj0lIFkxPVOP2lQzyc46e2ctuFejXVwCNDdTXhytwGJ8RJbky1g9EBVoWiFmCd4j1+EiCaDECUGZ0MPEyZw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LOYP265MB2029

On Sat Jan 31, 2026 at 4:02 AM GMT, Zijing Zhang wrote:
> Re-export ConfigSpace from kernel::pci so users can name the returned
> type from Device::config_space*().
>
> Fixes: 4dc0bacb1d3c ("rust: pci: add config space read/write support")
> Reviewed-by: Alexandre Courbot <acourbot@nvidia.com>
> Signed-off-by: Zijing Zhang <zijing.zhang@ry.rs>

Please reference the initial bug report in tags:

Reported-by: Gary Guo <gary@garyguo.net>
Closes: https://lore.kernel.org/rust-for-linux/DG2D5ONS18FE.TC7K3O8V8SU1@ga=
ryguo.net/

Best,
Gary

> ---
>  rust/kernel/pci.rs | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/rust/kernel/pci.rs b/rust/kernel/pci.rs
> index f347c2f7c3a6..af74ddff6114 100644
> --- a/rust/kernel/pci.rs
> +++ b/rust/kernel/pci.rs
> @@ -42,6 +42,7 @@
>  };
>  pub use self::io::{
>      Bar,
> +    ConfigSpace,
>      ConfigSpaceKind,
>      ConfigSpaceSize,
>      Extended,

