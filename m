Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.229.113
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792465870;
	b=0R7jjI7pcNvud4JOHL+DPuGnQ55VKZSe1AJZs14cR3yxlXSfF355DlKZk0COzjk6S/15
	 2Pq6kb2J8+xbSHZjgEQSxmvkvAsmcpPFpAyTI1NiUUeqvdL763H4p/zaiN58oSFtJatAm
	 2MuiouOS0qQV2l+8zLQ9YwYelHuXlGsIxafDqTQUOYYYLzl4WPEVvueDhmj0LRd0SPHDF
	 MdI02JsMeoHEducbvIVhzwImHJOO3nnp4umASSMdN+oVCcR3M/WfJI+sp68qs3b/O4Ns1
	 QeD2mB3MHornjYmbfAQmrP2rQ+BQdKEZGqAJ+3fw4iHxt/asWfw6yOs7YdWZfpZVY0A==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792465870;
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
	bh=YA6EAAmf8a6N729gZJUj68VzcwGviHhdcQV2SeUx0Ug=;
	b=pVl3zloSlE3OITmOyEwOCdVo0uTbbEybqub1BdEByG9WRU3OrqSB64kxyHTre2WsGbkk
	 Jv6pa3GROu54uHm1XvK7gNq7TMoPzU5+m/iTzIgKt1p0H2R3KyrVckLFMR7oB8j47izer
	 dXUNxIdzQRjdaa/DUvEvFRZhg37aewk5IUHForY6sjjapyIji23bvPwd3IGUXV93nP7wi
	 EeV15nhWBSQ51Vj5dHUrBebyoQcDFBNDlImuo1770BtBvwLJ8XHoHzUIBbSzif17VIr5R
	 MGCDo52cax85+IgrniZQaAEd6EXDbLU+es7oxPiKNFO6ad3dg4pj0cI4tZsGUunrqvA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=valinux.co.jp;
	spf=pass smtp.mailfrom=valinux.co.jp;
	dkim=pass header.d=valinux.co.jp header.i=@valinux.co.jp header.a=rsa-sha256 header.s=selector1 header.b=WzEEQgT9;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.229.113
Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazon11020113.outbound.protection.outlook.com [52.101.229.113])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D48C360A2630;
	Tue, 20 Oct 2026 03:11:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D48C360A2630
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=valinux.co.jp header.i=@valinux.co.jp header.a=rsa-sha256 header.s=selector1 header.b=WzEEQgT9
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bMBTU/DEh/jmsJzSVx3caS8Ra2kyD8py2862EsOJgLvpledWAhW9mUyL+6JfZSl3T0MsxXGaNlahiht37R8MsX5vEG5sH7DK1UqrgIWl0MB0L7hNubhLSDz36gLKAO0zNIO6tk0lfYgV2Sq1cJKmIZNKelOMVfm5D5DwRDP/QwwCtJ5YhbLMJqu+g0BAUn2PQrqr72uVujADSrgN/Ju6hCwIYiatyO1jOg67/0gYHevZLv4nUt3d+hv9o7fmvdKO1jhAHcHRxgOraNx7sSVkN2j8oh9fz6Tv8iYEBzakkbWiNcjmvoax9C7iS0jV2jpL4FHhOBMgMZFZKOamWPU4AA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YA6EAAmf8a6N729gZJUj68VzcwGviHhdcQV2SeUx0Ug=;
 b=gLJEmakQJ2t4WaL37snDzRQz+ttt7/xyku9Tuu/S7yjbFdvv8CJn1G4uVVyihEXf+UXbxjlzq1g2cJH80Sr60vmUNAC+MchTeYQrh47YtFc3ki69LoOSAYj8JHUqJTo/CpofF+Sk70/yNefytyRuEd7u7rdKsOdGJx2cn/d0Lf4MQZ9oxHOTzBzmjyz8zzJQMAN/MOlZ7rUSJjONBe1kBtdyCoMBD/fKVUOcYIJy0Q2ouRmrmUI10oDo/Ev1wrdzRxZSX3qaEU3VRCq4+tBnYuwvIu6rPg8iR37KCuHZBawp5Hhj90wvtcYPudSVYxxS3DV4nem/oMjPmlbuXDG8ig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YA6EAAmf8a6N729gZJUj68VzcwGviHhdcQV2SeUx0Ug=;
 b=WzEEQgT9+By88iUMkBQ+XSdAhyXNAuOT9ay23mbPilhP1phxNggYMpYa0QRToyBFQmWAsr5lbY6koILtxLdME3Q2mzJ9E967Ga185vVp5CY8ZZ136+O0nR/JUiybrjBShPZfhuZy4dg1JJOWgfiEu0gvUoLPgSRgx2Q3nHw74QU=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:325::11)
 by OS9P286MB7503.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:44f::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.19; Tue, 20 Oct
 2026 03:11:07 +0000
Received: from TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 ([fe80::cce5:2aa8:53f9:dba9]) by TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 ([fe80::cce5:2aa8:53f9:dba9%5]) with mapi id 15.21.0522.017; Tue, 20 Oct 2026
 03:11:07 +0000
From: Koichiro Den <den@valinux.co.jp>
To: Marek Vasut <marek.vasut+renesas@mailbox.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
	Shawn Lin <Shawn.lin@rock-chips.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Magnus Damm <magnus.damm@gmail.com>,
	Jingoo Han <jingoohan1@gmail.com>
Cc: Philipp Zabel <p.zabel@pengutronix.de>,
	Frank Li <Frank.Li@nxp.com>,
	Niklas Cassel <cassel@kernel.org>,
	Wilfred Mallawa <wilfred.mallawa@wdc.com>,
	Serge Semin <fancer.lancer@gmail.com>,
	linux-pci@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v5 10/17] PCI: dwc: Free the MSI domain after the host .deinit() callback
Date: Tue, 20 Oct 2026 12:10:42 +0900
Message-ID: <20261020031049.969895-11-den@valinux.co.jp>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261020031049.969895-1-den@valinux.co.jp>
References: <20261020031049.969895-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY4P286CA0107.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:380::7) To TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
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
X-MS-TrafficTypeDiagnostic: TY7P286MB6866:EE_|OS9P286MB7503:EE_
X-MS-Office365-Filtering-Correlation-Id: acf61f39-4a9f-45fe-dbc3-08df2e57c8aa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|366016|7416014|1800799024|376014|10070799003|22082099003|18002099003|921020|10067099003|261009223027099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	Sz/sO7InryKfFRa9PU1IWxz0Rbb9gj7DwuMM5HnobS5hFAYc7M1YDe7vOJ1Twskyk9KteCX3/u50A9aSyZeE0uuAb3gs3+argiYE6gUkxL4MUoRXp+SNH5J+5oMFcOUcTtFy2ZK8BJh04bjmYz+iI/OtNDqdbWTljqrHTLTzq7rUXtSrv1eCJzd/qmCpiN9JUHHXakYpG6HPO+hVd2H54Ptm7szTd1E9pRwl5Qi4RMAGGmay+6F3zni0dkMVNtGfll6togYMHZWlqVMz9dtYvyJiTTkxr3KD7/BEMEZ+OXo1tG7HK8jU4SACjpK88/Sns3ECZa2qfjn9tBqRF85flojVb6fTDWHA0iCQqOEcscVKglMrWWXX4ChSLUS+NEvClNg9YnYDvOwyHSvS5JSMD6R7+zf6qKi55eclyZVxbAIbNUvwqTJavH2h5Ox5PCGGHzjH6bBmR0M8DvB7V2+Mi54h6EFyveseGpxyWwBSEsThYJ9CZhcU6biZeTHmhpb3itU3glcArzktC1P7Mw3yCQcPfqL07thzEAkRhq3RO5zTnEBzYJ+U6gD67vX/2W42sjLQPlRQFka4hiSFRnXVTLN/hwyluEHGAfz9KFNmAPV7iKVlvqsbJD2HmO2Hf4RiMf+u2Z3Mw/nI2k8TdG9emkHZBdXwXCJkXHo9MSd0SqdkF//kMAvsTKjD7sNsJXqSe3mJDgNLRYhrQ9vnMRywNw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(7416014)(1800799024)(376014)(10070799003)(22082099003)(18002099003)(921020)(10067099003)(261009223027099003)(56012099006);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Lq4C9JfDQ2NxLp0nuxZnLfRuAaT4t3PX4QGaKGVM3Qyygw/ejy2u7avyat0F?=
 =?us-ascii?Q?EwBOh2V/7p5Ic19TUA+sKSbSsCmjjiaM8PzhqrAClUSMOm/49wxZqKkKAhTd?=
 =?us-ascii?Q?YYAFMpuCGUA5kW1/ZVepO6+WTxQA5cE3v+C0C8+P8bNahNVMipVtH26lcrP1?=
 =?us-ascii?Q?UTeOdIISaRxzX9k0i+gsVKUHfs6KhXyWLZJkH4O8dzdlqQdJawLC01CmFMYc?=
 =?us-ascii?Q?aTx4m68Iv34uXFUH7cHREjxq5KqcLu+DWE7CWzYCduwIwrqRCdg017FeZtd7?=
 =?us-ascii?Q?TjY8iy8+hi3qYCCy4FXREDIhj+BcdDik1xHszLiybeaAxUrSez5ks+B6xpg7?=
 =?us-ascii?Q?WOXfxg6IujPDsYq9M8FzCUIDq3Ba+Z54BrBIHjd/IiNS3zqRaeKXOw9e2roU?=
 =?us-ascii?Q?04HXEoYEIHQfWFjzqVYzfEDgBTy6zzVE4ute8N1Mq4m4ZWQ+eFXzGLTRGc3X?=
 =?us-ascii?Q?c2JYEx2et+vpbzJ45oEkEUTB4o3OPmOQxGXzcf1OxjcMe04oNLLfwec3HZz7?=
 =?us-ascii?Q?dYCZN2cNm5SqKaxwVyAO8NOOS6SKNjVV8hURM9OeGwqeIm77qQ367s40yiTu?=
 =?us-ascii?Q?K95TRp/sL7qP49blYxaCimgH2yN35jjBu7J6fnmrU+MON41Qk6eeKzJkp2I2?=
 =?us-ascii?Q?ULDEIg1+Q5Mby8zZS0IfggeViJ+atTMsd1eTeOIRutD3PN7iuVkt2XwneVUX?=
 =?us-ascii?Q?iz+ZNEPUMsaloKpLe66KyPSZgOlHk+WIcSSOW6J3mafqduR6uT3vLuhQweUy?=
 =?us-ascii?Q?AUIKXSWg5ss8InLtK3LmmZfkVDL7Ij9/EjC2OQ9w1YKlBDj7nzObKmXsWO4d?=
 =?us-ascii?Q?O3O3Si7n++i06wWLUqBjjadTnJRf2uoJ0tuF2j/JzBhfbUxSPnpJcWVtor5y?=
 =?us-ascii?Q?ycz2aqV8IsXuwiLTc26PiaSuFlWKvRwiPqNGk3mbTyRlvvcfZbMzZzI1SHU1?=
 =?us-ascii?Q?+mK+srAgbMdfoVrKfkh/hE0eWWGcHk1X9UjEKXu4ZoudtG0Vav+7FUhxbki+?=
 =?us-ascii?Q?SZ2YZFyD+S4fMi++cbgo+CA3g1eQerWkjwevZbDH5GLRYXaQtYGlryk94dE9?=
 =?us-ascii?Q?gvTUvB60ERYW/wlOFbs/l9tPWbUFeaFlFd/kG3wNGz7eAeBltN82K0K5Xbfr?=
 =?us-ascii?Q?wAyNqLxDkhjUB9L3PIq1H+S8BZEDEKB/xldhmbcgnIZHW8VPmY9zPcZqmd3R?=
 =?us-ascii?Q?YoDOhKJhvnC0ksQOqbUAvfjANSNB+byItdPD5hS6K+IKNPt7oEP7FqlQoa6p?=
 =?us-ascii?Q?FxNNAWof8Kfxgtq/NbwDpqgW78zgRmrG9j5ejkFVAFxBtMF3E/l5RoKZoy8G?=
 =?us-ascii?Q?SDZl0+BnSa24IcP8GhwOGn64WN36adjrVFHVrC7XGPugb6xWRxDHKuoILJOn?=
 =?us-ascii?Q?JOLjCqiwDVND2VzQWToRD/paRS0DV/xfMVnqzQ7NRiRFPati4kkKkyxU20zJ?=
 =?us-ascii?Q?hFFg7hq82JhrxXx2cJsFGq+kf4B7LwW3r+RxypHGSYVLrWsMztGxoiZk15u7?=
 =?us-ascii?Q?HeJJEjycYJX8hZfEU56K0Snp4HAPf1R8+6o8FsELuEt8DASbm2i+Yf5jlNgL?=
 =?us-ascii?Q?VyFn1X6Evu94jY8+OtjWCoCTe2yFLAEtMNUN7pC6YKCUEEbNyo9jzMeW86Cm?=
 =?us-ascii?Q?ZpXB+vgMFsGXqmf0ZSt2c7/R0CXky/3xQ8nS4Bg0jXeEDjTQ3euMt91jRnp5?=
 =?us-ascii?Q?cvvccidHqL82IBiz40C1OrELk3GPVAJ3+9GaODst+Ww1EVO+yYiYKONl6hMx?=
 =?us-ascii?Q?p5ycD3OCuCWd5MGrL5pJfgvI4KoQ7pX1l3hJLKnh1wCYrzWMZQm0?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: acf61f39-4a9f-45fe-dbc3-08df2e57c8aa
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2026 03:11:07.4290
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tmsWVvFIqBS4SS0zIjjrfIpIbxI2X4uUAiYq0DHI4mAvodh5eJsJMd3VyryZMp5R7gmcUGDQ2nUe7a3WIVbfIg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS9P286MB7503

dw_pcie_host_deinit() frees the iMSI-RX domain before calling the host
.deinit() callback. For a core-owned parent interrupt,
dw_pcie_free_msi() removes the chained handler right before the domain.
A glue driver that owns the parent interrupt and demultiplexes the MSIs
itself through dw_handle_msi_irq() can only stop its handler in
.deinit(), after the domain is gone, so a late interrupt can still
dispatch into the freed domain.

Remove the domain after .deinit(), in dw_pcie_host_deinit() and in the
dw_pcie_host_init() unwind. Keep removing the chained handlers of
core-owned interrupts before .deinit(), which powers the controller
down. Clear pp->irq_domain when the domain is removed so the unwind can
tell whether it exists.

Reviewed-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
Changes since v4:
  - Add Marek's Reviewed-by tag. No code changes.

 .../pci/controller/dwc/pcie-designware-host.c | 31 ++++++++++++++-----
 1 file changed, 23 insertions(+), 8 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
index 63b38532d069..774e1936d999 100644
--- a/drivers/pci/controller/dwc/pcie-designware-host.c
+++ b/drivers/pci/controller/dwc/pcie-designware-host.c
@@ -228,7 +228,7 @@ int dw_pcie_allocate_domains(struct dw_pcie_rp *pp)
 }
 EXPORT_SYMBOL_GPL(dw_pcie_allocate_domains);
 
-void dw_pcie_free_msi(struct dw_pcie_rp *pp)
+static void dw_pcie_remove_msi_handlers(struct dw_pcie_rp *pp)
 {
 	u32 ctrl;
 
@@ -236,8 +236,18 @@ void dw_pcie_free_msi(struct dw_pcie_rp *pp)
 		if (pp->msi_irq[ctrl] > 0)
 			irq_set_chained_handler_and_data(pp->msi_irq[ctrl], NULL, NULL);
 	}
+}
 
+static void dw_pcie_free_msi_domain(struct dw_pcie_rp *pp)
+{
 	irq_domain_remove(pp->irq_domain);
+	pp->irq_domain = NULL;
+}
+
+void dw_pcie_free_msi(struct dw_pcie_rp *pp)
+{
+	dw_pcie_remove_msi_handlers(pp);
+	dw_pcie_free_msi_domain(pp);
 }
 EXPORT_SYMBOL_GPL(dw_pcie_free_msi);
 
@@ -633,7 +643,7 @@ int dw_pcie_host_init(struct dw_pcie_rp *pp)
 
 	ret = of_pci_get_equalization_presets(dev, &pp->presets, pci->num_lanes);
 	if (ret)
-		goto err_free_msi;
+		goto err_deinit_host;
 
 	/*
 	 * Allocate the resource for MSG TLP before programming the iATU
@@ -649,7 +659,7 @@ int dw_pcie_host_init(struct dw_pcie_rp *pp)
 
 	ret = dw_pcie_edma_detect(pci);
 	if (ret)
-		goto err_free_msi;
+		goto err_deinit_host;
 
 	ret = dw_pcie_setup_rc(pp);
 	if (ret)
@@ -686,14 +696,16 @@ int dw_pcie_host_init(struct dw_pcie_rp *pp)
 err_remove_edma:
 	dw_pcie_edma_remove(pci);
 
-err_free_msi:
-	if (pp->use_imsi_rx)
-		dw_pcie_free_msi(pp);
-
 err_deinit_host:
+	if (pp->use_imsi_rx && pp->irq_domain)
+		dw_pcie_remove_msi_handlers(pp);
+
 	if (pp->ops->deinit)
 		pp->ops->deinit(pp);
 
+	if (pp->use_imsi_rx && pp->irq_domain)
+		dw_pcie_free_msi_domain(pp);
+
 err_free_ecam:
 	if (pp->cfg)
 		pci_ecam_free(pp->cfg);
@@ -718,11 +730,14 @@ void dw_pcie_host_deinit(struct dw_pcie_rp *pp)
 	dw_pcie_edma_remove(pci);
 
 	if (pp->use_imsi_rx)
-		dw_pcie_free_msi(pp);
+		dw_pcie_remove_msi_handlers(pp);
 
 	if (pp->ops->deinit)
 		pp->ops->deinit(pp);
 
+	if (pp->use_imsi_rx)
+		dw_pcie_free_msi_domain(pp);
+
 	if (pp->cfg)
 		pci_ecam_free(pp->cfg);
 }
-- 
2.54.0

