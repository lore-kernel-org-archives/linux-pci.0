Received: from TYDPR03CU002.outbound.protection.outlook.com (mail-japaneastazolkn19013072.outbound.protection.outlook.com [52.103.43.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAABF220F2A;
	Mon, 16 Feb 2026 02:27:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.43.72
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771208835; cv=fail; b=oAIcZYos4RC4cgL/dqXD1N/X1FbAjSGfd5Hz/3rKI1kljCwiAJK29w/4+HEtA0Mw6Dp+aVe5xAUzSoxrG/5V863GtthnkApp5zmiA7lVcmX114vLRpbvDQ9HSy/HVIvbW1uUMOhb6RMxa5aLJ4z8RW8W8dm/g0/H5h/LqGQipAk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771208835; c=relaxed/simple;
	bh=yPts/luM2WzNUDA6ZrbxhdoU0/JQRXYohOU57HLTAno=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=FdBzc8PyNxXMaydKAhp1AKWRgYLA9kC3ef0fN5ZER+oCSvfV3RtbiNt2Z9Pno9VYBBpNzAHK5NV9N5fhCB8Xr0sF/+qp23CVXPd8vr6Z6kVsvPIs2XctOAuvHoTg8bnqsT9S2gsHBH7nhVFC7TGgmF0CsrDpLeO2AMvq8X7BHIs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com; spf=pass smtp.mailfrom=hotmail.com; dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b=Ra62TnKQ; arc=fail smtp.client-ip=52.103.43.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b="Ra62TnKQ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yUT81pxvdDVlzLHyPtPPghYzHCDoFNb35u6LhXDKIPiBDiLmYEiUD8/2c3KsRhL+0nVUzbNX8p/N89u4b5nDMruZlEx2H/sNZYsONTvdpLmU7c0lzueyDIZntaTtqN9KjDucbM0QzMAQD94DrJyqcuhvt4MQwiONIP1l4dS3bgbVbzc7M0rLSTflhEBUYTLkteniluHvHehdE3hUEopBRj6egVWlOXzCoEWMBk/R9elrn8pXE+jj4Oh/r657LwZGgxIQhaA5JuRmtVKMMyI1fzkRxo1Zmr87Jun5yA5y4sUMJ/tlwOpEOdT845v8HbZeTQbLwdNM+PlH9ZgAL4xRJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tU0XDCbm3J3WRI12Q3c+K+nPG8UkfNef84ugDfDnn9k=;
 b=ER8eFNmOr6RyVs3k0ZyQ75CWOx7QmUtkpf49VMhqv7l6YjJ+B/1Zt/Ib7c3EbK3Fjyf76+VDilTffSS1N4zUyxKT87YfaH+DmQsSwuayQnV6yM3KddZLiEVMCYENURYhuPn+PlKwNevGJPNj7APZwwZdNO3TyE4QiYqjD3QylmKDS3AaGfLsBtmETZj18f9RIaH5xfOd2nSMemQN2yiDnqsja8wErvnaJ9aE+6kLolD7fvPYOtTKodB271BgtajU1RiTxs+DGP1I93Ig/2l483TbdRaSzUqt5opiMbklUXFF7WV9ZqbsY0aTjDnzNTG4/Wlb5B6HC8UK+XkGhhH+ag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tU0XDCbm3J3WRI12Q3c+K+nPG8UkfNef84ugDfDnn9k=;
 b=Ra62TnKQd1ksFl2kBb8NcgaLtLoaZU0dK3YRZjI7ElruOLcY2WhvfJPYNvpaCfpzOJE9joiKkvUfvL+zk7j2BWrtoQFQawR9b79AoAVa946zJt93yTE/ws8wlFUU7h2zS2SPEB6N8xS7UEv1FEYmrmFJRk5FV4mFpvCx6mnnTFSenSPbTqifOnTqVYToVe1E0lIv2k6KOo9aWYfkf4B8zAsZJQL90NZB160ag5curhItX2WNfup5R3MhUdRZGpcc5h/521PJmyc2porT9CfmErEagUIq3WzD0orY6yQjoKOzvE7Wf1otXGKP7jf7viPGge0KdiayoRNVJPN8/Ndd6Q==
Received: from SI2PR01MB4393.apcprd01.prod.exchangelabs.com
 (2603:1096:4:1b0::7) by SEYPR01MB5340.apcprd01.prod.exchangelabs.com
 (2603:1096:101:d2::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.16; Mon, 16 Feb
 2026 02:27:10 +0000
Received: from SI2PR01MB4393.apcprd01.prod.exchangelabs.com
 ([fe80::c735:fab8:6e3d:6d1c]) by SI2PR01MB4393.apcprd01.prod.exchangelabs.com
 ([fe80::c735:fab8:6e3d:6d1c%4]) with mapi id 15.20.9611.012; Mon, 16 Feb 2026
 02:27:10 +0000
From: Wei Wang <wei.w.wang@hotmail.com>
To: bhelgaas@google.com,
	jgg@nvidia.com,
	jonathan.cameron@huawei.com,
	akpm@linux-foundation.org,
	bp@alien8.de,
	rdunlap@infradead.org,
	alex@shazbot.org,
	kevin.tian@intel.com
Cc: linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	wei.w.wang@hotmail.com
Subject: [PATCH v5 0/6] PCI: Add support for ACS Enhanced Capability
Date: Mon, 16 Feb 2026 10:26:36 +0800
Message-ID:
 <SI2PR01MB439326AF08A79D1C5661C29BDC6CA@SI2PR01MB4393.apcprd01.prod.exchangelabs.com>
X-Mailer: git-send-email 2.51.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: TY4P301CA0029.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:2be::12) To SI2PR01MB4393.apcprd01.prod.exchangelabs.com
 (2603:1096:4:1b0::7)
X-Microsoft-Original-Message-ID:
 <20260216022642.112923-1-wei.w.wang@hotmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SI2PR01MB4393:EE_|SEYPR01MB5340:EE_
X-MS-Office365-Filtering-Correlation-Id: 2c3ae4dc-c748-4d40-a9e1-08de6d02e2cf
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|51005399006|5062599005|6090799003|5072599009|461199028|41001999006|8060799015|19110799012|37102599003|15080799012|23021999003|12121999013|10035399007|4302099013|3412199025|440099028|1602099012|40105399003|1710799026;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Qnh0aGJUQTBIMmM0ZDFMdTNrdVg3SGVRdlhITmlJWnNVdHRoUkZJV1dIZlQv?=
 =?utf-8?B?dUlqa0NOUlg1UWliZFhUZ0lveGIrbWw1bWNBOGNPbHZlWnVLYlhITkJSemNq?=
 =?utf-8?B?M1A3eEdjRm5DZTZISEorbEgrQ3gveGxvYmZVSnQrc2Vvd3ZQYk1iNkZUUE1t?=
 =?utf-8?B?TmQ2aGV0S0pHZ3g2aHlESGZxaUQ5MTJvaDVseEtUU1h4d1FCeVY0NCtuUkEv?=
 =?utf-8?B?MkFPOVZMZnVBREo0TjhGTFBMZnZnRk9NMmptTGRlWWtPc3JLNitON1dhckNJ?=
 =?utf-8?B?czNjWDNCbkJUSFBxVzhOakJaRUUzSnRuQVMyNHQwSjVZV2w5dFNnUllEa0NI?=
 =?utf-8?B?d3BkTWF6R2VLR0VHZlpUektsZzZaR1E1aHVFWmx2S0VHV24wOHZQa0ZwY1c2?=
 =?utf-8?B?dHdOT3lMMTV1TmpPcGdqNllZcE9ZeG9ONVVlWDZsdjFpL2doZU9kNm9INE9r?=
 =?utf-8?B?Zy9scEk2dUFBUHRDNjJ3M1RSQk50T2xVVGdxU0UwbHgraUIwdHlBTmNYcFg1?=
 =?utf-8?B?dk9IWEs5UlNuK1pqU2RjNWI2TXZsOFM5ZnR2SFJZNjNjaDBoYW40T0JKQlYy?=
 =?utf-8?B?Y01lR1JKcFFHVUFMOW5lT1lQZUMxSmc1dEExMWVUbm9seURlOTA5b3B5Tk9H?=
 =?utf-8?B?VTVHNzBsMkpJM2lFUUUyZlVxTXFjWTA2eDVWNDhiK21MblYzbGhuaHo1dXZ6?=
 =?utf-8?B?NXFmRnpaOGF6Q2hMaTVpcGNKekIrbG13OU14QXZMRFlQcFVDc2FaQlh6bGR5?=
 =?utf-8?B?bVljek5yaXpHQWFwQUgrTVliOEZrQzUyVVQxbTlRTk5USlVTcjRvMWJFbjVM?=
 =?utf-8?B?MUFqdFY1SEtJcUhNM3d4L0JkTFh0VWt6RGIwVTVLMzhjV1U2TjhZTDVkR2VE?=
 =?utf-8?B?Y3BpRG1FeFVMRys3YUF6R1lLMjZoamc2ZnBaWEN5NzIxUFpwSGs3WitLMnR5?=
 =?utf-8?B?YnNvUDQ3NGZXaDhvci9EYzNZQThwQjRUU3EzR0lTbUR6VHZjcG54bTVlRFVT?=
 =?utf-8?B?K2pCWk5qbTZNakF4QkVCa2JQdGloTDFVMGozdlloUGVxdVZTTC9INUJ1dXVh?=
 =?utf-8?B?TWhlSzYySXNndUF3TkE1clQzWlNxaFh2eDl1VDZiSmJDek5SWm5SbUpnY0Qv?=
 =?utf-8?B?RE9qTmg3ODAzTlFWRTk1dDhvR3ByRWk1UGRqQjlqNEYzSGp6dVJtci84N0dZ?=
 =?utf-8?B?NWdPYUs4VkdHdHZvYjBwK01KbXpsc3BxbzJEU3RDbml6TmRSTnEwL3BpYXRD?=
 =?utf-8?B?RWJMRG1nbmRHOUZpT01HL3I2TlB3dm9rMkJBTHZSRlhmV2UrdWpYeTdCMTd6?=
 =?utf-8?B?VUVuby9EcmZQVGI5ZE5QUkFPU25LbWI5RnBmaGRRcFpScUpXRjYrN29FaFZX?=
 =?utf-8?B?YWhWb2FQNmVuY0VTWmROMVVvQVBJdGFuaW5Kcll2TXJ3T2h3WUZWUXVleGhj?=
 =?utf-8?B?STNSSkxXSDJFVWRoaU51OE1URkVVaE9ncTBXRlNBQVllYWU3UEh1aE14VmxQ?=
 =?utf-8?B?WDJKcWRTNU9iSnArekNVM3lZS0lHbWc5bHpsYnMyUnhXYkNmSmd5ZDZtdzZZ?=
 =?utf-8?B?YVdQM08zd0wvSmtBOGtmN2hsbEMzTTRITFNlVmk4SGp6NStpc0hXNFl1TERp?=
 =?utf-8?B?NG9lQ3pHUmNuOThQNWt4dE1xUkJGZEF2cEErWWdyRHVDTDc5NzdtN0duNFRO?=
 =?utf-8?B?UHNkQStuQllGUFlTQllSNGhXUUU1QTdlRVJTdTVHRzU1ZzFnOUlJaTNKVVlY?=
 =?utf-8?B?N2gyTkFqSHJ1K1pnbzgwMEFlQmp0T1JrQ09VQjlob250ajlhSmhHcGJYL1o3?=
 =?utf-8?B?elVwY1k2Z2tqeWluc2R6MHZpMmVIR0ZSRmNiR3ZQK0JpU1Fnbi9rZmdMK01Q?=
 =?utf-8?B?aWtva2Q1MW82UmVnL2VZVHprbmh6eEs0TENGSEZXUnBNdE1QdUM4OXhwbXdn?=
 =?utf-8?B?WmUwQnd6d281cWdKQStqMHlsNXN4d1JBTDA4VTUwZmxnT3pUVzNBL2hCVkN0?=
 =?utf-8?Q?pKyUrXY/BLrvcP3z4yu/CRRtEGqqCA=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?emJKV0VFNUdMVXM1TVJPdnVFeFBqK21mNjFDTnRMTExZNHNjVDdGSkJuTFJz?=
 =?utf-8?B?UENRMjhHcEllOXk2aElIR2R2YUN4cnM0ZjBsUWgxM0szMWIwYXB4SVpucEI4?=
 =?utf-8?B?WDBndDljV28ydHI1Ui9wS2V2aEZlUTFJbHR1bjM0V3hkT3VGMVlwNEVET2Iy?=
 =?utf-8?B?T0cwaDlsNnBkc0toNGsxcjB3ZEplYzd0MWExVUg3UUJtNm9IYWRXL1MvS1Bn?=
 =?utf-8?B?RW9DMWtUMXpEbHdmalVPRWNSeHVRV2c5b01RaGp6UUxKb25tMlRLTkNtY3E0?=
 =?utf-8?B?WjN6U3MrdndyRE5rdXhVTXBpVEsyVlRia0RrdnBsNzZyYnErNUE4ak1pUWxK?=
 =?utf-8?B?MUN3NDk5aEVvSzczY3NsYitzZlBXaHVYcS9MU2Y4Qjh0dzlydDJLbmhoMTl3?=
 =?utf-8?B?aVJEQlNnOWZTbEpMeEpqUlpmM0EwajQ3WjNBb1pGSDhSOGxLbHZHckI5b1pX?=
 =?utf-8?B?VEIxN2pSaXRTKzloTFZRVlczR0VQa0NjNWZBTkpuaDJ2dzJ5ZmxwZnZlOHdG?=
 =?utf-8?B?cERiR3lWTGNEaTQreThOdWk1Q0xhTVI3VSt4Y3ZXTm9FcXFYNGEzeVFocWZz?=
 =?utf-8?B?aDhpQkFRMERzSWc4MFNXQXNwaUk1b3p0SktPaFQrMWVLcnNabkZncy9XdEhx?=
 =?utf-8?B?T2xMdDArNGNWU2NONkMzaGhXQWZlWU93Vitra2kxYmxZc0xnYXNZRHE2UjRt?=
 =?utf-8?B?cnM0Vk1nOE0xblJTVk1iWG5CV2RwQTl5ZXpTZGVHaDBlcHhCcHdRN2R5Q0Zq?=
 =?utf-8?B?R3lpL0RnVE5UVFRGY0xjQmhHanJVTXZKd2xDOUpkMm9LUVkvbkUxQkJRRGJU?=
 =?utf-8?B?VFpqdkpzdk42YlpKNG4rMjhYM3AyUk1Xd3FKYk02R0tYVFAxQjdnb0tBVTJZ?=
 =?utf-8?B?cUZXaStqRm1uS0kreG5rYXVOdHRZd1A1L1VwS21nalNUbEhDRzNMdjhpOW9Q?=
 =?utf-8?B?Zm1Kc3BCOWlTeFM3cjRiQUZoRU96TVAzcmFUMzkvcm1Lb2tyQktvR0xYZ0lE?=
 =?utf-8?B?TExpL1doSFRSdXlSRUF1U0pYVkRYYUtYQjVDR0lqcmFTSDhNek91bTJjWFdu?=
 =?utf-8?B?L29qcml0WWxIM2MrNVB3dWM4TVEvVWRxVHhKNWs5MUhmVmVLWXRSMVhhb3Qz?=
 =?utf-8?B?YnhoOHQxeExSWG9aVXJGZ0h3U0V3ZEViNVUzckNzZ1AxZFFpOE50bFBiRWFZ?=
 =?utf-8?B?ekE3emtnMFAvNlJ2Z3c3bjZrR3p4VFNHeTJIcFoxV1NRYXI0ZDdtQi9XSXNm?=
 =?utf-8?B?Wi9POTEyZFZIbHdBZ1JMVExUbUl5TDZmOVhvOTJTcGl4U3FKWlhwY3Z6eDdz?=
 =?utf-8?B?RERYcUF2SWttWXdHK2ZOSE1USEhPWlJ0clNnUVZ5ek5wQk1NZ3REcmo0dEkx?=
 =?utf-8?B?UFBBSjVjMXBlUmxoR2tveGc5WFY5dFo1SUZ5Ujg2VEc2QjhZUTh3Q3JBRzFG?=
 =?utf-8?B?bWE4OTYvZUNhZEFFNytreTgxd1gvR3c3Ym1DaVVtNzcrWjVpWGpnL3phWWxS?=
 =?utf-8?B?eUNJbmNnc2tYcU56UnVEQjFoam1tVEV0OTE3SGc2SVRMeGtEWW1TUHpFVG9Q?=
 =?utf-8?B?WDE4K0hVUW4zcHFTRU1ERVRDbnYvSGt3aDk2eFJJTTg4R0xUMkRtNkorS2ZH?=
 =?utf-8?B?WXdlaDR6Q1B4bWpSSFJ2TXNLSzgwUTBnUzJVTCtrbzNyYjlzd3Brd0U5S3kx?=
 =?utf-8?B?TGVvNHdweUM2ekVPMGt4c1Q4ck1jWm10MmZIY1FyQUs4YURWakRKMEtvMmg0?=
 =?utf-8?B?ZzVPWFhudXVyOXBpQ09vc3lWUDlSbktXSW9kRDVGM3pockVEK0FkRmRySHBu?=
 =?utf-8?B?c0ZWdkhwTFlqbVpBVGpJL0w4dUJSWmRod2FkKzVlWWV6d0J4NytmSU9uZU53?=
 =?utf-8?Q?vyQIqr2YAAoiY?=
X-OriginatorOrg: sct-15-20-9412-4-msonline-outlook-5f51e.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c3ae4dc-c748-4d40-a9e1-08de6d02e2cf
X-MS-Exchange-CrossTenant-AuthSource: SI2PR01MB4393.apcprd01.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Feb 2026 02:27:10.4443
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR01MB5340

This patchset improves the core ACS implementation and adds support for
the Access Control Services (ACS) Enhanced Capability, introduced with
PCIe Gen 5.

Improvements to the core ACS implementation include:
- Validating ACS enable flags against device-specific capabilities rather
  than generic kernel masks. This ensures only supported features are
  enabled while safely ignoring attempts to disable unsupported bits.

- Consolidating delimiter parsing into pci_dev_str_match() and returning
  -ENODEV when no further entries can be parsed. This removes duplicated
  logic in callers.

- Refactoring ACS parameter handling by splitting the intertwined
  disable_acs_redir and config_acs param logic into dedicated functions.
  This improves maintainability and robustness while optimizing parsing
  with better validation and readability.

- Updating the config_acs kernel parameter documentation to include an
  example of multi-device configuration with distinct settings and
  advising users to quote the parameter to avoid bootloader parsing
  issues with the semicolon separator.

Support for the ACS Enhanced Capability is built on top of this improved
implementation. This capability provides additional access control
features that improve device isolation — particularly important in
virtualization scenarios where devices are passed through to different
virtual machines (VMs). Strong isolation is critical to ensure security
between devices assigned to different VMs and the host.

In Linux, device grouping assumes that devices in separate IOMMU groups
are properly isolated. To uphold this assumption, the enhanced ACS
controls are enabled by default on hardware that supports the PCI_ACS_ECAP
capability. As with other basic ACS access controls, these new controls
can be configured via the config_acs= boot parameter.

Support for checking the enhanced ACS controls on Root and Downstream
Ports has been added to pci_acs_enabled(). On devices that support
PCI_ACS_ECAP, these controls must be properly enabled. To maintain
compatibility with legacy devices that lack PCI_ACS_ECAP support,
pci_acs_enabled() simply skips the check.

v4->v5 changes:
- Added significant refactoring of the core ACS implementation (Patches
  1-4) to improve validation, safety, and readability;
- For USP and DSP Memory Target Access Control, added masks and enum
  values for the encodings and explicitly rejected the reserved encoding
  (0b11);
- In pci_acs_ecap_enabled(), removed the use of 'is_dsp' variable.
  v4 Link: https://lore.kernel.org/all/SI2PR01MB43932C799AE9111C7D2C319FDC65A@SI2PR01MB4393.apcprd01.prod.exchangelabs.com/

v3->v4 changes:
- In pci_acs_ecap_enabled(): Check the pcie type for
  PCI_EXP_TYPE_DOWNSTREAM explicitly.
  v3 Link: https://lore.kernel.org/all/SI2PR01MB439325B4E44D5A39F34A4015DC9AA@SI2PR01MB4393.apcprd01.prod.exchangelabs.com/

v2->v3 changes:
- Drop the warning when a device has no support for the enhanced
  capability.
  v2 Link: https://lore.kernel.org/all/SI2PR01MB4393B836EA4FEDD1823483BADC94A@SI2PR01MB4393.apcprd01.prod.exchangelabs.com/

v1->v2 changes:
- Enabled all enhanced ACS controls by default, rather than just Unclaimed
  Request Redirect (which addressed the primary issue we encountered).
- Added checks for enhanced ACS controls on Root and Downstream Ports in
  pci_acs_enabled() to ensure proper enablement when grouping devices or
  enabling features such as IOMMU PASID.
  v1 Link: https://lore.kernel.org/all/SI2PR01MB43931A911357962A5E986FFEDC8CA@SI2PR01MB4393.apcprd01.prod.exchangelabs.com/

Thanks to Jason Gunthorpe and Jonathan Cameron for reviewing the patchset.

Wei Wang (6):
  PCI: Validate ACS enable flags against device-specific ACS
    capabilities
  Documentation/kernel-parameters: Add multi-device config_acs example
  PCI: Consolidate delimiter handling into pci_dev_str_match()
  PCI: Refactor disable_acs_redir and config_acs param handling
  PCI: Enable the enhanced ACS controls introduced by PCI_ACS_ECAP
  PCI: Add the enhanced ACS controls check to pci_acs_flags_enabled()

 .../admin-guide/kernel-parameters.txt         |  32 ++-
 drivers/pci/pci.c                             | 271 ++++++++++++------
 include/uapi/linux/pci_regs.h                 |  13 +
 3 files changed, 221 insertions(+), 95 deletions(-)


base-commit: 635c467cc14ebdffab3f77610217c1dacaf88e8c
-- 
2.51.0

