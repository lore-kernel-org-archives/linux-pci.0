Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.228.72
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792556569;
	b=VS7asaeccNYVk4F/Prywi8yBWPo08bEkNprmbFOGEXIGParfLsmAZG/IebfbHXx1dYOB
	 +HtPE4oPnDbooQkwmf51J3FpFoZgx7IrUr+kN/DVTEY+eNvsYpd5507Wq++lR+VFcyL/I
	 3aP58TMFC6FPa8ZVXxhg1Oe17EEqlUVtLgyaJevIsrjZMwljxLWpUC3X0SqsxM665z3BX
	 4jj3tysdjNJJYeVgbS1XFKp3+Q5xlg+eBP25o9Cx/1gTMFL16ADI3M6ffgeLbwkk/MKyD
	 nMVzSHWNwJaAN8hKs0Fk6I6v6kh7uC1/hg+A5mewGFA6oJKOnXzADjPKgiOlu8rd2ng==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792556569;
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
	b=W/uKeNxdsh4Zd6f+EWJcqtzjTHdlzjBsOvajxfPlms8MvZ06JnILvTFFOxoD4SbpeS3T
	 ib55oGDudggB2auxPZtKZfa6WPtB25b1wW7G9UynIqKIbjRc1Q/vgZO4ItAMbqB8zV7Ob
	 kmBfNKr9hjHCABHBFRh/HqfsOh4/coY0vW0bo45e5cjxT+q3wEyuMLOy8llKPvwOGmaHR
	 HXRs8RKXmH6ZMxKgyWzJeCTQ9rvTrGh4eDIv5jOR+7KJVvhnPzoqIClAru6MhkWV0XMhB
	 QjYbp7NJrZedJ5hx7hKB+onn6RYhQ/xIWOdRUy8+1Bx9QzV/3wCE3vcBIcrLLLofcUQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=valinux.co.jp;
	spf=pass smtp.mailfrom=valinux.co.jp;
	dkim=pass header.d=valinux.co.jp header.i=@valinux.co.jp header.a=rsa-sha256 header.s=selector1 header.b=IKc3L0fY;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.228.72
Received: from OS0P286CU011.outbound.protection.outlook.com (mail-japanwestazon11020072.outbound.protection.outlook.com [52.101.228.72])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BE46606A319;
	Wed, 21 Oct 2026 04:22:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6BE46606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=valinux.co.jp header.i=@valinux.co.jp header.a=rsa-sha256 header.s=selector1 header.b=IKc3L0fY
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bceJenX1eB34VHlzST0y/mM4G2Nd+v6h2IQxy7lFsIAM2UxbsaR0nWpzXpkEA52bB79cXMWoEJaWwCUBBgC6w+88JuR9W4VVjZL4HfFu/OpBZSTVp3Ov0v7YupBa7bYVhNV7pdcw9DGfuyx/zBS04cCohbgP5sKCVgjkJCEkSpPo8wdE1rVzcDWvIfKr3LdPAMqw7awGPC47QouGjm+vRr4knbVdzfoPS6kJbd3ux5K28DSn9CKyxVNAouPoD3LuOmwmHRdDCzIW5VlHDy+EJyAncQzbpc6cW3C7Gpj3Izyh4odZbnRtjQ3/D7yncE5VZ+ruspftY80JRL6LiyrlnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QDF+vH7C6dVPva/+z08gSMrAX0jRK7SiWjWXZzTXCPg=;
 b=oPeLmVzjrnpor7ZKhhQluGIz0VqhrjdHMgcyPsrj9DI6sb6dJZwc7i0mdXswz0k2kxAlXtliDt+ipg7P3xK1EsTgV9KTAStLSDAXhF1Em9eta3bS/U2Ue6yiLPGyPUYPGOjWUzue8C6Bm6sLfPxs+UxZKbo/iNRds3SKza6amK52ECBJvZUV5nb7WpUkMw1yQz+duz/j/os9YFAa2PTy6wDbemnUghtl5TrTH50SsIzzFNEaPSXTul+vwOPF680IFtUrVny/1G6GculYe/A3xVuvD+Kb7XtmXdq8ofDNCyIhyi/aozp/gLf4qRV1lkKx/S8TuARSPV5+gC/JtRU46w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QDF+vH7C6dVPva/+z08gSMrAX0jRK7SiWjWXZzTXCPg=;
 b=IKc3L0fYAvRzsjqeqTibY6bmj1j6k1H0ZRCqNIvjzIaZaXFsiLk5SWW0VLA4nUARjkieO+Wpnbt7AuGgt88Nb+O5+peT8jMgHN9iMy9fMfw96jWW02+duqMrlZ3y0skm3hFK5+/UZmq2/lVCoxjwN/Fpm44eQuM1/sf1u4gACDc=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:325::11)
 by OS3P286MB3180.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:20c::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.15; Wed, 21 Oct
 2026 04:22:38 +0000
Received: from TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 ([fe80::cce5:2aa8:53f9:dba9]) by TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 ([fe80::cce5:2aa8:53f9:dba9%5]) with mapi id 15.21.0546.012; Wed, 21 Oct 2026
 04:22:37 +0000
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
Subject: [PATCH v7 02/10] PCI: dwc: Expose endpoint DMA resources
Date: Wed, 21 Oct 2026 13:22:21 +0900
Message-ID: <20261021042229.2280937-3-den@valinux.co.jp>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261021042229.2280937-1-den@valinux.co.jp>
References: <20261021042229.2280937-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0307.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:38b::15) To TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
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
X-MS-Office365-Filtering-Correlation-Id: 0667367c-736e-4e88-0118-08df2f2af035
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|1800799024|376014|366016|10070799003|23010399003|56012099006|261009223027099003|10067099003|18002099003|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	lafL1gxyInf8PzVnV09LJ4bw3I/0iEodbE5DyDXJbR338aIPT+6GQjDnN3MsOqrVGvN6FCSEe5swC5P/Iby59wxuy4mjaAvbBjQQXfoYJsN3BL0gs02bp5lR74rn4at6Wid7auv100/aRixzDpbqxjWuf8MzcaEFqketERO1hy8IZycqimrNM22bqmnZAtOArvAODkbnJGbL1BbWlt3mlcPUEYzBUo2NY297HEQiH9piCqY9NKL72+KSOQaYub1YwIDpYRzpu5YSsEBeiLs6uEi84WVOJ1DU5ZycAsECnJ2/yW8Cj6+dVrByck2IE8V7YGA2r33YcvgarAjUSuQV9rP8Gp3IekwZ+6fH8HmZ+5rb+U77cxKnbgLdmMhf77C9B246U5BaKKu6Y6HnUBdMYUF7xcABsYZtQO1npIOg4nxTemrsxVtF9VmmtKW2OddcaX5pswTZ3Qqf3kMz6zM/6OQF8e6yQ2qfqBTOIv9PQlfh2Cx0fqlBxrhVDsKaTlkhR5o2axYzbiS42N5nb8+SkXWXu1xY/PSVAH6vmhx+k+CBlN2hHg8szQGrxV4F1UXGizc8fM/rZ6Nq1lTU25g12QOwkHdEU5E7uorCllOEAEh3M803vWi/NRXjnEKrATGtfbBnYGk4HlJNkT6W5Y3gNzJHm8Q4nsjx0hplfK2FaRI=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(376014)(366016)(10070799003)(23010399003)(56012099006)(261009223027099003)(10067099003)(18002099003)(22082099003)(6133799003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?SZAPSyEpGb9mMYyb/IQB9ddI+V1xLQmA79EV6lhAZLSBEh0UaXdvtKZiAit/?=
 =?us-ascii?Q?QT0m+AXG+VaFp+5sY6xO4ZdMUoxOmRiwf9SwaLrxka0Ru+PIOQhp25dSnfXj?=
 =?us-ascii?Q?xVZUGzA5JVneB6WxVc3rYMhRBaz6mMOtPCL+UZwn3dHolHMrXoO/L0/f84fx?=
 =?us-ascii?Q?VGKSmco1sdJwhCgqiduay3Ewv30eVJuZ5Jsv0HErzXX4/fzoClO7UeCNAtIc?=
 =?us-ascii?Q?KAt1ohkFJFD+6DZ/hrYpTLJBl7XdZJaogdjAv4qqQamVEs7q3WNAciJyo3u2?=
 =?us-ascii?Q?qyivC5GvAMT2sBUkAauMvKj2pvU08F9NfG1ovH2SZ4oJoho9xUee+k4tHZJn?=
 =?us-ascii?Q?qSUgPysXtL4mCwiQE5y6+T4Asou9KQu5VAnkaoIxz0OLxR3FmGle0hg9kOWn?=
 =?us-ascii?Q?EIrPoq6Lakk0qKwzstC+jdl7Gm2HVvTMfNZAKuRlL0Sk7NMlPHtRkznYZ3SR?=
 =?us-ascii?Q?u+PPERb9WQ8UNg+0xURGFqVbI6ot0cPucnnfDsbN0OYsbt+1zvbWRuLSRbYx?=
 =?us-ascii?Q?BXalaYN4uTJQEKHYLFXs4j+F6W+Te2huD1J9cotz5sRMuJRyHl+GNFPJ4aT0?=
 =?us-ascii?Q?P/iFSaZZLNKqv9ZuX4DZ+dZdcAEoIQ0wgvTES8BwfeiwKPpF07ETz1vUx9Yn?=
 =?us-ascii?Q?QS1KmA8pIjdKy/X3HWDy/WdEZlpfzoV5j7irTaDLVkPa3PSGaJgxZriQAVgb?=
 =?us-ascii?Q?1sfYbDj9Mih14qy2siiAnZ8RiyGI9BvwzyrEXTo2EGiCuQahfqKhPow1WB1f?=
 =?us-ascii?Q?eVPQVbS4eED/Wt6KxirLd4sqREtX+6AWuY2f1Wj1A032VlukchjRpS+oEPMd?=
 =?us-ascii?Q?Z8TMYXGiET8RushwFQuDzJbMMwVYlZIiXle8Ip3s5Nu5fFzCIuv/OaPA+EV5?=
 =?us-ascii?Q?K8L5BYOlprm0OdbC2edqElkBzlBkTrATiwLlbb/Hzi0mwHORM8w5ccGCQFdd?=
 =?us-ascii?Q?d+eU5S47Gi496g4yD9hSbRa096tapuqzGqZFkl4vFUW1pYD94f2uqVZyhb3S?=
 =?us-ascii?Q?V8hjVRR7VyJ1zkNQiOtgl+enyrS9YWkNN3DK5TXI4KdGin4xtjzuZOLL/T5g?=
 =?us-ascii?Q?26SyYAPQAVotcCe+lx1U51/nSbXasjW+wPkkQ6q6eQn81Ye6UPEKzpQ13fbP?=
 =?us-ascii?Q?kmTEofENnD+yp8iOeFz4YSlDmWpj0Op3VMJiZn5uMutSJihb/U1t6OnpiqJZ?=
 =?us-ascii?Q?GmntuJ6OEe7vqpQCX9vb4OwH8/zFRJmQKIzorm3U3664qUGNCAYWT2/uiB5Y?=
 =?us-ascii?Q?pMvtQF0lxCV7XT7d485Taihv+aM1smXTUlcXRjRqVXL5lACv5H3PoSTQzhxG?=
 =?us-ascii?Q?u/CUTxWcKQVwMGcvNkfCm8ZzdMwEDGBAT8P4nrNmzn399W5gAvobFuJqPRZ3?=
 =?us-ascii?Q?obt6IKbTWBd+8WIt6GF/2D4dBw8/ITN2NUvGhLDgsA513JTmUC/p/wpUEfkp?=
 =?us-ascii?Q?5loJ6LWXbTDn/jIvSXBcd82MyMNhCFEM73Aaje4vCNwe5R6iQ0QvFDH7wlQa?=
 =?us-ascii?Q?V+HxXZqQ9mi/d2PXQKrCCmZn5c1O+r38O0JMKBYxu8OUxxR10p8MA/XwlYmL?=
 =?us-ascii?Q?P9y68/TIqrBwOkY6zkVYGyD62/DZBngImyUP/Nf+pqQSHtYa0x/zWi2+MyuQ?=
 =?us-ascii?Q?V6IzHqND5P2OWM8fkcKrHUi908TSYnwqbQEl3Da8XkEsGSE1YO9Him4iwjHY?=
 =?us-ascii?Q?gkMkpa/tSmIYQ5mCH7E9DPeNvEY1sFX8do9hRoXYJqNn6YQX9yFQr1ZkPEYE?=
 =?us-ascii?Q?JnSDnLe39RBHiD5vqKLEzdZ1faDUFDhv5GSkyahs5UgSNu16iqHq?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 0667367c-736e-4e88-0118-08df2f2af035
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2026 04:22:37.6453
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: umjln0TALmD7/9QrTbv5I6URMLU+GwAhV9VUbN+XrQL0GunzGDibrtDaIYEVJPC2z9MAekCuBysZFXKBA+Kq9A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3P286MB3180

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

