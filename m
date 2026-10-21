Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.228.72
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792556570;
	b=oPr2Q+HCoF6ZC8mQOI91RW5wHWOUff0JsUIXuxgNRdzO/RHn8SCoGmiliRVckTDqOX2i
	 qn1DE57sSsOCiP16sHT5MrPmnwEeAiW95toGQ2QrPVSagNX+DPux8KY+FdwtNrXewKCwQ
	 lXVN5sppdk0GNEVl8fHclobVUa5HQv7tJ1SReNr3bl100jQ6WGKlFSI2h8eZDjBcln/xt
	 XWORnv/rcE3jonc2xgpnIvaW0go9hZfbT9dP570pRth9q+GK+B713y8vDL0VgnppmHgTX
	 A67te2aAbDBpTE8OH/61EWBZPohei+0UhWyx8/+EYUAyQmV04CcvsuEE0mLJKI7iW2A==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792556570;
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
	bh=S4l6Fv39rvHyKHu1t7JWL+XSPbos1FsfgRPPZACr8r0=;
	b=T645kA8/J5pqSE2QoRWWLgIkc1dU5MTBnbZHcSoBMQFkFqGYR/ls+XLI5n5U3JIxaS0J
	 Dki8r5cWQEYfoQh8uCOvpITnX1aEfZ/84+ojM4md8jNVFUEDXjN79ZkPFf6vvGP6AWN0w
	 e7y65MI9gPHJnxYxnjeIorDvWr39i34MFitjlAidf4Urmy1sZKEErjjg/4mNHmElx8sME
	 1jP2zn8i+N4SvJXszzVwsNQP1E+VVpsrKrr24ZKUtC8MSV37utvq0iP2cyUEj0n2axnYk
	 e+o8fcjtcE8RgjSG8bqtltSfKNv7i6G026bK2oGvIwoLWHm+H5F6kFeZos3UqxtaFWA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=valinux.co.jp;
	spf=pass smtp.mailfrom=valinux.co.jp;
	dkim=pass header.d=valinux.co.jp header.i=@valinux.co.jp header.a=rsa-sha256 header.s=selector1 header.b=UqJo9Aay;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.228.72
Received: from OS0P286CU011.outbound.protection.outlook.com (mail-japanwestazon11020072.outbound.protection.outlook.com [52.101.228.72])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2494C606A31E;
	Wed, 21 Oct 2026 04:22:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2494C606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=valinux.co.jp header.i=@valinux.co.jp header.a=rsa-sha256 header.s=selector1 header.b=UqJo9Aay
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QUnox2Ej82fW9sWrqXdfZWXlwItA5hFRIkVut7C46RfKSj6LWB840obJqy4G564zxPzt3+8Qn4ap3HVaX6ja50d4s93K0ojbR1ql/RHWX3fdzAyTKJB+nSOSBXci2sIeFiGZi3F4Syu4NFTfOCeEAArn5Kg+39e9v4/1NQ331o0XGVLizWbAYk0S8RT6FClUv891h3iBpQhsro+TxRHjIoH8FAVXMgQczciqxMRaRvJojXO1nM+Nhg1peHkx8wXOUfHLnv79ML69iNqalGu3etPfEQrRoC0/rtm+6+5P60teGVZFKBecKzg4mUjZIsS+k2MMqbYmGLUX851rHU5+Hw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S4l6Fv39rvHyKHu1t7JWL+XSPbos1FsfgRPPZACr8r0=;
 b=PfHbU0zKtRm6Qb2DRO3mdIxRDsJkC/wIV3SUo3FNUjHIbVID1BbZHxVijzmqfp4A059We3ClnaJfgYoHMX7RfzzWdfUXKTTh7BKMCL9KWWQso38uyP+so2ixViwtDdIn2H5BpFx5kAowQMAuG8ez8PkjSy/dIfC3d+vdhx16AxAJqQOMiy9rJfe6znlZYbykW409EyQwcKBi1sIKrJcBgcxRlv/fVtBdumCYrL0Jn6XW1VcTU/gwpV5R1Qth3gXpH8zEBZz6Sx4MT3OJ8nbBKiwIGpi4aFUp+qGbm9Dw2uYp0XCZcGsLjWUK0xwEuXK5U1b4d3yIs3qidNWkNouT5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S4l6Fv39rvHyKHu1t7JWL+XSPbos1FsfgRPPZACr8r0=;
 b=UqJo9Aay6lkrr4whYik2QrNPv9WBBUJ62D/c+Jo5hEnqgcctJJyyB1hGHcKcP3C/OA8Sp2eyLF5nQWHW1tGCqwPk1smaSGKnsaYncZcuOXh/16vNBqahtsL6GnmUtwH0gnEu+XSpCOgB4wrEF/bhoqoQwme6kxk526dVWPFR4oc=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:325::11)
 by OS3P286MB3180.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:20c::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.15; Wed, 21 Oct
 2026 04:22:39 +0000
Received: from TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 ([fe80::cce5:2aa8:53f9:dba9]) by TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 ([fe80::cce5:2aa8:53f9:dba9%5]) with mapi id 15.21.0546.012; Wed, 21 Oct 2026
 04:22:39 +0000
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
Subject: [PATCH v7 03/10] PCI: endpoint: pci-epf-vntb: Move epf_ntb_is_bar_used() up
Date: Wed, 21 Oct 2026 13:22:22 +0900
Message-ID: <20261021042229.2280937-4-den@valinux.co.jp>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261021042229.2280937-1-den@valinux.co.jp>
References: <20261021042229.2280937-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCPR01CA0150.jpnprd01.prod.outlook.com
 (2603:1096:400:2b7::19) To TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
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
X-MS-Office365-Filtering-Correlation-Id: 24cc61a5-07a5-4215-37e4-08df2f2af0c5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|1800799024|376014|366016|10070799003|23010399003|56012099006|261009223027099003|10067099003|18002099003|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	le/QvTqqG3+MN03rM2LNCRr31bUJkzchtphXzDj+cpRF1OI1PqHclBqBwXmdMpy2BP84ZSN/ZCkPGiuqzgSt0K71Sk2s9/dvM3taoBozmiHC69i7UZfWmBm9JOKkFTrX2Z7qoXPO0P8VG4zpGqaPGtv6G16RdQ8+yaXYgDcUgMve5vBnMbaQ7l63qcMSDdeRwM+85da2CavHO77x3ElKj2ApgARZ5ukvxpTcAeEqZjR0Pa5QRq/JNVTPV21TK0BHx03N726Z7B4XFymI+0eAjE6Toyat6xh5SvuCdV1b42AuvMpMqK0w5Kc9Hxq5fa0c511Izg4MrwaPyTYi9t6u7D7N6AKkkqyUQkjuX/2i1NXz777ZIp1CgzWwsvx3CVqxYgvPa49bkM83K5Bknlj/O8g5X9TKQKW1KiKXQ+9o45LFDobkR1UI3BLJ4ZfLzWHznTm/XPbpD3nezXtTn9MBAZZkOyEaOC+tNytT1r3Jl63sCApAhbf1ItCt9MkKI4bwXrRe/Bx4fLcAwWA5/PWwnxEWmb8kZeO4U60O7VT4xcXMk9YwBTvDHvYrEVLBhvwICH5CMiFyESolSaiBeoe0RuOJryO151znuHLocwH4HjsWztOIu3jB/PrHy0Jbt/3KSMMnOHKHh/FI1pBIfAuW/PmdsRlv82d+iRM+b6Frzp4=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(376014)(366016)(10070799003)(23010399003)(56012099006)(261009223027099003)(10067099003)(18002099003)(22082099003)(6133799003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?bxqAeLfv7BttubDqDcN/zCH3yPTEsMoFDyasINL4z8XJWF5NbfGJ+MQ23oFs?=
 =?us-ascii?Q?AgBX5+v2RRqT01uxooKjr7gWj4EEaFkGFIw2IdGRys/o+pUnoXREAe5+1a+J?=
 =?us-ascii?Q?zFRdDn1F3XF9xOzEWj5M4ghX3TpReHYAiFNm9AMsOExmgW2nUxe+PXmPPxNW?=
 =?us-ascii?Q?ywh7BMkYfNG4GHruxfTl1+ow1dQVg0Ko7XLjXstzSXQqfI/vmrVDrXnFFDSq?=
 =?us-ascii?Q?+lff6UGvJ/jtJ4IjPLCctfWV+jhMiFDV9f3LlUSSXdHZ363gzir0zAyxuhp3?=
 =?us-ascii?Q?f47dSfTn4hE+Q/28YrVPihtMuMd+eW8p713+m2Z14wnW4b0vfJvpKxLI5Tff?=
 =?us-ascii?Q?jvUl5VnISqkZKBsouG0wFg/6jgKuybubirVbj688Vlaa6am7LkASuEqKCCzV?=
 =?us-ascii?Q?Yqben/U+LQBaxc4Gd/86+vNIoUm+FhUGnzWLZwbvH1U6uxNAj/3n0jepVOem?=
 =?us-ascii?Q?qEKA92FnJJMYfzGQq3p7Kgedf0QSiR5cEkf3MfJZarsrxEkhX4L309OsztAI?=
 =?us-ascii?Q?HbUF+c9bw0Cuu++jfNLpTViAV6i2TQeeR/0UD13VyEOxH2eFL0bpGfjZxEM7?=
 =?us-ascii?Q?pw4y8EvJ1pTghz3d0thd5iHBCGWhI17jhmTWXAGv38QqhwJwhQCoJUkA/pXZ?=
 =?us-ascii?Q?H7X4Xhx2VOldlLVRvEleF3d2kucsgjXonA/KchO6jwh2j6mcZ+/13+rrskFq?=
 =?us-ascii?Q?CY1PRuGt9kNmumTmlQ5Yjllo73CLV6UWpL2vN3EH/p+AXNUhUu7dVR9zQP0n?=
 =?us-ascii?Q?oIptCOgxNiGphCLv5E47IS8oe1O8mGwr2WekvpKPcqzRGJS1eceQYuUwiKtR?=
 =?us-ascii?Q?Pct6YeSl3JOzuuAYnGc5aPaZwOh2R9oIc6T6eYNXiE/xxX9As6HNnoflc6oP?=
 =?us-ascii?Q?CIDNjh0BtDcA5GESQR801ze4YcJP5Sma6uilAP9oPJOCV8lpE+YcU5tsPd7u?=
 =?us-ascii?Q?WN1/1GYI8l5I8f0GIPh7gML+Ix2+mXrtdg1Z2NWYsET9cw3m20glUka9ljbq?=
 =?us-ascii?Q?qWyZcXV4sqnkHGrrkD11NAIJoeCjtvPXh53F1liZy6QUXwF+mfwa9Oh1Eobi?=
 =?us-ascii?Q?gzUwOJqdgE35D+hGcWHyhSqgGiUATMeM+EiU/E/WgWYfuzs5vrRo/Fvti1hj?=
 =?us-ascii?Q?Q3AODunImERUNqRJ4gQPx0Wo/GFXVdnrJ2huo75q56ZM8vhhz54spbdBs9Ko?=
 =?us-ascii?Q?+UB1O0Iok9fO0/QH2o4J87lRCJ13/BZYHPm498XzzgUbh1Ih4/73MhlszcAl?=
 =?us-ascii?Q?aCcsh+uIvY0hXma9ZTsAFbKMoigm4mKdO/I1eQGLJAySoAhTcSuUZehVrU48?=
 =?us-ascii?Q?BjmXZGOaM7X2L9FIiwtk6C6Ivkz6xZ9Ras+hfvw/NuI7fMzEeRhWxPYoAt9d?=
 =?us-ascii?Q?pl8MlklitOmTXC8Qiz58kenbTdXbwsiERo+sectp+KrAZtyP1dqnGCZ+cSDW?=
 =?us-ascii?Q?tlZYMm8AGrlww9ngHdFrL+jsNPKNlUDufj19+HM0RbmlEC7RM2eN4m/wnB69?=
 =?us-ascii?Q?wN50YUwjDEcmMKIaglI+wafBghWjvy2LD+tQxrnDY8nKz2YY+3G9gi7kmaeu?=
 =?us-ascii?Q?g+N2LldvN0j0KrUNGQTbvVhGvrm4oAdLNFm6hf4PokA27Sdcp9BJf/cnxy6G?=
 =?us-ascii?Q?nfIt/8qYLTcuueG/YuklVcUr/STqjOFrbIeOVQ4rRwUicFxeZ2e/hA6XDV/w?=
 =?us-ascii?Q?bwx6FYSadet0/3yb32C7sFX3YnwqF+pM9rPd+ZwYpTMT+3JxpQCVE1KDl2yF?=
 =?us-ascii?Q?I6Ll+EGwqaXKTBehdTnBR2qgWloiiEK4kklVMfVhzU76qFvT6nyJ?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 24cc61a5-07a5-4215-37e4-08df2f2af0c5
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2026 04:22:38.5515
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: If2XGKLrmONxPwf75rmeKOtrzOeZjteavZQkdFUimUPp+qxSkSt8jl1KmkzttKK+68ZlY6Ep2ZWGoxIp1HEQGg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3P286MB3180

Move epf_ntb_is_bar_used() up so later BAR selection code can call it
without a forward declaration. No functional change.

Reviewed-by: Frank Li <Frank.Li@nxp.com>
Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
Changes since v4:
  - No changes.

 drivers/pci/endpoint/functions/pci-epf-vntb.c | 40 +++++++++----------
 1 file changed, 20 insertions(+), 20 deletions(-)

diff --git a/drivers/pci/endpoint/functions/pci-epf-vntb.c b/drivers/pci/endpoint/functions/pci-epf-vntb.c
index f77e28f2fe96..1a0ce31e680c 100644
--- a/drivers/pci/endpoint/functions/pci-epf-vntb.c
+++ b/drivers/pci/endpoint/functions/pci-epf-vntb.c
@@ -244,6 +244,26 @@ static int epf_ntb_set_link_enabled(struct epf_ntb *ntb, bool enabled)
 	return 0;
 }
 
+/**
+ * epf_ntb_is_bar_used() - Check if a bar is used in the ntb configuration
+ * @ntb: NTB device that facilitates communication between HOST and VHOST
+ * @barno: Checked bar number
+ *
+ * Returns: true if used, false if free.
+ */
+static bool epf_ntb_is_bar_used(struct epf_ntb *ntb,
+				enum pci_barno barno)
+{
+	int i;
+
+	for (i = 0; i < VNTB_BAR_NUM; i++) {
+		if (ntb->epf_ntb_bar[i] == barno)
+			return true;
+	}
+
+	return false;
+}
+
 /**
  * epf_ntb_configure_mw() - Configure the Outbound Address Space for VHOST
  *   to access the memory window of HOST
@@ -906,26 +926,6 @@ static void epf_ntb_mw_bar_clear(struct epf_ntb *ntb, int num_mws)
 	}
 }
 
-/**
- * epf_ntb_is_bar_used() - Check if a bar is used in the ntb configuration
- * @ntb: NTB device that facilitates communication between HOST and VHOST
- * @barno: Checked bar number
- *
- * Returns: true if used, false if free.
- */
-static bool epf_ntb_is_bar_used(struct epf_ntb *ntb,
-				enum pci_barno barno)
-{
-	int i;
-
-	for (i = 0; i < VNTB_BAR_NUM; i++) {
-		if (ntb->epf_ntb_bar[i] == barno)
-			return true;
-	}
-
-	return false;
-}
-
 /**
  * epf_ntb_find_bar() - Assign BAR number when no configuration is provided
  * @ntb: NTB device that facilitates communication between HOST and VHOST
-- 
2.54.0

