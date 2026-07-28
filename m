Received: from OS0P286CU011.outbound.protection.outlook.com (mail-japanwestazon11020115.outbound.protection.outlook.com [52.101.228.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 037FE39EF33;
	Tue, 28 Jul 2026 17:23:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.228.115
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785259396; cv=fail; b=ow+lpbqBYi8I5G2bHztBzwTLkQDukL3thJgdXp+u6OHtTMKNA+AfjeQIJqhzuZ32HjBm6NNvTySWee1IYU+ifH/JF16e1SOn40NeIST3rDR05BKWp8YBMRDbjVVpKoNSzv360r+PwXIwEfP00s2Gnbyjf7Qlrl9e1B2QdhY/x/Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785259396; c=relaxed/simple;
	bh=n4m5q/AzOzVMNfR4YsJzBJFtCd8Jx8umxMRkqsi7oCE=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=NysUuqnS9kMptsp+bOPN67qEagZ4j3+92P5ihH9XHP0NH2oIDMkHFguYTzn6fJUGy7B+jeL1hq681fWVrBgGlcZ38EoK17VsBA48q4VMBXbE1wi52awN2oiAddvEbuxpoYVuABqQbqQbPelsU8HQ8Mu2qz4o0xOTec6tOl4Oy5Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=LSQ0SPqz; arc=fail smtp.client-ip=52.101.228.115
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="LSQ0SPqz"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UhPY3u8eU+lnf9xFlhzCQjH1rXIhuGUh+B9I2zh1pmK1Wscz5poYJ52dTzTfA53bcttBhMqcC46lv9MCjdXMjCF8V5MFUx0q0pYg2LIdL+YXQguNfJEAUzwnpDMAXCJgPlsYv1deuWyr7dAbPbuNesrTE7O1L+iDfH4W6l3LIrK0vyALnSb8HEadjAaJ41/iDUMP0yB3nQG1/mbU7dwsaTSUuCv0MuxHh6V6JYjOrPVglXmq542sf8pNXQTDPL9NCJ2QvNjV+636gOuNE+2WFqIgg48uvVqzXS8RuGCaamPcpuujVoZG+kc8ucb5Tkspy0rChdAQWjWUpdGPRAYicQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=92c17+yLO0JV1v+cR+4P86vlBojSM+RnI7swP5tF5TA=;
 b=rlCKNxdsdwrqG+079gJvKLH/lwhPOIz/h6l7OjjPSxwCWrkmh6JF4pCj3skbsjmE/xMAnIgipYcOVoPPYx3DT6sliE5WCu0MW9CHM7kTaHAi0QMtFmVG7h68pndcEJRnMPVoRj7E09umAQBH9pFR9K/FG6Z/lUdgXTUcBfY9CZLFnQAr02kofqVqjmClggaYYWS46C+0RgKBVA0krlFAQNP6usRCgJ97JiikSxAR45r25Z35TRS2Ta3Uj6UPrcpG6MjFxnaKmglbvJTV+Rq5L3OVIqUA2Wt/BtGuHKWrzseC36e8P8he4TAoSJ39mqsV1B4NsX/Qt8T5Y4Pj8xDy/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=92c17+yLO0JV1v+cR+4P86vlBojSM+RnI7swP5tF5TA=;
 b=LSQ0SPqzQC3oWTv9S/00sU8cbK+PvW3c8KVsuRy4lV2KvxxLjBPWQef7TsaH1lE4MkD11h6aJ89NmAyP9hWays17oCPUZ6T9urHuCI+ZIMXZZFdbccryOO1LbW7hK5TsA/Rq9Ca9tq9o92HhDrXkEPSR4CGsSV7pRdY8Vk0smAs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by TYYP286MB6129.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:1a0::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.12; Tue, 28 Jul
 2026 17:23:10 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%3]) with mapi id 15.21.0245.012; Tue, 28 Jul 2026
 17:23:10 +0000
From: Koichiro Den <den@valinux.co.jp>
To: Manivannan Sadhasivam <mani@kernel.org>,
	Frank Li <Frank.Li@nxp.com>,
	Niklas Cassel <cassel@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Jon Mason <jdmason@kudzu.us>,
	Dave Jiang <dave.jiang@intel.com>,
	Allen Hubbe <allenbh@gmail.com>
Cc: linux-pci@vger.kernel.org,
	ntb@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/3] PCI: endpoint: Support vNTB as a non-first EPF
Date: Wed, 29 Jul 2026 02:23:03 +0900
Message-ID: <20260728172306.2751813-1-den@valinux.co.jp>
X-Mailer: git-send-email 2.51.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY6PR01CA0027.jpnprd01.prod.outlook.com
 (2603:1096:405:3bb::17) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|TYYP286MB6129:EE_
X-MS-Office365-Filtering-Correlation-Id: 644af52c-577f-4d1e-a11d-08deeccce5af
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|10070799003|366016|7416014|376014|23010399003|56012099006|10067099003|6133799003|18002099003;
X-Microsoft-Antispam-Message-Info:
	Jt+doihqF0pzSngUTb0MQkf99iTSNzoKdCGnblh1qquhhhEzqwPJIaGXsmBwauMwbRKYnpQfWSJQPLzoM7waAGo9gQAsBBnjqg9sya7ggIyQixRVHsK/XJoUrneRT64IDsdvnGsi6pmBMBTUuzejJ/8VDNu2g7JrVSKikgf1bzReZTnQxDrL+W32uNhQC5CuWqMM1eAkoHuNhX3pg7iq7T+gRYDfHCtDuFU9aaWf5q1H27wePmuReSmmPaLyFZ+xXaseCybNspHaKXizsZXMZjpHF9mfTah1jDIwhJroV78yr4Pxc7KX7rZ6HMAJdGvHC48HV47vltjtJKUgYAea6FzdaTpbtSD8r/EVGCPhhJxgf/KKhc9gqevpjkhoo7nl+wfWQdOzc3HsIcUXDhgvGAGbnNbXSIbByR/xqpGhYfoDw/wuB05qUl93EBamqnmXr4ovmIVGUIsmxZfQKL2ixyrJvRjCxcOb2ciZ/Un+ktx8Z3TGDLbcS9vqwJVj0z5UOFsVk8q07T47D+1MTRHtpKf4YMfQO/3zuwiWTYUVIZiZir24VEkI+hgO2/atHNQrEKkznOR/9HLflh6bfTNGI3USxvlp/4oCJyFTsH7qZDSXlnAh4cpE0UYDZTKMrO5KqcwMacms/liTfOqbhh9IZmZUzdo61Ai/SA6M+nxjqAw=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(10070799003)(366016)(7416014)(376014)(23010399003)(56012099006)(10067099003)(6133799003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?xTkWMbx9F+cB56Bk/YkGmFtDiYBwCjlEo8Jgg4yQfBw6ceuwMO2mL9VycQFn?=
 =?us-ascii?Q?LxSJH5XcOq4smoe5E1buFXwZxsaZqiLOscmsvD4qJa/4wucCiGPL7r83HRHT?=
 =?us-ascii?Q?8RxljDk3f5MtZvkYPri4QtP/tTUigcocDsjUx4vGazLhP9KTPJSB1zFA3iLr?=
 =?us-ascii?Q?Kj4i0/B/EMFZlwatRvfGiLi7znUGdcc5qXQPnaesUORcS24b1I6dX8TzmI6x?=
 =?us-ascii?Q?xW45HJvEhIEe39UA+9bFGf8XrlBiC1xzYly4jKiFzqHEd/Eo6kMd1AmV2geS?=
 =?us-ascii?Q?3qeMvGvnwoj2b/aqZYMX7+B7lMyhSTBcP7xoTEIZh+6Qt5WF9W+sC+hcd4WY?=
 =?us-ascii?Q?OV5JHdNf5aaYdTIdRj6Ep1VHijXeKtx8M+67hLMHyBw3NDcP1JuJw5ffvJdi?=
 =?us-ascii?Q?p8xtvcjxL+RAHqr2Jxmws46s4/nNMZ3cHVbeKCaMT58S5KA5yhu39UWNMCsM?=
 =?us-ascii?Q?+unvk1pyrYr2P/lc4nKNAM0fWhFXnqvEJiF8b3J0p92Xdux1vAuNaWkmX2qD?=
 =?us-ascii?Q?BJ6lqul5P0p+Xpfv+2pKHvnjp6V9cqvdwFo9fucLzmGtrnFPnC1Cve+H+fBb?=
 =?us-ascii?Q?e+MiiamRlQsgZjXynCR5XEEGzmn+0E/fbWcyUEaa385vi/sz7YrJ8/aHclHC?=
 =?us-ascii?Q?TW8c3UWJJq8G3Ity/hEMNlnFhDHLb6gpS1QdTEQj5zsISFlsP9PBORQxtEr/?=
 =?us-ascii?Q?Cj+iWOizR8vDu4VPDA5MUgKaQM79s/uEQAIKmg6ysOVF2O1gr4HTRbUqlorU?=
 =?us-ascii?Q?sg3RssHd5GGKqkl1xTLL54NFgdgoObNfed1RY1J7WlAj0Rk17uoUyggo78wt?=
 =?us-ascii?Q?pe7pfPYexT9qmftclgTyW/bx5kAIQFnA9CD//Y8R9WgBaipTFopeOLgbizqM?=
 =?us-ascii?Q?lO6g5maaycLdxhrpCES4/AhVLbqQwvbufT2wXNxhWnQF8XI3eUgfoBtS554e?=
 =?us-ascii?Q?DxvnU4pRQwfljg44l8bfvbufF7F8oDbmF++3gnlYCxYIh/IWjwwrmp65UKCO?=
 =?us-ascii?Q?Q29rh/H/avIX0ku2eKr1mx4EzhBS/B3EHrtKD0TAFipdxl/E/H0MdxCg0KG7?=
 =?us-ascii?Q?haaakAWC503OxhqB8rjqHEVxdg2nz7poWNZPWdLBKHoDyE918/4pQDNJFeB4?=
 =?us-ascii?Q?5eRuGh8Fz8CPrNUcnWyljcRbiLKprZeajsMdFZWlFYq1vYmlAB4o26Pg5ZPM?=
 =?us-ascii?Q?bNUtthQklWEvNQt3rzntPo2giYzXZRg3Ot9NKkjEGiwbXqbpaktqjkFzdeRr?=
 =?us-ascii?Q?7uHfitE86DHelp4wqiRMkomRNHmlAviXqUlSf+H19mU3V+BCWyIeirrcqPTp?=
 =?us-ascii?Q?rLGOG6VnTQ4MuhjSczdMVWoCplqeKCoa92BivVLxFK3AM8I5BU/Ps4/8osiu?=
 =?us-ascii?Q?00cvpMGyuTT+OaH3u4zlBJ8VJpfnUqjeRkvjpz6oI/L0PFmggHFbcrNQuumN?=
 =?us-ascii?Q?wyhpY3tAfppxXH4B/1n7w5bCvfnF/g9asCFgNfm6Z1r9yxkFIwvPWzUZwJ0K?=
 =?us-ascii?Q?EM8tLoINHPHfnNpcDAbvqQx019ia7yVHZGkvU7Tn476w2QCSUiSKFyDAA9O0?=
 =?us-ascii?Q?UZVR38NZrwRnuTYu6LrmOx3LjIrkufe+cpHrMZ2TBqJC3JvJWtgD0y+UVfZQ?=
 =?us-ascii?Q?a0tWcoEsf7YaVlhVoXsQrpXMAkdqbXoP8P9MDlMYKQQhQ2U3jag9UC97fBhb?=
 =?us-ascii?Q?Gu4U429pyk1Sb7+g2yO9+flV+ZSwFAlIfR0zveGAqhvYzss3AasbWcJXECDd?=
 =?us-ascii?Q?MB5wi2Q8z5e95IeFQBS78vplN3W9259woVlm54PXrDUmkzp30UWS?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 644af52c-577f-4d1e-a11d-08deeccce5af
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2026 17:23:10.4867
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pSnMjcv6wyRt+jxxJGt77QwREYmsx7RhGZTQ5PFDvmGitX1PLpMaErHuBWLWLoUFUVDTi19nPNa4RPOb6MHhNg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYYP286MB6129

Hi,

This series allows a vNTB endpoint function to be instantiated as PF1+.

vntb_epf_mw_set_trans() programs the memory-window BAR with hardcoded
function numbers (0, 0), so binding the EPF to any other function
programs the wrong one. Patch 1 resolves it.

The platform-MSI doorbell path can currently populate messages only for
the first EPF attached to the EPC. Supporting multiple EPFs in that path
requires separate work. This series leaves it unchanged and lets a
non-first EPF use the embedded doorbell instead.

The embedded-doorbell auxiliary-resource interface is
vendor-independent. Its current DesignWare provider exposes one EPC-wide
source. Since the generic interface cannot identify which EPF's peer
issued a write to a shared source, patch 2 makes the IRQ exclusive.
Patch 3 lets non-first EPFs try the embedded doorbell. If another EPF
has already requested the IRQ, vNTB retains its polling fallback.

I tested the embedded doorbell path on R-Car S4 with the proposed DMA
endpoint function as PF0 and vNTB as PF1.

Best regards,
Koichiro

Koichiro Den (3):
  PCI: endpoint: pci-epf-vntb: Pass PF/VF number when BAR programming
  PCI: endpoint: pci-ep-msi: Make embedded doorbell IRQ exclusive
  PCI: endpoint: pci-ep-msi: Let non-first EPFs use embedded doorbells

 drivers/pci/endpoint/functions/pci-epf-vntb.c |  3 +-
 drivers/pci/endpoint/pci-ep-msi.c             | 40 ++++++++++---------
 include/linux/pci-epf.h                       |  3 +-
 3 files changed, 26 insertions(+), 20 deletions(-)

base-commit: e6ff30150738af5c7aa20fad08b74cbf9b86d3a2
-- 
2.51.0

