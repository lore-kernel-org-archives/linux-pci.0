Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010006.outbound.protection.outlook.com [52.101.85.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F99F4F68D4;
	Fri, 18 Sep 2026 14:58:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.6
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789743488; cv=fail; b=WqLLlBDl3BAbhkRcO5yR+9Zwdx2P4fTjYze0JAYB++IMlJ6t/IbEwVKpoRzNIiVmBMz0nCsa9Z4GwLfV9RZqhOD771kl5b7uutB+z3H3gCXkZ9XbO01hAzFitFZKpNhcV5jzb6Bu7AsM3xbBy8u4/qnQj+cRsJJiV7nZxZmuw9g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789743488; c=relaxed/simple;
	bh=W9RIJR0jgri0yz9Tqq/CmoZcWxa5qyliKAjlfDdIl0c=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AXbucIgbT7KWz/+LQMSuEn4qpR5rZWB09ECtJLjwFlnS1QMeBgUyPfFpat7VQpU+kyJHcM64R89nHV6BCBjjWevPDIiz/Xt6dL2QGhH40VRUq+pXlZf/hpc8g6p91amsRW8RnU2CHwII0CWAhrPV+lIGqn52vqFra6n75V+Z3WE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=2qAKVY6C; arc=fail smtp.client-ip=52.101.85.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="2qAKVY6C"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=a2MwhJynLQhRFhSomMRk/M7Kt1c8+4l36wneR6hHipbGl47PYEi3ZrDtiF3avfntGA0H9SndEe2mMps6THW6DNnKE5lUuoYtkE57v6lpgEUXziXEgBWGmuj2eQIFXpQXKZJBfi0wB8qsZ88fBknI66yumxShOA2pu4R+oSp1heUsDEaY2Tk9Bu+YPfpqWwPRWhfCNkgtRj9Atbwlenj+70E+fgniRUwcJ4o38F/3DRCj6nRePqnLDPMru58sJxbKZDtrQk+yPV+5iWCIL5nijgXiXFQKrwR+MBd01fEl1ZB1iisUv8w5DXsF3G77mFxA0rwyiafmgnqCC9/nvUf6GA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0/EJzjalnDkepYCUht93RhoKicB4bQsIUHJ8ISUjGHg=;
 b=Ugx/aTyiMY9rE+4A0ylrrkYkfRLDOO8LTqZdFXeF5Jf3cfB0AtgjmzIaPa2tOqYniBiwu5rVqYYilyifMg5yXeHBa9PSeimRJIH6RPVhdcyifpDZW941toReDkPvWTAGSaQZ4JPnWZG+ZPUBFWLwB6VY+NJ4qQF/CNc19zpsZH+uryn9j3In1hC4VTfi2/NW6I46RVDvs2MwNnhqWtZuH8xsHKS9QfrhYxGmVL40KCp4WlQHxeU/G+vQnr3yusiG4sovvuSFR7cBVu4sVPG5ZTNlw7bn7NbC7swSt8hODsB4ErlPvElxxiHpgJwxCX/yQLJLuKcrvFAsEeuOo9Fg3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0/EJzjalnDkepYCUht93RhoKicB4bQsIUHJ8ISUjGHg=;
 b=2qAKVY6CTSQru5hlTYf7ZlxC/ZMjcTxUDX2jByfWGOEDN6tBZHb7S+/faTGd0ffcePEuscutCKuIQQqrTYo99mS3uYzrzELjV+u58V/oiIqSsIww6gRooNohJ2JsvJlYTTvsZaldmU10bFqb5ybpsayqbxm4+e1DISm6zHjucQM=
Received: from CH2PR15CA0027.namprd15.prod.outlook.com (2603:10b6:610:51::37)
 by SJ2PR12MB7845.namprd12.prod.outlook.com (2603:10b6:a03:4ce::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.13; Fri, 18 Sep
 2026 14:56:51 +0000
Received: from CH2PEPF00000145.namprd02.prod.outlook.com
 (2603:10b6:610:51:cafe::97) by CH2PR15CA0027.outlook.office365.com
 (2603:10b6:610:51::37) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.428.12 via Frontend Transport; Fri,
 18 Sep 2026 14:56:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH2PEPF00000145.mail.protection.outlook.com (10.167.244.102) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.8 via Frontend Transport; Fri, 18 Sep 2026 14:56:51 +0000
Received: from quartz-7b1chost.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Fri, 18 Sep
 2026 09:56:49 -0500
From: Yazen Ghannam <yazen.ghannam@amd.com>
To: <linux-pci@vger.kernel.org>
CC: <linux-kernel@vger.kernel.org>, <linux-acpi@vger.kernel.org>,
	<linux-edac@vger.kernel.org>, <bhelgaas@google.com>, Yazen Ghannam
	<yazen.ghannam@amd.com>
Subject: [PATCH v2 03/10] PCI/AER: Report the ratelimit interval in milliseconds
Date: Fri, 18 Sep 2026 09:56:11 -0500
Message-ID: <20260918145619.3016889-4-yazen.ghannam@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260918145619.3016889-1-yazen.ghannam@amd.com>
References: <20260918145619.3016889-1-yazen.ghannam@amd.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF00000145:EE_|SJ2PR12MB7845:EE_
X-MS-Office365-Filtering-Correlation-Id: b9fd49b7-030d-49f6-73a3-08df15951290
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700016|82310400026|23010399003|376014|18002099003|22082099003|10067099003|11063799006|56012099006|6133799003;
X-Microsoft-Antispam-Message-Info:
	lOCa0t6IyExMl/6xKlUtz3szGyKhpbQo1KO0AHtjOWxHGU0wremSx7stF+YFrtCEnofbcwkQt6pX0jZllFa2Fr9hRwrjd2NgduHlwWOvFaVAWDsViQkJ6ayPJe8OineGV75g33mPloQX0gtJFjos5f/aXzFQ390RJwO/isPp5srWFJia0axrX2tw+ZxUu7DnuAvoYedF0LGGXhHO5NyDSHDoBlCKdptvGN0WGAOPji1fAlaNWUsIjlpughBkoHtHJppZfen/LzCtINUDkb95N1qiaZIG5oQ/GbpxanL2mX1Q5G7p2+jNgzVZ55saVWZ9w3qOYP8/P66Y6+ENTKQ6j7Ut96KuREy+N4er0EFUzFxJWQqo4nAYRkFcBz26CPbOEHHIOzE/6oWlXVHO6eeaFPwZ1o+K7uLwfl04jVSpLpRxwGM3vxKKiYV9cIw6jyucdNoKoTHY2vRDsRerWTm9SeCNyNH+nKxmwD/34LHGTxxosEnTpxnatuec9kDYyjbT7xCodrL7VNrnYG+cknfh7yYV8MfYcsOEwGC6P28YdZWLUeJW3rpM8pkYALN+gk6SOo4P01u5ruLfqg+jRuL0pEQdzvdTDSCiY8SunY8xSv9ntZ6W1X8dmaX/Em2CRrIRw3bUdSaBX+Xd9knRiD/YqLGm2x0ITlQQRFnNxJTsN0KEplbfMTXtch1mrVDfIeraSofNl9Ppxd5ohE2HcSzI3g==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700016)(82310400026)(23010399003)(376014)(18002099003)(22082099003)(10067099003)(11063799006)(56012099006)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	JkAF3V0h55x9nPHaWaEGu417AwNFMbk/Ee5y7yKqkz4nHWM887Y0a8ozsIhbP1RRe2+8cE3Y7ljAyQ19nZItdkMO6G/zHSqRS+LLUSahzIu0J3P38Aj/GqZMEMc99beYYNvB1Hn28qJDPScPswQiRV+E0TAGq/z8fMF5cg6b15rJPGwhsdmSnrBDa9jz56pGcqhNGuC0z+EB70pqsW+8TKWGx5upUSLNiYJIg7gv0CIbmjdcpATURcFUIJuMiu5zDx7l0LhkiVikMOmkmKMbjVjDXAcn1DdAPVhFwkM9IGBtPvfeSkNzwpt6YMbPEVW0B6RYM246hY4HQwhGtliKS+AMEQqLoZ87a7MmEzpoMjPrL5dW0axCyTUqRZN5kF3ncrBwv1IR1nQcRp/xOhfaJcP2parA0D49+WawXl8BLx9DwO4B2F7fwI3LgxkfD9VK
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2026 14:56:51.5118
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b9fd49b7-030d-49f6-73a3-08df15951290
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF00000145.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7845

The "*_ratelimit_interval_ms" attributes convert on the way in but not on
the way out. The store path runs msecs_to_jiffies() before assigning to
ratelimit_state.interval, and the show path prints that field raw.

The field therefore reads back in jiffies while the attribute name and
the ABI documentation both say milliseconds. The two only agree when
CONFIG_HZ is 1000. With CONFIG_HZ=250 the default reads as 1250 rather
than the documented 5000.

Convert back with jiffies_to_msecs() so the attribute reports the unit
it is named for. msecs_to_jiffies() rounds up, so a written value that
is not a whole number of jiffies reads back rounded up. Document what a
read returns, which the burst attributes beside it already do.

Fixes: b4fe7398def6 ("PCI/AER: Add sysfs attributes for log ratelimits")
Assisted-by: LLM
Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
---
 Documentation/ABI/testing/sysfs-bus-pci-devices-aer | 6 ++++++
 drivers/pci/pcie/aer.c                              | 8 ++++----
 2 files changed, 10 insertions(+), 4 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-bus-pci-devices-aer b/Documentation/ABI/testing/sysfs-bus-pci-devices-aer
index 215cf8bd4c30..732fc03ef5fb 100644
--- a/Documentation/ABI/testing/sysfs-bus-pci-devices-aer
+++ b/Documentation/ABI/testing/sysfs-bus-pci-devices-aer
@@ -135,6 +135,9 @@ Description:	Writing 0, or any negative value, disables AER correctable
 		ratelimit interval in ms. Default is
 		DEFAULT_RATELIMIT_INTERVAL (5000 ms).
 
+		Reading gets the current ratelimit interval in ms, rounded
+		up to a whole jiffy.
+
 What:		/sys/bus/pci/devices/<dev>/aer/correctable_ratelimit_burst
 Date:		May 2025
 KernelVersion:	6.16.0
@@ -156,6 +159,9 @@ Description:	Writing 0, or any negative value, disables AER non-fatal
 		value sets the ratelimit interval in ms. Default is
 		DEFAULT_RATELIMIT_INTERVAL (5000 ms).
 
+		Reading gets the current ratelimit interval in ms, rounded
+		up to a whole jiffy.
+
 What:		/sys/bus/pci/devices/<dev>/aer/nonfatal_ratelimit_burst
 Date:		May 2025
 KernelVersion:	6.16.0
diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
index 350b57e5ccb1..5498fc605556 100644
--- a/drivers/pci/pcie/aer.c
+++ b/drivers/pci/pcie/aer.c
@@ -688,9 +688,9 @@ const struct attribute_group aer_stats_attr_group = {
 };
 
 /*
- * Ratelimit interval
+ * Ratelimit interval, in milliseconds
  * <=0: disabled with ratelimit.interval = 0
- * >0: enabled with ratelimit.interval in ms
+ * >0: enabled, ratelimit.interval held in jiffies
  */
 #define aer_ratelimit_interval_attr(name, ratelimit)			\
 	static ssize_t							\
@@ -698,9 +698,9 @@ const struct attribute_group aer_stats_attr_group = {
 					 char *buf)			\
 	{								\
 		struct pci_dev *pdev = to_pci_dev(dev);			\
+		unsigned long iv = pdev->aer_info->ratelimit.interval;	\
 									\
-		return sysfs_emit(buf, "%d\n",				\
-				  pdev->aer_info->ratelimit.interval);	\
+		return sysfs_emit(buf, "%u\n", jiffies_to_msecs(iv));	\
 	}								\
 									\
 	static ssize_t							\
-- 
2.43.0

