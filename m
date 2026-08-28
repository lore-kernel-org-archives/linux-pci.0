Received: from OS0P286CU011.outbound.protection.outlook.com (mail-japanwestazon11020112.outbound.protection.outlook.com [52.101.228.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0205136A03A;
	Fri, 28 Aug 2026 17:09:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.228.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787936984; cv=fail; b=KLvatoQ2abyGh5RM8/UUG5FODo0GrQ6C5XZD6dnH7uhgm7BUaMgcZD9npg9Tg8OPamPDIR4xwXDYhvF7YFVunM3iTYrWiM5IapJmyWvptWpzj3moPjQO/ezmR5QBXp1m3o78cv5hP0VzfdYxPffzQcuUkilAtBIBeV1KMkatfLk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787936984; c=relaxed/simple;
	bh=dq9Trz35WOPQUEVH3WYQJ5eHItqaP7XbqiCxqsqMuF8=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=DN5HaE8kSLqiqsyVF996oDfTvhTcXGyUL1nrKe33M47TAaDPqSvdm/tUJ6gPd3nJLbuKFdi62/zY+s+tca6RwDQmHEvnWu6Nl4N6cLS0kBn1dm4zc9t9zub2eHB1Yd3sYfu9l+LhdnNw/7ZwqqmX0c4ZSgClYxx+y9+QEvQFTkY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=js2UTgi4; arc=fail smtp.client-ip=52.101.228.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="js2UTgi4"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TPJb5YvmhLuWyPKEEH1/L1/VX+P/4vM+Lp9mMbHqOw4OvdVvotTmVVIGANmUIcwPjDjmDv5MKXT80dALmU3zg0Rk9EeoNqkoLX8XQznTGuaisGbpuE/6W9BWkY5wJfaHDENub19Rhf3gTleOrQicI/fWweAvdj38Chl/aG4xpwZ6J9hBG2KKnSH7nWhO1Wa0TWoW09H2QAP34Q5mFh8zAWpeA8vr5CLbnXv9UeGjsu6dftoS9jELiGbEIW2AU31BLoA+jWj4C6xOuSNaeeUeLUlHSxtAQSE3S6AJgLc3dWyABK38H4tIc9A+XhCCJBuTw+MMc134Zl54HXQfNzUPhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VnoZE/B4+6HtxOWkaXQpCH1dDdijQfYVdL7pfNQ60dY=;
 b=WCNSIPO8B3rhn9Mil0L+GKyLZ0MevsYu1os4rSM4FJmknboQxB/6X7y7ioRyAUnfqF3TGyQFio1zOMjxcGMvj9AE7x5nvSSP6Um9Rn9oxoa3JlK4/8taWFH+2vQ6LjoCm7bL/wdE5mAuLU0Zq+3gH+veQ/VhBMOZnZ1bmisI2YRjxrat90styKCpduFuRqZtb+w78tTkjOhl32f5jT5E8xdtHotZQYuRyNnKElAQCof/+VMbWspi/bjlC1hCNsUocaBLDSd2EHgZMVRZg3FpjVw1cFBRVk1brvCElQFfZ8n4GhqPgz8eEl3+zTL+G4MxGfuB18W2ZBuKjWCBxzza7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VnoZE/B4+6HtxOWkaXQpCH1dDdijQfYVdL7pfNQ60dY=;
 b=js2UTgi4e+nd+Ax4LTgf3mZIh8jzXTUU54C8JZ0GBd3y2+2EjBOBWAk2ewP6xiZYpmO+DKkeGHj+nZvytushJKblayK1lgjIUFXg2idhSyZLskKGEJiAvs+nBv5GZwH0gW0WN6rgxSC4tOX06YfHaXMTcAHvRUhla58wKXovQa0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by TY6P286MB7951.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:3a6::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.11; Fri, 28 Aug
 2026 17:09:39 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%4]) with mapi id 15.21.0360.008; Fri, 28 Aug 2026
 17:09:39 +0000
From: Koichiro Den <den@valinux.co.jp>
To: Manivannan Sadhasivam <mani@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Frank Li <Frank.Li@kernel.org>,
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
Subject: [PATCH v2 0/5] PCI: endpoint: Remote DMA support via vNTB
Date: Sat, 29 Aug 2026 02:09:27 +0900
Message-ID: <20260828170932.2735807-1-den@valinux.co.jp>
X-Mailer: git-send-email 2.51.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY4PR01CA0047.jpnprd01.prod.outlook.com
 (2603:1096:405:372::7) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|TY6P286MB7951:EE_
X-MS-Office365-Filtering-Correlation-Id: 9f04680b-0703-4fd4-c5b1-08df052724cc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|10070799003|23010399003|376014|7416014|1800799024|10067099003|6133799003|56012099006|5023799004|18002099003;
X-Microsoft-Antispam-Message-Info:
	f1QWvK0OZfpirXjjXtvXqSFz0oXUxcolXeJynHxKMw5qzldn4aee1BFBxaH0eWFQknM5qCt0xB6Za1K734ksWEsW8D5X8hgFCTt7LBC+7ibOnp7FodWSn/y1IfIgXoRw+nlv1XTi+D7P73qxCBWZhNtqWKkSgmTPKS8WsWOvK7xMsY2k73lJ1A9F94GEsgRPJODTgAyRPejXmKFcJSFHOoEuXeHPd3kLUMtRKT5cy+VLUKF+Gz/QUdzfOWRNkrX/CPGulbIGN6ZP4755qLlVgMcPMtTPG6PYImGr3hveQEUhZjBoUGlGw5kKHIpPrhOJCcBmqsV/42F7s5XZ2HMoSRIk0rm1o7ZZRA5MbFxn+bxZ2OdFrrY2vsXSX7ULQ5giJNdyc34aIrs3E40nKfRFjp+xYtcdS6VUlv8JU+IoZ6yO/Hqf55juqTNjuF3mWho2Muo7/J0FEBfEvsaDkYJf8hoZin6AFeZ7j0hTjCY2R2YGShPf1cvFglT/VM/UxwhVWDGgl4d3VXAt+xlg5d1Akt+fb9FrX6pjtyPnoeD6XcOZXu5s4BeV+3ldLAbhJrg8rBe/h2MhHhYMUTJavokZm1Ibz5LdOBw7purh99nQBQTLUn9GWYGGPHnhFynB7BkK
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(10070799003)(23010399003)(376014)(7416014)(1800799024)(10067099003)(6133799003)(56012099006)(5023799004)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?xJFSe1zJLIIX6FhTtnlGdr7tjsEL7T6sbsIMpsGxk5c/c7DKF7TI1FYPW9Ts?=
 =?us-ascii?Q?x75Gfdbww6zcgP5erWqjV9qLZp3NJgGN+BT6ocg/RedS85SDjvSDdIz6ILjm?=
 =?us-ascii?Q?+tolg0RVuSHL6/rxNYb0Qu7WIAjDLrmifSVMTbYUlzDim9T8okDejX2mxUAK?=
 =?us-ascii?Q?KBOgV/GmzTlgYrryYZLaDoJD4o4R255R6xG9mISf7KCB2xxOT35UEo1dwIGJ?=
 =?us-ascii?Q?1zAxcCHFxDNAY8f45EEWsxmrs/FQSRVjZnzeM7pHJBj3gxrxRGrjgPb6HV/K?=
 =?us-ascii?Q?u+XY+7rBW+OweUa2Kbr0BmSx1NBqdVY/pkjuLv1ktFIIn0+aypoyrHlgyoTt?=
 =?us-ascii?Q?k3FX1INp4rT9AtHjcPKfmdWos7Yq0RsCisCcon4uhVvY2Av7FY2XeWvkKtsi?=
 =?us-ascii?Q?c27ckTccMqtW57yim8LyPcJ+ofnA/ayTCum/IuuL1JeCqJ1NTCRGQdr4MWs3?=
 =?us-ascii?Q?GccSNWNX44yAtN0m6vgi5/aC0U4/yhgwz3yPPV2ZdYP4v3mlRofn0xklKvIt?=
 =?us-ascii?Q?CKxdzkKl/WragD1Bz7oTqgOGNDf85K1PGehx6nRJkWMc/Qla9eDDJLkrroDN?=
 =?us-ascii?Q?/l1TVdIoCmIQ8PxOPNmYGVwR/K6cZst8AIB1+4AmXfBofpLrJ2aFlwD2R/Rf?=
 =?us-ascii?Q?/BV48EWb6V6fvuaJPwAjUWWrlWi+T9jsLceuAqnh9l4e3F04WpwnUr5Hz0g/?=
 =?us-ascii?Q?5ZnbFocASwX5fnTWsMOjsIeCmG46W7Rhz7SZmfBu9KuyYxeUCl2tSPn32wVM?=
 =?us-ascii?Q?EfWmDNDoZ5kbttcgYLhVHCRhNjXE9zZdSPy0AyWfnLMu+PnLPwnmMWtTS/7o?=
 =?us-ascii?Q?VhfTusksOphLjKtXXkrvcpSBMCSFHUP0zZH8yUoRY1VXF5O56pwwrLNqxhoR?=
 =?us-ascii?Q?Cacpj8a9fuimmxIRulwo8iXmwJ6sI0K9uQLJYa9G1NbHdI32t686Wlv62PYf?=
 =?us-ascii?Q?Q6VAjau1M+RjO+PCrEdU1BV4sjjuk7aLAP30jryOK5I0+3znnG/JKrfa+KNB?=
 =?us-ascii?Q?s8nI2X3FOmFkhzfT7P7OVWR/BRUEYrlDFAcZQuEX1QMyWqDEyQYnw8Xf0Q97?=
 =?us-ascii?Q?KijuozV7NlW6jHnERyvXogCF61LoPwF4CcLsVDaNuaUNEJ3mUx8zbf9VMVW0?=
 =?us-ascii?Q?s5iBswu+H0vuQ6Uq+fHg03XaZ7sdP4FXputUfuOpwA5YObidOdMOCHqQZttd?=
 =?us-ascii?Q?utWDrWS5VqHAfPyf2xk4pCL6x1SjwWRZk0Hvuoj9oZxvo91G7aTwyZi2vohp?=
 =?us-ascii?Q?6bGSHlTbfbKK1+6JXP1aSFSescqn+DItiUEU3vrAMIAOktXicbmytBy2/Gr9?=
 =?us-ascii?Q?NoGTpEMqDYIo892l4g0bQkbmd/HZCH/TdFMIZ2Ua/7gHLv+fFpjK+J2fLMo2?=
 =?us-ascii?Q?Ri3REltWAGx7T06f0w40V5eXQlkLXyvmYqWepWrFeDvc4pWvt0ceWVv/t0ph?=
 =?us-ascii?Q?+WuzN3FtTJJA09AX/BhJy1zaNAlapz4kkTbYSIKKxkNpmwnfBd4ts4bM56Cd?=
 =?us-ascii?Q?E+W77e54o/2YiN3I9aJzhwr2sF1LcITJC9624bJAb07CI9ElFKkwQmdYdpOK?=
 =?us-ascii?Q?5m4vbzqvEoUyh2K0m1nXBrexEieqGQ1ERTiCPIjbALn3l3NfBCLoUpYNnkM/?=
 =?us-ascii?Q?qsvdXuEvukHY0Q8aK/sa25ja4J/b2Ur7D284HAh+wyS3ht33MPJu2vYqSmLz?=
 =?us-ascii?Q?PkZ2J5z1xcte63hCBVEjIPxre7d8+WClRPbkDOk7kqZDQbFN1ifCGbqYOeW6?=
 =?us-ascii?Q?GmgFmbDbAFbLn1q6Al+hXiWN/ZZexNxZ+WR7BVk5hbtII1lJ91V8?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f04680b-0703-4fd4-c5b1-08df052724cc
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2026 17:09:39.0086
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mbN3D4BIDHAomXIsSxgvM+1qxVDiKQgAGQYswG2eFMJwW0Veyg9W62pyaZqRikAzRIXJ4unR2lv8qUlDDCK+rA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY6P286MB7951

Hi,

This series lets an RC use endpoint-local DesignWare eDMA read channels
through vNTB.

It is intended to supersede the separate PCI DMA EPF v7 approach (see
the link below). Since no consumer outside the vNTB/ntb_hw_epf path is
currently known, this rework keeps the DMA export there instead of
maintaining a generic ABI for one use case. It also removes the need for
a second PCI function, allowing this setup on EPCs without
multi-function support.

On the endpoint, pci-epf-vntb reserves the complete eDMA read direction
and exposes those channels as a group. HDMA is not yet supported,
keeping the series minimal.

The DMA feature is opt-in through the pci-epf-vntb configfs attribute
'use_dma'. Without it, no DMA extension is exported. pci-epf-ntb is
unchanged.

Base and dependency
===================

This series is currently based on next-20260827 (3d83758432b5) plus:

  [PATCH v2 0/3] dmaengine: dw-edma: Prepare channels for remote use
  https://lore.kernel.org/r/20260828163611.2691264-1-den@valinux.co.jp/

The prerequisite is for the dmaengine tree and is not part of
pci/endpoint. linux-next provides a common buildable base for both
series. Once the prerequisite lands, this series can be rebased onto
pci/endpoint.

Best regards,
Koichiro
---
Changes in v2:
  - Rewrite most of v1 and move the dw-edma preparation into the
    companion series. Drop the generic pci-ep-dma API, auxiliary-bus
    child/frontend, test ntb client, and preparatory MW-state
    refactoring.
    See individual patch trailers for provenance.
  - Replace v1's post-registration channel-ID cache with driver-supplied
    static IDs. (Frank)
    https://lore.kernel.org/r/abMcgQOHDD55Yv0e@lizhi-Precision-Tower-5810/
  - Let pci-epf-vntb reserve channels with dma_request_channel() and
    configure interrupt routing with dmaengine_slave_config(). This
    removes the PCI EPC DMA delegation API. (Frank)
    https://lore.kernel.org/r/ao2nHoCwfTEEiFSr@SMW015318/
  - Drop v1's dma_offset and dma_num_chans attributes. use_dma now enables
    export of the complete eDMA read direction as a group.

v1:
  https://lore.kernel.org/r/20260312165005.1148676-1-den@valinux.co.jp/

Related PCI DMA EPF v7:
  https://lore.kernel.org/r/20260813063757.3131865-1-den@valinux.co.jp/


Koichiro Den (5):
  PCI: endpoint: Add DMA auxiliary resource metadata
  PCI: dwc: Expose endpoint DMA resources
  PCI: endpoint: pci-epf-vntb: Move epf_ntb_is_bar_used() up
  PCI: endpoint: pci-epf-vntb: Export endpoint DMA channels
  NTB: ntb_hw_epf: Discover vNTB-embedded DMA

 Documentation/PCI/endpoint/pci-vntb-howto.rst |  23 +-
 drivers/ntb/hw/epf/ntb_hw_epf.c               | 360 ++++++++-
 .../pci/controller/dwc/pcie-designware-ep.c   | 107 ++-
 drivers/pci/endpoint/functions/pci-epf-vntb.c | 692 +++++++++++++++++-
 include/linux/pci-epc.h                       |  34 +-
 5 files changed, 1154 insertions(+), 62 deletions(-)

-- 
2.51.0

