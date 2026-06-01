Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010026.outbound.protection.outlook.com [52.101.61.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C29C3BAD88;
	Mon,  1 Jun 2026 14:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.26
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780323604; cv=fail; b=lDT4D5TkM39gobtSkjHeltS3zUfp5oadg+u0e4SBw27Kqg+pXMSg4mduGU/glgDhZ68DZ+XpBj8l0mGEINYjnQ1Z/qPJfEMEliUTNtonnAkpCeQtsOApA3IXMRGGsav2juDKv3gSPd15hnNQpZxxPbYnt+Z1FK6Yfy92x/wJEF4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780323604; c=relaxed/simple;
	bh=yoYxZvT3CLxoAw1IWoCsL6ozPK5t+yd6nNiV2By4u9I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=kqEoZ1X3MrBJ1ApqCQdR326GCa+dCxbUZBZGaNo/OAZbb4HMa47RVAcrEkbNnh1SVxM/bX3OJ/LV67oNkzp4UYlSEJ/THbrgbQTZ5CUJ0+2kBXMTcs2WnJbIEujtBVwLkaMpT4yA4GW7EcfkWJUFwRztS751C6qPYnxRAI5uWm0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=cMhMQJrC; arc=fail smtp.client-ip=52.101.61.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="cMhMQJrC"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=igE+O1G8U4Hi4YV8wpG978rv/Y0Q1RKUfCXwIb7Qsvba72YTGxyaIkCxePdQHmdlY2/KADG5ZDA7/eTTFb9z7RQPQNU/9DUBW+s6erSJ6VjDZE5jDDWjE+rKvEz9G+bgGErzzqBu+Q+oUkbhq+jIDP2vzXR0i7Ma/3Glvq/rRE99X2XMcy5rzdZ3VxRjCLvyLLso86r8MjCtKdZ7ffGs5Yur9mmv2i5DPND8DQQuYlWuIUZ7QUbaO/+rKiCx/Ar4ifracoRZ44xgzWNePgJIlO2oTzxuKsngXq9M44uPKvPTBKOaTxYg+77plpwRoumPiBGZ5Nw643I19qxdCJ71zA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yYOhKgH+oNMvNKY3VaUpL3L1ksuisTAGCJfi8tMT7OQ=;
 b=uzisIEfEkp8N3IurLXtlKM/jz1rnLSwDpoHQYSOLC0g18l351qB5Ivf2MmWxt8rz7FMz1rls4sZk1thcEekdkBcd3JC7AY9lnVvS9AJhZr90Ou/5gS8Tz3SuZxSpU2j0KcDL63c71DMiQCf4Le5k6m5WDGeNVja0Cth6/JzB2tTfjkc/WFp//dV8K/osHIgmzt9bCxkVloqM+7RtD2FvqkBY9RR7K8DAnF/ma1KBD0MNPGE+mQRVABQMg5rfrg/Zr6XYY2N8bUhtslKoXfBc5ONFPNC5nVmxWAktqmR8WtNpw2KWiRk8JKEI24cBuJPi77b3GhQaCbfk5AZZ8B5aOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yYOhKgH+oNMvNKY3VaUpL3L1ksuisTAGCJfi8tMT7OQ=;
 b=cMhMQJrCKl4N3tq2m9pgkSkllIicvx/UvjKbkjoh/MoS1ZORCOcLaUD+LbpKdox0zINBsenaUj+akkKpyNNIK0v6VtJ2BvSKgcq7vyMXS15GGp+UV6Vh0sw47yqLmm9t1ESr3IxQNNPlzpMbU5ELvO5zebuSeUCyRjR0Yy2Qfg7ZX49v0HIZDrx0aB1FhIsGxBk8XOazNl5HeOCGy7aN9PCSovFu/qUjpUSWoyOsbQpAFiTG3Iz6fVhdnVuszgUyh11/7l+qBpzY2RHAWX6w3rwg/RRYtq4Ymbm4I6YkRXSlz1+ABFybCpiAYJw3w4Bdl9+JFzG2f4/rD5xWA1YQtg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by SJ2PR12MB8845.namprd12.prod.outlook.com (2603:10b6:a03:538::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.15; Mon, 1 Jun 2026
 14:19:57 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%4]) with mapi id 15.21.0071.011; Mon, 1 Jun 2026
 14:19:57 +0000
Date: Mon, 1 Jun 2026 11:19:56 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Pranjal Shrivastava <praan@google.com>
Cc: iommu@lists.linux.dev, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, Joerg Roedel <joro@8bytes.org>,
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
	Vasant Hegde <vasant.hegde@amd.com>,
	Ankit Soni <ankit.soni@amd.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Samiullah Khawaja <skhawaja@google.com>, sashiko-bot@kernel.org
Subject: Re: [PATCH 2/6] iommu/amd: Clear DTE with update_dte256 in
 iommu_ignore_device()
Message-ID: <20260601141956.GQ3195266@nvidia.com>
References: <20260601134204.2150602-1-praan@google.com>
 <20260601134204.2150602-3-praan@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260601134204.2150602-3-praan@google.com>
X-ClientProxiedBy: BN0PR03CA0016.namprd03.prod.outlook.com
 (2603:10b6:408:e6::21) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|SJ2PR12MB8845:EE_
X-MS-Office365-Filtering-Correlation-Id: f2abae56-cae8-489a-506e-08debfe8dbd9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|1800799024|7416014|22082099003|18002099003|56012099006|4143699003|11063799006;
X-Microsoft-Antispam-Message-Info:
	KsDvg/BnWHndsT5TdZLLqh1fy/FG4tLBOUZrPsxIO/+aqvQXSaOvRfhfbwdOkIsmKUETA5rDZSVnEv/BZ/Ja/IIWwZgaG1fl3cnpNmcLf72DZF/ltDEG7zRQVMmTTMRN8GbGSN6etknBZyYhLTHUK05cA74sDcLLCTr5pUu43lqf3fglCM2ZdHwQvIP5lhpFvYuzdSMWYZjvoOngCGTDWu7raRH1+h/Yr0QNNO2rCF04lQwHVcOaFmR71lTPKLubi9f7eyGV2RlwjVszD4BC6oZ878fuRwWUof0JSzOAUDV/EJtHRfXAXK7ehlGohwhITF6E+rjnQdxd5jlFiackacQ5xSC/Nqn1jVE84KkNyvrL1nOmCL8Yo0/mCvMGnRzg6i6JzYKd1GhFJKANdiK+u39UV6Ybf3vDP75e02nJiFrj8+M2uCyMgPJs8dcY10zi2afQGDaiqE0zTZcJVa2Rt+NOlq3zgTeV1XWn2Rh718DVIb1km9Dl7QrKov+7FsAoMSdVqRYQlPbY/CobhMDw9cJSyGmrQN4mjKtKCpbL3vCr2XLDvFqitDtSElK4n2mjuCUW1eN9xh1UAMYosMdytnNK2aR6YgGDmUL4ceXAizM5rauTSQC63v3D+qpVu9zLlR0M7nOMajSRVkPFlkh9hyepgyG0fXul2tAMq4LdipZS1vsIMn4/EmUtwv+3q6MY4XejnvmE0uP2NivliVxzjA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(7416014)(22082099003)(18002099003)(56012099006)(4143699003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?JTXayYp5GhzTel2H0q+o8v5COmvZg8FSItD9O4EyWdyJM/f1Tc+h8W8snZCO?=
 =?us-ascii?Q?IyRzlnDfanpStWTu+k/RMPTuTlhMrsRrxJxQy/BbI02gmaqnvSlq3sYz+EGO?=
 =?us-ascii?Q?BZVgWHx2RmCvNRu5ab9JSbZPfPovBBRk6jVE/16jf1HAl/Ot52iPNSM3eF+4?=
 =?us-ascii?Q?NOHGB+M6kMGuj+g07Fo2ksfwO0zG8YB6KmxyIUuJMIvyo9B8t7YUZww4u4ro?=
 =?us-ascii?Q?ICLXYW2QlYGPpFXusf6cvNkCgjxn66vE1shuynfJ84qv7ZG9p57eySKUvGjN?=
 =?us-ascii?Q?Ag2HgJxhmb+dgkfl+Cjs6XymszfGm08gHyXg4JMn2zRXTjHCUxhLvkAOPm4g?=
 =?us-ascii?Q?kFAlBtJr7xN7XkO1iE4Gf6eWzPqUS0GqvY2Jkp82SLLT6Y+3zYTpUNXXysre?=
 =?us-ascii?Q?xU8jt/KEhVgW2gO54bbfByJJzYaAqeQkvBr5189dQIfFTzWT6/eG6u5uNvyJ?=
 =?us-ascii?Q?maOietvdIcUwi9ctfy781YziaXb0/mDg5IKXTDppWfWpBPukxFqG44Lv9rgB?=
 =?us-ascii?Q?lWJ2Zd4DYkbHebHGIiBEzOqEqHDHLm0LCyWVoi9BvmQvVK8NFazuYmqlzyQE?=
 =?us-ascii?Q?1MNOGyTP0re8U/72GI0bCI3bzi2FIocosXgu+lDyYFNGkTjAo0dCU9K92diq?=
 =?us-ascii?Q?t2GfYyOD+j96dL9ZaChTv4sav4lRB99ugi72xTIgiRcqBuzvxkeRctrDqOkc?=
 =?us-ascii?Q?ppaECW2Grdnovbv/UjkJEulH14etwd6f/J7E6IcMDtaLc3gBFdOr51rWLby/?=
 =?us-ascii?Q?i/lihKgK3LKk2iKBxa1VhRwgbPq3/IDjTqb2zACx/hMx2iEo0z9yQ7ELelOu?=
 =?us-ascii?Q?T3xRT3GxrBIe3CzhwD+Obj4jjUIQWIushQh1s/4GZo6yXNaIvoj+Ny77GfjG?=
 =?us-ascii?Q?Bm61sakvLMYyBsTMCR/qC3Uaibxyf7MPw4pGAEH3dChXQntRCmu6iIqNGU00?=
 =?us-ascii?Q?4m/LlhCG/gdoLGoEHUlosGaSADkeM5e3Z3LkWVe4ZhYKRIC5XwDTgMWxk6cl?=
 =?us-ascii?Q?p+9aY7dqtcMJDZT6mZCOCegZB4LXqMfDJHngLf/pAfojVVHd82uokZRFNxXH?=
 =?us-ascii?Q?NnbtbSCgbatKqEh0bC+P++zum+iTAaIxvQd1bZf78F98b7clEVMcjxpErMZI?=
 =?us-ascii?Q?m2dcD2d4EWx+6TBtGORYa5OoWjlU3QiKxT1ZU7DlhBZxuI6F9xePE8gOWG/a?=
 =?us-ascii?Q?OWtjkg8wKF/eGHf9ISgCQwlHRiWuSTL/jGtEezsg46oZkmIF2hsIv6KOZj+Y?=
 =?us-ascii?Q?0ZiDUHumaqYihXPrgSCUX9Y7mLADk9tGa5qCLgO05c1NrHeJ1vwNpCgmDIf5?=
 =?us-ascii?Q?JYwShGCVb0/Id1Eb4zMj7kcZ70Ss7m0HcaZKNKVJxloqVlBXPQ5G3O+tOD9K?=
 =?us-ascii?Q?bBAutogB5HvG7DL8rRPhsWBtATKGS3YH/HxtbKwALqA6DNnMNurQDFyuyx66?=
 =?us-ascii?Q?3Q0lQT7KtqT1gJgpM9lT80GXUAtZVJpZZo21bImY607k0hbrShzHjt+bWaHv?=
 =?us-ascii?Q?8h2gqNOlGSMTaVWZg8F2njOPl8l40qjqRFl415MAUlTgDorEkrKaaHu3o8L9?=
 =?us-ascii?Q?FmsZxbp/LKANLj5JF3yO3P95vJ8kaA4qgKJkDGqdhycPguYxmXN3jiwUQGTb?=
 =?us-ascii?Q?UD7qU5bG0jaCXBsOkOjebtxvWF5CzUf7O5QsSZhFez+7x/H58IxAH9gQ1ivi?=
 =?us-ascii?Q?MKsgGSNewlf8W3/rgMGXQ/EIjkN0eM/QDkmuC7zXZJunakeA?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f2abae56-cae8-489a-506e-08debfe8dbd9
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2026 14:19:57.6732
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4UvIpc7bJCkFhEgSfNkex/gm6ITJ8O8+DZCkn62x3q1JPACkGWAsF0ynDbvo7lG6
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8845

On Mon, Jun 01, 2026 at 01:42:00PM +0000, Pranjal Shrivastava wrote:
> The iommu_ignore_device() function currently uses memset() to clear
> the Device Table Entry (DTE), which risks torn writes because the
> hardware reads DTEs as atomic 256-bit qwords. Fix this by using
> update_dte256() to perform a hardware-safe atomic clear when a live
> dev_data entry is available.
> 
> Fixes: 99fc4ac3d297 ("iommu/amd: Introduce per PCI segment alias_table")
> Reported-by: sashiko-bot@kernel.org
> Closes: https://lore.kernel.org/all/20260529153216.2AD1E1F00899@smtp.kernel.org/
> Signed-off-by: Pranjal Shrivastava <praan@google.com>
> ---
>  drivers/iommu/amd/iommu.c | 11 ++++++++++-
>  1 file changed, 10 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
> index a94de66a885e..9b5861e241d7 100644
> --- a/drivers/iommu/amd/iommu.c
> +++ b/drivers/iommu/amd/iommu.c
> @@ -750,7 +750,16 @@ static void iommu_ignore_device(struct amd_iommu *iommu, struct device *dev)
>  	setup_aliases(iommu, dev);
>  
>  	pci_seg->rlookup_table[devid] = NULL;
> -	memset(&dev_table[devid], 0, sizeof(struct dev_table_entry));
> +
> +	/* Clear DTE if we have a live entry */
> +	if (dev_data) {
> +		struct dev_table_entry new = {};
> +
> +		amd_iommu_make_clear_dte(dev_data, &new);
> +		update_dte256(iommu, dev_data, &new);
> +	} else {
> +		memset(&dev_table[devid], 0, sizeof(struct dev_table_entry));
> +	}

This seems a little weird, an ignored device shouldn't have a dev_data
really, or it will soon be freed.

I think you are better to replace the memset with a dedicated function

/* Cannot not be used on a probe'd device with a live dev_data */
disable_dte(..)
{
	struct dev_table_entry new = {};

	write_dte_lower128(ptr, new);
	write_dte_upper128(ptr, new);
}

And then this new ordering breaks the clone_aliases flow, it was
supposed to copy the 0 from the current DTE to the aliases..

Jason
