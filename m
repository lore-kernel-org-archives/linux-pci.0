Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.53.45
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793274759;
	b=Y+58whs7iS+xSk8/hwW5BIsapL4V4b+QMqziNhpXhST+nR2KakP1YKtjAhc86galCVum
	 C5fc804VvLSzodho0B5DXf/lYTM84k1q8t69jAoojvQa1ZRKmx/xjzDs6xBQ9hcWATyUl
	 96XbCW8YV/Xmpz9o063okI8AqGeBQn7pOwjFgbSaM77B2Iwbg4rQmbAYxnDT3bQgKaayi
	 SUh2zfxevMeqsAAWDWphYbkOO+Jh1Crpc66aEsob2M5od8ctb/BnGl6vfAfyMtD3mhTvm
	 GjB6QoAVGgpt4m/b7Q6Wd7Zl2JxTWt6u4LSudTqp48c/qR1Fp9GeJVhfH+Jjg1p3tcg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793274759;
	h=DMARC-Filter:DKIM-Signature:Received:Received:
	 Content-Transfer-Encoding:Content-Type:Date:Message-Id:To:Cc:Subject:
	 From:References:In-Reply-To:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
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
	bh=yqWE2SV0gbubsGA3znbQgfTaYtiuoNfll9dM1LT5bJk=;
	b=oGZ9KLddWWfktwayRCPOnfKHretyFkat7j2c1gS3vTFMBXB7XZfj0WQX/bo4eVsVdVGH
	 XVVh41r2A/af4CZH2aCg5icOn//WTcThpyMTHftm53VrqBKNaTUE9xYqJQ2D7P6TggaJV
	 YoMpHu17N5PXri/BQEmPZOCGrdnp85FMm8CtNqQ3JhI4p/eGrXqOHpA0VK0Y3OsHmi9XZ
	 1+noWHQ0asM6JArfWnutEudCN3D0YcJOY79mAvIYvi80L8N7psXpmp6qba7pToTblFkaF
	 tJCAuHJBVlvO8noNpI+DOXZLc7rN84umqhzSfsBH/rKL72St0FNLUoc1E1AMXaj8G1Q==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=RPhAvv37;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.53.45
Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012045.outbound.protection.outlook.com [52.101.53.45])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EA9F606A31A;
	Thu, 29 Oct 2026 11:52:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1EA9F606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=RPhAvv37
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NLic5gUWPKcyCZQ1iQ6F45tQEbulJBBYsqRSUUaYxvXDNQcb+Do4AAGzxw8gc/hOAx9PYYlFOZVsLDpgGpl2qvBn+R6TFRjR4zEaoBLwPu5MQji9g0EOiePh7WIEGLe3VN47ger4GIxPOSnDImnQV1rVGrZHjWWHGsyt/xpypgp3pqLdh6gMToHfQCLz+oLM8Iw4y9Rrz6QEzaE36GKAK2uDNaIs8ZyWQ1CP4ICHyyN+2CYkARyfD5p7JZ8n+lNCB4vuoTseVxr2qVVDXjBDMreFRPstJOds7mRned06QERUSM4U5JKNjlhrM42IeI2hngdUA4OhSvJljqFWcSp7rQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yqWE2SV0gbubsGA3znbQgfTaYtiuoNfll9dM1LT5bJk=;
 b=IHOk6O2FeSSJeyzPItFfm1nRSAaejV1cgEW7wCCMIR0pvnvY6y8LEuPyrJnrFplev1yynNUhI6HWuW149PWsVYe+I+VVUjtkhxXNauElSPRKF33ZV5qAeC6pLf4PHVFRDhj5Gy80/sPngDHKRP1NwzBKRB1pyyGRkH7lPunEtQ5w6xwlpu1Z+O6GLlt5iteqDbnGXK8ZQcMGFRaY6/iXRIoDqJq552A0dVcAig5vFRLcUNjb3gRiHZEGq+HScMs2jfS5o9bIZ8k2tyTuawvi65tKmDw9u9b0QIElcjySrA1P6wP+syRkkuLaC+zbd3v6fqQE9rRnI0TN30GZH3mNgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yqWE2SV0gbubsGA3znbQgfTaYtiuoNfll9dM1LT5bJk=;
 b=RPhAvv37wWFjUy/9w35fLFz4nY6WzzqmNK+/KbPsj7F/iKQRm14BzjBiEERAS07K2C0nFFpbRuEhktglBGjK07g9WmL2Tl2ikyL86EwhmK+77Ke9ycgLrjSgJCLH7DtJoHu0+hh2pJa16uHe0Ep9UJmrx5tPT+/ry7M7k+Fo09NZ1xHAt85YIMtX+jvYjC3dMHZh59ZW1Arimh7v5ymucLCAthARTJnOwgMlSbAx8E0xFKeCwtHKP4zO9p79/3mMuqRVObbbqUqOmIXX+DAO9W/lfDln21YBW9Sq88r1uhtJpeEujI1Z6RT+QuMwpmofefLDtXbAbbbIbLQjpAEofA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MW4PR12MB6873.namprd12.prod.outlook.com (2603:10b6:303:20c::17)
 by MW4PR12MB5626.namprd12.prod.outlook.com (2603:10b6:303:169::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.8; Thu, 29 Oct
 2026 11:52:34 +0000
Received: from MW4PR12MB6873.namprd12.prod.outlook.com
 ([fe80::a338:bd2c:3a38:ece1]) by MW4PR12MB6873.namprd12.prod.outlook.com
 ([fe80::a338:bd2c:3a38:ece1%5]) with mapi id 15.21.0569.007; Thu, 29 Oct 2026
 11:52:34 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 29 Oct 2026 20:52:31 +0900
Message-Id: <DMHAUFW5V16R.20XEO2QDXIGGG@nvidia.com>
To: "Miguel Ojeda" <miguel.ojeda.sandonis@gmail.com>
Cc: "Alistair Francis" <alistair23@gmail.com>, "Andreas Hindborg"
 <a.hindborg@kernel.org>, <lukas@wunner.de>, <linux-cxl@vger.kernel.org>,
 <akpm@linux-foundation.org>, <Jonathan.Cameron@huawei.com>,
 <rust-for-linux@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <jic23@kernel.org>, <bhelgaas@google.com>, <alistair@alistair23.me>,
 <djbw@kernel.org>, <linux-pci@vger.kernel.org>, <wilfred.mallawa@wdc.com>,
 <gregkh@linuxfoundation.org>, <alex.gaynor@gmail.com>,
 <aliceryhl@google.com>, <benno.lossin@proton.me>, <boqun.feng@gmail.com>,
 <bjorn3_gh@protonmail.com>, <tmgross@umich.edu>, <gary@garyguo.net>,
 <ojeda@kernel.org>, "Jonathan Cameron" <jonathan.cameron@oss.qualcomm.com>
Subject: Re: [PATCH v4 10/22] lib: rspdm: Initial commit of Rust SPDM
From: "Alexandre Courbot" <acourbot@nvidia.com>
References: <20260928011123.450800-1-alistair.francis@wdc.com>
 <20260928011123.450800-11-alistair.francis@wdc.com>
 <DM4NT7TFX4X9.1GFI128LI5ZQ4@nvidia.com>
 <CAKmqyKNEup=x+bwmPD_8x0s4ssPkqFnQtSGqJ_82z9oDP=A6cA@mail.gmail.com>
 <DM58HRC3DHSS.1YC0E53ZXANT4@nvidia.com>
 <CAKmqyKPwirjmeBQvXgheY8Lh-M-RRq5pdbv=5mB4duhw9aCbGA@mail.gmail.com>
 <CANiq72n=eqh6W+iNWPdM+rrc+HujtZVRtVg=JB03OMS8rc5hiQ@mail.gmail.com>
In-Reply-To: <CANiq72n=eqh6W+iNWPdM+rrc+HujtZVRtVg=JB03OMS8rc5hiQ@mail.gmail.com>
X-ClientProxiedBy: TYCP286CA0188.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:382::17) To MW4PR12MB6873.namprd12.prod.outlook.com
 (2603:10b6:303:20c::17)
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
X-MS-TrafficTypeDiagnostic: MW4PR12MB6873:EE_|MW4PR12MB5626:EE_
X-MS-Office365-Filtering-Correlation-Id: ef2983b3-b29c-4275-8ecc-08df35b31ee8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|23010399003|10070799003|7416014|376014|261028144727099003|11063799006|4143699003|56012099006|261026130827099003|261022115727099003|261021135927099003|261022113327099003|261021123027099003|261026140227099003|261026121527099003|261021121427099003|261021130227099003|261022105027099003|10067099003|261022075727099003|22082099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	FCmLdp/xLQpYQFE5M3Ur59kVsgwHTVtttLxlKkSCXiYe9EKYvgXdULO5K5+R6RBCRjUPDmcLrHVS6vkpsZOB/BvfpbP0twBl8bTfHXToWfMfJnVLeYH3oeBH/IMT5acOeV7tXR0/YhrVK5EV7di47jcWgyqyRWt8ehHqeg0kGDvtPDsJntY2QSQUfA4Dsq9UV5UKoTZTwl9DYVJ9PbkUcurjdZqjuXmFpoT1cM5Y7FIT1hbL8p+66bCtHGkmtTHa/BooQBDBMNJIitGrmGEO4mruL65eJHPpMdfjRhruj4LzZVOeTVTPFzb5MicD0rswwnxFR2VWFewNrbJHUQlBZ33kQsELUP7WKHBCBN7N7nI8RtMY0pDSfILArswkQ4GFWd7643yQlXDePi7VH1+eNYVri3TyRu9SPHKo8gwKUAB0ZsRiaPSWTs7EcIQmUnFpLNs1zLuUi/lRJJa6S3QFG121WgHHh837BlilkU3tJw0hM9O5kvWSVq1EMOksxwY3CjfnQyLQYl9E3VraIfMFHu9LPcvYRNw7kbkNuQU3hD3UCaxwc+1dBGFArcvv82rrMzPf5D9HKKT2Joi4bUD4h/bTWz6KtdTQFeMCuOpzBcnEzV5Vx2IQew/IpPOh/dvLFWEjQFIjGlEoEYWYsFSXZ/V6QWOXMsf2V8vgA294lKE=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR12MB6873.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(23010399003)(10070799003)(7416014)(376014)(261028144727099003)(11063799006)(4143699003)(56012099006)(261026130827099003)(261022115727099003)(261021135927099003)(261022113327099003)(261021123027099003)(261026140227099003)(261026121527099003)(261021121427099003)(261021130227099003)(261022105027099003)(10067099003)(261022075727099003)(22082099003)(18002099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?U0R5UDkzd0NvUnYyYStvVWFXOW1LaGRsdU1hVncxUU9QQ2NlM0ROYmJJS3J2?=
 =?utf-8?B?SURPdEZMRkJVNGo1MXRjWHRCcUV2TVQyWHlROTJXS1Fzd1NrdDFFa05TR0U3?=
 =?utf-8?B?Snl6N1c2ZXBqdXgzNjdCWjlVclBCc1MxZVZDcGxvTWVvaDR6UXZKek9sS1NC?=
 =?utf-8?B?VTZwdk1ZS0pHZE83dnNLWE5YNDRUcm9OcU1ZdDhaaTBvaVo3T0l0Vm5CK2xl?=
 =?utf-8?B?Ty9sbmY3Z01LZ3hEZHR0bGc0cHRWNEtHanBXRlNyQUtYbVFlMEZ1bTE4Vmk5?=
 =?utf-8?B?UjRIbkNEbjVIZWRkUXk4dlNLa1pEb0FMMU1CdGtTZ3R4WDl1WE9HUEpvUTZM?=
 =?utf-8?B?RU9UYWdDMkUrL25WRHlzODBrZUhaakhYUC9uUWZwU1hSc29EZnVPbHZZTHJ1?=
 =?utf-8?B?UU9iVG00MVcxZFRQVW85M290MFUvRURyZjB6VG5EeTQ5djNyV0xXeDFxcld2?=
 =?utf-8?B?SHZTZEFLaERwczJEQXo5Ny92QjBLMmRTN2k1bWFuOENKT21pOVNxYzVrZFJu?=
 =?utf-8?B?ckc2OE1BNUMzUXVvU0duRmdHdTRwcklhWHVXSkJYaE9BZVJoZFJpRlM3cDF1?=
 =?utf-8?B?cytzaVVkS2VIME15N3N2TlpqNHMxSkoxUmRaaTRTM2l6TUNrdEFJWHlZVmJz?=
 =?utf-8?B?cnp2RDVEU3ZMdlgyMitsY1dGYnJHOHdJeVBRSlJxVm91OTY4QWhGMkZWM3Zq?=
 =?utf-8?B?Q1hySUVjSXBqcXJteGh2bWdhM1I2YVp1cGU2b2xHQWJ0SUl0eTFiTmVIVDR4?=
 =?utf-8?B?T1BQZmpCNjB6RmMxOCt4QnhzODY4ekd6VndhWUwxY1d0bHBSSEw1bUVpNHIz?=
 =?utf-8?B?a0pUdkxSczlQb1dCNWpCZG4zNlZEQUF1NXFYMFBSQktTRGdiNFdHRXlJU0RD?=
 =?utf-8?B?U3k0NS91WnR5VG13dXlmZndaNWlCaWVSbm51eTBPL21LL080M2cyKzlWcGRk?=
 =?utf-8?B?MkJvVVFtMnE1eHZmZG9DeVYvZWFQK3hmeTl1MGNsRVE4bHRFMVUwd3k1d1hG?=
 =?utf-8?B?SDc0c0NUTnhaY0pHQXUzVmZFMVVQNlJINktzWDVEV1ZjMkcxcThyc2sydElJ?=
 =?utf-8?B?ODNXcUptWHMzOE9LYi9EQUJGNlZpRnhjRlAwTkd3YWdCTHhCM2lpekQzcEVi?=
 =?utf-8?B?cFRxbzhORjh3dElHZ0V0RnUxbmdRQXdtejNrMS9TMGhHT2pqY0dMUDVubGFV?=
 =?utf-8?B?dDNqTTJhYzRHVG1rSXZHWkNVdlcwOE5INTFpd3pjMFZ6TGVRL3lKQnBaWGF5?=
 =?utf-8?B?bkxSdk1jblpsY0kwb2ovaGNub3ZETm1WTVFoOTZzemZCUWJtbmM3U01UbTFV?=
 =?utf-8?B?NnE2SjR6aTZmOE96WVRHQmlqRUFOMnJ2WHVKYlZOeGJhSmpvTGJWNlIvbVVv?=
 =?utf-8?B?OFVnSkNVblFqZDRkdXRQZFdTWVhtN0xpWmFoVXZkZlJQVmx4dHJxYXpXaVV2?=
 =?utf-8?B?YkZ2azVtb1VMT0N1SGduc2Q1Mk50TTlZNnk1aUVacU5oYzl1M2k2d040bjRZ?=
 =?utf-8?B?SmY1Um5WdFBPMWl5WnVPaDNCT0lob2FoWUF1cDArY3ZSSWF1OTlEckV5ZHBJ?=
 =?utf-8?B?L1pXbDFsWjhtZVc1a2QyNElMU01HOEU1cHhKMnVZOEVWUzZNVWUxVnRyWVky?=
 =?utf-8?B?eE9kV3Fac0wxU0k1alQyVjV6dkVqZG1yRUxIUHVaQzB0SHVhMVRzR251cWxI?=
 =?utf-8?B?dGZLUHd2bElnRGFaL2RPbENIdXVIMXJjTXd6Rmo1blAvR1NlSnZiR2NlVyt6?=
 =?utf-8?B?S1VlRXBBLzBCVWZucFArUk9vZERlNnhxTlduS0pCNldtemV5Mkt5dVU2U0Vl?=
 =?utf-8?B?LzN5b004VXRJWW40dVphZU52b25EZENxdWFudjBqOUxaeS9lMUhXUGc2ck0z?=
 =?utf-8?B?SjZTU3dVbnBscElGNkV2TklOZ3dtTEtKTXpEY0MxaUZDSVdOcDNmUnZkQlR0?=
 =?utf-8?B?ZFk0SXI5TExhV0dOQmNJU2V2Zzc1R0cxdVNPelJ0TFBuRGhVMlgybEFlTGlt?=
 =?utf-8?B?eGRiR25nMGFGY3ZzM3RjdFJJeVBWVWtOK3Y0OFNqUW9kYlVDa0pHMldiSk82?=
 =?utf-8?B?S0FQUHNJWUFYaHAraHliQ1BPVUpQekJUR1NVcmJ3eFB5SGlqZHd5SHhLU1Jr?=
 =?utf-8?B?ejY1cEJKTXFZRjRvT2lVZEhVc21RSXJxSDRBTkdIQTBJblppR01yMEc1Q2VU?=
 =?utf-8?B?N2xGb0FWaDdQTEVrNzdSSno4ZzhNRU1oaXM0RmNsdEg3eDZmVEswOGhvWThC?=
 =?utf-8?B?cVl3L0ZybEFJeGhqRFBCQzRCckpPWnZxU0MyMTl4MUtoc2lHQXZoZzIzVU4y?=
 =?utf-8?B?NzJOUkd1cVNhNHR4RHl5T21QK3JXYUtUYXF5UllrOHhKaWpITjF5aFRCcmhT?=
 =?utf-8?Q?ZjhJOZTbErdOkRv+twj0pLPHTqP35Lmm6tdowjxnDRakh?=
X-MS-Exchange-AntiSpam-MessageData-1: FRuXqiCd/xQJtw==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ef2983b3-b29c-4275-8ecc-08df35b31ee8
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB6873.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2026 11:52:34.5836
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Fx3lVf0C/tVCnkPPEChoZux5sP8TfaOOaX+LHLwep9G94VVaG9UOM3wAPe1kgcik6KuNaH1bwVU++n//IkorTQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB5626

On Tue Oct 27, 2026 at 10:19 PM JST, Miguel Ojeda wrote:
> On Tue, Oct 27, 2026 at 5:19=E2=80=AFAM Alistair Francis <alistair23@gmai=
l.com> wrote:
>>
>> That was kind of the goal with `SpdmState`. The issue is all of the
>> drivers calling this (PCIe, NVMe, SATA and SCSI) are C drivers and
>> won't be Rust for the foreseeable future. So there aren't any Rust
>> users.
>>
>> I have improved things a lot with v5, let me know if you still want a
>> Rust API. It just feels a bit silly to add one that will probably
>> never be used.
>
> I mean, it is true that we don't want dead code, but in general we
> would also want more Rust callers in the future -- so I guess it
> depends on that "probably" you mention, i.e. how likely it is. So
> could you please elaborate? i.e. why is it that you don't expect
> future Rust callers? Would the NVMe Rust driver want to use this
> eventually if merged? (Cc'ing Andreas)

Yeah the "probably never be used" part sounds a bit strong to me, unless
there is a reason I missed for why no Rust driver would ever want to use
SPDM.

Regardless of that, I think it still makes sense to have a layered API
design where the (necessarily unsafe) C API builds on top of a safe Rust
API that enforces the invariants and other rules you want to uphold.
That makes the invariants that C callers need to uphold manually clear,
and avoids having C-isms in the Rust code (like we had with the crypto
APIs calls in v4). Not to mention my favorite: it makes things easier to
review. :)
