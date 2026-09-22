Received: from TYPPR03CU001.outbound.protection.outlook.com (mail-japaneastazolkn19012059.outbound.protection.outlook.com [52.103.43.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A4FF554089;
	Tue, 22 Sep 2026 15:03:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.43.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790089432; cv=fail; b=af9XCrEgWDfdSs5Tibb+g8qRyftdVxnowGr2OUVTFitTaygYtTHoKTQUGqF15uiYPcGfLhE6g4RcOx9BbqBXVm46aDSRsx84eGeSXuHTEtfu8Qr2HRrT0iUcWfLv6NrfDOrNSaD0OfCt9R6LI0aJbFhvLWQWSw09cf3XsRjz9hw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790089432; c=relaxed/simple;
	bh=JEdp5xox5l9gCdm3TYmAPRjFoOB22cfGj4G7fx52f0g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=idionCfOMwFj5BULv4q1NYJUdIhXuoW2ZttiX2iG7DpOFPRNSb+LAzSKL9yuf56nlld6D6Q5gTsGkHqWy7ATKX+7gu8pByOuxTOaelh855R45I8Lit0WO3HrC+bRhS2naqkhk8IYdNvZlJzph1b82FFWnna/PAw7F0nTvgwVpIg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com; spf=pass smtp.mailfrom=hotmail.com; dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b=XDT+QJX/; arc=fail smtp.client-ip=52.103.43.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b="XDT+QJX/"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WU+KkGTKH3akeK78QPrhlQOoXDN+sv/FqxOL3ki7uKeD5NNlmrCLDleb0DDG+GRstziUWy9IkAIDyV72AzpCdsO5WIbW9xPRlmHXjgAzKtCsJjAgbOEnD8v1D0cmzcRFg4MNJdkWtgXCnKPw8w/bHAVtBaiM5R8hrO7N8hGrT78exrz/jKtEDqnNykMtsBpcnPA/3JYnpkP8Djnq9bZCHdJFQwElBUlpLDhwpSLGlFgvwBG8370F789lD5bfng3O2YZPeRfX3VVG6kX8zQiXj5Gd/1WPdG9xwXI1vXbzHfvbzmFVdmmRwbpfk6R/x2uzxOg+s9dmAz347p+LBasU9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8PHpXj7azX5Pgw0VKl8oWu7PLFKGYo0KBnnkRfPGeLM=;
 b=nTiO5rAY/klCHn7wdU0M/CBc4K5m4fLW7V8spr7P1m31YifjSqwo7tELHg0os7eMpCiF2GcOxNQKbPIG5rUpGhlEOOFDwIaI9lA0sSgik954S9hfJ8t3X1KuwkbLMVGyhxM77+znrlyJ45eZJJr3WOLkMvg0Sz0NgNsO94dytw9HdSqM4QjMz7Eajr+UiJLnPKVp+wQSWu64iXQ/sbbZzfbBZ3YWuk0jm4Qef7rZqCld4LDLqpcdXCHVqxwu6Dl9wyHYKi+wrJR2rGMnGtEzUQ8s56KCXA/JNhMEVmrSL34qOE8Sw4KLLTMm0ZalYNPDXNIhPlB6SfJ4Be6F8c9tVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8PHpXj7azX5Pgw0VKl8oWu7PLFKGYo0KBnnkRfPGeLM=;
 b=XDT+QJX/X55uSWOJ/BAGIenX3wDHr0jKGTM2ANzORE3ivcdGlKWlpA44cbh6F8/u07088s2WN1VBy0ogx/COcp5jW+a/6GlMf2WaE4/EdWzs/yBAvGn8Z/4QPELUVqJ7xmzzHPRBZWeFyB80h4cmeCAXC6AXebUxybxIc/lPJ7orWPhMcl6UpKTS/sJJfUbXfR0UEt7wGQ2zuzgdORhsijzHLLDCHVl67dKxDCWDxSGViJ+73O7QxQ/5vlRdX23M4Dg7ko0DOb8znE49TWfISxBAkcySsV2J842D9SqMravxme2uepucupIzgMMi3QesvYlYLV15EG+xg98YzgD7uw==
Received: from SI2PR01MB4393.apcprd01.prod.exchangelabs.com
 (2603:1096:4:1b0::7) by SEZPR01MB5711.apcprd01.prod.exchangelabs.com
 (2603:1096:101:12d::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.16; Tue, 22 Sep
 2026 15:03:42 +0000
Received: from SI2PR01MB4393.apcprd01.prod.exchangelabs.com
 ([fe80::c735:fab8:6e3d:6d1c]) by SI2PR01MB4393.apcprd01.prod.exchangelabs.com
 ([fe80::c735:fab8:6e3d:6d1c%4]) with mapi id 15.21.0451.014; Tue, 22 Sep 2026
 15:03:42 +0000
From: Wei Wang <wei.w.wang@hotmail.com>
To: bhelgaas@google.com,
	jgg@nvidia.com,
	jic23@kernel.org,
	error27@gmail.com,
	kwilczynski@kernel.org,
	rdunlap@infradead.org,
	ilpo.jarvinen@linux.intel.com
Cc: akpm@linux-foundation.org,
	bp@alien8.de,
	alex@shazbot.org,
	kevin.tian@intel.com,
	manivannan.sadhasivam@oss.qualcomm.com,
	ben@cressey.dev,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	wei.w.wang@hotmail.com
Subject: [PATCH v10 5/6] PCI: Enable the enhanced ACS controls introduced by PCI_ACS_ECAP
Date: Tue, 22 Sep 2026 23:02:57 +0800
Message-ID:
 <SI2PR01MB43937D197A3C0286A51A8D69DC832@SI2PR01MB4393.apcprd01.prod.exchangelabs.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <SI2PR01MB43935D2C01946E6D8FD9EFAADC832@SI2PR01MB4393.apcprd01.prod.exchangelabs.com>
References: <SI2PR01MB43935D2C01946E6D8FD9EFAADC832@SI2PR01MB4393.apcprd01.prod.exchangelabs.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: TY4P301CA0017.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:2b1::18) To SI2PR01MB4393.apcprd01.prod.exchangelabs.com
 (2603:1096:4:1b0::7)
X-Microsoft-Original-Message-ID:
 <20260922150258.3087572-6-wei.w.wang@hotmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SI2PR01MB4393:EE_|SEZPR01MB5711:EE_
X-MS-Office365-Filtering-Correlation-Id: ca84fc7b-846b-4513-40cb-08df18bab0a2
X-MS-Exchange-SLBlob-MailProps:
	EgT5Wr3QDKyfJ5ctroE+AnoJKQNH7uyZkvYUzK7fVRSrNR6ZNmzgGcoswfBRwGlCkjCzXuq+UMTnOPBR6Sv1ewyJMGEvg9DwlhPYQFVjiRzaQr1n8KHeoBsBDRfR4C9+tJMI5AkBr7ix97b5o4XbxE7PU7jkWh9eUwWrrEl8vYvrG2+1dHrRP+DPIWC8TNU5XKz/w9M5rFF1HGV4BgMhzcO+NpbmoyqddGL/zd/zQXebARCGH8znahqguOsgvAiffmUCf+1/26ywDfKcMS6FxyC/Us903/Ht1NZVb1FmDXSZix7HDSIkb64Mdw0PenBbvWEz/blnuM5UvUXq7inDY5iMy3ezhvYcFthFFq5Vzw+JwbtI5awOg4SAgnA+SW1YpE0I7b4VGKWu14hLJVxajzW1HcUrkTWQSnX6JCD/PSPqxS4f8OwS7GLJ6WyNpr9BsxLeups851rT/3XFi8crFXk9GnltW61SrtuwVmvOzy+ZSqeK5QIt5FfaaPzPGq9/pd5bCU8W2uIiZBBvPjL1LzRB04nkjUT+93g26MYZUQ9t0M6yCLUsFhZbm+xz66YRibqKe1LFuMiTOk4TWgOlwXGZ9GEVKGuhYcoRj8JmZ4Tvoq5JufXo6NVqkYMmeN4Ekov/4sPepcilI30zpttOZcXsJmeIDo7RD03PW6Z19vlLaHuT6oDgh6gue5TeaZRGtlWabx9qtt0MQhP6VbCH1lQznzEMr+k3C4yWLPxkJGM=
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|45011099003|19110799012|8060799015|6090799003|5072599009|41001999006|51005399006|7042599007|12121999013|37011999003|15080799012|25010399006|23021999003|16051099003|3412199025|440099028|40105399003|2607281247196008|1710799026;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RWoxdEZob0hEanpIME4xWWp4K2xrNjN4RzlMOGRkcXZkRWhTVkVlbkJCczRt?=
 =?utf-8?B?WHZFUHNsWXVncmlKeURSbU5SZ0V3Wkw3UFVIS2NZa0V3U01WLzhHOUVZMGdr?=
 =?utf-8?B?elFIRXVtSWNlWml6SUVzNmVrRTh4cWZiQWF4ZGtmVEFhcVV4VDNpTi9ESmlu?=
 =?utf-8?B?TUc2K3BxWWlMZlU5SFZYL1hMUklRTlRmTmQ2OFJmVlZlYkphUVlsaWMyTXZF?=
 =?utf-8?B?eEZjS2g0eEM5ZjZuclJxd1FMSW42czVLcnBWdlJrNzJ2NHQzNS92elQ2SExl?=
 =?utf-8?B?NEFyR2x6VHJWK2xhQmFqeWx2QUNuNjlDSUZwTElTV2Z5K3NWT0lnWVNyblV4?=
 =?utf-8?B?Wm5VVzNYdzVTR2ZoZ21BcHJSM0dDaGVxT2tjY0dxS1VMaHZiQlF3RXlHaFRr?=
 =?utf-8?B?a1ZlWkd2eHZMa25SOG94d3pQQWJFWjFDT3Q4cWNNNnMyUCszWGd0TVJ1OHVv?=
 =?utf-8?B?Y3cwUTB2VXF1SzhLd0FxdUdLVDRDU3cyUTBvU243bDNES0dIWVhZVzZJNDk1?=
 =?utf-8?B?Vktwb0JBcEVJc0tiS2IxVU9LU3Qzc2pkekwxUnZ1WTNQYk1VeGRVRy8rcjNB?=
 =?utf-8?B?N0NvOUtyNHZyV3lIdDFwKzRvNjlGcGx0OEk1d28zelZIeDVOZ0FWOE9VOExR?=
 =?utf-8?B?MkIrQ0oybnZUdmtiYjZiZy8zVWJrQXFDVzdiczJzZTI3bytnODNWQnlOcVRW?=
 =?utf-8?B?ZXZMR3NreEtiTThWOGNwTURDRE1RWkxQckxNT0NiNkFGTVpxemE0ZlZyRTcv?=
 =?utf-8?B?OE1TVWlDQUFobTJ5eXBPWTdhNXhUbklxSHh1ckhKSVB3eUlHMldPbWNPSms1?=
 =?utf-8?B?REU1YTZ2eG04cGIxR0VPd2RSaVJhdDU4VWE2ZFgrcTVvM1dMQWJCYVdCMUNr?=
 =?utf-8?B?VURPckp4b3pEV2RCSU5QNmxuVUtHWjRwWnV3Q0JrcDVORkM0Z2JyUTlzZm4y?=
 =?utf-8?B?Y1pYanArbkFtRjBTZmd5ZEdpY2pvRzBTc0NHNXlobldTN0pDWnU2QjdDOXky?=
 =?utf-8?B?cm5XTEp0MWJYbHZnWENtTVJUSVh6ci9SUXZvT2VlZ2hycW4vM1AxMUNNR3Zt?=
 =?utf-8?B?eHZIanlMRmxJSko4NXUvTHRwZ2t5bVNMdG4vRzBoK3V4TFkrdWNsZ2M4N2ZE?=
 =?utf-8?B?OUpVNnJNbHpOVEFMaGZvY01WR2NqeGp0TXNpc0dXR0JjRWVySUtuUllYQkQ4?=
 =?utf-8?B?bzFveXZCVVRBaUwyUGorcy9nc3c2bjVQUFFpcERJakhleGZPMTh2eU9kajFL?=
 =?utf-8?B?aHR3bFFNREhFQkZ3LzVJOEsrZnhVKzJRR2FNcU5XVEcrUGpZcHNyS0ovVXJs?=
 =?utf-8?B?OHBNbjBJQmI4Uk9mTHQvdE1GdTJoNXRDOUlKZ2FLb0x3V0R6cnFLdzhOMVRN?=
 =?utf-8?B?cHMwSHh6SHorWTA5UXFQeEJKYzVpOEkzbW5teEw1MzdMMkJtMEtpZzZMbnp6?=
 =?utf-8?B?U0tZN0R5dThwcUIrdHgvR1Y0eGpKUG1PZmRnTHhqOGcvckVPZVVRRE5Gcmxo?=
 =?utf-8?B?MjlsenJBbC9hMEtLVHI2RGhkb3pUMjVZUVU3aWVCaS9rdUxaTG9oaktiYWdO?=
 =?utf-8?B?WWNCUT09?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?L2pYZE9JY0FwTUhQdEZBSkpmK3hmZ1FWQ2Jva2MwM0k2akF4eHJlYkkwV3dW?=
 =?utf-8?B?OW90NXY0eDRRV1V5YUk5S3hKZWUvaHFkaTZUVG5BU3hNVVJlY1o1UHJVQTlK?=
 =?utf-8?B?bjlWT3RwWkJxTlVyeDdHWWl5a0FnaHJkaVpaVEVWSnI0dzBoaXBlK2FMbUVp?=
 =?utf-8?B?N0JhRTNJVnlMMDVIQ0xrUjkzbU9PTTUxUXhlNUtjZ2swVi91NlFCTzBCcCtw?=
 =?utf-8?B?d0JtMnBmUVhUc0pFZlNLaEZSYUJnNGh0WGp2UnlueEhRYW1uV3BlZmtJeVQ1?=
 =?utf-8?B?L0pwMmFIU1JJZ09DR1dEMFhXMWdNaWY4MFVVQk5sdjJPbzNERHpsV1l1bGdJ?=
 =?utf-8?B?OUlUOE9TVmZTL0RpKytPcWozcVFna2tpUmRJb1pXckdGSzFieEhna0FMeE0z?=
 =?utf-8?B?NUZQZ0U2QnY2OHhlYmJuLzJwcWlvS042WUp6OUNpVThSZjIzNU9XMGRvdVRY?=
 =?utf-8?B?d3RZNkxkRkN1Vlh4SkVlY1NYZEh4ZHdPbnVjMWlseUVLdTJuMlVoWThrV0ti?=
 =?utf-8?B?UzlGd0VmOHhhVnVicERvN2FvY2Y0TnU1NmkwenF3YmJnaFVhZ2kwdXA5R1Fo?=
 =?utf-8?B?V0lhUFhMd1kxOFJjSkhHK0JUTmVRRlAremhQSnl6VE44am9NN1pRWEc1SUha?=
 =?utf-8?B?aTNST0I2VDRXdnYwSi8rT2VnYXp5cm13UmZTQ2YzUW9qMlRxOERva0NIbVNq?=
 =?utf-8?B?YkE1dlE0REt6TVN5T1VWVmpZYlQ1WGloVndDVDRRSEY3bWQyZUtObDE2RWNR?=
 =?utf-8?B?Qm9iYktUV0N2aUQyQ3pYd0o3VXRHVCtwOVo1WFRPUDVQOElrN3hreUdNQWFV?=
 =?utf-8?B?NkIzYlhoTkVGdUhWKzUxTHdIUHI5QzR5eGVIbTAvYmFtUXJhSm4xZmhJemV0?=
 =?utf-8?B?aTlJbHRWZFd0eHhXdlp2c0dEaW9QZnUrT29lbU56SnBPUVF0ZHZkZnE4Q1lk?=
 =?utf-8?B?Rlg3N1FDcVJBdjlwcURnUVE0L1hVRzRVMzdNRkNIV3ExNFV0b1dDd0FVYUdp?=
 =?utf-8?B?cCtvUDQydkNITGtHMlZhWFhVSFlLeVMxOExkc3I2dFdQOWdtK2VYUm1xUUFF?=
 =?utf-8?B?eDJscjBVK3Y0ZEZnMnk1NnlCdGw4OE1OVHd4WXVRSHlXMm5FcS9sKzdZQ09B?=
 =?utf-8?B?aTV5MjFyNk5BdXVLcHkzQmRLZUc5NWIvcEJ4OTJYNjdpZEFSRTJDbEp0aXI1?=
 =?utf-8?B?cXpTVFpGcm5ENDN1dVhkV25pR1JObytSVTFTK0VabDc1OXZkOTFyLzhqYmp0?=
 =?utf-8?B?Um4weFZNUGlqVlFxMmt3Nk1zbWNXbDlUdDhScm5TYXZnK21Tem85YnJhRWZ0?=
 =?utf-8?B?aWFXS2lVUTBRL0tJMDM1VFhTbXBjZ0FBQ055OVVPa3U0MS9ZeVZod25lZ25y?=
 =?utf-8?B?WVRaVEVkbWhYL3o5UFk4eHRzUXdJRlFwdlVDOENaTUkwUnNIWnVRcmNaanBu?=
 =?utf-8?B?VzRPYXgvaGIvZXNQL2xVY0lXTVBMQUwvOHJvOUlMOUdWTjZDR0FvU09SdVFR?=
 =?utf-8?B?cmFsTU83Mmh4YlIwS2RNd3NhNzQxbDM0anlEaGlmTHdxeFpmNGpORVBmbmtI?=
 =?utf-8?B?SnU2bGgrUGYremNFVmg4U21aL1ZXdldDNXZkSXVKdy9zL05Ydnh0a1VDY0Q4?=
 =?utf-8?B?bVpFTXBSMHE5Rit3cHR2bm44QVVnY2hFWm01UEQybTlvL0lkUFR5Z1c3Sld3?=
 =?utf-8?B?a2s0YmthdER0YzFDY01DSy94NWtWd05XTXA5S05jYXdkdHA4WmJDL0pSS2t4?=
 =?utf-8?B?eTVXUXMrU1o2cUtxbnhSTkd6eEtMNDlnR09DU0k1MzZLazcvcm90WWVVSktk?=
 =?utf-8?B?NDU1QmpWNWs0TGt4MmVxNmtYMHJxSTNEdDFHdkJtclZnMmtkMEh0dW01MjNF?=
 =?utf-8?Q?tdCwIhWPBXEUv?=
X-OriginatorOrg: sct-15-20-9412-4-msonline-outlook-3e488.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: ca84fc7b-846b-4513-40cb-08df18bab0a2
X-MS-Exchange-CrossTenant-AuthSource: SI2PR01MB4393.apcprd01.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2026 15:03:42.2420
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR01MB5711

The ACS Enhanced Capability introduces several new access controls to
improve device isolation. These new controls are particularly important
for device passthrough in virtualization scenarios.

For example, a DMA transaction from a device may target a guest physical
address that lies within the memory aperture of the switch's upstream
port, but not within any memory aperture or BAR space of a downstream
port. In such cases, the switch would generate an Unsupported Request (UR)
response to the device, which is undesirable. Enabling Unclaimed Request
Redirect Control ensures that these DMA requests are forwarded upstream
instead of being rejected.

The ACS DSP and USP Memory Target Access Control and ACS I/O Request
Blocking features similarly enhance device isolation. Device grouping in
Linux assumes that devices are properly isolated. Therefore, enable these
controls by default if PCI_ACS_ECAP is supported by the hardware. As with
other basic ACS access controls, these new controls can be configured via
the "config_acs=" boot parameter.

Signed-off-by: Wei Wang <wei.w.wang@hotmail.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
---
 .../admin-guide/kernel-parameters.txt         | 23 +++++++----
 drivers/pci/pci.c                             | 39 ++++++++++++++++++-
 include/uapi/linux/pci_regs.h                 | 13 +++++++
 3 files changed, 67 insertions(+), 8 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 8c4d3aa6fc67..6b5d884622d9 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -5331,13 +5331,22 @@ Kernel parameters
 				flags.
 
 				ACS Flags is defined as follows:
-				  bit-0 : ACS Source Validation
-				  bit-1 : ACS Translation Blocking
-				  bit-2 : ACS P2P Request Redirect
-				  bit-3 : ACS P2P Completion Redirect
-				  bit-4 : ACS Upstream Forwarding
-				  bit-5 : ACS P2P Egress Control
-				  bit-6 : ACS Direct Translated P2P
+				  bit-0     : ACS Source Validation
+				  bit-1     : ACS Translation Blocking
+				  bit-2     : ACS P2P Request Redirect
+				  bit-3     : ACS P2P Completion Redirect
+				  bit-4     : ACS Upstream Forwarding
+				  bit-5     : ACS P2P Egress Control
+				  bit-6     : ACS Direct Translated P2P
+				  bit-7     : ACS I/O Request Blocking
+				  bit-9:8   : ACS DSP Memory Target Access Ctrl
+				      00    : Direct Request access enabled
+				      01    : Request blocking enabled
+				      10    : Request redirect enabled
+				      11    : Reserved
+				  bit-11:10 : ACS USP Memory Target Access Ctrl
+				              Same encoding as bit-9:8
+				  bit-12    : ACS Unclaimed Request Redirect Ctrl
 				Each bit can be marked as:
 				  '0' – force disabled
 				  '1' – force enabled
diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index ffb489e4cbef..4942bb6f1e11 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -41,6 +41,9 @@
 	(PCI_ACS_SV | PCI_ACS_TB | PCI_ACS_RR | PCI_ACS_CR | \
 	 PCI_ACS_UF | PCI_ACS_EC | PCI_ACS_DT)
 
+#define PCI_ACS_ECAP_CTRL_MASK \
+	(PCI_ACS_IB | PCI_ACS_DMAC_MASK | PCI_ACS_UMAC_MASK | PCI_ACS_URRC)
+
 DEFINE_MUTEX(pci_slot_mutex);
 
 const char *pci_power_names[] = {
@@ -982,6 +985,10 @@ static void pci_param_config_acs(struct pci_dev *dev, struct pci_acs *caps)
 	u16 shift = 0, enabled_bits = 0, disabled_bits = 0, invalid_bits;
 	u16 valid_ctrl = dev->acs_capabilities & PCI_ACS_BASIC_CTRL_MASK;
 	const char *p, *seg;
+	u16 new_ctrl;
+
+	if (dev->acs_capabilities & PCI_ACS_ECAP)
+		valid_ctrl |= PCI_ACS_ECAP_CTRL_MASK;
 
 	if (!config_acs_param || !valid_ctrl)
 		return;
@@ -1023,10 +1030,23 @@ static void pci_param_config_acs(struct pci_dev *dev, struct pci_acs *caps)
 		disabled_bits &= valid_ctrl;
 	}
 
+	/*
+	 * DMAC/UMAC are 2-bit fields where encoding 0b11 is reserved. The
+	 * final value can land on 0b11 not only when the user enables both
+	 * bits, but also when they enable one bit, e.g. "1x", while fw_ctrl
+	 * already has the other set (e.g. "01").
+	 */
+	new_ctrl = (caps->fw_ctrl | enabled_bits) & ~disabled_bits;
+	if (FIELD_GET(PCI_ACS_DMAC_MASK, new_ctrl) == PCI_ACS_MAC_RSVD ||
+	    FIELD_GET(PCI_ACS_UMAC_MASK, new_ctrl) == PCI_ACS_MAC_RSVD) {
+		pci_err(dev, "ACS DMAC/UMAC would be set to reserved value\n");
+		return;
+	}
+
 	pci_dbg(dev, "ACS enabled: %#06x, disabled: %#06x\n",
 		enabled_bits, disabled_bits);
 
-	caps->ctrl = (caps->fw_ctrl | enabled_bits) & ~disabled_bits;
+	caps->ctrl = new_ctrl;
 }
 
 /**
@@ -1048,6 +1068,23 @@ static void pci_std_enable_acs(struct pci_dev *dev, struct pci_acs *caps)
 	/* Upstream Forwarding */
 	caps->ctrl |= (dev->acs_capabilities & PCI_ACS_UF);
 
+	/*
+	 * The ACS Enhanced Capability mechanisms are only defined for Root
+	 * Ports and Switch Downstream Ports, so PCI_ACS_ECAP is only expected
+	 * on those port types. Enable I/O Request Blocking and DSP Memory
+	 * Target Access Redirect on both; Unclaimed Request Redirect and USP
+	 * Memory Target Access Redirect apply to Switch Downstream Ports only.
+	 */
+	if (dev->acs_capabilities & PCI_ACS_ECAP) {
+		caps->ctrl |= PCI_ACS_IB;
+		FIELD_MODIFY(PCI_ACS_DMAC_MASK, &caps->ctrl, PCI_ACS_MAC_RR);
+		if (pci_pcie_type(dev) == PCI_EXP_TYPE_DOWNSTREAM) {
+			caps->ctrl |= PCI_ACS_URRC;
+			FIELD_MODIFY(PCI_ACS_UMAC_MASK,
+				     &caps->ctrl, PCI_ACS_MAC_RR);
+		}
+	}
+
 	/* Enable Translation Blocking for external devices and noats */
 	if (pci_ats_disabled() || dev->external_facing || dev->untrusted)
 		caps->ctrl |= (dev->acs_capabilities & PCI_ACS_TB);
diff --git a/include/uapi/linux/pci_regs.h b/include/uapi/linux/pci_regs.h
index facaa324bd86..d09a1bf70117 100644
--- a/include/uapi/linux/pci_regs.h
+++ b/include/uapi/linux/pci_regs.h
@@ -1016,6 +1016,7 @@
 
 /* Access Control Service */
 #define PCI_ACS_CAP		0x04	/* ACS Capability Register */
+#define  PCI_ACS_ECAP		0x0080	/* ACS Enhanced Capability (CAP reg) */
 #define  PCI_ACS_SV		0x0001	/* Source Validation */
 #define  PCI_ACS_TB		0x0002	/* Translation Blocking */
 #define  PCI_ACS_RR		0x0004	/* P2P Request Redirect */
@@ -1023,10 +1024,22 @@
 #define  PCI_ACS_UF		0x0010	/* Upstream Forwarding */
 #define  PCI_ACS_EC		0x0020	/* P2P Egress Control */
 #define  PCI_ACS_DT		0x0040	/* Direct Translated P2P */
+#define  PCI_ACS_IB		0x0080	/* I/O Request Blocking (CTRL reg) */
+#define  PCI_ACS_DMAC_MASK	0x0300	/* DSP Memory Target Access Control */
+#define  PCI_ACS_UMAC_MASK	0x0C00	/* USP Memory Target Access Control */
+#define  PCI_ACS_URRC		0x1000	/* Unclaimed Request Redirect Ctrl */
 #define PCI_ACS_EGRESS_BITS	0x05	/* ACS Egress Control Vector Size */
 #define PCI_ACS_CTRL		0x06	/* ACS Control Register */
 #define PCI_ACS_EGRESS_CTL_V	0x08	/* ACS Egress Control Vector */
 
+/* Encodings for DSP and USP Memory Target Access Control */
+enum {
+	PCI_ACS_MAC_DA   = 0x0,		/* Direct request access */
+	PCI_ACS_MAC_RB   = 0x1,		/* Request blocking */
+	PCI_ACS_MAC_RR   = 0x2,		/* Request redirect */
+	PCI_ACS_MAC_RSVD = 0x3,		/* Reserved */
+};
+
 /* SATA capability */
 #define PCI_SATA_REGS		4	/* SATA REGs specifier */
 #define  PCI_SATA_REGS_MASK	0xF	/* location - BAR#/inline */
-- 
2.51.0

