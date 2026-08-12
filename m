Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011013.outbound.protection.outlook.com [40.107.208.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E88533955D8;
	Wed, 12 Aug 2026 04:53:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786510422; cv=fail; b=j91MznhMQZ8ZuJ8LqDDDs8m5r/17UN0lDiGJeg2u6nBS8Rt5Tyvd9AzUuGzqNq42RMArgDxhpq0lcunS86gda1Mqtnoczx+tPjjfTk+nM3bAgjtn0qsLiPfk0pRc3mLaTXHRfqbzzS1KUxvs2hCGp48Wjka9GVqTr5LJkaDbGEk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786510422; c=relaxed/simple;
	bh=O+0b/LFbL4vkcaEa6o/mbU+dsZQP0xfYCiuNbUaPgGM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=KailM30keQgBfYbOVeXO6zxYZ56WnLh3v2iYF9C9ZnSUYS3HuQJRw6tl0ewKRe4rrnf+kmR13tAHuAUvsjvK2u3vgIce6UJtKQtl9KSUbRSCEsJC+JooaChV4kZW6KSZwaE2XBqYiMZqA6RDinUwTSGTat3AWxy7rJdrV8Xza9s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=QiuVbwIu; arc=fail smtp.client-ip=40.107.208.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="QiuVbwIu"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=V10R7mGwsBBBNqnlBkM3tgCErfXEQsyLzcsHiZYQ4jwOLE5Zp2y7UwDv+TklPeBsvKdW6uoJJgr3XC37p/HVZiEEEv0eL28/itaOQWJJaw1qqlvtBzAr6Wu1EPLEQCxoTh6qdbF2PzOfHbuFarZfUZKYcXAIY8O86IwgdmHWJ0MQIGRsNWn5GwfLAk4MebQrc1MMbO/5bnYR2XcU5Vfr72m5yvTApO8dSIWJ6wKV5Yj35AKsYU73yF21OOhcMLGxB1lPJuJwQi9jyGd9sUTuX3gSvjgUEv6TS/8SmeM0zQwiIdyk4lhZ31EaDi5LyrmY6QJioNkKN2lZPAI+ZYhYiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qBjpiYPgcC60JV9uFHW8Xlv2k4mJnIPGbyzcMEC3Gjw=;
 b=qr6vIfLvEbyi6UNVrGkxAmGQpdXRIpU2TmV8ZsycbzMNgQPb1PwLBBBjd0wXGI+/TKlUH0ZfLbYpc/AUc8h+BKF3F0eZytRyQDlstqxP3NgCdDpo7bnPGEpJKBkty7/7gShashR3UUWwtiGO5dLa5X9MnqbouTzayYXuhltTJParGOBEv7+E6DvjeHliEPivN5A+YN2HzLMkk211wTAAfnMRYtrt7+BLvv6oZaUh7bPsbThfZe+juslMt1P8VSuoKAbB4e2iZ5362r2JhOoqDDvHBCxN/ixOVd7RVCsvhJtjzsvrdZPq/VpdqfzVe8cMc67cvp8YjwbDBk56Z/kvDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qBjpiYPgcC60JV9uFHW8Xlv2k4mJnIPGbyzcMEC3Gjw=;
 b=QiuVbwIuqi6nztL33VrMQZdOxTHQhqtU1pC0Xi8llhVpBrAPWE9Uik1A3I0tz2DZN+uFg81Il9GwWWxa5IwvpL6+cpoJmWpbi5W359RZkPfWmRwgzBtpx5UyuMOCFONyiJIS8rLhGV5g0X74EDH1I1TadROl34EJvHpHloTIhkOnAai8np4fKcIiYHY7FctkGvO8zI837mgtACp8NsrNDuTg0u6xvUUgRHGwAwEA9WsCM1gGY9vV8GnC/KzN1HKcZe7Ys/XcN2j8HLvm1QJs0JGjIUQF90q/TQr43tgRmDopHk0D5kwCyAwd2bHgZPB3B4rJP6CYSW4edDSlwHHNcQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV3PR12MB9411.namprd12.prod.outlook.com (2603:10b6:408:215::20)
 by DS4PR12MB9748.namprd12.prod.outlook.com (2603:10b6:8:29e::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.12; Wed, 12 Aug
 2026 04:53:31 +0000
Received: from LV3PR12MB9411.namprd12.prod.outlook.com
 ([fe80::98b7:86de:b69:2a15]) by LV3PR12MB9411.namprd12.prod.outlook.com
 ([fe80::98b7:86de:b69:2a15%6]) with mapi id 15.21.0315.011; Wed, 12 Aug 2026
 04:53:31 +0000
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
Subject: [RFC PATCH 3/5] vfio/pci: Refuse to reset an SR-IOV PF with enabled VFs
Date: Tue, 11 Aug 2026 22:53:21 -0600
Message-ID: <20260812045325.2733631-4-alex.williamson@nvidia.com>
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
X-MS-Office365-Filtering-Correlation-Id: 45ac1bb8-ad03-48ce-4189-08def82da7db
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|1800799024|366016|10067099003|56012099006|5023799004|11063799006|18002099003|22082099003|3023799007;
X-Microsoft-Antispam-Message-Info:
	/QYFWlb10lyPT7ROc/1y32jd/RvylWNuWLWpkj9n1i3MfWfVqIUEeh3gbKJ5hAgsjTx6cq2K2ma8qVrzzXGiH8JZuos3kpKx2EV4dioW3/xZeVsJPxOCgm93Gzqq8AkELf9V9V9Lu5QD/jpyLPmk1JYv5VGlGp+eBtLQA+E3hipLPp6n/2gkh6RG7WN4+Ho6PQOEl+HpNrSqC+2mnMVmPqWdBlxvLAByd9syHwH0ED4RXYdvGukDMHrLqfVhVSST11jbl9pcy6zyihbdZOXcYh5kd1jLo02WvHm7ZqoiH2hOmZnYawOsLSEcwwj2BbCHiXPOH2vIGkCIxjYTWev+PNxnFXZQaL7zTay0lqYtdrfSfPkWBkJuUNXu8CISdCMOTTGKIMRUoffyHeoXTsj1eLBuWtqHtJz8uub9SoCtj2pEC2ptfXD/aVd9mr09iCfOTeRdZ0e2H6CPWyAlncDaisQZ/8BAix/cnVmZp6yMBiUcYr9H0jI79ts+aTKsr0HVCmWeg1+HAYPXPdafi/pobp6zwzlGjR4eNJfmuX77EcNOkPKczvf76uf53q6sW/b7lpQw1KUInvFW1NqzNYs5xtzzUqkcWlhh06bAtoPB2aQSWa6Vh845P7Kj58vG8PCIfbyN7ZpIfkimbOWHt535s4yfjVP5HxrkG2mE2f32d+0=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9411.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(10067099003)(56012099006)(5023799004)(11063799006)(18002099003)(22082099003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?fKo7coqcFwHNdVB0Q7HMNOcKSwFnE+WJoifzo2pTZFu11r5oXzVRNGbaRL75?=
 =?us-ascii?Q?1mWV1Qi/rvFu5g4qDaZELzACOwpKNvw/C89ezD+DOhiBcPMaoRgEOzMaQ92x?=
 =?us-ascii?Q?POSq+hCQCZf4x8QFcdQiGWLkR56HU4fp/R8rFU95PG15d5G54jp5W99dfhaO?=
 =?us-ascii?Q?Vr4fpVr3LyNZZK/Gl1Hf/frlfqrSstsVXC8INsop0k6qUFNv2Vl0jYTDPWaO?=
 =?us-ascii?Q?y8qJS8cwJbuzUFIBPuCxE1nU7qXA5nouTcjrLeKjCVN1PH3O9mqW4ttWSx82?=
 =?us-ascii?Q?JlT/1GWbqUk6ukYMMbWX8v3cCkr/J5GIg85smX9tAVr9ox64FWBNoUtU7rXz?=
 =?us-ascii?Q?EEhYhiwBjaVJc0jxvnmNBGs2G6Im5KdJsBQv/DBOMMSxxRo2h9Z4+8qYoaQx?=
 =?us-ascii?Q?EOLp3EuEYn8Mc3+m6uS1R0nenEJn0GoP/Yn+HUS+nsPMPpAhagSjzwQ9ORMP?=
 =?us-ascii?Q?OE2MnnHB6q+N80oK08NA9JRnU960+5UyGbnosaM9mfGEoJqdXYGfcRRTXkmX?=
 =?us-ascii?Q?uDg859Cc+3QqVB/QhYDToH6IozeJJpBd7Ol8kXrGBNo3L+v++2cIuwniA4wj?=
 =?us-ascii?Q?/f4rEXhdp/+O7v3BA/XOyeDZZe7BHksVPXe7YtaxvCdT37MKTJ9kZdIvPx0K?=
 =?us-ascii?Q?i2NJKIrY6vPZAr7Qj7nu93opaoXaTBUzSH837dn22lpBGAaeSgePdxoUDHgR?=
 =?us-ascii?Q?piLwwI8BrCFLU8uZa+jAfsRtCS9JiPRUQxQh1JWhC9SHwmUFTWA5h2eHQiGl?=
 =?us-ascii?Q?nMq1KgFabzKxreHjWIuCGhcBJ0LacQ5n2jvgI9EEaedP5vw899nOXR68TXhC?=
 =?us-ascii?Q?ZFKfOhUzEVghuVsTUr1erjLfCCnbxI4MF8uYw2NiYpRhwF3zEuMth13Q8FeG?=
 =?us-ascii?Q?lz34tzzhqPd9NynBgtX4ID6WvkATDdrNUy680UuoCu2s2ITYjua2GIjognOZ?=
 =?us-ascii?Q?qv8hPQdTN45SQtCZi9aae1B3LEpChxeh4V3tbl9b1Sl+R6cNajscZWWHWbT3?=
 =?us-ascii?Q?AhzmIOZgA4H5QOlmAGGD81vuRCpqnhvTnQ4wraVKHk5znB8fiDhUsgpBduLI?=
 =?us-ascii?Q?0BpSErgOhLsSTIMWaVgfEfytrrarR6Ld+gcVZ0aMtRiqRbbMq+epdvbhgUYg?=
 =?us-ascii?Q?M6j64g36lORIBkgl10Q94t0mkKRDVpWB5OtqPC8hdjWUxRBZboqZxFcFArJn?=
 =?us-ascii?Q?o3shuFsh5f0bxHCUq6M7cBO24t5IRWhdJKrYo4m/nyUuqPDUReDU6vS3MHMN?=
 =?us-ascii?Q?LSufR2wC5mwYDYxdsHiJdtfujGe2/nU1r6CvzWyja984n+HE0V8B0VN4sTH4?=
 =?us-ascii?Q?G9w3Woih9lVc3iNOg+y7EY/cjnVJ/QGO1RMxlbM3wQTagFNDnTZS4w2E+IU+?=
 =?us-ascii?Q?SwzAfEdwQCZIW824UV8WDm9D+Wr4aErxuesuY/nF/MgDNBvezcyNGuOl4F/q?=
 =?us-ascii?Q?uKlbyW9udY6FsWyZMjS3S8twz4u1mqz3twqxT/KLjDqF+pJJfsyy/ySXQZxf?=
 =?us-ascii?Q?Q3oqggyaFAUogpiItbYSB/ZAEkdDvz2D6dimbIs4RD94PSDHRoHBL4C4JQlN?=
 =?us-ascii?Q?ovA6Ezdj16zcbHmTPA1l4gvGZ/YFXlSNB+OTt2BX472ZrxPuN63SHHYfIMZe?=
 =?us-ascii?Q?FjEMHUW6grpS4mqNJ7uy40wUsIdMOaa6dxc/QgR8NdV79HSwu3gg5DJaBUhY?=
 =?us-ascii?Q?quu/imxz3giF9r+ieN7bmFtWWZ615uZzocUBTrH3y5u9U3QJOWYxU4nOwmFi?=
 =?us-ascii?Q?3M82pOjcsA=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 45ac1bb8-ad03-48ce-4189-08def82da7db
X-MS-Exchange-CrossTenant-AuthSource: LV3PR12MB9411.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2026 04:53:30.8165
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: R1RNw5UxHN1IYMNjPzdRF/Yfuq8dulTdIxFJrGQEbZdO1w/S3F5PSNSQTinSLI4rdVUjouTjnH83yy1D6LXJDA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR12MB9748

The vfio-pci hot-reset interface VFIO_DEVICE_PCI_HOT_RESET does not
take into account whether an SR-IOV PF has active VFs.  The VFs appear
on a virtual bus, which is not enumerated in collecting affected
devices.

Move the burden to the user when active VFs are present, require that
there are no VFs present on SR-IOV capable PFs in order to conduct a
hot reset.

Fixes: 137e5531351d ("vfio/pci: Add sriov_configure support")
Cc: stable@vger.kernel.org
Assisted-by: Claude:claude-opus-4-8
Signed-off-by: Alex Williamson <alex.williamson@nvidia.com>
---
 drivers/vfio/pci/vfio_pci_core.c | 15 +++++++++++++--
 include/uapi/linux/vfio.h        |  3 +++
 2 files changed, 16 insertions(+), 2 deletions(-)

diff --git a/drivers/vfio/pci/vfio_pci_core.c b/drivers/vfio/pci/vfio_pci_core.c
index 9757b171791c..956a05ca12e5 100644
--- a/drivers/vfio/pci/vfio_pci_core.c
+++ b/drivers/vfio/pci/vfio_pci_core.c
@@ -894,6 +894,17 @@ static int vfio_pci_count_devs(struct pci_dev *pdev, void *data)
 	return 0;
 }
 
+/*
+ * PCI walk callback to check for SR-IOV PFs with active VFs.  VFs are not
+ * enumerated when determining affected devices and may be owned by separate
+ * userspace processes from the PF.  It's therefore the user's responsibility
+ * to teardown VFs for any affected PF before performing a hot-reset.
+ */
+static int vfio_pci_dev_has_vfs(struct pci_dev *pdev, void *data)
+{
+	return pci_num_vf(pdev) ? -EBUSY : 0;
+}
+
 struct vfio_pci_fill_info {
 	struct vfio_device *vdev;
 	struct vfio_pci_dependent_device *devices;
@@ -2598,7 +2609,7 @@ static int vfio_pci_dev_set_hot_reset(struct vfio_device_set *dev_set,
 	list_for_each_entry(vdev, &dev_set->device_list, vdev.dev_set_list)
 		vfio_pci_set_power_state(vdev, PCI_D0);
 
-	ret = pci_reset_bus(pdev);
+	ret = pci_reset_bus_cond(pdev, vfio_pci_dev_has_vfs, NULL);
 
 	vdev = list_last_entry(&dev_set->device_list,
 			       struct vfio_pci_core_device, vdev.dev_set_list);
@@ -2661,7 +2672,7 @@ static void vfio_pci_dev_set_try_reset(struct vfio_device_set *dev_set)
 	if (vfio_pci_dev_set_pm_runtime_get(dev_set))
 		return;
 
-	if (!pci_reset_bus(pdev))
+	if (!pci_reset_bus_cond(pdev, vfio_pci_dev_has_vfs, NULL))
 		reset_done = true;
 
 	list_for_each_entry(cur, &dev_set->device_list, vdev.dev_set_list) {
diff --git a/include/uapi/linux/vfio.h b/include/uapi/linux/vfio.h
index 5de618a3a5ee..8603959f1735 100644
--- a/include/uapi/linux/vfio.h
+++ b/include/uapi/linux/vfio.h
@@ -772,6 +772,9 @@ struct vfio_pci_hot_reset_info {
  * Mixed usage of legacy groups and cdevs across the set of affected
  * devices is not supported.
  *
+ * Hot reset of SR-IOV PFs with active VFs is not supported, SR-IOV
+ * should first be disabled on any affected PF.
+ *
  * Return: 0 on success, -errno on failure.
  */
 struct vfio_pci_hot_reset {
-- 
2.53.0

