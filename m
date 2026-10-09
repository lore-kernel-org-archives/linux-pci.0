Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazon11020131.outbound.protection.outlook.com [52.101.229.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64EB03DC4DD;
	Fri,  9 Oct 2026 05:00:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.229.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791522020; cv=fail; b=POMT2/Q7JmKOTdbkCnvv8qFzvszt6z7PvQrppSeISuA/FXqMZ+6rsSiDbhFvVSuExxAjJCpjfBVady/ZdWVVpb8easnp7obMPhZXV6c4zQbUxnJxdNhGY5xVmQQefeaWne25f9YCVH7PBTCNJvR2LXieVpGfM1vPGfOMa8I8suU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791522020; c=relaxed/simple;
	bh=Dh1RVKAD/tk/E4btaQJ3mHvolXzhB6mfQlAbsDwB258=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=fvVnOHDb48l8iXWkaf42IjNrEKRgR0AyfkfE0IGLb8EgUsTHXuZ5ksYGyJKMh6YXQm3uBvW0L6oFx/kzzXn+EYrhQlDeqlzXcrz7ofG+oaJ46qrErKi1IrKpwzv/ADvN8FymK+QhDRajJSt4WfXh9gAJh5W3Jr7QrvOTQKHhrmM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=QqdUc4hq; arc=fail smtp.client-ip=52.101.229.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="QqdUc4hq"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ySDo+YjJhcwnzYHvIA0xHnTgcEMH3sJQVeur4NR69DvADW0/xmBCC0o/kYi1Bsxn38XfBvir2V/yuFxK5MyP1sKI53ogT+YTc6C/AXVgQ8dYOYlCstTf3n8VDHKwzSeLRIwza2slI5ZY4HpeHve0ED7AcXXr9tKdGws/2IfH2t6bKPoXuolSyzUshVcK9zp2jJwuakYjDHoQuaX1WLf++4rKCP/CS9mkNK4diVZijIgQs9zBBqxfabbYyBHM4SQRE1fy0pjJE2CE7irunG6l9pKsqgASHCqMLgQPxVmwhoELcGMeY5Wui83zhioRnILNSTdaOE66Y8lo5typLdYjUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SiyER5Rb94CrkuBweGBlZSrwEu62liy1kq5tqd8N83U=;
 b=GOmsKrd7lJjWDX6/9NJDsT3uy/ob3QFzrnC/8MxCc0vpS+ZW4NrqRJKkPlxLWUnlaIqKDo2CQsHiEw8z34e9ENI7Fsp7GIXxaD0iCf+d0ATGID6g0mXhoRjPjuPeKJ1rDV447b6jLAwAoFT5rhRAn8zBd2C3PLKIpgYviQmLlqsx9MeIdQa5TLRL347ECQd9X/GAItPYJ/HU/EqWSa5hZ80AwAmnir8J8a5IKu8kRLJ6NyKzZ4eIZBL71zMsjJQDJZIZt6vH5eFs4DUB+fe9t59gEwldesQL97pN9OcWSacSaxHr+1gIacBrjePemNyjeH1mQBKKE9FcKVpxS8cVqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SiyER5Rb94CrkuBweGBlZSrwEu62liy1kq5tqd8N83U=;
 b=QqdUc4hqAgC7QdQ3QqYPMbBijYkJmB7OgkChcKrmNLkF7lHXYWlhnKMWGnx4uRvvhEwsaEFKmKg+lc/ZC1vyF9EMYctBQX6pqmxYhcgAAdjVU+b9dNp7ePJ/OMP1doMLdAYyBjJQ73XD1txGow/783YSOyd1rkhrdw+GJuHN4nY=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:325::11)
 by OSOP286MB4369.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:309::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.17; Fri, 9 Oct
 2026 05:00:11 +0000
Received: from TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 ([fe80::cce5:2aa8:53f9:dba9]) by TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 ([fe80::cce5:2aa8:53f9:dba9%5]) with mapi id 15.21.0496.015; Fri, 9 Oct 2026
 05:00:11 +0000
From: Koichiro Den <den@valinux.co.jp>
To: Frank Li <Frank.Li@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Jon Mason <jdmason@kudzu.us>,
	Dave Jiang <dave.jiang@intel.com>,
	Allen Hubbe <allenbh@gmail.com>,
	Niklas Cassel <cassel@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Jingoo Han <jingoohan1@gmail.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Jerome Brunet <jbrunet@baylibre.com>,
	linux-pci@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	ntb@lists.linux.dev
Subject: [PATCH v5 7/7] Documentation: PCI: endpoint: Document vNTB DMA export
Date: Fri,  9 Oct 2026 13:59:49 +0900
Message-ID: <20261009045949.1109871-8-den@valinux.co.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20261009045949.1109871-1-den@valinux.co.jp>
References: <20261009045949.1109871-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0176.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:3c6::8) To TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:325::11)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB6866:EE_|OSOP286MB4369:EE_
X-MS-Office365-Filtering-Correlation-Id: b1af2a86-2a11-4412-a41a-08df25c23264
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|10070799003|23010399003|7416014|376014|1800799024|56012099006|10067099003|22082099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	CXRxVOQ1HpMsq/QW8OBDWA4rb7FJg+n+DUmwtcVMVHX89tGr3i1EOdAMND00GjNEDvXZkYO63H1AXCidJFmspygXQMRBsNT6oZ21PCecHuxPASfQHqiN3pj0vQkcTXyHYidyuN+ZEjQQWTB6xAX/snPL5cyKGIBf/uZchVYkx5D+IbQgF9UeiSVxNPwVPZnxxVsQa8/zIjAwZbzzQNAkwJL1Cd6ZTGQJPuOfhj/MrFWnAgwsSyFI1m1v9XripABdOALsI6LSSYSTkVJx/tnVlYMSpO7+56u3K1rQxy+MS0JtQLR8KuRbtsRCJjGreS2eMbHEOdQabELBJqilb875/JUYwUIS7yk50EmB6SNmYdwHu3hIroLGZEYfIpBuUoMZoafBRmG2lmXTvAGSp3U47lQkoVeXvx+1sM/1pQjCRhd64FeFaNkCiZM7x37PHWYFaFevGIAP8TkL/G5xaoeL11jB+lf3VbdYcSpE3WVQb4ah+myyLvNJnKUYDgeCVaUFL1u/wYf3FBc84V1x4alrU1JiZ2+o4wQ9iNOg5JpILKlX98yn7h3jt2o5sRGcEUjlrjoOj0iImCA3C0NWj9968a0NTcTU7g1wUrf2QMBshP6MtelopgGcMsBcmn+k9qNBq2djvGWoFvsUZIJZGRy3R3HZjivLS3KueVXqJyH6ckE=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(10070799003)(23010399003)(7416014)(376014)(1800799024)(56012099006)(10067099003)(22082099003)(18002099003)(6133799003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?GRvOfpMCytG5gZsDOPe8tQFVNX0okI3M1cPLtPHp5FSu6fBTNNHtwh+d4qM5?=
 =?us-ascii?Q?/pJ0MJIOwChtfTnPqGbeu9an99gohLznqBl65xm0H3Wm2lff68wjfRmNGKYr?=
 =?us-ascii?Q?TzMVV5Wmv+hvmBPHLSd9vaWfd01WqN0iysYT0xlza+Q1Nn7gXRtfR3J4a8gm?=
 =?us-ascii?Q?nDV5ZqtUT5pXFs2WZcgLzS5MJkpy0VqSj5gt+1lp7JuHRYaNAL3pmC6+zdEZ?=
 =?us-ascii?Q?6sVPVuG2eZkzFvWJcTCNaRU5dRMik/aKZGr9LiGwyOZcEhpWbCXV8l28dhlA?=
 =?us-ascii?Q?GflvezcvwWpRxEE60s1R4p/HQSnR/6TCHiNu45K6HwT7KwjWpKKkPWpzfM/8?=
 =?us-ascii?Q?UyknKhPY+U+fSUDSfjdX937b+bwJPphdb+UeEn1TE5IMcNPfP49c7HGunYb7?=
 =?us-ascii?Q?o4DEirxlTvA0TayvqAIK0sW4ZUb4h4OTM7IXsmfKxeF5VG0wy3dmrr5AB6bR?=
 =?us-ascii?Q?Z9DNTCttwa7nPLkMAHwwTxIp0pl2pdPi5FDCjB28w03X2L5UTlyXwJ2qbNaT?=
 =?us-ascii?Q?N6VVcdjX+4qxcqsR1RLFY/TKPjs8g+bX5TL5PgGiI8o4yS+fxepbF7Yn5o4+?=
 =?us-ascii?Q?UOlw4A1Q/j3irHxZiz+eYhuNbJORZeyezXHo+qnuFJqXCR3usCXBwC6x83Iu?=
 =?us-ascii?Q?tJZ8sW9zziHxunNAMMXo280P4mZqt5Ij75fTlyEPNwHIdwt/xYynMDjLgh5C?=
 =?us-ascii?Q?90LnEgZoyE9Gs+mHgv0pMiwwanwvzdyJrS1euKbnVOiDS7+RUYCbK60G9qHj?=
 =?us-ascii?Q?scEQzOHb1sPX4AFB+pETrjLVwZv8rF2yf9BRPfU0Hj/6dDUUjV+gPYLckBBq?=
 =?us-ascii?Q?QSJSAaYdqumMC3JmOVz3hZDrqxwxrTghFLM6DmgzqIkDbB7isj9U0q03yMnB?=
 =?us-ascii?Q?zrullLl2FGBsiozZUIyU/nV9P8Xc2teR7kWlrvskjD4D8XnsBAGxwnphT8ak?=
 =?us-ascii?Q?jwGIPd/C0tkWLq/u3EsJ9fYjejMOhrM155A+82N3Jy2GrLCnthchSu6IEQpU?=
 =?us-ascii?Q?V2DH1vvi/85toc+KncqTnbhT8PAY+7Ckhk+YrYprbtOb87N6+rcBa1MiX/VR?=
 =?us-ascii?Q?PxL7x04KvXcV9jM4cgrmcR29/Biu5Rw9y65Jxpbc1HsAPTWNiQ8J5WNrJRGu?=
 =?us-ascii?Q?ycq1Cinc5cvF6m5ScVClt9CgXF3XAU93WAKCP/XGd0qs0uTNrORSd9XMmSu4?=
 =?us-ascii?Q?+x13CuJaj6GOJ4Z5BiKG+4TOsmvek/Toby9rCQKu02HONprvcrnqUAi9Odmz?=
 =?us-ascii?Q?H0bx6w/UmjTMRSzk7YE9JH00o4n0YXZIrL2LooccCMeD6ap+d/xandy905sh?=
 =?us-ascii?Q?FQtDCAfUkmpO3V2eKRlHtWnSMO54LTAVSuIzMsBzyL5KKSmTFsoRYuznIPrR?=
 =?us-ascii?Q?5I0kwEjdoSXI8H4Bapi4R/iWbs8EOVA1cePFRnwD0pJ3uEmyvzt/4yJyqqJF?=
 =?us-ascii?Q?aGPAOfXiSImXAPtbRQmML9G2esNdpfyI8dYw2IRd4ggntlyBT15fGKR5kH1S?=
 =?us-ascii?Q?6Anlp6XpKUfoUdeVTlgabj52kr5YhpKbmwAlzs3Y3n/Y5LQKGCHYotoNQHCg?=
 =?us-ascii?Q?JKOSviuNHaVyuo5Rtdcr56Brj5Ca6IiRYw+9Ui9VJh8xrcdDfnkr2rHR4SHG?=
 =?us-ascii?Q?6MRyD32gCOybxVWxRI6Vmhoz4N36xdwxD8TyX0tM7pxe7YQWUgCCmhHmew2O?=
 =?us-ascii?Q?EhUNs6BRjAwJUeHRM6VRe/BiGhY6AIzY7Gty2zUUVXyt02wDbfEnMVENMmRS?=
 =?us-ascii?Q?vlDE07KZXvi6NjRgKm9PC45WPIWQRXkqfgyV0ToPv8d1WS1oLQIc?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: b1af2a86-2a11-4412-a41a-08df25c23264
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2026 05:00:10.9985
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: egpuqVyi/vGAP/F4Ydx4Hs6euYGEjjIhMd21zErkxo7CmqWINjt+6wvfsLpMM/n81cUzlz0DmK2oE+Z75qcqOA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSOP286MB4369

Document the dma_bar attribute and the requirements for exporting endpoint
DMA channels. Also document how the selected BAR may be shared with an MW.

Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
Changes in v5:
  - State that DMA export requires subrange and dynamic inbound mappings.
  - Polish the wording.

 Documentation/PCI/endpoint/pci-vntb-howto.rst | 31 +++++++++++++++++--
 1 file changed, 28 insertions(+), 3 deletions(-)

diff --git a/Documentation/PCI/endpoint/pci-vntb-howto.rst b/Documentation/PCI/endpoint/pci-vntb-howto.rst
index 3679f5c30254..7ca4e1ff095c 100644
--- a/Documentation/PCI/endpoint/pci-vntb-howto.rst
+++ b/Documentation/PCI/endpoint/pci-vntb-howto.rst
@@ -90,9 +90,9 @@ of the function device and is populated with the following NTB specific
 attributes that can be configured by the user::
 
 	# ls functions/pci_epf_vntb/func1/pci_epf_vntb.0/
-	ctrl_bar  db_count  mw1_bar  mw2_bar  mw3_bar  mw4_bar	spad_count
-	db_bar	  mw1	    mw2      mw3      mw4      num_mws	vbus_number
-	vntb_vid  vntb_pid
+	ctrl_bar  dma_bar  mw2      mw3_bar  num_mws     vntb_pid
+	db_bar    mw1      mw2_bar  mw4      spad_count  vntb_vid
+	db_count  mw1_bar  mw3      mw4_bar  vbus_number
 
 A sample configuration for NTB function is given below::
 
@@ -105,6 +105,31 @@ By default, each construct is assigned a BAR, as needed and in order.
 Should a specific BAR setup be required by the platform, BAR may be assigned
 to each construct using the related ``XYZ_bar`` entry.
 
+To export DMA channels, set ``dma_bar`` before binding the function.
+For example::
+
+	# echo 5 > functions/pci_epf_vntb/func1/pci_epf_vntb.0/dma_bar
+
+This currently supports the unrolled DesignWare eDMA layout. The EPC must
+support subrange and dynamic inbound mappings.
+
+``dma_bar`` cannot select the control or doorbell BAR.
+Any rounded-up BAR tail is scratch-backed.
+
+Leaving ``dma_bar`` unassigned disables DMA export.
+With a separate DMA BAR, an older ``ntb_hw_epf`` peer can ignore the extension
+and continue without DMA. A peer that understands the extension also continues
+without DMA if the advertised type is unavailable or no DMA IRQ can be
+allocated.
+
+If no spare BAR is available, ``dma_bar`` can select the BAR of one MW instead.
+DMA resources then follow that MW. In this configuration:
+
+* The shared MW size must be a power of two and its translation must cover the
+  full configured size.
+* An updated peer is required because older peers treat the whole BAR as an
+  MW.
+
 A sample configuration for virtual NTB driver for virtual PCI bus::
 
 	# echo 0x1957 > functions/pci_epf_vntb/func1/pci_epf_vntb.0/vntb_vid
-- 
2.51.0

