Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013011.outbound.protection.outlook.com [40.107.162.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 428A1345743
	for <linux-pci@vger.kernel.org>; Wed, 11 Feb 2026 19:26:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770838011; cv=fail; b=a7I6zgPMy5TiCi11/HS56bNZfZqc4L37HF076I2JvSBF4sF3sdCip4UKc9rJFPk85wmdNiiXjc9i5jogoJWzP4BcLbSuqvahoZ8QsycjQcwpGGRAxKhPGrYlPa1kmQUWKvA8+RP13381Mp6oKHYngbOMZfQ+6QXxPsubMuhhwuk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770838011; c=relaxed/simple;
	bh=6DJ4hP8ORFWwNhTGUb/UO9hvGuvSkDGnubfHfjhB20g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=U5ORHpnNiTzzAoWcYupGmEcGoPQKcux+E9c6tzMCdy5OAaBwuRhjkDtJ6g7h/n8LPglVFEERr7xhem0Gau0eboYNNTaXN4Z088XLTSfc09xqYrk0yXJ7vr8mGCggln1ehX0Eb8+Hu8GhBxmI+67GiF4P62nw4WbjgKkwl/rBGWI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=MIH9yWgH; arc=fail smtp.client-ip=40.107.162.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="MIH9yWgH"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mGlp2CbBFGfwGFWQgw6eoGH2YvJ84XGKrXhyzT7NWxOHqlHg49dmYllNwaWNnA6vPG3mHcfubVBy5/StzVJE/Z9dhntT52VZOBIvGOS0BCTJpHTP7MrP3/94OGMchBRy2CZeCYUYJNj51ekFw5kUfaD/kZ8oxYGvIX6nXpt3vN9NmrDfZLW7A6ky58hDZcQVtFK/ge/Po5Cf40faYW3BAFJqHtxuhDT1/LB0cr/EixiQnAzixU3JzinXPpnKRxqN5bPYwCHIQraGIz0THTkgCdag4U2EqcVVaO7jnASp4ExxpEdJTQEbRpi3BoR8bzBNB8O+9XgmLv2UjXl+plq4CA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aAqsY2fa7EKHfY3fOqz3W70+E+CpqiuM//uOSdLPnRY=;
 b=ayW5O95DuxtvDipX5J0qpdo6k0vjuvaM71nAr9wCwwUn1iByID/m+ehDI6oLpPBVY9LuPz8tlWxpVxW/79571KRU3mAeP3w9XuB9Dr6aKAa874ALRgjWCYWRdi0UZiz3T9m/qo0REc76PBqHPaYGV7wKBnFfB7utj85P2RnEEp6kQF5p1qpuALo2+1no1OlLMsMdQEIeoFAdr/imxvKr9fhsDVWP5JcSIuCvM1/L4DmOopGImkAOfIOdqpKJf82BgFnbs81G9TofADktmg3EU1OeQEyqrE2eQgFYmHDYTLpuijGVIlPsmWbFLB5lUoLeRJv7zFQ5t2SM/W0o+okU4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aAqsY2fa7EKHfY3fOqz3W70+E+CpqiuM//uOSdLPnRY=;
 b=MIH9yWgHM0z8TZeHDmbmf+az4z8CQUcl1WrqWmjq+rEdTmVj+MfPjBTNNSXf4hk6oCQF+cxqmF//bZF0R3b9IzQmMY1xfHLiK5ia28qThUZDC2u16kb5ZBgjp/Wvi8CH/fYiOZ1Nv5LXkxISTnVc7Kr1maVvCuc/AZiwRJTS/7EMNoqMHxbLyxa1/bLWwv3kEhU2b1E2zlsLeNy401bDY9vEEMVZqsiklMCRihIIoH5NKjNJvIav4e8rQpNZeaZUOw3bt1s9mUkU9KnL52N/sDSVo7WgQJUke8WubfN+gsOEV2g0jIn94uaPrp5qCATG4CGv/geGSMNgkJ/7zE5pkQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com (2603:10a6:102:2a9::8)
 by AM9PR04MB7489.eurprd04.prod.outlook.com (2603:10a6:20b:281::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.10; Wed, 11 Feb
 2026 19:26:46 +0000
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588]) by PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588%6]) with mapi id 15.20.9587.010; Wed, 11 Feb 2026
 19:26:46 +0000
Date: Wed, 11 Feb 2026 14:26:39 -0500
From: Frank Li <Frank.li@nxp.com>
To: Niklas Cassel <cassel@kernel.org>
Cc: Jingoo Han <jingoohan1@gmail.com>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
	Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
	Damien Le Moal <dlemoal@kernel.org>,
	Koichiro Den <den@valinux.co.jp>, linux-pci@vger.kernel.org
Subject: Re: [PATCH] PCI: dwc: ep: Flush before unmap in
 dw_pcie_ep_raise_msix_irq()
Message-ID: <aYzX70JDerv8Zm1H@lizhi-Precision-Tower-5810>
References: <20260211175540.105677-2-cassel@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260211175540.105677-2-cassel@kernel.org>
X-ClientProxiedBy: PH7PR03CA0029.namprd03.prod.outlook.com
 (2603:10b6:510:339::20) To PA4PR04MB9366.eurprd04.prod.outlook.com
 (2603:10a6:102:2a9::8)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB9366:EE_|AM9PR04MB7489:EE_
X-MS-Office365-Filtering-Correlation-Id: ea4ee6fe-ba32-438b-85c5-08de69a37ef4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|52116014|366016|19092799006|1800799024|7053199007|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?w/6ItB4viIUOCPc6xdJ/0j/qczKdjeqngkz2viFOWN7wdfbCf5B/g8kJUpUS?=
 =?us-ascii?Q?fzkOCdCDI9xCeV9W+xkaQL8Ru6mvYzt7E+9yajG8wQCuh1OqvMZfRXg2YSuP?=
 =?us-ascii?Q?+yZlwSze17j02bD7O7tO6/nmoK8fnqno/ax44vrhRLMFBO3YtNfs1ssBQkJ8?=
 =?us-ascii?Q?CWbjN9W08iZNJNdbiqsZqO37/ckdJ2bAsM6HycQtrGHSDdNxyYknRxfr23Jh?=
 =?us-ascii?Q?x0cXGbO0IrhToo2uek5LKJhEOsiu8liuwplV2lAskXKNMbCgoN1c8Vtucxrw?=
 =?us-ascii?Q?PGCwfg1rV2VbHkHioPeTrkarAPtpe2yuPPtqI6DLY5++ZCct//jCs8yVqdpO?=
 =?us-ascii?Q?8VNL8rb5kOpD7zgVq/IhV8rkn/UeqyJvX6ZUcQEIomhxdZ3uIfH7XJavwrwb?=
 =?us-ascii?Q?XTOpGqZ42Pwhd7Xf/gCmlOTdOut4REIGG1rLlzNiJgRq5wFMxsd+uFSVk4o9?=
 =?us-ascii?Q?8TKeWAaSnqbnPfInX5MZKyII2NEFGKFTC3faTexAU9Y4kWoDYFcF3KUR/+Ja?=
 =?us-ascii?Q?YJHbUT/BXC18ZvoMBKlrgByFW+2VE0n5frAIB3aNYJ3iDDXWjA80tFMVt1lR?=
 =?us-ascii?Q?tDBsnLsf9vQvWNf6hZRius64x7076RvjaU+e2iJWzU0TSNpqagkuLOslGlmh?=
 =?us-ascii?Q?mnElt73XkNXcUpxIhG2uVoTF7E1fQNrp44YlkdgR38M4P5RysDAY47ktKxtf?=
 =?us-ascii?Q?FOFI2R6AzxsJtS7GwMtfHzWefNXBaKh37VMD2gWl8eQK3rfUr5NgZsd4Soz5?=
 =?us-ascii?Q?Govej4v7SmXhHypylIW31P3w2sYjtjgqqdtqRpELJybnXmGfCMDNrIEdhUB4?=
 =?us-ascii?Q?as+8zQM1t4saZCDyun8H9dr67nEYRGTfXdZGesoTOqFt4BDkqby1VX1nbSDG?=
 =?us-ascii?Q?GHe7s2eqcilVyaHrFqONhJxKr8bTJehntd3A3XEOntAXn5KroGG2fkOSWvLi?=
 =?us-ascii?Q?ZtkKSx9UQyPqHgWgaWGKgbP5hlI9yGEINWBVHdEG1pF5JGW9CBxFHfjzsZj0?=
 =?us-ascii?Q?ecgtxI1MDCJVoybBiCWOxA0kyVnTJNwYrPF+LdIImo+8hCZTCi/fNX6Cm+iP?=
 =?us-ascii?Q?3Ou+aEPUI/cI+87GDpSvy3z87m4FGdHUxC6846lejkY1IwSKZKPv0vIx9cEJ?=
 =?us-ascii?Q?cVC4Nf814OCK5ndZwMGacwH+Rz9AlTu2EkzM0P53WBhGPX31rEJhiJeI+XSY?=
 =?us-ascii?Q?boqvlotdkxJ8oGV3bExjNZwqWyMYO6YbEwkMnVPk8QMzt0t57dmvhNfFacYG?=
 =?us-ascii?Q?J6RI8AFOY3rlCMzJuBQofVYGUcmQPFNfwE0tS2JoFdUFlaANJgmeSmTuV7VL?=
 =?us-ascii?Q?mOtnwBr7lVLGVDiJHfx/qbdTH97kvES71dfI/K8JGHOFAgI0qD2b0vV7BzLQ?=
 =?us-ascii?Q?yzGm5iU3T1FpQf2981cMCRhe9QrfWYeusE4d7Dmwyoy3Iz7PCvhTnLRuKvuD?=
 =?us-ascii?Q?NpqWzgHaujNZr/LAh6qIm0/K0GCW1fC+4sCU2vBmsGzHz7YIDSaTRk1dcMoh?=
 =?us-ascii?Q?WVOhWTtHUV9GLJIfuNiTWZzaOFeCajwqTds+biJcuUxEVtHqSIOfq4MJkSqL?=
 =?us-ascii?Q?q3kxeaRj5a8d6Yvze/nASE83UUMsI8gKJYxELvYFSSTPIOvUnLje8EPfFa3F?=
 =?us-ascii?Q?4o7qS8lDAPPqAYoN9muCdSo=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9366.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(52116014)(366016)(19092799006)(1800799024)(7053199007)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ONHOV5A2EWmkY4HNdLfNi4NsFHPOf38CHclgi8+4sMnRjcS1nV8enCCQsJ9E?=
 =?us-ascii?Q?xCPP91S9BJKNFk3JeO3VBSVT99BSIJbScjDjM2RKy+oc/Dn6zv0VV5d8zUxG?=
 =?us-ascii?Q?kdzjQN+ghGIRh8UAy++PQ8HaluvzeKPqjclKRYsVLeP8UG9nUAD67goyweRg?=
 =?us-ascii?Q?e4sJJchR95DeWvFl1m0Ck+aFf4i6NAiYayGo0PHnLaQJUuL+8jFUx4GeVE8+?=
 =?us-ascii?Q?eCNBlPbLMFXa+Bkwnd+3XZMjCWECDSRw2LlY1SreF92QSwE4g86kwWHFz+Sx?=
 =?us-ascii?Q?ynRPdJDFwaF3Ep0VAObV6ubZxAA3HIC2rbTBQUvhHTSS3dUViN23fIVzHC3P?=
 =?us-ascii?Q?OS15W0z17iHpa56RBYG0WoHkZrF3aiQoXQhyOPx0jyKswZ/BoYRMnqjU9z6I?=
 =?us-ascii?Q?4L6a4I3Jgp6+SuL3oQmKuf8l0qY5bBdb11ims2+HYUFwBENTHqx0yvslImWd?=
 =?us-ascii?Q?53f5o3GZoJti/mHebP3Febhjw7aGHGCsDGnu+ty0RYI18ED78dU21m4UUuJ0?=
 =?us-ascii?Q?KzUYKouB+5BcMZ80qTS3+3U0LhvvLW5Vw8avPTj2fnfK2PDMU01owhb30Nxg?=
 =?us-ascii?Q?SkLe2eMz9rmmB9qbLXXF3mRKnwoLvPeD5LF3M1/Cf33v/+DisYeL5KYCMrrd?=
 =?us-ascii?Q?X/Qi7I9XPhI6sZzDvaere5egwIO3w6S/LxgYMlM2O6PwMAtMB3JoVamfrnY9?=
 =?us-ascii?Q?brK4w8GYcdiCrHqqK9jBUxJqutbKPGkQWEY93ZRARDbthwEfEbdrrm0zo7O1?=
 =?us-ascii?Q?LAxGlkCOET+aA6RmdIIlPMeBdgL19ar+viOs2zuFKUFP7sxwidIth72hWPij?=
 =?us-ascii?Q?L8TNt64dEdQTTS5PptNMH8Hyzp718m+0gK4H7xNAkYk1QI5C16I1FX9Oa8vQ?=
 =?us-ascii?Q?zZP4g9Yc4hjGBlpY1GrLJxUG/yBgK4lYGTmVv0peA24i2THHzWtfGbH712fR?=
 =?us-ascii?Q?eOwPWEVuHbYD+klcGl2sH3ipFEeuXXxVp7uI55ZSX89xwaj4XejGfI2mkPVk?=
 =?us-ascii?Q?rK8Cc318P99wjV8zVcGnqlLQa+e2wh6MgjzrZ9MUFMk+/gma7mDiOsmxFaBU?=
 =?us-ascii?Q?E92z7/shaebjEo03kBS0QF9Kg5fOL9cSjjwERq0lfmvxNxH5YaI8SODmY9bB?=
 =?us-ascii?Q?FESBljzVk5qdhw4TvOcD8tXUDWYPBHpcGyBP/YDxMsKC6/Xdl8aMYzSEFzll?=
 =?us-ascii?Q?yddEW4fDo4QbeLWUeeBTFl9C7XTy9zm+ljR30FFAGnAO1oCpGrTUjsGll/HZ?=
 =?us-ascii?Q?nxfPh0FwJcZDY06B2ihTBnrGJVWSebRjv5id06i0PE+e3OFCOL3YFDHIdJCP?=
 =?us-ascii?Q?2auJ8XfdkNWW4wNmeOVrBgZAifL3XnCh8TBwPfBJz28GSVWSaFxMxpyAa0KP?=
 =?us-ascii?Q?Vldg0uQ3JKw+SKFfLHyE0xJvn/ZGM39qINloVjAcPtd1g8e+Vw8S9vB3vgxe?=
 =?us-ascii?Q?i3dxy83DKqBDlZMwWsWtdHdw46FKV+Is3QuNBEJXXxGwePMcNlCCLGmDLNQk?=
 =?us-ascii?Q?G0TdGUeideSpsbI0A+avF5NKKiqqCphi64W01lHHIcD4FjCnfe4HlGMGInyD?=
 =?us-ascii?Q?57smG/2txZvdAXB0d1EkNBMqy/7kAMBniDWBAesXrszC+HTuaj2I/oFLWEgU?=
 =?us-ascii?Q?5YxvOMbZTt3Ti/HmUJ1wbADdXDwODpppJDWingI+Gw5aow4g71HhSne7uTJa?=
 =?us-ascii?Q?9Q5nSV8zww2rlaGJ4KAHmXHoWBu6tNad6QIBYFVIWe70ahJcrNaF8/LR7ZkP?=
 =?us-ascii?Q?i3Ljk4KofQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ea4ee6fe-ba32-438b-85c5-08de69a37ef4
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9366.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2026 19:26:46.5537
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kOuoB5V68jK5q9vlEopNU4WqreBHBkIYjQWEam0xQ/VbAFW/qlIRliAXyXy4XqKsTHYWG50RLlXZmVRRLIJ6Zw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB7489

On Wed, Feb 11, 2026 at 06:55:41PM +0100, Niklas Cassel wrote:
> When running e.g. fio with a larger queue depth against nvmet-pci-epf we
> get IOMMU errors on the host, e.g.:
>
> arm-smmu-v3 fc900000.iommu:      0x0000010000000010
> arm-smmu-v3 fc900000.iommu:      0x0000020000000000
> arm-smmu-v3 fc900000.iommu:      0x000000090000f040
> arm-smmu-v3 fc900000.iommu:      0x0000000000000000
> arm-smmu-v3 fc900000.iommu: event: F_TRANSLATION client: 0000:01:00.0 sid: 0x100 ssid: 0x0 iova: 0x90000f040 ipa: 0x0
> arm-smmu-v3 fc900000.iommu: unpriv data write s1 "Input address caused fault" stag: 0x0
>
> The reason for this is that the writel() is immediately followed by a call
> to unmap(), which will tear down the outbound address translation.
>
> PCI writes are posted, i.e. don't wait for a completion. Thus, when the
> writel() returns, might not have completed yet, and could even still be
> buffered in the PCI bridge, at the time unmap() is called.
>
> Flush the write by performing a read() of the same address, to ensure that
> the write has reached the destination before calling unmap().
>
> This will add some latency, but that is certainly preferred over corrupting
> the host memory.
>
> The same problem was solved for dw_pcie_ep_raise_msi_irq(), in commit
> 8719c64e76bf ("PCI: dwc: ep: Cache MSI outbound iATU mapping"), however
> there it was solved by dedicating an outbound iATU only for MSI. For MSI-X,
> we can't do the same, as each vector can have a different msg_addr, and
> because the msg_addr is allowed to be changed while the vector is masked.
>
> Fixes: beb4641a787d ("PCI: dwc: Add MSI-X callbacks handler")

Cc stable?

> Signed-off-by: Niklas Cassel <cassel@kernel.org>
> ---

Reviewed-by: Frank Li <Frank.Li@nxp.com>

>  drivers/pci/controller/dwc/pcie-designware-ep.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c b/drivers/pci/controller/dwc/pcie-designware-ep.c
> index 5d8024d5e5c6..aef41f0218a3 100644
> --- a/drivers/pci/controller/dwc/pcie-designware-ep.c
> +++ b/drivers/pci/controller/dwc/pcie-designware-ep.c
> @@ -1005,6 +1005,9 @@ int dw_pcie_ep_raise_msix_irq(struct dw_pcie_ep *ep, u8 func_no,
>
>  	writel(msg_data, ep->msi_mem + offset);
>
> +	/* flush posted write before unmap */
> +	readl(ep->msi_mem + offset);
> +
>  	dw_pcie_ep_unmap_addr(epc, func_no, 0, ep->msi_mem_phys);
>
>  	return 0;
> --
> 2.53.0
>
