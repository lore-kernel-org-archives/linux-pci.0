Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazon11020085.outbound.protection.outlook.com [52.101.229.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E8F242C516;
	Mon,  3 Aug 2026 18:04:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.229.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785780294; cv=fail; b=ZKWQNdEu5QXsN1+KIrDgHZd+3f097IcVs3ab+u5QpZDj0XnfaSHX4roe/+bui6XHvRmU9bltldU8NsQC/qMdtdf9wtp5J61Qyz+DNGvG+ZRFw5PJ9/fyGx1cPoXIA8b/Llp8vVIb4Ev31we7uXLr59GaaJCiOx8G+j2S5LCkCCo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785780294; c=relaxed/simple;
	bh=yWar2L/N/ronSSrB55Y1uD/vi0LzDyoY6fRKEvNlDF4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=GBxuceCNDRR9TdAIoXIP++z/mSDiGsQUuyWI1QP+skIfdAgLLmWWBKI/Gi1Fztj6ovlvxTqAW6L0/34BelQ26+ktyD6MdFFJM1yPJdJRSwH4R1eCl0zIRlNZYNwUOBgv8cPAGmlZd5ly99LhdO0SOsmCq6JXgXn9XfthRNTcipM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=d0zQSywH; arc=fail smtp.client-ip=52.101.229.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="d0zQSywH"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=urXw4BP3+OKrq8noxNc4kxIvFWBp8lHNg1uA4Iqk37rSzjrFNrrfHY18h7MOfucASZxsfLXHunBe5pkFbYuHxDnPuNCthV3tccJsm3Jd2HyKKeO8P1wTm4NttPLloIzM89ONh12zqww9JNIer/MHj4UBx2BPnzmLW2+NwW1wWiTdaBqLZkk1J/Bkqak6Vs8qNeuqrGXrC8Wq2eneyUzw+woDAQhKGXM6xl+AL9ny7iI6f72LNca8khKFhJb0xByYJMJB4tp41e9tOQB/WL8m+pp2LCFnrOhr0eIJLW9Ho55BxrluMulmvYZmBIwDeB2m3gm+6TGzcYUbEMine+zY8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2XdS5+jUTvN+4Xzo5LuQp7Zp66znkPcO98wmssqkraU=;
 b=bTS/ejDRd10dT4ZFWTx4GkcKw+xxiOzr9JW9JSqR8ZCzU4a+WiS9Ulf8LedWKcZlC/FV3ZIcQB8Y3PO5uRCogr2PGC8HY4OKv0zrZnQGj3d/8fdkewqJ+kLTCmdlN/LOYbtB1XsRNoNIumG/U9bjf52PcZuM3MFrdxcavYWPUF2Ut7Ql6csAs+0RvZACotSDVMMrS8PvtRVkjjxYsRP1GSewOaKx5zN+N6ayx+IJDf2hA7jUyxCxFuiGihy16mjjWkET3BF4kDe/u5oTOfuTSMVncXEC7mLI2zNPLyoekzEpjiUfHOpCohFOAX8Uf65LV8YufQCj9Km71xqX1/7rUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2XdS5+jUTvN+4Xzo5LuQp7Zp66znkPcO98wmssqkraU=;
 b=d0zQSywHBi/bwEe8GGUp0t/NMsbw5CEd+NECZzJZmPNdSt3PWHFX/Xp2UeC8Nxe46JT+K5eIhqItTakWu8X/f6YlNhVlYPdwK0Dr8QA52/pOMNWO9B4H92Xkzd91VjgjUpvoSHnTFOS3V9wVCeqAlktmCQnQ1qQi4bizyERXApg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by TYRP286MB5249.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:115::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.18; Mon, 3 Aug
 2026 18:04:45 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%3]) with mapi id 15.21.0270.016; Mon, 3 Aug 2026
 18:04:45 +0000
From: Koichiro Den <den@valinux.co.jp>
To: Manivannan Sadhasivam <mani@kernel.org>,
	Frank Li <Frank.Li@nxp.com>,
	Niklas Cassel <cassel@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Jon Mason <jdmason@kudzu.us>,
	Dave Jiang <dave.jiang@intel.com>,
	Allen Hubbe <allenbh@gmail.com>,
	Jerome Brunet <jbrunet@baylibre.com>
Cc: linux-pci@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	ntb@lists.linux.dev
Subject: [PATCH 05/11] PCI: endpoint: pci-epf-vntb: Allocate packed outbound MW space
Date: Tue,  4 Aug 2026 03:04:32 +0900
Message-ID: <20260803180439.1963864-6-den@valinux.co.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260803180439.1963864-1-den@valinux.co.jp>
References: <20260803180439.1963864-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYWP286CA0010.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:178::19) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|TYRP286MB5249:EE_
X-MS-Office365-Filtering-Correlation-Id: 147ba770-414c-4507-a5ae-08def189b362
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|23010399003|7416014|366016|1800799024|10070799003|921020|6133799003|10067099003|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	OC1klGcnzv59oK1K8HU5UjZYGMd0pZZbkShdap+zCV3Jsa3F31RFtsxgTvG6aTZSK/BLw06M5NWT2tMXRTqsmVqSKDjh752G8RViUJGyGYL1QpyXVYut5V//7mH1ObfClcLUYTHLS64gGacMA3Ga1Wl6ForsXCdDbDxKVePybBUGmNPz32lh0GBu3lxsodbTN/R7za+YLWWSWp6IqLNek4YoDDI3dy3ieXx4+ohRwZCOa3J09VLNYc6LEqDL86HtVu+tfzbYGlOCp4F96ICssXLqEE5kUcP7enGdU0DrbZFuR+BRy8qfS0O7tfCpgwUhV9DyaaoMr1aURZ+I9s/h9M0vwHMZtK4OAhSbHZbmalA0NLlS0KGh0rb9YEn8pEhrZ67d+5K1ahLvKS9wwYILsScfqJpJutTSvfIDLumgdcvCSCio5r3UgStu2R06dhq6x/QSfl7n9kZ14MG8ji2Dzx8ibXJXgslsjtNmEZcCkGWKu0b1wckHibYjy8vxVJ7eRKBPy4lBgVI0LOR6CfNlSccyia++vVXzt559EMo0+hct6+utmOUY+hRv9uw3xhvB8uvaKUnpxbcdS+ZnQwYaN9jaahTajuDyXIG+fXAum6NOTxyBm/gIERmTRCt+QF1xZKMNQGsQ7f32HZNP0D88m5AQVDPotaGsKIfHh38qS7BFI69wT2LPmQRGPZ/5MXItekvJcTdpwP5sNGpbUFSjOg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(7416014)(366016)(1800799024)(10070799003)(921020)(6133799003)(10067099003)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?wyAhStysbCu6yQqcaHl5hs3uXZVYTtOmxj1749TVrtO4QsyLlIhqSKhAbaod?=
 =?us-ascii?Q?6X2OF73Fc2pAGc5p0GZ4qQqO7hzuuNIp2FYVjaTkTOgg+vNyOOhR+/yvyM3i?=
 =?us-ascii?Q?jDUbOTuCxUEFgt+EG3vFwh0oz8+ObLzTyDqKgcQrMVRb7O8/U6+6Hh4ivjvE?=
 =?us-ascii?Q?2bvRV7pwHNqPU5dBZ+rG4HJR+8ZTapfwhWjny0Xus5OeYSbGADb9k2ENwQQc?=
 =?us-ascii?Q?DoZkV8oTfJfG0IkDuvvvqgxP9mDOFe6Q5J0V4K9Sg+BMn9sssWEhr7EgNlDS?=
 =?us-ascii?Q?DklGPWJQTe4fGoY8+8AbPK8AuRZTJXYG0PPkzeteye0sZa7q7Ffiy2/qDDLG?=
 =?us-ascii?Q?VzSeXOgmblSK1HTYTvNLckxCUV9hFmvr2lliwMTxRqQdtUHKqrxygEbRoFcI?=
 =?us-ascii?Q?h6S1BE47SOW0GkuHXab/oHmkPj5PGFzjEErYx7DIKbrQIMMSnB6b/KvHoJJy?=
 =?us-ascii?Q?zccMVj8KqYpJ79WUJ6yUUTXYfV7wOTW+aznuW23/BlCE58ximpcEOfSZElKh?=
 =?us-ascii?Q?mzxRrmufE088sLNghExYvIBc5Xjf7BRHWPVh1MakOL24Umtw2E5DuoqWXzLX?=
 =?us-ascii?Q?AiyHc/rF8m0AoJcRw60RFpXRKL8cZ7q6nGo0Av795DwWF4XIEmoNm7EhxWDr?=
 =?us-ascii?Q?WfzK0awLVWGHrR/Ketvj8bSlzLbRUD4fhSTW8c7xXmK9nafn3HtWk29l1Qm5?=
 =?us-ascii?Q?5/VlBWDzJRqXGEAtS9NSQXUHLoXyGGhhmwnIzkVbA10vEjqIsUcnSXJF1oge?=
 =?us-ascii?Q?BBRjjIEbW5FTNV8gn+uLLPh82KqMWqe7quGe5Sv+jb+1i2VMet1p6gLegRJg?=
 =?us-ascii?Q?fCHJGFun4tk5LzG8Is8rChw3zmV1WPT16PHZxcOVmJkWxQ0elb4D8vueK7zv?=
 =?us-ascii?Q?M7xrce89y2xHNw1tx3ORxPkHP0+ErO0X375MBcODNX3KobCVYla957dhOH6y?=
 =?us-ascii?Q?mZB1AJAbLIzzBJuqc8/E6QBtgjJ9uxbSribkaIJOoQYE6tQ1kIuvyb8jhVnP?=
 =?us-ascii?Q?cRy73izbMcFhwydc4CYFFpyveiNA9OlYYnG1HaDjXMat9xcsG1+ioG29auxP?=
 =?us-ascii?Q?5GDPuZhc4kpsnjJeypVXY05CdwhBnk8k/oVztxk/egYqIqAY3AQr6IuK2yUB?=
 =?us-ascii?Q?P+UR1Wg/KOxxHv0Pe3cC8r8bpGotb+5YpARM7vfD3mAt53j7x+b6TjPujNKx?=
 =?us-ascii?Q?xLpZ9Bvwpf48NUAT9/LKRurEUX2xBGGZ4o6rGCPPjFXsJX8+Ztkvj+rMpVch?=
 =?us-ascii?Q?qG1lDXNuSmwyCl7RfaCFE/Gdyvwj5gYEaYkZFWc3XrfznMnKNRzUjo8bO7KD?=
 =?us-ascii?Q?qmETB4OMZ43rCm6GGUZ1WfSUf24Z7h1J+CDG8njPDGZfUIINNurJ1faL7bjL?=
 =?us-ascii?Q?1Myhu9yscR2NmVl1/Epz8EDgYlojXaS+EC9uILhcYkxpO5PAK0+Xf7ky/kH6?=
 =?us-ascii?Q?0LfXR8x7u5SLgPr/SLzJVH+kG4EgOKR2ZuiazHdJ8PO9VSGu+GO36ybLmVTr?=
 =?us-ascii?Q?yL5NZ8lRf/4vgVTHG9JcojDbHFrj3ELWWrqfbzVjtHvfwnCdGCkvO45bjd/f?=
 =?us-ascii?Q?bH+poSRrnZitDbJ1UG2pfJRZImzPVBt0Q+Cn2p84pDYLtbOnB0Xg6A7MQHwg?=
 =?us-ascii?Q?ev7/Gbq5OXW7qTC+/wxEL/kPqFcS/+VYBGCZYx5QCxM+47WLdWZlKB7IfQX8?=
 =?us-ascii?Q?A599bjpXRCcep+tqoLUmRh72l5Cf55KoMuFDObYldI2Llwa+khqvwyrii2WU?=
 =?us-ascii?Q?yBmQJsBaS/UcnUBF9VFn1F+ND+8GXkR2XnaaPGx9UMFBz0wUW9V8?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 147ba770-414c-4507-a5ae-08def189b362
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Aug 2026 18:04:45.6057
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SuBmale/HHuvo7E9I+8LbX6QMOL2Be7j/he1SykvGixK9e/POkbFD0ZXOV7q/1EKwV20pgy+alhnH9jrjUqL7A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYRP286MB5249

A packed MW group can use one outbound iATU region only when its EPC
address range is contiguous.

Allocate one EPC address range for the group and expose each logical MW
as a subrange. Singleton MWs keep separate allocations.

Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
 drivers/pci/endpoint/functions/pci-epf-vntb.c | 26 +++++++++++++++++--
 1 file changed, 24 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/endpoint/functions/pci-epf-vntb.c b/drivers/pci/endpoint/functions/pci-epf-vntb.c
index 0c72b907c289..aa8d304fe861 100644
--- a/drivers/pci/endpoint/functions/pci-epf-vntb.c
+++ b/drivers/pci/endpoint/functions/pci-epf-vntb.c
@@ -226,6 +226,15 @@ static int epf_ntb_get_mw_group(struct epf_ntb *ntb, unsigned int mw,
 	return 0;
 }
 
+static u64 epf_ntb_mw_group_size(struct epf_ntb *ntb, unsigned int first,
+				 unsigned int count)
+{
+	unsigned int last = first + count - 1;
+
+	return ntb->mw_layout[last].offset - ntb->mw_layout[first].offset +
+	       ntb->mw_layout[last].size;
+}
+
 /**
  * epf_ntb_configure_mw() - Configure the Outbound Address Space for VHOST
  *   to access the memory window of HOST
@@ -891,6 +900,8 @@ static int epf_ntb_mw_bar_init(struct epf_ntb *ntb)
 	struct device *dev = &ntb->epf->dev;
 	u64 bar_size[BAR_5 + 1] = {};
 	bool bar_set[BAR_5 + 1] = {};
+	unsigned int count;
+	unsigned int j;
 
 	for (i = 0; i < ntb->num_mws; i++) {
 		size = ntb->mw_layout[i].size;
@@ -900,7 +911,6 @@ static int epf_ntb_mw_bar_init(struct epf_ntb *ntb)
 	}
 
 	for (i = 0; i < ntb->num_mws; i++) {
-		size = ntb->mw_layout[i].size;
 		barno = ntb->mw_layout[i].barno;
 
 		if (bar_set[barno])
@@ -926,6 +936,9 @@ static int epf_ntb_mw_bar_init(struct epf_ntb *ntb)
 
 alloc_vpci_mw:
 		/* Allocate EPC outbound memory windows to vpci vntb device */
+		count = ntb->packed_mws ? ntb->packed_mws : 1;
+		size = epf_ntb_mw_group_size(ntb, i, count);
+		/* Only the group head owns the allocation handle. */
 		ntb->vpci_mw_addr[i] = pci_epc_mem_alloc_addr(ntb->epf->epc,
 							      &ntb->vpci_mw_phy[i],
 							      size);
@@ -935,6 +948,13 @@ static int epf_ntb_mw_bar_init(struct epf_ntb *ntb)
 			i++;
 			goto err_alloc_mem;
 		}
+
+		for (j = 1; j < count; j++)
+			ntb->vpci_mw_phy[i + j] = ntb->vpci_mw_phy[i] +
+				ntb->mw_layout[i + j].offset -
+				ntb->mw_layout[i].offset;
+
+		i += count - 1;
 	}
 
 	return ret;
@@ -953,6 +973,7 @@ static void epf_ntb_mw_bar_clear(struct epf_ntb *ntb, int num_mws)
 {
 	bool bar_cleared[BAR_5 + 1] = {};
 	enum pci_barno barno;
+	unsigned int count;
 	int i;
 
 	for (i = 0; i < num_mws; i++) {
@@ -968,10 +989,11 @@ static void epf_ntb_mw_bar_clear(struct epf_ntb *ntb, int num_mws)
 		if (!ntb->vpci_mw_addr[i])
 			continue;
 
+		count = ntb->packed_mws ? ntb->packed_mws : 1;
 		pci_epc_mem_free_addr(ntb->epf->epc,
 				      ntb->vpci_mw_phy[i],
 				      ntb->vpci_mw_addr[i],
-				      ntb->mw_layout[i].size);
+				      epf_ntb_mw_group_size(ntb, i, count));
 		ntb->vpci_mw_addr[i] = NULL;
 	}
 }
-- 
2.51.0

