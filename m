Received: from TYVP286CU001.outbound.protection.outlook.com (mail-japaneastazon11021128.outbound.protection.outlook.com [52.101.125.128])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26A97395D8E;
	Thu, 26 Feb 2026 08:42:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.125.128
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772095352; cv=fail; b=jLDM7L1ZhGbnEb0uyae8pOf4dfpa9Fhwkso56LZRyfYF6bVdpWOdCzMEh6rZgALugdSzNMMXhZxu9cV/MTbl3ZC2YPBwNV40juA8UpDoUu6R2qdpBE7G3Iix4XgLsx62+KIXK3XWwFV21YYR6rUucyIJghYmqM3yQjAV1+q7HFU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772095352; c=relaxed/simple;
	bh=ePzYzeAS4a/f2z6yX/Vhh5h8FpPS5dqmvTuKBikZWcY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=VgNh0W+qBqR8jTNpi0B0ExehQfr1nujSnUoONn7K2JOIRfCeM0SrLf1cLRdK9zUQkybj8sY3FwtQAuvmwBhRC8YQD5Ua37o2/+0LPgO0XQEu9ao3QNJc1aqy4kNybBXfOBN/o41y1GNQfwgEOxH1pMYyE5/2Yf+TELx/vseSR7w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=P7fogK9g; arc=fail smtp.client-ip=52.101.125.128
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="P7fogK9g"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bQYRmJHk4Rqn//sALHYo7JO//AwGuYEKIb8ZDJdzwlViGcLM5vPee+cbvYlwa1M59mErjG/c/yGtRIkBG4hM8lH9b4NAZq+L+wKRfLv7KXHGZw+XBWest0avWt6zob09B1l7unbdcsOLiM9/2TJcKHSdtIaR8UptaXXDC90hnPNUAfTpjS5o/woKdzeuwNjG14XLbWkxmhxjWyBOysF1/9UtnI9IxcM1YlvvQkWgAanvYbxGbz/KH78+YTR98msbf3YTmoGWUl8LBdGQRK3gR5/jsVPq27/HMpqGnyN7EI+aj4pIWyM6fmzhWznDfx0mxtSyk7RoNqzi8HQyi/YFLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K32wXZjXs7aNHBhCw4McNsYD4KcqNRgZteBe80i59uI=;
 b=DpUKw3dvAtYtD89rLhvyggVU4+u5aa0b/H99E1MNprBB1wqcXFc81uj+gW4VOXGY74tj1Ej+s6NbZNp9T5qFbUly93ceG6A5U17t2pEGClMQzx2RxoHObRY6EUzcixCr+LDro0Ury3dl53omxs7leu0kh/qqKuAAXHx9Zr2t+rBTZ5/Qj4wOXwxgjKDECgsELyeHsIbJzBRNcSJZ3KQFChbJTU4igXs78NpR018lqvT9xk7KfNMEkZd8dWP1sqKx7yv+rfYNTg2DYy7qtnLc0f11N6RBNkLkwNrPE9S+NFpFc+hJzLE0Ts8blxXpWv2xTwhCH7uKOyJ5jECnFZwBdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K32wXZjXs7aNHBhCw4McNsYD4KcqNRgZteBe80i59uI=;
 b=P7fogK9gn4La+TifwBDmruaTGiPJ0rWuqNnzwMdu106CDmAV1fKyyTjUL2PX5Nx9XnpqtBuhJr6QZap7RTYD6DXWyk/TQOV+qU5kj2536NfxSgPH5DuRHszuno3hwqBmlvdogxD36wdxvin0Iv0Cl7iGGjf2XDQdbWk+xt4CCpk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by OS9P286MB5288.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:311::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.23; Thu, 26 Feb
 2026 08:42:17 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%5]) with mapi id 15.20.9632.017; Thu, 26 Feb 2026
 08:42:17 +0000
From: Koichiro Den <den@valinux.co.jp>
To: Manivannan Sadhasivam <mani@kernel.org>,
	Frank Li <Frank.Li@nxp.com>,
	Jon Mason <jdmason@kudzu.us>,
	Dave Jiang <dave.jiang@intel.com>,
	Allen Hubbe <allenbh@gmail.com>,
	kwilczynski@kernel.org,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Ye Bin <yebin10@huawei.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>
Cc: linux-pci@vger.kernel.org,
	ntb@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH v5 4/5] PCI: endpoint: pci-epf-vntb: Switch vpci_scan_bus() to use pci_scan_root_bus()
Date: Thu, 26 Feb 2026 17:41:41 +0900
Message-ID: <20260226084142.2226875-5-den@valinux.co.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260226084142.2226875-1-den@valinux.co.jp>
References: <20260226084142.2226875-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0015.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:26c::19) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|OS9P286MB5288:EE_
X-MS-Office365-Filtering-Correlation-Id: ef1013c2-146d-4953-a6ed-08de7512f271
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|1800799024|376014|7416014|366016|921020;
X-Microsoft-Antispam-Message-Info:
	mx5j41c/4K2Q3se/aFzH0k4unNcc2DfNggWT5x+PvaVT4Ibq79FPBCiKwAwo/Nd478nkeE6jXsaF7uSmHc2IJBAZtCTiswlrTOSRWgp/i2yo8JmyJguGqb5UWsZvKu9xSC1rzBy1e8RgueR2XiSTNE5uMJ4KqPvhWwTANoSiIBs5HYRc0ow1AniQopYjNehk/494JL4CjGReupLChu9KulqL2pESh5KS7HFLc7T1EXHagkB11bZlsz030LI2prXjOXEbDrVZZDQU2UFLVqkV6VS1bWhd2Xbj7d2HET7rAN7RRwOJaTezBeqYMuYOq2+/sLI8LA9o4FxsRFq0Pqc0zXnIV2WxJVInJhtn6+KwvPL2WDTKFWm6pbCHqufRXqNLnQ8jeDN2xoORiYkgJ3KHzFDI+dRmikLE0b2R+QGn5nlOfZb85CXVti3mlO3Dpi8PRA/Xr4khluzY1U2DnlO46H/MoUvI/GcGRofvdZvnHx/++qFCV7qu8h+zOa/uycekpAnWkgrY3Vlk3olT/s9sz07vnxLBmzOarjbDJDSEGEdwCG6iPbaqr6G7MudA0AypdKYcNTxjcZH1ijmvOWLuImw2Xrd/dAVbdjaIDI3tXinzUScX5B+55RtZ4mGPQhEwFoDzw0u1Rn9XsvkgK1lSdgRE8DRUnL+l6H6f5Nst88TQYYqnqqXxeU6ApFw/U40yjLgYd/SSpU9CNpJfA4hvguQ2O4smnPI1sTQ4JMAa71VlYNJVMSTYZCn3F1DJtm62Pmr674nJ+p9r1vPXTK7ahg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(1800799024)(376014)(7416014)(366016)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?FbqAT2hIKBr49yhqftfzJ86kQRskHBRowGBrG8Z1zf8Bitz63LB4kSsv9uA7?=
 =?us-ascii?Q?2AzHeewn90BA+CfYYfSQD/86QXv62RHN6+6Pb4acZGShSoP8gr45wlS7ceuG?=
 =?us-ascii?Q?kBShSTJTasuQGnAodVeWR22AJ18CoDNTv+eM8o23vtv38v9S2+zJ8ChLYyOx?=
 =?us-ascii?Q?lhwnLNBk6SmES31q6SfKxlTUbPkSBmlKLI0eBtp/yczhCIaRzeOfBCi9Ad1g?=
 =?us-ascii?Q?w4J72RUuYmnbpCfNznWBqGpv+2iE2Zyz+OeWG+DqB4i0ElIDht7gl9DcRY6c?=
 =?us-ascii?Q?xKiNsbCjfnLOKFFMSy/+11C9of5A3WjXtlzunsiQJ9Gjbw6X+HUkYBGNyyk0?=
 =?us-ascii?Q?cDGILa9mWXPPXKMKS4PKADQEN73Wh7jp4eVklmlGCZLa2JHKaS+xXvlScTRW?=
 =?us-ascii?Q?8OSUW+4YmFPWHF5La972phmrhqvbKVbls64p+ss+xkDKFM2K76bCAxGV+mTZ?=
 =?us-ascii?Q?LzuxVfmQYiynYAYM5dQid+KIpoc9w2ZkcSkHgoE7sJ6oNuCbu7/RW1wwqivp?=
 =?us-ascii?Q?MSGGpMIuIY9Vh9AqTO0epDKDbIC3q0xzB2PXlc0doy2Oo2p0HTd8MESHRTTg?=
 =?us-ascii?Q?EYq0dG4X7rfO42ZE7qcsMaw4CZgcCLYTG+GEviCkRr0gh0hydRwcjVoSM4X0?=
 =?us-ascii?Q?W2poymSJXHS2Ceip/LVlg/ROMNOXY/3vmCA/nh58lyrrVUqi/7W8UF/4zHu/?=
 =?us-ascii?Q?TFQ8QEmRhjvGSBV0y1QEkQsGXU/ULtvER1FUNjX+VM/vD6T7WpwqljbRcGkg?=
 =?us-ascii?Q?FNo+zMY/UyukY4/84Yrnb1SyExq6aDGxnPiLAlZYEait/FXp8oMNvhuDoLSG?=
 =?us-ascii?Q?sV4gutFLnZwNPkunIUaOwuerNkfPTkw9g90lC4+kk+yFcQ+VFS24+No9OaSf?=
 =?us-ascii?Q?dpaet7j6wSANj6+ThvdAR5hLNfWlZA6CPIF3MP6K08XEu/Jg5o6G/PJMM7rL?=
 =?us-ascii?Q?DkjiWo5ITOy9U88oE1mjv0px9mOO/Qn3p9RTnLbRXg8Kt9/rp4qOPHNQHZ1B?=
 =?us-ascii?Q?PUp94uY3nf9MKkobJIi2te+SCIguP7Oa7XRITGhehKJ1TWm/mIDN7DlH38H/?=
 =?us-ascii?Q?9YfRsjxWRUfti5dcO1oxyyhHRYawkcGq3uQ/sTnFsSap0uVjz0vwwZbCRiuT?=
 =?us-ascii?Q?qdK38JB2LrThn4AHhvmBI3KQ34/7aBiF9kv2nVN3cSm/K+wqh+pC0spAhZCa?=
 =?us-ascii?Q?wS2d0SQrA1ImN5uS+3mz5GjCBq+QAZFG86MKN+3J0OQRpka8PMV/Zm8vYPDs?=
 =?us-ascii?Q?i50xlE2rtKm4yszo1WYcwXFeLi7wCDQWCoTmR2CWbetrZm4FDyxCPzEOSAtd?=
 =?us-ascii?Q?9p8PDvqbC/H7BYXHrlGTenUP+tAc3AgiBj61RfJEOQUlid6t0eFrOS2TF7Z8?=
 =?us-ascii?Q?tD47rCOyBPAuNUGd4bjsaFPeLvSNqbPFHQRHdwfzloUVkNMt45533JNW4U+d?=
 =?us-ascii?Q?TsfbUQXH1CnZBpc0anpuDBbdBoxFFRiATHZuMoQrF91l4ijy9QhsZwE9bhGi?=
 =?us-ascii?Q?m1wnv1Ai9nwqiEk7RpP2/zp/TH3PdyBImZSmkOwjA8+BpMbckOvrti2p/z+8?=
 =?us-ascii?Q?2a4lgW/bteDt7h579JNntwGs+re4K9Lw/5nTDozF17akqrXv9RZpWQWP0mvM?=
 =?us-ascii?Q?+gbFf+8p8agd2dI7W9ZBRTHYkblOBs26pxodteI/Z8rtrPPJhqKGG3VnkQ72?=
 =?us-ascii?Q?QQoxbRVwp5LQ0ivJV7iz27ONCp/i/xqYX3eEK0UrSVdbzPaLYZKh8aHABymo?=
 =?us-ascii?Q?JMf7SIygO8OEXLVaYWG3bpyYz0gXjvSc25NFk5rcvURGCoaN5pYE?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: ef1013c2-146d-4953-a6ed-08de7512f271
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2026 08:42:17.1352
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qbPg+Zy7m/npEXbh0BYEcItjFLYBNcX//t07F9jBZRX+Qk7V4v0/MzQ17TB9+B2Q13LOOlT5SoIGj7MTGCJPrw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS9P286MB5288

vpci_scan_bus() currently uses pci_scan_bus(), which creates a root bus
without a parent struct device. In a subsequent change we want to tear
down the virtual PCI root bus using pci_remove_root_bus(). For that to
work correctly, the root bus must be associated with a parent device,
similar to what the removed pci_scan_bus_parented() helper used to do.

Switch vpci_scan_bus() to use pci_scan_root_bus() and pass
&ndev->epf->epc->dev as the parent. Build the resource list in the same
way as pci_scan_bus(), so the behavior is unchanged except that the
virtual root bus now has a proper parent device. This avoids crashes in
the pci_epf_unbind() -> epf_ntb_unbind() -> pci_remove_root_bus() ->
pci_bus_release_domain_nr() path once we start removing the root bus in
a follow-up patch.

Reviewed-by: Frank Li <Frank.Li@nxp.com>
Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
Changes since v4:
  - Correct the subject prefix
    s/NTB: epf: vntb:/PCI: endpoint: pci-epf-vntb:/

 drivers/pci/endpoint/functions/pci-epf-vntb.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/endpoint/functions/pci-epf-vntb.c b/drivers/pci/endpoint/functions/pci-epf-vntb.c
index 805353528967..f353e9a57194 100644
--- a/drivers/pci/endpoint/functions/pci-epf-vntb.c
+++ b/drivers/pci/endpoint/functions/pci-epf-vntb.c
@@ -1220,8 +1220,19 @@ static int vpci_scan_bus(void *sysdata)
 {
 	struct pci_bus *vpci_bus;
 	struct epf_ntb *ndev = sysdata;
-
-	vpci_bus = pci_scan_bus(ndev->vbus_number, &vpci_ops, sysdata);
+	LIST_HEAD(resources);
+	static struct resource busn_res = {
+		.start = 0,
+		.end = 255,
+		.flags = IORESOURCE_BUS,
+	};
+
+	pci_add_resource(&resources, &ioport_resource);
+	pci_add_resource(&resources, &iomem_resource);
+	pci_add_resource(&resources, &busn_res);
+
+	vpci_bus = pci_scan_root_bus(&ndev->epf->epc->dev, ndev->vbus_number,
+				     &vpci_ops, sysdata, &resources);
 	if (!vpci_bus) {
 		pr_err("create pci bus failed\n");
 		return -EINVAL;
-- 
2.51.0

