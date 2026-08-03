Received: from OS0P286CU011.outbound.protection.outlook.com (mail-japanwestazon11020095.outbound.protection.outlook.com [52.101.228.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1219442E8E6;
	Mon,  3 Aug 2026 18:04:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.228.95
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785780292; cv=fail; b=Eqxp0m7ECZdS5aIBwHNjfM/jUu3ll8NPaG5SkBYGxnsYSg+rYekRLEViT9zKsW5FanvjWx95jIQihNS083RtTmPj2GPxrD0AGC+XlwE+NuSGajWTjL/wUpb4J/PVoNdPIbIBkBgW+3Gfz6Ge52kAUAtehiV/dNh2IcQi2YZMhuU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785780292; c=relaxed/simple;
	bh=xOeVcLMYScY6ugX02McGTVVpguZqMeX+m+aL84VfRHM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=VtPiDmcOpzCDO4e16Yrjwv07G7g43b7mI6WrfX9tiIzGPL5QjtaUZFoNvGm5rSVnE/fTngG3zGXIxuZdBi+b24XnghDnfa3YmBAZFkcy8qlsYqG70MXzHEU1uX0AnPOLqvHZ2O1i+33+hEj6hNVpQ+xN2syHCj8X8rsDLTHZXuw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=FWeqge3p; arc=fail smtp.client-ip=52.101.228.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="FWeqge3p"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=f4P7OFAAK79QE1V6aWMs6JtZ4zBJdaHUMHosxKynJYHfi6aKCkIAbEq0h2OtbszG4ebCdKzya7mVqOVZun4T9JMYYnIor+d1+yJGS0tZBb0hJc+DVq+A4MYm0dyQ31F9tkG8rlZK0SrLQlM3sMmkDCiJmhwuJITt5R6lyHjDKcjXTV/83CHvZ/gUxWcruDpHIZf9EWnqW7gcF3EvyAKTLBWcqvNR92H5YiZpN4ymRbgKSNhGVZVeGQ6fOFGfHm6GNa4Gr6hSehRjgGQwvAlmBuexmHGAJ/O0dsf2rKU2bmFV4tANaryMx+BB4KOrtJdCU8+JeNrcc56jD3pZ5U0ZfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pMzjr6T8Zm91xCRn0kmmVC3NiEPjv92EgQMaCvHyaGU=;
 b=VgRFs8VrBFwMOXLbOftUvtDX4HD9VHADZVXzpbpgg0fqp75Kd2IgX4DJnvkeqsqS92uOiggojCzY0urPIrtykGLs+XJ0zTD/nFZHc9nn9azZAHkjYFptx4uOTdHDooNdCUFfzNuiulTsy3oFyGneOCx5uqg1j26F2JejoU+Bclz2xYLWnxy0BRs9IOZ22x+JDoDXMjwwVQ99B4I6fF8hkXlxBn55Nr9YVyG11Mb+H03kaaq5dl/7zb+6M8jkkG6hzzJrqrfz5R5JMkN8mj7VoVM2oulxqAoj1J3gJ8PQsXEZ18GxPzWi0sVd6zWlVezfj0XCGvdV0jJnbg6cOchdOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pMzjr6T8Zm91xCRn0kmmVC3NiEPjv92EgQMaCvHyaGU=;
 b=FWeqge3pol0jfE0fXOwiDSbgtZhHf9G2m0sZvrnmxZUyxlyAlMgeadkIPWY2JMGt2Elrq5N+dUG8ZUI7Itjw3M97D66dULsZI6zvUSUYuiNpKKZXNYbOGhdXqa9/QCVShE6u6Ib5rGF2u1fW15tx3lKxAmVzYxw6PIE1Vkwaaos=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by TYRP286MB5249.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:115::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.18; Mon, 3 Aug
 2026 18:04:44 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%3]) with mapi id 15.21.0270.016; Mon, 3 Aug 2026
 18:04:44 +0000
From: Koichiro Den <den@valinux.co.jp>
To: Manivannan Sadhasivam <mani@kernel.org>,
	Frank Li <Frank.Li@nxp.com>,
	Niklas Cassel <cassel@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Jon Mason <jdmason@kudzu.us>,
	Dave Jiang <dave.jiang@intel.com>,
	Allen Hubbe <allenbh@gmail.com>,
	Jerome Brunet <jbrunet@baylibre.com>
Cc: linux-pci@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	ntb@lists.linux.dev
Subject: [PATCH 04/11] PCI: endpoint: pci-epf-vntb: Implement MW group translation callbacks
Date: Tue,  4 Aug 2026 03:04:31 +0900
Message-ID: <20260803180439.1963864-5-den@valinux.co.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260803180439.1963864-1-den@valinux.co.jp>
References: <20260803180439.1963864-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYWP286CA0006.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:178::16) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|TYRP286MB5249:EE_
X-MS-Office365-Filtering-Correlation-Id: 67ea268b-923f-4198-648d-08def189b2f0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|23010399003|7416014|366016|1800799024|10070799003|921020|6133799003|10067099003|56012099006|5023799004|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	eky0Hz7SHyix72fsOeVwKbLi728NSO3mTY763riaa/zPgHqmOn0XyIf7G252N2Xz9HLV80gDvws2g9WX5LkZmPjEXGdzwDeyOOXJw3RMHCtvMJJTv4LfmLk6hobEAw+A1/e1hI7hLac6Y+Yxg8568jf/Mw9ZWKNoHiOr+Lsy3yL28fh+PSkfRUY+y8Sh6T02O8dXwDbkX9EWzFSv2qhIBig3h3Eg4sNZX/3JHcRTtDp9f9TzC6BeugIqWGfgLCfp2nxipvc/JaaEjtEsoZm5uWnmnsB9FvpCaSTMiLv34O/v9Ru79uOJ0C28VWBKs5RRrYTBAmb1U1jsh2CkXOMAicvjkJaaExFqm1d1Nvl2d/Sds34Gngu9Cm/kD5AqyWibg3AcNkUbYRy3b+ngiGxU+Q0hzE/jHBpUbR2NNwLkQokEoogQGPzgoZ59GjXpFqWqaciY7bwszHtUADma4I9sYllmNTMV91kPeITLQi0M5EmninjD7nxVZDxaViZ2cFVHviiupwzOgwwCu9cbnt2fHR/iFKnY0qB0PDP4P12rn1aU9/mtyXYBK4UvCe1dNRg598EbDTrVERO1kIQDCIqlKO+/QHxaShRe5a76S3ccpokfbCZ2ysRrWokrV2qgzRNlqA7+CfvdEhctsnTNsXGaBYK6cNZvdJTj5lZepP0cAabDUoO/FylqDsMBOjzohDSXbgnNrhm4DB7WCTSilpT8wg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(7416014)(366016)(1800799024)(10070799003)(921020)(6133799003)(10067099003)(56012099006)(5023799004)(22082099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?pCWS3SLZhD9kg1cwc4eVsSWMRAlb4iYpkj5O0KrltjON3RJ4jURZIjLPOZ8s?=
 =?us-ascii?Q?3GJdqCi8sR3Vq7j+kfT2n6zlaLtKJzYzgn2uiZ5bUmn5vYqhANE7F+C9QuzC?=
 =?us-ascii?Q?J5+HcQO1G8mWjv/lumZPUjb/GccYy/3b2uf2jxI8/OqZnFFWU9Wf8FnfvQhF?=
 =?us-ascii?Q?L+/rOkj3vR8Ppe5ftjUtNLIFA+oqxoG0d4fNSo7oSkF9tee9vZRMazoGQHmZ?=
 =?us-ascii?Q?aKqjQ372d+Upd8SMZdHJs6zGZ7/CcZKebqoQtCsdAC2+c9TRnLHhvntPj2S9?=
 =?us-ascii?Q?7i2VsPTh46xInlLz5GPUFTs7W6jH5Z6I6xEuldpCYWmnyaLrYkrq3U+96l13?=
 =?us-ascii?Q?BAWDpEPmURPC4lmibpHnkdb8CxVX8IYlOpPHIdVmy95Y4VjCClNWoh0UFBtr?=
 =?us-ascii?Q?lpu0USRz7bnJkwyEw8lF3f9ekE+1vzdReMfdGZ/lgjYddDAIs1XtsdY0zE/M?=
 =?us-ascii?Q?GA8H1DH2Smpl85aUhbMjyXRFOw4hKrIhRQoAs29k2dxEDWqfKCPPgM6AN0QS?=
 =?us-ascii?Q?trDOBwpu+bOKbU5y40yF6MTOVyg/LTUc9rN1+gfFytYVE2IIf8ZZGvoq1TB3?=
 =?us-ascii?Q?HX7/cUR4tWqN3bapRbmdfcs+mERUCDERcb0kisOQ+y0iBoCWIeCKfxO6K4Wl?=
 =?us-ascii?Q?8EfH4ylBfED1gK/oIYqM+zVFeAGzHVw/hV5l50mcPOWJeuwdyE49bdL9hR/S?=
 =?us-ascii?Q?eK31ODvcsBCf0F7ZADwAoym8nLoHiOmDWol1ojKmNfnYBmJhzzRZ57zQhsOh?=
 =?us-ascii?Q?1xYZNuQvCokcllR3RuYF+xG0kW2vppLNdTc/1MvpXtAfGDspTDEcrPrXAkH+?=
 =?us-ascii?Q?RSX1URd5jz5sNv2zq8aWAiBgYgcCfa2GzkHLROHkPRbfiC2b+PFdd5hFMIjN?=
 =?us-ascii?Q?E+8MZio3u0PLO+x1Fe2mSwodgITFjxRYUoaxI9JkxioIwoufX1TFmySELuuq?=
 =?us-ascii?Q?D8EA/oEyznXd2BfSwGqORhrhVB38CobTublzRZfGMOYYZAxS0FTV5wsbqQd8?=
 =?us-ascii?Q?ljdERQ88hcDEKYth84V7Zew3e8CQgsENKFSu0DuhPvZYca8w51DocU3aApTG?=
 =?us-ascii?Q?N36jnWlJQK6O2Ed8RwuwriY/o7xkKNrSNSDzgfONuIU1UuaVFW2pXYgpb7Vj?=
 =?us-ascii?Q?Y1Py0O9pjuyvR5g36ZyskYp9Pp2B6kmnR4bObLa6vHLvmSzvcakHz5DnjBCr?=
 =?us-ascii?Q?UR1oOsjh8uFP/6Bb6J+nJ2/wNlGhgNqWWvgaR264TLuBJCcTMG/zmwhHT17N?=
 =?us-ascii?Q?v9xZdp1iFwWukKojm519rIwdApW66ljfJBHqUbXAXWosD+EF4PuMLy7xEhx6?=
 =?us-ascii?Q?w8khyA+UDQah6wi1ccwfrADC9kWAct53q5OCi+kmQLuu8Kg8R2FZ/n1BM3sj?=
 =?us-ascii?Q?vHjY7gpC+7AHmmwPlhUKNwe5+8NjlHwn9pRCYZHzwRYULzQ9CwnxO/AyEwJt?=
 =?us-ascii?Q?MT10jGXzfTF3LSNYQWw5yMkU7sbktbL6zklXBxiriUnDG7+g7ft9XsMznilL?=
 =?us-ascii?Q?sTWWBMD3sPsr9HUPs2olYi6X7zqurqR+LOEkUlclciNN37QBSZqmQ0IPf3DU?=
 =?us-ascii?Q?Vco567r0Cq2gcEtje2MqPho3DXbBzbY8qfuJ/lFwI9RlmYWD1WAekFv7MLLo?=
 =?us-ascii?Q?nS6nRGicnYJ/Bh4PHHEJLwm5HsJkPSk2stqrxlMtgJYnYRaZSCwT3/ZxJm2Y?=
 =?us-ascii?Q?fr3ZHenTtrYgfqTYTAX6XhigNMTnk9J1u/Y/qWnzkXdQWoQAfAZXijxcuwlG?=
 =?us-ascii?Q?bVFKvXhnHhRwzwcaF7JoAu3lVzKaONzXyXF/ncPRxX0UyfKgnAMY?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 67ea268b-923f-4198-648d-08def189b2f0
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Aug 2026 18:04:44.8568
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oxb5inrges/s1fcS8Nltw6m3bdOvXvkWEJSrNzTGHPEVuDM3DL7j3ZA9UnMScxiFYNqVLYaaUm+J2bdsOTjC/Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYRP286MB5249

All RC-to-EP MWs in a packed group share one inbound BAR. Setting each
MW separately would keep replacing that BAR and could expose a partial
group.

Add group callbacks that program the shared BAR once for the complete
backing range. The EPC API has no operation to disable only the inbound
translation without also clearing the host-assigned BAR address. Keep
clear as a no-op, matching the existing per-MW behavior.

Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
 drivers/pci/endpoint/functions/pci-epf-vntb.c | 27 +++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/drivers/pci/endpoint/functions/pci-epf-vntb.c b/drivers/pci/endpoint/functions/pci-epf-vntb.c
index f22459e5a8c6..0c72b907c289 100644
--- a/drivers/pci/endpoint/functions/pci-epf-vntb.c
+++ b/drivers/pci/endpoint/functions/pci-epf-vntb.c
@@ -1622,6 +1622,31 @@ static int vntb_epf_mw_clear_trans(struct ntb_dev *ntb, int pidx, int idx)
 	return 0;
 }
 
+static int
+vntb_epf_mw_set_trans_group(struct ntb_dev *ndev, int pidx, int widx,
+			    dma_addr_t addr, resource_size_t size)
+{
+	struct epf_ntb *ntb = ntb_ndev(ndev);
+	struct pci_epf_bar *epf_bar;
+
+	if (pidx != NTB_DEF_PEER_IDX || !ntb->packed_mws || widx)
+		return -EINVAL;
+	if (!IS_ALIGNED(addr, SZ_4K) || size != ntb->mws_size[0])
+		return -EINVAL;
+
+	epf_bar = &ntb->epf->bar[ntb->mw_layout[0].barno];
+	epf_bar->phys_addr = addr;
+
+	return pci_epc_set_bar(ntb->epf->epc, ntb->epf->func_no,
+			       ntb->epf->vfunc_no, epf_bar);
+}
+
+static int vntb_epf_mw_clear_trans_group(struct ntb_dev *ndev, int pidx,
+					 int widx)
+{
+	return 0;
+}
+
 static int vntb_epf_peer_mw_get_addr(struct ntb_dev *ndev, int idx,
 				phys_addr_t *base, resource_size_t *size)
 {
@@ -1839,6 +1864,8 @@ static const struct ntb_dev_ops vntb_epf_ops = {
 	.db_vector_mask		= vntb_epf_db_vector_mask,
 	.db_set_mask		= vntb_epf_db_set_mask,
 	.mw_get_trans_group	= vntb_epf_mw_get_trans_group,
+	.mw_set_trans_group	= vntb_epf_mw_set_trans_group,
+	.mw_clear_trans_group	= vntb_epf_mw_clear_trans_group,
 	.mw_set_trans		= vntb_epf_mw_set_trans,
 	.mw_clear_trans		= vntb_epf_mw_clear_trans,
 	.peer_mw_get_addr	= vntb_epf_peer_mw_get_addr,
-- 
2.51.0

