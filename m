Received: from TYVP286CU001.outbound.protection.outlook.com (mail-japaneastazon11021130.outbound.protection.outlook.com [52.101.125.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C55302AE78;
	Fri,  6 Mar 2026 03:15:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.125.130
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772766920; cv=fail; b=doKLBM92VWMox3JQ+SZ8+AuG2jNijD5v/j2ZdougjHQLnS6Q9klkBhn2LngzGIPHQ5Txr+QewENSsWmIPOa61hWxFUB5o1IYMdYBEsJn8U4IXyfY2cGDTO3vOU9zgglKllwid6G5Sc5P6x6NobawjuSD9wgv+f+O3cNrDTzqATM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772766920; c=relaxed/simple;
	bh=ipyVibxU6P27bePTdFw4xhJHEbo6Ya7OQM+9Vn9gh/g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Xz51UmHQamB3mUWyhJ6o+qNgADqcWJzyRnQlEqLr8F4TVXF0QQMqUlvcsDoy00mzLooL6O4viO9VsKIhJL/HfgpDjIoiYCn/qXn48KpsYVLhoLZdFCnyUR6Xxb0GhhP4ZfjWreQ21i79ctJpPw7qZaEtd53AjqoBpSUwRCH3+HQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=aNzgPMPv; arc=fail smtp.client-ip=52.101.125.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="aNzgPMPv"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=g+Wfi4ck40qQh5k0qp3Qlao4zYcDcGLibpDjTj0OI8dPKuJVq/5NfRv9lUaxvKgmugKgK6R9QHfzwEBmH869RQqPCF3Mr/5fMyGYF6K9RD0GG7Oo/dhaNP0MZoJ4klYRi+uWl7VNTr04PK75tjKb2XT3DA3tH17fFYMBUxXWNpcl0s51ci5rmcdNhdslGcs20v+ifH0o8jJXl8wZrvzPe7NFCxaJ18JAxslT3eqgc7DEugk6w2GKN3setyO/3p43vmTKGlZ3+hJfdOjXcPHkwg6aHlyraxk7Ne2a2CukwGpyds3Ec9+PcrnLJFMfljxdbYfnoBFUma3GZmuRb85gvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NJbqzoJmov0AWuu+FGf9TercWH4YqrtSpL6t3+td3SQ=;
 b=HYNKi/BN2zxIII/ooz+V6EM06Gh9AKRo0GCBzoVMbmK2Tip5eL3dpk10s7xkDTr5AJ18XzULu8C9QA0vkOvfzh279d/IbACV+I9BEdI2UGKAwtvw9eNRlZ38ymZwr5pWqSpeQLz7t4uLGGSqLZFcoqpl7VtwfCSVyunBoV/4rX23SX0Vaq9qJzwPwvDC08WAhJixdhoMowT5mitACRAggZJ3NTlvub7aZHd6+M+MZAQU8uU60LKYbPPDfSFuh0nDHD46Qt2342zck0b3RMmTaMWVQNhyL5i7Sojolqq8LbvIBv2qLjurhjUgZn25Cs9AWCw36lMy21uRQGLlZLjkRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NJbqzoJmov0AWuu+FGf9TercWH4YqrtSpL6t3+td3SQ=;
 b=aNzgPMPv8oXBn6A9c7gQfEKVIDT2/fFbcAvqa4OVFfGOGLD0CmCi514rpZJ92j4bSiD4bm9J7QyA4QgKptzS0sddoKORDDLYPtBSiVVwMdCwL+3CkpyuJaeQd8zSXtNM8e8muteIKUzr5AXLbFi8hfeSZVNEz/a0V6v/UF6kfos=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by OS9P286MB6984.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:414::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.19; Fri, 6 Mar
 2026 03:15:12 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%5]) with mapi id 15.20.9678.017; Fri, 6 Mar 2026
 03:15:12 +0000
From: Koichiro Den <den@valinux.co.jp>
To: Jon Mason <jdmason@kudzu.us>,
	Dave Jiang <dave.jiang@intel.com>,
	Allen Hubbe <allenbh@gmail.com>,
	Manivannan Sadhasivam <mani@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Frank Li <Frank.Li@nxp.com>,
	Niklas Cassel <cassel@kernel.org>
Cc: ntb@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org
Subject: [PATCH v2 2/3] NTB: ntb_transport: Use ntb_get_dma_dev() for DMA buffers
Date: Fri,  6 Mar 2026 12:14:42 +0900
Message-ID: <20260306031443.1911860-3-den@valinux.co.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260306031443.1911860-1-den@valinux.co.jp>
References: <20260306031443.1911860-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYXPR01CA0044.jpnprd01.prod.outlook.com
 (2603:1096:403:a::14) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|OS9P286MB6984:EE_
X-MS-Office365-Filtering-Correlation-Id: c86b88ec-8b98-43dd-19a9-08de7b2e94be
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	S3EnfgfA8XqerPMFajZ3r9Zq/27zLJ8sdTh3+f1N/9jc+9TeQPtjl9hSfDLUHOZPder3WWQnGmYQgW6wwhdnUuztHagnqK2tmtgbBi2gYAbbbFBBttndNX3yVm2nUtR9AoOCm9wMgHvJt8nqyE3KuE5zqNGmd/eSVW63ccCJKpfnGS6RyOyMCYpuZQkVMIwfmRHc2OtlfISNvYDSgXUrCbDAGb5OxaV8MafYW8GtadTVLyYEKEXPtwd6beWeQ7425VUA44T6IotVKI28fIWEqMBhbkmgiSCnUXSFqMjOA4U7Bq/utdYAPYXhZtmTOX52VjKhGX4muf59nooKCWUYA9QX0OHmr0q4wxsOpNlX/u2ux3meoQ8c3bLIKRYszyeYAeppsDLeqbLxudvl79CsEWvboEIY65jVSsz47NM+LnwW2hq922Qaz9ApiJjIIoGPHKiL9jslJYxnMavFzd5yMlCYZMGaNnFAS8UxGCTSWplJJMy0SDf+Nkk/JseEeI2f9N5X4+bo0eRxHG9E3lwjbrHn8jOffl5H8oNlAvy08/6sKTU7eyFVG4kGXwu40mWfwW99QNbfqbZ8m9Kk8w0ppBqPUL9GawyfhGNVzvnxWIuwmGDVBtmmNZ7Q2qgCyjPR/Jb7Ks1ijyRZBZaL1hdMKNzfc7be7Piwdp2u+nAw+d/u+3Lv1eK5cSUa/7zafZfMMiXe2X06OQwJuVu4DkopG1zFADo/7GlnF0ys66hF4+k=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?BJdyghsbZ46gIQKMFYeQgECX6tzQ66UZddDHH9182WK7+/L5e8KrEHECb5Ir?=
 =?us-ascii?Q?yOmG8TQdwjXJroOj2xYA35AZPI9xyF+s9AcBm2Bg3sMkgtRm36A2Zze13BRl?=
 =?us-ascii?Q?vXhdN4Y360sNMCWyMm+n8DJkS6rVVIb3SiTrpccJ7bLylSkdIlG1znP5E9J6?=
 =?us-ascii?Q?OIYjiyqdN8rGmDvg3a+w/Ts1qonbfxIz0brjmhdeD7STD/ZWQUHe7YcFEkQz?=
 =?us-ascii?Q?f4WGnnvsrtqYtU62fVaZ/jhgkqHGbWvJnH4EiEXJEr3n+ur5fM7epDoG80HA?=
 =?us-ascii?Q?NQ6pkVlw5Yp56kD1O8ZHB0ysFJpQwQdU36QInpTwIBxfnT+s8JdmxkA2lFt6?=
 =?us-ascii?Q?47uqMZzCZocEQdPO6dYWX16aqTX3H6JiohI2v2I4zfZT700pdWoWQTmsRjOV?=
 =?us-ascii?Q?OVS6NRNf0DgrprZr47c8DBrm2JhoOqRtoW/KJZga8V8NxIVwJ3E/w8QcArZr?=
 =?us-ascii?Q?bl4pHYDdukBSb36B4DnRGDqlj7GtjDy/XqpmNsEr7vk4zS7oxqPYgZA+auA1?=
 =?us-ascii?Q?TXHnc61gYw69OSoqNA/1hSJv9cBHlUmdOU3KGJG+92Ewr6nOT19ACdrrKd1c?=
 =?us-ascii?Q?7kjwnZUDtJPtUJX2uZoOroGrQhuQFjTqBduZ8u+v6NWemt6Ajrf918Pjuh9G?=
 =?us-ascii?Q?H7L2YD2lnL9pJlbI2Iba0LcD2r1u/qLKe2HeLqvpHMbkAanK24xRiugukwi4?=
 =?us-ascii?Q?dCh+tqwr/fx/6gjzX6VEKkCADYvszGUor5K5PrF4jOf+6jvKZ8uam2HGpBPw?=
 =?us-ascii?Q?nh+/BGZH456bmfFisJpEvX8+/CjvvljHXPMqSWXIqnPFa7Oig4suMJrZGcfi?=
 =?us-ascii?Q?xUUQ8X227OJDJz+6tYsV4iXvNT5MF2tBpqjlE9EO9wvz2skU+wOLmnB+xDHx?=
 =?us-ascii?Q?5ReuS17CUagcTD4lN3Vn+QJUOHga7G0maixlbP1eXjCEe1VUrPWdHO3PxfNd?=
 =?us-ascii?Q?p9P2hQsYSZHoLZfZHkYlNPYMg3Hq8P3p+c6nMndhcUua0GircmD7oJ568zGn?=
 =?us-ascii?Q?fug2G7K4UnOAlFnYQhzjKxDSjmcOQvvVMtCuXj1tnzkkKR00w40ta8ijLF92?=
 =?us-ascii?Q?hyLIVAgco0clh+h/Q/MD3ut6/APEtdcQKgXvH7leUT4slqdIDAEfHr2oJafE?=
 =?us-ascii?Q?zfLpBE0k278B09DDeRSqDYAiotnQygVLLwWH1eMESMCdB/42UKcGlbfXk/vQ?=
 =?us-ascii?Q?6OWtxOcT7DREk3TlIf/ZUIPEa4oh37ih28o9OiQGrbSPDlBSJK3/ux5m3r33?=
 =?us-ascii?Q?Qbj22NrT12J/6omoIs6TwHau90wstFtPynErw+BE2yIG2kvkaXHVjHESamny?=
 =?us-ascii?Q?iRIBSdrIOcEynYc08nK59OQ2Dh7uy/0ueX/kPiDG5su5imlFlRvEefwL4WUA?=
 =?us-ascii?Q?R1MNOhtiAqiMsmDxNCOr9qT67TBnAUC0zWlc6/usX2UA4kCrjON0OvGCRrFB?=
 =?us-ascii?Q?Qrc2E9USdpfIkIZhzThbt0zWanP7hSHmDwioQiKguUwMwKL8SFs8YLmqipv1?=
 =?us-ascii?Q?ilp+RcOesqb8H533vCXQ8Y3mTzNUh5CG+WbUm2Swak8mJTp66NRf7AFONOk/?=
 =?us-ascii?Q?xrsW/fbjmxPhOoJi+T8ka4rkgGg/CpEUtkIKsjnRWXBYV0kWjvcqBDpzzRwf?=
 =?us-ascii?Q?DaEO+iaVUh/SpAaFYpncMStR2MqVu+gEu5gomXkHXuMMOqbIqOL58DwMFsnw?=
 =?us-ascii?Q?pN8UVV8f6bnXjwoPA5lq/Aldfgeu6zsHSyco/1xwjvO9noHrKeUq4I/Nqyy8?=
 =?us-ascii?Q?bRGK0YxmcwDmT+xTrfBF1swiu04HZfPiIrMkBs41rIu8Yk5l8eAc?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: c86b88ec-8b98-43dd-19a9-08de7b2e94be
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2026 03:15:12.8181
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /iOhtK/S7tf+1IUPXzUn9fBUvsWRx0GRAFHMYlg8uzQao6df1usK/df0OoKveTl7OGdbigT7xk5fg+aOkX6wXw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS9P286MB6984

ntb_transport currently uses ndev->pdev->dev for coherent allocations
and frees.

Switch the coherent buffer allocation/free paths to use
ntb_get_dma_dev(), so ntb_transport can work with NTB implementations
where the NTB PCI function is not the right device to use for DMA
mappings.

Suggested-by: Frank Li <Frank.Li@nxp.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
 drivers/ntb/ntb_transport.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/ntb/ntb_transport.c b/drivers/ntb/ntb_transport.c
index 78e02fe6caba..a67cc26e47b9 100644
--- a/drivers/ntb/ntb_transport.c
+++ b/drivers/ntb/ntb_transport.c
@@ -759,13 +759,13 @@ static void ntb_transport_msi_desc_changed(void *data)
 static void ntb_free_mw(struct ntb_transport_ctx *nt, int num_mw)
 {
 	struct ntb_transport_mw *mw = &nt->mw_vec[num_mw];
-	struct pci_dev *pdev = nt->ndev->pdev;
+	struct device *dma_dev = ntb_get_dma_dev(nt->ndev);
 
 	if (!mw->virt_addr)
 		return;
 
 	ntb_mw_clear_trans(nt->ndev, PIDX, num_mw);
-	dma_free_coherent(&pdev->dev, mw->alloc_size,
+	dma_free_coherent(dma_dev, mw->alloc_size,
 			  mw->alloc_addr, mw->dma_addr);
 	mw->xlat_size = 0;
 	mw->buff_size = 0;
@@ -835,7 +835,7 @@ static int ntb_set_mw(struct ntb_transport_ctx *nt, int num_mw,
 		      resource_size_t size)
 {
 	struct ntb_transport_mw *mw = &nt->mw_vec[num_mw];
-	struct pci_dev *pdev = nt->ndev->pdev;
+	struct device *dma_dev = ntb_get_dma_dev(nt->ndev);
 	size_t xlat_size, buff_size;
 	resource_size_t xlat_align;
 	resource_size_t xlat_align_size;
@@ -864,12 +864,12 @@ static int ntb_set_mw(struct ntb_transport_ctx *nt, int num_mw,
 	mw->buff_size = buff_size;
 	mw->alloc_size = buff_size;
 
-	rc = ntb_alloc_mw_buffer(mw, &pdev->dev, xlat_align);
+	rc = ntb_alloc_mw_buffer(mw, dma_dev, xlat_align);
 	if (rc) {
 		mw->alloc_size *= 2;
-		rc = ntb_alloc_mw_buffer(mw, &pdev->dev, xlat_align);
+		rc = ntb_alloc_mw_buffer(mw, dma_dev, xlat_align);
 		if (rc) {
-			dev_err(&pdev->dev,
+			dev_err(dma_dev,
 				"Unable to alloc aligned MW buff\n");
 			mw->xlat_size = 0;
 			mw->buff_size = 0;
@@ -882,7 +882,7 @@ static int ntb_set_mw(struct ntb_transport_ctx *nt, int num_mw,
 	rc = ntb_mw_set_trans(nt->ndev, PIDX, num_mw, mw->dma_addr,
 			      mw->xlat_size);
 	if (rc) {
-		dev_err(&pdev->dev, "Unable to set mw%d translation", num_mw);
+		dev_err(dma_dev, "Unable to set mw%d translation", num_mw);
 		ntb_free_mw(nt, num_mw);
 		return -EIO;
 	}
-- 
2.51.0

