Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.209.34
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795404567;
	b=l4AeUMkUgFEVtl6MDmaTj3UuU+CxqjEt7EjNy63gcS005Ahl2SPcNYsiFuc/H8vlYe9U
	 c47nESNlHQpe5GtzwbU5BkbLFRhhXAr5NcEGbi+IaNwmmIjUEz4euMFsLgVj75iiHNecw
	 ymr2K8xUDNcL9/0TVS7MwMPKsNvHNdgTv27uF09yXVNU+9YBfW+SQSpkrwxXSnNfMKpwf
	 Kwm8dtQesk63ZdJpeuJZtgRubC44kkQE5vb1GNZGcFFNU+pstEaIDTLy4cOJk0NOFCjd4
	 NZ1ouPL5YCoLikLvQZFg284pQjaYV0rFznPPFsLo4NUFqF/5B7BFJanR3b1P6CaBv6Q==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795404567;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:Content-Type:Content-Disposition:
	 In-Reply-To:X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=tVszMbjndaPMTNR/SQIXqX+WRdGEDtnm+7EGT5tXqNQ=;
	b=sYAnFbZDot2wR0B2s7a8OpnTM72iLrJmnyNerqJAB21Mq/DWIC2Mx8AvXO+2eLokO6Rw
	 VsHPVBcEwiD4fVI8krBrh3R5SvVuFs9h2gRUabZw9PYgbO8unf/aXuhF60gjQS/3ac+ck
	 /sv4vdDNttKFkaJ99jrDg8LyrrutB7DZbte5LDSaQsVdSpQ/u1FNbXXxOEvC9llGH6uDp
	 p3gZgJlhSc3euixa1maXVwE+8GLAFGjn9ol5mzNFhPNAoLjj9wcSo/jR0lehaXGT+OSSe
	 CGXI5PvvKfJne2kcN7n6TEztpTQeoXBLmku6lzb7CVQngxeGtMDJjGGrVHfkJANlnKg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=DIWHE8o4;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.209.34
Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012034.outbound.protection.outlook.com [40.107.209.34])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D6D4606A31A;
	Mon, 23 Nov 2026 03:29:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2D6D4606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=DIWHE8o4
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=o4KFDqwKASj8lXs0DW38Awun6I//IWjZQpfrT5CmAsU4IlIlYxE/xWe2WLtnoNGhV7fXpYeEPYuEwVqCVXGFKPeOZz4WtFE14ezKeU0ik81NnPdBmgu/rm6uJu0N6O/+ZF12rLkW9FQZ5zyqSP7IPUKnWp9JYLBuYfctqNQqF8YvYKdmByqeoV7GIR8melF3+Rvi3y5xOQAE4kh/Yjo9pbB3GG9PE7P3oLQsZyko3gyRyUI8UmjWe6+1fwUzZrzd5ThJ4gQ7EChxXRzp0eQFIF4eXYeYVOU8wYVEcBszNwgDa3gM/aRR+VLKcEaL71CiUgs6q6UQ3BfXaEofz+4p7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tVszMbjndaPMTNR/SQIXqX+WRdGEDtnm+7EGT5tXqNQ=;
 b=aQ0ID+LxqrWB5RD8JgOx1+iiQvFr0fnZX/DI+3Rb9/B9zH2Dghfpekc/uJqNqcAKNlh9W82mkQkbyNRBSYwUy5mQ8rkxhXsNtfFeruUBZJOpgfEnMBcPbWWkv/22/zNtLhrbMS1j8F+hLGNLV15WS5AObqpQAfEpULLFr6EmxnjF4ylYgYTWzxxUk5DNXRWI25nrhBVvmwPH057UBo0fz+frcig/g4yZPy34K+V28AG4+3rW0WLpN+scxCqtvTYIoVpJy3IMCEg1VD0nM6YDGlaEZkTg/1VcmXVqPSTxhFcYBc+DddDyQ7+mgajeqnuTqDy1YTjh7OpJJUJofX//Ug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tVszMbjndaPMTNR/SQIXqX+WRdGEDtnm+7EGT5tXqNQ=;
 b=DIWHE8o4leVQyCOYmUEkg/5h0g086oT71OCfwPZpHo6th1ertXG2ntAyaQ/f75lzaI7dVFlD8jiTeJdqmtj9X8Am8r5tHE370nZVk7V0jyWo5x1el63LD9Tqd0QNntsDptSTBj3XqzbpDsZ6+98qsOGXd0TrJnAP5G6Uk88nCdJzWaaQYeB/xcTVjvh9Zsp+MtdJb8jJBmtdZTiJYiH2rp32qSN7lSHeM0YFF8zVjc5J3gZTJwZbcs7cHplKqwHmGL4us9SJuquOTmD4kw83y/m1/OSLOCjJ1FzY2VH6CiQOMq/m6A+gp1OHmOrS9AwtdH6J5X9UX22knZibXQcXJg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB2370.namprd12.prod.outlook.com (2603:10b6:207:47::27)
 by DS7PR12MB9476.namprd12.prod.outlook.com (2603:10b6:8:250::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.12; Mon, 23 Nov
 2026 03:29:24 +0000
Received: from BL0PR12MB2370.namprd12.prod.outlook.com
 ([fe80::86cf:c3ec:2cf5:74c8]) by BL0PR12MB2370.namprd12.prod.outlook.com
 ([fe80::86cf:c3ec:2cf5:74c8%5]) with mapi id 15.21.0615.009; Mon, 23 Nov 2026
 03:29:18 +0000
Date: Mon, 23 Nov 2026 11:29:10 +0800
From: Richard Cheng <icheng@nvidia.com>
To: Joshua Machauer <machaujo@amazon.de>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org, 
	linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org, nh-open-source@amazon.com
Subject: Re: [PATCH] PCI: Skip the CXL state update for a VF
Message-ID: <awOxn3BcKl8Ru-QS@MWDK4CY14F>
References: <20261119164219.51540-1-machaujo@amazon.de>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261119164219.51540-1-machaujo@amazon.de>
X-ClientProxiedBy: JH0PR01CA0162.apcprd01.prod.exchangelabs.com
 (2603:1096:990:7::10) To BL0PR12MB2370.namprd12.prod.outlook.com
 (2603:10b6:207:47::27)
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
X-MS-TrafficTypeDiagnostic: BL0PR12MB2370:EE_|DS7PR12MB9476:EE_
X-MS-Office365-Filtering-Correlation-Id: 0b495c62-2748-4939-8c2b-08df4911f49d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|23010399003|10067099003|5023799004|11063799006|56012099006|261022105027099003|261021121427099003|261026121527099003|261026140227099003|261102123227099003|261028144727099003|18002099003|22082099003|6133799003|3023799007;
X-Microsoft-Antispam-Message-Info:
	SyyeIb9YxCEE5acXf85JHQ35h2gtXyG2CF03OPDhHYZPdywkqnkXx25GKlJGG8X9gl8ln4U7iMyKAznbwPBEKPy0GwDh9NX7JE/+DGgFvioePSU3bwa/QuKwLvauV3zfjZXVlatg4MA2Jfbw3x18SSplGDKKS+iGtlMmJtgb5D0kmIkXtljLyFsFM2MstVUVWPUKG/iQE+Y/R/XfdEMKvESxfwyXaSqGWEuvDrrHhMlHnAXbM+VmSYfEvXh2jd2sKmT7UyPQL58K9tJWT4ZMHUdtpQZF73VBnmReeqJzR+IjfooFtXs6Ud/wG2h4OfAsAgwgj1H0/7VjQUnOI1z1FURFSnWstbXtbSQRJGVxcSQ4dQ3B2/v3NuVLdDPfNI+QnMwCilmBTgoBqWMA12IqBQeQin5n0Ygb4pqWvNDxYG/PKi0ZjwomxCduUTWYFaJse76kjDaFgFHZvVV7r/znWXkvsrS4Z/84rTbZu7pdGTpTXTxoGExZgw1AYYc9cXfupVXBbL3pE5VtvKa6kQugNAG5StV78G+l9dt17mCuDr7fVUOQG3KzIFM0DrL1I/b6HAErj4UurObgo7O3DjoZqzFB/MOgbaGkeRmLrXmuGrEzJR0tZGRexSUPVmZH9og3NcoIsten8DZiXUgR/Ut0G3xgFGE8FSxTiFZr3pXa+8I=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB2370.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(10067099003)(5023799004)(11063799006)(56012099006)(261022105027099003)(261021121427099003)(261026121527099003)(261026140227099003)(261102123227099003)(261028144727099003)(18002099003)(22082099003)(6133799003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Rs17MgZQqj+QHEOtJkusnpX+KVxX1C4vhnUdiQnutBehEiBQ4Zo+mBgnU/3P?=
 =?us-ascii?Q?iTrhYi3gmCrP1EvEjQ7ccxoIRrPriSH3ZgMRH91rD5Dzb+f0CqAbzkclRUNS?=
 =?us-ascii?Q?y2IpnG+iECH+4qqDLlAxMcwS5P0Z/5JZlUWfwZTr4/HpYvHhy2aG64QXF1R/?=
 =?us-ascii?Q?FljL2tUUWxnUTp7XrQ/1yYqqXO4PFu+gQib0wvABF7p30P54s8iJKNhsLNrQ?=
 =?us-ascii?Q?z2Uh08frMYC06RnOdZ6AirH8xOVXYHIGcctkyYc7iRiwNA3iuo3lXGAvvpdr?=
 =?us-ascii?Q?qVSk2x72XYif3mAt1hccOC0f9qD7kygLmn372M3VIg9CJgmfrJBxNGewGIKV?=
 =?us-ascii?Q?s5mWCKk24ZIpde7+6xGZGsNhbY674ye719HOY6zBwrrdMps0t63YL252QdhB?=
 =?us-ascii?Q?8FidPx0oeOAy6lJeW4k5k3w/lnHZjLn/gqlIe6mW32/TVwzGlYQ8hvlnAiUx?=
 =?us-ascii?Q?/v8/8JKSgJPqgjqjEL8AQsu40WT8SS9wN6Y4x1ZqpNbEMiUP3BYmWv4k0+W1?=
 =?us-ascii?Q?uWebW3sPZqcrR8nV7vDiZqWZ+Vq3Dn7mhkDGz9FpRo5f0a+yosro+cp6h7jV?=
 =?us-ascii?Q?KFbQ1Y6dIHfygeMLqYP5vGQTucIswQ72z1bnRlrRASBmnLvbXbyLWntlffWQ?=
 =?us-ascii?Q?ZKFtXhhvZ7NcK61W8SvOTO826wfmWeiYMbRvwM5BxbB29QjN2nXXyxaQIKVk?=
 =?us-ascii?Q?XLa6DbBrwha9ikTePvIQVSwy5vtdyKPsfUljnaGrfqwHkZBZ8gacT7LXQS2B?=
 =?us-ascii?Q?QCaffBgwNRjtqL0nWv2xNGLgCBYSRUnUH3VJUS3NzHBe3r/+fA9Io46+vUAi?=
 =?us-ascii?Q?dw23lxHq+FIFvWuHh/3Z/Wv7HsEtf7dKLTITlpkLZD8eWwHEy27HY04HCwlU?=
 =?us-ascii?Q?NaDRMrhy769jt+X3P8wD1IWUH8ZGwApRsVNLiKFSjD35VWUnOTHJRPxeLyXa?=
 =?us-ascii?Q?DM/LCpsqMLEbj+xE86jReHQpi8nmQWjJHmMNAEJd7lhlMCv3BqRGfk1jU7rk?=
 =?us-ascii?Q?ujnimljy2P5/0N+QUlqWx5gaqxa1+PSBYkBru+Z8JYKNjc9nUXPgMVvr264f?=
 =?us-ascii?Q?FaD+4XLnfeUcKRKiCjC1i5Q1SPdO074pPKERY3AyCXPmzbJ+aVIgA/MI6Rch?=
 =?us-ascii?Q?JMjCHHfN/Rkq7igP2n5EPkF62MivElbnwtfXHUyki9XeeUzWPf04757c3wJD?=
 =?us-ascii?Q?h/zHbfFj+ck3Ko309++lihGBzLL0qKQ1M7vNuNeDO/zpoV+w9Val4chPk/gv?=
 =?us-ascii?Q?jDR+9cfxwAR8qReoZS6l+I46dOhjzeLPQcaJO8d1GJGZtKAcrFzEVYzqZz61?=
 =?us-ascii?Q?KtwGxCpVKzHtZ5hRkbBZ4tx+lSkAOe6JID+bnReMD625sQUJFfn60ThpKsWq?=
 =?us-ascii?Q?VHVEFh3/Q99ZUZW3wbjcQKef1YkdaLcnLmi4HIeIviTmqfjQbX9nGyAJGs3B?=
 =?us-ascii?Q?yCjXtEj/2tXV+H8EXA9FpjvQN0AIWfEPcQAUaaynRK6wCHzJ6yE57Vv8kb33?=
 =?us-ascii?Q?wpIksOZEaY4QGwmwF5J07rhkmVhAomLkf8PX3gervGmm+sNOaoCNkIe3UBev?=
 =?us-ascii?Q?JvyLRl5434I8W4Iq+YSO+GJdv8yb9rnWKYPGVKctkRIFQ9hw56+UuNHynSS5?=
 =?us-ascii?Q?SEk828odZYu6y1TRp9eEdNHm/E/BStCPm1kO6ZPRX0i8rtABj+BszU11qd0O?=
 =?us-ascii?Q?IuoMVdgqL0zavb5hqHg6mYYoYBbDiEqbyB4ZKpu4z5SAwDPJRoBYG9uIQjf6?=
 =?us-ascii?Q?JLqIAeGUOA=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b495c62-2748-4939-8c2b-08df4911f49d
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2370.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Nov 2026 03:29:18.1124
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TVFCkUzdZG5P3iiegblvGVGslLPU32yq5ACIZFOrL0sEhxODiWtAGA3zVEnLxULDp+w32etFookFk0eaOnnolA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB9476

On Thu, Nov 19, 2026 at 04:42:19PM +0800, Joshua Machauer wrote:
> set_pcie_cxl() runs for every device that is added. It first updates
> the CXL state of the upstream bridge, which walks that bridge's
> extended capabilities and recurses up to the root port. It then walks
> the device's own extended capabilities for the Flex Bus Port DVSEC.
> 
> For a VF neither walk can change anything. A CXL device exposes its
> Flex Bus Port DVSEC through Function 0 (CXL 4.0, section 8.1.8), so
> the search in a VF finds nothing and the VF's is_cxl stays false.
> pci_upstream_bridge() resolves a VF through its PF, so the bridge is
> the one that was already updated when the PF was added.
> 
> Enabling SR-IOV adds the VFs one after another, and each add repeats
> both walks against the same bridges.
> 
> On an NVIDIA Vera system, enabling 256 VFs on a PF whose upstream
> bridge has 18 extended capabilities takes 296 ms instead of 402 ms.
> Enabling 32 VFs on a Rubin GPU takes 218 ms instead of 235 ms. The
> times are for the write to sriov_numvfs, with the PF bound to
> pci-pf-stub and VF driver autoprobe disabled, so no VF driver probes.
> 
> Return early for a VF. Every device keeps the is_cxl value it gets
> today.
>

Hi Joshua,

The fix looks correct to me.

One nit on the sentence above, before this patch, each VF add also re-read
the Flex Bus Port Status of every bridge above the PF.
That refresh is now gone. I don't think anything depends on it, but
it is a behavior change, might be worth to mention it.
 
> Signed-off-by: Joshua Machauer <machaujo@amazon.de>
> ---
>  drivers/pci/probe.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> index 9a178e0e5f7f..34acebd1c706 100644
> --- a/drivers/pci/probe.c
> +++ b/drivers/pci/probe.c
> @@ -1717,6 +1717,14 @@ static void set_pcie_cxl(struct pci_dev *dev)
>  	if (!pci_is_pcie(dev))
>  		return;
>  
> +	/*
> +	 * A CXL device exposes its Flex Bus Port DVSEC through Function 0,
> +	 * so a VF has none. Its upstream bridge is the PF's, which was
> +	 * updated when the PF was added.
> +	 */
> +	if (dev->is_virtfn)
> +		return;
> +

I would like the spec section to be cited here, CXL r4.0, sec 8.1.8
"PCIe DVSEC for Flex Bus Port"

>  	/*
>  	 * Update parent's CXL state because alternate protocol training
>  	 * may have changed
> -- 
> 2.47.3
> 
> 

A wider question, not specifically a request for this patch.
The repeated walks are not specific to VFs. The recursion runs for every PCIe
device and goes up to the Root Port, so every function added below a switch
walks the extend capabilities of all the bridges above it again.

Is the walk to the RP needed, or would refreshing only the immediate parent
would be enough ?
If it's the former case, we can cut more cost for non-VF devices too.

Best regards,
Richard Cheng.

