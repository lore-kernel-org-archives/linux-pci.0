Received: from TYDPR03CU002.outbound.protection.outlook.com (mail-japaneastazolkn19013085.outbound.protection.outlook.com [52.103.43.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AA8C49252E;
	Wed,  6 May 2026 14:11:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.43.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778076666; cv=fail; b=e1O+WLOjguKZzK/zAiL/kg3r5XFr/9ASE59204LJPy/TXUujHZJ379p9hZr3s5Uwvg+uByiv1FURZ5anguMbP3GHNdq4XLiLK2YotBAL75M2U7r5pVSQ1QNAKSnjYdHOs03aa4KzxoT4ESlnOoj+FLtGAnp0K1xhWM1ARiUzILs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778076666; c=relaxed/simple;
	bh=KywU6q6BjO3csQPLK13GS9pmoNlvD7XE2JtZwgNywX8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=PDflTUWGacWRUs4kCznSBdmQZZN1foB3Ao5rU7/mUWFuNyy3iXJpEd2w+feNNajMan3XooeVgu81io3kWMTkVWmaY9GH4BWvQrIoA168gNfiB0MTjky/wzfZqQAaI8aTC4vNjKwJi9j1PKD+pvLyXQI39sSDuYyjw16HcJEbq0s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com; spf=pass smtp.mailfrom=hotmail.com; dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b=Zljvw8ta; arc=fail smtp.client-ip=52.103.43.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b="Zljvw8ta"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GaxglKuViyAYTYNMgJOuaDL6XV8h4mwSS9XUT0m3k+os+P8rLlTagzLH75J10lcuhpSG7qy2aEWVxJp5MPs2ewU42cmXtq4wX6UskzqJ1V4ZZN/2O762JnEks0XSYPMhjZ2pCyrDEr7btzc7lXt6Efxz/tC9PqyLeBjDJwL+tIPqjdR7KsI6x4tnyzTzG8PPx+gnpyIhuQUaSvUJ1iPh/lOJ9YcAM1SxvhtF2GoToTSpa/igh8S78gO9PjE68bvSBXbQRK9SjxV53Vd9t3I85Kw5q5iAb3wi9cl/7N05qyurrNtIAzD6bvsx/cBP8YzaeAvZ2akjj6XHubhwkUT8gQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=10Pv+kZIbMRtyNLVhez1QAwQnJnnCVkQ6+XHwUfrLm8=;
 b=ctMngr/H6zZv75sMHjBBYK37LLlYx2x6GQtze/TwmiQX1a47QcQeWztLsl2eAy5hMYTdmo/1KkPOY/F76p6R5CF63MpE7wKKmanbKahIbD9nZMFNxASloQrR5xcyyYrr++shBzFvqxDW97ifzeRa+lPRyCu/3sLg+b1GxgjTo4dqwRVztmi9tJpdMoe+e0aQEX8QY7q1CblRMI34EmMr+mUBqWJgylo8TV5GRpDvPSyRCzc2cCnmeOlFlkGz6qM3wK+VqzMUF6c4teh/DwMNve1IenPVoq1q/gHpp3aSKqPQ5EfDbASVfkri6fGV5sMMLVN5HgkQ4mZOgVcEYwpJ/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=10Pv+kZIbMRtyNLVhez1QAwQnJnnCVkQ6+XHwUfrLm8=;
 b=Zljvw8tasD4kslE+VP4SLRd072dp1fNLK6PiVHqO1f/oa6UC/raTWhbzbkCCtfIP77riRWaDI6I4IMfsoJodZdXwhiZ7gIbwtvfZrmpwYb2Gz4ooUKULr6AMnEFU3cMf4qoXILWpjseO/KLrAf/iLykMdSuN0/DlH3YRoeiDvxg4b1OjSwhWj7SaWnaGCb3Hoh3BZd0VfAJlIJEdDDMglszSoGMs+uiKvglNCqIH2P5d7aw6j+rG0EtVcVGDAZDFBaQtR//Co1+xdAh62NRSZsXzkcRgfadTs8eLWcz007begGGWutmoDivVeG4Sk5dMDG5kXyXZo+6qA54DJopngg==
Received: from SI2PR01MB4393.apcprd01.prod.exchangelabs.com
 (2603:1096:4:1b0::7) by SEZPR01MB4454.apcprd01.prod.exchangelabs.com
 (2603:1096:101:70::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.17; Wed, 6 May
 2026 14:11:00 +0000
Received: from SI2PR01MB4393.apcprd01.prod.exchangelabs.com
 ([fe80::c735:fab8:6e3d:6d1c]) by SI2PR01MB4393.apcprd01.prod.exchangelabs.com
 ([fe80::c735:fab8:6e3d:6d1c%4]) with mapi id 15.20.9891.008; Wed, 6 May 2026
 14:11:00 +0000
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
Subject: [PATCH v7 5/6] PCI: Enable the enhanced ACS controls introduced by PCI_ACS_ECAP
Date: Wed,  6 May 2026 22:10:33 +0800
Message-ID:
 <SI2PR01MB4393F6FB65CF0A46E8E89B86DC3F2@SI2PR01MB4393.apcprd01.prod.exchangelabs.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <SI2PR01MB439385689A32A1DDA9CEABE1DC3F2@SI2PR01MB4393.apcprd01.prod.exchangelabs.com>
References: <SI2PR01MB439385689A32A1DDA9CEABE1DC3F2@SI2PR01MB4393.apcprd01.prod.exchangelabs.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: TY4PR01CA0004.jpnprd01.prod.outlook.com
 (2603:1096:405:26e::16) To SI2PR01MB4393.apcprd01.prod.exchangelabs.com
 (2603:1096:4:1b0::7)
X-Microsoft-Original-Message-ID:
 <20260506141034.1738541-6-wei.w.wang@hotmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SI2PR01MB4393:EE_|SEZPR01MB4454:EE_
X-MS-Office365-Filtering-Correlation-Id: c15e7194-6918-4655-b8e6-08deab794cec
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|41001999006|8060799015|23021999003|5072599009|6090799003|19110799012|7042599007|15080799012|51005399006|16051099003|12121999013|461199028|45011099003|37011999003|3412199025|440099028|40105399003|1710799026;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TitjeXVtSmY5ZitGUjJWbEZSTFNJdzI4L2hEZ3hEM3cvRFdnUFRCYWk2cnVS?=
 =?utf-8?B?V0VHdm9VcTVlVmdGRzZDZ0t0S3pESVdsZzd6NlIrSHp5bTlyUXQ0ZkpQUEF3?=
 =?utf-8?B?d3oyWnBYUHorcHkrZzJNdzhuRldXYTYrbXN2RElPWUxlTkZjMFhKTy9Zd2xN?=
 =?utf-8?B?LzhGU0Y4QTBUL2ltZmpqSEwxZEp4MkgrZ2VINGErQmpTVUJINXVHUlNpOU0x?=
 =?utf-8?B?OUowWWRIUmZ3aVZTOGpMTWkyRkJEN2lXMWh3MjlOdDhRZFdLYmtKaFYwczZS?=
 =?utf-8?B?K0pIdUd5Qkg2ZUJzOEpFSGNyRHNMelhPSS9ZeUlzc2dTRlNNMXB3QXFKdkJw?=
 =?utf-8?B?SFVkRGNJQlJWQW9aY1IvMVJKcFlubmJSUDNFVFZPY1VFb2JJM1duT2pEbFVT?=
 =?utf-8?B?bkZIM2ZaSXNJNHRUNmtnM1dXZG1EOE5nVCs5cGU3eGw5bS9wd0lFZVN6QWZm?=
 =?utf-8?B?TGxQVktDcWxVTDNlaWRkc1dKeEloZjVObkoyaWV2cTlEVjRVZlpZMVdQNmdZ?=
 =?utf-8?B?RGlyQTF1N1M2OFNiM3VSbzJyTnhIT2NrdENkMVRueDc3dVQ1V092Z01HSDBp?=
 =?utf-8?B?bzIrOWs5WEpvQmxRQkdLQy9lSXdtRTQ1N0pIRmdiUGtFQTFmQkk1MXJVdVJP?=
 =?utf-8?B?N1ROSHpld2pZTWs4Uk9vcUIvQ2d2TXlPMmU1ZndIdWYzWHlOM0J4dThXWVZV?=
 =?utf-8?B?aGxqOHBmVUtwejJEWjQrbnNJcWRtbVRXbGhxYWc5Z0xCWjYvdmRTWUpqSk52?=
 =?utf-8?B?bHNBSTl0empjV1c0QUJwNSt2ZGJTMXVOdUU4aU5VbUxldlNmVFo3dFkxL0Q1?=
 =?utf-8?B?QjlyS0ZGMGFST1NtYUdXVU1udDE4UHRIVDJjSFQ5djNXS3pYenJ5dWN3R09K?=
 =?utf-8?B?STJHRlNEb0hNRHRYdTdIK3JhdXBrbTNMNzdPZmN2OHMraEpHNGtuK3k2ODVz?=
 =?utf-8?B?aFNsOXJDY1h5b0ZPTXJCalQwaEVlcVFJdFlDVmpXRk9IeEVaZSt0U0hTOE4v?=
 =?utf-8?B?ektnQmE1UnFnK1Q3S0p1Nm1pbDE0SG9LZVU4UjkzOW1JMGhJbksvSzUzWnFM?=
 =?utf-8?B?azEyRXJ5L2VuTWVIZ29hdjFiZ3VIak9ObTAzc2U0SWQyYkdaUE40Mk5McFQ0?=
 =?utf-8?B?dFpsVXdrT1Q0ZlJqTHJlWEdtWEVDVkNoc1NidVdiMHlncmJ2TjlnbmU0MXdC?=
 =?utf-8?B?T2tqSHdMODd6V3Zlb2h1Uk5vMkxzandnT0tEcElyS1NPazBVcFRXWmlGN3Mr?=
 =?utf-8?B?TWxpU05HUE9IVmF6OVduRXdLaWlydkc5OXBRVzVnenB2bXc0UmtPVHJTbW83?=
 =?utf-8?B?STVpSGExb0c2NnM5NmprL2Eva0pwbTBZNkxjOUoxNFI4ZUJwQUIyR0YzMjlV?=
 =?utf-8?B?cjhscGRPY2FLdDFoUmN1c3E4RmxxWW1YbU9PRy90SDdVdWkzeE1rbXFwV2ha?=
 =?utf-8?B?bkExZkNXc2MyRW52ZDl5ZE5TSUQrdXZaV1hzSlFvU2hFODE2cjRpNVBjSkZZ?=
 =?utf-8?B?YjRkc1l0aURTbnZVYlA5WTdGVGNhV1FwK2xmVndWL2xlZDNoSUxkWjJvMmQ5?=
 =?utf-8?B?azBkQT09?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TTRwTHVNcGdhcEJIOWJxeG5tbGM1S1NCTFUxUDFha1pVLytGQWxxTmJ5SGhK?=
 =?utf-8?B?dGpqejR5UHlzYU5yYnlaaEF6amlOaTFUd3lBQVNJM3VBU3EyQU9GK1AvS0ZJ?=
 =?utf-8?B?a09ia01YK0xreHMveDExczR4YXRwdmd6Mnd0bkJsMXdsOHJncGNvc1FYNUxv?=
 =?utf-8?B?QTFWL0toMmtSWjJUaDB6SnhhT2pHc1o1dHU2SHdLMWk3MFlLcjFVaHZrRHR6?=
 =?utf-8?B?TjNTWnVmM3oyYTlxemFoV1JyUTFSdHlZYkw5c01RNnNlaFhqODhJOGFMUTNS?=
 =?utf-8?B?V1pyMmhvUVhmSkRSZVZiRlZiWlZRMTEzcG1tTEhSSlJYdWdrNTFTbTcxenpr?=
 =?utf-8?B?Tk00NHVoVnRIb0hUamxkem8zbmRZaTFaR0RsQTVFQ1hyeWkxTzhyVldhdzR2?=
 =?utf-8?B?UFByMmZXZmp2cndSb3ErVmhhM290bnJHbG5GZm5XL3BEMHhmbFBJcWVER25r?=
 =?utf-8?B?ZUVsU0dEUitNd013amhyWmZZZHgxOVg5T3pjRi9wU09WWlVOVzQ1U3pCMkE0?=
 =?utf-8?B?TGVpQ3FNbE1iOUlvUUkvWVJEU2x2Y1VkUlRnSmd2VGlCNTVkS1ZUSVZud3Jl?=
 =?utf-8?B?VHZ4M01ObmEyeWUvZUwwQ3VPS1RnVGgyQVpKVGNlK0lmRW8xWGZvMThnRitY?=
 =?utf-8?B?NmFERHpzQ1BpdzJ2bC8wUGJ3bGprSGczUzZTYzBjeENPSm9WWmN5U25IRS80?=
 =?utf-8?B?cENpci9CWTR5QmJMblI0WVp6WVpFYmw2SVljckpMRHpza2tMRjZzaThOKzAx?=
 =?utf-8?B?azJaV0RqQkVyalc3VERBb05aRHVpOUIzM0xHL0dNQ1F1NVRxcHlIeUtvNlMr?=
 =?utf-8?B?NlAzZ2Nub3MwVzJERzI2bUVWRDQvc3oyNGhUVkVLanZ3aHIvV2YyUzNtejU3?=
 =?utf-8?B?eGdkY1FiT2FrdlJLVndTTnFNVnp0SnM4TTByaXA2ZHJDbnlLTmFpWXIxTWM3?=
 =?utf-8?B?aVdnYW91TTdFM0gyb2YxTkhzcHE0Z2Z3dnRIU1hPR1hncFZhQWtGZnZYZzJQ?=
 =?utf-8?B?TGVqYnFIUWhVaFhiQ1YrOWFITmk2N0twb3RDTnFTN3YrTzNuWVgvN3drSUpq?=
 =?utf-8?B?NVJ2aGhYUXZxcTVzdkVrQnhpYUJITGxPS3d1UzV2U0picldwS2ZKUktQU0xG?=
 =?utf-8?B?UDg2TVQyN3N0ZEFnVWw0cWU4NW5Vajhhd2xJNk56dFUwb1llWURRTStIQ2xP?=
 =?utf-8?B?TnNJeWZDejI3S1kvRE5XYVpqNzMvZStrUExJaW9UNzE5cGFFaTNxWUQzUDNk?=
 =?utf-8?B?VTFSam8rVkQyMmtNNWhyR2lranprN2locko2LzdDSnY0N20yaW8rVWcrbngw?=
 =?utf-8?B?aVdnMWhHSFp1dC9SRGhyZzZWVnl5TGlnV2tBZ2tJblJxVmtGUStZUGx6ZHpl?=
 =?utf-8?B?Kzh0VG8xaTVuQzJJellpZ2NvMURncGtTZVRJN3BNT015cTQ3bUltVFhhMXox?=
 =?utf-8?B?d2JwR0kvU0lPTUtSVmVRRng0Y0VBL2Z4U1NJOFhLU21oZTZWRXB6N3RHZElv?=
 =?utf-8?B?SVk4SWU1Qkh1WXVYUkxPVnRLSDNUeitVSEpUV1dsNXhUOHl2MUpiQThWTlpI?=
 =?utf-8?B?Rkh1ekJVRjNvbmtFUlA5ZDlZVzZEbnpHY0ZpbFlhLzNveFlKczlMTlNleWRt?=
 =?utf-8?B?M0dwZ0owc0NnNWFFbHFrNkZMZE1IYmwrMU1aR29mbWtGTWFCSFpEcTBwc1pz?=
 =?utf-8?B?ZzFIelZHZkdsMWpnV1NqcUpCS3NIbTJqTUF0U1hqRWhTVlgyQnYzaTUvWHF2?=
 =?utf-8?B?SkI0VUlvcTdoaFRSK2N4VEdBeW1MU05jNVhxRCtZSUtHZmZubWFCNFN3dDQy?=
 =?utf-8?B?L0lhczlXZUFtLzZQQm9JWlc3MjJ1Kzc1dVhHQjJYWElJbC9taHZuU29hWXJm?=
 =?utf-8?Q?g0df9w+5SIHGr?=
X-OriginatorOrg: sct-15-20-9412-4-msonline-outlook-3e488.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: c15e7194-6918-4655-b8e6-08deab794cec
X-MS-Exchange-CrossTenant-AuthSource: SI2PR01MB4393.apcprd01.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2026 14:11:00.7107
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR01MB4454

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
index 0c159ab59e14..32e82859089c 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -5265,13 +5265,22 @@ Kernel parameters
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
index 54f702ed4c96..b0c15de0aedb 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -1032,6 +1032,16 @@ static void pci_std_enable_acs(struct pci_dev *dev, struct pci_acs *caps)
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
index 14f634ab9350..b8e188eb06db 100644
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

