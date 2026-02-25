Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011015.outbound.protection.outlook.com [52.101.70.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2536A313273;
	Wed, 25 Feb 2026 21:13:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772054000; cv=fail; b=UuXnezYljsyRMiHPDyasqT395no0m6CBgVGg292pORrogKj8fnDyh+hkBn/CYI/0fDKcnGliDtErz/AbNfYV++AHU6yghmxcODnBmiRctOSxAQKh2nJCFTB26NrnDLE48qyitqKOW/pdmxGE4uGoMq8ZDk1dRTd5OouiljBVvi8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772054000; c=relaxed/simple;
	bh=iq5jpeAThl3veNUeiRmSZUdqeHtPGfJo81NMmGkqGbE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=p/lPfk22Y5FbyVL8Ks5PWtCty3wzarqkHrZkYZy7i396DYZfH7lCEVqSYZDHIL6833aYu3opXbZUenOTCPEnD+d6PRdMoquoJkTfr5RJ0RPAuDsUYDPhdd2zuhQ1leW9eVIslxXFWMvxBKxFW9GvtifC5K/6bvbe5drjn0Eqd1U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Mbfo+0u4; arc=fail smtp.client-ip=52.101.70.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Mbfo+0u4"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QBXWqxg9wOEhe2sNtegJmAxcKZ6xTj3lm+Bi+pyPQoSeWdbq7geiPxLKh2tyl0Np0giAELoBouc9400ILwtfJssmJLmhCPsZcKlcwd/z9wxAKD+gma+uMG++gs7XNegs/64SKub7tbA7XmcttRHKVPdod/fsV+T8kvi5WPTaX6Rfwjkh558X3kLDCzMHWO11bKQwzDteRjZXlliXyqzT7mxReIiPXbCgE123eBAD6CW8TVBmjbWtS9PYQuA/EjgLG5PdHKGLY73WUttoklclk2TWF6Upol+5/1uT9ClK3fYc61Du+hwzD+CdeHLTBMj0b4gtitIPUs2c6MjH27Jrng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jzEL68DIbZUh0o66U4MMu9f0vOYGa8AosB9SoqXtxwE=;
 b=fDjn27RqIlkm7sUk1ihAmONm4Xg5kEH4RSFwmH9XHjO6nJh4t0reqomi89cP+sN5Hkfv2sWI4p2JeFo+UbDGYACplEeH5JI5TbmQHJu8LShagaCe5Ppvabv1IWvtY8ke5gnF0GviKCPeO2EKC4GTQDwW02YoWbC+1OQ42MWs/xabh/hLTMpHYN549iST5hcKjCCxgDqr9BWlPwuMCjk1THKBq98fGm8B8ATodMR6k5kiwjKfGYUuOU3mr9IAV9WqpDHDQVIjc0BQwgKv78XLOECp2b9T7CSxQUGsD4wFoONkbjU1L9pWDV935DadaV2jN/hQlLysQMn1b7a3qTRRUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jzEL68DIbZUh0o66U4MMu9f0vOYGa8AosB9SoqXtxwE=;
 b=Mbfo+0u4C9d7oDAHQdJARIRHXDu0Mb4delNVeFYhCbsEiWx5Tv91ei89wB5/LVgv5YcPLzloEbXknel2s3Ke0WGy0xecSmOQcVS4OFsnBNGVqToAbEkVw9bNHEc0EUjNxSXdiHpa3bKH9aZBxk4QHa525QVYasrsjAVLI2Q5rerG/tATP/Fe7Gs96B0YsOcuvPI0iqya8lfAm2/kNU1X/whnLvIxS2eDc8C22E9qKJnJ0gYD6tJf+15y7b6q7HZQ/jJ9JOB0lg3NK81hW7KM9EN/M3SNGDL/MqXN/b+eJP4IOfI9j8S4rxoMPqnKFiHVA2ejDMnNUYcm8Pi9OfLMEw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com (2603:10a6:102:2a9::8)
 by AS8PR04MB7589.eurprd04.prod.outlook.com (2603:10a6:20b:291::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.11; Wed, 25 Feb
 2026 21:13:15 +0000
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588]) by PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588%6]) with mapi id 15.20.9632.017; Wed, 25 Feb 2026
 21:13:15 +0000
Date: Wed, 25 Feb 2026 16:13:07 -0500
From: Frank Li <Frank.li@nxp.com>
To: Koichiro Den <den@valinux.co.jp>
Cc: kishon@kernel.org, jdmason@kudzu.us, mani@kernel.org,
	dave.jiang@intel.com, allenbh@gmail.com, kwilczynski@kernel.org,
	bhelgaas@google.com, jbrunet@baylibre.com, lpieralisi@kernel.org,
	linux-pci@vger.kernel.org, ntb@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 10/10] NTB: epf: Implement db_vector_count/mask for
 doorbells
Message-ID: <aZ9l4z3UGX4o4-M-@lizhi-Precision-Tower-5810>
References: <20260224133459.1741537-1-den@valinux.co.jp>
 <20260224133459.1741537-11-den@valinux.co.jp>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260224133459.1741537-11-den@valinux.co.jp>
X-ClientProxiedBy: SJ0PR13CA0008.namprd13.prod.outlook.com
 (2603:10b6:a03:2c0::13) To PA4PR04MB9366.eurprd04.prod.outlook.com
 (2603:10a6:102:2a9::8)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB9366:EE_|AS8PR04MB7589:EE_
X-MS-Office365-Filtering-Correlation-Id: 862a2162-7818-4f18-5223-08de74b2b0d5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|19092799006|376014|7416014|52116014|366016|38350700014|7053199007;
X-Microsoft-Antispam-Message-Info:
	xy0mQC7QhHrF/8VyYf8SetblD03adh4RntRRbdEmTEvUZXJw3yO/vSGOzcwbfdEvuAjX47byBLL18i8QlGwqbC5B7yw/vNBKqfnlVDCe2BU9AIsU9AS4Di8B/J8gZCEBfLPIruYCdQNbqKZeA+AKMR2+o3O6eT3UhebAYq1i6NWBthCIjqicCooQxsfO2PN8hujVy39B+0tMlTZgBhb4pPApK1nLo8UB7fNYlJylvBUw/ypVqWeM4jGS5MJIzWzVa8OfUDIIJ5WFtoAjA1VujPTUplM7u6UMqEiqhDlVgcG1Y+bgERMpOHztOaVRggHolkrRDeNJTPCYRem80VvF9p0ZlIU8qjxuXfclTy7kPcJqzQ3MkWGJ/y0Npliq3j+100u+PkLcLNr/l/ce/ZXXxsA9CJ+TcCC54fkWB6yJPYxoX4N3VsddyjkYEUHC6LGBZtteP5dLTVQGdzCtyZy439qGdlX4Ha1M7uC8sKbxEmH+yeNXomxdbNNMMpISrP+hIKEZaFzvmAARj44QNRIPhF0k+g8XeJxwNP5fPWb9XL+a7k9yzG1sWkbN/+YomimHMlJO0rF/S8aZpsLkKNTHS1ULTu720SA/exRbYORtVoacDBYIhDs6UDZny0/EIzCisXjsm233tA88q0qUPQf+EfP742g14LksxEb2XtnMHPBBN+nJJlGuDVhvw2PLg9HRB8aA1j8VOfMDEVeuHfq6249dtGAYcejTgpa2+uvg1QOPq3n9Ou3DhiSrDt/LKVyNVo0WZUPTU3nVbonhjSKwCI1sdbQMZYpznCdq5clUuWg=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9366.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(19092799006)(376014)(7416014)(52116014)(366016)(38350700014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ZpdSfDjKg2bSR+sPfRQz/nKKVt5qbrqItvYGaGjdWgOqeXBzykQCHEHtVeFL?=
 =?us-ascii?Q?s8OpYlWgBVO4wh7u1C7CyqsrrBpWm6jDko0VN/HYOTPnkvRIn7BrzRayIWy6?=
 =?us-ascii?Q?dLKOw0M3emNGO1PAqUMnRJFSgacn+8nTO0raYDcokKzBwxq4TSK8uaqmuJTX?=
 =?us-ascii?Q?4Ys+0OJb0BcGRhxq+k0pUnKXKxLxfVNNRL9FV0oYVHO0Wq9tT9kcA15LmGBf?=
 =?us-ascii?Q?dS/su9ky7ptMYhU6F6fo2H17XkL1KB7CQbxbdvKJ+SyZTOjoxcyX9t0epUxh?=
 =?us-ascii?Q?VkQ44XnxYr3XaO27Gq8Z1NebTJSDheBkx+3YmufpnoX7x8BHqsbIcEQxOkhF?=
 =?us-ascii?Q?sYTZZAJHuFYxriQmdWfHlgfFS1qlfKRtmi5yu5U42AjMxTA1/U3GvqQyBi/9?=
 =?us-ascii?Q?9Jm63VkoZLbzseN5dfX9Hft1NFvDhhIlgv0BTSaHmA971YQixA9StXrPsw8r?=
 =?us-ascii?Q?zc5fkqeFOQBAAqXdcyLXcHyGZLE95xGTq2CN8WbgjJqzCRQ7l2nmVqTUlA9b?=
 =?us-ascii?Q?iDPi9/zcu+X1777a+JNftHocBFJOh3XiUPBlzlj1gdgiVB3PvZH9aG9OhUfV?=
 =?us-ascii?Q?9hO/Qwmz3kBjbADwDTMirsxSIZJ0JQfwZK8pUnRyl/aWVhgIJ9vDpXtmaU8j?=
 =?us-ascii?Q?fEFvurzvfFgOdhsMfwdpHqTCc+WoSgjvvZEFVqsvKifh4mxpp4RAbEtNmHp7?=
 =?us-ascii?Q?qJVMz9niS7JJAKdU86F0eFIsrp4LUt9w4uYN7AP7o7oM1nNEO14l+BsdOGeW?=
 =?us-ascii?Q?PO0E8cLYS6P4Wbe7WJbvb6tj6SGmUy7xvIFKv0AQCTpbSZnppBOe9X9LpsL0?=
 =?us-ascii?Q?lbnoMpmTt/AxoscRacgkENtaamimPUQFZBHiN4D1AuOp7aXxDGcWxbmCc49b?=
 =?us-ascii?Q?1BHLEbEgOL/TlbwAILOFmF3YWWjXkUcxrx0KAvW+l0wy2YvGaA1A3+lNJwt5?=
 =?us-ascii?Q?xAdqB0fEd62nNThBki2+yo947oOryjItU2ynwV5ojj/7RRxNwNf7zFNYkSao?=
 =?us-ascii?Q?9chBfX5o2hKlpuZuUFQ9E/X3IgVUTdQMVr73VUDdSLWyZkG4ibkSTok+8NhJ?=
 =?us-ascii?Q?39mt+166blEQ77KSBpg9HR1JEFfLJC8uF26rlPR1PQfH2F94m95GAsK3OO/l?=
 =?us-ascii?Q?iQ08U8c7sArahsA3D2NZMpj3PpTQ8u6xfLRCztX8FZdgDRw+blj4UQWxQKRT?=
 =?us-ascii?Q?erAKXsiHpZiivXQS9CV7fesvCxCT0olRJcpLw6W9hryjKNhW1weMGizlVIb1?=
 =?us-ascii?Q?pQ18+ZOfWJLFBAsoMa0nFF0A/BIl0pEKtfwx+boDzBPE/vst8YcQjmPYLqV5?=
 =?us-ascii?Q?WNO7xSmUYufe/j/NzuG0kdKuXisyq4FBk9t6YMmYAUhe5YK5aHdjqjxSWrdH?=
 =?us-ascii?Q?dv4g3iWg78+e0/js6RCQ/FD/T/k9xfTjmXys0zZd1asTuegENXCgO2Ybl8Cf?=
 =?us-ascii?Q?JrHHRH9nnTVO4bIo2nN64XMsMCIvJKQ8GSVw6WxLpeNWFfi9I+gtRzWdjadE?=
 =?us-ascii?Q?63brcal/G0j4KV6m3iaFgXW5yKOTInTBcsIqsLLZH9dphL3lpVq6hwAJdan1?=
 =?us-ascii?Q?OqusrnZGTUY6L2rdqGKYBXeQoIVZsDqfEK4InXqGHs3Pn93Uy0pGsXWxiYJ3?=
 =?us-ascii?Q?KYbo/ppQRykVAg3Ok0wvj/+1SF8CEQV4STBM/vcfrRtVem405OzjiK45UY2h?=
 =?us-ascii?Q?qaUWx/fasNfoNYhtpNTCjwzIurGflG8NLLUMbKcN11oxe+7i?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 862a2162-7818-4f18-5223-08de74b2b0d5
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9366.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2026 21:13:15.4852
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: m1t2/tEGLgAoRTENT8cTQtPmAlna3sAtRdGlNH0NHaT+Yz+Z8ZtBVerk8I9rRgwMtMxZgMQr9wrTKnCC+OHVFQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7589

On Tue, Feb 24, 2026 at 10:34:59PM +0900, Koichiro Den wrote:
> Implement .db_vector_count and .db_vector_mask so ntb core/clients can
> map doorbell events to per-vector work.
>
> Report vectors as 0..(db_count - 2) (skipping the unused slot) and
> return BIT_ULL(db_vector) for the corresponding doorbell bit.
>
> Signed-off-by: Koichiro Den <den@valinux.co.jp>
> ---
>  drivers/ntb/hw/epf/ntb_hw_epf.c | 30 ++++++++++++++++++++++++++++++
>  1 file changed, 30 insertions(+)
>
> diff --git a/drivers/ntb/hw/epf/ntb_hw_epf.c b/drivers/ntb/hw/epf/ntb_hw_epf.c
> index 0018adc35f16..7c76039a79d2 100644
> --- a/drivers/ntb/hw/epf/ntb_hw_epf.c
> +++ b/drivers/ntb/hw/epf/ntb_hw_epf.c
> @@ -414,6 +414,34 @@ static u64 ntb_epf_db_valid_mask(struct ntb_dev *ntb)
>  	return ntb_ndev(ntb)->db_valid_mask;
>  }
>
> +static int ntb_epf_db_vector_count(struct ntb_dev *ntb)
> +{
> +	struct ntb_epf_dev *ndev = ntb_ndev(ntb);
> +
> +	/*
> +	 * ndev->db_count includes an extra skipped slot due to the legacy
> +	 * doorbell layout. Expose only the real doorbell vectors.
> +	 */
> +	if (ndev->db_count < 1)
> +		return 0;
> +
> +	return ntb_ndev(ntb)->db_count - 1;

return max(ntb_ndev(ntb)->db_count - 1, 0);

Anyway: Reviewed-by: Frank Li <Frank.Li@nxp.com>
> +}
> +
> +static u64 ntb_epf_db_vector_mask(struct ntb_dev *ntb, int db_vector)
> +{
> +	struct ntb_epf_dev *ndev = ntb_ndev(ntb);
> +
> +	/*
> +	 * ndev->db_count includes one skipped slot in the legacy layout. Valid
> +	 * doorbell vectors are therefore [0 .. (db_count - 2)].
> +	 */
> +	if (db_vector < 0 || db_vector >= ndev->db_count - 1)
> +		return 0;
> +
> +	return BIT_ULL(db_vector);
> +}
> +
>  static int ntb_epf_db_set_mask(struct ntb_dev *ntb, u64 db_bits)
>  {
>  	return 0;
> @@ -548,6 +576,8 @@ static const struct ntb_dev_ops ntb_epf_ops = {
>  	.spad_count		= ntb_epf_spad_count,
>  	.peer_mw_count		= ntb_epf_peer_mw_count,
>  	.db_valid_mask		= ntb_epf_db_valid_mask,
> +	.db_vector_count	= ntb_epf_db_vector_count,
> +	.db_vector_mask		= ntb_epf_db_vector_mask,
>  	.db_set_mask		= ntb_epf_db_set_mask,
>  	.mw_set_trans		= ntb_epf_mw_set_trans,
>  	.mw_clear_trans		= ntb_epf_mw_clear_trans,
> --
> 2.51.0
>
