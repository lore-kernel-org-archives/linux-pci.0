Received: from TYPPR03CU001.outbound.protection.outlook.com (mail-japaneastazolkn19012062.outbound.protection.outlook.com [52.103.43.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDA403822A8;
	Mon, 25 May 2026 13:43:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.43.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779716592; cv=fail; b=He4h2+1SYcfmaz3G+WD1pMFyskvcsSQW4bbrHszuh4rrfgKOSlOzo3w6zvRawcBwz1edpZ4qIIAytVuf55k44VnXHKuav+dr8Qupo08UJ9A/jrdwcVzWb72RuNcgbZ6UBqZt8hz0LeEFE+yY3uGQhJK5gXTUNjSb1Gsu6h2pu1s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779716592; c=relaxed/simple;
	bh=Tf2dCGKgjXNnXeBKm8fr52aM6hoTRzmLF4f0pJZPNXU=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=Q7d3xBu53NiZ0XIrxbT16h8uX2qVZI7kKbl50hYbEr1NR9Tv0vAigVME7U/YOr8V+kX7hJQlg2PPbvoP+u6iLjozracANs26s4v4TbDMRUHgVbJ7HpUqoXX0kZZE8Y9uhCLETQ9aMZzRTJAhOE1rtgwyP3QHWqYJ9QB+FHUnWec=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com; spf=pass smtp.mailfrom=hotmail.com; dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b=IZjTyL+W; arc=fail smtp.client-ip=52.103.43.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b="IZjTyL+W"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Sz38IKfl4UyGFq0innGyAJ+t8xvbgd5t2I+zHyBXnBznNtzpNurrF2YYaU4QGfLu8M3UUY2BDZxqObS8E93aU8uoAgupW+Pv2ol2ZLs0pxEEkWtHurN1+6Pcmw6jR+L2narohYo+Q7tLtIMhVJqP/s3T+xRloBQEdv6mFtozANpZCK30ofJaOgGGZ0C827qa6BrVpJ602c6eU7UwepIUgnhx0JLLCx3hNLD3M5VepckhDcS9GIoM8GOD6Axvz0x0Smw0IIWs6nJy6TadJ4V7U+dhFKR4WpBUZA/w8sa5czbWGQylZbwVdmFvUqWYaAuN+0/1QAJc26fSl6HN/Aql5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XOJ3tM0/8UKjYO1Di/1x432Tf1AO0mBjwVuCfDY2l+w=;
 b=hPg0DAuvU44YPGIAxUHfEZADJk3vn3kZxleSv1vX83qoZ8GWWlMj/zHY0C+lDxAvdVr2DtgHiPPNgqsHi8LQXlbZhUs4+SRkbwZWN2r+a2leSdb3kTWVVeSjUuknrghLPS94LxmNu2cERn9dDgT20myA6qAnxGt2/wMOasvYbEfYDqQYn9Dl9ML2tl5BLVm+Yd+j91w7CfuGPpP0LaeL8sncl4XTJdMqtrIemXu+HYfUXTCMnARxPcSXl4JZaMN6UGj2hr8AOQU0SITdtXJ20ImpGXJDQakRwlmcpRrF+RUVIgCHA3oWRr24i+SZrY7w13hl58u7X341KPm5BpT02Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XOJ3tM0/8UKjYO1Di/1x432Tf1AO0mBjwVuCfDY2l+w=;
 b=IZjTyL+WzAR0zws7R3WLC5my9k1fr+ylfXVjMXDUuSn4ZtGY5vxVlC8creuGLHRUX8n4cbUcEmDcZzdr8Pmwn08bOXS/ujyhyVsQ2XtiNOqjbA+7uJiN9/7B9aY3XCIJAk0qWb/NRI7mjIRKnobiWWhgN3fFlDozVF+Cj8Sr0uWEZzFH6FzS+QA8CRGJncKhLXKPZrWE5uABJKkKRVRP/JoeiXqCAVE+/xZAB8CMEpDO2sdN4xmrEzU8aSkkP/Bkw1W02BiTfq/Qtrli4+fZZFK8ZGnFvpBPF+3eVYZQ2LLUEcbvbZBub6FN6LI66orsA5QpT1zPP1WSs7VjPPFcfg==
Received: from SI2PR01MB4393.apcprd01.prod.exchangelabs.com
 (2603:1096:4:1b0::7) by SEYPR01MB5718.apcprd01.prod.exchangelabs.com
 (2603:1096:101:1ae::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.19; Mon, 25 May
 2026 13:43:05 +0000
Received: from SI2PR01MB4393.apcprd01.prod.exchangelabs.com
 ([fe80::c735:fab8:6e3d:6d1c]) by SI2PR01MB4393.apcprd01.prod.exchangelabs.com
 ([fe80::c735:fab8:6e3d:6d1c%3]) with mapi id 15.21.0048.016; Mon, 25 May 2026
 13:43:05 +0000
From: Wei Wang <wei.w.wang@hotmail.com>
To: bhelgaas@google.com,
	jgg@nvidia.com,
	jic23@kernel.org,
	error27@gmail.com,
	kwilczynski@kernel.org,
	rdunlap@infradead.org
Cc: akpm@linux-foundation.org,
	bp@alien8.de,
	alex@shazbot.org,
	kevin.tian@intel.com,
	manivannan.sadhasivam@oss.qualcomm.com,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	wei.w.wang@hotmail.com
Subject: [PATCH v8 0/6] PCI: Add support for ACS Enhanced Capability
Date: Sat, 23 May 2026 22:01:37 +0800
Message-ID:
 <SI2PR01MB43939CF8CB4876038D01CE11DC0A2@SI2PR01MB4393.apcprd01.prod.exchangelabs.com>
X-Mailer: git-send-email 2.51.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: TY6P286CA0002.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:3b8::16) To SI2PR01MB4393.apcprd01.prod.exchangelabs.com
 (2603:1096:4:1b0::7)
X-Microsoft-Original-Message-ID: <cover.1779442182.git.wei.w.wang@hotmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SI2PR01MB4393:EE_|SEYPR01MB5718:EE_
X-MS-Office365-Filtering-Correlation-Id: b777ae5f-0249-46bd-db6b-08deba638bfb
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|7042599007|55001999006|45011099003|37011999003|51005399006|12121999013|41001999006|17081999003|10092599007|5072599009|15080799012|5062599005|8060799015|19110799012|6090799003|23021999003|1602099012|40105399003|3412199025|440099028|4302099013|10035399007|1710799026;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MnNwSTk0Q3RlZXVEeituM3ovY0F0blNLOWwwVkVuVHFQaWtxcm5xbjM0NXN0?=
 =?utf-8?B?dlBuY25xQTRIS2U5SmF4WWRzY0lUM2pjUkZxNzZMZVQ3czQ2UStUVlF0S3g3?=
 =?utf-8?B?RFdnZzh4ekRXS2c1Z2FvUUR1SDVPc0lqR1ZTN0FDNEhOMlFpRzFoOVI5ekVH?=
 =?utf-8?B?QjdWTWxYSnlmbjZ3djVJNWpnVHFHTFljbzlOTlFxN1IzYlZxTzl3OE5xV2dt?=
 =?utf-8?B?ZEVaZVVtY0w1WkJUdmsxemY3YmZ4REEzRUxSYUdCd0pBaXU1NHdscGNUUVZN?=
 =?utf-8?B?VFlSYVdqd0pmRXZnMnpMbjBHRk04VU1ERE80WkJUZnQ1dEdMeGJ3SG41K05I?=
 =?utf-8?B?eWRxMjVQQzVJMEhQUTVyQTRvUTJaV0wyQm5zVXRPeDQyWTUwWitZUFc4UDhV?=
 =?utf-8?B?cE9iYU15Z0k0WDJxUllaaWdwRHJSMmNjVVEwTzVvb1ZQamlQdUJRZ0YvcEpB?=
 =?utf-8?B?SzFiekgraG1TeVMrZ0MwamYwTGdaSkRJOFNvcnB0NlYvUnNTS1FEcGx5bEc5?=
 =?utf-8?B?blIxSEd3WE05bGhLWDQ0a3ZtNElzSlA4bW9TN2RxczU1ZFNzMldicVRSQThO?=
 =?utf-8?B?SkxiQXVVUHo1QjUxNjRmVS9rRFJYb3JTUFVtMFE2V1lxL0l2WEFRYVRVSW5K?=
 =?utf-8?B?R0tyaUFiZ3ROcmtHZENMWmNaKy9LRTdad21qd2tENlV4Vk8yQzBjaTlqb0Nj?=
 =?utf-8?B?KzczZHVPSzVlWnhHS085RmNKSkNhU3pXcU50ZEZCNFZyUCtmdEJkNEdGeEtq?=
 =?utf-8?B?cXNiNzEvcnpEeThDaFdKc0pQb1YyTHRoYTJKSkoxcnFTQytDbnB3YjRhaHFy?=
 =?utf-8?B?UzNpcis2eXp6TFJqY1F5a09DWGdSa0pkNlNCSklIcmR4RXJIOEN2cHI5OUEw?=
 =?utf-8?B?djVjRDUzTTQxNHE1TnRleVcvUjRDOEZWUnY1N1U3OGtkUEd6NDNjekdYTkVP?=
 =?utf-8?B?Q2tvS3QrNFlkd2VvVDN6N3lYU2o0VUpXL1BQQjljTTArV2N2U1hya0w1aGhB?=
 =?utf-8?B?TmhpZzlJdm1MbjZUdUhuK3BZQk05N1ZwUVRlUnhQQVp0U00xeXZlV3FPVUlC?=
 =?utf-8?B?ZnNzMFlxTlllK3Zxd1ZLNUtHcGoweWorNmdybXdpdm12TVFQT3EzckpGUHMv?=
 =?utf-8?B?T1M1bmFSK1FnQndkaEdSck5LeldoNjVua2QxaTRDNHczcDNrQ2hJY0N3b2ox?=
 =?utf-8?B?VVdDbVpvenludGNudk83ck15cjQrdlNXcWcwc0RmTlNtY1hpc1YvclFHZldz?=
 =?utf-8?B?Tzl6T0gydy9heU9ndVhMTVNHOW5ybE1GdDRDWHY0OUhGTGtjVFl3YkxwOEdV?=
 =?utf-8?B?dDRpeGdRQTd3T0t4ZDFVZTN0M3dZTnc2dUsyYkk0UlJNVVZHcEhUb0dYSHV6?=
 =?utf-8?B?QTNNN09VSGxIbWl6c01mcUFKTS9uZEFQOENmQXMza1o2b3VxN1kweVQ1U3dI?=
 =?utf-8?B?WGh5Q1d6OGxoZ00zcGpGM2czejFObHJXV2pGaVBia1BYbTI2a2Q5TTdhZUZq?=
 =?utf-8?B?ZlFZZ0FtamJWZGxlWjBMaEwwQzI2RkV0ZzFSeGZvbjZ4aEJDY0RoRTlXcXpZ?=
 =?utf-8?B?RG1FM0RZanBQUTFKckt0ejJVdGoyM2hkWExkeFRrQ05kV1JqSzRIc2djTDNS?=
 =?utf-8?B?bDVsbjhSZDRtd1R0Sy9CMENSbVBRT3FBaW95bVJ0MTFiOFc0ZGt6Z2RySWVE?=
 =?utf-8?B?SWVUa0FVaDBIODBhVHd3WnlsUVBUSzROWFkrdWFGTVpqaXV2SFVDdXJZVVB5?=
 =?utf-8?Q?SMBu2AB5vJE4fMjWnc=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Wit5eGxPeUtiZjVna1ZyR2dFUHB4UTArUDRHZGxId3k5K1NJYXlwdllDUFVu?=
 =?utf-8?B?RzRteVhrZS9kKzZtMFRxemVTa0EwbVZPRmw4dXJvaUJ5M3ZNZTUxU2l3aUdJ?=
 =?utf-8?B?L1NKSHpOWVpweEgzdlRiUENsbjlIUE9vM1FpS09xcTlsVi9GenJObzNGOVAw?=
 =?utf-8?B?VmtaMDloWkwwQXFvSUZsWjVWNGdZUVJnQ0F2dExwTTFjMTc5dDByQW9ISjFO?=
 =?utf-8?B?MHRFY2NMZ3BUakVkZStVMnIvVXZmSDVNb0s1Y3kyZjhaczFWVGd5MTU3c2Jl?=
 =?utf-8?B?OURHY2xkTUp1ekdIYzJyQ0Zaa0hHTGFySEpXbEQvaGFDbXJMVFNpUVd4OHB1?=
 =?utf-8?B?aFlQZXNzZG53enF1eFhvRWtnNEdIMzZmV3l1TFdnSERHN2pZSzFHakU0VjVZ?=
 =?utf-8?B?VWpHRmdISHhXUzFmZHUwNU9PMVJ5WndIcDFSVUNkZjBaNEtKUHFLSnp1MTlq?=
 =?utf-8?B?WHNOTEpaS0JmNjM1OTV6dTVYV1NVZDl6d2g0LzhqNGNaMEJzaE1SY0ROK1FC?=
 =?utf-8?B?U1A0OFFObi9ENi9lV0UzbGhtYjhqUXk5aGtyV0R5L042SUVaNUJJaFlXZFVN?=
 =?utf-8?B?OWZsWHdsWjdGVU9idDNqdUovZHQ2eTk4WWhMVGMzRE4yRE1NUmxGLzA0aTBk?=
 =?utf-8?B?V25ISWQ2YXQvSGJRSjN1ZElzRTR2U2xGS3kxaVNpZklXOHg3clpUY0M5V0ln?=
 =?utf-8?B?ZnlRRWdmTmQ1YVlGUlpXUGpNZmdSTVNuZ0p4T0ptQURIWkFSejg4OHFDaHU2?=
 =?utf-8?B?eVN3VG1pajVTbWF0bFEvTXphQ2FUZjlDRENBOW1HQStManl5SjJabEZwdFNw?=
 =?utf-8?B?R2ZrbTIxb3RPZ1V4aWdYdDhPeHhHZHIwTDRvL0lNZG5lT29ueXBXSFRiMXdS?=
 =?utf-8?B?bFZxaUtMdHhWVGhYV2k5YjNFeDByVW1GaEpCUDJ5Z1VKMXRFbGlYU2Q3RXM3?=
 =?utf-8?B?OGZLT0ozeStSajN3Qk1CdURtZFVsMVhlVUVaNE0ySmtHQ0lzN3ViRDY1cGli?=
 =?utf-8?B?N1d6SFFpZ2x4L3hKOG9BNnhUMXgrSlBlWXFEQXdvUGlqTlpieWRPMGJFemph?=
 =?utf-8?B?L1dPUGhucEdGVG1hNDJjWUhGajM0WklWRW5DL2plSENuRlEwekI0TGdqR1hI?=
 =?utf-8?B?RzNudlNiOFJsOEdzbzg5eVdqaHBNbmdQSkVBcTY4K1ErUnR1WVhSVVJodC9k?=
 =?utf-8?B?V0lkZW9IdnlJQkJBZFNlRG9iZkRuOGUrMkNoZFRSdWR0OFYrNWlGQnB5Tk0v?=
 =?utf-8?B?ZTYrWXIyazdNcDVUN1lRTmZPK0doZG1XOEhYNHZnRFlQN0VGdnV2OUlzMjhR?=
 =?utf-8?B?WVRnQXF3M0UrWEY5MjdBSWlLVlFGYndCMXlNN1NvNkpLQUt4emJ2RDBVOUJH?=
 =?utf-8?B?K2I5bnhaWGJnN0ZQRmVwYS9VbFQ0ZHZ4cUVHOWoydXRRMTUyRHExZ0tJTFJq?=
 =?utf-8?B?QVhtSnlDS1Rmb3hxM0M4OFVjSHpFdi96VjBITmk4OXpVUGl0R0Y0NTVqUFJa?=
 =?utf-8?B?RFVPdWlhaFBYNW5pWW9Xa3dSS29IM29JUi9oWVI3NjRrcU51MDlHejllcWVV?=
 =?utf-8?B?aFBPZmdPQmZNaTNReStVemVNTk1LM1NXS2MzRUl1eHV3S1RxaTB6SXF4azds?=
 =?utf-8?B?ZWpyQ1IvNmpHUCtvek42RGtEZ3czTStubWd4djYzZyt4OTdCR2dRTVpxcjBs?=
 =?utf-8?B?UHZZL215dUUzeXZwL2pNeFVtWVp0SkNvNGl2TVFpcFRlNVNYMmZ5YVdFYlJ2?=
 =?utf-8?B?dDlIQnhDeE1jTit6M0FNSUJjWUFPeXp2cHhNUS9ZQVBLN1orMC9oMjFWY0xH?=
 =?utf-8?B?VFh4b1ZYalZXRjR3THp2TnpJVVEySGVUTmNZT3VmWkxQUHQzK3YwNHhYTzRC?=
 =?utf-8?Q?EpFA2OwYaBjtx?=
X-OriginatorOrg: sct-15-20-9412-4-msonline-outlook-3e488.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: b777ae5f-0249-46bd-db6b-08deba638bfb
X-MS-Exchange-CrossTenant-AuthSource: SI2PR01MB4393.apcprd01.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 May 2026 13:43:05.6274
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR01MB5718

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

v7->v8 changes:
Patch 1:
  - Validate against dev->acs_capabilities & GENMASK_U16(6, 0) rather than
    the raw dev->acs_capabilities, as the latter may contain fields (like
    the egress control vector size) that do not correspond to bits in the
    ACS control register. (Sashiko-bot)
  - Gate the new capability check on !acs_mask so it only fires for the
    config_acs parameter path. This avoids breaking legacy
    disable_acs_redir behavior. (Sashiko-bot)
  - Validate both enable and disable bits (the full mask), not just flags.
    Reverts the v7 narrowing to enable-only.
Patch 2:
  - Remove the leading '-' characters in the documentation examples to
    prevent copy-paste confusion for users. (Randy)
  - Recommend using double quotes instead of single quotes for multiple
    devices to avoid potential shell-escaping issues where single quotes
    might be treated as literal characters. (Sashiko-bot)
Patch 3:
  - Move the error reporting back to the callers so that caller context
    is included in the dmesg output. (Krzysztof)
  - In pci_dev_str_match(): enforce stricter boundary checks on successful
    matches (see Patch 3 commit log for full details).
Patch 4:
  - Move the pci_info logging for ACS modifications up to pci_enable_acs()
    so it prints for both disable_acs_redir and config_acs modifications.
    Introduction of kernel_default_ctrl so the print only fires when a
    cmdline param diverges from pci_std_enable_acs()'s output (not on
    every pci_std_enable_acs() modification). (Sashiko-bot)
  - Drop max_shift; bound the parse loop by the u16 width (16) and rely on
    the existing invalid_bits & ~valid_ctrl check to report out-of-range
    bits with their bitmask, which is more informative than reporting the
    parse position.
  - Drop the -ENODEV "no more entries" signal. *endptr is now advanced
    past the delimiter so callers terminate the loop naturally via
    while (*p).
Patch 5:
  - In pci_param_config_acs(): when ECAP is supported by the device add
    the ECAP control bits (GENMASK_U16(12, 7)) to valid_ctrl.
  - Validate DMAC/UMAC reserved encoding against the prospective ctrl
    value rather than enabled_bits alone, so the case where the user
    enables one bit while fw_ctrl already has the other set is also
    caught.
Patch 6:
  - In pci_acs_ecap_enabled(): Add a defensive NULL check for the upstream
    port before dereferencing it. While standard downstream ports should
    always have an upstream port, this guards against kernel panics in
    malformed topologies. (Sashiko-bot)
  - Remove the redundant pdev->acs_capabilities & PCI_ACS_ECAP condition
    in pci_acs_flags_enabled(). The preceding bitwise operation
    (acs_flags &= (pdev->acs_capabilities | PCI_ACS_EC))
    already guarantees that acs_flags will only contain the PCI_ACS_ECAP
    bit if the device actually supports it.
  v7 Link: https://lore.kernel.org/all/SI2PR01MB439385689A32A1DDA9CEABE1DC3F2@SI2PR01MB4393.apcprd01.prod.exchangelabs.com/

v6->v7 changes:
 - Rebased onto next-20260505 (based on v7.1-rc2)
 - Picked up Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
 - No functional changes
 v6 Link: https://lore.kernel.org/all/SEZPR01MB439931D7320F6C476D181C1EDC44A@SEZPR01MB4399.apcprd01.prod.exchangelabs.com/

v5->v6 changes:
- Patch 3: In pci_dev_str_match(), explicitly set `ret = 0` when no
  matching string is found. This resolves a smatch warning that `ret`
  returned from sscanf() may be 2 or 4 even though no matching string
  is found later comparison.
  v5 Link: https://lore.kernel.org/all/SI2PR01MB439326AF08A79D1C5661C29BDC6CA@SI2PR01MB4393.apcprd01.prod.exchangelabs.com/

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
  Request Redirect (which addressed the primary issue we encountered);
- Added checks for enhanced ACS controls on Root and Downstream Ports in
  pci_acs_enabled() to ensure proper enablement when grouping devices or
  enabling features such as IOMMU PASID.
  v1 Link: https://lore.kernel.org/all/SI2PR01MB43931A911357962A5E986FFEDC8CA@SI2PR01MB4393.apcprd01.prod.exchangelabs.com/

Thanks to Jason Gunthorpe, Jonathan Cameron, Dan Carpenter,
Krzysztof Wilczyński, and Randy Dunlap for reviewing the patchset.

Patches on github: https://github.com/wei-w-wang/linux/tree/v8-acs-enhanced-cap-and-refactor

Wei Wang (6):
  PCI: Validate ACS enable flags against device-specific ACS
    capabilities
  Documentation/kernel-parameters: Add multi-device config_acs example
  PCI: Consolidate delimiter handling into pci_dev_str_match()
  PCI: Refactor disable_acs_redir and config_acs param handling
  PCI: Enable the enhanced ACS controls introduced by PCI_ACS_ECAP
  PCI: Add the enhanced ACS controls check to pci_acs_flags_enabled()

 .../admin-guide/kernel-parameters.txt         |  30 +-
 drivers/pci/pci.c                             | 306 ++++++++++++------
 include/uapi/linux/pci_regs.h                 |  13 +
 3 files changed, 250 insertions(+), 99 deletions(-)


base-commit: 550604d6c9b9efc8d068aff94dc301694a7afdee
-- 
2.51.0

