Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.195.34
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793905316;
	b=XC3lbU7wN3hVuwFqxiCbwJyRoRL/SABtkcxLuN50lmmmHwBqiTNTrklN3Ag+wTvv8WfN
	 znKCajfSPUTNS/KR5skyBYlbJwqi60mHU/k7qKXV+AFbaagYV5fwGtJTAc7ZuSrVXWonc
	 Lf6LIwe+xIVhtUPYtidQgfbj1eEOWlD6TpBpPiM2HK2YewSpsmRNGf+xYaS1S+SB/yJSX
	 3s4wrRSTv3mJ0h6JYJrSGJ/mI/EckszFcALw5pwXEyn7moBAEtrX1+Dch+7fDYaTdMbTR
	 1VeF7cS9iZUy3ixA1wJE0jDjGBUp1bDAhz3yZdLGfK/hDXcW2dJQb7F2STXS6W0nilA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793905316;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:
	 Content-Transfer-Encoding:Content-Type:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=krIfv4Hq6gEuJcsk14sLtaYUVrCfaXsU57zdCD6BiVE=;
	b=Y2Huvel/WPfGLwu2bZbgijj+hcoHggA4GpDUXmitK93XKPrsFOo+g+dxPXXj7jzKgPZf
	 QjMjq9IrNG8KVG8OoLEq4QOH4mHWQjZsRjScsJWXZG8tF3K94yW4FPmX+n+YvDEmQOscB
	 /6rgNZjZEScVlCuAcKnm6ufrDlUV+rXf/9ADHtwJkR93oaWtgPyLha7Axw2+jfLM6iF7g
	 QRdtZeMgT6J45COriBqF6Y+V7AQ3rEg/lcG9/lB3XqvopXwZjtjfethvJKsjdOBBOWdLH
	 I5FECkbhLV5/O3ROGOcmYzckT+OxyXQfZmcC4tfv8zMPKNZBTFDczTmPBcdLbG1Lb6A==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=pFM+sor4;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.195.34
Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012034.outbound.protection.outlook.com [40.93.195.34])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 749E4606D81F;
	Thu,  5 Nov 2026 19:01:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 749E4606D81F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=pFM+sor4
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=C5CoIKYyEX4UYcUlSrB8141ilkF/siFs+BBOySBjYmj+XF9kY6T+HhK9lnRys8NK7qXg6jNEuz2x80Vjhok9XXVVk41o6zZHS3EPK2zdbYOxLY2LDTibu6RRMeGNNQt6ZYLuNQCJvJNW5mJRU+11W9PS9J9hHlEIFnmsF+Od184zpZ/fLacv2WX7JuxE4SmpmIlW+QolCkol6GgeA9TJwlWwszAVZPcudP7/UbWufdLjW54zB76tAhK3BhmBJJMOPKnwflpjjGZNU5WsVr7Bf+WMbWAgq+iyBKtpCU5X9TixM0cogMFQQhuEme2BuP725T6vbWzszIKIalCdUiRFNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=krIfv4Hq6gEuJcsk14sLtaYUVrCfaXsU57zdCD6BiVE=;
 b=JesZh+/+2HR90xPadPdmeleBSGS7+m07RtNC4Eyceatb0cgegiZhe+Klk1D6Rd9Ua6Sob5dZceY2rRU5BkqlEFCMztZuCAojccArO3RyCCtyao5joGmYT5V2ctZ9vf2p+e/+g4IxPXu2Q9E+zM4lowBIjx0L9OeyuOoxGdlTMfRFSs1LoJ7ybyHrE5Op8hupwp0lWKRqFXXkvPhwnoLCMaxf5KaScnN36FJ2aGZCaKq2LPyDUCx6vyBmjwN1GHSruyJq+T8Bnlr09Q2H5Qat4wLQIKzM4qWloG4nBmeFMFtLonTzesbLh/ZgfVMb9cPbK/5eNcPlOna2Dz+52kglrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=krIfv4Hq6gEuJcsk14sLtaYUVrCfaXsU57zdCD6BiVE=;
 b=pFM+sor46fJqP3k8Cpg529K7W7iaVQzJ1CG0IiIuhJtEDfgrdOiU0d6G5qFkOHEjDtpV3k2MxKQ6mjbbP1VPJY3VpYATfpk85xvNMlu6d/IGxoRh7BQa/mRhNOh6311wGFd9DMT61KxqV/lmwTVDDpAN3JL8ZjRWEa7/0B5SZuaw/oC2HZ8O/OHxxzNMUc+4wcv294j9G2I5g3kE26Oi2xMRme4UxbnAzJSPolKqywb5wIr9JtIJceMbglKSuC5IMCKPlbi0dfpFy9QR6l53gFqlb3OLuDWeiY/LdH50M/nRrpj1n8Rq2/ZI6o0CorUQ8Us+gUuzqD2J7r5AI/9oWQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LY0PR12MB727857.namprd12.prod.outlook.com
 (2603:10b6:408:3ba::5) by LV2PR12MB733495.namprd12.prod.outlook.com
 (2603:10b6:408:423::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.10; Thu, 5 Nov
 2026 18:59:51 +0000
Received: from LY0PR12MB727857.namprd12.prod.outlook.com
 ([fe80::843e:82cd:41ca:f522]) by LY0PR12MB727857.namprd12.prod.outlook.com
 ([fe80::843e:82cd:41ca:f522%5]) with mapi id 15.21.0592.009; Thu, 5 Nov 2026
 18:59:51 +0000
From: Srirangan Madhavan <smadhavan@nvidia.com>
To: Alison Schofield <alison.schofield@intel.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Davidlohr Bueso <dave@stgolabs.net>,
	Ira Weiny <iweiny@kernel.org>,
	Jonathan Cameron <jic23@kernel.org>,
	Vishal Verma <vishal.l.verma@intel.com>,
	linux-cxl@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Li Ming <ming.li@zohomail.com>,
	Joshua Machauer <machaujo@amazon.de>,
	Alex Williamson <alex.williamson@redhat.com>,
	vsethi@nvidia.com,
	alwilliamson@nvidia.com,
	Sai Yashwanth Reddy Kancherla <skancherla@nvidia.com>,
	Vishal Aslot <vaslot@nvidia.com>,
	Manish Honap <mhonap@nvidia.com>,
	Jiandi An <jan@nvidia.com>,
	Richard Cheng <icheng@nvidia.com>,
	linux-tegra@vger.kernel.org,
	Srirangan Madhavan <smadhavan@nvidia.com>
Subject: [PATCH v17 12/19] PCI/CXL: Add CXL Device Reset sequencing
Date: Thu,  5 Nov 2026 18:59:10 +0000
Message-ID: <20261105185917.2667656-13-smadhavan@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261105185917.2667656-1-smadhavan@nvidia.com>
References: <20261105185917.2667656-1-smadhavan@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY5PR03CA0002.namprd03.prod.outlook.com
 (2603:10b6:a03:1e0::12) To LY0PR12MB727857.namprd12.prod.outlook.com
 (2603:10b6:408:3ba::5)
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
X-MS-TrafficTypeDiagnostic: LY0PR12MB727857:EE_|LV2PR12MB733495:EE_
X-MS-Office365-Filtering-Correlation-Id: 86e12e0d-1ba5-407f-cc4f-08df3b6ef8b2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|7416014|376014|366016|1800799024|921020|11063799006|5023799004|261026140227099003|56012099006|261021123027099003|261022105027099003|261021121427099003|261009223027099003|261022075727099003|261102123227099003|261026121527099003|261028144727099003|22082099003|18002099003|6133799003|10067099003|3023799007;
X-Microsoft-Antispam-Message-Info:
	9t4Fg4LZg1j58TQ2HUBPHYIWEj65NElcpxO4HyCeWF6JTbxkHPDRioHrwGIrGSc3NPdV1L3sOWqjOPLov3jWSWQo6MQok+YrSxmbYJkmnQ1JLN9QFpmHHDtbXEBvH1aVoU/i8gNOuYL8eLP1YmgDV0TS4wB7qFH36iz9W1iMNYzJnPUvXkWosFmKRD9ma0wF3loiZaEoWx6x20tagvVn0bBhlzPX6Fzd653Au3A+U36XWgHl4rare07eS/1HGDFhyyhCx6AAz9AIksqPInObDJNgj2wtDc0cfAIfjfp7YTYTtcX041hs/BFBY6KTB0YQtqFu4oHTxMwvd4uugQCTz+BbUjpg8lykYdyK7q33HLI0QhV8IR7auQ7KUyAniM8Z+hvwV2NSMWCZotxMBlXeYEoVey9mXeV7aXc+1wJi0QD1gbaSiupgsOWgp3bZu+ynOCGKmeX9vlg/6yI+zwKwYPnDaqmlJuJRyGzjhrINPLp0jTeXObaLHaKPK6yuZXK2mJNLZUG/2Db2s5ejYaYeaDYMar6ti00G4V8Wd4jQdxUnHXNPoMZVkiWS+Hxzudnf1nGGXXvvarjpBKXitvWqtS7grZj7AC1WV4bioye6nlAJ/Vvt0U5S/vBfvZA1mcA5S6qUPubdOtVifIatwNUEm7Tt9C6BHgTC92hPzoKYn5a0gAVSvPqFyLish2iQsMUfKr2bAmOnMXQ6isXmsL0Lfw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LY0PR12MB727857.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(7416014)(376014)(366016)(1800799024)(921020)(11063799006)(5023799004)(261026140227099003)(56012099006)(261021123027099003)(261022105027099003)(261021121427099003)(261009223027099003)(261022075727099003)(261102123227099003)(261026121527099003)(261028144727099003)(22082099003)(18002099003)(6133799003)(10067099003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?aqg5N5ItPDCGrbgMqTnCGE2gBv3643+8Q0C4BpJjaMROV3LASAF73ubEl7Om?=
 =?us-ascii?Q?C8u0/b7uzaLxl2Z4B21CzhejvxMYTlqG+wD0l0CjdelvpM8XnL6wASCQSUHn?=
 =?us-ascii?Q?FiFxP70PrV61rlZnuxIwhtJ/9dyuQ0qbmIwWE14Dn3zsY2BxNdYxVoGPB2at?=
 =?us-ascii?Q?OP6wp2gNWRCTQvUKxWtwLD39aghJfQLeohY+DCoepajFhA+2mHYN3R31Ly0O?=
 =?us-ascii?Q?mgFkdlI5fHuijn95gXilesxX5ajyXOMW1NTDClSZN9gQNuYfOXGu0zuV0Rwh?=
 =?us-ascii?Q?mewSWoNDoBpX6Nv/tJwfmmPKtFWFKAGm75BNFuQZ7ENBCGLsMdo7D1ckF7RW?=
 =?us-ascii?Q?lPHHYwWJCD68VviHnYlvTH+vWLd4Wd+E3u3Z/n+10zqLU7dm5jVyZictCc/k?=
 =?us-ascii?Q?/GqAzBOI7TKfUCRbYJjmRQBCo6MpSPqRvRZyFX2xloK/86iNat/BN2GSnExs?=
 =?us-ascii?Q?52Q1VJPhDcdVV2RYOpoRkLzIVjXcBUsL4ddEXDhLnNMEdSrNSC1X5ksi2d3n?=
 =?us-ascii?Q?MPix7MEtgkq0TWAV3HjmUy6WphDk2c/cZi9VwS+cJpAyBTchBD+YLeHkbe8k?=
 =?us-ascii?Q?vxL++fiHiNppRBkKIyixm/2RGW3/18oBdPJPDjB2LeWoL38tFB404H+xAts7?=
 =?us-ascii?Q?GgWKXjhbJVbcF1mwJde1TCeuE+BMiKy9V3KPIqw/khXOZGuqQa/Qh3f7N2wq?=
 =?us-ascii?Q?yxdW2L6T/hAA0DzNNew4VZFKVaj+SOzz5dW/rL65N+KZIs/9FIdbWkFjXCmb?=
 =?us-ascii?Q?I7u9wZxApRuSAAdfwbDaJGEWo/NT5gti8tznotBh373SFg2MXk4LyexmWa87?=
 =?us-ascii?Q?s5U36wOLj9FCFDkBDI3RjbfpwP6hE5KGd/4k9V8/TjUCkMHnkg4HCAwkw5Ua?=
 =?us-ascii?Q?1evE7sA5/Io+bD/7VvcsF3Zkkt8vF9LNMJL3cQosjLjZ4VIcRomeh07LU/lE?=
 =?us-ascii?Q?RW4D0lY68NI+3o8XGC0sR3oAKSwt71zIT7abIXPSVaGYSj6e4VwRw+wEkr0m?=
 =?us-ascii?Q?9wB3KHt/WfRxaciCh4A6fzRgMYIYHYahMC2bfuWhulohvP/xmqq/IkmfmgZp?=
 =?us-ascii?Q?aq3W4ky9HTtXdgHAiUqHKEJU0E/W2Ndqs5f/K7b+gkS/BjyIGtCTHr/RPrNz?=
 =?us-ascii?Q?0TFT5Imf7jiWnvyQsQ9Y13JcxhDclz0EGjRZTATk47hfXsFD5LXbGCFB/pwl?=
 =?us-ascii?Q?a3E+sLDDZdk0ZpgqIlK8IoY2nltDbw/egGSH3pFmU1ftvF/zZcISqTgftSrX?=
 =?us-ascii?Q?SsR0Ey8AH+cbCUaIv3LokcVA1OBXCc06+sA6MuMYIe+P54lad/hJ1QwxkcVS?=
 =?us-ascii?Q?cGPvMbSsgw3t1kzsuH9QTSMwvJ/JKBNPeDkcpK0PxryOF8VwhzRppqreU/s8?=
 =?us-ascii?Q?TblPmob+DTzhcOU60t4BdXsshVL062Ihrz49z6hL4pz02bhyweO6W5MDgGKo?=
 =?us-ascii?Q?/3ABnyMpTXvf482cdYeSLPg67DT1YR78WLaLFIyiJ8jQ/t4xPPmg1iK/hB4O?=
 =?us-ascii?Q?2NeL08vI88JjlAnfFi9/aYiJ9iuY63eAp16nLZcIhE7/eCRqgaj2jj6grts0?=
 =?us-ascii?Q?jjW+xyhoHwBnN6HswLhMfh1tojp0DQkNM/ZN1UQL748XeKXBvv0kkuiDOZ9T?=
 =?us-ascii?Q?UQTOXvkQYo8PXcKPNt7DJOaewpHt9pIcORwUuJVeLsb8nTGt9skEFqCDN7M6?=
 =?us-ascii?Q?ySQgNo4sHy0MhUqKGHrbfFX3lQrVX8Tek5ENKU4S3pkTGpxx62mQK7V0hKWH?=
 =?us-ascii?Q?DEE1D4WTuw=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 86e12e0d-1ba5-407f-cc4f-08df3b6ef8b2
X-MS-Exchange-CrossTenant-AuthSource: LY0PR12MB727857.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2026 18:59:51.6080
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QNu8ib7F7eZh9kXcnANputogCd+GYjEWF+EH0DP+wLAwo+GdAaAq/yBv2NZqcije9GUSzQaNdEsB9mzD1RvFTg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB733495

Implement CXL Device Reset for eligible Type 2 devices: disable CXL.cache,
perform supported writeback, drain transactions, prepare the IOMMU,
initiate reset with Memory Clear enabled, and wait for completion.

Observe the 100 ms post-reset quiet period before polling Status2, and
treat an all-ones read as not ready. Wait for the timeout the device
advertises, up to 100 seconds, and access only Status2 until reset
completion, error or expiry, as CXL 4.0 section 9.7.3 requires. Control2
cleanup runs only afterwards. Treat Control2 command bits as
transient state, restore cache policy on exit, preserve the primary error,
and abort when IOMMU preparation fails.

Reuse Device DVSEC discovery from cache initialization and keep the
reset entry point declaration private to PCI core.

Signed-off-by: Srirangan Madhavan <smadhavan@nvidia.com>

---
Changes in v17:
- Wait for the reset timeout the device advertises, up to 100 seconds,
  instead of clamping it to 20 seconds, so that Control2 is not accessed
  while the device may still be resetting. The warning for an unknown
  timeout encoding now reports the timeout used (Richard)
  https://lore.kernel.org/linux-cxl/auQC2UECQ8vaelPz@MWDK4CY14F/

Reference branch: https://git.kernel.org/pub/scm/linux/kernel/git/djiang/linux.git/commit/?id=04f8f84816d724f8b47f4d47a77916ac37c63a49
---
 drivers/pci/cxl.c             | 244 +++++++++++++++++++++++++++++++++-
 drivers/pci/pci.h             |   5 +
 include/uapi/linux/pci_regs.h |  12 ++
 3 files changed, 260 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/cxl.c b/drivers/pci/cxl.c
index a0d20f4210a5..9ac5948f595b 100644
--- a/drivers/pci/cxl.c
+++ b/drivers/pci/cxl.c
@@ -3,13 +3,17 @@
 /*
  * CXL reset support in the PCI core. Cache the HDM decoder state of a CXL
  * memory device at enumeration, so it can be restored after a reset without
- * a CXL driver. HDM register formats and programming live in drivers/cxl.
+ * a CXL driver, and implement CXL Device Reset. HDM register formats and
+ * programming live in drivers/cxl.
  */
 #include <linux/bitfield.h>
 #include <linux/cleanup.h>
+#include <linux/delay.h>
 #include <linux/errno.h>
 #include <linux/io.h>
 #include <linux/ioport.h>
+#include <linux/iommu.h>
+#include <linux/jiffies.h>
 #include <linux/kernel.h>
 #include <linux/pci.h>
 #include <linux/slab.h>
@@ -223,3 +227,241 @@ void pci_cxl_hdm_cache_release(struct pci_dev *pdev)
 {
 	cxl_hdm_cache_release(&pdev->hdm);
 }
+
+/*
+ * CXL r4.0 sec 9.7.2 defines the reset completion timeout encodings.
+ * Sec 9.7.3 leaves config-space access behavior undefined for 100 ms after
+ * initiating CXL Reset, then limits software to CXL Status2 access until
+ * reset completion, timeout, or error. Wait for the full advertised timeout
+ * so that Control2 is not accessed while the device may still be resetting.
+ */
+#define CXL_RESET_RRS_WAIT_MS 100
+#define CXL_RESET_STATUS_POLL_MS 20
+static const u32 cxl_reset_timeout_ms[] = {
+	10, 100, 1000, 10000, 100000,
+};
+
+/*
+ * CXL 4.0 section 9.6 permits using the device cache size to determine
+ * a timeout. Use a conservative fixed estimate of 100 ms.
+ */
+#define CXL_CACHE_WBI_TIMEOUT_US 100000
+#define CXL_CACHE_WBI_POLL_US 100
+
+#define CXL_RESET_CTRL2_CMD_MASK \
+	(PCI_DVSEC_CXL_INIT_CACHE_WBI | PCI_DVSEC_CXL_INIT_CXL_RST)
+
+static int cxl_reset_update_ctrl2(struct pci_dev *pdev, int dvsec,
+				  u16 set, u16 clear)
+{
+	u16 ctrl2;
+	int rc;
+
+	rc = pci_read_config_word(pdev, dvsec + PCI_DVSEC_CXL_CTRL2, &ctrl2);
+	if (rc)
+		return pcibios_err_to_errno(rc);
+	if (PCI_POSSIBLE_ERROR(ctrl2))
+		return -ENODEV;
+
+	/*
+	 * INIT_CACHE_WBI and INIT_CXL_RST are commands. Do not replay a command
+	 * that remains set in the value read back while updating persistent
+	 * Control2 state.
+	 */
+	ctrl2 &= ~CXL_RESET_CTRL2_CMD_MASK;
+	ctrl2 &= ~clear;
+	ctrl2 |= set;
+
+	rc = pci_write_config_word(pdev, dvsec + PCI_DVSEC_CXL_CTRL2, ctrl2);
+	if (rc)
+		return pcibios_err_to_errno(rc);
+
+	return 0;
+}
+
+static int cxl_reset_wait_cache_wbi(struct pci_dev *pdev, int dvsec)
+{
+	unsigned long deadline;
+	u16 status2;
+	int rc;
+
+	rc = cxl_reset_update_ctrl2(pdev, dvsec,
+				    PCI_DVSEC_CXL_INIT_CACHE_WBI, 0);
+	if (rc)
+		return rc;
+
+	deadline = jiffies + usecs_to_jiffies(CXL_CACHE_WBI_TIMEOUT_US);
+	while (time_before(jiffies, deadline)) {
+		usleep_range(CXL_CACHE_WBI_POLL_US,
+			     CXL_CACHE_WBI_POLL_US * 2);
+
+		rc = pci_read_config_word(pdev, dvsec + PCI_DVSEC_CXL_STATUS2,
+					  &status2);
+		if (rc)
+			return pcibios_err_to_errno(rc);
+		if (PCI_POSSIBLE_ERROR(status2))
+			return -ENODEV;
+		if (status2 & PCI_DVSEC_CXL_CACHE_INV)
+			return 0;
+	}
+
+	pci_warn(pdev, "timed out waiting for CXL cache writeback and invalidate\n");
+	return -ETIMEDOUT;
+}
+
+static int cxl_reset_disable_cache(struct pci_dev *pdev, int dvsec, u16 cap)
+{
+	int rc;
+
+	rc = cxl_reset_update_ctrl2(pdev, dvsec,
+				    PCI_DVSEC_CXL_DISABLE_CACHING, 0);
+	if (rc || !(cap & PCI_DVSEC_CXL_CACHE_WBI_CAPABLE))
+		return rc;
+
+	return cxl_reset_wait_cache_wbi(pdev, dvsec);
+}
+
+static int cxl_reset_restore_cache_policy(struct pci_dev *pdev, int dvsec,
+					  u16 saved_ctrl2)
+{
+	int rc;
+
+	rc = cxl_reset_update_ctrl2(pdev, dvsec,
+				    saved_ctrl2 & PCI_DVSEC_CXL_DISABLE_CACHING,
+				    PCI_DVSEC_CXL_DISABLE_CACHING);
+	if (rc)
+		pci_err(pdev, "failed to restore CXL cache policy: %d\n", rc);
+
+	return rc;
+}
+
+static int cxl_reset_wait_done(struct pci_dev *pdev, int dvsec, u16 cap)
+{
+	unsigned long deadline;
+	u32 timeout_ms;
+	u16 status2;
+	int idx, rc;
+
+	idx = FIELD_GET(PCI_DVSEC_CXL_RST_TIMEOUT, cap);
+	if (idx >= ARRAY_SIZE(cxl_reset_timeout_ms)) {
+		idx = ARRAY_SIZE(cxl_reset_timeout_ms) - 1;
+		pci_warn(pdev,
+			 "unknown CXL reset timeout encoding; using %u ms\n",
+			 cxl_reset_timeout_ms[idx]);
+	}
+
+	/* Allow one retry after the mandatory 100 ms quiet period. */
+	timeout_ms = max_t(u32, cxl_reset_timeout_ms[idx],
+			   CXL_RESET_RRS_WAIT_MS + CXL_RESET_STATUS_POLL_MS);
+	pci_info(pdev, "CXL reset timeout: %u ms\n", timeout_ms);
+	msleep(CXL_RESET_RRS_WAIT_MS);
+	deadline = jiffies + msecs_to_jiffies(timeout_ms -
+					      CXL_RESET_RRS_WAIT_MS);
+
+	for (;;) {
+		rc = pci_read_config_word(pdev, dvsec + PCI_DVSEC_CXL_STATUS2,
+					  &status2);
+		if (rc)
+			return pcibios_err_to_errno(rc);
+		if (status2 != U16_MAX) {
+			if (status2 & PCI_DVSEC_CXL_RST_ERR)
+				return -EIO;
+			if (status2 & PCI_DVSEC_CXL_RST_DONE)
+				return 0;
+		}
+
+		if (time_after_eq(jiffies, deadline))
+			return -ETIMEDOUT;
+
+		msleep(CXL_RESET_STATUS_POLL_MS);
+	}
+}
+
+static int cxl_clear_memory(struct pci_dev *pdev, int dvsec, bool initiate)
+{
+	if (initiate)
+		return cxl_reset_update_ctrl2(pdev, dvsec,
+					      PCI_DVSEC_CXL_INIT_CXL_RST |
+					      PCI_DVSEC_CXL_RST_MEM_CLR_EN,
+					      0);
+
+	return cxl_reset_update_ctrl2(pdev, dvsec, 0,
+				      PCI_DVSEC_CXL_RST_MEM_CLR_EN);
+}
+
+static int __cxl_reset_execute(struct pci_dev *pdev, int dvsec, u16 cap)
+{
+	int rc, rc2;
+
+	if (!pci_wait_for_pending_transaction(pdev)) {
+		pci_err(pdev, "timed out waiting for pending transactions\n");
+		return -ETIMEDOUT;
+	}
+
+	rc = pci_dev_reset_iommu_prepare(pdev);
+	if (rc) {
+		pci_err(pdev, "failed to stop IOMMU for CXL reset: %d\n", rc);
+		return rc;
+	}
+
+	rc = cxl_clear_memory(pdev, dvsec, true);
+	if (!rc)
+		rc = cxl_reset_wait_done(pdev, dvsec, cap);
+
+	/* Always clear Memory Clear; successful cleanup must not hide reset failure. */
+	rc2 = cxl_clear_memory(pdev, dvsec, false);
+	if (rc2)
+		pci_err(pdev, "failed to clear CXL Reset Memory Clear: %d\n", rc2);
+	rc = rc ?: rc2;
+
+	pci_dev_reset_iommu_done(pdev);
+	return rc;
+}
+
+static int cxl_reset_execute(struct pci_dev *pdev, int dvsec, u16 cap)
+{
+	u16 saved_ctrl2;
+	int rc, rc2;
+
+	rc = pci_read_config_word(pdev, dvsec + PCI_DVSEC_CXL_CTRL2, &saved_ctrl2);
+	if (rc)
+		return pcibios_err_to_errno(rc);
+	if (PCI_POSSIBLE_ERROR(saved_ctrl2))
+		return -ENODEV;
+
+	rc = cxl_reset_disable_cache(pdev, dvsec, cap);
+	if (!rc)
+		rc = __cxl_reset_execute(pdev, dvsec, cap);
+	/* Restore cache policy after any attempt to disable caching. */
+	rc2 = cxl_reset_restore_cache_policy(pdev, dvsec, saved_ctrl2);
+	return rc ?: rc2;
+}
+
+int cxl_reset_function(struct pci_dev *pdev, bool probe)
+{
+	u16 dvsec, cap, ctrl;
+	int rc;
+
+	rc = cxl_pci_device_dvsec(pdev, &dvsec, &cap);
+	if (rc)
+		return rc;
+	if (!(cap & PCI_DVSEC_CXL_CACHE_CAPABLE) ||
+	    !(cap & PCI_DVSEC_CXL_MEM_CAPABLE) ||
+	    !(cap & PCI_DVSEC_CXL_RST_CAPABLE) ||
+	    !(cap & PCI_DVSEC_CXL_RST_MEM_CLR_CAPABLE))
+		return -ENOTTY;
+
+	rc = pci_read_config_word(pdev, dvsec + PCI_DVSEC_CXL_CTRL, &ctrl);
+	if (rc)
+		return pcibios_err_to_errno(rc);
+	if (PCI_POSSIBLE_ERROR(ctrl))
+		return -ENODEV;
+	if (!(ctrl & PCI_DVSEC_CXL_CACHE_ENABLE) ||
+	    !(ctrl & PCI_DVSEC_CXL_MEM_ENABLE))
+		return -ENOTTY;
+
+	if (probe)
+		return 0;
+
+	return cxl_reset_execute(pdev, dvsec, cap);
+}
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 9e218f236e66..743e65abd758 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -733,9 +733,14 @@ static inline void pci_doe_disconnected(struct pci_dev *pdev) { }
 #ifdef CONFIG_CXL_RESET
 void pci_cxl_hdm_cache_init(struct pci_dev *pdev);
 void pci_cxl_hdm_cache_release(struct pci_dev *pdev);
+int cxl_reset_function(struct pci_dev *pdev, bool probe);
 #else
 static inline void pci_cxl_hdm_cache_init(struct pci_dev *pdev) { }
 static inline void pci_cxl_hdm_cache_release(struct pci_dev *pdev) { }
+static inline int cxl_reset_function(struct pci_dev *pdev, bool probe)
+{
+	return -ENOTTY;
+}
 #endif
 
 #ifdef CONFIG_PCI_NPEM
diff --git a/include/uapi/linux/pci_regs.h b/include/uapi/linux/pci_regs.h
index ca3e77b72d87..7224857c7b30 100644
--- a/include/uapi/linux/pci_regs.h
+++ b/include/uapi/linux/pci_regs.h
@@ -1352,10 +1352,22 @@
 #define   PCI_DVSEC_CXL_CACHE_CAPABLE			_BITUL(0)
 #define   PCI_DVSEC_CXL_MEM_CAPABLE			_BITUL(2)
 #define   PCI_DVSEC_CXL_HDM_COUNT			__GENMASK(5, 4)
+#define   PCI_DVSEC_CXL_CACHE_WBI_CAPABLE		_BITUL(6)
 #define   PCI_DVSEC_CXL_RST_CAPABLE			_BITUL(7)
+#define   PCI_DVSEC_CXL_RST_TIMEOUT			__GENMASK(10, 8)
 #define   PCI_DVSEC_CXL_RST_MEM_CLR_CAPABLE		_BITUL(11)
 #define  PCI_DVSEC_CXL_CTRL				0xC
+#define   PCI_DVSEC_CXL_CACHE_ENABLE			_BITUL(0)
 #define   PCI_DVSEC_CXL_MEM_ENABLE			_BITUL(2)
+#define  PCI_DVSEC_CXL_CTRL2				0x10
+#define   PCI_DVSEC_CXL_DISABLE_CACHING			_BITUL(0)
+#define   PCI_DVSEC_CXL_INIT_CACHE_WBI			_BITUL(1)
+#define   PCI_DVSEC_CXL_INIT_CXL_RST			_BITUL(2)
+#define   PCI_DVSEC_CXL_RST_MEM_CLR_EN			_BITUL(3)
+#define  PCI_DVSEC_CXL_STATUS2				0x12
+#define   PCI_DVSEC_CXL_CACHE_INV			_BITUL(0)
+#define   PCI_DVSEC_CXL_RST_DONE			_BITUL(1)
+#define   PCI_DVSEC_CXL_RST_ERR				_BITUL(2)
 #define  PCI_DVSEC_CXL_RANGE_SIZE_HIGH(i)		(0x18 + (i * 0x10))
 #define  PCI_DVSEC_CXL_RANGE_SIZE_LOW(i)		(0x1C + (i * 0x10))
 #define   PCI_DVSEC_CXL_MEM_INFO_VALID			_BITUL(0)
-- 
2.43.0

