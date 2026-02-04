Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011012.outbound.protection.outlook.com [52.101.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A97753D994;
	Wed,  4 Feb 2026 15:25:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770218742; cv=fail; b=iYgLeDb7+ziahOfZWpo49UpD+P5g3Xw7D/wRX9AOvnzBXCDNWTbLBMuNrpT3GV0nl424LZoRuxa2OjTX7a8nEiaGo1GCO5KFWi/spfFYQQYs8sZYvmQ/AbXhQm/7QdhmEBfHWwldnk59rqPAJ/OlaywXLoMVmu02yrA9mjSK0Dg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770218742; c=relaxed/simple;
	bh=eyC8Y7cQrojoe3J7+4WxLnfcQEFyMPXe52IClhHzsys=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=HZcLz1Y/KxwWszyyyKXMu5qRt4JTdjv/RRNXQLuiGGRQxOsFn670PkrTSEE6XBkrlvIKkOwpf7MaMg4TpvJbqYSyqp6uJV/EPRWCRILd9G2ckhzMpNvSBBrAJihaVDV/T8+AwJkiGjAro+WZmLDVtJbDSsSWbZUQwaWRuRaNWto=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Hr1zxp62; arc=fail smtp.client-ip=52.101.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Hr1zxp62"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iNT6u0ipFlB61HWrkPWq71wCPNrPwMQRZcvK2D/VjRPe+D+j6OlgasSzf5gCMDV4igSbRgbv/GY95HO5S4Ik2Y2rsdaZv9c8s076S2w2T4CHujXv3RWUa73keJtdfXHwdXoSAwjqHz0II5iDAGkj/Q+damdLch41xmASIR3B6HVMBXUnNq8HaNdiyR2Fgt/FAW/dfn2h0pZJI11FTfX2an4L6DBWny7ZB6VDzopbYJXO/XYhRnqX+165VfRAqsKGHMABgJkRqVhnHW8tgAAZYPb507yAeQ882RjYXcMERKHYvwGkN07J2TsBOsPFZ3jITJKzh2RCPycxOD5BG042ZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hLYwSRQInMKmP3Ve6Ub6WqonkNQ+X6hrgVfEqO/VVwI=;
 b=h41Ph5sxMRs4+pEs20Hwe3EvYTjbdDJZuIDumNBdJZvud93rNbBzWot3z96wKs7ZsiSWx6c+hVdp4v1OsmAbsJLUIubj3GrjEB+ORhD9Y7iAnIKqdiSbh117PECELcNIL+ozBX0C+EfcekAeXZD7fcdZQg0us23zElHoDwwnWj3aFw9yupdQx1Ain+WWB3DJcR521dvcKXr7LxupN0j0DlbWsEx3aTNfYYceOkuKGwKb9x37bKgQVLqncE7oCnv0ponL1u3gMYMsh1HQ0bQh6N7AQKM9CBiAzf3gCRa8zeXSM5GcOshsfsf5m8x9Y5T6C+UH2d3AO7en0yVfOi+NMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hLYwSRQInMKmP3Ve6Ub6WqonkNQ+X6hrgVfEqO/VVwI=;
 b=Hr1zxp622ttT0+J0Db6U9pfPjSOqJhnK0/r4Gpj/y+8oOeuJJLRGd0kMSw4cGJ9XJ58n1OymuI1LakiG8rJmTM3QQOtmg6JSyw8fMYLmpGHDyhyEpD5kSsGJsoDQ2/VuyN8fsTU0PFxEfdw698HWO02ZZYtvcA7HjTdlEnvmJ8e17g0jYTueHebBIfkSdUem8iLtMDvITszh1yHKoWyQxRzxKQNXsn0rt1TK/ae4fWoQdXXXaGquvj7IEi+Y1IGhuRobz9gaXL/cU21Xsymg/QunGfqS8nA4L3XjFMz3/h7rdyx+iCuBqTMxx6O5+j8OX2xGJrTdLc7yD7nMI7x6AA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com (2603:10a6:102:2a9::8)
 by DBAPR04MB7224.eurprd04.prod.outlook.com (2603:10a6:10:1a8::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.12; Wed, 4 Feb
 2026 15:25:37 +0000
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588]) by PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588%6]) with mapi id 15.20.9587.010; Wed, 4 Feb 2026
 15:25:37 +0000
Date: Wed, 4 Feb 2026 10:25:28 -0500
From: Frank Li <Frank.li@nxp.com>
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: Sherry Sun <sherry.sun@nxp.com>, hongxing.zhu@nxp.com,
	l.stach@pengutronix.de, bhelgaas@google.com, lpieralisi@kernel.org,
	kwilczynski@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, s.hauer@pengutronix.de, festevam@gmail.com,
	imx@lists.linux.dev, kernel@pengutronix.de,
	linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V3 02/10] PCI: imx6: Add support for parsing the reset
 property in new Root Port binding
Message-ID: <aYNk6C_W_oSFVqbH@lizhi-Precision-Tower-5810>
References: <20260203015614.2957479-1-sherry.sun@nxp.com>
 <20260203015614.2957479-3-sherry.sun@nxp.com>
 <nekxn5osukwkumqfh4qabj6okhtv4tdwrnthza4x54psrhauyf@p3lhia4mkhb4>
 <aYIztYs/07WBLsAq@lizhi-Precision-Tower-5810>
 <pz5zmte5dbb23ccwvc2xkl4grptr35bmcwd6ohlzo2arjopgkw@t3euzojtsoyf>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <pz5zmte5dbb23ccwvc2xkl4grptr35bmcwd6ohlzo2arjopgkw@t3euzojtsoyf>
X-ClientProxiedBy: PH7P220CA0131.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:510:327::33) To PA4PR04MB9366.eurprd04.prod.outlook.com
 (2603:10a6:102:2a9::8)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB9366:EE_|DBAPR04MB7224:EE_
X-MS-Office365-Filtering-Correlation-Id: 806789f3-6c11-4c49-ec33-08de6401a5aa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|7416014|366016|1800799024|19092799006|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?anZEaGJTNVVBaUZyREN2RWlwNVlzVHJCRWlHempHV0VIMmRmZWFPRGVOSG56?=
 =?utf-8?B?aUVnMVFlZXo0NXRSZFFHOEVUVU0vbnZCdW1qVXlTeDhQMDhkRWh3eEQyQ3Z0?=
 =?utf-8?B?ekRhN1R3bzNNSnFLc1F0dFBHQ2lmS09WS1pOTmtRbFBNYnBINjE2b2hjWCtT?=
 =?utf-8?B?cngzaFFjWHlDM3ZKWDVNSDFjc3pmVjd5a3hpOGkzS2ovbC9TbWg5emVmSzdr?=
 =?utf-8?B?Y1BLUnNzQVBmb3p3cnhnWkFmZnJOYU8vK0JtMjBtRUc4YVZhSjFPMmZ4VmVK?=
 =?utf-8?B?dUZDcGI0NnVnMW43bWExVjhIMXpEdHlzRXgwK1drTllDVnNib1dKaUo1TXpM?=
 =?utf-8?B?d2NUK0Zqd1A3ZFdoZ3A5MTVoY0V3VXZ2UDQreFYra2JYUE1vVXNheVJ0bXMz?=
 =?utf-8?B?OUlJS0haR1BGNUo1NDJ5VTdybmhNaFZDZkdkeTU0bVlidEJWV1dsVmFENDBV?=
 =?utf-8?B?Y1ZlWlNlVkFtYXdiZS9GdjZsQ3d2eDR2VFp5cGs1WllFbGI3ZFFRckFObHFq?=
 =?utf-8?B?ZUFnUlBMRVpXR0N6RDNiakJXTDN0cXBzL0ZyeTFuMk1KNzBSb1Y2NmJKL1hV?=
 =?utf-8?B?NS9vZUQ5dTR4eUZUSjJMNE1sVlBDcVFKcUJCOE1UbEUzQ1ROSzdtTmJjV2s1?=
 =?utf-8?B?MU03NE84T0NqTnJpamRvb0ZpK2p2NDNCR1hnSk5zZmNFNDcvVi81Z0ZJL0tx?=
 =?utf-8?B?UWlNK1ZwMFVQZ1lCU05BY2RjaXJwRzZGYTJydWdqMVE0L0ptOHowc2VoQkJw?=
 =?utf-8?B?djJPQUlFaVV2aEVpUHd3UmdRVFNVcEo2UDI1d3BnQ0kvd3NyN0wwem1XZkJj?=
 =?utf-8?B?NnpzVkpRZlE3cXQyM3N1OXZ5SlV5UExiRmo4czhaRUpXTVJaeXpnZnlGcjRB?=
 =?utf-8?B?R1RZMklrdExhaXUxbzJxMjNDeTJhbnRnTGlIWVlUT1llUko3QUU1SEt6NVVi?=
 =?utf-8?B?K0o5ZDFQRHIzSlJoVnVDbHlJcnZvNTVRcjRCcEJJdTdKRTY3RXF5TDNCNFNB?=
 =?utf-8?B?YmdsQ2JYcnloeE9LdW42RDdjWHBxNS9vbzUzZ0xkQVZqUGVsZUZOdUdkaS9o?=
 =?utf-8?B?SjBXa08rTW1SSDR1SjBVOFliYUd6NENmRjRZOHF0d1YyVXVQejNPZEJmTldS?=
 =?utf-8?B?S21zeFVpR25CK0F0cXU2TS9scm5xYjVKYXRVZ1ZlUzdVQm5nQloxc0t3bXd5?=
 =?utf-8?B?b3lRdG5JYzJPN2dUWUJYeGYzb0sramRzakx4bEVIaFIyV1pnb3k1WVd5bUJ1?=
 =?utf-8?B?R242dHFiNzFJWmh5QkwwdG9mR2JySEJWQk5iazdjNE1EcTRVTDhpd3V1QXhY?=
 =?utf-8?B?Zm9KYWVGendOVFNmK3dzV29hV0JUcjcwNDMrQk4rcHJtaFNYT20rZWp2ZjYy?=
 =?utf-8?B?Rk9HcEhaOXFMcis4K0tFV09YWnpmQWM3TklsOFJPSFA1SHN2N1dkK3hDbGkz?=
 =?utf-8?B?QTZaQVpKSFgvdVI5RjQyRU5BeStWWTFGd3hZTVRGU1lZaG9uTDBoN3o3TStt?=
 =?utf-8?B?Um5GV3h3SUhINWM1cnFtcU8wRC96VXpMSFhWU2NLN0RQMlhmZGg3YWtwcDV0?=
 =?utf-8?B?NCtrTTJyRUFIZkZOMEd1dzdNVUdza2o5TWJPRnk2NENzNWtpRDlVbUtIUThW?=
 =?utf-8?B?ZnFNUkVWb3FlTlZOVk10ckdtbkJ1a1ROeUM1QjB3dXA5UCt5dmhBSXZTcWhF?=
 =?utf-8?B?RWlOUERxSjdSQ2VuK1VVVU1iT280T1NjRHdNQkFaZUkweStFVEhiUjN2a0Ni?=
 =?utf-8?B?a3JTdEdkZGZFbDFuTjByMGpUTG5QVzhqVUQyMnJPQmlEdGZIS0pqU1ZaWUhC?=
 =?utf-8?B?NmJiMkJmT2dLc0pHQ3h4b0MwLytkaVBsNW0wTWU3S0RsQ2pqdUhCMzY4WGtv?=
 =?utf-8?B?YTVENGFsVy9ra1dYNDlFenB4NVI5Ty9uV0cyV3NjWWdyTEdTejl5eUE1bWR6?=
 =?utf-8?B?MFJlMnQzNGFzYWxzdFhxVmhSUDZ0QitXSnJkTVNUTjBYTjNzS1dyM3QweVhV?=
 =?utf-8?B?d1poOHdvRklhakk4UjBIbWx6QWxtcXd4SXUySzNCcVB2bjVNdFZkRG5RaEVK?=
 =?utf-8?B?dmVIOVpYbTBoWE94YW1waGhZNHp6ZCsyL1R6Q1Y3Wm1SZ2c2OE5Sczh0bkVV?=
 =?utf-8?B?T1lmVmFRMkV6dXVwRE81SlkyVER1cisybVNxblBqYmo4dUVINFhNcndTY3ll?=
 =?utf-8?Q?s/P6tCAQd22U8asCh91G5/k=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9366.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(7416014)(366016)(1800799024)(19092799006)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UmlLOTUrWk1tRTc3TVZGYU94ZUFsWThIZVRrTGxUem16SW9oRVZNZ24rUjVy?=
 =?utf-8?B?QXJxM0NlcDNwME1Lc3FzWlMwd0tUQWxOS2pVY3BmT3Ntc0wzcWQvQ3lKMEhi?=
 =?utf-8?B?Y0kyZHFGSHQ2ZnZxSGQwcGhnUW9mNkNTcDhQMU5IWGpUQ01PYmtkVTNLTEs1?=
 =?utf-8?B?S1NCSjZxWUZmVExvcW0rM3FvNmZESmpMNkZwUE53YmhFb3RTSXRjd0NqU0Jn?=
 =?utf-8?B?WHoxWkduUnFIUzJtU3FGdENlNVVocktabHR0aFJ3V2N0RWQ4RXZBTloxTWVl?=
 =?utf-8?B?MGJBd3dTRkg0MDNsZllsV3FidzNXRUhFbmtxejBDckJ4czJIeGJkSGcxaFMx?=
 =?utf-8?B?SmpNaGpmU3lrNmp5d3p6dFBSMHVzcUh2UEZKbUdKQTZSeENKVkZ4N3cyZ29O?=
 =?utf-8?B?ZzRaU2xvR1N2dnVmcnUrODdtMFdUSm5IZC9xZGxGYUdXUC9OR01zWmJVMld2?=
 =?utf-8?B?WFYxL1Q4WHpydzltckNZZnBXRCtVYnVVS1lrZGgyYzMzeHMrZ3hsbkpZK05D?=
 =?utf-8?B?UVZ5YlE5bUNmSHNaTHhQMjBCRVptTmptVFlvdVM0N1kwc0hyWFNhcTdnajFT?=
 =?utf-8?B?RjBqOEV5SS92WGpkbWEwQmZaekdDZXVSTVVWS2ZNdDJJZm12emhzenlDYnpB?=
 =?utf-8?B?cHl4YmZJVEd3bTV4b0IzN240SEltRlR1NS8vN1RaSTYvQ3BoLzlRZ3JpSEVv?=
 =?utf-8?B?ZEN0U0ljb1pnK0gzSzcrN3JKZWZwQ09SV1A1NURobEg4ZkdRSWQ2Qk5aYWxy?=
 =?utf-8?B?TlRkUzN4WGxPZUIxdVJlQWMwaUc2em8wcnFkTmdDNXRGMHF1OHRXZnZqVWNl?=
 =?utf-8?B?aW5RWGNVQ0VtSTZJR1hZV3pUMkFJZVV6cGprdjZUeTBEcExqR1diZXZMVG1C?=
 =?utf-8?B?L3oxazBTNXR5dnB4WTNESVZLNW5iSlRLQ1NJTzdNVkRFTGpVV2xXdDBqZS9T?=
 =?utf-8?B?TlVxdHprSUI2RjAwbUU5QU5LMEh4WUxReFU0c0RsM1BXVzk3SjNEcS9xWDBL?=
 =?utf-8?B?WU9rckxqVXBKaDB1Sk4rNDFsOVp0cDlrc2h0SnczanhKZFRaYkI3VU5GZWU4?=
 =?utf-8?B?cERyYzVKR2RLNVZYYzB3cTFEdG5XOVhJMkI1Q1crVjhvQWFvZGREcWVseVlR?=
 =?utf-8?B?L3RCc0JvSFNTVndZSDFLTWpHNStoekwxUzM2K2dyTTVXRGxWSXdzd29ZRkc2?=
 =?utf-8?B?Q0Z0RnZLTENKRVJ3TzgwZVhncVZMeHRLVjNEYXVDRm1qV21qMFRhaHBVY01Q?=
 =?utf-8?B?YTh4MHVjY0RvN0FEdDJSczhINkR2bXNKL01WbzdxZEFtTENIbVZ3UE5zT01t?=
 =?utf-8?B?YUVhUTR6Z2ZxN1lUcHV4dVhWSzYvb3E0Z0ZTL2dPQkRvZG5hYXE4RUc1SmZy?=
 =?utf-8?B?WTVJSGNyWXFYTkxRMjM3YzBqNXc0eXlQemI5QVVHVUNJbTNkNlFZaDl3SElm?=
 =?utf-8?B?bE5YTDZ1TWdnenpnSUIySkl6VmZ1MEYva0VLQTIxVThERzNjbTQzZlJremZr?=
 =?utf-8?B?OUEzQ1dFNnRING4yc0pKaHFzMitHWlZOZFpNeG9FTEUxczBYYmxua1hrUXBj?=
 =?utf-8?B?aGxoajl1c2hiWUttSjNrNi9ENlpLVGkxcW5lU2tQMlFkK2M0U0laODlQRTgw?=
 =?utf-8?B?WnlBOHE4N0VWS0pDdkgva1dROW4vRnFjenFXZ0ZLVkMyUEwwNVcvZDh1WEZt?=
 =?utf-8?B?NkE2bUdGS0wwSVNoTGN4NkU3VGNZUmtXaXc5Z3NFQWFSVGdlbENZS0NpUHRX?=
 =?utf-8?B?Y1FPeVV1OVVRQVJlaEdORGNxaWt2WlBTR25zL3ljMFlkSWJuZWJlZGllSE4v?=
 =?utf-8?B?TVdTZDhqNzJRb01Rb0JCSmxPaDVubCtRampqdW15dldGcWd4ckIzYVROSWlw?=
 =?utf-8?B?KzMyZkhXTXR6S3hTU1ZmMkdqd1FrRzF1eUV4cEV0ZWZZV2RTR1BqUDkxTXZp?=
 =?utf-8?B?WHdoK0gzdERtbGU4S1k1Y3g1K0ZVOFVKNlFtN3ZDemlLSTdrWlBiV0ZUSEFi?=
 =?utf-8?B?M3dFUmZDcm95OFljU1IwYitQTGVYWTdxM2NvMXFJQVBFdWtiVkxDeG4wMzBY?=
 =?utf-8?B?Z3U1ajNYWmdDajZKMGpQZmVLUFpEVDZXUk1LNUh1WDBpdHE1LzNsQjhWQ293?=
 =?utf-8?B?VitLT3dCVkVwM2hsWWtnUC9tVFl3MW5YcUFQV01TaFp1bzc2RlpQWDNFUEl3?=
 =?utf-8?B?YU43NmpBN2JLNVh5cGdoZFV4REZGWXA4ZTE2Z3N2YmRHZFprdWl1S2xsM0RN?=
 =?utf-8?B?V2QwaHlsc0dWSk5tU0lqby9IQUx2alp2QkxwYTZyTFU0dGhqKzhWRTlaZmcr?=
 =?utf-8?B?alhBWjAwcHFzRkZzWTdkSGUrUzhINkpaTWUvTmJzTUlsRUJDWFdZUT09?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 806789f3-6c11-4c49-ec33-08de6401a5aa
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9366.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Feb 2026 15:25:37.2238
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ykvdBugiHgvr/n0bqsCtZj+WZIKuuPFJi5xSQVlQ5Ka1X+/MX2KQqA0Swv9/rVSxvRpONeHlo2oIdSJO+HHIqQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR04MB7224

On Wed, Feb 04, 2026 at 05:58:33PM +0530, Manivannan Sadhasivam wrote:
> On Tue, Feb 03, 2026 at 12:43:17PM -0500, Frank Li wrote:
> > On Tue, Feb 03, 2026 at 06:38:18PM +0530, Manivannan Sadhasivam wrote:
> > > On Tue, Feb 03, 2026 at 09:56:06AM +0800, Sherry Sun wrote:
> > > > DT binding allows specifying 'reset' property in both host bridge and
> > > > Root Port nodes, but specifying in the host bridge node is marked as
> > > > deprecated. So add support for parsing the new binding that uses
> > > > 'reset-gpios' property for PERST#.
> > > >
> > > > The initial idea is to add the PCIe M.2 KeyE connector support and PCI
> > > > power control framework to the pcie-imx6 driver. Since the new
> > > > M.2/pwrctrl model is implemented based on Root Ports and requires the
> > > > pwrctrl driver to bind to a Root Port device, we need to introduce a
> > > > Root Port child node on i.MX boards that provide an M.2 connector.
> > > >
> > > > To follow a more standardized DT structure, it also makes sense to move
> > > > the reset-gpios and wake-gpios properties into the Root Port node. These
> > > > signals logically belong to the Root Port rather than the host bridge,
> > > > and placing them there aligns with the new M.2/pwrctrl model.
> > > >
> > > > To maintain DT backwards compatibility, fallback to the legacy method of
> > > > parsing the host bridge node if the reset property is not present in the
> > > > Root Port node.
> > > >
> > > > Signed-off-by: Sherry Sun <sherry.sun@nxp.com>
> > > > ---
> > > >  drivers/pci/controller/dwc/pci-imx6.c | 123 +++++++++++++++++++++++---
> > > >  1 file changed, 109 insertions(+), 14 deletions(-)
> > > >
> > > > diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
> > > > index a5b8d0b71677..e3ba68976bee 100644
> > > > --- a/drivers/pci/controller/dwc/pci-imx6.c
> > > > +++ b/drivers/pci/controller/dwc/pci-imx6.c
> > > > @@ -148,10 +148,15 @@ struct imx_lut_data {
> > > >  	u32 data2;
> > > >  };
> > > >
> > > > +struct imx_pcie_port {
> > > > +	struct list_head	list;
> > > > +	struct gpio_desc	*reset;
> > > > +};
> > > > +
> > >
> > > I'd love to abstract the Root Port properties in a generic struct so that we can
> > > introduce generic APIs to parse the ports. But I'm not asking you to implement
> > > it :)
> > >
> >
> > good idea, where is good place to put it?
> >
>
> drivers/pci/controller/pci-host-common.c
>
> > > >
> > > > @@ -1688,12 +1771,24 @@ static int imx_pcie_probe(struct platform_device *pdev)
> > > >  			return PTR_ERR(imx_pcie->phy_base);
> > > >  	}
> > > >
> > > > -	/* Fetch GPIOs */
> > > > -	imx_pcie->reset_gpiod = devm_gpiod_get_optional(dev, "reset", GPIOD_OUT_HIGH);
> > > > -	if (IS_ERR(imx_pcie->reset_gpiod))
> > > > -		return dev_err_probe(dev, PTR_ERR(imx_pcie->reset_gpiod),
> > > > -				     "unable to get reset gpio\n");
> > > > -	gpiod_set_consumer_name(imx_pcie->reset_gpiod, "PCIe reset");
> > > > +	ret = imx_pcie_parse_ports(imx_pcie);
> > > > +	if (ret) {
> > > > +		if (ret != -ENOENT)
> > > > +			return dev_err_probe(dev, ret, "Failed to parse Root Port: %d\n", ret);
> > > > +
> > > > +		/*
> > > > +		 * In the case of properties not populated in Root Port node,
> > > > +		 * fallback to the legacy method of parsing the Host Bridge
> > > > +		 * node. This is to maintain DT backwards compatibility.
> > > > +		 */
> > > > +		ret = imx_pcie_parse_legacy_binding(imx_pcie);
> > > > +		if (ret)
> > > > +			return dev_err_probe(dev, ret, "Unable to get reset gpio: %d\n", ret);
> > > > +	}
> > > > +
> > > > +	ret = devm_add_action_or_reset(dev, imx_pcie_delete_ports, imx_pcie);
> > > > +	if (ret)
> > > > +		return ret;
> > >
> > > I'd prefer to do it in err labels.
> >
> > we just removed err label and module remove.
> >
>
> This driver is always built-in. So the only way 'struct dev' will get freed is
> when probe fails. The usual pattern within the host controller drivers is to use
> err label to do the cleanup not devm_add_action_or_reset() (there are some
> exceptions though).
>
> It just helps us to keep uniformity across the drivers.

Thanks, but err label is quite easy to make mistake. More and more function
support devm_*. I think if well design common API at pci-host-common.c,
goto can be avoid.

Frank

>
> - Mani
>
> --
> மணிவண்ணன் சதாசிவம்
