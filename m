Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.125.111
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794299108;
	b=LpY2cgl4GM7peDeuXHIGaWyE++0ni2baVdIGXMAQOmm6PqC15yk/JRNZsJupWsCaIFSN
	 s21/V0e90r5rPCV+fR1TTEGls1pbxrS3Mfh2V9WdLf0lpBFrKWxO+n6/6zHjXAxufP/Yn
	 So9d8cKLhin9zL/m/IN9d0qg3JWyXiQ8kmYKG481SluTncqfMhZfipl0qprkVlvJaRUXK
	 en9ZOIcpEdbVoGEScyJlgw/MrU27W6uIXcBurdHMDxAE2J4CtRkJpp+p/6KEWBNczguhd
	 wMeJxFkhIKtWdkHXSKCmhfgTHi42JULn/5NqhsC6tKTK8DIwUFsRIsmLfTI6LowyHaA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794299108;
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
	bh=+TOn6XCpgMVshjCjzjRnaNPph32C0Jp45lM/OA+kK5M=;
	b=LYU/TllAEsZOKZA/5hpK8w2gXwcWAfD9r3xaxYW6qrlRht6yZdNnWKO+r4kaPmGfu7+x
	 YRqB+KtKIgi6SpFnWXhFrWIgGLSdwVZNs7K75bDEx7suDx49WU3cuSCo+UYGCuk9sC5el
	 T8RSaS0WL7FwtWMU9ARfK4cyYIFxArr+qTuUD7uy1Elyh77SZAV1WDOrGvLbVa9OzZqY4
	 0yrxkCntsLjJbEwWuqSW3v2kiwm2WF7RFo6NmdGCt8ejGfc/k1wLhE88sGmbBE55+Dl+o
	 lgZO+S2k5S4mY3N3guOFmLD+PEnPMHeNMvGQFBi9LszHhKtP/rbHe58dr1ZAHbLMVEA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=valinux.co.jp;
	spf=pass smtp.mailfrom=valinux.co.jp;
	dkim=pass header.d=valinux.co.jp header.i=@valinux.co.jp header.a=rsa-sha256 header.s=selector1 header.b=nxyDbtjU;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.125.111
Received: from TYVP286CU001.outbound.protection.outlook.com (mail-japaneastazon11021111.outbound.protection.outlook.com [52.101.125.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92598606A325;
	Tue, 10 Nov 2026 08:25:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 92598606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=valinux.co.jp header.i=@valinux.co.jp header.a=rsa-sha256 header.s=selector1 header.b=nxyDbtjU
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wfcVMBed2DX5JuikYER034wY5vJ4yeJfgHxE/rGprfT3nSflsMswFQq/rEuGToMgDFNPLrs901FNEExECNvsYbqSpK/pfLU5ywRxtztRYEUsGDVsVHZVuswK5b8YmiPmDEed8PNI9u7HO1jZ7qV4OVyQskcIOE4kbFQJxO0uqRBgsRpYfFK5mgfKUUkacqvLEGDoM45RYDLp7q2kQ4H38G/y1zBzSHwGoKFH7NQXgqmoxv4r2OG33xsCYJT5b9eE07sAHHILaTQNsbyx1rgoE4DkgrF5Saafj5LH8fkIBqQONBf9lwu4bA3LhOow6MpQblwmxiO5wwfCB2e88Vd98g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+TOn6XCpgMVshjCjzjRnaNPph32C0Jp45lM/OA+kK5M=;
 b=JUd3HoMnRszoXp4JzEEYAAPn66TqZcZuwn2mq/0vuPFJ3X2IUX9ChD88HKf37xnkXq/iUcn6VqNLuwvkr79oVr2miQMRaQN8Q0u0Kpnn79/3zuPwDuF+twZKh2JL9UG6r9B5H157hxZY4reecD6GxI+1KVhUanIT9At7u6utGSSbnlypQ6kIUuf+f0uzzhC+/VOfZox+zwB5ezfkY6v5hiq5bshK3+sxJeQuelEU9hTF3UI3YTcApDKMLn4fJO16MEnWDNg6MDotllCxnHYt+mdJgmiYoRdqOXIhk+E2IySxkVT1k+5XF2ITFE8JhyKmtgVrIzOEg2CRgglsbObfgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+TOn6XCpgMVshjCjzjRnaNPph32C0Jp45lM/OA+kK5M=;
 b=nxyDbtjU+lVGY5tUREEQrbGmrqiI7mQJcOCdR+vqJ7E9YGVKPUb/gPdPoAIoP7xon2zi9qO51J9yu2SL8qra4JgGmDziLUVabRdesAxSKrCkZuATE0aUtVY2ByGowN1hV2UA/d+DKuyIO72xSuqFqGHqkIRtLdaD2cCSDOqPcFs=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:325::11)
 by TY3P286MB3015.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:318::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.13; Tue, 10 Nov
 2026 08:25:05 +0000
Received: from TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 ([fe80::cce5:2aa8:53f9:dba9]) by TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 ([fe80::cce5:2aa8:53f9:dba9%5]) with mapi id 15.21.0592.012; Tue, 10 Nov 2026
 08:25:05 +0000
From: Koichiro Den <den@valinux.co.jp>
To: Frank Li <Frank.Li@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Jon Mason <jdmason@kudzu.us>,
	Dave Jiang <dave.jiang@intel.com>,
	Allen Hubbe <allenbh@gmail.com>,
	Niklas Cassel <cassel@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Jingoo Han <jingoohan1@gmail.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Jerome Brunet <jbrunet@baylibre.com>,
	linux-pci@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	ntb@lists.linux.dev
Subject: [PATCH v9 00/10] PCI: endpoint: Remote DMA support via vNTB
Date: Tue, 10 Nov 2026 17:24:49 +0900
Message-ID: <20261110082459.1798763-1-den@valinux.co.jp>
X-Mailer: git-send-email 2.54.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0230.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:3c7::10) To TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
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
X-MS-TrafficTypeDiagnostic: TY7P286MB6866:EE_|TY3P286MB3015:EE_
X-MS-Office365-Filtering-Correlation-Id: a0e38d89-69ec-4192-fa4d-08df3f041fd1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|23010399003|7416014|376014|366016|1800799024|56012099006|261022075727099003|261021121427099003|261021123027099003|261022105027099003|261026121527099003|261026135527099003|261026140227099003|261102130727099003|261028144727099003|261102123227099003|261009223027099003|10067099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	ghpqs82WCbH3nPU59nt59LK0LMyHGfhUyrDEOSnHlsvsffu7auQx4B19hjZHVTcqwiBZSosnRGFycGE5isCZNSuyLo6ZcBdUQw99WUSolUkUN0c5C41Vs44mAqq5UxFgpAt5MhdKN7xUakwRXi6GPiGZJGytNFwSEYIV5EhoCpn0NPObPTVoFEAFad2MS/FQMQNCGCyYSRQKEa+vG3HSaBMEXVkThROkRxHgm6Ar738oXMkhXV7eX0GeXWP+CADK0zSKvl9BE9UUjWDVk875sVi3E/5MWO925TAlbcWfNJ/qcqhNwCMQj76JQ10jmR2BOsdp1fh3+O9DMoACllT1WcXr6yUUHrWlNrT3NLkFV49au23uez8pRq0dHKYbYo8/AVTG83kgF2SWFp71aISSx/FMamxbN1hkmf75Wo6KdynlqsfIcyjRj2TtzUOWSesuYTQDazx28c6IxGCZeEkc2Pl7DzENqk7o+xcUW4RPCYLFKq74uEElwkkQODiQDGT8M42WEZzEtitC5jiU8Te6ArDRVWRX7KrqX1p8SMu5JBpWRVCtgbOVJFt5hmLBCojXKDydoSUphga3ZcejUl2C9bzjQDBWCldpsm5Wy6TiHIslEoQn1h6/x+weCUmgA+7U
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(23010399003)(7416014)(376014)(366016)(1800799024)(56012099006)(261022075727099003)(261021121427099003)(261021123027099003)(261022105027099003)(261026121527099003)(261026135527099003)(261026140227099003)(261102130727099003)(261028144727099003)(261102123227099003)(261009223027099003)(10067099003)(18002099003)(6133799003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?GyklSxp3+j7f0pyb8hxRJyq4YcLZiHTmX0ZlXvB0CEaJMhkmR83KO56xPJey?=
 =?us-ascii?Q?Oab3utkdQcNrqvB/1HEfoWbqGUy0l+VRPRXTuc34sfKHU/Kg0QhMoxWDyvFy?=
 =?us-ascii?Q?nrx7xAUPZjmfgyNob9c3cmciWw1cbB6poS4GCVxkuKKGaEeplXGph5FfxU96?=
 =?us-ascii?Q?MeYBuji/vFajr4f8pXevPkTKjEXtAC21Bp/j849rJU3rXEXf5AImmrCmNnIr?=
 =?us-ascii?Q?Wjua55yohEzWxOpBi7ywFyO4AkQ3zo3KKFr5EG++NJHadrycsSIIKyIK6npC?=
 =?us-ascii?Q?qBMApcsFPPxwKn1A+TLz/MMrEEfeTSe5ltLsUFJRg3C6vN0jWOIsxwgqiaha?=
 =?us-ascii?Q?5alptEkxINUhhZI5oE+7W0tT3OcAqRVoA33jFEtSIJ/Anzkxspm/ftVsMc6n?=
 =?us-ascii?Q?jW8pFaxxGOTTxTMLHZsGRdXhNQgqFgxuGkzJFm2ZbCmAxQD7KpFLo/Wk86Zp?=
 =?us-ascii?Q?64SUpZJPSsMGby/TmU8YhTid7TiRiDq8D5Z8rHGj2iSyNiM+zVPfAsQ54uGV?=
 =?us-ascii?Q?4oI5M3ybOvVD09OGd0kaq8iCvvhpjS3QzYimQpYd3URTB/Kk0r0TxWEN4rEB?=
 =?us-ascii?Q?09PlDj/Cnm0otVpztl7Rb/+wUPlbUtxyRJMUV4ZFl2i3o4i4uTNePyeLpOfA?=
 =?us-ascii?Q?hhZQNx39rn6Aj9Lel5cv9+zjwRQ8eNIoPT6vCxT3C6mFDeUBUcpR3oDd/jBy?=
 =?us-ascii?Q?BBjKOCe8GL/XzSuV1JUWZNcSNYlQw1OnK69aZbtLSovfZIrp8LJ5b3yf/8KN?=
 =?us-ascii?Q?dGde6KTJIy3RJxeMddMni/UdsU7zHZ3g6XG97MjZjadWOlYP32qccVauRlSv?=
 =?us-ascii?Q?fljluOpnTMCmS1N/hBwxWObef04Zf0fTSS/ABPNHLVSfx1gXeisW8crmErUH?=
 =?us-ascii?Q?lurdnKnx3tkCxxA12cVW7JGC/5GaJcrZeN2H05+5uDo7DJWzhqAiP4wf+H18?=
 =?us-ascii?Q?M6r9kofw0REyRP9n2nQvYB5FEF/9yKY43umbTtUhA/j2BX8fOUekJo7K62gg?=
 =?us-ascii?Q?JRuvnkWS1RiYSoI3hBnZSu2ADcjGUDW1n4TGBm8VuGev/Aj6+xXgH/kJjnds?=
 =?us-ascii?Q?QvNu2424O0uR8vOic2zqUXhzLpVH8r+8SVB4Vm0FxB6nSN/Xdoy5iq6jgV/I?=
 =?us-ascii?Q?DqpbF0ZUYZeBy2trqaHH+ofImhtV0OD61U4f+daWUZqISHIi8MKFYX1CTcAC?=
 =?us-ascii?Q?m9tbi4TeryI2QVQcCVdom5W3HI3qKyJKQPWB9uG5Rys1lbUqL0g4AwRSF8p+?=
 =?us-ascii?Q?mUx0bSuaBhRNrLuE0IuiRGPHAflKQT+RBdp7TWuwrq3bOhnqx/6GZGtS7DT2?=
 =?us-ascii?Q?hV8675lvqfvwF8GI7hf5wvgM96prRSDNBo/QhCMemOTZW8V5Xz5OWyc2IOHr?=
 =?us-ascii?Q?VvzNjGrL7MWY5mOuC5NKN+gRMYWSoYw7e99LHw12FxFvLCdTLLHMaj7ks1fx?=
 =?us-ascii?Q?AWWHx+jLkgKFE+Z5tSlWqKPdCwkTzugxUZ2bUdK5ZyB/+Oixdip5N3gxSYY9?=
 =?us-ascii?Q?hK0jZsMIqgYpuaW7XdcKbCLShzy5lndIFbEdus5RZ1fb95rVbJmMPhdV2r34?=
 =?us-ascii?Q?Uev+TWb25ksDIMpkFBdH12LFsS0cwjFf6RKioqcu7F8LPuMgfvoRghb8apNh?=
 =?us-ascii?Q?7VZVOpBTMXQ5uS4NtQQUG/p+zoNTbGohOG/2MEhyI29avacd+HqMm0qVbZLH?=
 =?us-ascii?Q?9eLIyIIhtM2gmbb4yWu+vAU7naJAqr2QEUmROZUNLZymrECjB+pUsosnFfAd?=
 =?us-ascii?Q?ZZih/xtJ01us8gpO8CHF8BVpeISez5A3eWSbLVR2A6F3ihDuqlcd?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: a0e38d89-69ec-4192-fa4d-08df3f041fd1
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2026 08:25:05.7177
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tZlKywCwpFm3rAedbIgwblaSgY8vv8AVMQH1YYcc9ZtkxT6JQ/s/z0/0L3Y725bB6QcTd2CVt2sfny3EheH4TA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY3P286MB3015

Hi,

This series lets host Linux use EPC-local DMA read (RC-to-EP) channels
through vNTB. I also tried a separate PCI DMA EPF, which reached v7 [1],
but came back to this vNTB-embedded approach after discussion.

An EPC-local DMA engine can use host DMA addresses (IOVAs when an IOMMU
is enabled) as PCI addresses to reach any host buffer mapped for the
endpoint. Letting the RC side drive its read channels also gives the RC
a direct path into endpoint-local buffers.

A major motivation is direct TX in ntb_transport. Both sides could use
the same dmaengine-based TX path (ie. symmetric), sending directly to RX
buffer DMA addresses supplied by the peer. This would avoid MW bounce
buffers and per-transfer MW remapping for payloads in both directions.

This assumes both sides trust each other. The RC side still programs DMA
over PCIe MMIO, so this is expected to pay off for large data transfers.

DesignWare eDMA is the only supported dmaengine backend for now. Other
EPC-local DMA engines can be added if there is a need and they have a
suitable programming interface.

This series does not include a consumer for the dmaengine channels exposed
to RC Linux. Native HDMA support is also left out to keep the series from
growing too large.

Setting pci-epf-vntb's 'dma_bar' configfs attribute enables DMA export.
The default is -1, which leaves it disabled. pci-epf-ntb only switches to
the shared control layout header and is functionally unchanged.

Based on v7.4-rc1. No external patch dependencies.

v9 fixes setup and error-handling issues reported by Sashiko. The data
path and wire format are unchanged.


Proposed merge plan
===================

Patches 1-7 are for the PCI tree, and patches 8-10 for the NTB tree.
The NTB patches need the shared header as updated by patches 4-6.


Compatibility matrix
====================

"Old" means v7.4-rc1 without this series, and "new" means with it
applied. The table describes expected behavior.

  EP                              | Old host     | New host
  --------------------------------+--------------+----------
  Old                             | OK*          | OK*
  New (dma_bar = -1)              | OK*          | OK*
  New (dedicated DMA BAR)         | OK*          | OK
  New (shared MW/DMA BAR)         | OK**         | OK

  *  NTB works without DMA.
  ** NTB works without DMA. An "Old" host treats the whole shared BAR
     as an MW, so the EP falls back to that layout at LINK_UP and the
     DMA ranges are no longer mapped.


Testing
=======

The existing MW-based ntb_netdev path worked with DMA export disabled
(dma_bar = -1) and enabled with the following EP-side BAR settings:

* Dedicated DMA BAR configuration on RK3588 Rock 5B:

  ctrl_bar = 0
  mw1_bar  = 2
  db_bar   = 4
  dma_bar  = 5

* MW-shared DMA BAR configuration on R-Car S4 Spider:

  ctrl_bar = 0
  mw1_bar  = 2
  dma_bar  = 2
  db_bar   = 4

I retested all combinations in the compatibility matrix with ntb_netdev.


Best regards,
Koichiro
---
Changes in v9:
  - Rebase on v7.4-rc1. All prerequisites are now upstream.
  - Fix shared-MW size and alignment handling, and validate the shared
    BAR at bind time. (Sashiko)
  - Reject SETUP_DMA_BAR when DMA export is disabled. (Sashiko)
  - Retest the compatibility matrix on R-Car S4 and RK3588.
  - Link to v8: https://lore.kernel.org/r/20261022082230.3164834-1-den@valinux.co.jp/

Changes in v8:
  - Fall back to exposing the whole shared BAR as an MW for hosts
    without MW/DMA boundary support (ie. "Old" Host), instead of
    rejecting LINK_UP. (Frank)
  - Link to v7: https://lore.kernel.org/r/20261021042229.2280937-1-den@valinux.co.jp/

Changes in v7:
  - Split and reorder the patches for the PCI and NTB trees. (Frank)
  - Reject LINK_UP from hosts without MW/DMA boundary support when
    a BAR is shared. (Frank)
  - Link to v6: https://lore.kernel.org/r/20261020054948.1218370-1-den@valinux.co.jp/

Changes in v6:
  - Add a prep patch that moves the control region layout to
    include/linux/pci-epf-ntb.h, shared by pci-epf-ntb, pci-epf-vntb and
    ntb_hw_epf. (Frank)

For earlier changes, see v5:
https://lore.kernel.org/r/20261009045949.1109871-1-den@valinux.co.jp/

[1] Superseded approach, PCI DMA EPF, v7:
    https://lore.kernel.org/r/20260813063757.3131865-1-den@valinux.co.jp/


Koichiro Den (10):
  PCI: endpoint: Add DMA auxiliary resource metadata
  PCI: dwc: Expose endpoint DMA resources
  PCI: endpoint: pci-epf-vntb: Move epf_ntb_is_bar_used() up
  PCI: endpoint: Add pci-epf-ntb.h for the shared NTB control layout
  PCI: endpoint: pci-epf-vntb: Export endpoint DMA channels
  PCI: endpoint: pci-epf-vntb: Allow DMA and MW to share a BAR
  Documentation: PCI: endpoint: Document vNTB DMA export
  NTB: ntb_hw_epf: Use the shared NTB control layout
  NTB: ntb_hw_epf: Discover vNTB-embedded DMA
  NTB: ntb_hw_epf: Support DMA and MW sharing a BAR

 Documentation/PCI/endpoint/pci-vntb-howto.rst |  34 +-
 MAINTAINERS                                   |   1 +
 drivers/ntb/hw/epf/ntb_hw_epf.c               | 410 +++++++--
 .../pci/controller/dwc/pcie-designware-ep.c   | 107 ++-
 drivers/pci/endpoint/functions/pci-epf-ntb.c  |  85 +-
 drivers/pci/endpoint/functions/pci-epf-vntb.c | 838 +++++++++++++++---
 include/linux/pci-epc.h                       |  34 +-
 include/linux/pci-epf-ntb.h                   |  90 ++
 8 files changed, 1322 insertions(+), 277 deletions(-)
 create mode 100644 include/linux/pci-epf-ntb.h


base-commit: 6628e7d4c6b25c8d18f1345e3a20d21829aae7e4
-- 
2.54.0

