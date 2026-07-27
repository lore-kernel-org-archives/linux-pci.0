Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012053.outbound.protection.outlook.com [52.101.66.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89260429CE8;
	Mon, 27 Jul 2026 21:28:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785187709; cv=fail; b=ZXEuo41B5pXQ2KbWTizqZ5iQkT2npk7WqZumqPq+scN7C3/ck1aA6KUlRBvwUSu+L8B4UbRvePUUclQGvATeujHe5kOdQEFlReB+y1O3Ey3WhW34XavE6yn2X/vGx9BRlJ7shMfn26naGNNqmzX3MIxhVe4gjTWWrHXMJM7xC2o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785187709; c=relaxed/simple;
	bh=D9hR/NbiWj8MNuNT8yV+2kKr6em5GSD9XnVI6aKcjPY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=VSNGdMyML7k6p510wlWNsQDFbwvKRLQUCzseGB1jaw+80PxsCEdavTZfU2DplgmYFCIImqdJUJimDTu+CCe1kcJlKGfl00UIcuAMoZ13tnTPGNDWQmAj7Tl3u6xa7ji/sJuWofoK2y/e8+13AY3SzRKeU/0bs/hqkZCfuHz1QR4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=lvdjafwJ; arc=fail smtp.client-ip=52.101.66.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="lvdjafwJ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=u0O3DjEJAktIRahWbRbWmL6na7GnC7goDwwz1vFeHmjwGcwHHc0wxmvjXOAUUkIBSPTg2YFbdYcXzSvXXklMYoXtDzikNXJlnadeB6I5ASBUtmK2tHSubqzI/hcG6D0VHKcSeXxOp1c3YhM2lLha8EJ9IwcQOthg4LOKO3odfp7hNwrSvk44cMnm+Mkbqu7GEZRxTpLDjB0FeZqWamjaQUqkR/WXn5YVYz2bgfzRwRz9PYvJXDp5Bi8nCxvi9yC3OGarKA33HTCyZg5k2LnvhHrdo2FBJ9mYXZSlaWYw20DEFd0OutukGnwjiLbeR0hxU28AcIDOjUZLDXA+ntLIbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yosP5qA9avjxLuGTkLqX8uS8CDPYxsmrPhIg2wm/ZQs=;
 b=YltmTY8Xrdvv/xZ456n1wQYqpsir0HOZ+TJvZWz2EB3V+1+atnqC8xb4eIuScUR2UhDZHn/QgOiFqLp95IU2/yqDzwCIc7V4Yq8S16zWMIxFhGM+8B6uuM+UWd8yjCs20EkL5f9jaPKlckhmYkzL92BmeFDHZZlcMVY48I0bDa5mGpYZwGFe5h8UevB4JRIVrH83tNnI+Y7gNW4OL/FvwBZm/B4HgzFQQMQXcEne+EJmPlxIvWgJTDbsJAVPh86pRY4RVUY1EeG7NwWVOtxZ7uPUa/byNDX3jaXfuWNhl6qsjpI2EZyuAD2c8FQGZ+d4haQWtqK7X/3fpvxmxjm1Fg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yosP5qA9avjxLuGTkLqX8uS8CDPYxsmrPhIg2wm/ZQs=;
 b=lvdjafwJ5pQYAr3WBwLwcI1rNA7/OKCRjTVuhC/YAUI5x0wj3pm34k5JGRpvK0+xme9y6Tp6gSggWhmpsNxnGfMSfCTe7OR69ZrcNkTPh0MSU2xC5AFqY+9IN6Hu+B2t5tunggsWOXUmM35PMjHWGXP/YURLOrCZxMva6SQlpSvCoBZUxapgQXXSSW27lMfq8RKA0MkK6mvmUq2VhP5a9G6thPB0LvnGtgQ4i1fSyhH88onwUasXLz52dJufJ3NhzXFLNYKH1Y3/E5FI2vDWsi5F0tOXJ/jF2BERf3IQkWNCgHqHHtWAeC/xiiNqH+N3ZQo1OHiUM64S5zP4g7NY8Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9)
 by AM8PR04MB7811.eurprd04.prod.outlook.com (2603:10a6:20b:236::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.13; Mon, 27 Jul
 2026 21:28:26 +0000
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c]) by GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c%6]) with mapi id 15.21.0245.012; Mon, 27 Jul 2026
 21:28:25 +0000
Date: Mon, 27 Jul 2026 17:28:18 -0400
From: Frank Li <Frank.li@oss.nxp.com>
To: Logan Gunthorpe <logang@deltatee.com>
Cc: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	dmaengine@vger.kernel.org, Vinod Koul <vkoul@kernel.org>,
	Frank Li <Frank.li@nxp.com>, Kelvin Cao <kelvin.cao@microchip.com>,
	Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>,
	Dave Jiang <dave.jiang@intel.com>,
	George Ge <george.ge@microchip.com>,
	Jaeyoung Chung <jjy600901@snu.ac.kr>
Subject: Re: [PATCH v3 10/11] dmaengine: ioat: use sysfs_emit() in
 per-channel sysfs show()
Message-ID: <amfNctdEWzFmxOcO@lizhi-Precision-Tower-5810>
References: <20260727181526.9672-1-logang@deltatee.com>
 <20260727181526.9672-11-logang@deltatee.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260727181526.9672-11-logang@deltatee.com>
X-ClientProxiedBy: SN7PR04CA0156.namprd04.prod.outlook.com
 (2603:10b6:806:125::11) To GV2PR04MB11799.eurprd04.prod.outlook.com
 (2603:10a6:150:2cf::9)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB11799:EE_|AM8PR04MB7811:EE_
X-MS-Office365-Filtering-Correlation-Id: 7d592620-0cd7-410c-528f-08deec25fe4f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|23010399003|366016|19092799006|1800799024|4143699003|6133799003|56012099006|10067099003|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	kZfuMEM0D4haokQWmeYTqWCx/GOHvVWoO/8zlnxIqCf+X/sZROPaDfrxzML19epPeGx8lpVoeVC76Ri2Pu4FFauEb96MTFDfJwnkFdDxuFQrhdNl/6JiIdT716fwjCJJQElBWmq54rtscLFw2F4X7mqBJ2gLXWsyMcNen5dBAK6KM6TNbQkUEEfbO3aNEPlgOPebrM5pSGA/dTaZwFt05IlMHHvAHzJp/hF11rlPkY1eol1EeX4xYk9xs5jgA7y7zZCi5GDhkwbdOpNp+qCRkLc8RjjpTK475NGubibpO/Qdb4wqqwtkjkp+HvDpD/cLIrzdtTLsguloViVl7oBQpg89qvuIsc+zEIvEKrp370vfhufISZLGIjQq4UP5iXpl3HhOL+b5Yrt5FW0AZjZ7mO1xaVz+M/q+C9Its7Hr6l/ZGQ39nLLCCm0EAYO7nkvRGc7u9wxEIlzyYbN5N9VXsM9gUvXbntG3aUjFU+ykXNefn2XeMv4EoiG2ja4vmS35tN1LwHMiAN+61C7GREUHyiGm1uSGs0Wo3RwfKMaoSlMvbrpkR8R18O+B4Q9r5A2qVyvV+9T80aQu+RrgjzrD/gF/ZnSG3VVZFxZVISoL3TLmd+/1fynjSt3/OelplwoLzq6gx3OVQtpQGNulIcOUXWH0gzLR/vRdZhzhL1XNQRA=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11799.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(23010399003)(366016)(19092799006)(1800799024)(4143699003)(6133799003)(56012099006)(10067099003)(11063799006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?8MOXwwHj2Udi+Bzgv7KBfiz/KmbI+mbrOg8iigN55sKTT0v2cahCSGzjXLlI?=
 =?us-ascii?Q?0n2JfNNkK4A23t8fWc1JiT5MzHqv9VT5dthIK2Po1SmUGrmQq6nXdvtucrvD?=
 =?us-ascii?Q?nD5CI5C7MHvnbjFMMWKuYxktBaIAA8OjAZoUb2Y6wELrakIF4j9D7o3liU6j?=
 =?us-ascii?Q?jxF4fA0qZqScgIA8oKqP2z0vaycZruGvI1tp5WBnBQ9L3mDeNoVfzpiGjy4u?=
 =?us-ascii?Q?wRPRj3tj1bm4J2+EqI14qqiXya8K+89gETqhgFf7JZKL6ZSaNEYFVJtWny7T?=
 =?us-ascii?Q?5/myHt64XjvJ9cPKwVzcowaSft+EaamSo4YvKmN18PB/gGd2PFsLVKlrjRuL?=
 =?us-ascii?Q?r/ps47kHf5oq4Os9DS7GeiS3VVS1szzG0nYuA6B560QojdPmcYZXWumpNH3b?=
 =?us-ascii?Q?JAChtLKH5djabfl0IeNHAkz5bQUDdABSye85K6pMZ942LVK36Hyl2zSzfADR?=
 =?us-ascii?Q?OS6K8jc6UALcymlIenQzJJNACHJ+4rPIQHBXK+YaJ3M4/jOnoI+D+cQVcbK0?=
 =?us-ascii?Q?fe08WTA7kNIyn3RnfExB2WFp+qAprdo8JK6unV0tVReOQtrXXEQQrZHXSSo1?=
 =?us-ascii?Q?XPBOdrdwEc5e0aexLBKfLTvNB9SWMB4iaaJV9gpIKL1Zg/xcEZ9Bv83333zv?=
 =?us-ascii?Q?xgv+TwkDoJyqnK4ykP4T9txGizKrPKs+hlzSHLWwpUgspnNfk5z4mwio6JfA?=
 =?us-ascii?Q?uQ+aFxyY2i0afYwXuuE615+mqqg8xcOgE79z/+PyZ5wCaSoXK6RUi/9yO8IW?=
 =?us-ascii?Q?2En3hm5ZiDcOc7DOMGCFKtCFI7GY2LH8kbrHLJZSCKkwVspU0lHMinQYfDti?=
 =?us-ascii?Q?hLa9owXdwp+aeZKwyjnHCSS+i7zJYUjct0RubtHQAnQpoXyLZ46NNfO9CJvf?=
 =?us-ascii?Q?y6Iiuf3qBfkNcoBQHZZPgG3Iu88Gaq8FJEBiFkyQkiGGGhhXaKONk8w9bxey?=
 =?us-ascii?Q?7M/F3RMAISwP0QPwjedd46rMudQ9nOdBzuh2CmJQlPfbJ7tH5nVDOw6w0qBJ?=
 =?us-ascii?Q?D1UeFYYITjS6HfuvJzlUpPiO/MDj8hAcWd66ZAys8Xp4eB0KHO1/3UXi/a/X?=
 =?us-ascii?Q?eXaNalZWQ4jHddfb7UirjhDUIdaYL7xyZKSdC6ahMEB2NAs4hSovY3p5acXN?=
 =?us-ascii?Q?rnTDx1c0qOdP1L7wfCpupYDYviHSZAJkqOe37BBUTgbgIExODu5Y0H3/cYw1?=
 =?us-ascii?Q?4nSGddibJhQqn78tctp17Bd8OxZVV7JRrY+dzprN721qyCvWx9Cl+QOWhXwd?=
 =?us-ascii?Q?lP8DWZN+cn8uyaVZoDwCt3O97rKgqgURPYdfOvCleD62P9YqreXPalt0zeC0?=
 =?us-ascii?Q?susePo+7Lb/dzmx1gRM1Ooy+/hxiM//KGM57QVj32huyThbsERE5FrdqdY78?=
 =?us-ascii?Q?wtSO2/nixmqQRP/+yXOCjMprtHA+hG6AfzxNT6zbv3cHWL+s4enA77sAw9+n?=
 =?us-ascii?Q?AXie6f4za3YX4CGHfI8HX164DLnPAqZel+nWIIkS6tSmJJ/jLS7nm1Fgj2F9?=
 =?us-ascii?Q?oB7ZFjngV5SHEpwHSib1nfYQRrzs6xbjInHk1kBQILnnk8ezeb2Q/zu0DnE3?=
 =?us-ascii?Q?m/wjncM37s4XtQDGPX9owkC7C7A+UigypGgw3UguOgqbS1gum9RrJxzCPBhr?=
 =?us-ascii?Q?rqCxZhaT65d1sdgfS3QUA4J8xQBAeOlcEpOjxgtm/IytzQZxNJHjMRJw0bml?=
 =?us-ascii?Q?rANo6YZ9mcTNG78uXgczILFOZoTLi2kzEXmb5I5uzE5k5W9UeJ6ltaEw2wGF?=
 =?us-ascii?Q?5r67uKNEWAndrNKhClaw76AZtnSbUKPApitzj5rqUv14uSC3BNbZ?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d592620-0cd7-410c-528f-08deec25fe4f
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jul 2026 21:28:25.8997
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1r5KhX5q/Pt4kD5bJLV3Q45ASKCK22pTLmZv2X7Gm4vm/txDsjZ+uWYAa28h4rC603uQ5W/DzLyi2msfq5i0bEhPTnyApqHVUaS1zYyBsZ49vi/PpdNOLJAoqgHSyPtq
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7811

On Mon, Jul 27, 2026 at 12:15:25PM -0600, Logan Gunthorpe wrote:
> Convert the sprintf() calls in the per-channel sysfs attribute show()
> functions to sysfs_emit().
>
> Acked-by: Dave Jiang <dave.jiang@intel.com>
> Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
> ---

Reviewed-by: Frank Li <Frank.Li@nxp.com>

>  drivers/dma/ioat/sysfs.c | 22 +++++++++++-----------
>  1 file changed, 11 insertions(+), 11 deletions(-)
>
> diff --git a/drivers/dma/ioat/sysfs.c b/drivers/dma/ioat/sysfs.c
> index e796ddb5383f..976134df8108 100644
> --- a/drivers/dma/ioat/sysfs.c
> +++ b/drivers/dma/ioat/sysfs.c
> @@ -24,12 +24,12 @@ static ssize_t cap_show(struct dma_chan *c, char *page)
>  {
>  	struct dma_device *dma = c->device;
>
> -	return sprintf(page, "copy%s%s%s%s%s\n",
> -		       dma_has_cap(DMA_PQ, dma->cap_mask) ? " pq" : "",
> -		       dma_has_cap(DMA_PQ_VAL, dma->cap_mask) ? " pq_val" : "",
> -		       dma_has_cap(DMA_XOR, dma->cap_mask) ? " xor" : "",
> -		       dma_has_cap(DMA_XOR_VAL, dma->cap_mask) ? " xor_val" : "",
> -		       dma_has_cap(DMA_INTERRUPT, dma->cap_mask) ? " intr" : "");
> +	return sysfs_emit(page, "copy%s%s%s%s%s\n",
> +		dma_has_cap(DMA_PQ, dma->cap_mask) ? " pq" : "",
> +		dma_has_cap(DMA_PQ_VAL, dma->cap_mask) ? " pq_val" : "",
> +		dma_has_cap(DMA_XOR, dma->cap_mask) ? " xor" : "",
> +		dma_has_cap(DMA_XOR_VAL, dma->cap_mask) ? " xor_val" : "",
> +		dma_has_cap(DMA_INTERRUPT, dma->cap_mask) ? " intr" : "");
>
>  }
>  static const struct ioat_sysfs_entry ioat_cap_attr = __ATTR_RO(cap);
> @@ -39,8 +39,8 @@ static ssize_t version_show(struct dma_chan *c, char *page)
>  	struct dma_device *dma = c->device;
>  	struct ioatdma_device *ioat_dma = to_ioatdma_device(dma);
>
> -	return sprintf(page, "%d.%d\n",
> -		       ioat_dma->version >> 4, ioat_dma->version & 0xf);
> +	return sysfs_emit(page, "%d.%d\n",
> +			   ioat_dma->version >> 4, ioat_dma->version & 0xf);
>  }
>  static const struct ioat_sysfs_entry ioat_version_attr = __ATTR_RO(version);
>
> @@ -118,7 +118,7 @@ static ssize_t ring_size_show(struct dma_chan *c, char *page)
>  {
>  	struct ioatdma_chan *ioat_chan = to_ioat_chan(c);
>
> -	return sprintf(page, "%d\n", (1 << ioat_chan->alloc_order) & ~1);
> +	return sysfs_emit(page, "%d\n", (1 << ioat_chan->alloc_order) & ~1);
>  }
>  static const struct ioat_sysfs_entry ring_size_attr = __ATTR_RO(ring_size);
>
> @@ -127,7 +127,7 @@ static ssize_t ring_active_show(struct dma_chan *c, char *page)
>  	struct ioatdma_chan *ioat_chan = to_ioat_chan(c);
>
>  	/* ...taken outside the lock, no need to be precise */
> -	return sprintf(page, "%d\n", ioat_ring_active(ioat_chan));
> +	return sysfs_emit(page, "%d\n", ioat_ring_active(ioat_chan));
>  }
>  static const struct ioat_sysfs_entry ring_active_attr = __ATTR_RO(ring_active);
>
> @@ -135,7 +135,7 @@ static ssize_t intr_coalesce_show(struct dma_chan *c, char *page)
>  {
>  	struct ioatdma_chan *ioat_chan = to_ioat_chan(c);
>
> -	return sprintf(page, "%d\n", ioat_chan->intr_coalesce);
> +	return sysfs_emit(page, "%d\n", ioat_chan->intr_coalesce);
>  }
>
>  static ssize_t intr_coalesce_store(struct dma_chan *c, const char *page,
> --
> 2.47.3
>
