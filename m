Received: from OS8PR02CU002.outbound.protection.outlook.com (mail-japanwestazolkn19012063.outbound.protection.outlook.com [52.103.66.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EBD937C101;
	Mon,  9 Feb 2026 15:03:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.66.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770649387; cv=fail; b=cpAID7y31L93MvRlQGMrdbsudkkGvwZQaQr2O1gIQHZK/VWz+5a6v36t8zJFm4VYz1b+/tCvFu4wi7SbcobbNDGlXurI0uDBH1wPAnZH6qzYrz1MeDroGgwCmQUZrP6MQiZDRjUpczT43NUADDOr7Wu1vMIwzhj4dbaMipWc4Ag=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770649387; c=relaxed/simple;
	bh=O0VOwdf8eyhVU1yfyb+ynkDQuh/eheTSgSISkw7QSQE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ufqlmnvpFpd5wR4TuleEtsFzk7epCTTZizxIctJdTAANutGHkZLJOtxeFm+ridK49ZNcYoz2753FlNJF45LR1eg5ePWNYcxAJXP6wJWq4JUPKLGZ2+TSlKSG/YLkDZYI1vcCxhdLJYe8fKU+cs4wUu5YRUsp0Um9zLsUfaKpmCA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com; spf=pass smtp.mailfrom=hotmail.com; dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b=Ec3zRWAX; arc=fail smtp.client-ip=52.103.66.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b="Ec3zRWAX"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HCpj5e4TvxuiCEhuPub0rhQoYTNuFQprnwwpcTc1CYaMoLJDd4ARF/6QQjtw0W6l7Jy7E+QgbrelV5K1/X2ooGjt59rH1ERP959kMY2AlAbe5PBdCTVBZqyrY36vfdT0sRT3Hjc7mlEDzBffGG7pAtuS9vOWRjipmHL89eaubjUgI+0KJ1BCLESjnapI12GT1Y4ZtzS0pkXOJyj7Bz+/BK5yMSjCVJM0toDbjT0b6E29h0eZZoE/linSGjNecI/wXwVPNeU0hLTPdcjZkbR+k36u2+s9UCg9GCMXUa6vSY7n+50BICV5iTr/B+iAe8Hgo2xxXFk2YJZent7fCSOhYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gJGDbA0s1nA4s5/EZQTmILmHkxcIEV+AasgMhwKKW+M=;
 b=ZVC+oHC814IHn/h3bu7eVzPWPVlaJ/NOBV22vFEthXpdIX3RO+z1Jn8DDsZ8uLkHZ+kXxjue7gMAErTslGxb51SisDPcCXseiA7aF017KVn0Inn7UqklNm7xqjYbU0ETBzTqEsJXqfPZVaQQxiZ4SRG85imT0nd+yQdjp1dKhh0MsXLZrXiZRPJ9Iq+td0OgsmCa6LMpLmubdTefnp7QHODTp449CqB0vwP6IXSjJnPnWQPxfC+uoZhL+N2CoXDoN818d/0k58RRNRhJ/GGtdOhIJkR9vbWw9whxfT1R+qcHHTQvtHr52PwHdjeTbmlQuqGSzo63btvWxZlzXvTmTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gJGDbA0s1nA4s5/EZQTmILmHkxcIEV+AasgMhwKKW+M=;
 b=Ec3zRWAX+OW/YIu4pa3FTJlt8+E5Fd3fquIi+5lF86AkbnlKnV3U1/xHiSCFC5G4cscc9C20mZ4/z/wZC3KNsmgAqbp/yoAeRFAGuZ67YnyiUeobcoQLyQN71Qt4OPtVWN7hWMS32TZYoP3WU6F61EQA+UBBT8mtD9lJTZQeLZ1DZGXrCg1DaYTy3B17qdpooAJT1wPL6HxImTy2t1I/cD2d0YRmt7InZoRlXX+ZcvgG6fSTU20AXvDrEtJ4xoPRfzTsk+5X6s9JoIHK8Gp1k4tibjWW26VdjGMlKabbo6brWL9441F4IvvNUz8KiAGB5lSIJc4pHTU0UVsGqnYh0g==
Received: from SI2PR01MB4393.apcprd01.prod.exchangelabs.com
 (2603:1096:4:1b0::7) by SEZPR01MB4945.apcprd01.prod.exchangelabs.com
 (2603:1096:101:9c::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.19; Mon, 9 Feb
 2026 15:03:04 +0000
Received: from SI2PR01MB4393.apcprd01.prod.exchangelabs.com
 ([fe80::c735:fab8:6e3d:6d1c]) by SI2PR01MB4393.apcprd01.prod.exchangelabs.com
 ([fe80::c735:fab8:6e3d:6d1c%4]) with mapi id 15.20.9587.017; Mon, 9 Feb 2026
 15:03:04 +0000
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
Subject: [PATCH v4 1/2] PCI: Enable the enhanced ACS controls introduced by PCI_ACS_ECAP
Date: Sat,  7 Feb 2026 19:30:58 +0800
Message-ID:
 <SI2PR01MB439394223FDDF3F405B40926DC65A@SI2PR01MB4393.apcprd01.prod.exchangelabs.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <SI2PR01MB43932C799AE9111C7D2C319FDC65A@SI2PR01MB4393.apcprd01.prod.exchangelabs.com>
References: <SI2PR01MB43932C799AE9111C7D2C319FDC65A@SI2PR01MB4393.apcprd01.prod.exchangelabs.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: TYCPR01CA0087.jpnprd01.prod.outlook.com
 (2603:1096:405:3::27) To SI2PR01MB4393.apcprd01.prod.exchangelabs.com
 (2603:1096:4:1b0::7)
X-Microsoft-Original-Message-ID:
 <20260207113059.335295-2-wei.w.wang@hotmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SI2PR01MB4393:EE_|SEZPR01MB4945:EE_
X-MS-Office365-Filtering-Correlation-Id: c25f45af-e3c6-4653-32d0-08de67ec5370
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|461199028|19110799012|15080799012|23021999003|41001999006|8060799015|37102599003|5072599009|6090799003|12121999013|51005399006|3412199025|440099028|40105399003|1710799026;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TzFUYm1MYlBraFFxbzNOME1yRDYrVVNYYnVVZEs3SHRXNGVzYXZhOFlvYTNr?=
 =?utf-8?B?OVlBcVdaMGhiZjJUVVhpbHBWTVUraE1TR2VzU282YzNWWVljZUVPVUs4dTdK?=
 =?utf-8?B?ejFIZmcvVEMrUUFHZ3RxdkQ5cE52Z2w5SHhWREJwaExiSTEwYks2V092R2Nt?=
 =?utf-8?B?RFRkTDFPaUVDRkJvcW1mUWJoTVdpRFk4SFVIWGRPWEUzNUxqUy9xSTIySjMx?=
 =?utf-8?B?L3hTRWxlLzk0cXhZWmJlbzVZaC91UmxsZUxiS21VVjFPZkUwTkMyY1hETE9T?=
 =?utf-8?B?VGFSZlZPRHZzUzNCTCs1NmN4bEZNTytvK2RIL0JMMXFZYTE1dnlkL2tzbEFB?=
 =?utf-8?B?RnlOS2tja2t2QjV5Y1dtRDNVeWxLb2VKUG13bW53U0NKbmh2WTBVM0RyNGZP?=
 =?utf-8?B?S25XMUNHcWFMSVpab2k4SzVpQkx4bGovUTZwWWhZZlNPYnBITUF0ZkNGRUdw?=
 =?utf-8?B?V0JmdzRBa1ZnMGxSMDhUMzRPTGNHSnBJY3BRZ3o2bndrVVZZYmlHLzJXRlpq?=
 =?utf-8?B?SjdSM01VckRVeCtSejd0ZEZIbmRsVXFnSERJNVQwWTFzdG8zRzIxUHRnMjR6?=
 =?utf-8?B?NUtTNm00U05yZ2ZiZldKWWl1VnFkbzJta3JVblEzdmt2RUxaTE1JdFlKTmxT?=
 =?utf-8?B?eXVDcG45eGdBZ3ZmSUNmU0VKQ2wvV1kwOHFHNVpROXRhVU5uVmpMSFQ3SVZt?=
 =?utf-8?B?eUcwTlRYeFVlUzhXOEk0MXYxQVk4VnZINmlvRnBJVzNNUy9PNHQ0MUVKVUVo?=
 =?utf-8?B?eWtpcFlQbk1wOUViYTBpYWhIZGp2NE5CTU9tK2FHcmZ4U1hUeVhaNnlCL1ZI?=
 =?utf-8?B?bmc3YjB0LzdwVEpWQ2lYZy85UUlucXI2M01rVzMvSS9nUk04UG5HankxYlly?=
 =?utf-8?B?KzkzU001Z1dlMldBaFVvb1JmaGIxTmU1UHViSFBuLzdXU0xhWjBSU0M0ZHFR?=
 =?utf-8?B?RHQzU3JmY245RG54d01hbnBsNUtwNmxBZiswTk5aV2dtSWYzOWIvRk40dElC?=
 =?utf-8?B?VUhOOUJ0NzFvZFZ0OHNFREQ5eEtUV3VIV0tDQnNET3Q0eDN3dHJaMU5abjA1?=
 =?utf-8?B?dUQ4bVQ2RXorU0I2b1lWNzZ0ZndhM2ZDU1d2dlpnTW5nY0Qwazc0K0xKYnIy?=
 =?utf-8?B?OFpQV3Myc2tERzk3U1lEMFNXVUkzd2krV0tPZ3BRMUUrZ0FGblM4QUVkUEl6?=
 =?utf-8?B?SnVWc1JDZXV4YlJ5YVo4dzhBdmpDWkdHNGkwWHQxdktXeUdhallLL05RSXlU?=
 =?utf-8?B?V2JZbThyRTcwd2ZLRkZ3djRMZ3ZJWjFEejhnMXlQOGg4T0RRQ0ZYZzNvaWNs?=
 =?utf-8?B?SHcydnhGLzdML1FBQUZuQmRkZlZ5TjQvVGliQXAyNllrMjUvQnBZRDFhZXNz?=
 =?utf-8?B?UklGRjdhTXF1ejZMVFJYQlM2V2M3TzBBczFleGVxZU9kU21TbjVjYnM5N3I4?=
 =?utf-8?B?M3RySGVmRDMzZERweUl1WWN3MUJ0U3orVm9hOGl2anczV2xTRDlHWmNwZ3VT?=
 =?utf-8?B?dDNEMld6c09VdlVFaXQvb3dBRUZKQytwOWRrRG5zcE9iTHhWaTFxQTlrczB0?=
 =?utf-8?B?QWExT1BIcU9lUGJEQVUzSTFqWEFqcm9zNEZTMW9ybThqSWl0alRkZFJaMDRR?=
 =?utf-8?B?U2JvSkJKOWRBTW1qczFmOStVeUVpOGtwMmhDcjRYUWhQbFNDbGtHSG10aHda?=
 =?utf-8?B?M2I0Mk1odE92SEFSUHZqNEIwM3YxNkZVbVNtM3N0N29RYjlxUVFaTEo1Vzdn?=
 =?utf-8?B?akJuc3BjZDE0UlAyV3BZRkIvbFI5NmpScXpCQ3hOdjVRZEJWT213dVNNKzVo?=
 =?utf-8?B?N25QMDFVVVBqK0RUNWhvZz09?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?STg3RlRtc2NKZEIyNHpoazMzclJtM01sYTdvMWNDZkZ0ZVZ4N05qM29Tb2Ny?=
 =?utf-8?B?U3BuQW03dkhhd1lNMnlVa0pDRnFhNTliOVg4Q1lINldUbkNOMWFMcWEwRDJa?=
 =?utf-8?B?UmlzblRRYVFqOW5wUXZnTzIzQjdVK05DQUFCVTJxb1l2YkhhTndrZWkxcDJp?=
 =?utf-8?B?TDFNVUprdFlRL2U5ejM3QThTMEx5bVBTSjRVa3l3MldRc1ZUZlNkdGMxRFJj?=
 =?utf-8?B?aXFhSnpZdnNrdUdmeUJ2a01pVlFnSXdzTDVHKytNTWJoNThqYTcrSUhwRzNq?=
 =?utf-8?B?cWxsdDg0Y0U4QjFkREt3NWxUWFZjdWxQN2U5V2Jla3pMWmpqK2lQRkVOTWxP?=
 =?utf-8?B?UDlzbE0wT1M5NUFjdmgrRG85ZzVWekpJaWxwTEtVVVNWcExqMlRGamdMS1d6?=
 =?utf-8?B?VU16RHNYNENzOEFkYUtmM2swcU1jZkw3MDU4N0J2dXJOc2w2alpLa3BPclpy?=
 =?utf-8?B?aGJGTmVVYTZYNDlFRnEyWXdJRHdtNEhlMWhnTGdaQjZPWndCS0lRTkpxeDM1?=
 =?utf-8?B?MDZRbGttYlhYaVQ3U1ZBWktNa05xUkZOc3NlUkpzdlFrcFRyOGtSc2pQbTBt?=
 =?utf-8?B?cmVhL21MYlBBUnYrMHkxUVhJUkdNd0RxZXVyZ08vRms3Mi9POUF0bDZyS21I?=
 =?utf-8?B?YnRoalJsZWppeGdhZ0h3dnFTTXkyNjRDenVKSDl2Uzk4Q3lyZWNuaEJ0Y0hK?=
 =?utf-8?B?TDArMFI4a3N1aVhjVFRvZnYxOCt2Tm00dzlUUWx6ejdwRkVFT3ozamtPbStI?=
 =?utf-8?B?VExLQmFPeXVveGozL1F4S25nc0ZuaE85dE14Z0xQUnVRdllPYUplcThxYjZD?=
 =?utf-8?B?NFZVejYxSTRRQXo4bHRjbjFLQ0hRektWbGZYVWhQcFpjNXZKTnBsMlkzMnQ3?=
 =?utf-8?B?ajNNbXI0N0NFOURuYUZvZDYxNitzV3NjMS80QTV6b1RoSm5FM2wyV0d6WkpI?=
 =?utf-8?B?c3daMkovTXFQVVJlZThMTno2bm5jWGVVaVNTRlVocWZ5MnV0d0Y2Y0ZYVi9Y?=
 =?utf-8?B?UHZRQ2VFQnFMcURaSGh4UXF3ck53YmE1dzFYZCtnVHdIa3NnYjlEbkRmcnZ1?=
 =?utf-8?B?c2RocWJiWG96d01tMGNqQUVVRmRRQnh2amJ0YXNTYWxDOER1bHJyMHJKU0Ex?=
 =?utf-8?B?UDJodENWaSswM2V3eFNwc0tsV0pmald2TVZZY3hTaEd1eFlDUGhJMzRYd0Ju?=
 =?utf-8?B?L0ZpZUZYNE8wWDQvdFU5T0NST3dhS2FPSXVFa0dJZDU0VFZ1UjM5UDc3VTFv?=
 =?utf-8?B?OE9JTzRPSHpZdjc2NkxSZFdYc1Z5TUlFV0JpN2ZCQUlMWDViN3BBRHZ6MGQy?=
 =?utf-8?B?dmV1ekFLdEZOY3lSMkNKTWc3MFo3RTdmY3ZzNzI0V29uUmwveEFyNmNxTitp?=
 =?utf-8?B?WXJmWC9ZK0x2clh4THhZS3BzZnFyaDNLbVFRcnZkTDk3WG1oeVd4TVo0cVlk?=
 =?utf-8?B?Z1JaMjRLZDlsOW52RnFkcGo2bnV0YWpIMHJZOHpuaXRiSFc3cnMzTFJKTU5n?=
 =?utf-8?B?M3ZQMnNiNzAvZTdkdVZYSjd4SXpVWWl0UzAwU2Q3ZkxSR3RtRW1KdGYwKzBa?=
 =?utf-8?B?V0Npb20vb05COHVWNGk4ZnA2M0E2a3Z1RkhaazNkNGhheWxPZ1kreHhwMmxu?=
 =?utf-8?B?enkvZWFMZ0t3UzBzcTB2aUNyUkFXVVhUR1pwZHVzbkRmNi8yMm8wTHQrS2hi?=
 =?utf-8?B?dGlwZmVrcVFFSkJVSVNtZmxPdVZvZFZSRHBJc3NQS3FMVWliU3l6dThlT3g2?=
 =?utf-8?B?cUFpRE1wTHJzZGhFNFlOY1pYOWh0Ny9oSmRaWkJITVdQM1BJdVVIVWNnclhI?=
 =?utf-8?B?NUlHZHpUeUU4aGtyTUJrRUFvakhNTG9xekV0RmcvbUxraFpOdWdLMjRTT0F0?=
 =?utf-8?Q?uIAC40WeDp0Fc?=
X-OriginatorOrg: sct-15-20-9412-4-msonline-outlook-5f51e.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: c25f45af-e3c6-4653-32d0-08de67ec5370
X-MS-Exchange-CrossTenant-AuthSource: SI2PR01MB4393.apcprd01.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2026 15:03:04.7430
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR01MB4945

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
the "config_acs = " boot parameter.

Signed-off-by: Wei Wang <wei.w.wang@hotmail.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
---
 .../admin-guide/kernel-parameters.txt         | 23 +++++++++++++------
 drivers/pci/pci.c                             | 13 ++++++++++-
 include/uapi/linux/pci_regs.h                 |  7 ++++++
 3 files changed, 35 insertions(+), 8 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 7cfbf1102152..fd895716b07d 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -5301,13 +5301,22 @@ Kernel parameters
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
index d2810eb97bda..1714e29ce099 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -942,7 +942,10 @@ static void __pci_config_acs(struct pci_dev *dev, struct pci_acs *caps,
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
@@ -1002,6 +1005,14 @@ static void pci_std_enable_acs(struct pci_dev *dev, struct pci_acs *caps)
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
index ec1c54b5a310..593ef522d2ba 100644
--- a/include/uapi/linux/pci_regs.h
+++ b/include/uapi/linux/pci_regs.h
@@ -1016,6 +1016,7 @@
 
 /* Access Control Service */
 #define PCI_ACS_CAP		0x04	/* ACS Capability Register */
+#define  PCI_ACS_ECAP		0x0080  /* ACS Enhanced Capability */
 #define  PCI_ACS_SV		0x0001	/* Source Validation */
 #define  PCI_ACS_TB		0x0002	/* Translation Blocking */
 #define  PCI_ACS_RR		0x0004	/* P2P Request Redirect */
@@ -1023,6 +1024,12 @@
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

