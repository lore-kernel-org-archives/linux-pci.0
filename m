Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.229.108
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794576596;
	b=yEJHJJwtpiDX9pFzur2zSaD5I1g7PO0fsPMIpH5OcuDJbORcBTH+Lfgy3Y0gLp0uwIjJ
	 6Iidlo/rVZGSRZzbFE+UZcGqaTEhF3iX6oYLhwAu8ZRu4gN5fJJ2pXVp5z2pawfxMIyYz
	 8/Dc8T1yiWS+aG+IqEY57HuvwPCQGkNC9Z0R4fDIf465mVVMd5t4AslNzXFyU59wxeIWd
	 emElGAuDfSuX9rEqjeS8aR6siOYTKwrkBxy8US1fKs6GsFvvM8VeWb7upzriH0buHUjus
	 1un9/KvQTPAVf7/e/2l278PBkJ/Y2pLGsihIuIsB9gbnGJ1fyY7hSsPf08/u0lFjzFQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794576596;
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
	bh=F/v1Oisu0PIAy2ZFdaf+gTTBtT2r//rszmcD+fdw26Q=;
	b=4GcjmTcNfMkb5+twObNv80pahrEzkHvDQ2xBXERrb+Jbq89CEonaBTlfvnUptzUjupIs
	 oJn9yAOiAUYuTetx8doJ0OhCwa6Jzr7rKD6KHDUXmyDdIRrmoGAvMqQQrxTs4ghfmxYni
	 +1a/dFxL7j9m1SJTmgUfKxvXvcssxGudE7Vrs1ADGjHqrZlNdivquxvVEeGY4PBf9V4lA
	 iBLnc48uEs0TAuUklIBB1rh1+KhjqqusTe6Z4vngWNVt/9yDFEfpL7zSu8F+pmXfG9JhE
	 eprGEpshdQQL/50h4DU1dfbceCkRb/LxvenmRa5g3hkeNAcHIYjbcHYcftNzsXqizXg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=valinux.co.jp;
	spf=pass smtp.mailfrom=valinux.co.jp;
	dkim=pass header.d=valinux.co.jp header.i=@valinux.co.jp header.a=rsa-sha256 header.s=selector1 header.b=TSaGJlQg;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.229.108
Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazon11020108.outbound.protection.outlook.com [52.101.229.108])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0606606A8B4;
	Fri, 13 Nov 2026 13:29:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C0606606A8B4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=valinux.co.jp header.i=@valinux.co.jp header.a=rsa-sha256 header.s=selector1 header.b=TSaGJlQg
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wxAfqOG11+sz22Rx2QU1ZzmJ33/TBOM2VV22bh0qVrVYDfXLTltDJIwNDMsOLDS7dn5jgOEVIVYwBtB66MnaOA4lyejwLwBkqMHZQg68nK01s96t6McfN2D7kvONe5ZVKj/qpmvjj7OVh6RwroqgwuVa6PMc5eJzD+4Tb4otTf4nQOm7H2XZpeDIWOR98ME2C/RLwO4GEwRsyREdaBd598H1vwSFsesT2vDPXyYNLfDeNvR5QblRuoyv5GymqDT3Id13oFqTwy31sAW06eG+6xlE24j0uashSiRgsPuzwFdQgFEq6/n8N6XJ5obOtWgYqs+sZZScpyVcSInasffD9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F/v1Oisu0PIAy2ZFdaf+gTTBtT2r//rszmcD+fdw26Q=;
 b=fli9RSnkrPdzg9vxxAiusxmbD9V3nnhv9KZT38j6MhkuedJNIbjhCSLq9+NheFTfxixLiC+YniTaXYsrjQkkiqBYC1R4gkUY0gtapXGDwoMohibaH9BFtcQk/mRPyuDGbc/lOlSbYDn+qp+QRrco3ev9R4fjcI++wM8sfglndntnnP1QBYxl+8DkBx/FfX6c6F2SDbMioihnOjKUQzNKcNRU2khD9fE77mxFcDVwcWUNc+3U58c67idon0XiFvsnXOKzBpg58iozo+eNmrsv+kh0/nOOuauBeTJY4czfqhWeQLoMWlPWOi0bIRFS8D30HnTVW6sDk7D7jIUZOFRlYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F/v1Oisu0PIAy2ZFdaf+gTTBtT2r//rszmcD+fdw26Q=;
 b=TSaGJlQgUYq7MrtQYoLye0fHE9mrfz9jAxxIjnHYTT199/Yc8EyDJ/C1Qp0Ah/gqMZJxQ2Fa1i8kw9jo9iogeX8DRao2KKcMNThL4UcCKwUfetv6Wkh82/FEAbJh8WeKsEVzXKVn2QpXME1kxXKsXSaEtg4vYA+oPO44tIIVmxw=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:325::11)
 by TYVP286MB3716.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:36d::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.10; Fri, 13 Nov
 2026 13:29:52 +0000
Received: from TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 ([fe80::cce5:2aa8:53f9:dba9]) by TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 ([fe80::cce5:2aa8:53f9:dba9%5]) with mapi id 15.21.0615.009; Fri, 13 Nov 2026
 13:29:52 +0000
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
Subject: [PATCH v10 07/10] Documentation: PCI: endpoint: Document vNTB DMA export
Date: Fri, 13 Nov 2026 22:29:32 +0900
Message-ID: <20261113132935.4152566-8-den@valinux.co.jp>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261113132935.4152566-1-den@valinux.co.jp>
References: <20261113132935.4152566-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY6P301CA0016.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:3bf::12) To TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
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
X-MS-TrafficTypeDiagnostic: TY7P286MB6866:EE_|TYVP286MB3716:EE_
X-MS-Office365-Filtering-Correlation-Id: 1a5748a2-4766-4b6d-efce-08df418a32b6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|10070799003|1800799024|376014|7416014|366016|18002099003|22082099003|6133799003|261009223027099003|56012099006|10067099003|261102123227099003|261102130727099003|261026135527099003|261022105027099003|261026121527099003|261022075727099003|261028144727099003|261021121427099003|261026140227099003|261021123027099003;
X-Microsoft-Antispam-Message-Info:
	korFKGuB7HuNLCIFGzJEnPH6D06xKET0mrqcRyLrl335CWCQlau99IcHegW0oFI/MA4qNCFsUAXlIIZrghZM6mjY3OoVHK27Jd/AXPY99uCCmVKgNuB1r8gi6d6omXplRyJ6B1A4xf/QU/5KK9uxVRhXnRKVY7Xnx4gNRZJQjNZ79JR2jCcbVrw8oajygPxE+bCo3E26JhVoN47ECsLLgf5qXYks5RxwwUjITEchZiGhfPj8ts7om2Er1J1FBlGhmiz9Wh0/fuS47//tVKnGmOg+u+vSF5vME3+xLAT/kOMarsmKsK7JcMxCC7FVJxd8Ei97QN1Ck5zmzfOP6g7hG5CElPwWZJ3IDq91rb6uLsT1IelP2RGGuFkTZJaCYhsp3iRWx7EKbA6WYP/Ap+J3btUV0TE9QDQweM9AoX0B0tFhtG/69yOLZ8wbC1gpHgRnzSst5sdH+Xn9gRsvjGoMfAeg3XzYp5dPFSovsUhJiq3xEOL7Ay/j29zIMjzc+ssVA0HvrJjruIbJInAqnioeZ/fqEqBAkZgV9CvOzxLDRHnZVhYqON0uoHFiYJXxrpodCtPBebVPQrUgqS5XLqi3+zdzpDJor3dJ+y0sdZehXNnPgwf1lDagHogrf3bDk6jw
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(10070799003)(1800799024)(376014)(7416014)(366016)(18002099003)(22082099003)(6133799003)(261009223027099003)(56012099006)(10067099003)(261102123227099003)(261102130727099003)(261026135527099003)(261022105027099003)(261026121527099003)(261022075727099003)(261028144727099003)(261021121427099003)(261026140227099003)(261021123027099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?R1tyhd44Q6BjCZgABKtRZB3fswXVnvB4FHO4+s4il6hPzRG6HWdziXZIXnHG?=
 =?us-ascii?Q?5BVRuqTeVQ5d/VOzz3/chfu9Ux0LG1o4luHjRQfM7phV6r76EALtP4LHp3xO?=
 =?us-ascii?Q?joGKWLYunxN65UlmmVYMlC9FtIHMcGLu1kjGfqOq23+VomRBkHr1YvTdePW6?=
 =?us-ascii?Q?6IlA+elLpI8O30Dk1tXdUudyaPt1N+c8BTZnh3Wt4zKORJc8ZJafzpw3pHZk?=
 =?us-ascii?Q?RmTGJwug1RSewwDVKq7gG39QmbG+6mWD6qFydVwef25AI6P96p6ODOOY0+Vh?=
 =?us-ascii?Q?I0GFv1GjoH/yrqlI4KYOLMoI4mcU2Kh0nJFHvi+qUI2pTe1yhDHTWYokDqvO?=
 =?us-ascii?Q?Vn8k/CjogBDH7Gb+jKno/Yw5ngBYiFHfMiayaHKqETb9/eFXaskx4trwdQdO?=
 =?us-ascii?Q?jsLGwAb87VoQI8hlMUMFI/Fec8G+E4F+sJjEA/tjS7XOkRBDDNfQyI7s7epO?=
 =?us-ascii?Q?qdv1aMOWhp5tI0/IG09pvP9pA/eyvqmj6ALFWSHWnkigS6ISCf+Tx3Ct+RIX?=
 =?us-ascii?Q?32aD0yigaCUmx+n1z8fgpBtsZtWRhStb+ypOyw2MCq4olY/3DcodeVm6hgVT?=
 =?us-ascii?Q?fj3tw5tsherEUlQd7gCaSczfVxfnrwV4RFlSS8DjOImAfwwRaiJndL7xMlh8?=
 =?us-ascii?Q?OhSLBUHyH6R/qgHjdQQVbo7cp/B4dckf865DpjHHXg1iuq8Cp5SLVRB3wfkp?=
 =?us-ascii?Q?eZRylWvmLRzw6DOzSRCapoSIFSNMIDe4czKAu+TRPa4XgluQgy9O9yb3wAkl?=
 =?us-ascii?Q?hmrYleE2rjvJ3w0p/TMo+Qbv6C+vHkSYTaavt28yTK9WiA5Qbr0PfkDYE8KW?=
 =?us-ascii?Q?+zs9N+7iK5HKZoxnE0ujpzwPT0HwSqyd0qZdipX/9kqJdr7Y2Z1v/1v7BMjG?=
 =?us-ascii?Q?YOhAFu64pdKW+cWI8PAM5pDJ+8tCn88iRTke4tmSMXK7NYGd5XJr8EqJ1vCr?=
 =?us-ascii?Q?z+pQwpgDgfww8L4NFlRxhIHj4vlrfI+fNsdGSiFX5YRN2/erbEQ5yqTOP4Us?=
 =?us-ascii?Q?CtYoAUWpW5JnJc4qfVxBOijhxs5ZfGXVMHB1ntyJIQYhOgJRFGuqDluWc+op?=
 =?us-ascii?Q?fJZQUZ+oP+RDMS6tZfAISliA/0LQi85hfPYai23s6Xe9uUtFbXwvHpg6i8O+?=
 =?us-ascii?Q?wFue3x/UIe1tYaPjlki3zpYQ92rusZYUERzFmF6VslSzoCqLtKLP38n8HnWZ?=
 =?us-ascii?Q?ydrjCxCgGv+vcSoPAh9zEyRGh4uxJQ7QbrstlNVr+JEZKfw3zBrtqWzSeYRK?=
 =?us-ascii?Q?K2T9eAwLkX7xUA6m+tPEtZJoT+Cl3S11dS4wGNo4aOW+W04nnmnjEnIpnwW4?=
 =?us-ascii?Q?2WR5+uDSTKtYWFq6xNqIuUngnoRk+J1QycvHOMHH3jx/Dx4OsmaNwgSsLS0Y?=
 =?us-ascii?Q?RCi3X9V54pIVl4O6am4SsMiyuJIumAWCa0k0mP95jeCJi7J5yaNMTxqumor5?=
 =?us-ascii?Q?0mUW5czNjL1v7MX7oyiLvf68K9oAh9xFGuiRMScivpb26IQ2Uhexv0+1X7RQ?=
 =?us-ascii?Q?/usy7ln/wdpKmopmshaRoRXV3nDZ2DcrHuzQvrfxEBSTXmtCt3wCewIWzf7i?=
 =?us-ascii?Q?HHDrz837kWekrZPGDwfhp9PLfAmMxMOAQjwEL5TSLOZ4xkBEQsgHA807Tv0W?=
 =?us-ascii?Q?q9c9vYDOkzaTeo7KN+Duq7Y5n8KK5ywm/gyNOu4pSr0KDuU8+BXa7zP0F8P7?=
 =?us-ascii?Q?hQu7uCLLEhGNINaY/aKq9bazZY7hVQl8rXMJaYJM2bYJlMDhYrWvWfM/W2a3?=
 =?us-ascii?Q?QiVmolDIfZVLcmTO9cVY2i41lOTxhGf7e+XOWay0mBxFNtBCL6JC?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a5748a2-4766-4b6d-efce-08df418a32b6
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2026 13:29:52.4023
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PaKJKbTwwoRiti/59zQRpu5esPvq0mf1eUIPws0jAyQPuDkgEPAwU2ubKWxk3CL9jPJsGe+b8QdZ/q21qP7e0A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYVP286MB3716

Document the dma_bar attribute and the requirements for exporting
endpoint DMA channels. Also document how the selected BAR may be shared
with an MW.

Reviewed-by: Frank Li <Frank.Li@nxp.com>
Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
Changes in v10:
  - Remove the IRQ-allocation fallback description now that DMA uses slot 1.
    R-b tag is kept. Only patch 9 should need another review.
  - Link to v9: https://lore.kernel.org/r/20261110082459.1798763-8-den@valinux.co.jp/

 Documentation/PCI/endpoint/pci-vntb-howto.rst | 33 +++++++++++++++++--
 1 file changed, 30 insertions(+), 3 deletions(-)

diff --git a/Documentation/PCI/endpoint/pci-vntb-howto.rst b/Documentation/PCI/endpoint/pci-vntb-howto.rst
index 3679f5c30254..f53cd0fe91b0 100644
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
 
@@ -105,6 +105,33 @@ By default, each construct is assigned a BAR, as needed and in order.
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
+without DMA if the advertised type is unavailable.
+
+If no spare BAR is available, ``dma_bar`` can select the BAR of one MW instead.
+DMA resources then follow that MW. In this configuration:
+
+* The configured MW size must be a power of two and meet the EPC's alignment
+  requirement. Without the fallback described below, the MW translation must
+  cover that full size. Smaller requests are rejected, including those caused
+  by the host's ``max_mw_size`` setting for ``ntb_transport``.
+* Older peers treat the whole BAR as an MW. The function detects this at
+  link-up and then exposes the whole BAR as the MW, so NTB still works
+  without DMA.
+
 A sample configuration for virtual NTB driver for virtual PCI bus::
 
 	# echo 0x1957 > functions/pci_epf_vntb/func1/pci_epf_vntb.0/vntb_vid
-- 
2.54.0

