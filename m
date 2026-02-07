Received: from OS8PR02CU002.outbound.protection.outlook.com (mail-japanwestazolkn19012063.outbound.protection.outlook.com [52.103.66.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33D8D1DED4C;
	Mon,  9 Feb 2026 15:03:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.66.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770649387; cv=fail; b=ZKQqmxx1uxk71g9FEASDCu65mQWhdmK4hKjoAT5W5UyYhNW9NZgBB9lj2LJXUBqA7oKQ56y7o2E3mFA8q72RKM6RY6ob6LwxkYim3ax2MKmeHhZk6y5m5PAHSEsVPolC/tG4fQjFGcQ0/QSMrPpbFZRPkrV5OaoJDLAfYmh1Qnc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770649387; c=relaxed/simple;
	bh=xvoJsu82vg5wXJ7gYgp8/UnvWr+EEW8CFa7ystngVHk=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=sevdAL4tWsfJfOqyvUewkQN82bI9BvsdJOSVH674eqlwBvLqsHCRV5KCI4gfNWmgXCr68Sa5Zy+ri8Ddq+FiZeWHkcmziKAiE3FSeKqzwgK7EPpgvqCtbIc0nsar0ujJypnCAcQZtrcSremmUD8yNuOuPxVJBGJkRzwDqB7mFgQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com; spf=pass smtp.mailfrom=hotmail.com; dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b=mJe9U/cm; arc=fail smtp.client-ip=52.103.66.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b="mJe9U/cm"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Fz6PX3QSuE4hBqOGdLLwqBj9o7IMk2nOacwG2ZNiVwDDPCCFb1YANZA9rdaSNFAjg9huWykfbHPzIMSFAXyCtdnl2LM7eozpy/Xg2J/NEFqYZGsMC0vkGc09vASvk8LYJr/QbSSeetoS6tRuDslvy75ByyBUIkM1Ja/BDcN6goSNNb3vl9IKAEUnHoM0JU1toaU0hP+tseUXW0LrxE8WuZQolJbKw+m1VZnWm52mrY7ZMvwgW1yQHTtGV69xVssW0Cu65B2gnEjZkM/+nTfxpawjebo7CaPaZ6cZzSnZNXbOgBeGhQJ/tJuJp52ykQ/NaFHpvHfbmPTHVRdqW7C0xA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7eNF/F4oSekmbeomVU/+r+hUsWCdN7RxJlrgixVKjIE=;
 b=oEdwunhGveuiZPOiyybjNl2SRRcw1fUc05jq84y6W3aNpuvboYWnm35wlh9UxE+ZOOA0jhlE35xJCMubdlpJAGQEyS+V+HDEryfmdKiFPduwdjdOy6lNyKq6G8dEuc7da9fsahKrA9Q6gOvO7qhBjlDukOPpTOPET73VZRFxTIq9312azna6ohdlx3M/pmuMEKqP0lo2ODP3PRrd4jRS0SaUDufUccBIOElAioWuxH+OPvhlPdsneUsIpj3njqWnDTGyQ7lIqZToLVonaEJZazxGaC80HGTuF8lQZKRKUIjs1YUUqWD6dpqtoTAcgj+kL8em7pqT8ksIlYXNCHXXug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7eNF/F4oSekmbeomVU/+r+hUsWCdN7RxJlrgixVKjIE=;
 b=mJe9U/cmZU4D1bBvweIFDh1ZHqiuF+UWeRWwxJ5WKKCHzFrsj1QuvlrJbUzUvVoVndeBKWCxMpMI/J1PrAlbb8H0IYx8vND1hRcAhBMkL3yJY2pukxYfWL0G4nE//DmgUdUCP4mingM2nXBOf2M2ZBqavu1aDwhXN8uS8LmpBHZ7qP05F6e78vHRetbqXGYEa5wtSZUMyWuGKjX1rxVvOrjXrqTYkE+DcubrZkOGW9W6L9ymUHWnILAuAnu2+LeoABMH804t9lckt5fwJVEZr5sapmhG/S5W4MhSDre1wRBvQlgZmhcx6N5zOd2pOBCAa49cCI1D32vu8NpLftAw/g==
Received: from SI2PR01MB4393.apcprd01.prod.exchangelabs.com
 (2603:1096:4:1b0::7) by SEZPR01MB4945.apcprd01.prod.exchangelabs.com
 (2603:1096:101:9c::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.19; Mon, 9 Feb
 2026 15:03:03 +0000
Received: from SI2PR01MB4393.apcprd01.prod.exchangelabs.com
 ([fe80::c735:fab8:6e3d:6d1c]) by SI2PR01MB4393.apcprd01.prod.exchangelabs.com
 ([fe80::c735:fab8:6e3d:6d1c%4]) with mapi id 15.20.9587.017; Mon, 9 Feb 2026
 15:03:02 +0000
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
Subject: [PATCH v4 0/2] PCI: Add support for ACS Enhanced Capability
Date: Sat,  7 Feb 2026 19:30:57 +0800
Message-ID:
 <SI2PR01MB43932C799AE9111C7D2C319FDC65A@SI2PR01MB4393.apcprd01.prod.exchangelabs.com>
X-Mailer: git-send-email 2.51.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: TYCPR01CA0087.jpnprd01.prod.outlook.com
 (2603:1096:405:3::27) To SI2PR01MB4393.apcprd01.prod.exchangelabs.com
 (2603:1096:4:1b0::7)
X-Microsoft-Original-Message-ID:
 <20260207113059.335295-1-wei.w.wang@hotmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SI2PR01MB4393:EE_|SEZPR01MB4945:EE_
X-MS-Office365-Filtering-Correlation-Id: e0cef4b7-c6c8-48ed-fee8-08de67ec5195
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|461199028|19110799012|15080799012|23021999003|41001999006|8060799015|37102599003|5072599009|6090799003|5062599005|12121999013|51005399006|10035399007|3412199025|4302099013|440099028|1602099012|40105399003|1710799026;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?YWRJOFgyczFNUk5jdm5GUVhEcDY0VEdkQjYvT210NW1SWkdhdmhsRnRqVTJH?=
 =?utf-8?B?L2gwY1k1NmozTW9JZ3RYY3U5M1IrUzcrRExqbFBQM3VERDV1VjBBY2F6dCty?=
 =?utf-8?B?cGljdVliTjZWanpzQ2hqUU14alNidzliN2ZrdXFpa2V2UUpndmc0UmJTU1Zl?=
 =?utf-8?B?Nzc0c0dIZ2VMdFVUcGMrYUpua3JzQTFCRGErbzZ4a1o4RkZwek84Rlc4RGZT?=
 =?utf-8?B?MlZDSWRSeEVFL05MMkRNdEM5c0tXakJZN0hqam5oOElqZlowMVpTcmRFOUN4?=
 =?utf-8?B?RkZUNkZsOGgxMmZOM3NXM2d2Z0d3ZllUWGh2eEMvSUVtYmc0V3l1em1UWXFE?=
 =?utf-8?B?RUNzTkFDRy9HWkU5dFNkbzVmd1ZCVUx0ZjRpbGhRaXZScitZaERtVnhWeC9F?=
 =?utf-8?B?YUhrVzZTM0FuWmV0OUlzZnpLb05FWjlkbG1abjdUUVJwTzNMTW91aXR6dmtV?=
 =?utf-8?B?Slo1UHcwM0tjTjJoU1RBVHFVK0V6N1BiSnB6WnZLRi8rdDY5OGxTdEVlR1cr?=
 =?utf-8?B?UHlCV3ppbm5CQTBSK0MvNk5UUHNMZUV5UGYwenRqdW1DNjBCLzhtM3Jrd1dx?=
 =?utf-8?B?YTV5V2pxczJqck9FWGU5TjltNlVTRHBJOFR6MS9lRjMyZVNXcDUyQjZMejNX?=
 =?utf-8?B?Q1RNRHpGY2Nhb3JFV2JCYVRUeVZ0UG1oWkpINjJxR3FlbjNFbEpzeHhFRXp5?=
 =?utf-8?B?NC8vcWIwOTkrQk0vaDJhaEZIRGFCSy9pVVNTbm1ydEFOaHlETldTT2JibEpP?=
 =?utf-8?B?NmFlSWgvaHRScHRPZW9nLzF4R2NNeDFjaUlCQkN3clBEMUNuUXNsZlV4V0Vk?=
 =?utf-8?B?Z3hEQm1jOHRzZzdTUnVpRFlZeHpCN2dtbGRYUG9GRnVCby9iWW5JQ3lGeGhj?=
 =?utf-8?B?anJWL0lmak1rQjBvbFJGRThqN1hYeHg1bC91aFVUeHFWM1J1OVhYTXdpN1RW?=
 =?utf-8?B?TnNjQ2NXRWVIMFFwK1R5OERvMytKN2dIM1VabmNJUlRhc0JuNkNvSUFtTXdZ?=
 =?utf-8?B?M0ZFVGwrWC9CbVExdlB6eDFSV0p5VWJFMjU5Z0FzWlBmZkJQb1FsZFBiVXdI?=
 =?utf-8?B?K1lKcTVialJ0bWVwcVd2Rkkwck9XbndIdHFkdTluV0VnbVZPM21KYzRjY2Yr?=
 =?utf-8?B?UEJMNmluK0tMY0MvQmNiSi9TSDQ1NG9memgwWEovenhCZEZsVldleDNpS3Br?=
 =?utf-8?B?cmJaZ1lKMHc2ai8vQUQ4a3haVjVNSUhFZTlycjduMXpvUytoL2FjWnMrclU5?=
 =?utf-8?B?bmQ3NTc2ZVlNL3hNTmtiMWhYZXB1d1kzQmVCdnFDNWZ5b1phVXZoTnlkdHBX?=
 =?utf-8?B?Z2pEaFpMYzVqOE4zVXlRZ1p0cDVQbGxkV3YyVzVTN3QycVJaV2Erc1ZKSFVP?=
 =?utf-8?B?cE1kcDVkKzZzQmxMWThTdnFKdUMwWWNoa2dEL2VUcTV3QXZDMXE2VUh2S1lO?=
 =?utf-8?B?djVjQ3hEQ0JGN2hMZ3lLS2FKMHpQTVIvL2dneUdvSWQ5d21BVHBtb2lQc0Zl?=
 =?utf-8?B?WnJldithQXVEZTFDY0VyRVR1eTNWT1ZPczJiajFKZHFzNjdsRGlKdk1SR1lS?=
 =?utf-8?B?Zk1Zck9UZkdqd0x0WktJRzk3b0dtTHAvUmlmNXU0K1dzd3k4VktKRWVBU3k4?=
 =?utf-8?B?QXFQQXpGU2t3WGIvdis1MkRVS2dkTzc5KzJMbmZvNWI0QkFNL0VKU2owaytG?=
 =?utf-8?B?N3Y5VDBWbjkrUG92Zk1NRUlKT1hzZmFjaTR6K0hRcHdpZEV6d1c5MXVxeGVa?=
 =?utf-8?B?QUZaU0wwSlMzang3bU1VVzNFT28zSDdncFRhaEtKc2UwRlRCNXRYbjRCL1I4?=
 =?utf-8?B?YW1PdXZzV1VZLzE0RTY3UnZiZmxjNEdNRFBGTlpKZ2FTSWt6aGRTTE5JeWs2?=
 =?utf-8?B?aGgzVWpoWWJnTnVUOXhNT1J2c2ZOWmZVeVJjZ0tsbVBsTllhOUNPcGUvenk1?=
 =?utf-8?B?MFJmQ0d3ZTE3bnFqSklVTTY1eGloZDBmSXJ2eEY0bkJENGk1WkR1bmw5dTdh?=
 =?utf-8?B?Ti94bFlVTnJGZTIvWW45TnRsRVdhSUttblVsQ3ZsTUNaajhyckx6UzF6UkFq?=
 =?utf-8?Q?VErhlT?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UU02UVhGcGtMeEE4U1U4NjlwcytIenMxN3pCcE5GcWpXb2hSMEtzLysxek4x?=
 =?utf-8?B?RWJDZFNFNXVhbFc1NWlGb2lFOTBSVXRxaHMwMWpEUWpsaFVCUkJCVWVjaFF5?=
 =?utf-8?B?THdNN0hhd2FpUXVoN0ZmSG5sblNoQ3JmYWJsbFlyYlUzUyttdXpPKzJtTHp2?=
 =?utf-8?B?WU1xZFZCbXBUMFdodGRIQXYwYmJMWUlrRHFNcEZDQzZZT0Q2TWxTSGhJYkVE?=
 =?utf-8?B?OEJSZTlwTnA4eTFQYnFSUHgwV2EzakFZVWY0amxEU053b1VxZ1lETzd5RXd4?=
 =?utf-8?B?czhkTS9MbDZrUTVPS1lVRktRZmdJeFNGaGFUWFB4ZmN2aWVjKzY4MjEvT3Rx?=
 =?utf-8?B?UE82Ylh2aStScDV6Rm5LSnJmMjN0Z2VGa3NCa01FaXJoOUs2S29RVVdoN2tF?=
 =?utf-8?B?T0c1V0o4M3k4YjB1a1Znd3Uya3VJRWlJYmRuMnhteTErdnEvcXgzcmtLdVNs?=
 =?utf-8?B?YnhJRmd1UU90UitodHFCMExWOTF0cXZpTDdjRDQvdTlUZDBid2JlSXVyQ0ND?=
 =?utf-8?B?cDA5QmtpdlBJRzlDOVI0WnZJblZHMFNXNmhpdE51Qms3eFBLMWpLOXJHTEkz?=
 =?utf-8?B?OHJaeE1LeVV0Z1UzT1NKWitWQndBNWp1UXRIOVlpMEtGTHFiUGFCUUlNVUdS?=
 =?utf-8?B?MWJ3cE5SeHZ5N09NMXlUcitXOUtPdDA3Wm53SkU4Tm9JMDF2REYybmc2bW5B?=
 =?utf-8?B?cGZQb0FrbSs1YVBTVjhhVDNFRVBoQ0VWWENBN0d1UnBsc296Z1BzU2FZa2pL?=
 =?utf-8?B?SUVGYUhpMXN4UU81Nzc3dUN5RkQ1ZHduRUZOdlh5RUVjWFB6YW5odVVsQ1JM?=
 =?utf-8?B?WHRNaW9iVCtpWHdqOFA2aGlxU2ZFelBGOHpFVFQrV2tFbndNZ1ZNZm53OWh6?=
 =?utf-8?B?OUtWdVBSb1VpNElhb05pRThTWjVsWDRUZENBTFNXV3B1aDgzZjhvbFFRODJN?=
 =?utf-8?B?S2IvWE9oU0dYR2lWcDN2WnpiOWkzRGFCUDZoVXJ6WmJqNjY0SWtKSWJkYVhH?=
 =?utf-8?B?UHhiblEySmJYODFZdGlHemRjSmRCeXZoZjIxbVhsMG9LeFd3U0c4emxqUjh3?=
 =?utf-8?B?Uy96UU14WGhPbjFpWE9XbUw0TWFBSHVGdkVCSUp3QXkwMVFUOCtxRHhkZk1Y?=
 =?utf-8?B?U3V2N2IzamJnSTlmOElTdzJTUzZ2QlFWaDNGbzdIcmtKRExGazJYNzhod0Ru?=
 =?utf-8?B?WGt3Nk9BMmJHM0F0L3hwMTZzOVY1SDFnWStoN1J6ZWgvN09wUk14RVBSYnox?=
 =?utf-8?B?bit5TnBrSnZ0UVEvVVR5WVMzQUFFM0g3SUVzNE1aUHIzZjdrWUh0Q0diMFNU?=
 =?utf-8?B?K0Z1cXJGcU9YblljT282eEFTZFBaYmI1SmdvN29icmJ3UGRycXNxVUFoWWM1?=
 =?utf-8?B?ZWs4eFFrNlNhOXNxUHA1Z1Mwdjd4SEtYcXdickNqVzNyNFFHekRjRDV4WlQ3?=
 =?utf-8?B?Q2Zxb2dlc09Ld2UrRnlEVUNkV3VTallMNDM5bVRiKzIwOUpjQ3orYTFlQWRT?=
 =?utf-8?B?US9UYVlnMWhzVlRaZ0RFVHdWVGFqbFNVQi84d1lNOWg1K0xoczFkWmRRRVNj?=
 =?utf-8?B?ek1rSHQ1SVN5VThWWENiekxOcUsvNTZDVXUyTFhTdkZodjlCU1YxSGo5LzJ1?=
 =?utf-8?B?TlNRU1lLQ3RGbUNoL0xob2xwYXZzanRFblVWb29HdG1xdzZCOW9neG0vQVJL?=
 =?utf-8?B?VDhOMkRDQitDSGdQMWRLTEtwWTRmMVVCMUtsM0NWRXRYZGwwVUF3TmgvNjBw?=
 =?utf-8?B?eE9lZWlVL1hOVWJqcy83OTJPTGZhc3FpczRLUXl1OURIQVRMTkZYUkl4Z2lT?=
 =?utf-8?B?ZFNYbDVIRVpBYmxHN1hzZ2tTdTE5dEtVd0ptaVVybE1uYTN0TEVUSkNxK1Fz?=
 =?utf-8?Q?4e3QLZdnTXY2G?=
X-OriginatorOrg: sct-15-20-9412-4-msonline-outlook-5f51e.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: e0cef4b7-c6c8-48ed-fee8-08de67ec5195
X-MS-Exchange-CrossTenant-AuthSource: SI2PR01MB4393.apcprd01.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2026 15:03:01.9358
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR01MB4945

This patchset adds support for the Access Control Services (ACS) Enhanced
Capability, introduced with PCIe Gen 5. The ACS Enhanced Capability
provides additional access control features that improve device isolation
— particularly important in virtualization scenarios where devices are
passed through to different virtual machines (VMs). Strong isolation is
critical to ensure security between devices assigned to different VMs and
the host.

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

Thanks to Jason Gunthorpe for reviewing the patchset.

Wei Wang (2):
  PCI: Enable the enhanced ACS controls introduced by PCI_ACS_ECAP
  PCI: Add the enhanced ACS controls check to pci_acs_flags_enabled()

 .../admin-guide/kernel-parameters.txt         | 23 ++++--
 drivers/pci/pci.c                             | 78 ++++++++++++++++++-
 include/uapi/linux/pci_regs.h                 |  7 ++
 3 files changed, 100 insertions(+), 8 deletions(-)


base-commit: 9845cf73f7db6094c0d8419d6adb848028f4a921
-- 
2.51.0

