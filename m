Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.125.111
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794299109;
	b=3yVihfr9wyuvNTCu4/xNSvTeerhvBU8TtuCv4D0z50w+La0zo88yFCbpHl0ryGMhnJcC
	 8OLZJUSLfKoRzCJT75a30l6FNqxp2fIc0++iYNT0Oc4tsrogYKHgGgng5kbExxXTvaLPz
	 RSg+RTAISK1V/XdnL/L/R1kFbzSMAUPtzRk9DQBg+Rebpk7956Cm4xJ2718Wbeq9IgK+a
	 Gygdxdgvs+kxwbQuU+g9dqrSclLqctrmuJGNHTPTNwwTJPeihWdeVfBZ5ldenJpp+YN4n
	 fexuhG1UTi/prp83Q0qYJ2kqGTqsy5SO35bGBfQkS39gXU0bxdlPLb0zTu4roLUNI2g==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794299109;
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
	bh=8tDHt7BQEYtdfMQknb9JWS0YOvWlcrfnPZ0gojlnVqg=;
	b=enjCk8mQdaGGBQTnxIF68Z4GEb5mE28fo1YFBXZ8n4aJNM4fUc1klfJ9N6ZT06Y0aMmD
	 HpPs8LTg+EOMRrH+TD7YIRzOBRYYjuC+r9lk0xbfHmuvzBs8AH3KJvM+PlTT6OtpwujXY
	 au19BOx/V6vuD0rdUIZQHkKMQtpnubhYFlQKY7sUb2Z+OokUBKRwO7kcUZ414qxTFs8s1
	 ootM5s+KPkOO3vSPpj+eofClnrA2bp0QMkcYN16Fu8IHAfTEnXybQiXIR09zVZfKAS5UD
	 Fzh4FptQo1sIG769DYZRrKGU4x/0S+rNAncsoE8bRYTJQcIE9E1BZk2s53DHsY2yWIw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=valinux.co.jp;
	spf=pass smtp.mailfrom=valinux.co.jp;
	dkim=pass header.d=valinux.co.jp header.i=@valinux.co.jp header.a=rsa-sha256 header.s=selector1 header.b=q81CTxF0;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.125.111
Received: from TYVP286CU001.outbound.protection.outlook.com (mail-japaneastazon11021111.outbound.protection.outlook.com [52.101.125.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8527A606A331;
	Tue, 10 Nov 2026 08:25:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8527A606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=valinux.co.jp header.i=@valinux.co.jp header.a=rsa-sha256 header.s=selector1 header.b=q81CTxF0
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=u8gPw69X5s/sKCqj9DY5fgiebqwWPem51bCljZFaGlWf4FV4Uu9+meKWUHfZwUfWjv66GWpC9tvBwUCFtXuiJW0shk3NWXJBHxA2NKiTUmuIYZiIXu6FPxQXDZfo1Nka60/dLv1BQFOEqdy5BCG/7+K7tTfQz8UOBiEinuUeRXBd9PSikLcfb7kgLD9i8wMKyjE12ZGpbpt1BQ1J+jTmjicIMlzsHLSf0MppB/5x8MHLZvRzx9+mg0/VWWedpsqE5+fU/oLhCMZlwzvGkRh2jpc0Waer9OxcO4rfVjPsMaPnp6NyBQDg7qFHYveoyrAFYydTZkFwGFQ5p8WB5HZJjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8tDHt7BQEYtdfMQknb9JWS0YOvWlcrfnPZ0gojlnVqg=;
 b=ErxVZ5VTp9L9QDTqWBcysjDIHBLVngjjZNQiq7kW7pgnmNYWYZgZTZ+l3Y6VTAez81eNYyGTgs85rzFU/D/J9Z0Gjopgs/MU3PqMcfEfKhBed8CF+0OQHOp9ZpP/jsR1YNcRnEBAyCVcGgzq0XVb8ov7tVos7PelqfWETk7LH7vMq2rw+rNFEDA32Xh0CvaWOQlbTRsU9ArlZzkn2upbLNPPmRNH9aqnpZs36LgLv7IwoknDU1KoKvHzPeblQnzsCMFN2Rn8Il8aO2loKNXAfQjFeIe+cvZon4pHJBsktvmBWG3WkQjRpQ+nMeAN9PSZ9bFjM21a+gS+IAYxmDLXRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8tDHt7BQEYtdfMQknb9JWS0YOvWlcrfnPZ0gojlnVqg=;
 b=q81CTxF0Tas/EoTjmydU1n1yfpKcV5KMIhH5w6iJlqPy0ADcP53Ph08wQ7NEi7xJyssMpqKJONmJ+bo2DLwf2UNG5tVwkkcYDUvm4kUTvKgnGeQhZ3Jrac75i4KIUQovISwCxbqZJGq3oiW7WS5XQA8gNIWphkQ/ptAR0Sc5q5s=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:325::11)
 by TY3P286MB3015.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:318::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.13; Tue, 10 Nov
 2026 08:25:06 +0000
Received: from TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 ([fe80::cce5:2aa8:53f9:dba9]) by TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 ([fe80::cce5:2aa8:53f9:dba9%5]) with mapi id 15.21.0592.012; Tue, 10 Nov 2026
 08:25:06 +0000
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
Subject: [PATCH v9 01/10] PCI: endpoint: Add DMA auxiliary resource metadata
Date: Tue, 10 Nov 2026 17:24:50 +0900
Message-ID: <20261110082459.1798763-2-den@valinux.co.jp>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261110082459.1798763-1-den@valinux.co.jp>
References: <20261110082459.1798763-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYWPR01CA0043.jpnprd01.prod.outlook.com
 (2603:1096:400:17f::17) To TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
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
X-MS-Office365-Filtering-Correlation-Id: 6162f0f9-a620-49a2-c203-08df3f042056
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|23010399003|7416014|376014|366016|1800799024|56012099006|261021121427099003|261021123027099003|261026121527099003|261102130727099003|261102123227099003|261009223027099003|10067099003|22082099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	/rnZtLcIysLy07YMTXlgxe6u6DHJVucebdviNrxng0njwccc1XlbH70RzkdrpsyzInznx0Y9s7n2/gL0QvcFDFHB3MQtNlpWGfizQHYXS/tyGzieJKvx3GQHLOR2yG9knhUodJ99f5mcYNnHWzHBBXokiOCALx0EGfSuohs8vci8adIehawoMBmWRNc4xgRdp4W/52v953b5BSXDxbZHBnkZrVQVU9L2J4a3ZiF3ToexL4Hg+tn+Mb+LV2ffcCDD6m5bYyMH498/j5ER+WTtq2ckyYvsdK963EfY0mz6381BDgMgFenLhJmaaU9UUcaE0lY3+0NOxgsqxC7hlc2XovE5Px/O5E1GMLr05i65v/AjNVLy+zm1/rCi16l9XYUUWcvs4yo7jVzCXV0rg8YFVPCiX6XOF+6oAPZ8H5pifng/vX1NAtza81okVq9z13GgLI/ugp3mrHQzhFrlu0FPQAG5OVPmbhIvNTZd45uTIp7Sa8lEW2H+VJ3Dz9RjV2fHp6/rSJE3YPd+ltJR77M3tpI6/KSRYpNT0rZUyKFQxmbbrbHxePQI/eJ6fW+EdDIaOGbA85e67izHPgGLFbI+6AnaS8xC6s4/3l7Ujvmjysuj2GZyU/d20q9Cql1bsbOOtkLGkSjuhYsPhKzNrVpSDMltYDIrLZ6dJA031b3yk9s=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(23010399003)(7416014)(376014)(366016)(1800799024)(56012099006)(261021121427099003)(261021123027099003)(261026121527099003)(261102130727099003)(261102123227099003)(261009223027099003)(10067099003)(22082099003)(18002099003)(6133799003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?djq6mqGEkmd9pGVf9Hu0k6UOoElDGJpdFPF6OjSIvCT81nMnEdncZF+BXifd?=
 =?us-ascii?Q?egV2uZ0iP9C+GtghYMotRaPhqFiIz1d4DgnUXorHufGxunSGpwUGQf+Qzs5r?=
 =?us-ascii?Q?dr5thDQy7hRJb+QHpzCM5uEp/ICf3xBaZh+MHR9K1dfegGWzTwlmIvNkpX8Z?=
 =?us-ascii?Q?W+7iyWsvsMPSco4Jh1mPl2ZwFLvuGoswIfsdyyrlQIprLW2gWSwAzCASYhSn?=
 =?us-ascii?Q?yENLL0E9vsvX1nHbLix5tPgBM1YwX2GL9YmoPlSJNmJyMTfs2HyC14mMejG4?=
 =?us-ascii?Q?1lk2LwTclAyQTw2/JuYbs40zEGkziIzdpUwng6Sb1Xz9EYyB/4Yr7o0pwsIv?=
 =?us-ascii?Q?psTDjNk1oq1807077xjacggnydn6/MXRCObpcftoe9G+UiAhW9SpzQ0eBIPf?=
 =?us-ascii?Q?KgMJM3XoS5nCMH3ESwrDlTTlCuSaJKMlymHqyOcQMYCVgJJ0kC2swM1OjE02?=
 =?us-ascii?Q?qLqXTallFq1N2W8jZiapkcEhHD9txhmbMdDyDn5J358gxxmyTv2+r51wA6CE?=
 =?us-ascii?Q?1y7jrsL6+sSvrM/gXSlMIREiXdqiXeUOCHLddFOX15PCJ2isAQ//yBi/s/AJ?=
 =?us-ascii?Q?3AOgrx+6CbIv39thdcYGublSloh5FyMFpCOljnn0FQ2gkCfDkLaMnnfN5d6W?=
 =?us-ascii?Q?Btw+VsPbbcqCtm3ZUNzNh5xpRvcVM/UkR4bGAPvrICblWr1G9YLZJx0ppGRv?=
 =?us-ascii?Q?i14JTBLw5AemsAVH4RArst5CxQOr4PvTVXdfnODrhCG4m4CNJCuOu7KtaPna?=
 =?us-ascii?Q?dAhMIWyGdprSnvCXmX0YgQRlSvHgYhmCcd18JX79RmdNzqK4ZzrIhq1FJLsf?=
 =?us-ascii?Q?M7BSvTVLqeo8aeeOp3Myn2lY4WWu6hCC89NLLPc+/EOBr93udg5g5B9ZK65V?=
 =?us-ascii?Q?Wsn0igDi7nnbWEPfKk6j0EhcDzW0vXiQMiMKdHD+u+10T/6QMHPVljgEYomn?=
 =?us-ascii?Q?4mj5YNPkfT570vKm8P7NswkfFRdtawFeOcs+90t2b2gO8o2JtNch0O74I+Bo?=
 =?us-ascii?Q?vxRx5Q//6bBXMK5SjqSmeuMLMAsZbWDG8yN76zGG5DM8KkiixPvFUr+h+3Tv?=
 =?us-ascii?Q?e07dUN8o9VkyIzyA2cHbDo2U8uDJ8t3J+Y/J5WJOsrADg0KgAL8qagNxIZ1C?=
 =?us-ascii?Q?EAsJEmiIWRCOVG4e10lhbEXuRj28JEhFXzm5UezwQQpqZWHN22LeXlq7Aghn?=
 =?us-ascii?Q?u6iIPgBZl6mr3G9gY+z199XJnAb3AOen0piQb1fa/dLCsFroRWhr6uH04oqx?=
 =?us-ascii?Q?sqENmSCo4tbbyc/eQhgfoVZKBLYEau5WVgqD8hwF5wiLOdmvSk0XD0+M/Ckj?=
 =?us-ascii?Q?tdypsySGj6xb2+LpZSHkvBcizl9lg/lq58hXuvGvValVsQHq6CIiuwhehtuY?=
 =?us-ascii?Q?eQ6aOzFI7zFNHkcaMIrOn7NG7YaSV4KlW4p+dM6UdjlnIOxO6sl/+1gjbRms?=
 =?us-ascii?Q?sSEhvs8UGbsEcmBDnJF/86dbLIUBpgHUqc/o9v5JZZ/eGhcmvVjTu1dQy1z8?=
 =?us-ascii?Q?61x8V8dgeKmEmlFkvLjIofmfsT6pS+7Ajnj1bj0tPNp7GU+fTGQzON0xgZ5W?=
 =?us-ascii?Q?0wOINpV+5DDcBXEsTSe6sk0oxk84lYotap4T0uP6Zcvotxmveg80ix7zpKOK?=
 =?us-ascii?Q?wRWZotXTIiUw/cHqSmGm2eHwriNjRGww/kwHkJauT/B769uasluO4wyYqm6b?=
 =?us-ascii?Q?N2TO2zI07kpCqecSSB7JLIu/TNEZyqfhfe9nU1CMlRSUUKH8IEx/xN/w3HYz?=
 =?us-ascii?Q?k473fRBKr3Ar+UjbBABUoYLqWdG0YA7XEkx6g3jM48WR4/MyaJqx?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 6162f0f9-a620-49a2-c203-08df3f042056
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2026 08:25:06.6106
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: A94kjH5hbiBoQAWgwiDALiBKRLP3ZQEBp6FtUN/MOo8zkCfeiMjoUxKpEwq7oOJT3XtgnDwMEMUDVcBSNnHnuQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY3P286MB3015

Endpoint functions that export controller-local DMA channels need the
controller register and descriptor-memory layout.

Add DMA control and descriptor-memory resource types. The control
resource carries the register layout and channel counts. Each descriptor
region is associated with the static channel ID assigned by the local
DMA driver.

Reviewed-by: Frank Li <Frank.Li@nxp.com>
Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
Changes since v4:
  - No changes.

 include/linux/pci-epc.h | 34 +++++++++++++++++++++++++++++++---
 1 file changed, 31 insertions(+), 3 deletions(-)

diff --git a/include/linux/pci-epc.h b/include/linux/pci-epc.h
index f247cf9bcf1a..e0348e7bc534 100644
--- a/include/linux/pci-epc.h
+++ b/include/linux/pci-epc.h
@@ -65,6 +65,8 @@ struct pci_epc_map {
  * enum pci_epc_aux_resource_type - auxiliary resource type identifiers
  * @PCI_EPC_AUX_DOORBELL_MMIO: Doorbell MMIO, that might be outside the DMA
  *                             controller register window
+ * @PCI_EPC_AUX_DMA_CTRL_MMIO: DMA controller MMIO register window
+ * @PCI_EPC_AUX_DMA_DESC_MEM: DMA descriptor memory
  *
  * EPC backends may expose auxiliary blocks (e.g. DMA engines) by mapping their
  * register windows and descriptor memories into BAR space. This enum
@@ -72,13 +74,25 @@ struct pci_epc_map {
  */
 enum pci_epc_aux_resource_type {
 	PCI_EPC_AUX_DOORBELL_MMIO,
+	PCI_EPC_AUX_DMA_CTRL_MMIO,
+	PCI_EPC_AUX_DMA_DESC_MEM,
 };
 
 /**
- * struct pci_epc_aux_resource - a physical auxiliary resource that may be
- *                               exposed for peer use
+ * enum pci_epc_aux_dma_reg_layout - DMA controller register layout
+ * @PCI_EPC_AUX_DMA_REG_LAYOUT_UNKNOWN: unknown or uninitialized layout
+ * @PCI_EPC_AUX_DMA_REG_LAYOUT_DW_EDMA: Synopsys DesignWare eDMA/HDMA layout
+ */
+enum pci_epc_aux_dma_reg_layout {
+	PCI_EPC_AUX_DMA_REG_LAYOUT_UNKNOWN = 0,
+	PCI_EPC_AUX_DMA_REG_LAYOUT_DW_EDMA,
+};
+
+/**
+ * struct pci_epc_aux_resource - an auxiliary resource that may be exposed for
+ *                               peer use
  * @type:       resource type, see enum pci_epc_aux_resource_type
- * @phys_addr:  physical base address of the resource
+ * @phys_addr:  CPU physical base address of an MMIO resource
  * @size:       size of the resource in bytes
  * @bar:        BAR number where this resource is already exposed to the RC
  *              (NO_BAR if not)
@@ -99,6 +113,20 @@ struct pci_epc_aux_resource {
 			int irq; /* IRQ number for the doorbell handler */
 			u32 data; /* write value to ring the doorbell */
 		} db_mmio;
+
+		/* PCI_EPC_AUX_DMA_CTRL_MMIO */
+		struct {
+			enum pci_epc_aux_dma_reg_layout reg_layout;
+			u32 reg_layout_data;
+			u16 ep_to_rc_ch_cnt;
+			u16 rc_to_ep_ch_cnt;
+		} dma_ctrl;
+
+		/* PCI_EPC_AUX_DMA_DESC_MEM */
+		struct {
+			dma_addr_t dma_addr; /* Endpoint-local DMA address */
+			u16 chan_id;
+		} dma_desc;
 	} u;
 };
 
-- 
2.54.0

