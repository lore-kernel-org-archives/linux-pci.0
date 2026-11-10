Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.125.111
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794299120;
	b=1odjMgie267rinnES7OA77rPAsFX5gw3uxHD/8hBNwql+nSB2gn37su9IzEew7FyczSm
	 2PZirL4X0+dDCouowEPC9maZxCY1wbjb3Ncu/8pdRgQ2DR5B/RJRIApgpXV5X7Q+OA0G3
	 LALe9nUt1WBgeR36fL3w62eUt4bYR+74r+lbKZEEHBKhrwqJ8YZgXiexiAJKkwVGll9I2
	 apOW4Q2tAS/FEiahIm3U2gsm7Kav15W/Ow2S0ObYcWJMgj+F0H0O2bRuGlQTNmo0x9NHE
	 lj8dfS51ZYBVfJIgKuDNH+uSI/qYpchLvq7djrJohnVn2TxK6Fv369qBbN11U2VB0AQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794299120;
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
	bh=+A19KZktfJ9WubK3tSrVGgcJywvdEEEzc8mO41Be7dQ=;
	b=4z/NAPh7znbdzTdzLRGlctrTfKoYNfl6bAXPB0G9qkk32qNJ0czkb18NV/sHLApCrwX6
	 ++x1hynTqLHFDDJ9V5yKYJW9OFVmIbB0Oe4fnPKYls6eKWDIU8X9okqvkf9xoIeun0vyz
	 JfkVlHJGrzWVYZHEwbWVzh8OYqSJ1j8L5GB+ty/+UnMCXz/zb1bxuXWXSG4Lh6RLGzyBB
	 DiRbF9Y8AhSELSjSYd2G5lZu+gzlmZ83KX7f7IV5zFKQG9hq75NaYSFBWC24eEW+cIxoS
	 RdQIezLwDRmkBSVt7mwzMcaD20i0RegRvEcvJLGn0YMK15kOagpc1xGg1W6lRi9VklQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=valinux.co.jp;
	spf=pass smtp.mailfrom=valinux.co.jp;
	dkim=pass header.d=valinux.co.jp header.i=@valinux.co.jp header.a=rsa-sha256 header.s=selector1 header.b=KtKp8Eq8;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.125.111
Received: from TYVP286CU001.outbound.protection.outlook.com (mail-japaneastazon11021111.outbound.protection.outlook.com [52.101.125.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A72B360A260F;
	Tue, 10 Nov 2026 08:25:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A72B360A260F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=valinux.co.jp header.i=@valinux.co.jp header.a=rsa-sha256 header.s=selector1 header.b=KtKp8Eq8
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FwjroSqLUPWPawXHaBXaya44b2FUav6kHXC95N68Wiz8DnnKVVnmwpP/j7zWiQf583FtD4LPmXTSNNHAEJ+YXohBa3K812bBb9dGMb6YlEa9PkmVA7pE0F77N+wQzogV4fiFhHAdUI/Ojujl5Vnk9U2sxqE8vrCRJJcWkt9E5y5/VwCGbAc+ANQizm7OF22IuxsBe5wrshhHI1KdGKCCLh6cAUfQQu8zsLOL+8WpkotEYxjnANNlo9fR3jLwwhmefP9IDE+XcI4UsPkMBsEbVMI1LIpfBI8tuU4N4ojRYbMqV+c3ANtYfGfy0wHTBgNP9OsRJhFKZ1wm1rA/JtRwAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+A19KZktfJ9WubK3tSrVGgcJywvdEEEzc8mO41Be7dQ=;
 b=DnSSZ9jHZqy0MUhA3FfjIOvTcRatZOEP3jTLpYmZyORY5sllCFqddsEKki3J4fHuEZg70bTu+HM20mzvlX8BlwKo+N2sJiyt4MU9iJCBaxWX+VuqpXCTTyhegahwKImKyOc+5pA7yeW5t2NaH8uHbwwX1/gFQ9j0RU2jZ40LZMeChHbP7LM+v+KXYTqSrqJ3owF++2d/3YuZGqbYBR9Yew41q1dca91FbJKqzez6dD93YpOHOFoe0LtqFzIja/tRhsGqO+CIXIv/dQgFOdWT4zWGebktrywl13kXc/8t7ECMUGvrRk2fq9mfkFTqBFUbK0NoQpxD1hLRg5JF0lU9Jw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+A19KZktfJ9WubK3tSrVGgcJywvdEEEzc8mO41Be7dQ=;
 b=KtKp8Eq8ZcJEJjKpGJE5t722dA0uayBlrcsU7hoPZSzdYfxeig9NRuTNwEuFipPHNBMbBjtDKTigAFI/MuuvV7W9Xdc/4hdAR5GIMWtX2Yf4XkCTRq2Q8jwYmkVc+ab8Lv4e+Q27Mu5kmPqhO2N3ZZTvmwOCsZGVXwplvJ/jRfw=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:325::11)
 by TY3P286MB3015.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:318::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.13; Tue, 10 Nov
 2026 08:25:12 +0000
Received: from TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 ([fe80::cce5:2aa8:53f9:dba9]) by TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 ([fe80::cce5:2aa8:53f9:dba9%5]) with mapi id 15.21.0592.012; Tue, 10 Nov 2026
 08:25:12 +0000
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
Subject: [PATCH v9 07/10] Documentation: PCI: endpoint: Document vNTB DMA export
Date: Tue, 10 Nov 2026 17:24:56 +0900
Message-ID: <20261110082459.1798763-8-den@valinux.co.jp>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261110082459.1798763-1-den@valinux.co.jp>
References: <20261110082459.1798763-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0320.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:3b7::16) To TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
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
X-MS-TrafficTypeDiagnostic: TY7P286MB6866:EE_|TY3P286MB3015:EE_
X-MS-Office365-Filtering-Correlation-Id: 1f60d284-ec80-4c92-f230-08df3f0423b8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|23010399003|7416014|376014|366016|1800799024|56012099006|261022075727099003|261021121427099003|261021123027099003|261022105027099003|261026121527099003|261026135527099003|261026140227099003|261102130727099003|261028144727099003|261102123227099003|261009223027099003|10067099003|22082099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	p+fGk3Xw4XK9OfhDVXDELFDN2ucioDiDje3hXoWv0xF+guLn82OHrvznPwdlF5IPq2mUnpaVI3qTAcy01e5ozhx5khZaa/IdjpFmvZvic4ZlTGEa2SKHKdMiT9NY0opbR6cJDGsdg5JIvP+R8ApCjC2TfMyXeBFiwAocG4M65GuwAcXxVPNjf/skbMnqngllgaV9WayEyfI+ndJb3JeVrEhK5bZHVYMOMqq2Po1r3PESKUQxMvw8+Jay0ppFIhhjfy9XhloQ4e/mXVlLP0gFbPHTDtS4N2rY8knh8AZXQG9l6mipuVujyR6svtbtW3gT8CtOFLNphdUQI8CYC4o3/TlBNdCEIUByN8DOyeAVK+KGq+NB7lD2OE8M8Ca6Tb0cMclAJi8LVY2V8OXf7YQYbEYNbju+Ow5K9ytfP+Hb7XjvhexRl/0fB8NK0+6iK3npsncKdCl1pjdPzjVOe51Ur36GwyuMP0BZOHlpW/XZWG1SYyOr2t8xknueThMVodFbtgd6HfKuOIgJZ4yej/fknIphTFUMzZLgysgdqTuyyrnrcXQr9AD6F24Et4HNvGrwASbWNhCBr2+LOrY1JnCAcKKlHlbxdFAJh0QBOlOlhEmooIeKqYFR9cT5ln1EqDO+
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(23010399003)(7416014)(376014)(366016)(1800799024)(56012099006)(261022075727099003)(261021121427099003)(261021123027099003)(261022105027099003)(261026121527099003)(261026135527099003)(261026140227099003)(261102130727099003)(261028144727099003)(261102123227099003)(261009223027099003)(10067099003)(22082099003)(18002099003)(6133799003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?3t52LVxSI6gkWd/lSFME+oShGhGIfsdAAOkCYu+gVkAcS3yyn9+SftWkRX++?=
 =?us-ascii?Q?SN0gB2MDLyHb0R6mnmwWQ42LjGlo2aWWBlg5Rkuf4UcQ1uhKJ0V0y7jpwUMR?=
 =?us-ascii?Q?EwqS/sPdPKRBVr9TBz3v4rqRMKZ3QVAAn2xnt+Xz+0P3bw13ZxwxcW/d2m/+?=
 =?us-ascii?Q?r50OHEzhOqbciLntw4aPzB8WxpOyPkNmiKGogrv3mr4Q88oH0dEQChpDcj9H?=
 =?us-ascii?Q?n1FR2dlT8Db8XDKRCSZid05PqAo0VOzsiIRqnfBMgw5nzKmL5l3EAyzuk4uy?=
 =?us-ascii?Q?0XrI+BMDv17mp97E56ubzC2qQYbSgjqzl8v1gaU4Vri3r/EuD0ZKpU963Ipf?=
 =?us-ascii?Q?wWeASypFA/LmhNcDmFj04l62PxUD5x/lxyXqYj+GwdF7oIi0RhDkPTiWCk/i?=
 =?us-ascii?Q?eBVKTEyl/UGZrRO1xLJLvXQTPC49uKPoNPnchdgzGn20pqlguAuY3lwC7Drh?=
 =?us-ascii?Q?lZbZx65DaRbhyIyB5NiMkjR4QaW9ndBYVDAV3vInJ/SVdzTgs7/3tcFWU8Hx?=
 =?us-ascii?Q?aWzy0xpaT77XkRBfe91NpigatBi3NXD+trSxWjDVsP32fPHjF2taTvJ7bosd?=
 =?us-ascii?Q?dtUmQCzZGAeOJ3bGEC0BhWvRowdbu+QQY29PED61UsfpHwDFOFkVJrJVzdpj?=
 =?us-ascii?Q?loVQ/zrpE/rdOI+JqqLDNvTCsUx24jWSQ5rvpnFS6jXvROQPSeG/ji5jbWX/?=
 =?us-ascii?Q?KJy6FNdMi5iWaQTiz4gUjBtBGoow6lLOGifpCzzHAFcBKpMMzsOPPdgEy4RX?=
 =?us-ascii?Q?22JlB3jHa7b1MQYIA944qcNpx3SS7sTEHpcnQK3F9DJKy+aGwYpHs1VboTn4?=
 =?us-ascii?Q?i0anN0K98xMdAUTaGyNGdaWuh0qTKbfAJOyLHqXOKW6rReICE0ceP1t94vRU?=
 =?us-ascii?Q?cao3YDN4/S60RJtV27n8eCNWe2MbZTdPy5UIgkIs1xd/Mn9ImAC7N34kUH49?=
 =?us-ascii?Q?HhgtGsuIU58iFZBYxjdRD8C3jvvUGJcGhcHmdgWa2ATxzHVSBL5tqQb1sTha?=
 =?us-ascii?Q?y35paoxJRNNuNkJ+/wIVFj2LaB99CkZEkLkQiBpunEHQqFVWlF5+YmFDDj/c?=
 =?us-ascii?Q?M0Xhemsu6wUxGgibnwopP3DnqeZg9bCxikuPRxgpCh8HZQA1vQoVI/8jxzEi?=
 =?us-ascii?Q?lUl4f+V057LLP/6PV4VVaoca6guExxxfNUAeXAVu+mAYzaU4Drksv90UZ+U+?=
 =?us-ascii?Q?b9dGrH/nlWXk4PkT6+j+VrySC0AnpXhhDkyMI4x2vR6pdD4g9Usm0gHfcO+o?=
 =?us-ascii?Q?WD8WHj82km8uHLn5ce9haKKXTAGPWFEuKytyP17bXQEIebbauvclOJQbSHW7?=
 =?us-ascii?Q?1aEFHspSDnK5b9RzGKGy4IlQ8yLc66HBeFWw0UJRCVTtHf2g+aD1Ggy3VGTj?=
 =?us-ascii?Q?8lxNchmB+vM7BOcoZcjUnYRkCg1FmF+V/1ZeP5d9tmpWxnexOH5dBmAKCsjq?=
 =?us-ascii?Q?06riYI85kFcY1uiupYYUhyU77Ujp5jqgHNKHaDD53eZqC0PBo2i1i5dbmJJn?=
 =?us-ascii?Q?DbffxSD/bFt4acFVLkXKBo/CN1dkgJLkCPtvHIYdQs/4JNCoj8BgtyShYHkT?=
 =?us-ascii?Q?alrrlcnQdzayR16oQCXTZH1CiBAsFTcTomki9nqWdzINrjvkzvqHAlXGtGX4?=
 =?us-ascii?Q?L7aOw6rHE0zR9Q0XZzHheVt9mrY+DMhA+NnVYPDRbE/vBlLyGqU7dxNk/pdG?=
 =?us-ascii?Q?fv7gBsbd7yujLBPV4fYTrw6tQ7Wnj+lLquMmYTLfD1KQ38cRYfAqwj5T/XRM?=
 =?us-ascii?Q?4KiD+CG/daL/pW2r5/OgRaCSYzi4jitepy445/rblmbOUqBlb5m7?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f60d284-ec80-4c92-f230-08df3f0423b8
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2026 08:25:12.2556
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: at9o0/ogWCKilaE1lH0UQhVOKmHJRWpoEAdNu8uyRiZyg14L/P/vpH9Se/QfXsLn/juqHhxjiAfnxxUv76COtw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY3P286MB3015

Document the dma_bar attribute and the requirements for exporting
endpoint DMA channels. Also document how the selected BAR may be shared
with an MW.

Reviewed-by: Frank Li <Frank.Li@nxp.com>
Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
Changes in v9:
  - Clarify the max_mw_size restriction and EPC alignment requirement
    for MW/DMA BAR sharing. (Sashiko)
  - Link to v8: https://lore.kernel.org/r/20261022082230.3164834-8-den@valinux.co.jp/

 Documentation/PCI/endpoint/pci-vntb-howto.rst | 34 +++++++++++++++++--
 1 file changed, 31 insertions(+), 3 deletions(-)

diff --git a/Documentation/PCI/endpoint/pci-vntb-howto.rst b/Documentation/PCI/endpoint/pci-vntb-howto.rst
index 3679f5c30254..7f2fe24ea60b 100644
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
 
@@ -105,6 +105,34 @@ By default, each construct is assigned a BAR, as needed and in order.
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

