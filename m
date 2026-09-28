Received: from OS0P286CU010.outbound.protection.outlook.com (mail-japanwestazon11021116.outbound.protection.outlook.com [40.107.74.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52AC34E1C94;
	Mon, 28 Sep 2026 16:53:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.74.116
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790614397; cv=fail; b=t05NozZ4icq5FAiniLCZ2oPaDa6QLlA0mBkDWB2L4FWaBrn6BSe+o30pB/UaN5lnKVDC4sr0FWxJLjoI1IFmzPT/airEIL6QMER5nfFV2uYBZ0TVxtbaSe9KSVGDA3qIDNRodIkh9u5IW8wDfmklj6GOp1OXWtZQxR/j5M9E/y4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790614397; c=relaxed/simple;
	bh=gKV+Igh08zmlcMlAaz5Lp+RnEl3i7S8FNnZdzhJa1tM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=WHMBhgIDiCyQOhlUlt5rv0G10bR/80mv5SYeqhkZjNyRNginh1RsSSK+o4pKzwC4Vx5fWe451WIU0ofjFuVF55VPpf3U86XhbzZpIRbDEyHNI7Da+9KK8bgjEnMwTPazZ3ullHz65jZIGjVGqJF4THJLcOUk66JjUvu9YerVbXQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=jnziGCGu; arc=fail smtp.client-ip=40.107.74.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="jnziGCGu"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Tdv/urzL4R0hstiGcdxP5j/oZCmN90ioncLU4DjSpVdwyBROrxM5+Xf+NbT5gexdci8a6Aa42zpxHzdy42VT6C+X4i8hzD36ha1Cw64SdwBhUUCfcLKJLWtajCVy3Vl4ynalEnQqADkrmSUQ9GQSo4GpbHT181vR0gtt5IfAA8KriEoGCmupCQIO3yHnBOZ02ZV+F82toG6wNl/GZ+XRJPjfKtNBoarVRcMBgzjxJLwwmKh3mx1XTlAIl2lg9J65qS6lXO+RiEv+WtT/WaMK9jhjbaHUkiNtieLLjLnul+tBgCt7O90lDmBNN/naiyljcc3lnrtcmY1jA49HNxnbOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m59vJeKxhLagC9k8cOHwsikac2x0/+PywsFZUdADyo8=;
 b=OpI6txbHXV3FuwSNdU/v3gqYs30IThExmiuxxT5uc+qsQo3PFxYzy9WRBWI87hOsj0rSuLgGd0ItapfPPkE/AVnXOV3WOJE7Fc7P2tdGvhfvYmpcKyOkfLxRtOidb6o2sOjUeJYHYHKDF1T3PO/a1AvKUNta4LMyhaY+sHwVkDJ5Nb+r5t6LoFt4u5jffo9/1CVk+6fHdB8e2gK8V3CHfAl3PZl0Ya4xKuHdnwB/73crJnUrZBMwwIj3OtY3xJaihFtUPBM2Kwj1h9bx8Fh9yDAyAuHdkEPBCTHaOVPxh/NMBWVFf8XfHaqhW1VqmeWehrpoL78Ua9V8zDcnnC7MPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m59vJeKxhLagC9k8cOHwsikac2x0/+PywsFZUdADyo8=;
 b=jnziGCGuF8jgbNW3Zz/sqQ3A2t/hOFTG+x6LuVl/7iIv7PInfE7VRuI2x+XCEW/n06/L34TKSXwHsA5oGA69TnKkwHG76cAKLhl/EAv2dBgSEoxbbVsSFQfHNh75ccd1wnv3IvrVcanKlS6f2bWmSVWTd641MOPqUoNZEvCVEas=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:325::11)
 by TYCP286MB3638.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:3c0::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.24; Mon, 28 Sep
 2026 16:53:03 +0000
Received: from TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 ([fe80::cce5:2aa8:53f9:dba9]) by TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 ([fe80::cce5:2aa8:53f9:dba9%5]) with mapi id 15.21.0451.022; Mon, 28 Sep 2026
 16:53:03 +0000
From: Koichiro Den <den@valinux.co.jp>
To: Marek Vasut <marek.vasut+renesas@mailbox.org>,
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
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
Subject: [PATCH v2 04/15] PCI: dwc: Export dw_handle_msi_irq()
Date: Tue, 29 Sep 2026 01:52:19 +0900
Message-ID: <20260928165230.3397664-5-den@valinux.co.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260928165230.3397664-1-den@valinux.co.jp>
References: <20260928165230.3397664-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCPR01CA0199.jpnprd01.prod.outlook.com
 (2603:1096:405:7a::13) To TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:325::11)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB6866:EE_|TYCP286MB3638:EE_
X-MS-Office365-Filtering-Correlation-Id: e9f12b02-2858-4b15-8609-08df1d80f623
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|23010399003|7416014|376014|10070799003|56012099006|6133799003|10067099003|921020|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	+jU9owcV42SECGxul16GW2Y1VWX6ShDrUDZjW/oSWYHNyTTXfIH+t6pK7/RXo/lBnbGKqcOjxEQay9tbzWCCSOK5DsiE42Uz27OsH2Rebs9Hk8RYmn8q1khrwSbOQr3i9XXu22ZvAwInb+OkCHCGEoAjEmwp03vQbQjxYzkO0b2iIjd6famaAGd9uo+pRogMuv0cQTz1w+OGu0UIXTsoBK2gXAG4Ipa7gz0Dm6p7oa/ee1hSODFwvRmpmb7duNg5AK4uC/wvQo5eJaoeVVKRUAfXxaJ6BPmK99v3v4BDKw39TyNrCGbxtFc6JmI7ysqyc/ySgUFIISej3a9mH0/Rv64WEPmd1A7vicFuowNUiJXXWX2gEgtWqI+VsElUgK46RBJcNYVoHlkgaQqr4Va4Kj2POtbsQR/1mep8OsZXfkUWvKy9XKx5aLZuuhK71cuty/ZZYO98pfltbEtJUdcMWGQwbr2oGpJxouAMajf++Hm8DSWuUr89/Th81Q6PvSrPUKlZuJDdGatojujU3E2hTXcNk5sbJXf8sJNI3F7DNeNgIxItgNAPE5+u6NgRYdcRF9/J4WBcuDhId3jlnRWkB29Um+0UD3UchnmBJ5BOzjKivqtQlClOi30TBwoQJ8og0O0wGxVCtTh1ieeU9JHWVDIYb8lEfiqez64FXUqv716XiwRL4mcW++KO2EwEgPc1wCqbwsc5CjnFopLW38UW1g==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(23010399003)(7416014)(376014)(10070799003)(56012099006)(6133799003)(10067099003)(921020)(22082099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ieiWlC/okqHdHnCERME78/J7F6H4pyWZMD6CNyAJEio9DpKa/1xAUUKld1KP?=
 =?us-ascii?Q?3PE5Vt71xpnVPBrTJYfQHdJXcxiL5OeAGVdch2yz8Jdu0fhrHzdpMS5a34B5?=
 =?us-ascii?Q?G+KGemQzf7vpeb9YgxivsSQLbRgVKsRFhmMVzBgLA3gZUxN1ZTBCzdZMXbjA?=
 =?us-ascii?Q?VmNWFLChC/2Z3bh9FqJ/aaWoEXK/hPFVDzb+ibbJD3izp0ifhvvfG8ZQCDvp?=
 =?us-ascii?Q?HAGrW269BO3CMHeD1Pz34smKPTXzR86QbSrZv4EtkvorKzHMuw66n0oCstFR?=
 =?us-ascii?Q?Ujm1WOwXK+dLRuErOQ3FOpgOJznH/A62k9hfXFsww1p3yopH5QF+EpItbLr6?=
 =?us-ascii?Q?Rq/jmlQj90WMj68u6b2ACWZNAa+ulWLXnP9JGhZK0RsqTNQC8tdTctILUilS?=
 =?us-ascii?Q?S+zdxq4jvF7nC+/Iz6ef1WgplSG6VugOK0eaOlDMS/tyH9+v2oan1uyBu+Rk?=
 =?us-ascii?Q?/tWLyzooUUaQsV5uAOJAO+52nDqZLOUrPHb+PJUvwB8Cfd2ZXpUribdgLEgb?=
 =?us-ascii?Q?gxr+UWs+LMrIgLv+DOaKCLEL0946RYm/OjQ9XP6mepAfyc6i1xqLGPXtGWYy?=
 =?us-ascii?Q?5UzunLIRhwLBbPp7bCb0SJpND4XhgqxH5EiMrX+llUu4G+CpnOHfOlFjxU9B?=
 =?us-ascii?Q?2cyyvY1vpBm0nRVPYJnRM/ig56JMc6GJYaaTuxQmKvz6sVDlQHE8S5lyjG7/?=
 =?us-ascii?Q?aS0RZerRyEnwRSkc0owA1MRDV+LB0E2etZRD3tW+HGjyWksnBTFPp9A/QInx?=
 =?us-ascii?Q?WkukKi/PcqBJRik9LSIIDl5kyxUQeUzJQkHNxrtmOU1q2RAiWpA8B9esyc24?=
 =?us-ascii?Q?hsZ8nCvkY4qp4fEpowHG+36aGofHYqSZlvalL36HqTu87Z1bSnoXpLEf/V7B?=
 =?us-ascii?Q?8JNRwAd6P+RiFuTB1f3WTSWx3VK6+VIGo45OfFXda+8PQiO1Z7JUWst8YHyZ?=
 =?us-ascii?Q?2Wndo1sHNO/U1/hzS/MN6TLWajyCrNo/jbgBP1xEzYAYskEIp5t21awA2nRb?=
 =?us-ascii?Q?gx8B62+gNRMSM8oVWbAx08L+/DqXKhqTwGykT4jf3z1FwbEe7xN7o2ZYTueV?=
 =?us-ascii?Q?DbEaX0MlTV4+9n7RSXSfqmH6tYhie2wjL2mCN3tr5WvrbBzW4lI5d892OYXq?=
 =?us-ascii?Q?1t8f5dxnn0m3eYr92JLmE/5cdSAEkydfw30aohvDkAdzsKjDLhPzcY6C2Fq0?=
 =?us-ascii?Q?QyFOIJQleDg30+h6tGXX/Pg59RLeTj90/CKjGYJguFsiyKyPspD+PVbnQuLP?=
 =?us-ascii?Q?AOVz77gstkcJ99RITMZtCXlHtj3RATyF4lGYUDMLznG0KKxtIe93/dv8ztZt?=
 =?us-ascii?Q?VGwoHOq+fs03OsRoo5U5eaHUNxe8tgAnti1g07f5WPvaG0MR21l2HkWTXdws?=
 =?us-ascii?Q?yXDGrMxwmH6qbA7H5qA9zetesdz5ZQ4lYx+MvrNBljJj/2Q1JM55M/6Ig8AR?=
 =?us-ascii?Q?WnugOX/0+CB3GwqteT0MR6eWowaEKCh7axtWCH3/angg7HPv5rgiARnccuJi?=
 =?us-ascii?Q?0J1SuITyKf0o9r7nzFr3At6nYp/VzC/Y9w8+4ZrpWaiKiKxpDUskIh08WuMZ?=
 =?us-ascii?Q?NZqoZSZkD72yWdr3jMhbDd4zusGldnSjxZ4dVbef4ng3xgbEaHP9faH4kQ1N?=
 =?us-ascii?Q?SVpVEz5kMjiBNU/2ZGhJznEn59tNqDYPV5gEsszgsv79qYRmVOrowLJXSw0q?=
 =?us-ascii?Q?urgWcy/rjxwK9hPjBoxViPCppWhSAs9ko89O5Z6RhFXYKyge5Jd9yqOcSc+d?=
 =?us-ascii?Q?fwCTCID8JbGpMtrSrFQ86MITNw+4WV7cS6RXPepexFjwkdanMZiQ?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: e9f12b02-2858-4b15-8609-08df1d80f623
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2026 16:53:03.3176
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: z3YdDEXRx7rPVFlXYJ8Nd8mE0q2HNeFamVUP/FRLGIR+rpxdCpsNZGsO2mMYS8etvWm1TZpt3UiPlrN7Z8zBDA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCP286MB3638

Not every platform brings the iMSI-RX interrupt out as a dedicated
line. On spear13xx and keembay it is a status bit in the SoC wrapper's
interrupt register that the glue driver has to check and clear, and on
dra7xx it shares the line with other sources the glue driver has to
demultiplex. These drivers set msi_irq[0] to -ENODEV so the core does
not install its chained handler, and service the MSIs from a handler of
their own. spear13xx and keembay call dw_handle_msi_irq() for that.
Both are built-in, so the function was never exported. dra7xx can be a
module and has an MSI loop of its own.

Export the function so that modular glue drivers can use it as well.
The R-Car Gen4 driver, where both situations apply, is the first user.

Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
Changes in v2:
  - New patch. Replaces the pre_msi_irq host op of v1, which is no
    longer needed now that the R-Car driver requests the multiplexed
    interrupt itself in all configurations. (Marek)

 drivers/pci/controller/dwc/pcie-designware-host.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
index f5a38e6fd8d7..31e15666479b 100644
--- a/drivers/pci/controller/dwc/pcie-designware-host.c
+++ b/drivers/pci/controller/dwc/pcie-designware-host.c
@@ -85,6 +85,7 @@ void dw_handle_msi_irq(struct dw_pcie_rp *pp)
 			generic_handle_demux_domain_irq(pp->irq_domain, irq_off + pos);
 	}
 }
+EXPORT_SYMBOL_GPL(dw_handle_msi_irq);
 
 /* Chained MSI interrupt service routine */
 static void dw_chained_msi_isr(struct irq_desc *desc)
-- 
2.51.0

