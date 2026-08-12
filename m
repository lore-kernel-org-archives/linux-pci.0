Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011013.outbound.protection.outlook.com [40.107.208.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE135395AC6;
	Wed, 12 Aug 2026 04:53:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786510430; cv=fail; b=DAgdNDP9ql212nX9ad4QwhaYiRl48Eq2Hjqmqw61JtL1J00o1OVVclc45OvvUAEPT251YtlBRX8u2lI7i0mpUw0PN1Awuu5Cr05kog9X/TZIoK4bNuFQdOMYbIj5lFnF7Ca09lRLM6/FTt5OJa1FfBG29BV1XFb2tGrRG1wMWMQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786510430; c=relaxed/simple;
	bh=jtHFF4Wx7CpwHhOlos1Zq10Jj+hCpLJzLgDFe/rpYKY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=g5us6R73+bqrmE6Jzg7W7eZkKmws5U/0ydDWPQAfntQn3Q2dy0mEqRMOnbEIYtJ8ccdCOkLa1IU5JuU4+nZrMvFl5oqptK3YArZGSaT/SRQb14YhcBecxKLy8sBRJK4htdioC7bwbpxEo54Fquq/7TxzKsoWfBFyGzmP1f+f4OA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=C0ERgX2Z; arc=fail smtp.client-ip=40.107.208.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="C0ERgX2Z"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Bp/Cw1jD8TACBL7EbdIQlExcBkSB7fIsFEZd2MnGawRBXQjaCu19TB5U/wXHVredcMwT6F81q1Lw0kjRRHKvM83oajQimSRkcdveNl6hQZjyD8BO07x0xgV+wW7NuIjtCjeG0Xr24xgwGaByY64Ctam3OpdywfuadE5mPz7VxhoBCcLpmsuZR4aL4lBsHWxLA76kLdDQnLtbG8C4rfio7ZSr1+hdsU1ZEwAkd1X8gl1K7+zM421Q49G6SSGaTarwejZw54+8UVeRnE0ahmq95OI7lUFfgs2Y8L7mQZPowtx/PsShdgYQfNYKdV5XhXUzHjFxxVgT0hO+6kee3OSMqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W25Qjhl5htoEvXWB8dZFHcrWtT+sG2NlcNZC9Sm1Inw=;
 b=oIeNIl7n+XMVIsRuKllBmOhXehBIeEQ1S/1CTvEAb1CMoLp5ZNekIY2Exl6Z6cXSQDxAmm83HJH7JWHUoxHxSO3CpZQPDI/wUR5m2rXqoDopmEWYK/5VhEZ9bp5wIdOhDhCMbG/SbJiDNlBRcCPSF2c2Jfzn0DH5VYhQS/fRfw+/6X/Ag7Nsgzsz15txl1fTzCQIgL4OJPix6Sl2HtUadMBX52klAGzvrDZh0Fo/Y32LLbT2Ea3cYcROmNAHIPAFq2sXOxvmP+hpLZfNl7LPG7Zzsh6DE1V6gLBw3BVPyVJQEqRQ2G3M/SLUxqAfaa5cB0b9RPCzKhm9v2YT7SQPcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W25Qjhl5htoEvXWB8dZFHcrWtT+sG2NlcNZC9Sm1Inw=;
 b=C0ERgX2ZUO6FPzbKxBhHkbbaKQFUNVTG+HKrBRxF8W1iJFyu8bUyDMeHQti2OSQBKuPnsADvk3XgQCMMmcDKL6CxMfyO2r8bJMCX9xRfg9tPMhUS0IyO1b8jrBr/rq7SIn2MLnJLnFgjRXr69u3LA1qhUcQV5hg4HPY7BuRabFjkSiBN/WX1MHRPyAUGeoWwxC3TLsy9XhVJxdgtPtaxGFAsLUoJ5n10LJgpzW3sYtWddBiJqrd3BMMFkUuoi7/p25szl0sIAt2LFmOLg5nddE5LyEdB0qKNkUo5+o1AuvNyfY1G1yIyxODBZ+6yNgzmCZ2AWCRvSWvsHm7t5ZafpQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV3PR12MB9411.namprd12.prod.outlook.com (2603:10b6:408:215::20)
 by DS4PR12MB9748.namprd12.prod.outlook.com (2603:10b6:8:29e::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.12; Wed, 12 Aug
 2026 04:53:32 +0000
Received: from LV3PR12MB9411.namprd12.prod.outlook.com
 ([fe80::98b7:86de:b69:2a15]) by LV3PR12MB9411.namprd12.prod.outlook.com
 ([fe80::98b7:86de:b69:2a15%6]) with mapi id 15.21.0315.011; Wed, 12 Aug 2026
 04:53:32 +0000
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
Subject: [RFC PATCH 5/5] vfio/pci: Use pci_reset_supported() in place of reset_works
Date: Tue, 11 Aug 2026 22:53:23 -0600
Message-ID: <20260812045325.2733631-6-alex.williamson@nvidia.com>
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
X-MS-Office365-Filtering-Correlation-Id: 7e610242-d7ce-4f32-ee93-08def82da8fe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|1800799024|366016|6133799003|10067099003|56012099006|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	+l5s6z3qJEBL2W9DybxJZa8L3Suzp6EdS9f+p0yhZJ0ygLwjAMD4n0dnkvwqNRbtcVAuxx49MO6d5hRR53ZxuNB+2+qE+OR2lB4DarvCRScC1xe9BBPfwG8MH9SLIoM77iiTRTg9ckXg/XIN0e6sMSor8HHLHK4+eB1E8EpttxERxkhtZyr72W0bctYyFEOcTNsli1l8v+xtB+j5p7xZXegogKwQdkAjLpCC+prlGgRNq0S2c97mdODKlubGkECEmTUYTlcF5Q3OTIU2epXgRaOM8iCJQuWS7XCukUkbCBGmrmyDmooWlEzRa8drSqq2QrqT5dH7YndENDWs8pTn6sdv4rfNrD3zaAcjuUBxQAcBi6le8UnQIZVhjAEhb0HCD52xJUPAR9d81MMVPUYEzQE9SJ5GiU5QmOd+dwR4svRimp5HWcqSKpjFVBb0taVXKMt9eLnlp4YUma70A3FrNCNO9efJ5XzMkS4y6+17brXqouePpcT/texc4kaw+pOYEtFZeeiu+osxJI9WkirWIFg93mpkZplMGzxwA5IcXfYexsrFpQ9uBJVWL9KKoLNEF/oNqZi7MkTaEi6zzpTBKBZYKDGeNR//3ON1jjeQ8ry6/rIr3BOX4kroaAKtTo8ivDiZNrbwCj5PSWmgidhbWmYq2PtsYI8pbn9k72PkOhE=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9411.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(6133799003)(10067099003)(56012099006)(11063799006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?tiFuQge3xf8UjBlcK3KVVGt8w/u3q98e3kBvWGOOLmOfxBqnjDhUXGEW3gjZ?=
 =?us-ascii?Q?t0bXO8X78lbDE94l7XLGoxezGrfQYtn9tfNgMfmpJRwm7vgfAwZAZyvlgMht?=
 =?us-ascii?Q?bpHA7NKfodETPiTrklG+jmpS8XhvdQI156VZmr/iENmcsagTtAk9GL3Ps3ED?=
 =?us-ascii?Q?EtvTZKOZFjl3MF7SZd7gmOjeHl7bjhYE9+wNbjwzoFecVJ81iSmgfOzydvAY?=
 =?us-ascii?Q?evIRgIKPe5dsDS5sAfD8e+rHF8zrbHX7ADn/OX9nKyJeYlHMuSf2I2gri2uU?=
 =?us-ascii?Q?TbUtCdIbg6nHXX94xx75gmkPs67nwpR5eIJUZH8tb8NoH3qTneecTfta9JCJ?=
 =?us-ascii?Q?WnbBB7j7UhWg8vuUnHXhwQq1esK9QovSOqE9qels1Ve4JaLF1RpufpGSs1gn?=
 =?us-ascii?Q?eVOBsH70VSl2Cw4ILhL+ZEHOxUZrD4oZVuZbLl6vtQ2Lc/lD2cqBNqMxvRDc?=
 =?us-ascii?Q?Wt3EbYo1kt7iOuknXQeePR8mgdaM3DSsRYbmvaUoYlGDdD9sNJevn8pVsUp2?=
 =?us-ascii?Q?S0x+Xljc7F3VnWiwSoZSFs2rgNjFDWA+x3qP/ckh0NxGS2GcGqVWtyqkcg3h?=
 =?us-ascii?Q?36zAxt0wb90cHBha/R5hbe74LCiMObKeVKUOCNvPh6GlRCtZRytGg7sbABVX?=
 =?us-ascii?Q?t/EfVrXvPMql3BF4vimSaip/j68L0BdjeHrJfxNv7TWbyBiEG+H2U/LBSGH7?=
 =?us-ascii?Q?y5Cj9wVVMtW+OUZ1BPXVqCAhcI11+SxoNnK44pA0CepAZyG7ldp/FJdHbGJu?=
 =?us-ascii?Q?vNLfLZavig+v8MWKq7C6f8OJlMkEyWxI23CuG0dpDE8WcxlkIPKl23NnfPv7?=
 =?us-ascii?Q?wOg/So5/HYkMihnvg9l+c7zj72mZaz5DuD95/JdhauUjGmKfR8YyLH5ElSYd?=
 =?us-ascii?Q?GiyJPi2yMZsBQo4obotKqRP6mPf1pz8XHjEwe366YF8vNoMgEby9UWhwQ0/G?=
 =?us-ascii?Q?tHicNazQUJtxWv7HX5DCR5fjhXEHvHNqDSHW6U4+DdhY76jbw8GvSpnUY+HM?=
 =?us-ascii?Q?R/buqyv0k5afg7TdKluw2XRq2GkR9S/pmEemcawzFjDLoS0Y+aD5FnTacMjx?=
 =?us-ascii?Q?mmiAACKTodmPziTGZhPW0e8knc1cPgJLK1Wzt6Ao/T6Vo46NioPc4dzTBfvv?=
 =?us-ascii?Q?iN7v3NYDt4VYapz6ROJGi7Kdn9ma2/hGGtF3/MUtUgFnMYAFbOYmUOeAXAKJ?=
 =?us-ascii?Q?A8MgwrC0noHmxzXY+hE6yubu1v/Gw2entOO18iSG8Gw8ldJqAxCdlsSQAU30?=
 =?us-ascii?Q?f0bnReDkc0UkhlpnAzSfGGRuAq4LGF4mFvrXsrhcxpcswXXN0BG1eJi3BIPH?=
 =?us-ascii?Q?MBK0kKt9OO1ASoyAytz9UCM6yW6pXr20da6w9J6pv20ffjq0ubw2oIWkh4jJ?=
 =?us-ascii?Q?HL1v4MgGJcjOT+rnIymcG1qpiFZDcoo3qMt3SkFgVpcLSWFvtAqvx3RKhUKA?=
 =?us-ascii?Q?x+GLaDTUC+XS/mxItlaEot4Rn0dgcmQVMFp1V5AXxZDfiksF9DnHmVsWu9G1?=
 =?us-ascii?Q?GnJQgdnc8Nzl586i5wposCmwo36kpMA8X/T8rU73TNFaLpcObamSGcg4MqKm?=
 =?us-ascii?Q?qYaZ8zbP/UI+ZOxVPP100Kfuah1lgic2bWbVaHcdW/F10ekxowIwAtkARNBR?=
 =?us-ascii?Q?tK1vFbgJpsnMfstJePryywvq0UxdT3nfrY1t4Xls8bs+crnz5QNF0EZQKJcj?=
 =?us-ascii?Q?60t1uGzMBmegkO0AyOfa37XH2Lqy9CdsA+4fg6mm3CHnw+7RJrUxNSH6pwog?=
 =?us-ascii?Q?GbHfAlvGXQ=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e610242-d7ce-4f32-ee93-08def82da8fe
X-MS-Exchange-CrossTenant-AuthSource: LV3PR12MB9411.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2026 04:53:32.7218
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bq6G06SZIbOlNZ9mEQK//Qif+BI7u99wmAM/LaTw8ezNlKC4pRwaQO70rfzvDSs6cQ3mCGqSR/mmmY9nk9ujLg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR12MB9748

vfio-pci latches whether pci_reset_function() works at open device and
makes decisions based on this latched value at runtime.  With the
introduction of the reset_method pci-sysfs attribute, this flag can
be made stale at runtime by administrative action.  Further, with the
SR-IOV active VFs gating of pci_reset_function(), the flag can be made
stale via more subtle dependencies.

Drop the latched flag and rely on pci_reset_supported() to indicate
whether reset methods exist for the device.  This is no guarantee that
those reset methods work, nor has the RESET flag in struct
vfio_device_info ever been a guarantee of VFIO_DEVICE_RESET success.
It's only a guarantee that there are reset methods that are
applicable to the device at the instant it's called.

Assisted-by: Claude:claude-opus-4-8
Signed-off-by: Alex Williamson <alex.williamson@nvidia.com>
---
 drivers/vfio/pci/vfio_pci_core.c | 9 ++++-----
 include/linux/vfio_pci_core.h    | 1 -
 2 files changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/vfio/pci/vfio_pci_core.c b/drivers/vfio/pci/vfio_pci_core.c
index 956a05ca12e5..8e42342d56d3 100644
--- a/drivers/vfio/pci/vfio_pci_core.c
+++ b/drivers/vfio/pci/vfio_pci_core.c
@@ -609,7 +609,6 @@ int vfio_pci_core_enable(struct vfio_pci_core_device *vdev)
 	if (ret == -EAGAIN)
 		goto out_disable_device;
 
-	vdev->reset_works = !ret;
 	pci_save_state(pdev);
 	vdev->pci_saved_state = pci_store_saved_state(pdev);
 	if (!vdev->pci_saved_state)
@@ -766,7 +765,7 @@ void vfio_pci_core_disable(struct vfio_pci_core_device *vdev)
 	if (pci_load_and_free_saved_state(pdev, &vdev->pci_saved_state)) {
 		pci_info(pdev, "%s: Couldn't reload saved state\n", __func__);
 
-		if (!vdev->reset_works)
+		if (!pci_reset_supported(pdev))
 			goto out;
 
 		pci_save_state(pdev);
@@ -785,7 +784,7 @@ void vfio_pci_core_disable(struct vfio_pci_core_device *vdev)
 	 * We can not use the "try" reset interface here, which will
 	 * overwrite the previously restored configuration information.
 	 */
-	if (vdev->reset_works) {
+	if (pci_reset_supported(pdev)) {
 		bridge = pci_upstream_bridge(pdev);
 		if (bridge && !pci_dev_trylock(bridge))
 			goto out_restore_state;
@@ -1098,7 +1097,7 @@ static int vfio_pci_ioctl_get_info(struct vfio_pci_core_device *vdev,
 
 	info.flags = VFIO_DEVICE_FLAGS_PCI;
 
-	if (vdev->reset_works)
+	if (pci_reset_supported(vdev->pdev))
 		info.flags |= VFIO_DEVICE_FLAGS_RESET;
 
 	info.num_regions = VFIO_PCI_NUM_REGIONS + vdev->num_regions;
@@ -1330,7 +1329,7 @@ static int vfio_pci_ioctl_reset(struct vfio_pci_core_device *vdev,
 {
 	int ret;
 
-	if (!vdev->reset_works)
+	if (!pci_reset_supported(vdev->pdev))
 		return -EINVAL;
 
 	vfio_pci_zap_and_down_write_memory_lock(vdev);
diff --git a/include/linux/vfio_pci_core.h b/include/linux/vfio_pci_core.h
index 9a1674c152aa..6fb599ec2919 100644
--- a/include/linux/vfio_pci_core.h
+++ b/include/linux/vfio_pci_core.h
@@ -121,7 +121,6 @@ struct vfio_pci_core_device {
 	/* Flags only modified on setup/release - bitfield ok */
 	bool			has_dyn_msix:1;
 	bool			pci_2_3:1;
-	bool			reset_works:1;
 	bool			extended_caps:1;
 	bool			has_vga:1;
 	bool			nointx:1;
-- 
2.53.0

