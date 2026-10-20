Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.74.140
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792475402;
	b=istWq3AEEvB4conc6OLJ6m+4VLMqT8AFsRxpT5QNbPL1znpUBxlUobVMyVfNq6AHuYmS
	 xTrgZUoSAlGgtlOx8/xubsDQt4y7sXBzn3AfCCFSQWgKqMWPwVKmRcoE7JDKrnMG28c5J
	 hSuYp1mzmc4S1lcK9H9q4EyWGVzSA6qvl0TQJ4/SOi4C+d8lhnrERZw2ExWQmUcy4B7m2
	 hZIe06BMh8NynQa5l+rrjYnLRuEBQ8fzram7x0tpwIoVIWn+cTSiX/PuqTYTbbjfm+N/J
	 bqA+pIoyA/RwH8m0cDMOzyVbQOUr1XGTCe7XOCltbumMcUQ6jR6o2JFl7VnzWBTuYnQ==
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
	bh=S4l6Fv39rvHyKHu1t7JWL+XSPbos1FsfgRPPZACr8r0=;
	b=JqmId8uoMXHhXJCRzUs0OL9G/refmOq2vHBxi1wF0SEzJnfz86OOaVbPdaNtJlIENSGC
	 5FKg6IyofW7r6mH4pwlOXucmIA/ngYqJix38YzLIrrt7Cq6Z0YP/MRR21n4qH8yuLI9bb
	 HOxQoDeSlugAtdBZK9mTjataLtamwLL7SNRlc5vXC5JcAHT7SfOQfAC9FBzPiEFQwoJWi
	 +i3Omdh2gsKNwxMrjeK90zXsrwYUgFRnETj14Dvc6+wv6x7xcaz8Mq4iMaECiSwl6h/PC
	 peyW0aiZk21L3lfwgk8dLApCIedMnI8MgVaCmoGh3EK6M+U/bhtlRRXIecn2aoiI2xg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=valinux.co.jp;
	spf=pass smtp.mailfrom=valinux.co.jp;
	dkim=pass header.d=valinux.co.jp header.i=@valinux.co.jp header.a=rsa-sha256 header.s=selector1 header.b=qJQvsadk;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.74.140
Received: from OS0P286CU010.outbound.protection.outlook.com (mail-japanwestazon11021140.outbound.protection.outlook.com [40.107.74.140])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 313E2606A31D;
	Tue, 20 Oct 2026 05:50:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 313E2606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=valinux.co.jp header.i=@valinux.co.jp header.a=rsa-sha256 header.s=selector1 header.b=qJQvsadk
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bKtGxwDND+5pTFRlXh0d4RKg2YrhV08uO8vrXHX4251EoTnwWG1U+v4VeoxL6fBjLZ0rf1+sR/665XgvoPJ+jYRT1GOR1WjcLikVGwbzHgrhqsBb27ZU5j3Y59N7oKxNCETVAXDgu89keBz7c2Yfr40/6tY8AL6KvYf4m/OiGi/MC8om/9x1FBoJM9zCOrUvIRa7YttdN6WtXDf2HlxP6dR+QZAVuXQprLt9pSYdpQ5O8lWxUWXQ+h8N3/Q01p1NiFOCUZdepkgG+hDmYlbxGbXaJhiWBAD932qsye8qiw9wRAuNOES0HFdKxNC7gdrV72tddrHZ/KsD4QKkvOsxmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S4l6Fv39rvHyKHu1t7JWL+XSPbos1FsfgRPPZACr8r0=;
 b=Q4dLvgyMNh/WzokwOnRH2sAqkA2891at0N9VIH5SUvia3IxTJ2Kg9SjJZnaB3ffY7BnOtUH6o1lxq2arHZEk3SPQkY9ZxVmu+yu+/8iKG1IHOf8Vg02sOw295nerPTgaL3gJfVWJsHM3dbrB95lUYTblx3WKodttK4DMmDjH5AiaVga728CU/FdqkuvDATd1L1Vdw52qxnwqwUoDGSfXf+HotfLBa5CtI/o0nuFMqK5XL4/fXeS6T9DVBJFNZkRdiv3BX9e2k40UuWpr/NneaxCcDORZ4GsW/7Jx777mtmo7Il6WFGiU8zoNz0BKj03/OM4d4KH0zwGs4vlxg/IoDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S4l6Fv39rvHyKHu1t7JWL+XSPbos1FsfgRPPZACr8r0=;
 b=qJQvsadkamepDgL0gYpvpoYkM4mQAtZr8bUT/sAcb6yN/w0P/sYfOwUI0RGDGPNVRwW47gPQD1K2T5Ase3Pf7rjiaWPoKH+9GWl8eE6R2BqcrcC3SlBKzLsgUEF6JDzQToydu/RXpGMVAsTz10y70wDuu8GTDNXZ8CybIgLQwUo=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:325::11)
 by TY6P286MB7913.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:3a3::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.19; Tue, 20 Oct
 2026 05:49:54 +0000
Received: from TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 ([fe80::cce5:2aa8:53f9:dba9]) by TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 ([fe80::cce5:2aa8:53f9:dba9%5]) with mapi id 15.21.0522.017; Tue, 20 Oct 2026
 05:49:54 +0000
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
Subject: [PATCH v6 3/8] PCI: endpoint: pci-epf-vntb: Move epf_ntb_is_bar_used() up
Date: Tue, 20 Oct 2026 14:49:43 +0900
Message-ID: <20261020054948.1218370-4-den@valinux.co.jp>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261020054948.1218370-1-den@valinux.co.jp>
References: <20261020054948.1218370-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY4P301CA0092.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:37a::16) To TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
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
X-MS-Office365-Filtering-Correlation-Id: 00f0e0ff-a8e2-4097-147c-08df2e6df757
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|10070799003|376014|23010399003|366016|56012099006|261009223027099003|10067099003|18002099003|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	MLbCtYGOlMjHvsS6f3r9u1cFCGkgQPXvmfjJY6A0cQKArF/2kbsQ/VLGEQd6m9brtujDfYWcPRBejq28xzcG0q2e/e0r0us4Qp2UEP92sn8NQxj1OY/8WUbrlvUPZSARUxBYMkzaS4U+ZhHzE4KXKWQyCZBKNo8v0nqYHgiZg0VqGBbSY3foKNWV3J6KVVuGpVZZPkcAaCr8S419CrWUdVSgtL9TMBFp83oXhEpWzcmmA115GBlWPHO5TvxDPbjPpBV4lkcs8zHx4ZR/p0AlEbdz7gkcqpHJYAtxZAoPJLyexLh2HJmsQD+VEYP+qhnoslZRrDEMzWXA3T6claWi5Eu0S+Z92tV5OjElU0kvpr4ZcVxd2DapSajRO9cQsxY89627Pw6/aMQjWjXZW7HZnk5a/dF5TmpHbi2p8VpYoTWxeX7tDsAZTwFZkwqMYWVpsPxV8y+J2+ytsoYi9fOm/ubh9+PbKJSeDuuNMxDvE/murirsueaUbl1LRmviBRLDK/RlnbW6Zj1ZmqQK51IGYYPlznZ7nfRJdJXkdUVSpu8TM5W+RCx3slzz66aT42O5aoiUoaVHLPn/rAbZOd/U6v/VD/uV6DgLzFHrW3u4mRoF69/srQ2hZzJnavLbUEsXbsu4BhSSF8iUcxpbw9r/XOpFU+idhFj1O2Y+S3unbEs=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(10070799003)(376014)(23010399003)(366016)(56012099006)(261009223027099003)(10067099003)(18002099003)(22082099003)(6133799003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?hwatYTz7PJCJiGrKthF1MR87FkC35sEYllehL7wO7WOfBXkXxcW8ksiSZzEL?=
 =?us-ascii?Q?pLz2fpH9hfZrIWjKDF3/kzUVRPhLmFQNP+U33bvo8GUXPJArAfiB+QLMeXlg?=
 =?us-ascii?Q?JdXwqnsQs+svSBeLU3W/UTWz4LMAIMqXtW/cnKLVOznQTfjdULz/s4hk9V0E?=
 =?us-ascii?Q?EoJf7Btebuq/i7RWmGY37vycLMR4BPgj/ZcInKEWDwxqHLlm6F0eIS5r48i3?=
 =?us-ascii?Q?LHOR306wl5nsv/cW7KzhgLd+CkuyStMpwbH0ar/+Q1oD0McBiF5LsMj/PBtU?=
 =?us-ascii?Q?1q/aOhTTudO5eBQGhbEOhBdsmwX88magcLVrwgQMvhAl7XkC73ydqd9GMpEB?=
 =?us-ascii?Q?UO5MPFHC5OTAwkQV9nbPwp50BdmUV/adPUGsWkt9MYN7EBtOGu3WNkwYXmti?=
 =?us-ascii?Q?co78J0OaTTTd9E2YxPdH8pjc4UgfDIhGFOHVsCavKCX85ebYJGHT2WWg6i5o?=
 =?us-ascii?Q?FqCsmgWPElDXAfoLzF0REeSizZt/T0myuDljR4TWG6HBVdxvKmvTNZ/isYPp?=
 =?us-ascii?Q?hmhNULwcQ+7Spcoo9Uwa5t6GT0mnuVwYdIR0Ui27N0xrpxz1JjI0xcvIY/2y?=
 =?us-ascii?Q?XLezQs1bK6BHWFG73aOzQ8Q0QoIuJqO/jo/RUX4lx+P+0gH87AEJeC5NT8/W?=
 =?us-ascii?Q?++vI1MDcVt5XQ+rDBi6tF1PzMYwUAO0tSErLMFVWPClMFtz+syVN3knAx4Ao?=
 =?us-ascii?Q?FogWSQPOpwOnBIgrJVzw3N1co38FWgYWWJyiZIYLTAZ/dl097Td+6W6tPBtW?=
 =?us-ascii?Q?FslTXuRBlGAXXYAif6fWicaov4VctQnC4iFzZPKmr0d67bfw05ikhNkvJvjZ?=
 =?us-ascii?Q?zbxlckbatIoNiSF1EqjPoxJqFILTtkv9p2Mhv0caAZRl1vkdbl8wMKIk0LlK?=
 =?us-ascii?Q?tlPiV+bbSTsCfoYr7xRBOqlxgDO/DqNE3Cth848QjWg8A3ykJ1UBlS+rd3+2?=
 =?us-ascii?Q?Fk+ReQg5ajilYPwewSLNvP2yStauN5FrGMj1CLcGxKFNqZbHs7VChVgaoBTp?=
 =?us-ascii?Q?HcbRxYYZfIkTDuAh2/zQlmebMl2HthHJX4WCgSsq4Z8A1+uk3yH6uBkhHVWP?=
 =?us-ascii?Q?EXN9tpjD2N1ciBuTMRDfQjYPhC/tjCc8KRQXVK02c4br2bMuyRjaLlWsmnDc?=
 =?us-ascii?Q?J6q8C0kIe5J7uQLx9b1Yi5UsK2KApEyGnCN49PlKd8/116yParSYN1s/FhEA?=
 =?us-ascii?Q?pdFjuHbw2m0PQ4Ya/H5KJtTEwEi/25VEy56A5vJm/3NFMM20pizAQbac2DET?=
 =?us-ascii?Q?c9F7vkeqGzfVLhoI58FjcTQJWGPEg8VSW/QbEPQ2ugw85rilT0M9oZHVKJDJ?=
 =?us-ascii?Q?Zv9DYubgqvxxIjnr11eVWRXFaCHlcWx9dtBs5mZP6MsCs1sbOrumilYZVOfI?=
 =?us-ascii?Q?iNVoxjOZZPtlRB/AHWe62H8ZB+a2AOiJoaOQVvPIDRgtmudxdaMLJz9N2kcD?=
 =?us-ascii?Q?JIusmsIYWnFyOsMThBOl724c9vizwFRTwHmidDVKyC4cu8Akrl0U/E1Z/k2y?=
 =?us-ascii?Q?haKs1Ibfo3+V0kugS4q3vjio1Nv1ZzPC+/75j9CDTH1/kP+FR3dThXA5D2ik?=
 =?us-ascii?Q?dUvVLL7zyF7LmN7u+JtWPAWlCogYtv5ItoZJWMUZOxr/49XJutF3g5PWFUDW?=
 =?us-ascii?Q?dfROhM4M1GxEdZx+RqLuZeSszSIJlydrBNTun+YN9aJ1IAbO356mI6cVu2VD?=
 =?us-ascii?Q?rSubs/F1q+iSsw9NPM72yvNSDcWv0XaF3meXT8k6rGGPv+DZkxJnwbLQUMM9?=
 =?us-ascii?Q?WXmZLIrCQdXOvRyQdVU6nwFEI+jXiZBg0TcmSlRlCzgJRoRx5bH5?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 00f0e0ff-a8e2-4097-147c-08df2e6df757
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2026 05:49:54.6587
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BbSakYfLI0uGexlc1Pr0wJyxHduL8PRET7Q8DaFwq2GcpQSzd6Q+WOYPNx9amwomzEOHqt81BaLM4iCa62KRVQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY6P286MB7913

Move epf_ntb_is_bar_used() up so later BAR selection code can call it
without a forward declaration. No functional change.

Reviewed-by: Frank Li <Frank.Li@nxp.com>
Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
Changes since v4:
  - No changes.

 drivers/pci/endpoint/functions/pci-epf-vntb.c | 40 +++++++++----------
 1 file changed, 20 insertions(+), 20 deletions(-)

diff --git a/drivers/pci/endpoint/functions/pci-epf-vntb.c b/drivers/pci/endpoint/functions/pci-epf-vntb.c
index f77e28f2fe96..1a0ce31e680c 100644
--- a/drivers/pci/endpoint/functions/pci-epf-vntb.c
+++ b/drivers/pci/endpoint/functions/pci-epf-vntb.c
@@ -244,6 +244,26 @@ static int epf_ntb_set_link_enabled(struct epf_ntb *ntb, bool enabled)
 	return 0;
 }
 
+/**
+ * epf_ntb_is_bar_used() - Check if a bar is used in the ntb configuration
+ * @ntb: NTB device that facilitates communication between HOST and VHOST
+ * @barno: Checked bar number
+ *
+ * Returns: true if used, false if free.
+ */
+static bool epf_ntb_is_bar_used(struct epf_ntb *ntb,
+				enum pci_barno barno)
+{
+	int i;
+
+	for (i = 0; i < VNTB_BAR_NUM; i++) {
+		if (ntb->epf_ntb_bar[i] == barno)
+			return true;
+	}
+
+	return false;
+}
+
 /**
  * epf_ntb_configure_mw() - Configure the Outbound Address Space for VHOST
  *   to access the memory window of HOST
@@ -906,26 +926,6 @@ static void epf_ntb_mw_bar_clear(struct epf_ntb *ntb, int num_mws)
 	}
 }
 
-/**
- * epf_ntb_is_bar_used() - Check if a bar is used in the ntb configuration
- * @ntb: NTB device that facilitates communication between HOST and VHOST
- * @barno: Checked bar number
- *
- * Returns: true if used, false if free.
- */
-static bool epf_ntb_is_bar_used(struct epf_ntb *ntb,
-				enum pci_barno barno)
-{
-	int i;
-
-	for (i = 0; i < VNTB_BAR_NUM; i++) {
-		if (ntb->epf_ntb_bar[i] == barno)
-			return true;
-	}
-
-	return false;
-}
-
 /**
  * epf_ntb_find_bar() - Assign BAR number when no configuration is provided
  * @ntb: NTB device that facilitates communication between HOST and VHOST
-- 
2.54.0

