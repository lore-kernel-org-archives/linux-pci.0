Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.194.21
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794225243;
	b=jZNF26Y+HLz7RMSMMYT/AWGLSYRVL3bT+2IrRBtFyVOMIH2DkLULQoMIdSAd33uoxPY/
	 pySPnZtNXqCdMhIKd4aosCAjkTpMc8ALXmzTVx9kLGwB+xL2V7T4trAEPWRd3cT1rzbG2
	 w0fbuZEScoKNtTlVVJG/82uDGlJBtSnLmos19fxW/eJoYldW6Mf2jG8FYsi09cD6z5ZeJ
	 YDV0p7YryqHVQM4mjMC6Vyeeklj75elm/CkKhyYN8shZsxIctKPNSjkupsOT2QDxWgjNa
	 KoUli1yHQM7ERc80QLb2stT469i1SwPl2MSGcmNKfxu4vFKuZDeyZ+20zB8ZU2O1pxA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794225243;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Content-Type:Date:
	 Message-Id:From:To:Cc:Subject:Content-Transfer-Encoding:References:
	 In-Reply-To:X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:
	 X-MS-Exchange-AntiSpam-MessageData-1:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=JlD5unEwhMYwiO2cM+z5zSIFeCB/imh4xDwGExIHQEY=;
	b=kA9YH0/41AvdH0GBHTvcnj7j/yiO/T7HUD2v/lGUc8RYgkDUKXQeRDtfSEhRQV4BuiBa
	 VweZZEn7Hur2KhfztSjzS8X3+ikwduib7b3nAypVvRDM7WmWJzm5ULhQV40xtmEDNFoGU
	 86MxAhMiQYQqgPkM42pjV2yuGpN8lGy1oXqipMtlvHz40j8GyCB70H9ba+SoLBa2bP7g7
	 ChjHKX59vJ803rdcR3o7fwF7l0Wmx1bDWcdOnwhzSkEXm0jNZPpYOK4T9D8yCNCXMSHDL
	 1kpe6z0PhCi8835mxJ3BoqhmXqXBnNkxDlb8KZPP8ZihyCOrY3pyBIdSsDosy1aNvsg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=P+v2Fuh8;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.194.21
Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011021.outbound.protection.outlook.com [40.93.194.21])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7EAB606D80A;
	Mon,  9 Nov 2026 11:54:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B7EAB606D80A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=P+v2Fuh8
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RTndJx2gpSMNpESl54G09IlMyvS7y8NhDUGHJ4F8F7DmsckBg9I4AUTN25BiPx/1rVCwxDjuC8RULy12SK2uiPfn/wZ0UuBf5GSMW9OYBtMoGANld0G9nHTQZyju0/fwO9fmLOpMOCiECQTqYMP8Iy7on5fBfLGnxBrfKox5Qk0bxaauF8LCx4EuMQ5FSgEDlYE2AG3y1j6uZyvPrfAY64OU5xpmFG4Gx0JnPY2aaoEwEBzswmCa60EeyEba4/wqlLigYO7RoSEWsG11XtdLBmDWLoDUWdLNYBFT4eJHYAXX/slMw3MTONi1IEgXyP4MIqWjErmkJJmuzoIKp8dZ5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JlD5unEwhMYwiO2cM+z5zSIFeCB/imh4xDwGExIHQEY=;
 b=RHlfTxrot06xqY/FzUi8YCXfGVD33E7tkhDUAy3l0ANmhwEFPT8TOFkwqDVhTN82iisbxBa3q/bF/Wz0loCs5PVSlAR9WsLT0oj6LGidlXadSNEztBSicEagCpiQ9Qs3Hv+ZGg0uuVk2IyutNnISPG0HqAgBDo1HjcnB0gycNBkYfcqcpqmBlc8L+07YiUbpxlViGhel7UbEE1zWjIJrP3ZUb9EumBFuje5dW92IWaqHUdXWc4GVKe1YhTKYTuMdHh4TN2vDEg19G1DJ6S9jIheOTyoaVjqxzvMAeZdcXiFbeT9NTy9DOdZ52l3iHKfSlAYC1xbStFHUVZWAEwPPCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JlD5unEwhMYwiO2cM+z5zSIFeCB/imh4xDwGExIHQEY=;
 b=P+v2Fuh8Cmb1hXa6SWCTVvSUM0ZOt+fKT0HWj/FHtEl2AgxCHwUxoZZcal01aqLx/c7elSCCdKjxcVARh0Xctwre2qd9/Nzk/nBQ2IV8NjleqcqUmMWxjy7QMf0Mn0At11K3/vuS2aMZiGOIqL1ayn6tFDeNL85mAV3n7ZAnUVdG0S+uT6OaeDA+TJ7Vs3y4KvV++wgPkiWfuLukz1zyWQYpsP97/2J2rSSu+seYKxPFVwRDAJ+QdFn+kZ1LF61P33RSPlBI9a3lkNtcfbJVydNqM/mjk593d3piL4N6CedWflE86btuh6gPs2AXQyFvsD4nVd2UT0SUd43ZkfO8RQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MW4PR12MB6873.namprd12.prod.outlook.com (2603:10b6:303:20c::17)
 by CH3PR12MB7713.namprd12.prod.outlook.com (2603:10b6:610:14d::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.13; Mon, 9 Nov
 2026 11:53:56 +0000
Received: from MW4PR12MB6873.namprd12.prod.outlook.com
 ([fe80::a338:bd2c:3a38:ece1]) by MW4PR12MB6873.namprd12.prod.outlook.com
 ([fe80::a338:bd2c:3a38:ece1%5]) with mapi id 15.21.0592.010; Mon, 9 Nov 2026
 11:53:56 +0000
Content-Type: text/plain; charset=UTF-8
Date: Mon, 09 Nov 2026 20:53:51 +0900
Message-Id: <DMQNRGDHAK0A.3EZQZGAHKYF47@nvidia.com>
From: "Alexandre Courbot" <acourbot@nvidia.com>
To: "Simon Song" <xinmengs@nvidia.com>
Cc: <dakr@kernel.org>, <kvm@vger.kernel.org>,
 <rust-for-linux@vger.kernel.org>, <nova-gpu@lists.linux.dev>,
 <linux-pci@vger.kernel.org>, <alex@shazbot.org>, <jgg@nvidia.com>,
 <yishaih@nvidia.com>, <skolothumtho@nvidia.com>, <kevin.tian@intel.com>,
 <airlied@gmail.com>, <simona@ffwll.ch>, <ojeda@kernel.org>,
 <alex.gaynor@gmail.com>, <boqun.feng@gmail.com>, <gary@garyguo.net>,
 <bjorn3_gh@protonmail.com>, <lossin@kernel.org>, <a.hindborg@kernel.org>,
 <aliceryhl@google.com>, <tmgross@umich.edu>, <markus.probst@posteo.de>,
 <jhubbard@nvidia.com>, <apopple@nvidia.com>, <joelagnelf@nvidia.com>,
 <ecourtney@nvidia.com>, <cjia@nvidia.com>, <smitra@nvidia.com>,
 <kjaju@nvidia.com>, <alkumar@nvidia.com>, <ankita@nvidia.com>,
 <aniketa@nvidia.com>, <kwankhede@nvidia.com>, <targupta@nvidia.com>,
 <linux-kernel@vger.kernel.org>, <zhiwang@kernel.org>, <zhiw@nvidia.com>,
 <boqun@kernel.org>, <daniel.almeida@collabora.com>, <tamird@kernel.org>,
 <work@onurozkan.dev>, <jgg@ziepe.ca>, <bhelgaas@google.com>,
 <kwilczynski@kernel.org>, <dri-devel@lists.freedesktop.org>,
 <peter@colberg.org>
Subject: Re: [PATCH v5 7/9] rust: pci: add SR-IOV enable and disable tokens
Content-Transfer-Encoding: quoted-printable
References: <20261030171230.196717-1-xinmengs@nvidia.com>
 <20261030171230.196717-8-xinmengs@nvidia.com>
In-Reply-To: <20261030171230.196717-8-xinmengs@nvidia.com>
X-ClientProxiedBy: TY6P301CA0011.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:3be::15) To PH7PR12MB6858.namprd12.prod.outlook.com
 (2603:10b6:510:1b4::20)
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB6873:EE_|CH3PR12MB7713:EE_
X-MS-Office365-Filtering-Correlation-Id: e96af893-0ba9-4ff9-8745-08df3e582130
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|23010399003|376014|7416014|366016|1800799024|18002099003|22082099003|10067099003|4143699003|56012099006|11063799006|261028144727099003|261026121527099003|261102123227099003|261022113327099003|261022075727099003|261022105027099003|261021135927099003|261021121427099003|261026140227099003;
X-Microsoft-Antispam-Message-Info:
	EgIopE9N0qoSptSMNOLKC4KL7K3a2io0McjZNk1o3oacN3DJfaWl9XlwyEvYgywLGevlSiLG1LNlGek5lxRcg62VRR7ThBizccejNJqifNdbBWso16KkEthKORzt9dJt61woUpBoLizAKmeTvuw9HsjGmhptGJAVfDun+kJYnuEQlsL/nLIFqNl+dI4OvQ4/TgGMFsZYhpgetr6zJAexdzjDOdM9lWLuFxvAcBhjQ6Kk7s4VREvMsc2/uLVcv77d0RoUf6g2cq0WKY3ETC7UBcEL5OflCaHyScaB8H5ArFUkZuI+S3y/hVAmvKZSejOL6uv/AzplbCu6jz2gy5pmj4OcIxd8GWWqcg99vx5TgcDhvU+jkoY1p2+9awoG7lfO6kyKO+xfRaRVycLpzYUMHp2SkOn+h4ICiXUSAD7UsKZuhZG+HiHV0t4AUem3NvYZ3Z6BBE9WcSrc6lZMGIVHL0yFlMX1pJmkEN3+rL13oZySAZ9kqFS1pkFtDnf9hgLVXNjF7fv0s0UHN5svELqE/yOpNPNnuQOPlg1tJOr5R3yohV/uBR4gvOJm0o3MXkksvqy0NS8ubMTAQQBvIkttavXs/xHxkl/ajvmJtmCse60WcnLq2i6jOk/ekshyim7eMU6noLaqXVdNB14k9qJ6i57Zz5EP0U8phczPMZckowY=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR12MB6873.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(23010399003)(376014)(7416014)(366016)(1800799024)(18002099003)(22082099003)(10067099003)(4143699003)(56012099006)(11063799006)(261028144727099003)(261026121527099003)(261102123227099003)(261022113327099003)(261022075727099003)(261022105027099003)(261021135927099003)(261021121427099003)(261026140227099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Rm9xOUZTZHNWbTM1ZXRYMDl6Zm5sK1lQaEQ3Wm9Xbk40V2tvV0VhdWN0YzJV?=
 =?utf-8?B?cGJRZ3gzSDFzUHFLYUNsbzI0aU9ZZllSeGI2ZEdwTThPbytpV1JLVlJvbGJn?=
 =?utf-8?B?RERqRHpIaU42WCttckxnZ3RteXEzbE15bE92aEp2ZTJjT3h2ckxOSEtZL3Vn?=
 =?utf-8?B?ck5jWUw0UVNuRFR4bnl5Z1FFeHRsSndaZG13N2dROWZPanhSdGpYajQvNklj?=
 =?utf-8?B?MFRlOW81ekoranlaRDAzN21JRm9tR3ZwYm5RZ3FieFJHcTREMVdLcmd3S1lS?=
 =?utf-8?B?ditXc0tNZmdhQldnc0QyNlVuaW92enZ5dTdLZGZaNFVLV2c0SW96c3dBSDJ1?=
 =?utf-8?B?ZmU3MDBDbmtkYU5WTHUzbzc3SE9aQ20yWDRwdWpOQVd4M21Ga1pqN25vcTZJ?=
 =?utf-8?B?NkNQSWx5YzdjcVBmaHNRNDZQWnBvdzVBUHkra0lrRGxkMGxCU3ZKOXNwOEVL?=
 =?utf-8?B?TE9waC9rZVNlTXFrVjVTMk84Z3JBRloxSWVtcEJkMEU0RXFYbi9Fa1kydERF?=
 =?utf-8?B?MU5mRlpjb2JhcnlySGFIQWsySkVOZjJGZjFxSUdFaWZ5VG1zVzZjVUtEcDh3?=
 =?utf-8?B?UWFYNmY4bTRLL09rWllxa3JOVmVSSEFONmdjVzRWaWl5REtDL2lneEhyVE1K?=
 =?utf-8?B?d05CQmw2Y0tWMXBKTWpFa0hpZXdXSm1vZlY4T1MzM3BMb0M3WGxLeGZORktY?=
 =?utf-8?B?cUhFQzZBdkhleU1CY0h0ek1xUmJaMy9pNUZRbFlBSm1meE9UTEdOUS9jbUpM?=
 =?utf-8?B?UVVxeVQwODRsZVFsM2wrU21SSGErMjh4aFpBYmNNLzBwS2ZocXBsT0FSMnEz?=
 =?utf-8?B?RlJJVkp0eno2RG4zK1BsKzB0QkpsaXlQM1NsajJodEhYVHpMcVlIdWQ1T2s1?=
 =?utf-8?B?Z1pQQmNJRUxWL01rN0JqSnpNRVM5a1BSQlZaOS92VVJJeHF6ckpYdTE2MUdr?=
 =?utf-8?B?bEwzTmlGOG5FdWZya3AyWnQzYVNMMjU5cXNwWWdTQlJxUHNUci83M1N2bldS?=
 =?utf-8?B?OGVvRXpZMFdwRElSRkljRHpxN29nbEhBcGVCK1dBWWpUMDdNcDlBRGU5d1E5?=
 =?utf-8?B?M2RhVlVsTXhmcy9NTEh5eGZtY0lScUtXYzFTakY2VE1RNVEwU2lCWExROHNt?=
 =?utf-8?B?WVhVckJzQ1VycisrWllraXkwRnVQaElmdzA0OTNRR2dTVUlqYmVBUlRJMlV5?=
 =?utf-8?B?RC9BS0pKbVA0YWcxRlNzc3hadmJUSWNja0h1Zi91OHIxNFZLSEY1WHBaWGYr?=
 =?utf-8?B?dWl0RUZQTmR0eGZCT0JBWllCQVp3cENQWEFrVy9VcnlaM2g1a1hOYkhidzF1?=
 =?utf-8?B?d0ZxUFdrMlduelM5bml0d0haUVNhdm5iV2gwYUtxU2tNSFZqei9Ec3dIYzF5?=
 =?utf-8?B?eUduTUJqMlFSV0JmUGhFTDVTUlAzc1BLcnp2elZZUUZkczRaazJpdzY2Y1Rz?=
 =?utf-8?B?eFNyRDlSbWhTWCtwQTdna05zc1ZmLzJZL1kvN24wOG5ydmI0RjMvZ1dqYUZO?=
 =?utf-8?B?NzFwaFlXKzBpMnJlU1ZGS1VuOVhqdnFKR0VKc1lvMVhRcUpFQ1MyYjRUUm9q?=
 =?utf-8?B?dzRMMXYyaW01cTdUVUxnTlJoUHl6WHYxbzVZWEkxZFR5V3hjMXhPVE4rNDQ4?=
 =?utf-8?B?VTUwZlFsTDk1Ykd2SldURWhUV1NNT0Fvb2cxQk8raWVndVQvSW1xb2xPT29s?=
 =?utf-8?B?VWFOQ1NIY2dwM0NFR1RyNEdHK3VuaU5aYWhjU3pCOSt3RTg4V0ZDUmlWNit1?=
 =?utf-8?B?Z2pXU1BRRUo0Wkk1VXR2Qm9oRnU3UE14aU1PTGloRGZaQy9jT3MvRjl5WjhZ?=
 =?utf-8?B?YkM4R1pOSGZvNEJTbGdpZFg0WU83MTl2Q2NHUFV0L2E3V2J1N2twTGU5Yy9u?=
 =?utf-8?B?N2RLa2QrR2ZXcE5aVDZpYlRJMDJaMzJFSG51L3VWRGlvRDRZYW9MMGQyaFNq?=
 =?utf-8?B?ZnhBa2M2M3hITFNyZlprTHhqQmRqNnV3TVE5bDNqZEtYcFVKWlRnK2taOFV6?=
 =?utf-8?B?YjFvRFRvNjB3N1hCMDEvVzJqYTBrbDQyZU96UzBCWFYzZkZycUEvRWd1STJG?=
 =?utf-8?B?aG5waHVQWDZ2SVMvSmtITWR2NGsxSCtIdk9BYzNseHFMMGprQ1pNalBNL0Qv?=
 =?utf-8?B?c0p5S1Y0TWI1c09UVVZVbUtBMlRjUHVEVkEwU0tCVGtTdFk5WjEzbk50d2pC?=
 =?utf-8?B?bXFQRVZIUDBRUVQ4ay94aGM1MmNOMG9ZWm13bUl1ckYvMXdOcFFteTZEWHpp?=
 =?utf-8?B?eVFQVG5XUmwvN0ZMK2wwTHlzVERvMk1VbnhGMTYrTkd6Qzk3SVdOSEh0cndT?=
 =?utf-8?B?alZYSzNSNzFVWDQ3ZDF3eWF5dzV2elhHaWZ6NmQwSXVSeHVneklBMlJPOGVk?=
 =?utf-8?Q?xRafV/7mWhwEDQ3elCOQleHxUNatcFOiEumZwOpzTRTOC?=
X-MS-Exchange-AntiSpam-MessageData-1: +HEV2kIsGMAAPQ==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e96af893-0ba9-4ff9-8745-08df3e582130
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB6858.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2026 11:53:55.5962
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /r162QmxKNKfeLjGy5kfw20RzWQK0EQsIidi1zSCaGoQDi1+PtxcqU8G591uzwHHuOAZtFNDUHZHasfz87TmJQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7713

On Sat Oct 31, 2026 at 2:12 AM JST, Simon Song wrote:
> From: Zhi Wang <zhiw@nvidia.com>
>
> Enabling VFs can succeed before the driver's remaining setup fails.
> Use a callback-scoped token to return an enabled guard that disables
> SR-IOV when dropped, rolling back those VFs on a later error.
>
> Add SriovEnable, SriovEnabled and SriovDisable for the split callbacks
> introduced next. Tie each token to its PF and callback lifetime, and
> limit the enabled count to the user's request. The PCI adapter disarms
> the guard when accepting a successful enable callback.
>
> Require a VfRegistration to own final VF teardown after that handoff.
> Drivers that do not share data with VFs can register (). A disable
> token permits explicit shutdown without forcing it on a rejected
> request.
>
> Suggested-by: Danilo Krummrich <dakr@kernel.org>
> Signed-off-by: Zhi Wang <zhiw@nvidia.com>
> Signed-off-by: Simon Song <xinmengs@nvidia.com>

Reviewed-by: Alexandre Courbot <acourbot@nvidia.com>

(one nit comment below)

<...>
> +/// Permission to enable VFs during a driver's `sriov_enable()` callback=
.
> +///
> +/// The PCI adapter creates this token for the PF being configured. It c=
annot be cloned or sent
> +/// to another thread, and its lifetime is restricted to the callback. E=
nabling VFs consumes it.
> +///
> +/// The callback lifetime cannot be extended:
> +///
> +/// ```ignore,compile_fail
> +/// use kernel::pci::SriovEnable;
> +///
> +/// fn escape(token: SriovEnable<'_>) -> SriovEnable<'static> {
> +///     token
> +/// }
> +/// ```
> +pub struct SriovEnable<'a> {
> +    pdev: &'a Device<device::CoreInternal<'a>>,
> +    num_vfs: u16,
> +}
> +
> +impl<'a> SriovEnable<'a> {
> +    /// Returns the number of VFs requested for this callback.
> +    #[inline]
> +    pub fn num_vfs(&self) -> u16 {
> +        self.num_vfs
> +    }
> +
> +    /// Enables between one and the requested number of VFs.
> +    ///
> +    /// VF drivers can probe before this method returns, so the PF resou=
rces they access must
> +    /// already be initialized. The returned guard disables the VFs if s=
ubsequent setup fails.
> +    /// Return it from `sriov_enable()` to leave the VFs enabled on call=
back success.
> +    pub fn enable(self, num_vfs: u16) -> Result<SriovEnabled<'a>> {

Do we want to return the token back in case of error, so the caller may
try again?

Also it would be nice if the returned errors could be documented, as
that would also document the conditions required for this method to run
(i.e. a VF registration must be active).
