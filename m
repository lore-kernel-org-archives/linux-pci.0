Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013054.outbound.protection.outlook.com [40.107.159.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90D05227BA4;
	Mon, 26 Jan 2026 17:48:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769449684; cv=fail; b=R1Qb4XongvMi2vj73r4uKz/NLWMpMbxw+OzHHeJqbhDm1KO1irkPV0eFjeYXemv5yAIXV+mWyz6TvrVhwz9Il/dL2EvkTsV9jZj8Esfv6/FqsADF1dnEtwFg8r6N9OdwY3NLLTP81w4YpNlVfe4T3AjYskmJnyKN5CSuRW7Syd0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769449684; c=relaxed/simple;
	bh=MIjnM+Z9qcJwP0rQdDYiR/sJZhV+Ox8HtWng1Bmnzuc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=dfmYhBwRRbp43q6PE69oPKgn8G4Xe1cn6C4DifgW+2nL1ImfA4oaOvW2dCU+dV/fdw5KBYaXwP9Bl2a7taC03+iVy9FiGYL3S++xqpHMsrU961mntoAEg/SiumF3YJ6IBWbkV4LgKN7dUcuvtltdyxrZzxzqc5kJ52cukWXpE3M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=GfFYZjm5; arc=fail smtp.client-ip=40.107.159.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="GfFYZjm5"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LI0yV37kvNbio4xo9iM28JeksS3O7Qp2pjb6/8IF69Ll83Zybtui1BEiCP2r978FH1caleQqXR03MT2NKZ/4zs280pCRm/FgxbeFQlR1RyOIuYMXySnrp0pskhmBSWO2vB1lgWD5q6fB+i4KHhtfv5BC8XvFj8N4L5046PuEs/muHeCFZsMyM3DzJWFGHJN8NUpNNUeLiUf9mY4poa/+aK0jTxmfntWElkN3ZEwhubpFz81INJBraXWWCRIq3xLFVvLbOToJB4bOO8TG39w2fV0UyK4kpqJa8oeOuva+j9KuuSloDjQKsfXX5fyHjSkFdOtoWYUoG2p+su9ppn3tDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7OxO4CVl4eX0Jq4vHD44QgNt0IkR1R52eSsbKPy71RQ=;
 b=MOoPMUC+H8q1G1djivl6BBV71HxEEoTJ8035lGiqajdvwl2WKrSxejbp6eoT1NxRye4MItbBsZUhNzpqrx83+LdUHR+3KDq0dmiMxCUSsXSVJA89oMxkPgISiFguLSt2LE3leC0tQYU9fPJqKI/bxMsvxPveUiKJDm0bLwU9B3Y7fvDFsMeBRZDuq4Rtuy9DIr2bX3LI4l9i3bJXffAYOsbgE8iMyFe/2V3d5pyEr2OzKzjOlmA+XC7c8PTc7dMW2QxpQxhxy4xM+G049zu/3FPnW+7NWE9g2aai04DI9V7spNX5oDKtNe/wGTTnPgefR/pplyvYL/bJTL1oVCQVmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7OxO4CVl4eX0Jq4vHD44QgNt0IkR1R52eSsbKPy71RQ=;
 b=GfFYZjm5KDrvtJo7GhWTOIrWZLXYg4ON+7ryZZ+OSjaDpyYN7vw0tWUWNRxNK4CoAF8LWz1AK1Ot0I/u8wjA4DSxSGiq+2OMQ7vYavmlgn6EbgkfyQ7Y93omTPlJP8CAkAUioT5m6RIcqljr1xePYYaWIQZrmMmGb1BKZAhYEvK6dF6VeVX/Iizspl2YNXMs84sTLnzto/lh67MlI3+xRWa8ny2bCwK+uW42qjj6aIYPvWmB5BvQiyuXQM2NQSYsMmaqCnWJ7iYNlUgiPbKphUbcwE6D+VQixH5KR83rFi1JDlMT6vDf+jO50Py91Tp60HEeS4NoDpkbumwm33GF8Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com (2603:10a6:102:2a9::8)
 by DB9PR04MB11558.eurprd04.prod.outlook.com (2603:10a6:10:60c::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.15; Mon, 26 Jan
 2026 17:48:00 +0000
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588]) by PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588%6]) with mapi id 15.20.9520.005; Mon, 26 Jan 2026
 17:48:00 +0000
Date: Mon, 26 Jan 2026 12:47:51 -0500
From: Frank Li <Frank.li@nxp.com>
To: Koichiro Den <den@valinux.co.jp>
Cc: jingoohan1@gmail.com, mani@kernel.org, lpieralisi@kernel.org,
	kwilczynski@kernel.org, robh@kernel.org, bhelgaas@google.com,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] PCI: dwc: Expose integrated DesignWare eDMA windows
Message-ID: <aXeoxxG+9cFML1sx@lizhi-Precision-Tower-5810>
References: <20260126071550.3233631-1-den@valinux.co.jp>
 <x4cilkxvg5ccqqx244ttxgh2kgj7x6bf2e35suwguels5yiqxc@ij53hgrert7j>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <x4cilkxvg5ccqqx244ttxgh2kgj7x6bf2e35suwguels5yiqxc@ij53hgrert7j>
X-ClientProxiedBy: SJ0PR03CA0183.namprd03.prod.outlook.com
 (2603:10b6:a03:2ef::8) To PA4PR04MB9366.eurprd04.prod.outlook.com
 (2603:10a6:102:2a9::8)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB9366:EE_|DB9PR04MB11558:EE_
X-MS-Office365-Filtering-Correlation-Id: 4b300547-2771-4ae3-417b-08de5d030bec
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|19092799006|376014|52116014|7053199007|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?VaL9X5aRnw3FYKE8zTwv7Kh+U96bVFw88YQQIvtnHgiPEHCHcN6D/CzYqKE/?=
 =?us-ascii?Q?/0wMUzPA2MS/VwrEovV+Gl54DwVYo+bpCHWbklt/dQqBFCg55oBH3U7b8xco?=
 =?us-ascii?Q?JtGVo7P521QoYR81BZlIa2OyuaIkyo8nE8/UVPim0mxemSmPafz57dtwCwp6?=
 =?us-ascii?Q?3H817CiDyDq5a8vYr3Rk1tN6E9hOp00ynBfaZej4FfkjOrv1FbwZTQQSiOBy?=
 =?us-ascii?Q?8/xEuAaCI9eQMaIvubKygCiLZ2zlRA8Q1b6SPyDqYzkOQMGf4K/DVtu9bXbD?=
 =?us-ascii?Q?Q6ATwjRokoOAm7nuct/3Kn8zAHtJLr62pyzj6jll3r5SiqcT4STZNr/RCkZ1?=
 =?us-ascii?Q?TR1ahb0+bNKqC7zrqKzEuJIW1mNjbckquZ02gPj82lHOFRlSnKls3wFHTp6p?=
 =?us-ascii?Q?y1vj96j4L8c1d6NrFTlOqh55pW6tWU32ch39xKVpLcw7WSJIhrichyiWQrbv?=
 =?us-ascii?Q?GE7UzBGkDbWqntlg7wSsoC6sdX6yGtDWFJE0doe/89CeTIyygF8h8+8c7dUi?=
 =?us-ascii?Q?JuU0axCo8qf5HxjPGlYVoSa5snlOmOOSq5hpqUMj+5JMSWiYVbE1cx+wpeVv?=
 =?us-ascii?Q?pW7rk0swTl3fzapGaODo/fyCdNnHCmyFbVrzCJ3Akn99q9Vjxke94jD2uj44?=
 =?us-ascii?Q?GWyx69wOMRqR3Bvi9DYEmlmvJtyCcCzzZaT4c3GTV6vtmL5mQkTiqCH+7jez?=
 =?us-ascii?Q?gztOuapIB89A6pmrYFR3xRdk+m65K/vZ1EddugUiHJrINTBHhyukh9tD9cED?=
 =?us-ascii?Q?JLkd4VQx0h0VjPhNdl/ulLqxSdONTBenX17eXo/Mu5yjcg2p9a9OAkP6cDry?=
 =?us-ascii?Q?BzFdShl3/zVWYBXf+QF4R9CUaAmXset6RiiJpAomdG/V+eONymNWHZpGJVom?=
 =?us-ascii?Q?OkFe84noUnGQLoocNSGXwNESP5O2Y2KXbIqLGjdGCmw5KtFYKX01Ey6IZXL7?=
 =?us-ascii?Q?HI3ophgaRyC2SE9UeftPtbt9zSLfAt8xvgGSo+YSvZ/RfE/OXn6nT1awDj/G?=
 =?us-ascii?Q?1RhBH9DQJE507pYgIo9s6RQnvMI3Pqhmc0zFMm9BmjUu6M4cO8TnHrV8S80Z?=
 =?us-ascii?Q?o9uuvXGSlzbSrJBfccwBrDjeGZcPWQOpypoPFl90iHjJDThs7K+v8B5f9toC?=
 =?us-ascii?Q?YYjUKum30tjn9AHj1Rbkix7iDT0mo68j0eaHBJcrMZQB1fFQ21YnuijzecB7?=
 =?us-ascii?Q?IVPVSOoeIyDIVH98Iw24GUYcJxF/uxb2iSC3WAUkIDo9HLP6a2d3Z8EDMNQa?=
 =?us-ascii?Q?qQiqmrYLHHeJL69WQb+hnXGnX4MvMZXoRiOg/wKpfCbirzUDKf4/b5I68JDc?=
 =?us-ascii?Q?hIZR9HBIb+s2inJydLKEhHYHOmuwaXOVSg93ZHd+/xPefB+wm3A4USOc0xNA?=
 =?us-ascii?Q?jk2Xxh+hi9XPT3pJIMwtVc4RFCJf385CXEwuieuR/ofc+c3Qk8cyqTKCJKcP?=
 =?us-ascii?Q?ZhbhY5Sp/HQERYq+8exwNdAi+BdZLqsettyFOzjUkRaZo+94zh6JoZ5yCv4b?=
 =?us-ascii?Q?OWvkJ2FWhFUxWOoHKChcPSM9HUP9RfSTaJKsJl4FQRBHY5EODhpGd8MjOT0j?=
 =?us-ascii?Q?hm+/MYSrDPK0cPF2LinWe2ds5dq+uUmHHHTLB8sRMLJlFFqA/scBwao8e9m6?=
 =?us-ascii?Q?ENOgX5vi2DtDIfZTV7hrjHs=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9366.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(19092799006)(376014)(52116014)(7053199007)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?i+mLk7XdN/TlWHazdPGM9nxCzzcZsDp2J4i2QmbimguFCFWJSNCwnWi+CZNe?=
 =?us-ascii?Q?Q0+DGYQHbyXkvh3x3eZvYr2PIO3bKHyyzC9IovHKr9PC0brbIbq+tia09hZn?=
 =?us-ascii?Q?BUCLaWMD3l/n0di5jVwi8lb9cK5M3uXxW+Pg/dV/oIQipFg/P5zLzhv3o/qZ?=
 =?us-ascii?Q?w05Ixt/9qoCsLwQ7+U9wJjnwNerl5gYmATpFaMU0qi+fSpQ8wWlkVr1jU7vM?=
 =?us-ascii?Q?IMx9AhpsxQupubbstyckNCIuyQXodf10GRlR13pEk6ke9btHBjk2v4pw2d4B?=
 =?us-ascii?Q?2XHNxXqOO9txVStU2zOF9fsSO8n39D+HVfBshtoKZJTf5pb1SrebA6HS6xyv?=
 =?us-ascii?Q?Ih24kPt5ee8so/n7mE1bpgJ6vZoLB9DFB541nIxmfQH/XwkFMqPwsjGJQcVV?=
 =?us-ascii?Q?82iQLKOFgRHH+yJJxnyGdpYd6fcWPFftKRziBKUsdSH0LaDALcn1ZhEmWgPV?=
 =?us-ascii?Q?dKAxWleoLq0veint/VhW/YDsi7uoGS/gkQdbRGIHn6t2lho7X+UpsohPHc5a?=
 =?us-ascii?Q?+PVvFocVteh8p2+L023GC4NZ98e8FdxhVm3rDr8oXnsZCQ7yPKnzrRRZKgEe?=
 =?us-ascii?Q?IKlYyM5YXFfhhmz7zMmTGMHPk75tEQ8bgSj7j4FBdUShKYB7cX/oWHvyjvNT?=
 =?us-ascii?Q?2QzVMtuHKmGhtsCm0wwCwy/X+XoTaiHo7VH/St0LFortBwRus5JtGSSppAGR?=
 =?us-ascii?Q?P/qcaZ4MFcq1TUNKcg3iUAg1Wr5lCN7W2+eV0gGk/X2PNZPZ7XV91aHNTU8j?=
 =?us-ascii?Q?RoOhwi+cDKJlFAd4pW8rZCoKgfRMy6Lk1mVz99hk326MvG6dGDe1C6ip3H1J?=
 =?us-ascii?Q?LoP1/tn8KOF90MbS/k4IvuwO7E0peikdzMESCLaEE54kcfYkV7Q/wxCGTsBe?=
 =?us-ascii?Q?6eZ2aCWWlcE+hG80JFRyQPK4ucczTiR+ucaml47+6+j7YBd7ONloDihfmAfZ?=
 =?us-ascii?Q?s8JjoR35JhsO3UpCOa4e+jWdSaejE9sytrmaHi1snGedOIDB9MqjCCG+aGqs?=
 =?us-ascii?Q?M2vqQ/NEHoXAlaE1JHwPszdZS1BpIXVYffO4osdn0vm+1/3gqNciWKFTaFek?=
 =?us-ascii?Q?ijW7cIinaz9boe4RcMNNMV+qoZJzDjK6wjdtKymvaMWxT3TaShulQySU+bb8?=
 =?us-ascii?Q?IChxHXkJIN/GILtGLn8SCI6l5dOUiSSLy9wXQf2bf5zXoKPwsHwYmSUBWG3+?=
 =?us-ascii?Q?lQ/wrPnBfsC8XyU2QAf9e5Gl2UX9W5wPgbYjMzEWyo8S2tdEZTSm/6oLws5g?=
 =?us-ascii?Q?Q3XOzEFYpP9dK374p65KqrYMb6kFzt63m5PGETuNA7cGC/vUXZjNFpEG5lhu?=
 =?us-ascii?Q?knV5L23jXBFakBcJaTwCcxGfFq+176H/WimEIhTHTQon5Z6uzmcjk5m4lNMB?=
 =?us-ascii?Q?Wwno9b7dQnY5ZADX1EPJerHmk+923jivVdJTG8l9NDAO/smL9wh4O4481vmK?=
 =?us-ascii?Q?7VeB04eQF+caZjfgguwM6H2Ck2VtwQkiGcAAfj8Lg/Y4AchT1I5jCoyi+LzF?=
 =?us-ascii?Q?GPsN5i4WcZGg+vwxq9CCNqWUudkdQRZidvTbiUKQ4HUktlWBgc4k2CeXiu+Z?=
 =?us-ascii?Q?6guQAUCh4HxqJVFhMwOyit536kjKqapBF6Ko2xXAyF1TwClGLRZGHLpnMjPe?=
 =?us-ascii?Q?yLLE+PpyjP6EXjpJuFbJSPIYcz4Y3D6A464vS4J3vLY1mX9Lx9DrSx9pbYrc?=
 =?us-ascii?Q?eZtTInoPIIwneSUUBtNygDhZrP7vc+GYbN/2gfM5OqDBmdB4?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b300547-2771-4ae3-417b-08de5d030bec
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9366.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jan 2026 17:48:00.1169
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vxfYAamXzRJTpg+O6L92b4GXSJMN3+lYc4H8plfcS18xZ9ZRrhWT606HAMClHT3fzOaokpt/Y/V5Bl2nP4yAaw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB11558

On Mon, Jan 26, 2026 at 04:55:58PM +0900, Koichiro Den wrote:
> On Mon, Jan 26, 2026 at 04:15:48PM +0900, Koichiro Den wrote:
> > This series adds small, query-only helper APIs to the DesignWare PCIe
> > endpoint controller driver to expose resources of an integrated
> > DesignWare eDMA instance. Specifically, it allows querying:
> >
> >   - the physical base address and size of the integrated eDMA register
> >     aperture, and
> >   - the per-channel linked-list (LL) region base and size, keyed by
> >     transfer direction and hardware channel identifier.
> >
> > The motivation is that some DesignWare PCIe endpoint platforms integrate
> > an eDMA engine that can be driven either locally by the endpoint or
> > remotely by the host. Remote eDMA use cases (e.g. [1]) need to expose
> > the eDMA register block and LL regions to the host through PCIe BARs,
> > while still allowing the endpoint to boot with a standard EP settings,
> > without DT changes to hide the eDMA instance from the endpoint itself.
> >
> > The hardware channel identifier used by the LL-region helper can be
> > obtained via dma_get_slave_caps().hw_id, introduced by a dmaengine
> > series posted separately.
>
> For reference, the series has been submitted here:
>
>   [PATCH 0/5] dmaengine: dw-edma: Add helpers for remote eDMA use scenarios
>   https://lore.kernel.org/dmaengine/20260126073652.3293564-1-den@valinux.co.jp/

It'd better post together. It needs API user.

Frank
>
> Kind regards,
> Koichiro
>
> >
> > [1] [RFC PATCH v4 00/38] NTB transport backed by PCI EP embedded DMA
> >     https://lore.kernel.org/linux-pci/20260118135440.1958279-1-den@valinux.co.jp/
> >
> > Developed on PCI controller/dwc:
> >   commit 0ecd890e3cf5 ("PCI: dwc: Rename dw_pcie_rp::has_msi_ctrl to
> >                         dw_pcie_rp::use_imsi_rx for clarity")
> >
> > Kind regards,
> >
> > Koichiro Den (2):
> >   PCI: dwc: Add helper to query integrated dw-edma register window
> >   PCI: dwc: Add helper to query integrated dw-edma linked-list region
> >
> >  MAINTAINERS                                  |  2 +-
> >  drivers/pci/controller/dwc/pcie-designware.c | 74 ++++++++++++++++++++
> >  drivers/pci/controller/dwc/pcie-designware.h |  2 +
> >  include/linux/pcie-dwc-edma.h                | 72 +++++++++++++++++++
> >  4 files changed, 149 insertions(+), 1 deletion(-)
> >  create mode 100644 include/linux/pcie-dwc-edma.h
> >
> > --
> > 2.51.0
> >
