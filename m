Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.159.59
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795453049;
	b=maHmz54DT9ESOWepy7kOr3UFs6SsisTzQHBX1o1TMvsw0GuE9Cj5aizi8KHMsnc545ST
	 pPGM5QKW6k2WJlZ45MNRYpg8UuymN0+OKtFSIU4Oe94Vj/cZwsVgdy1Xa6yGiL6AQ1J/W
	 x4S32zjUVSQxiYZ5Bqd3HBMHUINMm7FM3TPSF2VBfZi9Hqp+OYur9tCSVTcLiURYxvgPQ
	 mnH8X5MJndF1L7wOTOZwBqr+jeEm9sV7/8Hm+HhXZw+PKS6DPV+mgd7UrrtAs0Ef6W94v
	 wFj5fJC768HhHi08feT+5D07aXbuTKqsH2J+f6iTZ8bJc6ujB+5baIIoVRA0RUYmmZw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795453049;
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
	bh=80aQkLY6UjaQSByLlgddT0UUZMb+tPTxz+bcynB4vJg=;
	b=hMaGz+L8rX6rJz6hHUWVcytU5BD4tsVNRr4iMqaUGO4iCY2MrOXzbniP/z6djXYM8uj7
	 dDuaRwMlcg8JI1A8wlU95b3mHz+TNaHRwerewsqpn1AJdjgLA5PbfI8qIvFRMW/xO/BkP
	 ym7gyOagpMGammyWsEltQ5qi/N3DUvvvjhZyZU4NtJywBi1Z6v+IUiySvGpKhnlUi0T8A
	 Sj+jqW8WPk8fX/LmUxYTy/t4WMBkbBCIT5ItJkcDJxQo+vZ5OIV8C3HMqZ+r1YYE0KMao
	 jf/Cg9FGYjWQpkcxktHJeSY5KO+N5OhVDMJkRAnr2jJAKofa/d60mXqHe4fMpS3ppaA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.nxp.com;
	spf=pass smtp.mailfrom=oss.nxp.com;
	dkim=pass header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=LshtOkQ2;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.159.59
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013059.outbound.protection.outlook.com [40.107.159.59])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A1DC606A327;
	Mon, 23 Nov 2026 16:57:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1A1DC606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=LshtOkQ2
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Zs7qBfusIojnOd7uT5ZuULSHXUMyNkr5C19TvUj3IC/eJlxslFOUfrUQ1kbjYQz11bZaksvtkhDHMQ6DBJriUoHLhN40do4mmGntesdzy0isRWK9Xb67PCh/WtHKNBbJCLm4pcvcCTFoz9nPPdCmqBcg4ahxp3tHIJ1wCIey/ROan08LAn+Fd6NrhEvUTwM5/JSz8RXYxohqXNLyQ1n3QzFAGPkie/LSbDoSvQEHh049jW4xB4Vy85BHDl1NKdjkn/1iiBWDD/c4zMxbIkG+rV0muD8o9w3Mb9lFDBYzCF4kXa6hAGkPvSO4/E+VQ9dBVLJKJWiTcpDXGlBbQeRUzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=80aQkLY6UjaQSByLlgddT0UUZMb+tPTxz+bcynB4vJg=;
 b=xgPrRg6o16W2XaHoIeU5udrEj9Nu0AtpFWFq4iPLZREdUHAj0dLLjDee+/xtDuOH6RnRUWlskIAHptsJu+/TELHBiGTpcv3deYzKq8SXNSxcqrWQZ7fLAXdQ/cyWdWqcjk6jRshSfPeSn2ozWT3vWmdlrXV0rS3FdqNYr/oKZozE83I0DoopsjABSXGYPgOTBbhi1ILny1mUJbTy84kBGe2Yd3+OsB6xcdELqFj5QREP/eW3eLiw/1zLv7HPySk1CUVgJgjjq7kZDefrGTiTIIjytypsoMghCfeVjdSlJPU/LuGNnZbmyL5SZ/4THonYqsFf2ttGub0p139zShfmhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=80aQkLY6UjaQSByLlgddT0UUZMb+tPTxz+bcynB4vJg=;
 b=LshtOkQ2sFJniHDEDEVvYijnnG2BglxQ+PmvelLJVZ0uWo05jooazqtF276OCRf5+kUu6KzEI5vJIERSy8TQQTG5F0BNzzYDNl5JQBM7FpKJF3emFB9i2POVF3glBCCnNVnq6O9tgFJjxviClNthoBzd1vmXlBDiq1esAXmbnuSqKm/eY7B3saxjYpI7ML9a0F2BXDSef4G92OI8EzriDu6G3cM7Gf1ZnDD56aR1jGifEyfQZzRDoke9uKpppI8tXKLHTsRlvFD+foY40/30fJK2QI7RgIEHjS0LBIANwVQ1hWR1kh4pJ4GXTqksbq39ePmqRKKIvSAch2behZTTCA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from MI3PR04MB12438.eurprd04.prod.outlook.com (2603:10a6:290:76::14)
 by AM0PR04MB12001.eurprd04.prod.outlook.com (2603:10a6:20b:73f::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.14; Mon, 23 Nov
 2026 16:57:22 +0000
Received: from MI3PR04MB12438.eurprd04.prod.outlook.com
 ([fe80::c715:c32:8bb1:b70b]) by MI3PR04MB12438.eurprd04.prod.outlook.com
 ([fe80::c715:c32:8bb1:b70b%4]) with mapi id 15.21.0639.012; Mon, 23 Nov 2026
 16:57:22 +0000
Date: Mon, 23 Nov 2026 10:57:11 -0600
From: Frank Li <Frank.li@oss.nxp.com>
To: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Cc: Manivannan Sadhasivam <mani@kernel.org>,
	Jeff Hugo <jeff.hugo@oss.qualcomm.com>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Frank Li <Frank.Li@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Niklas Cassel <cassel@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Jingoo Han <jingoohan1@gmail.com>, Vinod Koul <vkoul@kernel.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Abel Vesa <abelvesa@kernel.org>, mhi@lists.linux.dev,
	linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org, linux-phy@lists.infradead.org
Subject: Re: [PATCH 06/11] phy: qcom: qmp-pcie: Add Nord endpoint mode init
 sequences
Message-ID: <awRwZ8ydn6W0pR_6@SMW015318>
References: <20261122-nord_ep-v1-0-6d8839ffa9aa@oss.qualcomm.com>
 <20261122-nord_ep-v1-6-6d8839ffa9aa@oss.qualcomm.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261122-nord_ep-v1-6-6d8839ffa9aa@oss.qualcomm.com>
X-ClientProxiedBy: PH8P220CA0033.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:510:348::11) To MI3PR04MB12438.eurprd04.prod.outlook.com
 (2603:10a6:290:76::14)
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
X-MS-TrafficTypeDiagnostic: MI3PR04MB12438:EE_|AM0PR04MB12001:EE_
X-MS-Office365-Filtering-Correlation-Id: fbc0325f-08f5-48f5-316a-08df4982d7b3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|23010399003|1800799024|366016|376014|7416014|261102123227099003|261028144727099003|261021121427099003|261021123027099003|261022105027099003|261026121527099003|11063799006|261026140227099003|4143699003|56012099006|10067099003|22082099003|18002099003|261009223027099003;
X-Microsoft-Antispam-Message-Info:
	J6/047VgWei3sTDt8ch88N3a1Nx1xpLpT+aC3XI+HTSf9CFo7WVU2pkjYl1YjdXTnV9D2qAHfTnmDqFNvGrVVZm2N/B3Uaemt1B+GMfK/0NIl/PunkZsru22MekxZl+4D5nBxDqOSQ05balTsJGfLm0xtS23s1ycLKHFp0V35xJiQ85Gcdnx/dMY28GrHNSI5RJbYaFwXPAgKKO8TZqy5ZU2ZUKsFfwZb27tvgXMEgI4JbDzGN4IaHM4V8/pDY6fdblVJlXuOl8/7hOT0Uu/gy+Q2/N8lK7IaKh4YoQwk+5In1IICJFIvIuOJZDjF/1wK7IisYb8bqndWBQJ7Olg1m263tc5swaEX21RdFu2EQXO36yailGSglcdXYxX0qsYHhslA0gpGt6SiA2Q/gHwgShMgtCeAmb5S9RgUPchX6fdMSNY4a8ZQPh/egzgSTf+ngN/pyfcCCZerr1Tvf4gplUoAcEQDQBNCcun9FcoQh0Ws34IKotzIJbf2ZgiTAreIkO8j7V/sLGht8bTgyHVhMQmSqbT41UWKFs0i7auvE5Xhcuw2vTx0kpW+FQcfYzjXi4ar6C1M9LVOUpZVK9w9CO9vBsU+H93pu1d5spl8c4ui2y6L/BzeM28Mtq+Y3arcDzkS1MDJWElB2keFWSUC1MeneWXZ0eMOkkM/+HMnOI=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MI3PR04MB12438.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(23010399003)(1800799024)(366016)(376014)(7416014)(261102123227099003)(261028144727099003)(261021121427099003)(261021123027099003)(261022105027099003)(261026121527099003)(11063799006)(261026140227099003)(4143699003)(56012099006)(10067099003)(22082099003)(18002099003)(261009223027099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?SsgJeaWXV/Pyqz2D8egRyphPyexMpj2kMQaKhsgJwkaqyqQASyRV5reibrBV?=
 =?us-ascii?Q?UI17QVYwiqCZoon8Ad4BIlu+c2l8wkW3pevRlRMS3bvv/0JpktfSx1rFNoYx?=
 =?us-ascii?Q?yTYiLezdQ0hhou63UyNEqB6RURSMfuuI9camlNt/j4fUAS3BrHa11n/xSexQ?=
 =?us-ascii?Q?uLQL7hcYVKWBFCwkzgr0rtgTDSjiquTAfE2rmEmssPUl+UWUdF3Q8C2oD6mZ?=
 =?us-ascii?Q?nQWW6Ag7Q66s2cDCB4sWMV7BTYP1tDYGSJ1yut/wTh3U35cyMNPWWptCwjcC?=
 =?us-ascii?Q?fQa8IjdR6whnvTwCY8yFF2GQMCjqgrKjkt92rJDh7LQTFSVmI96bDHrCFMjx?=
 =?us-ascii?Q?sNHQrg8IxAuF5OJghKMqCA8o0+d0Lv8wG0h2INXKeCD7yD1dfulaRX1tTpZU?=
 =?us-ascii?Q?rNhbgd+lh6NbudFDZCgysQeWLKLKt0kaeYYa9TFmIVYV6ZK7Fl9KQ8uh9nUd?=
 =?us-ascii?Q?YrwgjHZn/kwmPYL26/7nT6+iJdPuIISguzTTDAYw4fkWhjj4IXiptQPBuSp4?=
 =?us-ascii?Q?r7EFwAQgvVKJTVLGLaClhmsF+wO4dh2K0SErTd2RNxxfQMoDmRsEYkdiGdE0?=
 =?us-ascii?Q?dQdxOP6cEhPeOgd33NvlBP1XvXQVPKvS+6cH3eNSAJKCe4wc0pgwiWsnL+gq?=
 =?us-ascii?Q?+92ld2bmcw7IFoGDSTAhuGIOkF/HSI6pOGU9xTDhcvs3CrhV0IQzu/l4wich?=
 =?us-ascii?Q?6Cdd8zaHdE0XMnz1pGykpZjQwxzzbniF9Jjo4Ye54tQr4zmTdlXhtRCilTeK?=
 =?us-ascii?Q?JTE9tE84XjXz8F+QKi6hxTVwkiubBbV2d/UrnpEOauLbk01iSIEuivgpGIBp?=
 =?us-ascii?Q?n+ZPC2GAmob0JUMJKn44meNrL2zdoUQgM3sGWTezg9gE56TylYXJJZBRih6q?=
 =?us-ascii?Q?wL+8EwZVUKClRDALBnKHhfKov1HxaRkGvcQDNiNgyQfdAc4ooLwluUhR9ED0?=
 =?us-ascii?Q?Hpvf00uOM1vVUcq7KGgnQDT130DPLX3fvUu2fkx5RlNwyLUArESk33MHTkgW?=
 =?us-ascii?Q?DmEeekkU4xf4ptFU9PEga9sCqc4PJo44uqOFnZ8wIhpJ+6anwzSvdN92eI4c?=
 =?us-ascii?Q?xodl4Mhv3ocW+hloX6C3qrhNSrgFVNjVgV6qDCHn89HyfrNnjOsMIYoS94hn?=
 =?us-ascii?Q?5f+H4oGN4wsb7/BDotsXuxclxzUxfxEoXLKUKga+nKWUlHFuxvqBaYbFKBk3?=
 =?us-ascii?Q?aILjGdCO6In4r4IMsDrFKYgLFnRP5Vu7YvhxyEM8l+9ndwUKIwsFbZnLBCpt?=
 =?us-ascii?Q?VdkKtzct+CYkkJuz0j79M2fuIilDUFsIqDxAO1Vk5i3VjyUsQSM9X8KAM8mr?=
 =?us-ascii?Q?9MNcl3HGUXhh+Bxbls13fbF5GEMWJee+0TEPa2C5gv4b2J6L49DGmTlqfJsa?=
 =?us-ascii?Q?Rfs4wu8zI88T0pCXZJZ8ooejLTThQNeuZmpxjKqpw7fIoH6pTwF2e3k4WbD1?=
 =?us-ascii?Q?Rx7Lz8+beOULSixxYkzK7iqca6avPGRAnSMAlGwfDNnMjvr6n3lOfY5rlTaQ?=
 =?us-ascii?Q?dc/FtPK3fdCXjoj0l/C+o6WQIBWMWVNFJhjGmRhK7sWrmyd2BfP8pUPJDIv8?=
 =?us-ascii?Q?hILrHPTuh4BL8NbbtTa6O9k6DYCFsmouWkjZAeFQtWbOxGuhFS3WQV8YeCdk?=
 =?us-ascii?Q?ValEZ0FkM0tay5a4rGGC43L6q3kbAG2STAMWit2eQ6qusjsGTEM6mDrYlBzb?=
 =?us-ascii?Q?SQuEG5Q/BVrhETRU2uB6TzX158BM7lMnKoJSOdfiswX2KgTWbvLiCX2z7Qmx?=
 =?us-ascii?Q?4vvNB9elvcr/PwgNxygXevMNfiB7LD8t3l6dGcGopQh2ry0yF9w6?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fbc0325f-08f5-48f5-316a-08df4982d7b3
X-MS-Exchange-CrossTenant-AuthSource: MI3PR04MB12438.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Nov 2026 16:57:22.5424
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XzwaVtyOAu5/LX5d5/4oihHWK3HgCKpvHYZMN4sTLsRCg2gDG45urp7K53u/h4fIUhmyQMMOnAi/svvG3LvGdDCA98GvsrOtqcgTF6XugkFHOXCpN8xKYgPcL60lZ57x
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB12001

On Sun, Nov 22, 2026 at 08:26:19AM +0530, Krishna Chaitanya Chundru wrote:
> Provide the endpoint-mode PLL, TXRXZ and PCS init table deltas for the
> Nord Gen5x16 PCIe multi-PHY and wire them up as tbls_ep so they are
> applied on top of the shared root-complex tables when the controller is
> operated in endpoint mode.
>
> Add the QSERDES v6_40 COM register offsets (INTEGLOOP_GAIN0/1 for all
> three modes and CLK_FWD_CONFIG_2) used by these sequences.
>
> Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
> ---

Reviewed-by: Frank Li <Frank.Li@nxp.com>

>  drivers/phy/qualcomm/phy-qcom-qmp-pcie-multiphy.c  | 97 ++++++++++++++++++++++
>  .../qualcomm/phy-qcom-qmp-qserdes-com-pcie-v6_40.h |  7 ++
>  2 files changed, 104 insertions(+)
>
> diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-pcie-multiphy.c b/drivers/phy/qualcomm/phy-qcom-qmp-pcie-multiphy.c
> index 21cf6adf7d60..dcd8a3f794cb 100644
> --- a/drivers/phy/qualcomm/phy-qcom-qmp-pcie-multiphy.c
> +++ b/drivers/phy/qualcomm/phy-qcom-qmp-pcie-multiphy.c
> @@ -653,6 +653,102 @@ static const struct qmp_phy_cfg_tbls nord_qmp_pcie_tbls = {
>  	.port_split_post_cfg_num	= ARRAY_SIZE(nord_qmp_pcie_port_split_post_cfg_tbl),
>  };
>
> +static const struct qmp_phy_init_tbl nord_qmp_pcie_pll_ep_tbl[] = {
> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_COM_CLK_FWD_CONFIG_2, 0x28),
> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_COM_CP_CTRL_MODE2, 0x28),
> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_COM_PLL_RCTRL_MODE2, 0x0d),
> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_COM_PLL_CCTRL_MODE2, 0x00),
> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_COM_LOCK_CMP1_MODE2, 0xff),
> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_COM_LOCK_CMP2_MODE2, 0x09),
> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_COM_DEC_START_MODE2, 0x28),
> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_COM_INTEGLOOP_GAIN0_MODE2, 0xfb),
> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_COM_INTEGLOOP_GAIN1_MODE2, 0x03),
> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_COM_BIN_VCOCAL_CMP_CODE1_MODE2, 0x87),
> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_COM_BIN_VCOCAL_CMP_CODE2_MODE2, 0x17),
> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_COM_CP_CTRL_MODE1, 0x28),
> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_COM_PLL_RCTRL_MODE1, 0x0d),
> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_COM_PLL_CCTRL_MODE1, 0x00),
> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_COM_LOCK_CMP1_MODE1, 0xff),
> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_COM_LOCK_CMP2_MODE1, 0x04),
> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_COM_DEC_START_MODE1, 0x28),
> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_COM_INTEGLOOP_GAIN0_MODE1, 0xfb),
> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_COM_INTEGLOOP_GAIN1_MODE1, 0x03),
> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_COM_BIN_VCOCAL_CMP_CODE1_MODE1, 0xc4),
> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_COM_BIN_VCOCAL_CMP_CODE2_MODE1, 0x0b),
> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_COM_CP_CTRL_MODE0, 0x28),
> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_COM_PLL_RCTRL_MODE0, 0x0d),
> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_COM_PLL_CCTRL_MODE0, 0x00),
> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_COM_LOCK_CMP1_MODE0, 0x3f),
> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_COM_LOCK_CMP2_MODE0, 0x01),
> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_COM_DEC_START_MODE0, 0x19),
> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_COM_INTEGLOOP_GAIN0_MODE0, 0xfb),
> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_COM_INTEGLOOP_GAIN1_MODE0, 0x03),
> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_COM_BIN_VCOCAL_CMP_CODE1_MODE0, 0xab),
> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_COM_BG_TIMER, 0x06),
> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_COM_SYS_CLK_CTRL, 0x07),
> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_COM_PLL_IVCO, 0x0f),
> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_COM_SYSCLK_EN_SEL, 0x00),
> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_COM_PSM_CAL_EN, 0x01),
> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_COM_CMN_IETRIM, 0x1b),
> +};
> +
> +static const struct qmp_phy_init_tbl nord_qmp_pcie_txrxz_ep_tbl[] = {
> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_TXRXZ_RX_MODE_RATE2_B1, 0x30),
> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_TXRXZ_RX_MODE_RATE2_B3, 0x60),
> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_TXRXZ_RX_MODE_RATE2_B4, 0x2c),
> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_TXRXZ_RX_MODE_RATE2_B7, 0x1d),
> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_TXRXZ_RX_MODE_RATE3_B0, 0xde),
> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_TXRXZ_RX_MODE_RATE3_B1, 0x35),
> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_TXRXZ_RX_MODE_RATE3_B2, 0x38),
> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_TXRXZ_RX_MODE_RATE3_B4, 0x2c),
> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_TXRXZ_RX_MODE_RATE3_B5, 0xdd),
> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_TXRXZ_RX_MODE_RATE3_B7, 0x23),
> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_TXRXZ_RX_MODE_RATE4_B0, 0xed),
> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_TXRXZ_RX_MODE_RATE4_B1, 0x68),
> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_TXRXZ_RX_MODE_RATE4_B2, 0x6d),
> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_TXRXZ_RX_MODE_RATE4_B3, 0x20),
> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_TXRXZ_RX_MODE_RATE4_B4, 0x8c),
> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_TXRXZ_RX_MODE_RATE4_B7, 0x06),
> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_TXRXZ_RX_MODE_RATE_0_1_B1, 0x42),
> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_TXRXZ_RX_MODE_RATE_0_1_B4, 0x1a),
> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_TXRXZ_LANE_MODE_4, 0x00),
> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_TXRXZ_TOP_LDO_CODE_CTRL3, 0x83),
> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_TXRXZ_CDR_CP_CUR_PLL_RATE3, 0x01),
> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_TXRXZ_CDR_CP_CUR_PLL_RATE4, 0x02),
> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_TXRXZ_CDR_IQTUNE_CTRL, 0x00),
> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_TXRXZ_KP_CAL_LOWER_FREQ_DIFF_BND_RATE3, 0x15),
> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_TXRXZ_KP_CAL_LOWER_FREQ_DIFF_BND_RATE4, 0x0a),
> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_TXRXZ_RX_IVCM_CAL_CTRL4, 0x03),
> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_TXRXZ_CDR_LOOP_RCODE_FAST_RATE_0_1, 0x00),
> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_TXRXZ_CDR_LOOP_RCODE_FAST_RATE4, 0x02),
> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_TXRXZ_CDR_VCO_CTUNE_MEAS_CNT1_RATE2, 0x09),
> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_TXRXZ_CDR_VCO_CTUNE_MEAS_CNT1_RATE3, 0x09),
> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_TXRXZ_VGA_CAL_MAN_VAL_RATE4, 0x0a),
> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_TXRXZ_KVCO_IDEAL_FREQ_DIFF1_RATE3, 0x2f),
> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_TXRXZ_KVCO_INIT_RATE_2_3, 0x11),
> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_TXRXZ_KVCO_INIT_RATE_4, 0x03),
> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_TXRXZ_RESTRIM_VREF_SEL, 0x12),
> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_TXRXZ_VTHRESH_CAL_MAN_VAL_RATE4, 0x45),
> +};
> +
> +static const struct qmp_phy_init_tbl nord_qmp_pcie_pcs_ep_tbl[] = {
> +	QMP_PHY_INIT_CFG(QPHY_PCIE_V6_40_PCS_COM_POWER_STATE_CONFIG2, 0x34),
> +	QMP_PHY_INIT_CFG(QPHY_PCIE_V6_40_PCS_COM_PCS_TX_RX_CONFIG5, 0x01),
> +	QMP_PHY_INIT_CFG(QPHY_PCIE_V6_40_PCS_COM_PCS_TX_RX_CONFIG10, 0x00),
> +	QMP_PHY_INIT_CFG(QPHY_PCIE_V6_40_PCS_COM_ALIGN_DETECT_CONFIG7, 0x30),
> +	QMP_PHY_INIT_CFG(QPHY_PCIE_V6_40_PCS_COM_EQ_CONFIG2, 0xdc),
> +	QMP_PHY_INIT_CFG(QPHY_PCIE_V6_40_PCS_COM_G345_EQ_CONFIG1, 0x07),
> +};
> +
> +static const struct qmp_phy_cfg_tbls nord_qmp_pcie_ep_tbls = {
> +	.pll_common	= nord_qmp_pcie_pll_ep_tbl,
> +	.pll_common_num	= ARRAY_SIZE(nord_qmp_pcie_pll_ep_tbl),
> +	.txrxz		= nord_qmp_pcie_txrxz_ep_tbl,
> +	.txrxz_num	= ARRAY_SIZE(nord_qmp_pcie_txrxz_ep_tbl),
> +	.pcs		= nord_qmp_pcie_pcs_ep_tbl,
> +	.pcs_num	= ARRAY_SIZE(nord_qmp_pcie_pcs_ep_tbl),
> +};
> +
>  static const struct qmp_phy_init_tbl * const nord_qmp_pcie_pll_a[] = {
>  	nord_qmp_pcie_pll_a_ovl_tbl,
>  };
> @@ -839,6 +935,7 @@ static const char * const nord_pciephy_port_d_pipeclk_l[] = { "pipe_d" };
>  static const struct qmp_phy_cfg nord_qmp_pcie_port_##_port##_cfg = {		\
>  	.offsets		= &nord_pcie_offsets_v6_40,			\
>  	.tbls			= nord_qmp_pcie_tbls,				\
> +	.tbls_ep		= &nord_qmp_pcie_ep_tbls,			\
>  	.pll_tbls		= nord_qmp_pcie_pll_##_port,			\
>  	.pll_nums		= nord_qmp_pcie_pll_##_port##_nums,		\
>  	.port_split		= _port_split,					\
> diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-qserdes-com-pcie-v6_40.h b/drivers/phy/qualcomm/phy-qcom-qmp-qserdes-com-pcie-v6_40.h
> index 0eeab0693e9b..3cc030625f25 100644
> --- a/drivers/phy/qualcomm/phy-qcom-qmp-qserdes-com-pcie-v6_40.h
> +++ b/drivers/phy/qualcomm/phy-qcom-qmp-qserdes-com-pcie-v6_40.h
> @@ -8,6 +8,8 @@
>
>  #define QSERDES_PCIE_V6_40_COM_SSC_STEP_SIZE1_MODE1		0x000
>  #define QSERDES_PCIE_V6_40_COM_SSC_STEP_SIZE2_MODE1		0x004
> +#define QSERDES_PCIE_V6_40_COM_INTEGLOOP_GAIN0_MODE1		0x040
> +#define QSERDES_PCIE_V6_40_COM_INTEGLOOP_GAIN1_MODE1		0x044
>  #define QSERDES_PCIE_V6_40_COM_CLK_EP_DIV_MODE1			0x00c
>  #define QSERDES_PCIE_V6_40_COM_CP_CTRL_MODE1			0x010
>  #define QSERDES_PCIE_V6_40_COM_PLL_RCTRL_MODE1			0x014
> @@ -26,6 +28,8 @@
>  #define QSERDES_PCIE_V6_40_COM_BIN_VCOCAL_CMP_CODE2_MODE0	0x05c
>  #define QSERDES_PCIE_V6_40_COM_SSC_STEP_SIZE1_MODE0		0x060
>  #define QSERDES_PCIE_V6_40_COM_SSC_STEP_SIZE2_MODE0		0x064
> +#define QSERDES_PCIE_V6_40_COM_INTEGLOOP_GAIN0_MODE0		0x0a0
> +#define QSERDES_PCIE_V6_40_COM_INTEGLOOP_GAIN1_MODE0		0x0a4
>  #define QSERDES_PCIE_V6_40_COM_CLK_EP_DIV_MODE0			0x06c
>  #define QSERDES_PCIE_V6_40_COM_CP_CTRL_MODE0			0x070
>  #define QSERDES_PCIE_V6_40_COM_PLL_RCTRL_MODE0			0x074
> @@ -68,6 +72,8 @@
>  #define QSERDES_PCIE_V6_40_COM_CMN_CONFIG_2			0x22c
>  #define QSERDES_PCIE_V6_40_COM_SSC_STEP_SIZE1_MODE2		0x1cc
>  #define QSERDES_PCIE_V6_40_COM_SSC_STEP_SIZE2_MODE2		0x1d0
> +#define QSERDES_PCIE_V6_40_COM_INTEGLOOP_GAIN0_MODE2		0x208
> +#define QSERDES_PCIE_V6_40_COM_INTEGLOOP_GAIN1_MODE2		0x20c
>  #define QSERDES_PCIE_V6_40_COM_CP_CTRL_MODE2			0x1dc
>  #define QSERDES_PCIE_V6_40_COM_PLL_RCTRL_MODE2			0x1e0
>  #define QSERDES_PCIE_V6_40_COM_PLL_CCTRL_MODE2			0x1e4
> @@ -83,6 +89,7 @@
>  #define QSERDES_PCIE_V6_40_COM_DCC_CAL_3			0x2e0
>  #define QSERDES_PCIE_V6_40_COM_PSM_CAL_EN			0x2f0
>  #define QSERDES_PCIE_V6_40_COM_CLK_FWD_CONFIG_1			0x2f4
> +#define QSERDES_PCIE_V6_40_COM_CLK_FWD_CONFIG_2			0x2f8
>  #define QSERDES_PCIE_V6_40_COM_IP_CTRL_AND_DP_SEL		0x2fc
>  #define QSERDES_PCIE_V6_40_COM_PLL_SPARE_FOR_ECO		0x2b8
>  #define QSERDES_PCIE_V6_40_COM_PLL_IVCO_MODE1			0x0f8
>
> --
> 2.34.1
>
