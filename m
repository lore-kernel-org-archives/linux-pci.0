Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.125.111
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794299109;
	b=UxiQo7DbgXZkeegNpaw1Z7dpk3Ay3MD1XU90vv7FbJiEF4sKn/jNoqEMiV99WiLLjBqB
	 9Z6UofPqn+Vk0FfeW12WzoVaGI+OLJJOOlsop20bdyM1mOoMXG2FRTFeYkCTH59ncTK/3
	 ipGqJ3uZprw5T9MncsdCE92sDWX+I/xd+gnq/bQAFWGA8Llv1n+RSa34e+Vop4ObVZvpQ
	 yk+58td4BAI6j4QkZ+Q0Wi4+Su7ayGhDagM7UvnODOKoDyR5+snggvzfWu3ycfs0RlGTf
	 YRlvArJgTurOJLkpY4ib78DLPgWyS5s+4XIl1t8oCRGeKlEeRwu2VkVL43IeHCkuwUA==
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
	bh=QDF+vH7C6dVPva/+z08gSMrAX0jRK7SiWjWXZzTXCPg=;
	b=q7mbpT3mmRA7Dn3uJaEm30hJhienug2a+HP/0EP7n4btYe0B4A+jLWcJ680xOBimrY6X
	 nexbK3Ez6QTsG1lZvQx4Xsf3rRIVpxacr5e05STnCN4+Q/4Vkmt48oDzKdYC6+gDwmPXS
	 WdsRax+J9bJIdQpnuZr/mMMn7ZuAvaRC5CkOQNOT1hG2R0OlkOlTqn//WO2sK+ESddDrr
	 Ph3Skpws06NUl5svB9WJ/cw9lXVKbGmI2WRFef4efzrkkrtTS+ZSYTCHeMTcMYehdxKCL
	 UhLoQu4CCZL+rv2mxusQtRGDTVftNtnZp3aEdthj7eFmz3UZyv3o5HLlhZDaGpaQ4YQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=valinux.co.jp;
	spf=pass smtp.mailfrom=valinux.co.jp;
	dkim=pass header.d=valinux.co.jp header.i=@valinux.co.jp header.a=rsa-sha256 header.s=selector1 header.b=eFLQWLSJ;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.125.111
Received: from TYVP286CU001.outbound.protection.outlook.com (mail-japaneastazon11021111.outbound.protection.outlook.com [52.101.125.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44DA1606A339;
	Tue, 10 Nov 2026 08:25:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 44DA1606A339
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=valinux.co.jp header.i=@valinux.co.jp header.a=rsa-sha256 header.s=selector1 header.b=eFLQWLSJ
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sIA0rSJBDFr/3zEGi8XxFcn54FgCFM4j2ptHstCpG55TiFPPIWeLlwGoQYb8Z9aPW6GLgGd+TSoMQ8qzmE4wCr8GiIfF8sfHoCczglN3eStVrsnXea96TOsWjeGWRzY25NAWszv0+LbYc+h8Jc/kmop8ndizMvfr1PRv6Ehd1nwt4SCkSTi8jwZKnPoiOHLA5pLr47QS3mxx9evODXiO075tjNH4sU5bmrwwnrDChuDQNcVlxeYba4KizHhaITGDCrVrTTagsbHroO/rIbYi1VNSzYKQb9ZPH9iMr1qsktgSsVzNXK/YSczp8Pm5GyUq818M4W7h+GCrM0MG2Vfb+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QDF+vH7C6dVPva/+z08gSMrAX0jRK7SiWjWXZzTXCPg=;
 b=fG9Gw5WrIx9XSuR5Vr5i1GtEAd5dk0kHfNA8xEEharRUWyyWfucEGn9aL3VxIgJM8qU37jftBG2NHspmTEQmjLBrWrQQrPynFMIGnjR2KTH6iKo6O7OEcDC5kiDkKKqWRVyg1KYrjSlzYhscKQdhjtHw9nsoSNcE2j2NfnHvD3ua6JpeGaM9i8MBQb+MWzdKIoUPxYk4Se+DlsgSJA8lIYt3dy/GSYYOZrgJFKEpYjiuLkro6iowokTx8T2pTtGuwoXRxQDoo7EvAhYgkRuipLuxCK6O4EXrL9cDo2NwDJgIYwSHbp2bWeCrRWTqYsyjMqvJzrP/ryl+atUrCNBOlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QDF+vH7C6dVPva/+z08gSMrAX0jRK7SiWjWXZzTXCPg=;
 b=eFLQWLSJ9kvHJ6viW8rL9sfUVp3aoKXDRcGwCnkweSs6ohja9AERsKdxEsvzWIqbYBvJo224YvLQ090Q1eRz0wtWuKa9gP81EK11EYWI8kwrgNlOwOWguZnDCn3sl6IrXjpWfBLLyidBs49Op22ne8hILRz/e7VCg/qGNaV2wOI=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:325::11)
 by TY3P286MB3015.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:318::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.13; Tue, 10 Nov
 2026 08:25:07 +0000
Received: from TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 ([fe80::cce5:2aa8:53f9:dba9]) by TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 ([fe80::cce5:2aa8:53f9:dba9%5]) with mapi id 15.21.0592.012; Tue, 10 Nov 2026
 08:25:07 +0000
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
Subject: [PATCH v9 02/10] PCI: dwc: Expose endpoint DMA resources
Date: Tue, 10 Nov 2026 17:24:51 +0900
Message-ID: <20261110082459.1798763-3-den@valinux.co.jp>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261110082459.1798763-1-den@valinux.co.jp>
References: <20261110082459.1798763-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY4P301CA0036.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:2be::19) To TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
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
X-MS-Office365-Filtering-Correlation-Id: 33743b89-6ee7-4a48-b1dd-08df3f0420f1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|23010399003|7416014|376014|366016|1800799024|56012099006|261021121427099003|261021123027099003|261022113327099003|261022105027099003|261026121527099003|261026140227099003|261102130727099003|261028144727099003|261102123227099003|261009223027099003|10067099003|22082099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	6fnexGo0W1CCwWlTeBweCmMQd3/ZVfU0dR11ut8PxAdICSHRGb/hLaeshYtWqp640kKmYui9R7b5NOx6KEEa/CXa4/zmbi6NCBY7rCCxxAQQ9hQVBd94QRcfHqTVMcJLkuGz7J91Z6hREkXeV5h+TfqZb3BcCJ4zMiwC5WMP2pqZ70MB7CYjUjiwvPTNKRDTl8d/SjdIWdmZQsuEWgleygYlPgmTVu5f0oPuo7KMpC/LfeBpEH+KPwkXFsM04xBYbi+f5XC4wVpOtomef64SkNUvVQnlYe7dp5vVoFWCpnIrLVrAYur4MJcVgW4+NR0LzCkd9+wEH4vwSharBQIwk488kvbcDDvjRm22OBfFUkrc08hNATxhv7I7SsDZkwaNd+Zr1xRpYFlK9WVBLlw/WU0ZvGLvgWOsyaheR7cDoEZJAyEA8/OkO86gYD0zpy0ZX01a55r3f7A9cdi39nI6nvuLHPNAJM+9sAiYXhm5L8NztdAUQ3xrZRVdE1dHTD3bE39u2kwLV+f75gFr/38dzdVIycXoiaTpZVihlFmy9Q3X+0svMB5fk2n9cKC0nhwpCmyF80kjI2o/P0B1gWcI6+QcznurbtpYsxtUjqcJTY8OgljoBt2xFNTbPh6XHt/uTQBIiHjklj5zQb1ODIf6swhyZ9rd0nza8VmffGG4uFY=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(23010399003)(7416014)(376014)(366016)(1800799024)(56012099006)(261021121427099003)(261021123027099003)(261022113327099003)(261022105027099003)(261026121527099003)(261026140227099003)(261102130727099003)(261028144727099003)(261102123227099003)(261009223027099003)(10067099003)(22082099003)(18002099003)(6133799003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Wwc2pGpchkCscsPF9ROM0hgUGLWf8aWrU6IsS+vK6auqXf6CXE9IU2V1o+Mj?=
 =?us-ascii?Q?RRx7xt1s3kEG8sGiadF+ANyFo3+xFUnbScid8DmYH9rV7FGEgD7wxAnBELsk?=
 =?us-ascii?Q?vkzpV+d1WZwTMOtBFWziCPu9gmHhph2yiTWxJ8Dlui/NQnglDU/+BIEtj9Rv?=
 =?us-ascii?Q?RX9g/SDUBL1UWeVJW2HQx6y3wX+YE1AR+bk88hc+RQQ1emHsR53xdGelcGyR?=
 =?us-ascii?Q?EPKBUMTmgoTfdo7wpAhO5e5XWJWLiNjolbBYqGBWM6QYAT8Ai+9KU5VTnblz?=
 =?us-ascii?Q?pMULAmnIj5xngd4Mm00v/U6au9AAXGCD2MD1sRZwB3Ov8mdlRXgoVJG94GJ+?=
 =?us-ascii?Q?+EIL+WEW9Z4bs6UjZhRSTMx2dhqu3LAehV5mJi9ygcne0h2IOfJ5MCKE8JSu?=
 =?us-ascii?Q?VHGOiM9rG37+0XW8DCP7PT96TJcXslPCkn1dqbThDyHKVgY/o2KzXc99qCRi?=
 =?us-ascii?Q?nRSdwLuZCotdJMxxkN58OQK27AoOd4A20Cw0CFf0ZPb+MWIrHAgIyG00EzhM?=
 =?us-ascii?Q?pBcVW5S/zk+dALwFkwVYhiwaddvcWZvdLrrw/7JeGeuqPToIB3UUdXFOacUx?=
 =?us-ascii?Q?e0kedWrpiGPcyctTGe6QpC29CrCF/YnqIm9TpbBIkgJwx7ckE7nZgAs/DqkM?=
 =?us-ascii?Q?BvlhJ9Zyi2+wGCpKmo4KXlJoEGwfc7iLka8qseZz7KTkeikwnVT7/j6hXax1?=
 =?us-ascii?Q?Ut4MV8dbQNuBtMThC8ghwOZhYq57oGW/tUCi6K//PI0oeYIviFh+xvS7Twcl?=
 =?us-ascii?Q?kNVdtdQYIm4c/oX12yMvEY24vUz0YzS5LfEMCEAeMDHI1mAdUOaGA0pYs+JN?=
 =?us-ascii?Q?pGOIC3dQz+shUqfXFEug+ih6MDE46dN1nQqZnS3JekN24FKmcBE6TOJxKrwy?=
 =?us-ascii?Q?+o9wkTmGA+T2Or3nD+Ko+dpwb/OEKK/+Tw7ETI3KKagqb9rI4ES4QE1X0Pmg?=
 =?us-ascii?Q?pIfaF8WN+7/A5TnEpO777y3GNhphwsyllnN+DanX72DgzLPOXTXEi+NpVfgt?=
 =?us-ascii?Q?yUvCzSewbjEt2lue5LO9Vfth03ypfu96Lw1ne410Drtywt347bG+MunCHHok?=
 =?us-ascii?Q?2/MNtLCjLzan2nVhsDMivPWydsrh4ffU3oOuLIPPI+n+w96FnhBx02oKdYXT?=
 =?us-ascii?Q?dgmjzHghCqBmSnUlXWYmYxpfrlVF8TxstQl5LNxYVdlCFzvMtz1NJIC214WB?=
 =?us-ascii?Q?DrBjA4zfqNO3JIC10tebwXtGNPlm3gbQbWfDEkZUdRCUd9jjo/5az6ltv3Ru?=
 =?us-ascii?Q?M2UjmI6rJE5dPuuxl9pXmupoW0CbaTJt6gTQf0X2aGpad66eCZx3nF5HBXxQ?=
 =?us-ascii?Q?oSHcIT1rwgeHsh43fqovnn8rDiyS7m5v2poLW7nHRZCkCuEJOo/vWMgWS/pT?=
 =?us-ascii?Q?gHDXyTEhbttDV3xu3DlvI4pSAwBCAZBYypHauZs89PftumM/FeEtq1yT40NT?=
 =?us-ascii?Q?onokXI7RFu2o9PkejIPnScnvuCpimzzkP8Pt+5TfOL8thoDy2n8LuLvyBWal?=
 =?us-ascii?Q?3/YPg4ILy+e9Crh9hgaUmlAbQjMkoKxnFeRBOJyjnM/W28TVGYEVQPZ0Uszh?=
 =?us-ascii?Q?RRDco1q9NyM8dQgy4wrx9D+KDgBrdFOszczk67fVln3W6KjTOFkgvhnwZfB/?=
 =?us-ascii?Q?/IGv4debKrmU7L/P/L+u4hhFlsod26z3/Ftr/8MW6XAOWMDLaPMDDSe3+qxB?=
 =?us-ascii?Q?TQUZhLw5rxjdCa7dCqHNKuX4aY+HYXakkzqEStcoaZ92sAZOUkcYNXXpupcP?=
 =?us-ascii?Q?KliMEB1285NCHbXoreiIbehCIEXckRk2OTaIL8F8NSfE63VOaz7Z?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 33743b89-6ee7-4a48-b1dd-08df3f0420f1
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2026 08:25:07.5881
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5fC0FWfBopqqx0WaRJLJcOehsZsMIZAYpd3DrRybhCNpZi55cXzk1ELqv2dCkqGUnxd2AtdaIT0AZU5g1ahOrA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY3P286MB3015

Expose the endpoint-integrated eDMA register window and linked-list memory
through the EPC auxiliary resource API. Endpoint functions can then choose
which channels to export and map the required windows.

Associate each linked-list region with the direction-flattened static
channel ID used by the local dw-edma device. Report these resources only
after that device is registered and only for channels with linked-list
memory.

When the register window is already part of a reserved BAR, report its BAR
and offset. Otherwise report its CPU physical address.

While at it, harden the existing doorbell resource query. Report it
only after the local dw-edma device is registered, and reject VF
queries because DWC cannot assign DMA/HDMA registers to VFs.

Reviewed-by: Frank Li <Frank.Li@nxp.com>
Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
Changes since v4:
  - No changes.

 .../pci/controller/dwc/pcie-designware-ep.c   | 107 ++++++++++++++++--
 1 file changed, 99 insertions(+), 8 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c b/drivers/pci/controller/dwc/pcie-designware-ep.c
index 630ba172280c..7166ec7f212b 100644
--- a/drivers/pci/controller/dwc/pcie-designware-ep.c
+++ b/drivers/pci/controller/dwc/pcie-designware-ep.c
@@ -858,6 +858,15 @@ dw_pcie_ep_find_bar_rsvd_region(struct dw_pcie_ep *ep,
 	return NULL;
 }
 
+static int dw_pcie_ep_check_edma_vfunc(u8 vfunc_no)
+{
+	/*
+	 * The DWC endpoint databook says it is not possible to assign the
+	 * DMA/HDMA registers to any Virtual Function.
+	 */
+	return vfunc_no ? -EOPNOTSUPP : 0;
+}
+
 static int
 dw_pcie_ep_get_aux_resources_count(struct pci_epc *epc, u8 func_no,
 				   u8 vfunc_no)
@@ -865,14 +874,30 @@ dw_pcie_ep_get_aux_resources_count(struct pci_epc *epc, u8 func_no,
 	struct dw_pcie_ep *ep = epc_get_drvdata(epc);
 	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
 	struct dw_edma_chip *edma = &pci->edma;
+	u16 ll_wr_cnt, ll_rd_cnt;
+	int count = 0;
+	int ret;
 
 	if (!pci->edma_reg_size)
 		return 0;
 
-	if (edma->db_offset == ~0)
+	ret = dw_pcie_ep_check_edma_vfunc(vfunc_no);
+	if (ret)
+		return ret;
+
+	if (!edma->dw)
 		return 0;
 
-	return 1;
+	ll_wr_cnt = edma->ll_wr_cnt;
+	ll_rd_cnt = edma->ll_rd_cnt;
+
+	if (!edma->cfg_non_ll)
+		count += 1 + ll_wr_cnt + ll_rd_cnt;
+
+	if (edma->db_offset != ~0)
+		count++;
+
+	return count;
 }
 
 static int
@@ -885,14 +910,32 @@ dw_pcie_ep_get_aux_resources(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
 	const struct pci_epc_bar_rsvd_region *rsvd;
 	struct dw_edma_chip *edma = &pci->edma;
 	enum pci_barno dma_ctrl_bar = NO_BAR;
-	resource_size_t db_offset = edma->db_offset;
+	resource_size_t db_offset;
 	resource_size_t dma_ctrl_bar_offset = 0;
 	resource_size_t dma_reg_size;
-	int count;
+	u16 ll_wr_cnt, ll_rd_cnt;
+	bool has_ll;
+	unsigned int i;
+	int count, ret;
 
-	count = dw_pcie_ep_get_aux_resources_count(epc, func_no, vfunc_no);
-	if (count < 0)
-		return count;
+	if (!pci->edma_reg_size)
+		return 0;
+
+	ret = dw_pcie_ep_check_edma_vfunc(vfunc_no);
+	if (ret)
+		return ret;
+
+	if (!edma->dw)
+		return 0;
+
+	ll_wr_cnt = edma->ll_wr_cnt;
+	ll_rd_cnt = edma->ll_rd_cnt;
+	db_offset = edma->db_offset;
+	has_ll = !edma->cfg_non_ll;
+
+	count = db_offset != ~0;
+	if (has_ll)
+		count += 1 + ll_wr_cnt + ll_rd_cnt;
 
 	if (num_resources < count)
 		return -ENOSPC;
@@ -909,6 +952,54 @@ dw_pcie_ep_get_aux_resources(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
 	if (rsvd && rsvd->size < dma_reg_size)
 		dma_reg_size = rsvd->size;
 
+	count = 0;
+	if (has_ll) {
+		resources[count++] = (struct pci_epc_aux_resource) {
+			.type = PCI_EPC_AUX_DMA_CTRL_MMIO,
+			.phys_addr = pci->edma_reg_phys,
+			.size = dma_reg_size,
+			.bar = dma_ctrl_bar,
+			.bar_offset = dma_ctrl_bar_offset,
+			.u.dma_ctrl = {
+				.reg_layout = PCI_EPC_AUX_DMA_REG_LAYOUT_DW_EDMA,
+				.reg_layout_data = edma->mf,
+				.ep_to_rc_ch_cnt = ll_wr_cnt,
+				.rc_to_ep_ch_cnt = ll_rd_cnt,
+			},
+		};
+
+		for (i = 0; i < ll_wr_cnt; i++) {
+			struct dw_edma_region *ll = &edma->ll_region_wr[i];
+
+			resources[count++] = (struct pci_epc_aux_resource) {
+				.type = PCI_EPC_AUX_DMA_DESC_MEM,
+				.size = ll->sz,
+				.bar = NO_BAR,
+				.u.dma_desc = {
+					.dma_addr = ll->paddr,
+					.chan_id = i,
+				},
+			};
+		}
+
+		for (i = 0; i < ll_rd_cnt; i++) {
+			struct dw_edma_region *ll = &edma->ll_region_rd[i];
+
+			resources[count++] = (struct pci_epc_aux_resource) {
+				.type = PCI_EPC_AUX_DMA_DESC_MEM,
+				.size = ll->sz,
+				.bar = NO_BAR,
+				.u.dma_desc = {
+					.dma_addr = ll->paddr,
+					.chan_id = ll_wr_cnt + i,
+				},
+			};
+		}
+	}
+
+	if (db_offset == ~0)
+		return 0;
+
 	/*
 	 * For interrupt-emulation doorbells, report a standalone resource
 	 * instead of bundling it into the DMA controller MMIO resource.
@@ -917,7 +1008,7 @@ dw_pcie_ep_get_aux_resources(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
 				  sizeof(u32), dma_reg_size))
 		return -EINVAL;
 
-	resources[0] = (struct pci_epc_aux_resource) {
+	resources[count] = (struct pci_epc_aux_resource) {
 		.type = PCI_EPC_AUX_DOORBELL_MMIO,
 		.phys_addr = pci->edma_reg_phys + db_offset,
 		.size = sizeof(u32),
-- 
2.54.0

