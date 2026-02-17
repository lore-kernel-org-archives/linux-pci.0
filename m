Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013049.outbound.protection.outlook.com [52.101.72.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A08735965;
	Tue, 17 Feb 2026 16:45:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771346739; cv=fail; b=aqwTUkYz3LIBW+VEz+menVtiFDUWnzpivI56n25V1nILCeiUHVyglELkAGj4z9BG87U72wOPAbfrQK+JeDoSO3HTVDG6F6Xt3fepEExvGPQhtxfOrx4E6Hl/sl3f2LPIDU4bba0NhLLLSDPbZK5L7FVfARRIWTJZVS+MikG4zkc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771346739; c=relaxed/simple;
	bh=7NoOmroXk+Ppp/ZAByboToyzB+GrfaRx4gvlDmHdfx0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=uRhq6ePTZDnhaxYL7HtdUdg5h9cJlSqNbk2FCy8dphEJ85BHaWLf+d5W45S6tLLWK0Fm67ZoKO6GrhwOFT50gpnl+DJQFqeDN7vnBhUY8SobRs4eQYoPO7Yr/skBG0bEeIkdRmIOROlUlD4t2njEhgYoOKnyC1/7aLwW0L/bbw0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=E36+4XSa; arc=fail smtp.client-ip=52.101.72.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="E36+4XSa"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=k1dnsrhcJC+woFlvy3RxpuGA1wryH4oFkv7Vr6sdeP74mTh97duo+Pp+pGW9Wrp7csk+LhpjPdaR7ml+TOCOvgdygA0ZrZDJ/StUNiVR6NpL9EveNp3zxSDl9caQv/yaKj4QyoHpBo4XC7KnaOYRyupTrkPfP6zeMk76QSEV1De3RLheLs4TZXZE1Z1m+gIcTUB3i8VL1t8gTSOGDMJm108VIbzGWfIyqj+3q6rplAQuTlaDZxSwmHMu3CMWhyEDQHw7rchlh4V6JIGXpkMfgmXEE9Cw5Ha6tVVw2R4sjQiTzVWTdzI4pD03FzhWbKQ5qSZo2q+uXnzFImAXA8D7/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m3yvX2eVRerCTnP4v0t8WEZm5HkoKtJ/gxPyA0fySks=;
 b=DrAUFfhSYLS+Hm5ucdDm/X5OVbh7k9u/kcvlfWSARccANwuZvQjtCg6WRENHbsdA7QUsL8gEi4c20WcgfbWXbLfNxALcxm599zvTEdeNIzdsV8Ah92U/ObG1neoUeu88TjX5zbtpZickUce1E10hFREtZC7bVEOezfAaId6DUFxa0xPERnwCY+YFYgI1hwJ5BT4uAv2dsTAQk1N8gaipwjNzScpYhMp4ywu0RhwGSdyLADuwj9u6l9n5Cfmxm7EZHIOSvMLyr6Jxza0OSaYD1Cu1khhrLt+02/HIhjhkH9dk3ZLDRPEY4Mr6fR1uZo9eJ1TCenMr1zzdqBS/X0MTFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m3yvX2eVRerCTnP4v0t8WEZm5HkoKtJ/gxPyA0fySks=;
 b=E36+4XSaE48PrgruvF9LTe6dQg50zDAlMYoUgReQIhA76+T4SLukAuVW6gX+EDlNIOxt5iWjczYvGpRnceZRP8oR/YXU/cEe+YYjKjXjeETiWFMs2/p1Sj/aTRdBpxiCQhEGC9R1Um3tnTTF4WC+Af0fuBREnu5n9plCgt7svl50BhL5oN+9Rh+XySo5JAMnbKBsePMevNBZ3FOnkNhAA+7EjvYG58ZAMGE2MIvLvKr3gUZb5oLShyNDwPnNDPoJQQXiqoKoKJQ0AMyAo6ublqg8bKJmsJaUoYJbNdMCaePVB8j9r2UKt7aV89/4VUufWzKbKlDBTcwrwmdQsg7U/Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com (2603:10a6:102:2a9::8)
 by PAXPR04MB8557.eurprd04.prod.outlook.com (2603:10a6:102:214::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.13; Tue, 17 Feb
 2026 16:45:35 +0000
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588]) by PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588%6]) with mapi id 15.20.9611.013; Tue, 17 Feb 2026
 16:45:35 +0000
Date: Tue, 17 Feb 2026 11:45:26 -0500
From: Frank Li <Frank.li@nxp.com>
To: Koichiro Den <den@valinux.co.jp>
Cc: jingoohan1@gmail.com, mani@kernel.org, lpieralisi@kernel.org,
	kwilczynski@kernel.org, robh@kernel.org, bhelgaas@google.com,
	heiko@sntech.de, kishon@kernel.org, jdmason@kudzu.us,
	dave.jiang@intel.com, allenbh@gmail.com, cassel@kernel.org,
	shawn.lin@rock-chips.com, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org, ntb@lists.linux.dev
Subject: Re: [PATCH v8 9/9] PCI: endpoint: pci-ep-msi: Add embedded eDMA
 doorbell fallback
Message-ID: <aZSbJph9cF4ghJYX@lizhi-Precision-Tower-5810>
References: <20260217080601.3808847-1-den@valinux.co.jp>
 <20260217080601.3808847-10-den@valinux.co.jp>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260217080601.3808847-10-den@valinux.co.jp>
X-ClientProxiedBy: PH8P220CA0014.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:510:345::18) To PA4PR04MB9366.eurprd04.prod.outlook.com
 (2603:10a6:102:2a9::8)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB9366:EE_|PAXPR04MB8557:EE_
X-MS-Office365-Filtering-Correlation-Id: 8e29c3d0-d8da-47ca-b10d-08de6e43f907
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|52116014|1800799024|19092799006|7053199007|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?8yWfZfsmye9MicAdsNc8Okzx9n2Sb6VS7berNLjBTNJZU1FGidqQ018fekDy?=
 =?us-ascii?Q?gBl4Oe+4O/j+anD7KOQ6aZw0Cpv2gcnFUlzA0rgqx2Ji8ZkqEex537QFqUyd?=
 =?us-ascii?Q?VayxeBRRu4ctA7uqa4jC8nrZMjmRHvi1B7yuVZatTd9BiQJ8hxqxq/CM+z02?=
 =?us-ascii?Q?MPe+PIkL05EivxLwRXkCwDPH5V7xPnWK+KomXWOQyhLceTt72XsKXkqc+U+n?=
 =?us-ascii?Q?6N1PD3VrD3w7OklCQ941vZz3tfZdKddbpIRRbSDXe22UYd8N6txeHDbHsdkx?=
 =?us-ascii?Q?vZpJ0PHNgJryrAJKVemvdidNESgVUsh2RaA72m1/bpG5zPNMe3eKff40tq20?=
 =?us-ascii?Q?oBXD4TVdLQB5WagDt8eYZtO9n6lgZtxEMJEUN89rmAmADicanXToOlMp6oEU?=
 =?us-ascii?Q?se0K6oohS0XUIHtMDBW/TEWT/DumNKX2Rb3edWJb+Mhibcihlq7fgx4Rhn2A?=
 =?us-ascii?Q?WIgU5ygT58LHuFi2+T6FGq/CavmCQDQKJRk0UXcNY8NVA7ujcHdX5KIUIv/L?=
 =?us-ascii?Q?SvzXsc492r0re+rlR5IFZl+/bnIlUS8J3TUvPR+0rPtuZcd2kgxArw3fF1Hc?=
 =?us-ascii?Q?e3dGBfw4LfSlF3M6cAPVpkvVgKboOws3+RDdH+nQ8yNLjN5x+EhyD9X0n01H?=
 =?us-ascii?Q?L8O1ZbM1b5G32t26lkyvbEXPRTtVV3Lq+b/A3Qrdov1oKGU9UnQZM4ulLPVT?=
 =?us-ascii?Q?2hC/GPRjKTMIdOwgzm39X7b7RL2JE+EtSU49q7LyxOm5rtaD6gqkp/vwf7ac?=
 =?us-ascii?Q?4epM0ugWsyOnpubiiGvO8e0Hw08smyVpoxx22/NEB+QeI/qud6e0WoOmGPW6?=
 =?us-ascii?Q?DfMSsVtTXv9dZF+FW2g05m0f3EIEYFfj2mlAhQNr85NcYt2cKwAKpJd0XTVy?=
 =?us-ascii?Q?gAxie9IvmWBLp04RzBwx+rWL7YYMgp5wM5Vam1996pgnsR0Jt65Cy8DtDOyJ?=
 =?us-ascii?Q?o8wGqLf93CaiBgtWffTTn5cWmX2WzqWHS4Z9T1ags8PyggIQCAW1ykYefdae?=
 =?us-ascii?Q?BfR7v4nD9M1VRDrD6mevoAc36zBQrcKFTwr9Hmy0Y/utq+2i434fu0REqpxu?=
 =?us-ascii?Q?hgIZsBHi1+EVE8ySpyEXK2k+7+5CDzbTCQy1AHVQU/HzNX6TVIsI7e+diGdk?=
 =?us-ascii?Q?447XdozrGz5QMvOmnhwPblrueZwBjG3telIA7xzGMiPXW52Pwi1BLUOpQj56?=
 =?us-ascii?Q?4IiIf1fL9f4Y0hafXC0DeV2XOckbKWsVEpNrfIJ0NnOYN/8I1/tTCOhg8Dhp?=
 =?us-ascii?Q?M0Db3Xf+22FuDu76Plvtah1B40XtowVuW9lZdFT9CUTNeWnoQVhTPjI1p7XC?=
 =?us-ascii?Q?se8rA6XnAJux+5oV6oNs3su4KO8MyBTVzN+Ck/n2NMqdKBW9T2lRuSFXw7lN?=
 =?us-ascii?Q?ffQCmFbdo6exQ2wzgdfC0x9kBVGS7Z88toYJyXE/FBteArHFmA4OFFM3wCL6?=
 =?us-ascii?Q?1QwOKm7IsIkb51MhjedZ3LRlT919WSCQmYe4kmDvzVqsuRoFuz6Cjd2kZByt?=
 =?us-ascii?Q?0YbrojWtZg2Accyrz71WuKehCgWQvmDx6Na9ArJIdAAG/r/IauEtxR6tUmYJ?=
 =?us-ascii?Q?IYCdqeOCS99G2x5qwxlGXt3+6W/OzdVFBDQi/7GCdT2m0SXUq5cdVx1lu+a+?=
 =?us-ascii?Q?2LD2//3uFkRjR/1P9b3YSnA=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9366.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(52116014)(1800799024)(19092799006)(7053199007)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?jMt9++cR+b2HP+jbAsuGfqKvlojkkG7CdynPlWvHWghwFV2W6QBZSJ08uSvM?=
 =?us-ascii?Q?EaimhtIebb+VdW+7b4Yt7k7o4S+pNVJJFXUOEPDqwMocBYmcqoQt/q6/KUe8?=
 =?us-ascii?Q?4Jolxz9RoJybZraclCLoy1GZHWfvK1ASYScKvgi8+9IacDQYFxvF85FGbYYt?=
 =?us-ascii?Q?74lLhqefw08Uo38tNDKWDtPOIW6zlOu/68dwf3fV4mkPyBj8c6TateKaTDh4?=
 =?us-ascii?Q?rrY1PPRs45R2xAvmbSt5s+uphWor+Pg2+XfWufImuCmDyyx+IG5mn0kPIbaE?=
 =?us-ascii?Q?ZxOpgklnsxD2Fr0zkFeRfpUEnFhKMUNUu5AOQwDvwndyZ6pllLbD92P1AUZG?=
 =?us-ascii?Q?KUE892FmpH1+2pGJcKSj6SSOJhTgwlr53R9T1s8xlVwmt2Z+2TmPlGr+qwnB?=
 =?us-ascii?Q?+CymFkAM9MKWGMHAMENVTYfuNUd/1WB0tlCfqGUjdkLDAmQHDYhO6aHQ+ehC?=
 =?us-ascii?Q?VEJY/9kLiS3TOJRjLBDBG7fQbX2HkrHa2CMmB6QvOFuXaHtm4FFSitZCRhgh?=
 =?us-ascii?Q?j4UajgI75k/pco1qor9YC3fweQJs9Aa4ME5zUbFyDUdIUhuCoTHVF4iPUYBX?=
 =?us-ascii?Q?Hb02pLIDbwTtDWr067Sw2a2gfwIe6jUZWCPjWtoD3ol4Nn1BmFj25D09+76P?=
 =?us-ascii?Q?Thw4nUItFKgp0DTA7ulS0ywU9V/LBsJWYF0gjy01Gzoh4sg4ungRHmXWrS8e?=
 =?us-ascii?Q?2lKpS57q8tKq+bl7bLbDm5aQymR7OA5zlgFOjGXNsekgDObjVrLO+m/ffnJw?=
 =?us-ascii?Q?bgt+GBv4DBPztRGsrem96+0GnKnJfN/Y8Q7vrHOHsuJ+6Hea76kSg0gh7Ktq?=
 =?us-ascii?Q?L+e8kPGnGw/PyWiGonhOi2/cqd1VxGflmjaFvEXE5mUpyBrWNrBRiD7hajmu?=
 =?us-ascii?Q?hg9GXoKboY+Bytvuec76KusN+xg2MbZWzD4F7tVbpYXqGznZh9NLmiSW/+ET?=
 =?us-ascii?Q?aH4vwXkSgP9dE3NvsMrPVVm5a9cRos10qNKvP3ZCcxyJOTVUUvP5IHq48YU7?=
 =?us-ascii?Q?D2GenWYWuSUkHu7GdlZWq5EEg0C/9pV1PNcwJKI8S+6hQvDZvDxDz3fFHRtq?=
 =?us-ascii?Q?N6JkiFpWlW9fGXLetSOp87vRJfhpYPDutaGqQqSSkA4DfO26ZUM5il+UWiwi?=
 =?us-ascii?Q?ymac3cK+7qG6p0WLuPFz/b6QPtuTh1Yf1An3UehlXbR7I5iaZSDkZsMKK3bl?=
 =?us-ascii?Q?LfWnKCZ/0oc/8KChtgZI04S580PTY+4UKawTpgDokYQhJ4zmnCbmPxdWtOI0?=
 =?us-ascii?Q?d/Oaps8njNb8ZUgYOrHqr3MgG9pV9FJOMS+1Y3PNJ1ru1uiO12H1EKGm9bHf?=
 =?us-ascii?Q?vcxOqWtw/+ntg375oUkBkFQE+9UKlkbP375pB8hBgXuPy04eew6ElXeqJKk6?=
 =?us-ascii?Q?aAJmE7r+oOGuISC0BmmWqYgkmFmJufhChQ0/KSTMKNiUEa76SjMFk7MajI3v?=
 =?us-ascii?Q?8Dm2chZdq062oPTlfes94wPPyUOrHbaIOWqpC0x0MpqBkdjUyIgc41Kbut/b?=
 =?us-ascii?Q?RHiPtnFAo4ZU2VvmOXo6d+8FCBia2tijzCgr+7PYZUItAxEPzofrKS+qm3NF?=
 =?us-ascii?Q?c7yqEXoH5oGOBtXN5bIBr8VZ+56Kgz3I1lR2Nh/M73ZX8/ES0AMNdbviHxCV?=
 =?us-ascii?Q?Zre9CqxfSsvFrM/Fu8qFqutc87oGjfPDNNQ/pQotPmQn2kXGEcfbeKDEMSZX?=
 =?us-ascii?Q?yDs8pDPzBHQc/vrfEumMvlP8gscsWNQDGat9Uq1BZ4Zzsor/51iRYtsjZks3?=
 =?us-ascii?Q?4rZIAgX7gw=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e29c3d0-d8da-47ca-b10d-08de6e43f907
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9366.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Feb 2026 16:45:35.4628
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: U2IgPP3FahSqFoPELZYlexSodiGwIdhKldgCaE7kkH1Y1Ep7tkn80fzsY9K3L+Y3TKirNJ3E9Ft3N3GW9H2afw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8557

On Tue, Feb 17, 2026 at 05:06:01PM +0900, Koichiro Den wrote:
> Some endpoint platforms cannot use platform MSI / GIC ITS to implement
> EP-side doorbells. In those cases, EPF drivers cannot provide an
> interrupt-driven doorbell and often fall back to polling.
>
> Add an "embedded" doorbell backend that uses a controller-integrated
> doorbell target (e.g. DesignWare integrated eDMA interrupt-emulation
> doorbell).
>
> The backend locates the doorbell register and a corresponding Linux IRQ
> via the EPC aux-resource API. If the doorbell register is already
> exposed via a fixed BAR mapping, provide BAR+offset. Otherwise provide
> the physical address so EPF drivers can map it into BAR space.
>
> When MSI doorbell allocation fails with -ENODEV,
> pci_epf_alloc_doorbell() falls back to this embedded backend.
>
> Signed-off-by: Koichiro Den <den@valinux.co.jp>
> ---
Reviewed-by: Frank Li <Frank.Li@nxp.com>

> Changes since v7:
>   - Use designated initializer for consistent styling.
>   - Clean up the pci_epf_alloc_doorbell() error path.
>
>  drivers/pci/endpoint/pci-ep-msi.c | 96 ++++++++++++++++++++++++++++++-
>  1 file changed, 94 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/pci/endpoint/pci-ep-msi.c b/drivers/pci/endpoint/pci-ep-msi.c
> index 50badffa9d72..66f5a68c81b0 100644
> --- a/drivers/pci/endpoint/pci-ep-msi.c
> +++ b/drivers/pci/endpoint/pci-ep-msi.c
> @@ -6,6 +6,7 @@
>   * Author: Frank Li <Frank.Li@nxp.com>
>   */
>
> +#include <linux/cleanup.h>
>  #include <linux/device.h>
>  #include <linux/export.h>
>  #include <linux/interrupt.h>
> @@ -36,6 +37,84 @@ static void pci_epf_write_msi_msg(struct msi_desc *desc, struct msi_msg *msg)
>  	pci_epc_put(epc);
>  }
>
> +static int pci_epf_alloc_doorbell_embedded(struct pci_epf *epf, u16 num_db)
> +{
> +	const struct pci_epc_aux_resource *doorbell = NULL;
> +	struct pci_epf_doorbell_msg *msg;
> +	struct pci_epc *epc = epf->epc;
> +	struct device *dev = &epf->dev;
> +	int count, ret, i;
> +	u64 addr;
> +
> +	count = pci_epc_get_aux_resources(epc, epf->func_no, epf->vfunc_no,
> +					  NULL, 0);
> +	if (count == -EOPNOTSUPP || count == 0)
> +		return -ENODEV;
> +	if (count < 0)
> +		return count;
> +
> +	struct pci_epc_aux_resource *res __free(kfree) =
> +				kcalloc(count, sizeof(*res), GFP_KERNEL);
> +	if (!res)
> +		return -ENOMEM;
> +
> +	ret = pci_epc_get_aux_resources(epc, epf->func_no, epf->vfunc_no,
> +					res, count);
> +	if (ret == -EOPNOTSUPP || ret == 0)
> +		return -ENODEV;
> +	if (ret < 0)
> +		return ret;
> +
> +	count = ret;
> +
> +	for (i = 0; i < count; i++) {
> +		if (res[i].type == PCI_EPC_AUX_DOORBELL_MMIO) {
> +			if (doorbell) {
> +				dev_warn(dev,
> +					 "Duplicate DOORBELL_MMIO resource found\n");
> +				continue;
> +			}
> +			doorbell = &res[i];
> +		}
> +	}
> +	if (!doorbell)
> +		return -ENODEV;
> +
> +	msg = kcalloc(num_db, sizeof(*msg), GFP_KERNEL);
> +	if (!msg)
> +		return -ENOMEM;
> +
> +	addr = doorbell->phys_addr;
> +
> +	/*
> +	 * Embedded doorbell backends (e.g. DesignWare eDMA interrupt emulation)
> +	 * typically provide a single IRQ and do not offer per-doorbell
> +	 * distinguishable address/data pairs. The EPC aux resource therefore
> +	 * exposes one DOORBELL_MMIO entry (u.db_mmio.irq).
> +	 *
> +	 * Still, pci_epf_alloc_doorbell() allows requesting multiple doorbells.
> +	 * For such backends we replicate the same address/data for each entry
> +	 * and mark the IRQ as shared (IRQF_SHARED). Consumers must treat them
> +	 * as equivalent "kick" doorbells.
> +	 */
> +	for (i = 0; i < num_db; i++)
> +		msg[i] = (struct pci_epf_doorbell_msg) {
> +			.msg.address_lo = (u32)addr,
> +			.msg.address_hi = (u32)(addr >> 32),
> +			.msg.data = doorbell->u.db_mmio.data,
> +			.virq = doorbell->u.db_mmio.irq,
> +			.irq_flags = IRQF_SHARED,
> +			.type = PCI_EPF_DOORBELL_EMBEDDED,
> +			.bar = doorbell->bar,
> +			.offset = (doorbell->bar == NO_BAR) ? 0 :
> +				  doorbell->bar_offset,
> +		};
> +
> +	epf->num_db = num_db;
> +	epf->db_msg = msg;
> +	return 0;
> +}
> +
>  static int pci_epf_alloc_doorbell_msi(struct pci_epf *epf, u16 num_db)
>  {
>  	struct pci_epf_doorbell_msg *msg;
> @@ -109,8 +188,21 @@ int pci_epf_alloc_doorbell(struct pci_epf *epf, u16 num_db)
>  	if (!ret)
>  		return 0;
>
> -	dev_err(dev, "Failed to allocate doorbell: %d\n", ret);
> -	return ret;
> +	/*
> +	 * Fall back to embedded doorbell only when platform MSI is unavailable
> +	 * for this EPC.
> +	 */
> +	if (ret != -ENODEV)
> +		return ret;
> +
> +	ret = pci_epf_alloc_doorbell_embedded(epf, num_db);
> +	if (ret) {
> +		dev_err(dev, "Failed to allocate doorbell: %d\n", ret);
> +		return ret;
> +	}
> +
> +	dev_info(dev, "Using embedded (DMA) doorbell fallback\n");
> +	return 0;
>  }
>  EXPORT_SYMBOL_GPL(pci_epf_alloc_doorbell);
>
> --
> 2.51.0
>
