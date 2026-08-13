Received: from TYVP286CU001.outbound.protection.outlook.com (mail-japaneastazon11021111.outbound.protection.outlook.com [52.101.125.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37B2F423E91;
	Thu, 13 Aug 2026 06:38:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.125.111
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786603102; cv=fail; b=HP93/IiQ43GdNvWRBzmkQKJZSy7HlCLHlb77iLoWSrCkwzSRKpO9IxMncB6NUdu62/0wKb9xT4XQt9ZdzY4bl88FNhPbW8EO3v1m/gBg8F6ObnJNX1vQE2kBF/+/nsi0bevRgEHOMVzYRpAorbuDdenfTpBRBlL7HAeJUD0eWoA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786603102; c=relaxed/simple;
	bh=ackDJwTcsi4IOLiFu6vJm8HJoNecTL1wU5TfNecegqg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=aTwM2LNO+D5r35Ox5OPfZ8MPvt/nhUzaxvbUCNo7NmLr3zLcC2IaP3irMsiZ4KsvdVK7nh4CafaleSrRpjGl639zsHNA/CkcNvC4HgkiUllnhCuGEKKJfrhqexBMSsUokZnfqfCzTwCItixBNDSWte/lx0sCT0n/86wdrFbekhk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=pKkOFRPv; arc=fail smtp.client-ip=52.101.125.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="pKkOFRPv"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rKCj5KTwfVafZobMv0Pg+hF2Wen85koMvHh/6wrTjJzLdPihnFoKD624Ej5DF/jgZHAnHwxMX94PJt0LZ7j9Q+SXK9pEZIwj/PDZcxooHP8O+DPQ0Ktq6Qkc3cwF83JMhx1YMx666UhiCogST8M/zrA0AAKvBl4WCGsOGy6QIvVZYcxUFO5LygLv7Yh2MCt2KsSfzQt/FNo+5hE4OY5biUKCNimyweNWzl2DFxx7AI+tuEJSAMDfwkL0Er/wyRJ0DscbTBenptf/ZfLIpoSWpHBeXN3CZzB0g40BgWfkKjQPAAXW7NQ8ueIcjKPfAfGy/rdNlqTtBS423ooLwPVvEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=syZEZUKWo57xOhYia4CN/WEtye+H6lDRcvXppTLB+A8=;
 b=X+qQyhAnBRu7lKsW8CEJZEZSfggtsQ0W5b5IJLU0jZYib3m13zfanMJD8Im9nrCMXsPShtm5JSKJjbTAJTSd4boEwdLd+JdO4YpZ41feZSf2bT0wrUS9peP5QxWQJTTSjM322CLNrnMgHqHXKRn5xDHgh/47DXnEsN5cF8CdvjtH427Vu71Uw/f6f6ycYkD7NIrwzWH3X/ValZJvhuh+Jc7rI401UOStPU+p0WiDUUPepL0Q8BHK0jNYq23doOyxu87AEPiAbuUJNFFDeWPbdugI04eUj8CUv5ROkXf2Cci2IBr6B0JsnEiKEdZzJnGHXIQ91M2bvWaFdp/TRRb1sg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=syZEZUKWo57xOhYia4CN/WEtye+H6lDRcvXppTLB+A8=;
 b=pKkOFRPvB99fSlg6+SeF7i9CygblkqIqAlPEKNEEVAIhFTLk+Klnx/z65hmckPec8KdrOspDUhY9qJU+oZ5bq0b64Z8cxJC3Hg4qbpagyAgkY+WFowbBP2MbKMWyjjugoK0FHMpVtXitpNg13ahK0M7xo4WWJZ6KWzDzGtdx1sY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from OSOP286MB7730.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:468::22)
 by TYWP286MB2252.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:13f::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.14; Thu, 13 Aug
 2026 06:38:12 +0000
Received: from OSOP286MB7730.JPNP286.PROD.OUTLOOK.COM
 ([fe80::b7ab:6af2:d18e:4a71]) by OSOP286MB7730.JPNP286.PROD.OUTLOOK.COM
 ([fe80::b7ab:6af2:d18e:4a71%6]) with mapi id 15.21.0315.008; Thu, 13 Aug 2026
 06:38:12 +0000
From: Koichiro Den <den@valinux.co.jp>
To: Manivannan Sadhasivam <mani@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Frank Li <Frank.Li@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Vinod Koul <vkoul@kernel.org>,
	Jingoo Han <jingoohan1@gmail.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Niklas Cassel <cassel@kernel.org>,
	Damien Le Moal <dlemoal@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
	linux-pci@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	dmaengine@vger.kernel.org
Subject: [PATCH v7 10/10] Documentation: PCI: Add PCI DMA endpoint function documentation
Date: Thu, 13 Aug 2026 15:37:57 +0900
Message-ID: <20260813063757.3131865-11-den@valinux.co.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260813063757.3131865-1-den@valinux.co.jp>
References: <20260813063757.3131865-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY4P301CA0032.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:2be::10) To OSOP286MB7730.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:604:468::22)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OSOP286MB7730:EE_|TYWP286MB2252:EE_
X-MS-Office365-Filtering-Correlation-Id: 0dc97a4c-3c00-43d5-c82f-08def90572ab
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|366016|1800799024|23010399003|10070799003|18002099003|22082099003|56012099006|3023799007|6133799003|10067099003|921020;
X-Microsoft-Antispam-Message-Info:
	6OqdwJ/W/SFpWP6eCRmt7PxZrRtUq/bC0720+vVxDfVJoplSAiAsNpN78hVlkWIMGGlqPWAoT2ubBSi/t1wb9SZ9qU3xsZG/4N/RauLi1HRa0L7Ek0Qmab5cu1hC4S3faXvJyjRy2jRu5/Sm6MtZwxwKFgafomXkwKCZd81QntBiVjbMdDMDu3fvj3RJfkVJ1bF1yzTOR+EOj4PbbWe7jz4a9H/jYqDMoiYUKAuPI+X0vAuLLtvhPvgTLMrCgzCTugqX6NVj4Wk7I7aU52E4TqKJyFCJuNPO7vT89FBE7WdyaNL1i6wl0Qtzx45HVYutG9tc7aJk+jfgYUDKETe+4UGHY7Z2jrSBEOVZZ119PYFFqZbNVjcw4rmX+IZJhF8R++SGD0ayKZ8KSdZtdqE6ypY+PG1WYvKYoWiqMTfCeYm0j//jaeGs+C3OzNv4JnCZ4iSyw/m5bhT1QS+kQqvlTEzwUzhgZfc6ankcrwrcVQQY3IEWQX5Pa2jGgBBagwkRETBVJ0PFnfV6mIa9NqRTz1yDThnzpTIYoHRcOZ27PqG2+L+SMnlN+tDrrzTlNuxhuQe8FiLLo/UVqOhavOrQR1tbxR2Pzl3Iwpzv0KZCz/jCMMSs4esC3V8Na1I0lWfYgcPEzsCMdo0qkI3wyRVUdWKn2U0llRkQx9azu2jCRcN3g7kB02rCehpR2edVsIGk79wAoF+ufX5WlwyqWAvR0Q==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSOP286MB7730.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(23010399003)(10070799003)(18002099003)(22082099003)(56012099006)(3023799007)(6133799003)(10067099003)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?UZr3rQjVQv/2A23AldURqa92eX/4R5nHuPpsBN70HTBUagb7Frahdtv8LGbL?=
 =?us-ascii?Q?nA9Ev1RlhDL8iEOI6N5WWPGiDq6GrlQEnyna4SZOM3W0ClC6opiW0p7wueEN?=
 =?us-ascii?Q?mO1Rmo771i64GIoAOutYx22eU7krFiUOLEKpjKBdYiNYQdKg2lcBnFGYdipS?=
 =?us-ascii?Q?OQnsZYA0NdxEHA4fDRzmigZibGx1xBFQHRVpMaHym+E4QTbK3GgymsgVWIw7?=
 =?us-ascii?Q?9z4sb0CWO0rIVZWEgktJsaS4mWckA2L9NO3adwrWidSeLQmgGD8fG0c3cSRI?=
 =?us-ascii?Q?qU4HaGcghx2nAHXrsG6J0Kz3J24g3Cl/HFNl02CxW3b/cpJSBTudHPoeRYQk?=
 =?us-ascii?Q?se7dQoXh4pDn67lq63vzBJ0icjJWU9t5wsoP0LS3gETgOct7b7rze3/ar72m?=
 =?us-ascii?Q?pMlG7r54MZxUQwBsPWTvj/zUR4UajIyqE2sQNM0IV+eL7pdgTQ0eMDEHhqx/?=
 =?us-ascii?Q?LfzlAR+fOstujPQH9LlOSvTm0YICHWgmed2tM/GrukuGRNmR84X3cCirJIqa?=
 =?us-ascii?Q?tHybRPNIn5gDGrwsxe6/510WheH8O+vDQbsOX14Mf43yF4yM890opu1vGPJg?=
 =?us-ascii?Q?5ow2Of0/2S7IIL55LMNyp/lFmKqHob6Xl2JyQQvBavDPsg5Muza7ZGmYR+B4?=
 =?us-ascii?Q?GLssUy6AegJL1sJk0tDp2Gx2jJy5/Ry/U9loTBfp8JcPCuvNmHtcZ4ZsjH7L?=
 =?us-ascii?Q?T+ZPm2cYXVB/2dttld3bkoaffCJmidy1ty8mBy//+4QvJOD0VQJ1kgUyjZOp?=
 =?us-ascii?Q?JbEtiql4TPTIVjq8d3LZ9gLocrPZm0ogF2IbA2CYpmrS8PAEivcmWzQOcHsK?=
 =?us-ascii?Q?2PztzbWtUtkfT/nxnW4ZAGI/4cYuRYxFEun6GMx5HF4iFrJODxSgpbtUlFDZ?=
 =?us-ascii?Q?QY/EXxIRhROP21me7EHM4WsPxwRYNt84mPnMyApkTgxZPI8ufp0fFXk1cPgt?=
 =?us-ascii?Q?UVnfZeqvpvdLq3SDfn6eNAAzYRktd+DuoCztGppuCyE/czTbwMmXAc4n00uA?=
 =?us-ascii?Q?APf5wDuz7OgSYkhRjU0+zBLk+G75rKCqs5PC1CUfLxKzCx/kY66x6YiXXMBv?=
 =?us-ascii?Q?FYY2I6XTgTcL32igAFSVLhkjPdPksCb2a4qNGHmLoFI4bsRuTL0YD5a3d7ng?=
 =?us-ascii?Q?fmW0l+XOL7LIowwpyHvVMCkGw0URkFm+vFLfCM6D5+7L0gJaRphfytFjbFX7?=
 =?us-ascii?Q?6R/CLjJiZRJjxacOB3EFCZWPjAhy46MHD/d/K+SMDdCOt0hcKLzMKj3LYdeH?=
 =?us-ascii?Q?nqW+ukEMXWPJ8wBN0bSpJqEeexLHpVflAV0oK8sb1pI0NNHUSTqOuS9Yl9UG?=
 =?us-ascii?Q?2Fs+R09y8KJnzIIyrtPifS8i8Ot87ZCeKp96jIFJuHWq9apbP9GlV/donzYg?=
 =?us-ascii?Q?ezNEPxdm6RjO3Hcmjx8kYUrHM2BVLoi7YGws0hD4DaL6y2NVa2mLyS1fbhFF?=
 =?us-ascii?Q?uvNEOodI7yfSmOBKOpv4ir3Bjs4rHnAtUeT/4I4Z2dy6YvjgH38d0peILAV2?=
 =?us-ascii?Q?F17UhEXc4QeNsWBCwVvBHjlp3skZYksA6wrlpVDORP5IYkrqU+qRkFv2dERr?=
 =?us-ascii?Q?b1+qJCUSz9SBZJ9l4Dzg26phA0wcGu2UrV8CDitO9A8TrDFEVdFYrD1nPNl0?=
 =?us-ascii?Q?JfqojhFh7CE/2PYkw8PjmnZ27GRB8PlwednJesGH/mm145PQ7U2Zhmn0IKG0?=
 =?us-ascii?Q?RndsOlxDoU5Pa/FOJJBerRCNJlGWp1SI/ySs+qa4qjpadYC6iPBDuMooagyP?=
 =?us-ascii?Q?I2WNDUHEUNSyvFWpVoNO/sAbJJzcoNC0Z311mBFwcCq0FS8YFPkr?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 0dc97a4c-3c00-43d5-c82f-08def90572ab
X-MS-Exchange-CrossTenant-AuthSource: OSOP286MB7730.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2026 06:38:12.8016
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SHHZQdNvQVdXi2pfoaAdFIdmaDP3d2Is8EGn8vwNpRwttomeWHNwIlgdjEW8E67p1NwZ/Ka0Ukv+TzEkbZXcQQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWP286MB2252

Add a function description and a user guide for pci-epf-dma. Describe
the BAR-resident metadata consumed by dw-edma-pcie, the configfs
attributes, endpoint controller requirements and the host-side DMAengine
usage model.

Suggested-by: Randy Dunlap <rdunlap@infradead.org>
Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
Changes in v7:
  - No changes.

Note: This patch was previously posted as part of the separate part 3
series. No v6 of that series was sent.

 Documentation/PCI/endpoint/index.rst          |   2 +
 .../PCI/endpoint/pci-dma-function.rst         | 188 ++++++++++++++++
 Documentation/PCI/endpoint/pci-dma-howto.rst  | 201 ++++++++++++++++++
 3 files changed, 391 insertions(+)
 create mode 100644 Documentation/PCI/endpoint/pci-dma-function.rst
 create mode 100644 Documentation/PCI/endpoint/pci-dma-howto.rst

diff --git a/Documentation/PCI/endpoint/index.rst b/Documentation/PCI/endpoint/index.rst
index dd1f62e731c9..cd4107e02ec2 100644
--- a/Documentation/PCI/endpoint/index.rst
+++ b/Documentation/PCI/endpoint/index.rst
@@ -15,6 +15,8 @@ PCI Endpoint Framework
    pci-ntb-howto
    pci-vntb-function
    pci-vntb-howto
+   pci-dma-function
+   pci-dma-howto
    pci-nvme-function
 
    function/binding/pci-test
diff --git a/Documentation/PCI/endpoint/pci-dma-function.rst b/Documentation/PCI/endpoint/pci-dma-function.rst
new file mode 100644
index 000000000000..4de02553f5ff
--- /dev/null
+++ b/Documentation/PCI/endpoint/pci-dma-function.rst
@@ -0,0 +1,188 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+================
+PCI DMA Function
+================
+
+:Author: Koichiro Den <den@valinux.co.jp>
+
+The PCI DMA endpoint function exposes an endpoint-integrated DMA controller
+to the PCI host as a PCI DMA controller.  A matching host-side driver
+discovers the endpoint DMA metadata and registers the delegated channels with
+the Linux DMAengine framework, so host DMAengine clients can submit
+transfers.
+
+An endpoint Linux system can already use an endpoint-integrated DMA
+controller locally through the normal DMAengine API, for example to transfer
+data between endpoint memory and host addresses reachable over PCI.  The PCI
+DMA function provides a different ownership model: it delegates selected
+local DMA channels to the host, so a host DMAengine client can request and
+program those endpoint-side channels through the host's DMAengine API.
+
+To make that possible, the endpoint function publishes the DMA controller
+register window and descriptor memory layout to the host, reserves the
+selected local DMA channels on the endpoint side, and lets the host program
+those channels directly.
+
+Constructs Used for Implementing DMA
+====================================
+
+The PCI DMA function uses the following endpoint-side resources and
+configuration:
+
+	1) DMA controller register window
+	2) DMA descriptor memory for endpoint-to-RC channels
+	3) DMA descriptor memory for RC-to-endpoint channels
+	4) MSI or MSI-X interrupt vectors selected through configfs
+	5) One endpoint BAR used to publish metadata
+	6) If needed, one endpoint BAR used for dynamically mapped DMA windows
+
+The endpoint controller reports the DMA controller register and descriptor
+resources through the endpoint auxiliary resource interface.  The PCI DMA
+function uses those descriptions to build the host-visible metadata and to map
+resources that are not already visible to the host.
+
+DMA Controller Register Window
+------------------------------
+
+It contains the DMA controller registers programmed by the host-side driver
+to submit transfers, control channels and handle DMA interrupts.
+
+DMA Descriptor Memory
+---------------------
+
+It contains the descriptor memory used by the DMA controller.  The PCI DMA
+function exposes descriptor memory for the delegated endpoint-to-RC and
+RC-to-endpoint channels.
+
+MSI/MSI-X Interrupt Vectors
+---------------------------
+
+They are used by the delegated DMA channels to signal completion and error
+conditions to the host-side driver.
+
+Metadata BAR
+------------
+
+It is the endpoint BAR used to publish the endpoint DMA metadata and handshake
+bits.  The BAR remains stable while the endpoint function programs the DMA
+windows.
+
+DMA Window BAR
+--------------
+
+It is the endpoint BAR used for DMA resources that are not already visible
+through a fixed BAR.  The endpoint function may switch this BAR to subrange
+mapping after the host-side driver has found the metadata BAR.
+
+BAR Metadata
+============
+
+The endpoint function places a small metadata block at the beginning of the
+selected metadata BAR.  The format is defined in
+``include/linux/pci-ep-dma.h``.
+
+The host-side driver scans the function's assigned memory BARs, looks for the
+endpoint DMA metadata magic, requests DMA window programming, waits for the
+READY bit, and then parses the metadata to find the DMA register window and
+descriptor windows.
+
+::
+
+	+----------------------+ metadata BAR offset 0
+	| endpoint DMA metadata|
+	+----------------------+
+	| optional padding     |
+	+----------------------+
+
+	+----------------------+ DMA window BAR offset 0
+	| mapped DMA resources |
+	+----------------------+
+	| optional padding     |
+	+----------------------+
+
+The metadata can also reference resources that are already host-visible
+through fixed BARs.  For example, an endpoint controller may expose the DMA
+controller register window at a fixed BAR offset while descriptor memories
+are mapped into the DMA window BAR by the endpoint function.
+
+The metadata is BAR-resident instead of a self-contained PCI Vendor-Specific
+Extended Capability (VSEC).  Some endpoint controllers do not provide writable
+configuration-space backing storage large enough for a new VSEC payload, while
+they can map endpoint memory and controller resources into a BAR.
+
+Channel Ownership
+=================
+
+The ``wr_chans`` attribute exposes endpoint-to-RC DMA write channels.  The
+``rd_chans`` attribute exposes RC-to-endpoint DMA read channels.  The function
+reserves the selected endpoint-side DMAengine channels so that endpoint-side
+DMAengine clients cannot allocate and use the same hardware channels while
+they are delegated to the host.
+
+The current metadata revision describes channels in dense, zero-based order.
+For example, ``wr_chans = 2`` exposes write channels 0 and 1.  Skipping a
+hardware channel in the middle of the exposed range is not supported.
+
+DesignWare eDMA unroll and HDMA compatible layouts require each exposed
+direction to be delegated as a whole.  For example, on a controller with two
+write channels, ``wr_chans`` must be either 0 or 2.  DesignWare HDMA native
+linked-list mode uses per-channel registers, so a smaller dense prefix can be
+delegated.
+
+Interrupts
+==========
+
+The PCI DMA function exposes DMA interrupts through MSI or MSI-X.  The common
+endpoint function ``msi_interrupts`` and ``msix_interrupts`` configfs attributes
+select the interrupt vector counts programmed into endpoint config space.  At
+least one MSI or MSI-X vector must be configured before the function is bound
+to an endpoint controller.
+
+Transfer Addressing
+===================
+
+The host-side DMAengine client supplies the endpoint memory address as the
+DMA slave address.  For example, the ``dw-edma-pcie`` endpoint DMA metadata
+parser passes that slave address to the DMA controller as a raw endpoint-side
+address instead of translating it through a host PCI BAR resource.
+
+The host memory buffer used as the other side of the transfer is still mapped
+using the normal DMA mapping API on the host.
+
+Endpoint Controller Requirements
+================================
+
+The endpoint controller driver must expose the DMA controller register
+window and per-channel descriptor memories through the endpoint auxiliary
+resource API.  Endpoint controllers with other DMA register layouts also need
+matching metadata and host-side DMAengine driver support.
+
+Current DesignWare endpoint DMA support exposes only channels with descriptor
+memory; HDMA native non-linked-list mode is not supported yet.
+
+If any DMA resource is not already host-visible through a fixed BAR, the
+endpoint controller must also support BAR subrange mapping and dynamic inbound
+mapping, because the DMA window BAR is assembled from those resources.
+
+Current Support
+===============
+
+The current host-side support is implemented in ``dw-edma-pcie`` for
+DesignWare eDMA unroll, HDMA compatible and HDMA native linked-list layouts.
+Other PCIe controller DMA implementations need corresponding host-side
+DMAengine driver support.
+
+The ``dw-edma-pcie`` PCI ID table does not contain a generic endpoint DMA PCI
+ID entry.  Users need to bind the host-side driver explicitly using
+``driver_override``.
+
+The current metadata revision requires the exposed channels to be a dense
+prefix of the hardware channel numbers.
+
+Security Model
+==============
+
+The interface is intended for trusted endpoint/host deployments.  A delegated
+DMA channel can access endpoint memory addresses supplied by a host DMAengine
+client.
diff --git a/Documentation/PCI/endpoint/pci-dma-howto.rst b/Documentation/PCI/endpoint/pci-dma-howto.rst
new file mode 100644
index 000000000000..4bdce63c6f7f
--- /dev/null
+++ b/Documentation/PCI/endpoint/pci-dma-howto.rst
@@ -0,0 +1,201 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+==========================================
+PCI DMA Endpoint Function (EPF) User Guide
+==========================================
+
+:Author: Koichiro Den <den@valinux.co.jp>
+
+This guide shows how to configure the ``pci-epf-dma`` endpoint function driver.
+It uses ``dw-edma-pcie`` as the currently available host-side driver.  For the
+hardware model and layout see Documentation/PCI/endpoint/pci-dma-function.rst.
+
+Endpoint Device
+===============
+
+Endpoint Controller Devices
+---------------------------
+
+To find the list of endpoint controller devices in the system::
+
+	# ls /sys/class/pci_epc/
+	e65d0000.pcie-ep
+
+If ``PCI_ENDPOINT_CONFIGFS`` is enabled::
+
+	# ls /sys/kernel/config/pci_ep/controllers
+	e65d0000.pcie-ep
+
+Endpoint Function Drivers
+-------------------------
+
+To find the list of endpoint function drivers in the system::
+
+	# ls /sys/bus/pci-epf/drivers
+	pci_epf_dma  pci_epf_test
+
+If ``PCI_ENDPOINT_CONFIGFS`` is enabled::
+
+	# ls /sys/kernel/config/pci_ep/functions
+	pci_epf_dma  pci_epf_test
+
+Creating pci-epf-dma Device
+---------------------------
+
+Create a ``pci-epf-dma`` device with configfs::
+
+	# mount -t configfs none /sys/kernel/config
+	# cd /sys/kernel/config/pci_ep/
+	# mkdir functions/pci_epf_dma/dma0
+
+The "mkdir dma0" above creates the ``pci-epf-dma`` function device that will
+be probed by the ``pci_epf_dma`` driver.
+
+The PCI endpoint framework populates the directory with the common
+configurable fields::
+
+	# ls functions/pci_epf_dma/dma0
+	baseclass_code   msi_interrupts   progif_code    subsys_id
+	cache_line_size  msix_interrupts  revid          subsys_vendor_id
+	deviceid         pci_epf_dma.0    secondary      vendorid
+	interrupt_pin    primary          subclass_code
+
+The PCI DMA function driver also creates a function-specific sub-directory.
+The numeric suffix depends on the endpoint function instance number::
+
+	# ls functions/pci_epf_dma/dma0/pci_epf_dma.0/
+	dma_window_bar  metadata_bar  rd_chans  wr_chans
+
+Configuring pci-epf-dma Device
+------------------------------
+
+The host-side ``dw-edma-pcie`` PCI ID table does not contain a generic
+endpoint DMA PCI ID entry.  Choose a PCI vendor/device ID for the endpoint
+device::
+
+	# echo <vendor-id> > functions/pci_epf_dma/dma0/vendorid
+	# echo <device-id> > functions/pci_epf_dma/dma0/deviceid
+	# echo 1 > functions/pci_epf_dma/dma0/msi_interrupts
+
+The PCI class defaults to ``PCI_BASE_CLASS_SYSTEM`` and
+``PCI_CLASS_SYSTEM_DMA``.
+
+The function-specific attributes are:
+
+============== ============================================================
+Attribute      Description
+============== ============================================================
+metadata_bar   BAR used to publish the endpoint DMA metadata and handshake
+               bits.  It is kept as a stable BAR while the DMA windows are
+               programmed.  If this is left unset, the first usable BAR that
+               does not already contain a fixed DMA resource is used.
+dma_window_bar BAR used for DMA resources that are not already host-visible,
+               such as the DMA register window or descriptor windows.  This
+               BAR may be switched to subrange mapping after the host driver
+               has found the metadata.  If this is left unset and a DMA
+               window is needed, the first usable BAR different from
+               ``metadata_bar`` and not already occupied by a fixed DMA
+               resource is used.
+wr_chans       Number of endpoint-to-RC DMA write channels to expose.
+rd_chans       Number of RC-to-endpoint DMA read channels to expose.
+============== ============================================================
+
+A sample configuration for a DesignWare eDMA/HDMA compatible controller with
+two write channels and two read channels is given below::
+
+	# echo 0 > functions/pci_epf_dma/dma0/pci_epf_dma.0/metadata_bar
+	# echo 2 > functions/pci_epf_dma/dma0/pci_epf_dma.0/dma_window_bar
+	# echo 2 > functions/pci_epf_dma/dma0/pci_epf_dma.0/wr_chans
+	# echo 2 > functions/pci_epf_dma/dma0/pci_epf_dma.0/rd_chans
+
+``wr_chans`` and ``rd_chans`` default to 0.  At least one channel direction
+must be configured.  The selected channels are exposed in dense, zero-based
+order; for example, ``wr_chans = 2`` exposes write channels 0 and 1.
+DesignWare eDMA unroll and HDMA compatible layouts require each exposed
+direction to be delegated as a whole, so set a direction to either 0 or the
+number of hardware channels in that direction.  DesignWare HDMA native
+linked-list mode allows a smaller dense prefix.  If ``dma_window_bar`` is
+configured, it must be different from ``metadata_bar``.
+
+The common ``msi_interrupts`` and ``msix_interrupts`` attributes select the
+number of MSI and MSI-X vectors exposed to the host.  At least one MSI or
+MSI-X vector must be configured.
+
+The function-specific attributes can only be changed before the endpoint
+function is bound to an endpoint controller.
+
+Binding pci-epf-dma Device to EP Controller
+-------------------------------------------
+
+The DMA function device should be attached to a PCI endpoint controller
+connected to the host::
+
+	# ln -s controllers/e65d0000.pcie-ep \
+		functions/pci_epf_dma/dma0/primary/
+
+Once the above step is completed, the PCI endpoint controller is ready to
+establish a link with the host.
+
+Start the Link
+--------------
+
+Start the endpoint controller by writing 1 to ``start``::
+
+	# echo 1 > controllers/e65d0000.pcie-ep/start
+
+Root Complex Device
+===================
+
+lspci Output
+------------
+
+Note that the device listed here corresponds to the values populated in the
+endpoint configuration above::
+
+	# lspci -nk
+	01:00.1 0801: <vendor-id>:<device-id>
+
+If the host was already running while the endpoint function was configured,
+rescan the PCI bus after the endpoint side has completed the configfs setup
+and started the endpoint controller, if the platform supports it.
+
+Bind the endpoint DMA function to ``dw-edma-pcie`` explicitly with
+``driver_override``::
+
+	# modprobe dw_edma_pcie
+	# echo dw-edma-pcie > /sys/bus/pci/devices/0000:01:00.1/driver_override
+	# echo 0000:01:00.1 > /sys/bus/pci/drivers_probe
+
+The device should then be bound to ``dw-edma-pcie``::
+
+	# lspci -nk -s 01:00.1
+	01:00.1 0801: <vendor-id>:<device-id>
+		Kernel driver in use: dw-edma-pcie
+
+Using pci-epf-dma Device
+------------------------
+
+The host side software uses the standard Linux DMAengine API.  A DMAengine
+client driver running on the host must request one of the channels provided by
+``dw-edma-pcie`` and submit a transfer.
+
+For an endpoint-to-RC write transfer, the DMAengine client uses a host DMA
+buffer as the destination and an endpoint-side address as the slave source
+address.  For an RC-to-endpoint read transfer, the DMAengine client uses a
+host DMA buffer as the source and an endpoint-side address as the slave
+destination address.
+
+Troubleshooting
+===============
+
+``pci-epf-dma`` requires endpoint controller support for DMA auxiliary
+resources and MSI or MSI-X.  If any DMA resource must be mapped dynamically,
+the endpoint controller must also support BAR subrange mapping and dynamic
+inbound mapping.  Binding the function to an endpoint controller fails if the
+required capabilities are not available, or if both ``msi_interrupts`` and
+``msix_interrupts`` are zero.
+
+If ``dw-edma-pcie`` fails to probe on the host, check that the endpoint was
+bound to the host driver, that the endpoint BARs were assigned by PCI
+enumeration, and that the endpoint DMA metadata READY bit was set after any
+DMA window BAR submaps were programmed.
-- 
2.51.0

