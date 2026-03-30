Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012022.outbound.protection.outlook.com [40.107.200.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60C0C372B2C;
	Mon, 30 Mar 2026 09:42:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.22
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774863753; cv=fail; b=VoLbFIpKxTLhwRvxm6B6fy0yVMWahLyX8hwbCS6aXAl7pii2iiTBiGz4oTFAVSrbTHXdPiqpk1amP0IIORTpXrPV96d9eB3xo7xuKiwztm7LPjqDD4MviGNI/oaor2DmjLnKhRzgVmLD6JSWio+hkg3IEUvAEoaNij+5Jcn+CS8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774863753; c=relaxed/simple;
	bh=+upANx41izA72ECEjvgxQLbzO+CYN/J4Xd+7f2f/V8E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=RfWRmJidqXcZgcg6FIjKtW/scJzVgjr0ZLzbtH0zceOnwhJUpcrJ3jZUhNRS4Z/UfDldQuesG8qvMYke01TWNAJ5XXveSV1x4ApEn/Ftw1fDr+U0TsP5wWeGvGVVcb18biVP4K4ScxxESpwZF7tn8HQ+FQ4QdQ9wvr2PWqgGKJw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=QFI+YTI/; arc=fail smtp.client-ip=40.107.200.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="QFI+YTI/"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Z1cRtMKT6c8H7nGGrywVFUyaTqY2WJc8CcTgMoZzwGl5qsTGXNrdrdgDTsd/5+VgDII1C3uLkxguAbNVDCTXDkxrZyh5K5UzkYnqDIgKO/Z9GufseeXnsw2TycjIrnuSqjWMjFXuLUpkFM+krJRdin/KdAU7cNiuXR6RALA55T5qbwe57HwlK1c/zvweOYGbX2HzitOL2pb6COubU5T9LZOhVHS/L9/QkeKveCGptVA2/BBKM/hn4smQjReKAV82svT4VxtBLTzQamQDK4sJrFHVB+OQBP46AdlWQrrS9abHsH4o261jItufZ/rgJudGvc8GB5Y1Ndx2EF1S8YJxTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QzgBZZk2BUzgMSm6mtr2EFsW3aRbvon+I8dMYcf+gWk=;
 b=E0puEb/tQGWnjM7iandTvnrRq+TR+i0L2qJTK6z0QPTygHtcpsWaZnheyK00Pb5NVgPZwJivOeaFxSnK7o+NJdWLAizKaOlbCKhs76Iq8JhpjzVl5hGimKsKf8H6iFY/j0MjcAM0NbBTtJT1Lp7dhYnoybtxW9GZiWTJPaREP+1nLqlvETYzeP7YRwByQmp+L26Y/JWe1PQ+Rzc7J+jsuIdz13YfBA5U/ELgZPfH7QqBph0AGAo9knUeQAczTew1B8VL+/5Hel21jfw8SWQJqV0zI8RKtERGELwwxtbkAaK0BbFmHhfj8UJ9jp74KUfGpiDvQgVYoj/hsyHn+gMMzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QzgBZZk2BUzgMSm6mtr2EFsW3aRbvon+I8dMYcf+gWk=;
 b=QFI+YTI/vQQItaYbygZvitkw2b7FXo4AeRKlDDY8q/m07fThR2zrNCFpKWTPx8qOC0hy+J7h16sv/iSQhwmORFsUk0HafYDbwoUdz35ZiyMTfWAaST+yjRAa6+IEKi9EH9lts6AgQMc4nZaa6bi4lME6iFPmtkw8q6D556MxIG2NpS1QnZVWKjFcDZ1zclXJ3fpxc8jQF2ode2HYYdnXqzLW/+DiNh2QI70FS0ejtKTaCxWAlxntWW9s6lYW2KhY9kCTH+EJnGLyy5rbS+ajGp3+Q0BVtDzZjaBVJGDMrxY9RpV7SJKzBWvCXLgRXNfi/MGlT2A7UNseD0dp9Surrw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH7PR12MB7914.namprd12.prod.outlook.com (2603:10b6:510:27d::13)
 by DS0PR12MB8246.namprd12.prod.outlook.com (2603:10b6:8:de::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.15; Mon, 30 Mar
 2026 09:42:24 +0000
Received: from PH7PR12MB7914.namprd12.prod.outlook.com
 ([fe80::d390:582:5536:40ad]) by PH7PR12MB7914.namprd12.prod.outlook.com
 ([fe80::d390:582:5536:40ad%5]) with mapi id 15.20.9769.014; Mon, 30 Mar 2026
 09:42:24 +0000
From: Kai-Heng Feng <kaihengf@nvidia.com>
To: rafael@kernel.org
Cc: jonathan.cameron@huawei.com,
	helgaas@kernel.org,
	guohanjun@huawei.com,
	linux-kernel@vger.kernel.org,
	linux-acpi@vger.kernel.org,
	linux-pci@vger.kernel.org,
	acpica-devel@lists.linux.dev,
	linux-hardening@vger.kernel.org,
	Kai-Heng Feng <kaihengf@nvidia.com>,
	Shiju Jose <shiju.jose@huawei.com>,
	Tony Luck <tony.luck@intel.com>,
	Borislav Petkov <bp@alien8.de>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Shuai Xue <xueshuai@linux.alibaba.com>,
	Len Brown <lenb@kernel.org>,
	Robert Moore <robert.moore@intel.com>,
	"Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com>,
	Breno Leitao <leitao@debian.org>,
	Jason Tian <jason@os.amperecomputing.com>
Subject: [PATCH v3 1/3] ACPI: APEI: GHES: Add devm_ghes_register_vendor_record_notifier()
Date: Mon, 30 Mar 2026 17:41:55 +0800
Message-ID: <20260330094203.38022-2-kaihengf@nvidia.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260330094203.38022-1-kaihengf@nvidia.com>
References: <20260330094203.38022-1-kaihengf@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TPYP295CA0001.TWNP295.PROD.OUTLOOK.COM
 (2603:1096:7d0:9::18) To PH7PR12MB7914.namprd12.prod.outlook.com
 (2603:10b6:510:27d::13)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB7914:EE_|DS0PR12MB8246:EE_
X-MS-Office365-Filtering-Correlation-Id: 391ddfab-0d0e-47be-e89e-08de8e40a5a5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|7416014|376014|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	nXqfpL9zFbZ3dJVwQbo4z+K/AkIStsDYiRWml1+eKwSUmqIsddGoAMoYS178y2LbSMFLdWQHfpueD+ZZF9wNW/mGfw4Li8SZFRlR7OzArO1j7y6iun8v7Rzf926bDXYIKwFqCkPw3amv9lXDU9hjktnFb2UnTIFQNzxqPV+HEmtkv3GrQ6beNOjO7E+U/w/0mKknf9JYwc+PHmQdumRVEiwhOlRkSSbtyLW72qNn1wasSVeJVTHNmvHj8tkmVdCERIjwbd1r5Zr48XUDSiPJM1dpu0ldWFs/CJMps0M5cHpp6cCtO8AHNfNOsB+OYQvBM4i4BX/Yga0HiS2Wgqvnc/CDArAA+ptaA7B39k+QSrqwzGUdGE2+MzxGPVpL0tuYb95V42PeFrY6fdtzZPUz3AsfDa5NuYhshs6jM7sXYo/DTaxSdV9uATqceIAUvum64Bf2asRCKXxpFoto+VhTYeT2l0apa45hR+5H3otIvTZ87vPr/mcEHtffTB8CLA29wy8HRUGXi7rWpemipEdcatlQlIaJMBah43+hQAFm2S6E8WfnafKCIH9QZ9L9SCWjqsOj/5CZu9SgXyg0UnISWrWE5SmD83vB4IRvMlKzaY43tPyvMPCnTLRQ00kkRLeRFKnkk1BuBeQMJUMULSCTMVacYplzuKjdeaqfwm+FbnDsRRPlzabNFG4PD2v1kOSXz9QsiVaV7me8IBqE0MCvErBvQgz2FMYRQYKMn13gN/E=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB7914.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?xXWx4Gmx0s0HQeLU4zFzVGiH816ahgLjR8yUhfi1odRiJbGsBZJLPCBP81JL?=
 =?us-ascii?Q?S31577s3v/foV7TF6fMCXHMCE6LyqdEkdStg+1tzph62ik7ztsIN7vEoSzTu?=
 =?us-ascii?Q?rHwPZcTqcuJAyvMOjuJ4HxNWnxC2KbJJVnZp5jelBYOVb+v4KWRPELopuH2E?=
 =?us-ascii?Q?jWV+vvfxk7ulSSGDPrapzGkPuiTu1UwDQj/DpEoy1f+RNSPZpsTOLSSWtVpZ?=
 =?us-ascii?Q?QpVJWW7X27csDAtTkM4GkpIJIllOcQnpFRRGKeU5CsofnaRk34CaPMO9ToeK?=
 =?us-ascii?Q?VCdcagd/EapQyKIvq3HIcx7AkAEqzlduUXM4EKo+q6qLdkAwCFdfgGxIFENX?=
 =?us-ascii?Q?hYyJSvFksForF3egssBJowKgfd4z8dAFLui1cWnmoZS0INOWXOih5aR1OSCn?=
 =?us-ascii?Q?4oyiZA6+HnruPy4pIXnp/IdpzJ/37ZgttkIGvLYS3tr6itQ1P+BKBG5pYLsD?=
 =?us-ascii?Q?I3CFS/0IKt6L1eqMQ37Sq4LeN6sU7ZB0uh1YrjJp2YImb0zP5LmWEALluJ3F?=
 =?us-ascii?Q?8SUeHcR6HccTt6+5Uz50rURrNSDr17zPbH7xF3kvm8dTmwnGxgA4pFqREXox?=
 =?us-ascii?Q?0V5TWfHi42bi6XpObzNpMdiYjsgj5MIlv6EfpbWX42ga3trJingc7DVB/xYi?=
 =?us-ascii?Q?rBghRGU/4Y8kdIxfaGCoXewo+9XH8klGs+KHHWsGBuxCvF8sapfhOHVJME9w?=
 =?us-ascii?Q?hikMDZmbcWWa9RK8ELD8Cz9MykYav14nI5aFo37RAuvZ38iTlgr0s0TRCOjJ?=
 =?us-ascii?Q?A2hAMtEA0GO3S13Hv41KVkPsQTh29kX5EyGnCClcP731LVsPZpopsPnqKJEH?=
 =?us-ascii?Q?SA7PFj126oLM0nOVAqAkPGioWh9KlGkBjikW8DNfbODqJb3ZGXkYoG9e7ppg?=
 =?us-ascii?Q?U7Q8HYhzpfNOBZ2bdPPN3oISWkSnOF+HR9LPmQL98pVtpg+aJmnK8mPMpF0X?=
 =?us-ascii?Q?Smy8b5pROf1ezRPek9yAQF8xAURGuXDye6aYQIsAG2J294buDsBX81B2tcY7?=
 =?us-ascii?Q?3GGSKVrEzIhsA6xVflAtMnMDJK81Jh9BgirfI7xu+Sk3wU5gdc8P4uRAHAma?=
 =?us-ascii?Q?5HEcs8RwD2vy2QDusDZAeyhKP5i2nHJ3i8XDfjPBnyO7BX76b4HgnyVUrtOE?=
 =?us-ascii?Q?yNsuu2QBbr64Mu6RFfexlCMehUQWquEtvFDrZ9zZ7bKE1BTNudQJKeLLgClr?=
 =?us-ascii?Q?v6TWj9cSdPd7+Nh2TCSTucb9fu5nqjq1FHnq2sVu0Ui+WKGKjsdCDD3HsOch?=
 =?us-ascii?Q?R2httQSTP9mXfQOpR4SWhycID5U8aQVNf/Opkxx12T5QueOjz+hdybjLlo+9?=
 =?us-ascii?Q?Rgi972M+C/VxTiH+xts8Q5+kRBpWLeyyEdktkf5jBRx4szCKC/0mN3+dKRaZ?=
 =?us-ascii?Q?JCWs+2rg1hFGNTd/nAavKh35YV0AitHzt6nTD53dG9sAU8lvvrODZbqj+8Y0?=
 =?us-ascii?Q?mDBZWOV7q6f2nlkjE6KzUxqFFFHBI+LHRMnQNjjG1TauBfpHnqOen/9Pjxlg?=
 =?us-ascii?Q?/W+xWp/hHTn2j+ykpgPiw0g0t2Utdhz6bMFf88Z9RBB8HzjJGFL9tkyKAGzd?=
 =?us-ascii?Q?jINFbWLc54UCIJOd7o+ZazOobb6EWVJCdIOzzBRj5r1BKQVR5RpJhjCZoMo/?=
 =?us-ascii?Q?yleIzxunPS+QefLziEHAVBjgoIwNPHUtcaiFo5s6j9NQqxVM3oworLbwBzY2?=
 =?us-ascii?Q?2v4zwHW45u+3eVI93ojJfWwHV/DQ3eZbDl7uAC9XXpJdd5c9AkNJ22IPXujj?=
 =?us-ascii?Q?nusWGd3tjA=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 391ddfab-0d0e-47be-e89e-08de8e40a5a5
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB7914.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2026 09:42:24.3445
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: msss23uoJi63RiNVaNQdr6+hMefJ3cFF0Vy8CaipJGB6e36+OdtqhebuunwxbwkN4IcZNiXTpZYCn989JUkv3Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8246

Add a device-managed wrapper around ghes_register_vendor_record_notifier()
so drivers can avoid manual cleanup on device removal or probe failure.

Cc: Shiju Jose <shiju.jose@huawei.com>
Cc: Jonathan Cameron <jonathan.cameron@huawei.com>
Signed-off-by: Kai-Heng Feng <kaihengf@nvidia.com>
---
v3:
 - Change patch title
 - Move documentation to header file.
v2:
 - New patch.

 drivers/acpi/apei/ghes.c | 18 ++++++++++++++++++
 include/acpi/ghes.h      | 11 +++++++++++
 2 files changed, 29 insertions(+)

diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
index 8acd2742bb27..3236a3ce79d6 100644
--- a/drivers/acpi/apei/ghes.c
+++ b/drivers/acpi/apei/ghes.c
@@ -689,6 +689,24 @@ void ghes_unregister_vendor_record_notifier(struct notifier_block *nb)
 }
 EXPORT_SYMBOL_GPL(ghes_unregister_vendor_record_notifier);
 
+static void ghes_vendor_record_notifier_destroy(void *nb)
+{
+	ghes_unregister_vendor_record_notifier(nb);
+}
+
+int devm_ghes_register_vendor_record_notifier(struct device *dev,
+					      struct notifier_block *nb)
+{
+	int ret;
+
+	ret = ghes_register_vendor_record_notifier(nb);
+	if (ret)
+		return ret;
+
+	return devm_add_action_or_reset(dev, ghes_vendor_record_notifier_destroy, nb);
+}
+EXPORT_SYMBOL_GPL(devm_ghes_register_vendor_record_notifier);
+
 static void ghes_vendor_record_work_func(struct work_struct *work)
 {
 	struct ghes_vendor_record_entry *entry;
diff --git a/include/acpi/ghes.h b/include/acpi/ghes.h
index 7bea522c0657..8d7e5caef3f1 100644
--- a/include/acpi/ghes.h
+++ b/include/acpi/ghes.h
@@ -71,6 +71,17 @@ int ghes_register_vendor_record_notifier(struct notifier_block *nb);
  */
 void ghes_unregister_vendor_record_notifier(struct notifier_block *nb);
 
+/**
+ * devm_ghes_register_vendor_record_notifier - device-managed vendor
+ * record notifier registration.
+ * @dev: device that owns the notifier lifetime
+ * @nb: pointer to the notifier_block structure of the vendor record handler
+ *
+ * Return: 0 on success, negative errno on failure.
+ */
+int devm_ghes_register_vendor_record_notifier(struct device *dev,
+					      struct notifier_block *nb);
+
 struct list_head *ghes_get_devices(void);
 
 void ghes_estatus_pool_region_free(unsigned long addr, u32 size);
-- 
2.50.1 (Apple Git-155)

