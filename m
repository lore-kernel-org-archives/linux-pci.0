Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011012.outbound.protection.outlook.com [40.107.130.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B09ED43C7DE;
	Mon, 10 Aug 2026 19:11:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786389070; cv=fail; b=FoGxfWZFyZc8bd/9vP5COBaNIZmEGap7BrYH57LZg3NLKKU2zSJJWdw11HIUQzmcEeKd9pxWcZjwI54wHMwkqX5i8ZioJX/l47SFsza/WDPL0HTLEUqNgrBpT94gNd+2fmQGzVX9TfAL3tqPd8/kjDpY2P2+0S6Ya5CPClpe5Jc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786389070; c=relaxed/simple;
	bh=JFMPeYI4xTgcBPAw7DspLrEERLnFFs23FhrWadR1Juo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=c2aWDirX+HiVZ1Jy7tda2Po52UeuQHW/p1pNlingMlJDJkJvlGDmGtXvddc0WSfzePXzTsDtp6WwZLW+NTmJejzCXUTOQldDpkkk9ynRwfWudxE+27eT2+qwqu4wXVvDskCJr7+dbztNKSJ07aXZl1LY9zc8Cl+Ljerp8SMk5DU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=Xfw1iAY4; arc=fail smtp.client-ip=40.107.130.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="Xfw1iAY4"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cVn82vd1w8LCFkgV82Jp6PYlqfDZsq7hCaieJhxnt6pVFXbpPTu/wxs2eUMlGsVUkCMiw1LJpSrDhJ6+GoUFO7QSFHawFBi3M4b3wAxekEGoiXwN+kvemenEx49mgvx3ijkomLe2/KBLR4wX0+ARH5cQiVJwAIuWOEQEWQS06iF7oOKOI9nYxo6P3kPBhbHZs5yyE7j8B3DmVV93QaBE4Cs4D0X6JldXZ0F8jTOu9XI3JlRhDVxGoPj7Lo6AFh4Wiji7QPitCfCGImd4It9fDM/JwKrBu1/Vczyfn6wsJgg+Y8bbPxTSU9eXoLwYTitt709EIp9krPkySrNKvMjNIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J8c+RHwi1EXH8oXaS3eoI0pMzATyZqZlVug8k69neo0=;
 b=vuGySxodJYupmE2d4esAfkAjcQwP+E2+X0yczhWJolalS3Y4UDArgtVW+6f+UHc8uaWQSJ6rXyAXyu22AjZyxIDiLGMdiMRgDGxHfijpePhKKihZmKzptpq4saGOF5r2HCr+B0RWsBtftJ+OlI1KTEAVXkkEkQFyzR4WTIbhS3wzU9h4cSBjMbYMuUJWgFKLyUfIfLFx0XFYk7d2ejh9QcayQMRN6GdvSjFXJCaGeDnpYMMephyxJ/k1aMxTOdnlvDkHM4BB2qMESE5cNI1MfRwy+p1OGF9P8b40Faf4lHeC+kJRZSurRDl4oKBhE7q0qhd0p/+bcZklpeOIWVuMkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J8c+RHwi1EXH8oXaS3eoI0pMzATyZqZlVug8k69neo0=;
 b=Xfw1iAY48U7ygykywDQm/d+NH5WBkSXnX7xSKEMrIn1wOONAGhu/bcGFch20sSt3hJk/bTL1lrhUX6KNFBASjXMokfg+4zaWX+yOVeT6AdvI0IRbnX7G89Pv5sPgqoromuZPaVpOg3xh6j1loCrmUgGmhuOg1YsqTHXoRi3EkU2LfjDG8NGr3PBR947vOoBqqz1pbmO8VIOGbypsmU6B+LR+gChDPsEu4NdoBAkyI2KW1tJm7N4S9NR5U0sfEms6+XRlxx6UE1H61v2k/1VUsGTS1rtg926vLN3dcW3Zbn7DpctksoutcE8dxiN4qhGlWUM28ntSn0CT7Eh2Izc00w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9)
 by AS8PR04MB9079.eurprd04.prod.outlook.com (2603:10a6:20b:446::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.25; Mon, 10 Aug
 2026 19:11:00 +0000
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c]) by GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c%7]) with mapi id 15.21.0292.024; Mon, 10 Aug 2026
 19:11:00 +0000
Date: Mon, 10 Aug 2026 14:10:50 -0500
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
Message-ID: <anoiOov5nIapcteC@SMW015318>
References: <20260804033855.2115817-1-den@valinux.co.jp>
 <20260804033855.2115817-5-den@valinux.co.jp>
 <anISE4zj1odwT2aJ@SMW015318>
 <eu5iqhvvnpklaudcb7tkbjp3hpzecyzqxdbf4u7fnh6bjjgcqe@6hpimw5vu62m>
 <anOFUSDiDjD0jvei@SMW015318>
 <ni6sfv45mypgxncitlstnqxgpqwn5ocxkns6kv3nez6hnq4x5m@setbl5dlfqdr>
 <anS7WQ-b4y1_wwY-@SMW015318>
 <pzeysikhd2mdblpn3hbl3fsiehmgwcogbep6f4btr65he5jb4t@mdas7wsvkrtp>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <pzeysikhd2mdblpn3hbl3fsiehmgwcogbep6f4btr65he5jb4t@mdas7wsvkrtp>
X-ClientProxiedBy: SN7PR04CA0032.namprd04.prod.outlook.com
 (2603:10b6:806:120::7) To GV2PR04MB11799.eurprd04.prod.outlook.com
 (2603:10a6:150:2cf::9)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB11799:EE_|AS8PR04MB9079:EE_
X-MS-Office365-Filtering-Correlation-Id: 744025b6-7904-426c-199a-08def7131d02
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|366016|7416014|1800799024|19092799006|376014|11063799006|10067099003|56012099006|4143699003|6133799003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	V/PboEEgQB5O+sIP/zojAKMpC2cryCCqKHXez5mgNtRBz5eFuxF8a+D/YTLPNDuZqvWtuvDbSqltptwQttkFzNzAUI4hi1d1gP8oot5e5vE+Q+dv9lBzmuzEo3LB9HCKgK3SArG/954aUtmbCwD5NhLY7kcdWBXUbWfh6Pc93uXHrBuMTikQ/gFQhrHkbdk+4pphRDov6e1DsBnKxgpj6Rf1fbfWAThww5J4HcTBBNvwS/tak+bwtQ5zOAGiMmF1COuxCq9jJi+QLfP73m/4PJYrs+v1ciXPLlFe34cJVojnaWiQ1tMSW59NJPtkYcaG8pebzSxkDA5KXEDikjAW/NOUYixtDD78mpp3NvHkcwhk8Zmx8L1lHbU04GK1Tko5QFD/geymt7JmCHMjCFv4vWMQQc+y3i6ooR6mVIeQnMasxC55jJlZtnuzHt0ZHJ9QWDgOcEpTxRXlZpEm1qyKo6JpRW1aiOX5jB76v2vAA2yaVe7I4FVojZ5X93SwIEBpN76DB0jpN75v988jvKfLmIf2oB7XeRnLDrvJ1ekxeRCIiX5llmlScpGVDrZwiaSMACZHWFWJYzDPiQlbdaNt2g2dImHtiTacjIkWb55bovT3uIGzZuQIWGnfdEff4w739gImGxZfqrfTi7GcgOHW9WudTMMOj6zGvTMK1i7g8ys=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11799.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(7416014)(1800799024)(19092799006)(376014)(11063799006)(10067099003)(56012099006)(4143699003)(6133799003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?7vgpJ64+UFFn3CZTy9h9bofrfWmp2LdlSXC/aMRAX33rnbxQQkzs7A6O2Wek?=
 =?us-ascii?Q?QqJ8Eyz9XlxhZf2DsMhh3StOCmqQS/cN1fMIKuhe2nTsYY4xGc8a/oliKktT?=
 =?us-ascii?Q?Z8RVSiimdwqRG9zuxA4HzaC7z1brrvXbSBC2GpOz+8isdJcgufBfKiCUX296?=
 =?us-ascii?Q?Reso24KhE71sLFVuV85XChaWuaP6d+i0Ed82ZwpGCsq6W1IzAXUb0KXl1fub?=
 =?us-ascii?Q?z23Y64TNPV9Uw0QTQZ/F+T4n/yFbaRioX3iLGwqMTe4sBPdDwsAsyBueEf+P?=
 =?us-ascii?Q?P0XTt4WqB0R/+LaoyFLpKR7dyl/WTA3eTrOCHD187FQHuutI3ZERpbKTmj7I?=
 =?us-ascii?Q?VwnVfH51xKNiZ9FceBZx/QfiRmTPPGK6iUB9x1gbyGix8kywpr0IYS0oywi7?=
 =?us-ascii?Q?PHmVdynaFXNqmpke0S5xQ4zhK9S+BebviAIuE08C4mSkCufky5yWIXLsVI17?=
 =?us-ascii?Q?7IHQu3eRYf8g0ozqtUPGwkLXmrwOqf7N06Qg3Fap1D0W3TGAmicfbeTkzHpE?=
 =?us-ascii?Q?EfHyeV//qiuko1L69ldZiuzNKJ8cjMFlxytLF+Vhu29NUKbIGg4G9fjERc5d?=
 =?us-ascii?Q?ogvSaASh0HjeGUfdVEhsDZRxCFZA5EMoTgp+Pir9Fo9Vs+k0i8cfwiNG8K6o?=
 =?us-ascii?Q?UU+a6VKBMF0MNowbLR6EyLBXVCrpDlA5SY/wRgaZqHsON1fFBfS9iG28K8lT?=
 =?us-ascii?Q?HgaEwfTdtS9yUXCmAjv682VID82zJPEjjkGHhpDZSUVJG1Z6gc3a0Vx+FZ8q?=
 =?us-ascii?Q?4M46tfKz72E6kjNwgtXDqFB8ERjNLlfDz3ogx7nVCZWmFOmi2ghUtq8+tSoT?=
 =?us-ascii?Q?MkJ3qCWqW5AfNzLidhtDhJxK6AjszXBXbJ2dmkMN6vNfQt3aF7HgmUsrHQjE?=
 =?us-ascii?Q?J112eGyDWZJNgTG8CH05cXBFKEkV1w3taIq06VW4xUOvOGSUIWk/q9cZPTAU?=
 =?us-ascii?Q?4v38Fpz15zDlnRPsURP/InbplX+g0BDXZ6r8ZX/cuGX20ri4J0RLzNjSijxE?=
 =?us-ascii?Q?/qHeDt7DE7KMHdqv35f1hEdHTNYpssuqb0YC//wN4jgwGuhHgZNzj2h1fyF4?=
 =?us-ascii?Q?KOnsnEx6VC/4xZSkwMZRb4dkp32wb+OvRTr3qbwdpE+vJyQHMNHZWunwqqei?=
 =?us-ascii?Q?jN0GFHAvBdSx8puD1QZZqyplZBZyzAo9XRDNarK6+mDe/e3Da79DfiozRyoh?=
 =?us-ascii?Q?lhApyDlVLBu91fHZ5kIfVyLSs5RSdvSG5YZKEhxB9MrhLDpOlgC4B2v2afDl?=
 =?us-ascii?Q?SXDX4hkPvbRpCwBSeJjqlVvNrRSp2bYZcmupG4Kcw7P38Gwax9P/xyvdq9d1?=
 =?us-ascii?Q?gw+8L7rruTUJDTGf5mE8k486Xan+i/kYjFfZMDvpt5kpPZm92hcVXQswk1V/?=
 =?us-ascii?Q?QizXCMgQCKaiUjY6RGu85DASOQhM178AKj8NEDJldaC8rk/0YxvuGGyl4ACG?=
 =?us-ascii?Q?EuFjRvsVHm5sucRzoL7CRZr8OytIF9/OEmBTg6CV/FubU5Nkln/S12XUOwAy?=
 =?us-ascii?Q?hY3EJ0w8t8ehDLhXv8oXzmrx1/E5kF3qcT2ePtMztXeMimVtZpyXM3uWNSvp?=
 =?us-ascii?Q?PYH3CCUrHKm5H3Y6EcJCzA7fPDKhrt68qn6w1MGoE8dfXZQ4dbmjf9G1/Ugv?=
 =?us-ascii?Q?uqdsU+7YnEn6KrIcADT34cdPq4NYhzZy/cnvL9NszupGJZ/mRcVlNrFFIC+c?=
 =?us-ascii?Q?0WbgV/NJ0XgUfJL/02vEoJsrbAiC1aMdaxVQ7V/hPbuHPf/39s0uPPFeBXXo?=
 =?us-ascii?Q?cat9aX00QMofxvUdYFNrAXTUyqSk2m+EYEt5Ti08O9X2EPZcfL04?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 744025b6-7904-426c-199a-08def7131d02
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Aug 2026 19:10:59.9459
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sLiDo9C+G2Uz2bbkfGbgvVMsc0mrQKLVzSZIQtmvyM34la/4p8BqPioVbD9KLK3dqakGymeubmPRo3J58h/WBNHOeoj3ljt/15oFSrrl52L1MAuiQJrgrdNZrwPD9GG9
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB9079

On Sun, Aug 09, 2026 at 01:42:13AM +0900, Koichiro Den wrote:
> On Thu, Aug 06, 2026 at 11:50:33AM -0500, Frank Li wrote:
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
> > Thank you for your great work, let me read and feedback to you, do you have
> > irc, discord or other instance message channel.
>
> Hi, sorry about late response. Would matrix work for you? I'm @koichiroden.
> I'm in UTC+0900 (Japan Standard Time), by the way.

which irc server?

Frank
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
