Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013028.outbound.protection.outlook.com [40.107.162.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 828A930DEC4;
	Wed, 25 Feb 2026 21:03:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.28
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772053429; cv=fail; b=oggmKDDV/2oxYZgQeTnyQQuiYjuO+nWxj9vYMEe3aQQ1ly7crsH9p6SrmlNQS+OcAXaoJ/uKrLcLnVXVWWNhTQgxZt5FPHHJjyBg78tk7IVMXFWWdPiZgWU1RceeKcP5I1QiQuPKWmZ7gyfWF8+vjDTgIEfuWxzk6lAfKIna9ng=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772053429; c=relaxed/simple;
	bh=aMBGt07QroIoq4YAMprN+IenOZqko8aoXRItxd0mk6I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=tupMuyanUNnUWJOJATQB0sZONbz16xIbhnVhfWiyVi9/iuaPKXUMYF7bfhvaQAE/+n7tVxbqsvEG6v7+CL1nlLLdD0xjdIV9PgkQcfXCTbJ5zRKxtsjJR9/t95qHlhxrJKFQTncgE0tAeTZkP3qxQdi9mZVxrOzN+MSBd/MLq3A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=YhCfFn1x; arc=fail smtp.client-ip=40.107.162.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="YhCfFn1x"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kew0m8csOMI+bpBRRTbpAljSjQzNsSA/22OZXQSWhCh0Ii0oo3ael8PuPnUQizG9Tyu2oRyplSrwXXSJYYGfBnRvFkEjqkPAGyGVfXtLgPxx5mctVEjnLazjefEVDSHEFDEok34zGak/njHzIt0IX9BA6NbHDk2jZQl7WMmnwm6CB9FF4acV7hbKSrKgSYE2s58sKHgw6sXu/e/dZor0Jbq2AYmAQGzWVfWhauW8sGj8Z2ceOOM744V7D3Ta0JKZF5FNGEVkd9Ysg8UYgztjifHEhY8nP/3bTXWdxukmF8SsAyzvIO1+UnKVAaKaUr4l3+JlcUf2xMjMpZ4Mu4nFtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6dmaPUbH12pWPaN26WtJ8RwK86ORjbP/82wHjKluDVc=;
 b=zGoxy07PS2/EDMliV6Jy9ZwJcaeDNZUuZhxsZYvS2HFV+rSFG3E7W4ZlQZ7V1AX5V21aezHLLCtj+rlIXyXNVlta8wpXveCRSCzC/gcb7P1qZUbpCuMxn0Zj3qOiAYyoEa8Z6BUo/NHo8lQMDunPSM9/VlJcCul7l0zEKXQ+4kU/H1dqPTSbYY1n1oY1xuMckbYPFbeB8yPyyHMBH/6AB+aNhNfyWeNVQSDN2vYq/j6zsCfXuq1velxxmwKoOPBwJC7ESatCihbgRcIWrXgUi4erQvnBNj6hgwvAj63vUFShVOiGicLTlNn0cfzS0ptLZUxtx5MaqYIg193oQMovlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6dmaPUbH12pWPaN26WtJ8RwK86ORjbP/82wHjKluDVc=;
 b=YhCfFn1xWLyWEB93uYDGyeGb8k2XJUfhMQuM2kIAR1/Tuxa3IMvy9jEhIX4OUw0ywfvAhsT2XLzS1fd0HwC7Foc9IxTCjGZ5apqfPlsCWKVAtbonAZKyvaqeub7F1qQ57Soz6Df25d0iAzVrU1UvQl7w83LuhHBDfwJp/jO94O98PmGYJzud77Zpnt/QRvXj/Fs92hRZFR1bfPozd94+gmSNCW3XSoc4mZTgcfGoV2qTn/0NEwJK63m9NGpPEe+RXoChPcTcUDJ+zuV2Hqpo4R4mFy7NOd9myEmU+JGLeLuWfe/JuxhgDBQu48DLYYOq2Mx6vqdeBneu7AoP7VoxKA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com (2603:10a6:102:2a9::8)
 by PA4PR04MB9687.eurprd04.prod.outlook.com (2603:10a6:102:270::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.13; Wed, 25 Feb
 2026 21:03:45 +0000
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588]) by PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588%6]) with mapi id 15.20.9632.017; Wed, 25 Feb 2026
 21:03:45 +0000
Date: Wed, 25 Feb 2026 16:03:37 -0500
From: Frank Li <Frank.li@nxp.com>
To: Koichiro Den <den@valinux.co.jp>
Cc: kishon@kernel.org, jdmason@kudzu.us, mani@kernel.org,
	dave.jiang@intel.com, allenbh@gmail.com, kwilczynski@kernel.org,
	bhelgaas@google.com, jbrunet@baylibre.com, lpieralisi@kernel.org,
	linux-pci@vger.kernel.org, ntb@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 06/10] NTB: epf: Document legacy doorbell slot offset in
 ntb_epf_peer_db_set()
Message-ID: <aZ9jqSPIO4oVQRnC@lizhi-Precision-Tower-5810>
References: <20260224133459.1741537-1-den@valinux.co.jp>
 <20260224133459.1741537-7-den@valinux.co.jp>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260224133459.1741537-7-den@valinux.co.jp>
X-ClientProxiedBy: PH7P220CA0172.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:510:33b::33) To PA4PR04MB9366.eurprd04.prod.outlook.com
 (2603:10a6:102:2a9::8)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB9366:EE_|PA4PR04MB9687:EE_
X-MS-Office365-Filtering-Correlation-Id: c6080461-a358-4a3a-c20b-08de74b15cd3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|19092799006|1800799024|52116014|376014|7416014|38350700014|7053199007;
X-Microsoft-Antispam-Message-Info:
	c2DmsTx4qejoN5+ailLp7tQ3VDobSlPgQnE6+9aeCTnv/Mnk+NYSRzy9IyrblRbYWb8pl4Yf9KFlURQ3ohZpMS5cPagv95WHpKmO6MGM1wgMMjN1KF+zGDhDJkSrTswDIO7u5CouwBqKruwwO8Pr8+sR550Layc0u5fVWEYr2WOzzaUeXx3hOTkA1HIDqoJnzWzmdWmQ/qq6o3ADJ6x6LZXYJlNEHTtCYWaBa3IuhJwEAafb5BdnUcccI5iUYol10wYWK53mD7KqWLJP8lDMCbnIPOIdoOAohDIcm78CdWTvXLfaoUbBKfuPCeDRNdBjop5ATFtg8XxolIKKVE+KikKD06U9jjKuCXIISJpeqzR4nlZROFKgFVKeFEOGhk1zxrpUBt9QrpVPpFLdmFLr9yo65ZhzHvvmtORoBwM/4dctp96mnZgblCRuirGzxpI8BnHBqV3xhfFHuSOswi10P/dddG8nuIYkqEdgD02QXBThDk2pdywQIQRsBzYrQ1/ulMerLNTbedJ40HAv7ymkpINVabQRJuaOsv7trfFXvg5RxFMQeFxya8aGbpHXVaRL3mtg1DcCSirvWemCj1j9QrJYzsR+r+ssyw0nNiB299ue31H0kv1zBwgCZps98YVO213lM5neFtqMlS3ZiqbVLl08a0jOGbOgLcJZOSNvIm82JOYZHKhYyOjT7DdPz0GxfU8snrPdJqZ/tSISB52YMhLMZZ7E7K9mjozYS76JBlMZDkAspMDhB/+yF0hFIQuS3HtQPlqA73+nVYJY1lNZAavR6/dnGfo/jeyWQ/wo5is=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9366.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(19092799006)(1800799024)(52116014)(376014)(7416014)(38350700014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?5aw76eEMyA1I2QM3xbamEHSnR8/ieXaP3NvigL2wStG8ksIXn2Jx9foKKs22?=
 =?us-ascii?Q?eJu3GqCwjiFartqEo4rTCzwWvzXnIPatvs2TjVDb7jM1VVAAEXY4CY9yXZgG?=
 =?us-ascii?Q?zPjAAppyp215q7O9QINBYjhHpT9j73ZdE8uusKZQUps1UZ9Guo34bYIDuWcA?=
 =?us-ascii?Q?fwQOz1/aZtFLimfPf8EU50EVldVpC7FAnBVKJHK3PYgM3mcDgHTZFHPOLito?=
 =?us-ascii?Q?fjD7PLm7nFVe2j8Wh8ic+dYPQwa/Fq1pVN26kLvFOg8NuK4D3m/NlYxnaPtg?=
 =?us-ascii?Q?jH07Dki5cWCanwTEGpGYikEcYfwaA5JrvemPw0wZmP0q98AeGHcxzQoIaD8p?=
 =?us-ascii?Q?SNakH63KjjAQLQhzgbKq/A2ChBmf1YVoQHp2PGSdls6O4HIissViBv760Ven?=
 =?us-ascii?Q?M2MYjz1OR8AGdFxjIwcywF0Ah0QmhVOrQQcLwoXWEfdP7y4hsGXG8ERuGmqo?=
 =?us-ascii?Q?DwYaGBiCHPDPdLpycy0BPSm7rwNYfmMRK+H/R+FyXhB5AOMoO4xUNDmtDwow?=
 =?us-ascii?Q?hMn6AjfrukRCO5/T3kG4j0FyU00Js8XzyMgvYe5WN5ax+QS25mbxzzE5gAUh?=
 =?us-ascii?Q?36y3UCITe+S960Ng52juYLWpcf5dW19VFwLj4EmQFy0Wgi+b1GXXDFwS4Jr1?=
 =?us-ascii?Q?ZHPeGRD5miHinDg968P+x+FRXIrlMkm4RFv+U/uPb9nVXjf5+Iow5JT2/Rp1?=
 =?us-ascii?Q?P21DEmwPXkE4aC0Oq+d0W7oXJoPd3aNpKkiyePEZy0eJdockpct+oFN/prKp?=
 =?us-ascii?Q?V9U5h2JLfYUI+2pdfxS4WvZZXr0R7k0iMgf7m2Z/YkTO/7MVjczvNMIf+qUm?=
 =?us-ascii?Q?iTp/dP/NvqriyxQ+1teourZQFw6qGlPugYcYdka6PCieugvAIBarwNJHcCZ8?=
 =?us-ascii?Q?aBjPomld04qoqs/oyaT5nhl+6X8s5Sr891CyTlX6imcjQEXlouySZF32qQK2?=
 =?us-ascii?Q?cLixyjDfXvcVqYss5HnV9BW13cWuErzhK578bjqTwq99H1BgebprEz/Zqsvl?=
 =?us-ascii?Q?0Vs8R4pUVxEhdaWx4U+3npersrl+YCCM/ZjWl0Y+NYaz62+qATyeMHWEbcbB?=
 =?us-ascii?Q?7AEZ1q1G9Q3ikTHDHQL8A6tknErX59I6AaCXi43njaglmYMqhdIo0LFXco0d?=
 =?us-ascii?Q?9ezX9uLroOEaFwOCpjgD1FVuW/7fjs+nWnoqilVBnQLtwrmfvlnxImGTjCUe?=
 =?us-ascii?Q?fkr4QtkxcVAGygvIfqHWLi6r8b1Xfi69Jo1Jo7YSZL4dQz5gbUpB+74RQxGs?=
 =?us-ascii?Q?b/SuxuhyveMsLhfREaJPbRQ8kXBPkmAEUaAEWhA4SJPyMobdeN2qx2RjDUCp?=
 =?us-ascii?Q?lRnAGhb1Tji9m6ikNXNT3tmWH3w95poQ5TCtZthMqAyWn0PQZ1UydTSpSJQ4?=
 =?us-ascii?Q?OKsbqeiuxut+FgkXvNzaCUY2PG01+sG1/WV4eGo6o/WmeNDpLAS0793HXJk7?=
 =?us-ascii?Q?uyGOX9UklXmjKdRcVu1uLweZ3O0JpJfQFUDtIF0GJPUmzKgfGGQL3LTL0L1a?=
 =?us-ascii?Q?t3xdQENCMzZWcsX6fwZQq1E5j2l6F6SmhwSAQweoUY8Yd5B8jmkZFI4+z93f?=
 =?us-ascii?Q?gCdomNwYGDgosux/xi1Blt88rJFvsBHrYK2JNle79A8Sve9mjZyJNYHgqFyq?=
 =?us-ascii?Q?KgAHl7D128nf4VB36md9e9tW1iToO0XVuRvDoDqUolcyGaObBUqnHrs6O4Ss?=
 =?us-ascii?Q?vjsTPuiAsPoXD3yx3xhug0U0TDbmlgwYm7ZAnngiQ9bLrxCyyFuCFytgX39X?=
 =?us-ascii?Q?58iDm1KzKw=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c6080461-a358-4a3a-c20b-08de74b15cd3
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9366.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2026 21:03:45.0302
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vE8y/0ixBRDCkyWY7AOrrH5dl0UtlpGBj5shQtkaEK0xwlbpeOdm2/Ls9ZQcZhiScVBxmEOgIq5LEc6Az5lJsQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB9687

On Tue, Feb 24, 2026 at 10:34:55PM +0900, Koichiro Den wrote:
> ntb_epf_peer_db_set() uses ffs(db_bits) to select a doorbell to ring.
> ffs() returns a 1-based bit index (bit 0 -> 1).
>
> Entry 0 is reserved for link events, so doorbell bit 0 must map to entry
> 1. However, since the initial commit 812ce2f8d14e ("NTB: Add support for
> EPF PCI Non-Transparent Bridge"), the implementation has been adding an
> extra +1, ending up using entry 2 for bit 0. Fixing the extra increment
> would break interoperability with peers running older kernels.
>
> Keep the legacy behavior and document the offset and the resulting slot
> layout to avoid confusion when enabling per-db-vector handling.
>
> Signed-off-by: Koichiro Den <den@valinux.co.jp>
> ---
Reviewed-by: Frank Li <Frank.Li@nxp.com>
>  drivers/ntb/hw/epf/ntb_hw_epf.c | 20 ++++++++++++++++++++
>  1 file changed, 20 insertions(+)
>
> diff --git a/drivers/ntb/hw/epf/ntb_hw_epf.c b/drivers/ntb/hw/epf/ntb_hw_epf.c
> index d3ecf25a5162..bce7130fec39 100644
> --- a/drivers/ntb/hw/epf/ntb_hw_epf.c
> +++ b/drivers/ntb/hw/epf/ntb_hw_epf.c
> @@ -43,6 +43,18 @@
>  #define NTB_EPF_DB_DATA(n)	(0x34 + (n) * 4)
>  #define NTB_EPF_DB_OFFSET(n)	(0xB4 + (n) * 4)
>
> +/*
> + * Legacy doorbell slot layout when paired with pci-epf-*ntb:
> + *
> + *   slot 0 : reserved for link events
> + *   slot 1 : unused (historical extra offset)
> + *   slot 2 : DB#0
> + *   slot 3 : DB#1
> + *   ...
> + *
> + * Thus, NTB_EPF_MIN_DB_COUNT=3 means that we at least create vectors for
> + * doorbells DB#0 and DB#1.
> + */
>  #define NTB_EPF_MIN_DB_COUNT	3
>  #define NTB_EPF_MAX_DB_COUNT	31
>
> @@ -473,6 +485,14 @@ static int ntb_epf_peer_mw_get_addr(struct ntb_dev *ntb, int idx,
>  static int ntb_epf_peer_db_set(struct ntb_dev *ntb, u64 db_bits)
>  {
>  	struct ntb_epf_dev *ndev = ntb_ndev(ntb);
> +	/*
> +	 * ffs() returns a 1-based bit index (bit 0 -> 1).
> +	 *
> +	 * With slot 0 reserved for link events, DB#0 would naturally map to
> +	 * slot 1. Historically an extra +1 offset was added, so DB#0 maps to
> +	 * slot 2 and slot 1 remains unused. Keep this mapping for
> +	 * backward-compatibility.
> +	 */
>  	u32 interrupt_num = ffs(db_bits) + 1;
>  	struct device *dev = ndev->dev;
>  	u32 db_entry_size;
> --
> 2.51.0
>
