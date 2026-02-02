Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazon11020128.outbound.protection.outlook.com [52.101.229.128])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 289CC372B2F;
	Mon,  2 Feb 2026 14:54:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.229.128
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770044057; cv=fail; b=RIrgZASGED4TvxJiJg4gc4jMcUHSvzYI1W+61+RHcQDEA6HeIZtFXcJKKQ5lNe1q0nCM2XivyMfO6EbXlQI/RC+jjjk0EpQKbwYvUAWvu1nwdiFnJgDJoQMP8mjYtAuap5jI/h9sf+5fsuYdTsz1TdtoD8B9bMhxPKyDA/Jw59Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770044057; c=relaxed/simple;
	bh=UclqMHu3pNKLk2knrJa991cGuRQ8xDdtbY5N807hZdw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=WGyzvpNQN32IT0m9ZtBkz02OGzYjiISP2mrPUzchYqyO+OF7WBroIFOy242QS39ZL66fBkm8eKn3yW8ipbB+pOUNc8wA4ve25N//yZz+jwaN+apA+Xp9A5qK9ij7hkP8efGyJri828ZyEt03rhOZHC/phKYkvri2VuIRs9whoXE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=VlVjDX8x; arc=fail smtp.client-ip=52.101.229.128
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="VlVjDX8x"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vsscqaH6eceXGGx46mm3+G/nvHV4SufR1O+x9LllwP53xm81flxOlEjOhV1nowdfScXRw/5zgKVjs15aXPCpDcCzfKIMbEGPTWGjZfleSp0gLr4GRq6reh9/bn0+IZHAG7qYaPyuxo1qEvYt/w71e4qaSu62kfzeRAXyaLrUeDwvqy6rDuNkY9Zx5XvASkouY1rYaue4VAK4O1YCFdLXF+O0f/PBG4hLFBEY8kRiAnSrAE0Ocz2Osf2NITjZVtTkVBOKcbQQL4Ym+5taVr16r5S5FTti4JApD/I+VkGwbczPDro8RLob/3fkoQEp63xkmiX7OdJb7AxWEaDCUUKFmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CRLYnC9tFwYsvxbd/UXODFYvMJQIpxjC5Z8qbMrrzvo=;
 b=OqdAY1ssadVximwdhLTreto3ftCvyrWRoi9vRayB38AekJnwjXk9Nn3qJ6CPw+nkp1MFcm6nJsjaezlCEE2nmMZP1tptXYFp8KujWxr+avWOngpmRClXgYpss3B/UnvxjODzFKr0NAN6L8PrNQpys9gcWvvGzODVhx2HeWImM7oErkxmPBpQtaUOb2lgEubgGFe9p/V9Y0sTrgUc17ZfqVN/C2neeDG9+2WlSSF1toemvxkFA+HecB9d2PUqzyvhqXCDLRoBYTufHYBrGmxtYvoBp3klM1Sq4ryJ83XqfS7csGfdbwOrONoaugOy9DdnuWlEP9dPdCJlBE77E9ZHwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CRLYnC9tFwYsvxbd/UXODFYvMJQIpxjC5Z8qbMrrzvo=;
 b=VlVjDX8xoGfsk4UKhDz38VzjjAo2lZGvPOIRviLKJn3jTmRExbfb2Az7e3333EgMaJ6omSE+/c1DnZYRijizNFU2JVlmvkEQrdaGA6gVfkTj3hQshkfrF9GyKCF8Izwl/M1GBNlSqn57Ip5RRBsKlFK4ZcGTX867nyvyN57VhHw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by TYCP286MB2195.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:15d::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.15; Mon, 2 Feb
 2026 14:54:11 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%5]) with mapi id 15.20.9564.016; Mon, 2 Feb 2026
 14:54:11 +0000
From: Koichiro Den <den@valinux.co.jp>
To: mani@kernel.org,
	cassel@kernel.org,
	kwilczynski@kernel.org,
	kishon@kernel.org,
	bhelgaas@google.com,
	corbet@lwn.net,
	jingoohan1@gmail.com,
	lpieralisi@kernel.org,
	robh@kernel.org,
	Frank.Li@nxp.com
Cc: linux-pci@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/2] PCI: dwc: ep: Return after clearing BAR-match inbound mapping
Date: Mon,  2 Feb 2026 23:54:06 +0900
Message-ID: <20260202145407.503348-2-den@valinux.co.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260202145407.503348-1-den@valinux.co.jp>
References: <20260202145407.503348-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0134.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:2b6::16) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|TYCP286MB2195:EE_
X-MS-Office365-Filtering-Correlation-Id: d1e903a5-fb48-492c-080b-08de626aecf9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|366016|1800799024|10070799003|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?nOnkL/LEd3SELP9pWGeYMBMiSkWrOqJz5zvmg2kZmpgliAdk2BAf/Bvn5y9l?=
 =?us-ascii?Q?UeSpuhYlLJ1wwkU3VL6IAJdEzKRqH8+froD7wv6g+gd2G/nUbcIoJBvfyiHi?=
 =?us-ascii?Q?FupwfISZFIowRwgWaWfvMAmOwi8Z9/zKNP8DiEuj3cgxx87cZmmidYTYTbK5?=
 =?us-ascii?Q?TpxnkprOFCHwTX1IQuacoZA0xAzs3nkdDg2dbN9leUQepIyLZUKkkQb2Fq6m?=
 =?us-ascii?Q?wj1i8+zsLDPSBHxwrHSUQg2tfogAfst3QBuD95s6LmMuttKJrx5BxMcUbFxZ?=
 =?us-ascii?Q?Jwl9c8R31LYk8+xsINai0AyvzZUZEhE5XVXk7gPB5EZqF8ovytVpE5fIXrap?=
 =?us-ascii?Q?CrdiDwy9IwnS8B+oSYXXxb9GDPBjpaDGti38vQlRhdgZaxmbqz+J8M17xnyX?=
 =?us-ascii?Q?TIyCjvJVG1mWEAdVl6BGdObs5MsPDdf2x6SENyLod0EY2qSvQI/320J9KAjQ?=
 =?us-ascii?Q?FIP2Z3hD4q/W6Oz/7ZjPoo6hzqAFp8kMwc+YeOQwQtvX/fqWvqwHWQpqu0jL?=
 =?us-ascii?Q?CO6gK/Nd1WIr1Vdgk4tYGE0n5ZyZCzuhebORH4gJCKPMjH5JOKNSIdxHSD/K?=
 =?us-ascii?Q?dwbnnx4T+KskEkgEAawz+qw1o+uncyb0jr+UcltwzVClL//OC9C1Q0n/3tW6?=
 =?us-ascii?Q?HEg7JGM9xqHbET36YnwSVbWRKSKEQfmdISv7nFhdlPO/HOb5sqg3KFjo6RO5?=
 =?us-ascii?Q?ohd1DKGR0Ni6K0PdD736qNR5BOV150NX7AFc1rSuaJpln+zMX1pciK5KG6c/?=
 =?us-ascii?Q?rbtBtVnJw8ohaCCDd0UzkCyArYiciYBc5Dd7k8RO26nZFi0ta2zWCtjG64J0?=
 =?us-ascii?Q?bjoW++QOCYa00Z7ZUs3torv6twe28OIl4hdat18t6PWHRcusapqsIeZpP3g9?=
 =?us-ascii?Q?FUJ/M5Yp2JHTmNZ8aLi9vlR5Bzxngklq1EAYm7LC3m3ATtAin0zhy89TSzCl?=
 =?us-ascii?Q?ABn0VuKQwI63Gb7zzCtzs334SJYxe5WK4Jmt/6pQPkb/8EaxQ3hPwigNCKhb?=
 =?us-ascii?Q?wdcRonUMM95fxFEuNwW2reGk7sHwAoOkVZZqIN5zs8vGJiuZ2NeMKn/EcIo2?=
 =?us-ascii?Q?ZvLVucJuAu7njIhi4dVWyZ4oqLDYbB4y+p+YtCy86m6ORMMzZHltzk6/KwgI?=
 =?us-ascii?Q?dmxME6q3jyCdCYD9hCifLwavklXvdnR1WVIlOruPA3yGy08D1KVOaYLZLRPB?=
 =?us-ascii?Q?YTR+ta76smjl8rU7Wj4H1Z7NlVtUxQ7yEH3hxOSFKHWlWeVM0VQESzUQL/WI?=
 =?us-ascii?Q?p5dNZCn8WgvmwkVz121drstCJrtACKpItUIAeKYoHgrofl92JobT+vC/fwXb?=
 =?us-ascii?Q?REZdohdIgISw2hQJLIjiYRYKloWFr9emSInFZ7Qq2OT/ep1DmWOPg5Z+pRe/?=
 =?us-ascii?Q?atWWTjH0yVzvuuAJYiTQlmX1TEHzK8ReHgT0b2JSnzP3XdT+paQvDtNFSZCz?=
 =?us-ascii?Q?KHp/USFX87FKMZJ3VhyBB+QQGcPLVzQi0Ze6dcWFxRG3xidpPat69JtIFWfO?=
 =?us-ascii?Q?8OGBVVbrOoxyTtv5r8xqdGJotCtNditDy3wI0EOvlT9QFD5HJpG9BG/aTy7h?=
 =?us-ascii?Q?dCnFWqvwYuj5lt2Y0BF1Lq+B4kddGJlGF4bPAr7By8Lt9TBnlZ6j5bJfXrmJ?=
 =?us-ascii?Q?cg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(10070799003)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?lJWhOY7hk4lgYICE666mh9V8McjtIHVL1M1aAl1f6UysVlUB099dK1YGD+lp?=
 =?us-ascii?Q?5tRM3X3cVYcqhp52lOgRvUdNtqcSXU2ccCDlvJjB0klbPoiv6Qk1LTlCdgPX?=
 =?us-ascii?Q?0nMMUAT4M/ISXaqYRH+h5Bmcdx3Nwy2IEPBgbXywvGGWctDDlTelvi7KgCbm?=
 =?us-ascii?Q?Gas2XdPC/oC0Yhl3yaO8CJyajA7G6Zc/G8XT+BZSQH0O9mQF6mgcvMzdHI8Q?=
 =?us-ascii?Q?+/eeGQHpfwn8hJT7lPm6N0phL2jJ7awcPwW9JpRZJqdbGKVh9QauLUXdVqNS?=
 =?us-ascii?Q?JSb9+Ct1xmvhTtNya8elyWmiDVRaE0hnHuv2s3xTVy6b4ZxGYfFENYO6Akv0?=
 =?us-ascii?Q?GrHZE26d3P3BTUsEO5oK6YF9ypNgc3idumTMDMDyu1Hr3Huh0qYXcBZ1n1u+?=
 =?us-ascii?Q?n4Asn/c3w6RkL90rncIXhf3vUV+MpltnlBjTssxU0nbnizyxF2tueo9faT1q?=
 =?us-ascii?Q?CAycMB2O3WsZEKNOR3k8bYfqSFvgQA8u60lHigZDCpcTy7c3+2SGKdyusLPa?=
 =?us-ascii?Q?vQDi53SGisy/KsCbo4j8cXYnANmD4S7L8PUbeNrH4K/RCg2VJdwNhdrKDPcM?=
 =?us-ascii?Q?kQZR0wG95u0GmN5se0CtP92g9h9Fpr7GQ548Lm+WtH5eVZKJk/qgMR0o6c95?=
 =?us-ascii?Q?FxZwgV5G9Sq90ueMryDSOcON/KZotxLEmwGCpp0HyXUUPoyGXAeuxPrvxof4?=
 =?us-ascii?Q?habP6aXg6+0b18liKsv1WAsziSqabLNsgmyDi3KC+9JQ5QludGvCEE8F9iKe?=
 =?us-ascii?Q?vN7nS/ObkiQDuSReMVKRCRhhZoRmOXV5wuk7r+4Qxsn5gXPA2FbO9lSv58qx?=
 =?us-ascii?Q?xy1y4nOTkOxVSIiCwxk8GgS7CnYLUx4FdWkf/g09V4OL3Dltw+tiggRUtpfy?=
 =?us-ascii?Q?kGIjxqVlPSTbXuI4r2bwjoH6IJWzUY0Cl5vtSuzcANbUudNsMJsNgdQJrVhZ?=
 =?us-ascii?Q?AYWf/bgWvCjI9xOEtn+Yq4K19AE5kz83V4jLp8Us0tD7Mgr6DiVODzub/CXQ?=
 =?us-ascii?Q?Sp3X7VZYPrLs0ezMmmgan9VvUNS5Qhy7Yi5WTIQIORMEJdwzIYB388JWo08R?=
 =?us-ascii?Q?YqOcjB06frzGK3a7JT/2VbZOlVPTnI9gyjIZjX/kDhoMX93FZ1YZm8zlEn9D?=
 =?us-ascii?Q?9uhEQvkCWSkWtV9m0afONkfFVLLNDxyoD6W3dtS3TVNLKbHS6D6jQBOwkzyg?=
 =?us-ascii?Q?41U1jRi/n2WbEAgsZqnMz/Zf2NY5YSaj4cD7CJfZYIaUkeJt4sR2giBlhEVv?=
 =?us-ascii?Q?2sJzv9H6032ObQQ4JH+yv048XdldVstsPi3tG+bUKC041TA7bp9bATUcQlUD?=
 =?us-ascii?Q?6C+rz55nGIOex7VC/H8Kn8DlGJwm/LJNA55CFESAEtAR1iZuEXcdbr11AqG6?=
 =?us-ascii?Q?y8G/I47LGcIxGTmQP7PJUXXhOsYz6eBQTR5vzp23pUIBTUyKMvf5swpoOabY?=
 =?us-ascii?Q?dYbDcBQ+tvJwlGykg9FOFUgNJ4qrT/W+rP++Qw2xpiiE0GJxKi0+yzpknhi9?=
 =?us-ascii?Q?fot14PKVL8Bp6d/L+Ld5WmzbxkvtVXwVS6UaKM39VxbuigK7rsi5QSzKD8MF?=
 =?us-ascii?Q?QwktIjoTXkTGdyBaiMidZ9asH6A5qAcCZIpGnQZuF67ByYSl8k4O+GnEgpRY?=
 =?us-ascii?Q?91kpUWMT/ZSF4Ro61+wbWP9kqiz0JN6OVy7T9xKg4pS/+VcfAHGXvNmMwuQL?=
 =?us-ascii?Q?BPdNOEtowF9czLMQ8PAJKgFC+3K71ltdJQCLEr8x4DqvlGYOtYbTVwiC7Z3+?=
 =?us-ascii?Q?eaykPs+Mz6m29IjGwqU0WTR9ZX1G1i3+5NJElEt4vvQcuox4IWnV?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: d1e903a5-fb48-492c-080b-08de626aecf9
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Feb 2026 14:54:11.5415
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /oAy9D/zTwQtz1sA44an6gcX2caAVKa52mU2UifnUxJ84pmyK0si7OIyZIH6a3C2DSzN5QbBLMSSel0Ai8OFqg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCP286MB2195

dw_pcie_ep_clear_ib_maps() first checks whether the inbound mapping for
a BAR is in BAR Match Mode (tracked via ep_func->bar_to_atu[bar]). Once
found, the iATU region is disabled and the bookkeeping is cleared.

BAR Match Mode and Address Match Mode mappings are mutually exclusive
for a given BAR, so there is nothing left for the Address Match Mode
teardown path to do after the BAR Match Mode mapping has been removed.

Return early after clearing the BAR Match Mode mapping to avoid running
the Address Match Mode teardown path. This makes the helper's intention
explicit and helps detect incorrect use of pci_epc_set_bar().

Suggested-by: Niklas Cassel <cassel@kernel.org>
Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
 drivers/pci/controller/dwc/pcie-designware-ep.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c b/drivers/pci/controller/dwc/pcie-designware-ep.c
index 7e7844ff0f7e..0ca05943a1e5 100644
--- a/drivers/pci/controller/dwc/pcie-designware-ep.c
+++ b/drivers/pci/controller/dwc/pcie-designware-ep.c
@@ -165,6 +165,7 @@ static void dw_pcie_ep_clear_ib_maps(struct dw_pcie_ep *ep, u8 func_no, enum pci
 		dw_pcie_disable_atu(pci, PCIE_ATU_REGION_DIR_IB, atu_index);
 		clear_bit(atu_index, ep->ib_window_map);
 		ep_func->bar_to_atu[bar] = 0;
+		return;
 	}
 
 	/* Tear down all Address Match Mode mappings, if any. */
-- 
2.51.0

