Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.229.108
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794576591;
	b=W/IGIRHbOnYt4DBgYeEfT9uHGjIaO33iTHm5ZnOD5ULq/7rsonGq7fXAkTOyhl1xhRhz
	 pVSfIcX5SVH1NCT2F/Tb7tw2fszDzpZbqqhtzRQ7l+1clcte/0thvvDtjsRkVChMQOf2h
	 /1evQIv6aPVnTa72jiY2Yfd7qtyIfOw8mdrEWiAtAL5OlR9Lb9MsriI42g1ym1KAGB0z5
	 C2ophM/daRZ52Cis+az7OqlbBxRWa7iYq4a3tjldU2uMBUqw4jVhJrn7IxdXh+VbmYJ/R
	 Mb8DYiG6tdb7PAs680d3oef3IdkisR0XFpNYKTPjMGW6NIDZXr7xiYqSfu02emowVWw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794576591;
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
	bh=QDF+vH7C6dVPva/+z08gSMrAX0jRK7SiWjWXZzTXCPg=;
	b=wBM6szHM9D6EYVhIN2zPxXtI8bq9A8UoFVlOOMXZ9jEF0Z37uVKA3jiBi7kjk/Y/h521
	 ouTKxL/uRmfDamMuxrPn8U5z8CgFnj4vHOuSJ8sSnm1ygaYFcDxm3WzE3Dx86ZGVr5Kfx
	 ShqyNlc21F9gvjT2y4pC4egLsaSlQiTE+lfedZTgypfAgsUtVVVfstfotMk3f2r29OdTQ
	 N34EUacA9bfoEgWhHpbHknsB60ek1OgX98lUnFvnR/gIvpNsdh5fsp2lFHvgu/JTZpvDX
	 aR4oCEqwrq9KOkjW3pInWT1bzEXbqkLr4niOYZy9n8sGKVj+0H4ouk+CPv1lWuTRgDw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=valinux.co.jp;
	spf=pass smtp.mailfrom=valinux.co.jp;
	dkim=pass header.d=valinux.co.jp header.i=@valinux.co.jp header.a=rsa-sha256 header.s=selector1 header.b=vaLlzOdt;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.229.108
Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazon11020108.outbound.protection.outlook.com [52.101.229.108])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2204606AB8A;
	Fri, 13 Nov 2026 13:29:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E2204606AB8A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=valinux.co.jp header.i=@valinux.co.jp header.a=rsa-sha256 header.s=selector1 header.b=vaLlzOdt
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UfFAhf5zi1TXcB6esKS1ptVAw46SHICvmSkuKqCMiobCZfcKpwNNLTO/r7Rj2DyC+16ZtkMwg/g4jBeOf3L3sqKFgW+FjRsXQ8DUv+29yW3Vyv/ySJSlEhIwzU5rdLKQy6DPVtS6opjzY+LUA3xWRxVqn9l6+Yfs1VeGoEsnISxrLeAqQEj358vslRZ4MCcMHBQYGt/5tG8ctRm/oNhhNdxP03SXRRragqbsScxlZgm6BxYL0wx6Hqp4QDWTP/7wwVbb5cTLCmjJ+0LvQnrjuC7vAeTUQnWgAYrvSCOpw72uFCrdG0HLTU3FdvVqH8ANTrYEhaKoawabwUsuMRlhTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QDF+vH7C6dVPva/+z08gSMrAX0jRK7SiWjWXZzTXCPg=;
 b=Omxj8tGDUXgWWF6/HhNGNbiyjf8j3taQv2Km5C0LMp8oi03X3JofKlAWz3WybFMCDHDgUiFGL6BDwTEWwgnbHjJ+GXys41yjtDWEJwEMnlylx80iwE5uu5DMQWuAmdmR2fjVeeeNOxr5hMN2Az6bBwQFnRnbbsmYxLlywVn7vJZJjXIWewbrwCnGtzNgZXNO/j/iF+8JrRICfjw+fgGovcQ90ghDlQVzZNmwXyz+MZ4/ENalfdv/F/IGp5QXQdrnwFsI57Eo8Ab/w+l9v8HC9qGxEirAgmlEkd78uKTgzbPqQH+RPxyMIEGEOCwClicOHqiE4/vfsdTBmR/9G8yOFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QDF+vH7C6dVPva/+z08gSMrAX0jRK7SiWjWXZzTXCPg=;
 b=vaLlzOdtA8x8HotC0vz/huQVOeHEDS+ne9IknmSw8dglcXgOpkdfp6CnPB5Af9Mw7+YPdD6DaYHb9xhlY/VdKUf8DmpjrFAgH+ojtG7KEIyrE42Z3Wp0W10Dn+16ddCp5PArtIZKASOrMF3qfD4tmmW6bETm1ClPGfK1mwF/CE0=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:325::11)
 by TYVP286MB3716.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:36d::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.10; Fri, 13 Nov
 2026 13:29:47 +0000
Received: from TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 ([fe80::cce5:2aa8:53f9:dba9]) by TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 ([fe80::cce5:2aa8:53f9:dba9%5]) with mapi id 15.21.0615.009; Fri, 13 Nov 2026
 13:29:47 +0000
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
Subject: [PATCH v10 02/10] PCI: dwc: Expose endpoint DMA resources
Date: Fri, 13 Nov 2026 22:29:27 +0900
Message-ID: <20261113132935.4152566-3-den@valinux.co.jp>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261113132935.4152566-1-den@valinux.co.jp>
References: <20261113132935.4152566-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0161.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:383::6) To TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
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
X-MS-TrafficTypeDiagnostic: TY7P286MB6866:EE_|TYVP286MB3716:EE_
X-MS-Office365-Filtering-Correlation-Id: bc1b62e6-3be0-44ca-118e-08df418a2f9c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|10070799003|1800799024|376014|7416014|366016|18002099003|22082099003|6133799003|261009223027099003|56012099006|10067099003|261102123227099003|261102130727099003|261022105027099003|261026121527099003|261022113327099003|261028144727099003|261021121427099003|261026140227099003|261021123027099003;
X-Microsoft-Antispam-Message-Info:
	E09gzq/h59BzWwLbxTT3S0Kydbs5qdWoyr4t4GNhAxOHNdThFjGkuZbbKA4KyzExYBho/E9vdrJzQIpvht5b7A+/6xlminhnFh4D29hgGeV34R4OBKq42ucqYNENrGmCLi0vaWne0XwZom51wPpH0C7+GBq8Qbzs+WoQYhx3PkdtLm08ICTH+AH5Umln0jKSgHlLnQxBEKp2IU4TPWituEl8X990hq80asRZc0QcumgNKT3prqOEBWwXC7SG03tAOj51Z3+q5zXrWHjoMDtC4DHCYXnsRWe+UFFtbvZ2KCcQJTLjOv+bkCEFHCLc8Chd3K9cYWD83/XlMideJX5FmIQXiXqldgN8/up88qIBichyMMK05TCNIhbS8K0rRmIPhkLVh8EjpPlX7+c6vQarGHJUNG0a5P91z8cs+58/jTUkX0IpCH9bmkw0w12l38k5PqnqWkLGhE6m/HDhjy2ZaaYD9g9pRNlTPiDskbW1zoiRT7vRVq5iTtubWV8f3A/NlWNEE9/YN+/INWvmXJNyLmGJtEFacDHa9lHSKnOx3iz9bYUwrTyqSIk0C2nYujuFivyD2d0EWZH67ZDTSd7du8IVb58MA5W/xEfyouzNWZ62xldR52ymLnjAU7L080SYaBkrN4uapZigfF3x6oOs9kzUXc8FLXD5lZW/UVAJZUQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(10070799003)(1800799024)(376014)(7416014)(366016)(18002099003)(22082099003)(6133799003)(261009223027099003)(56012099006)(10067099003)(261102123227099003)(261102130727099003)(261022105027099003)(261026121527099003)(261022113327099003)(261028144727099003)(261021121427099003)(261026140227099003)(261021123027099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Ybp4gcVhLF5eU3LvfL2C1xraufFn31vwDeVYrTOlWAH+9XzYKZg/o74ElrbG?=
 =?us-ascii?Q?RcFKWHqcebHLDH6Z0zsYDBCIzgMJcGgFujrXgkueU1IfjXfsOvr3kckWE9PN?=
 =?us-ascii?Q?35vGzduW5qswudLqtMBvJh3nJXWxGy+P8jlZgStlS/DKo1JkFsPQaz3GGK3P?=
 =?us-ascii?Q?Ygch1KWVyvrLUOg9ZjLxwW9/yBVGPaZFW2V7xFF7SPAmi7LuWAdimETIMOUb?=
 =?us-ascii?Q?tawQNmD4pwoirwX3XNml0U3KiZOQl8QUS7JUq9TVTU0+MAlkNKNTZxzBrzP6?=
 =?us-ascii?Q?rVdZ4EfTcgCn3JY1aqFma/OzpptBqFVW6TgSnoq74ri6ZZD9YkSqA1cH5fVa?=
 =?us-ascii?Q?GtpsbWyMHminzNyhlAolknYDKEjf2uiL2Ox5E2/VuydcRfkhmeDvrzO7lgvI?=
 =?us-ascii?Q?aRUv9dlBQhxGhtLCUbWTRYC7Dkh23naubEZBY5z1AXWAzmjV/sN4YKAozdtR?=
 =?us-ascii?Q?RgEc1xgElpidOOwTL5qsZzaU0XsRet2H2qmrnHjwtu1SYAqlSOkZXdGF7VPV?=
 =?us-ascii?Q?dechPoyZ4vdsX7Xcl9GMz0NzKr+reObE3PtJDfBxiafFrUL2ibMYOlkIodNW?=
 =?us-ascii?Q?6J1QyeeLqMuzalcxG3n7kkW/6+3oEqD7ZJvpE3K1JWYaryDAttpiKWoVmU3Z?=
 =?us-ascii?Q?Gd0J692HwMqu7XP59K65J3C4lCyczH9oKUWzUQXbKvJlITI90PIo0znR7jRB?=
 =?us-ascii?Q?JPUmA6CcJ8jDn6kQZ7aNSXAJu7hzxVq+Jm2x5dopbAxZxsF2Errr107tOPkb?=
 =?us-ascii?Q?6rNVbC9WXpMgSwppEnkfRTysV7P0KxjL2zHoroByGMJ7E4aE6Wy701hbUIAT?=
 =?us-ascii?Q?1br/J+r4a9V8ZuCkWrBVkEi2mBXBdq3uTaEeIxIDHoncdasrtk0mZCLW3LjV?=
 =?us-ascii?Q?j8Cp8X91f/kH760Ivu0KMIrcpMEMDND/luZaq9fOGokPHEVurIq515sHODGV?=
 =?us-ascii?Q?QZozWtIh8ldl+p3wApOQ0SK14epax5t25G+QHz3p8u/ET4DLMY3xvIfX1Ig/?=
 =?us-ascii?Q?iESRubVsdpwSV0SqA7s7eRYH8FOwgiyOeZHoRHxHRMDfOGDFR9ih1JXQXaT/?=
 =?us-ascii?Q?RRUPHDj1F/mvbFO3mLYMkTPECHqv7Usn2vaKoDDmj1krzZ2q9xvVVeIAMw06?=
 =?us-ascii?Q?q4mPHokxDeBwNySzjOhhvLqVQfI52Etuvi+814FBbHeNfEATHOF9F6WfTicR?=
 =?us-ascii?Q?Xuv/FmHQrxA3w9Jm2UrlmZ9gWOKA6Bjqfiew8SBbSfZlj9Pvz1v4Fxo7+5lr?=
 =?us-ascii?Q?ckYRYI+ajQt/r8AnB9XliAOgGghog27TTSL3X2V+jtgrCT/hzA004GrKPYP7?=
 =?us-ascii?Q?LOf6FNdNnGPrUMxbH0lVDXD6F9EOj7hbG7JuRYEG1W7MBIaym4jz8xEsN5j6?=
 =?us-ascii?Q?2+7nU9tyQ2nH08p9VwNGVvXP88H3ViJG+FAkzfWcC+99FDsqJZXT1iw/klAo?=
 =?us-ascii?Q?DfhSCaj+ZzjvAfFyqw1Ughrst1szP6eaw/VjFgqWfl17K6kn19yGciseAgKW?=
 =?us-ascii?Q?0RQ3cRVixP9eXP3/Ew0o6BfRb7MqgSWVVXg0XYqOgVQ3j0wFlBV9XXJs8Ate?=
 =?us-ascii?Q?bXQy4e9ahySxwIXN5+AafP7GlzyxnWARHvZ07L7gkuJDKXjbbf0LprWxtUyR?=
 =?us-ascii?Q?3wKt/5jtrVe3f+Qc2YlngazTRrvI3GNYG+6c2AzM7X8WrQMa/GUSaDCQhPF0?=
 =?us-ascii?Q?LeKdQUJVKgkzl1hbtImoYzZ/ie6UB05uCiOOFXL23ffLhL93HNYbeW2fyWo0?=
 =?us-ascii?Q?wBx1o9BOX2JhczAXvf3m1y/53WmNdmB68maj0m9mr8So+bzzvwGn?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: bc1b62e6-3be0-44ca-118e-08df418a2f9c
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2026 13:29:47.1024
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5gZC3LRmbJ9mKRxrMreJ+tOpfAheckVlyaPrAE6MORVaea+qySxvHg/P7V29E+qtnjFR1iI5+ky+fbhEpLVpJA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYVP286MB3716

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
index 630ba172280c..7166ec7f212b 100644
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

