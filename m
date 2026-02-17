Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013055.outbound.protection.outlook.com [40.107.159.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7ABD36BCC0;
	Tue, 17 Feb 2026 16:43:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771346604; cv=fail; b=ap0Z2eiw6bD0vcWYuNtmDGlh3Yyh5JwLsEKW3HEipr9tGHbnjT2bzIFvAf4261KOvefaecqsbpMjJ/gL3t/a9xgAAsV7q59QJvPskByoqInyCg1t1sh/X1UbFfko87iWOtT+4oQx2USV1KvKGcmLmrtzl+D/rkaLqMGzg9ZYF7Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771346604; c=relaxed/simple;
	bh=lHXkNtC7Mm7p3AVpvKgrXR5I/RlQxb+FmJraYihUpJU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=MW735qjGJf2XC2xvx17Bt3A6wFc0L2ROdnlAym5DdZ++zfSD+XvKtFqFqFM+rYNQI/7MVx1+c6+Yk3A8JRlnG2VEv1F3jH7KCvtftgmW/VgNK1sXVpNLTbfC6UWpZbSWDF4zdZtfyK43ibmcxYaZZb/6aloynA5D0bEZQfmfOHw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=LAUPLqVh; arc=fail smtp.client-ip=40.107.159.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="LAUPLqVh"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=H0KgGk/iAQOSGJ4HtyWIH7hE2JZnUH3/inUWYTORRM1U5b37OY3vB/8EbsdTmcFeJU2jXafgCsp+mv7Vf5h0Yy1GkMdjNFMIuxL2Tu800h8zT6IAsDJgYO9UfKOK3MAMvyIOncxj7WeoqvZf955LT3RIFakSEUY0Mf8NmiYvPm8srFVZoutpcSYtjYaKkVf3Oo9TJ+vFUk3reYIvHhTydwfyu87W+dA+nSlq6NghnFVXiYJnEaPN3E6WBbFo/HT+6ItDKd6q5ZSDOgA8dt1xASgxyjbzanKCb6XWi7tRpoP59BmMIilOxedfodrSmdhnbsoIZVKFm5UrKcOw1O+Y+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ywb5PJTUq5yA3zfq6NqtUfFaWNPIMhF/ZD1Sd1KDL9A=;
 b=SQxo08+N6tU839T/9jdqlJ5dz/jsWHlZcK4QnDsggKXgm9hHyhxerjNo4wndkG4MdGhRJ08WcQwhaqCRQPTB5y4dw2Ht42roEFGh/szVkegI4krbB04KDxZNB8k6hzXGOt3LbHz9r7NWZgE/HzNW2FK4aQhnIjU7h5WBUv+jEWdBfwC3XztFwdiWkKwIKtGNMfCytW/ZSDoXcJ7Kx4261zUSQU8gEVxVVvuY1Xjf+kZigm1CL2V5xI+RikT2tPS/G1lxopgK9Z+/GDxiKKwZobgjx11FcyvkAv4ykqUsPIjiHlbo6CDmy0lyc5+K+xTABlp8/k0YOMEt6SCBcAVYuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ywb5PJTUq5yA3zfq6NqtUfFaWNPIMhF/ZD1Sd1KDL9A=;
 b=LAUPLqVhoJbVEdKAQC5YfoWpfbYqy1uGs5gKHtqJhIrEd7giiT7o80dQRcX+du6Pk/qLoLlBeBeD/izoy0G1MaqluizzbEkqc2KGQtNTiqSeTMhl6eD6dtXmN8ukYs8djB5Sii+6RIPMePt1NPFs0Jn/KVajM+Uw0stMGzbBPBXVoYxny2YQFpDhxliZAdKr63hTjfIgMKz+yrSouus6feKf089ounvOdIfotGNtfOpkAYZiHvfK9uNpRYY2/NOFFpK4JK5xSXl+BL0j91RXBDqSGzM0WYbXOzAjjt/MVjm7U/vr7UfYFagiT000bsWYMJnXL46UDj/QJYcaSn6Fiw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com (2603:10a6:102:2a9::8)
 by PAXPR04MB8557.eurprd04.prod.outlook.com (2603:10a6:102:214::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.13; Tue, 17 Feb
 2026 16:43:19 +0000
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588]) by PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588%6]) with mapi id 15.20.9611.013; Tue, 17 Feb 2026
 16:43:19 +0000
Date: Tue, 17 Feb 2026 11:43:10 -0500
From: Frank Li <Frank.li@nxp.com>
To: Koichiro Den <den@valinux.co.jp>
Cc: jingoohan1@gmail.com, mani@kernel.org, lpieralisi@kernel.org,
	kwilczynski@kernel.org, robh@kernel.org, bhelgaas@google.com,
	heiko@sntech.de, kishon@kernel.org, jdmason@kudzu.us,
	dave.jiang@intel.com, allenbh@gmail.com, cassel@kernel.org,
	shawn.lin@rock-chips.com, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org, ntb@lists.linux.dev
Subject: Re: [PATCH v8 6/9] PCI: endpoint: pci-ep-msi: Refactor doorbell
 allocation for new backends
Message-ID: <aZSantK-I2pFAJ9d@lizhi-Precision-Tower-5810>
References: <20260217080601.3808847-1-den@valinux.co.jp>
 <20260217080601.3808847-7-den@valinux.co.jp>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260217080601.3808847-7-den@valinux.co.jp>
X-ClientProxiedBy: PH8PR05CA0007.namprd05.prod.outlook.com
 (2603:10b6:510:2cc::18) To PA4PR04MB9366.eurprd04.prod.outlook.com
 (2603:10a6:102:2a9::8)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB9366:EE_|PAXPR04MB8557:EE_
X-MS-Office365-Filtering-Correlation-Id: edc4ec08-e5b3-4783-ca19-08de6e43a787
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|52116014|1800799024|19092799006|7053199007|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?gjaDfYvSOLyZW7WDW8lRhTxX4g987lLCy3x0VAhfrQrQgs84UwQQvK9Howxa?=
 =?us-ascii?Q?HCAJ4ttuBw/IE9R2/Z+Q4UJ9n8xeHf3ii03k/U5/gSTFwY/VjQpda8RRgNq5?=
 =?us-ascii?Q?K/rW7YKEPXEoKXTrNtTNhGiypVSxgYH9Do+DJ+pMLRpMi4bijecE6eG70hzF?=
 =?us-ascii?Q?2Ok92VSU7I/o2Mm7Jg+INmzVoOFzFwFVeGQ5r9wWwy7G6TYq/9BA8uoN2Rab?=
 =?us-ascii?Q?RZuf0yb7mhj3/Qkf32pEHVFiSjuGVYxfYQJ4M7g/d5CD4rVIrCXhZe6t+EDO?=
 =?us-ascii?Q?OPQDJLmNucg6I3aSVMPDf+SEMAzIKZjAyE7I9X3sxotJ2DumD4qIv6N8Nagy?=
 =?us-ascii?Q?Fb1Re+SAtBsUtQ4fHBP7a8/4phgFltabn+e2AX9fTuV/fiXXI9BsFIKQzb3H?=
 =?us-ascii?Q?KJVL5vCgILRUiEj+3/RhJglWfJHRJiHyROoqxLh163P+UdW1rdnrWWgRWtWH?=
 =?us-ascii?Q?WV21GztCWsaH+FzXrw/kczxj3wwbCM9LqHBmh7Jdqp7ckHqzM+J7vq23qdCp?=
 =?us-ascii?Q?WA7PpphOsUTb492Hz71bs7k7SBVcsWZawwoM8MPUGXP6AHQVa8+OQwWdUte8?=
 =?us-ascii?Q?FehElgOZflqC9mEFpJAgUz+5S+Us7BFwdAb1D6a79guYY6YCcY+Wd/Wv8HJP?=
 =?us-ascii?Q?jUYd8ntU9BfAf+e4iqT5kzyIWyr+YKxzuZdGHXhsaNIFJaxs0wFdk/3FbTsI?=
 =?us-ascii?Q?h0WdOAaX0R5gPxyLu0BTUDy1EpljK+iCFk7MAExZXhVILsNCemFz50XdS9TI?=
 =?us-ascii?Q?1JDUORI0A5ZmldOiD292EAtVbUe1yp7kOwdXE68LtOPzx0zyUXN2iKes8DOW?=
 =?us-ascii?Q?i4kxDb0aL/TF1N6yhbL5Y9XXtjDUS958trdKliUWLqi7J+wk91eeqxdUMy0a?=
 =?us-ascii?Q?74jIkvzyE5c7miKeQoM+A8a6LRdZzzeSt/e/IjrpLMK4+jafassH9NJ8ZYrh?=
 =?us-ascii?Q?Mo06ihpz+bD34MbLuuXHAO2KpLhRXwDlQpGyTYBFgJARFgicJPo2rxz8k04N?=
 =?us-ascii?Q?rWVLEjYLsr5RH3hpuMP64T5m75rrfdNMogjbZAJl8YLqjhllUPfGicmmUZZR?=
 =?us-ascii?Q?EpTK0rVbMG+JRp9d9YmOIRA1QlHOErxiLO3H3clEzf8TBQZ6gdFLudRT7RSm?=
 =?us-ascii?Q?rBSMgHeB3ovDFVhpZciGkdZ5It8vZam4S33IKCZTYbFbLYfngoWwrF0bCVDP?=
 =?us-ascii?Q?CN3vUrkHFOVi3y52jeSeyXebLAb9pJjRH3h/rVmL/tJjrhzcUuT4IHFIZz8L?=
 =?us-ascii?Q?ObJ8HOZr9EwNaM1uPrIxjkAk1teOjcf4aOsNV3wEPVnJy9gSl/4NYhi4cJTN?=
 =?us-ascii?Q?NdKNKIhNYFeS+p1IOtI+tK0+ICiupyNAOCARlwLRs6lv0uxXHuFOXpkePZCX?=
 =?us-ascii?Q?seevF/vkZKB/aRvZYuPw8iE9scAMpLU6vC+/YkOUlBSs0q+dHE/GSS9FaiRL?=
 =?us-ascii?Q?xi/S+jb93rQk0kl7nJ5Bl/PE+VjEMnW+6mmELhNitfGTKlx7APIuERkRGvwt?=
 =?us-ascii?Q?wShv0GeR/28QidGWEZJ91WaLWI78cBbvXwE5iB10fDVC5H5TXvQ0kMI20L2h?=
 =?us-ascii?Q?2aR6VaAJrwSbTwhxiN+Wx+l9uvAvmfW3qhT8Aid1HTniFeRQHJxultpD9yk0?=
 =?us-ascii?Q?jNHaC3sJNOut7Hvw+hoTqQc=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9366.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(52116014)(1800799024)(19092799006)(7053199007)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?iAXSIziDFBOAyCcxlXt6VlsQUOOVEdk3dbjJruiYwmKe96pAp5RpAxXzWGH4?=
 =?us-ascii?Q?HN2IY1wlowTKsfI2uoE1CQ4LyXHMA+21Jvnzn84IX1bLbOdYYWjxEueaFwdM?=
 =?us-ascii?Q?Vx39xLhVd7rtmocduu6mKTf9oMtrjsKOZlFqrIl4fKgPnsy+udVGKgbD54Q6?=
 =?us-ascii?Q?MN3Iz7sS+qFMblxBBF3lmu629Wu33NpSY2RAXKZb09jpX3BpIthJKtJKroj6?=
 =?us-ascii?Q?jyi4zFK/AjxboaN1KrGTM/dYWlT7pH4QPY/OV29ZE1O1YqhYxnvIm85AUPIU?=
 =?us-ascii?Q?yqpqwXRDTIOJeYwdx+1mqQ233OsDwEvhiCUwKhrsYXsupISiebt+AM6B6Jmw?=
 =?us-ascii?Q?bqQD/+5jWUwWmWYnMR78qlcn1d9ydBQDtXIG0R0gpDhYpODN1WnSPlqvjezc?=
 =?us-ascii?Q?DVQv6RmVA/91UXzUBZBH15LWNVEJ84l+dJI7MaJgbjjZB10DH/QKq1EZyknB?=
 =?us-ascii?Q?fyOvojJppHOs4rhgzOmCSc/vTpeciXpsG0h2VKF47uE8bM8uHadpo/YkgfuY?=
 =?us-ascii?Q?omP7TdSFtTpie+Kw+8yCFqt2AXSgkLgwBOHY+HnnqThjWxSgV/JIAUzGh+z5?=
 =?us-ascii?Q?rDaqPDN2qm6sW35M6lQOtRebEwXY4NiuLEQH8b9CGpgBFDRPU+P2VK0PI1z4?=
 =?us-ascii?Q?aB+8Js5GraFTSNRzgqdNjRS0YIdejbIWZe/AJTbB3s17+wLbd9q0QJTIng9J?=
 =?us-ascii?Q?wgxrF2XrGfHC5wbwKP1ggVrOY9/24rKyWNxD93+qSSeqjiEEfk95av3tY/Tx?=
 =?us-ascii?Q?QNJu371jwC4C4ej89e/rltS/zeGG2HPDRSjo0QneugVkts71cSH25XJv9viJ?=
 =?us-ascii?Q?ZqYlM3czh1dabs0QEIu0g7KE3op9rkyD492cemLMwDU9ZNEm9hM+UNa77cwl?=
 =?us-ascii?Q?45I0OENeFDewiNk8qBq5XRIU23lf/QmbeGlTreK/FgdjRiJHsZSzM9Lfx63r?=
 =?us-ascii?Q?afPDrUr3RffnGuKaSYb/3Ilv7tnoRdcKxvH0686zzYdWqEqhNBomiLqvG3ZZ?=
 =?us-ascii?Q?YNV8JMHL/gSbq+TDm0EvArUdANTvgBXAtHevtOxq75gK0qSDuw+KBNxk5X+N?=
 =?us-ascii?Q?9NYmj42Hx/CzstPAowD+j0M9GhpzMBTvSfgHcPJXb1/iM8y1nItXfYi353Ps?=
 =?us-ascii?Q?AlsVyDUOgFPjsQ67pe5NW//DX9ZOMgW1Q7QqvXjpj2Eil5rbDtlQUD03COUo?=
 =?us-ascii?Q?rDUTkvD0yyeEY9hVE6DodvihSOkA17eBr+SSveO2OFE9lDECYGrjEar0igoc?=
 =?us-ascii?Q?pyeMD+O9OLyYmHyDKfWCkhbces4EqxbkkXdTrCnmayIckDHhVEcZm36Y4O9o?=
 =?us-ascii?Q?M2/zd6zXrguGo8nPe5Duw1gDWQhIHBPx6uanhYQGRr6a7noCHvvwvQbvciun?=
 =?us-ascii?Q?moFhkvBeUVtE7nuE/0K/OfVO+d3ATjO6aRCk7bOyj7sMaCUFhbpSR430DTJ9?=
 =?us-ascii?Q?R6fO+duLj1kbRcrli8HcPRisAAP35pXy58WKRQQ7N6KMIRfo+9dDqFw0e2Qq?=
 =?us-ascii?Q?XWbUW2Cb6XDcMEoFZZRVnugwfwUcCYwdcQpCTjZafJb8pRMGoyp/7VIpSwdP?=
 =?us-ascii?Q?Z3Vme/P0hPRh6ejCR4F5/1UTj97LgRh1a3mGf5ELmf3Uh61P1qfy6LMgrzyd?=
 =?us-ascii?Q?KKiE1dTqD693VnPCGn/HVtBxWq4MWJXzy2kc82ZeAw3duW6ycYCkE5ehDLFK?=
 =?us-ascii?Q?8WyPsYRV+47IDInUrNgU6O03/1kOm1kFBdwYpCfh77qjwRkG?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: edc4ec08-e5b3-4783-ca19-08de6e43a787
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9366.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Feb 2026 16:43:18.9551
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +/y5U6en1A3MjzCXBU8wnDboGJeHj9g62NHYol58Eau4M2H5DY6FnTZzuMatT1yXCFCVZPhIOI3tKiinegFoPQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8557

On Tue, Feb 17, 2026 at 05:05:58PM +0900, Koichiro Den wrote:
> Prepare pci-ep-msi for non-MSI doorbell backends.
>
> Factor MSI doorbell allocation into a helper and extend struct
> pci_epf_doorbell_msg with:
>
>   - irq_flags: required IRQ request flags (e.g. IRQF_SHARED for some
>     backends)
>   - type: doorbell backend type
>   - bar/offset: pre-exposed doorbell target location, if any
>
> Initialize these fields for the existing MSI-backed doorbell
> implementation.
>
> Also add PCI_EPF_DOORBELL_EMBEDDED type, which is to be implemented in a
> follow-up patch.
>
> No functional changes.
>
> Signed-off-by: Koichiro Den <den@valinux.co.jp>
> ---

Reviewed-by: Frank Li <Frank.Li@nxp.com>

> Changes since v7:
>   - Switch to designated initializer and rely on implicit
>     zero-initialization.
>
>  drivers/pci/endpoint/pci-ep-msi.c | 54 ++++++++++++++++++++++---------
>  include/linux/pci-epf.h           | 23 +++++++++++--
>  2 files changed, 60 insertions(+), 17 deletions(-)
>
> diff --git a/drivers/pci/endpoint/pci-ep-msi.c b/drivers/pci/endpoint/pci-ep-msi.c
> index ad8a81d6ad77..50badffa9d72 100644
> --- a/drivers/pci/endpoint/pci-ep-msi.c
> +++ b/drivers/pci/endpoint/pci-ep-msi.c
> @@ -8,6 +8,7 @@
>
>  #include <linux/device.h>
>  #include <linux/export.h>
> +#include <linux/interrupt.h>
>  #include <linux/irqdomain.h>
>  #include <linux/module.h>
>  #include <linux/msi.h>
> @@ -35,23 +36,13 @@ static void pci_epf_write_msi_msg(struct msi_desc *desc, struct msi_msg *msg)
>  	pci_epc_put(epc);
>  }
>
> -int pci_epf_alloc_doorbell(struct pci_epf *epf, u16 num_db)
> +static int pci_epf_alloc_doorbell_msi(struct pci_epf *epf, u16 num_db)
>  {
> -	struct pci_epc *epc = epf->epc;
> +	struct pci_epf_doorbell_msg *msg;
>  	struct device *dev = &epf->dev;
> +	struct pci_epc *epc = epf->epc;
>  	struct irq_domain *domain;
> -	void *msg;
> -	int ret;
> -	int i;
> -
> -	/* TODO: Multi-EPF support */
> -	if (list_first_entry_or_null(&epc->pci_epf, struct pci_epf, list) != epf) {
> -		dev_err(dev, "MSI doorbell doesn't support multiple EPF\n");
> -		return -EINVAL;
> -	}
> -
> -	if (epf->db_msg)
> -		return -EBUSY;
> +	int ret, i;
>
>  	domain = of_msi_map_get_device_domain(epc->dev.parent, 0,
>  					      DOMAIN_BUS_PLATFORM_MSI);
> @@ -74,6 +65,12 @@ int pci_epf_alloc_doorbell(struct pci_epf *epf, u16 num_db)
>  	if (!msg)
>  		return -ENOMEM;
>
> +	for (i = 0; i < num_db; i++)
> +		msg[i] = (struct pci_epf_doorbell_msg) {
> +			.type = PCI_EPF_DOORBELL_MSI,
> +			.bar = NO_BAR,
> +		};
> +
>  	epf->num_db = num_db;
>  	epf->db_msg = msg;
>
> @@ -90,13 +87,40 @@ int pci_epf_alloc_doorbell(struct pci_epf *epf, u16 num_db)
>  	for (i = 0; i < num_db; i++)
>  		epf->db_msg[i].virq = msi_get_virq(epc->dev.parent, i);
>
> +	return 0;
> +}
> +
> +int pci_epf_alloc_doorbell(struct pci_epf *epf, u16 num_db)
> +{
> +	struct pci_epc *epc = epf->epc;
> +	struct device *dev = &epf->dev;
> +	int ret;
> +
> +	/* TODO: Multi-EPF support */
> +	if (list_first_entry_or_null(&epc->pci_epf, struct pci_epf, list) != epf) {
> +		dev_err(dev, "Doorbell doesn't support multiple EPF\n");
> +		return -EINVAL;
> +	}
> +
> +	if (epf->db_msg)
> +		return -EBUSY;
> +
> +	ret = pci_epf_alloc_doorbell_msi(epf, num_db);
> +	if (!ret)
> +		return 0;
> +
> +	dev_err(dev, "Failed to allocate doorbell: %d\n", ret);
>  	return ret;
>  }
>  EXPORT_SYMBOL_GPL(pci_epf_alloc_doorbell);
>
>  void pci_epf_free_doorbell(struct pci_epf *epf)
>  {
> -	platform_device_msi_free_irqs_all(epf->epc->dev.parent);
> +	if (!epf->db_msg)
> +		return;
> +
> +	if (epf->db_msg[0].type == PCI_EPF_DOORBELL_MSI)
> +		platform_device_msi_free_irqs_all(epf->epc->dev.parent);
>
>  	kfree(epf->db_msg);
>  	epf->db_msg = NULL;
> diff --git a/include/linux/pci-epf.h b/include/linux/pci-epf.h
> index 7737a7c03260..cd747447a1ea 100644
> --- a/include/linux/pci-epf.h
> +++ b/include/linux/pci-epf.h
> @@ -152,14 +152,33 @@ struct pci_epf_bar {
>  	struct pci_epf_bar_submap	*submap;
>  };
>
> +enum pci_epf_doorbell_type {
> +	PCI_EPF_DOORBELL_MSI = 0,
> +	PCI_EPF_DOORBELL_EMBEDDED,
> +};
> +
>  /**
>   * struct pci_epf_doorbell_msg - represents doorbell message
> - * @msg: MSI message
> - * @virq: IRQ number of this doorbell MSI message
> + * @msg: Doorbell address/data pair to be mapped into BAR space.
> + *       For MSI-backed doorbells this is the MSI message, while for
> + *       "embedded" doorbells this represents an MMIO write that asserts
> + *       an interrupt on the EP side.
> + * @virq: IRQ number of this doorbell message
> + * @irq_flags: Required flags for request_irq()/request_threaded_irq().
> + *             Callers may OR-in additional flags (e.g. IRQF_ONESHOT).
> + * @type: Doorbell type.
> + * @bar: BAR number where the doorbell target is already exposed to the RC
> + *       (NO_BAR if not)
> + * @offset: offset within @bar for the doorbell target (valid iff
> + *          @bar != NO_BAR)
>   */
>  struct pci_epf_doorbell_msg {
>  	struct msi_msg msg;
>  	int virq;
> +	unsigned long irq_flags;
> +	enum pci_epf_doorbell_type type;
> +	enum pci_barno bar;
> +	resource_size_t offset;
>  };
>
>  /**
> --
> 2.51.0
>
