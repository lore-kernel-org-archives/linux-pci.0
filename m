Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010065.outbound.protection.outlook.com [52.101.84.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C7D235DA6A;
	Thu,  9 Jul 2026 15:09:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783609755; cv=fail; b=N20seCfBwdpkCnMU9AIxTLxH1qy6Ved9Gvl1mUW6iJ3eIkRF0wL1roRujKH2Y85KBtzZFWiSmR0iOlcBQLO1WTCpQraF+mU11p65DoNfkfQeXjY8NMWBHi1JBM/6J/luJPbFViEG2R96M/Hebr8FnpORwKyptMOoOmofgitxLQM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783609755; c=relaxed/simple;
	bh=jnYP3y7e4thneTtCl17R9p7b2tlXrDZ9E4dKVjZ1QlY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=cqjtdWCnrJa0Fh9dxbIsZAC5GZPC7YGOqZD+FJJDtYfk3Sh9PCjkQXrCs93Ey4MtYkJk3UJGZefumvMxXD0NJ9Hijv/lOS/KI9/2a7IkNyWhbWeRa3mXSU6IoXlq97uiUvla7CYOTprS4YeKfdZtT6e4TFAjzAGdFNaXhovPonA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=IPRs2OCk; arc=fail smtp.client-ip=52.101.84.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="IPRs2OCk"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CW2EPzzfk7miuqBQNyHY8eZNcaddXhZLKoUe84nGBxlG1RKquT4qESOZAUyeO2SWhtVczc+Ly79viI4pS+gDjgRRrBO+5JkUDOQXa4XBEoZq6OSiyTyUCygd4T0/gQqpNPD8y8nG8wXznYGZlkseo3jv7o2MWmAIF3Ds8qxOCGp1cZh92QWIt0aPrWcd0l+n58SaHn8Rv+zt2CWMMPpNgMhaIRdJaVHrTEKLvRQ7iH+z1PMHvEv3sevAD/i2uQS+HHxYGVZvrod0VeEzp8wrel/EAaegHFviDK1qqKO6Ntgwz6+YN2HWN5sWoX5WeYhqOoAK5soXwJrg3SeiizI9qQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rVxAtIGBlLPLXw7IbTgLE+1NXm28ROHanewzT/lzYSc=;
 b=TQiKTShG+DFnRfOuCIjylf/9ihyI691GymJzAoF8daGYTK36LCYB6C5XJ39jNeUxNF4iiiNmxn0MqsAlymZKVuyk4wrGbNxCtAl1zuM4VoxYd4P1yI3ttExISk0PEvS45U8IGHjnIcJHJdSFzb3jwbvFy9cHlgvK6w/vHujL096jdXEvtnzNLS3hkrvtrj0tdyxMcAuCEdn5QAbbiX2saRewXlBO+nse+lIMYCA7cRIfjfyX8RHmz5JpsYmDdaS5hPg50FlkAEGQnHbmhHbZXbryxwY+LHIuQjtA5hEotX7Xx88F9HkvRvimPJnaZPe/XJqncwXj03m5ARXnpwWxIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rVxAtIGBlLPLXw7IbTgLE+1NXm28ROHanewzT/lzYSc=;
 b=IPRs2OCkcgO+YKU8BsgMAbDSLq6CjLwuhJnIU5aFypxfZPaRHd3u0tDKC3MT+PW9Z500YW3siJawxWBl7bWZIm/Z0fN7Ia1vKVScQaFy4SZ85vhEBcBPuiouCeCrJ5WawE+wSCRJr8MrxI2bruZQqmwMtxym7BBUV1jBP2q3uzZXQsGSiLG4Hx+RLr+UwMqU85kDttmnoAfWQOFFvoDaGEKtxT5cnaqkgMbXfUFRdINgr95U5Oqyr6Gzgf7YcYf1iW6LRMVTf9voE5JIes1AcD3BKZddvoEZxCQxuQ/qrbwlDUxjxRJGUQZvDDLL4ZVc9VLE2pUa1o4jEkgqA6invg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9)
 by PAWPR04MB11551.eurprd04.prod.outlook.com (2603:10a6:102:509::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.15; Thu, 9 Jul
 2026 15:09:07 +0000
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c]) by GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c%6]) with mapi id 15.21.0159.007; Thu, 9 Jul 2026
 15:09:07 +0000
Date: Thu, 9 Jul 2026 10:08:56 -0500
From: Frank Li <Frank.li@oss.nxp.com>
To: "Hongxing Zhu (OSS)" <hongxing.zhu@oss.nxp.com>
Cc: Frank Li <frank.li@nxp.com>,
	"l.stach@pengutronix.de" <l.stach@pengutronix.de>,
	"lpieralisi@kernel.org" <lpieralisi@kernel.org>,
	"kwilczynski@kernel.org" <kwilczynski@kernel.org>,
	"mani@kernel.org" <mani@kernel.org>,
	"robh@kernel.org" <robh@kernel.org>,
	"bhelgaas@google.com" <bhelgaas@google.com>,
	"s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
	"kernel@pengutronix.de" <kernel@pengutronix.de>,
	"festevam@gmail.com" <festevam@gmail.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Hongxing Zhu <hongxing.zhu@nxp.com>
Subject: Re: [PATCH v2] PCI: imx6: Update MPLLB bandwidth to improve i.MX95
 Gen3 PCIe stability
Message-ID: <ak-5iCpBwKn1QkM6@SMW015318>
References: <20260708035928.580236-1-hongxing.zhu@oss.nxp.com>
 <20260708035928.580236-3-hongxing.zhu@oss.nxp.com>
 <ak5qZxsTsIWqe-ML@SMW015318>
 <GV2PR04MB1201927798A7D00F7900E97EC8CFE2@GV2PR04MB12019.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <GV2PR04MB1201927798A7D00F7900E97EC8CFE2@GV2PR04MB12019.eurprd04.prod.outlook.com>
X-ClientProxiedBy: SA0PR11CA0174.namprd11.prod.outlook.com
 (2603:10b6:806:1bb::29) To GV2PR04MB11799.eurprd04.prod.outlook.com
 (2603:10a6:150:2cf::9)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB11799:EE_|PAWPR04MB11551:EE_
X-MS-Office365-Filtering-Correlation-Id: 399b919f-3d2e-4349-8ce7-08deddcc056c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|19092799006|23010399003|376014|366016|7416014|3023799007|22082099003|18002099003|4143699003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	rnDRNYYTesrOe1nVjYnZ3ZlrCSReQJbKWONW2S5ireJsspgsY1bEaNM6mjuDUfuYvJoH/FGGaGkFON8S3x8LjkQ144OIBSoTv5mwtsCAeEPli0oKprfwlHvWaoZbRK6lYCpBo7N8KQYcRRqFNUOf5aYVJWHuqItaUhapOEMU80gWyL1Mlb0XHuuuM1vhLITl09/8ZYn8N1cSJKBSm+vA9Lf6IsXJsJrM5Eaj9G3mErnKftfZnE42R9jBFPqY6W8McpVSAxp2jZi6wK7xSVjBqGV/cZT+IVFg4njFGIoZ4jRydo1KsAe7N1AgT2oKJrNLsz7wfB+HWXdkM5xLYuwWp2N69fN7cTWz6iwdI3GnbLP/K6XArcaPqLU53WSgGHH4EIUwoRxegbX+3ExkE3oSRz2dPAV7DI4TcMOpyjHyhPdSqP5y29PGvOJjuiHPTOpVJaZU8aRDjNUb8qvQJ7VZTW4zfLAgNo2bwwav+xmKHgEtafYeRyvDII9m79lQMRh0bFLHAJJiEAve47E64bgkT/N2O7Y0XLeeXHKOX2HimsIbgwRAyE+j3yIISBLZyXZKK3rRDP/pHm9LY/Kv+y/tSM4+zdiB/LEJXuh8iTen3zC92bghv3T+pPjgzonRnhD5jV/prb4rnFSNZBFVydxKc9+3HuGziVFHH4aHlPj2hEU=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11799.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(19092799006)(23010399003)(376014)(366016)(7416014)(3023799007)(22082099003)(18002099003)(4143699003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?9n1xle2cZlOsSEH2XKnFGEmJ74e5sh607jz5QY5lFRt+y9xGtoaNtxmF4Br1?=
 =?us-ascii?Q?yZkHj4QeMTqrgle9aJT1O/FDEYD3hdagEn6SiWhahTCJqlmBPAYITR7bsM5K?=
 =?us-ascii?Q?MqIjSIL4P85sDC079zjGJ8nOOTvpVpRTcCTksXRVrBWmjouXL17B8b43ltY5?=
 =?us-ascii?Q?mLkT2FSqDOse3YO/Tv23ZMQbBo8sDOUh2fk9Smvaal0w7Cy/xpsBhnpZg2FE?=
 =?us-ascii?Q?Iesxo6amvV6py6PZe0RcC8GGLC9oMcew5h8HCMXSVlhSZrfYIRJmLBflc59Z?=
 =?us-ascii?Q?HO9Ih9w1vBigyw/Ba4MSI3YV74HKRUM3Eoco7UHHAOWfTLIQIu2TqG7pWwJd?=
 =?us-ascii?Q?ExIIhONgYe81XcpOl8o9INuPia5u7fjrSUHgWcReosp/xJKAGih0qIqbyTnc?=
 =?us-ascii?Q?y3z/S0MtkElJy52ftm+SImtOvbA6SiSTH5EldNvUxNxloBsTSwqel2Ekbpgn?=
 =?us-ascii?Q?tizC0gTKSgdLPV49zmifYmgnay2tsrbG53/fi3ME6TpwbNsWMff48nADwJ0q?=
 =?us-ascii?Q?GzYUwaG23b5AfgddKIOFa6EdqT2gyLLgIhViBaloPVk+sDEmf1XkEEHJyWu2?=
 =?us-ascii?Q?xIfn5wm6vBcxw1YNFPTttjWG8dtdf2zUfNGl1ceYT45het1bMILP2FiI8SqO?=
 =?us-ascii?Q?pApDd9SyZd6/Xkio86658sKBBMq1AZyqnojpqPU8ovCj8CoVw4bbn+To86k3?=
 =?us-ascii?Q?FGu6QWelLX7/Ay/u0RoiZtd13aN/PIkyeEcobYdw5mgzgu6iLbddFH/OEX9y?=
 =?us-ascii?Q?O64/K1M7h9DODUzov6ArzOULwIpIoE9JJky4Pq9DyPft6sZhrULx8J/9mjzU?=
 =?us-ascii?Q?DTbeHY9hHTl1/j7eX0eQm0rR6WOYR/eyKyQpni8t/6APkPkZPtfgq53Ty882?=
 =?us-ascii?Q?xMZl7N/ALH+Y/+zLTVYXHl5zJrk6mGdbrxCBIH5K6fD4Dttx8Q8FwbgQfWk/?=
 =?us-ascii?Q?+dnvMlaNt+T1sF4z7Q5PCZL5aU5oa9PRqbHQ/mWpvC2aqRVBl2CNFXmfc6n+?=
 =?us-ascii?Q?df32X48dUsiWdgNB00kH9ZGZZFQdefIAyi8BPF9n9kl9NOqhqCzWjEUFzlrp?=
 =?us-ascii?Q?okRwWNqZuvgjLhsoJ/TPti59hxzjCb9geVxMIYNnPlr45a7BL0iTkJSgF9hN?=
 =?us-ascii?Q?eNds3jBBZde5cLveRZuZKWVbgiDHV1lbaeEw3xTOhKrp3d4GRTxc4ShTul42?=
 =?us-ascii?Q?s7ae+bl3WnxEcPQDPt7eP4XrVaBB4LlQpqTPdZaC0H3xkcOflRIBxz4Y9J+h?=
 =?us-ascii?Q?n/bupOiEgW0VIgeenkP2Pzx5kVyl/uQNyDqvoz6m/Vyici+mMBw7xN6QNAdY?=
 =?us-ascii?Q?tQsvUxQzjq1zYJZPaBdQJHuEtcF/LRXKh2cWbYM/yxJbRuql/7YIajYAtVlD?=
 =?us-ascii?Q?JQcnHfa/SON2LYLmyaWsFoWIe0z6Yv7bPd7+dV6Lw8xazQZWatfE7fUo3Uav?=
 =?us-ascii?Q?A+Fla92HG8q2hLVHcGUfFd1UlBlerOKM7wXQNBPRfjLRma+wh/pq4rUsnRwI?=
 =?us-ascii?Q?rZVavxkb2mIfXwB0Sn7LRBXFDDaUOcEIsxJ7wmJp3LIp9xvZ49oHMcFg83GA?=
 =?us-ascii?Q?2SpBZJiKW6Bw8VmVnY3wREDvu7jThggJf29rzcTZ1l9dj5OOUuHLF0sg/1jE?=
 =?us-ascii?Q?/PZqXsVp84BZQb2CWggAOzw4Lrtw+cZIiUn7ontkyKXts2D7oNSQDJkwgvg3?=
 =?us-ascii?Q?UfoEtEoQVezvyNr7iodnsGXeNYyKLc8CODwPvLKaHrTGAS9r4HqEK1y+bxNf?=
 =?us-ascii?Q?0alnRKVzrXB6agvASFMvXWdekSLCC71jILGnBF8xzu8eqzX0zgtE?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 399b919f-3d2e-4349-8ce7-08deddcc056c
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2026 15:09:07.0520
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6fRUHRt/2FKMmUoo8HVGD36EBhAkL3RhsreH0mKl2sroFb1/WdfciTUJwDdojLXSpjK/BYw1Fwcw6LYHNulOZb0dP4YVQTK1wf0pWR8nSrG0moI21I5FLLp3AbHc3otm
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR04MB11551

On Thu, Jul 09, 2026 at 07:55:10AM +0000, Hongxing Zhu (OSS) wrote:
> > -----Original Message-----
> > From: Frank Li (OSS) <frank.li@oss.nxp.com>
> > Sent: Wednesday, July 8, 2026 11:19 PM
> > To: Hongxing Zhu (OSS) <hongxing.zhu@oss.nxp.com>
> > Cc: Frank Li <frank.li@nxp.com>; l.stach@pengutronix.de; lpieralisi@kernel.org;
> > kwilczynski@kernel.org; mani@kernel.org; robh@kernel.org;
> > bhelgaas@google.com; s.hauer@pengutronix.de; kernel@pengutronix.de;
> > festevam@gmail.com; linux-pci@vger.kernel.org; linux-arm-
> > kernel@lists.infradead.org; imx@lists.linux.dev; linux-kernel@vger.kernel.org;
> > Hongxing Zhu <hongxing.zhu@nxp.com>
> > Subject: Re: [PATCH v2] PCI: imx6: Update MPLLB bandwidth to improve i.MX95
> > Gen3 PCIe stability
> >
> > On Wed, Jul 08, 2026 at 11:59:28AM +0800, hongxing.zhu@oss.nxp.com wrote:
> > > From: Richard Zhu <hongxing.zhu@nxp.com>
> > >
> > > Bandwidth marginality was observed during i.MX95 Gen3 PCIe tests with
> > > the default MPLLB_BINDWIDTH value. This margin degradation worsens
> > > across voltage and temperature (VT) variations and different test
> > > matrices, potentially causing link stability issues.
> > >
> > > Testing with MPLLB_BINDWIDTH value of 140 (0x8c) shows significant
> > > improvement in bandwidth margins across all VT conditions and test
> > > scenarios.
> > >
> > > Implement PHY register write helper function and configure:
> > > - MPLLB_BW_OVRD_IN = 140 (0x8c) for improved bandwidth margin
> > > - MPLLB_BW_OVRD_EN to enable the override
> > >
> > > This ensures robust PCIe Gen3 performance across all operating
> > > conditions.
> > >
> > > Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
> > > ---
> > > Changes in v2:
> > > Update the register name and bit definitions.
> > > Don't move IMX95_PCIE_PHY_CR_PARA_SEL settings.
> > > ---
> > >  drivers/pci/controller/dwc/pci-imx6.c | 24 ++++++++++++++++++++++++
> > >  1 file changed, 24 insertions(+)
> > >
> > > diff --git a/drivers/pci/controller/dwc/pci-imx6.c
> > > b/drivers/pci/controller/dwc/pci-imx6.c
> > > index 53f3da6ab30d5..5f75aa09e0377 100644
> > > --- a/drivers/pci/controller/dwc/pci-imx6.c
> > > +++ b/drivers/pci/controller/dwc/pci-imx6.c
> > > @@ -80,6 +80,15 @@
> > >  #define IMX95_SID_MASK				GENMASK(5, 0)
> > >  #define IMX95_MAX_LUT				32
> > >
> > > +#define IMX95_PCIE_PHY_REG_ADDR			0x3008
> > > +#define IMX95_PCIE_PHY_REG_EN			BIT(31)
> > > +#define IMX95_PCIE_PHY_REG_ADDR_MASK		GENMASK(15, 0)
> > > +#define IMX95_PCIE_PHY_REG_DATA			0x300c
> > > +#define IMX95_PCIE_PHY_MPLLB_OVRD_IN		0x2004
> > > +#define IMX95_PCIE_PHY_MPLLB_OVRD_BW_EN		0x400
> >
> > > +#define IMX95_PCIE_PHY_MPLLB_OVRD_BW_IN		0x2005
> >
> > This one IMX95_PCIE_PHY_MPLLB_BW_IN to keep naming consistent
> >
> > write IMX95_PCIE_PHY_MPLLB_OVRD_BW_EN ->
> > IMX95_PCIE_PHY_MPLLB_OVRD_IN write IMX95_PCIE_PHY_MPLLB_BW ->
> > IMX95_PCIE_PHY_MPLLB_BW_IN
> >
> > > +#define IMX95_PCIE_PHY_MPLLB_BW			0x8c
> >
> > 0x8c only one special value.
> >
> > IMX95_PCIE_PHY_MPLLB_BW_XXX put special name for 0x8c, if no means, you
> > can put 0x8c direct at
> >
> > imx95_pcie_phy_write(imx_pcie, IMX95_PCIE_PHY_MPLLB_OVRD_BW_IN,
> > 0x8c)
> >
> > We need knows what's macro means, like it is offset of regiser or it is field in
> > register easily.
> How about add some comments as below?
> +/* BIT(10): Override enable for mpllb_bandwidth[15:0] */
>  #define IMX95_PCIE_PHY_MPLLB_OVRD_BW_EN                0x400
> -#define IMX95_PCIE_PHY_MPLLB_OVRD_BW_IN                0x2005
> -#define IMX95_PCIE_PHY_MPLLB_BW                        0x8c
> +/* Register offset: Override value for mpllb_bandwidth[15:0] */
> +#define IMX95_PCIE_PHY_MPLLB_BW_IN             0x2005
> +#define IMX95_PCIE_PHY_MPLLB_BW_VAL            0x8c

Okay

Frank

>
>  #define IMX95_PCIE_RST_CTRL                    0x3010
>  #define IMX95_PCIE_COLD_RST                    BIT(0)
> @@ -309,8 +311,8 @@ static int imx95_pcie_init_phy(struct imx_pcie *imx_pcie)
>                         IMX95_PCIE_PHY_CR_PARA_SEL,
>                         IMX95_PCIE_PHY_CR_PARA_SEL);
>
> -       imx95_pcie_phy_write(imx_pcie, IMX95_PCIE_PHY_MPLLB_OVRD_BW_IN,
> -                            IMX95_PCIE_PHY_MPLLB_BW);
> +       imx95_pcie_phy_write(imx_pcie, IMX95_PCIE_PHY_MPLLB_BW_IN,
> +                            IMX95_PCIE_PHY_MPLLB_BW_VAL);
>
> Best Regards
> Richard Zhu
> >
> > Frank
> >
> > > +
> > >  #define IMX95_PCIE_RST_CTRL			0x3010
> > >  #define IMX95_PCIE_COLD_RST			BIT(0)
> > >
> > > @@ -269,6 +278,16 @@ static int imx95_pcie_select_ref_clk_src(struct
> > imx_pcie *imx_pcie)
> > >  	return 0;
> > >  }
> > >
> > > +static void imx95_pcie_phy_write(struct imx_pcie *imx_pcie, int addr,
> > > +u16 data) {
> > > +	udelay(200);
> > > +	regmap_update_bits(imx_pcie->iomuxc_gpr,
> > IMX95_PCIE_PHY_REG_ADDR,
> > > +			   IMX95_PCIE_PHY_REG_EN,
> > IMX95_PCIE_PHY_REG_EN);
> > > +	regmap_update_bits(imx_pcie->iomuxc_gpr,
> > IMX95_PCIE_PHY_REG_ADDR,
> > > +			   IMX95_PCIE_PHY_REG_ADDR_MASK, addr);
> > > +	regmap_write(imx_pcie->iomuxc_gpr, IMX95_PCIE_PHY_REG_DATA,
> > data); }
> > > +
> > >  static int imx95_pcie_init_phy(struct imx_pcie *imx_pcie)  {
> > >  	/*
> > > @@ -289,6 +308,11 @@ static int imx95_pcie_init_phy(struct imx_pcie
> > *imx_pcie)
> > >  			IMX95_PCIE_PHY_CR_PARA_SEL,
> > >  			IMX95_PCIE_PHY_CR_PARA_SEL);
> > >
> > > +	imx95_pcie_phy_write(imx_pcie,
> > IMX95_PCIE_PHY_MPLLB_OVRD_BW_IN,
> > > +			     IMX95_PCIE_PHY_MPLLB_BW);
> > > +	imx95_pcie_phy_write(imx_pcie, IMX95_PCIE_PHY_MPLLB_OVRD_IN,
> > > +			     IMX95_PCIE_PHY_MPLLB_OVRD_BW_EN);
> > > +
> > >  	return 0;
> > >  }
> > >
> > > --
> > > 2.34.1
> > >
> > >
