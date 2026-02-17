Received: from OS0P286CU010.outbound.protection.outlook.com (mail-japanwestazon11021114.outbound.protection.outlook.com [40.107.74.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CC832E1F0E;
	Tue, 17 Feb 2026 08:06:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.74.114
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771315579; cv=fail; b=dvZtnCzDZBUDjhzx8hWB0aU8orVPGm1OAqHxjlWGjy2XYfbaJIip6ZzrYTq36SL80wkLwTbH2U5N+aQjI8Cec7pHtl+PcW/VAQC6Lz0H1COauvU+2fN2G7LtND0SweTtZ1gTRbDCvqan8OPZyLz49GuWHXZESIJEsqQzRhxaBpg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771315579; c=relaxed/simple;
	bh=PxTbLjMewAMWGY784JXwab4skk0wddfnEqT1sdzUfo8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=pS2P69C51FIzWNIkldhznGG51evS4/2bZSI/JI6x+GEN/bVItaJn1wRQvLr5zLFGEYXg4xYdIXsuCyvov2grJMNr/U6NQiOr+bojvOi+nSecvFFcVPPIyVUxEmNruxGnca4h7Cpst9MtdxYCT0uoMZmyFtDXoHACQmbkz+L2op4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=R31/9uAw; arc=fail smtp.client-ip=40.107.74.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="R31/9uAw"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MM9ynv+qsfO2K7rlYtUwb2yi058wRgsG8L9oonJEyHj7P4GA0doQfQ62s90triijhuklB2Uclv7ppYGKCEwLnHSZBwfDcsih/W6R0n8JCFoWNZAeIlxvC8hcEcPddX4r656Mgs/G15/E4thEWRA/cCxj4pZlKD+uhLtYgXiHNbuM+EY8r63lIoI3lGdEGjZQc76ix2X9VRJfO+x1R/cslcvfMnuN/Uh2jX/Eqh2SP7jAsbh+LWEogetvjcQ2nRhRw0WFLZjUdD8MtGYfs0/+1tCF69RDLWNTuw0Xaj+4b3MBdxWXdtGWUdK65siZm0tnEva4deabiEaP4ubOz1qQpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UnpEJbNlT3wgIICCe6Hn7gKgsJuija/JZQQy7qzTEaA=;
 b=hpqpXLcQpfMb4EVKuEqFn25ois5C5UmBNNX8t+HxbWIpP0+/XynHaCTQ1U4GnHVPp/83Go7BjoYF6AxtN2CRYWfe8Qhcto2iBSEH8tgfJueJiG6+06Y/g+x50nQ4rT8mtIAyIXQQbbI/zuY6A46zVD+snT4Di+H4PJHB2yIM1QZG8RQITFNqtHWsw2DvlP0NnnJ5iIoV/CdJlOHGblD585+177mxPqjdhsAvh55xmS/EOOzbu11c19gKDqT0jTcQy89rd6LmMS2OGBv7FLH4+iLZ1rs4mu7IM3BZlUqoPGAbZtwNfCzKpUDf2grfGXYw2Iqivd0Cuu1zj8Hu7LgmpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UnpEJbNlT3wgIICCe6Hn7gKgsJuija/JZQQy7qzTEaA=;
 b=R31/9uAw2Vt4yEL7K/Ftoffs2VTmOBfWkjRqHyZW/PZdmZ/cWzvNsnu3rmzMXc6rwJsA27dbcYo1vFd+70mGVPdUwYOI+bcdOj8dl0FF+OXoYpTwb1W162WoYRr0ljZB0q/EqKckyb4LYqWNw9HOlbd0cEBSJTrLZjShfLmU3Z4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by OS7P286MB7132.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:42f::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.16; Tue, 17 Feb
 2026 08:06:10 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%5]) with mapi id 15.20.9611.013; Tue, 17 Feb 2026
 08:06:10 +0000
From: Koichiro Den <den@valinux.co.jp>
To: jingoohan1@gmail.com,
	mani@kernel.org,
	lpieralisi@kernel.org,
	kwilczynski@kernel.org,
	robh@kernel.org,
	bhelgaas@google.com,
	heiko@sntech.de,
	kishon@kernel.org,
	jdmason@kudzu.us,
	dave.jiang@intel.com,
	allenbh@gmail.com,
	cassel@kernel.org,
	shawn.lin@rock-chips.com,
	Frank.Li@nxp.com
Cc: linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	ntb@lists.linux.dev
Subject: [PATCH v8 3/9] PCI: endpoint: Add auxiliary resource query API
Date: Tue, 17 Feb 2026 17:05:55 +0900
Message-ID: <20260217080601.3808847-4-den@valinux.co.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260217080601.3808847-1-den@valinux.co.jp>
References: <20260217080601.3808847-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY4P301CA0005.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:26f::9) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|OS7P286MB7132:EE_
X-MS-Office365-Filtering-Correlation-Id: c2a5481d-ee94-4002-42a6-08de6dfb691f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|1800799024|7416014|10070799003|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?rsGkcYQBMdZ1akNzeEV/uJ1Nj5FAxnC17AbLCuwwKC3vlQhxM/3Lq1GY5G4u?=
 =?us-ascii?Q?pGa0bEIl2+/5xJHZx69cN29vkG8Q0t7hDQav8ZcEaL76F0vgEj23P+6FjGJj?=
 =?us-ascii?Q?LJLm21DkHjSWpXvtHQ6j27htyJ8KYa5SyE9oHmzPL8SDERYkjRNfyR7J6w1I?=
 =?us-ascii?Q?ypGURMERe0xXKt7ufvTPQzchFJHiNk0B0KGpzQmNEX7N4ZcLropRgh24BgMl?=
 =?us-ascii?Q?Ep9eT9KSV5UGT9VTt0izIG5uDVmpyHXiCNg7KbYWNb61ipu5s23GDbA2wZvY?=
 =?us-ascii?Q?WfvP/foIqO7updF8VtB+odylY7yg4tCPDH85KDTH90HLQij0TUu3DmpZbrpQ?=
 =?us-ascii?Q?+S4azm0iSUv5Is3GgjdK1kU4dXZYc8GDNOwiwzP3H9ljGdXX/cZQH94lDkF/?=
 =?us-ascii?Q?zF8mu+Ga818Kna3D42dsuU8vGUen5lGd+4wtc9gqYbL+YJfAWWBfBG8coTXH?=
 =?us-ascii?Q?SKcbLO2ajZtjkVUymHyCr8lq1YDxqdmVytMCLp+LEZyLg5Vb+NOhDbRkdn4c?=
 =?us-ascii?Q?dhwttbTUxymioHiM1/bEPSzuVySFvdcY8L+0WKjKkHUq2VJA+tbVfD2RABkY?=
 =?us-ascii?Q?BR1HKzjQNeG1hMSeMCWWYDU8HLriNbsjv3uSjbZSaHHGT5pSE7Sv4uvokyL+?=
 =?us-ascii?Q?BYY4W4VPOV5Zj1TXn8j2XUd2mkYqihPJPsQ5d7CI87YzZWNmhBDR/Fhwkd0J?=
 =?us-ascii?Q?7Y/js6YR096KAS7Ex96hVgCsQ43jIVQYKltvGvWtfBRXJqq1zOJfW3jsJx3R?=
 =?us-ascii?Q?6lrb4ryWL1k+0muPR4f/yON9nWaHIIWkhsgXkom8vK7kxOPdxjZpYO0A3s9C?=
 =?us-ascii?Q?6GLtnYSAOwCz6l6YagrTopN619D/W4OwJnZo0QaKnG11o2orJBdKqDUHi73k?=
 =?us-ascii?Q?Ewne+o5zI+7C54sIo1K9UDx43i5p3j33R3AOWByPXIiLFqOD12uzC+S8VF+M?=
 =?us-ascii?Q?OlRh1Y0kt1jrzvdhjkHv+npWrQxuuba58aXwymnL6IxjdAjjqU5ADmpCY4S0?=
 =?us-ascii?Q?I9HA8vcj9w2BqqvyTiDdeUFWodhmMJNvHTkcUxf9nhMRwau0WIyaU8JwvqOl?=
 =?us-ascii?Q?87wvIQhHZxazwZui137G3IJTyA/gWNX4wpntm1J2pnvb7mMetDpbv2IQ25hV?=
 =?us-ascii?Q?bgMn2ouYl8HIX25OBsi5JeO2RzaRB+EytasHHmp0xqHC7mXbj9QSE7TdHoT9?=
 =?us-ascii?Q?5RP+cO4VQhJDp30EV6e6En7pwPLq8tOuAFbi7ZHJU3qTxnlACR4LOtcKb3/W?=
 =?us-ascii?Q?HEWeZGPRZ/Tqhm0o45fr1SpDjGgpVhH1IZwKv4YzI7ZVdqGEXKTf1bktnkY2?=
 =?us-ascii?Q?UQrGspwrzCYQFrPwiitBJimLUBnN2OmWU42KPm7I4GNZ22S+nGyFTkkK65fA?=
 =?us-ascii?Q?1AMQLw5KdFzTGFkBvN/4ePuRXmH0Xi0YgzImtDBp+yPjLiu8FtG9llt01Soe?=
 =?us-ascii?Q?cRbRE0F4wUgYUS92AtzQ7vf7T/QxXuziOUEFRNHLlVPWvFLzcnP/QkKqNL8j?=
 =?us-ascii?Q?G5FLEQ43l8WiAr298HzRKhKRsLoL1HDiQN2vTbEPIa20MSrnc+OQEqp9LPI2?=
 =?us-ascii?Q?DeZsVGH1dcyYnsAqt2vKm1P3+rU7WfqYUc/d9mZN7Yro2EevkDpwDexXayF3?=
 =?us-ascii?Q?sg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7416014)(10070799003)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?DYs3ECes0HhtdyAEVe3D3ZKfw0bqezEotV7oXiPvRlxPbB09VKlKy6RXTR2H?=
 =?us-ascii?Q?6VHYu9CzptMCNSeF3tg+rIUwsuuGiw6bNAl+yXDIccxn+4zx3XL2DV3JnNwH?=
 =?us-ascii?Q?Z8E9EN/P29+l8I0Y3f74uVfLKgIbLQlNwoZMI/ln24JZeZiHirdz5fe7pq+h?=
 =?us-ascii?Q?cFE/Xi05353rzqgN78VwjTq3Z2bZW6Ge7Cl30eKHyTt1FuMg4GQienS0sxa4?=
 =?us-ascii?Q?ybYrw/iu796vrL+8EngMp1FFMJKf9ahmVO+lOkY6NJo3cOH2vXGfajhucxXt?=
 =?us-ascii?Q?XwveNVjH8vEPIqMnl5Hk8IGD1E3Amoa9QHd7hEvHCDUD7Zg4+uVwXVlKyh9k?=
 =?us-ascii?Q?BW3MnOIo01wudb8QzjaLpGqdsRD8i4sZaIn+Hff4Kyo0v0K5f3ym0LQFebMM?=
 =?us-ascii?Q?H+qtFKHOkOCoSSRQvKw+FWmntmowocBfTCIAIgCfbGDTAkDKuE2w5AwB5iKX?=
 =?us-ascii?Q?2hIDpwPvxp1cTLaZwG17zYKyC0OcpStwgkwzG0/6BpBEXNFChnW9jVU6bF3i?=
 =?us-ascii?Q?UsxYLc1sDw1CO8CeaRDneuK/nKuczSF96NPnT1yeC7y/UZbCZx/zQnX3+kF7?=
 =?us-ascii?Q?SjaE1Wg0f6tFcKqPJuU4ysoc0hsupzEqxGklZLUtaEcJtera0Zm17iUvxd6V?=
 =?us-ascii?Q?aqng8LlVhNHNLu9PJ83O4HIGV56cVDnzyTJP9hfHftHAP+/ZQR9Xlyp+Od+0?=
 =?us-ascii?Q?AK0vOIx5heUr6Nt7pdxSL4FwVAsH8xi39CwU/+Equ3CayF+CuhzL7BpCh6sL?=
 =?us-ascii?Q?MYK/sYBcjSuf65gJL7s1XoQRYl7FGFmbsyd2BYMM/Uzcy7R8kTHhUXb/yMmg?=
 =?us-ascii?Q?1WGQ/L/fJUvrklfDhgQMEbiXunWUOjBJopr2BUlMLni73EHqAAciUrU2zkEm?=
 =?us-ascii?Q?lugfsXN9UJvI6/gM+Pv8HiZM5x95LAerJk5TGAJPsvT0XoZ8eRS0ETii9EUO?=
 =?us-ascii?Q?KY+e2ZfByFCorqaW60cx9BzaujZOWQU5+vWURNDA4bxnIlXyBYjisisMHOnv?=
 =?us-ascii?Q?xGOJFHATxwCc0Z3ZYnbmxEdSX7R0Cozm143knl+Jer+2R+Hm3FVX9vz3FShj?=
 =?us-ascii?Q?W1+USg8v/PCiXjRX14x6XCfqyY6S62Y5nwn1HMRbNwl34ZO3svmjFejQoK7x?=
 =?us-ascii?Q?4H5GCgHp4UUkMFsOnxDz+OLYxLx0ckL8lVjrWWixiAiqbn5DAX9/8Un8bz5A?=
 =?us-ascii?Q?VBAKaGflQE+JRZthOg7Fz42UUntHm0YPDfdp36rMdK/EPKCrJTsMHvKT7lEP?=
 =?us-ascii?Q?rpP356lDu30gyGHRtVnfMZO+F9t1NkGtUG7iV3feqpTyaeu85UJliBmf7mnp?=
 =?us-ascii?Q?wakatEKB1RyyrKGlQE1mvwdZcmiXikDnH2eKEdJo4A+HUSjSPGW2zGhGnCup?=
 =?us-ascii?Q?lLxKUTwlA97xo3c7TYab+GKQAenwZFSEHRfgpAJrlXS40hfCU+APo9HcOZQ0?=
 =?us-ascii?Q?YDrUutUpc+gs0M7KPX0/P4dE4A5wDqZRDFhp2pjUDNDkm1I5COhl8Lm80pFk?=
 =?us-ascii?Q?hSuo7MDBhcC++73OfJ7lTHcVijyly5A7ETRtbzSGjI0D3XgNJXVMbFiz4eRT?=
 =?us-ascii?Q?gRw5BjW5CCi9YxjzGTC6H5PcKng5FmruL85vbHX61a3bWwJ11ip0EWwVtWaE?=
 =?us-ascii?Q?duiGooN2Jylitit0EdOqth8qrOS/qJf/rVAlYmcMx97X108tIumLh665+Qot?=
 =?us-ascii?Q?Msn+TWTx3/jlHWBLahJD08ogftIgu9bRQQe4oZevCWodVMY3hqqRQHEWsyRj?=
 =?us-ascii?Q?5G05NKmkPxxp81e/RCFyK4pa/n3m5e2fc2s0rxxRUc2gFPttOmrU?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: c2a5481d-ee94-4002-42a6-08de6dfb691f
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Feb 2026 08:06:10.1824
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OCXUeUG7Bss5WV23R9wSaik6LveiTsMEculIUpDvWSqhrglsQm0T1UCLS1WGrrcDn5pY02HrfwQd5xlqP4Pnmg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS7P286MB7132

Endpoint controller drivers may integrate auxiliary blocks (e.g. DMA
engines) whose register windows and descriptor memories metadata need to
be exposed to a remote peer. Endpoint function drivers need a generic
way to discover such resources without hard-coding controller-specific
helpers.

Add pci_epc_get_aux_resources() and the corresponding pci_epc_ops
get_aux_resources() callback. The API returns a list of resources
described by type, physical address and size, plus type-specific
metadata.

Passing resources == NULL (or num_resources == 0) returns the required
number of entries.

Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
Changes since v7:
  - Add a 'data' field in pci_epc_aux_resource.u.db_mmio.
  - Add comments describing the type-specific metadata fields.

 drivers/pci/endpoint/pci-epc-core.c | 41 +++++++++++++++++++++++
 include/linux/pci-epc.h             | 52 +++++++++++++++++++++++++++++
 2 files changed, 93 insertions(+)

diff --git a/drivers/pci/endpoint/pci-epc-core.c b/drivers/pci/endpoint/pci-epc-core.c
index 068155819c57..01de4bd5047a 100644
--- a/drivers/pci/endpoint/pci-epc-core.c
+++ b/drivers/pci/endpoint/pci-epc-core.c
@@ -155,6 +155,47 @@ const struct pci_epc_features *pci_epc_get_features(struct pci_epc *epc,
 }
 EXPORT_SYMBOL_GPL(pci_epc_get_features);
 
+/**
+ * pci_epc_get_aux_resources() - query EPC-provided auxiliary resources
+ * @epc: EPC device
+ * @func_no: function number
+ * @vfunc_no: virtual function number
+ * @resources: output array (may be NULL to query required count)
+ * @num_resources: size of @resources array in entries (0 when querying count)
+ *
+ * Some EPC backends integrate auxiliary blocks (e.g. DMA engines) whose control
+ * registers and/or descriptor memories can be exposed to the host by mapping
+ * them into BAR space. This helper queries the backend for such resources.
+ *
+ * Return:
+ *   * >= 0: number of resources returned (or required, if @resources is NULL)
+ *   * -EOPNOTSUPP: backend does not support auxiliary resource queries
+ *   * other -errno on failure
+ */
+int pci_epc_get_aux_resources(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
+			      struct pci_epc_aux_resource *resources,
+			      int num_resources)
+{
+	int ret;
+
+	if (!epc || !epc->ops)
+		return -EINVAL;
+
+	if (func_no >= epc->max_functions)
+		return -EINVAL;
+
+	if (!epc->ops->get_aux_resources)
+		return -EOPNOTSUPP;
+
+	mutex_lock(&epc->lock);
+	ret = epc->ops->get_aux_resources(epc, func_no, vfunc_no, resources,
+					  num_resources);
+	mutex_unlock(&epc->lock);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(pci_epc_get_aux_resources);
+
 /**
  * pci_epc_stop() - stop the PCI link
  * @epc: the link of the EPC device that has to be stopped
diff --git a/include/linux/pci-epc.h b/include/linux/pci-epc.h
index 7a87f5962dd0..c68aaaf3542a 100644
--- a/include/linux/pci-epc.h
+++ b/include/linux/pci-epc.h
@@ -61,6 +61,51 @@ struct pci_epc_map {
 	void __iomem	*virt_addr;
 };
 
+/**
+ * enum pci_epc_aux_resource_type - auxiliary resource type identifiers
+ * @PCI_EPC_AUX_DMA_CTRL_MMIO: Integrated DMA controller register window (MMIO)
+ * @PCI_EPC_AUX_DMA_CHAN_DESC: Per-channel DMA descriptor
+ * @PCI_EPC_AUX_DOORBELL_MMIO: Doorbell MMIO, that might be outside the DMA
+ *                             controller register window
+ *
+ * EPC backends may expose auxiliary blocks (e.g. DMA engines) by mapping their
+ * register windows and descriptor memories into BAR space. This enum
+ * identifies the type of each exposable resource.
+ */
+enum pci_epc_aux_resource_type {
+	PCI_EPC_AUX_DMA_CTRL_MMIO,
+	PCI_EPC_AUX_DMA_CHAN_DESC,
+	PCI_EPC_AUX_DOORBELL_MMIO,
+};
+
+/**
+ * struct pci_epc_aux_resource - a physical auxiliary resource that may be
+ *                               exposed for peer use
+ * @type:       resource type, see enum pci_epc_aux_resource_type
+ * @phys_addr:  physical base address of the resource
+ * @size:       size of the resource in bytes
+ * @bar:        BAR number where this resource is already exposed to the RC
+ *              (NO_BAR if not)
+ * @bar_offset: offset within @bar where the resource starts (valid iff
+ *              @bar != NO_BAR)
+ * @u:          type-specific metadata
+ */
+struct pci_epc_aux_resource {
+	enum pci_epc_aux_resource_type type;
+	phys_addr_t phys_addr;
+	resource_size_t size;
+	enum pci_barno bar;
+	resource_size_t bar_offset;
+
+	union {
+		/* PCI_EPC_AUX_DOORBELL_MMIO */
+		struct {
+			int irq; /* IRQ number for the doorbell handler */
+			u32 data; /* write value to ring the doorbell */
+		} db_mmio;
+	} u;
+};
+
 /**
  * struct pci_epc_ops - set of function pointers for performing EPC operations
  * @write_header: ops to populate configuration space header
@@ -84,6 +129,7 @@ struct pci_epc_map {
  * @start: ops to start the PCI link
  * @stop: ops to stop the PCI link
  * @get_features: ops to get the features supported by the EPC
+ * @get_aux_resources: ops to retrieve controller-owned auxiliary resources
  * @owner: the module owner containing the ops
  */
 struct pci_epc_ops {
@@ -115,6 +161,9 @@ struct pci_epc_ops {
 	void	(*stop)(struct pci_epc *epc);
 	const struct pci_epc_features* (*get_features)(struct pci_epc *epc,
 						       u8 func_no, u8 vfunc_no);
+	int	(*get_aux_resources)(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
+				     struct pci_epc_aux_resource *resources,
+				     int num_resources);
 	struct module *owner;
 };
 
@@ -337,6 +386,9 @@ int pci_epc_start(struct pci_epc *epc);
 void pci_epc_stop(struct pci_epc *epc);
 const struct pci_epc_features *pci_epc_get_features(struct pci_epc *epc,
 						    u8 func_no, u8 vfunc_no);
+int pci_epc_get_aux_resources(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
+			      struct pci_epc_aux_resource *resources,
+			      int num_resources);
 enum pci_barno
 pci_epc_get_first_free_bar(const struct pci_epc_features *epc_features);
 enum pci_barno pci_epc_get_next_free_bar(const struct pci_epc_features
-- 
2.51.0

