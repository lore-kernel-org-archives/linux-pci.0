Received: from OS0P286CU011.outbound.protection.outlook.com (mail-japanwestazon11020104.outbound.protection.outlook.com [52.101.228.104])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F4952C3271;
	Mon, 26 Jan 2026 07:16:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.228.104
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769411774; cv=fail; b=VfSCiPjl5WXjm4m2Ymp3RT9+M90OWWm6kKxuTRkoMSSzi2zJ6tWZJCLoEuf4QyM2hsn+cOgEjTspFB/A9PmD4grtEPcQz/sPZC2F8X5XCWIXBJLvebOWOhI1mEpvQ0oMmor0cXH7jnuqcRnIFL7diO0/zZtytccO0VFqENI+3Ao=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769411774; c=relaxed/simple;
	bh=X5h5KITbnLDUM5vZ0sjOVUR+jOI60EWRavInB5R7VHQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Z2wIrwn9gGwREnaLS3ok7Kgae4SVWM3OJnyiqWXERtQNRvQd/CChvflD7QZ/1bvWN+qeN4uk9SRnN7C/dk/prueuzuFbmrkwknImfU37uT/2WAq6htJ3nJexFMp5zTM1mMC62gu5ihewyzpuMpxBg/66xMubrZLBsyLIqeZ+OZo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=eIWP8g9Z; arc=fail smtp.client-ip=52.101.228.104
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="eIWP8g9Z"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FPsMgVl7PojoHqO7gVWmcJlVqcwOzgoGd9bWEXubeOxKNjdM9dMBX+UycG4mebUgkM3SAOC71VJgXUyORdu5Sm9l2yNT+/c7xPPcIa7oYNUkMW4TerpH6WPq0QumUg38iE8dLG4pTdxOxp1h3hcaJh5JHfQ5Fb8p8PUfatgZf9THKTKE3nuiArJgGkTnn52LQWGFsPNjbDgTFBVL19vBW/Vry0L+SE0hF+oOjOmuRm5xoPMuyilckcA2QOQGh/7gjqzQ1L2kG6deCQrYgLUuw8ex7gNyWJ/IJeMCjGGo6gdsvNjZAN6BO4xuyREBBYC7XQaBom8IW0C8gV7ZYf0R0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Dn2+gl/ceTIgMuy3VSaoxy3zFwCS0PCmo1sp/rz5C5Y=;
 b=rRBN3rTsxBNmMDxanqvLzWHEAkulzHMBH5NYDDDf17+TbPzx5lpUrtD44ZZAuUm1S1JMOX0EmoHEivdRQ+t1zFhQWpb3VITam52zPOes5VA9dcpwGI0bDlgdm/ZhemKeG9pxl2wKnfCztqcxp0K0nClu1CCRi9HkfL03e+NxMYNrkXgBDvf87wWjAH0zTOrkvtFy/k9Xo2tZmPTWEh71u4YsWWYaKPEEVmXjjwkGQUs+WfWnH9HgVKyH2oKHKm0hBB6CTHyEXYEZHEgH7fh8Z0KTVDjtw+JioVNKjYDzvTEoTJwI3qfMko4UnBtIreGyYdHs+frQutZuhg/AD/7A1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Dn2+gl/ceTIgMuy3VSaoxy3zFwCS0PCmo1sp/rz5C5Y=;
 b=eIWP8g9ZAoAGCJxTGjSyo4GCC78wpBPVx6YmoHSMtObI7DCiQSXUC5NZOcs2G0f3GY4eUy1nzf3pEs5NS3zpgjlTwXlvnluxnU/Y2lVO05SNNv2Vj3APPFbeFapjD7o4irSjyEgID/LKVanmj6uCTyivFT5r5SPD/EeFyLDeUMI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by TY4P286MB6973.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:340::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.15; Mon, 26 Jan
 2026 07:16:04 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%5]) with mapi id 15.20.9542.010; Mon, 26 Jan 2026
 07:16:04 +0000
From: Koichiro Den <den@valinux.co.jp>
To: jingoohan1@gmail.com,
	mani@kernel.org,
	lpieralisi@kernel.org,
	kwilczynski@kernel.org,
	robh@kernel.org,
	bhelgaas@google.com,
	Frank.Li@nxp.com
Cc: linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] PCI: dwc: Add helper to query integrated dw-edma linked-list region
Date: Mon, 26 Jan 2026 16:15:50 +0900
Message-ID: <20260126071550.3233631-3-den@valinux.co.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260126071550.3233631-1-den@valinux.co.jp>
References: <20260126071550.3233631-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY4PR01CA0004.jpnprd01.prod.outlook.com
 (2603:1096:405:26e::16) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|TY4P286MB6973:EE_
X-MS-Office365-Filtering-Correlation-Id: 6617d708-476e-4c1d-2a1b-08de5caac446
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|10070799003;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?hPqkLjZqzhQub0sSpy07+yM/EXJ42idMbprTTe5VtZeE/SGYADI1w3c3rwFp?=
 =?us-ascii?Q?Zgs2q7ZeInL2c4zkrpyt8Rs3WajxcIf4dqTF/4FBitNIsMCwi3q9+DxQ01e+?=
 =?us-ascii?Q?Kw0brJ6HCXOylJWvAjwpiI4CjhM77EnlU0tpS0tmxSfYDhNPL/F7Hd0ycaY7?=
 =?us-ascii?Q?qI8or564HuDWkGSehArGNqHi/gD0643tMjHJo6lEKw4bYEahMmwe5K7gFItd?=
 =?us-ascii?Q?5kCeCod5HuidsD+i7L5C4OEcwGbV5vhC55lY2/H49Ge6KoKMjYZFs0u03ciD?=
 =?us-ascii?Q?Vb6BrR74E3e29db5dvqexarUsBr1IvbiOoDj++rLBni67RRO6c9LEDk4EJqQ?=
 =?us-ascii?Q?Bbbusmr7y3LwSc8bhbAoDE7KJow3QzFWlCYyfpfIArIMWMUP+lXH9DjqILZy?=
 =?us-ascii?Q?O9lZcs+gf9mqiZ6a19/9VQWdVV3QeyBAi/Fc0la6Hcl+KAbbBPN6taE9YZMd?=
 =?us-ascii?Q?HTPXSmk7jGwteraw6+oVQ9LgO3ZvQJ51gUZXnZ9rlOQ1Ti7gARySe+EmJSLG?=
 =?us-ascii?Q?uDY6hCN19x1BDHADkslf92mnCHuCmapAOEdU6FbtPzovNc95XkSB2FFozf0y?=
 =?us-ascii?Q?L5gKAVxztlto7UBPV+nmdNcRsMU9KtOpJCrXI0LuGD6x9vO1MKP4vXoPLVTs?=
 =?us-ascii?Q?lyk2m5HorAREaPcwjKlK1Uz6n5EUEfBIuGw1pBW0RuYhgQwLD3ztZJJnk85u?=
 =?us-ascii?Q?w8M0HK4IESaP6IvI+CMTt72utWCYgqgKNYQA3yzX8IWCkBPKJdHVZUL+SH93?=
 =?us-ascii?Q?xvu7uWil6zDQyrNIc0Et51p88/2PvW2GuGbP2cfbjaPKOO+++rQc5dbhjEdC?=
 =?us-ascii?Q?GSvZVQZ1SwnMKgPqCVGRT24YsNusxFw4Vv61wIA509gJ3RVQkuDe8wPjtlrg?=
 =?us-ascii?Q?LYO7NcpJc1GoOwdgTOrovcWjPn0gzQhgUf9StGvM+aGXwdRguWPwSRTfDE5h?=
 =?us-ascii?Q?2JfSJXrYiy0utoZa7yUKiP/66XMd4m/fPadpVu11UZh1Ems7yofNu1fmKxdn?=
 =?us-ascii?Q?wIdN3Dpz3KiDDi9v2rMTQVV9hRMfID04do/lZpKp3XCTPVvi8Te9hNt4zSAh?=
 =?us-ascii?Q?HOuELw1CiHSnlRjMnM52UHR1T0pZPX0vbo8wZiObMnsQijx9M/qIynt5Uw3k?=
 =?us-ascii?Q?5BKNH+qp/ofkPqby/C7+kk/l9OEFojEjCsDUxz8tePY9NZlVt9N9BfV4JpvS?=
 =?us-ascii?Q?stY5YE2E+SDNaaNfAKlOaHu8sO0tfslApwNRI8N4vdD5igS06PiNpmwdWxPj?=
 =?us-ascii?Q?8p0lATRuzQRh+2BG/RF3qYHsId4WfOLkqKjWZstni1d9EloBXkV0cW7T1Pv1?=
 =?us-ascii?Q?LUkLvFnUgD1WV/RGFbmoMYXzogpOhoTi/MJmjNhRiwnfbQ9OWjoWICcRxXsj?=
 =?us-ascii?Q?AxV3yTVmWhAWpU3HSJigN74fftgec5XXmOvbjW80VM9xoLccabnkTWRZy2j5?=
 =?us-ascii?Q?+Hf1NJMezV0HyQoq/dnOqq+9Ra4cJSidRHd9Pz+eSMI+gyM1louexb79eyKM?=
 =?us-ascii?Q?xeI0gXaKQ9nEXkSlgReH78QmmjZK9H9xsGYsHTYgn6qJlQKr93I47B8yNDmX?=
 =?us-ascii?Q?SttT45o/GQXoleVH9Qg=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(10070799003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Asr/mR6pfN7uAZTJut1ej4L0aRqAmVofUxVsRBXAjMxP1mpCb2rTYIHJmZQx?=
 =?us-ascii?Q?b89MIo7FZhQe3goWlh3MBxaehVLpJpriaHt/GoZ9xxUwfKnmSvBnsI0WSM8k?=
 =?us-ascii?Q?OXEasl/1DqtOxfhsd8cOl/CScmjTJ8ApDJ9UjW77lvr/orqIBIln5zCS3vcH?=
 =?us-ascii?Q?HEP8bkaU6epsoxFwik86hUorn9OS2fnTWcl8Fjk47MO1DTWDviv+gk9qBRFw?=
 =?us-ascii?Q?yIDOtqZG65+nHFhShlQL02cSINKNjaq6wAYw9llHmKmIqCjs7Y1AODGm3UnM?=
 =?us-ascii?Q?qZ3nfA0WkUPOeYp9QQvnBTb74i9vUjW4p3etgvqpDYjEkm+q/8lzYsbiVAwc?=
 =?us-ascii?Q?I7q/AnSrdlFc43iR5GX6sx84SKfZ/X1yXSaGYchmG+G3nwpyVG3mPN4BXKf/?=
 =?us-ascii?Q?90otH+j1Znv1+zpI/oWMC1CS5fLkKWUxvnAWtaqbZBpQPYBO9IusIuC259as?=
 =?us-ascii?Q?hcMUg47/SvyOBvyM8R3HZv3lH6K9+kQb7LXJpfYVXGhGSJRCnAxPOHr3d10k?=
 =?us-ascii?Q?RQNyt6dXJ6iKLgne/fZwnlkqsZ8qvaOb7nNVa7G6siRosMeKf+cnMTTIEkdy?=
 =?us-ascii?Q?zVytr0+TB/ZTZ3WvcoW2u3udmK9TQTPzLGyuCDevLWxI+dM1ODxOmNz/L0P+?=
 =?us-ascii?Q?cAKx1mRwWxGJo+UO3uJVbTI+od4nu48nlYfUR/epi15ebxXX5CMsWXvLyVNG?=
 =?us-ascii?Q?4SOPzpZAquzIz3WQWU0M0Q+zLGqGQxzokmD5Dl2ICdIhX9xxpuS7eIBRTU5S?=
 =?us-ascii?Q?NC/CsKVnwQ+hp0yGhqwmci1zMDUnYa0238HRu0tw4boZhqZCg7tVxUfsNBSO?=
 =?us-ascii?Q?bcWcPFVKapQQUhzlWDNOEYcWlpgxuL3DCANghnUR5bqo5MuG1RU6G0dNhanc?=
 =?us-ascii?Q?KkDMJ8KX4UeSA34CME8N416V1c72eVYyYGYz9J9dtWmAeBs7zKqU+4eyGTM1?=
 =?us-ascii?Q?y2sSFs9//hypcRrC0w+xvZal3j3Mm9p+lBcP6jJHi/yQ3dvMsQL43Ktg9DDc?=
 =?us-ascii?Q?gMW5Y+yV9V1jrKLId4yOF+J0nE/2aVEA26+s47x941jfamsxgy1LcJlGuZOw?=
 =?us-ascii?Q?lNX54B22yXqhQJwVx/zmgvg2/NHwgATw3l1Q+GcapMRTvfkRCCxtQ3nUuv/G?=
 =?us-ascii?Q?7zo5yrVym8caJUVeJeP8IYVpq7j4x6VNZpF0U3cMo2lXhKSgt/++mo6dL8tG?=
 =?us-ascii?Q?pVZctnN4M4LfDudDW2uf3MdkIudHSsCynuQ8d4iCQallBIxieyhX+jvIo1BA?=
 =?us-ascii?Q?1+6uucf4u8jz9e/G2BvCjhdlNOrBYjN1YABt1jV4FVrM0Lfnu5vjSakc82/P?=
 =?us-ascii?Q?+dcCPTS/HW0CWsKMF5AIxaG8MaLrCogunm5BHK7S+Inf+Ow5p/plu/cP8gpI?=
 =?us-ascii?Q?tsoo83wX3ON38iiVFJUBfxnBhYXUv5PY+ZzXAi2J5pwNRQYJHKa/qoQEojHV?=
 =?us-ascii?Q?OmjnDV0b/UiG4ZuNWaODijlWYu7X4gY/2Q+9Ki/gk/n3/BNof0IzL7UQAHRw?=
 =?us-ascii?Q?UUhRmYYwCagQUkNKrK22kzk9C0Vwff8pbwRoHSUxDkVcSpAhX9ocT8JDfMWk?=
 =?us-ascii?Q?Gn6H5xj2PgwbsfjNbrp/jotcYBwPGVdlbkfD3U9JvYr3wZ+WFUUORPxmuLgk?=
 =?us-ascii?Q?tJKerMvakabi5eguow9m5OUMI3N06sqbLR09eDGQwUeDg0fyjX42ZsVMDtPp?=
 =?us-ascii?Q?QKn0LSXOw8HjjK8k8o8FKHmJnNL2ROLzznB5Ngs4G8hK4YaeNKRRWAdZ4umI?=
 =?us-ascii?Q?sNsbUToTG4pTpUYiGrv9GUfSowdQWtam4LA10Af6gi9xY6FsMqts?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 6617d708-476e-4c1d-2a1b-08de5caac446
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jan 2026 07:16:04.0929
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eY6isqxcV2/hjc5rvXNIjC/VjrM53ezMpIK0vDxz8HdmA4v+jdArd8hj9gIb8uZRCBE1Eqdn9A3LGSEnd24nXg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY4P286MB6973

Some DesignWare PCIe endpoint controllers integrate a DesignWare eDMA
instance and allocate per-channel linked-list (LL) regions. Remote eDMA
providers may need to expose those LL regions to the host so it can
build descriptors against the remote view.

Export dwc_pcie_edma_get_ll_region() to allow higher-level code to query
the LL region (base/size) for a given EPC, transfer direction
(DMA_DEV_TO_MEM / DMA_MEM_TO_DEV) and hardware channel identifier. The
helper maps the request to the appropriate read/write LL region
depending on whether the integrated eDMA is the local or the remote
view.

Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
 drivers/pci/controller/dwc/pcie-designware.c | 45 ++++++++++++++++++++
 include/linux/pcie-dwc-edma.h                | 33 ++++++++++++++
 2 files changed, 78 insertions(+)

diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
index bbaeecce199a..e8617873e832 100644
--- a/drivers/pci/controller/dwc/pcie-designware.c
+++ b/drivers/pci/controller/dwc/pcie-designware.c
@@ -1369,3 +1369,48 @@ int dwc_pcie_edma_get_reg_window(struct pci_epc *epc, phys_addr_t *phys,
 	return 0;
 }
 EXPORT_SYMBOL_GPL(dwc_pcie_edma_get_reg_window);
+
+int dwc_pcie_edma_get_ll_region(struct pci_epc *epc,
+				enum dma_transfer_direction dir, int hw_id,
+				struct dw_edma_region *region)
+{
+	struct dw_edma_chip *chip;
+	struct dw_pcie_ep *ep;
+	struct dw_pcie *pci;
+	bool dir_read;
+
+	if (!epc || !region)
+		return -EINVAL;
+	if (dir != DMA_DEV_TO_MEM && dir != DMA_MEM_TO_DEV)
+		return -EINVAL;
+	if (hw_id < 0)
+		return -EINVAL;
+
+	ep = epc_get_drvdata(epc);
+	if (!ep)
+		return -ENODEV;
+
+	pci = to_dw_pcie_from_ep(ep);
+	chip = &pci->edma;
+
+	if (!chip->dev)
+		return -ENODEV;
+
+	if (chip->flags & DW_EDMA_CHIP_LOCAL)
+		dir_read = (dir == DMA_DEV_TO_MEM);
+	else
+		dir_read = (dir == DMA_MEM_TO_DEV);
+
+	if (dir_read) {
+		if (hw_id >= chip->ll_rd_cnt)
+			return -EINVAL;
+		*region = chip->ll_region_rd[hw_id];
+	} else {
+		if (hw_id >= chip->ll_wr_cnt)
+			return -EINVAL;
+		*region = chip->ll_region_wr[hw_id];
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(dwc_pcie_edma_get_ll_region);
diff --git a/include/linux/pcie-dwc-edma.h b/include/linux/pcie-dwc-edma.h
index a5b0595603f4..36afb4df1998 100644
--- a/include/linux/pcie-dwc-edma.h
+++ b/include/linux/pcie-dwc-edma.h
@@ -6,6 +6,8 @@
 #ifndef LINUX_PCIE_DWC_EDMA_H
 #define LINUX_PCIE_DWC_EDMA_H
 
+#include <linux/dma/edma.h>
+#include <linux/dmaengine.h>
 #include <linux/errno.h>
 #include <linux/kconfig.h>
 #include <linux/pci-epc.h>
@@ -27,6 +29,29 @@
  */
 int dwc_pcie_edma_get_reg_window(struct pci_epc *epc, phys_addr_t *phys,
 				 resource_size_t *sz);
+
+/**
+ * dwc_pcie_edma_get_ll_region() - get linked-list (LL) region for a HW channel
+ * @epc:    EPC device associated with the integrated eDMA instance
+ * @dir:    DMA transfer direction (%DMA_DEV_TO_MEM or %DMA_MEM_TO_DEV)
+ * @hw_id:  hardware channel identifier (equals to dw_edma_chan.id)
+ * @region: pointer to a region descriptor to fill in
+ *
+ * Some integrated DesignWare eDMA instances allocate per-channel linked-list
+ * (LL) regions for descriptor storage. This helper returns the LL region
+ * corresponding to @dir and @hw_id.
+ *
+ * The mapping between @dir and the underlying eDMA read/write LL region
+ * depends on whether the integrated eDMA instance represents a local or a
+ * remote view.
+ *
+ * Return: 0 on success, -EINVAL on invalid arguments (including out-of-range
+ *         @hw_id), or -ENODEV if the integrated eDMA instance is not present
+ *         or not initialized.
+ */
+int dwc_pcie_edma_get_ll_region(struct pci_epc *epc,
+				enum dma_transfer_direction dir, int hw_id,
+				struct dw_edma_region *region);
 #else
 static inline int
 dwc_pcie_edma_get_reg_window(struct pci_epc *epc, phys_addr_t *phys,
@@ -34,6 +59,14 @@ dwc_pcie_edma_get_reg_window(struct pci_epc *epc, phys_addr_t *phys,
 {
 	return -ENODEV;
 }
+
+static inline int
+dwc_pcie_edma_get_ll_region(struct pci_epc *epc,
+			    enum dma_transfer_direction dir, int hw_id,
+			    struct dw_edma_region *region)
+{
+	return -ENODEV;
+}
 #endif /* CONFIG_PCIE_DW */
 
 #endif /* LINUX_PCIE_DWC_EDMA_H */
-- 
2.51.0

