Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011012.outbound.protection.outlook.com [40.93.194.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9238F1E0DE8;
	Thu, 13 Aug 2026 09:41:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786614080; cv=fail; b=H8ljzbHnT+vzDbcdYHvUCwvDFW2T4BkKMkPqo0nvkYYnCmqI6TKL+JsmZo+fPcB+lmNuOrQ+1MP9IzubyAfYDsVXGA0wjG0JOioNjUzxcQr8MMnKL1YTC72AKnbZ4C9G3UKcpwug2Gds7AH0zMxrVx9UHJNHeF2+zhdlyx8HJfE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786614080; c=relaxed/simple;
	bh=TFDV3IfRtqzxTcpel3wbnhoeE9e2wEV28GfDIZ9Mbb4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AMOxSohuSZRovfub68DIhAIQNzlYEvkUmjScoRaBcCzQrKEFBWztfP/Mb3u7KM0ALC8s64QyRWLCQOEJyftokdyV7STBxtDOYlFOjlcIZN2+8bwFhJIJITZI36iOFPf6cDWBiSXO/FP08lVZ3uuaNBQXpks2wAHIJr8bIrLiCyU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=FXmt3jS0; arc=fail smtp.client-ip=40.93.194.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="FXmt3jS0"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kuLsdy7jBtGutQOdZvXuinxgzF2OvAa5v+e4Wg+rQ3Df0GBDScG/biudjwtpKmuEtI6fHf6HWByx0gfx+MwMClmNxXw2u2+qzuKNEaP8FVrU5nXbMdmhIXKGD6EPBEz+d9N6Z8wCFpMbhOF2WuUSzf/BzuOU2q1FzoaAENrOcj+wtDRHxymKSib5PcvYGWtACm7JuvHAUoDN6PZ2dlPVvO8hXfudTOJucPxgVOdQ1SLtL1gHRZIHVVYLs9MK4nGgaBUONc+nlptk3Mtxtte2uR8hPZTMcI/3FXAdtQfMBJhxDtEck3w3ydkzEjH69OoTCf2HIoITO/aPzLBF+ABHbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DCFfXWQC1bmApmPIFs+wx/nSnWN2/Bw6dlOHnMcpwMk=;
 b=MxmQ0f9PEGMDnQ1VW0LVwjXCMuKW+ENXg2XRlVelHebYhZ+clYlIXhMdu1wzqUONsgswiJsCO5ms4TozLGdhXd6eApMM+11qvPgMm7EZ+tyuPWRCV3QdrrE04xuVxQpgK0MHii6nwz8gZWuiiGEhgDWdRNK+sjtaSw2S5lRbk8mRTtwGgxdBrOVbA7o48PRW5J1zzbl7WrYU1wdA7yMvFgYEgYlrXInyuvg768qe3PP9ADwWQBBNUy0ULz0KcJ8E6V6mgfmhfYxDyrRKJIkhz77l5OA39Nnf1BA+2wK8VSCwwobWu/PIEGxVIcLdfzeaoHiOOtb/pfZALG17pL3hTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=shazbot.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DCFfXWQC1bmApmPIFs+wx/nSnWN2/Bw6dlOHnMcpwMk=;
 b=FXmt3jS0KJRE1R5s+8AM9cQyraBnZ87kH6uuxoiLhfO5gLn0IMlGKoS/MAvcrGWEeY4gW55sjtHjg8fZRB9dYzpRou44LNFg4Te11UynhF8ryHti1FLA3cSvyZeKagK6m6pp2ebxGKqKXLMIq2nS1qAMXSn6EBmUHIJhPoZ4T+GCXviFFI4GO/nokICobl3rI2AYcZC0BEYCF3if5NXf9+SJk8yFM1a/Xbu6v9899HPXSINCPuRTZ5CD+w2sEFPs/uqZsXxjLkS48eOePPXaX9CeEWDhz87cMMatBDEjrkj17vgOJK1ivFDX+jw1EoLiakYm5w5BS5t8BiJoNqsFIA==
Received: from BN9P220CA0016.NAMP220.PROD.OUTLOOK.COM (2603:10b6:408:13e::21)
 by CH3PR12MB8484.namprd12.prod.outlook.com (2603:10b6:610:158::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.14; Thu, 13 Aug
 2026 09:41:10 +0000
Received: from BN1PEPF0000468C.namprd05.prod.outlook.com
 (2603:10b6:408:13e:cafe::1f) by BN9P220CA0016.outlook.office365.com
 (2603:10b6:408:13e::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.315.14 via Frontend Transport; Thu,
 13 Aug 2026 09:41:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN1PEPF0000468C.mail.protection.outlook.com (10.167.243.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.339.3 via Frontend Transport; Thu, 13 Aug 2026 09:41:09 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Thu, 13 Aug
 2026 02:40:51 -0700
Received: from nvidia-4028GR-scsim.nvidia.com (10.126.230.37) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Thu, 13 Aug 2026 02:40:41 -0700
From: <mhonap@nvidia.com>
To: <alex@shazbot.org>, <jgg@ziepe.ca>, <ankita@nvidia.com>,
	<jic23@kernel.org>, <dave.jiang@intel.com>, <alejandro.lucero-palau@amd.com>,
	<smadhavan@nvidia.com>, <corbet@lwn.net>, <skhan@linuxfoundation.org>,
	<dave@stgolabs.net>, <alison.schofield@intel.com>,
	<vishal.l.verma@intel.com>, <iweiny@kernel.org>, <ming.li@zohomail.com>,
	<yishaih@nvidia.com>, <skolothumtho@nvidia.com>, <kevin.tian@intel.com>,
	<bhelgaas@google.com>, <dmatlack@google.com>, <kees@kernel.org>,
	<gustavoars@kernel.org>
CC: <cjia@nvidia.com>, <kjaju@nvidia.com>, <vsethi@nvidia.com>,
	<zhiw@nvidia.com>, <mhonap@nvidia.com>, <linux-doc@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <kvm@vger.kernel.org>,
	<linux-cxl@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<linux-kselftest@vger.kernel.org>, <linux-hardening@vger.kernel.org>
Subject: [PATCH v4 23/27] vfio/cxl: Refresh the decoder snapshot after a device reset
Date: Thu, 13 Aug 2026 15:06:27 +0530
Message-ID: <20260813093631.2288172-24-mhonap@nvidia.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260813093631.2288172-1-mhonap@nvidia.com>
References: <20260813093631.2288172-1-mhonap@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF0000468C:EE_|CH3PR12MB8484:EE_
X-MS-Office365-Filtering-Correlation-Id: 13bedeb9-21d8-40ed-f645-08def91f018c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|23010399003|36860700016|7416014|376014|22082099003|18002099003|56012099006|11063799006|10067099003|921020;
X-Microsoft-Antispam-Message-Info:
	fU85mnGhukbH/eVaGMliLWkBa6z6p3WD3Q2qap8Q0VoBKHbM+tm/Anot+ZDFE5gBASZE3N6yjUrqSk2g7hUeszGkcrPAJvPKmAx19ajhg9IcsTVrnEsaytVsGgbU4Ub3oKxnN9R0vQZzYCuVLDksXXepbGNu06ZX4sMa0H4inwFmj36iSvh1xZsk7kZQ36d0rQg7WXbT+xMQt/JvdFuZvhZRblu8o6VVdDWmB5hweB6LGprGYs9aK1pP5F+Il2nxSPDQHxrHX6pOZKnFkvD2FrnfDbIc/ZlsOhB3pOILvtQEjQXUI1l53/mdQIIszDnNzZtom4PKFcmSIQG8wDIN+vEy2WWml0PruIriYAKullhiFcA3pRdF73c54KEajFYVUbeJS/2sEvz88ZpxsKpE+uCg8JQDybj1lWNk+kIeeJBXJfA/4kJWzm9TOtaAzCWcZ5nACZFwBdt/3w/hI7wFR3gE1gsaqUFJoovousRwI6KV4oKNGW5ivrPPEefzKaMNM+2ShZ/sx2Dq3QpuU4zeeqIUOlaTxyOIzXvO6upnFUfkfj4wykRkmX4kvF/TtmceEbz6k1T7B/Oz1jq9DGSA6AZekdcjeQLm7cJ/u8U1FzaW7HGNYfQXOOle2dDej3BPDSXLa7R4hc3vdTgOj7bZ8XNPLS9f6F62ONgoKCyr4mS9YEwrUDN5XKkvFR1rFBHOUmLqyx4Kl9K77eIVTJgxhXTPJ1jPHC5/jlCtHIbXDTrIOAnfJ+pPeZn2/H0e8AF8
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(23010399003)(36860700016)(7416014)(376014)(22082099003)(18002099003)(56012099006)(11063799006)(10067099003)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	nV82eZdNm/uFY4E4yO8E+A8Icj33XsPBNVzfEsPzzQ3a3WeJt1Im7S8PnUVaXn1eX8sCZ4AMA/hSpr0+NFP4uPZn1tOwTQiZYZfA1uODuohN/OXVeov/8+tJlwsysXprY8luulO4QUxNfNc4Dj0OUr2ZZC/N3aROHQ3k4GSt9qgjfgR/72qDAUjQPGQhrxbY9hwpi+ulO7zv2wRZeqFmTVyypqB9NAa8knwLly42SYRf2Ghk1kF7VyTdcoceqbrq2LhFtK75eLMYgrYYYx9N7CxerRdbPJvrvbv+ljPXEpBiO7mcrWggtnCMHXgac66y9MybjLilZjRrxzfGvYQQ6g4+W54Ad/EDHdjm9gdrM1YJ7IJfE3wI0Z+v12BfajhVRCxAAqPcITH/azSFNFxSYkoDOFi0hTzSpSD/BOqzVSQSw4PCiN87yyv/dXIfF/3f
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2026 09:41:09.6645
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 13bedeb9-21d8-40ed-f645-08def91f018c
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF0000468C.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8484

From: Manish Honap <mhonap@nvidia.com>

A reset clears the HDM decoder registers, so the guest snapshot has to be
resampled once the reset settles, on every path that can reset the
function: the reset ioctl, an FLR driven through config space, and a bus
hot reset. Re-enable Memory Space first, since a config restore can leave
it off and the component-BAR read would then take an Unsupported Request.

The bus hot reset zaps BARs directly rather than through
vfio_pci_zap_and_down_write_memory_lock(), so it also needs the HDM
window zapped by hand; route both zap sites through a common helper.

Signed-off-by: Manish Honap <mhonap@nvidia.com>
---
 drivers/vfio/pci/cxl/vfio_cxl_core.c | 82 ++++++++++++++++++++++++++++
 drivers/vfio/pci/vfio_pci_config.c   |  2 +
 drivers/vfio/pci/vfio_pci_core.c     | 25 ++++++++-
 drivers/vfio/pci/vfio_pci_priv.h     | 20 +++++++
 include/linux/vfio_pci_core.h        |  4 ++
 5 files changed, 131 insertions(+), 2 deletions(-)

diff --git a/drivers/vfio/pci/cxl/vfio_cxl_core.c b/drivers/vfio/pci/cxl/vfio_cxl_core.c
index f1c6bf06c408..f45eaa60bad2 100644
--- a/drivers/vfio/pci/cxl/vfio_cxl_core.c
+++ b/drivers/vfio/pci/cxl/vfio_cxl_core.c
@@ -555,6 +555,86 @@ static void vfio_cxl_zap(struct vfio_pci_core_device *vdev)
 			    range_len(&cxl->hpa_range), true);
 }
 
+static void vfio_cxl_post_reset(struct vfio_pci_core_device *vdev)
+{
+	struct vfio_cxl_state *cxl = vdev->cxl;
+	struct pci_dev *pdev = vdev->pdev;
+	bool re_enabled = false;
+	int i, dwords;
+	u16 cmd;
+
+	lockdep_assert_held_write(&vdev->memory_lock);
+
+	if (!cxl || !cxl->hdm_shadow)
+		return;
+
+	/*
+	 * The decoder registers are read through the component BAR. A config
+	 * restore can leave Memory Space disabled, and the read would then
+	 * return an Unsupported Request, so re-enable it before sampling.
+	 */
+	pci_read_config_word(pdev, PCI_COMMAND, &cmd);
+	if (!(cmd & PCI_COMMAND_MEMORY)) {
+		pci_write_config_word(pdev, PCI_COMMAND,
+				      cmd | PCI_COMMAND_MEMORY);
+		re_enabled = true;
+	}
+
+	dwords = cxl->hdm_len / sizeof(u32);
+	for (i = 0; i < dwords; i++)
+		cxl->hdm_shadow[i] = cpu_to_le32(readl(cxl->hdm_regs +
+						       i * sizeof(u32)));
+	/*
+	 * Leave Memory Space as it was found. The guest owns Memory Space
+	 * through vconfig, so a physical enable done only to sample must not
+	 * outlive the sampling or the function would decode while vconfig
+	 * reports it off.
+	 */
+	if (re_enabled)
+		pci_write_config_word(pdev, PCI_COMMAND, cmd);
+}
+
+static int vfio_cxl_pm_restore(struct vfio_pci_core_device *vdev)
+{
+	struct vfio_cxl_state *cxl = vdev->cxl;
+	struct pci_dev *pdev = vdev->pdev;
+	int rc;
+
+	lockdep_assert_held_write(&vdev->memory_lock);
+
+	if (!cxl || !cxl->hdm_shadow) {
+		pci_dbg(pdev, "vfio-cxl: pm_restore: no shadow (device not open), skipping\n");
+		return 0;
+	}
+
+	/*
+	 * A D3hot->D0 transition can soft-reset the function and clear the HDM
+	 * decoder. Restore the physical decoder before the fault gate re-inserts
+	 * the mapping. The restore needs the device lock, taken here after
+	 * memory_lock to match the reset path ordering. On failure the decoder is
+	 * left unrestored, so close the access gate (zap no longer clears it) and
+	 * return the error so the caller keeps the HDM range inaccessible.
+	 */
+	if (!pci_dev_trylock(pdev)) {
+		pci_warn(pdev, "vfio-cxl: pm_restore: could not lock device, HDM not restored\n");
+		cxl->hdm_valid = false;
+		return -EBUSY;
+	}
+
+	rc = cxl_restore_hdm_after_pci_reset(pdev);
+	pci_dev_unlock(pdev);
+	if (rc) {
+		pci_err(pdev, "vfio-cxl: pm_restore: HDM restore failed: %d\n", rc);
+		cxl->hdm_valid = false;
+		return rc;
+	}
+
+	vfio_cxl_post_reset(vdev);
+	/* The decoder is restored and re-sampled, so reopen the access gate. */
+	cxl->hdm_valid = true;
+	return 0;
+}
+
 static int vfio_cxl_open_device(struct vfio_pci_core_device *vdev)
 {
 	struct vfio_cxl_state *cxl = vdev->cxl;
@@ -767,6 +847,8 @@ static const struct vfio_cxl_ops vfio_cxl_ops = {
 	.config_read	= vfio_cxl_config_read,
 	.config_write	= vfio_cxl_config_write,
 	.zap		= vfio_cxl_zap,
+	.post_reset	= vfio_cxl_post_reset,
+	.pm_restore	= vfio_cxl_pm_restore,
 	.owner		= THIS_MODULE,
 };
 
diff --git a/drivers/vfio/pci/vfio_pci_config.c b/drivers/vfio/pci/vfio_pci_config.c
index f088e4ce5e07..01d808546a4c 100644
--- a/drivers/vfio/pci/vfio_pci_config.c
+++ b/drivers/vfio/pci/vfio_pci_config.c
@@ -911,6 +911,7 @@ static int vfio_exp_config_write(struct vfio_pci_core_device *vdev, int pos,
 			vfio_pci_zap_and_down_write_memory_lock(vdev);
 			vfio_pci_dma_buf_move(vdev, true);
 			pci_try_reset_function(vdev->pdev);
+			vfio_pci_cxl_post_reset(vdev);
 			if (__vfio_pci_memory_enabled(vdev))
 				vfio_pci_dma_buf_move(vdev, false);
 			up_write(&vdev->memory_lock);
@@ -996,6 +997,7 @@ static int vfio_af_config_write(struct vfio_pci_core_device *vdev, int pos,
 			vfio_pci_zap_and_down_write_memory_lock(vdev);
 			vfio_pci_dma_buf_move(vdev, true);
 			pci_try_reset_function(vdev->pdev);
+			vfio_pci_cxl_post_reset(vdev);
 			if (__vfio_pci_memory_enabled(vdev))
 				vfio_pci_dma_buf_move(vdev, false);
 			up_write(&vdev->memory_lock);
diff --git a/drivers/vfio/pci/vfio_pci_core.c b/drivers/vfio/pci/vfio_pci_core.c
index 1a54f15d1c2c..fc8235c8b4fc 100644
--- a/drivers/vfio/pci/vfio_pci_core.c
+++ b/drivers/vfio/pci/vfio_pci_core.c
@@ -362,6 +362,14 @@ int vfio_pci_set_power_state(struct vfio_pci_core_device *vdev, pci_power_t stat
 		} else if (needs_restore) {
 			pci_load_and_free_saved_state(pdev, &vdev->pm_save);
 			pci_restore_state(pdev);
+			/*
+			 * A NoSoftRst- device soft-resets on D3hot->D0, which can
+			 * clear a CXL HDM decoder. Restore it before the fault
+			 * gate re-inserts the HDM mapping. memory_lock is held on
+			 * this path (the PM config write and runtime PM entry both
+			 * take it before the D0 transition).
+			 */
+			vfio_pci_cxl_pm_restore(vdev);
 		}
 	}
 
@@ -529,6 +537,13 @@ static int vfio_pci_core_runtime_resume(struct device *dev)
 		eventfd_signal(vdev->pm_wake_eventfd_ctx);
 		__vfio_pci_runtime_pm_exit(vdev);
 	}
+	/*
+	 * A NoSoftRst- function can soft-reset on the runtime D3hot->D0
+	 * transition and clear a CXL HDM decoder. Restore it while memory_lock
+	 * is held, before the fault gate can re-insert the HDM mapping. PCI
+	 * config restore alone does not restore the component decoder registers.
+	 */
+	vfio_pci_cxl_pm_restore(vdev);
 	up_write(&vdev->memory_lock);
 
 	if (vdev->pm_intx_masked)
@@ -1449,6 +1464,7 @@ static int vfio_pci_ioctl_reset(struct vfio_pci_core_device *vdev,
 
 	vfio_pci_dma_buf_move(vdev, true);
 	ret = pci_try_reset_function(vdev->pdev);
+	vfio_pci_cxl_post_reset(vdev);
 	if (__vfio_pci_memory_enabled(vdev))
 		vfio_pci_dma_buf_move(vdev, false);
 	up_write(&vdev->memory_lock);
@@ -1838,8 +1854,7 @@ void vfio_pci_zap_and_down_write_memory_lock(struct vfio_pci_core_device *vdev)
 	 * a runtime-PM entry, D3 transition, or reset would leave the guest
 	 * with live mappings into a quiesced device.
 	 */
-	if (vdev->cxl_ops && vdev->cxl_ops->zap)
-		vdev->cxl_ops->zap(vdev);
+	vfio_pci_cxl_zap(vdev);
 }
 
 u16 vfio_pci_memory_lock_and_enable(struct vfio_pci_core_device *vdev)
@@ -2780,6 +2795,8 @@ static int vfio_pci_dev_set_hot_reset(struct vfio_device_set *dev_set,
 
 		vfio_pci_dma_buf_move(vdev, true);
 		vfio_pci_zap_bars(vdev);
+		/* zap_bars misses the HDM window; bus reset needs it too */
+		vfio_pci_cxl_zap(vdev);
 	}
 
 	if (!list_entry_is_head(vdev,
@@ -2802,6 +2819,10 @@ static int vfio_pci_dev_set_hot_reset(struct vfio_device_set *dev_set,
 
 	ret = pci_reset_bus(pdev);
 
+	/* Re-sample decoder state for any CXL device the bus reset touched. */
+	list_for_each_entry(vdev, &dev_set->device_list, vdev.dev_set_list)
+		vfio_pci_cxl_post_reset(vdev);
+
 	vdev = list_last_entry(&dev_set->device_list,
 			       struct vfio_pci_core_device, vdev.dev_set_list);
 
diff --git a/drivers/vfio/pci/vfio_pci_priv.h b/drivers/vfio/pci/vfio_pci_priv.h
index 902d17815ab6..46e67573d264 100644
--- a/drivers/vfio/pci/vfio_pci_priv.h
+++ b/drivers/vfio/pci/vfio_pci_priv.h
@@ -82,6 +82,26 @@ int vfio_pci_set_power_state(struct vfio_pci_core_device *vdev,
 			     pci_power_t state);
 
 void vfio_pci_zap_and_down_write_memory_lock(struct vfio_pci_core_device *vdev);
+
+static inline void vfio_pci_cxl_zap(struct vfio_pci_core_device *vdev)
+{
+	if (vdev->cxl_ops && vdev->cxl_ops->zap)
+		vdev->cxl_ops->zap(vdev);
+}
+
+static inline void vfio_pci_cxl_post_reset(struct vfio_pci_core_device *vdev)
+{
+	if (vdev->cxl_ops && vdev->cxl_ops->post_reset)
+		vdev->cxl_ops->post_reset(vdev);
+}
+
+static inline int vfio_pci_cxl_pm_restore(struct vfio_pci_core_device *vdev)
+{
+	if (vdev->cxl_ops && vdev->cxl_ops->pm_restore)
+		return vdev->cxl_ops->pm_restore(vdev);
+	return 0;
+}
+
 u16 vfio_pci_memory_lock_and_enable(struct vfio_pci_core_device *vdev);
 void vfio_pci_memory_unlock_and_restore(struct vfio_pci_core_device *vdev,
 					u16 cmd);
diff --git a/include/linux/vfio_pci_core.h b/include/linux/vfio_pci_core.h
index 8b93949d4484..c438d968dc59 100644
--- a/include/linux/vfio_pci_core.h
+++ b/include/linux/vfio_pci_core.h
@@ -78,6 +78,10 @@ struct vfio_cxl_ops {
 				int count, __le32 val);
 	/* Revoke the HDM mapping; paired with the BAR zap */
 	void    (*zap)(struct vfio_pci_core_device *vdev);
+	/* Re-sample the decoder state once a reset has settled */
+	void    (*post_reset)(struct vfio_pci_core_device *vdev);
+	/* Restore the HDM decoder after a D3hot->D0 soft reset */
+	int     (*pm_restore)(struct vfio_pci_core_device *vdev);
 
 	/* Pinned per bound CXL device so vfio-cxl cannot unload under usage */
 	struct module *owner;
-- 
2.25.1

