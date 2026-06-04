Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011070.outbound.protection.outlook.com [52.101.52.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0FD842188A;
	Thu,  4 Jun 2026 11:44:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780573469; cv=fail; b=ViX/yBOzexpwD0qwBAgyRgG6BWlgdoNGpxvALyJj33Y7Uc8Da6TrlvSk5F3/CcmNSyu5wC/zwR7N1H3Fo6b/NA1Fm4CKsf456be4fD51N1q/Z8iz4Eoj1RwznuvPuIAqIOg5dv7d9K+qa9Nc1g5ll+g7I3t5nEjmxHUU8UboSGk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780573469; c=relaxed/simple;
	bh=YAqYy2JhOShF1xC4L7BvQolewalbz3zf5dwPiTMXc6M=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=s5WclQhigzj5LbyvUDSNrwRc30K573WRbejOdpjdGpHG9IE5PP0eagxir7ca5GKRzfOhCahIrbVlauLo3VnghgQ3K7y9S0Uq5g2tMZpex3ssZv2zfLK20i2xFbKEukAgQTwZsNCa6rAKGExkGvYrCmqIpNck8esFa/tieNeepbM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=uKCT05hc; arc=fail smtp.client-ip=52.101.52.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="uKCT05hc"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Pvql9myHLUZv5753r96eVK60Vo4WGHVS4b5Xpzi/SUYOlL6nE5C6yfHazK4wZB/vH0AP4SV50YfNFgCVWT28v/SVlHeP2X63+S+ef3lYbHWbUI9Ag7nVZgqg513SirfOUT9GRpGxEnXj+4OWhyqV3V3BDht6Ws3ug7xHIstga0U8XtQe5g88gmukZ1Be2Tf+pL4toa33ZoCrWHFFK+QeN3D3fVrZxXo7vRMdHX48RdxT2kVn/HqekmcOx793zQyFXN9Ju3IuAcMJrTj7Vq85UXHwx9mlsx2UpBoqvuSQ4voOgZ9yY4skL2iRxOB5o8RutA4rfyWmLWNSaKgjBbHvWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rSMgM3UgTjsktBTB8+dwoPwNjo94GgxLMqJZGM9Ngew=;
 b=ZW/ZVZuINdHU8Zzk+FBXW/Q8GpZZdZBD+CjB9X7feVQ9cGAZQoolnSdXy0xeS9bpUvPj2lAxnE8dyU6a3Uw4WKg2oXhxtoOyOO96LBQ/58RYYwXovMVTJ3p5dT/8J2dup+WJvdeKkjsE3tnoyMHch2nY2OgBVk/qF8z0l5aWO3OtKq0ZM9haQ+NSIit3xogDtaydciBLAyuMF9nNeQZDl3JaEZV1iPIgBIY+Zxw18EF7Y/tnmKU69IGAhQs/Hbfb/c2BghSIKwXWmC7VSuWhDoL05CbArP5fFqnuGesQwrO+CdsVYme9zzXOTJWclY52jUp9/0fZXUE2H/njS1oTvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rSMgM3UgTjsktBTB8+dwoPwNjo94GgxLMqJZGM9Ngew=;
 b=uKCT05hcQ+vjHfNomTVm6I0VlROAk9xQj6jWKwbvWxBT1qKRiA/5wpZVxSIq3QoyhWxZ83k7kBuIcOcX8CC9RF2hPXL5CrbkYI60MekdRf2J10FQk6IayOvF2yJHeO7MtO6hYmOLVWOhrO38oCGPBQYtgfMY1zhMrh960Bs/dCGZdqJ+N0SVV2mHbjn3Rc/BdCqNUhkzGsO4OUKt4t9nyopqQxVkY1eqcy9TPBVpHEBKqTk32w0Pu21ph5OzJQPRD6hfDyjofZVcb18hOLcbXGZwG7sR6la0TQuMVPusl3oGxOa0jM9iYNskQRqL4MNGL7b0fLIxEln9YLkPVlWrQw==
Received: from SJ0PR05CA0072.namprd05.prod.outlook.com (2603:10b6:a03:332::17)
 by PH7PR12MB7913.namprd12.prod.outlook.com (2603:10b6:510:27b::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.7; Thu, 4 Jun 2026
 11:44:20 +0000
Received: from SJ1PEPF000023D3.namprd21.prod.outlook.com
 (2603:10b6:a03:332:cafe::86) by SJ0PR05CA0072.outlook.office365.com
 (2603:10b6:a03:332::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.92.7 via Frontend Transport; Thu, 4
 Jun 2026 11:44:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SJ1PEPF000023D3.mail.protection.outlook.com (10.167.244.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.113.2 via Frontend Transport; Thu, 4 Jun 2026 11:44:20 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 4 Jun
 2026 04:44:06 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 4 Jun
 2026 04:44:05 -0700
Received: from inno-dell.mtl.com (10.127.8.9) by mail.nvidia.com (10.129.68.9)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Thu, 4 Jun
 2026 04:43:57 -0700
From: Zhi Wang <zhiw@nvidia.com>
To: <dakr@kernel.org>, <airlied@gmail.com>, <simona@ffwll.ch>
CC: <ojeda@kernel.org>, <alex.gaynor@gmail.com>, <boqun.feng@gmail.com>,
	<gary@garyguo.net>, <bjorn3_gh@protonmail.com>, <lossin@kernel.org>,
	<a.hindborg@kernel.org>, <aliceryhl@google.com>, <tmgross@umich.edu>,
	<jhubbard@nvidia.com>, <acourbot@nvidia.com>, <ecourtney@nvidia.com>,
	<joelagnelf@nvidia.com>, <apopple@nvidia.com>, <cjia@nvidia.com>,
	<smitra@nvidia.com>, <kjaju@nvidia.com>, <alkumar@nvidia.com>,
	<ankita@nvidia.com>, <aniketa@nvidia.com>, <kwankhede@nvidia.com>,
	<targupta@nvidia.com>, <nova-gpu@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, <zhiwang@kernel.org>, Zhi Wang
	<zhiw@nvidia.com>, Bjorn Helgaas <bhelgaas@google.com>,
	<linux-pci@vger.kernel.org>
Subject: [PATCH 1/9] rust: pci: expose sriov_get_totalvfs() helper
Date: Thu, 4 Jun 2026 14:43:31 +0300
Message-ID: <20260604114339.1565660-2-zhiw@nvidia.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260604114339.1565660-1-zhiw@nvidia.com>
References: <20260604114339.1565660-1-zhiw@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023D3:EE_|PH7PR12MB7913:EE_
X-MS-Office365-Filtering-Correlation-Id: 0b43f63d-e523-4ef2-c4f4-08dec22e9dd6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700016|7416014|1800799024|82310400026|22082099003|18002099003|11063799006|6133799003|56012099006;
X-Microsoft-Antispam-Message-Info:
	76BUCbpnPCSb/sgAPkPq4jhBSmha9QzvpkdlWkFUJQkeFniMZJpQ86HVVvZ9cQAu12ioYBAjYIun4UCR2bI6Ac+A+AE+Fx4LJfsygIaKslEnX6egP4tihl4LzipQExgWVo/g/evCLw6rqCOJBxW0OqeQo4wj+zEm/ls0tKs+a7jJPoY0NOhevMbMLTBYwo5QmiFkz8OLTzELt33nwpObcGAbGAXuooYFBpLn0BXleGpP+PVSHDjQ7agGFC5+CYeHyliz7klop3rwL7YevWEzOgza2bSlpUXJt1/rklpTNsesdZjQ39x6U5OIFtNu54GNGUOhEK/75n6QnbVcD1Lq9E1GY0feRnMDIvPdeElTuPlV9Z6REHwJ04Flpz4XS/ORKalUWK3Y0gX0WEAaS3/OOVmcFKtWVrB2lYv1DfuDyoPXJpuDx+DOqiraJp7zyYIXf7k/TxofmpmwOiUrLvPlRh47QJsyjdo72Tb7m6x8IMmhjbdNnETqBHOx/C2K7CVSOKPZpxELUtn8r3ytdFse6bUz+2VtWCQNkJqvelZjWDDVQPcndpmpN0RdFOZ+fjsC2MOiKz4hdj3M1SIAPKBe1pAIEpjiP7PumHmZHwAzmzALoG/UbseJp2ih0EU9FED1O200jc0nWmF9NUTLUIhpT8EaLxvBYu2152jh7Ruw//0FO2viEWO2O9JP5jz/Y4XCiBXd4r9pSFeyj54mwFo5HrKDhLrCJDJ9I4TIZhkV4QY=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(36860700016)(7416014)(1800799024)(82310400026)(22082099003)(18002099003)(11063799006)(6133799003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	evhU2WjcVRK35J4rZZqa8rkK32oEsrEGOzrFQAdcAC8qpvsXqhuGYzivLtn8ws/I6Z7a0xUPI6qcUZxsMO8XMw8FjDt5YFhU6KBKQ9Cf1kHBSEa9rrzjJPd6OtWFlh12D95+9FSIaw6rk+HGyS+PDbdnjKZFmY/YAdOIaaXa/bpM6QXWuVs/fFZaQhuO03xCTZuO9AB4miB/VeW1Sdttov1rTWkyOwk8qW5BWiagL9pR+pcxzCrf9c4JrGHHvSqLXa1bbyPkmkh+E7E4V0mJEAVpjtsH/RNg5/1XNR1Zcs1JIPUDihsjugBKHUJfy19Em5YnKaObaq7dl3CPSb29gNlko+CSkyywLl6jGJl6rpR0XMNGr5L0MV9mwrvAbF0EpEGGbmRo8/e1ywDoOY42SJsulNqBxTZeI1e402psL7SrrJGpafqRpv/CpVYcTqIp
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2026 11:44:20.4568
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b43f63d-e523-4ef2-c4f4-08dec22e9dd6
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000023D3.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7913

Add a wrapper for the `pci_sriov_get_totalvfs()` helper, allowing drivers
to query the number of total SR-IOV virtual functions a PCI device
supports.

Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org
Signed-off-by: Zhi Wang <zhiw@nvidia.com>
---
 rust/kernel/pci.rs | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/rust/kernel/pci.rs b/rust/kernel/pci.rs
index 5071cae6543f..d04e5f6841f2 100644
--- a/rust/kernel/pci.rs
+++ b/rust/kernel/pci.rs
@@ -450,6 +450,18 @@ pub fn pci_class(&self) -> Class {
         // SAFETY: `self.as_raw` is a valid pointer to a `struct pci_dev`.
         Class::from_raw(unsafe { (*self.as_raw()).class })
     }
+
+    /// Returns total number of VFs, or `Err(ENODEV)` if none available.
+    pub fn sriov_get_totalvfs(&self) -> Result<i32> {
+        // SAFETY: `self.as_raw()` is a valid pointer to a `struct pci_dev`.
+        let vfs = unsafe { bindings::pci_sriov_get_totalvfs(self.as_raw()) };
+
+        if vfs == 0 {
+            return Err(ENODEV);
+        }
+
+        Ok(vfs)
+    }
 }
 
 impl<'a> Device<device::Core<'a>> {
-- 
2.51.0

