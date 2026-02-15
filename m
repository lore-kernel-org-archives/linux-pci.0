Received: from TYVP286CU001.outbound.protection.outlook.com (mail-japaneastazon11021111.outbound.protection.outlook.com [52.101.125.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E1C829994B;
	Sun, 15 Feb 2026 15:09:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.125.111
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771168167; cv=fail; b=fHXe6ao5FzYcescYIkvhJwUsnqtilhGF1ndoQUEuuCyi99JYzBiqJUvBs/eVwRzyUVhRcXlgV0WgxKpQBASpRxdnK/pT68sjIKjRvlfdyQCEL6pQza8q/7MJVtmZUX9fl01DZ+yWCYcOFF8Fwbf+scMCEdlNJoSrPKhUbKoVOjY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771168167; c=relaxed/simple;
	bh=4l1tJB5AhtVQLOQOwBkoOvwxMs6rc2Eo1r+iJJTKg6M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Z7irZd7PD/vUjcqB2PZl5W5cFc2nWF7AkjaXSEES9XsibxSCn+Mb6rZ/4IUacloIB5b4hcgooS0LYtDhOey8lDbGZJFmaL5BbOlIExAOwS9gfJWPQjWMSaLgBdCaVPRuK4Jyn0r2UJ/rPN2gH2zhOZU67DNbYMUwzQ3YN7uGbVA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=JMQnQXxf; arc=fail smtp.client-ip=52.101.125.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="JMQnQXxf"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AxZylBqiab2QxQndRxJaqhax4oRm5WUu2ESx5gwACvrPgrsPNo0GqNu/9a4tiWWIxHtgJxCPHr5jKKaRW1+7M4l8oLCBvJkBHxYBZHfbfhppQvKpQs7RsJS2oR51IU+Xl7H87v72L8MpodoTtvqfc1bW/c9VssrzdQp99bc2DDAb3gArqSQ6mbHuY2cHpz0yD7gq6hTUHnhpgz/xMGudXwqzxLJlYPO2N0OyQsrkj1OIXnMwCM4YTk+4xaizKiBLHymfVJIBInKkpCi2H2DfwDVhK57wKzEbtJiSTLMcgn35oEH/9HKXsrhPDLfa9lNR1xsXDbBctqRm9y5zogYljg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SH5PTHXRL1dEry0ncmWzRNUYq+nLN5BMZ776SG5Md6w=;
 b=WC2g01w5Dk0WPcAo6qP4tuplzFWHfY0E8lItjoR4Mu1nZcdnOwrombRcSPPsBwgbVC34lxBUb6mbcyca7/kG2xx/UA8zoYnW+f+nfw3I1TC/M7FUf8rHzEf+j7T+X8czxoefzI1XSqLiUVLL3Wyii/CB0IvTINg92BIDrPDCivXm98B4QzSMXbmRvJIDbiXNvfL/1rKyyFKmcjtflk4Czj354dpyD4Kxtl83dooVIjm2lGUs3F1zbUoBhqjcjfVAzbMVaP5hikj+8Dixm1TrKXS575ZFuM9/gpd/T/msA5GOaBHt9y9EiqUjAT0X64PIqP+axhneiaRG9M5cOVnrDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SH5PTHXRL1dEry0ncmWzRNUYq+nLN5BMZ776SG5Md6w=;
 b=JMQnQXxf3604Glt3bT2bLY7kufpGA7qB261VyioUqRQVMTM1MpzqgfKcHURqMQijRlq18TnQe9Eje3poM+0wjvW9i4WyN1DTUnna3WRolHjlgi7HXcbB+xz4Odd0uYjp9DiwFKOxdBqoFpd0nx3zF/o1hpo+5KbUANPsPgmQ8vM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by TY4P286MB7240.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:367::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.16; Sun, 15 Feb
 2026 15:09:22 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%5]) with mapi id 15.20.9611.013; Sun, 15 Feb 2026
 15:09:22 +0000
From: Koichiro Den <den@valinux.co.jp>
To: mani@kernel.org,
	kwilczynski@kernel.org,
	kishon@kernel.org,
	bhelgaas@google.com,
	jdmason@kudzu.us,
	dave.jiang@intel.com,
	allenbh@gmail.com,
	cassel@kernel.org,
	Frank.Li@nxp.com
Cc: linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	ntb@lists.linux.dev
Subject: [PATCH 3/4] PCI: endpoint: pci-epf-test: Don't free doorbell IRQ unless requested
Date: Mon, 16 Feb 2026 00:09:13 +0900
Message-ID: <20260215150914.3392479-4-den@valinux.co.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260215150914.3392479-1-den@valinux.co.jp>
References: <20260215150914.3392479-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP301CA0008.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:400:386::6) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|TY4P286MB7240:EE_
X-MS-Office365-Filtering-Correlation-Id: d3982c85-77d3-4c46-7e94-08de6ca43372
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|10070799003|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Qun7XETY442eETaJlbSOaqbdbXKFxgO8Gp3BCO6xpa/RWXt63IQVZFhr6HVB?=
 =?us-ascii?Q?NuQBQ2N8i2d/3gEk8X6L8590CFTAQ3dD2kJPEPQBLJlNxFiVD2RYEUATOLhf?=
 =?us-ascii?Q?mBi5rY0oELnZyCPpXZ+4ucY9eWhv1rgY5AsmYHj5+EukqjI2KEf5RJQjKTyy?=
 =?us-ascii?Q?NLMzKI6uub/lJCLT0mxVkECMjFeRwal2G0Gi8NG47q1e3e1+Bn+EU91T1Gzj?=
 =?us-ascii?Q?cg/uZRd16wIK3jnxNtT7gmHk+Ogg7+uVm3O4lZYj5S6WZBeW+Dh3ByoMkyhk?=
 =?us-ascii?Q?h/F+/Su1msF+VBVCmEgoqf76xcngYMTIiqZDarhQC1jyI0Ct3y6P91qTyNwv?=
 =?us-ascii?Q?7QkBbU5MnKjBkCErYNJs+3Sd8hpLLNsSjMYEKmdtDmnJ8kX/P4pdL2ogRRTR?=
 =?us-ascii?Q?DRmlYcceicJRhv8/yDY9Pc7sqErUyWGPOnM+62E1UMZJruRfeRoO5erE37gm?=
 =?us-ascii?Q?kib5WAnFQSGZTB3ur+4hfyx1t9omsbR9AlpXSec0ytVVZwXQ7hZB+pNaftWY?=
 =?us-ascii?Q?F0ZSTDMFygDQTPXPl17oassVW6B5Er1Um/QsLDwMu9uAimVrbhiIj2OnhRoY?=
 =?us-ascii?Q?baUQXHKCpS2jzres8nfmNrl+L/O75A2n1a1P8AE/Tn5BernxGbLmymfP0L0R?=
 =?us-ascii?Q?OMrl4ubLBv5JpUpacDPC6cperIQ1FwAo8H7K+rj+CRJpkMID5rWwgq7C+co4?=
 =?us-ascii?Q?LWTtCmXhvL1zq022Ry/aEmVnQDUDwyloW/wOocK31FenpDHzkSkIw2VlRG7W?=
 =?us-ascii?Q?9rWzqokycqxXu+Z6Irl0KxDHQD8IbOI7sp2ad4prz84uKGnzCU5u8WGPVj3q?=
 =?us-ascii?Q?xscw07y9CILyzYDDcMYhzNcDnvPVOpKRTVIMim3DPo6SZLF5Vms/ekI5fsEG?=
 =?us-ascii?Q?/4Ij3ELSGwGloD2WT8rtmViCe4TOh5ZxeJ8rjaZBN7B/SK9lD19l9VfrWY2J?=
 =?us-ascii?Q?DFEN6VZJCAgGiphlrl0tz1pxCBXAAH475hN+Pg3eQtZomNNJtW6dvhl1muJp?=
 =?us-ascii?Q?g62KQkD0LlCNe8oIVO9wkpmq4tPDqiRV5daXT92px4xdsnhh4HpU7z080lpo?=
 =?us-ascii?Q?vsEx7KJKUdE1Cb9EmsEnknP6PvsKa0fnazFoItss8vyaVb++kdqOeDahJSt0?=
 =?us-ascii?Q?G89OtBgcrt2xIzxydqkb9cNIbvZZImbJLHr3otwCzgApsZmFnyfzQNpc7f4B?=
 =?us-ascii?Q?jsV+vUsPMQPHvR4rtXuScwPR7FPxEzYm8VsrOvroSzthI1POnTWVwZrDJTcI?=
 =?us-ascii?Q?1V+rNzm8NDhCxiiViXM5O4jJjWAJpDP+QMhmNyKLDjusMqdQBjQdzPGfXpFq?=
 =?us-ascii?Q?djCMa1734uqHRxTlGcPT+Gk14jJy9n1JCw4lg/UDV/q5LYOv5GPxY85Bzqqw?=
 =?us-ascii?Q?uksm+dXoYcn1WZGKIzB/Q6cgwBFgAdRtACSKllRroTLHgXchpcUHXVhi11Ur?=
 =?us-ascii?Q?9pFNFPBOKVdClrjJRwOK4nuVTi5HXtRnmZEiI6USYmapeWDTCPPWrBS2bmHc?=
 =?us-ascii?Q?eDTXUZNViHhK1n9i6kxHg/2beAO3zuES+WY/ym8lsm4uw00kp9/KOElBDz0/?=
 =?us-ascii?Q?GMw5t8t+ir5x1N8RGv8=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(10070799003)(7416014)(376014)(366016);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?r7V+JPOBEwoRoBp/ldqV3DoPDysMixJH0enjlLYp6wurR/L342K3aG2MKNl5?=
 =?us-ascii?Q?18Q26aEQwdMGuIEU1yMrpRFUYYcwTHMmf1sx9zprh4/YPedp+1gpAe9RVYsL?=
 =?us-ascii?Q?H9wiqEvRRNyuNVW8pHWV5LuEWa9j9ZkJtzak0mgqfRzlcPOlCyRciIL+BECQ?=
 =?us-ascii?Q?UfLLUd4R2QJTz62AZipliwD9UWYtgzgUTN57uW7885pj/3YNNOvwPhbRG2pw?=
 =?us-ascii?Q?PTdgvoaSwPuRWyMjt7eGI5mkj3iVm+TYx++A03vKDdSvWTb0ojnH/cTfeDzq?=
 =?us-ascii?Q?vxAzunhoAyiO3RJOurVHamN/VTChSAu/vXlhXcuW0yEoqaHklTX21kmJvVnW?=
 =?us-ascii?Q?oLne+OLxmfZsTsodPf4CfnDUqSpYccmmavi5EO0q8B+OpC67Sp9KeGFvG/Qb?=
 =?us-ascii?Q?Kbm5lnZhxThx+zzA2F55xTA91WIjSWEkYnlsck/ThGvsUPZRLLxP6FsXTjqa?=
 =?us-ascii?Q?yPyoDqAAe2Au+jYGRkPkPvWqzx+8/RH+Ww+tvqcGlZFwjiIzVtK4JhhmH5r+?=
 =?us-ascii?Q?iOegSxzEza8xZ2Hc2+Wu4b26LAvd/aMkvyrCeWP/HZmciid7PwbaxbBSAjnd?=
 =?us-ascii?Q?SmPj4FVpkcxRpzwB5fabJHpAhvpfZbQs1r7Ts4E6PgmaEULDQudHVjrDrSCV?=
 =?us-ascii?Q?b4sNorAM84dNmDnGg+jZ33j+0YJaOaRrFRgHGTvlXorE+sAi/5yHTkanEAuK?=
 =?us-ascii?Q?ZyUnJAlXrfhLXDo4AqxwHfaZMXCsxiIh3YG+c7KH3U54kQrVVVRfEUSaZa8z?=
 =?us-ascii?Q?JV/AaKhKPx9zNj5IusxVu4wEM+iwJ2tZWF7cZgNPku40uZNiGcz1EMb66CGM?=
 =?us-ascii?Q?TB+rxvf4M3PoXy3lafrsdedrKay5kjTyOtV/81ZEhFG2em1kUlY6w29bxb+A?=
 =?us-ascii?Q?OtV54yR4Dx7Ez/79CDyMzfuIxYqNaGFqJAMUb0AJBhHDlMFC2AOKBQS6Jgyr?=
 =?us-ascii?Q?tQk3unio8hsiPN+jX0CT5BPnkF/iePUFYo1FzbIaPH3bn3zsJyNH/TSITDTc?=
 =?us-ascii?Q?nOApbpvx249decc+YI6TazVA7M6Sv4aq7Fw5Q2zUbNF1PuBq/inE01XEhBwx?=
 =?us-ascii?Q?oTm/7IIl8YHWmEQf3buT1OtvsPC5uIGff/n3BCGXzfrY3bsMR+Ued+0WUbff?=
 =?us-ascii?Q?2otGOMTs+7VNceb3G4/uIeYQeq7s6MqsIuB2fQ6tB/1pKBoao//ciFx3puHX?=
 =?us-ascii?Q?Tfjw3BLuMj8Yn62e49h8IsK00p9AzVsvdeiKo9IRH6L2zeuKY95TLFfQL4V0?=
 =?us-ascii?Q?HtrPYdTa+PtbLkqp7ezdGX1jndv5PCyRIHqkrJqFjaCmT1WVBR8kZxg9NVgw?=
 =?us-ascii?Q?Grczp7c+PKD0HN9pn1l8zqlG2Oc1fsBkQ78FqdVUyspPuxPA8Jlj9EZpm0RD?=
 =?us-ascii?Q?YHEgTvg2g6dLj9K+HbTFF2x0a8mTwaHAnsAwAP9SalfE+a3fSxkkS86dFocx?=
 =?us-ascii?Q?jx0zK7lhaCLSJfNL68eWopXUNVyUO5LZxvZg79kIo+iuP0FeOwvtjWzHiKKJ?=
 =?us-ascii?Q?BG9mOBkR+Ugf5XoZcpvO23kbJE61ALGC0YDbnzZzmh3kh7DGNRxMEZL49H9d?=
 =?us-ascii?Q?Di2Xy/bHgfol8ggznCyIeiYQwWlJsquhIz6lMGPaL2rp/LktUvyC/8CDuKdg?=
 =?us-ascii?Q?sm3j45lZuAQPUbu9Zb3/GyM9GvS/BA1dFDaw9ftK56APSq8cTHnuffk8h/ZY?=
 =?us-ascii?Q?C1TKf+5DxENy295MUZcZYUzL727X99f7yyO8VLjdWFVjCeFnXDhzDEPBf5+B?=
 =?us-ascii?Q?NvHOZzVIkN08rQnc9Tewg+iy48VU8cdWDAiRw8gy8R+e79SoANMN?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: d3982c85-77d3-4c46-7e94-08de6ca43372
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Feb 2026 15:09:22.7250
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eIMlXdOSTnPkkO4uwJtSM16xtfuiS08o2vuViOA0tJg9djq1HioWhAsMxtbAvkrIt99hYMTLI6JXtIqknQZnNA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY4P286MB7240

pci_epf_test_enable_doorbell() allocates a doorbell and then installs
the interrupt handler with request_threaded_irq(). On failures before
the IRQ is successfully requested (e.g. no free BAR,
request_threaded_irq() failure), the error path jumps to
err_doorbell_cleanup and calls pci_epf_test_doorbell_cleanup().

pci_epf_test_doorbell_cleanup() unconditionally calls free_irq() for the
doorbell virq, which can trigger "Trying to free already-free IRQ"
warnings when the IRQ was never requested or when request_threaded_irq()
failed.

Track whether the doorbell IRQ has been successfully requested and only
call free_irq() when it has.

Fixes: eff0c286aa91 ("PCI: endpoint: pci-epf-test: Add doorbell test support")
Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
 drivers/pci/endpoint/functions/pci-epf-test.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/endpoint/functions/pci-epf-test.c b/drivers/pci/endpoint/functions/pci-epf-test.c
index 148a34e51f6b..defe1e2ea427 100644
--- a/drivers/pci/endpoint/functions/pci-epf-test.c
+++ b/drivers/pci/endpoint/functions/pci-epf-test.c
@@ -86,6 +86,7 @@ struct pci_epf_test {
 	bool			dma_private;
 	const struct pci_epc_features *epc_features;
 	struct pci_epf_bar	db_bar;
+	bool			db_irq_requested;
 	size_t			bar_size[PCI_STD_NUM_BARS];
 };
 
@@ -715,7 +716,10 @@ static void pci_epf_test_doorbell_cleanup(struct pci_epf_test *epf_test)
 	struct pci_epf_test_reg *reg = epf_test->reg[epf_test->test_reg_bar];
 	struct pci_epf *epf = epf_test->epf;
 
-	free_irq(epf->db_msg[0].virq, epf_test);
+	if (epf_test->db_irq_requested && epf->db_msg) {
+		free_irq(epf->db_msg[0].virq, epf_test);
+		epf_test->db_irq_requested = false;
+	}
 	reg->doorbell_bar = cpu_to_le32(NO_BAR);
 
 	pci_epf_free_doorbell(epf);
@@ -732,6 +736,8 @@ static void pci_epf_test_enable_doorbell(struct pci_epf_test *epf_test,
 	size_t offset;
 	int ret;
 
+	epf_test->db_irq_requested = false;
+
 	ret = pci_epf_alloc_doorbell(epf, 1);
 	if (ret)
 		goto set_status_err;
@@ -751,6 +757,7 @@ static void pci_epf_test_enable_doorbell(struct pci_epf_test *epf_test,
 		goto err_doorbell_cleanup;
 	}
 
+	epf_test->db_irq_requested = true;
 	reg->doorbell_data = cpu_to_le32(msg->data);
 	reg->doorbell_bar = cpu_to_le32(bar);
 
-- 
2.51.0

