Received: from OS8PR02CU002.outbound.protection.outlook.com (mail-japanwestazolkn19012063.outbound.protection.outlook.com [52.103.66.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FE8F2C08AC;
	Mon, 16 Feb 2026 02:27:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.66.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771208850; cv=fail; b=fsQ3DUZe1PJxIySrWcz0JM9N79lsMHrT1SY8mj9R90UhviebShyp3wR24zl4A4r0C2zH2wzTW9bKyignb9fZ3AV+MUJZQ8UhLFBSEP5L3NbqfC4QpFYcoN3BM4SXH9Oc2ZvAiUF+lbCV4p+H7h9KMrA4ObBePJYKh342wh8Ci38=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771208850; c=relaxed/simple;
	bh=KcYco5FyyhZ6GfntI3ZHYfCvLEC1jPl1ptoVgVI6itQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ImnT2lnXnkYm52fXmiiwc98+Rr2me7+uq/6QOL1YPte5wjTrmG5gA7lBjOV1sfqy1VR24X2bTaheH+frFzukgzIaoa3VkniSLsfidbMbVIMPr3BMfzCFv0PEew/QZQ63ph0r/5OpXvUETBu3Nfq8Ai7stkz/2agO/8TCZlUFLYw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com; spf=pass smtp.mailfrom=hotmail.com; dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b=Gpx/W8Y2; arc=fail smtp.client-ip=52.103.66.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b="Gpx/W8Y2"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FWE6GqmjwiHhycu3tE+wSzQK0UmXiTFgrlQ1ccuMJkh/496QoAXh7XrbJPsj/IvXCbUEtp9JEKR628wC4zFlY3gSyYbXWOwKDyPW+qAmw3yyf/8HA6bW5QtZcc3IYHIa7l66IBrlCtg+0orgwvbGkoKQ8+Mwa+0WG8ZIUxn3xwP/SeOuQR4yP8KAN2gPYj4P2pOOAz2M9P177PGysjOOjJUxEdqM1GiErdVTsGWjjF3aJt7Y2KcshXqZ0AudtRj+bdFpeIRC2NrOQ7NaX8kqwxObjmVRHIHfSCsdUE2JMI05aGnpfThxgK7j0INusWYzyaJXIVXZ21eyYNhnGROJHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DMHBdzedRi2jcd25MbiZz5f91uLxmhRxn9metCerQGY=;
 b=IrRZEnrCOh/EdrYW9g37PaWSKaVah5XJoC9u/pCi0Zd1c+dcxe7sSSEoZeuM/xMEYuvXPM+aGnPKq3N6+BTAyagL9nU+9ALbbG0TXu6j5HK5ebqm4TuoSQ3ovy/tMnyNfj1sGYk2uDMtNewwxlF/1CD+n5/JuTWIAqPTEWrhRgq7NyRH6DAieScyvTJ0780VvJ+HL/J59zVLeGRHvFApayiBf00Lovjt9NBGwUXt8Q1n7QleuP5hOOLyJYH/3tYDjRkMH9HTtPyVdidKbv03RKwKIBgvvLDhJWBzSqB2kkWH6VSWItC3jkX2wmQuUBU/ohelPGNs/CUJzhGaGB7mnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DMHBdzedRi2jcd25MbiZz5f91uLxmhRxn9metCerQGY=;
 b=Gpx/W8Y2QhfUeAcUpHAN0E0TmA4Q3fkiP7TywljYqddyxbKiHDGV9XS0WUFnjOHyAsUbjQfkDv0KbRQoO/zpc2+CDaSUFWp/o2a2EW1Tv/uXmVaIit4SGlTCyzdugG3Fgy7o9g7/3WHYNT8kVLOFBCamldO1j82QbvDMKhZJMLiToZASNGlZvGMvQvWLVqCCQYZiNWvzPFlZVBBObs0HMbXaGBmvnnHHg5O+G7gxkMmcX2b3Y7nIuKyGzSqKeSNfOtRYPQY6pIrwvzmeYJHcH6H/4+TPoYI+VO+hDhC4dOFfJhWoztI7GHjQgBcLZbmuzU6IbfWe+K0OzDlN0hLPaA==
Received: from SI2PR01MB4393.apcprd01.prod.exchangelabs.com
 (2603:1096:4:1b0::7) by SEYPR01MB5340.apcprd01.prod.exchangelabs.com
 (2603:1096:101:d2::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.16; Mon, 16 Feb
 2026 02:27:24 +0000
Received: from SI2PR01MB4393.apcprd01.prod.exchangelabs.com
 ([fe80::c735:fab8:6e3d:6d1c]) by SI2PR01MB4393.apcprd01.prod.exchangelabs.com
 ([fe80::c735:fab8:6e3d:6d1c%4]) with mapi id 15.20.9611.012; Mon, 16 Feb 2026
 02:27:24 +0000
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
Subject: [PATCH v5 5/6] PCI: Enable the enhanced ACS controls introduced by PCI_ACS_ECAP
Date: Mon, 16 Feb 2026 10:26:41 +0800
Message-ID:
 <SI2PR01MB43934A39792A32D5058876E5DC6CA@SI2PR01MB4393.apcprd01.prod.exchangelabs.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <SI2PR01MB439326AF08A79D1C5661C29BDC6CA@SI2PR01MB4393.apcprd01.prod.exchangelabs.com>
References: <SI2PR01MB439326AF08A79D1C5661C29BDC6CA@SI2PR01MB4393.apcprd01.prod.exchangelabs.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: TY4P301CA0029.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:2be::12) To SI2PR01MB4393.apcprd01.prod.exchangelabs.com
 (2603:1096:4:1b0::7)
X-Microsoft-Original-Message-ID:
 <20260216022642.112923-6-wei.w.wang@hotmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SI2PR01MB4393:EE_|SEYPR01MB5340:EE_
X-MS-Office365-Filtering-Correlation-Id: 51494b6f-ff5d-4f33-9f53-08de6d02eb92
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|51005399006|6090799003|5072599009|461199028|41001999006|8060799015|19110799012|37102599003|15080799012|23021999003|12121999013|3412199025|440099028|40105399003|1710799026;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?N1dKL3lqREp3Y2d5RVl0NlNCQ0JjNHBlUG1oTzNhQjBaWGZ2cys0cmE5WW1P?=
 =?utf-8?B?bnNZK2lkcE10Y2NmeTRpdUNtMEtrb04yY3JrditKWVRLR2w3QVhiSGtRS2dn?=
 =?utf-8?B?QjBxajJma21qQXRwUTRFS1dFd3c3bUxCUkhaalVWMmUxSWc1eVVKYTlPK09Q?=
 =?utf-8?B?cW1RQTNJWlA1cWIzNjl4VUhwQ2xzNXRpYWwzdHZUYU9UdGNzaFJkbm03WXVo?=
 =?utf-8?B?Qk9rNG9obEliblZ0NzVBeHpvUGNXbE43NHcvVHV2VWJVWmZub1hTVEpOVjU1?=
 =?utf-8?B?clpXbEZFd29udXlSeXJJUG90MEhnSHhtcU83QUlpRFdpUER5RGlWaW9XWEx6?=
 =?utf-8?B?ekswYjM5Z2xkUFFxU3N2djVRODhmN2thWG1zQUZ1bTBYSGRjYUlBOHRmRC9r?=
 =?utf-8?B?QjRXNHJ5R1R2eFdXWFNXaWtKeGtEOWRNbnJvTGtVK3RZUTZnUnhjY0JRbFk1?=
 =?utf-8?B?bFFGNU5QbDVzVmhFVTNXbmdOUHd1QlIzRUphYjJjelp5REZDdHRrcllsa3Zz?=
 =?utf-8?B?OFhXdmJsbTdKaEpEdkpxMTlvZ3Zpa0RQTm1VZXI1dWpHVzFpODU4d2pjNDl4?=
 =?utf-8?B?bDY4SC9yL284eDlIVXlXalVHWTdxODQ1WmxmeHV6TzRNcy8xcjNDQ0V5MWln?=
 =?utf-8?B?MjNhR2xzTHBpZWlJQjNmOXpQNHo3NUVsZjc1K1k1QWJybk1oL1dFUmx2Mnhn?=
 =?utf-8?B?c2tWWkw5WHYrckpmanJVcTlROCt5akxJaFpMR2NJQlZkWmhtUFRUZnZBbkor?=
 =?utf-8?B?NllINlN6SDF3bUZld1JiR0cxbTBhRmR4aDFQOG9hOG94TXhMSWxSdUdzdUJC?=
 =?utf-8?B?bkdvbHZ1d3h4S0pESzBBbWtCL1hlQTZUY0JuMGltMXpkNDJETmZERUJNMGVj?=
 =?utf-8?B?SmNsUGxKWm5tRHJOVmRiZzYxZXZqcXVzK2xhUU42bWdEemVwS1h0VXlaSTRo?=
 =?utf-8?B?SlA2QU0yVVFsaUwyZ3VUYmc1Ull0UGZKdEtIbkV0eGVXbi9RcTYrQVBnV2tM?=
 =?utf-8?B?SnVpdytBN1k5OFk5TGtLWnBmVlVPT29BdWN6M2xrZlpYdW16Ui9MWVVKb0kv?=
 =?utf-8?B?SkZqVXNZYzROVGFTQ3lpcXVwTVVaQTJwRi9QZEYwd2tJV3l0ZS9yc3d4dHdu?=
 =?utf-8?B?VVpkWGZyWlo4RG1RcEF1N3FOSEU4Y1BkMkdzckROZU5Wd3NyNW00UGswQVZU?=
 =?utf-8?B?T2tFTW12OGhhZGpVOHlMUFg0ZzZxb0c1empDcExwNXRxc0pLREdzc21DU09s?=
 =?utf-8?B?c2N6ckdncDZWZU5oMVdCMVdUbUg1MjNCb0QvLy80djJGNnRPYTRVY0lCRmVx?=
 =?utf-8?B?SXRFdVVKZm1FQWdIUnZSS2IrMm80M012QjFGa2xWYTNjY0pSUmNUcjQ3UlhY?=
 =?utf-8?B?NHZqVXFYL1VaWVRBOHRsZDlQOVI2dUUvSkoyZDgzZmN5QW9XeGovUDFTL25h?=
 =?utf-8?B?RU1KeWlra2NpMmszRlRHVnpMNkdmUkFHbzZsVUQzdXNubVI4bWtjNDh5Y1JL?=
 =?utf-8?B?UlA2dFhFd3ZCbXh0R1V6a05rdTZSbmxTK1llczlYeFpYMGpzTWxZc2F0V0dq?=
 =?utf-8?B?RXMvREtDem03ODJyTEkxOUdtUFlrbk53NlVBZkhLdnJ3cHpjeTFTUXlhWVJQ?=
 =?utf-8?B?MjhyazN0ZHVudW5PR1dCMk9LNG5xMzhmbFhBUjd6TjY0YldPVlRXTklPVnpx?=
 =?utf-8?B?b0FnOU9EVGxZUlpGVUR3dW95Mit1MWZuYkJYbHVwcEgxVjEzTXdNdGZJdCtN?=
 =?utf-8?B?U0laZFhQa0p2b1Aza25tU2x5eWQ4ZlB5SlIyaWNxNlE4Umo1TmNmQTY0aHNv?=
 =?utf-8?B?WE9zOEtmb1JHQ01RZTdzUT09?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?V3YzUWhOSkVnY2hXeFFhVkE0a1d0TTFFNnpLbWJDSHViWGF1K1F4dWVtRVpp?=
 =?utf-8?B?eStxckVPR0RjZ0RHb1dmcFREdWl3K09peFNEVW9hcHpSZmM3OFVIdUUzZElI?=
 =?utf-8?B?YnlQaHpSTGRNdHhpSTV5b0tRajlXTEo2THYvSWV1NnhFTHVZcFBmbkQ2OS9K?=
 =?utf-8?B?TlZvYXlaNU1nTE1mRjgweHB0Wjc3bjBSalF5bzNrOUt1MnJTcUludkVhY1Q1?=
 =?utf-8?B?VnJaTFRjemFweFpLNEZVbUFEeEhNcXdIRngzLzRYeGRFbkR4QUdRV1hoLyt6?=
 =?utf-8?B?Q1J2bEFRdlRCYkxhM0FwS3FFckVGRC8zeW9GblZRRk4xVThLcjBMRlJSbUo4?=
 =?utf-8?B?TGgzZlBhd1BNVjAxVnBzanQzU2tCRWFjY1RvQm84SUhqNzFRY3ZDTGxnTjZL?=
 =?utf-8?B?WitvMkZDRkRCSjZHNVBZU2hCdHJKVUs3OFVHYms1c3Vzbi81cGR0cEY2UEtR?=
 =?utf-8?B?MjdBS3M5djE5SVZJNXVOdlVhd1BCVEdGYmUvMERYNlRSdEdSUkxhRzNIQmdU?=
 =?utf-8?B?c2o4anhVcm15TUNUcmROdnVOZU44VmI5Y3NKRU1ZeEw0QjUyQUlINjlBSmd3?=
 =?utf-8?B?RzJCMDVFMG1VbXBDd3ZmTENidEd2b3ZqbUdMSDhhNGc4MUhsazZWL1V3U3Rh?=
 =?utf-8?B?M3NwQjZXY0FJR0ozWlBHWXE1bXFGMkFvKytod2UvV0srSzVjQ0tpZkwxSHBr?=
 =?utf-8?B?Q2tyditKcTBhMnVEck5teFpUTDcrdlhha3ZoMjQyNmx1NDNuZXZOMkJzTUc4?=
 =?utf-8?B?VE5DNUhxNjhJSnFaUFd3UjNwU0xwTzNOR2VxMXR4aUtPM1hLQ0RPc0c2U3RY?=
 =?utf-8?B?eGcxTkxiVy9QOVBMSVIwTkw3Sjk1TUl3NnMzc0hxdnU0U05MeUdoNUxZZGI3?=
 =?utf-8?B?ZmM2eG1iaVN1U0xJbmFsTWVXczdlMzNzUmxDc2dQZmRPNGNzT1U5R055ek8w?=
 =?utf-8?B?SVZIWVh3VjQzeEVhTCtlWmRGeWJ5eFo5djY1NFhHdmJva2I5OXlzcmtVK3Ur?=
 =?utf-8?B?cUZWeTRpRDZnVndwSHRtSml3MXpRUDB5ZkpzbnZRNjFGME5KbHBpd0swNnN6?=
 =?utf-8?B?QnJRMktDc2FDYmJ0NEwzRXJIYUNNdmR2eWc3N28rc05aMVlkdmZQdjBVRXdt?=
 =?utf-8?B?MFpKSFJNWmd0SWVqeWdGY1VpU0g4VnE1WjdQZXBJZlhmQm03NTRtUlE0K0F2?=
 =?utf-8?B?QjlZY0Y0cEdJamVIR21IZ1hxZmNlL1FUQ3hESVFXQkpSc3Q0aEJoOWRKajVM?=
 =?utf-8?B?bnliWUx2STZwN09DV2dNVjFVOC9TS21Xc2F3cHp5QTRSc2VVVDVDSjVlZS9Q?=
 =?utf-8?B?QnJhSUlTcXlqK2xiejBIVWZOS3dTNzFmN2U2NmhtZnB4d3A0WGRMUU1tY3lu?=
 =?utf-8?B?REU2dTV0VHR0czdxbHppMGdiMG5yY1haVmE2aFRSMTFYYnl4OVdiWEJTcERL?=
 =?utf-8?B?NEt4d2M5Q3NkR2Vmazk1Q0w3YnBoY1BxZjdQUHpHM3JlNmJmOStQWjhodzdj?=
 =?utf-8?B?WVRLMncvUG1HTGRqdDdEemgvYk02ZTdUMTV0SlF6REorZ0FnMnRDNU5hUkgr?=
 =?utf-8?B?clk3K29DYy9FNjB3WEdHelhEblFXandTL3dFZGhndENIc1JBdTRxbEVyUlho?=
 =?utf-8?B?am1WOGRXSE92Vmpscll6WTl0NGd2Sk9Na2MzMHo1bW1QbWlkVmZML0w0dlFG?=
 =?utf-8?B?MUsrRzBkVC9LNTRtTXpSL3BQNDFyUmhwWklnc3A2akpoNWFOMVBRN2hEd3NY?=
 =?utf-8?B?cnFSSDcybC9PY2tDM082YlFZaStyWlpZek12dGNTQXdSSklQV1ZrcnFtZy90?=
 =?utf-8?B?ay9ZYVhmQ0syZTNTb1JCWGtSb3RrZnFYMWxuVmZpci90aENBSkxKd3lwZ0xC?=
 =?utf-8?Q?FIIwmoxyWbEU7?=
X-OriginatorOrg: sct-15-20-9412-4-msonline-outlook-5f51e.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 51494b6f-ff5d-4f33-9f53-08de6d02eb92
X-MS-Exchange-CrossTenant-AuthSource: SI2PR01MB4393.apcprd01.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Feb 2026 02:27:24.6939
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR01MB5340

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
 .../admin-guide/kernel-parameters.txt         | 23 +++++++++++++------
 drivers/pci/pci.c                             | 10 ++++++++
 include/uapi/linux/pci_regs.h                 | 13 +++++++++++
 3 files changed, 39 insertions(+), 7 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index bfd13197658f..f8444fea9914 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -5281,13 +5281,22 @@ Kernel parameters
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
index 4b32fbbcacb6..c34780a5f886 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -1039,6 +1039,16 @@ static void pci_std_enable_acs(struct pci_dev *dev, struct pci_acs *caps)
 	/* Upstream Forwarding */
 	caps->ctrl |= (dev->acs_capabilities & PCI_ACS_UF);
 
+	/*
+	 * Redirect Unclaimed Request Redirect Control, I/O Request Blocking,
+	 * and Downstream and Upstream Port Memory Target Access Redirect.
+	 */
+	if (dev->acs_capabilities & PCI_ACS_ECAP) {
+		caps->ctrl |= PCI_ACS_URRC | PCI_ACS_IB;
+		FIELD_MODIFY(PCI_ACS_DMAC_MASK, &caps->ctrl, PCI_ACS_MAC_RR);
+		FIELD_MODIFY(PCI_ACS_UMAC_MASK, &caps->ctrl, PCI_ACS_MAC_RR);
+	}
+
 	/* Enable Translation Blocking for external devices and noats */
 	if (pci_ats_disabled() || dev->external_facing || dev->untrusted)
 		caps->ctrl |= (dev->acs_capabilities & PCI_ACS_TB);
diff --git a/include/uapi/linux/pci_regs.h b/include/uapi/linux/pci_regs.h
index ec1c54b5a310..dcff29eb839b 100644
--- a/include/uapi/linux/pci_regs.h
+++ b/include/uapi/linux/pci_regs.h
@@ -1016,6 +1016,7 @@
 
 /* Access Control Service */
 #define PCI_ACS_CAP		0x04	/* ACS Capability Register */
+#define  PCI_ACS_ECAP		0x0080  /* ACS Enhanced Capability */
 #define  PCI_ACS_SV		0x0001	/* Source Validation */
 #define  PCI_ACS_TB		0x0002	/* Translation Blocking */
 #define  PCI_ACS_RR		0x0004	/* P2P Request Redirect */
@@ -1023,10 +1024,22 @@
 #define  PCI_ACS_UF		0x0010	/* Upstream Forwarding */
 #define  PCI_ACS_EC		0x0020	/* P2P Egress Control */
 #define  PCI_ACS_DT		0x0040	/* Direct Translated P2P */
+#define  PCI_ACS_IB		0x0080	/* I/O Request Blocking */
+#define  PCI_ACS_DMAC_MASK	0x0300  /* DSP Memory Target Access Control */
+#define  PCI_ACS_UMAC_MASK	0x0C00  /* USP Memory Target Access Control */
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

