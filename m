Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011013.outbound.protection.outlook.com [40.107.208.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93DF92989B5;
	Wed, 12 Aug 2026 04:53:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786510414; cv=fail; b=XhGNPK/Qyddm0dVqKOTfg38HtNbxlVIq6DdT/QXLXy5+IPH6O2NgFDEY+jBCUOckhj0NNzfjEIxaUJr+vnXlfGVle3Y4yVKWjCwfPoRoP9lZpNXQZwyu5dejkClg6+7+8lsvnb6skTL5Sjzel5DzTZ4f7TQJnA/eZSK2rSt13UE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786510414; c=relaxed/simple;
	bh=TsdEwwLRnetNXrxxHLjV6oxe91UZ3BdtVQ1muxrxUWM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=BYo7xII+igb3QUHassPxqodQm9in4UUlC2kPltdb77P4iexLdHS1rCExhgJxs8VWirbnSw/iyA1HMUVCjOBUhP3B1F0ZWYIBBDlWrYO5VSvTw3CxbtwLd1rOH0NC3LwJQ8QNpPFMUyAjvI813/p7faWlREEUyQLj/44vp1/2a4s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=hqnSlZ8F; arc=fail smtp.client-ip=40.107.208.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="hqnSlZ8F"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=o2OZLamUecQ6Q1L77OUe5y0MSlIrVX7+ol7ft8mm6IYKNlsO6sP1VHpaVY1eorh5fQr3Q1iIuxe4UevyiSarFwYZQyyAeiflfSb17UYOK+O7X1WM58bwUnu8btyv9y+oVJuD70MnfzQJ8xJMTau7RgPjs8yKrK1XnvXyV3clnJcXMUciQS6fD0DuvbcRlhhQWZZQ7h+ZdrUneyQu27s2xPYCerY9D4UqnlK6jSR5CVbY9dlyx4AtyTiR0MepSdartck11b7TMlB8geRnqlGeP9NH8E0JVKIeyJPgS2H+F1Nb9+IfXhC/sNkuihHxKx8ltDcHA27BqQ4E5SVv4PXRmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rj1PXGHttc9LiMPCujzdPnnftpQ2KDBKQFntTeZtVN4=;
 b=tlGFCkH3T2wWB+2/w0e0k20dQ0q23eUUcZgqxsLp2P9N9FkpKBZu64QHERg564zq+Rg+QYYpuWlhi0H4GDPvTu7d78xKBWdeYSnv9OPcGAhKrp9h+fUlu0M9gVO5A18gsw+CDPV4FS6InMWxPodRdjQUumkKtknkopVFXmcKqInex7ro5cN0/HYBocN6dV+V5SpbWHP3WBsX6udRI20d984Els7EpSvbzbVO/rjGIEu+msY7n28WkqL/MwGOFLTwsu7p62i0PrQNCphuDQ1FTXaliRaS8jLNdntVIwcb06eBdl+diSup3a1X4yHvBASLewKdVgCSbyDfD1UkHGx8jQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rj1PXGHttc9LiMPCujzdPnnftpQ2KDBKQFntTeZtVN4=;
 b=hqnSlZ8FdX8sA/jcBzYnQzbQxWVVHOprQjLioyb3XaI6nOSyis9epBc9edRbdNI7FZESitE/00t94Pm2YwXIPwE4oP7gEPEQi97tDcePm4vN42YUX1Z/+g89Aocg9Y+ZrO7hdSENC2DcJ/IBDyRzJq1REkGcTwTlj5kvxMXNWD3IVz16gFtEoQdhDLqgqwo26rJbshiiFoQGMn2a3Af/XfQTtIty1sSnyX9y+P8OlAnsPAe1BSXrOTL8xqDwuqSLVIlsqcV2As/VyxUPQcgSbowQTQwZUu2lfpCZQ+XukEvN9TCzL15u0oH0qdy2J43DadFOBex7iKE3HwLLIIRf5A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV3PR12MB9411.namprd12.prod.outlook.com (2603:10b6:408:215::20)
 by DS4PR12MB9748.namprd12.prod.outlook.com (2603:10b6:8:29e::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.12; Wed, 12 Aug
 2026 04:53:28 +0000
Received: from LV3PR12MB9411.namprd12.prod.outlook.com
 ([fe80::98b7:86de:b69:2a15]) by LV3PR12MB9411.namprd12.prod.outlook.com
 ([fe80::98b7:86de:b69:2a15%6]) with mapi id 15.21.0315.011; Wed, 12 Aug 2026
 04:53:28 +0000
From: Alex Williamson <alex.williamson@nvidia.com>
To: kvm <kvm@vger.kernel.org>,
	Alex Williamson <alex@shazbot.org>
Cc: Alex Williamson <alex.williamson@nvidia.com>,
	skhawaja@google.com,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Kevin Tian <kevin.tian@intel.com>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	linux-pci <linux-pci@vger.kernel.org>
Subject: [RFC PATCH 1/5] PCI: Refuse function reset of an SR-IOV PF with enabled VFs
Date: Tue, 11 Aug 2026 22:53:19 -0600
Message-ID: <20260812045325.2733631-2-alex.williamson@nvidia.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260812045325.2733631-1-alex.williamson@nvidia.com>
References: <20260812045325.2733631-1-alex.williamson@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SA1P222CA0078.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:2c1::25) To LV3PR12MB9411.namprd12.prod.outlook.com
 (2603:10b6:408:215::20)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR12MB9411:EE_|DS4PR12MB9748:EE_
X-MS-Office365-Filtering-Correlation-Id: 1e026254-9c41-4d78-1008-08def82da678
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|1800799024|366016|6133799003|10067099003|56012099006|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	n3kkMsvsvLZJEn8g3WpT+sPwxdmGYt+k+iJLw5Yvd8KUz1yU3LpdOFMTH97EKyK49TORgs9siF33lNioL9YNgQz1FBTQl/BCQMyjLc97TrcooVJZUhFUOeZktwsquG0pmup+9sn3P4ylLLMRIWaHKhzOCZhXADCye08wAWOlHE500yG8iNOLpHEWTkoq3cicOdMEA/bI4qWObPJlVWBjFsGL4KdA7mRAd9nBG5qVO/k48uPKpZhfQwgYtNdnH2vjTnT8K0RRG642kP3tBAJSE+WfqGFKMl9R9zoKrNAxTE0ZIHDMIBS9Xjj20AcEq1+IOQCtCRDBFomIhBB0Ux+W3OSGafmzQtgjPmBXVDtHb3R6RbYdXzswl2afdvWITDCIFnGf5cP4FoSarOYP5xSuQK9jz2BMZa1Z5xyCXNlJkLxbaZfNQ4ytuvLDk+AS8XmFXH8zVuFOxt8VqaYphjGPgCwYHf7rtQsiphj6TFTPFH+gaR1aoQ1b7RYB94ggKBf3mY/e5Dkm4TLCmItWzCKifuzHJ6i/HWRAoAyI5IU3J3qbM4jNRaC1p6lGfgIvE4Qsq6BiihTGbfTYw04dA6H08gHJ0OvWYioB05xDzywc451pIKrX7LvMknosgJrYIc/towz5gxqmlCAUeJcOvscQNpnQ7G3l+yD8hXxGSLWoBYc=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9411.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(6133799003)(10067099003)(56012099006)(11063799006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?uAv2dh+8cIjlBFqF/sba6a1a57aSGNMBB9Gt1BnrOobUoWDE8HddEuXyYDSf?=
 =?us-ascii?Q?Fq2niFh89lKZXhY8xQ6BOBgjEQIh/gk+7j5GBcrj9KEavZ/JKRYpCmJLaN/s?=
 =?us-ascii?Q?x8WPXTUcrK1QtSc+QKFAyLeP1+Hv2SMVchjvYEbRawyNaA9udM0ecG5Tro/R?=
 =?us-ascii?Q?EWijjSKMtp5PYoTrmEa+dVgj0f5ws5cT7Q6AVzUmVuJHjRuijbRY1MIM7Lwi?=
 =?us-ascii?Q?hm1+6hp86b2qPj+6g4CBi/GcOgrId6OQzUzv8ZQJPXMj15ubeeVNrzApWIaD?=
 =?us-ascii?Q?VqfEc0u3QSBDcdOwOr0YGwGjMs6tCHcyYhFYxf7s5+Iq25yBW+nnROp5hoDC?=
 =?us-ascii?Q?sLxWFX3Bh7svH4RvyePSHHEaucnu0RCRwZrdKfO0M4rdr8KdzxEaBYFL9/5+?=
 =?us-ascii?Q?mieb4TKpcHtx/We1mBJA4ynwCq/yz2nvhqXPd9OMp6K9MIiag1k28WhiwLuQ?=
 =?us-ascii?Q?w1k0SL4osfu34tP2DeP9lvEZfVuyWk/1pDfhb1hJCARSMojZxp6a18Jxod0I?=
 =?us-ascii?Q?PfcxuP9UqpNAD15C14TGVkITBir6DjiMEmC0wVW39oUCrEl9Y5nnbwg+7Yjr?=
 =?us-ascii?Q?ZAIFLqPvkS3AysS7FH75xvlKGCgU2sQz3PiWrKhVCW4pwRK/uhQvnvhnZF7g?=
 =?us-ascii?Q?s4ZlyQHnqLe0xCUn/16LWERbUwWEhjL3n5sizTeK+celW6hrB+Q+6+4Exp06?=
 =?us-ascii?Q?2+1VZu5VORtqWCEACM4A2NMIintV4ZwFp4bJfZwE4s2RWYG8SQyTgpWxWYQ9?=
 =?us-ascii?Q?p6qmhB4eCxbd8HEAGNtXD5C1OkZjx72cXsci10fBBlUQFOaMyKErTYg8+QxZ?=
 =?us-ascii?Q?iC5ubBMRsFFEZUbEupp9PJRGANaT69vMV2R4ryslcCZCz12UiDy/wkWjn1YS?=
 =?us-ascii?Q?LGX1DS2d6iPLfGu0wGJaxr7jhPARzawV3oiaIY46zthUu+RD9/4TzSxEa1Lp?=
 =?us-ascii?Q?RG6lJ5MIkAg+lrMGR4EqI9MuXICbg2E1NmtxygvU801MjRTV67X4h6W0GdRn?=
 =?us-ascii?Q?g9xUNRbTzXBkr8mP3k3qcmMVZhdEpRUJZ6OIKUzMjRQOwn7SwnvwT6BNZFbN?=
 =?us-ascii?Q?fHZToe/HSPSi75BDFL3yd4SNod5Fh4i9OZsWPlqDTkzioO51xmhbE50pOvcm?=
 =?us-ascii?Q?nxQRegj2wJD8dMnMifHfNZgugSGaApeIyyLvsKKwi9t3qfFXmjBR57fPqbnB?=
 =?us-ascii?Q?4A99XqqFMgtuhK+nUNGS9YSPNzrMqiRLySt5ArvmmauzaNHT6BLRZleG/0ca?=
 =?us-ascii?Q?oW9XuoKGcyX2wlBVWCht1ww0e/lXijKB43jSJqyhlBZEzTnATFEnluW6QRQI?=
 =?us-ascii?Q?OmvYNpXM6vyEr+QHbN7Yx8zhLJ2d42X+f6amCQ+gjcbyLRrLmr8IcF+MoxiR?=
 =?us-ascii?Q?l+HbXzqyOvN1DfDei6JLjuCnqy9lN98eJXTlN/axRoounPxTERjVx9wFCage?=
 =?us-ascii?Q?6donseFEzLbrENQe1oGnJPTdU+cscokAlKJRIZpeN2J5nioOBKz6oI7vT0A2?=
 =?us-ascii?Q?EbsdHkmbyWA2FwWTQRsXb6ggd828O37LKrwAcZqrzizjeuSSRtqSAaeauwvr?=
 =?us-ascii?Q?6kt9ay07y8xt56sUhnWD3pJvHlkw6dh8pK8jsPGctHes/luulAP1bglFZZhv?=
 =?us-ascii?Q?mN83FOJ42bH6r+OCVBfmJiscKRhGBzj3mM4trLk/KOJi+VrB43h043Dj0GnX?=
 =?us-ascii?Q?AKN/5DTX1J60nJ9tw2d9i76dgqfNi0bWaYtkPv+TE2tKv+o/AMEZlLIZHKad?=
 =?us-ascii?Q?K2ao4aQ4GA=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e026254-9c41-4d78-1008-08def82da678
X-MS-Exchange-CrossTenant-AuthSource: LV3PR12MB9411.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2026 04:53:28.4710
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: y9BUWJCQUtr2CNKu6f9JeYfxxedjupPaKcA77Sb61Ln/sEUWYKQGhpcs+MFavFzCHkDXIf9kSj9Sxhl8Mlr9PA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR12MB9748

pci_reset_function() and its locked and try variants are intended to
provide a function-scoped reset.  The bus and slot methods supporting
this interface refuse when sibling or subordinate devices are present.
SR-IOV VFs however, are not currently considered in this scope.

Correct this oversight by testing for non-zero VF count in calls
through the pci_reset_function() interfaces.  This test needs to occur
under device_lock to avoid races with .sriov_configure.  It should
also occur before pci_dev_save_and_disable() to avoid calling
potentially destructive reset hooks.  Tests are therefore added
to each of pci_reset_function(), pci_reset_function_locked(), and
pci_try_reset_function().

The __pci_reset_function_locked() interface remains a low-level
primitive depending on the caller to perform such tests as necessary.
The vfio_pci_core use case of __pci_reset_function_locked() is pulled
through with this test.  Other use cases, such as xen-pciback, that
don't obviously support or prevent binding to SR-IOV enabled PFs will
need to decide whether VFs are possible and can be preserved.
Additionally, direct callers of sriov_enable() that do not hold
device_lock (lpfc) are considered a preexisting, non-compliance issue.

Fixes: dd7cc44d0bce ("PCI: add SR-IOV API for Physical Function driver")
Cc: stable@vger.kernel.org
Assisted-by: Claude:claude-opus-4-8
Signed-off-by: Alex Williamson <alex.williamson@nvidia.com>
---
 drivers/pci/pci.c                | 19 +++++++++++++++++++
 drivers/vfio/pci/vfio_pci_core.c |  4 +++-
 2 files changed, 22 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 77b17b13ee61..b40b00c0c0c9 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -5222,11 +5222,22 @@ int pci_reset_function(struct pci_dev *dev)
 		pci_dev_lock(bridge);
 
 	pci_dev_lock(dev);
+
+	/*
+	 * Reset of an SR-IOV PF necessarily resets any active VFs.  Such resets are
+	 * beyond the scope advertised for pci_reset_function() and variants, refuse.
+	 */
+	if (pci_num_vf(dev) > 0) {
+		rc = -ENOTTY;
+		goto unlock;
+	}
+
 	pci_dev_save_and_disable(dev);
 
 	rc = __pci_reset_function_locked(dev);
 
 	pci_dev_restore(dev);
+unlock:
 	pci_dev_unlock(dev);
 
 	if (bridge)
@@ -5264,6 +5275,9 @@ int pci_reset_function_locked(struct pci_dev *dev)
 	if (!pci_reset_supported(dev))
 		return -ENOTTY;
 
+	if (pci_num_vf(dev) > 0)
+		return -ENOTTY;
+
 	pci_dev_save_and_disable(dev);
 
 	rc = __pci_reset_function_locked(dev);
@@ -5290,6 +5304,11 @@ int pci_try_reset_function(struct pci_dev *dev)
 	if (!pci_dev_trylock(dev))
 		return -EAGAIN;
 
+	if (pci_num_vf(dev) > 0) {
+		pci_dev_unlock(dev);
+		return -ENOTTY;
+	}
+
 	pci_dev_save_and_disable(dev);
 	rc = __pci_reset_function_locked(dev);
 	pci_dev_restore(dev);
diff --git a/drivers/vfio/pci/vfio_pci_core.c b/drivers/vfio/pci/vfio_pci_core.c
index 3f11a9624b9c..9757b171791c 100644
--- a/drivers/vfio/pci/vfio_pci_core.c
+++ b/drivers/vfio/pci/vfio_pci_core.c
@@ -790,7 +790,9 @@ void vfio_pci_core_disable(struct vfio_pci_core_device *vdev)
 		if (bridge && !pci_dev_trylock(bridge))
 			goto out_restore_state;
 		if (pci_dev_trylock(pdev)) {
-			if (!__pci_reset_function_locked(pdev))
+			/* Enforce function scope under lock for SR-IOV PFs */
+			if (!pci_num_vf(pdev) &&
+			    !__pci_reset_function_locked(pdev))
 				vdev->needs_reset = false;
 			pci_dev_unlock(pdev);
 		}
-- 
2.53.0

