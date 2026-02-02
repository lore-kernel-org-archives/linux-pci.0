Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013033.outbound.protection.outlook.com [40.107.201.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A47437AA9F;
	Mon,  2 Feb 2026 16:02:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.33
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770048140; cv=fail; b=to0zC52+3Oc8Ns4NsUQzUfpbY1qVizjfXiO/nJyER2TvizKJoVsdCO9RCjRut5WL/BsMVBc9u7lpprrlvx47tZCfOmSLnAGvzSVFCxwmsRLVB1evpkY7FphUdsMl/h94cu9BcKT85TkOxf/35D5INeKTTgOgdFiGq3p48nnudLo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770048140; c=relaxed/simple;
	bh=GQjTrf6nFlRM9OpjpEmO3FVUBRaRqkTD/aZD76fFV24=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=aRIiuIvBSKY8DPH+nCS+tH41ZIC/4abEQssA+m1TTmfF7CwAja0BSd6BN8+B4YDQ8yWQHvygeo3oBU/UXW3hm8miO3tlnxnz6I5UHDqsZKWRLpliEdKXUkHBz68spF1l+eKJmbQIzs+A2P3wyzsY3USmkS3FAutD1rSskBdxMUs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=bhgdetCu; arc=fail smtp.client-ip=40.107.201.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="bhgdetCu"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kt5iv1gskb3HaW5GvY+/1SecRdOWjGCLMfS9dcOHxjY6Sq0BsJ+8cLXECLPvf5qzE3fyJM2/yL4opAAsB1KMmRFv7zYjp/floLreEa3278Ia0NllV4uEyma9zCzNxeJtpcR9JqfWyCs3NjJLcMI670I7hmpYhNEwNfkCueNTJIm4uGkliy0JNDkR8gJgj89H2HtN0ifOxd5yn0VsZ3IR8NXuDSkWaQ24c/tYNiABnfuhYj8OXQ/PSOhwMv1IQVH4hWIu7DxKMdH1Lab0exwbeCYwO69S/B7+XbPN+H4oFfLVt40W3bbHLjiVuNzJ2lG1GFNUD6HNhGandgvHxyKPvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oyOnrajpZ7+CF1GUWGn27SPgCzJJHY2UpzZIyGvOjwY=;
 b=yhPvI3IYcpWtglfWlfg+7cU87G47+gdiO+JnoW8e0R9nWr8BarvQxSitMPUavSMnOujfQDFBt/6ThRhsnL2o8rTI+k7Dyro6Tlht1QrZCo994wHdQqVYHyrgE/DlERoIPK0NdGKuF7ievk1MMSBvGXOcWT5f4vRYU8ZHREJsOBqcrGTY7MRVqw3WOFX6Jm3eyuo76lZllw7fv2OOEd+bam3sgfsyxskN+nWrv5JgB+Y9YWIlu7pzLAb0avFSeda0ZU3EY6ys6iSvpNyv+zo1vtEPhaqzldngU5TyVBqrSodb4tqIybaSig0w+k6HN7J2IWjqVD5GSS/FXIP3Kb+qjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oyOnrajpZ7+CF1GUWGn27SPgCzJJHY2UpzZIyGvOjwY=;
 b=bhgdetCuyYwwhgGhbvrGyvBXfvQdMXaeVhwWEABN7SPms7Px2Z9Lrw6efu2JjKfrsW3wlBRGp3kOiGPlpG0jDttgHpf3CTrhTdohQIdARITfDYMFqZo1ox3whfMpw/ynECyQZyaZTub5080jLHvYvr0C5LpZAySS2VlLnSdEL8/HKpZMNa/T5tTFUY64LFkB7a5wrel1QG3w29gO9He1HzVnqycNU7sJ/VigRv+M4qxAtB95EPpvVUGDJWMcG5CXghVGXE5LnyhiJcYBlKEHxnPAPqZB5X5NcU6fAFlD0R7sBs4B/sg7h50yi3G3YnYt24EIjTsBaJbdzV+1DhkM5w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by SJ1PR12MB6364.namprd12.prod.outlook.com (2603:10b6:a03:452::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.16; Mon, 2 Feb
 2026 16:02:16 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%5]) with mapi id 15.20.9564.016; Mon, 2 Feb 2026
 16:02:16 +0000
Date: Mon, 2 Feb 2026 12:02:15 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Wei Wang <wei.w.wang@hotmail.com>
Cc: bhelgaas@google.com, akpm@linux-foundation.org, bp@alien8.de,
	rdunlap@infradead.org, alex@shazbot.org, kevin.tian@intel.com,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH v3 1/2] PCI: Enable the enhanced ACS controls introduced
 by PCI_ACS_ECAP
Message-ID: <20260202160215.GS2223369@nvidia.com>
References: <SI2PR01MB439325B4E44D5A39F34A4015DC9AA@SI2PR01MB4393.apcprd01.prod.exchangelabs.com>
 <SI2PR01MB4393E1496C7B1DDE7DBDBFC2DC9AA@SI2PR01MB4393.apcprd01.prod.exchangelabs.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SI2PR01MB4393E1496C7B1DDE7DBDBFC2DC9AA@SI2PR01MB4393.apcprd01.prod.exchangelabs.com>
X-ClientProxiedBy: BLAPR03CA0045.namprd03.prod.outlook.com
 (2603:10b6:208:32d::20) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|SJ1PR12MB6364:EE_
X-MS-Office365-Filtering-Correlation-Id: fe923d0f-e0fb-4261-b4ba-08de62746f65
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?855XGaSdvRK5iEKuzRG3oATAB1S7y/OQJT/WJda8CID8CnGpmD0hPH9mcZc1?=
 =?us-ascii?Q?0UBLLFVoiT/WEW4RVnytQjO58L3nMYnLrmsNNpxr/+YtYImPlYoyeknWakSV?=
 =?us-ascii?Q?rynyrb2QJapVpD/IrcsVCd4tHy/g7Vwc9Xk32gMfkiTwNFKSArpw2Jf62rmP?=
 =?us-ascii?Q?WW1MePbYkRpPxS/ft2QSvoJskj+HXrkTMCextamv5J8QGUcr2xOyegDeH8QG?=
 =?us-ascii?Q?FNbP7q2lXIBN0jYjXHD7fdOs9ISgvvA3YJVvZcW8AmxzSFL+TluiGWOAAvng?=
 =?us-ascii?Q?jZmk1pHnDFUxZEqYFP2WVU8cPaWweb3K3H3a4ogWFHgSB488DDLNrph3t5HP?=
 =?us-ascii?Q?e/UlS7E1hajm2kk2RP+NepqowYrkiIM7YQsjLdQbpyqwKdFTqn3h9xYJifAu?=
 =?us-ascii?Q?9x9h5iGzmh6ws+lej732lG4eMAjJuEV/5J9DNAEvitr12DZ92rStnG2db/co?=
 =?us-ascii?Q?bkHthq9X9yhB3JFAx9zQ+p7bxs+Vus97iBP2oWQNTYATAcHSlkKzKafw+Yko?=
 =?us-ascii?Q?0GUKan18qqX3BKna7mAlsDjE4XcUkbduxDDbwSbf9Wdq39TjcXlsmOImSn/x?=
 =?us-ascii?Q?tjAGoXOCpKQmA/GANHV69tkticWMYDeLxg0AXFZTkOWC8mLEfgRVNdRMCz/c?=
 =?us-ascii?Q?9LmtQZ7YIPeDGA3YfZlmwlsG43vWX1U7qBMJ1eYciviSsQf4SGAOkk4cKcqa?=
 =?us-ascii?Q?KcVKrb3/q465cAoqKi8LHlmzDtF2kTjxvNseEh+KlNIA9tDkmQMAkOyQYOZ6?=
 =?us-ascii?Q?lrBrxN2vtU/KNXM4YIT9rp1hx74OSpzvkpXtFxtKAxzJnPXO1EPvOppmK7Y7?=
 =?us-ascii?Q?iT+VxzH6dUfigdmF6OYnaxYSHKeL+ZcsarLcFIL2qkv76BIWJil+Nj9yQZmo?=
 =?us-ascii?Q?Nxl9qInMPSRAK1oDWVP/cR2QiprewTl+bZ60YWOdcWvW8ORoSHJhNYTkAODn?=
 =?us-ascii?Q?/Ji8lsRDkQS9TVqhcsXxuw4Gyu+bfvULPbxqiOAcApT/BUZNo/O52y34mZDC?=
 =?us-ascii?Q?SuFlyY0v+k+9cUsOO+Gu4l82/zAcCD/3J1e+/tHyAOvvnuUO6cdCqyHSmB7b?=
 =?us-ascii?Q?bnE9Zjr3N978rAP2m/KkWp6T03CSsiNMj+zgYXoJRZzwD9yV8xnyh0B/fUGA?=
 =?us-ascii?Q?mw6GsCDPDNYuWyreHVkm2mn9aCukojky/fXAZfRLfcTANGkY/rc6mLxUAVMR?=
 =?us-ascii?Q?ZiJChJQEp0yMMWJLRDZs1n31rp4fArShpb+xlze7i94Vrrc1KaumWci3j+07?=
 =?us-ascii?Q?58fa3rqjRMPnDWQhHil58xfLO9HsxTTBMnkb7kGM5f+HmJ+Ym0UJ9G1rbI5O?=
 =?us-ascii?Q?lvlN8oP5Rv+6yna4BT2sMLKRhoSrS2iZANop9NLuENJltSmqZv/6LAgyDfsx?=
 =?us-ascii?Q?PydMIbwnvqDow/XAkFitnvIwaUx6XUwSAeKA+BpFzyJmG4WdhZUB4/YgpPMA?=
 =?us-ascii?Q?dkXC6VeyqZHqOnlirSYWJjsdO8gETmmwvnRZ1OyCAsYQccSpmwJvkijjOv+F?=
 =?us-ascii?Q?+lzqRDwQsIfpDvnenOzq9VOLyB1oTMy/QZ+R3oGxRZPBgJAbheocQQagAL5H?=
 =?us-ascii?Q?z15CD1gTDxeumTju9Po=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?BxiW19NR+PXHCfWRJORY2dlgB8f0HeQI7WkjRhJV5AgnDSsbFobN4ZlH4tU+?=
 =?us-ascii?Q?Csb13aFhRNwyVanlPqk5ka4cky/gFNfp+Kynn2bmUnmBzqww4R2uHLxL9wn4?=
 =?us-ascii?Q?ynRIDmqgiDB+J4YTuy6DndyRfVxVfkfZjKjA+kHgIyFwBMBJU0rU73IGJx/+?=
 =?us-ascii?Q?WG/KjFx9oBFN7WP0ZxWbE1DKBI1JG8Lu7BI2mKkUAGc0tdpFQzD1/hHRNZkP?=
 =?us-ascii?Q?d25BKSnTfXqfCss0qT6ieufnGnWNLQd2tRCbZJxCygup8o/X7mrMFwehEBjs?=
 =?us-ascii?Q?dtSWRQMbWRGyAj8yRG5vJxirECnBreREypytZmbGK3Bt1Ayne9aU23myZwrN?=
 =?us-ascii?Q?OAPiJ1rCLf/SD6HGBq/ZRDPmVxPGJnH0Hw4kq9xOcdvOBKUabxxdJMiOJ6IO?=
 =?us-ascii?Q?X38eEe5BKz8yIlS7mYT/HB7IOPcmKwnNJ8AtHljQZJMJlQlMQfICVFZFyclU?=
 =?us-ascii?Q?owS9vRTztUjvfK9S0AEd1me9E6rXzVZB3RKTodiRGJU8LVENxq7hNGiW3DKX?=
 =?us-ascii?Q?iBHpeTee82wFU7P77vGb0SatKpZtTOTC0jd8EXCXjAz96AHioCob+fbG7V+y?=
 =?us-ascii?Q?YBKHyhorkcOe6iUn21yKcxUZLg8x0uaavGI27Uf0Zf7doC1MvaZZUceGz+Gu?=
 =?us-ascii?Q?zIdTPhnckAn8zSCgH+ZJ7Ta6m2ODUJ9qmZEIjAQPIwBlQVpH5dLniaY4HqPO?=
 =?us-ascii?Q?DwRwrxelNWsAGQw0WY9DcQx6N6xiZofTryIOyD3H/HcFM0wGEzTSXRikelOD?=
 =?us-ascii?Q?QK0J6UpbgcLgMmEkNElTPXQmIAg+nX7K/MUD0LwvjnKQpak65E2DunR/pyo6?=
 =?us-ascii?Q?DmFO3/Pq08YTK09Bx2r5geWuoE4anIh4RM0chzdIFImjhm8YVI9GsQJSd8hf?=
 =?us-ascii?Q?eA9gvnUOOIwZyA3PO/OBQAJdV/sakSmn2ytP6upvzevwWdGNaifgAP9FjZck?=
 =?us-ascii?Q?dmQnE3czPz6DHYgUnvw0D9+fo1kMHry53WQtVJQreuFx3zPyKPWlZVtdYoWv?=
 =?us-ascii?Q?rwqkR0Epp5ZVM7G0L+RZBuMLxAQ9a5gx+oa2nGhvkEuqItNYiwxKrfViLFsh?=
 =?us-ascii?Q?RxhKj9fhhDrTrfSZZPTS/Dbn01Vv/yskXc73yEFFXCi8fXnCttfRcThb26lQ?=
 =?us-ascii?Q?+/JRvfGRmfz8gj71vVZpbE9yki67Ej0Z5cbB0KusBqo98BuB0d9BTaUPbai5?=
 =?us-ascii?Q?JwufobIh+9etYQnipWVWStzIg6B2obuQD/76msaC1ccgFQcsfLInhpbaAu95?=
 =?us-ascii?Q?fO0K5oadpQgh6ScwKDKUdYhoTCEoFfbZ8ZAGudAh8v4VVshlosvXHKtUW6se?=
 =?us-ascii?Q?iPFzgihQW7XI9I9/U0dNvGl0ZGd2EGmx2ZeGNQB5duwTmYnKy6whx3WFtX/f?=
 =?us-ascii?Q?3W3j02s/5WRV/O4JwvMiXIIqcXFOYR6EvBZlKtXtJ9wEru/K5GdbIPec1m++?=
 =?us-ascii?Q?bbX4LnY7am9UOiDGtBTCFglbRkN4yPj4XSMU2NvYWkkqazIW3OX7i7AmM4r3?=
 =?us-ascii?Q?mALQtnujPsziUYhMPhoh0Z7DnxXziQADNwyTKzA8MP8DyfcX4omsV+f1vZT5?=
 =?us-ascii?Q?LgxLk7MBGRyd3v+6GTGhQs1VMkCnTwVnPeiZUkNlTf53GZ36Ty4sZeDu7EV2?=
 =?us-ascii?Q?k8JIh2wmnemyz+chPTXd3qb74ZURf6LMaE+9QjpZnMxvP78CO14T+3Pr+rYc?=
 =?us-ascii?Q?NlqhDAxLLdLqgNHhIDlve2gq4wZqFl7/Ngw0ONY/s2EKl9Xv0kTvKTh51EAN?=
 =?us-ascii?Q?D3nDgO0UXw=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fe923d0f-e0fb-4261-b4ba-08de62746f65
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Feb 2026 16:02:15.9557
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZlRi36ExSPcG9pwcuzKjQFTGN9BvK2jyGRt+JDm8sHGumIxLnHsEvD+om9CUV0cx
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6364

On Mon, Feb 02, 2026 at 07:33:34PM +0800, Wei Wang wrote:
> The ACS Enhanced Capability introduces several new access controls to
> improve device isolation. These new controls are particularly important
> for device passthrough in virtualization scenarios.
> 
> For example, a DMA transaction from a device may target a guest physical
> address that lies within the memory aperture of the switch's upstream
> port, but not within any memory aperture or BAR space of a downstream
> port. In such cases, the switch would generate an Unsupported Request (UR)
> response to the device, which is undesirable. Enabling Unclaimed Request
> Redirect Control ensures that these DMA requests are forwarded upstream
> instead of being rejected.
> 
> The ACS DSP and USP Memory Target Access Control and ACS I/O Request
> Blocking features similarly enhance device isolation. Device grouping in
> Linux assumes that devices are properly isolated. Therefore, enable these
> controls by default if PCI_ACS_ECAP is supported by the hardware. As with
> other basic ACS access controls, these new controls can be configured via
> the config_acs= boot parameter.
> 
> Signed-off-by: Wei Wang <wei.w.wang@hotmail.com>
> ---
>  .../admin-guide/kernel-parameters.txt         | 23 +++++++++++++------
>  drivers/pci/pci.c                             | 13 ++++++++++-
>  include/uapi/linux/pci_regs.h                 |  7 ++++++
>  3 files changed, 35 insertions(+), 8 deletions(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
