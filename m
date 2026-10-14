Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013057.outbound.protection.outlook.com [52.101.83.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2AFE522F19;
	Wed, 14 Oct 2026 14:39:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791988790; cv=fail; b=VKQpBUnHiBWYwv60f9DSwu9cHcn+juaDNDOtnkpbZW4NHfowcmmqn/16OKY9nEUH5QimnA3ZYEgECvYJz5zLOi0his7nkpqBcwhs+cmE41Jw/NKwzujVhksvu1/JVjIQhsJCOkYQCZT5HJEFuGUktl0Zl0bnKJyODZF7Yrf7bbU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791988790; c=relaxed/simple;
	bh=RP/nGDzqqpFh4pR276Rnsj/IkMOcJDcNKDcBNLEz1qg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=SoB4wBM3UStkJCNgzltJEkZ10Nw8pF3Nu0pn6WOeSgBDJ93txmlVYC556JMssKkqz8uIFiSxG4WvlKR003wsIYlndhUO6sn9WotuB5B1H7cs1z9WDPtVImO/eO1HJoOfpPb40maJa+XRib1JEqT/Qv9CGj/Eht3z3GcBDazIMsQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=qNXKsvQH; arc=fail smtp.client-ip=52.101.83.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="qNXKsvQH"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=c+whu8PR7JXMqyLJiK7ZqnFSi4wadyUmroDJtXRqJLmrQGFTroPNRz/xZT9nFPFBABE7vdRLEB2G9Z3d2WOqXNxlZOiuomNT/lHMl8TwsnkKYHZKY348PVSsG6Gi3PT/YRSE1TPDaCEuj56bQQKXgb2QYoyWecmw6I+jcAKoCzP/rlojj/j+E/98Z9TYgz2EXgFXyBEP855IR8NxInuOv8YTrbzJql+Zbblql94pz2il6cYIDC9Zut66J3/4EaqFDqQmztjuEjRDX7+q//mOonxreUw91O47TrQCJkzfVSM/wzgv34mIdke0b9i/8eX2sjOpJOqf1HCXr0i4zKmf2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OJ/ZeTobdvk7D0LVVDSUGE3v55yuD9SseyX8BJipfRc=;
 b=JqBMkewC0JfyKtr3UlcnyUN5IMCVhx2nSAMzU/ynBFzqX7cy1O3A56gg5ehNHPw8kek/SZQWKBPaySw9IrAl0UyWQN4FZFz/pnvX50sBUwhX31uIfAa2uZ1fwt3bFy5QR2YKEUFE2e775pXeDXmUankhSfJ75fFnCN1igScvrmJT8OW2I3Oq4IXTXlYyEKpLOuyAtdRY57qNSQRGF8ddOSgxCo8BSe01sOaa5NHyer30QrTPqXipVXw56KEcHwrYMRpJWYss6YiN9pfWqKI9t9tsgXpX1HjhvMZpPDotqbUebSWk76k5eYhxvHuVLJjtTU955Y/6KEbvdLWCmwy5Pw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OJ/ZeTobdvk7D0LVVDSUGE3v55yuD9SseyX8BJipfRc=;
 b=qNXKsvQHrYUl8aySC5m5K01e/leelS5EjYXRHXFpcEDq5eHVZXJzcyjF8YPxeKtOV0yKRFRrxEWFPx4ldJ9hrkY/j1jYtY6Zg08Zqhjrph4Xsly+cqFR6WhVTknKWowBAmRK9i9vkAaS+zy9nKmPfz9HoFHw3rAG37q2P6db+wA4rfgc6mYXJ7jSFRREXBnLF8dSvO/PMqYNX2U+qW+9QqcAZPaTPoruTj2CKdwVDpo8XG70jGNVQ1M+gTus1O44T3mC71AAyEt1hVjZ5+ytbUMqo4A7ywH5kQ7RwAcsPexYz9OM/sxucYcA1oJIhHQvCaJE8r2M1yrLxMcMDbZqNg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9)
 by PA2PR04MB10445.eurprd04.prod.outlook.com (2603:10a6:102:41f::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.23; Wed, 14 Oct
 2026 14:39:44 +0000
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c]) by GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c%7]) with mapi id 15.21.0522.012; Wed, 14 Oct 2026
 14:39:44 +0000
Date: Wed, 14 Oct 2026 09:39:33 -0500
From: Frank Li <Frank.li@oss.nxp.com>
To: Koichiro Den <den@valinux.co.jp>
Cc: Manivannan Sadhasivam <mani@kernel.org>, Frank Li <Frank.Li@kernel.org>,
	Niklas Cassel <cassel@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>, Jon Mason <jdmason@kudzu.us>,
	Dave Jiang <dave.jiang@intel.com>, Allen Hubbe <allenbh@gmail.com>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>, ntb@lists.linux.dev,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] PCI: endpoint: pci-epf-vntb: Honor MSI-X selection
Message-ID: <as-UJX1jD8ZFiBxk@SMW015318>
References: <20261014053256.2378817-1-den@valinux.co.jp>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261014053256.2378817-1-den@valinux.co.jp>
X-ClientProxiedBy: CY5PR15CA0244.namprd15.prod.outlook.com
 (2603:10b6:930:66::17) To GV2PR04MB11799.eurprd04.prod.outlook.com
 (2603:10a6:150:2cf::9)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB11799:EE_|PA2PR04MB10445:EE_
X-MS-Office365-Filtering-Correlation-Id: 533b5d3f-f4d3-4dc8-0eed-08df2a00fc97
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|366016|1800799024|19092799006|23010399003|5023799004|56012099006|11063799006|261009223027099003|10067099003|18002099003|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	3XAcLSOu4uUHE93tckPdJIpuF3OYXQkX4h28KT5oOy1dOMQMcRR8XRcP5z92g75NvG86lP5EgEEkFC0DwWXmYdwV1c6p5hV/h5P5lhXXihAeA5VHFcbcGUxjkUW0AtUlNjwe/Af/KnDKwbX8VnuhZrKBKKn8ops+YrXraNLnThhisidIWGy2eegOde5tCsj+hovolZJKnQRLTVv4buYFr9DpQ4Qyq84y0iCg9ImVclnLnroBG656LmDwrWmmu4mJIn5w8uTlUTeNH4WpaEdWDVYKN9HThn06rPkA6qmCzMPfhYs89jaSXzSt5aFGJz0beS3eCbxjT3XsMWdAx10uxgKDVswVd6hjVVcHFkjvk9Wh35aZjxk/OuYSYPLzUJ/l0cJl8fyxbauw6BA8HgUveVXsULvjcYCJFCW0YQ0nh8Qwt6UooEzORaw9YIhz4nP8AQ8r99vVM5x6plkzKHAiTcgiOqaucJSQ9CXCxt/9eEdeU3PALKJF2io1PHpyQV+OZAKWEB90SZRnDaGOMaT7IEbK/Gdunb1fTrosC52IpOtr8TrYQIjPgcKS43Ym6L+JjL4ZKAgcNVAzpwjY5kjGSKAiaPs1vYBXHxVcgO7fnJG2Kkg4iq2YPw2eiY9yTphv
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11799.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(19092799006)(23010399003)(5023799004)(56012099006)(11063799006)(261009223027099003)(10067099003)(18002099003)(22082099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?IV9fmGfbe9eRJ2X3As2h9lqOgxCD7OnKHTEMeeQE7qHYlxz4qRAOuIpShHrr?=
 =?us-ascii?Q?EJDJWPkkDwV/pjF+DvhiQHh34EHzGn9/Kfc41yxGMEjTLTzQQAYzyQ7qA8i5?=
 =?us-ascii?Q?2zTfQ2OGeU88NZBpxRlBN3nmGNwdNPpqD3Bf/2Ikb+L4kXNmeNFtY9fpDrSk?=
 =?us-ascii?Q?ZhSMHUblQ9SdvmqInr0uxfTk9OfZaHrQrM74zD0WFxfNNp5bH4PtP455XJA6?=
 =?us-ascii?Q?HfvEOZC7ZWYs9WZIuoQNpR3fL2z194VmlR2nBDBg6IwzbYvLU7XIMAcLoPZt?=
 =?us-ascii?Q?MJHHeySEPn9pPjPp1i1qemj+C6MR/FPuKsrZNNojc6z/2wc8j1bnT03JVq7b?=
 =?us-ascii?Q?D8ExQFpaGedyzQ5qC8izZx+b2+tDXh2LZ1AunDl9SRfuUtlOZPiowfe0bq70?=
 =?us-ascii?Q?v8fuDTzlK4E6Kh8wko5xOXyiuGybxw6RvTbPT+0k8SBErDoypCqyiYmC6Ptk?=
 =?us-ascii?Q?aYU2ydFOPwOfv9yNwfSZlkMBXxGAKINiDg4eeq9WoKHDSqNjTjTiBIShDut2?=
 =?us-ascii?Q?p2H8BDWpzS7//HW/BJ4mXq+AwF9b2PYj1pmbBIqKG4FfIg8N/m0QYzxWw9eI?=
 =?us-ascii?Q?gbZLQ7Huuaw3igSr1UrrKBDOKQ/BUfX6Qc7QZ+DNBwM2IWXry04SKps41LZ4?=
 =?us-ascii?Q?8jZsaX/9j7Nu0B6pvcgNJKEswfxppvjvGUSP0WTB9Y3VorZ8KCjPzzKrpSLQ?=
 =?us-ascii?Q?dJi3hDjsO7qtBuIkYwRsVhf1x/aADjpu05irURFCMC1AOGIPFUh7f1Rru+5Q?=
 =?us-ascii?Q?wyoUp2U6fmMzkkoSQKhOP5TNwXvfA/QFln0Nsbkj03rnHmVioh/WsTmVuXmG?=
 =?us-ascii?Q?EaFdOehm/9aUkKnnBOQjS2Q3MsJdOins7w5HyLxGSmLhoEJfeD/Ev/5PRH0I?=
 =?us-ascii?Q?9vyz0RWTt0T8t3hLI/314/uFp38aok1B+VC9Eo1OFUGvZ5rPwDiY8XAR7UnL?=
 =?us-ascii?Q?0RTFrFW/Spf3ODXgeofNWsTwg6cc6+PfLWe6czP8QZR/d61ifvLhOeCh1xQh?=
 =?us-ascii?Q?jr0M7vw2EfneFAp8hB6yaN82jealHgPPu/gS8A/W81e3PlAmMONt2EgdMAaX?=
 =?us-ascii?Q?DMFW43kIwAPlguxY+ytn1ZG9Q5A467YmJE99ojoiO5n/uhhJUAMiVkC3uoRf?=
 =?us-ascii?Q?1TM7Dp6I9q8I35JBTAdOOK8dfl4wgtyPXLstrlvkpd8DaxnDP6RMydeT6nEh?=
 =?us-ascii?Q?YNrDeQP/XstlOd6Yupck8ttYQm8FyVWyHdUfgX77cYt8Y4cnNbuXsJDvbZba?=
 =?us-ascii?Q?W9jtmiUE3S6tVxHQOyeA01R/gBSxnhc44CRDZuyxsw00tiiBPQR1fgVp2p4J?=
 =?us-ascii?Q?ba/iESfVaoMTPxsmA/w9eOCXCyQ0waWYN/PKU//PXYYdUFH/k1XdI2n/DHUL?=
 =?us-ascii?Q?cD+ZCz873MxJPspnwVBtVXLw0Gu2L/osun3K/3d9ZWkqynQltH+PLlOI1PGZ?=
 =?us-ascii?Q?+gjd/lRP3mQqgNo+ftueOw4p1X5+u1yPUbZELlIZtAVI0Ga+fi1gnogmHyud?=
 =?us-ascii?Q?V1spHrvJCa2decgcber3xAujFc/YD9j8q41vk3FuLrZH6md42PlcF2fPzEJi?=
 =?us-ascii?Q?9O+4YESnR3vIVWjrMCz4kRCFW3azLjCjA0ErKDeLJ8QVQV1qfI0+xTHzET71?=
 =?us-ascii?Q?c2VvNonBMgI+dQrGrv6cZJA4Lc3nU8k3v7PNbqlFgmbLO3WiXOxJtiia/TnJ?=
 =?us-ascii?Q?As/zViXk3KFJNljpwVqVhExpzGiBEy54W9bRdLRI8B2uSqI5VUqfdTCG7+/A?=
 =?us-ascii?Q?rGRSyEDN3l0Ue0R00Y6PtJ1CK4hFtNXHU8maxhbIgzLkqhK1zTbn?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 533b5d3f-f4d3-4dc8-0eed-08df2a00fc97
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2026 14:39:43.9219
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8XpiGUlxj/mWRSulmBbijm1lYrpKiAHemgzmIR7A3TSAWJD79Cl+p5gLGcwhc5mfiI3ARF/CT2mfyDF+rq/AhOFiRcBLG+tZ3OrC+b2O7T4X3IdPkTBxjhuzVdA/DXEN
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA2PR04MB10445

On Wed, Oct 14, 2026 at 02:32:56PM +0900, Koichiro Den wrote:
> ntb_hw_epf tries MSI-X first and falls back to MSI. It reports the
> result in COMMAND_CONFIGURE_DOORBELL. pci-epf-vntb ignores MSIX_ENABLE,
> configures only MSI, and always raises peer doorbells with PCI_IRQ_MSI.
> When MSI-X is selected, the host does not program MSI, so raising it can
> issue a write to an invalid address. This was observed as IOMMU faults
> on the RC, with no doorbell interrupts delivered.
>
> Configure MSI-X when supported and use the selected type for peer
> doorbells. Allocate the MSI-X Table and PBA in the config BAR and
> configure db_count entries. Use this EPF-owned layout even if the EPC
> has fixed, hardware-owned Table/PBA regions, as pci-epf-test and
> nvmet-pci-epf already do.
>
> Fixes: e35f56bb0330 ("PCI: endpoint: Support NTB transfer between RC and EP")
> Signed-off-by: Koichiro Den <den@valinux.co.jp>
> ---
> Changes since v3:
>   - Reject MSI/MSI-X requests unsupported by the EPC. (Sashiko)
>   - Link to v3: https://lore.kernel.org/r/20260919172021.1055451-1-den@valinux.co.jp/
>
> Changes in v3:
>   - Split out the vNTB MSI-X fix and use an EPF-owned layout. (Niklas)
>     Niklas and I both hit an issue with hardware-owned MSI-X on RK3588:
>     https://lore.kernel.org/r/mmcripxdekhktnn73ikylthajkdnincwu7p2nelcpcqzexpf22@rrmmzr6hfvzf/
>   - Link to v2: https://lore.kernel.org/r/20260830151948.3547577-4-den@valinux.co.jp/
>
>  drivers/pci/endpoint/functions/pci-epf-vntb.c | 63 ++++++++++++++-----
>  1 file changed, 47 insertions(+), 16 deletions(-)
>
> diff --git a/drivers/pci/endpoint/functions/pci-epf-vntb.c b/drivers/pci/endpoint/functions/pci-epf-vntb.c
> index 07ba338732d4..c30a73c537a0 100644
> --- a/drivers/pci/endpoint/functions/pci-epf-vntb.c
> +++ b/drivers/pci/endpoint/functions/pci-epf-vntb.c
> @@ -148,6 +148,7 @@ struct epf_ntb {
>  	u16 vntb_vid;
>
>  	bool linkup;
> +	bool peer_msix;
>
>  	/*
>  	 * True when doorbells are interrupt-driven (MSI or embedded), false
> @@ -155,6 +156,7 @@ struct epf_ntb {
>  	 */
>  	bool msi_doorbell;
>  	u32 spad_size;
> +	u32 msix_table_offset;
>
>  	enum pci_barno epf_ntb_bar[VNTB_BAR_NUM];
>
> @@ -276,6 +278,7 @@ static void epf_ntb_teardown_mw(struct epf_ntb *ntb, u32 mw)
>   */
>  static void epf_ntb_cmd_handler(struct work_struct *work)
>  {
> +	const struct pci_epc_features *epc_features;
>  	struct epf_ntb_ctrl *ctrl;
>  	u32 command, argument;
>  	struct epf_ntb *ntb;
> @@ -308,6 +311,15 @@ static void epf_ntb_cmd_handler(struct work_struct *work)
>
>  	switch (command) {
>  	case COMMAND_CONFIGURE_DOORBELL:
> +		epc_features = pci_epc_get_features(ntb->epf->epc,
> +						    ntb->epf->func_no,
> +						    ntb->epf->vfunc_no);
> +		if (((argument & MSIX_ENABLE) && !epc_features->msix_capable) ||
> +		    (!(argument & MSIX_ENABLE) && !epc_features->msi_capable)) {
> +			ctrl->command_status = COMMAND_STATUS_ERROR;
> +			break;
> +		}
> +		ntb->peer_msix = argument & MSIX_ENABLE;
>  		ctrl->command_status = COMMAND_STATUS_OK;
>  		break;
>  	case COMMAND_TEARDOWN_DOORBELL:
> @@ -451,8 +463,9 @@ static void epf_ntb_config_spad_bar_free(struct epf_ntb *ntb)
>   * @ntb: NTB device that facilitates communication between HOST and VHOST
>   *
>   * Allocate the Local Memory mentioned in the above diagram. The size of
> - * CONFIG REGION is sizeof(struct epf_ntb_ctrl) and size of SCRATCHPAD REGION
> - * is obtained from "spad-count" configfs entry.
> + * CONFIG REGION is sizeof(struct epf_ntb_ctrl), plus space for the MSI-X
> + * Table and PBA if supported. The size of SCRATCHPAD REGION is obtained
> + * from "spad-count" configfs entry.
>   *
>   * Returns: Zero for success, or an error code in case of failure
>   */
> @@ -473,6 +486,12 @@ static int epf_ntb_config_spad_bar_alloc(struct epf_ntb *ntb)
>  	spad_count = ntb->spad_count;
>
>  	ctrl_size = ALIGN(sizeof(struct epf_ntb_ctrl), sizeof(u32));
> +	if (epc_features->msix_capable) {
> +		ntb->msix_table_offset = ALIGN(ctrl_size, 8);
> +		ctrl_size = ntb->msix_table_offset +
> +			    ntb->db_count * PCI_MSIX_ENTRY_SIZE +
> +			    BITS_TO_U64(ntb->db_count) * sizeof(u64);
> +	}
>  	spad_size = 2 * spad_count * sizeof(u32);
>
>  	base = pci_epf_alloc_space(epf, ctrl_size + spad_size,
> @@ -513,12 +532,14 @@ static int epf_ntb_config_spad_bar_alloc(struct epf_ntb *ntb)
>  static int epf_ntb_configure_interrupt(struct epf_ntb *ntb)
>  {
>  	const struct pci_epc_features *epc_features;
> +	struct pci_epf *epf = ntb->epf;
>  	struct device *dev;
>  	int ret;
>
> -	dev = &ntb->epf->dev;
> +	dev = &epf->dev;
>
> -	epc_features = pci_epc_get_features(ntb->epf->epc, ntb->epf->func_no, ntb->epf->vfunc_no);
> +	epc_features = pci_epc_get_features(epf->epc, epf->func_no,
> +					    epf->vfunc_no);
>
>  	if (!(epc_features->msix_capable || epc_features->msi_capable)) {
>  		dev_err(dev, "MSI or MSI-X is required for doorbell\n");
> @@ -532,16 +553,24 @@ static int epf_ntb_configure_interrupt(struct epf_ntb *ntb)
>  	}
>
>  	if (epc_features->msi_capable) {
> -		ret = pci_epc_set_msi(ntb->epf->epc,
> -				      ntb->epf->func_no,
> -				      ntb->epf->vfunc_no,
> -				      16);
> +		ret = pci_epc_set_msi(epf->epc, epf->func_no, epf->vfunc_no, 16);
>  		if (ret) {
>  			dev_err(dev, "MSI configuration failed\n");
>  			return ret;
>  		}
>  	}

This part belong code cleanup by local variable epf. Can you move this
part to prepare patch? Or pci_epc_set_msix() use ntb->epf->epc, then
replace all after this patch.

>
> +	if (epc_features->msix_capable) {
> +		ret = pci_epc_set_msix(epf->epc, epf->func_no, epf->vfunc_no,
> +				       ntb->db_count,
> +				       ntb->epf_ntb_bar[BAR_CONFIG],
> +				       ntb->msix_table_offset);
> +		if (ret) {
> +			dev_err(dev, "MSI-X configuration failed\n");
> +			return ret;
> +		}
> +	}
> +
>  	return 0;
>  }
>
> @@ -1529,6 +1558,7 @@ static void vntb_epf_peer_db_work(struct work_struct *work)
>  	struct epf_ntb *ntb = container_of(work, struct epf_ntb, peer_db_work);
>  	struct pci_epf *epf = ntb->epf;
>  	unsigned int budget = VNTB_PEER_DB_WORK_BUDGET;
> +	unsigned int irq_type;
>  	u8 func_no, vfunc_no;
>  	unsigned int db_bit;
>  	u32 interrupt_num;
> @@ -1540,6 +1570,7 @@ static void vntb_epf_peer_db_work(struct work_struct *work)
>
>  	func_no = epf->func_no;
>  	vfunc_no = epf->vfunc_no;
> +	irq_type = ntb->peer_msix ? PCI_IRQ_MSIX : PCI_IRQ_MSI;
>
>  	/*
>  	 * Drain doorbells from peer_db_pending in snapshots (atomic64_xchg()).
> @@ -1553,16 +1584,16 @@ static void vntb_epf_peer_db_work(struct work_struct *work)
>
>  		while (db_bits) {
>  			/*
> -			 * pci_epc_raise_irq() for MSI expects a 1-based
> -			 * interrupt number. The first usable doorbell starts
> -			 * at EPF_IRQ_DB_START in the legacy slot layout.
> +			 * pci_epc_raise_irq() expects a 1-based interrupt
> +			 * number for MSI and MSI-X. The first usable doorbell
> +			 * starts at EPF_IRQ_DB_START in the legacy slot layout.
>  			 *
>  			 * Legacy mapping (kept for compatibility):
>  			 *
> -			 *   MSI #1 : link event (reserved)
> -			 *   MSI #2 : unused (historical offset)
> -			 *   MSI #3 : doorbell bit 0 (DB#0)
> -			 *   MSI #4 : doorbell bit 1 (DB#1)
> +			 *   IRQ #1 : link event (reserved)
> +			 *   IRQ #2 : unused (historical offset)
> +			 *   IRQ #3 : doorbell bit 0 (DB#0)
> +			 *   IRQ #4 : doorbell bit 1 (DB#1)
>  			 *   ...

Needn't update these comments,  the key information is #n, there are not
big difference between MSI and IRQ.

Frank

>  			 *
>  			 * Do not change this mapping to avoid breaking
> @@ -1573,7 +1604,7 @@ static void vntb_epf_peer_db_work(struct work_struct *work)
>  			db_bits &= ~BIT_ULL(db_bit);
>
>  			ret = pci_epc_raise_irq(epf->epc, func_no, vfunc_no,
> -						PCI_IRQ_MSI, interrupt_num);
> +						irq_type, interrupt_num);
>  			if (ret)
>  				dev_err(&epf->dev,
>  					"Failed to raise IRQ for interrupt_num %u: %d\n",
>
> base-commit: 5cdbd6d3a3a147fa9975e35f2602cbec9a72a932
> --
> 2.54.0
>
