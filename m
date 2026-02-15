Received: from TYVP286CU001.outbound.protection.outlook.com (mail-japaneastazon11021111.outbound.protection.outlook.com [52.101.125.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27E7C1624C5;
	Sun, 15 Feb 2026 15:09:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.125.111
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771168163; cv=fail; b=LyaFwEOkMl7prf78Y/eHt7/ySeqRW7ktFBCaN8I2aTbkBL3W1LEy2G1ZmkAr3+r/QT6t+QCsZp+zNVVNgn8mWkfWdxtlIfp+3k5TgTQeY8dOszJ1dMw3PSG8v8LAWuFF+O/OnTzNGM27FPAbc5/oyk0OCe28EqXqWd3kWUSKwTo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771168163; c=relaxed/simple;
	bh=r4MDa2IBQQJeW3mYOkZWcOMmQm0gCsmjMdfXotfh58A=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=dccZ9s+3wjlUMcb04rfFmVQSLMpPTx65yPbloBbyK19UMUpFjNU28ykgY9Pakjfwa39oEJXa8fdIUCKYF/h/XhWeTaUswyZRvyL07N/hFKzLQZziu59bROqkXBQ4GsJIBFlTR843VOBRYCREoPluR8U2H+Zkf1cKz3Tb2EdCqrk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=id/ErmRn; arc=fail smtp.client-ip=52.101.125.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="id/ErmRn"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=y77zz/XHl1HGByyLHU0g5E/eiU+fk+ucG1jSLPqbwJlooa6A6HPpC8ggmdEeKDfBRJ3Dn+r2KyfGSvqiep5W2+QIBU5D2hRQ3kHVNmlQy7V6sES3Ng3TFd+ZKvfjoAW56CY9Rpd7qWNCaLHBS8NLlPrn7JYP8FKTV1OnVeY0PZZdzmlvZkg44wdv8pnKjBUGbTg5OFYtd8xnRHqEnw879G5JG+go7Sp8KHYOoOV5ljNKtEIRIWeqAS84sRFYByKtelfTJVealFaRAeVkVrC5lkSP1HBkNsI71HkgK4nS64GliTW4/KqGEsh0vzvKF+lBzA+kq692n/70u1nLhzHMQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0rO86WfqPClLp4V+bW0Yk82JEs6dwYBJpT6uQxF+L/8=;
 b=dArstfNXTo8QafuPqVMIHXYZwEedOtoqLSOa4VoiAocefgByF8FRcumLO0Ae6Y3q7/b/CqYdIfNxhTKNC9egiwslAuaB5+jqv3hD5kg4NbzXp2aOdkjAh0hqJ7U0yLCUoQij+8cAQrrZxajQSdxAB6IfcQyfqqZpjFCQC/xwlcrxSXH5nh4WuV6yy+ZmEARyjF4H0oR4Dy1Vm+Z0Io2R77YZJi8yCgU2j63/9jHcetZ3A9vz5q7gajq8ehnWNrteHNZyswZypqFGkZQmYoaKzbL4hwbzYVMQXjGvvzCLEVrIDgPmjhMPLtrAW7BjuikKOyQe/3dAl4r014wEhxr0ig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0rO86WfqPClLp4V+bW0Yk82JEs6dwYBJpT6uQxF+L/8=;
 b=id/ErmRnfWv1PpLEIk2jegqBLPl8MbzwaF6tND+ULuh2L1QKDE9fjNoUgy5x/UWTaBFP1BmtwDB0OMzJPR9vygNuJUCHgzFN4xF0F/6W5rcu2rxhoeytiii+UawcjSUYhuPtrDcIC/ZrtqPpg8h12hzRP56FdJoRHK/fWekX8hU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by TY4P286MB7240.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:367::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.16; Sun, 15 Feb
 2026 15:09:20 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%5]) with mapi id 15.20.9611.013; Sun, 15 Feb 2026
 15:09:20 +0000
From: Koichiro Den <den@valinux.co.jp>
To: mani@kernel.org,
	kwilczynski@kernel.org,
	kishon@kernel.org,
	bhelgaas@google.com,
	jdmason@kudzu.us,
	dave.jiang@intel.com,
	allenbh@gmail.com,
	cassel@kernel.org,
	Frank.Li@nxp.com
Cc: linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	ntb@lists.linux.dev
Subject: [PATCH 0/4] PCI: endpoint: Doorbell-related fixes
Date: Mon, 16 Feb 2026 00:09:10 +0900
Message-ID: <20260215150914.3392479-1-den@valinux.co.jp>
X-Mailer: git-send-email 2.51.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY4P286CA0091.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:369::10) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|TY4P286MB7240:EE_
X-MS-Office365-Filtering-Correlation-Id: 5b7d87f3-89c0-4f2c-36bb-08de6ca431f6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|10070799003|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?0jYY3pfWyYIlejvQ6X0EV6OUTUqeaL0jBEoZci86Rxw+juZY563GjRrsZRtf?=
 =?us-ascii?Q?75ZxCo67k2tPeh0CGiPrkrF5rJBVRLeqN5D3RW7gyaRQXJe0N1R1hFZAxrKx?=
 =?us-ascii?Q?+LdU+n2COQHJB4bFJsZFkM3Ay5J9r1QV3cwPf0a/lbL8IbiEKg1UiEw8PFiL?=
 =?us-ascii?Q?OrLg3CxkRe2rr/KenbczeYrmkYyjLktbtbBwt9DPqymLc+7e3XYn2PwgKNDE?=
 =?us-ascii?Q?7uf3jLg9+NcFyMdP7JIsb3CQSfO0gi+tWZn0lWQMGSSS8cz1PhsH3GRdLUSE?=
 =?us-ascii?Q?bsgOORr7bCfPo0VdCexclcmwe/Hs0RJ6xu03iglgFkBmzNNPQ898f14xgUGz?=
 =?us-ascii?Q?GDjPBUQ1RyRZIuoMiiRnvyi21cRDkPH2nzIGePy/f+yCeW4oHugroggTedSP?=
 =?us-ascii?Q?+LUMLWfzvwf7HB4vi9hWqiNJvgQmyEJziFQspwvd/uGtndPk5mIL/HZfSf1d?=
 =?us-ascii?Q?knGjmDn5K88IxqZkd0yYAa5E3cY8G92xbLA8A7CDhG57IRAJc6MKkak1ia9c?=
 =?us-ascii?Q?Tx1Hl1rw3u+9tS7DksaklUKthQQpe2QoSM1GCAu+hcJLAc7aZi64cbzmXFJo?=
 =?us-ascii?Q?cQRZvCu1UlSpxUJngMv3dzWHWM/oh2OmF1TOkuOP0vjFGhNUWq8KZ5jchJjR?=
 =?us-ascii?Q?UHj4xKE/Dq4rZ8IXNFgMdH2uMtEJy0ATJHgUAigaWCQDiwex3uivp0VFSgsO?=
 =?us-ascii?Q?mXMacrETVBn5ea7p18TAT5GP7MHb4DEUyQmHQT8RqzUMb1Vm0R71W8ZJvgn+?=
 =?us-ascii?Q?zijEMg4AVwvGTFX62AMw4gr9Ws/6taLlhZL/a4bRCk3ScNT1PSTqONokd4Q7?=
 =?us-ascii?Q?zI30bIvg92/uXByphBaKRSe711lqW3AKDo2fLbmL7xg7qNwjhc+xUdczlRqg?=
 =?us-ascii?Q?H9DDPaP63ueAW2uQt2V1HII8ULnyKguJmFCJ6fbnXfzaoehgXmj7ZqnilplQ?=
 =?us-ascii?Q?ZmxrDIUjtBdJd0KA7bgiZKdj89MrCI74PJ7Pzq+Z2rOU2GTg59et7k7XWsjY?=
 =?us-ascii?Q?sSRjK8p2e0RzoJHQemKN01NuD/6SYFMTd7tkjxTNkbdg3Z7N3cH9ON7VWA9l?=
 =?us-ascii?Q?VaZDCMIa93VsEPpA9G7xmZax7VqpZebAOS0xqYJ6Ib/B9S3eQURMXwAJe7eI?=
 =?us-ascii?Q?fIRQcqCZH7GeTsT4+1Au3P61cqHc73wrfN4XHdaUDYdr4w1IEEFj7yrH4vmP?=
 =?us-ascii?Q?BzqlRNQSt2eSTtN7AQaNJ4fxzrHeSNx//CSizddJkjTdMNoEMJLM68jl/OHm?=
 =?us-ascii?Q?mj/OO1/473eQzZRkjyk64cGDquDkmKymi2SSVoMRDUC2oj14HMwtLbiGBzbc?=
 =?us-ascii?Q?yU1LYBIOsA//jwofWDFjHFZ1IznCNQ/xUlDqVEUeMe9uX2VKfgS5MHruJhuD?=
 =?us-ascii?Q?vcsWTJXBAH7eJU7vvlbbQfoKhZ8wIqIwg3MW9HwHJTI4Do5sYFrJ+N7MQoqv?=
 =?us-ascii?Q?k8LbrlFI4n9f+5lNOJHEO/KrZ7BwRG5zKb47GvLuZPSomGzpnEM2u/mccAjv?=
 =?us-ascii?Q?NtO++Vx6SoSP6vLRMieK4W53sttxXPSWyfbA8gH8MeyO6ZWRB275ZAkUEXhd?=
 =?us-ascii?Q?jSiEecNfsdIc5NtasgQ=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(10070799003)(7416014)(376014)(366016);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?4OSsxylGmDYsTrYtT9ABk3/mzHOI+iY8KLqdqhxkPPAcgEOnVG+hAiOEYILf?=
 =?us-ascii?Q?+bue34mXkAJcC+PAKlKD1+3opYwLL0vNd1GVYqC7+0dRx3dTRUw1NLLp8IvB?=
 =?us-ascii?Q?YQSw7XRpQvvl+eSfVO5kVo5vL9BakR49z0wJxu/hfjI6uFhyPL4VVmMnb6Ha?=
 =?us-ascii?Q?XsKae9e0/ntb0RGNU1bf3cPrXDyA+fN7LjnaMhthsvMAZlWYx7HUKpsZIrGi?=
 =?us-ascii?Q?rYLwB0M9EqnGbJCjkZU1ZJjnk9ul9kXbOytdJxRmgIy7nGj4Jv8tg3ZMFiUu?=
 =?us-ascii?Q?OFSmwc5RcG9ffA9Ih3XGBiJiplTrmcFb0R5tfDO9oukDpBkS8V+DuT0/rYpH?=
 =?us-ascii?Q?bneofHD0o3HAhHovPKSnMKSCnWTlT8lDM64D2w14ygs607C7HTr/Q/OiW/MQ?=
 =?us-ascii?Q?r6NqPAGwFI6YB+uKFJ9uXNauDMJ9hgD5OGBaogPEGrTYC7fO54I+71Qc3zhi?=
 =?us-ascii?Q?+KhTlxZfvG804AxdL+g9xuhmPqV3jzo9HMMXs1YA53gWkQGtS8v2Z3u/2St7?=
 =?us-ascii?Q?hqqh/yw68qpHk2F4Sz1h/XG5EXd/FmvbRp2fzI29dNbBhxo2lUFOtR1eBfzC?=
 =?us-ascii?Q?xk3lsNcT2ZIR/Jf1Y2L/BATxLIPH+gxrTyPkM6u1etelQe0rouC05jmp4RAk?=
 =?us-ascii?Q?gTZ5AJQMqG7TuMO5Ua9nTE1tFlaRi7zNhYahO3DqBYFnZbzgRYcEuVx+YDJ2?=
 =?us-ascii?Q?/FCK3bOhxcCUVRV8HcN66IdjO8fLs6H12U4IyitRwfOK6ofHE4cSCem8Flbh?=
 =?us-ascii?Q?T6tu55SHLlEO1GyUXQBzHlmIkg7dBPZktmwJQRCCMdE665vUqy++HiSxx0lL?=
 =?us-ascii?Q?BZH3NDapysdBWaTQb6LOOQZtaO+6+VrS8iA2hd6t5ZbcKaT02hZAuiRogOOK?=
 =?us-ascii?Q?plP6ncqqIDMhZo543EuCSO/7c2v8nkIV2I/mSBcz7IlXfRweFNJUnOIn7rkf?=
 =?us-ascii?Q?gYyUvIgzA0rK3OKXq2w3sBeaxl7TEENkFN+IFN1SBtSyxXhdL15J5hJ8X6xc?=
 =?us-ascii?Q?3Bidzw11GTA8GptN0NfLQ7/zlGPl/zmcvQ1Shqy7G5CCZsWM9kXGL/1/sima?=
 =?us-ascii?Q?9JdXGyszvM7XK7MEbeptdssk/cvJW9ef9ggW1t+umV8Bnd5uc9UxeDcn0P5r?=
 =?us-ascii?Q?FS6KahnXQ2p6AlcWvxLQfgaWEND8a/OZPgdQmC0xoIOjxvExF6kD0u/6k5oa?=
 =?us-ascii?Q?QXqPjx8bRzhx9euqKftFhyIAHCZezM5y3A1mo+l2GwCq5g+1+OfcpUj7l35O?=
 =?us-ascii?Q?DoaQOMSAOB6IpbJGGObB8oNCTRHyLiBqrf4zK67PjoyfXHw7J8YkOTjKBZnM?=
 =?us-ascii?Q?OufGmCyCs7O0oVhoSUn+kFm0wOkDD+v7ESIml1g9VHgTX1JOXwXWYVLKqYXO?=
 =?us-ascii?Q?OWFyfIJOzuKIOGtExyY27KDTYpkwgG6NoXGqfy+vfJgRbsVPW+h1vpgvCXlX?=
 =?us-ascii?Q?X3cM4rscYFEypim8i78poM4z/l4eTBOW7w0pligKJHHO1CStHbYlFLOv9wfH?=
 =?us-ascii?Q?55tDFptcVnx0jDgODN9K+YllRKNoU3hXK1ptHw+T/dOe2IHNpcI6zdkANGmp?=
 =?us-ascii?Q?raP4uRiTWePd9tYAeJ3XMXh6p8956e0LSr10i8L7ic59ubWzsMINbWaEyReT?=
 =?us-ascii?Q?I+pOhN4fTcNxvNlDki98bgh+Uqin6eoogV9T8bWvLN/X94xeFhBhzfloE6g9?=
 =?us-ascii?Q?PNRmi7IXcT1Fj9sWkTYLPzuIO+BSeBBac694jnd8SLnGFAy+7FBjJcbCYcdz?=
 =?us-ascii?Q?njWS2ju2llF9HKIl4rSJO8o9rx2wPi/p/LHgaExF2Z+QNMVz2Sgw?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b7d87f3-89c0-4f2c-36bb-08de6ca431f6
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Feb 2026 15:09:20.2417
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZYGssjVbkg1peBpPxOYF7vEFpR3k/jia9L7JkHLAtTA+HCmHbySaciLbnNHyfHDD2FoGHMqkoXEUGOu51tgepw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY4P286MB7240

Hi,

This is a small fix-only series related to the previous (v6)
doorbell-related series:
https://lore.kernel.org/linux-pci/20260209125316.2132589-1-den@valinux.co.jp/

These patches address a few independent fixes in pci-epf-vntb,
pci-epf-test and pci-ep-msi:

  1/4 fixes IRQ unwind in MSI doorbell setup (pci-epf-vntb)
  2/4 adds a bounds check for doorbell BAR offset (pci-epf-test)
  3/4 avoids free_irq() if doorbell IRQ was not successfully requested
      (pci-epf-test)
  4/4 fixes error unwind and prevent double allocation in
      pci_epf_alloc_doorbell() (pci-ep-msi)

These fixes were originally intended to be included in the next revision
of the main series. However, doing so would have grown the v7 series to
around 15 patches, so I am posting them separately to keep the feature
series manageable.

Kind regards,
Koichiro


Koichiro Den (4):
  PCI: endpoint: pci-epf-vntb: Fix MSI doorbell IRQ unwind
  PCI: endpoint: pci-epf-test: Sanity-check doorbell offset within BAR
  PCI: endpoint: pci-epf-test: Don't free doorbell IRQ unless requested
  PCI: endpoint: pci-ep-msi: Fix error unwind and prevent double alloc

 drivers/pci/endpoint/functions/pci-epf-test.c | 12 +++++++++++-
 drivers/pci/endpoint/functions/pci-epf-vntb.c | 11 ++++++-----
 drivers/pci/endpoint/pci-ep-msi.c             |  5 +++++
 3 files changed, 22 insertions(+), 6 deletions(-)

-- 
2.51.0

