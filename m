Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11011031.outbound.protection.outlook.com [52.101.57.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A06D42B338;
	Tue, 21 Jul 2026 07:33:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.57.31
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784619220; cv=fail; b=VJVtAyRf8dwP9Xy1hsf/eYb5JWuzMd0TqpUimm106+IizyeMA/R1TucIEk5jE5aglfYG8qUVovt4qajm1bTba8Mz/hIHRk0c4n+WmmoWuv/B63gW9APWe1Ep3/7k74tu2E+4tkH+f0kW1ThtFr8kbTu1U9q8/0E8cRv+LZFR1QQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784619220; c=relaxed/simple;
	bh=XqTHry1BJns/eNRTYZ2V4wRZKNnlJel+0KdXeogot28=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=DNe2CeDqECTbbflxCRQ1z+6Glp7+DR9pVFxAAixgVbQH10mWd3mDMzCH8fG113JDmexqr2Neq0IO5Obstrq/lEDgH1w/2p796QpsuYHLFRBeiSQpaXuVi5cDkxQ6pt6xLsf1nslKDzmPHDT0Q/JdPc2IYariFmR6S9onc/MvbGI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=YQznzkmh; arc=fail smtp.client-ip=52.101.57.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="YQznzkmh"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eSgKxkbNcLtrXevyd3C4V3uAZxhI8KGxpfsEn/+oMKVepeaEtK7pJQOAO/rZ3NQVWdCK8WR9jcwbh8EAayOXuqlmf1otIFbPWtpCEvp1vYe7/pnsPkUEhzcRgBbaW8oxGNO8DsCMB01v+d/f7+R3XB1Y1SmyWn+Qk1uqPvRovUbAAdJcCghe8qII7JCe/CJk/PvIWnG/CrnMIBLPTQVXyE1ZDE4SzyjZhznYBV0H8BrqHDvVDMCiSYXjMpjwiYM/XRZz01sj2lnY4ZAapTYZYMUOd0CGXfSU5JA8qUb7fFa7C2rTOeWKPLEqEzE0w9IpXjL7AhA8jI92J0qR0BHc2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aW1UKIvRgiIR1txaaTkqV3VElki/WuNaqfXBdxd2fz4=;
 b=n8TPUeJbGMvqxuem0SrEVRhWlyXEE3CvEy6pgcxM2az/7BoDz/JCPhYIJuThr6tWB2U+CjKG+mzYbVprLc0e2EuSmCYe8AumnI6vDxW2s1aeALUD8Ou95YEls97+AaFk3LcMKD2EbF1lzRsixGv2etMetI3ysnnZMQHXeD+XiDuMbTt2lJtLLqqcSVO48HlGqI64kZ1sVkuJXsTtUFPYXQVSfOzDY0Kuoz6INQNGBpx0xavJXXW340iKlWzJyOU5voB+pn6VloQRjjirQn6/MOjDqO2UJMIQMGmpz5+Ujz048bvTCXSbiFQqnEuUAZdJea3CMaBjm3hn22idpY+azQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aW1UKIvRgiIR1txaaTkqV3VElki/WuNaqfXBdxd2fz4=;
 b=YQznzkmhltBvw1xe2V/MRe2QvdSoQ86cU2qI+Y8pGA3kdwddNgp3LPJvYO8PITdJ3Ku6Zst5N2vpDocLesAhWPkyGn2E898B1df/qLvgV73PdHqQBCikEwfKxLkWVvUxLmXfH9UKu25MavvEdixOo0lXGDbsxq+rkcjQ+45pGET/TybATlzrwXnAGU6f5vZzbEK841c86jkQ8kFW7yBvsK36c4o2Cg7u0XboHZaoQX03c2eg8rgUYMCf5/mJQkCfImLMwSzqIf8kjszzlnP6QXXNINHi6Z/EJRDsBVnQd49xxmo7N4Pw/H0AqjpIOLxLWt/lYAjocMZ1M4MPZQ0OVw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB2370.namprd12.prod.outlook.com (2603:10b6:207:47::27)
 by CH3PR12MB9251.namprd12.prod.outlook.com (2603:10b6:610:1bd::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.18; Tue, 21 Jul
 2026 07:33:27 +0000
Received: from BL0PR12MB2370.namprd12.prod.outlook.com
 ([fe80::86cf:c3ec:2cf5:74c8]) by BL0PR12MB2370.namprd12.prod.outlook.com
 ([fe80::86cf:c3ec:2cf5:74c8%5]) with mapi id 15.21.0223.017; Tue, 21 Jul 2026
 07:33:27 +0000
Date: Tue, 21 Jul 2026 15:33:21 +0800
From: Richard Cheng <icheng@nvidia.com>
To: Herve Codina <herve.codina@bootlin.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Rob Herring <robh@kernel.org>, 
	Saravana Kannan <saravanak@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, David Rhodes <david.rhodes@cirrus.com>, 
	Richard Fitzgerald <rf@opensource.cirrus.com>, Charles Keepax <ckeepax@opensource.cirrus.com>, 
	Linus Walleij <linusw@kernel.org>, Len Brown <lenb@kernel.org>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Daniel Scally <djrscally@gmail.com>, 
	Heikki Krogerus <heikki.krogerus@linux.intel.com>, Sakari Ailus <sakari.ailus@linux.intel.com>, 
	Davidlohr Bueso <dave@stgolabs.net>, Jonathan Cameron <jic23@kernel.org>, 
	Dave Jiang <dave.jiang@intel.com>, Alison Schofield <alison.schofield@intel.com>, 
	Vishal Verma <vishal.l.verma@intel.com>, Dan Williams <djbw@kernel.org>, Ira Weiny <iweiny@kernel.org>, 
	Li Ming <ming.li@zohomail.com>, Lizhi Hou <lizhi.hou@amd.com>, driver-core@lists.linux.dev, 
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, linux-sound@vger.kernel.org, 
	patches@opensource.cirrus.com, linux-gpio@vger.kernel.org, linux-acpi@vger.kernel.org, 
	linux-cxl@vger.kernel.org, Allan Nielsen <allan.nielsen@microchip.com>, 
	Horatiu Vultur <horatiu.vultur@microchip.com>, Daniel Machon <daniel.machon@microchip.com>, 
	Steen Hegelund <steen.hegelund@microchip.com>, Luca Ceresoli <luca.ceresoli@bootlin.com>, 
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>, stable+noautosel@kernel.org
Subject: Re: [PATCH v10 10/10] PCI: of: Guard against node removal with
 incorrect np->data
Message-ID: <al8faCx6ydg7BI9h@MWDK4CY14F>
References: <20260717145147.823749-1-herve.codina@bootlin.com>
 <20260717145147.823749-11-herve.codina@bootlin.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260717145147.823749-11-herve.codina@bootlin.com>
X-ClientProxiedBy: TP0P295CA0005.TWNP295.PROD.OUTLOOK.COM (2603:1096:910:2::8)
 To BL0PR12MB2370.namprd12.prod.outlook.com (2603:10b6:207:47::27)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR12MB2370:EE_|CH3PR12MB9251:EE_
X-MS-Office365-Filtering-Correlation-Id: 2f1ad0ce-3e9d-4bd9-f4b4-08dee6fa5aa3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|23010399003|366016|6133799003|18002099003|22082099003|56012099006|4143699003|11063799006|10067099003;
X-Microsoft-Antispam-Message-Info:
	aZ7293Rn8/ZOD1eRG9Xzn14GW2kuVI3cGOBSPTZokegLJ55zgOuRqhmhv3/zuO+6a2LQ/BQTlZE1449K5pq1skf3F4VFubS3P+WOxmO95i6A1v2ws2m2Xw0DGtMX4PaZhZrU5cej7dXormiXRNY5dw7+sYlb7wl5oMoB9mgHUt35pXWaQKgyPt3DhKcRt8L45l/PChlFBpuKWvwrsPVBA8qSeDYbKvEHHer20oSM6pjOnicgvku357QHfyFFZXVFMf4Ikd61bpm3YW8eRD81Gl/ePg8ciC5lXjCqtKjbXDnzDMIM4oHtHAP1uXKcDaCFiOogpIVssnCNLlNsaEK0GmalkC9IB12WJoSlOETllfO+xVOjYsTtGBw0+cD3r8iNOko1iOgR9+PM5KM7KogbhcdtcO/YeaYqLKSzp6ERmAUHbm7FCQDXYkWFTUVE0jz2ehxRWyBEFHElesvWH3oZrbd/sXxzrYA+ZiDVxbcgDhfVptHvUDO4mOpwJCvGBWo34N9y0BbqADnotbujpT8r7TD65RcCQ66cub+nbE8sJiouZsrftNZd+X6pwPO9cVIYJcyDLYkBQ1+HKEJZwTvNJf4hoqPTxvYiJY1pw2z2n+KVBZI5aAT0fdlZ6pgY+6depxYtk6unO2k9TE+gVoUqGim2Ny/QfwEJERTp8Kfdozw=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB2370.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(23010399003)(366016)(6133799003)(18002099003)(22082099003)(56012099006)(4143699003)(11063799006)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?TeCg5XIBcLTRc1PY/CphjzbEIxfieN1dDPCjqAVR1/EpwWT0EOHu2FOBJBiA?=
 =?us-ascii?Q?LAY422CvGJxRanzkSv/ie5+KfMmCDFlQTcalsOg8Y1FB+kuGXsHmNVI4r4kM?=
 =?us-ascii?Q?nHTw3sx7ipexNHXfo87Em9eTAS0dIAJVeo+W2z/iUeTrffyUh/wAIFczTpAS?=
 =?us-ascii?Q?RSK1INfU0YBCPjITF0PMGXDKeEn4F+KXhOmArkkqlYtj/B+os8+5Y5JjO+aO?=
 =?us-ascii?Q?JdpGu6ogQZBiZglcC5kj6w1RbHyU9LNBBaXgjLmUoN/+QcvAsLVh0foXAGGq?=
 =?us-ascii?Q?DN93ncxW3CKFHXWKr5tcX+iqkmT7X+YmdMRQb6nIUP6JbxyPOiZubAZK44D3?=
 =?us-ascii?Q?BOhijsf5VokkPwqBmnjvjRnrS3lKg2VRmlSZhK0/NHvYEK7iUVXbPFAOH6ce?=
 =?us-ascii?Q?6tQ3qKeoX+WX6S6eOU+W2nGuFus0QJ34veToXzsxDIaX8dMIxpDFjzsAYcqH?=
 =?us-ascii?Q?nxKnv4lBobxbRsVvJ03EtjHQyYdkY9qF0/4zPi1QC7m1WHcFKWPiNk47bucs?=
 =?us-ascii?Q?vIMWl08lGoJNr9wrlkNm7Qz1gUZ0vvus3YdHjPuP3ddays/MacyA8mfKtecH?=
 =?us-ascii?Q?NXrssIVdKMTNQefvgoTK4SRTiC/IJtLBY1ris4ll/ICJPT+v9iMNlLzT6XD6?=
 =?us-ascii?Q?pGPaLdhmw5cl2U5QPVMiNkw8+J98I66GcRuC/6SI3DqqCUnRhO8zkoGFrQTG?=
 =?us-ascii?Q?/HdSHaI6recXnPSalETWDFxCRNwtE0fGJJZrYNkxnSkZeTtUS5oDWKnRM6ZE?=
 =?us-ascii?Q?ZN7kV4kFq18IsvADUnzoH6DjO7cdyyYx0ChSumMpueyh/wXW0j8fZWLUzalR?=
 =?us-ascii?Q?qbo+EYI/3/dQpoSQMuYfCeuHepga9p3gp2k/m8fEDp+IaQ69GJTzbXNKMp5L?=
 =?us-ascii?Q?6ertNZNjCnyTuuG+bbgEwnz9x2Nx66C+h4medMf94ZZw3pBl/NW0VVo7BoPr?=
 =?us-ascii?Q?y7n3vuqNDq1NgU0Bw7/sB1UKlIoAFdgs6WshjmL8+FIC9CA4bpuqgQwocrNP?=
 =?us-ascii?Q?QKdtmXzR+bADWVJWPbU07AS7sANLUYwnuMHqsAxagL+0SVhYM5WCOR7mPOOv?=
 =?us-ascii?Q?JLy+3JyPjMA7JjDop9+qxvkdR6CnK2bY6b9Niq12E9/0vhSauAkECjsZ8wad?=
 =?us-ascii?Q?4o0oDTj2Yrzhf4Gd+6LriowzrK3eTgVxs+H0MLcm0/qOWLM8roxkG1Dyn4c/?=
 =?us-ascii?Q?aiq2JnBDD6hoEWITexBmkdiW0grUcTsLhz64/eKuTAhBndyCKgBUQ8oV/Stj?=
 =?us-ascii?Q?yzo7sMEniDW2cLmUM7rVST54GHDH+u8ZAH0seVfi+EKSJz4+nwWHR67Tk4TR?=
 =?us-ascii?Q?N1pwcmyYN+Byst3bZ34MMBSFjh6hwfvjYHZcnj941EE0KRRDB7QYNRj+eY/H?=
 =?us-ascii?Q?vYQLqmW5nh6iZCUyGM/COyDJR96oBGISGlrHcDAsvCYcEc6XvBv+uGe7oj8S?=
 =?us-ascii?Q?vOZ7rJgN7jc/DMRNfTnossrQrxsM+054PYcy84zejVUEYyjqXJgD7Amd8str?=
 =?us-ascii?Q?O7iEPRFUM5P8C7U0sxYmOlMS4A17c5DmroYFA9Vm0TjC/qD8mcSPhBYYxpJK?=
 =?us-ascii?Q?/34HE/h/1C44PR1ve+UVtl5zEh7LlkoeByFsccBMfGQp2MOMVLyIuO6o5d1C?=
 =?us-ascii?Q?+/QUXol6pSnyb+qrgyxWaUKoZtKGpkYzdp31rhG3taVmDsvWXC6/CZagkumg?=
 =?us-ascii?Q?3wfkC6KX0tfEvDsj6i5gpgo4oxpIaH4n1lNpFI0oFimPrYiSMIxfrvgohySs?=
 =?us-ascii?Q?yMENB+j5CA=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f1ad0ce-3e9d-4bd9-f4b4-08dee6fa5aa3
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2370.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2026 07:33:27.3620
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uRStdDyJ50dBIclna1j+8k+RHS1dIJxNFRTtYMwGLIoRPKmABLG1tsbdPiOoD5TfNdMSRCJ+SdZqsS+TR5c1AA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9251

On Fri, Jul 17, 2026 at 04:51:45PM +0800, Herve Codina wrote:
> of_pci_remove_node() and of_pci_remove_host_bridge_node() check
> whether the node is dynamic but not whether it has valid private data.
> 
> During the node creation, an OF changeset is used and this changeset is
> stored in np->data to be available for removal functions.
> 
> If, for instance, a PCI host bridge is created using a device-tree
> overlay, the related node will have the dynamic flag set but np->data
> will be NULL. This leads to NULL pointer dereferences.
> 
> Further more, having a NULL np->data pointer means that the node has
> been created out of our PCI node creation process and so shouldn't be
> handled by our PCI node removal process.
> 
> Add a np->data check for NULL to bail out early of PCI node removal
> functions.
> 
> Fixes: 407d1a51921e ("PCI: Create device tree node for bridge")
> Fixes: 1f340724419e ("PCI: of: Create device tree PCI host bridge node")
> Cc: <stable+noautosel@kernel.org> # Not triggered but 'This could be a problem...'
> Signed-off-by: Herve Codina <herve.codina@bootlin.com>
> ---
>  drivers/pci/of.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pci/of.c b/drivers/pci/of.c
> index 28896f748e8d..9f35e1e07cdc 100644
> --- a/drivers/pci/of.c
> +++ b/drivers/pci/of.c
> @@ -654,7 +654,7 @@ void of_pci_remove_node(struct pci_dev *pdev)
>  	struct device_node *np;
>  
>  	np = pci_device_to_OF_node(pdev);
> -	if (!np || !of_node_check_flag(np, OF_DYNAMIC))
> +	if (!np || !of_node_check_flag(np, OF_DYNAMIC) || !np->data)
>  		return;
>

Hi Herve,

I wonder whether "np->data != NULL" is sufficient to identify nodes
created by these PCI helpers.

struct device_node::data is a generic pointer. As my limited knowledge,
on pSeries, pci_dn_reconfig_notifier() handles OF_RECONFIG_ATTACH_NODE
and calls pci_add_device_node_info(), which stores a "struct pci_dn *"
in "dn->data"

Coud an OF_DYNAMIC PCI node from that path later reach of_pci_remove_node()
or of_pci_remove_host_bridge_node() ?

If so, the new guard would accpet the non-NULL np->data, and the removal path
would pass a "struct pci_dn *" to of_changeset_revert() and of_changeset_destroy()
as though it were the PCI-create "struct of_changeset *" ?

I have only reviewed this statically, didn't do a real pSeries setup to test it,
so I may be missing something. Could you confirm whether this scenario is possible?
If so, it seems that a stronger ownership indicator would be needed.

Best regards,
Richard Cheng.
  
>  	fw_devlink_set_device(&np->fwnode, NULL);
> @@ -750,7 +750,7 @@ void of_pci_remove_host_bridge_node(struct pci_host_bridge *bridge)
>  	struct device_node *np;
>  
>  	np = pci_bus_to_OF_node(bridge->bus);
> -	if (!np || !of_node_check_flag(np, OF_DYNAMIC))
> +	if (!np || !of_node_check_flag(np, OF_DYNAMIC) || !np->data)
>  		return;
>  
>  	fw_devlink_set_device(&np->fwnode, NULL);
> -- 
> 2.55.0
> 
