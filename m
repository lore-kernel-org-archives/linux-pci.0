Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010070.outbound.protection.outlook.com [52.101.84.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52AAD13AD26;
	Thu, 14 May 2026 19:02:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778785349; cv=fail; b=Yewlt1YkrrCuQTVhqUF61bZEoAOE5LcxqHgaB2TYOFIs8Myruimy/27WihkF+2G0krc8kkDNokjR0dT9Pz/vDyfzKDpSnmRwqBXZ/pYIW2j+I985uQAqKxPyq1uLYcJC1U7NU00PqPAERchYA5YJ7ZFek52LWa4N3Oytq73Du9I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778785349; c=relaxed/simple;
	bh=qh+sSJ/IAaJLNro1l6s7WWyShE2bG2zWXHTgA/cWOio=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=t17LH17VM07fymQgyJgZRKTiHqkc0AfNfd4h/RDSZOhwXVgGIKoclPtJnjroc8RlSXB68wv15+YIVYUynrUL0gV7+tgwx1UJpfp1DUyr151zH+7yxkr4yF2NIB055sHndF9JPVVu7MT+6Z33iWNYSLYFgAQ8Ym8nxTnkTKWyv4Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=AeQVOcYM; arc=fail smtp.client-ip=52.101.84.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="AeQVOcYM"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dRO8LiGGYij4BBaX8yyd9ynNQrq1PsbzfdZGnb0EVZjCSKxctFuCIB4cjfZVE8/W06z5GpGd1p0EyHlpy73LszkNYYHEONIcF2mHvz575dq+ipMnRNslkE2LJE30YMD2Vd5JiQYBIBZdSsNu0Ktk2wKvCtnenC03fH5QwQeah4M+c09+nE55HcF8yrMZYtpD6QMaTTCF8tFG1eW5LmhtTFKtJs8G3FAasMdYzNXwssNBdX6p1nEaGigtcR6GA8ZhtNzYS4+H4syxO9bmjRo6XFhXsedOaIIGwNyw8mEyEJf184xPDJlw1dXzWNN4nPCPjENy1zvW7VzqxZ8LNhdKFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bS3YR/GHv4yFMgmc5pww8WWxQZ4FbgQG+jlK5Y3aMI4=;
 b=aLL3TIMon+PLGJoToR4R8C8DYOsTTrl0zFE08yO4gHH2hfOKnoMW5mQf78K+6zpNghp1YnYBJ5JrkX2d8BkQyuh61pyzwjKB89SowrAvaok+Js+HEDp660GMpaNZtOI+RAmNF9j/Keupqx1JSk7TfgGbwJGUlXRP58yspiUuYR/iOqI+bZZiV8HRbyLfKhB8Tj6unVar3k4tthBex7FnbpQJdZLmabN1MXi10NiqjaKuzwOR7IquV0+ZI6EKXWpTJk/37524LZduUrcZAOmXS7MuCA0W/B6g4eVTE6kD2TVSgNLJE79RuFD4zeOSyBHK6dQ0wsPt1QaPGhMM0ee7gQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bS3YR/GHv4yFMgmc5pww8WWxQZ4FbgQG+jlK5Y3aMI4=;
 b=AeQVOcYM2CF28yIFoL5FGYf9uHd3YuqYhmM8ZJt7iRG/vaXeB8Ng2SUXL7bDBVWEeUJkZ4JdWv/pGeFYRG7zqj415pt/OYhVlgAcna1aPCtNqfF6bQbQRYoQr+P5m0vJAXH09J9R3dzJ4Sa97OtCKeJ7pk13aoXsuEEKoCJWeTvR9Sl090iOiBeVEnzgpYxJMDT3ekH83nFUiHs9+IvG/7WXqCTtljsjYLQpV5niR+E7xx5v+6xGLX53F1dkWRbnyTly7FaH96v+OkqmzJPGEhaeZ/QqbJBvI1403l8/viEu1IuDHtea7/syHPahqqst9a8lMLvLZeBvmFYqbRwR0A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com (2603:10a6:102:2a9::8)
 by AM7PR04MB6806.eurprd04.prod.outlook.com (2603:10a6:20b:103::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.12; Thu, 14 May
 2026 19:02:25 +0000
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588]) by PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588%3]) with mapi id 15.20.9913.009; Thu, 14 May 2026
 19:02:25 +0000
Date: Thu, 14 May 2026 15:02:14 -0400
From: Frank Li <Frank.li@nxp.com>
To: Koichiro Den <den@valinux.co.jp>
Cc: Jon Mason <jdmason@kudzu.us>, Dave Jiang <dave.jiang@intel.com>,
	Allen Hubbe <allenbh@gmail.com>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Jerome Brunet <jbrunet@baylibre.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Niklas Cassel <cassel@kernel.org>, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, ntb@lists.linux.dev
Subject: Re: [PATCH v4 07/12] PCI: endpoint: pci-epf-vntb: Implement
 db_vector_count/mask for doorbells
Message-ID: <agYcNqBvF-0CYiIw@lizhi-Precision-Tower-5810>
References: <20260513024923.451765-1-den@valinux.co.jp>
 <20260513024923.451765-8-den@valinux.co.jp>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260513024923.451765-8-den@valinux.co.jp>
X-ClientProxiedBy: PH8PR22CA0024.namprd22.prod.outlook.com
 (2603:10b6:510:2d1::15) To PA4PR04MB9366.eurprd04.prod.outlook.com
 (2603:10a6:102:2a9::8)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB9366:EE_|AM7PR04MB6806:EE_
X-MS-Office365-Filtering-Correlation-Id: d39b1441-f06e-4bcb-d5d5-08deb1eb5606
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|19092799006|7416014|52116014|376014|38350700014|4143699003|3023799003|22082099003|18002099003|56012099003|11063799003;
X-Microsoft-Antispam-Message-Info:
	dM78TB54a4+XJUmJFZEGt5eP7e4YJNEx4UuTLy1EloOKFoCmI8ev/AD6CAYr3w1/IpERbBPNIiDh3puEGYt18CvU8YVTyTL7az2E4ZggZZb6v0GCBeE4tCZQSXx7mCjohQfLJqinc46gUhFIccM++cG3SEp1gANe0jCLyMhqKH9wkiEs8Dtinaob62hJuUaclLOzPa97Pl0/DjH0WrwSfiyH2ObTuW9bmfEgL+uOo53Nz6QRjccLgrNDtnO8jG5dFh9yPAKrPEDN9SG18doLFu1gXwhiC8t4j2XTTS8zpC57MYH0QtOSQcjWJsv+msJ0jm8GDh7eH6sFVtu7uI0xAB4qnNK8og3vyO3tlz1hxcmTkfZwrV5EgQ/LLyU7w5ZThWVE2dbCDJaYYC1nLFolrML/oOTgV8F1bDV7fQCXitlWcpItO8r0EzYYd0VgjO6IlZE5yyMA3bB4xfSRZJwwlzyNp3cuxfx/nvmGUtziNAiD5DU0Ct5cJVKcEs+r1mHiasCR56S0IGXzAGGwWi8XjmwcrqxrwdO0FSCAsVrma+c1UhqKUsbNTrpxkqqpEZCSNhzDarMI3WUo6fKpPk+XLPy+XxBFIB0fdGYAeTcJvl4OUlilaYr5sOIcAwIXynstqjdMSDPA5YlvpJ6p8HV1vOnR0E3gBWLNvuK2hQwYjk7Y69mRIbdEsRkZOJC2dZGwsUX5qug0OV43YOJa3eqRAPHo3Vuacwar3SRzpYDHNKUq0ZJn+/aiZMB3eu8vpe6T
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9366.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(19092799006)(7416014)(52116014)(376014)(38350700014)(4143699003)(3023799003)(22082099003)(18002099003)(56012099003)(11063799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?5FP1IQhqY4AO2RnNrr5e98qGPb/bdue57HOT5OypZ/eYtHO8cLXOSQAjpPej?=
 =?us-ascii?Q?VmMS4qQutPiBdUENSTTCNid5mqXfovKAFByxX+o1grgNWXHjlGWWQLyK2Uw7?=
 =?us-ascii?Q?Tv7VvVp9Fdjp39008X7ZIuYX4Bf/zSzz/XKtY1LhkV5mLZJi6Ugvsw0wV/rQ?=
 =?us-ascii?Q?I4rfFsboHwElneSHDOpcTAZ/ajyfGA8E4NnoOYnFTnqH4hHYnAeVYBrjnXrt?=
 =?us-ascii?Q?/a8SjHK5mqvLhFd7CKyAIAlMtix/P/AfL3r5LDVrfg/UsjMyVwKx5IDZ/0IG?=
 =?us-ascii?Q?Ft0rBU8wC4AyMegZ/oiAZQpLvQihsTz6iSb4dWiSf5g1qDEwAkkHpWn6FEcp?=
 =?us-ascii?Q?+pfHLta5X+dbN2KeRLKe5pw0GWrGx4+TT4hLJjje5efvvcdAjhF3LGpzfb0o?=
 =?us-ascii?Q?bADxUXls7hERbHwWjaZuF8v4vMna0KzMNeLGFhizHMmiO1igi4wU7v9fs0Z/?=
 =?us-ascii?Q?5zN052J+i3R/nW0380lIYkYVGts+nn1cgmcIakFNUXVqZeOW+fgDKsfG5Z9i?=
 =?us-ascii?Q?XR/Q9/Z1BJj52QYJCTU0MND9AdjxEU2Gf+HMw8GtTIpy5snGMi4i72jtfJdH?=
 =?us-ascii?Q?lxlEaqacdX8tUpjQU8BFlmmnkECndVi+aTE8zroBYFiJdYIfhqgGrqLVTr55?=
 =?us-ascii?Q?1ljwR44/R9+vK9I3mOwB9lG/LoWder7E4QF0RB2/dr0tB7IisugVqoCeJ8uZ?=
 =?us-ascii?Q?oNU6mfKp4EFITflAcxECWyh/3U3yIJZhdVjcdELpYLSCNLRw99bI4jt5x0L4?=
 =?us-ascii?Q?xybOVDNX6OIi2tTI9lAHO0vY5LDoCt9Zi7HKl9l+DyGMvjPJzCfczZdZtb2J?=
 =?us-ascii?Q?DTzrUrHfL478KpH/ldx7lJkyyRYzU4ZE27dY4aTat/L+eo3BP18hQqgLMXkd?=
 =?us-ascii?Q?zbtNsanyZDbTqHgMjlF/SaG+h5pSIqy/TpUp9o+V7TxH5On0Jck4qyQr95BA?=
 =?us-ascii?Q?ezYvOnQkw18IcHEn3uWpggS0dEEzyKoYlYUXiiCwRs3QuT9LpTLHFti/Ld2V?=
 =?us-ascii?Q?cAPcdyoiqID2FfeW5Cf6+mZr7xlEw6L8fnqAgIxk9X8elRU3wJWwy0n46dkk?=
 =?us-ascii?Q?lgh6cCq11c9Sms5uXMsJWprBX1ifo9EZUvDNc1aYV2auWVDgiXDOVsB8fyyR?=
 =?us-ascii?Q?k5rG19yhFt8X1ht7N28Y99leK8XOhRHOHi+yzL9CF2Jk/BDzxcbC93ttbMhV?=
 =?us-ascii?Q?SMRvvUwWijEFpArmX+G+FIm9uQC+IXItUJla81FeQRRZmnn6EeJv3Fbb/Sio?=
 =?us-ascii?Q?YIkqdifFEcOQDUs0eQGzx1wlqpyOMAK8EqEeOzwCk8bShPbQhSU/4q8gsbsB?=
 =?us-ascii?Q?LROfT1xuNz83pwaKuE6u6/uvGHAdPcWjmqpro3EYuX0WixlfEvXveMXzGu90?=
 =?us-ascii?Q?/XsRFLPOej+k3qFh0MBR4qaSh07YcOhdsEjM7VTaSnJUy4gjP+kXMhFRgW2b?=
 =?us-ascii?Q?JF5wmqUL1DKVB4rpGG4EL9lOLx6YJXxHAkiQb7TrmQhAbO/evKcSo33/yGOW?=
 =?us-ascii?Q?a10FS77xIQpaFb6f7IVdXj5GAImhoxiWvls4vg3JWAy1ckeoNqqEPZFX6yPF?=
 =?us-ascii?Q?21KHbLE7ybpMVr/1ZX45GQDu99k/TFe6OCpKGHkqXWEVTJ49xMQ33sldl7hU?=
 =?us-ascii?Q?6UJAJFAOOOzJIbVJM2EnfXQ4m6LDvv22RwvzMov2yWRyMPgSdLAFOgdWu8oP?=
 =?us-ascii?Q?JWz6o1ySXNDTO4tFs2Ji6e/2B5XxfSl9MONZlFql3xiyBi1r?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d39b1441-f06e-4bcb-d5d5-08deb1eb5606
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9366.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 May 2026 19:02:25.3218
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: J1P2b4mMLkiRy/zKrS0l6XhZ6Iu/AecsqSige6vp7S4OHCkcMM5im/vUUXRqT6pW9YZqrI4MeJaFm3d8PFfDpQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB6806

On Wed, May 13, 2026 at 11:49:18AM +0900, Koichiro Den wrote:
> Implement .db_vector_count and .db_vector_mask so ntb core/clients can map
> doorbell events to per-vector work and avoid the thundering-herd behavior.
>
> pci-epf-vntb reserves two slots in db_count: slot 0 for link events and
> slot 1 which is historically unused. Therefore the number of doorbell
> vectors is (db_count - 2).
>
> Report vectors as 0..N-1 and return BIT_ULL(db_vector) for the
> corresponding doorbell bit. Build db_valid_mask from a validated vector
> count so out-of-range db_count values cannot create invalid shifts.
>
> Signed-off-by: Koichiro Den <den@valinux.co.jp>
> ---

Reviewed-by: Frank Li <Frank.Li@nxp.com>

> Changes since v3:
>   - Tighten db_count-derived mask handling after Sashiko pointed out
>     invalid-shift cases. The new configfs guards should prevent them, but
>     keep the helpers robust on their own.
>   - Drop Reviewed-by tag due to the added validation.
>
>  drivers/pci/endpoint/functions/pci-epf-vntb.c | 42 ++++++++++++++++++-
>  1 file changed, 40 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/pci/endpoint/functions/pci-epf-vntb.c b/drivers/pci/endpoint/functions/pci-epf-vntb.c
> index 58e41d95d029..c3caec927d74 100644
> --- a/drivers/pci/endpoint/functions/pci-epf-vntb.c
> +++ b/drivers/pci/endpoint/functions/pci-epf-vntb.c
> @@ -1362,12 +1362,48 @@ static int vntb_epf_peer_mw_count(struct ntb_dev *ntb)
>  	return ntb_ndev(ntb)->num_mws;
>  }
>
> +static int vntb_epf_db_vector_count(struct ntb_dev *ntb)
> +{
> +	struct epf_ntb *ndev = ntb_ndev(ntb);
> +	u32 db_count = READ_ONCE(ndev->db_count);
> +
> +	/*
> +	 * db_count is the total number of doorbell slots exposed to
> +	 * the peer, including:
> +	 *   - slot #0 reserved for link events
> +	 *   - slot #1 historically unused (kept for protocol compatibility)
> +	 *
> +	 * Report only usable per-vector doorbell interrupts.
> +	 */
> +	if (db_count < MIN_DB_COUNT || db_count > MAX_DB_COUNT)
> +		return 0;
> +
> +	return db_count - EPF_IRQ_DB_START;
> +}
> +
>  static u64 vntb_epf_db_valid_mask(struct ntb_dev *ntb)
>  {
> -	if (ntb_ndev(ntb)->db_count < EPF_IRQ_DB_START)
> +	int nr_vec = vntb_epf_db_vector_count(ntb);
> +
> +	if (!nr_vec)
> +		return 0;
> +
> +	return GENMASK_ULL(nr_vec - 1, 0);
> +}
> +
> +static u64 vntb_epf_db_vector_mask(struct ntb_dev *ntb, int db_vector)
> +{
> +	int nr_vec;
> +
> +	/*
> +	 * Doorbell vectors are numbered [0 .. nr_vec - 1], where nr_vec
> +	 * excludes the two reserved slots described above.
> +	 */
> +	nr_vec = vntb_epf_db_vector_count(ntb);
> +	if (db_vector < 0 || db_vector >= nr_vec)
>  		return 0;
>
> -	return BIT_ULL(ntb_ndev(ntb)->db_count - EPF_IRQ_DB_START) - 1;
> +	return BIT_ULL(db_vector);
>  }
>
>  static int vntb_epf_db_set_mask(struct ntb_dev *ntb, u64 db_bits)
> @@ -1617,6 +1653,8 @@ static const struct ntb_dev_ops vntb_epf_ops = {
>  	.spad_count		= vntb_epf_spad_count,
>  	.peer_mw_count		= vntb_epf_peer_mw_count,
>  	.db_valid_mask		= vntb_epf_db_valid_mask,
> +	.db_vector_count	= vntb_epf_db_vector_count,
> +	.db_vector_mask		= vntb_epf_db_vector_mask,
>  	.db_set_mask		= vntb_epf_db_set_mask,
>  	.mw_set_trans		= vntb_epf_mw_set_trans,
>  	.mw_clear_trans		= vntb_epf_mw_clear_trans,
> --
> 2.51.0
>
