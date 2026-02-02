Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazon11020128.outbound.protection.outlook.com [52.101.229.128])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B25C37472D;
	Mon,  2 Feb 2026 14:54:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.229.128
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770044059; cv=fail; b=EKYGGGk6IT7+evXDbnmWJT6bMM0T6OzYiQ3pBG+jnKFVckPfDGgiO20Z47ur0oWZrYgw8U03/Lz3Cw0dQOCGcJSVl8HlAwfyasakKQ3m4PTjr00UgUrPPqG4I+0K8wbXsRdPpDSLHBpqDJlrwGwl4ebymXbhpMMGoJW8aT8rkt8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770044059; c=relaxed/simple;
	bh=r7SsTH7HX9+moUlX6s5BOvcRCclyeKM1P+rJX+GIFks=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=WWZCvX5rZCRMa9qeeOjdNTT+LN0TeJc4FEcb6Zi+YepCTvi40RDObNQpolUgtWRH0SSk8dYwFozb/w6KqqegwwkFsIH4dkZFFgsHHYyV5ROi9T/5aEBvJjA/0vXBrYN7cSwD2qhgYdpTIE9chfhvqcSnUj1NYXH0njaXXyamJ9I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=Z+95Y62G; arc=fail smtp.client-ip=52.101.229.128
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="Z+95Y62G"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mXa7HsCXaTJ80fFTtHW53598eHny2B7mIB08BiLJeUxm5fuV3KVGAGudlPHFS7+HyBkNImERk/lTSZ2pqs5HR9f3gD6hFeaNwa8T2CNrdQBs2JK42cg1CtdRXEYQq5Mui3OxwnzliK+z6khwtgGQqYSuSpn+cNlcKUCcANQlHblaTsAvPynott4kHJo1GIj+4wloF8RU5bCng/wEtb6UbZ9eT2HTlp9uE543du68JInqNhBLmId+6G4D1rDtLZLJqjy6w0jA6Nqr7Wz8i8ESUIpViOqVtlNi7P88l+7YUfTjHAGhtKGGfRwNI63OEXS6/9aUYbA2i8Si4Nb/b2T7gQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=myfWSvjvbUQ1WyQRdDNcmljcaZVqPv4q0vybl6Z1Grc=;
 b=PRS1+JazAxRxVQW0o9TSxxtbdlOwTUq4gmO3WVrie0XvLKy31Vu2xgFa1vE8lYD++6LwxBWZC2FI4XbGxYncd9Q49e2elIfCebtpWgQ2Ow9mXkmSflNb+THynfcHyXDkJMBp+Ep8FcvPFLhBQPUUspP+QSbGWxtLa9WLn5c9UjYP38s8wXMo9fY4h9riV6tk7J0utv9Ex+KQ3Dw64l70/kUVcoV54lzrnaWQl6NtBOZ7DJCbLW3VSjHqi3rogewm6pZ5RKXq7BDLDCRdhot3lJNJkAQnih1W0PlQnXB1GOclU+qNSKBT+ADxpS4G8/VhBuX4uQjYC4VdXDiHOul8bw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=myfWSvjvbUQ1WyQRdDNcmljcaZVqPv4q0vybl6Z1Grc=;
 b=Z+95Y62GVqKom9yRorBoGregChLPQXOe3/91mRyoZJ04sjYBzL62BSqZO+5Zqj7wCaTPbjulR9VM01HVEK45a0AFaWJa7g0bDsX1LkAYHXX8zhkPD+DnZVuHBSb9pFVroWRV+08FJs6arIT+CyAPClQebJIfzGFUtMeccZ5yEuA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by TYCP286MB2195.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:15d::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.15; Mon, 2 Feb
 2026 14:54:12 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%5]) with mapi id 15.20.9564.016; Mon, 2 Feb 2026
 14:54:12 +0000
From: Koichiro Den <den@valinux.co.jp>
To: mani@kernel.org,
	cassel@kernel.org,
	kwilczynski@kernel.org,
	kishon@kernel.org,
	bhelgaas@google.com,
	corbet@lwn.net,
	jingoohan1@gmail.com,
	lpieralisi@kernel.org,
	robh@kernel.org,
	Frank.Li@nxp.com
Cc: linux-pci@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/2] PCI: dwc: ep: Always clear IB maps on BAR update
Date: Mon,  2 Feb 2026 23:54:07 +0900
Message-ID: <20260202145407.503348-3-den@valinux.co.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260202145407.503348-1-den@valinux.co.jp>
References: <20260202145407.503348-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYXPR01CA0044.jpnprd01.prod.outlook.com
 (2603:1096:403:a::14) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|TYCP286MB2195:EE_
X-MS-Office365-Filtering-Correlation-Id: ab330635-e323-4abb-8181-08de626aeda4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|366016|1800799024|10070799003|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?s/ZlPKumhJCgOAQcSMH/tP+ccuiHADx1PaWTHCYmmFbTSjiSbyUV7JCMCVLH?=
 =?us-ascii?Q?DKsWRPdVJSEVL7aq0XT53QQupEtCZFFZW9Wnh1Nn9KCkT/ruAv95nEYCLSUb?=
 =?us-ascii?Q?AkbyfNWd9Rv9P3EckakWlBobeaNzycN7GShCIUI9IS/X4janr5Qdvi4CzlmP?=
 =?us-ascii?Q?+41detbk8B6I2/n3FbOhGASFwtt78zT3v0lK9Amm+W5EoGJA/0Tu9v6XmFKz?=
 =?us-ascii?Q?9c+Ll3spECVJA5R+8Q/VPXpFUWhbUBEhOnNlgqsAioMfC1g2Dc3w9oQqL/mw?=
 =?us-ascii?Q?ryk3e3LYNxW6gFSXaJaguKuT+F0aBr+FECetzAP/jFBMNtMmpGNajlHd/y8v?=
 =?us-ascii?Q?1C4AhEge+eMCqImUL298tsq4K+AcfSoW2ogPc7Nj1N7pZeEf4kTlpYJBPUmm?=
 =?us-ascii?Q?kai1e+fsjflP0swczeCzPE4To8VpmFHeC+zT/RGO+L13xc63Eaxx5WhZxJ+/?=
 =?us-ascii?Q?8aoL+cnS6bUic8ok5qjM/bncE7WMVkjiJAGjQpVuB6I6JWVpOEitn7iudipP?=
 =?us-ascii?Q?l+W1XVlwlVD7USRq62POVNzJBb//3HtIl6w4Oco+fA3TAJuA+ji4BDOA58qF?=
 =?us-ascii?Q?hpBqG6yU8vFSBOsbV7ITwv1uZBwCAI70enep2nI/AxuEqUt4bIyq3F1gMLuw?=
 =?us-ascii?Q?inoJBeO0B+747gBZblmiKW1Gyu0fyfu+7POfwU6epiK3tqmzg1jYaLJxPxWB?=
 =?us-ascii?Q?/Z7Zk2ZFZ9FmwgFDXsC1WcN0MBmuPkSx22PRbqj4PfjnPMLPbs629WoRY+lB?=
 =?us-ascii?Q?4S1M7MioOkEqN9W/y7P0UBByhI8qraakaLxpB2UCAudOJq2fPCvjJq1W3gKR?=
 =?us-ascii?Q?0UIBkV/nMtNroeU8LWxVI2vywP3Wr1JaiilvQmA967NCjfH2DtV365zX7tAh?=
 =?us-ascii?Q?qYNNVqZYpvUVdlQ+LAiOpeYJKXAjyXpVKTL+TQQbIN4oRm3wJLrqT6/wxvqg?=
 =?us-ascii?Q?3KoFhJG5Y2H3qkezwvi6i1Q208BcvZGytCJI8mRBsFxdExLjOH664Ui85+nH?=
 =?us-ascii?Q?avR0LB0TyKoZrNBx5aJ/TfwfKZ9clqkNyrnZ32VOSEb7aLt38GqRpkHOkCxh?=
 =?us-ascii?Q?IO2ihxXVaVP8v0U/IHbxAgtKB5evfAPOSGSU7e44hHBn99E4Um6CvG0+B9Tj?=
 =?us-ascii?Q?n3FuQ/bZoC/SCIdtt3J5c+2vd3XpBzkd8VGovncEidk9HGc4oXCxhajgHdcI?=
 =?us-ascii?Q?Z1h+pwKNvErr3Eqe13wtOXlLx7SQReTu+eOCorlY+kzAWiii/CK1v9d3CO6e?=
 =?us-ascii?Q?j8IF64H3UD54v4zqIBaMtCsAytpQzYo4hqyw68Ml0gdQfMJM0lnQC/vdEhVs?=
 =?us-ascii?Q?uN7b82lZhTTIqJTbUZJqpkHy+KMgHWGiZD+vRC1W4IVggLOdAoVwL6PWrwfs?=
 =?us-ascii?Q?SWiq++IO8gBjFcC9xUSkp6za+k6+LVCtpY3CrP+6Qb0h+t5dKoRhb7Y61Hai?=
 =?us-ascii?Q?s0aTjPfNx51MWLnrN7Wj0cfqwP+K4QWAUsmozt6jzBMuY+CLLgTe8zaXvnCL?=
 =?us-ascii?Q?/X1lvEklsPcarU+0+47YyfzpQ5JoeJSShxGRu9vNORjJnFs6W+UVAOjWMsAl?=
 =?us-ascii?Q?5NWgxXLaMJZmq1e2MVubSynyS53u03OeHXn8TW80Bx+nMc5QRFb9y81MBCqe?=
 =?us-ascii?Q?1w=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(10070799003)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?kFaiznd6hfPXWb1SbD6J61hhBHpLC4GbfNN7SLuTA7AKvaT6wdRTFXjWiFOS?=
 =?us-ascii?Q?qvABXqdnZuwDqb2prUDxReChGCamlKJt/8F3ntTEESUyp90DS1mOMocnaqZF?=
 =?us-ascii?Q?6a6Bwfb5me1KugijoWxuWWvNkWLQyeT9dahBzhMaj/Hl+W4i7GtpIAjLgOKM?=
 =?us-ascii?Q?vuZKrQCa2YfdZmkjhGIW311+9HBlqRgkiSz2+/8mswIYMexeq0YqdsgblmqH?=
 =?us-ascii?Q?uShE6ynY7s1Q6gbtfNV0/ENEUVBpghqGAQ5lSRz2cMonFeiYP/ok391VzB7s?=
 =?us-ascii?Q?BMYqIWtgzeIdrtVeHO9O6zvQvG8MC7kKc3sDgP3BZUTuJgx3lTsDUAp+MBzA?=
 =?us-ascii?Q?rB2vAXUyh/gu9rEu0YvUe086a8KR+wCQCD6oj/AStPa5mvvBwSeskd6Knw9d?=
 =?us-ascii?Q?OIX6z13cR1RcJIBwpZOUYNryp0KR7DU7wKgzNHayTCpPZC39VUavozCWHTEk?=
 =?us-ascii?Q?ks9CuG3PaRF51kPCQncfyoQUVIdJJwomQfqgZ3PjOmAqD6oc6yGgio67pb4h?=
 =?us-ascii?Q?yxqe/gyJlZufZI0mv7e9qjz/y8R9iL2+jWC3136buSVCUT3WJCE9gIVTByEW?=
 =?us-ascii?Q?pTA/HEWG5ZD3hiynPW6f3G2q9B39eOGiytFwfyUTv8PRSt1nG43klQf2Xg6g?=
 =?us-ascii?Q?BTEeEzfe0I/QEhTRnF2+KTP7SjFlhfpO3sbQLVAkURXy3z94DsUJo1RJgTLN?=
 =?us-ascii?Q?eMyPoLy0LgVZiwOfb475pgvEk08PT/q7VTSKMuCtYE976rBKprfjj/Iniuyc?=
 =?us-ascii?Q?A6azXgeRCsRN9l8Irgdm7zYcCAf5cIROxs+us9HrvenlcEjW3jFADlMc/cvj?=
 =?us-ascii?Q?UB6hAyrOOucKqm0lUwNcXdYilIzKBDRwODE7TxOCx7PnOYPcQxCHWFPSjWPY?=
 =?us-ascii?Q?HhdI7pS6vm5UF/1qC6XQC0ZCLdc82pwCpsdWynImiXz0GaO8vDyy8w3AMEWX?=
 =?us-ascii?Q?jVe/TB/HflYbO3AgIqzMWhlzUrymP+Sbw2qo+bfpBgoGU1MCsaB2WIW0UNzs?=
 =?us-ascii?Q?4Rm90JGsOElrllpTYOKjwrNIeDUIeWKb2OZyBwHffzwUWVAqaJ8foqIXD8Jj?=
 =?us-ascii?Q?oFsp3j9mHyEOhTXmRNIG5PBMa3lkiG15HvRqhIMicgIfE6w19+uf75NAI8/i?=
 =?us-ascii?Q?KWqyQzCR1XuzPrKIIdBw/eub2r7X1hkmrzFd6OOwAm1KT6rtP0VQ6bHXpgt7?=
 =?us-ascii?Q?8I+NkDks84XOuVcKb8nXGziuXe/ROKKri+bcSrG5U9swExL5m0HnHUe4OiBn?=
 =?us-ascii?Q?hAeccCBQDMzp+68YWKicMiksXIbi6KYUqApcTQ7VUhlUqezsLIn5MWPG8+04?=
 =?us-ascii?Q?mjzjGGXAKNyb0Xfi8JGMo3e4LcY/XeRCK5mK2OWweSd+rAAtuV6NvlxE1paV?=
 =?us-ascii?Q?3okSKnzS4O60bW4xzfy3qBdzvsIImhtUEN0e2PYdAY5/cP6Sopo0XybCGfce?=
 =?us-ascii?Q?BNZ5FdDY3A8NhiNQWK7SWLtPybuY1cp0toI6SlJQzFAQQiamBJ4KIGeIHHEr?=
 =?us-ascii?Q?obMBfVK56giP8JbW6iUuLP2EGLBa6pl5igg4gLeSpxv/WfRHkSrffjSfHNXn?=
 =?us-ascii?Q?mg8FIG8lN1/jzrOjb5BwPX5nNxfCpwfY8zfIPaUL5m5czBoEQC2P2WZQ2z2W?=
 =?us-ascii?Q?7kFPQ1P3jAigs2tS8wouhHLZf5hnYHf0Vmiq8Yh2BWJHluVp2E6MTZhTPntF?=
 =?us-ascii?Q?5Kctqu7XrvCl4Iy66gEa873cFUaldcb9XABI0ZgOTj9EtVgnf6pJINDiHebp?=
 =?us-ascii?Q?jHLT+Cc15aP0riGSiW6m0HN8XI2x2XHnitAo3Q7JVdDEPP41gJBE?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: ab330635-e323-4abb-8181-08de626aeda4
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Feb 2026 14:54:12.6741
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OAtR3pI2CffkkFiBNH66XsZKaXTo514TVi74pLN87EJ5OvOyRNSakDaMkISAibzhoONyEHD2kdP3NQNGZO9YRQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCP286MB2195

dw_pcie_ep_set_bar() currently tears down existing inbound mappings only
when either the previous or the new struct pci_epf_bar uses submaps
(num_submap != 0). If both the old and new mappings are BAR Match Mode,
reprogramming the same ATU index is sufficient, so no explicit teardown
was needed.

However, some callers may reuse the same struct pci_epf_bar instance and
update it in place before calling set_bar() again. In that case
ep_func->epf_bar[bar] and the passed-in epf_bar can point to the same
object, so we cannot reliably distinguish BAR Match Mode -> BAR Match Mode
from Address Match Mode -> BAR Match Mode. As a result, the conditional
teardown based on num_submap becomes unreliable and existing inbound maps
may be left active.

Call dw_pcie_ep_clear_ib_maps() unconditionally before reprogramming the
BAR so that in-place updates are handled correctly.

This introduces a behavioral change in a corner case: if a BAR
reprogramming attempt fails (especially for the long-standing BAR Match
Mode -> BAR Match Mode update case), the previously programmed inbound
mapping will already have been torn down. This should be acceptable,
since the caller observes the error and should not use the BAR for any
real transactions in that case.

While at it, document that the existing update parameter check is
best-effort for in-place updates.

Fixes: cc839bef7727 ("PCI: dwc: ep: Support BAR subrange inbound mapping via Address Match Mode iATU")
Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
 drivers/pci/controller/dwc/pcie-designware-ep.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c b/drivers/pci/controller/dwc/pcie-designware-ep.c
index 0ca05943a1e5..295076cf70de 100644
--- a/drivers/pci/controller/dwc/pcie-designware-ep.c
+++ b/drivers/pci/controller/dwc/pcie-designware-ep.c
@@ -519,6 +519,12 @@ static int dw_pcie_ep_set_bar(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
 		/*
 		 * We can only dynamically change a BAR if the new BAR size and
 		 * BAR flags do not differ from the existing configuration.
+		 *
+		 * Note: this safety check only works when the caller uses
+		 * a new struct pci_epf_bar in the second set_bar() call.
+		 * If the same instance is updated in place and passed in,
+		 * we cannot reliably detect invalid barno/size/flags
+		 * changes here.
 		 */
 		if (ep_func->epf_bar[bar]->barno != bar ||
 		    ep_func->epf_bar[bar]->size != size ||
@@ -527,10 +533,12 @@ static int dw_pcie_ep_set_bar(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
 
 		/*
 		 * When dynamically changing a BAR, tear down any existing
-		 * mappings before re-programming.
+		 * mappings before re-programming. This is redundant when
+		 * both the old and new mappings are BAR Match Mode, but
+		 * required to handle in-place updates and match-mode
+		 * changes reliably.
 		 */
-		if (ep_func->epf_bar[bar]->num_submap || epf_bar->num_submap)
-			dw_pcie_ep_clear_ib_maps(ep, func_no, bar);
+		dw_pcie_ep_clear_ib_maps(ep, func_no, bar);
 
 		/*
 		 * When dynamically changing a BAR, skip writing the BAR reg, as
-- 
2.51.0

