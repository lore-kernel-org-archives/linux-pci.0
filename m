Received: from TYPPR03CU001.outbound.protection.outlook.com (mail-japaneastazolkn19012062.outbound.protection.outlook.com [52.103.43.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61E7084A35;
	Thu, 12 Mar 2026 09:06:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.43.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773306418; cv=fail; b=T/0D2IrxJnlU0y20jgUSHVHGs9g/96pl4GuD8ESUnYBmu29gqn5Iop/QxTclKwFvkDF43G8mxhWoAlYxWJg+iXZ/GUai8dwXfaZBBoxbjgjlOYd62BX+Qich0PoxP4Iuo4JA+aSKrhVXXipk5S2+yYP2kuTqrYk/CQEmUPtzqPs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773306418; c=relaxed/simple;
	bh=n9VzoATDS0oNR0LmX/Fbkn2WMp6LOseWwlJYWeR8zcs=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=YUkAmrfPG80wrtvb+/tdhr5mjiMzSHA8X3CUsIyha/HL4PSiQwcPo7/2uI1cATJ4o4AwtgMnBbhVSIIarEbOhIAzw7KTCVb2e8bqZAK7VDCbB6AQ6rGTt1NyltZMY7O47moIQzJIkP1+wcUjO7YS12OryATs/Gl+5Z8FN9kxvPc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com; spf=pass smtp.mailfrom=hotmail.com; dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b=abAuYI95; arc=fail smtp.client-ip=52.103.43.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b="abAuYI95"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rjmwfr2PPdTBlFqMntdh8tFDEo6pFH2QZ7PStQHTat/fuoXAE64Z+xvVq1uw+J63Ln1OBXneboD6ZaOJIJDuUaw5ojgpvC6bfujZ4XX9XTRoz1I8+xVsqSlK9+YxdSAgq0yZvj+KcD16PE8HszCNqje19peqNCWsIpRRMDBEg5WDEviBGd2hFlhHJKRfF5v+mQUrffkFrWA0qxMBS8vXkP1LgHnGMDVttCZEej6btqtCg5L+vEk64JAkXaVtP4UZGZnJFcdlC055vv8qLz0K/1xL/zBaIi39dFeluo94VSuo484ZUh/q4D8M+SJOVVlzh8V/HhmmmWQd/j+rLxdy0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hxGiG4JjIEqCE7u8kHmGcI/dlOqWwTN9/yrjX6AHGVY=;
 b=Pm83HBNyzYm0Pst7XZBDc/XGCTdKbTvbVKvi/6ikfB8+lqz1zqKhPsWtrF8Q8OQgrChY649ESBkeYaFAa829yC8BMc90SQdbF5d0ugFH8+bDIUfktBpC3qtfoDP2KTTy+zE3SmG+P92hNPI7DHGiJ8uFs8117tEDxpnx9RvSglPGRgXEFdHDhjJFgq1oj52WwmPXAXFVu4/zyZvdBcHaDVgKUmOi6w2VAlKM5iIghtnSY6txgjln62KrfBWpjtoYv+X5bBUTzN9YnpoG8/+GMFzv5Y2KMUbCAqaKCnQgHG1CvJ3iqbgYRNCNsxTP9vOUCpVzgTqLj+JsugzM6WxElQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hxGiG4JjIEqCE7u8kHmGcI/dlOqWwTN9/yrjX6AHGVY=;
 b=abAuYI95EMhwVLSR6yvIp6PdmP/2RPpmwtc9dmnvv40BLtk7+O7o9hMy9thH3+QRz+9B8hzWl/z0spbIvbiQ0axL4VYKTJUiF/oV66v1MHERO0zohZHvRHmdoLc85x+8zzoeGSE+RzTPAylniRvCEhPQL5b0ocEO2Axa6JqPeS+VzsbDVTczOAtivOgqPNzrBZ6XMVeFmlketfwekkO3ZU2PVGSgaLSfItC/eKSugbAWDX/Bp4c2pd4+AyDjeob5XbUBIY9TQYIUkDL1ARJwGLSuwoCCH4e366kPDPImpCBr6VuXUIJBJseCbGSlCErOC0FW2a2DmjipVnkH49graw==
Received: from SEZPR01MB4399.apcprd01.prod.exchangelabs.com
 (2603:1096:101:4f::13) by KL1PR01MB4704.apcprd01.prod.exchangelabs.com
 (2603:1096:820:c3::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.15; Thu, 12 Mar
 2026 09:06:48 +0000
Received: from SEZPR01MB4399.apcprd01.prod.exchangelabs.com
 ([fe80::fa7b:b19f:e19e:ed75]) by SEZPR01MB4399.apcprd01.prod.exchangelabs.com
 ([fe80::fa7b:b19f:e19e:ed75%5]) with mapi id 15.20.9700.010; Thu, 12 Mar 2026
 09:06:49 +0000
From: Wei Wang <wei.w.wang@hotmail.com>
To: bhelgaas@google.com,
	jgg@nvidia.com,
	jonathan.cameron@huawei.com,
	dan.carpenter@linaro.org,
	akpm@linux-foundation.org,
	bp@alien8.de,
	rdunlap@infradead.org,
	alex@shazbot.org,
	kevin.tian@intel.com
Cc: linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	wei.w.wang@hotmail.com
Subject: [PATCH v6 0/6] PCI: Add support for ACS Enhanced Capability
Date: Thu, 12 Mar 2026 17:06:31 +0800
Message-ID:
 <SEZPR01MB439931D7320F6C476D181C1EDC44A@SEZPR01MB4399.apcprd01.prod.exchangelabs.com>
X-Mailer: git-send-email 2.51.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SL2P216CA0100.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:3::15) To SEZPR01MB4399.apcprd01.prod.exchangelabs.com
 (2603:1096:101:4f::13)
X-Microsoft-Original-Message-ID:
 <20260312090637.71548-1-wei.w.wang@hotmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR01MB4399:EE_|KL1PR01MB4704:EE_
X-MS-Office365-Filtering-Correlation-Id: 64b78f13-8b13-4d6a-c765-08de8016b083
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|6090799003|37011999003|5072599009|5062599005|12121999013|51005399006|15080799012|19110799012|23021999003|8060799015|461199028|41001999006|37102599003|1602099012|40105399003|440099028|3412199025|4302099013|10035399007|1710799026;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SllPbVR0anZ6RkdRZitORjA1OTFadlNLSHBmYUZRQ2xjdVhHaFVBSGFXTCtp?=
 =?utf-8?B?bHY2ekkyRzEzT3hVeEx6M0F5enROY2xtM1VjN3RkemsrTVgwRXU0TjVtbnVK?=
 =?utf-8?B?MDNuNWg5RWhQOEQvZHhCY1JQWVhWZ3JPM29xWkRJVUI3UWNrcEQxL2pNYU0v?=
 =?utf-8?B?cnA3SjZqMCsxVEtqNmVjNGhhRWxxVTQzRytqNjFMVkNNRU1kYUZQMXhJTk5i?=
 =?utf-8?B?dzg2WWVsMTJyWGZjM3hRZW42a1dpMWpTSElHL0FwaFhlOHBPbDlvdHduTkhE?=
 =?utf-8?B?MkJYbndqM3g1VjdDT1p3UkZJcjlnY2lUWWgyY2U5WE9TeWNoZHZNb3dNUEx4?=
 =?utf-8?B?dXRMcWJmRGszTzZxZjNHQzJHZ05YL1NYZ25xRXAxbUpTdmhIbDJvWjRqUmYy?=
 =?utf-8?B?L3E1SmpDa2FScm9Va0ZoVUFya2RXb1BkM1k1aHVFM0ZaQ3k3dHBTWUYxZkRV?=
 =?utf-8?B?c0NWUlpBdWhpbjJHTGJ3UDlnOTRFVzBjNGluRVNxUGx6ei9qTXFWckphZFMx?=
 =?utf-8?B?N3NvMkJ5b3FnQjFQMnUycU1mYStSaTk3S0VGZ2Q5NUhYWUZJZDRQUkhrblo4?=
 =?utf-8?B?SFRsRXhlV0l1NDR3VlFhNEpBUnVROVlaMkNZQWJKVnI5ekd6c3JiaWppMWlR?=
 =?utf-8?B?Yk9mMHNDYTVFUTFFSnFXMTYvdFBXL0FheHFTaWU3Zi9GTjZrNXpkbXNLN0xU?=
 =?utf-8?B?MlZJY0FkTytaVXNJYldhQjZSQ2Y2bnpiaTgzQWMyZ2w5NFhERy9aeU1YTVpK?=
 =?utf-8?B?THdUU2EwcTlSa2pNbU1HcEQ4UnRibXVNSVlzVVdMdWZiMmllRjZHV3Ixejd3?=
 =?utf-8?B?Vk5HYVNHbS9lT3hHb3BMbXpJa3pJVjJtbHUxSXRqWmxwSzAvVVF4ZFdkWDFB?=
 =?utf-8?B?MVJ0MVNJUWV4Qlp4b2ZuUnpWNmwyMlVDRHQ3Q2ZNaVFKMWluL2JLRGZnOVZV?=
 =?utf-8?B?MUdBN2hWc1JyWWcvaDNwTG1WWXhtODFmVmVNSkZacjNwalZJWTEwaVh3cU9x?=
 =?utf-8?B?L3I0c1drMVJXQXNKdW5WY2NSU2NFamVVQXZQWFNrY1VKK3pXRjhLYTBaaCtG?=
 =?utf-8?B?OTJsRzZncDIrMmNSd3dvRTAvMnFqSHprUlAwSndpYjJaTTdWRkFvUHJIZTJR?=
 =?utf-8?B?NDhKdjJHL1BvMUJZNlNvZ0JuYjhXQ0VhRGJsSUxhelJWd1F0TlRGeTBORXdM?=
 =?utf-8?B?ejNZVjNpWXBvV29nSmlqS00yVW82NHFYNGQydFQrSDRjSWUzMUgxYk9rZ1J5?=
 =?utf-8?B?SzhBQnQrSjdGcHJCK0FEWFZ0NUt5S1BXbkFWdXkxU0pQNERpcVZPa00wZlUz?=
 =?utf-8?B?QStSRHFxUXpFTE8xaEVES3J1WlZ4aGx5ZFdGVERGZ2x0VmVGZ3B1UlUyTHdE?=
 =?utf-8?B?TEIzYWlRQWFwWUplSzYvazBwOUQvS3hMTnQzbXdkUGFQenZ1d2ZmT2wrbW1o?=
 =?utf-8?B?VzRLYzNzOXJKdjlSMEJ5VExnSGxPejJBVGxMNG1kSktzYjBIdm42OW52SXJF?=
 =?utf-8?B?YmxnZ1lmdE0wV01tMFBiaUhQbnZnMnQ1UnAvcFBYWlR4S3k4VldORGIyM0Ix?=
 =?utf-8?B?RFBtWUhlcXgzZkFoNStTL3FwTWxNRm9ISURNL2JoNk9MZGV4U3BWMEk4L2pm?=
 =?utf-8?B?NGROWXUyQTBIU3ZaQzdRTmRXQmo1RUE9PQ==?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bGErMGZDUiszY2hmVmNNeXF1a0tkTk91TzljWndXZVRpd0llMVFUYklKZVhV?=
 =?utf-8?B?RDJuclQxSlJxQVBja1hsOHZYRlQyNXkrMExNV0tHeVJYdFhOL01aZ1JQdStI?=
 =?utf-8?B?SlhDOGFRYUdSanY2VXE3akViWHJxYmVTcXVEUU10Z3dSMERqK1lDcFV6aTdw?=
 =?utf-8?B?TjNTemI1dHJNOFJaR1U2QUJFdzFZUHBaNWdpOTU1QXYrZ2wzeEFMUlcySTl1?=
 =?utf-8?B?elErSVlQVEtrcFh0RzgzZ3FoT2FSZWFmK0s3dktQQzdBN09VTmhNcTNRRnFL?=
 =?utf-8?B?cHRiSnBoVGtXVnFkUmhWckpqaEJsUnM5SWdCTnM5cElJeHpDQVJHNFJpQlVu?=
 =?utf-8?B?NEZ1T01xRExwMGl2OXRiVTNBdk03Tm1hcTlCWTl5WFZkeDlCcU9NZ2l4SWkv?=
 =?utf-8?B?UWZYTmNqMVoxYjkra1kxKzRBL1g4QTVEOUVWeDA1aXlHWE00N1F3U1RJcThH?=
 =?utf-8?B?RTlXTzduY0RJaS8wNTVXQXZJNUNhOHdFbHM2QzNSK1ZlQVJsUmNyK2k2cGtv?=
 =?utf-8?B?OGF6cWliVFladVUwT2VtWUdGMUJmYXQrUGpIUGI4M1l4Tis5cHZmMmtocis2?=
 =?utf-8?B?U0VoWEV2UEtza0t6bVVBc2NTY05hd3kzbWdyMGdWY0h1c2d5WHNZSU1ZN2xq?=
 =?utf-8?B?MFdpaDcxNW9YK1JDazVPaG9YcnRIV2wweUlFd09tQ1pHbGJzUS9HVVg4ajBi?=
 =?utf-8?B?Y3lRbEF6OFpGeEdDTCtocThuWGRybjNGSXVmc2RwTVk3ZytiV1BXb2JBdXA2?=
 =?utf-8?B?OFZ6aFp0NEh3SXZGZ0xSOXdGK0RzRE85OVhMRFJ3bHhieTduWmFxVzhJcHgx?=
 =?utf-8?B?d0NsZFMxdWNDMDJZQUh2MFJoVnRtTXQwQ3p4NXo0ZVNtMHZYRkJBQldpVlB5?=
 =?utf-8?B?eFlrZ0JEUmtWK29RN2pLRnJCTVAwN3lyRFIyUGJZUzg5NVNCaEp1N0lJbEp3?=
 =?utf-8?B?UnFIQmdRTm9ockpNcUdjdC9PYS9GT0k2MXF5TSs0Z293ZkZhQnBjTjlUZmFU?=
 =?utf-8?B?YjBxKytpTEhCVmFQejlQcFhuNkhqUGhqL29HREpnMldEYmFoNzhUdUVKMGNG?=
 =?utf-8?B?Q3ZJOWdXUy9rZVNLUnRaSmRNY3d3NnFBSU9naHpZZC8yUWxkdnJkVnh6bGQr?=
 =?utf-8?B?SnA3bllmQzU3MGRrL1lKN0NwZlBWVHJVZzk5YitaekZsQStKUUp6ZThOUzRy?=
 =?utf-8?B?K2hoSzlveFhUMXdjTy9HbWRnUlRONVEyUWVEVWpUZUVLY21QdW5zZG84b1Nj?=
 =?utf-8?B?RUxMTEIvR0ZrSC9EWlhGa0o4VFVuTEM4bjQ2NjZDQjB1YkY4MUxldUFMWVBE?=
 =?utf-8?B?aDJjODI2RWxoNHlBYmhVLzZ3bENUamkvRExKb1BWbnRINHBxQWdsNHdIYW44?=
 =?utf-8?B?b2ZOWmlMZEhMYWJ3bC90eW9vb0h2K0YwdDBqN21BN3I4TnFoVjgrOTBRV1Rw?=
 =?utf-8?B?TEQ4VXhsQVZTODI1S0xscTVBTmFlWi9YR2pVZmpqeUp3K2JjaVpsRjRPa1p4?=
 =?utf-8?B?Q2pYekFmd0Y3MFVtZmUyUy9oWWEvOWtVTnRWcDFWTDV1QzlsTnJjNnhsL2lw?=
 =?utf-8?B?bnZXYnVxVEU0b3BmaVYzZWk5YzBjT2lYaUVWVmJUQU1ZbndDZnJmK1pRTHdX?=
 =?utf-8?B?THE0dE45VlpUZEhldnlwamYvaEtHYlNQYnlWOGczcnFWS0NBTUs0TVBqenEw?=
 =?utf-8?B?SllpWERBaDlwYmpCbkFzSTcvb3kwWHEvT2hTR25JbVVUakpwKzlnTmZ5UUdI?=
 =?utf-8?B?UFptTjg2K2FLWXdBckJiRnZMTy9wa250cW9TK1hvV3huckJCeVV2ZkFVTjh2?=
 =?utf-8?B?LzluWGVsMkQ2YXdQT2JJMnpvRHF0bnZ6eHF3cHdTWUl0MVdFejUySnBIbXBR?=
 =?utf-8?Q?/d2f+7ZgFQcSA?=
X-OriginatorOrg: sct-15-20-9412-4-msonline-outlook-3e488.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 64b78f13-8b13-4d6a-c765-08de8016b083
X-MS-Exchange-CrossTenant-AuthSource: SEZPR01MB4399.apcprd01.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2026 09:06:48.8704
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR01MB4704

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

Thanks to Jason Gunthorpe, Jonathan Cameron and Dan Carpenter for reviewing the patchset.

Patches on github: https://github.com/wei-w-wang/linux/tree/v6-acs-enhanced-cap-and-refactor

Wei Wang (6):
  PCI: Validate ACS enable flags against device-specific ACS
    capabilities
  Documentation/kernel-parameters: Add multi-device config_acs example
  PCI: Consolidate delimiter handling into pci_dev_str_match()
  PCI: Refactor disable_acs_redir and config_acs param handling
  PCI: Enable the enhanced ACS controls introduced by PCI_ACS_ECAP
  PCI: Add the enhanced ACS controls check to pci_acs_flags_enabled()

 .../admin-guide/kernel-parameters.txt         |  32 +-
 drivers/pci/pci.c                             | 274 ++++++++++++------
 include/uapi/linux/pci_regs.h                 |  13 +
 3 files changed, 224 insertions(+), 95 deletions(-)


base-commit: 7109a2155340cc7b21f27e832ece6df03592f2e8
-- 
2.51.0

