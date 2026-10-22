Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.125.110
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792657368;
	b=FKLd4c+8zRoj1sJuL9U2GL82seVKud4TrmErq+e4+57gGXC4dPLa15TCoRF+rwK/sOWB
	 5/r69L/tRNfW96Swq/D2kp1O0Za8wFaCey3aA/GUxx52+PzVy7NGF5xGGDcOzMKLNxKpI
	 RGBvGlLmKrhqeVNbANF8YXht7iqz+KoOpHogawJPpx0U6SEmgDLziI+Wmod8vKHbgZtZf
	 vTwl3iQBYqcQ80I2K3tk0ViqS6ykXNDRdys5FkKvk/oAD5hXAN2gU6KANoIINnOhhnABX
	 UaQn4B1ht9EJLlOapHkKx72NhJM612lhf3t+n19vVXQvzGQV3rmqd/wKxKEPdCHxPkw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792657368;
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
	bh=jjSrvAjkXABs1DvzXtLtGiJqiE+5vowyYsH1gCpJlzM=;
	b=pg/YsAirVJ5z+5chkBK880mPYjP5RPjReaddRfDLa4a6xec4SKPz3EE9kv3v3JAVc2I1
	 pldiIgAYNJQZYoyLnyOApVNclCbK8Ea4phZv6h08Xgde09Z4bD1N0bvbG+3qjHMVsh8hi
	 6WoBpM4xYuraAruNeI7Z0USNBLYwjmaAWgtLVr7JU3P2XMz0BrFndjP0PWesBKPzOH4RO
	 f37BwtOF73kp9s9g8R4t2WNQQyaEw9+fZ8a8m6GfGLM8R2WhcMpSNAMPq3+Hce+X7paRz
	 nwT+vZk7o1eCZdSJmkzdEn0pTb8/EP72JUTFiXc7A6qVhNss5S79h3yzxCZo5GXP2cQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=valinux.co.jp;
	spf=pass smtp.mailfrom=valinux.co.jp;
	dkim=pass header.d=valinux.co.jp header.i=@valinux.co.jp header.a=rsa-sha256 header.s=selector1 header.b=O7j+mXCm;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.125.110
Received: from TYVP286CU001.outbound.protection.outlook.com (mail-japaneastazon11021110.outbound.protection.outlook.com [52.101.125.110])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FF77606A31A;
	Thu, 22 Oct 2026 08:22:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0FF77606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=valinux.co.jp header.i=@valinux.co.jp header.a=rsa-sha256 header.s=selector1 header.b=O7j+mXCm
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QES6KdFoFShF/tnot3plKG86KLIY/t/F2+8jb/RV7rsjX81oyK91qfLiuL0I7DIxUw6fBXSV/mk4xFsc/zWd02nQFCGScSJCzVcrQV01LJ4ZbQU6GTHnbk7ul3eifPqQYLCGiglorGcwGVLjhna/QMBuKtZr24Keunh2Q8sWvor7/PaJmSwLZ2OQeN1AKBMpA4+VpGUcVH6xORAeINGGqIDCQxtqfDmONeh86q/6DQGJUXfF3DNZLUVtv5jzdqEH01KaFw0zQBCD01XZXfzLBRwunL4dcJgXomdlH/e/MQ5+Xq41EjV3ijRZI6CaeiBtYbpA0OZbj3gk/d67VwvV6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jjSrvAjkXABs1DvzXtLtGiJqiE+5vowyYsH1gCpJlzM=;
 b=koglTCMo2vhIPG8E7OZmSbOSF2yns/59yNZPjLPljwcrDRmriRKGoRMcGcwRY/sultGo54gcyuXGAP0L4WSLgMJYhlZgAhZbhj5+mcH7XSRQUk2I9JMDpPP1T9Gmr/kcN2J84EsIXd3zntvUfOZtLrImQAc/FpQR8veuCai7E00SPHz6ctHgSk6ma2LCAxdgvgGvB5DyESrZNS2ipOX1LTiTLV/f95FKKUzxEn/UnuKfdhOA6RnD2SliuGDdKnyDxPFCd64kqUBD1/fi87QxRUD5Xbj0VBCmlns8FHHvyANO5xWtGe+7PRbSDAU09GsqMSUl3ZhjUDVAKFU95AK/Cw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jjSrvAjkXABs1DvzXtLtGiJqiE+5vowyYsH1gCpJlzM=;
 b=O7j+mXCmeL38d0C5aIhWVNzw6Y5ZYRV3o3mzv7NcvhPDJsf4QPg8VVcYz/HzNHDqdrNu4WrGt+Tl0/t5AILFReAqFsGXZA43L2BfrVizL4nUe1hkmEltcSlHL/X0Q+hmd5FqHPT0sTn4dU+GZ9cxVi8Q2zzuQFD2qMWPuo3YhvA=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:325::11)
 by OSCP286MB5275.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:353::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.15; Thu, 22 Oct
 2026 08:22:39 +0000
Received: from TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 ([fe80::cce5:2aa8:53f9:dba9]) by TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 ([fe80::cce5:2aa8:53f9:dba9%5]) with mapi id 15.21.0546.012; Thu, 22 Oct 2026
 08:22:39 +0000
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
Subject: [PATCH v8 07/10] Documentation: PCI: endpoint: Document vNTB DMA export
Date: Thu, 22 Oct 2026 17:22:27 +0900
Message-ID: <20261022082230.3164834-8-den@valinux.co.jp>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261022082230.3164834-1-den@valinux.co.jp>
References: <20261022082230.3164834-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP301CA0002.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:400:386::20) To TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
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
X-MS-TrafficTypeDiagnostic: TY7P286MB6866:EE_|OSCP286MB5275:EE_
X-MS-Office365-Filtering-Correlation-Id: dfdd1a93-5aca-43a5-5df2-08df3015a2f1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|10070799003|7416014|376014|23010399003|1800799024|6133799003|18002099003|10067099003|261021121427099003|22082099003|261021123027099003|56012099006|261009223027099003;
X-Microsoft-Antispam-Message-Info:
	bV8/MT1XcZpnGD9GOSZaQflu1UC/K1jUT6gNUfGiNuxsH05aaLvmJS27midorbeScxM66pAt55Dh4hNkXzZIq6urkVPcvUS3ZZK1JxQ1w4bEoHLf4HZrYjbYz2xmjhTzmIR2erK+P+Ok+AenlglxZs7SfOW3zVIDcXhJUWujje/5XP292V3QldlKXM562EXF+2RtqIwybS8xutFQSLFioNz5vvjjlh1AKTGF5wji6rfVoshBl1mu2dO+yM+RElI0lxYKHhEiXfLWO0cad7h01VQGN++8dNza1Faj1aYaE7w2Wdkuxo9CqB/HhhFS6Y9Vq4wVE94vgE02nUheCvYqDUYkmxtihNExl8qjquS7jdySpa79eppUpat6az5aQBCypkiU+CYOZpetPvdIdW+opktOaEuP5SOHUaUrvPCsYIQ8nnmO1IDn1FzRIYc/p3wFrIp/w3HewsZyrAvl7xhpMryMt7s7FDzxYqeN150L8zZMpor/Gq8uqFfTBqHzGj2jAtEoiFFFtSFZ6Kv9nmGiKKzeSf/OaT9TuMSjNYUzziJ9Bkg5Bge4YNPvTQRDnwFIVYdM6lV5w+1mjoPbLyXl55H5zlCYWz3yHawFoTlaAqYmSX6UGU1kOzbVnjgWHou9
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(10070799003)(7416014)(376014)(23010399003)(1800799024)(6133799003)(18002099003)(10067099003)(261021121427099003)(22082099003)(261021123027099003)(56012099006)(261009223027099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Dq+hUqiI0uHOwSGoqKkjdoJz0JG1kSs+S8JsjOvKA6P0oTxjqgCSyhNyaZnw?=
 =?us-ascii?Q?BfbDM1N6PZOFrY9IXuZx03e+rXe64o7Jrxr5dZ2r6+lKOtRJbLxp3eCOYifL?=
 =?us-ascii?Q?OnaQO0H7xe9qhbihnU/2CfT7foGU2WYAbNt+do61B3QVmPx767JI3WbpWBsO?=
 =?us-ascii?Q?T9fBHup6hNCIZ2wy0ZVQAuR6KZ2szdbV9w88sqXBH89gvwlFkT57EHg+YFMP?=
 =?us-ascii?Q?9lSpD8xEA4FF5Qvzb7cAnT3DaY7SrBjClWaX7MQVT3Qkij61o0hKAa0HQ/eY?=
 =?us-ascii?Q?+lsHAc7Zr7vkE0Em5yR6BIgLAXKIg+ngL6hmLYoJ9ftptJOWJIHT/Bg1P5BO?=
 =?us-ascii?Q?WO7JzAYHiQp7EYW4Vbd+Z0I1g7daoVF0C6+Gwj/89Q04Jn9Hz73sPSBueFLJ?=
 =?us-ascii?Q?AMeyg2Gxzuv8Kt5eAUlaOYXKFDAQt0xb9L3pXHdWXMCi3QsCsChUHuHnqwG8?=
 =?us-ascii?Q?mUnttRZdgBsj4Jez1cIn/M16KFbF1RSyKISvyz0Z20YEZlG4my4O8vJOCjeM?=
 =?us-ascii?Q?k/LYQdvu253rc+m9aGl+FnNtTziRxa6zB2XrlA7j7L8iu8uM5qSll7zMIqDj?=
 =?us-ascii?Q?4AzMZp3OYuKFR5XjFHEQUm4pu1f7ghQWRR4Y53Kzo7o3Rop/K5d8XHzo4z6d?=
 =?us-ascii?Q?1dI76CK+ousryYerWv93jJ0LHlK6hQqTxyFWs6k+kIt+bQkaEOABNizVbUDQ?=
 =?us-ascii?Q?oJKLr/QVNO7MBHRiVExVXkgnqrgGdtzY2/14B/Fmk0k+rZu/zSYrvSg0PJ3m?=
 =?us-ascii?Q?I36rKeMOakHg8ter2zb88SYhtpDEGtJ2F5y839qjDAN7Z+W0N2zOHViTCmZe?=
 =?us-ascii?Q?k3HZn6KH0A/ChbDs5qigy8miH9VV6BGCnIRbVqiup2xQSVed9K/p5aSbd0i3?=
 =?us-ascii?Q?5HyQOtljc8gPAuQEdRhzDTx+fkZzSlt/d2gDcBUICTc+yRoVKUbBqG/+Hk54?=
 =?us-ascii?Q?VMAKHV9X9uyW3V9AIMUFfxPEFkvtIHY0HYvQD5QQW78FCdMj26pjjaUZrfwN?=
 =?us-ascii?Q?zFnsT/4Quvt5u+DXtQnGvfPgF9PnYn7DdTWh2tjea7eHGm0uobjY0EgiPgYl?=
 =?us-ascii?Q?Quxv2AfMmY9zO4soHmnniSBwZzoYVQcWwfdm+2kHs/uWN0X6/lezH31LGCzU?=
 =?us-ascii?Q?6b8p5cX2LwyVJcQiuPPKm4paXxEKakmRmyCS+03Y3bRrA93KEXPwH+d8wuyS?=
 =?us-ascii?Q?8tXvSZGQ/BkhYfHn2antehJg5ns3MfxeJW7NoRpaO/wGDLfZ30Wx0KXVsIpR?=
 =?us-ascii?Q?EQlBRpLyYTV7/PExU3FCW75KiC9R3xouOgdiiTVHKuicYBkGAfEI7vrdTHmQ?=
 =?us-ascii?Q?WVNNY6fKEdNP33R8ZtsNDAIa3zn7yGEQm9IEhamtAnaI77qj1ak9szIabZJV?=
 =?us-ascii?Q?rWtGbFKlZGQ4HS5AvUG43ba6dO+O6kKxh2FmutJLehA8CylBflrVAsGPyvLf?=
 =?us-ascii?Q?NmazYgCR72YC4TMQkn6spahgppmfrZiFf8MOo9UNh/l9RM5VmwM+qe/hthZG?=
 =?us-ascii?Q?Mkt/jXM2P5xQN5/y51IbF5ai1oQ819VNpR+RpuNy+m7vadMe4MdP7NjkKqXg?=
 =?us-ascii?Q?5Szf6w2TqZaKyeJ02uzgUC4XGOwK8bM32b8X7SZVVjoUgZ2rzItLqmtqcxhc?=
 =?us-ascii?Q?l5cIzBz8ir3NCMOpOr0yELngJhURdpQ1m30HLBUAmSsHZ1OSpXFaVD3h4dDE?=
 =?us-ascii?Q?Ij1L4EGumqlroEkvxWlhe4dpB2WDzv6KZ+Tn9OnAAOTo5TTQ21qi0DenltcJ?=
 =?us-ascii?Q?xyTJjjRkziuGQ6gS1oHyEZMHm3fjRHv6YpZFD9L9ZgHWfNaVQ8Df?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: dfdd1a93-5aca-43a5-5df2-08df3015a2f1
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2026 08:22:39.7289
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ARDW3I7okYZdaXurwnlzgmr+5Rf6m30dU9nEJBZfQL8eZT1uvny+wlT0zsVQ3eyHuBJA43U8JiFyW7F9PQKzLA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSCP286MB5275

Document the dma_bar attribute and the requirements for exporting
endpoint DMA channels. Also document how the selected BAR may be shared
with an MW.

Reviewed-by: Frank Li <Frank.Li@nxp.com>
Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
Changes since v7:
  - Document the whole-BAR MW fallback for peers without MW/DMA boundary
    support, instead of link-up rejection.
  - Link to v7: https://lore.kernel.org/r/20261021042229.2280937-8-den@valinux.co.jp/

 Documentation/PCI/endpoint/pci-vntb-howto.rst | 32 +++++++++++++++++--
 1 file changed, 29 insertions(+), 3 deletions(-)

diff --git a/Documentation/PCI/endpoint/pci-vntb-howto.rst b/Documentation/PCI/endpoint/pci-vntb-howto.rst
index 3679f5c30254..81c857384449 100644
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
 
@@ -105,6 +105,32 @@ By default, each construct is assigned a BAR, as needed and in order.
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
+* The configured MW size must be a power of two. Without the fallback described
+  below, the MW translation must cover that full size.
+* Older peers treat the whole BAR as an MW. The function detects this at
+  link-up and then exposes the whole BAR as the MW, so NTB still works
+  without DMA.
+
 A sample configuration for virtual NTB driver for virtual PCI bus::
 
 	# echo 0x1957 > functions/pci_epf_vntb/func1/pci_epf_vntb.0/vntb_vid
-- 
2.54.0

