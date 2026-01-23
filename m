Received: from TYDPR03CU002.outbound.protection.outlook.com (mail-japaneastazolkn19013073.outbound.protection.outlook.com [52.103.43.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7662A292936;
	Fri, 23 Jan 2026 01:50:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.43.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769133045; cv=fail; b=CfX6tTXcEnlfQepnAFQte3nsXRcDGC8vkMWKoy+qcX/1kxdx4YEFS8ToodVzt8GX2MLZerWuAW3mZGa8aoo9Z5TWHJ8NeM/ACyReWHgJWHdkJfTBdPjLktapkFGw4SsBttpCuFx+zyjIINLiWDOjdDuGGgRNcKdmHJRy/Ywz+cA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769133045; c=relaxed/simple;
	bh=4K9Z1HeMCLSBOJ/GkO0cwZzM0Kf6XsKJksiQIrdzfYo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Yi5MFXajQjaYD7W2jXeXBQMrJzjsbZX2+M/Bzk5nqhrMcuOnFTekFWCGD1vkHVpUB0YY6UXJTTuSpazS3TrTU1ZcewuAgAKNmXhjzuuxzooD+/8P4C6KRJsDCRY4LGfWX/+7bAYI0OQ+YZwSLQl/fTk4ZaJrIYb+nbNbZZJ+M0E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com; spf=pass smtp.mailfrom=hotmail.com; dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b=aMzSclIF; arc=fail smtp.client-ip=52.103.43.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b="aMzSclIF"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=e7QOeeifKWXyX3H+Zd/bEcO92aRQ7yuxQrCwgldnrhp24Pb5mcEmT9H41MsYMGTrMg3FRbeWDAeYINw1dgN4qxQMFKMUVmHzt34QzqIESyfFC6ogjX3Y8ey8Q+b1BYyxbMokwboF8M73RVQWO2n8V+q+H5YafjbyNTCI5qcZDgoIIXcF0odUa/UvfNKF7kTkGy0nUHUlA/kfhoqsKGfLyPCMakbjdVo67GVxfwacfvU+Av9HOLicreI31dOnUU9I08TrsVbTcUOQ8bfCEqd2g7n3HTxUNqXyKHQkIpsbbe61T0fLLnl/oh3Ok5MJVnnmugTvZHxp3QS/HyNob78OiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p/FV+OWrEpWimE03GCdNoKz1/b6VYrumkAt9/5GXGyQ=;
 b=c8vwQCeRIz1lmFYTgVgOE4EecK4GRNW69mIryeMUyL2ehKt3FZj9Yu0IbX9tkEPHb9QVlDQ8gG7AzOr5ff3dWFdhpofULYZTE7Ex7H9wz6oWtJb37JnNvlRX1/6DhHr9+3fbgAGsyczq3pLe8XEHliNd5A1c70jZYIlQi15RuW5GkBKB9ShMXrESMHiI8RsKNp3nRTH3oGEGgS7RmsYHaAVsseDI45KmM4469w1Y0tU9ZkNe6a1jbYyrVNeeQmkCjnZ/rILgs9GBUYIqkkcW2MsL47NVhCgAlRbtw6f9Bkx09JXKZ6UPhuq3OXt+6LrR3inoMoswx5UJ7348F5j3TQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p/FV+OWrEpWimE03GCdNoKz1/b6VYrumkAt9/5GXGyQ=;
 b=aMzSclIFgoek+rh8qNh5tEjsKwZXJtbqfBU/OW6sSqXyipBtLF0YK9Fh66oFtOKqrR7KFKULM7olMNPafmSYVm2nYKXPKJ3XiTh19Z+8HiBB9qh2ONuAOsulaBjC/z2z4ETbN8vuDzJQEtrLBP02mKVpNgMNGaEejF12f3sZUymTGsG7lWvNeJ/auYYZPXl6j1a5W0vFeqnCLoPcya+C1lvtx7YGa3Rh29WiaAAV/GTXdJj6l58zcKwAOJzzaurknVroRD57m5TZEZKAxLY8xfAf/5xuSPYpvqi/rNZpBRz5sfdCvMDnFgCEk8QT5ihg5R3pKLIZM1QLU5tfkLosYw==
Received: from SI2PR01MB4393.apcprd01.prod.exchangelabs.com
 (2603:1096:4:1b0::7) by KL1PR01MB5198.apcprd01.prod.exchangelabs.com
 (2603:1096:820:d3::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.9; Fri, 23 Jan
 2026 01:49:57 +0000
Received: from SI2PR01MB4393.apcprd01.prod.exchangelabs.com
 ([fe80::c735:fab8:6e3d:6d1c]) by SI2PR01MB4393.apcprd01.prod.exchangelabs.com
 ([fe80::c735:fab8:6e3d:6d1c%4]) with mapi id 15.20.9542.010; Fri, 23 Jan 2026
 01:49:57 +0000
From: Wei Wang <wei.w.wang@hotmail.com>
To: bhelgaas@google.com,
	jgg@nvidia.com,
	akpm@linux-foundation.org,
	bp@alien8.de,
	rdunlap@infradead.org,
	alex@shazbot.org,
	kevin.tian@intel.com
Cc: linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	wei.w.wang@hotmail.com
Subject: [PATCH v2 1/2] PCI: Enable the enhanced ACS controls introduced by PCI_ACS_ECAP
Date: Fri, 23 Jan 2026 09:49:42 +0800
Message-ID:
 <SI2PR01MB43939A4D62F08C873D3954D2DC94A@SI2PR01MB4393.apcprd01.prod.exchangelabs.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <SI2PR01MB4393B836EA4FEDD1823483BADC94A@SI2PR01MB4393.apcprd01.prod.exchangelabs.com>
References: <SI2PR01MB4393B836EA4FEDD1823483BADC94A@SI2PR01MB4393.apcprd01.prod.exchangelabs.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR01CA0110.apcprd01.prod.exchangelabs.com
 (2603:1096:4:40::14) To SI2PR01MB4393.apcprd01.prod.exchangelabs.com
 (2603:1096:4:1b0::7)
X-Microsoft-Original-Message-ID:
 <20260123014943.1311157-2-wei.w.wang@hotmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SI2PR01MB4393:EE_|KL1PR01MB5198:EE_
X-MS-Office365-Filtering-Correlation-Id: bd59d3b3-ffda-48b4-2822-08de5a21b64e
X-MS-Exchange-SLBlob-MailProps:
	znQPCv1HvwXZ5XHxNrJCjRnjimRBgM6SR9Vkfig/MaD8tjRJoAeFiZSDvi8hXTPAVkJgQ4yBxp3OSDKZXJQOYoQU7uPnHef/7A0alMl8YUYlxT/xwk55s5YwAnt49uURL/E0PaoBwIuxfBYQYSnlUddEICEF6IlNSPC9Dn+I3Q7at3DkwIw1BTznA2Eyo0p+nSzJpJw5VInVNn7cI2W0RUetafuf4886rTFuYOYkeXmj67nNCZS5CkmVb3UJ6/H80uinqrl4t9cxAZoa0fAVgNIiwea5+3O39RTfZKDzvqbuF4TRH6qnF2hAPzi/QVUWQfaXKqRcxS0D9LmWfHntPxh+Xm0LMKkoMa3yFPnIv3LShJuN8Pt895vrGBnrs8J9ERuVPeqcT39qYSNi6K9waSZFYXpCnW+iN9vYpfjksw+vCnLVMa0BlzjSLhnlQisUaLVYJgg2Iw6jK1f6c/EI426AV6XRSynuc6/BSHNNEbifW1V0QRga1bXJC1xr/1R8FCZa7ZqQ2SVfdEGelHE+GzBgkkmzpVFSbYU/66CkwBqPiFCyHuwgPx/YQ85YyeZePW1ISsxdRDjBllpWcVdIp4etpCViSW7JAjbrDqnAPog9SXSRPtu8DHmC97qA6J7KhcUI65vIb6/f6BsdNt4HzTGWFzfhlkJ3jWdgLNLJpYMy3Dm9okOtAgAJciXigT94Qyj7GUEXA4Nw6xyn3tN0ThPDa2xrHWN3dQ6FhQjfiPq41gJww/BhaXChtsKJzQPdE8uDz/1KmKs=
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|19110799012|37102599003|8060799015|12121999013|51005399006|6090799003|461199028|15080799012|5072599009|23021999003|41001999006|40105399003|440099028|3412199025|1710799026;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ODY2THlmV1ZwRTVOZU4zajNjamFLZHRJVU9hUjJWb0hJZ01pKzdBYXlvWWJT?=
 =?utf-8?B?b0dpZTNpVEN4elNtNlpuYW56LzZxWHBSeVJjQ3dqQk5mcVA5TEl2ek1lT1ls?=
 =?utf-8?B?L1dxenI4Z3lkWnRjVTdtYmlIMVFNaXJ6THFjdHdIdit3aXVwcysrNWw4U2dP?=
 =?utf-8?B?bWNOVEpMRUhYUUpJZXNYaWJJMXpwN2J2TVVESmttMUhRTkNEM3crZEhHS0hz?=
 =?utf-8?B?OCsrN0xQZlVZYVF1WktyUUh5ZzgzWFZKL1g3UjduUk1WYVBMcFFTSTk1UlVT?=
 =?utf-8?B?WU1CRFV1WWlJdC83SmdZMndIK2Y0NGh4bXdRRExyNVVwazdrbEhBNGNMQ1F6?=
 =?utf-8?B?R0x4UUF4MG5OUytLQWRKdld1Qm5Ma29OdENlUnNSa21USUpSQ2ExSStzdHQ0?=
 =?utf-8?B?eVpObmduQ0NBSTFaSVNRaG91UHArdVkveWxkaTJaTkNyS0Z1Qkp6RDdWVEZU?=
 =?utf-8?B?QUdwSVoyZlJ1U3MwSzlpa2ZReTVTMmk3Tk1LWHBwdmhXUGx6Y3d0MUhlaEZi?=
 =?utf-8?B?aFpBQ1VqZU5rM3Q1MXVPQStBTWpwdzVSQlQvUXNUZEpWR29HSldTREwrMkl5?=
 =?utf-8?B?VW5LdElFSnk1MThXNUNrb0FmNW10QU90cE5EVW5vVTRBTjF1NzA3T1FJVU1H?=
 =?utf-8?B?YjMxQXVnNE5nL3MvN0xMR0htVHVSWFZBbnZpZUx3ZlVEc1N0ZlhJTzVPM1V2?=
 =?utf-8?B?OElPNWp2ZlM5YmNoTEdYZjJtNXdocW1HTEFpM0psUmpqYlI4OWEvaHQ2WUR1?=
 =?utf-8?B?cjZndUxHVmJSSkNtY29PSWpJbkJLWCtLYzRBc3Q1SlBicUVVTmtYWE5hMFYv?=
 =?utf-8?B?NmxQMUpmVlY4ZGNJMzZKZHdwZC9Zb0V3OEo4RHdpRWFwZVdHWU9vQURmT3JV?=
 =?utf-8?B?dElySWZqS1hwaGQwanRPdlZmSy9VSjFWL1ZCWnhNbEJCTUsrY3ZFSEFscTNZ?=
 =?utf-8?B?NyttYTFFelRTRmlyZmFCdEdtOStkajdqZXdoTnBGQ05oa1FldWpxUU5MeEls?=
 =?utf-8?B?SlZ2VVFWbWVyN2tYeWpuVmduWVhUaHZZYWNVU2hNYTF4ZDVBU05qYisrUU8y?=
 =?utf-8?B?dVNQNG4yaEVLWXZ3SnZMQ0RQMjhROFZ5NFhTYzAwcHIwYXYwZjBtM1hWV2o2?=
 =?utf-8?B?R0FiRlYzaTkrVHRDNVpjekxWMHhmbVlXY1BsSnlTdFg3QjU0RDJkNEx3Q0FX?=
 =?utf-8?B?dXU1NFRGY2ErYTBpT1RSdkQ2NjRhYklHWkZYUVJrR2lkZS9kK2hrWDliaHpn?=
 =?utf-8?B?UWlzZlE3Tkp1NFVnM1E0M3M1MEk2SUVPRk9FUXloVVJxWDVPR29kVWg4bDJj?=
 =?utf-8?B?WnBOcXZQaFR1YXNnLzJKN1JBcTZ1QmJCTDBIR2Qrb1dVMlBaWVhscStPT3Zy?=
 =?utf-8?B?N25nR04rVmk2RjRUYmtPVUxibVVRbVFiMmNlaGU4SUNESDdEQnRtQndLNm53?=
 =?utf-8?B?SnpsNm5pOWVWZmp0MkhDYnRLejZLMFBJYXM4bDhMTWNjRWlzM2hFS0hIVWJL?=
 =?utf-8?B?YTI1ZUM4QkdoZ2NYK2hENG1wRWkwVWtBU2R6MnI5UWRNdWd1bVFKOElIbnUr?=
 =?utf-8?B?SUtFSVVHOUVXQmZoNjVrN1VOYnNRR2FvV2NxOVRMQkVaOXVMb2c1Q3A5MDRG?=
 =?utf-8?B?c3ZERE1xVll4VllIbGkyY29uYjczMjNMbEFDU282SG5ZTlk4aWZReGo4YVlw?=
 =?utf-8?B?RUhCanJMM2xXZnhtTzRKRnBHeW9YTWFHLzdMRjJJcDJMY1R4SXdhL1BhY0Q1?=
 =?utf-8?B?cC9MQm44eXlnL3lsYnpraTZ2Z29vOWhXb1YyZGFJRWJHdUxyZTFQWmRGRUtO?=
 =?utf-8?B?VFBKb3NzcDFKaXRNWHhPZz09?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Uzd6c2dFUTRBTFVzR1Z6dVRueVlDa2lDOWowRW10NG1QMVUvaVJMNW9Tbkhk?=
 =?utf-8?B?ZzcxMmtsNktwRVFSZ1VaMDRNZkF4cDExM3VBQ05lZWFCU1gzWHNFY1Bnakxs?=
 =?utf-8?B?T0wxYTdqN01jUmpId0FqYllzWjZJRnd5VzdORHJVOTZ4Z3ZsM1JhVnlBaVY2?=
 =?utf-8?B?ZENPb3huaTZhZSt5SkFsOEJaUFBmNmlrNXZoVEtyVDY0QUFkZk8vblVUbUxp?=
 =?utf-8?B?eGhCWHBYbTYyM2Izd2VMYzJ1VlNUcjRIMkJZWW56aG5jNTJLcmM3OFF5T3dK?=
 =?utf-8?B?WTYrNmROUTEwWmVlMWt1ajNIWVJzaHhlSSs0Ry9lWDRpa3k5MEpGWUpzcGYy?=
 =?utf-8?B?S3RqV0tNMU16d3lHSFRhaU90eWRGN0EwRVdEWThlT091UE8vay9YZTgxSkJq?=
 =?utf-8?B?L0czY3Z1Z3V4anAvbXlIQmtYSWhoTU95VWE0VGFia0pSeXNOVlJYdGVCa0VK?=
 =?utf-8?B?aXRWR2tRME55NWd0WWJ4Z1pqT2JScDVPaGdDWld1dTNJQVc5My93ckhmWGNP?=
 =?utf-8?B?NE9xSWI2ZXVBa09Lb3pkaTFpVU1jMldIajF1WmYzcDJxQ0VheUpac3ljTThT?=
 =?utf-8?B?K1VSSHIvYXBXaEdVOXVYRUU3V0lhNCs0d3FWM1lNZUdlTG1NcUZBWm0yR0pM?=
 =?utf-8?B?bytXV3p1RWZIS0tNQW5uMjdKZTRna2YyaGUyc2JQUElzdklTdGJjenBFUCsz?=
 =?utf-8?B?K3l5SEUxK0NjbVFiS1oxYnR5WHg5QVFRNlVVRVRkVndyaXFpbWNCT0x5SEc5?=
 =?utf-8?B?azAvUEdXWlcya2VaK3QzVEVHd2h1V0tDL3R3K0YrdTVLb0R5L2ZIZ0pUWlpw?=
 =?utf-8?B?ZHMxV0EybnA4OUZHQnpBb2lLTGJtSVc5VlRaQjM4ZDVRSlR2R3BLakZCM1pD?=
 =?utf-8?B?TnNKVzFFdlE4S1p1QXJJVm94UVVILzY5S2pjSnB0OC9MWUlpbmVZWHlCbFVQ?=
 =?utf-8?B?YUx3a1BvQ3hoVXQrNDVwWkhKVlQ2VW9FcmVmRVoxdnhTanRGbFJibDlNTlhl?=
 =?utf-8?B?QjVrNnRvb2czQ0lSV1dUaVp5WkpQYklXRFlGaVZGc3BQUkR5SFJHZ1FuU2Rr?=
 =?utf-8?B?ak1GSDRQWml2THZUMU1kWWhTMFNjZFdKZzhNelRVaGU2V2M1OEN3NEFGeFBH?=
 =?utf-8?B?aUF3cnZNWkZMNldtRnNTbElEREwvMks2QTRqc2w0OUNDY3pLdjdaM3VhN0Fp?=
 =?utf-8?B?WktJQTV1a0Rjak82NTc3Z2hXSjBWajF0UTNEczAwN1J2RXg5MW9lNmFPemo5?=
 =?utf-8?B?SWx4ZUptcXU3SzNsNmV1VkcvY0lVLzQ3bWJMdzIrTFUwc1BOdSs5TEQ5UGM2?=
 =?utf-8?B?SVRNVStLaE5tVTAyRnJDbFFqa3FjZnV2TXdvUlk0QUhqdnBpRDUzNlVwK3FP?=
 =?utf-8?B?Z1NZRll1V2xIWlZSQWlXTWtXSkNqVnRmVnk1cWRyeWhFcVlRbVVDczhpaFJm?=
 =?utf-8?B?SW42cGJkWGlOK29vRC9jbDI2ZHJFU1AzVWZTYWJDb3p2aUtuM3F5YlFIbkxP?=
 =?utf-8?B?elcveHREUFhXYXBEL01TR2hMb1MzQ3IzeUl1bVNuOU9MQnNsay9oVE5BRGg2?=
 =?utf-8?B?eEwzcmdPY1dCTlBiSGM0N3NCMlZCU3RnQUZORnQwdmlNV1RmUEp5ZlJnTDJS?=
 =?utf-8?B?bW9aeHZyRENiY2xIQXdsaHFWRVBqckNidnlCT01wRGJpMzlSc1RUaUlxbjN6?=
 =?utf-8?B?NE1mZGl4TDErTGozL2U2L0d0V3QxZnhIaWFVcVBiNjVldHBRUjkzTnl4eDhO?=
 =?utf-8?B?aW04c2s4eHZOWFR1Ny9CU0FWR0E1N3kxVEZvcWxWRzB1M25rNEJzbno5cjd2?=
 =?utf-8?B?WXFERFBkMlhhZXdxT3UvcGlNb0l2TUM4Y1RoMFdiOXpOcmJmbU84aXhSZ2ZX?=
 =?utf-8?Q?ImL/yBeBBayAw?=
X-OriginatorOrg: sct-15-20-9412-4-msonline-outlook-5f51e.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: bd59d3b3-ffda-48b4-2822-08de5a21b64e
X-MS-Exchange-CrossTenant-AuthSource: SI2PR01MB4393.apcprd01.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jan 2026 01:49:57.5648
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR01MB5198

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
the config_acs= boot parameter.

Signed-off-by: Wei Wang <wei.w.wang@hotmail.com>
---
 .../admin-guide/kernel-parameters.txt         | 23 +++++++++++++------
 drivers/pci/pci.c                             | 13 ++++++++++-
 include/uapi/linux/pci_regs.h                 |  7 ++++++
 3 files changed, 35 insertions(+), 8 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 5637bb35cb75..8f99f6d728b9 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -5261,13 +5261,22 @@ Kernel parameters
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
index 382ce8992387..c4cf835ec8ba 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -948,7 +948,10 @@ static void __pci_config_acs(struct pci_dev *dev, struct pci_acs *caps,
 		}
 
 		if (mask & ~(PCI_ACS_SV | PCI_ACS_TB | PCI_ACS_RR | PCI_ACS_CR |
-			    PCI_ACS_UF | PCI_ACS_EC | PCI_ACS_DT)) {
+			    PCI_ACS_UF | PCI_ACS_EC | PCI_ACS_DT | PCI_ACS_IB |
+			    PCI_ACS_DMAC_RB | PCI_ACS_DMAC_RR |
+			    PCI_ACS_UMAC_RB | PCI_ACS_UMAC_RR |
+			    PCI_ACS_URRC)) {
 			pci_err(dev, "Invalid ACS flags specified\n");
 			return;
 		}
@@ -1008,6 +1011,14 @@ static void pci_std_enable_acs(struct pci_dev *dev, struct pci_acs *caps)
 	/* Upstream Forwarding */
 	caps->ctrl |= (caps->cap & PCI_ACS_UF);
 
+	/*
+	 * Downstream and Upstream Port Memory Target Access Redirect,
+	 * Redirect Unclaimed Request Redirect Control
+	 */
+	if (caps->cap & PCI_ACS_ECAP)
+		caps->ctrl |= PCI_ACS_DMAC_RR | PCI_ACS_UMAC_RR |
+			      PCI_ACS_URRC | PCI_ACS_IB;
+
 	/* Enable Translation Blocking for external devices and noats */
 	if (pci_ats_disabled() || dev->external_facing || dev->untrusted)
 		caps->ctrl |= (caps->cap & PCI_ACS_TB);
diff --git a/include/uapi/linux/pci_regs.h b/include/uapi/linux/pci_regs.h
index 3add74ae2594..2b026aa91647 100644
--- a/include/uapi/linux/pci_regs.h
+++ b/include/uapi/linux/pci_regs.h
@@ -1011,6 +1011,7 @@
 
 /* Access Control Service */
 #define PCI_ACS_CAP		0x04	/* ACS Capability Register */
+#define  PCI_ACS_ECAP		0x0080  /* ACS Enhanced Capability */
 #define  PCI_ACS_SV		0x0001	/* Source Validation */
 #define  PCI_ACS_TB		0x0002	/* Translation Blocking */
 #define  PCI_ACS_RR		0x0004	/* P2P Request Redirect */
@@ -1018,6 +1019,12 @@
 #define  PCI_ACS_UF		0x0010	/* Upstream Forwarding */
 #define  PCI_ACS_EC		0x0020	/* P2P Egress Control */
 #define  PCI_ACS_DT		0x0040	/* Direct Translated P2P */
+#define  PCI_ACS_IB		0x0080	/* I/O Request Blocking */
+#define  PCI_ACS_DMAC_RB	0x0100  /* DSP Memory Target Access Blocking */
+#define  PCI_ACS_DMAC_RR	0x0200  /* DSP Memory Target Access Redirect */
+#define  PCI_ACS_UMAC_RB	0x0400  /* USP Memory Target Access Blocking */
+#define  PCI_ACS_UMAC_RR	0x0800  /* USP Memory Target Access Redirect */
+#define  PCI_ACS_URRC		0x1000	/* Unclaimed Request Redirect Ctrl */
 #define PCI_ACS_EGRESS_BITS	0x05	/* ACS Egress Control Vector Size */
 #define PCI_ACS_CTRL		0x06	/* ACS Control Register */
 #define PCI_ACS_EGRESS_CTL_V	0x08	/* ACS Egress Control Vector */
-- 
2.51.0

