Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010058.outbound.protection.outlook.com [52.101.69.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F4524503E1;
	Wed, 12 Aug 2026 14:39:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786545602; cv=fail; b=ZlXJTZ9L51dk9KU1UXQIdt9H2L2BBYHu/ils8BXGfuHnaEao9WOaeM/7u9dmcHLNaFD5bF7MABsW0POubqmkozTXxharjxe17xu768g4KourCIemjeDKSvB/4MMsFAfWDVCz5Aq80h+Vvo6WW+rO/NbyF8cVciEXA9I+seT+YtY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786545602; c=relaxed/simple;
	bh=d7x1k5Z7rpNGimAJ2l/+1ak2LvtjvDYrh+I+AA1v90c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=KBb9t3ylYvIPmTTLuKYDWzPDrHN3MqeRc7uwKwOYVk/t/ag9oOklwpo8umBCpkD3UKJ+yo83BRN/IpLtfhFffkDuvp4jhwhwPmA5dNf2u/ZXGLoA6QhJVPVoUnUnnPP2tEd61d4sBNNcoif3WNtKWfK5T2CZdfXfXc7pk3MHMBE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=VXfV77ze; arc=fail smtp.client-ip=52.101.69.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="VXfV77ze"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=V7pxL3Wk1x4gBJuaZYbIMzfNiODDgKJf0rshJyxzBnZjdJJOgE8S4VfTToa49C0yEjjOM/l4qim4AzPnjWeRNYhfd+ku2eysU6haVyBfJN7rqWX9liIYoiBc6FHRRv/7fmmL6u6t2CKFvb3wI6msvvU+u0aIoHiP9X+aDJ7np7vHih5as1SWOUCwNmyocYIMhrheXyP/E9HsfyglW7IXNIpweW74RKWsatudrdSmHTmhQNoDbd7xwbVM9cJYUedW58+V1D2NbI+xDmH37gfYZ2RqWrTE+UR0QE1/i8iufIf3aVjcCF0xJLX9Rb8PWIsFH3FRPILWLy7Z9bAlNYMMlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Eqyt86+xtRBaTNj4AIsbaXhqD0PpwG3lTMyh5h2NaYI=;
 b=VlvHb9JySzomDX2T4c9GY32yUUHUA/E8tp4B1R2pBfUkhHa9TelsDg1J4VPy8HE78d4FbNLV1qIk96sDa6Uwnz9i1DQeiTErxXWWa1W2pc3OAPPAnHzNJky92NybFkLxKNtbdPvRAzyeyYc50duzNV2otN5oF3oralwoAYeUALfOlKQBFC4QftBZLtCtHgpHmnJJ2Wkx/lXBe4PF30qwLsUeo9bFppRBq5SjeS320OVKuxmZZBuOtDK3VcVHg/CGTqSK+2qdOWh+XZ6Atjlh2IRshbSecEAbktMgmRFweFSOStlWRCJQtDP5XuODK5LH9wK1atsTOp4AV45npl3VJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Eqyt86+xtRBaTNj4AIsbaXhqD0PpwG3lTMyh5h2NaYI=;
 b=VXfV77zefBhEWUNXj9mt6V1Sx5vaur+tQww7q+MGUTOzR65BCwsS4LkbTSDwT+QiMIdkiSl/6Fc/m2yvpIyc1ABfOPY2Sz64TPGQau5ulLeY17Tv9VW+9arC7BE4C+ssEmx3WjRTUX7BH3PDGOpFQJ7Nl1ix9bN3LrsORCYp/EynelbXshblb8s/glJuAsFf+iwmGfUedfexDtKi8F/9A9W+TIYeDvMtC/Q7V+RGEehxqe7bgBjf8v5SQfhRiDUX6Avg94fpebXxWM8ZvjttqEK6Th+/EKainpd4fbJtx2DcJ2HrDH6OVv4g00PNDQm0daJBhEiBIZloYmx890TFiA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9)
 by DB9PR04MB9776.eurprd04.prod.outlook.com (2603:10a6:10:4f0::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.25; Wed, 12 Aug
 2026 14:39:52 +0000
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c]) by GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c%7]) with mapi id 15.21.0315.012; Wed, 12 Aug 2026
 14:39:52 +0000
Date: Wed, 12 Aug 2026 09:39:43 -0500
From: Frank Li <Frank.li@oss.nxp.com>
To: Koichiro Den <den@valinux.co.jp>
Cc: Manivannan Sadhasivam <mani@kernel.org>,
	Jingoo Han <jingoohan1@gmail.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Frank Li <Frank.Li@kernel.org>,
	Marek Vasut <marek.vasut+renesas@mailbox.org>,
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 4/6] dmaengine: dw-edma: Add delegated channel request
 helpers
Message-ID: <anyFr6IW5ctVpmm3@SMW015318>
References: <20260804033855.2115817-1-den@valinux.co.jp>
 <20260804033855.2115817-5-den@valinux.co.jp>
 <anISE4zj1odwT2aJ@SMW015318>
 <eu5iqhvvnpklaudcb7tkbjp3hpzecyzqxdbf4u7fnh6bjjgcqe@6hpimw5vu62m>
 <anOFUSDiDjD0jvei@SMW015318>
 <ni6sfv45mypgxncitlstnqxgpqwn5ocxkns6kv3nez6hnq4x5m@setbl5dlfqdr>
 <anpIJM5OligYsEK0@lizhi-Precision-Tower-5810>
 <lm7tadnxsyrypu4mypptlkx5qkytex4qxsijdr5ydud2n3anvf@yakjfjg5ng4u>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <lm7tadnxsyrypu4mypptlkx5qkytex4qxsijdr5ydud2n3anvf@yakjfjg5ng4u>
X-ClientProxiedBy: PH0PR07CA0072.namprd07.prod.outlook.com
 (2603:10b6:510:f::17) To GV2PR04MB11799.eurprd04.prod.outlook.com
 (2603:10a6:150:2cf::9)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB11799:EE_|DB9PR04MB9776:EE_
X-MS-Office365-Filtering-Correlation-Id: 7c2af0d0-db3b-42a9-d573-08def87f91cb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|19092799006|7416014|366016|1800799024|376014|22082099003|6133799003|10067099003|11063799006|56012099006|4143699003|18002099003;
X-Microsoft-Antispam-Message-Info:
	fwoA9gEg2IKyHCC+EG9NH71blcOiFAI1rC373CsCMzcgkOb3t1P7djHUzJcTc8DW8L5i1kJeNLJ/3oZ2Me52HmTajj5Y21DdLba6QPPAM/F/m2n+n/4ClGuDhTsbRn9HFYpaaR2FjXOJzbAkWL823K9HoF0CQxEJtwHokE4C+ahMTUUMCqENV3fvJul1mnfvB8D3gmKyUkwdBxawT87aL1kClEJLwyV13MVCGb5ag3+VJtY4TvSg6QV9ebL5S4hokf/5ehal6RrNbv3Tq+KWh4OXMQYd+ieyUrNU5Hqu+tZTgpkdBbnshjP7DIZuqdgiNIiIvFL0Q0ucAEKuneKlxrg5kxU9DRBb6SoVJoGhGvP4b4FEcoy6gxYV8IaoPQ1mtDHqiD2+ilth9SHF5BFgllieW7ZfwAVLrQTOivGI/OmGCRxm7uYKWuGTNOjQznfbACAqd0YZdLvFhOwnr3rDtcGrPESi2cJz7gBAhhbAQZNngyq/WcE7hEifrj/rLO8UBKO5VCPrvaEoetEhYkL4cOzDfFFPoD+nKUAl51yUIOx9m2OC6aTEYdcgQe9Gyc8AFOU/uzpLZpCQLWTzjYdD2yBXeuW6p7l8nWyA1dWZ8fNuatu9DWsZb+Cot+B+FK8e80EW4Kidvx7aKXKsB/iRr60yzfJFzx8DR050jZ/UIMc=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11799.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(19092799006)(7416014)(366016)(1800799024)(376014)(22082099003)(6133799003)(10067099003)(11063799006)(56012099006)(4143699003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ImpNktCcQhDuLB2jo+UZdFu5WKZeJAa7QIJ6ys73UdIL5fRGqlvSX4z37F5b?=
 =?us-ascii?Q?rX0m61zDnr8J+/4DXahB5wj2mCrPfGpdzzCM1eBzOiPaouZsRo0M1g1pgwdL?=
 =?us-ascii?Q?rjrlsbrsaDqIv01Qmy4R6ASfvCqp0Hy8z6jeMH/lIuXCLtu2yW6qqpiow00o?=
 =?us-ascii?Q?tn090ehrlEiAiXQOTStp1A11TDAWiM9R4xbER8f+ARlZntRHS7qIwamQGJLW?=
 =?us-ascii?Q?kEffKWuSad4A8AX7/syIrcf6djfXaG/g46PXNegcuFoiZ7CkgBvXDIOT4CIF?=
 =?us-ascii?Q?daRPcJSBFkTdu1uUueHHfELQAg6eG6WC/v11jkXVfeMmHfR0nmwD3vwarNG0?=
 =?us-ascii?Q?HK8jMvnCxOANb0tjLxrGAtC0zMKo5cidw+E5w+F+dMdkSJxHkDaC4lVa5TJh?=
 =?us-ascii?Q?A/cVoWfdeseO5sdPEb7V8Bc1OU0qlt4E7QKz5ZG/FaiCOuGETuAPifjSYkq3?=
 =?us-ascii?Q?+F8HMjb0WmpSWbSKZMci9DqYSMNxMv6FvRSvNJ2Cz7o/GWHRkP1MlCg+IOf+?=
 =?us-ascii?Q?iDgqZsmRbXBAz40ZXU6laMdxXlB4P2fT2+0nHhc92fhe0ArVgMc21PLDzGSv?=
 =?us-ascii?Q?bPDGGWSxgLnIHio/QQCNKAaYJApdlBNnW7lDdP5Nv6r59UK1l89SMB0qYCMG?=
 =?us-ascii?Q?svRiHmX8Ea5MdgH29b/fMMnSE08Ls0UkJbjsurWr/WjrLXYzXWGOtFKQqNek?=
 =?us-ascii?Q?YyjEcU+dDa+Tl4M1TcZNpl54sM54q9J6HIZrOn3ZAv6ALgBu3kWgOMkwzq61?=
 =?us-ascii?Q?xYehlULxgEY5DG44HHZI582E/cg+fhftwBpXATKHZUI9q1ugLMp6wXBLSGQD?=
 =?us-ascii?Q?BcOJpNT3+eOXjEKIiklgaOCpUmrlv7MQfF05h7Rs0aYkks1q6UZbEFq7UOWY?=
 =?us-ascii?Q?Nf4G70K3Dr6DucX/4ASIkKQJuq12J6bBYpqc3r746AbkeZrI6kJo6EeJQsfI?=
 =?us-ascii?Q?ZjiDmlt82RJ2Kj7G7JNZh/XvFNnlUHnHR9rNIJ+SMtATLpzcTeCr7T5yH33s?=
 =?us-ascii?Q?iHwUOLuZbfwY50IZ9TuJYqQJo0j8wyRkBjlpgoelx8sZOL2kKV/03QR8oG8P?=
 =?us-ascii?Q?BBMyexl6As30Smog7Y2kRzegDhGQMPFi/8WHgijmK/Bv0FmB60nyXwobP3/3?=
 =?us-ascii?Q?V7tMrREh0VLyizlNMVcFUUc+TjVVaYnxrvUhwHwq5VNx39yc9E5Eugv1RL8U?=
 =?us-ascii?Q?VDQIOIpVJBjFInE7JU7JbU8kdQGorHVK8A7TfknOoJ2aC8j1gOzBSBi2I1zg?=
 =?us-ascii?Q?nstMpGm1eEvFC7D8XnzBy14N4CQIHqmbfyOhhFRpVKBhbzOlD94h8x6U6Yj8?=
 =?us-ascii?Q?RRZg3E/EHuCWmp5UbK1HJ+KKNQMLNuRZ/oDI27URTuGd0+9yFVit3CSiza8+?=
 =?us-ascii?Q?y1NlKDk64mISw+NN8z7+1Bm03Ssu4BznbZ3KL9Vag3e/Y6Nfemi+BmFtC0mf?=
 =?us-ascii?Q?/mR8Ym9eefYwrMXlwuaxBiEtItgmZ9lo0/TxvSLsEuXM0zx970i3s5/ea3Ix?=
 =?us-ascii?Q?+lnQXLQs5UxSfRrCTSD1kk1auEujiLrOT4fGqpo9lBEQXQV0gI1vSPqhwUzm?=
 =?us-ascii?Q?UZ370UzOzSln9PMWbzrFAWJ55QKVc149Z4XpCgCGh52lAjV9MJTmfmgeiWET?=
 =?us-ascii?Q?bbjudqoc07VbqaGMHwsLgO/OGQVrRs+MmpZfjfva6yVBRjP7cmCZI/Souakw?=
 =?us-ascii?Q?TktqV8BcaO10Rpx5lVP9CVFMfRwh97Yzd5bqeOiIsY4tz5qzdWiVogEHteKi?=
 =?us-ascii?Q?wjp1grKcWmdENU0BO2yoDHr6yGkX2c51plTg8wiT33BbqZsIsdLc?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c2af0d0-db3b-42a9-d573-08def87f91cb
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2026 14:39:52.7011
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 47aKokjDDShTmY6P1Kh+DKZ1C4NXJt9uGAKWJmaUTNGrk8tK9gbopd/oGZxLdCwBVdKUxtT/KRDc6kwWHze3TKolFKu4Vgy7+6DLLoX43pOJYreOTtyBn9GDQONw0bAd
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9776

On Wed, Aug 12, 2026 at 01:11:41PM +0900, Koichiro Den wrote:
> On Mon, Aug 10, 2026 at 05:52:36PM -0400, Frank Li wrote:
> > On Thu, Aug 06, 2026 at 12:45:13PM +0900, Koichiro Den wrote:
> > > On Wed, Aug 05, 2026 at 01:47:45PM -0500, Frank Li wrote:
> > > > On Wed, Aug 05, 2026 at 11:05:21AM +0900, Koichiro Den wrote:
> > > > > On Tue, Aug 04, 2026 at 11:23:47AM -0500, Frank Li wrote:
> > > > > > On Tue, Aug 04, 2026 at 12:38:53PM +0900, Koichiro Den wrote:
> > > > > > > Endpoint functions that expose endpoint-local DesignWare eDMA channels
> > > > > > > to a remote host need to reserve exact hardware channels and hand
> > > > > > > interrupt ownership to the remote side before publishing the channels.
> > > > > > >
> > > > > > > Add DW eDMA-specific helpers that request a write/read hardware channel
> > > > > > > through DMAengine, keep the hardware-channel filter private to dw-edma,
> > > > > > > and switch the selected endpoint-local channel to remote interrupt
> > > > > > > routing after the channel has been successfully reserved. The matching
> > > > > > > release helper can quiesce the channel while it is still remote-routed,
> > > > > > > then restores the channel's default routing before releasing the
> > > > > > > DMAengine reservation. This lets callers skip quiesce when unwinding a
> > > > > > > reservation that was never exposed to host programming.
> > > > > > >
> > > > > > > Release is best-effort because its callers cannot abort teardown. Report
> > > > > > > a quiesce failure locally, but always restore the default routing and
> > > > > > > release the DMAengine reservation.
> > > > > > >
> > > > > > > Signed-off-by: Koichiro Den <den@valinux.co.jp>
> > > > > > > ---
> > > > > > > Changes in v6:
> > > > > > >   - No changes.
> > > > > > >
> > > > > > >  drivers/dma/dw-edma/dw-edma-core.c | 91 ++++++++++++++++++++++++++++++
> > > > > > >  include/linux/dma/edma.h           | 14 +++++
> > > > > > >  2 files changed, 105 insertions(+)
> > > > > > >
> > > > > > > diff --git a/drivers/dma/dw-edma/dw-edma-core.c b/drivers/dma/dw-edma/dw-edma-core.c
> > > > > > > index 1f893dc54c79..4c0d2bba755b 100644
> > > > > > > --- a/drivers/dma/dw-edma/dw-edma-core.c
> > > > > > > +++ b/drivers/dma/dw-edma/dw-edma-core.c
> > > > > > > @@ -1302,6 +1302,97 @@ int dw_edma_remove(struct dw_edma_chip *chip)
> > > > > > >  }
> > > > > > >  EXPORT_SYMBOL_GPL(dw_edma_remove);
> > > > > > >
> > > > > > > +struct dw_edma_delegated_chan_filter_args {
> > > > > > > +	struct device *dma_dev;
> > > > > > > +	bool write;
> > > > > > > +	u16 id;
> > > > > > > +};
> > > > > > > +
> > > > > > > +static bool dw_edma_delegated_chan_filter(struct dma_chan *dchan, void *param)
> > > > > > > +{
> > > > > > > +	struct dw_edma_delegated_chan_filter_args *filter = param;
> > > > > > > +	struct dw_edma_chan *chan;
> > > > > > > +
> > > > > > > +	if (!filter || dchan->device->dev != filter->dma_dev)
> > > > > > > +		return false;
> > > > > > > +
> > > > > > > +	chan = dchan2dw_edma_chan(dchan);
> > > > > > > +
> > > > > > > +	return chan->dir == (filter->write ? EDMA_DIR_WRITE : EDMA_DIR_READ) &&
> > > > > > > +	       chan->id == filter->id;
> > > > > > > +}
> > > > > > > +
> > > > > > > +static int dw_edma_delegate_chan(struct dma_chan *dchan)
> > > > > > > +{
> > > > > > > +	struct dw_edma_chan *chan = dchan2dw_edma_chan(dchan);
> > > > > > > +	int ret = 0;
> > > > > > > +
> > > > > > > +	if (!(chan->dw->chip->flags & DW_EDMA_CHIP_LOCAL))
> > > > > > > +		return -EINVAL;
> > > > > > > +
> > > > > > > +	guard(spinlock_irqsave)(&chan->vc.lock);
> > > > > > > +
> > > > > > > +	if (chan->configured || chan->status != EDMA_ST_IDLE ||
> > > > > > > +	    chan->request != EDMA_REQ_NONE)
> > > > > > > +		ret = -EBUSY;
> > > > > > > +	else
> > > > > > > +		chan->irq_mode = DW_EDMA_CH_IRQ_REMOTE;
> > > > > > > +
> > > > > > > +	return ret;
> > > > > > > +}
> > > > > > > +
> > > > > > > +struct dma_chan *dw_edma_request_delegated_chan(struct device *dma_dev,
> > > > > > > +						bool write, u16 id)
> > > > > > > +{
> > > > > > > +	struct dw_edma_delegated_chan_filter_args filter = {
> > > > > > > +		.dma_dev = dma_dev,
> > > > > > > +		.write = write,
> > > > > > > +		.id = id,
> > > > > > > +	};
> > > > > > > +	struct dma_chan *dchan;
> > > > > > > +	dma_cap_mask_t mask;
> > > > > > > +
> > > > > > > +	if (!dma_dev)
> > > > > > > +		return NULL;
> > > > > > > +
> > > > > > > +	dma_cap_zero(mask);
> > > > > > > +	dma_cap_set(DMA_SLAVE, mask);
> > > > > > > +
> > > > > > > +	dchan = dma_request_channel(mask, dw_edma_delegated_chan_filter,
> > > > > > > +				    &filter);
> > > > > > > +	if (!dchan)
> > > > > > > +		return NULL;
> > > > > >
> > > > > > I forget, why need export delegrated dma channel to dmanegine? If EP
> > > > > > driver doesn't report delegrated channel to dma engine, what's happen?
> > > > >
> > > > > This just reserves the exact channel against any dmaengine clients before
> > > > > handing its programming ownership to the host. Without it, a local client
> > > > > could request the same channel too.
> > > >
> > > > why not epf function driver call dma_request_channel() to decide which
> > > > channel pass to ownership to the host.
> > >
> > > I actually tried that model in v2. pci_epf_dma called dma_request_channel() with
> > > a filter supplied through the EPC resource.
> > >
> > >   In v2, .filter_fn was part of the pci_epc_aux_resource definition:
> > >   https://lore.kernel.org/r/20260525063129.3316894-3-den@valinux.co.jp/
> > >   ... and pci_epf_dma_claim_channel() used it to claim the channel here:
> > >   https://lore.kernel.org/r/20260525063456.3317509-3-den@valinux.co.jp/
> > >
> > > I changed that in v3 after your comment about why the dw-edma filter needed to
> > > be public. The replacement kept the filter inside dw-edma, and moved channel
> > > reservation, IRQ ownership handoff and reclaim there too. The current EPC
> > > delegation API follows that model.
> > >
> > > Or is that v2 model what you prefer here?
> > >
> > > That said, dma_get_slave_channel() might be sufficient inside dw-edma here,
> > > since it already knows the exact channel from the direction and hw channel id.
> > >
> > > P.S. For clarity, the options tried or discussed so far are:
> > >
> > >   (a) Expose dma_chan directly through the EPC resource, then let the EPF
> > >       reserve it with dma_get_slave_channel(). This was v1.
> > >       (https://lore.kernel.org/r/20260521063405.2842644-3-den@valinux.co.jp/)
> > >
> > >   (b) Expose the hardware ID, direction and a provider filter, then let the
> > >       EPF call dma_request_channel(). This was v2.
> > >       (https://lore.kernel.org/r/20260525062420.3315904-2-den@valinux.co.jp/)
> > >
> > >   (c) Pass the hardware ID and direction to pci_epc_delegate_dma_chan(), then
> > >       let the backend reserve and delegate the channel. This is the current
> > >       v6 design.
> > >       (https://lore.kernel.org/r/20260804033855.2115817-5-den@valinux.co.jp/)
> > >
> > >   (d) Request channels normally and correlate them with EPC resources through
> > >       a generic dma_slave_caps.hw_id. I proposed this in a much older series.
> > >       (https://lore.kernel.org/r/20260204145440.950609-2-den@valinux.co.jp/)
> >
> > (d) is close to best solutin.
>
> Hi Frank, thanks for sharing your thoughts.
>
> >
> > There are chan_id in dma_chan, but have not implemented good enough.
> >
> >   	/*
> >          * When the chan_id is a negative value, we are dynamically adding
> >          * the channel. Otherwise we are static enumerating.
> >          */
> >         chan->chan_id = ida_alloc(&device->chan_ida, GFP_KERNEL);
> >         if (chan->chan_id < 0) {
> >                 pr_err("%s: unable to alloc ida for chan: %d\n",
> >                        __func__, chan->chan_id);
> >                 rc = chan->chan_id;
> >                 goto err_free_dev;
> >         }
> >
> > But there are not check for negative value eventhough there are comments
> > for it.
>
> I looked into the history. Isn't this just a stale comment left behind by
> 0821009445a8 ("dmaengine: fix channel index enumeration")?
>
> >
> > It causes logic channel and hardware channel mismatch if dma-channel mask
> > existting. If skip some channel register, it will be mismatched, which will
> > cause confuse when debug.
> >
> > To keep back compatible, we may use reverse logic for dynamically adding.
>
> Just to confirm, by "reverse logic", do you mean keeping the automatic IDA
> allocation from 0821009445a8 as the default, while letting a driver explicitly
> set a static channel ID? (pls see my next comment below)
>
> >
> > BIT(30) as static enumerating.
> >
> > if (!(chan->chan_id & BIT(30)))
> > 	chan->chan_id = ida_alloc(&device->chan_ida, GFP_KERNEL);
> >
> >
> > Or we simple add hw_id in dma_chan. at debug fs can show hw id. but idealy
> > chan_id match hardware sequency.
>
> I agree. It would be nice if we could do without adding a new field. How about a
> small helper such as:
>
>     static inline void
>     dmaengine_set_static_chan_id(struct dma_chan *chan, unsigned int hw_id)
>     {
>             chan->chan_id = BIT(30) | hw_id;
>     }
>
> then in the dmaengine core:
>
>     if (chan->chan_id & BIT(30)) {
>             id = chan->chan_id & ~BIT(30);
>             chan->chan_id = ida_alloc_range(&device->chan_ida, id, id,
>                                             GFP_KERNEL);
>     } else {
>             chan->chan_id = ida_alloc(&device->chan_ida, GFP_KERNEL);
>     }
>
> and for dw-edma as an example, use it like this:
>
>     diff --git a/drivers/dma/dw-edma/dw-edma-core.c b/drivers/dma/dw-edma/dw-edma-core.c
>     index 1f893dc54c79..d214df55da3c 100644
>     --- a/drivers/dma/dw-edma/dw-edma-core.c
>     +++ b/drivers/dma/dw-edma/dw-edma-core.c
>     @@ -987,6 +987,7 @@ static int dw_edma_channel_setup(struct dw_edma *dw, u32 wr_alloc, u32 rd_alloc)
>                                             &dw->chip->dt_region_rd[chan->id];
>
>                     vchan_init(&chan->vc, dma);
>     +               dmaengine_set_static_chan_id(&chan->vc.chan, i);
>
>                     dw_edma_core_ch_config(chan);
>             }
>
> Here, 'i' is a direction-flattened ID, unlike dw_edma_chan.id, which is
> direction-local. It keeps dma_chan.chan_id unique within one dma_device.

The method looks good.

Frank

>
> >
> > chan_id match hardware instance will beanfit more. There are some code
> > assume chan_id is that hardware id, such as
> >
> > drivers/dma/dw/idma32.c:        value = readl(misc + DMA_CTL_CH(dwc->chan.chan_id));
>
> Thanks for the pointer. I wasn't aware of it, TBH. The current semantics might
> be a bit fragile.
>
> Thanks again for the review, it's super helpful.
>
> Best regards,
> Koichiro
>
> >
> > Frank
> >
> > >
> > > Best regards,
> > > Koichiro
> > >
> > > >
> > > > Frank
> > > >
> > > > >
> > > > > Best regards,
> > > > > Koichiro
> > > > >
> > > > > >
> > > > > > Frank
> > > > > >
> > > > > > > +
> > > > > > > +	if (dw_edma_delegate_chan(dchan)) {
> > > > > > > +		dma_release_channel(dchan);
> > > > > > > +		return NULL;
> > > > > > > +	}
> > > > > > > +
> > > > > > > +	return dchan;
> > > > > > > +}
> > > > > > > +EXPORT_SYMBOL_GPL(dw_edma_request_delegated_chan);
> > > > > > > +
> > > > > > > +void dw_edma_release_delegated_chan(struct dma_chan *dchan, bool quiesce)
> > > > > > > +{
> > > > > > > +	struct dw_edma_chan *chan;
> > > > > > > +
> > > > > > > +	if (!dchan)
> > > > > > > +		return;
> > > > > > > +
> > > > > > > +	chan = dchan2dw_edma_chan(dchan);
> > > > > > > +	if (quiesce && dw_edma_core_ch_quiesce(chan))
> > > > > > > +		dev_warn(chan->dw->chip->dev,
> > > > > > > +			 "failed to quiesce delegated %s channel %u\n",
> > > > > > > +			 chan->dir == EDMA_DIR_WRITE ? "write" : "read",
> > > > > > > +			 chan->id);
> > > > > > > +
> > > > > > > +	scoped_guard(spinlock_irqsave, &chan->vc.lock)
> > > > > > > +		chan->irq_mode = dw_edma_get_default_irq_mode(chan);
> > > > > > > +
> > > > > > > +	dma_release_channel(dchan);
> > > > > > > +}
> > > > > > > +EXPORT_SYMBOL_GPL(dw_edma_release_delegated_chan);
> > > > > > > +
> > > > > > >  MODULE_LICENSE("GPL v2");
> > > > > > >  MODULE_DESCRIPTION("Synopsys DesignWare eDMA controller core driver");
> > > > > > >  MODULE_AUTHOR("Gustavo Pimentel <gustavo.pimentel@synopsys.com>");
> > > > > > > diff --git a/include/linux/dma/edma.h b/include/linux/dma/edma.h
> > > > > > > index 3c8e2ef9dee0..944469258b8b 100644
> > > > > > > --- a/include/linux/dma/edma.h
> > > > > > > +++ b/include/linux/dma/edma.h
> > > > > > > @@ -153,6 +153,9 @@ struct dw_edma_chip {
> > > > > > >  #if IS_REACHABLE(CONFIG_DW_EDMA)
> > > > > > >  int dw_edma_probe(struct dw_edma_chip *chip);
> > > > > > >  int dw_edma_remove(struct dw_edma_chip *chip);
> > > > > > > +struct dma_chan *dw_edma_request_delegated_chan(struct device *dma_dev,
> > > > > > > +						bool write, u16 id);
> > > > > > > +void dw_edma_release_delegated_chan(struct dma_chan *chan, bool quiesce);
> > > > > > >  #else
> > > > > > >  static inline int dw_edma_probe(struct dw_edma_chip *chip)
> > > > > > >  {
> > > > > > > @@ -163,6 +166,17 @@ static inline int dw_edma_remove(struct dw_edma_chip *chip)
> > > > > > >  {
> > > > > > >  	return 0;
> > > > > > >  }
> > > > > > > +
> > > > > > > +static inline struct dma_chan *
> > > > > > > +dw_edma_request_delegated_chan(struct device *dma_dev, bool write, u16 id)
> > > > > > > +{
> > > > > > > +	return NULL;
> > > > > > > +}
> > > > > > > +
> > > > > > > +static inline void dw_edma_release_delegated_chan(struct dma_chan *chan,
> > > > > > > +						  bool quiesce)
> > > > > > > +{
> > > > > > > +}
> > > > > > >  #endif /* CONFIG_DW_EDMA */
> > > > > > >
> > > > > > >  #endif /* _DW_EDMA_H */
> > > > > > > --
> > > > > > > 2.51.0
> > > > > > >
