Received: from OS0P286CU011.outbound.protection.outlook.com (mail-japanwestazon11020112.outbound.protection.outlook.com [52.101.228.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A910E1A9FA7;
	Wed, 18 Feb 2026 04:47:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.228.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771390059; cv=fail; b=LVoNL6g8E4AY7oVgS8cuZpYPpfGzFinDXz6ZcWxfQ0YKabFcUNTit08t8e6X8zEaEF8g0xucIZpWoUNzNhykYDqR6AGBnyHOz91N1qCHE+NBp1EIGSDdlamhjhtzoW3TcX0S1mWrMhc/m4ZtIP5oN24QAKI6YLrxicwngECbaGE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771390059; c=relaxed/simple;
	bh=Sfzk62QKSGnqO7/WUbZk9U+YN7fxQJ6w6vSkB2WpUx8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ev+KhxPB4bnzWbl/XpDtXDEoRg9yKMQXbvzwVrjt6IlK8f5l+reE+b5oJPLDiv6mQ1TVUBdAS/C3kR2efKKl1WqN1VTv9djpwnYkOtEwJecXpHduSI3uZd/RWSlHbH2Jp8kLVGiSoK6VcYYsoqwxghx5T4OiRAHxTGOWCD4LqsQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=Za7p/lT2; arc=fail smtp.client-ip=52.101.228.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="Za7p/lT2"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NRWLFrEkNpklSyJKIuBatq25VLXFQun7jqzV5vD0xjQZsQaBReby9DYiXHCf9mRnaeeSLf0nbTOIS7T3m2GCdQZeGueuB3VFDZmMa1br9NT/moLg7++sRfsxbHaKrRHNvKqsjMee1Wdekq4MAKZPytge/2Wwe9oyHEELAZKTQiSlS4suGAZSE86hs28Mam3YWPKCCd5OHqzZTIAShkTHLStvE2CQq4LrWA4uY5KfHw9crZVKGPg+54B26vkuUEO5WJqypUF1rl5BW1/JtSAkCfxFM1ZxUQh1HyNVlsXjzrzvF0+mfIpFqKaARGuV0ylhhFlxIbSoVTo2sS+dbWuhIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N86OmXSXH8lHvHmTSRMI1qEsQOFtrb+8FF3ZCaETadU=;
 b=GIUQ0w+JXpcwOJzyjc22ECoGEUoMeIXv/nkKN9dE0j31IjIi7kcR8IFo4HVxD1Xpk1cT8xsSyfhpZ5BOYJ2reh+Wnr/mbMnjwFNhxUro/ekPiEA9I9H54mQcy3++afPgLlQEvzWJj9Wf0q6CyAhmVb9I85YujbjQEVmqSK+RLxU8crR0S1e/SJFZR0SsJU+x+V7aPpCnQh6Q7MSTgMV0rx0ccqf3l2dwae3WHYfLsHxUej2R3bFzd/fFIxZPvkCEmIEpKBRS/dt/9/RnEf+OcQGRs1CCn25FRrgRSKl0O3+8R+lQCHmunn5jqCG1jttUu+CDD8pahRmBZuL3Un6JPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N86OmXSXH8lHvHmTSRMI1qEsQOFtrb+8FF3ZCaETadU=;
 b=Za7p/lT25CyAh2Ho1xThTEnLscYhzeYDJFVlVDS0NeyexZD1hYra6kW34VDNr3mI5p94/9dSGZjw/sSme5A03Y7ICu53SQ6eGyxI1peBgTUVNIutpXbe8scqh4PynsadUlU99CdND5QDLZyRu5PLGS5BRT33MD/ILjT9FOUxONw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by TYCP286MB2701.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:244::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.13; Wed, 18 Feb
 2026 04:47:34 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%5]) with mapi id 15.20.9632.010; Wed, 18 Feb 2026
 04:47:34 +0000
Date: Wed, 18 Feb 2026 13:47:33 +0900
From: Koichiro Den <den@valinux.co.jp>
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: jdmason@kudzu.us, dave.jiang@intel.com, allenbh@gmail.com, 
	kwilczynski@kernel.org, kishon@kernel.org, bhelgaas@google.com, ntb@lists.linux.dev, 
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: endpoint: pci-epf-vntb: Use array_index_nospec() on
 mws_size[] access
Message-ID: <zyaurygtzi4qapq3n4lfcae7uahqumvdni5ojwcexpx2rbmbde@rzol5arwg7l2>
References: <20260105075606.1253697-1-den@valinux.co.jp>
 <n7griejk7mlutc5mdi6b3ysedn2dgcius43urhxnfohjeo32fc@d5gymxxhrutw>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <n7griejk7mlutc5mdi6b3ysedn2dgcius43urhxnfohjeo32fc@d5gymxxhrutw>
X-ClientProxiedBy: TYCP286CA0008.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:26c::15) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|TYCP286MB2701:EE_
X-MS-Office365-Filtering-Correlation-Id: 4c8f486d-948d-44ab-a535-08de6ea8d522
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|7416014|10070799003;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dkxvbXpMemtlbkVPWXgrSStDVGJRR2FTeVVuVjNlcTl3aGE2TjMwdVFtOFE4?=
 =?utf-8?B?K05BY2QrWHdZNy9RbmVKajNJRVFBd3RQblNWMFR5YmZ4Qkw5YzI1eHU4V2k4?=
 =?utf-8?B?UVhZMzliUjY2NS84YitqcUJRZTMrNHFpK3YvdjI2ZnFxOWFienRUc0VLbDRM?=
 =?utf-8?B?VTZ2WW5oZWJkaUU3MmswcWhCR0srL2w3TUpJSE93RElEVTUyWXd3QW9WOWNr?=
 =?utf-8?B?WVFPa05HQW1FWGpZN3NxY0VGSEp4YmlwOURhTkt3UXZpOTEreXdaZGxmbXpY?=
 =?utf-8?B?Wml1dmdpT2ptUEwrSTcvaFIxQmNTMmIrRXc0aHB0bHlOanB1TGVFWFVCNUR6?=
 =?utf-8?B?M3JONWorb1ExY2FWMms3TTRublZDOFNVODgwU04wSEZaVTA0OWJsZUhzeGhZ?=
 =?utf-8?B?ZHJOUHdpalU2b2NmRHhnTjY3UjRmeEhVTERiQllqcGliRHFTUGs0OFlCRHQ5?=
 =?utf-8?B?YUYvZVB3cU9UWFAveDA1Tk1KamxEZGc2T3NsakZsYWZUbmswZUtUZm5PK0RJ?=
 =?utf-8?B?T01ZYVBKSk1uT0NKZzhKbFhVbVB1YWlGU0VHREpENVdVNEZ4eTlNZHN2Q3Zp?=
 =?utf-8?B?Ym90dWhVQ3I3QXJLNmZsZWRxUWpHN2xUNWxsVUpBSk43bi9pV1drNllUOHc5?=
 =?utf-8?B?T2NONVFRZkZMQXh5RCtpQkpodkhSUmZjWkMxd3BsZmtpd1AvdHh6dkNFbEZm?=
 =?utf-8?B?aGpFZmo4THAwc04vbm9ubHNQQTZFbElBUXdnTDJtVHFVSnNVQ2E0eXp4N3l3?=
 =?utf-8?B?RHFEQUN4ODNnV29CMFhRRGRDWW1hWTNNUjBWVXQ0MmJaa2xZeW1pLzVlaXVr?=
 =?utf-8?B?QkV1dkJUdTd2SUp6d2NYc0RXTDkvTHZrRzYxb2tnTHN2YjVoSTBISi9sOGVM?=
 =?utf-8?B?bCtJL0NTcjJxTnVnOWhYcmpEcitCTzE2Ynd5aDEyekRUcGJpdHJORVlvako4?=
 =?utf-8?B?RnFmRy94bVpHSkl2QUFmOTVRZnZUU2hGOVNQTlpXbHRRRFpIMHFzeVNxYnF4?=
 =?utf-8?B?ajEvbEdESlVLZ2YreUVUTTg3ZkVaM0pnYkF3VzllckN2OTlrRkVkSE4ya0F0?=
 =?utf-8?B?RE41bzgwLzlWaEZBSWJJcmJuOFp0eHlZemhSUlozaHlHU3hXWjlnS0t5RXI3?=
 =?utf-8?B?YkFxRWtMN1lmQ2VNSFpsZ3h3M2ZaSTZPZlZVb1pRRVFjYjIvU0JVcWZSazA4?=
 =?utf-8?B?T1hXTXUvd2dwcGVjdENXM3FuWHFhZ1pPL1Rnd3YxSmt0R0xOYllHUXJkZFRJ?=
 =?utf-8?B?L0x2dnM3cUt4bk1GRmtxTGRxZHIrNSs3eDVyZGVsVWdHak9JN0UzRHpZMUdZ?=
 =?utf-8?B?Z0dLTThwVXBDN0ZSNHp3VXVNMklpd1h2ZEpwbjliWlVjQkxOcjMyUHFtamlH?=
 =?utf-8?B?aWFFNkNwQm5VWXhCb0dDcmFwdmtDUERFQ2w1eDM0a3VnWlFwclc1K1dHRmtK?=
 =?utf-8?B?Q1BZeS9ZU2NYNUFEbFBXTWxWbzFoYm9GNkhUZ3cwM0xrV1EwVkthMGZZRXU5?=
 =?utf-8?B?RWNSVVBlOE83ZlBCR3VILzcyaUxSVXNweGY3RmJBR3hnZUlsVGdueXAzYlI5?=
 =?utf-8?B?MUJhdXhlVk16c2ExaXdQVkY3c1hFQ0pJemZvS28wK0M5QjV5cUNJeEw3QkNa?=
 =?utf-8?B?VnBReG93K3dZYVo5a0h6K1owS2RkSVQ0VVQydVA3ODR4TTg4NnlpSGFzaG1a?=
 =?utf-8?B?T1RaWGlaY2RFcTEvRC9GbExkMnlBM09neDk3d2JNZFRSN1A2a3N4QnQ1Zkwz?=
 =?utf-8?B?ZXNxWVFLWEhrWHVFZHF2bVZUUXhNM2g5d21TQUdWZ29zY21GZUhnUWRKVkJZ?=
 =?utf-8?B?YStKZ3hEMms2aWdvcTJ5OVAxN2oxZ2V6WUQrNzYvWkRoaGFSYUxZbWduSjFh?=
 =?utf-8?B?VWF6SlJOcmVlWDhPbXR6akc3ek81TnBUSkQ4M080bEZwT2g1bXdnMkswT3BL?=
 =?utf-8?B?bVdFdUpkQTFKdWJPclh1c3RYMjNLTnlVSzVidWhLNFFvd0RNTlpzVkZoRG11?=
 =?utf-8?B?ajZNVWRRek9rOUNHZU9ZLytSZ3Q2VlZDb2R1SEZJZ3hhMDdUK0U3MTgyWkdh?=
 =?utf-8?B?cXdWSm8wYTMyUW1SOFZHMVY3SkQ2Q0VnTHd0S1BDVXIrTGg0R1Y0YUhTbEJQ?=
 =?utf-8?Q?51mM=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(10070799003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?c0N5a1dKbDR6ZFRKSXZZRjBQNTlIS2hMbzM4bm44WFliLzI3Z0paei9pN1po?=
 =?utf-8?B?aEZEMDdVQkY0ME1MUWJzbTJjOTRTV0RETFhJSUJObjN1YkwwTXJLaEc0RHNn?=
 =?utf-8?B?Tks2MllhOWRlR2pzOG5GcXBIdk5qQzQ3aGlvbFlkU1hYdDlpNzU3OUdiMEJS?=
 =?utf-8?B?Ym1XT01tckZMNTc4VU1ESThYTlIySGNZMzBRRGNJcS9BelphZzBuSmVBU2tZ?=
 =?utf-8?B?UkdrQXZ4UWVKRTJ2U25NcEhJS1UxeU9GUVozY25waWtnaVFXQXg2QU9ScFBp?=
 =?utf-8?B?b3VlTzJXbTFwemtzNEZ6L2loZm8vQVFXNGs3eGF2UkxLemVieE4vSXFuMkhK?=
 =?utf-8?B?amEwTzhLMjFoeTFWelUySW84TUdmNUpFQjhMbnUyLzJQOW9pS2xMM2NJaWw4?=
 =?utf-8?B?MXVEYzJUaEd6N2JhbGRmdnFVRkEwLzhDUTJCdDQ5TUR0YXFqdUc0LzF0dEFx?=
 =?utf-8?B?ODhXSE1yWnhFZkdPcWg4dVF3MHR4bzJnN0ZMLzFUVGJtTW41OENpTXkvMFVi?=
 =?utf-8?B?VDFBck84c1RTa3NGWU1qaXQrWmtZVlp4bytXRXZkc0RORWplV2pKQXB6c2hJ?=
 =?utf-8?B?QzFvVUJvRDJFZ2JtMzM2c1lPb2dBSlFpWkVBbE9Bd3huVktpVzBPSGFvOU5H?=
 =?utf-8?B?amo4enRGM3ZCb2dtVFUvS3o0eEFHMjBkdVlYOUdsbC9NZ0FXSkJwa2swWjlY?=
 =?utf-8?B?aHV3N0tPZjVXOHdFY3JsZlFlOGorS3dHK1RCZXdjeStlbVNzNjdhbmcyQlAx?=
 =?utf-8?B?cHoveEZ3Q3BBcFZDN2ZNL0FYTTk1bm82dURpaFI0NnJ1bmp1Mm9tRHo4cG91?=
 =?utf-8?B?OVJYWmJHTWdQTUU2NDVtem5xbUNOL0YrbXlXaWRRbm14d080OWhYSHVxN0Rq?=
 =?utf-8?B?RjRXQjRoalJTbWtyVFhYM3RwU2RhQkJLTlEwaTNodkpuSGhTS3hpVXBkT0VG?=
 =?utf-8?B?RDdFV2RMT3BUdlBIaGlXSFFWMXpCK0pvblhGU2Z5YUlTSjhUbnd5YVRDb3M5?=
 =?utf-8?B?VCtFVEFoZ1FBS3Q0Q2dkSUhvc2h1QTM5dGZQMkZ5TXdNVlVkYUxwNHRPWWtG?=
 =?utf-8?B?Ny9Vd1Rzc1lzVmJFS2x2VmNHY1dyeHNQR2JnWVZMTE9zbFNuOGdaSDJIRytG?=
 =?utf-8?B?U0tIdFJINmplRW42UU5KU0I3NlJjVUh0VW1Dd29UQUppUEtSdEhhUW5xdExS?=
 =?utf-8?B?bVV4UWRzaHJFbGZjN1YraDh0ZWZQcStBUUZZWW1JRjNkSURKbk9MTWpWSlVY?=
 =?utf-8?B?ZGtsbGtvM28zK0FLWElsTG5aMk9yN2RzWVNWRk9sVTlJWEpWVnpZbW4yZ0Q2?=
 =?utf-8?B?MVRmcExaQU1QcmJPM0RvMXF3ekxqZ0xGMTRObi9uTjhnTzcxNFI5RnFsV1d2?=
 =?utf-8?B?OXZobUh6YS91YjlVOC9zaUdhMEpFVEZYZVp3Y1lwNlduYzFyWmlYVlBSVUpo?=
 =?utf-8?B?YzhtdEVicXBWOGR1N2pER2ViNXdzdVFsQXlkdzU5YWIxQXBVMFpoQVBxY1RV?=
 =?utf-8?B?bWhIRW1OczVHU1BKdHE0K0dCdThza0x5M3pOOEVSMHdHTGNqSDB2Vml1VGZz?=
 =?utf-8?B?M2diSmpXSEdXTk85aFJNZW5KL1hRazM0RW1FajVTc05MU1NkV3M1QWdLc09x?=
 =?utf-8?B?SFVFQklZZzd2SGxMdHZFL3pRTW0xQWlVeG41WkJLcWsxUElWbkVvZ2tobUN0?=
 =?utf-8?B?L0lQUExvMWt1YUFGaU1XcUUxcHNHMFF3Lzd1bFRmYnk1NGsvVm5rUFBOT0ln?=
 =?utf-8?B?OW5vUEdrTmZVOGNzbWMrbkN3eGt6T21uaVF4N3p5WGEyMHJKSFhXb3l1clVJ?=
 =?utf-8?B?Y2kyQzBNTjczekhiMGI5Q25IekVFOHYvalhnQ0U3dGh2VGJ1bmx0a2RvWmJQ?=
 =?utf-8?B?UE9SQnJVbUNmM04yM0poK2xNNzBCODNDWktoWlZvTUM0RUtRcXZyWHliS1Fr?=
 =?utf-8?B?eE53QnRCTlFDUmlyM1A1eURud0dCSGNTcnQ1WWJJRGlid3lSRWpHdEpMUXdy?=
 =?utf-8?B?UW0reGZMMTJSVEQwaTB2QkNaWjJVVU1kUzdhbmxPbEFsSFM3dzRkb0lCUTFR?=
 =?utf-8?B?dDA5MEp4TTdZSjVuaDdBM2hEQ0VuZHRsK2prNEZ6Y1FYWkxCMG5NRzJWeXhn?=
 =?utf-8?B?ZlRzK2JLUnA1amlJOFZvM1VRUm5ZZFo2VEhnemY4TmlOMWlxWjJoWlRQTkxF?=
 =?utf-8?B?UFZTQzJRL3hiRTRmQU85SHprbjJDUUJ3OTlvTWRvcEI4dUhoQjd3ZEIyeExG?=
 =?utf-8?B?cy9EWDk2djl2aExac1Z4WE1qK0JmaHFIRTdoaG5qRFo4OXo2QTRRaTVoMmgr?=
 =?utf-8?B?cWRpU3ZoUm9MbzQxdDFjbEdyUGxTY1lXTEl6SFlPTWZvaCtBWGlFUU4rRldh?=
 =?utf-8?Q?/AbTX4WMXcCTkTQqPNHhXNp7xXR3LNTIv/F//?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c8f486d-948d-44ab-a535-08de6ea8d522
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Feb 2026 04:47:34.3690
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eDL5Jubc0q4FzDGEXPffndE4mehoe/dQXzWnjUVMhSjyjzOUP04vwvBcicREltyt9243Ix360g5JKbUNeVbG1A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCP286MB2701

On Tue, Feb 17, 2026 at 07:20:23PM +0530, Manivannan Sadhasivam wrote:
> On Mon, Jan 05, 2026 at 04:56:06PM +0900, Koichiro Den wrote:
> > Follow common kernel idioms for indices derived from configfs attributes
> > and suppress Smatch warnings:
> > 
> >   epf_ntb_mw1_show() warn: potential spectre issue 'ntb->mws_size' [r]
> >   epf_ntb_mw1_store() warn: potential spectre issue 'ntb->mws_size' [w]
> > 
> > Also fix the error message for out-of-range MW indices and %lld format
> > for unsigned values.
> > 
> > Reviewed-by: Frank Li <Frank.Li@nxp.com>
> > Signed-off-by: Koichiro Den <den@valinux.co.jp>
> > ---
> > Base: https://github.com/jonmason/ntb/commit/68113d260674 (ntb-next)
> > This is a spin-off patch from the following series:
> > https://lore.kernel.org/all/20251217151609.3162665-2-den@valinux.co.jp/
> > 
> >  drivers/pci/endpoint/functions/pci-epf-vntb.c | 24 +++++++++++--------
> >  1 file changed, 14 insertions(+), 10 deletions(-)
> > 
> > diff --git a/drivers/pci/endpoint/functions/pci-epf-vntb.c b/drivers/pci/endpoint/functions/pci-epf-vntb.c
> > index 83e9ab10f9c4..192dd4f4de8d 100644
> > --- a/drivers/pci/endpoint/functions/pci-epf-vntb.c
> > +++ b/drivers/pci/endpoint/functions/pci-epf-vntb.c
> > @@ -876,17 +876,19 @@ static ssize_t epf_ntb_##_name##_show(struct config_item *item,		\
> >  	struct config_group *group = to_config_group(item);		\
> >  	struct epf_ntb *ntb = to_epf_ntb(group);			\
> >  	struct device *dev = &ntb->epf->dev;				\
> > -	int win_no;							\
> > +	int win_no, idx;						\
> >  									\
> >  	if (sscanf(#_name, "mw%d", &win_no) != 1)			\
> >  		return -EINVAL;						\
> >  									\
> > -	if (win_no <= 0 || win_no > ntb->num_mws) {			\
> > -		dev_err(dev, "Invalid num_nws: %d value\n", ntb->num_mws); \
> > +	idx = win_no - 1;						\
> > +	if (idx < 0 || idx >= ntb->num_mws) {				\
> > +		dev_err(dev, "MW%d out of range (num_mws=%d)\n",	\
> > +			win_no, ntb->num_mws);				\
> >  		return -EINVAL;						\
> 
> This should be -ERANGE, but in a separate patch.
> 
> >  	}								\
> > -									\
> > -	return sprintf(page, "%lld\n", ntb->mws_size[win_no - 1]);	\
> > +	idx = array_index_nospec(idx, ntb->num_mws);			\
> > +	return sprintf(page, "%llu\n", ntb->mws_size[idx]);		\
> >  }
> >  
> >  #define EPF_NTB_MW_W(_name)						\
> > @@ -896,7 +898,7 @@ static ssize_t epf_ntb_##_name##_store(struct config_item *item,	\
> >  	struct config_group *group = to_config_group(item);		\
> >  	struct epf_ntb *ntb = to_epf_ntb(group);			\
> >  	struct device *dev = &ntb->epf->dev;				\
> > -	int win_no;							\
> > +	int win_no, idx;						\
> >  	u64 val;							\
> >  	int ret;							\
> >  									\
> > @@ -907,12 +909,14 @@ static ssize_t epf_ntb_##_name##_store(struct config_item *item,	\
> >  	if (sscanf(#_name, "mw%d", &win_no) != 1)			\
> >  		return -EINVAL;						\
> >  									\
> > -	if (win_no <= 0 || win_no > ntb->num_mws) {			\
> > -		dev_err(dev, "Invalid num_nws: %d value\n", ntb->num_mws); \
> > +	idx = win_no - 1;						\
> > +	if (idx < 0 || idx >= ntb->num_mws) {				\
> > +		dev_err(dev, "MW%d out of range (num_mws=%d)\n",	\
> > +			win_no, ntb->num_mws);				\
> >  		return -EINVAL;						\
> 
> Same here.
> 
> - Mani

Thanks for the comment. I will send a separate patch for that.

Before doing so, I have a quick question regarding the routing of pci-epf-vntb
patches.

Commit e4fe2a2fc423 ("MAINTAINERS: add PCI Endpoint NTB drivers to NTB files")
places pci-epf-vntb under the NTB subsystem. However, I'm not entirely sure
which tree (NTB or PCI EP) is expected to take changes to pci-epf-vntb.

Should updates be based on the NTB tree or the PCI EP tree?
Sorry if this has already been clarified and I just overlooked it.

Best regards,
Koichiro

> 
> >  	}								\
> > -									\
> > -	ntb->mws_size[win_no - 1] = val;				\
> > +	idx = array_index_nospec(idx, ntb->num_mws);			\
> > +	ntb->mws_size[idx] = val;					\
> >  									\
> >  	return len;							\
> >  }
> > -- 
> > 2.51.0
> > 
> 
> -- 
> மணிவண்ணன் சதாசிவம்
