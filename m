Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011047.outbound.protection.outlook.com [40.93.194.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89ADB59C972;
	Wed, 16 Sep 2026 18:38:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789583932; cv=fail; b=ERwqlDdFc5KFiH5Js/N4XnoxfFaL0UZv/dfg1mfRQSUzafz96WtglaVbiDiTy1MFAyawctCd9lSxsrsg2QpYjsismtbpmU+fnzoqgNBdzQHUlyiv9/zq/Hd5/L2R4h48PQptOv7nQA++KQP7fDWdoe1iYSZqR83yVciCXTNeyfY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789583932; c=relaxed/simple;
	bh=HarnXl+76jENvf0k1sLPHOiWdZfFXUFDnkp4EEg45NY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lt8QJEcCsnLK1QAUvm0pjjuq/ZzBeCEUI8qMoc8p7O8N1jN4Nug4khbedrduAC3IkE91mGdpgZYYIwE6JWCsoQzTq6PZmhn3TpmTzGqc/hf1vFTkYQHPdPWFJc9K17JaMCliqnd+V4WPlhaG8dYeLRb9q9UB7V+Mi8MyVmakGs8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=YVOByMZ3; arc=fail smtp.client-ip=40.93.194.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="YVOByMZ3"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bohqI6jZ28002Yl+5/4sIJzCX8U0h83VikO+aTZaimb1eUVMNahd14G00vzjwevIfZdLTwJ4C4UGhY66zL7fw5+Iz+/IJ5ELP5b362ZngjDrW1uqMV8PaBO4AEQskbwxUoFGl6x4BgzEP7uuVyJDGpW9HEbdy3Zi014KZA/1nSWEb9C/3xfbGsXyrMTeMviy4WNonHyFA+h+Ctswjvywczdy9n795o/0PGZQRUmnu4haCEsW/6fsAoHULlZX+aGvARMNdwhZIyVoPYR1O+zTdtApGuoO05Hyk5jK7+vvl4WCECkERQ/Acui03iSkqJCd1lx8MN76XKcTvmhbuB0ZSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=decP5zO7Z6mzPDwjjw5ozaqmByV54aA8aCnC4oQIaCE=;
 b=S20LNtjc/AbPa1NYz6lYnrlB64cDl+2WTWPs1lnOfMCCfGLEbkbwALaUYhafe6JqptQYtRaZLpF5W2DJldjb0GsqueG0kFZ3DGPlIshUmai1i41HXXD0Vm45dCB0H4+uT08wuOxxekdYlHbc19pe5wwZyaM6cWRmKHJ/wf5ZGxCnw28HKoG+Fh3zKNDWwK1fbESWpczKZhNcOv330D0DekpVJRvT8VS0LR4sGriDcNJ8j4vjY0CMIGHmwf9B2mBkXFpdnnTWaISkw9bjl3Sf9Cm+wZXshef5XbKYkfKiFo7icUX8ND98mfTL8Vjt0Gi21Qhqh6cW9Uj+BzZkE/3xaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=shazbot.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=decP5zO7Z6mzPDwjjw5ozaqmByV54aA8aCnC4oQIaCE=;
 b=YVOByMZ38hBzOhajn+dO8ucFiT709XQqPMxCBf27rX9eWYhftu0HjIWcd/hZITMCuVFoQsg5+yqYSfHjFcAhxjw5dkPEtVNXnasYNlSE5Cod7CPKM1qYufYYzkXT8awGza2fUfL7gM5I6o16BbQQVxrk3apWX5I79uRz9Xs/Zf5pQBwCV+1hVF5P0oL8LSrX9WuWSwx3PPI8ppsREld6apvARfj4wv5vULqeOEygLr1ZzvFk5U7022yoQ7LguYcD5WjxzjbiWPSAY/dcT+lr8Ok8DGa3hu0G47/2RgTwUSystDiWcccB+GOk71pZvZ2kEl2cAmkNC035/kKaxt0fcg==
Received: from BN9PR03CA0265.namprd03.prod.outlook.com (2603:10b6:408:ff::30)
 by CH3PR12MB583062.namprd12.prod.outlook.com (2603:10b6:610:363::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.9; Wed, 16 Sep
 2026 18:38:16 +0000
Received: from BN6PEPF00000071.namprd03.prod.outlook.com
 (2603:10b6:408:ff:cafe::44) by BN9PR03CA0265.outlook.office365.com
 (2603:10b6:408:ff::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.428.9 via Frontend Transport; Wed, 16
 Sep 2026 18:38:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN6PEPF00000071.mail.protection.outlook.com (10.167.248.198) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.428.7 via Frontend Transport; Wed, 16 Sep 2026 18:38:15 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Wed, 16 Sep
 2026 11:37:48 -0700
Received: from nvidia-4028GR-scsim.nvidia.com (10.126.230.37) by
 rnnvmail202.nvidia.com (10.129.68.7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Wed, 16 Sep 2026 11:37:39 -0700
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
Subject: [PATCH v5 11/27] vfio/pci: Virtualize the CXL DVSEC in vfio_pci_config.c
Date: Thu, 17 Sep 2026 00:05:24 +0530
Message-ID: <20260916183540.3813685-12-mhonap@nvidia.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260916183540.3813685-1-mhonap@nvidia.com>
References: <20260916183540.3813685-1-mhonap@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail202.nvidia.com (10.129.68.7)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN6PEPF00000071:EE_|CH3PR12MB583062:EE_
X-MS-Office365-Filtering-Correlation-Id: 0010e6cc-7950-45c2-39b1-08df1421abc4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|23010399003|1800799024|82310400026|36860700016|11063799006|921020|56012099006|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	6KKf2MiMqRsPr2HbNvCeOv3INb4cv7xpLOziyXTGgYNFJGKt0ZZH1ZMyzquO8frRRrsRXrEqFlryCBenasNkFGiOOlGEa8sGcaUq5tAFP+Ty7d4t3v4Eg80khAvRpVarggEnf9IiAsGH7mK6XNlM14UntVoFTIj6Yb6csb0RmgAAPgi7+W9yRR9kFj+eRq7qBWiwxxgPl9fmLF/XVP7QfooRCWov8EmTACJZ+SdM1k4j26eVKPDdtZxOJpVf9m+DnBGSE1kcr5NFRHTzrI1b7hiALIisiArPXthc4ukVsSDflc/mKRCeT538OhcFJXDJOvflZrraU6yPS54ZB2VTcAhHLISkkvyshQrkY651/3iASJLGaeTRWZM8SznmKAUaHN3lWsgFI4WgmAsLUj/HGESGkECULihRm9v121Pgai4K90Pecd5LCbhl4e6kOtqyhXiiMHOxbvz6bQ6wxncyP/rFEKhosGiSemX6a+saddZFzXpC20jWRbSvOqkBGxjCg6BPNOJ9sWTk7IZo/62yq2HZ7YYKZWJm/bn61UHi3JdpDSQfxdNemHRWxw2ukXv3505LkD+oP4NlGtFzDznXjXYVp055AqlFVY6hREo0Bw6yEmRq9q1GyCgX8i1hPSFcKApkLOfF6a7qg2Rg7zk7ZvJLO5CXw1jDMea5qoYpqyDfDAfkiwqqE01fw+BEYwMb3xB4lz0dP5zaW+nCLiz8hFmJSDi7VqNDpqTRbOcxGVBV0VFdTq/71OFBDJDU3CGA
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(7416014)(376014)(23010399003)(1800799024)(82310400026)(36860700016)(11063799006)(921020)(56012099006)(10067099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	rni4/OqE7I5LSD7EfHqTSCe3iJL2f4yEivGTqpp79tRYOWnhOgYdgrYq45+GBTcfhngOl9spH/wE+VE6t1HZcPmyDu/HujNmZeKktmsPWhhLWsH3BTaujlaU5z6fZj8jv6cL5YoUbZaItdhUHWfCGd+4lNPZxhoDJfeuwHAk3ol6CEjhYfGl0wauOxmx4/lDmt8bnjyV4ls9JSZ7RRkaGMLSHZwk1F6d+ZI7RCkGOraCr6P3nbpkplp9ZN9i2PToPJCkl0/STtfelV4jKMUI9v0C5C6RWqi4CUC186QFUx6+fyfJuQVgf22CBLzvmdRbBfxHRtCW3YWJNgRFgImqhPmK6AAfawjo1qxohCw4LQG0jh2hBgYOvQmjHLIhNL5W+p5A9QXEVfOe3igTjcZD6wcCOiLk9hBNQOm4MDosiBcdp/B0LIBFRSdSf4VWU+4o
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2026 18:38:15.6277
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0010e6cc-7950-45c2-39b1-08df1421abc4
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN6PEPF00000071.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB583062

From: Manish Honap <mhonap@nvidia.com>

A CXL Type-2 device is reprogrammable through its CXL DVSEC: a guest could
set Config Lock, toggle CXL.cache and CXL.mem enable, or rewrite the HDM
range registers that govern host memory decode. Virtualize the DVSEC so
the guest sees a shadow it cannot use to reprogram the hardware.

Build a per-device cxl_perm permission map, modeled on msi_perm, when the
device is bound through the CXL provider (e.g. vfio-cxl). The whole CXL
DVSEC is served from the vconfig shadow; only Control and Control2 are
guest programmable, while Capability, Status, Lock and the Range registers
keep their firmware snapshot. A vendor DVSEC on the same device is
unaffected: the map is selected only for the CXL DVSEC offset.

Control2 carries the CXL reset and cache write-back-invalidate initiate
bits as self-clearing doorbells. vfio never forwards them to hardware, so
a custom writefn synthesizes their completion in the shadow: the initiate
bit self-clears and the matching Status2 bit (Cache Invalid or Reset Done)
is set, so a guest following the spec reset sequence
(INIT_CACHE_WBI, poll Cache Invalid, INIT_CXL_RST, poll Reset Done)
progresses instead of timing out. The host performs the real cache
write-back and reset at the vfio reset points.

Assisted-by: LLM
Signed-off-by: Manish Honap <mhonap@nvidia.com>
---
 drivers/vfio/pci/vfio_pci_config.c | 132 ++++++++++++++++++++++++++++-
 include/linux/vfio_pci_core.h      |   3 +
 2 files changed, 133 insertions(+), 2 deletions(-)

diff --git a/drivers/vfio/pci/vfio_pci_config.c b/drivers/vfio/pci/vfio_pci_config.c
index 9914f3ac69ae..9a020a768055 100644
--- a/drivers/vfio/pci/vfio_pci_config.c
+++ b/drivers/vfio/pci/vfio_pci_config.c
@@ -1747,6 +1747,119 @@ static const struct pci_device_id known_bogus_vf_intx_pin[] = {
  * for each area requiring emulated bits, but the array of pointers
  * would be comparable in size (at least for standard config space).
  */
+static int vfio_cxl_dvsec_write(struct vfio_pci_core_device *vdev, int pos,
+				int count, struct perm_bits *perm,
+				int offset, __le32 val)
+{
+	__le16 *pctrl2, *pstatus2;
+	u16 ctrl2, status2;
+	int start;
+
+	count = vfio_default_config_write(vdev, pos, count, perm, offset, val);
+	if (count < 0)
+		return count;
+
+	/* Only Control2 carries the self-clearing doorbells. */
+	if (offset > PCI_DVSEC_CXL_CTRL2 ||
+	    offset + count <= PCI_DVSEC_CXL_CTRL2)
+		return count;
+
+	start = vfio_find_cap_start(vdev, pos);
+	pctrl2 = (__le16 *)&vdev->vconfig[start + PCI_DVSEC_CXL_CTRL2];
+	pstatus2 = (__le16 *)&vdev->vconfig[start + PCI_DVSEC_CXL_STATUS2];
+	ctrl2 = le16_to_cpu(*pctrl2);
+	status2 = le16_to_cpu(*pstatus2);
+
+	/*
+	 * INIT_CACHE_WBI and INIT_CXL_RST are self-clearing doorbells that vfio
+	 * never forwards to hardware. Synthesize their completion in the shadow
+	 * so the guest poll finishes: clear the initiate bit and set the
+	 * matching Status2 completion.
+	 */
+	if (ctrl2 & PCI_DVSEC_CXL_INIT_CACHE_WBI) {
+		ctrl2 &= ~PCI_DVSEC_CXL_INIT_CACHE_WBI;
+		status2 |= PCI_DVSEC_CXL_CACHE_INV;
+	}
+	if (ctrl2 & PCI_DVSEC_CXL_INIT_CXL_RST) {
+		ctrl2 &= ~PCI_DVSEC_CXL_INIT_CXL_RST;
+		status2 &= ~PCI_DVSEC_CXL_RST_ERR;
+		status2 |= PCI_DVSEC_CXL_RST_DONE;
+	}
+
+	*pctrl2 = cpu_to_le16(ctrl2);
+	*pstatus2 = cpu_to_le16(status2);
+
+	return count;
+}
+
+static int init_cxl_dvsec_perm(struct perm_bits *perm, int len)
+{
+	int i;
+
+	if (alloc_perm_bits(perm, len))
+		return -ENOMEM;
+
+	perm->writefn = vfio_cxl_dvsec_write;
+
+	/* Serve the whole CXL DVSEC from the shadow. */
+	for (i = 0; i < len; i++)
+		p_setb(perm, i, (u8)ALL_VIRT, NO_WRITE);
+
+	/*
+	 * Control and Control2 are guest programmable; Capability, Status,
+	 * Lock and the Range registers keep their firmware snapshot, so the
+	 * guest cannot set Config Lock or rewrite the capability and ranges.
+	 */
+	p_setw(perm, PCI_DVSEC_CXL_CTRL, (u16)ALL_VIRT, (u16)ALL_WRITE);
+	p_setw(perm, PCI_DVSEC_CXL_CTRL2, (u16)ALL_VIRT, (u16)ALL_WRITE);
+
+	return 0;
+}
+
+/* Virtualize the CXL DVSEC so a guest cannot reprogram the device through it. */
+static int vfio_cxl_dvsec_init(struct vfio_pci_core_device *vdev)
+{
+	struct pci_dev *pdev = vdev->pdev;
+	u32 dword;
+	u16 dvsec;
+	int len, ret;
+
+	dvsec = pci_find_dvsec_capability(pdev, PCI_VENDOR_ID_CXL,
+					  PCI_DVSEC_CXL_DEVICE);
+	if (!dvsec)
+		return 0;
+
+	ret = pci_read_config_dword(pdev, dvsec + PCI_DVSEC_HEADER1, &dword);
+	if (ret)
+		return pcibios_err_to_errno(ret);
+	len = PCI_DVSEC_HEADER1_LEN(dword);
+
+	/*
+	 * The virtualization writes fixed DVSEC offsets up to Status2 (the reset
+	 * doorbell stamps it). A device that reports a shorter DVSEC is not a
+	 * usable Type-2 function; leave it as plain vfio-pci rather than index the
+	 * device-length-sized perm allocation past its end.
+	 */
+	if (len < PCI_DVSEC_CXL_STATUS2 + 2)
+		return 0;
+
+	vdev->cxl_perm = kmalloc_obj(struct perm_bits, GFP_KERNEL_ACCOUNT);
+	if (!vdev->cxl_perm)
+		return -ENOMEM;
+
+	ret = init_cxl_dvsec_perm(vdev->cxl_perm, len);
+	if (ret) {
+		kfree(vdev->cxl_perm);
+		vdev->cxl_perm = NULL;
+		return ret;
+	}
+
+	vdev->cxl_dvsec = dvsec;
+	vdev->cxl_dvsec_len = len;
+
+	return 0;
+}
+
 int vfio_config_init(struct vfio_pci_core_device *vdev)
 {
 	struct pci_dev *pdev = vdev->pdev;
@@ -1842,6 +1955,12 @@ int vfio_config_init(struct vfio_pci_core_device *vdev)
 	if (ret)
 		goto out;
 
+	if (vdev->cxl_ops) {
+		ret = vfio_cxl_dvsec_init(vdev);
+		if (ret)
+			goto out;
+	}
+
 	return 0;
 
 out:
@@ -1863,6 +1982,12 @@ void vfio_config_free(struct vfio_pci_core_device *vdev)
 		kfree(vdev->msi_perm);
 		vdev->msi_perm = NULL;
 	}
+	if (vdev->cxl_perm) {
+		free_perm_bits(vdev->cxl_perm);
+		kfree(vdev->cxl_perm);
+		vdev->cxl_perm = NULL;
+		vdev->cxl_dvsec = 0;
+	}
 }
 
 /*
@@ -1926,12 +2051,15 @@ ssize_t vfio_pci_config_rw_single(struct vfio_pci_core_device *vdev,
 			 * of the extended capability list.  Use default, ro
 			 * access, which will virtualize the id and next values.
 			 */
+			cap_start = vfio_find_cap_start(vdev, *ppos);
+
 			if (cap_id > PCI_EXT_CAP_ID_MAX)
 				perm = &direct_ro_perms;
+			else if (cap_id == PCI_EXT_CAP_ID_DVSEC && vdev->cxl_perm &&
+				 cap_start == vdev->cxl_dvsec)
+				perm = vdev->cxl_perm;
 			else
 				perm = &ecap_perms[cap_id];
-
-			cap_start = vfio_find_cap_start(vdev, *ppos);
 		} else {
 			WARN_ON(cap_id > PCI_CAP_ID_MAX);
 
diff --git a/include/linux/vfio_pci_core.h b/include/linux/vfio_pci_core.h
index 92e3db116068..e8a1fc398571 100644
--- a/include/linux/vfio_pci_core.h
+++ b/include/linux/vfio_pci_core.h
@@ -120,6 +120,9 @@ struct vfio_pci_core_device {
 	u8			*pci_config_map;
 	u8			*vconfig;
 	struct perm_bits	*msi_perm;
+	struct perm_bits	*cxl_perm;
+	u16			cxl_dvsec;
+	u16			cxl_dvsec_len;
 	spinlock_t		irqlock;
 	struct mutex		igate;
 	struct xarray		ctx;
-- 
2.25.1

