Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.228.89
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792475407;
	b=VoERanW62sWNCdy9zTSjWTPn+ADj2M0ECjSyPk+22h5iDMUY1d6tm770xF3ZVrzgO6qB
	 sD4cJJpxZi11/mzJGaVmZhySfxeDRGeEtiVOoiAa96SZRPo+39fFC/L/174lr44hrvL/e
	 HF//g2BwFY3qTFQQDoLqvnL8fmfdEe7J1I4jRwGVaaI/wRw+3neqCGVPLtxFEMd6UZ+uv
	 apshP0TKMP3aGhc/CBgpytQmrkxG5Y+o70C4TX6TATvLVqG1jXoL2lgUPk8zy4iaKIh6J
	 9/eI9bC0UkDnUFPStiXH7Vsehj9NpVbkTT5Zjysw7O5NOXpUcdniuZQ3nzYSg76fH0A==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792475407;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:
	 Content-Transfer-Encoding:Content-Type:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=tGCK2BiWGc9wJMaGiPxv8QOBk3eeSHhr5znjT1/IFg4=;
	b=eW2h2M5rNZAMKGud9CD/ARwawtQhAdxsY1hvuQDkGT9dByaGoDLZsSrJ9qU2f95B/VQO
	 21w9K2s3lSjz+XhsFCpYAvl+wjIN3gLlT/jWmPoXQphsnm5H0cZ51I6cmjMl0ZeFXgNk7
	 zgk+j+Mh57w/q4ApAOgiGW7zyJ8GyRH84k/3Uto6gSviRX4m55RrEyKydS0mvC4s5osvz
	 u8NMkLF1CS4xoXWa6xd5fnSC94UOdidVaOPigyGM+6wH7aeVgB2sJj70Gh36alkVfVDqH
	 /woEBDYOMFPxuyuSolFPspEeRJj/PStRvKK+5EIW0BclN0IbbbqspI5y7WP42vigXMQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=valinux.co.jp;
	spf=pass smtp.mailfrom=valinux.co.jp;
	dkim=pass header.d=valinux.co.jp header.i=@valinux.co.jp header.a=rsa-sha256 header.s=selector1 header.b=mcfYgDaj;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.228.89
Received: from OS0P286CU011.outbound.protection.outlook.com (mail-japanwestazon11020089.outbound.protection.outlook.com [52.101.228.89])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80E3C60A260C;
	Tue, 20 Oct 2026 05:50:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 80E3C60A260C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=valinux.co.jp header.i=@valinux.co.jp header.a=rsa-sha256 header.s=selector1 header.b=mcfYgDaj
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MxMkkFD/misrJQJtcTi20+ILO19k7HyIISTdwn0xAI9j60u9Bu6lioAKpcmL5BiObL8/Cv3xEVQqrN8uaEWL3O58oEXPVGUODouJMCjVLexLPeXh/GDCW0Oq5m8Dj8315Q88eVqFXU9J5/GLYk15fY3eddH25y3/UI6iRcgjhR92x3ZMs85S2K+kF/gw+g0hqy3FJP3b/Ug3ekoSZ9zka5bisraCOWCsSWIhR1xsP69SuenGcsJBjOuEhoy3u8yhEjbTauWvUN8311WFocBBfGlOC6PwjWx2Y99mJAR1kyGKieUyAwj3iR3dnQ3iStOIoStcmANGLq1lXIyVKN2nKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tGCK2BiWGc9wJMaGiPxv8QOBk3eeSHhr5znjT1/IFg4=;
 b=bGLV9/UYUc/ciPoiBL450rhADOWvmKx/LiTXq0NWfLdUR8WPdd28YuTPAhDswZNHrTTXiq7b1ik4NuuofF1BQ2q/D36KHRaB2uGXCndd5obOnpIq7YirKyT6TYGoCQUP0yLWXcaJk0GotY9goUWzwW8VLz6ys7h7aKgB9gM8h2kEChlC/LkID8T8wugvce4wJ7MZ7tR2tfv6mcnOdumVouzH7SQfnQHTUVhf8KhMuUIuq+0o7yKLZfG5NqdY/rEN/KfkEVkoL1Lh7Sx/rVJ2DJV5TEZEQSAn591ZFvfo8OINe5adzyxgUJtgb+1pJsBFDal9Hqxvib3Y0xKKNbqFzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tGCK2BiWGc9wJMaGiPxv8QOBk3eeSHhr5znjT1/IFg4=;
 b=mcfYgDajh3VgvMvnGdVaUKdiaXYtlVNdbde7SUWKVMaXxdygyDRnNQefGaMtL7aE7jUn6SMIXiuoAfizewCVRRRVEG/FuPK2GxNa0QWg/rbPbAnjNltlkC1j5WV2p9VTcarb8rMdmMoGVYPuwHTSCNk6gvsNTCdmFmgaXRzKRoA=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:325::11)
 by TY6P286MB7913.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:3a3::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.19; Tue, 20 Oct
 2026 05:49:59 +0000
Received: from TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 ([fe80::cce5:2aa8:53f9:dba9]) by TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 ([fe80::cce5:2aa8:53f9:dba9%5]) with mapi id 15.21.0522.017; Tue, 20 Oct 2026
 05:49:59 +0000
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
Subject: [PATCH v6 8/8] Documentation: PCI: endpoint: Document vNTB DMA export
Date: Tue, 20 Oct 2026 14:49:48 +0900
Message-ID: <20261020054948.1218370-9-den@valinux.co.jp>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261020054948.1218370-1-den@valinux.co.jp>
References: <20261020054948.1218370-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY4P286CA0021.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:2b0::6) To TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:325::11)
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB6866:EE_|TY6P286MB7913:EE_
X-MS-Office365-Filtering-Correlation-Id: c132dd23-a842-47ac-c807-08df2e6df9e8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|10070799003|376014|23010399003|366016|56012099006|261009223027099003|10067099003|18002099003|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	1vmVrYBmGkHL8AsC4rO6tawwqpaE1ZyDPVXc1WJZt08eQh7kJ/QEeEBjcAbPfSUXgftmGmgqZkuOsGahgOqPktxkDxpL0badyiRfd2gs4Lx5EkUChwvB92G0NF3emVCmmIK8B6pAowelzv4poM1HE2Asf3C4DXJhfFnRmqiRKT22/2AESHpGa2aZPaEXgq0X7tf78O+NyXy7TYSh32VlJTn8XEXgnbgjifu6iBxAZo39RsJX7FDmdN/ZJsYda+CiaJUuvsRl1g//7Hi1oNiOuE2U68p5AE8BQ3JfPcvCTc62GuVevCFoQp+YZJi5seK8ZlMOKo8FrFJLxmyVJIG/zg7sM29GVyDN/dekqgSf5vwJKfcBYFyOvlBZSHFrykL1mCWXrB4GVpxMe1UT72kX8xsPKd1H7Dz3dypEGsox2fz651tP4y5aD+ACHXqMG0O428Crbg+9N0UnwpQt3fx53pBtYLnFNvJVPIfUw+AkBDwX93U5gU77Re1+FM6r/vzkJU72ehUwRjh4HzGeSSzC+wRrd2tw+h+eGXGBrE9lmpRzI+uEbwL/nwn00VqzUtbnWVdW/l+3YLU+GdqumVC/eBMN6C2uOHVFqg/YKrSYHteplxG4BOaKYCZYtj3+eKN7z+XhkjhYzGsEh8ITbC0NHrTjd4ly/l7CiUdki5DNlFg=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(10070799003)(376014)(23010399003)(366016)(56012099006)(261009223027099003)(10067099003)(18002099003)(22082099003)(6133799003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?bH1qz7YbrwJW3jhNImOGBd61ivyXdqtNNCbemtYNBpNpeWPEH//ynHR6O1uc?=
 =?us-ascii?Q?43p2W2SgGm3xkwU/u0N0gmrHpjyrLpB/a8ZizJ7JEKPwYcTJ66Mtfin92ZiX?=
 =?us-ascii?Q?sl2KH13KOsYjWMq8lf/le2Qec5nU5rSXm7bIsf8gKfPOElBWkmq205gf3xuY?=
 =?us-ascii?Q?ohYRIzhylconoIEGQ9ew/U24G09Zu88mnZUrPAm6VB06vPKhIt3PICLSQI0W?=
 =?us-ascii?Q?6Vg/JwbgARxAFMV+QSc/WCJm2wA8ShWl/icB6nn7m6E8qUli0hloHdmJW5Qr?=
 =?us-ascii?Q?8FzB9thAbh6W4nRnWTZbBHlntxbLPEpyd0MiYcO0KmV98AxouGoS4gxtIzaD?=
 =?us-ascii?Q?tm89VerEYMVaqlV+S4Gmiffh73QIswE5aQtZ9kn2FuoefVCdbRycuSl25rZo?=
 =?us-ascii?Q?HyPQaJaY/OOPeo4Ta8KEAh1+n9e5q7wNP4wPkeJ3dVAbbXBFOh7ptGnFChyC?=
 =?us-ascii?Q?gza/keSv46WItMSVbSq7ttk6AbFf3GUC4DWScJxy10dhTT6cyaoRpkclJb4r?=
 =?us-ascii?Q?KVzbSW8r4nsXo/HwkK86xqz3B7FE9qgZ27VxVtqOV4sVQ7JCT1SFRzH9RqpD?=
 =?us-ascii?Q?+8E6o2dFlJzvnEf2kJ2wZZ0iLMMKY3XrpfvHTJ/3VLJbeYkuYp6At6byevIG?=
 =?us-ascii?Q?whlAUOsbd6RX447gHhgl3BmP2UwGXYA5tzAnej3FxQ0ZXZC0+XuNsPsEOPEZ?=
 =?us-ascii?Q?XREptyr8CWqmHF+1/0mjfR2REPwynQFPDCXO8kQUXGVCNAtayZstv6BNf1Wo?=
 =?us-ascii?Q?W0KC3vVVXugLwuXwZQ64P9N7ctnW/opwNTzZsIKEWfmkcPl48uFGzv/ovLsr?=
 =?us-ascii?Q?YHh1h1KkVB4qJUrFarXO9cLPGLHJsuYA2ifnXLSavRvR22GbPNL4D+eJIXio?=
 =?us-ascii?Q?d0VB6cz58vCdNS3meVBJ2cmuaW1KlNJffmFlQ2fAzN1DA1vnHPhEkRi73tL3?=
 =?us-ascii?Q?yrycXwfiNRLCbQ/vXzr3yV1q8D/d67a0uh8Phrh8y2zMgBbiGz0yzr8MBzRq?=
 =?us-ascii?Q?H6XlEA5O78Uoo9VZJw3Ntst7VppZTD0TMJDGVOq6WkGR2tMq8j5P/ZLIdgDB?=
 =?us-ascii?Q?N6XVmDuVvKScgodzTMbbi+h3DSgnL9+NoYWbyBYDRNTuYybO8gkO01+9N4yC?=
 =?us-ascii?Q?4b1Y2lW0iyIh16dmUC8C8v9JgvDcajNKbEc+g4ZIcJPM8xO8rRN/eElaIyVr?=
 =?us-ascii?Q?VruQzB/xapoJ2hTv0RmRcywOS/ILSYrMlpstt6CmBiJ3i0KmqCJZdZMp3GBY?=
 =?us-ascii?Q?b1PPMx46SuEld2wHsWS0p2H5q7a5Oady4XKQtPAKEObXOYxI3fWyJaudEZSF?=
 =?us-ascii?Q?fXGe07WLhpt6RQR5su8VADmeofZfxmxJkNhEzLMthgvrMmpe8INY1Hw00IJu?=
 =?us-ascii?Q?s6Z9fhkS104F9YX+AXHErnWyq3At+gsiFKifRQgTIwTH/G881ndXWi0LgS3s?=
 =?us-ascii?Q?fM71xjIfJn2gAn2pBe26L5GZ7m95/wWP3W0fW8gCuSnysoKkS/TUK+bWe8aK?=
 =?us-ascii?Q?H+FW/Opg2Hy2bIS3JD5o8eZynD8DaEjFUACSKVl5+4d4a5ZJW7YPCZYnkD/c?=
 =?us-ascii?Q?G05iweemhHUUvGOeRlc0nM3asin+B21+TQheXqeGcN9rkDMApnYr4oN2EyVN?=
 =?us-ascii?Q?NVXEdFI3oLDVYgLaw+PvdxIswiKlQ+zLM18C7FOxXXY0WjANwg5YgojoEx1u?=
 =?us-ascii?Q?4adHqU4O49rm0QbMA9jwX/CiyOwBA0xNYoFah7U9hVulHixZ7rJ+aGU91Iyu?=
 =?us-ascii?Q?M5B3wr7xKE38kpnjSEEvc3YnBnxfq5UhC1GC4phmpKxF0mQZpTcd?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: c132dd23-a842-47ac-c807-08df2e6df9e8
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2026 05:49:58.9960
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1swiCO8sCqsVxjqY7O5jsMoizacyJSfB7gEhkdspwqyK1oLvzyN4rkKzEXrbPjdQ43uEabm2RGfeeNLd96XgKQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY6P286MB7913

Document the dma_bar attribute and the requirements for exporting
endpoint DMA channels. Also document how the selected BAR may be shared
with an MW.

Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
Changes since v5:
  - No changes.

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
2.54.0

