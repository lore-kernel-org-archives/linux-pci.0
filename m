Received: from OS8PR02CU002.outbound.protection.outlook.com (mail-japanwestazolkn19012048.outbound.protection.outlook.com [52.103.66.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 843D648C8C7;
	Wed,  6 May 2026 14:10:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.66.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778076658; cv=fail; b=EBNxjxduH482qpsRYF+DNe2jY64MKrxPb9LucsHabWmTDXJnhrVg/AdzJ9UnF204t7+oI9tLGrwLaUCi4cfEUU/RfXr4JkZfdojPj7NOmnfdU/VUPbRR5Q1AQgI6k5g38CQd+XIRiD0JE9QUr7sf2lKsLBTe4J/AEu0SciUm4q4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778076658; c=relaxed/simple;
	bh=bbaTuCAt7tLG36b0ZSHmBjLBW05brYzRcOBl/V9Dt2o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=SmD0y7gQfP5Zf/DczD32dosNTLzTSXpGLHRlQCSq/Y+S3jp+0hFLur+UKqIu/JYvhzArxdoT6oK1pPNa4NsqCh7t9eUqAvUYVSAWQbVPTTcHhVLtCCPhitPaw4D/cWUlL1VMTlnG6G9gv+YbvnlUSzsfnnMvPkhVCono3eSRjdI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com; spf=pass smtp.mailfrom=hotmail.com; dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b=lh+kYc38; arc=fail smtp.client-ip=52.103.66.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b="lh+kYc38"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=h39T/93nng0WcIZUP+35l9zplAX+tmYDOsKLMZXZv62S6ilVUOWTZb8qabQr9ZX8gGve9mnqMbGbZZo8z604m9DwGn5QHP2JkI7He3sdXTy9KfdHfi9nmOvAS4vTbM9J/iL/DcdSM7sop7HqX4/2WY7ADbry3DXIWluroW0FulzjPuqDns74yAKjiptjl4JhVrNM5nLEfghviQPVR2v+BUWMKYsD3bbP72A5ZoWkACC+Sj584clPeUYawoif6M+uHo691pwGodHtenTwiROyabPhqtggl9t16+d3yo4IlAoy6kyfXgdXOZI3MBm1vWK2kZ6afSAJ7MZLoaUAaIRjyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a+65zYWLcQQepW93pkD6ogep43Q+jGNJmLgwn3UEtoU=;
 b=S+/qL6mDugmMGo9zCN7xmxV6cjF7SqwGwr3UUeFuTdQneMXAGB0CPZgskEN41vybvhH8VHZYUIJbpzFGlqo9SnKW7Lft6Na4yv/BDzi4yTBQyugBiX2XfDH4d0e6wWkdzXPbIEjSIzHO6n/HegdLgSTJoSeEDnObl0COVuxy6q5qQxM1BnJ1oOM0FqPOmdIPbIe0XuDnuRBH0P45T4A3lkCoZDxCTBLe0xjnd+79fxZi0zi8Bcih7rMJj5qPoiffmOCRp3D75kdz5nJbx9czxKd3RLn8wuowyCOJnFNJ6e8kz2XVNgpH0iJ8HV6KYlroQ6HMFh5SeSGoOmHBgcSabQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a+65zYWLcQQepW93pkD6ogep43Q+jGNJmLgwn3UEtoU=;
 b=lh+kYc38CrSpIsQIfNgO7vxGm1PJ35uRB2u86+qA7wjaErhfsrP8omYO3GCr5nHv96AkqM62KwH3oKbfxd0syK7FZVI0Mi2/AfE0W+uXk/KTSpsBh8A5+lhLJYrEG2Tw9imZ/Yy2j0xpfKa8JqYVRGGkY8t65dM9AUGPFE19AGl3QQD+ONBOG5Qds1o7ZYfXDm5YmMjZ80yK2/QzfC7m2CrZuOmxbVTBC4vBazOmwpXrQI/NNCOmKC71ET7l2SsJLH0OdTffq08h3xQXSTwsyGIXRKr+WVGaroepC7CSaJIYbZHb06lRBYIeLnmrjI5/NjBHGgv8KY9dILrc9xDrBw==
Received: from SI2PR01MB4393.apcprd01.prod.exchangelabs.com
 (2603:1096:4:1b0::7) by SEZPR01MB4454.apcprd01.prod.exchangelabs.com
 (2603:1096:101:70::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.17; Wed, 6 May
 2026 14:10:53 +0000
Received: from SI2PR01MB4393.apcprd01.prod.exchangelabs.com
 ([fe80::c735:fab8:6e3d:6d1c]) by SI2PR01MB4393.apcprd01.prod.exchangelabs.com
 ([fe80::c735:fab8:6e3d:6d1c%4]) with mapi id 15.20.9891.008; Wed, 6 May 2026
 14:10:53 +0000
From: Wei Wang <wei.w.wang@hotmail.com>
To: bhelgaas@google.com,
	jgg@nvidia.com,
	jonathan.cameron@huawei.com,
	dan.carpenter@linaro.org,
	akpm@linux-foundation.org,
	bp@alien8.de,
	rdunlap@infradead.org,
	alex@shazbot.org,
	kevin.tian@intel.com,
	manivannan.sadhasivam@oss.qualcomm.com
Cc: linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	wei.w.wang@hotmail.com
Subject: [PATCH v7 2/6] Documentation/kernel-parameters: Add multi-device config_acs example
Date: Wed,  6 May 2026 22:10:30 +0800
Message-ID:
 <SI2PR01MB439372F20062A8C25599FE43DC3F2@SI2PR01MB4393.apcprd01.prod.exchangelabs.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <SI2PR01MB439385689A32A1DDA9CEABE1DC3F2@SI2PR01MB4393.apcprd01.prod.exchangelabs.com>
References: <SI2PR01MB439385689A32A1DDA9CEABE1DC3F2@SI2PR01MB4393.apcprd01.prod.exchangelabs.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: TY4PR01CA0004.jpnprd01.prod.outlook.com
 (2603:1096:405:26e::16) To SI2PR01MB4393.apcprd01.prod.exchangelabs.com
 (2603:1096:4:1b0::7)
X-Microsoft-Original-Message-ID:
 <20260506141034.1738541-3-wei.w.wang@hotmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SI2PR01MB4393:EE_|SEZPR01MB4454:EE_
X-MS-Office365-Filtering-Correlation-Id: dcaa06c1-cc05-4c94-ce7d-08deab79488d
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|41001999006|8060799015|23021999003|5072599009|6090799003|19110799012|7042599007|15080799012|51005399006|461199028|45011099003|37011999003|3412199025|440099028|40105399003|1710799026;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dXo1bkNnZ29QQ05IVFZwQnpIcjRSS0lQbE5FMTV2VzJUTVJIeC9ScHpwaThV?=
 =?utf-8?B?NTQrWWREM1Z2eEVMaE1yK0pTWmdkTVJ4eml6cDkrQ2ZwTGpZTTFxQitTSzN4?=
 =?utf-8?B?VGw1RlpvWW96eUdZVTVDNGRxMFU3Tm9uYzFIUGwxTCtTSlZva3ZSL2Q0bzRo?=
 =?utf-8?B?dmxDTklQSDhJazFmOGFMZy80NERZL0ZuTDFYb3VBZFpEWkRqbW9tVzJHL09k?=
 =?utf-8?B?djNvUnNWU2pSQ1RhLzB6ZDFtakRGU1YzZlQ5VHhGeTBJMkNBS1ZLVkN6aUdR?=
 =?utf-8?B?M091T1JZTDUxOERUdVBHb2VmaXdhV3lmZURJQU1uVGtTVXh4OWFEbWVnZE91?=
 =?utf-8?B?ejVtdWpZejdEZFBpeS94Rm1veDFRck9zRmxxV1ZaYVlzN2tkd2laRlpybDJi?=
 =?utf-8?B?eVlrL0RXT0Uxb2d6RzBwNVJWTVVEcXZKRm5WbXYvOStMWksyTTYrcTFzR2lO?=
 =?utf-8?B?UkQ0R2xIOUtFblRCL2hsY3lubUd2eHpNbThLUzlycW5KcWNsTHY4Rlc0NUFQ?=
 =?utf-8?B?Uk1QRlI1VkRHejM0ZFozTmhiL0Jrb2dUYUpiOHZaMTN3RmswYytnK2ljTjJT?=
 =?utf-8?B?bkg2U01aMUJ4dVFFSGRGOUV4Q1NTOStWQlFnbWtmVzMzWkJTMmgzdTdjdTJJ?=
 =?utf-8?B?eVMvTFlOaXJvdy82cXhZZTF2ZGVDUmtGT1pnUEF1R25aeU9YWlVPbkxPZmsw?=
 =?utf-8?B?TWhCWUhPWUV2SHYxdEhTMTIxaWlIckNDRTJOR0tmQk1DOGJyczZJV1lxZ0lh?=
 =?utf-8?B?cFU5V21DQy8zVTBBK3VYUUl2YU44aDB2bFlockhTK2RWUUczY2c0UHFzdFhM?=
 =?utf-8?B?dG9ac0YxV3VkOGNJbE85RzZRb2dEZ2twdmo0MHB5d3R6bityaXJMN21sZXVw?=
 =?utf-8?B?cXE1S0RiUGFBeGZzYkNPTStEb2N1QzZrMTFwQkU4OTlmRVRleGhJc3NNemlS?=
 =?utf-8?B?ZWMwVDBncEZET3VCaW9VRnJsOG9CbGxEeW5lQXVJazRKc0F5MFd4MUFiSDRI?=
 =?utf-8?B?UXVWWEVaR2tYYVNZbExIMTFOQktrNGE2czZQSnhWcXZrNG9zdCt0MmQxdFE4?=
 =?utf-8?B?QVVMMmIvK0paTGNKSGVFZG5BZjdBV3JpYVdtZEZJV29pMDkwMS94NFdOdEVu?=
 =?utf-8?B?OGo0L2wzNEtHSDlKbFozMkZSUGtValJiRXhtK3RHS1RTNmgzaGx2bGI1cW9m?=
 =?utf-8?B?SWVLek1sd1NmYjRtUjdVZ2oxWkR3SXJ1NU4vTlljbFc4RHo3ayttblVVdUJB?=
 =?utf-8?B?UmxzRG9SelNNaE9QcWVxYjA3SmNyVFB4bHhXVnFOVGNpbEN2Z1U3Qk9xRmJ6?=
 =?utf-8?B?alFCT0oxVDB0MktSTjk3ekxDb3lzekpwRC9hMERraEtwNm9DRlJGemw5Tkds?=
 =?utf-8?B?RC9JeWxsSUtDbjVRYWxNd1dYUFBWdmpjUWJQam5CMmxEeHRhODNrR2xNUFJy?=
 =?utf-8?B?NFJFWWI0WUpYRE9HTTE1K0pDYXhMOWM2TElHS1RBPT0=?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UmFzVzFYLzN4aXJqMzRBQU0zdFpEY1ZCV2E5V0lmdXNvLytVb1lBVS8xZEJq?=
 =?utf-8?B?eW9iV2xITjFhMXJrdFVndVduaUxHSlFNdERTRzFQYXh3RWlhNVNXNzhFVXk4?=
 =?utf-8?B?c0NYTWE5czc3ZkQ0TmxrWHlyQmFVQW1aSDhBelduckJMdWJSaGdNampsWU9V?=
 =?utf-8?B?N2hQZy9VRjkzeWFVcXdFWUZNdXdIWGk4ZjREcjJDWXgrWFBnQ0JiU1llam1i?=
 =?utf-8?B?NThheGhHMWVYS0xnRmlheFhKamx2NnZmKzlSTTVudVZwaFErcWt3T2gxS3d0?=
 =?utf-8?B?bVRBNXpIWHBrcWNFMHhwaXoydXg1NC9CRTkwQXNkcmRybWd5cFhIbERLNUhs?=
 =?utf-8?B?Z203bHpaSytNajc4OE5IT1RNbWQyQVJPbm1NNkppSjhoQnMzbVg3dHJ2Q2Jl?=
 =?utf-8?B?aHBKc1ZZTisxYWFrSTdaZ0o0anQ5R2RtU3hraDRoNWs4Rmd0VW8yNkR5N0R5?=
 =?utf-8?B?aDNxTTJPd1ZHVm9uNjFFcnV5Y2FZQlcwOFBkOXErempxSGJleGQ2WE1UYmJu?=
 =?utf-8?B?T2hzQk1QQ002NHU2Rjc4d1lhYXQzd2RlMTVwejBXdWxYNGVKVnJsSVdZbXFD?=
 =?utf-8?B?a3cyNVlHaEFBUW1Lc0l2SmQvdEZ2cFBhT3FYQ1pyTVJmT2ExM2dkMTI4Yk8w?=
 =?utf-8?B?OWxnaUlQckg4N214WjdEajg4K0F2dnREVUZIcGdEcVNZN01rTThmamI2MFhz?=
 =?utf-8?B?bWNKQUdwQk42b2pDV3RrcnUwMTlxbEpHa0FuNmZIOTloUVJjVFRKdy9WNXFq?=
 =?utf-8?B?TDJibThJZUZTeCtveVdQcTRDMFNJL05vSEd0V3B3aEFlVWUreTV0UkhRK3hY?=
 =?utf-8?B?RUlHcWlyRFZrcm9kYnoxSGtyczNIUHMwU0p3eGVVekdCVUFmSitmbm5Nd2tB?=
 =?utf-8?B?ajNuOExheGtYQStsWktObSsxSWQ0RUVHUUpuMTBpdGtKQm1MQVp5QTk4NXhW?=
 =?utf-8?B?cnp3SVdOUURmZ2d0ckFnTGlZWFJTd1pMZGV5MDR4dThrRnFGcm42bk9wRVg1?=
 =?utf-8?B?Y2pCU3FxUkxJVUpsVXlpdVpCancybnh6L2dNNDRaSWV0R1lXZDhwaTJuWXZr?=
 =?utf-8?B?VWZoczEvMkxaN1cvS2Q5ektmWHJ0Y2FIbUZxQWxhcTB0M2N2aTVVSWRtSW85?=
 =?utf-8?B?dHpVMWRTREV4YW15MUNiYkEyTGZyYWlyTWVNT3Y2ektjNWI4YktUTTcwa3Ez?=
 =?utf-8?B?NER6cVJQVUF0dC9UU2h6bGJNWm5FRFNiQnpQT2ErRmRHNW1tUDVwejNldUdr?=
 =?utf-8?B?ai9zamJzZ1ZKM2x3QzhpMlMyMTF4K0V3ZW5DNHNtTTZ3Znlsc0J5a3VzYXZS?=
 =?utf-8?B?cWFPQzJSbFpDbS9NSWF4Rk93eTBKTUsreWVSbUpBQkVFUmwvTGY3azV5ZzZ1?=
 =?utf-8?B?bTc5MGQwdDJVR1BnVE1HVExhM3ZMVWdQVWlmWU56WmxLZVVUdEhZdzJkTW4r?=
 =?utf-8?B?cUM2elh0V0pMNkt4Q0RCMy9ZOEF2ZFE2dmlCNmtJNjJ3WUpHRWlROVhGejFQ?=
 =?utf-8?B?NHhYQUo5U2JaL3FMMURSVFBJZk9vSTFWMktKNEJjMnVKcXBmRVNpL2xvdDFM?=
 =?utf-8?B?ZUg0ZE5YaGQ3d1VUSHBsaDlsWjA2UXBKR0J2aHRMcGNXSlNodXhuQkJnV1Vo?=
 =?utf-8?B?bnFCczBxUjgvYmxmTytwK0F5eUlPazNiUnBaRDAwMzA5K21CeHFiN0FJbnVF?=
 =?utf-8?B?eXYvaGUvUWpCYnBXUGhNc2ZOYjRLcVRkejcwYVV0dko5Q2Q3MjlHTE9lcU1N?=
 =?utf-8?B?cDVTUWNiOXdyODhIQWVtL3VJZXNwa2FIVmx3alovNnJmOXRWaFg5aXZvT3hz?=
 =?utf-8?B?ZDNuMG1vd2hZZ0dIUmkvZkVWOERVRW8wODRKM2hVMFNUMjkybmlsUXFqWkNS?=
 =?utf-8?Q?sZhq3m7OwZJWC?=
X-OriginatorOrg: sct-15-20-9412-4-msonline-outlook-3e488.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: dcaa06c1-cc05-4c94-ce7d-08deab79488d
X-MS-Exchange-CrossTenant-AuthSource: SI2PR01MB4393.apcprd01.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2026 14:10:53.4946
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR01MB4454

The config_acs parameter allows configuring ACS settings for multiple PCI
devices by separating entries with semicolons. The current documentation
only illustrates applying one configuration pattern to all devices, but
does not show how to specify multiple devices with different ACS settings
in a single parameter. Add an example demonstrating multi-device usage
with distinct ACS configurations.

Some bootloaders interpret ';' as a command separator, which can cause
the parameter to be split as multiple commands. Document that the entire
parameter may need to be quoted to avoid bootloader parsing issues. This
avoids confusing bootloader errors such as ‘can't find command <BDF>’
when passing multiple device entries.

Signed-off-by: Wei Wang <wei.w.wang@hotmail.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
---
 Documentation/admin-guide/kernel-parameters.txt | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 170aae226e2e..0c159ab59e14 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -5277,15 +5277,20 @@ Kernel parameters
 				  '1' – force enabled
 				  'x' – unchanged
 				For example,
-				  pci=config_acs=10x@pci:0:0
+				- pci=config_acs=10x@pci:0:0
 				would configure all devices that support
 				ACS to enable P2P Request Redirect, disable
 				Translation Blocking, and leave Source
 				Validation unchanged from whatever power-up
 				or firmware set it to.
-
 				Note: this may remove isolation between devices
 				and may put more devices in an IOMMU group.
+				- 'pci=config_acs=10x@0000:04:00.0;1x101@0000:84:00.0'
+				configures two devices with different ACS settings.
+				Note: Some bootloaders interpret ';' as a command
+				separator. If so, quote the entire parameter to
+				ensure it is passed to the kernel unchanged.
+
 		force_floating	[S390] Force usage of floating interrupts.
 		nomio		[S390] Do not use MIO instructions.
 		norid		[S390] ignore the RID field and force use of
-- 
2.51.0

