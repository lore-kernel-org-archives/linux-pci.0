Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012060.outbound.protection.outlook.com [52.101.48.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 446CF3E2AB0;
	Wed, 26 Aug 2026 13:32:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787751180; cv=fail; b=XOVxHsjtKIm3A4EjXLS5kPUtK6tG6qQLaa08x7m9W7THjMWpIHm/0FGMYEVX/38G51KF6VmPHiI3mycn6XPeX0i1Z4q6TzUOYh/nVBS9vDrYI8d5Ejvfer7Rh2LndX9qZWeBJ+agtlXAtTiMz6wgQAHYLYCerte7vUSTGlXfSp4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787751180; c=relaxed/simple;
	bh=XDg2u9a+kmq7ovDoqslxbZHup2hXHJw3oAWCFGlqw4s=;
	h=Content-Type:Date:Message-Id:Cc:Subject:From:To:References:
	 In-Reply-To:MIME-Version; b=t1+vQ+Ae2k4Ip9PQ6CXih9oVPjKyK8VNPhah5TzwABFWcVbXf3Ojo0KIUt2EdGtbRnVNnKMh8SBMg+W6km8/wpy+X8iwSnjqg6BX0szV9PNQFtSLLal0+P/CjLJkW35b+E01HA53KE/Pg1IeqTLQe7rUNfnn92NzNcCLn0zPwAg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=cHq6AMgU; arc=fail smtp.client-ip=52.101.48.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="cHq6AMgU"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gWA2zrM+9k+SfrVX1z064QOQUpfcbov3B6cN93NMTncgtV/RHhGr0B6XEf3YcD1cgm5o8loNPxLLzJkt+tPtv2s+iMRywumQ25VzJeTwQiRwZjSL8gaj6UO/xqdzMDnFbCiIEWV1haMNCARc+lkv/KqPrGbyd2IZAxnc7Nrrpwyjq0Cp5f04v9VjTyHCO5X4wzwFucuMSQh0xwAVOYjARUTbHc4KzLbOTcQJz58VWPtyTBVukm0WUw712D2KOS1kshoQV02tSxEjOsDf2Ow7sGSYx2Bt8w2NsTBHS34121qKfoTTneVNoubJ9kGwd3Tu8bcrpPBEVLHSzfyo+7rtGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jYnW/qRoFwUtACCpyL9SyGvXCmYqia+QuRioMZvhPhI=;
 b=rNkHKjoVsp/BDAApuJS7oAuBZjueZbl/K6UErD59zbFrsZXqbzixHZwsGfgKnwxVWuCCk6wuYJ6ydvFas6eMgeOrUgmhQJL2wMgDu8wATpVpNGDijpt54u3sWMDQZj+jq7ft9Fzts3kJG8Zm3rtSmQwgAxJ1UfwpnOdBLAGrJgO221yXfFv6eve/jQJOgm/7QjPmgk7u6c/GFfnOLBL5sm68F1vcaGCmL2AklPbbgZQGXr5+AwazpPdjAnepCgnVpLgZHUH9LMKdLLf3obLy+A36BNMrOK+OeAY2mRI0D5tmXgCO5a5Z56RG9teBXac7EOsi/SV4cr6E9+aDlWgZbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jYnW/qRoFwUtACCpyL9SyGvXCmYqia+QuRioMZvhPhI=;
 b=cHq6AMgU67pL9LN62p7geyzq+tDbFxFCDAKJ2z0kl1D1Kn2TIPSmfgRitPH4PXeC1dSwP35xEiRnkI/tsxIYXclvofdCANmw90U+qUU/heS0wmJq2bOtI1TAjcR8ViVmXVXi3WFeQpG1ahUlQzEAeg6XjFyEOS7ULSl1ROEA+fS/YRFOazqRcMcclOEunmGr6CQST6zZReQ5LX5EXYLFrD6ddT7b3pw4HmtON/jGSYrD7j+Ryat2IkPdnqbU1cmLmSUIFfY94fLapFxy+avbyxxBxPgzjq8e4GkyuD8KqToUOv10xPKkfAzK/sB/Q16D8oMGXjpwRU5ZbFRAomiXNw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MW4PR12MB6873.namprd12.prod.outlook.com (2603:10b6:303:20c::17)
 by PH7PR12MB6468.namprd12.prod.outlook.com (2603:10b6:510:1f4::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.7; Wed, 26 Aug
 2026 13:32:53 +0000
Received: from MW4PR12MB6873.namprd12.prod.outlook.com
 ([fe80::a338:bd2c:3a38:ece1]) by MW4PR12MB6873.namprd12.prod.outlook.com
 ([fe80::a338:bd2c:3a38:ece1%5]) with mapi id 15.21.0315.014; Wed, 26 Aug 2026
 13:32:53 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 26 Aug 2026 22:32:50 +0900
Message-Id: <DKYWWDNN9XXG.1GQQDSN3NWVLH@nvidia.com>
Cc: "Zhi Wang" <zhiw@nvidia.com>, <rust-for-linux@vger.kernel.org>,
 <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <aliceryhl@google.com>, <bhelgaas@google.com>, <kwilczynski@kernel.org>,
 <ojeda@kernel.org>, <boqun@kernel.org>, <gary@garyguo.net>,
 <bjorn3_gh@protonmail.com>, <lossin@kernel.org>, <a.hindborg@kernel.org>,
 <tmgross@umich.edu>, <markus.probst@posteo.de>, <cjia@nvidia.com>,
 <smitra@nvidia.com>, <ankita@nvidia.com>, <aniketa@nvidia.com>,
 <kwankhede@nvidia.com>, <targupta@nvidia.com>, <kjaju@nvidia.com>,
 <alkumar@nvidia.com>, <joelagnelf@nvidia.com>, <jhubbard@nvidia.com>,
 <zhiwang@kernel.org>, <daniel.almeida@collabora.com>, <tamird@kernel.org>,
 <work@onurozkan.dev>
Subject: Re: [PATCH v8 1/1] rust: pci: add extended capability and SR-IOV
 support
From: "Alexandre Courbot" <acourbot@nvidia.com>
To: "Danilo Krummrich" <dakr@kernel.org>
References: <20260818084633.1673214-1-zhiw@nvidia.com>
 <20260818084633.1673214-2-zhiw@nvidia.com>
 <DKYU6ELNN060.154BHE2QG442C@nvidia.com>
 <DKYUBX3TU66J.1P5UZ908CCKBX@kernel.org>
In-Reply-To: <DKYUBX3TU66J.1P5UZ908CCKBX@kernel.org>
X-ClientProxiedBy: TY4P286CA0102.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:380::16) To MW4PR12MB6873.namprd12.prod.outlook.com
 (2603:10b6:303:20c::17)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB6873:EE_|PH7PR12MB6468:EE_
X-MS-Office365-Filtering-Correlation-Id: e1be6da0-bfaf-45d9-f3bd-08df037687aa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|23010399003|376014|7416014|1800799024|366016|10067099003|4143699003|11063799006|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	2df5+lk6JomWWU4ggs2UNnM/MZLXn05GQzZsUC0WleUL1wpmmkpEaLgUWat+6qtdKZGdRRzSok9s0dxlC/rQdn5VF7F6989j0Wd5jClS1tMNgybaAJtHSKyT+qVuYTRYvh02Amda1v5nmAxLhMigaUUnVStYd6R2uajNc3m6gXDES5IHSmvEVo36xjOaWJ9jboS6hDT70hZvbNt6uf+BbcHNHL+7JQl7sCOOGzC9qVqmp5+RIudqLZEY6u4eJaN5qva+UiuUtHPgxevNBMCkXE7GYjuA6CU+9/EDcqDonX/qpyn2EiuhIJocmLgbB7fagiwMJiA5v++JIUhfccsMW/a2sOZZJdBkVMft5QyZ3FIZhuKwzscpZhVP0yiwYWU1kOFIDqlhd4ZlWtruBZHOrTIBZ+aRKw2JrNIOaSyIe0UtpLhSfxyFcZk9ncPSxpMnchmLCGm4geFZF8cM8Xpd0Uh+r7FxSyJgN1oD7RmTIY2x9NVxlDuZKPOoONGwLT+AG+d1i/adZfK5k0ek4LkeBgPKDQA5ate31EEn2ObY2Y0oxgICT+1i9S3d/D74irAMnslcOVdzvEGPIwExg3u5fZDOIiGrwr236jsZNXgBWrzoLblBc37Yi6Rqd7cdpLLY+RV8QNrNcnjud/xkXwnzWR9hJJ764Z8hrda70LPFz+8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR12MB6873.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(23010399003)(376014)(7416014)(1800799024)(366016)(10067099003)(4143699003)(11063799006)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Wm1hekJPZGpvNXRxd01uU2pOZ2NBTnVjVGR1K2F5dVhpSzRzMzk0UHh2SjFG?=
 =?utf-8?B?Z3hUU24wNG5RRkdWU0NYT28zRUM3dk5GOVlWamVaSE5WbFFXSEpSVkxnOVZT?=
 =?utf-8?B?T2NqeU9DYWV0akorUUpjZWQwaDR4TEo4NnhXR3lpYlQ2U0huR3pVVFUvQkZs?=
 =?utf-8?B?cmY2U0lGOHMwR2hnZ0pnbHBKaDJacEhkblFGVklaRXZmbEVHNVdQV2JaYzc3?=
 =?utf-8?B?bUVaS1pSSXRhQUZUdkdqYU1TNXhnbFNkeVhyWFVGbGVNdFBGOXpCd3g4bjRC?=
 =?utf-8?B?TlFxWWx1amhXYXZKaW85bjFrRUdUbThLU09OMmJqMVJCVVJzZjhabDdwOEdt?=
 =?utf-8?B?UXYySUZxR1BjaFRwTmZCZ1EwczV3MTd3Q2hLTXp6cHlSRFBtSDBGYVphNlBp?=
 =?utf-8?B?QmppU3FRVmZCUDA2M1pHUG5YMzVlTVZkNlZTeTRYQXd4TzRuMytxUE82cjZo?=
 =?utf-8?B?OHEzcVdRNzVCby9sL3g4UU9NamxlRzl0cHdHdUtTS3IyK1pjdDdpQUhIem1o?=
 =?utf-8?B?Q1MxOVRFb1pFaFpNMUtGVXp2SUViVmxmRlhZRm5ZS0VSMC9xV1FGZ2FwYThG?=
 =?utf-8?B?Y1czRW51d2JPTDhMcDl1Zm9XTVJjVGdGVXNFbjhuYnNYdE8wdjlGa0hLaEZ4?=
 =?utf-8?B?KzljUVF1N0pGcXVuOENZMEJnM1k2YVdKRzl5OHd3V2QzRkNBZG5YQ1lIaG5J?=
 =?utf-8?B?SDIzL1ppQXlQdUMyOWZyV3FrVmwyTjZsYjF0enJqVm4zUm12aVhERHdoVkt0?=
 =?utf-8?B?NEdON3dFTGRyQjE1dHVRNFZBcEhXU3N6SGw0K3BSWmxtRHQySnBIcFF1Qnh3?=
 =?utf-8?B?amFob2hBTms3ZGdWZHRZcEIwMS9ZZUlRT1BxS1JlZC9BOWRPQUt1WVlKVCtn?=
 =?utf-8?B?Y3ZWTEJUemN4bWxIN3hZbjE1MHR5cTlzUis3MHNHc255elNVb0ZiTHJ5dEo0?=
 =?utf-8?B?YjM1ZUUrN2FWLzRCY0lBWDM0SlhYSzNMOTRNRGdBNHZrVXdtdWVFUjRwTEU5?=
 =?utf-8?B?WG1LeGZkcUszbEt2cXhON0Vkckh4Z3BPdXpRaTd4bEs3U1kwVmpuYWJRdXZE?=
 =?utf-8?B?d2RPSGVHYzlIWk8rdHBOcjE0d3FDZzMyWk9aVFRleHVSNmVvMmk1aGNVdmN0?=
 =?utf-8?B?cmJmM2tGQjJjcFVpcVdHNlhocklTczAwRkJDbEdLNEhzeklEKzZFYi9jbkRv?=
 =?utf-8?B?S05UUW1zTm5COXZiS05pTUlmdnpPQlJqS0V3SXBmOGtwOE5RN0FROTBWS25I?=
 =?utf-8?B?RGVMSnVzZmtxV3FvVHFjc2llZWtRYWJoc3RMSUxHWGFzWmhOa0dHdERuSE5E?=
 =?utf-8?B?UDJ1V0c4NHJ1RlBuYWJOdnhSTXZZZ3Y4OWZyRnhFOFRnNTdkVWovbktnblBq?=
 =?utf-8?B?aVhFeHdPR1VvV3NYZVFUYitWSVQydG9EVDh0Y1ZjbHI5bzhaZG1VUXlLUVNZ?=
 =?utf-8?B?MUM4NjRiL0hhL2NvdGFnNWphc2xqZUY5K0dvV1hyay9keHdLZXhxRGExYmhU?=
 =?utf-8?B?NTJHNjdlY00yVTVrUFREUDJtdG52bmtIWmpYNDVCNjcxVWVYNmVsZ2ZEUFFC?=
 =?utf-8?B?RTFxelpuTHlzd0VReU8wU1o5cGM3dHRxbHg5TXFLbWk3TWExUTJmNTFSaXBj?=
 =?utf-8?B?YUNjNFRkb2hqdFQzaTFlN2RLMW9vREF0QXhpa0JSK0YvZjlLWnNwVnZpaXdM?=
 =?utf-8?B?ei92UWpEQ1I0NUxzL1FaampZc0ZXa1kvMVJCM1lyV0NTdGxNSmFjakZaRXZj?=
 =?utf-8?B?ME50SFR0L21ncnFjRHd3Tk0vKzRyeEJTUVYySVgvSnRIOXhLcGxCK3NOenNt?=
 =?utf-8?B?ZUZVS1o2VUhwNGVpRWNOUDVuZ1NOYlN3UHhTWTNSek1iQ0U3aTNyS0VsbTFZ?=
 =?utf-8?B?by9mVHZHT0s0cjJpcWhOZjFrTUZwTU5RbUtxOS9CcVFhbzJzYVdCUlQ1QzVH?=
 =?utf-8?B?U0VjMk5mdFFyMmw0SnVwVk1DMktkZnpOZzV3aXUwMEdXanN3bUwrVDNNWTJJ?=
 =?utf-8?B?NmVuc01sZXB2c0JiSWdvaXBYclgvZnhuZ2F1bWNHdCsyUXVnb2laS3F6UGNq?=
 =?utf-8?B?Z0ZpUXhhbURMME5yU0xFMG96OFcyTnlLM3R5emsrUXl3WlpRa3p3cXA5L1BR?=
 =?utf-8?B?bHp3dzVpVzRRdFFJbkRjS1VFM0RsMExBSEZjZUh1enhmRjk2Q1o1YXFtMHRQ?=
 =?utf-8?B?dmZkVVZTN3A2RVBXbWZyRk5UZ1Nya3FUSlJWS2UzUkI5REhmVkJNN2NjMnRO?=
 =?utf-8?B?M0lzVVFhK0FWbGd2RXdkVWVUL3RoY3J4V2dWTGRoUWI4bE95WFB1SVFNSmR4?=
 =?utf-8?B?SEFhanpEUzc4aTdMdjFldmJiVmFnVVU2alVXaVFxRVI4S28weDFPSVdxTU1G?=
 =?utf-8?Q?D6E9F9lyWE61uhMcuMuYtH3m+IR8f7wmiZoToEszyV+S5?=
X-MS-Exchange-AntiSpam-MessageData-1: Tah5dN1htcNilQ==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e1be6da0-bfaf-45d9-f3bd-08df037687aa
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB6873.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2026 13:32:53.0044
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Wh5AHLkVK4OU0rtM3hYvbHcpJXjG63x69jpLahCy+XyHeUHyyq9wJsasggYPuaXTqVLLYgSjpfaP/WcwSMS7Xg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6468

On Wed Aug 26, 2026 at 8:32 PM JST, Danilo Krummrich wrote:
> On Wed Aug 26, 2026 at 1:24 PM CEST, Alexandre Courbot wrote:
>> Coming back to comment on the conclusion: we have settled on a solution
>> [1] to handle this nicely, but it is likely that your series will land
>> before it. So meanwhile, please use the turbofish solution that I
>> initially proposed:
>>
>>     pub const SRIOV: Self =3D Self(casts::u32_into_u16::<{ bindings::PCI=
_EXT_CAP_ID_SRIOV }>());
>>
>> While it's a mouthful, [1] does remove `u32_into_u16`, which means we
>> won't miss it and will need to update the code to use `const_as!` when
>> applying.
>
> I don't think that works; your patch is not backwards compatible and remo=
ves
> casts::u32_into_u16().
>
> So either this should just be a regular as-cast, or we have a signed tag =
to
> share with other trees for [1] early in the cycle. Since -rc1 isn't even =
out
> yet, I'd prefer the latter.
>
>> [1] https://lore.kernel.org/all/20260825-const_as-v1-1-1ce712225fe2@nvid=
ia.com/

Ok, I'll try to send the v2 of `const_as!` promptly then.
