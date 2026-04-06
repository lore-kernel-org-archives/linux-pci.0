Received: from OS0P286CU011.outbound.protection.outlook.com (mail-japanwestazon11020114.outbound.protection.outlook.com [52.101.228.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C454325701;
	Mon,  6 Apr 2026 15:57:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.228.114
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775491051; cv=fail; b=U+cbkxlSMOogIe/pdmxYed61redk879Y529TRhfcMEPtg5XiYca/rSzMpdj60xZVr3Z6MflJpaoaC2CHqof/3vT8NUyT+LB3sqgR0mObisSuy+AkahNEpXuGpI0sKK04gOlu1VxDK43DccMGKbfedFDOak0Da27HDiLK5W9S36U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775491051; c=relaxed/simple;
	bh=24CtTktMCrTYnhJKM0CPxo89ofgYKr4aiWJjFoL6RkY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=qBZbtB71+3zu6lfasIRa4GCqes4rCeV22psMkHCdAsKEpq6Z4/uB4tbv448PAlPY7Wg/fPrRASScYVFTfxHyWq6wbhGmENlSVXDCilZDdp/5Qp4KxDW2K9/KrNZ4osEjoudcmEG18gYrDdp7t3dyQHni7dxWWWu2GEsVgFmqQgQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=uFCCTb9G; arc=fail smtp.client-ip=52.101.228.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="uFCCTb9G"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JLQaHMU7tnLFYX0fzkiREpL8c0ULnvJJphGti1yZaG143kXfBB3vRIfCck2kTjPNvcnLRFK2up3xtfulECG6u041VCKgb01Htmz+z9l+gE7qwUjZyh5fYltHWlJHKZ9MQEVyth/YdFK3M+UeFFwzSM7bQ7OPL2zP0Vhew/Oq+yOADtoTZAZSF/RS+yycJ0lo39Jf4H5fFiKnRofx3rQatrzshDF3+Pp/Wt4OCWUYxFjgy+VLUQyJgPUcXTid+DWPX0U8OU7xDbjTKq/XC78+wi2oSjRvqd4loy+DhipD/CH0pA67kfCMQ8hDt3bhFSMh0ip7Rb1N8OT69LdhB3cp1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r7RiGuw4rdIqME4X0uRgpKq66eSKksk/+mPslKC5zL4=;
 b=RjDPUTw3bz11IbpcDZApJrgA4oES+wZe5+lDnwrR6uu89Eefumz+bvNY7KSGD8usEnR1WKpwsbEH2ypCMzThi0JsKzl0jIiryLRwjd5zKLiyxJsNItLTY0MWrs4sivyA4aU5ZwB696owTehiBjZVU9jGWUMdlc7MKNycTTD+9zpVxQBxTZ2/tniiu4hJcclYNmd+6MojWDr3GpM2KK6O75qZzRhMmpHfD+PAx+M4dO2S26DEbrAx2HM96a5D4Cnq7kZHTagpVnbdH+R67NIW+wzdHAjCruj5U93L3ixV5A3uHfZsD9FOf73YyEtfGaGBA9HIAb29cOp+Q7LsZgYnTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r7RiGuw4rdIqME4X0uRgpKq66eSKksk/+mPslKC5zL4=;
 b=uFCCTb9GauZrdoAq+dabFwkBSGF2Tl5x7tRIdxDJO97gOSS0GO1lT/3q3h40YQWZght9Sg8ZWaOAK1LKzpdgeUTJNgIY4IDTICpt7B7nzYqT6oWGl46f+HYJnRim/LC14ABVs4CWG+MqGqKvSEhYEDzjNgYQsNFSG1IqAAnuK48=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by TYYP286MB4187.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:10b::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.17; Mon, 6 Apr
 2026 15:57:25 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%5]) with mapi id 15.20.9769.017; Mon, 6 Apr 2026
 15:57:24 +0000
From: Koichiro Den <den@valinux.co.jp>
To: Jingoo Han <jingoohan1@gmail.com>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Jon Mason <jdmason@kudzu.us>,
	Dave Jiang <dave.jiang@intel.com>,
	Allen Hubbe <allenbh@gmail.com>,
	Niklas Cassel <cassel@kernel.org>,
	Frank Li <Frank.Li@nxp.com>,
	Bhanu Seshu Kumar Valluri <bhanuseshukumar@gmail.com>,
	Marco Crivellari <marco.crivellari@suse.com>,
	Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
	Manikanta Maddireddy <mmaddireddy@nvidia.com>
Cc: linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	ntb@lists.linux.dev
Subject: [PATCH v13 4/7] PCI: endpoint: pci-ep-msi: Refactor doorbell allocation for new backends
Date: Tue,  7 Apr 2026 00:57:14 +0900
Message-ID: <20260406155717.880246-5-den@valinux.co.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260406155717.880246-1-den@valinux.co.jp>
References: <20260406155717.880246-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0043.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:29d::14) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|TYYP286MB4187:EE_
X-MS-Office365-Filtering-Correlation-Id: e4d2aa31-0dae-4c22-bfa1-08de93f53203
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|10070799003|1800799024|7416014|56012099003|22082099003|18002099003|921020;
X-Microsoft-Antispam-Message-Info:
	0VWuc4K868ZEIfrLzRs8hDSwlJH296OZdSFyMwU3wX73jxmKdPWLVEN3SVY2HmnOVnQ5YL/QlV+yI1jHTiDhv4hVvbs0EibxT8WnJZe66VeLszg1XzBcNb5HgtvzGKBmnONclYTvGQzWyQaOZ+LOJhmblgGUbtgFb6uE7SUP7lTyqy2T8p4NNRxlNdgb3SxqNG9TJaB13NhzekALwV0qxGoOwd/XI47VWqylAJFHOT44ac9J++P+ycd21v1iC8cCSvbn3TCkS5PL3du74JC2Dc2L9WYnoOtE6k1yxaVpCGYmqQHem4+fkF0a8bdv6ZAwMz+p2uHpaddOBCxzxr79ZHFYGezKAk+mISKdxb9yebtJHuDClJQB1EAh/wr7BfYHAhYVZGWaL4AqhPOctwVaQrfrf4SgY9NaK8EMJFT9BjFazPC0gmv9V/Jijl1adLhpT+tbBlmbAQak6GXJpVvFArMDC94yOuQAd6DNyd6WxRHH1CEAUpBYzbvMeqJa4M7YDV5eALpDxJVdVEg8i3WEvdr9tbgyvjQBGdp1f/02ImZKwYje0fMohSEn/pcaVFjyjxVHtq+jfaYfJ8g5OWPc9ku3+YwOeqYPAkv1+c4njCDBWjqLacQ194Bk9fcQ15YUeg01b+gIaAeVyYJKLb95u2/AuCaTdOaYh98LfB3WydFgYFt8RzlEC7KYDDv4Mf8cHaDE7R8dOW78KZvhlZRb0wViUMKbH7pdMm3HMtRwtkmgGuzq8eIRwkXtUJn8dMwl1y/ZT/wk9e48MdUcPz3cVQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(10070799003)(1800799024)(7416014)(56012099003)(22082099003)(18002099003)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?sAs3wfhJiRrSZpQSkjm2xQmN1Cb4gj65mVgji2yfGTOwHQ3gvsaemxGGxCPw?=
 =?us-ascii?Q?YP9GmwVNLKtI8HMsIyVMBZjIbBrDLAhNgWOP67jzfZq0DL50u5pUu2AwhtvI?=
 =?us-ascii?Q?i40Yj/Tz2JDw6+u7jorSkuPj5bcWf621djQpkZyfcMOx8yyhc4+pRyhgM3YB?=
 =?us-ascii?Q?4GtnSpWx3Vs5TDgNzE37o5xqYlFfq4yM2xEhGjmhR7CAGuM3Si1TD6Da8RTA?=
 =?us-ascii?Q?ejm4QituVNlL3QoaO4Ei2xV1b1V//rBO/7vcVlW16H1VbV1PIgpdvYxO8RiN?=
 =?us-ascii?Q?Dfuwtuo36LUNFurnSL3LjaWBW+69c/WM/tEjYhTj25fUOqNICfHeoy6FS8sx?=
 =?us-ascii?Q?G5brWOSYWZnBucncX738mi7CseVT/6BgiCCbgJb8YbagiGfIXqYBSfDXh0rH?=
 =?us-ascii?Q?MgQcW3+4S+R5BW6dCJ4dS88vxnRcQCUsV0HfSJHm67IOX1nSa2AqJshs/wXP?=
 =?us-ascii?Q?eWdghTqjqb68QpIyy+APGrYx5qOjT500QFlxtxLOQICgYiUXhPwB/CyRbBnB?=
 =?us-ascii?Q?uztnR1jAe0i8B7tzPb03AK5ecJqhe6hpGu4BL6/4VIR9uK6XyRUG3PTdNLPG?=
 =?us-ascii?Q?gvi8QmdNMSY/oje+V5Zt9jJclyojGdUiTmYDnfqgTpboX3O9xLCwt1ChWtec?=
 =?us-ascii?Q?RS68ToF23vC70rvj32EhORDPpMsHkE0dObVKck9dhhQMkFv+bj0HmkFXEuIk?=
 =?us-ascii?Q?BqViu/YzmEUHQURHZb3E2lh33cSeeXDBCaD4wzePHZZDTQ5ApyhLit4H7Hwf?=
 =?us-ascii?Q?5GPgxKn1mB6kLpc79iHUYpsTpsmX48q9yoZRHuskOfSf658jadpEYwYNVOwv?=
 =?us-ascii?Q?2q14ybxtijTxLWGg/XIvZ8Axse2LpNR755gGPIEENg0HS/YY3pMJ6EJKXgN6?=
 =?us-ascii?Q?AifRK355SwLXgZOYBY1GF0hdJA6anRk8JefBVaiYrAgJWdRE5Wlb64Y5ZWzz?=
 =?us-ascii?Q?auOOqxx23Q/rWOQyywNNMxvx/O11MZwRLSRVnJGvwKPmisVNjpbVfwQp3UUK?=
 =?us-ascii?Q?cZbGrnlHt4SKBN1FvBL4YwABn3lD86hRt11TUhkLpzqKhWIW4yjDKglLZt+T?=
 =?us-ascii?Q?ibHFBhNQA7hsSDrTcXAZ8qiTj3MO+wnRgzjRwD9uuLzGogYFobhPe5f4wiTX?=
 =?us-ascii?Q?Sjcu8VKv3Cdp3fQBdAmH1YrRFQO/xTTXTJ0ti9ubdILwUJNagHbuxG/eLmWq?=
 =?us-ascii?Q?o4UvE/n8KqqfiXb6owVPVystecUk6GSgeUI1bTiVRtz0YrT7NsJXXrGUMbKK?=
 =?us-ascii?Q?0Yfuoh6JcPRaH/Tba5r2RFPuZRRfKpy22r3Y6LwkELyZT2UDTxYF0nijGRiB?=
 =?us-ascii?Q?QcF6/PAGElD3EQWc+pe0pjaDiyMnpq2+1aROqL2u5TDDsDf+mnv+hJGFzjNc?=
 =?us-ascii?Q?lMNpUdhP8AoWMj3WsXkLdgKvGUWceGDETs7UcTv9MUmCTmJo33ift3ssAtqV?=
 =?us-ascii?Q?nAZdFDUuAWvgY7O2xkvjpFHyiv+N8jd+Vozg90ZrvpcYIyzhK7lFGX6pm9vx?=
 =?us-ascii?Q?Jv0Qb+cOmhjjYX0DYB+tTYyEQrKoMy312C8QCGU4RPjEsgTkYgnJAfM2FU26?=
 =?us-ascii?Q?+B2Lpeba6Sc04osUc/Na6mx4+WUSE1bCTiAm1gVHUPt6CEC3/Ak1J1C0ky1+?=
 =?us-ascii?Q?QPrUp0b98bN91D7v/fpL/9QcqV9t5vIMluv5sQjexz5lZBAJTIjK+n/ptcaG?=
 =?us-ascii?Q?MHdCexeaI3zZ8pBeX2gJrBpPoREiVb6sSotMp5PUATacbDPfF5bU6//MmS5b?=
 =?us-ascii?Q?GRB/EE5Qx6R18gwzpWjxBJ2/mM2vXHKQkZJTjvXYnau4UE54OfTz?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: e4d2aa31-0dae-4c22-bfa1-08de93f53203
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Apr 2026 15:57:24.9065
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: g5q0P+9QMbq5idADw6GHfBQ/peep8jo/SJ5iisnuvaaMW6eT8m86N+djUzO50z/xqpEhqfEfJyxvLLeNntswvA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYYP286MB4187

Prepare pci-ep-msi for non-MSI doorbell backends.

Factor MSI doorbell allocation into a helper and extend struct
pci_epf_doorbell_msg with:

  - irq_flags: required IRQ request flags (e.g. IRQF_SHARED for some
    backends)
  - type: doorbell backend type
  - bar/offset: pre-exposed doorbell target location, if any

Initialize these fields for the existing MSI-backed doorbell
implementation.

Also add PCI_EPF_DOORBELL_EMBEDDED type, which is to be implemented in a
follow-up patch.

No functional changes.

Reviewed-by: Frank Li <Frank.Li@nxp.com>
Tested-by: Niklas Cassel <cassel@kernel.org>
Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
 drivers/pci/endpoint/pci-ep-msi.c | 54 ++++++++++++++++++++++---------
 include/linux/pci-epf.h           | 23 +++++++++++--
 2 files changed, 60 insertions(+), 17 deletions(-)

diff --git a/drivers/pci/endpoint/pci-ep-msi.c b/drivers/pci/endpoint/pci-ep-msi.c
index 1395919571f8..85fe46103220 100644
--- a/drivers/pci/endpoint/pci-ep-msi.c
+++ b/drivers/pci/endpoint/pci-ep-msi.c
@@ -8,6 +8,7 @@
 
 #include <linux/device.h>
 #include <linux/export.h>
+#include <linux/interrupt.h>
 #include <linux/irqdomain.h>
 #include <linux/module.h>
 #include <linux/msi.h>
@@ -35,23 +36,13 @@ static void pci_epf_write_msi_msg(struct msi_desc *desc, struct msi_msg *msg)
 	pci_epc_put(epc);
 }
 
-int pci_epf_alloc_doorbell(struct pci_epf *epf, u16 num_db)
+static int pci_epf_alloc_doorbell_msi(struct pci_epf *epf, u16 num_db)
 {
-	struct pci_epc *epc = epf->epc;
+	struct pci_epf_doorbell_msg *msg;
 	struct device *dev = &epf->dev;
+	struct pci_epc *epc = epf->epc;
 	struct irq_domain *domain;
-	void *msg;
-	int ret;
-	int i;
-
-	/* TODO: Multi-EPF support */
-	if (list_first_entry_or_null(&epc->pci_epf, struct pci_epf, list) != epf) {
-		dev_err(dev, "MSI doorbell doesn't support multiple EPF\n");
-		return -EINVAL;
-	}
-
-	if (epf->db_msg)
-		return -EBUSY;
+	int ret, i;
 
 	domain = of_msi_map_get_device_domain(epc->dev.parent, 0,
 					      DOMAIN_BUS_PLATFORM_MSI);
@@ -74,6 +65,12 @@ int pci_epf_alloc_doorbell(struct pci_epf *epf, u16 num_db)
 	if (!msg)
 		return -ENOMEM;
 
+	for (i = 0; i < num_db; i++)
+		msg[i] = (struct pci_epf_doorbell_msg) {
+			.type = PCI_EPF_DOORBELL_MSI,
+			.bar = NO_BAR,
+		};
+
 	epf->num_db = num_db;
 	epf->db_msg = msg;
 
@@ -90,13 +87,40 @@ int pci_epf_alloc_doorbell(struct pci_epf *epf, u16 num_db)
 	for (i = 0; i < num_db; i++)
 		epf->db_msg[i].virq = msi_get_virq(epc->dev.parent, i);
 
+	return 0;
+}
+
+int pci_epf_alloc_doorbell(struct pci_epf *epf, u16 num_db)
+{
+	struct pci_epc *epc = epf->epc;
+	struct device *dev = &epf->dev;
+	int ret;
+
+	/* TODO: Multi-EPF support */
+	if (list_first_entry_or_null(&epc->pci_epf, struct pci_epf, list) != epf) {
+		dev_err(dev, "Doorbell doesn't support multiple EPF\n");
+		return -EINVAL;
+	}
+
+	if (epf->db_msg)
+		return -EBUSY;
+
+	ret = pci_epf_alloc_doorbell_msi(epf, num_db);
+	if (!ret)
+		return 0;
+
+	dev_err(dev, "Failed to allocate doorbell: %d\n", ret);
 	return ret;
 }
 EXPORT_SYMBOL_GPL(pci_epf_alloc_doorbell);
 
 void pci_epf_free_doorbell(struct pci_epf *epf)
 {
-	platform_device_msi_free_irqs_all(epf->epc->dev.parent);
+	if (!epf->db_msg)
+		return;
+
+	if (epf->db_msg[0].type == PCI_EPF_DOORBELL_MSI)
+		platform_device_msi_free_irqs_all(epf->epc->dev.parent);
 
 	kfree(epf->db_msg);
 	epf->db_msg = NULL;
diff --git a/include/linux/pci-epf.h b/include/linux/pci-epf.h
index 7737a7c03260..cd747447a1ea 100644
--- a/include/linux/pci-epf.h
+++ b/include/linux/pci-epf.h
@@ -152,14 +152,33 @@ struct pci_epf_bar {
 	struct pci_epf_bar_submap	*submap;
 };
 
+enum pci_epf_doorbell_type {
+	PCI_EPF_DOORBELL_MSI = 0,
+	PCI_EPF_DOORBELL_EMBEDDED,
+};
+
 /**
  * struct pci_epf_doorbell_msg - represents doorbell message
- * @msg: MSI message
- * @virq: IRQ number of this doorbell MSI message
+ * @msg: Doorbell address/data pair to be mapped into BAR space.
+ *       For MSI-backed doorbells this is the MSI message, while for
+ *       "embedded" doorbells this represents an MMIO write that asserts
+ *       an interrupt on the EP side.
+ * @virq: IRQ number of this doorbell message
+ * @irq_flags: Required flags for request_irq()/request_threaded_irq().
+ *             Callers may OR-in additional flags (e.g. IRQF_ONESHOT).
+ * @type: Doorbell type.
+ * @bar: BAR number where the doorbell target is already exposed to the RC
+ *       (NO_BAR if not)
+ * @offset: offset within @bar for the doorbell target (valid iff
+ *          @bar != NO_BAR)
  */
 struct pci_epf_doorbell_msg {
 	struct msi_msg msg;
 	int virq;
+	unsigned long irq_flags;
+	enum pci_epf_doorbell_type type;
+	enum pci_barno bar;
+	resource_size_t offset;
 };
 
 /**
-- 
2.51.0

