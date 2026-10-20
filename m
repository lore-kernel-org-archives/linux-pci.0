Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.74.140
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792475402;
	b=2FiQi2CAog7dBFTpOIX8EPX1ctZJdsuKxD20A8pYObybIOXiktnoexOElDI012w9eOXU
	 bXP8LrFsMrqzbZyc5adDLuTu+G18RQC5UvE1t398QScVIft28KDEgmWagKoLZ5V8h4aSa
	 pM0/+jZpnYrHO1Yt8NY1YJKPzTsdDIHAvqeDL2dejd+lOXvzi1XrnP2Vz7k+Yb5i0aGbl
	 7KLBSxPSrnpzMHQ3yzyLpJCFqEI00M6tAHqMXmfaMqqasax8EY5IhArI0KkTF40T34Xjv
	 9fn6P2SA1EO1aBGmzuxXKPcpcCjD+00zd94IeMoJdFaMDN9oQdrLnZvWdIJ+lLd6nAw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792475402;
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
	bh=sdSfzCk5bMPn+aKCR2QotCc44dfQY7LfayUBRebEaqU=;
	b=hOm6xYwjSNGXVQkfjBmcpbIlkUATS2O1qqUEa7F6E2ZA8y60rUrg33txwJAMzzFYwcjh
	 7L7xNIgzBscdmp+sQ+5mDha8pHzLZA6lsB/6HLJXQKIJfEsSfRNnkvzwv7ia0jSeejExC
	 3pA/zGk8d9pdR16cc0YFtktQEviqimfAGqfUZabZc4Z9HUV21O55MplgmbAN/OF1AxoIZ
	 Q3BlcCB48wFWd+TSkBVOy2hxZEUG0IdFgzDi6+WJjTpSAGJci3l7JvcqUNUo6jr/YyVQk
	 GWN4OpJAPQJemFWDsttfpsdZtntdWQNYNBG2Voce7fJ6ft8qHE/LcAc3P7iWhsW4LgA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=valinux.co.jp;
	spf=pass smtp.mailfrom=valinux.co.jp;
	dkim=pass header.d=valinux.co.jp header.i=@valinux.co.jp header.a=rsa-sha256 header.s=selector1 header.b=iZwIzZW4;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.74.140
Received: from OS0P286CU010.outbound.protection.outlook.com (mail-japanwestazon11021140.outbound.protection.outlook.com [40.107.74.140])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E11D606A321;
	Tue, 20 Oct 2026 05:50:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7E11D606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=valinux.co.jp header.i=@valinux.co.jp header.a=rsa-sha256 header.s=selector1 header.b=iZwIzZW4
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=L3eyrt9crm9kDaQWahjMttjgTjJR3UKWMxnK4lwCyFfGVHnMNu7ZPljWD7WT5/NSkClD0zlHveQG7zsbEDxT/cYrblhXgRocvSrOuvIncRI3jDJYCnc9lz6fijWE3O8mzt3xVoHLRUlgqoEs84KoLHm+fBt687Dbz+4lOzNKn6Ged0Q7lnEUW7R8sfAIiWdJWtyc4u1YI7hO8HYX/R+JF9G4fE9V5Q3+5xeAe68cx9+JGKFOzavWwqROKerjMhRPse3Kpsimwj6HCCp+zh8ulvXF8l50CLxasEA9cHOhXLSXw2OvewkaY0BSWViAnossDsT/ywBHshY4a1iRFc/VgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sdSfzCk5bMPn+aKCR2QotCc44dfQY7LfayUBRebEaqU=;
 b=qCzjPT1d/fUSiuWknzM9QylXCN2jjyCOTT6prud217hDoszRR2XuMKLTj9TgA/626vTCz0GDEuQIXy5zEeXQWF6DrdvFECDEQSAvh+UjvO6DKGD+7JIaaxlzEYqigzyIiJDEIHFNBBPcNEh04cKv0igT39y5tGASFqM5AMaASGB1LfLQoHsHi63YA9O0kM7Iy5z7P0SWXvd6+cRDhB5ANIcmnOMxhy7Nm+IzWOCnSpZFSB8ch/NX+4o0tUUuGLvj7OENRFmnz05a3DE3BLUMR6mXN11VnZG4tWGmgDIyxVpaXQ1NtPqq1scCQHEi6hPQdH/KGCauTx5KDJfcWsC3Lw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sdSfzCk5bMPn+aKCR2QotCc44dfQY7LfayUBRebEaqU=;
 b=iZwIzZW4NTo5J/bqILJyGoLjMXRKZ9LVBDhvrqfnZVGwe8vho4Mdx53byHrF6potr3z+4fi14TeOGnnGXxdL93Q9Zry6vmZk8gpHWQLqmi2OBXWD3qgzoNPdzJFDV78Y2FLmtZzqK9iiUPVoGKzsP3yCTaKhKzJ6tdmEKC0OTtE=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:325::11)
 by TY6P286MB7913.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:3a3::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.19; Tue, 20 Oct
 2026 05:49:53 +0000
Received: from TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 ([fe80::cce5:2aa8:53f9:dba9]) by TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 ([fe80::cce5:2aa8:53f9:dba9%5]) with mapi id 15.21.0522.017; Tue, 20 Oct 2026
 05:49:53 +0000
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
Subject: [PATCH v6 2/8] PCI: dwc: Expose endpoint DMA resources
Date: Tue, 20 Oct 2026 14:49:42 +0900
Message-ID: <20261020054948.1218370-3-den@valinux.co.jp>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261020054948.1218370-1-den@valinux.co.jp>
References: <20261020054948.1218370-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0141.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:31b::6) To TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
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
X-MS-TrafficTypeDiagnostic: TY7P286MB6866:EE_|TY6P286MB7913:EE_
X-MS-Office365-Filtering-Correlation-Id: 9d32c8cb-0bf1-4d16-71b5-08df2e6df6cd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|10070799003|376014|23010399003|366016|56012099006|261009223027099003|10067099003|18002099003|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	1RymQZr3bye+dOMCTgrag/RjPVUn1jRE/OGzvJqBbnnx8Pf06mZCtBsNW8HNf4Zb9IRR36KU9eMPzKCydgoHQRy8okroM3iF22LaGCzXgEOn75ec/ESpC44kdY10qHJt7FD4zvsyqxmPkvOq5/yq2swq9P0/ESTptyb+Xg58aZoN+v7OU+YrPyCCyh4LxipGjPFw/rpptKUQncTCqbTeeDE1eo+Cu1N3vo7ybRDm4VtnD3euaw+MIxFcnrjWxpdsHf90J/6gT9Ra+Ec57qcmWU10Vh2GV79HK4JYfFySxDcH6EAz4poa3RQ62vkz/4UCYoe/pcdhaLMdUToX5tw4Ykl32sYF8+X/WyOeAM80iy4Cxlg25hCph7IFUvZ0yavk6o0CqA4hmwhPICnNOFWcTvN9wXIK+txbyOayB/4Qhf+NqW3aRrnNO8scCXvCZPqbYjfjKVnsUhXtoO/sqn8Ysi64oZsoZnzURgxIMAc//J9AFkNrhj0Auxk8uj/MklMvz2OzKKkJtAEVFRi9+nUjYBGK7SJFLqO3i8wqSwbmMI+jhEG0wtCzz/VpdJ3zqZwVb/cQGG1DFxyll1fMWiZlGO4ayVcL3NwfhGNnT4CPPEknJEh9cuhXCLslNgRRoPbP63xUWQL28qUHLqm9uB4WeajUtcRunhIFda3mjimCABg=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(10070799003)(376014)(23010399003)(366016)(56012099006)(261009223027099003)(10067099003)(18002099003)(22082099003)(6133799003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?qswk8O/UgR5BRJr2i0+JH/xNXoyo04R24Fpkys8z4320XVAByStJlZ6JByDh?=
 =?us-ascii?Q?9SpZlJbbjN2L2dldMtytiOQVbHPf0GuVpDruYVKPeV0AHjdOnqHfQpg3UZiD?=
 =?us-ascii?Q?RXXYymXeg3Yx6XroaXn91ma/X8HtkFCYxLgyTylQ/ku8Be/FGK+pd5f6lxF2?=
 =?us-ascii?Q?A5Tn894/z2OWfgagay+vvCVR2bxWxzamBvph6SK9bMg4wphGBnHpmqXlDEOJ?=
 =?us-ascii?Q?SMGKhbQQRl+OYnCN73C0n3jBs7ApiAtjc3BS+H/in+t5/ro0+MuCU77pPwCx?=
 =?us-ascii?Q?SdBQZUA/m8gP6ae777LOL7H5WeXHFWczz5iQHEVFATnHSHLKNULlfouBaL4H?=
 =?us-ascii?Q?y1EwKO6aXzQ6Qj3hFgYx2LO9hnCL7a/+Kq2fLkvjOyWQFgSsB5I0uITEF109?=
 =?us-ascii?Q?+f7D+caSgoAwIgO5H3BJ/fAE8JG1Ci+J5qD2JCPWFs95ohiIJC2YhFVm1sNX?=
 =?us-ascii?Q?x56Osi7RPJK0qnG9vKEkPZolBFwXRixLXGNt8yriNZTmTOKrW35ig9dfBGeQ?=
 =?us-ascii?Q?OlU1NJjPCF2lRupaMUW/8KDOTEiuQuBui88uwfE3fu/iSR+EO7sXxO6G0G0M?=
 =?us-ascii?Q?pOTL7vYiCuGQbzVk7LRrl65fza4+YnXZVraBKlNv989KoLN3Pbr/rXP2Ox69?=
 =?us-ascii?Q?jwJMSTFegI3MxAGmttQvXMnIbQ7NPEhZAxuaBCY7X/J61/biBk+f7DAGBmhM?=
 =?us-ascii?Q?2zLb23y1NkOP8Y/Yi3RiyJhCjE78XH2uOWlM1UszXuU+ly54URVxPEDKIUye?=
 =?us-ascii?Q?GSDPJ8hoboInzAkmmnvy5Dvc7HekLFoot7EAIzvTmxTf95AXOiDhhOdW42c6?=
 =?us-ascii?Q?Jc7kTe8Rokq83D1+rKaxRI84W3hC5G+MSgyc0AlI5vik3gEgvAucfLMyCtKZ?=
 =?us-ascii?Q?JrfX+dnLJ3ZS1UOgObMq+dDLUWIt9Hwah0LoUBO1Vo1YpDrTLfPAGDpYFEUX?=
 =?us-ascii?Q?zxr1hCbQ3IGW2sLSM4JT1FEZa1PlSk6CD6po0OnMJvwAUnl3yqF0yDrnHWdC?=
 =?us-ascii?Q?lr+SdXnvb3Sme0gI2DkRVCQ+7alZZK9sjGY4lm4vc1iRVBu7U7waNvz2si9x?=
 =?us-ascii?Q?zV2IKDlL4198DBnf0dK0u8KoO2XM1SPwvh6yU/zcm//8PhrMpUXzNf3yz/tb?=
 =?us-ascii?Q?YZDh0yW5pTz3/hjoFY3UHnF9ATDtdUiyP/ccPqCuZXJwLF1XN+vCy7Wzm/tQ?=
 =?us-ascii?Q?X96kj/XymBS2aO9o8lNSyBl77Niw7vB7PxCuSGyeW0eGQVhw9hs6eTiLil8H?=
 =?us-ascii?Q?qEISc4NwUWuWDMi8G+E6MexEzE4cH61sv5mgObHM8L8dOq+xtfdvT7lQHi7g?=
 =?us-ascii?Q?e2vxdYxUgvx0w6plvThMMh4FbMhMhwzyoGT43OjZFIfQtkw0XzOLk94MVHx2?=
 =?us-ascii?Q?zhmE2qTx1KiiGXY+uOwUHgOrojt/KQpCCuOaBGIvMsBFuJGSE4KB5pkPIPsN?=
 =?us-ascii?Q?+MokQTQzfz7FjRUOtz/LGDdop2EuCYq/949O4TmQR/5QOoRt3uy94MdVKVaO?=
 =?us-ascii?Q?ihmVOP/Y9iUguW0NFXhuUy2GLhBxdrhykeytti9mFR4fo+d7loKom9FeyegW?=
 =?us-ascii?Q?/eNi+F7h9sDsrkfj5l5iVzifhrO+bWo6h/k4RACOGvlsii6ty6cT1kVi95yP?=
 =?us-ascii?Q?AIQ2dj7Wp7wJPdYbtDszSeNocxFhd7NeSIvlXDYTTq2lPJUTXcxvhgcm6vML?=
 =?us-ascii?Q?uJpgK+X8jnGk/iCMIRDnptSQL06z4yJZL0/b4xAqDz61ULUPqMuCVCqXPz1m?=
 =?us-ascii?Q?SryMXs8g0YeBdVIc8UGw9m9HzePYMvRQ7WatSRg64YES+9XHWPH9?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d32c8cb-0bf1-4d16-71b5-08df2e6df6cd
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2026 05:49:53.7609
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BKnL54l6w682x9HbsT0Jj7FdmW21xfNS+Il5BMXlFQAR/MRMaDIFHLH0WsVBIEP4K5iC2Yw0jVsCFRfIAROJUg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY6P286MB7913

Expose the endpoint-integrated eDMA register window and linked-list memory
through the EPC auxiliary resource API. Endpoint functions can then choose
which channels to export and map the required windows.

Associate each linked-list region with the direction-flattened static
channel ID used by the local dw-edma device. Report these resources only
after that device is registered and only for channels with linked-list
memory.

When the register window is already part of a reserved BAR, report its BAR
and offset. Otherwise report its CPU physical address.

While at it, harden the existing doorbell resource query. Report it
only after the local dw-edma device is registered, and reject VF
queries because DWC cannot assign DMA/HDMA registers to VFs.

Reviewed-by: Frank Li <Frank.Li@nxp.com>
Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
Changes since v4:
  - No changes.

 .../pci/controller/dwc/pcie-designware-ep.c   | 107 ++++++++++++++++--
 1 file changed, 99 insertions(+), 8 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c b/drivers/pci/controller/dwc/pcie-designware-ep.c
index 6c18579466b4..2b2988011c3a 100644
--- a/drivers/pci/controller/dwc/pcie-designware-ep.c
+++ b/drivers/pci/controller/dwc/pcie-designware-ep.c
@@ -858,6 +858,15 @@ dw_pcie_ep_find_bar_rsvd_region(struct dw_pcie_ep *ep,
 	return NULL;
 }
 
+static int dw_pcie_ep_check_edma_vfunc(u8 vfunc_no)
+{
+	/*
+	 * The DWC endpoint databook says it is not possible to assign the
+	 * DMA/HDMA registers to any Virtual Function.
+	 */
+	return vfunc_no ? -EOPNOTSUPP : 0;
+}
+
 static int
 dw_pcie_ep_get_aux_resources_count(struct pci_epc *epc, u8 func_no,
 				   u8 vfunc_no)
@@ -865,14 +874,30 @@ dw_pcie_ep_get_aux_resources_count(struct pci_epc *epc, u8 func_no,
 	struct dw_pcie_ep *ep = epc_get_drvdata(epc);
 	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
 	struct dw_edma_chip *edma = &pci->edma;
+	u16 ll_wr_cnt, ll_rd_cnt;
+	int count = 0;
+	int ret;
 
 	if (!pci->edma_reg_size)
 		return 0;
 
-	if (edma->db_offset == ~0)
+	ret = dw_pcie_ep_check_edma_vfunc(vfunc_no);
+	if (ret)
+		return ret;
+
+	if (!edma->dw)
 		return 0;
 
-	return 1;
+	ll_wr_cnt = edma->ll_wr_cnt;
+	ll_rd_cnt = edma->ll_rd_cnt;
+
+	if (!edma->cfg_non_ll)
+		count += 1 + ll_wr_cnt + ll_rd_cnt;
+
+	if (edma->db_offset != ~0)
+		count++;
+
+	return count;
 }
 
 static int
@@ -885,14 +910,32 @@ dw_pcie_ep_get_aux_resources(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
 	const struct pci_epc_bar_rsvd_region *rsvd;
 	struct dw_edma_chip *edma = &pci->edma;
 	enum pci_barno dma_ctrl_bar = NO_BAR;
-	resource_size_t db_offset = edma->db_offset;
+	resource_size_t db_offset;
 	resource_size_t dma_ctrl_bar_offset = 0;
 	resource_size_t dma_reg_size;
-	int count;
+	u16 ll_wr_cnt, ll_rd_cnt;
+	bool has_ll;
+	unsigned int i;
+	int count, ret;
 
-	count = dw_pcie_ep_get_aux_resources_count(epc, func_no, vfunc_no);
-	if (count < 0)
-		return count;
+	if (!pci->edma_reg_size)
+		return 0;
+
+	ret = dw_pcie_ep_check_edma_vfunc(vfunc_no);
+	if (ret)
+		return ret;
+
+	if (!edma->dw)
+		return 0;
+
+	ll_wr_cnt = edma->ll_wr_cnt;
+	ll_rd_cnt = edma->ll_rd_cnt;
+	db_offset = edma->db_offset;
+	has_ll = !edma->cfg_non_ll;
+
+	count = db_offset != ~0;
+	if (has_ll)
+		count += 1 + ll_wr_cnt + ll_rd_cnt;
 
 	if (num_resources < count)
 		return -ENOSPC;
@@ -909,6 +952,54 @@ dw_pcie_ep_get_aux_resources(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
 	if (rsvd && rsvd->size < dma_reg_size)
 		dma_reg_size = rsvd->size;
 
+	count = 0;
+	if (has_ll) {
+		resources[count++] = (struct pci_epc_aux_resource) {
+			.type = PCI_EPC_AUX_DMA_CTRL_MMIO,
+			.phys_addr = pci->edma_reg_phys,
+			.size = dma_reg_size,
+			.bar = dma_ctrl_bar,
+			.bar_offset = dma_ctrl_bar_offset,
+			.u.dma_ctrl = {
+				.reg_layout = PCI_EPC_AUX_DMA_REG_LAYOUT_DW_EDMA,
+				.reg_layout_data = edma->mf,
+				.ep_to_rc_ch_cnt = ll_wr_cnt,
+				.rc_to_ep_ch_cnt = ll_rd_cnt,
+			},
+		};
+
+		for (i = 0; i < ll_wr_cnt; i++) {
+			struct dw_edma_region *ll = &edma->ll_region_wr[i];
+
+			resources[count++] = (struct pci_epc_aux_resource) {
+				.type = PCI_EPC_AUX_DMA_DESC_MEM,
+				.size = ll->sz,
+				.bar = NO_BAR,
+				.u.dma_desc = {
+					.dma_addr = ll->paddr,
+					.chan_id = i,
+				},
+			};
+		}
+
+		for (i = 0; i < ll_rd_cnt; i++) {
+			struct dw_edma_region *ll = &edma->ll_region_rd[i];
+
+			resources[count++] = (struct pci_epc_aux_resource) {
+				.type = PCI_EPC_AUX_DMA_DESC_MEM,
+				.size = ll->sz,
+				.bar = NO_BAR,
+				.u.dma_desc = {
+					.dma_addr = ll->paddr,
+					.chan_id = ll_wr_cnt + i,
+				},
+			};
+		}
+	}
+
+	if (db_offset == ~0)
+		return 0;
+
 	/*
 	 * For interrupt-emulation doorbells, report a standalone resource
 	 * instead of bundling it into the DMA controller MMIO resource.
@@ -917,7 +1008,7 @@ dw_pcie_ep_get_aux_resources(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
 				  sizeof(u32), dma_reg_size))
 		return -EINVAL;
 
-	resources[0] = (struct pci_epc_aux_resource) {
+	resources[count] = (struct pci_epc_aux_resource) {
 		.type = PCI_EPC_AUX_DOORBELL_MMIO,
 		.phys_addr = pci->edma_reg_phys + db_offset,
 		.size = sizeof(u32),
-- 
2.54.0

