Received: from CWXP265CU010.outbound.protection.outlook.com (mail-ukwestazon11022089.outbound.protection.outlook.com [52.101.101.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF7802C11FA;
	Fri, 26 Jun 2026 19:50:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.101.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782503412; cv=fail; b=q7TuBsuNpHOUZnLy8s3kPROBSxlhAptkOWIJsc4stnwauPuPSdfECr4RojdjxnMxNK5P6QNANXH+xGZZN9Ky5Ac7uLH8sXmsqk4KxBN7UDhPzKe7eppuwmF+9cLLoaq7ONlgIJIezHhH4McqW3psK14GIcycZB3jU72rG681Qpw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782503412; c=relaxed/simple;
	bh=90kB/GM7b0DQ+jjnST87ZDE++fh7lXWSk1GT7mZARH4=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=lK7Sc40+XkbNscIGSPncWZksYOdc42O+xe3/+/GIlgDJ3vk0DQ5gLOOZ7whxZHRLNzkLeKLPCb2RXuu5cccxpjeNMGPro62OI34tHoInuSqmfTXMp9B7ZAWXLGvXqj70wjjn+6FwyPyEaHwlWzjdcEt8vSM+NqS8t3KJohrVArA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=Rm8TIYWU; arc=fail smtp.client-ip=52.101.101.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="Rm8TIYWU"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OAimiH4eF52RKpXvfPAeCR7TDhOGjh0ks+JmDFLxkRsJmUHInOyg3E7H0rRmbAlYC0fhlOrAHtVlaF4YH7Zuvhye1ZFH4dgATHrrW8r1Ee1rZ9ATazEJkAzFSvRRJzE+/V1p1kZ2Wrxy55tnrvrw1iSGHofQ7e081JfEm0IO0WWJLiAJwRWoSmUh8NHPDtHWuqQ3zCMI/fKQdM5zNLgHZ1KpFngZN7uowVGLfCIh587Cvm2M2Pnm5RlhIWIXnu4MinlO5M6Qir+Asn7SBegtVWYFBOnRyof/4tXeGHRblRsNpcc6wraIwd6o9pbEHXANGaQjFUBOpJmjmekGGQo4SQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6dr/WAuQwPRX8T9jjsivyRvTYjnw1PmzcgDbpCOa/t0=;
 b=Wrazrwo3L6cEARuBoihn5Hu9jVzHflKG/8i3v5KjqWxFxhP6Wx0MbUtuVgmSRMSbgdBTm+wFd8D+pWdZpWjotO57jcT2wEOHQ+a0LkEyrDutajRsFtRvVIGJUZQUpEZnLhW9Tsr1ia4LbzjuhV/T+D/IFjZPtJf8jQ8Y0tkzhZnA3b18P5i1iruht58ArH6ec7NVPTPylHR3gKdKeG1I03TsA0y/jFzMXBPlawuZFSFExhDHC6EmFlFcclRZLPVFlIke/Irwr+YyJXu8rSwBOLrNWRT7NujJ7bLPKzrh8wAQRnb+pu64Z/LC5a6Bb8rKjU43wtqGzbgJQTo391jLhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6dr/WAuQwPRX8T9jjsivyRvTYjnw1PmzcgDbpCOa/t0=;
 b=Rm8TIYWUwYbJLw2+DVQOnZUU+3O2waKkommRao2dqY+S8OWX7lz3QSi3YuthPQH5IBgUVKPhNrLxfeKXslu1rDEnyJYh7B/1msvXF1f7A0W1qOxV2fmbJS6JdheDIrkK90JshPvg3+YQN3ZJfKjEXSgeAReuSW9LDjXltTsoTjc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:488::16)
 by LO0P265MB2905.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:181::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.16; Fri, 26 Jun
 2026 19:50:07 +0000
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986]) by LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986%4]) with mapi id 15.21.0159.016; Fri, 26 Jun 2026
 19:50:07 +0000
From: Gary Guo <gary@garyguo.net>
Date: Fri, 26 Jun 2026 20:49:39 +0100
Subject: [PATCH 2/3] pci: fix dyn_id add TOCTOU
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260626-pci_id_fix-v1-2-a35c803f1b95@garyguo.net>
References: <20260626-pci_id_fix-v1-0-a35c803f1b95@garyguo.net>
In-Reply-To: <20260626-pci_id_fix-v1-0-a35c803f1b95@garyguo.net>
To: Bjorn Helgaas <bhelgaas@google.com>, 
 Zhenzhong Duan <zhenzhong.duan@gmail.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>
Cc: linux-pci@vger.kernel.org, driver-core@lists.linux.dev, 
 linux-kernel@vger.kernel.org, Gary Guo <gary@garyguo.net>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1782503406; l=5374;
 i=gary@garyguo.net; s=20221204; h=from:subject:message-id;
 bh=90kB/GM7b0DQ+jjnST87ZDE++fh7lXWSk1GT7mZARH4=;
 b=WrmyWxwZLO12vGke/Bq7CW3sRBkgDdYrjvZqtpm1JhO947cPA092lUfmhKtpKhLh8zAP0+GEF
 nS7CcilK5xsBhjWsaXiYtk72QuN3u/TuJ8BwjMh4pHJFuu8GU1Q2sxD
X-Developer-Key: i=gary@garyguo.net; a=ed25519;
 pk=vB3uIX95SM4eVrIqo1DWNWKDKD2xzB+yLLLr0yOPYMo=
X-ClientProxiedBy: LO4P265CA0261.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:37c::14) To LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:488::16)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LOVP265MB8871:EE_|LO0P265MB2905:EE_
X-MS-Office365-Filtering-Correlation-Id: de77f910-3d45-4bd7-ec94-08ded3bc1fd4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|10070799003|1800799024|23010399003|376014|18002099003|22082099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	9PYLJ53xqD3DQ5vD/Iago8czXiPq3aY3C/Z7fBwwDGtFoe3iMtxbKcmSlWbX6DcAV9B47ZWMbugWAS7PzDfEOISJCnuMuiuIyGBzB8uKWBcuGIGAGWvawzX15aqLcGJ5BrZT0vs1nmM88lfJjPUOs+dE4FX+c6G7ielz505IRQEm2GdP2OWB3QV2mziugtm4VV0lmxWpbJNM0DtfbmSQNOKW7oEhYPY0L5WAbnf9aq6s+roBhS2dr5svz0ofltIRLfWwualylm5xJic2qDTXKp0qG/uOINfYURApwhG4WOpXdwdlvTXWMww3mUKE8EZRs0A42t7aWJPOGyFA2s+oBlq5U9uIZOCEKCLf+EA1uVmJ2WC7So0iDgzfUQ/3X9ZBiZRfQPRDWFuPi5taMtI5upTj8CuRPZK1fo3h8giOQyFnSuhlEwQHXqFcCOee3q92+CTfLsQXbS3C+/t8PasaBdkcksB/Ah7IR+qasajPAjCNyji1YzCp9PWSk+q/nEet5wF3EqK2sUv4UIcVpJ1V6WQoz7OjlTP27jY4QvI96HTshZd+gd//dMyL6RUoHqIp57ggsjAta4ZzmLgvjtK3hhnTUu5xUViUlQh/0e6hrm3BVTp56kG9IyEfHzwf16jL6MFSkq2hcR4MA+IWzuuTTESs1xwyf3TI+3xap2O8Os4=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(10070799003)(1800799024)(23010399003)(376014)(18002099003)(22082099003)(56012099006);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bGVzWk54Nmg5ZTFDN3JUYU9ONkwwS2FyWHBZTU5SeTlHdjREWGFQS3cvK0tY?=
 =?utf-8?B?U0JmOXlnL1IyNFNHYzBOTHBaeGlhcGd6UitqSE9hdE5RbWc2WVpwU1UwTlFu?=
 =?utf-8?B?QkZ0QmxvajltdVNDVlVYZ1JGK0piWk5ITHQrM1diR0JuR2lINGdGZlB3TE1y?=
 =?utf-8?B?ODNtUHRkU0toNkRTdURZTSt5cjk3YitZUkFIMGhkSFNuREgwQW54MXZ3ZCsw?=
 =?utf-8?B?eENSdy92R2NtVEJNMzczVTE1SlgvT2d2VXAwL2FLWm54b3VBeExBeTdDTFBj?=
 =?utf-8?B?WVM1azhHS284T3AwVkQ0VHFFYkpEVXlyZm41cGhMQzlSNzg5VEEySWl1bHJt?=
 =?utf-8?B?Z0FlOGdYRldxdFEvbmtTNE5WMnltYlpnOGxQSGtmV0lFMGJpWVZGZ1NPeEx4?=
 =?utf-8?B?cW5jcmIxYWpYNjBUYU1VejRoR1lTY3JLUDNkNVdDK2x2UTZXN0o2TUs3bSsx?=
 =?utf-8?B?cHF0RlQ2SDJuRVlmL0xKUnpNS3JIa29BM0tONzcxandSdEJtR08xWEMxZW9J?=
 =?utf-8?B?YWM2TzhXRnBYWWluVUhzN3g3MnJ1VHJNdkpzTysyRU5UdUprVm5NODE5anA1?=
 =?utf-8?B?OVZYNUlpd3drQ3l0QWNPYUxHNHd6ZFlTNzBiN3d6eEs4Rks0bVNZVS91MGJ1?=
 =?utf-8?B?eGR4bnZXNFlBSzQxdFJ3cWpFOEFrWDBLRlg2STZVTUZyekdrczVjRjluNEtN?=
 =?utf-8?B?K0JBNm1zRm1lY0t1RHRXUEM2ZlJyd1BqcHllWHhKYjl3MlBEUHFUWnRUQUFs?=
 =?utf-8?B?UEZkRzVLa0tmQk1KM3FTWm1xOWNxbVBHWjRlUkJxeGNHNlJZMTJuSVBTT0Jv?=
 =?utf-8?B?WHMxV1QxSGgzRzNQQm5CVXNtWkdlcFpwTzBTQ3NTVzBwdGd4ZDNwZXcvR0RV?=
 =?utf-8?B?N1NONE1sdkZoM3RHdGpQQzdCWFgyTExvL01zQi9VajhWQXpBMFpmLzNDYnA1?=
 =?utf-8?B?V1FrM2tZYzQxUDRVcWdBZnRrclAzK2xTNDhvdE5UZzNoUGQzRnVKV2szMGwx?=
 =?utf-8?B?U0o4WG5abzJFSXFKU1VycDNnVElQeFUxeU96SFk5RG8rRXFiM3R2dHFENWRk?=
 =?utf-8?B?ZmdSRFhHWUZVZE1uRmZFY09qVEtTMkhaQUpzeHA2SDdUZm9sZnVvQUlGUlVv?=
 =?utf-8?B?OHdXbklYczRTNnNIM1FBNkdRNnBLdlF6c0c2TUgrWWtOWlJmZjZ3TXZCbDFI?=
 =?utf-8?B?Q3RycWRkR1RqLys2bmwxY090U0Y0RjhZTEdkdVdnMWlQaTVocmV0UXRJNWt6?=
 =?utf-8?B?clVhaG5XTnlnMVRBTGxhSFdVamVDbDF6UWE2LzBTZlFUZ2ducERDdzdqU1Bx?=
 =?utf-8?B?eWU0TTFaUEpMM2ErcCtEOVVVOGNHSWVkR0grTTBkaUxvM1l0eDluV0hEaVhW?=
 =?utf-8?B?MjIzU3VjVDgrK0pTL1ZLNStLMUQ1eklUbEFHQmdkbDd6RDdEMFpuNFczQW5S?=
 =?utf-8?B?bkZyNW1WalExQWZLSGxtVjZzbmgvdHZOMVpvUnJHSFY1K1BIRFQrbUtlRnRX?=
 =?utf-8?B?b2tjNUhrSnd6d1g0bkp1VzlCREcwQzlJTnNjMnZIRnc1aXlkblBER3NiTW9v?=
 =?utf-8?B?Mm1OY3hCZ1dQU21oOThyYjZnVDFlZC9KQVlPaTQ3NHk4eHhZc05Zb2hoWk56?=
 =?utf-8?B?ZTloM3lHT21PbFpsc3h4MnF5Mk93M0YzMUloTWhRbDU2Qk56NHMrUVlEalgz?=
 =?utf-8?B?N2tMdEY1aFpOaEtPSTNKTHJ3YUMydzRrTVgzODJjQ3J6WXBKNTVuTmFUbnVw?=
 =?utf-8?B?VTVJMGlod21KdDBVU0FjV1laMnA3SnJ5M0thU05sd3dlUVgrcUl0SURDSXJF?=
 =?utf-8?B?Szh4SHFRUG8vSEUxOXBNT1BvVFlENkEraURoZ3cveHlDMUo1ZUUyNjhnMWEy?=
 =?utf-8?B?WW53Zmo3MzMwczJKM1FzVmoxY0ZNWVQwMW1rOWdUMnVVUDV2ajhzNWk2Yk5v?=
 =?utf-8?B?TFRscjVHRUR4WmdNbEMwTThiMG51T0JkRjNFYTlTOHRmSjJWQmVaRDcwSksr?=
 =?utf-8?B?ZHluVTZsZ0dvODkzc0pnZGZsMU1ka2xCOGluNVdETU1UNGlhOHdpMk4yeUlQ?=
 =?utf-8?B?bXVRT0ZKRTBzaGxJNlZock96OWpvVlM4S2RkeWEycXpDdnYzbXRXTGhJS2dq?=
 =?utf-8?B?WE4rMDQ0WWlHQjNxUU5Mam4vdDF6K0cvekU5TE1ObURrN1A2NXE4MGt6bVI5?=
 =?utf-8?B?UUxrTk95NWFsQnJROXdHRk4vTU1SVnVHa1R1am9PR2s0Q1FMSlRMcFRCUTBh?=
 =?utf-8?B?MjUxZnU2ZjJEUGNYR2dnODZPL3Z2L0wrZUsvU2pycnNZQ2R2NGJHVzhTeVRI?=
 =?utf-8?B?RkRyM2lqcTcvYXh1RTBiUzFTVmN3bUMxRklnZVI4cm9QWW9wanZlQT09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: de77f910-3d45-4bd7-ec94-08ded3bc1fd4
X-MS-Exchange-CrossTenant-AuthSource: LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2026 19:50:07.5213
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bPONsot45upzQKBD56f+4VTAsHI6UBquavvnTkZx618Xqc8cT+8ldDV+6Rlng26fSokHYu8LMekOkDUxQmII+Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO0P265MB2905

Currently there is a TOCTOU issue in new_id_store as the dyn ID insertion
in pci_add_dynid and the pci_match_device are in separate critical
sections.

Fix this by moving the existing ID check to inside pci_add_dynid and only
check against the static ID table outside the critical section.

Fixes: 3853f9123c18 ("PCI: Avoid duplicate IDs in driver dynamic IDs list")
Signed-off-by: Gary Guo <gary@garyguo.net>
---
 drivers/pci/pci-driver.c | 112 ++++++++++++++++++++++++++---------------------
 1 file changed, 62 insertions(+), 50 deletions(-)

diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
index 0507cb801310..464ee52346fa 100644
--- a/drivers/pci/pci-driver.c
+++ b/drivers/pci/pci-driver.c
@@ -29,6 +29,48 @@ struct pci_dynid {
 	struct pci_device_id id;
 };
 
+/**
+ * do_pci_add_dynid - add a new PCI device ID to this driver and re-probe devices
+ * @drv: target pci driver
+ * @id: ID to be added
+ * @check_dup: whether to check if matching ID is already present
+ *
+ * Adds a new dynamic pci device ID to this driver and causes the
+ * driver to probe for all devices again.  @drv must have been
+ * registered prior to calling this function.
+ *
+ * CONTEXT:
+ * Does GFP_KERNEL allocation.
+ *
+ * RETURNS:
+ * 0 on success, -errno on failure.
+ */
+static int do_pci_add_dynid(struct pci_driver *drv, const struct pci_device_id *id, bool check_dup)
+{
+	struct pci_dynid *dynid, *existing_dynid;
+
+	dynid = kzalloc_obj(*dynid);
+	if (!dynid)
+		return -ENOMEM;
+
+	dynid->id = *id;
+
+	{
+		guard(spinlock)(&drv->dynids.lock);
+		if (check_dup) {
+			list_for_each_entry(existing_dynid, &drv->dynids.list, node) {
+				if (pci_match_one_id(&existing_dynid->id, id)) {
+					kfree(dynid);
+					return -EEXIST;
+				}
+			}
+		}
+		list_add_tail(&dynid->node, &drv->dynids.list);
+	}
+
+	return driver_attach(&drv->driver);
+}
+
 /**
  * pci_add_dynid - add a new PCI device ID to this driver and re-probe devices
  * @drv: target pci driver
@@ -56,25 +98,17 @@ int pci_add_dynid(struct pci_driver *drv,
 		  unsigned int class, unsigned int class_mask,
 		  unsigned long driver_data)
 {
-	struct pci_dynid *dynid;
-
-	dynid = kzalloc_obj(*dynid);
-	if (!dynid)
-		return -ENOMEM;
-
-	dynid->id.vendor = vendor;
-	dynid->id.device = device;
-	dynid->id.subvendor = subvendor;
-	dynid->id.subdevice = subdevice;
-	dynid->id.class = class;
-	dynid->id.class_mask = class_mask;
-	dynid->id.driver_data = driver_data;
-
-	spin_lock(&drv->dynids.lock);
-	list_add_tail(&dynid->node, &drv->dynids.list);
-	spin_unlock(&drv->dynids.lock);
+	struct pci_device_id id = {
+		.vendor = vendor,
+		.device = device,
+		.subvendor = subvendor,
+		.subdevice = subdevice,
+		.class = class,
+		.class_mask = class_mask,
+		.driver_data = driver_data,
+	};
 
-	return driver_attach(&drv->driver);
+	return do_pci_add_dynid(drv, &id, false);
 }
 EXPORT_SYMBOL_GPL(pci_add_dynid);
 
@@ -197,11 +231,6 @@ static const struct pci_device_id *pci_match_device(struct pci_driver *drv,
 	return NULL;
 }
 
-static void _pci_free_device(struct device *dev)
-{
-	kfree(to_pci_dev(dev));
-}
-
 /**
  * new_id_store - sysfs frontend to pci_add_dynid()
  * @driver: target device driver
@@ -215,38 +244,22 @@ static ssize_t new_id_store(struct device_driver *driver, const char *buf,
 {
 	struct pci_driver *pdrv = to_pci_driver(driver);
 	const struct pci_device_id *ids = pdrv->id_table;
-	u32 vendor, device, subvendor = PCI_ANY_ID,
-		subdevice = PCI_ANY_ID, class = 0, class_mask = 0;
-	unsigned long driver_data = 0;
+	struct pci_device_id id = {
+		.subvendor = PCI_ANY_ID,
+		.subdevice = PCI_ANY_ID
+	};
 	int fields;
 	int retval = 0;
 
 	fields = sscanf(buf, "%x %x %x %x %x %x %lx",
-			&vendor, &device, &subvendor, &subdevice,
-			&class, &class_mask, &driver_data);
+			&id.vendor, &id.device, &id.subvendor, &id.subdevice,
+			&id.class, &id.class_mask, &id.driver_data);
 	if (fields < 2)
 		return -EINVAL;
 
 	if (fields != 7) {
-		struct pci_dev *pdev = kzalloc_obj(*pdev);
-		if (!pdev)
-			return -ENOMEM;
-
-		pdev->vendor = vendor;
-		pdev->device = device;
-		pdev->subsystem_vendor = subvendor;
-		pdev->subsystem_device = subdevice;
-		pdev->class = class;
-		pdev->dev.release = _pci_free_device;
-
-		device_initialize(&pdev->dev);
-		if (pci_match_device(pdrv, pdev))
-			retval = -EEXIST;
-
-		put_device(&pdev->dev);
-
-		if (retval)
-			return retval;
+		if (do_pci_match_id(pdrv->id_table, &id))
+			return -EEXIST;
 	}
 
 	/* Only accept driver_data values that match an existing id_table
@@ -254,7 +267,7 @@ static ssize_t new_id_store(struct device_driver *driver, const char *buf,
 	if (ids) {
 		retval = -EINVAL;
 		while (ids->vendor || ids->subvendor || ids->class_mask) {
-			if (driver_data == ids->driver_data) {
+			if (id.driver_data == ids->driver_data) {
 				retval = 0;
 				break;
 			}
@@ -264,8 +277,7 @@ static ssize_t new_id_store(struct device_driver *driver, const char *buf,
 			return retval;
 	}
 
-	retval = pci_add_dynid(pdrv, vendor, device, subvendor, subdevice,
-			       class, class_mask, driver_data);
+	retval = do_pci_add_dynid(pdrv, &id, fields != 7);
 	if (retval)
 		return retval;
 	return count;

-- 
2.54.0

