Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010032.outbound.protection.outlook.com [52.101.69.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4A65434E5F;
	Thu, 27 Aug 2026 19:08:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787857715; cv=fail; b=DfmWqrIsYPkSndF8SWCGcJN7fQ7sjHP7NA2yDniwLwJtTT/L9iiNo6hHzPA7wnJ0r21rYH4OKzL5OhBzLKIwWgZM81Zeuuk3XDsKFsuSl8oKyLrII7t+crTaP8RbfDNwR4+r+Vk254tU3wvM/gZyQvAlN/g03yzwsOo4SwX5b/s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787857715; c=relaxed/simple;
	bh=sHkxNLkvDl0S5XzJb9HBHx7AV1n55j9Ahnrd2Exudbw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=giSOc8GKi0EKVrj5RGWbnn42gH/mi7zumlGD04qAbL5FE6TziKVTEfNwY84exBZUZiE1c6mzrNnArOqx/4QWYtDIUVxKstCX1N45TVQd5oCs1lXmgFxQqfWBfMb/Kd/iOj5j7wXeNNsrVc7qdY13chbfWPZ//GhvoMvTQWUI6lc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=B0AYhaKu; arc=fail smtp.client-ip=52.101.69.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="B0AYhaKu"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=J7hqFBGYJrpePSsugJEufOdmRHj7e6Tyf/HhekQCZSV3OoaozZDYctm9IRv1jm8p3Kssztyi9wH+wPDsHfDlDvjfMsHFbnlB+maFsJxl873zacLF/gsX/KoGSA2xJuMTZCc3GkzyPBGqg5pfluqqmUNUEHT3W57X0PGqp0d54cKdTnyB8sa0yFLsw2vCs+d0/JFw0+L+UGZlngc/XcZeHugxlhWPCtxWhlHY2YEAzqV8FXhN3rA+Pd8DoO5NBJmptdCRD7urTnNL3/2bsJuRbaggMQ/ZLxXnAmxWXPVWhex3VeAJU2UH/hLYo0sth77Mv/7q43DraFHhnrqghvwOxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r+JAqUxprDtXjR/ovr/oecZePvC1qI6a32cUDBoL56k=;
 b=gY/omXiI7gj9oq/iAOxK5r5UuWqsNuMQ8aOkMlQCINHEiq+ZKyzOQcd6aeXPt0NZPETGU7WRjWpQchUQMJw7ORvyPdf43ari9y8DH6BrGcYgOihLCCAWnkcce8Y2Soyuqz/VQZPxpFAby9CPBaztdPUnbYs8vj55L+cVYTYrcBuxEQv3bu3xLlCCZheIYmndU9lC8c1EjSDC4dGHwvQMaSQsvK/XRPiz0UgJVQHqNe1BeIDFt04gFATq3USVwrZ+JGSF3a4SUk8VNKdVln9Rgou0B6mwh7N16DH52iScBNePcj6E+AhX+bQVkE2r4MuKM+q4mmXsGiOE4Ej40WRanw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r+JAqUxprDtXjR/ovr/oecZePvC1qI6a32cUDBoL56k=;
 b=B0AYhaKufy7upzGCLWD/pirYXDPW6tSQrOrGh6oqraDypm+3r9QU+Ao/ysVc8fRoMCtQV3NZkZdv0eEPn7+WKL7dINi0S6YNYpRu2HvRhW+1rv5N1G/CRlrQ7qZyTPv5GGWq+pibU82alM0p9cOOL6TGJQdpWDwKyTYwHkGbyA+lMQks/nw8/f5vKbmTlEcNHbUDkxGr63AqGSFmURmYnx30RWzIBygWlVZr8t188GcinLLi1UoNsoxdr4mN2czE83shw1R3m2RQ1eh6XDpABAKHa76ny4fmL+8Z1yvLLUVqFGUu8wXp8/gVZYpGCQsuWx3ICOnWQqISyNoV1f7ZxQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9)
 by GV2PR04MB11374.eurprd04.prod.outlook.com (2603:10a6:150:2a0::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.10; Thu, 27 Aug
 2026 19:08:27 +0000
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c]) by GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c%7]) with mapi id 15.21.0360.008; Thu, 27 Aug 2026
 19:08:27 +0000
Date: Thu, 27 Aug 2026 14:08:16 -0500
From: Frank Li <Frank.li@oss.nxp.com>
To: Michal Gorlas <michal.gorlas@9elements.com>
Cc: Richard Zhu <hongxing.zhu@nxp.com>,
	Lucas Stach <l.stach@pengutronix.de>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Frank Li <Frank.Li@nxp.com>, Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, imx@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH RESEND v2] PCI: imx6: Enable ASPM L1 only iff CLKREQ# is
 supported
Message-ID: <apCLIHvxbuBBIhhT@SMW015318>
References: <20260827-l1-conditional-imx-v2-1-40b324aa2a94@9elements.com>
 <apBvfYOnCHfl7Zu9@lizhi-Precision-Tower-5810>
 <DKZXTSZPJMY8.XM7YYCVPT3EP@9elements.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DKZXTSZPJMY8.XM7YYCVPT3EP@9elements.com>
X-ClientProxiedBy: PH8PR05CA0015.namprd05.prod.outlook.com
 (2603:10b6:510:2cc::16) To GV2PR04MB11799.eurprd04.prod.outlook.com
 (2603:10a6:150:2cf::9)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB11799:EE_|GV2PR04MB11374:EE_
X-MS-Office365-Filtering-Correlation-Id: f7df5df7-e61c-4b71-157a-08df046e92d4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|19092799006|1800799024|366016|23010399003|10067099003|56012099006|11063799006|4143699003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	9/twqKoWFn2lJY2tWbLD0u6XWVhZKeBT3iRmj9X0pvN/fA9X0V+ztV4dUAInsUsBGx0hr3Zxr6SBZYgJZnhKlOBk8oOz+R+w8mG4KBeo0VUmySkokQdR91eZx1SfJpx563uwp5gx3HsNMX8yEKaZ/J4wfTeFboBnd13aIcvYhR849IFhE4o8V2OlUp+fo0CPvk86r44a6UnEIegycJL+MGVvAQsr+qzeFQRIX1R7ve4V/eA+9IB0YbEoX9k0KXc90dBoxz2qDrELEZuydIKTwE7FwRk+rYAY5f2a7c3z+YRbjny7Dpe4rrytFSGJ+QI+FMhS9BaqwqfC1ExStNB0z32QRX3g/i/Dcm7RGjcq/0bFXOkKHgWB2Mvb8I5zf5vzBZ/UhteK8mFgTSi3WRS30O5G+eCKabljknBoM2sp/aM42k0+mi/ngNzYU15tqfQLzSNCv9nwm9bg5CEEZMdf56FWNWmBRtPQC4dpdEeYJnG49T5VTJC4lA3qloezNi372C5txGQLv+iE5UYWeGVodzLzutTYBDa7e0Wuebkmx7zkazNTC9Kok6MjU1rrE5EIDCm3dXelMKv7Rc8kQMfHU+WD3LOOjoCwt0/QavWJ/cdSxb7oLJPvXF6f38qPAm3I
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11799.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(19092799006)(1800799024)(366016)(23010399003)(10067099003)(56012099006)(11063799006)(4143699003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?UY5IYO0FJz7CmQUZo3AX34WZ053sSCIdE91TOBJF0QNlpfeiTtvTlXRSxRdy?=
 =?us-ascii?Q?8ap8go9UNJe01xh3cQELnVjQVuHbw7imDNlaMENAA5GiIvXAshTid5RSkt24?=
 =?us-ascii?Q?TCWGHkHDaJrqkXNXJ1g+lPC6yU3UrvMG6OL13VBJKskqJfo8VlJ0M3OS9agN?=
 =?us-ascii?Q?Rjy5R7qJESCyOih6E8q9wBWnBvEKDzSX6BrV3I9PGtUIUtUVlfWJQbN71SoS?=
 =?us-ascii?Q?LXBGVYO8YFsiy8h21VI6qJLczfKIu6r7Cqg1Y4AnInlcyVUoJQvZdzTg316X?=
 =?us-ascii?Q?rL8/jiJ5mNUMAppHT+B3dtWeP0CddgsAeaTMDWuMEnk5QMv+/laA++uXofx6?=
 =?us-ascii?Q?8ByywTchg7azW3ijNY2QF0tNbcI8ZsniBDHIyMUpREZk7E/7OHI//jMAsLxi?=
 =?us-ascii?Q?HyD2Skv01AfrRYG0Z6JOmO7h5CF8LScOlyyiuX7hrf82kIx+Ax/UcPsnIipR?=
 =?us-ascii?Q?3yN0PYr03qAaQG+ssBstzRutPOk7ESw7zSNGgh6qfghJE14XiJxYP16JnDpa?=
 =?us-ascii?Q?aVwARP0EQnl2zCvYk30o05wIJI9X+5FK6fwWDaml5FlGe/dBzKso+wM11X8O?=
 =?us-ascii?Q?0kOwH7Qcgr/+M4hq4pQuDklrKQ5n7BI8h1gy5BVp6AuK+2Bx95D+NUKxmPGv?=
 =?us-ascii?Q?f414xUm0o03+CijvGtNpN+s8z1wu8vAIufdqUpAY/y2JA0kKgT3NoQPQn0/S?=
 =?us-ascii?Q?rXTT77dj0lxn5xZE0S0SlVHyLI8eUSEpQg1/MHIvUD5zq3GflU76Cu0TW8k+?=
 =?us-ascii?Q?wxOTOXTde3Pa//Ni+nX9rH38t+5r7f1Pj401oaKyFaLQFHwoIYqQZ9GGFGCJ?=
 =?us-ascii?Q?ep0RHnUyYZGe4DoxcXgVd75RautYxXUQQSTvcINMQl6Ii04UmIdhB5JuOQM+?=
 =?us-ascii?Q?5pmgwTKCO/2QstV8DX+uEbEmFDMDLRAnIcDx0k0jeao4c91ooyecrSYNQ8HL?=
 =?us-ascii?Q?TGm+c1mHWy53qPSy/AVS7sn4qF/Hs0kQlkCsPCMYucmP/tGlI0mKTHnZEeDN?=
 =?us-ascii?Q?qXQqDeUCCj0VhvyeMouYaf1KpD+0rQ+dB1Y2s0VmS2kpkTWRmZDIZsLS6OdL?=
 =?us-ascii?Q?iK34eBynj0cRgdUss8o7mzlXCfxjuYkJ2owSryByNlvYLvU7don0yqZduwhu?=
 =?us-ascii?Q?F0xPmmSk6oNO2JEenWyzC/Y+CjhHIn3PysSsvkxNdMwsyol6ltsdXRlBBcJn?=
 =?us-ascii?Q?oM9Cj2ZwzWGhHb557ELy+XkSXszCZ44e3wE7pVOj5vZ+UFZX7hdHZUWEhpQI?=
 =?us-ascii?Q?8V+Wzr2cYcVbGFa/egQDFA73fjGOsR78w3guuwME3aWHvGT51Ce2j9QmaIgb?=
 =?us-ascii?Q?lxHauFQGu6la3/TfyzCIA20DC6HahpEpNF+C6jBjfASxlSKpqEvIV01wnZ7L?=
 =?us-ascii?Q?xm30E82BTc5oHneOL+CcqAIuCDhckSZNEXCT6HFrVbFtlIB9m/seTf4g+owa?=
 =?us-ascii?Q?elidsZ0E57+9+3+nCW7QNSvDdjx7QaTKYGGB6R7Z28BKiLtQ6vynlfGK+Chz?=
 =?us-ascii?Q?JA3Za377R7kq/4RfE9r2N3+zgyaOOH5XpmxMonq16Z3eszRQMbS7u4utJ+fX?=
 =?us-ascii?Q?t3Ji3AXam63eEwWN/LLW0+3ncEfQAkJm7VAtc9WF86p9RN0fHupqCiT/lwyF?=
 =?us-ascii?Q?IXM8QT6GRgZ+0h9wedPQqKpLpsindKq3qVYAkQg6NbEpk+9zznZ5nLdmvrJr?=
 =?us-ascii?Q?eThind/H5H4Dl2nx88Y3LWY+NnyjAuXkW/fOJ2OUAua6F0KkSgyOhk70vJcz?=
 =?us-ascii?Q?tIXO5EnFusffJN1Ov6GiTq3uw8r9KZkZlfSKIYz2W9gdXqmSz3m1?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f7df5df7-e61c-4b71-157a-08df046e92d4
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2026 19:08:26.9250
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IRndIvMvIsuW3vANXPu/kigqlbscCmPiPi0jzgsaAaZ3vQyMG/Wm4B50snFXCnAFX3ezeep9IhPBkrOgUcjWhJyksKTqW9rmGtU9TKC28ivL5kL1N1eg7UQ12TtKv7Dk
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR04MB11374

On Thu, Aug 27, 2026 at 08:29:09PM +0200, Michal Gorlas wrote:
> On Thu Aug 27, 2026 at 7:10 PM CEST, Frank Li wrote:
> > On Thu, Aug 27, 2026 at 06:51:00PM +0200, Michal Gorlas wrote:
> >> Since commit f3ac2ff14834 ("PCI/ASPM: Enable all ClockPM and ASPM
> >> states for devicetree platforms"), ASPM states are force enabled
> >> on all devicetree platforms. This causes PCI devices on some i.MX SoCs
> >> (for e.g. i.MX 8M Plus Kontron SMARC eval carrier) to enter L1 even
> >> though CLKREQ# is not supported (and consequently supports-clkreq is
> >> not set in pcie controller node of their DT), which causes the device to
> >> never wake up from L1.
> >>
> >> Hence, disable L1 capability in the LNKCAP register if supports-clkreq
> >> is not set in the DT explicitly. For devices that set
> >> IMX_PCIE_FLAG_BROKEN_SUSPEND, disable L1 on resume as well, as these
> >> skip imx_pcie_host_init().
> >>
> >> Note, the logic here is very similar to 613f3255a35a, only difference
> >> is that leaving L0s enabled does not cause issues (at least
> >> I never encountered them myself when testing on the device) as its
> >> not dependent on CLKREQ# being physically there.
> >> Since there is already a way of specifying its presence in the DT,
> >> the driver should be aware and disable L1.
> >>
> >> Fixes: f3ac2ff14834 ("PCI/ASPM: Enable all ClockPM and ASPM states for devicetree platforms")
> >> Signed-off-by: Michal Gorlas <michal.gorlas@9elements.com>
> >> Tested-by: Richard Zhu <hongxing.zhu@nxp.com>
> >> Reviewed-by: Richard Zhu <hongxing.zhu@nxp.com>
> >> ---
> >> Changes in v2:
> >> - disable L1 unconditionally on resume for platforms advertising
> >> IMX_PCIE_FLAG_BROKEN_SUSPEND (Sashiko)
> >> - typos in the commit message
> >> - Link to v1: https://patch.msgid.link/20260719-l1-conditional-imx-v1-1-a55a57915c68@9elements.com
> >> ---
> >>  drivers/pci/controller/dwc/pci-imx6.c | 20 ++++++++++++++++++++
> >>  1 file changed, 20 insertions(+)
> >>
> >> diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
> >> index 98e1db751132..1fdcbcd2422e 100644
> >> --- a/drivers/pci/controller/dwc/pci-imx6.c
> >> +++ b/drivers/pci/controller/dwc/pci-imx6.c
> >> @@ -1318,6 +1318,22 @@ static void imx_pcie_assert_perst(struct imx_pcie *imx_pcie, bool assert)
> >>  	}
> >>  }
> >>
> >> +static void imx_pcie_disable_l1(struct dw_pcie *pci)
> >> +{
> >> +	u32 val;
> >> +	u8 offset;
> >> +
> >> +	offset = dw_pcie_find_capability(pci, PCI_CAP_ID_EXP);
> >> +
> >> +	dw_pcie_dbi_ro_wr_en(pci);
> >> +
> >> +	val = dw_pcie_readl_dbi(pci, offset + PCI_EXP_LNKCAP);
> >> +	val &= ~PCI_EXP_LNKCAP_ASPM_L1;
> >> +	dw_pcie_writel_dbi(pci, offset + PCI_EXP_LNKCAP, val);
> >> +
> >> +	dw_pcie_dbi_ro_wr_dis(pci);
> >> +}
> >> +
> >>  static int imx_pcie_host_init(struct dw_pcie_rp *pp)
> >>  {
> >>  	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
> >> @@ -1442,6 +1458,9 @@ static int imx_pcie_host_init(struct dw_pcie_rp *pp)
> >>
> >>  	imx_setup_phy_mpll(imx_pcie);
> >>
> >> +	if (!imx_pcie->supports_clkreq)
> >> +		imx_pcie_disable_l1(pci);
> >> +
> >>  	return 0;
> >>
> >>  err_phy_off:
> >> @@ -1748,6 +1767,7 @@ static int imx_pcie_resume_noirq(struct device *dev)
> >>  			return ret;
> >>  		imx_pcie_deassert_core_reset(imx_pcie);
> >>  		imx_pcie_assert_perst(imx_pcie, false);
> >> +		imx_pcie_disable_l1(imx_pcie->pci);
> >
> > Does l1 disable permanent after resume? should it be
> >
> > 	if (!imx_pcie->supports_clkreq)
> > 		mx_pcie_disable_l1(imx_pcie->pci);
>
> It would be unnecessary, the imx_pcie_disable_l1() there is already
> guarded by IMX_PCIE_FLAG_BROKEN_SUSPEND, so we know that only iMX6Q
> ends up there on resume. And none of iMX6Q DT's sets supports-clkreq.

Okay,

Reviewed-by: Frank Li <Frank.Li@nxp.com>

>
> Best,
> Michal
> >
> > Frank
> >
> >>
> >>  		/*
> >>  		 * Using PCIE_TEST_PD seems to disable MSI and powers down the
> >>
> >> ---
> >> base-commit: a13c140cc289c0b7b3770bce5b3ad42ab35074aa
> >> change-id: 20260713-l1-conditional-imx-c2bfd20ae085
> >>
> >> Best regards,
> >> --
> >> Michal Gorlas <michal.gorlas@9elements.com>
> >>
>
