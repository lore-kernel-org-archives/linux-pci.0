Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.228.118
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794058234;
	b=vOg3nkcnSuHay9TXAcXoNXJrcChNaQjWLsj8So35XNBuIMIi+zYBoqQxyHMXkY8hIwnI
	 +P5/xc8ijAD5GqDGnxW69p7vofjuugYhrCTu8Q0pUicOlivN5zES61Dl+uEE2/lD7VRAn
	 /JnPgTYrl5Hsm0e8FeSjgpSHBhqNg5xxWGb149YjVCMWSx+vlEp2Wa0Lm+0uWHi3dvc7r
	 qSr2ICxz7NXsa8agDhDmesTaOVARzmnTw+WOBu5NzkMbX8W7TLUpBtLezQkOHy/1enT1h
	 iEsQtfYm0bxScCBgh6GrXTdJQTtLx3IYVE3+DKXsVaB2Al25K+L+USxKtEv41J91q2g==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794058234;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:Content-Transfer-Encoding:Content-Type:
	 X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=AOiEUTErM4jujryguvYdYAjisxFsdtxDdsRJADqb8o4=;
	b=tHN+d1i+a58LLNzGMETSQLt/ihgkfT1l7nrxVZV2vo++KhADHkbnw2VaUkJIkX7bWg2O
	 bvgF+JxlodUCsuQFIEXuHq0/NiD3QHr9YoLQx0pzfh6vLEVnMUaIOYa9qdefkuDdinVYk
	 ecwQw02CHB7WQbuBr+YrxU7BytkV7viaK5LGAn2jaBoUfVcberYhipQCBho3NsfmP94KN
	 iiSQn8WxljsHLAZxUnqN52q5fixe/8DLUEzufhyMcGa73wJSt8ptYMMMdi+iwgrZ9xWkB
	 eeDBE8N86fRKQUY97dyro/3UIbQ8Nxp5JUHiUQ5JspllcmzohNhHV1IOZ2xskxdjPCA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=valinux.co.jp;
	spf=pass smtp.mailfrom=valinux.co.jp;
	dkim=pass header.d=valinux.co.jp header.i=@valinux.co.jp header.a=rsa-sha256 header.s=selector1 header.b=AJpZsEF3;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.228.118
Received: from OS0P286CU011.outbound.protection.outlook.com (mail-japanwestazon11020118.outbound.protection.outlook.com [52.101.228.118])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C1D6606A326;
	Sat,  7 Nov 2026 13:30:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6C1D6606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=valinux.co.jp header.i=@valinux.co.jp header.a=rsa-sha256 header.s=selector1 header.b=AJpZsEF3
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=N3zleWjfZCU/gRcWKW9WzBBIz2kgZlj9CECki+A7zGVP/5tw6suJsHsUszMS0PYv0j1CuBFNZoRxWmhWigH1mHEjbQevn4l8jtXQU4Q2DPEzO9IH9fYyOJeXNHhLlFiZ25DQelrQplL91ayN0sWZz6ZrsEcRzYMIibXlNs3p9W9oH+/JaVof4AG3gQHbFdMYr4VM+tTHqW7XYGXqs8X0JswWZyGzv54To6OC67cgCf9dav9jG1WO2Bi/j2a6YnnuQOcdSKE9WP5fTgM0vuckpgH8rcDNTXVX9uYRGYGP9T83PTYABmHl4x0LBqL0k9MC9WRTzLaXqgAVTxfx7zY6KQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AOiEUTErM4jujryguvYdYAjisxFsdtxDdsRJADqb8o4=;
 b=wFGTuyqvAMMohI62X0L2ejxEMO+lrUPiBWr3zkYybvM6HGPj3LHo8GEjDaXTmUUFw9iW+nV28czadOWkzk6hdAVrktJpGaV6xmlobgIkBFfxB5zFoS+Z3QkrkeDo/HlUb8MCJ2Ep14JF9EP+6gxRlencVQfqmnKj/5WVzPl2gza0NuO31C7isJ4vjS9PgnW7wnue4LEJNoOB3/35gscXWy3IZjpDPz+abkcJ7H9tgBGPswcCq+T69hq/NzITixGI63lrjUuOSteCXq/X+wKm0K8E0hrfIqf9txtwWXu00hk9T6faJpIN5tm/c0o389HX9IatoThUhbzP2C5SPQ1LbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AOiEUTErM4jujryguvYdYAjisxFsdtxDdsRJADqb8o4=;
 b=AJpZsEF3nV9QP5HvhbQ+WZw5DhWatMjOh6JOKEus1KcQe6Tir0hfwo89Quin8BCb97s6EQFjAG5cXl0DQZNICkzNa3024mCo8ZMDA3o3Assl5nhhTmwQjGbDuCWnAZPtB+y/W+PLVssK3e345JFHlnWakWI3JvLs72IPIAOm1i8=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:325::11)
 by TY3P286MB3538.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:3af::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.11; Sat, 7 Nov
 2026 13:30:30 +0000
Received: from TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 ([fe80::cce5:2aa8:53f9:dba9]) by TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 ([fe80::cce5:2aa8:53f9:dba9%5]) with mapi id 15.21.0592.010; Sat, 7 Nov 2026
 13:30:29 +0000
From: Koichiro Den <den@valinux.co.jp>
To: Vinod Koul <vkoul@kernel.org>,
	Frank Li <Frank.Li@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>
Cc: Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>,
	Serge Semin <fancer.lancer@gmail.com>,
	Cai Huoqing <cai.huoqing@linux.dev>,
	Niklas Cassel <cassel@kernel.org>,
	Devendra K Verma <devverma@amd.com>,
	dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org
Subject: [PATCH v8 0/7] dmaengine: dw-edma: Support dynamic LL appends
Date: Sat,  7 Nov 2026 22:30:20 +0900
Message-ID: <20261107133027.364237-1-den@valinux.co.jp>
X-Mailer: git-send-email 2.54.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY4P286CA0132.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:37f::14) To TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:325::11)
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB6866:EE_|TY3P286MB3538:EE_
X-MS-Office365-Filtering-Correlation-Id: badb99a9-1056-4fca-ed7e-08df3cd34a98
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|10070799003|366016|7416014|376014|261102123227099003|261009223027099003|261022105027099003|261021121427099003|261022075727099003|261021123027099003|261026121527099003|261026135527099003|261028144727099003|261026140227099003|6133799003|10067099003|56012099006|18002099003;
X-Microsoft-Antispam-Message-Info:
	ZtiHlUfT6Jtc0KqNxuZ/7EeCZejMZHN+FzEwVHMzxPzIJCjE8eir/mp+TB5bDkIE5kpcXE9V19JhAprYH6ORGJsE8DMZB3eKSxjPetSOQymWNIm1XKcRSiyn3qaQ25Sz1KbASJWnnHhE3cvWHQeWrGe00dmryMWhNEioGWVqlStuue0ksbitizdZGGoVVPwtErAkt+RXB4kN9UO205PZgADuxZcFITeOPgeA8O7GP28VzjMgNdjHujLCs9fJvmsTuQnofddsVXelOoc9MbWMllIY/j+Dng+a5Zdb5y7NdjpGKHFzsMaUOc0tje/9pExzsTbvvCFlODsEXmThOqXWrXyGptUnWWPrImeTqM/41Dd6uuwkxJ83NGXA72bY6A2xn7mHSo+mFRQL1E+aY2/cwa95f8Og1TdltPaLTlD+9A4e0jKQcil1+hS3gA9UAlDwgFyKIyxqHCRAFOb7V19OzvsxqpSdlBo3m5tXUgLc10zAuBKEMZBoOWfupLZtWvGAMilj1+BV1OyptcJHLRkydvSrNgY8UJS8ML23IIZWVKrBTIx300wr0cCfCMj3EQClz4op2tbFJSCx7JRdxKsLcHTUuG1JSPT++hmh1+OFqxxSMxNJloWAwGT5IgIz3IQR
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(10070799003)(366016)(7416014)(376014)(261102123227099003)(261009223027099003)(261022105027099003)(261021121427099003)(261022075727099003)(261021123027099003)(261026121527099003)(261026135527099003)(261028144727099003)(261026140227099003)(6133799003)(10067099003)(56012099006)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?+uebN8YWeOFI5jXldSwglIHxeDGQxYt6FIn7biF8EecBsm3zC8Fs4K/+2fVk?=
 =?us-ascii?Q?iCCyigYLq8dxW+vDS5a2OOSfh1j1jrOrS1FrEh1j/n6WmzProIbkO2vffOL8?=
 =?us-ascii?Q?12cfO8b5tTPPjZsJ+FlVFG1AFyKQQKLOEhlG6GL4jahhUV9d9e5dXk5u+HJh?=
 =?us-ascii?Q?SliC7mJoBZyJc+9oUtEWMPG78prHbnlgAdFAdTLVtnlTHL8s10fmFVjiLQyJ?=
 =?us-ascii?Q?68/wzCftETL/a1wpRwq2Yl852ijwycX0/Xqy9ATl7005pH2m1K5janzLrHi3?=
 =?us-ascii?Q?8DHg4gRiQtudOL4KY1k9kzznT+wdKKxrSbF0hF3zGrsc/A0M43u363Ov0ZM+?=
 =?us-ascii?Q?hfrSigHurw5bq2cPK1YcUjT429xtbI+/UQdvIa+NMaO8H5uccQCWnHF45uzx?=
 =?us-ascii?Q?XnZ9g+ZzLBqnd4cdsjHoMRumhc1ztmPV7SKv6YPx4zm/H5f3N/kDHi26cFkO?=
 =?us-ascii?Q?KL79y8JqF7TN1vN/RlxvrE2d5SoOxPloaQ6+oWwBjV7Hmp7rl9HOzAsVoXKr?=
 =?us-ascii?Q?wcrvcbiA2FDePtrj5NAhvO/FmeaiXr1V1y5LNijaHhLzbev2mTx3V06dRBtM?=
 =?us-ascii?Q?ZpC79oNsJVVPxZ8MfbllPg/7XTeL+P5++bcMpnaDWwcPxMWKivu8DHPTnp0o?=
 =?us-ascii?Q?xV1/AbEk5fKz6VMtZqUMX2dyW1wfPslCI63+/yIhsYGhKhigEAPnYynNqyiK?=
 =?us-ascii?Q?Dz4C84/xyPkJA9T9xYoaCAaL2QlzDeVQLH36z1srpUKdpNs245hzM+zVApub?=
 =?us-ascii?Q?j/ZwJdKRcffwzlBfAx4/a3pNTuvynfFpdX9jVtygkz1BspfaitXyaHRMMhZn?=
 =?us-ascii?Q?hHCuJjCYhNMIJf2gdSbzpthPumuiEt3DdYXiHjsKDsMOQ+HYYpVNWfF1rXRD?=
 =?us-ascii?Q?CHICjwd8r5bYCICG6yrWT/AY2dAs7teP8XKTcoiaO5u35Gq0fqhuPBtqyxgK?=
 =?us-ascii?Q?4Ao4CJKeCbuAOJDgw1WYTrGD9V7/NSiHNGmnchMLOzE15NTGHmoEASJdwmVS?=
 =?us-ascii?Q?5N3nmIvwCSZ8bb1NxjfFY7Yu6FxpehClaeeDNNb0lxKs37Spw0EYE3f6LRWN?=
 =?us-ascii?Q?YiQ+WBRIcqiNSGiiiyYudLJKzPErYc1Hjoqx2LT+Ek4HOY/QVCXJwc1V8jVv?=
 =?us-ascii?Q?h9CQjJRlmPrmiAeuEsA3FOknco7uDlruKrCrNP0TyUODx+5QerpuJCPHHbK8?=
 =?us-ascii?Q?QUvFZysnsmow5kRwFKOyaSh8BmiQ3mfc4jiHW9edIhrQLkZx7cA50N+S/DOE?=
 =?us-ascii?Q?ljDW3gTvnQJuyMyrhpN+CMQCXV9GNCWdEsKZVoEAVujhM0zDrChQuC+XkEHE?=
 =?us-ascii?Q?LHUqJxS+JEpolDJLH4GRBxdBcpFQpglBpM5vQV3AajCsRn4uL9AohkrHDleH?=
 =?us-ascii?Q?EQyQ700Jt5U0uRBgj5+7qW4Mmu2rFomFMmTQqdOjU1me3s7C5EeWl3nDL+2a?=
 =?us-ascii?Q?BeGthGsUh6yu+OU2ZxD7bh44DnVUiCwdNS0zXCQzZhoEzVA4rHq9DJMBFq8C?=
 =?us-ascii?Q?4ZpqrrJKUeHCsOLNVA/9SnYsbNvOGrE7rWhUwswBktgmsWOHfdhkNTH7tVzN?=
 =?us-ascii?Q?k1gd8k/MzehIQbqWItfaJxCglou/bl34RUG9J1JhVAYeUcyXKJqUIuZDwFz0?=
 =?us-ascii?Q?LjCuU+w3drkLl45AaBEShKsUHXCXiERlr5CCdnREkClaAxP56dHPnRWOhjUg?=
 =?us-ascii?Q?U8Hr/wlVFJpVO5w3TEv4nh3z1ftxmxXv1ORKRxMaYqt5Kw17B/zDujSr7h3A?=
 =?us-ascii?Q?xjEAwi+zQ3J4Ezb3JFBo+z6QIdsWrgbuMdt98Vg9YLiz+RZBXsyb?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: badb99a9-1056-4fca-ed7e-08df3cd34a98
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2026 13:30:29.8388
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: w5lxpNKsoS8Xn3JIhImUh2OH/WbTntA0LpV9mVZ6uOTEp4Per+1yRY6vNdJee9TN8L7OgTnz6he6x62Fcm6DYA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY3P286MB3538

Hi,

This series lets dw-edma append requests to a running circular linked
list (LL) using PCS-CCS-CB-TCB Producer-Consumer Synchronization. This
reduces stop/start cycles between descriptors.

v8 fixes the premature LL completion reported by Sashiko on v7 patch 6
and picks up Frank's Reviewed-by tags (dropped on patches 2 and 4 due to
updates). I reran the tests, with additional tuning on K3 and S4 to
reduce run-to-run variation. See below.

Based on dmaengine-7.4-rc1 (aff5e6a77fc6).


v8 (Re-)testing
===============

I used three setups for testing:

  Id   Endpoint                  Link       Host
  ---  ------------------------  ---------  -----------------
  (A)  RK3588 ROCK 5B            Gen3 x4    CIX Sky1 Orion O6
  (B)  SpacemiT K3 [1] Pico-ITX  Gen3 x4    CIX Sky1 Orion O6
  (C)  R-Car S4 Spider           Gen4 x2    R-Car S4 Spider

1. pci-epf-test:

   For all (A)~(C), same PASS/FAIL/SKIP set with and without this series.

2. nvmet-pci-epf:

   I ran fio on the host against a null_blk target, with runtime=30s,
   ramp_time=5s. Each setup was tested five times without the series
   (base) and five times with it (new), alternating as
   base1->new1->base2->new2->...->base5->new5. The table shows median
   throughput in MiB/s.

                           (A) RK3588       (B) K3           (C) R-Car S4
                           (5.60a eDMA)     (6.30a HDMA)     (5.20a eDMA)
   ----------------------  ---------------  ---------------  -----------------
   rand read     4K q1       36->  35  -3%    62->  52 -16%  12.1->11.7  -3%
   rand read     4K q32     180-> 162 -10%   169-> 164  -3%  48.4->70.7 +46%
   rand read     4K q32/4   188-> 160 -15%   169-> 164  -3%  66.1->76.9 +16%
   rand read   128K q1      718-> 661  -8%   942-> 950  +1%   207-> 203  -2%
   rand read   128K q32      82->1199  x15  1140->1590 +39%   696-> 917 +32%
   rand read   128K q32/4    51->1248  x24  1810->2428 +34%  1243->1328  +7%
   rand read   512K q1     1039->1034   0%  1281->1287   0%   143-> 196 +37%
   rand read   512K q32      58->1312  x23  1800->2368 +32%  1217->1294  +6%
   rand read   512K q32/4    46-> 953  x21  1816->2528 +39%  1288->1371  +6%
   rand write    4K q1       34->  26 -22%    58->  48 -17%  11.7->11.3  -3%
   rand write    4K q32      70-> 148 x2.1   117-> 220 +88%  40.6->47.1 +16%
   rand write    4K q32/4    69-> 151 x2.2   115-> 219 +90%  43.3->62.0 +43%
   rand write  128K q1      466-> 474  +2%   758-> 781  +3%   142-> 144  +1%
   rand write  128K q32     888->1310 +48%  1686->1921 +14%   557-> 696 +25%
   rand write  128K q32/4   900->1287 +43%  1686->1920 +14%   733-> 860 +17%
   seq read    128K q1      663-> 621  -6%   905-> 836  -8%   203-> 207  +2%
   seq read    128K q32      69->1184  x17  1150->1590 +38%   699-> 938 +34%
   seq read    512K q1      948->1033  +9%  1304->1276  -2%   146-> 193 +32%
   seq read    512K q32      55->1335  x24  1804->2345 +30%  1072->1167  +9%
   seq read      1M q32      49->1021  x21  1841->2484 +35%  1249->1330  +6%
   seq write   128K q1      504-> 464  -8%   810-> 833  +3%   138-> 140  +1%
   seq write   128K q32     897->1307 +46%  1689->1922 +14%   565-> 704 +25%
   seq write   512K q1      569-> 715 +26%   271-> 306 +13%   113-> 172 +52%
   seq write   512K q32     899->1294 +44%  1687->1921 +14%   737-> 861 +17%
   seq write     1M q32     843->1194 +42%  1685->1918 +14%   747-> 876 +17%
   rw read    4K-1M q8/4    193-> 529 x2.7   531-> 727 +37%   453-> 499 +10%
   rw write   4K-1M q8/4    198-> 530 x2.7   532-> 728 +37%   453-> 500 +10%
   ("/4" in "q32/4" means 4 jobs.)

   More briefly, geometric mean of the new/base ratios across all runs
   in each group (5 runs x N cases):

                      (A) RK3588        (B) K3             (C) S4
     ---------------  ----------------- ------------------ ----------
     QD32 (16 cases)  x4.46             +28.2%             +20.0%
                      (x4.06 .. x4.81)  (+27.2% .. +28.7%) (+16.9% .. +22.8%)

     QD1   (9 cases)  -0.9%             +0.2%              +11.5%
                      (-10.8% .. +7.3%) (-3.1% .. +4.6%)   (+5.1% .. +16.5%)

     rw q8 (2 cases)  x2.70             +36.8%             +10.6%
                      (x2.48 .. x3.13)  (+34.9% .. +38.2%) (+9.7% .. +12.4%)

   Parentheses show the min and max of the 5 per-round geomeans, with
   each round comprising one base/new pair.

   Note for (B) and (C):
   - To reduce run-to-run variation, both base and new kernels used
     nohz=off on the endpoint, and the DMA IRQ was pinned to CPU4.

   Note for (A) and (C):
   - commit efadda401c5c ("PCI: dwc: Set DMA_BYPASS bit in outbound
     IATU CTRL2 register"), which is not in dmaengine-7.4-rc1 yet, was
     applied to both the base and the new kernels. Without it:
     - (A) often hit NVMe I/O timeouts in the 4K q32 write cases with
       the series applied. fio still exits successfully and the
       numbers look plausible, so this is easy to miss unless you
       check dmesg.
     - (C) was unstable in general.

3. Terminate/pause test during dma load

   Following Sashiko's report (against v6):
   https://lore.kernel.org/r/rbkljnmrf4ctc7rj6qlwhvhemvzvxx6pdxjxsdc2bmicez56ms@bgshyuvsjuqh/

   On (A) and (B), I used a locally modified nvmet-pci-epf to
   periodically terminate DMA transfers or pause/resume the channels
   under fio load. Terminated transfers were retried. Baseline,
   terminate-only, pause/resume-only, combined and post-injection tests
   passed CRC32C write/readback verification against a memory-backed
   null_blk target.

[1] Based on Ubuntu-riscv-7.3.0-9.9.1 + some other out-of-tree patches,
    especially to make EP mode work on K3.


Note
====

Much of the complexity in v1-v5 came from working around channel stalls
on R-Car S4 with the out-of-tree direct-DMA NTB transport. A channel
could remain stopped and ignore further doorbells without reporting an
error. I have not reproduced this particular behavior on other SoCs with
different DWC IP revisions, or with the in-tree DMA clients I tested on
S4. I have not obtained further information to explain it, so it remains
unresolved. More details:
https://lore.kernel.org/r/tkyu5rsxfa7i6rxxw6qxmmwke5qnlxptwx4j2s24fhftsmmf26@gamef2ec4wwm/

I substantially simplified the series since v6 because I was concerned
that keeping all those workarounds would make it too difficult to review
and leave it pending indefinitely. I continue investigating the S4
stalls separately, alongside the work to upstream the more demanding DMA
clients that expose them.


Best regards,
Koichiro Den
---
v7->v8 changes:
  - Read LLP before checking for a stop to avoid premature completion
    (Sashiko).
  - Resample after a stopped result, and use the same sample for
    completion and termination.
  - Reclaim delayed completions while paused without restarting the
    channel.
  - Pick up Frank's R-b on patches 3 and 5 (dropped from patches 2/4 due
    to code updates).
  - Update test numbers after rerunning with K3/S4 jitter tuning.
  - Link to v7: https://lore.kernel.org/r/20261104161227.1742005-1-den@valinux.co.jp/

v6->v7 changes:
  - Avoid premature LL reset on stale STOPPED status during termination
    (new patch 2).
  - Factor out descriptor completion (new patch 3, Frank).
  - Handle STOP before LL reclamation to avoid scheduling callbacks
    (Sashiko).
  - Restart stopped LL channels to drain published entries during
    termination.
  - Use modulo arithmetic for the running LL boundary and add lockdep
    assertions (Frank).
  - Keep HDMA watermark interrupts masked for non-LL channels (Sashiko).
  - Use the dw_edma_ prefix for tracepoints and the event class
    (Sashiko).
  - Add Frank's Reviewed-by to patch 1.
  - Link to v6: https://lore.kernel.org/all/20261030150742.2586776-1-den@valinux.co.jp/

v5->v6 changes:
  - Drop the recovery code and the defensive doorbell handling added for
    the R-Car S4 stall: IRQ-paired LLP snapshots and event
    serialization, the delayed stopped-channel recheck, tx_status()
    reclaim, the LL interrupt placement policy, engine reset and stall
    recovery. Empirically, the stall so far reproduces only on S4 (5.20a
    (GA)) with out-of-tree direct-DMA NTB transport.
  - Read progress in the deferred handler instead. A channel counts as
    stopped when its status is STOPPED and the transfer size is zero, on
    both eDMA and native HDMA.
  - Fold the STOP/PAUSE drain into the progress handler.
  - Rebase on the circular LL groundwork in dmaengine-7.4-rc1. 14
    patches -> 5.

For earlier changes and hardware observations, see v5:
https://lore.kernel.org/r/20260812155721.2807506-1-den@valinux.co.jp/


Frank Li (2):
  dmaengine: dw-edma: Dynamically append requests while running
  dmaengine: dw-edma: Add trace support

Koichiro Den (5):
  dmaengine: dw-edma: Add a channel transfer size operation
  dmaengine: dw-edma: Avoid resetting an LL on stale stopped status
  dmaengine: dw-edma: Factor out descriptor completion
  dmaengine: dw-edma: Reclaim LL entries from hardware progress
  dmaengine: dw-edma: Use HDMA watermark interrupts as LL progress

 drivers/dma/dw-edma/Makefile          |   2 +
 drivers/dma/dw-edma/dw-edma-core.c    | 286 ++++++++++++++++++++++----
 drivers/dma/dw-edma/dw-edma-core.h    |   8 +
 drivers/dma/dw-edma/dw-edma-trace.c   |   4 +
 drivers/dma/dw-edma/dw-edma-trace.h   | 117 +++++++++++
 drivers/dma/dw-edma/dw-edma-v0-core.c |   6 +
 drivers/dma/dw-edma/dw-hdma-v0-core.c |  68 +++++-
 drivers/dma/dw-edma/dw-hdma-v0-regs.h |   1 +
 8 files changed, 442 insertions(+), 50 deletions(-)
 create mode 100644 drivers/dma/dw-edma/dw-edma-trace.c
 create mode 100644 drivers/dma/dw-edma/dw-edma-trace.h


base-commit: aff5e6a77fc69a7c490246465940d18422d7c631
-- 
2.54.0

