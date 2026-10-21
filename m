Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=52.101.228.72
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1792556578;
	b=aLcSgJZv9GWjprrEYx17JsceXccxGzbJgnLSrQA32C2pphvMCt0qxPl7ZkSH/lsOTGJN
	 Ua9WNMRkZzO6xHoZKQPofYn6THApmo/LlWk2YBpWQKgS9sQ8stetsVspgHyxK1/bPn4m+
	 r3NnTBSBaZnSTIreRUJkmsyZaxYnqO2VMR2+9Jt9u+zteEZJxEu3lfQKEi07CS4ySdd57
	 z2x+h2+tNL53FyW/L9+FP7ZfJgeBKjVdDNoC95idFTzxZMQVaTqUj9Eef7kD2wgtVzXJv
	 lcO4I7M0xCXQ7cad34yzMmYvHdG89vr/CtAv1FOjEsrI9PPxnlcFpx9L6kWLaFo6xiQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792556578;
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
	bh=y+S7Vh1h4juRW18hrUr/fHzuHGJmmy5wjThhiCA7M6A=;
	b=eUDASHehq4TSpw2eWMzkoGBSQinIKy3Aa+8oGmUgodNasc4L8S0PCJosIcAUmVjQw3dC
	 vMdxKvuwr632ntvgiBBDG2rxR2XeDwauEOLTLuCvE/yxL7faxsDTSfUHePjvlG8jkfFCU
	 +MeLMjIm4iNOGr9ULl3sLaB4tf6gTOV/GQukjJ7E3iENaNtKSrXYD/mDOy0dM7TieqaTW
	 YP2Bedw2N9KkfU89+IPP+LvhnWLRpwVb8bmRL16ZHrxaXJwy0aE/76Ki/IZV0ZjQDi1Ms
	 NpNqfpAp9Zd5Txog484PPR06dxdeKU+5G9DvovzTMYwQL6HJKOsDOvPEEyfyO7JPsrw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=valinux.co.jp;
	spf=pass smtp.mailfrom=valinux.co.jp;
	dkim=pass header.d=valinux.co.jp header.i=@valinux.co.jp header.a=rsa-sha256 header.s=selector1 header.b=dCK06lSg;
	arc=fail smtp.remote-ip=52.101.228.72
Received: from OS0P286CU011.outbound.protection.outlook.com (mail-japanwestazon11020072.outbound.protection.outlook.com [52.101.228.72])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB644606A321;
	Wed, 21 Oct 2026 04:22:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BB644606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=valinux.co.jp header.i=@valinux.co.jp header.a=rsa-sha256 header.s=selector1 header.b=dCK06lSg
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SBSv+SXB+RRZ+Fwbm1ngwoRnsMWDKndcjfDbTA0fKqOxMNmtFT9SwiDVrTTwPs6mgaPkg72u1JXY9jwoFIpLx4xaRqP0r+rfeeLtsVX/pojQte50i8eB5WkvVybQoOnD51wj7n8RDKpP0LE7CAxLKNTcMqLN6onnhCyrqZp5IWv96oBAoTccA5QF91Z2YGxmCbuo5lvlJnBAWB/VcnFje7Jx0gH3a6s+MCaEQ+p14kvXZ0ENfBBLCezjtD7PZceHv3BlXTf1dg2dCVPuC1Ed6bfTqPLSVWml9oFrxtXlOAQGNpJYeLWrsXzC/Rm29oj3hkDMOHFAXOoxpfxV4ouF8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y+S7Vh1h4juRW18hrUr/fHzuHGJmmy5wjThhiCA7M6A=;
 b=TQNplynLmDS+vseNmuRg78oX6pOk5PKG0tplLzxp44RMgGBQJADvpPa051A3JPYOIClKWYOJJwkeTkp+eGX1EbqpZvBlHVGoAbU6abdfn9MC7GsGDzZFf9/MTf2gsMxLV7/CEg37cN+07WcmjxERmiGqzrNARY4XA+eeb6FG8JH8pN5MyeiosaGSzHrKHSFIkUTLRnzjSaYdoSqc8qASa+ryzAF/X0QbQ0VCxAbXcJhgHuVKe+A3tt+jBmq0T9xw3APDWAYjp4Jsvvv4ET6CjnAiNAC5SUARGKEwOEmiE8fk3v/KKg9GTKBOmEnLJYEmzBvvutTgZqQSQ60p046IUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y+S7Vh1h4juRW18hrUr/fHzuHGJmmy5wjThhiCA7M6A=;
 b=dCK06lSg1KZRzb74kAwPie9P1XFEcOFyuBcRgIogXMPA/tqjba1/wXyB4jwfawjfldyEyyMvJQJKUgSDmaAtDSsRiGVN2Pj1w0k1AvH51Qq3IO46Yoa4CmmpVhHtARzTIeqm50gOhT1f51ZeKgJMpMy4tel7X1AtYDOWsEKZy+Q=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:325::11)
 by OS3P286MB3180.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:20c::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.15; Wed, 21 Oct
 2026 04:22:43 +0000
Received: from TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 ([fe80::cce5:2aa8:53f9:dba9]) by TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 ([fe80::cce5:2aa8:53f9:dba9%5]) with mapi id 15.21.0546.012; Wed, 21 Oct 2026
 04:22:42 +0000
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
Subject: [PATCH v7 07/10] Documentation: PCI: endpoint: Document vNTB DMA export
Date: Wed, 21 Oct 2026 13:22:26 +0900
Message-ID: <20261021042229.2280937-8-den@valinux.co.jp>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261021042229.2280937-1-den@valinux.co.jp>
References: <20261021042229.2280937-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0121.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:2b6::14) To TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
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
X-MS-TrafficTypeDiagnostic: TY7P286MB6866:EE_|OS3P286MB3180:EE_
X-MS-Office365-Filtering-Correlation-Id: 6cef839a-90e9-4bba-a2a0-08df2f2af34e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|1800799024|376014|366016|10070799003|23010399003|56012099006|261009223027099003|10067099003|18002099003|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	WJOlUG470KZS//ExDJBBGM5Tc5Lz1wd1YIFn5090kr6ebYwLhF2/mIyBFBdgUyEBHEWblTicJCPC/hvZUMPXyPcT/cvSVluqYJmuXLDEt4QoVhnHdnsqO1NGDak9J6MdNzucUxFzlmoQ4uaqLub14tl9pCGK0i3sQsWVc/WFnQFIPPPMwBzAXZtc1nxuKrO6arAeGDx5059aObi/kP+9XXQg5z9ipskkcNrPAAX5/S/WDbiA+gVRZjHTNF0WhbZd599zkJKixToh/kb1ltdUNdowPR1WScvZDPHxBSvtsHqvEP5OQZ5WPVOvnbsC7CoppV5PqzQ8niXZczaN0alYdwfiJgi/dx/m20ia0cmYGSrtQjoU6l4meNhAwI0+o5481Cl528GWPr8ifjZqMzpSMk1GL/iLheI53kIU497ArDcHD7+KZwCBPnCoWzpnOKPfdcJz52YaTixleijgYmjpRMmuc1sHBLNqmCu3LcVfODHgorZpyE7FA7PJhdLFuBjMqEiJEO+ty7x2lO6n8Onsea5vj1H5uC6Sfxx6wRZvoa7+7xYshJJ1D59goZSucU77fl9lwggAxUE0ny358B3lMAYh9OH2P5JAGtCYIoZ11WMtxoDnY9bwlS8rhrNmDNO9
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(376014)(366016)(10070799003)(23010399003)(56012099006)(261009223027099003)(10067099003)(18002099003)(22082099003)(6133799003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?B7Yt8o123PYZYI0LGTpOdpt2UycJLdrmzRV4mTa8ZAQ8tzLf6MRsqmHz0bj7?=
 =?us-ascii?Q?u4dhEP9u/9zycHZM2otKVo17bpKNAA2WI4WtMTQ/n4A6uJO64254JNFCudDy?=
 =?us-ascii?Q?jxnHUBLOF0YmPXebg0ejdzCXq8Kt5xm0ylaDce0nlgy3Mc9VHI9lGrhb0Ejx?=
 =?us-ascii?Q?/owBkDdyo6b5Y/gQ/olSb/59e1wRPMBGtXDXYnrj23MmtDhACw8MZDf2VYaT?=
 =?us-ascii?Q?rj6QGI2n/c/OiSqGNJuZLlxpmtvZQdvtQ5o7/fEi1YlOXu+1PJokJFPYhsno?=
 =?us-ascii?Q?Rv6/H2hpJ34KxqV4AISbWE5/wYTUxcVK+EifJM3ybuLmU84S0nYtrR1zD4nb?=
 =?us-ascii?Q?KiF4MYhFvM/Pj8w4o/6tPbHmUGhAM9gedsHSTyZ7jGE2PX8iCRLCSXjnoEjE?=
 =?us-ascii?Q?s8vP97ooxj2i7xgGms6zo1kACWsXBiEJK7B9o5c4vmxMg6LyLie5MYblr9d6?=
 =?us-ascii?Q?wE0+qn/jl7AmxgVHsK5GgqQ2sLha77aE7+l3MCU8ashjsLNm4G3pR8sz2x8z?=
 =?us-ascii?Q?hBePfGI0o9q7Hi2DZdiHbkWJL9Q/J1AVidkP93Q+XOftTXc6Qt3B1E+WHm9z?=
 =?us-ascii?Q?k+Yq88r3cw8CWQt0cspSRqTby1jSqyoEJW6JMmORvVvbHGnx6Jxiu0ErXKRG?=
 =?us-ascii?Q?rctzulLZOzttXE6xUVjRqe8dvg/bVXPWzmPLE6WDzeeYWumTf+ehhBOqvowd?=
 =?us-ascii?Q?4z4ghjCLE3Ka25yzduIZ/IWz9jmTPGf5QbTHBObSK+zptgdkoXn+OKHBwAZw?=
 =?us-ascii?Q?0NsZ0h2FbWpFGkKgLJMYPPYiBQd6BlXlZWJ0s9UcSyQZueGJ5baR4PXBVTOx?=
 =?us-ascii?Q?bSTLcyblRvkrA/yzBk7TQRwmVDGnloIekBa7AarbF3ttqWg7oerhL79617bk?=
 =?us-ascii?Q?X9WzGOAvpcPzPbKuKU4CuV2ouxrqIOtHZMqjdtBmToIld0vbPHagRk6IdsyO?=
 =?us-ascii?Q?CWQFIVXS4q+GpIv3QPpl0A0VKzQADOA66BEcAMQ2tQ3xW2weNC9hqC+cUVcj?=
 =?us-ascii?Q?QQt+TGIg7L3/lH5bx1uH0BIvVDCs0T2S5MhgG3dUTgddotmI2fGp6Nc60YlC?=
 =?us-ascii?Q?tA+fPb7i+wdhRpG+sBs/Q9+8JNSBiH/qgw060IlYFTasclEVy4fKiI26gLbl?=
 =?us-ascii?Q?w+E7VdpQih3seAWcNdANye2uI9teyypdvFSbfHAdNB/S3QhkqPLM8q9vf77A?=
 =?us-ascii?Q?hh/wMnxeu/Vyi2iWyLchvf9CWUupHnsAOSnc3PBaRwv4a0ZN9w8dmAGKdJHi?=
 =?us-ascii?Q?AaIBadAW++O2psD9jzqbFGpVx9H3F1KTxiTudMQVTzRcjg5UOIuyiGMN3PJy?=
 =?us-ascii?Q?9tyB2FA0cqrj9N5zvnmD3viVDHEXTmVrha+kgr7L3iMnq7nnoDNXnw2LveeN?=
 =?us-ascii?Q?nGS0kmEeS5b6pS4JRsOblw2qgtxomnzgmZ5NQL6FGpNIkypj10V2m930wNeb?=
 =?us-ascii?Q?10R8LsG0Zjpo1OLMqEXcZSQuSDFpkPOtd57QL3OO3T6chmM3V5az184n7KnI?=
 =?us-ascii?Q?IUQ7cHDEYIMlLMpaKB4hnuJ8THVxIFVXAviBRosjgQj7wdNu8fQvMH1lg/lF?=
 =?us-ascii?Q?wKUQoSkNjx1whP7U8rWJ/u9AZzJJwV2hs8KYtb9Dmf7+Ds+mggXdHIqCAl/B?=
 =?us-ascii?Q?IIyq1RSCxWOVyJj32j9MHPATHjjpRLQJGBsVGoM+a/wpCMDq/0a8H0z3VW97?=
 =?us-ascii?Q?OL0Lb6whnaV1HR/m+xGfG2notfEzzKouMUQKBjtsYLXs3wwS7Ee/0PpBbCoo?=
 =?us-ascii?Q?XQnCySDzHOu+klzm3mHgfLEaQmLbLxniESsgz8HmhPQ7c681aWLT?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 6cef839a-90e9-4bba-a2a0-08df2f2af34e
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2026 04:22:42.8688
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OjcejzB7wXz7QvNBWTllLOW6zcxpoKZ+PolV5RlxpEbm0dTa5DQsx1Zhn5hc5LRnLH+QIGOS8imzY0HTxAuKEg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3P286MB3180

Document the dma_bar attribute and the requirements for exporting
endpoint DMA channels. Also document how the selected BAR may be shared
with an MW.

Reviewed-by: Frank Li <Frank.Li@nxp.com>
Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
Changes since v6:
  - Added Frank's Reviewed-by tag.
  - Document link-up rejection for peers without MW/DMA boundary support.
  - Link to v6: https://lore.kernel.org/r/20261020054948.1218370-9-den@valinux.co.jp/

 Documentation/PCI/endpoint/pci-vntb-howto.rst | 31 +++++++++++++++++--
 1 file changed, 28 insertions(+), 3 deletions(-)

diff --git a/Documentation/PCI/endpoint/pci-vntb-howto.rst b/Documentation/PCI/endpoint/pci-vntb-howto.rst
index 3679f5c30254..d909e2454804 100644
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
+* Peers must support the MW/DMA boundary. Link-up requests from older peers
+  are rejected because they treat the whole BAR as an MW.
+
 A sample configuration for virtual NTB driver for virtual PCI bus::
 
 	# echo 0x1957 > functions/pci_epf_vntb/func1/pci_epf_vntb.0/vntb_vid
-- 
2.54.0

