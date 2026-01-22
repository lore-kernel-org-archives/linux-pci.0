Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010033.outbound.protection.outlook.com [52.101.46.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D182366DAC;
	Thu, 22 Jan 2026 04:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.33
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769056236; cv=fail; b=LFchj2/MS47Svwd/UGhL4MB5RPVhGsBDT06DSlYJSDu1SFeOE8WgyhSKlo2unmsANJWrzXVdzA+DJWUP6Ddd0f1DWRUSj2nHFQ9q4tsULj65V5d9iw2hpafW4Hrp1yUYyj8CtGmm2VQ3dgyiRsz8a/IvfPTjcoXN8Ej5xpkTTz4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769056236; c=relaxed/simple;
	bh=jwa3kvrFC1zx00QjPInjIvEhVjcMxCMx9THQvj3tXSk=;
	h=Content-Type:Date:Message-Id:Cc:Subject:From:To:References:
	 In-Reply-To:MIME-Version; b=HEFVKcSdvaHcRDs7uVwV6Drbd/SkdWiC2U65WsjSmuxHG8n+7lkcJAIherXZFnbdXEBYInltNoMvmhn43WV1dBYhMQnpPPWRdAIXHeYS3ObLIdwiM9DKnGmvI7HfDWFH491W1VnsxhfAXRlEpGX8qqvn50cqjyGvaCcIJXLQ3OA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=nZaUTARb; arc=fail smtp.client-ip=52.101.46.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="nZaUTARb"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ArtRi+HDiYANFJrBGItZv1thcWuK1Hn8Hd+g677uEvg/YFLXdU0QtWYJ1gBSGZPUtzY02O4nNfVT9OPXmYaBQpcAPQm5CiQas48hpxqcFySM9njny5H0zPis4KEwDyLQq8hwnkqGnJ+Law2CPfmiUi5T4Vj4UT+ee+se0CKa4xb1G3ifL/iDrFcOUOGg82XcG0qu+RBp7wx7kPFN3RTyKZ6z6KjfyA89XgRiEJlAer6p+bImZQPiVWnZilM8g6DXd8UYemay1RZgDu2VnrwWVe3UPFwMhPlBg75ta0GShoX2tCNPHEWL/bs8nB65gQkE/R9qUj/xd3WT/Stiadmxjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jwa3kvrFC1zx00QjPInjIvEhVjcMxCMx9THQvj3tXSk=;
 b=yNu+h771ShX/fepgsZJ28Jr5ukJ44rQMnGL3QXD5+4p8IvRDtBG8I2nNzGOso2AiIfebxQOEr/WH0Hzt+QlpAPmHCUsCflT6w50+jKbGnC78bPyHkXx5L53ZtwZW2SuzeDYZQ/bU/xx4sFKp8ZiZ42GC4rASvXM07ZmyOieJ81eakuxedIR4Z8woczpcwHI6XqpZ6s/5xxhjz4rBZptdOZ2WfqfQ5N8dy2k/hqq9XjQFThnL5hwrQ2fY/MrGCVe+1tAPJAcmWfG1jK/WcFSCxglUzc/0h73if3MhuHNiucqvFVdDy4n0yUf0O/bmCxXiSCaThllj495HEghg21wxNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jwa3kvrFC1zx00QjPInjIvEhVjcMxCMx9THQvj3tXSk=;
 b=nZaUTARbaNjk1Epne+j6KJXzQd7RZOvWvpzbQHqRxa8iSfuEqAr45O/uRWNkK/hLYtAKRwTT1UfxYtDMdYHDtzYDD+iY8SLSrUtMor25iG9pU6lYi6mqt3AbRyI8PV/bG7y5Wkp2GyZzjrwU1ZeLA2eQAscwwytTBMx8TCr6/jjtj+/mwHuoHKAT4mBoORUHT70+QvnF5cETIXtA0f8mbD6JWKfuy2MLnpEq5nXsRqFlLrLxfdaLSFLPzhP6l2O8fQLrTd4dCvujVA4aWDY73m4s1b4t/R2RULxBrV/p7MnveQJsMaJfu1DWTfEYIB99MuMwrv+Bt3V+2y6yrnf2GQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB3997.namprd12.prod.outlook.com (2603:10b6:208:161::11)
 by SN7PR12MB6713.namprd12.prod.outlook.com (2603:10b6:806:273::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.10; Thu, 22 Jan
 2026 04:30:31 +0000
Received: from MN2PR12MB3997.namprd12.prod.outlook.com
 ([fe80::73c6:e479:9b75:b2cf]) by MN2PR12MB3997.namprd12.prod.outlook.com
 ([fe80::73c6:e479:9b75:b2cf%5]) with mapi id 15.20.9542.008; Thu, 22 Jan 2026
 04:30:30 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 22 Jan 2026 13:30:26 +0900
Message-Id: <DFUU3EZKTPPV.18K3I0INY03QK@nvidia.com>
Cc: <rust-for-linux@vger.kernel.org>, <linux-pci@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <dakr@kernel.org>, <aliceryhl@google.com>,
 <bhelgaas@google.com>, <kwilczynski@kernel.org>, <ojeda@kernel.org>,
 <alex.gaynor@gmail.com>, <boqun.feng@gmail.com>, <gary@garyguo.net>,
 <bjorn3_gh@protonmail.com>, <lossin@kernel.org>, <a.hindborg@kernel.org>,
 <tmgross@umich.edu>, <markus.probst@posteo.de>, <helgaas@kernel.org>,
 <cjia@nvidia.com>, <smitra@nvidia.com>, <ankita@nvidia.com>,
 <aniketa@nvidia.com>, <kwankhede@nvidia.com>, <targupta@nvidia.com>,
 <joelagnelf@nvidia.com>, <jhubbard@nvidia.com>, <zhiwang@kernel.org>,
 <daniel.almeida@collabora.com>
Subject: Re: [PATCH v12 3/5] rust: io: factor out MMIO read/write macros
From: "Alexandre Courbot" <acourbot@nvidia.com>
To: "Zhi Wang" <zhiw@nvidia.com>
References: <20260121202212.4438-1-zhiw@nvidia.com>
 <20260121202212.4438-4-zhiw@nvidia.com>
In-Reply-To: <20260121202212.4438-4-zhiw@nvidia.com>
X-ClientProxiedBy: TY4P286CA0013.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:26d::6) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB3997:EE_|SN7PR12MB6713:EE_
X-MS-Office365-Filtering-Correlation-Id: be9c7d1c-82bd-4335-e66f-08de596ef906
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|10070799003|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MlVISHdudGVvMVdGMjZ1UjhWR1A1OHRhZzZDOGoyNFBueERNN1BnblpsY3Zj?=
 =?utf-8?B?VnEwbENPRnVmM0RNRjh4azZUNDN0YkdDYkJBRGh5WXBLTlpiTHhuKzJ0NEtO?=
 =?utf-8?B?UFlPcWIvVlVSUXJsWUYyNHI1ZlUycWs2dkIxWWJMWFRqQ0s2ZTJwK3U2dFpQ?=
 =?utf-8?B?ZC9jSUpaNkFsZGh2elJabG96QWNoN1hvNHc2NWMrUFFXdGl3SUJZZnlVc1dl?=
 =?utf-8?B?YWdYdytlbE5EN1NpWEh3VUNGbGlBSXNuYjh2WEl2ZVIxNFFmR3N0ZHduMXA1?=
 =?utf-8?B?TXdwL2NxUWI3c2R5dCtXNzk5ekRUYmpIdDV3d3pRWFhaTXNWSVJoa0JNeE42?=
 =?utf-8?B?aGtLcDdNNkRmTjE3TzQrTTN1MDh3amx1V2hDaGVqN0Y5OU5Ld3RYYjZCYlVy?=
 =?utf-8?B?UFUzNUVUc3BrZndHcGFJOE9Bc2NxdUdYZjFHN2ljVDlTR2ZISW43eXhKTElm?=
 =?utf-8?B?TVVpZ1F1Y1F1c3NhdUNMQ0dITGZhbkdqRXR4WEZvaUJEUG1rTCs4UjNyNnZs?=
 =?utf-8?B?TE5vTXlyQ1I3NUxVRUY0UjFSUzJ4SGZuNnhDLzMxR3lzeVV3QlZMZ1dnMmNS?=
 =?utf-8?B?bkFseStzeW1iU2hMYk5kekFCV09vRWZ3NE02T1Nkci90b0hQN0RyZ005eENq?=
 =?utf-8?B?czF6RGM2MmwwT3p4TlZ5VlRiODhVRUdnb3JHTm5lNmREa2RvR2hmMElJclYy?=
 =?utf-8?B?ZEJlQkxRZUIwaVZLU0VPSVZjRWZmTXBQdFBDNE1Ja3h2UmVEeFBRc3pDdHhO?=
 =?utf-8?B?TlZmd3I5WU00MUxwZzhMS0dNY3FCYUp3NjFFQ0R4Q1k2SGhtNCt3QXVvNndj?=
 =?utf-8?B?Tzh5TXJDOWRKWWw0N3pWTXZvVVBjaWZPL3NlT0U5SlZjT3pmRlNXQjlvSlE0?=
 =?utf-8?B?K2NjTk1mdGJRWGxMTlhYNlVENW96UTg4RDhQYUg2RW9HaFlJWnVtMXZjVzRs?=
 =?utf-8?B?d0VVSUVrTmU5SFBNNVdYS1pha1BFR05NSzkwSStHWXhFRS9XVTJ0bzI1NDdk?=
 =?utf-8?B?bW5hYzJlTk5BVGx1NE9BTEV3UGVJNjgyQ1ByNDNEcU9BczBHZmttSjMwaTA5?=
 =?utf-8?B?dzBrUlcxQUs5Q05qdm0ycXZ3Tk1UNFMwUTlNdlZkeUMyOVorNlBmWE5oVWkr?=
 =?utf-8?B?VVZXS1BUVWZpbEFocG9sMHl0OFVjZ0VuNE1TcXpHZ2o5MlkvVkRiU0RpUE9X?=
 =?utf-8?B?V1ltM2hWcHpyUWM4R2RYYnZ4LzU4NGxMZ2F1NWJtNnlMUFBBWnp4Q0ZNY3pV?=
 =?utf-8?B?d1JucXMwWlZqaHNrdlpTZVdWMTJqVDdoUjlWWktyWTE1V2kxZW9mSjRITWpZ?=
 =?utf-8?B?aHJHbktVREpWWnd3TUZRdzBiYU9uSE5VSW5lWDR2cXNxUFI5NUN0SFYySVF3?=
 =?utf-8?B?WFplNXVKakdPMGEyUnNCYW5tTkJZVGNYelVTTU91NkxxbVMvc29xQVdRckp2?=
 =?utf-8?B?NU5MY2k2RkNJY01DRFlnWUR2QTdFeGpFd2QzYU1wMjVVbTdHTTZGS1QrZXZB?=
 =?utf-8?B?WDA1cmxKam1pRm0vcDZRbmo3cVJ2S1FoS2hVdjB4RkY2YzdYcldxVzIvNEFS?=
 =?utf-8?B?MXB2VEpxMWNIbUU4SGVFcDRZQjRHa2VYVnAvYjBEbHpSRlBiVys3VStZc0VM?=
 =?utf-8?B?S3ljK2l6NGswckdwaFRuOGtaa1l4a25SL2JPTURJMmw4cDZRS2hyNTVKbVBq?=
 =?utf-8?B?aG5DQnVhT1pacjlCbVNOeGpFMlplWnFCb3RCSDdmbUIvNFpMUnV3WFFIUUhm?=
 =?utf-8?B?RkZFR0wrZmNFQzRKNXZENVZJeEhFNDFPSmNxWGNXZ1JDUzN6WG1oNTNkTnha?=
 =?utf-8?B?ems0SVovWDlqZUY0VmFHRUppSmlhem1QUld2ZFczb2dUZVVvanZnY1ZGczl4?=
 =?utf-8?B?bUd6aGMvT0RoL1JuQ2lvallYR2hUdmI1cEdyOGE3akNFR0NGYzF2MmdrYXg0?=
 =?utf-8?B?blVVZ1I1MVMyY0xpWGx5WDMyV284bFlYdm5rZWRKUEdJYkFZaGNEYkZsMG1x?=
 =?utf-8?B?NXFjUGdKbm9ZTUprODd4TDNEUno4MVhyMUdnRjZLUkNuenpwTjhuQndDMXpo?=
 =?utf-8?B?eC94VVJJeTdHYkRDdkRvZGkxc1ZsZ01wdnBmMFp0bUt4Zk42NWt5MTBuVmtQ?=
 =?utf-8?Q?Fpys=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB3997.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(10070799003)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WkJwS1AvMitJcjNZUjFZVnFzdFpybndDNHV5YWVkYmR3T0lZRzNOendKNjd0?=
 =?utf-8?B?RDc1YUN6blFVWlFnaXhnNmJZT2RIbWdic0wybjMzSnlzVndwdXlLVGNpMFpE?=
 =?utf-8?B?R2xDSHJhL3lWd3RuNEFxMjM2cVZxNkM3SThyb1U5UGhSQnUzUVllYnBseW5V?=
 =?utf-8?B?NW5zank4MERKSk9BdGRHS2lUemp4MzdHRHJJU0gxSlJKYUdMTUxBNjNhV0c2?=
 =?utf-8?B?c2pvR1JKMzFuZEtMdEhlMlNzN3F4OFp0MmFYcWxlZW83amRDdzcyOC93NUtL?=
 =?utf-8?B?RHJlRmRxa0VXM0NvN1F2d3QvaVRVeXlXTTFkQWRVckl1YnFyQUIyb1VGQmtP?=
 =?utf-8?B?aFRFZUpSWW5FT2RJaHVyMTB0MFVBOTdCTEllR2I5aTZwWnllcjQ5WUZrNzBn?=
 =?utf-8?B?YVVFZkZyQ1ltQW13RDdmQTVJQ095aVRiN1NIYUFqYk5pcHFYY09qWVZxMXR6?=
 =?utf-8?B?bVpEdHJUaVlHcFZROVJXUGdWaE1wNTNodk9Ea1FrOXlqZ3R2bW1UQ0lHUGlB?=
 =?utf-8?B?WGllc1gwVXVzV3VncGdJdE9aVnZEQTRnNUhZUWRrNEtXOExQVUNadDFUakx2?=
 =?utf-8?B?N000b3JySTREbkUzRlMzNXFhcTRnTWM1UDdZcmxwUEptVjFucG53ZmRkdE0r?=
 =?utf-8?B?aEl3S2daekRBTXd2Vklja1QvdUxzMFN3WHlmOHBHOW0vMDJUM3QwNS9mVDJp?=
 =?utf-8?B?Z2tGeHdlcENxVnNad3lnZ1FHV2plSk84bFFIUkNBRVRxNDA2RFQ1MXMrL0JE?=
 =?utf-8?B?Zjl4TXkvS1BaUjJMcmovaUxkMVNCaDZPRUxTOUsvSHJvdDhzSUZOVEtCc2Jk?=
 =?utf-8?B?c0YxNXZwa2J0TTl1bk1mYS9PMm5DbVhlZnoyMnpVTEh6UUwwL3FVZGllTDVR?=
 =?utf-8?B?MHg5NnVrS1VBYldzYnBJSnJiVE41Nit5RWRNSFRvVmhyU1JMUE5lL0JvWk94?=
 =?utf-8?B?eHh1QitVOXBiOUV6Q0FzYVg1cVZxcE56ekNQMEl0bDdVaG1Fd21jdjQ3ejdX?=
 =?utf-8?B?cHZQZS95eTFoNFdsd0dFYi95dzBzanlHRG1EUHR6enZVaEt1U1dSQWpYMlFo?=
 =?utf-8?B?VTlUUTFBMkxicEM2MFFEUGJFNmJhTzlSQitIY0ZZNjYrWTVKUkd1RG83ZXpm?=
 =?utf-8?B?eEFIdlNvVzNBeituYVRJRFUySnR4RVpwODlpbzkyYWRPdDFYRm9td0Q5a3o5?=
 =?utf-8?B?dUV5b2JlaVVWVzdjdmxwTEpHT2dGZ0NHaVpmM3VZZCsxb3RqOTc4VUZmZHho?=
 =?utf-8?B?S2Z0SzBXQnFNR01XdElNY3pHS2JJM1hRRmM4K2ZSc2tLSkFoeEVUSmo0QUw1?=
 =?utf-8?B?YTFqVEhOeEpVMFVKVzVBMUNaeSsxZk1hTVlRemZMbUZOZ056bXB2b0NCSGZM?=
 =?utf-8?B?RS84ejlNSnBUUktDZXk0WnJSWEErbjBzVGk3OW4wUklCZDRyZkNoclptdFhD?=
 =?utf-8?B?dVZtNlZ2N2R4dFplWUp0cXRsWkFiaHlJYk03RitkS0ErYTdUYWZ1aTRWcllC?=
 =?utf-8?B?YVVISHQwNitXdGdURGIzVWFiRDZaMzZpaWVoM1FqQUZwTExxdE9IUWVIbDl6?=
 =?utf-8?B?MFExUmhpRmJXZTdZTzZESWxDTmQvRXBEWVFuT0xrOEVWY0ZIVXo4NHRjR2dU?=
 =?utf-8?B?b1plMytBWjhjRW1qdnlRTVpyUlhTTC9hT051ZkxrQ0JlTjFzTlFMakpIMVNX?=
 =?utf-8?B?ZWxCOWZwQXl3dUZ2bXorYjVDMU1rdmNhYkhhSTVWeHliTTVJNjQzNDB5WFY1?=
 =?utf-8?B?REpUeUhuYVcycVB4YUtxUFNOYmJ3aUV4VGdCK2kvVlFQSjB0YjJ5Mnd1eC9p?=
 =?utf-8?B?KzhhcS9uUjNpQ2JncWdZNE5HZnNCY3BHa0hRL1VIMHhNalR3WnFOWVE4WU9G?=
 =?utf-8?B?U1JVSGVIWkE1eDIwSzRuSXFqYlplTlNFcUFHaGVydW1SNFdHaHlzRHcvVHJO?=
 =?utf-8?B?aHpVN1BiUUE1Z2E4cXd4Rkxybm9wY3hITlJGSzFCZDBHckExZFJRMkdtakxz?=
 =?utf-8?B?L3VhSFNMNEozZGx3TGlscWFUbmlza2ltb01JbDdRaE1zVzVkYW9mcUZ5L1ZS?=
 =?utf-8?B?MVhQaUR6WFZkWHhYT3JmT1VZSUhWbWZSUUtkWFRVd1BBUXhqMWs5YlVYTitz?=
 =?utf-8?B?aTNQS3NkeHc2U1ZtbW9WNGhOeWlITk0xMEtVVGlsZlNVRStodGhkOE02MFZJ?=
 =?utf-8?B?amU1Z0hnVDA1OHdFdVcvZVhBRmczRmxCZlBsVUx2N2tLVm5Wc1V3SWczUkE4?=
 =?utf-8?B?M1FCay9FUU1SbHJPZFlWL0pwKzlEMWtway94bC9KSHBodDcyMVN3Y2dnRUhQ?=
 =?utf-8?B?dmVxeVhvems3L3hnZkh4RmJDalBRUEM4OVNsMXpGOW11KzIzR2QzV0Zmd1dI?=
 =?utf-8?Q?Pl5AlK7uWkQRnlAagin0/ars++XJGjdXjZSm6Kq8X3Zjy?=
X-MS-Exchange-AntiSpam-MessageData-1: e1we+KBPjCniRA==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: be9c7d1c-82bd-4335-e66f-08de596ef906
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jan 2026 04:30:30.8264
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SsQUdE76x7H2LyOBvhkWzEs3SdDHIQQZAgN3QQJGjKO/tpk1OyUoHzZkHxwai/Uf34E0LeCcqEAKco2WrlNytQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6713

On Thu Jan 22, 2026 at 5:22 AM JST, Zhi Wang wrote:
> Refactor the existing MMIO accessors to use common call macros
> instead of inlining the bindings calls in each `define_{read,write}!`
> expansion.
>
> This factoring separates the common offset/bounds checks from the
> low-level call pattern, making it easier to add additional I/O accessor
> families.
>
> No functional change intended.
>
> Cc: Alexandre Courbot <acourbot@nvidia.com>
> Signed-off-by: Zhi Wang <zhiw@nvidia.com>

I still want to eventually switch to a trait hierarchy that removes the
need for these intricate macros, but that's a few more step ahead. For
now this integrates well with the current design.

Reviewed-by: Alexandre Courbot <acourbot@nvidia.com>
