Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013002.outbound.protection.outlook.com [40.107.201.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FA6C2C15A5;
	Tue, 19 May 2026 03:39:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.2
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779161986; cv=fail; b=A5s3rXclRTZkadwucX+TlB+Ih2Wewb38E6Jkmpd0/dzHl0w/NfhzdH9C9lfgwEaKGs9dJedZlckoJ82ExcOoYaHKmKoRqqUAdwtBn8PlApFnf7setIfW9xDsthj96e7IwRBrVFNedOc8GIJdGQfaHSTuxbNfLCR/IutYqyMUv/M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779161986; c=relaxed/simple;
	bh=kt0UaxrgHpMJOHglmNpBtZ8S6zQglBuGGxBJb05c/6A=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=STQWfxg1ZM6S5OcH7pG8rBydZBLmcoIa7aky3woA7Itaet/q2RuMtCzdfgdflUvzIGpekN0Yu8wGgxxkr2OLFP40NhXQdWjv6ezdVorzbQNLiq674cSv9YU+0rSkuTz8VjN0PMqnTd3U0dLuuUb5JjvQA8dJBHB1M6vpr/evrHY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=VsxuPA3u; arc=fail smtp.client-ip=40.107.201.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="VsxuPA3u"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=J7lT/KQOLEBpaNOYuRq0QJKRfopoN2nomKy47uLpQtm0R7RyEefXdzmSPVWoxlx7H/ezVFZ1VFMi/TUeLdd0fjNYcCQ6mKwUGCqdQJ/tRBrAGqPYV9rEE8E0WnGRkaW2V0eZDyZwTQUV1lzuGCds8gEBImoLu75G63ZmBSoUviXhsjyvAAaCL1jBzDIaKTPHtmo13wld7rriEb8izfNWa49AQxnSHlcXbMWYldh+1L83Z3edPllCAPWr8zO8mtG8AWCmgCkkB+EnMHdSvPIlnmaa9S+hVz1KoiHilCOIjUAer1OWi3fN4OX6DSJesm8sAz89Ud5tgVyDNk3aS5DLbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Kr8MsZ50iT0ypnjYlH/6eqFW8rI9Evswe5GVXTh4MmM=;
 b=jqHKC7jjnYBIoUEW5bIEItqTABPfs/qqOYmPViX8ZDToSWY2kRpmviUXTpVgUyxGIrqBzZNR7vlhJtQ9hGIWF4U8nA9OAa5/ns2TGsF/dN/M2kzRFr3SpeLgb/W3lSs6K8iODba9f/Ry7IWaCbQF0bjwO6jjYiIlBi1Xxg5aWjAGufmppWGkMYN4PGEr1g1X4Yb3vwUDYL8hvy+azzOCBjD1Zrwq5kNc7DGNAC/nvYwgfoONJPWWBZoPH/2hBvqZKRJ4/jAhKuhPHu7arQsZBVHDhGzXpCwPMbiihE0y6v4CsmmcYAjON9o2rKK8fpQ7fFQJ2O23cNQIvHrIABitbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Kr8MsZ50iT0ypnjYlH/6eqFW8rI9Evswe5GVXTh4MmM=;
 b=VsxuPA3uscU/G/bMXLHHtmtkXZBbGf9f2G6Grlop4zQ2Y/5B0JqF6rgDXRlJN8GowZiGn2Vc+c98Q8fp5HOeSC35BD0nhjvEuUJvjdHatu1e2dLqnC/xdwpyRrr/ZcPjWoDk3r7cG5y0qQHlzf7+57MZPVxQ02YEojxS9yFLDVaNY7MacE3K2LtEC1xC6IIt5X1rx7CKVt96XmvvJdT3DBmpoOM1RIfBiiad9q2cA5RYM8iyh48Otu4ljBm9LjW6KEyXngonKNr2XAxRgAwCLl6D8nVydHakpDXi/Y/0F7rC5A5UCNkWaLnGUNw895r8qOq0DpyeNFYd6fbUuPeUzw==
Received: from DS1PR04CA0001.namprd04.prod.outlook.com (2603:10b6:8:44f::8) by
 MN2PR12MB4319.namprd12.prod.outlook.com (2603:10b6:208:1dc::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.24; Tue, 19 May
 2026 03:39:38 +0000
Received: from DS2PEPF000061C3.namprd02.prod.outlook.com
 (2603:10b6:8:44f:cafe::9) by DS1PR04CA0001.outlook.office365.com
 (2603:10b6:8:44f::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.48.14 via Frontend Transport; Tue, 19
 May 2026 03:39:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 DS2PEPF000061C3.mail.protection.outlook.com (10.167.23.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.48.11 via Frontend Transport; Tue, 19 May 2026 03:39:38 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 18 May
 2026 20:39:23 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 18 May
 2026 20:39:23 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Mon, 18 May 2026 20:39:22 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, "Joerg
 Roedel" <joro@8bytes.org>, Bjorn Helgaas <bhelgaas@google.com>, "Jason
 Gunthorpe" <jgg@nvidia.com>
CC: "Rafael J . Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
	Pranjal Shrivastava <praan@google.com>, Mostafa Saleh <smostafa@google.com>,
	Lu Baolu <baolu.lu@linux.intel.com>, Kevin Tian <kevin.tian@intel.com>,
	<linux-arm-kernel@lists.infradead.org>, <iommu@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, <linux-acpi@vger.kernel.org>,
	<linux-pci@vger.kernel.org>, <vsethi@nvidia.com>, Shuai Xue
	<xueshuai@linux.alibaba.com>
Subject: [PATCH v4 02/24] PCI: Propagate FLR return values to callers
Date: Mon, 18 May 2026 20:38:45 -0700
Message-ID: <f3d432f4da7a310545e99172b91de737c7c9321b.1779161849.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1779161849.git.nicolinc@nvidia.com>
References: <cover.1779161849.git.nicolinc@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF000061C3:EE_|MN2PR12MB4319:EE_
X-MS-Office365-Filtering-Correlation-Id: 60e72bd7-8439-43a1-fa53-08deb5584107
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|36860700016|1800799024|82310400026|22082099003|18002099003|56012099003|11063799003;
X-Microsoft-Antispam-Message-Info:
	UeBKxtzWAsJeBVsfCa+W+r2/Qb5d8ZDr2iNGsCwEn4rnUhf06G/ygooLL6/8/9XqiF9t5z9rx8MX5IHqp893DaXFXEdN3CA8zeQTi09rPKRLAyms+i5vaJ9eQy0u0plPjmF+nnxy5rXrRY0TyppA9OUZdHW89sXEBoYc91weTGi9jDq+J/8ah+aIN+QDgI4pKHwTYoIzjdolnmrhgMvaI3O1WgepAwx7WQWoCop+x3uS3spf2r6uXV2DJctp44ll5IgBdCUppb6tUxLeZoDfp2LMf4bKJCo0bQoyL8yE+/g8KPCG8GcaKC20Z6iNbyzIG4rO8c5/7hDmt0yA1u+iPFxQN4gWj8Dxzg69ljSMoq6W/UsmFqOtLtqcR2bcP3HIxRY/WVZVRgxFZks71NCTUlGSfISG55x2MkLScvHxeWabCiGfqEYFbVeuDBljg3yzn1e5yzK56ykQP+41NB6W1gAdIU/sXPdMyKP1UyhOZTIh6V28n9/yayw0HyZPW6QAqW+zAf5SkcvotyEcvDOlcACP5x/KbYN/F5XZyL3jrKmll0G0O4TI177ALweAWSgJdY1tnLTRP0oablfwWyrnENbqx0WgmgPdVDeoqYanF4IVGKt46ilqWmny6jbMMfU2BHX6t2Jvk41yXYP8PCJSTfLAAPPQOqO3w5S0S6/r1zowcf4Gr5YsY5FSnESLM/UZmmvOe6XHRMTzGqi2S4YQK38Qj5vHBPoA+6ldJ/Qjq/U=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(7416014)(36860700016)(1800799024)(82310400026)(22082099003)(18002099003)(56012099003)(11063799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	Ca8fD5YB0VRlTF8BinhXYy1rmtmVhMXf0sAKF0rSpKE6ncEUG6VNNlp1lAOHqDDahlUBgZV4EDkAaMWLxG1Jrupnc8rU0upXXeyG7gfL8CWsxu6EyBLwCHPk76yeWIyH6IfHScF48JA60zlbDreGmbmsd/hpX0JabfSVXYLAV1/pmFfa7z9HMxSRjCgJ+fAogz4pHAmEhj8b4hP5eLlxr+KPDbS8JysTnKTBTq4RGLIdOFYD5h8zyaNU72lgYk7WiafcClNaLwWoERrD1f4pzkavvWrW5X66zcHA1JyMl+hAszna0by0SSHUHSr00EE66OmnhySlMq3MaBEOqWkBDhcJNevtbqK/1qniY2W0pRd0WWNbRa8SRfIF82uPAVX6ivUKC/3j2Le2IDexTLdaV1gyPhAXFvMkKyCHP5ZXvndndb+V08Drn7aMKl1fJDP3
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2026 03:39:38.4495
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 60e72bd7-8439-43a1-fa53-08deb5584107
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS2PEPF000061C3.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4319

A reset failure implies that the device might be unreliable. E.g. its ATC
might still retain stale entries. Thus, the IOMMU layer cannot trust this
device to resume its ATS function that can lead to memory corruption. So,
the pci_dev_reset_iommu_done() won't recover the device's IOMMU pathway if
the device reset fails.

The quirk functions in the pci_dev_reset_methods array invoke pcie_flr(),
but do not check the return value. Propagate them correctly.

Also propagate device-internal ack timeouts in reset_hinic_vf_dev().

Note: this change does not introduce any early return on failure, keeping
everything status quo. It only propagates the error code properly.

Given that these functions have been running okay, and the return values
will only be needed for incoming work. This is not treated as bug fix.

Suggested-by: Kevin Tian <kevin.tian@intel.com>
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/pci/quirks.c | 30 +++++++++++++++++-------------
 1 file changed, 17 insertions(+), 13 deletions(-)

diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index a344abd745947..6cded18c9a687 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -3955,7 +3955,7 @@ static int reset_intel_82599_sfp_virtfn(struct pci_dev *dev, bool probe)
 	 * supported.
 	 */
 	if (!probe)
-		pcie_flr(dev);
+		return pcie_flr(dev);
 	return 0;
 }
 
@@ -4013,6 +4013,7 @@ static int reset_chelsio_generic_dev(struct pci_dev *dev, bool probe)
 {
 	u16 old_command;
 	u16 msix_flags;
+	int ret;
 
 	/*
 	 * If this isn't a Chelsio T4-based device, return -ENOTTY indicating
@@ -4058,16 +4059,15 @@ static int reset_chelsio_generic_dev(struct pci_dev *dev, bool probe)
 				      PCI_MSIX_FLAGS_ENABLE |
 				      PCI_MSIX_FLAGS_MASKALL);
 
-	pcie_flr(dev);
+	ret = pcie_flr(dev);
 
 	/*
 	 * Restore the configuration information (BAR values, etc.) including
-	 * the original PCI Configuration Space Command word, and return
-	 * success.
+	 * the original PCI Configuration Space Command word.
 	 */
 	pci_restore_state(dev);
 	pci_write_config_word(dev, PCI_COMMAND, old_command);
-	return 0;
+	return ret;
 }
 
 #define PCI_DEVICE_ID_INTEL_82599_SFP_VF   0x10ed
@@ -4150,9 +4150,7 @@ static int nvme_disable_and_flr(struct pci_dev *dev, bool probe)
 
 	pci_iounmap(dev, bar);
 
-	pcie_flr(dev);
-
-	return 0;
+	return pcie_flr(dev);
 }
 
 /*
@@ -4164,14 +4162,17 @@ static int nvme_disable_and_flr(struct pci_dev *dev, bool probe)
  */
 static int delay_250ms_after_flr(struct pci_dev *dev, bool probe)
 {
+	int ret;
+
 	if (probe)
 		return pcie_reset_flr(dev, PCI_RESET_PROBE);
 
-	pcie_reset_flr(dev, PCI_RESET_DO_RESET);
+	ret = pcie_reset_flr(dev, PCI_RESET_DO_RESET);
 
+	/* Settle the device even on a failed FLR */
 	msleep(250);
 
-	return 0;
+	return ret;
 }
 
 #define PCI_DEVICE_ID_HINIC_VF      0x375E
@@ -4187,6 +4188,7 @@ static int reset_hinic_vf_dev(struct pci_dev *pdev, bool probe)
 	unsigned long timeout;
 	void __iomem *bar;
 	u32 val;
+	int ret;
 
 	if (probe)
 		return 0;
@@ -4207,12 +4209,13 @@ static int reset_hinic_vf_dev(struct pci_dev *pdev, bool probe)
 	val = val | HINIC_VF_FLR_PROC_BIT;
 	iowrite32be(val, bar + HINIC_VF_OP);
 
-	pcie_flr(pdev);
+	ret = pcie_flr(pdev);
 
 	/*
 	 * The device must recapture its Bus and Device Numbers after FLR
 	 * in order generate Completions.  Issue a config write to let the
-	 * device capture this information.
+	 * device capture this information. Note that pcie_flr() can fail
+	 * after the reset is asserted. So, recapture it unconditionally.
 	 */
 	pci_write_config_word(pdev, PCI_VENDOR_ID, 0);
 
@@ -4230,11 +4233,12 @@ static int reset_hinic_vf_dev(struct pci_dev *pdev, bool probe)
 		goto reset_complete;
 
 	pci_warn(pdev, "Reset dev timeout, FLR ack reg: %#010x\n", val);
+	ret = -ETIMEDOUT;
 
 reset_complete:
 	pci_iounmap(pdev, bar);
 
-	return 0;
+	return ret;
 }
 
 static const struct pci_dev_reset_methods pci_dev_reset_methods[] = {
-- 
2.43.0

