Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012038.outbound.protection.outlook.com [52.101.66.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 846CA4418D0;
	Fri, 27 Feb 2026 15:50:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.38
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772207439; cv=fail; b=NydAQBC6xbivFHGYkj661RpI31cK5zaSYcy3XIYWESXcVndgL7CCbqFbx41NPuIbJezu+tGL5GlW542sbPfkA174yus1b8cqygfEGsmzgnwEbKRhPZ7pVlgrgNE+e32U3VFgtFzm72L5jJb9JccszHTW3lWkkQp/8Z7B7idxPCg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772207439; c=relaxed/simple;
	bh=+PTXaUpXmFj0GYrnNBErCMxA4vISBPMkgD1pRORi/as=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ZPa/9ledxWry5B4YoBs/hlyar0UNw7ohmVW9Cs0u0tEcO5R0tQUlyCWJK+jWD3KS42CHVOHrbt9ZXlXSgl4hbRoVmvB1LMthwxhQFLjkdIRl2TdglPHQLUpvwwOu5khfmGsEUafxuH1vQ7qLqIwiMjeQnAbwVhC+YX8xO8zY6Z4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=CUt0jJGd; arc=fail smtp.client-ip=52.101.66.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="CUt0jJGd"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=N0rspQ1Iijr+Q9GCm2Q8NghcQd6V8mXDcFHGUIAJQZ5uxLsyjnae1jvmNWPzeReCjocytGzJmCmhimzDHR01chKa7pR4Ce7bTpjkU9xHTZlR0a48VJkvUIYVV4TepfvLDsIawIQLqZhpfVVcFzH4ChGHYR95YIlQSqsXzpaAj+XLMe6qUfM3v8plCyeGqDfhh7Jrgzeq0Y8WfV6eMY6Iu8C+fDfZoQXcodwSQT+w6QXLq27mNg2thVy/CkvbH0pmpYMRC8POwR4Mk5W9Lgkpwn2qcl2P4f6My9TiowGJ7hkRXnxO8FZmdgVoHCIwl0rUvvTXlfByvoOeuE1yDqHD+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7y3YcYLAVXR8Wwwg18R7QTEwRu+3l2GAWFy7EB7Qs1g=;
 b=watUX5Jv3YBiEHFRDW65RWb0B8dh3Z1kcX9W/L5LiU9B9nwvg/Z2B7ikLhQ9gZL2LeGiA8Ju6s31FNuJG6+BSzGQYkqO+hl1TIOeVz49e4JB2JaDA2yyFVajGEGFLD+tPmLq8T6qdD0Hoi9Kzq3HmP4VNQ1bCvAgzYgDjHZ7bWKuul2oVtuuHEP6Np1z26QE15FLwipcbdGni+gq1yuYiEyIPP8Hn6fV/jucGGqB7kKO0Ys55aIkiLKqf9OJaRsNO3bDy0iqzPHP2ryrZXo3iSOCi4y7eDdoyXKOidM1Ky1AyhPM3oTK1FDP72vRGGD8efiAlOsMsMSoQgGNOBZDag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7y3YcYLAVXR8Wwwg18R7QTEwRu+3l2GAWFy7EB7Qs1g=;
 b=CUt0jJGd3fGLQn7xs97PKu3Cg/A0/LViKZxZJdo+2GJR6huRI3n6ACIqjI9LW671CznBaEFAF6hQzQd9zYJmNEQZkoUayxFaKWUsx0mQXICwQSmpbdP4F8mMOmNSPET4LPzYCf2pcGldu+iL7P3D/X5Z/aQHKuqJAIM9b8jNO8/jgXnCNWfL/ei0729hFhR9Jyyo3r6zFYa4A1kxKtOdCdXrm72mwZECvVx+VLAnxgfsbY4ec7h82EsazIq5RAiheZCMSB0qtFsBrsO5G6XpXTxTEMc4XT45MYVkEMTsCAbf1bg7b1QMoAZ1MOuGYloCXCM5ZhiwgloXyQa7jHEApQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU0PR04MB9372.eurprd04.prod.outlook.com (2603:10a6:10:35b::7)
 by MRWPR04MB12048.eurprd04.prod.outlook.com (2603:10a6:501:94::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.11; Fri, 27 Feb
 2026 15:50:34 +0000
Received: from DU0PR04MB9372.eurprd04.prod.outlook.com
 ([fe80::4f6:1e57:c3b9:62b4]) by DU0PR04MB9372.eurprd04.prod.outlook.com
 ([fe80::4f6:1e57:c3b9:62b4%4]) with mapi id 15.20.9654.014; Fri, 27 Feb 2026
 15:50:33 +0000
Date: Fri, 27 Feb 2026 10:50:28 -0500
From: Frank Li <Frank.li@nxp.com>
To: Koichiro Den <den@valinux.co.jp>
Cc: dave.jiang@intel.com, kishon@kernel.org, jdmason@kudzu.us,
	mani@kernel.org, allenbh@gmail.com, kwilczynski@kernel.org,
	bhelgaas@google.com, jbrunet@baylibre.com, lpieralisi@kernel.org,
	linux-pci@vger.kernel.org, ntb@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 05/10] PCI: endpoint: pci-epf-vntb: Implement
 db_vector_count/mask for doorbells
Message-ID: <aaG9RBmP6ZORo_Ul@lizhi-Precision-Tower-5810>
References: <20260227084955.3184017-1-den@valinux.co.jp>
 <20260227084955.3184017-6-den@valinux.co.jp>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260227084955.3184017-6-den@valinux.co.jp>
X-ClientProxiedBy: SA1PR04CA0004.namprd04.prod.outlook.com
 (2603:10b6:806:2ce::9) To DU0PR04MB9372.eurprd04.prod.outlook.com
 (2603:10a6:10:35b::7)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9372:EE_|MRWPR04MB12048:EE_
X-MS-Office365-Filtering-Correlation-Id: 7c152ecd-2f30-4cc3-8fad-08de7617f141
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|366016|1800799024|376014|7416014|52116014|38350700014|7053199007;
X-Microsoft-Antispam-Message-Info:
	8R6s5MaG+20kNjveXg2VCxAAe4UTtEMcLT8sj4KxGtxODJnty1iqUkF4H75JspPvnmK0ZEU/x6UcMOXLy8CrzulyNND66JIJGp1o99WxDjHTPTeTe0arq5FPgELA1RQr2kUDv+vtMiHWxZce7mFg4JKLPxyYT3FDp9KGkv7JI9mFEWXl6LON4FD/ptg7P7I+E9U7AG5awGf229jS153DBcYySjlEcnC82zpe/jCYjKMRKhUYjH2qRVNCg6EQ1BcpGQYHNHTdCHdMA1qZ39rh+EMl/n9HAe0UkeZFk5Jm7AZTCDKlbhRAoYnYKMgmJIR3oyfOt/9eR3HGiVpTqx5PqOE77Guq8jdW2F+GARZTY+7AbWIe1dln4hqL56M1B7geZpOjCxwpP+L7V2XjXugk/VAFpe0UQDc3Yrn6Y/rF/5F+IxYhcjWYT/B/JOTM0QihF1A+JeWmH08/VIA0uH79SfDwXBIOoWqBkCiR/5bac+AI1Z/MNgt7VkqzFgFkT3phewjfMiSyWhnFU71np1jBL2WPvMwT8ShphvsTVotHI9A+qtpuWQ3JLLLB7ITSvu8qFVL1j2R9B6mMdgWyxG5HxVHAMqu5xfrYrsqGiJLUas9NLGarySm3PZjTIuSsxWX/6F0PLuAvJRkxbjN1/HonaPyC9+eoIOsTYzw45H1LjlMCK913cj4FWCeAmxQj3ZMwSS869baAkJ/4vTYC4al7xtgL/CLs24nWZyGHNh4DsFrAVumpEJe2VudjxyzAIm+6R3ouk8kBzWXFtfPO1dSEcA4cAzxiOxCYXDB1+j1Owbs=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9372.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(366016)(1800799024)(376014)(7416014)(52116014)(38350700014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?fE1gX8AO9n2dLotKm8a8Bb1XlWuHzm51FblK1ihEEeQsvH6aRRVf2m+8G4Ro?=
 =?us-ascii?Q?un+JYv9qP+C/8SCj2sf64l1eOgYFfKCxjiBds6yqgE9Pk7dQP/0PWFtkSgt9?=
 =?us-ascii?Q?STMzPd4QcfaG171oG2Xx3CnROnTyE0sXb2hp6/EKtvKhcfYi4QKNcmn7aLxH?=
 =?us-ascii?Q?1gvV1I8Xc1H1XHfqNf1SQii7N15DHryUxRr053EDi8CHZARYfvleG0UZgU9/?=
 =?us-ascii?Q?SjCV6oG97FwqZXLhjjyczyTFmDfSnLt7TMy2dWxPwF++NQWjRR9GzcLV4L7g?=
 =?us-ascii?Q?qHYuRox5u6YR3OFWqo0d9iLxsUenATskHPr3io1zFWS0F4nj1Hxh0vKPvtDg?=
 =?us-ascii?Q?QiBwAYIbg/Hi30aOhg8DJjKshrYmx5QPZKbdCTWKiVUZ4xSaSthlEN1JRzeW?=
 =?us-ascii?Q?iwPfgaBSH93+zwJ9aMn462bANRcC0CwlM7JzA/Q/3MU1xzMD1dT1+3qQmEO7?=
 =?us-ascii?Q?wtksLGHTujKKYpnvEXdkSz4d3O/wli9JkWn2UQbxWIViIf7sH7sf8oPGqHNo?=
 =?us-ascii?Q?zTksICAvDX5Di/KpWc/lyJvQVLI5pV8NIYIYHwh0ZxetOWQtlmI2nOXaSKDg?=
 =?us-ascii?Q?URD+PpuMDdsrIZ0UmjuL1AsHJ7QdttCDqTvr6YHMzePL6PpKGK5atsfs6IAV?=
 =?us-ascii?Q?8z9umIL2AxojYLdpxtDThf1O5MvpYt2z6hNuQ/wZ3InJdAq9KSCyvQnk5fhm?=
 =?us-ascii?Q?7ThnyOuJvHuVcJbZq1dmrdgSlp8kHRO06CBhKc0hil1K6l7Cl2EbvzwR9O+Z?=
 =?us-ascii?Q?TzxervtIcYCoxSwDhfTRUsSyIQzcAB31hotV8b4jYlSJNalCB3f3OaYKg2wg?=
 =?us-ascii?Q?lYTAXdqb8tzLyNuN4dp0lPCZnKM8ly7mP8FG+KIeG4kflXBB7LFwoytIq9cF?=
 =?us-ascii?Q?zAa4cdr+NL+Eip8phXBtOyf0MTrFnUKsOI6dvIfsi5Pspdl2ceAYaA7YQxEy?=
 =?us-ascii?Q?OWrOkQ4lpLxLlLauiUjZX+sKDmqU4+DVJfCUjkT8/3pzA0+y34mTh6AZtLJp?=
 =?us-ascii?Q?I6NgmoOCQm00L5d13sdsBTwk1sQof4XEbrrcyfO3DbgiZqX47eUZyBZ5LJBH?=
 =?us-ascii?Q?/A5HGC/G2FW46yDknMG8aMyShp+kHqUw+B/W69OXf3gimJEFs1ul63cAdK5l?=
 =?us-ascii?Q?I8cwT4VjpksgWT9/q4Zutcr2WsvtCb0ou9vheA1Kkf5vmW0nZhjdWiaDnwIj?=
 =?us-ascii?Q?4yjHRXk7ZpfVnTOcEWs0ujE5kA15khGvBSSk9BR/vf0/xS9zfx9hjnMSJjVC?=
 =?us-ascii?Q?5WVMyqdqUefzH02l82VEJ08/R+/yGVlmq+63MwnKZoEAE8IBi7TTJ3WAhGKj?=
 =?us-ascii?Q?wlJlar9OYk3ZWnpss2hKWS2eUugrm3EUBILhTrGvr0/TCQsUHraqnNEqVn0X?=
 =?us-ascii?Q?7Dn8+SiNlm9Gbt43/R9vTu7rpc/6CspoYcKIsYLvsRrmX3oCc88KTXfUwD6l?=
 =?us-ascii?Q?aA8ZG/D4DoTfH1qFPrSNOqF0SniEJUMfupkRAW8cU4EE2pKTQH1LxXFf9g/3?=
 =?us-ascii?Q?/sqeNF55K8pYkOZgTEDPYqIGJN4Z7dEoYXic4l5ECCVcjTnGonG/Mi/KIQRx?=
 =?us-ascii?Q?zledHWMDEXm/FmLjp+QLhf1GXYE1p+M2MDkbKBmyLaZbcCzy3AXrVfX0gAEW?=
 =?us-ascii?Q?3EerWOWwyDCkcWGW6/wRPbT7oELDC1nSQ8AhL51IBbqZPPmGKl2nRXJhopuT?=
 =?us-ascii?Q?r7ApVsEf4AjVQ+dsNbRXkc7mm7ITGMZmCr8s/+DgQrZwtIeP?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c152ecd-2f30-4cc3-8fad-08de7617f141
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9372.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2026 15:50:33.9220
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wWKe0q0at5s76tdwOBvrNFYPk2R+31VYTTMVkElNvqsbcAvsz8CHA7hpgyPXZtcWt/un5JYdbNI93PX6hOGncQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MRWPR04MB12048

On Fri, Feb 27, 2026 at 05:49:50PM +0900, Koichiro Den wrote:
> Implement .db_vector_count and .db_vector_mask so ntb core/clients can map
> doorbell events to per-vector work and avoid the thundering-herd behavior.
>
> pci-epf-vntb reserves two slots in db_count: slot 0 for link events and
> slot 1 which is historically unused. Therefore the number of doorbell
> vectors is (db_count - 2).
>
> Report vectors as 0..N-1 and return BIT_ULL(db_vector) for the
> corresponding doorbell bit. While at it, use vntb_epf_db_vector_mask()
> to simplify vntb_epf_db_valid_mask().
>
> Signed-off-by: Koichiro Den <den@valinux.co.jp>
> ---

Reviewed-by: Frank Li <Frank.Li@nxp.com>

> Changes since v1:
>   - No functional changes.
>   - Use EPF_IRQ_DB_START instead of magic number 2, to be consistent
>     with the change on Patch 8.
>
>  drivers/pci/endpoint/functions/pci-epf-vntb.c | 36 +++++++++++++++++--
>  1 file changed, 34 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/pci/endpoint/functions/pci-epf-vntb.c b/drivers/pci/endpoint/functions/pci-epf-vntb.c
> index b94e2e1d3421..832600b6eae1 100644
> --- a/drivers/pci/endpoint/functions/pci-epf-vntb.c
> +++ b/drivers/pci/endpoint/functions/pci-epf-vntb.c
> @@ -1278,12 +1278,42 @@ static int vntb_epf_peer_mw_count(struct ntb_dev *ntb)
>  	return ntb_ndev(ntb)->num_mws;
>  }
>
> +static int vntb_epf_db_vector_count(struct ntb_dev *ntb)
> +{
> +	struct epf_ntb *ndev = ntb_ndev(ntb);
> +
> +	/*
> +	 * ndev->db_count is the total number of doorbell slots exposed to
> +	 * the peer, including:
> +	 *   - slot #0 reserved for link events
> +	 *   - slot #1 historically unused (kept for protocol compatibility)
> +	 *
> +	 * Report only usable per-vector doorbell interrupts.
> +	 */
> +	if (ndev->db_count < EPF_IRQ_DB_START)
> +		return 0;
> +
> +	return ndev->db_count - EPF_IRQ_DB_START;
> +}
> +
>  static u64 vntb_epf_db_valid_mask(struct ntb_dev *ntb)
>  {
> -	if (ntb_ndev(ntb)->db_count < EPF_IRQ_DB_START)
> +	return BIT_ULL(vntb_epf_db_vector_count(ntb)) - 1;
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
> @@ -1520,6 +1550,8 @@ static const struct ntb_dev_ops vntb_epf_ops = {
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
