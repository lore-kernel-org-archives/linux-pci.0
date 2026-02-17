Received: from OS0P286CU010.outbound.protection.outlook.com (mail-japanwestazon11021123.outbound.protection.outlook.com [40.107.74.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAB0C1A238C;
	Tue, 17 Feb 2026 01:42:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.74.123
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771292529; cv=fail; b=gZvRRa9f+fsvhYdUbYge2Fn4r3l8pgzwacP/RRjpIyLijsmjxWJSXVv64i061/Snxjl0M0rvln1/apI5pQi5xU+WAuRg1ZuA5jG7cfl/4bfQIpO3c+x23kF9wd/8dIceZrJ1OB/2NTeTtmnjhL6cPzPe6nOpJAeqxS2ExXzPn+8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771292529; c=relaxed/simple;
	bh=u7cBKovJE9+68smvKbWGhvneAnhipxdpZXesDpGB4+E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=bpPAYUKfq/hbfiJMVsGyURugD8vOujPU2US6ou535nwSXmo+nemhamjsSbs298bM6OI2FlnV/GpkgpEwZ7FyQ99kSihvtVUDCC4jDnFl3LUQ+/0PhK5N3JQhm1uo+u7bkE1TwvkcRkJ4owfYkEECPVt77Fw3UtOAQiQDYQggGMk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=kZ8io5Vx; arc=fail smtp.client-ip=40.107.74.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="kZ8io5Vx"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YbabUkiuu2oXbP0xXnAgNWzsNdQY7aH7s+ZeJGXOxNbVvfp6NpCaGblzjcXdLceJA0nL+I4WCA3NRkvTxMVHxUk283lOVf5aVMNoRN16XYf5gUkwF0fROKGvD+EllMKDFrbk/SEXSC5WS1HkaeFAsz8kiX9BMpGDSPGfYqe8hy2LArlB+SIYDQbE9Af3+vX+d+9MEmATXPED1v3y2hLrPJNH6QXtWB6iKdqXTRlUcYXasFLDYtZ+Zw/E2j2+8tO8O6Hz+LAF5ootRb4+in4508A9Q85iH2PRDJuTrIgeYOnjF78C5Tb2/ZdnhSfbDHPwAF7FhHInlvYJMxBS6DRaZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uJMIPRbFGimeYgyjOMeZbwsE7TgmloemMuZeleus/xU=;
 b=wc5GljrRr7OljiY4/XFs9h6N+GmUkHddk1u4y2K45qx6DLTPSNM3w5CYmO+yir+3+3rahnOoUFHWilKowRghu4Ee2Y41Z5BzCCvaCHrAAbRBSQcdZtkvcpgE8dZnzL5eqM8ORgSgTkjz6eNUgwAlnqZkchYnx+wHCicjYGv9xzly+CNjX0cewn8NSGf9g3Zgemdt8whTet7MpmKKJcTczqC5w1rlje/Khqcdrtq8RI60JJWO5tbUw9BI3pJJAHd3ni2LqSENFKdhaot2nYCFwx26hFV9viO9JpejgjE2DA02GzQdMrdjUqRkAZo72KS/H7/4NZWiLFEiqG1FQpSxxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uJMIPRbFGimeYgyjOMeZbwsE7TgmloemMuZeleus/xU=;
 b=kZ8io5Vxp/sYMen69nms7/6Cl7gbXYYRbRGzI/ES7IQKq7bV2ChCIRmsA9Qn9zSIw5mx/NMMkIUB24yvaEYz1QSd0dpOXNdYvTWKMnSPGE/85YHsOPeTCLPGIJxs1zPgoJwXigVix5Ty34TSnrKPQRYnPuYItSSY6drY6uVyaMg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by OS9P286MB6901.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:416::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.16; Tue, 17 Feb
 2026 01:42:05 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%5]) with mapi id 15.20.9611.013; Tue, 17 Feb 2026
 01:42:04 +0000
Date: Tue, 17 Feb 2026 10:42:03 +0900
From: Koichiro Den <den@valinux.co.jp>
To: Frank Li <Frank.li@nxp.com>
Cc: jingoohan1@gmail.com, mani@kernel.org, lpieralisi@kernel.org, 
	kwilczynski@kernel.org, robh@kernel.org, bhelgaas@google.com, heiko@sntech.de, 
	kishon@kernel.org, jdmason@kudzu.us, dave.jiang@intel.com, allenbh@gmail.com, 
	cassel@kernel.org, shawn.lin@rock-chips.com, linux-pci@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-rockchip@lists.infradead.org, ntb@lists.linux.dev
Subject: Re: [PATCH v7 9/9] PCI: endpoint: pci-ep-msi: Add embedded eDMA
 doorbell fallback
Message-ID: <a7frycy3m43simbbxl4qornzl4e5xujlmhq2llfyuqad7eb4iy@wpitxwzgmk6u>
References: <20260215163847.3522572-1-den@valinux.co.jp>
 <20260215163847.3522572-10-den@valinux.co.jp>
 <aZNExmCvCgJ470z8@lizhi-Precision-Tower-5810>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aZNExmCvCgJ470z8@lizhi-Precision-Tower-5810>
X-ClientProxiedBy: TYWPR01CA0014.jpnprd01.prod.outlook.com
 (2603:1096:400:a9::19) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|OS9P286MB6901:EE_
X-MS-Office365-Filtering-Correlation-Id: 60bb8eb7-185f-4d1c-3dfe-08de6dc5c111
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|10070799003|7416014|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?+a3tT0Mu1EyAv546qf/bpIs8ypgLkkLjDzpxxCR7dpKor8d5iaOkfp2Z9vbT?=
 =?us-ascii?Q?j9tWhsFg80vwti4jkqzAqWJutgwANkTnh8fuK62RUwM2inas++vKy8Qchufz?=
 =?us-ascii?Q?R3IAEH/ON7HholeR8F7L0C/P7xXFADiVZDtSqgXFE2foUZCsdR9MxRomGUI7?=
 =?us-ascii?Q?MJEUvgi+yegXop0mVns6TJCAL8tsR2jQu7MAlOo0x7IgLSFzFPtKPuRLbnD1?=
 =?us-ascii?Q?biVtC0bRdpvhu0o11ROsqtP3bUShizJ3NvxonrfByX3RHP7rPRYlS7r25YTF?=
 =?us-ascii?Q?AJZZLL+x/b79t3L7n0duPV82uGOVkLTJ0VXGfht4LBA+Ci2iJ8vtd6zicQVE?=
 =?us-ascii?Q?8x4UVwvIIeRkq7yLqvNjzvKLJWBC7Vl9nBV9Ddnw8QXQhynAkcuja3w5DMS3?=
 =?us-ascii?Q?oHAJSHJPb335yew7vANe89nhHRUvT3hH/sWrtKlfpSuIJyvijTJV8wxd6VFj?=
 =?us-ascii?Q?wqC9b0wI3oxyAnk+CMeSJMkb9BOk21Wep2c5XBxtLocS9hwqCAudpP4i7qMS?=
 =?us-ascii?Q?9EBALwuTaiLh/S4/bkR8r+0+SkLNTrRidecIkduMdrZHJqdX/ntK6ZUQYhBe?=
 =?us-ascii?Q?IQeJc0h6Q8FlK+OFzyO9s4xTSm7zl7O2z3gJZJBsxsWoxtufrYjjuDn8ZFVU?=
 =?us-ascii?Q?yWRZaA47a3LNgXFa9qyEKGxAvC+jA3Rk0KK1wlyIHqyzLXxlXvIK6Jsl7jAR?=
 =?us-ascii?Q?NvwSJBBWsOLBhYiRklAJoB6/mcYa6cbYyha5uH83sWnlNYgqAnr0gCzMyyCX?=
 =?us-ascii?Q?KxYleQVCpXSqnRgn7Wig7dGnEFyqDRiBjVIwNqEjF0j9huy2olpSjB63lRaf?=
 =?us-ascii?Q?/W0YVISMwz+QGctHzjKmbSGIRIDSiPioUdKIwnYpd9HOZZKFF2I7RtxGOYAq?=
 =?us-ascii?Q?06sJhahbmglyNEnt/SAkxrYuU4121z04TqquQ5ZTU9fuz8Stix0OaHMJSghD?=
 =?us-ascii?Q?IB93lZaJW0JHF30yVWXWaTaO8+m3W+zvch3bHh4u9Heqa0/ESVCdXezwK4QQ?=
 =?us-ascii?Q?ttH5SwJ+MYRUnSeYl8Mn+6CL1Wz4H73SjY/xyK4axAI+LrU7am4wiXj3gF1I?=
 =?us-ascii?Q?LKf9zEPWIg8TWUEPLjdCrDUKl3iWhS5RKBbBK8s5jVSlRmXKRuRgeVKGGpIr?=
 =?us-ascii?Q?/yERWRHutgD/6Eok9B05PY7IXuyV1Q/7WMKP/GhwTEEA7XGlJRJ3hlJYxLao?=
 =?us-ascii?Q?Ms2511qqdr/6TlmgRrUcJysyIkE85UigNrTMAxxpJeq1bYDO6L6TDGrMPOU8?=
 =?us-ascii?Q?MqOwaZZbTkiu9hpHM1bzVAJakArzbIXyTQXG3afnI3EvY181MGC5BTI9dkeQ?=
 =?us-ascii?Q?KHuTSmXyc0aLrSg47Jh/d4+duAVq5oISSIIsYoqGnLC7nSuRePWYUC+GCvTZ?=
 =?us-ascii?Q?rkFHJxyhoBmyGMScMKDR+H1uwEdhtbuxqaNnjRmTHK2MTLhPOAHUQhTDNjJg?=
 =?us-ascii?Q?C/z7Y8ftmH4E0vDbv2DPk5evAapuHeOqRPBdv7COBAYzQSXhqRmJ4ybv28Qs?=
 =?us-ascii?Q?UtfqJlSLec+lxOAY/KTbhhMXfN3zTMwJHgOm/yeC9hztGUSW+cVqCsQ+eaVx?=
 =?us-ascii?Q?F6+TkD+05CcxR7kkKkg=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(10070799003)(7416014)(376014)(7053199007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?JSVTqCX3ck59i2Bo1uhsPV7hIUolTA5/eZZ3g7SlVl7TwRK6GS0KaD8Hva27?=
 =?us-ascii?Q?e64i9A1HxlRrWXBAViMaK2Bs/5d4/dBSIdjznVeB6puRrJ0WGbPJmwReRH9f?=
 =?us-ascii?Q?/3zhsrWGkC7A3kAltsyyvDPLO1SsPXBQPdQ8iZXq5TgbQfaioNWvEmuYNZ2G?=
 =?us-ascii?Q?4pCYlzNm8QtfTi1Ct8yuf9Hyj7XEfslbcvDCYcKavpwf5e7a4cHqnpJ9iBQZ?=
 =?us-ascii?Q?2ald5RPr7nXx7jWJE4B0pP8gqysCdzoz2izP30bbYTNas2uls5LLEqysy3Sq?=
 =?us-ascii?Q?ZgX2EJgQyytlZfTCczO/4t3IoTKstAOZMdlj7w6AA+jcH9D/Z0SFr8JWXK6k?=
 =?us-ascii?Q?7I1x33o28eQ5iTTD0uWLGUMoPVUf7XfFWO/bm1ubqRGIwtGHEy4ihA+6arwb?=
 =?us-ascii?Q?Zb/YzyFBMrm3xPiprex9QSFEybHfjqc/zsFBOLoK5NamNUFvhrea4rvpYIis?=
 =?us-ascii?Q?lxRSwpSneS2ZZjOTNQQn0/6dHALWKVIJ206McS251q9G8w+b9v5B/r2m2ZdM?=
 =?us-ascii?Q?v35k6Ip8+TKNm1rAhTaVyN0crx4kVJ9PQSW27TUBqy3P22t1FoZtyoUYWmrl?=
 =?us-ascii?Q?0wjrIK3I1SskbZ++dxaSSmCx/9U7w4EYHMJTS9te9MfmMz4OfJxwRIw4m8R/?=
 =?us-ascii?Q?i4jVetL5XPm1Vk169eoL8fAiAG/55xrIOZw5RPTQDTdTW1E/jk4K2eVBkJeA?=
 =?us-ascii?Q?da4LlHwOBo6NgFZaK6w3Ad2LcME9eSQOVkDCGoU4YNFpYA+uuxfR+fzLCgta?=
 =?us-ascii?Q?dGYMqLXKfgy2Ha1DUZuC+Q6OPWAK1gyPuEyUcNZOCqx0Pdp9QoYHRXAREYx5?=
 =?us-ascii?Q?ekcFWg+SnzGnjEagzKQU9bzojqy0eyjxfvB4LoO0uWwV3O8ZYPTtyvlBvYTV?=
 =?us-ascii?Q?InemBSHSBrO2nRg5dh5BcnMLMKm2PPsVAzbSdbW54BrxUa+9/khfdHZJYZPb?=
 =?us-ascii?Q?N3eLPKba7xMSEpIfxwlXW1XS+pPLcTjS6KVJW+D7t3O4LKEvasymq+noiMbz?=
 =?us-ascii?Q?/MoCDueSfYHA5Q/s1UmJYhSDWgd3s9Dc06Kustk26N2opfeV6rP/V3VW5GHw?=
 =?us-ascii?Q?R/gBguL0or5qVfTflzdn1K56FpZmCVcXBh46WrZsUsTWwurgsUCrMR0ALGUh?=
 =?us-ascii?Q?MuwyuHMHLU3PNcdYao4C3lljeBc4svEdQGi31JnnwmQEbHCja4khMQT3f8Zj?=
 =?us-ascii?Q?/+Bg1vZGa4ojPaVxYo7dY0QL4nzXOGh3veku9NslSat8lEe2K8RalGz2k7Uk?=
 =?us-ascii?Q?YyBIh4LCeqDENH9LXY7LXvGd9X03IYancvWfR8WEK2Nd10BZ1GvCO28UgkUn?=
 =?us-ascii?Q?Nw+EcKhHEOCjoeWLpBscSYzqn9De705/dyIxuepGicRGB5t3xCc0NmpKK6el?=
 =?us-ascii?Q?Y+xb1a4mMrQ3Q6caIzbvCIJ3139fOfZ1HTe5BDzW/BcKmh1LL2+Jx1gH5oRP?=
 =?us-ascii?Q?3hSB4OuxFd7LpyLhBTbbmy8dtYJGQwDZjD4QDhw1qJBHXZnG1dVkNjJ7l+Sm?=
 =?us-ascii?Q?DzelTM9DcuSuaMxR0Fa+gDqrlEptomDwhSeNmcJfOptjZjl6ocHUbyY6uinY?=
 =?us-ascii?Q?WtthlOK6e2bSGV6SAf7HVMZ42BQQUNaq4S0kAAPQLwXRnzeF4RrfP80//9/c?=
 =?us-ascii?Q?VEtOfiibhzvf9UjreshhzMNH0TPrP6oD//OKpbK58t1XVUf5tLAfmrUm1RBc?=
 =?us-ascii?Q?0yPQLlW8TjMjGeEx0OCdxIscCxghU6B7o3rcIMvmnACCfzCFiuu2EG+Ndqsu?=
 =?us-ascii?Q?LCfDUsMho/bC11KU8mNZ6Px6Wx0zO16J6shr9Yz68NaoG5d+eTjT?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 60bb8eb7-185f-4d1c-3dfe-08de6dc5c111
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Feb 2026 01:42:04.9444
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dhfXaU5EV0zWeKY6OsaHfcP9V5hpSI9DtARxY4mJt47GsMIPjkN90QU5BM6ti6Bsystg2M54IrY7jEtaGysWUw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS9P286MB6901

On Mon, Feb 16, 2026 at 11:24:38AM -0500, Frank Li wrote:
> On Mon, Feb 16, 2026 at 01:38:47AM +0900, Koichiro Den wrote:
> > Some endpoint platforms cannot use platform MSI / GIC ITS to implement
> > EP-side doorbells. In those cases, EPF drivers cannot provide an
> > interrupt-driven doorbell and often fall back to polling.
> >
> > Add an "embedded" doorbell backend that uses a controller-integrated
> > doorbell target (e.g. DesignWare integrated eDMA interrupt-emulation
> > doorbell).
> >
> > The backend locates the doorbell register and a corresponding Linux IRQ
> > via the EPC aux-resource API. If the doorbell register is already
> > exposed via a fixed BAR mapping, provide BAR+offset. Otherwise provide
> > the physical address so EPF drivers can map it into BAR space.
> >
> > When MSI doorbell allocation fails with -ENODEV,
> > pci_epf_alloc_doorbell() falls back to this embedded backend.
> >
> > Signed-off-by: Koichiro Den <den@valinux.co.jp>
> > ---
> >  drivers/pci/endpoint/pci-ep-msi.c | 90 +++++++++++++++++++++++++++++++
> >  1 file changed, 90 insertions(+)
> >
> > diff --git a/drivers/pci/endpoint/pci-ep-msi.c b/drivers/pci/endpoint/pci-ep-msi.c
> > index a42f69ad24ad..6e1524c2d891 100644
> > --- a/drivers/pci/endpoint/pci-ep-msi.c
> > +++ b/drivers/pci/endpoint/pci-ep-msi.c
> > @@ -6,6 +6,7 @@
> >   * Author: Frank Li <Frank.Li@nxp.com>
> >   */
> >
> > +#include <linux/cleanup.h>
> >  #include <linux/device.h>
> >  #include <linux/export.h>
> >  #include <linux/interrupt.h>
> > @@ -36,6 +37,82 @@ static void pci_epf_write_msi_msg(struct msi_desc *desc, struct msi_msg *msg)
> >  	pci_epc_put(epc);
> >  }
> >
> > +static int pci_epf_alloc_doorbell_embedded(struct pci_epf *epf, u16 num_db)
> > +{
> > +	const struct pci_epc_aux_resource *doorbell = NULL;
> > +	struct pci_epf_doorbell_msg *msg;
> > +	struct pci_epc *epc = epf->epc;
> > +	struct device *dev = &epf->dev;
> > +	int count, ret, i;
> > +	u64 addr;
> > +
> > +	count = pci_epc_get_aux_resources(epc, epf->func_no, epf->vfunc_no,
> > +					  NULL, 0);
> > +	if (count == -EOPNOTSUPP || count == 0)
> > +		return -ENODEV;
> > +	if (count < 0)
> > +		return count;
> > +
> > +	struct pci_epc_aux_resource *res __free(kfree) =
> > +				kcalloc(count, sizeof(*res), GFP_KERNEL);
> > +	if (!res)
> > +		return -ENOMEM;
> > +
> > +	ret = pci_epc_get_aux_resources(epc, epf->func_no, epf->vfunc_no,
> > +					res, count);
> > +	if (ret == -EOPNOTSUPP || ret == 0)
> > +		return -ENODEV;
> > +	if (ret < 0)
> > +		return ret;
> > +
> > +	count = ret;
> > +
> > +	for (i = 0; i < count; i++) {
> > +		if (res[i].type == PCI_EPC_AUX_DOORBELL_MMIO) {
> > +			if (doorbell) {
> > +				dev_warn(dev,
> > +					 "Duplicate DOORBELL_MMIO resource found\n");
> > +				continue;
> > +			}
> > +			doorbell = &res[i];
> > +		}
> > +	}
> > +	if (!doorbell)
> > +		return -ENODEV;
> > +
> > +	msg = kcalloc(num_db, sizeof(*msg), GFP_KERNEL);
> > +	if (!msg)
> > +		return -ENOMEM;
> > +
> > +	addr = doorbell->phys_addr;
> > +
> > +	/*
> > +	 * Embedded doorbell backends (e.g. DesignWare eDMA interrupt emulation)
> > +	 * typically provide a single IRQ and do not offer per-doorbell
> > +	 * distinguishable address/data pairs. The EPC aux resource therefore
> > +	 * exposes one DOORBELL_MMIO entry (u.db_mmio.irq).
> > +	 *
> > +	 * Still, pci_epf_alloc_doorbell() allows requesting multiple doorbells.
> > +	 * For such backends we replicate the same address/data for each entry
> > +	 * and mark the IRQ as shared (IRQF_SHARED). Consumers must treat them
> > +	 * as equivalent "kick" doorbells.
> > +	 */
> > +	for (i = 0; i < num_db; i++) {
> > +		msg[i].msg.address_lo = (u32)addr;
> > +		msg[i].msg.address_hi = (u32)(addr >> 32);
> > +		msg[i].msg.data = 0;
> > +		msg[i].virq = doorbell->u.db_mmio.irq;
> > +		msg[i].irq_flags = IRQF_SHARED;
> > +		msg[i].type = PCI_EPF_DOORBELL_EMBEDDED;
> > +		msg[i].bar = doorbell->bar;
> > +		msg[i].offset = (doorbell->bar == NO_BAR) ? 0 : doorbell->bar_offset;
> > +	}
> > +
> > +	epf->num_db = num_db;
> > +	epf->db_msg = msg;
> > +	return 0;
> > +}
> > +
> >  static int pci_epf_alloc_doorbell_msi(struct pci_epf *epf, u16 num_db)
> >  {
> >  	struct pci_epf_doorbell_msg *msg;
> > @@ -110,6 +187,19 @@ int pci_epf_alloc_doorbell(struct pci_epf *epf, u16 num_db)
> >  	if (!ret)
> >  		return 0;
> >
> > +	/*
> > +	 * Fall back to embedded doorbell only when platform MSI is unavailable
> > +	 * for this EPC.
> > +	 */
> > +	if (ret != -ENODEV)
> > +		return ret;
> > +
> > +	ret = pci_epf_alloc_doorbell_embedded(epf, num_db);
> > +	if (!ret) {
> > +		dev_info(dev, "Using embedded (DMA) doorbell fallback\n");
> > +		return 0;
> > +	}
> 
> here, needn't reverise logic, mostly we put err path in if branch.
> 
> 	if (ret) {
> 		dev_err(dev, "Failed to allocate doorbell: %d\n", ret);
> 		return ret;
> 	}
> 
> 	dev_info(dev, "Using embedded (DMA) doorbell fallback\n");
> 	return 0;

Thanks for pointing this out. I'll update it.

Koichiro

> 
> Frank
> > +
> >  	dev_err(dev, "Failed to allocate doorbell: %d\n", ret);
> >  	return ret;
> >  }
> > --
> > 2.51.0
> >
