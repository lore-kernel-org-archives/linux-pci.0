Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazon11020118.outbound.protection.outlook.com [52.101.229.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB3323A7D74;
	Mon, 25 May 2026 06:31:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.229.118
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779690700; cv=fail; b=aw0/AJS99JicOJD+1XYUTLr7Az3k9vKFXx7rECyhihbf9E5D42PxAMqW8c1b0zwbzFALIRbnPD1p3y/7ExLz9Wb6RGjJtUsJMourZje+hMXufYKOVJZjXItMyEc/iSuEmib95Lc/ivVArOZZ4T5+zrHBoSvt0BvWgE4/sBYMays=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779690700; c=relaxed/simple;
	bh=1TgHKWB+myhdAk9xzgH/iRt3IL7OAL90CbgapFk2oKY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=FurXLLCi1UEIF+1IhIWy92ug5Wu1jiGj+n4VBXnT5Vp/BHQ+una168NtOvyb0pDLf1fL6dzpwbrWNVWtFGNDhbYobGg3w+66S6w5J4sAd67FSlfJSfxN00MghtAFefjgoRzM0buJ2pIVewtAWctaPzBoKrDJA//dKx+esGC3gzc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=EGWozOgv; arc=fail smtp.client-ip=52.101.229.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="EGWozOgv"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HkzIX7YFRjv8ScEgQ5oKqXmnxe9x+vaIWj/OFB2+TDElhjm66ItpjLL2elRbIGWogpfhpPMGUdO+vvqapnFk2NhclHnjYrzBgYxsqJJbYFwkBSmB+bTU8mXE7pyZCSWjFfUgBNi+ymvDjLdGSJCzbNgIK0aUPcFhkJMDNYdVHxVqNA2NOjQZkjvkkHWKs2oYZJ8i4V8C4t5ZAzjNBKz6dfPs5OeZkMLj7rQivpQ3PGdIOTZbalVZ4sXjmyEfunC0bCrynNxrIKEC4vkvjPX4DmTlJ3I8gs6JpeN2aEbIwL1pfivl3iTojRasHqtfuk/XrwaP1ahRPpTDBr2UCGKwxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vlxGaqXxomLpCdc0mvzHBrp/4l1N6R8p/PGD3NFHhF8=;
 b=drXK4axKRYICqELhBI1mgYm8QwH2zcZwHljSoo0RMJ9mSPVgD+H2q89TvIKvfdLpTK4zKEk07jDudtJS2l9izHi7i7tN/4vkuL4HJvs9aLGudVGRJH+R2crQJJQIs/Eh/lgPYcFoLD2bme81VDNkFj/nwvzLJgfFDekJCZkAPPfpx55bdTW8Al5i7JTTiuqVOApef+JriAxlBTVXU6TgpfLB8Cqfl1YkPpYJQpV7+NMrVIwLAuE/Nym5E0hdApX6w0SX9bR54VAhd/uESSgZirs2JJmA8PAINZfKP/yP3e69s48J7j8udSnCb2s+I1L3ucPp7D+nKlDTZWa30bAr1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vlxGaqXxomLpCdc0mvzHBrp/4l1N6R8p/PGD3NFHhF8=;
 b=EGWozOgvKWguNlzDwve6GEi9ZXUBe2zI4+o0oBP4oPOKRlQ04bpjadcKH06XRnfx9q4q6pKvFJ9xjooH21qYDd30fXvJbwVgU3UycQWDaE5y5i4Yq84743kuPfqw0YVNH+X6UB4NKSZcRHXdbzi2Whneup7+wl0MvIwyo0z0mDA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by TYYP286MB4607.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:197::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.19; Mon, 25 May
 2026 06:31:35 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%5]) with mapi id 15.21.0048.016; Mon, 25 May 2026
 06:31:35 +0000
From: Koichiro Den <den@valinux.co.jp>
To: Jingoo Han <jingoohan1@gmail.com>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Frank Li <Frank.Li@kernel.org>
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org
Subject: [PATCH v2 2/3] PCI: endpoint: Add DMA auxiliary resource metadata
Date: Mon, 25 May 2026 15:31:28 +0900
Message-ID: <20260525063129.3316894-3-den@valinux.co.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260525063129.3316894-1-den@valinux.co.jp>
References: <20260525063129.3316894-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY6PR01CA0012.jpnprd01.prod.outlook.com
 (2603:1096:405:3bc::17) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|TYYP286MB4607:EE_
X-MS-Office365-Filtering-Correlation-Id: bae21c2f-7814-4b35-a330-08deba274492
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|10070799003|1800799024|7416014|376014|6133799003|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	AYjf4ZddbyL6dHVyFpNEYkJ/wcVgKMRBcuHrzrhB6SEW8rT93rIyXrw/PWAOw/GV/UA08EZeYp5W5/ooKMeswp/aPGsyuDKCt0bBDZ9uq8dJ8wuz3xGmpdpnl3mSBR396zfp8CzUOdAibHpkmaFOAA2ThgpZqIpkuxLFuBtI09VXKZfvZSgLHenpRxN8A0hW6e9jXR3ZjUp9EmRKpoIwkMNBkQtezcC5DQgEpPA7q0qgHnmO+Fiu/Q2hnJkdjq2H+4SbfIsA8YqpXX0EMHZdd6eZ/Oj252DksNlxkJGKgHuk/2wb7++9Lx6PfDrga3cZ3inEOrpItd28h745oxu0tLrxSCxCucgy0mbamaUbn9Zt6/H6sifuZORLMWqxbKX5j1t5AWn2Ou3Az9v4bXo906/jbO3Ro26IdCKaXhcncQvZ3EpqhiPhxiLV5PoBV4DZoyMSLWkcTGu+NDCwq6KIQkjLF7M0piJC07eEfcqGSdXATWkl3km8GziMZpMju4e6eS5E6CDK1IIvgBcTrIBkcyfNobbqVMj/90+qC5YTPRRhHiz0rCIqD4dGM9CKsey9X+F/xUJ4Nmqua4yOg/md25rV3UeKZSpcTfwXhkhjsW51a9JF3fDTj2+YEZJzE1K/DBRUfKU3ZOtCieNlJGjqBLthwZ+pKVRZoTsDst/TBt2yS/pumiDHxgKkVQcF/r4t
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(10070799003)(1800799024)(7416014)(376014)(6133799003)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?iqZnTvFQmkrHQBnXQr3HeesAy3SKSRnWwCxIXXZOoZb7HiOd1sw/AvEjKF0x?=
 =?us-ascii?Q?zbbZDLDCL4j3yG1erzbi80dfoXjvXdyI9ZcW93EjxVgxK1ccLb85o6G+H2pR?=
 =?us-ascii?Q?l4Ohfd6FkJIroZsRJWSOozIykZupH3yX4D5W7aFVwv6UUkhCkPLgCQ6oA0yv?=
 =?us-ascii?Q?d9KRaHTDebWmurl1wrHrjCJbGlvkR7mvhnf9+Li9X+pmrdJyUnHi3xD7xvEo?=
 =?us-ascii?Q?OOVirAtcJUpXoK8piu4wRSeRwMqRk+cuMbYsJEcvaUDoxw+P4zbK6yvvFVeg?=
 =?us-ascii?Q?Q99WeQsCw/Ygr7XaH/UAbWMhx4UIBhsT29ZXm3Sn/FYz//EUOLNR+yB5nlsl?=
 =?us-ascii?Q?3iKZtsAsDfKGxl6476pKAoyJVZ0LcwgXKd0kMfx62ijrdJa0cbgppsAkcMk3?=
 =?us-ascii?Q?0vGB0T+C3BNwEyRJwKHqbr1d7+fC7dZYbnmIlAD4z/sLnpC8gcR7MOjimd0u?=
 =?us-ascii?Q?eg/rC+OCKitt+eVBJqOlyUdMSguZWgzXfwjdD1gMcKR+mPcCQXhMBoabN1yl?=
 =?us-ascii?Q?h5+kAhVE5cIHVLTiWEPB82vcNF7bVZ9kcsFvzIu2+u5kZOsdQJo8b1NS7b6Y?=
 =?us-ascii?Q?XwIB0nwHPdoT6dFPdYcIyHU9KYhAt00zb0o3Pym4UyJ/BYwjE2hgFrOnHswv?=
 =?us-ascii?Q?KXMg/8SGbem5OMA7mAR8mGyhHJLg9lR3i85qFQERwt4RT9txAXCAPEeytFYe?=
 =?us-ascii?Q?mFtzeGOVgSgFptX83VKAAGiBLBdg2PS9huNMUgmGKZTA/mMbnJWuZn8PY6Rj?=
 =?us-ascii?Q?9i9Wpx6ZbmWmSKLgj9wqXLl0jhNjDcfPv/io3IKDC01QiGFSGl30NhMzc4oP?=
 =?us-ascii?Q?J8nDZMLSyQifWaM0Tqg1Un/M/5BybXMDOtqnlxH+Xet4HjMByNvlNWvR6Yhr?=
 =?us-ascii?Q?MivtsQ2kOpLNLJFPUa+uVOekIxiuv9cwbTipCesJ/lAkIPLJ0Bt7hSfFoDKy?=
 =?us-ascii?Q?jrdp6w4pM7kMVqBfVbAKPBranrxOHfLsOyRZwUh+dlGyzLbSrUL/2B8sXnmw?=
 =?us-ascii?Q?Jy9RCjvbYqXmaLo62t83TevH/aKzdYNJV4/Z5kLu+b/+P/KzJ9NLWgupiYvL?=
 =?us-ascii?Q?OPDmzAiRbCDkt35Me/Mdd1YmoKtGDZ2QamALKnOSUvU/ELAx8eN641Yoqm2q?=
 =?us-ascii?Q?aOzUr44pci64v1vg67RmP1JEeDRHeyVWHDhGoG41BaSWVjGQQAAKxnhVqdf4?=
 =?us-ascii?Q?WuYf1GK6rWpJ1jb/fWV6mRjFo1GhXs0pQ4qVBRGnSYrqFoC2UZrKYsJIN1Es?=
 =?us-ascii?Q?ts8ykxHQtE9T32eVIk2QVSzXoeX4bxbzSMCZ/L8JOzLbLket9biL9NOdkKtO?=
 =?us-ascii?Q?jNUMnGtACekW32aNUUNJW1uR1BcPwGGmFAkBCdRh6qQHX7L6osBQGxE2SXH4?=
 =?us-ascii?Q?kWp8BRsuRyEUK1e2gTJfG8f36S5mttBkHNoHqsVOZ9xTOdZFPAuHs+gskJle?=
 =?us-ascii?Q?dfV2pSKrkn6xDxqtIxCipo7JHEr0lSuKg4gOMa1A7u5r+R800KNVWIoqwWxR?=
 =?us-ascii?Q?tQC6r9EVcPsV3P3UirpPfYjGWSy51LS3khr5CL55hZFve/lZ7UhbzkuZ86jG?=
 =?us-ascii?Q?tNptI0YZOhBvzM1Htlr2E3AaQJO6vMdYhF+mvCBimZor66HyCUoYWQvg74Jt?=
 =?us-ascii?Q?4PcHPE9KhCui8fDMxKN3itGTT4Mwkudt32WxI6u6/aR2m3yox/Wk6jejwMTZ?=
 =?us-ascii?Q?5OJ62f1mPxZPNnax9AIDvn7z96iKuTodb9E7spbsfrpXecEdg1P4fu6Pj36G?=
 =?us-ascii?Q?/ftrYVcqaQr+iULKYqSKOKHSkqGubm1BO2UjZ95s9p7SQsivXrWg?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: bae21c2f-7814-4b35-a330-08deba274492
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 May 2026 06:31:35.0834
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SLZhj6FL4wooFT/dmj7Oc0DXsGqhX5+b1ltyBltpFg3xE9agsA1AGMusoT+G+NLRmqUqLRrRabL7B5l97TZqcw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYYP286MB4607

Extend EPC auxiliary resource metadata so endpoint functions can
discover controller-owned DMA registers and descriptor memory.

The DMA metadata is intentionally generic at the EPC layer. A backend
reports the register layout, channel counts, descriptor memory, hardware
channel numbers and, when available, enough DMAengine filter information
for a consumer to claim the channel through dma_request_channel(). An
endpoint function can then decide whether it can expose those resources
to the host.

For DesignWare controllers, reg_layout_data carries the eDMA/HDMA map
format so a consumer can distinguish legacy, unroll, HDMA compatible,
and HDMA native register layouts without making the EPC API itself
DesignWare-specific.

Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
Changes in v2:
  - Follow the part 1/3 v2 channel-claim model by carrying DMAengine
    filter information instead of a raw DMA channel pointer.

 include/linux/pci-epc.h | 44 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 44 insertions(+)

diff --git a/include/linux/pci-epc.h b/include/linux/pci-epc.h
index f247cf9bcf1a..cdad8cd64820 100644
--- a/include/linux/pci-epc.h
+++ b/include/linux/pci-epc.h
@@ -11,6 +11,8 @@
 
 #include <linux/pci-epf.h>
 
+struct device;
+struct dma_chan;
 struct pci_epc;
 
 enum pci_epc_interface_type {
@@ -65,6 +67,8 @@ struct pci_epc_map {
  * enum pci_epc_aux_resource_type - auxiliary resource type identifiers
  * @PCI_EPC_AUX_DOORBELL_MMIO: Doorbell MMIO, that might be outside the DMA
  *                             controller register window
+ * @PCI_EPC_AUX_DMA_CTRL_MMIO: DMA controller MMIO register window
+ * @PCI_EPC_AUX_DMA_DESC_MEM: DMA descriptor memory
  *
  * EPC backends may expose auxiliary blocks (e.g. DMA engines) by mapping their
  * register windows and descriptor memories into BAR space. This enum
@@ -72,6 +76,26 @@ struct pci_epc_map {
  */
 enum pci_epc_aux_resource_type {
 	PCI_EPC_AUX_DOORBELL_MMIO,
+	PCI_EPC_AUX_DMA_CTRL_MMIO,
+	PCI_EPC_AUX_DMA_DESC_MEM,
+};
+
+/**
+ * enum pci_epc_aux_dma_reg_layout - DMA controller register layout
+ * @PCI_EPC_AUX_DMA_REG_LAYOUT_DW_EDMA: Synopsys DesignWare eDMA/HDMA layout
+ */
+enum pci_epc_aux_dma_reg_layout {
+	PCI_EPC_AUX_DMA_REG_LAYOUT_DW_EDMA,
+};
+
+/**
+ * enum pci_epc_aux_dma_dir - DMA channel direction relative to the endpoint
+ * @PCI_EPC_AUX_DMA_EP_TO_RC: channel moves data from endpoint to root complex
+ * @PCI_EPC_AUX_DMA_RC_TO_EP: channel moves data from root complex to endpoint
+ */
+enum pci_epc_aux_dma_dir {
+	PCI_EPC_AUX_DMA_EP_TO_RC,
+	PCI_EPC_AUX_DMA_RC_TO_EP,
 };
 
 /**
@@ -99,6 +123,26 @@ struct pci_epc_aux_resource {
 			int irq; /* IRQ number for the doorbell handler */
 			u32 data; /* write value to ring the doorbell */
 		} db_mmio;
+
+		/* PCI_EPC_AUX_DMA_CTRL_MMIO */
+		struct {
+			enum pci_epc_aux_dma_reg_layout reg_layout;
+			u32 reg_layout_data;
+			u16 ep_to_rc_ch_cnt;
+			u16 rc_to_ep_ch_cnt;
+		} dma_ctrl;
+
+		/* PCI_EPC_AUX_DMA_DESC_MEM */
+		struct {
+			enum pci_epc_aux_dma_dir dir;
+			u16 hw_ch;
+			struct device *dma_dev;
+			/*
+			 * Consumers pass this resource as the filter
+			 * parameter.
+			 */
+			bool (*filter_fn)(struct dma_chan *chan, void *param);
+		} dma_desc;
 	} u;
 };
 
-- 
2.51.0

