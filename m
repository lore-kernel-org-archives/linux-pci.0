Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011000.outbound.protection.outlook.com [52.101.70.0])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A60AB299928;
	Fri, 30 Jan 2026 17:47:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.0
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769795243; cv=fail; b=ZRsBHfUSQA0z73TcBeAsMzzdJ5aKy7x7HcQy7haYAu6T++1mbWiXDoUaBu8yP+k2V8RGHdeURivjU8/STrc3ks1k27Tw9hbPOIppHRh2iiAQt4RQQhonmsQwHWwKQUyYdufXjE6IYoMgW6tqidzS8xb9dpjtKWdT+a39Ms5WDMw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769795243; c=relaxed/simple;
	bh=aBJ873KTStFHjafuEw1X37kLQNPu16rn0Unslp6KxzY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=kHecLedAmSOaYRLo6zfNSdF0cLY5DdkmCjb/MjuUe7N0hhYWlsn6/vX3mwQthXfG+Cs9kqUpAZq7PWm4l6HlHsZYv5C/i9MZBe34JUoXh/KeXog8a9hEA+Kg7uzefXpC4wrFfhkCQCoVwmPk4P+5/U1PgAQxFa+msvEuAWk0PzA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=HQWL6tkw; arc=fail smtp.client-ip=52.101.70.0
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="HQWL6tkw"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ocLqz32H9rgjczpLwnUpDRkvrUSlOMaWhDauLH0B77w7AEvYQL74+s5WHACezoZFESVfuGR46ecmTzaDOMcIBsD+5Dq6ZLwS1CM1coXw/3p5jtyxlHC8IM6MIri0gskQxKCCsXDop13/mBQPyey/B+7GJbVeXICFpnBi9ODMl1bQ7DY94xrzBLzTt1B0uXaEgqGxAvE0FH8a3G8XGYVI87rNLMOUIOQgqnCgzs+APCOcXTpHQHtukykplXFQdOZu9LpvMHRjT7XgrMRYQ5REIVU3Zc3Ig4KbhutfO3IbFAEoMI4mjosaRfG7u0sxUzuu63dI/sP9+K1L3yCCR0arhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JvNyEzCKYHLFVW/Fyf7jbHg840N9ZQ92eUc/eXdCxEU=;
 b=BpBKgUYi6jwSsr98CLP6wXcZczrrUYspz3gdrP6IHM5CJqXng+XcwSUKjajiiiu1ujbSLGdVegGkEWY0suXo84sf4qaz+ni0R51mtzdmIlpJl2n3//tJOErsHI3mjn3TwLBXphv82YMIG7bPmo82nap4kmFggyMkKjjk2GD7ucwiuvhydAajleCF3nC50Lp2Uy3JlNLeW+uIIEnJZBZWKfvrvlb0+9mZP8aGmvQw/czn7nLLTP1jRXxa7iMJ63fvkrGqbJ4b8iN3D41SGOVBYUFrdioO3nobm0hoC/IoKrWcPBX6gvkaP2S6tNthd8/rnC4v4gz/AU6qmkqdvFi9BA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JvNyEzCKYHLFVW/Fyf7jbHg840N9ZQ92eUc/eXdCxEU=;
 b=HQWL6tkwimKG/CCHui2I7Rn3d5iRieVhwRhPIvI+YCdYZatT3glihQry/OZ0ULuKvzNio3eeQJoD4PodosxpC6dV1H0utkBZu6lOj2hp6iWgOQvJn7z3yuu1aUB7gs6qJ1OPelUkM/spgwGgiNImiBwhppyiHas+l6iynVWGNtFW4UOLgbHGqHRUCRhQg13YCfCct2954hzCbu+JWjJlPtowB15u7USBlLTc1qwxZLwEidzBhFQ39NjTtV2gyV0hwpas03cbvJ2vngGDzeyvCBU3TX3Kf1DOcx44g/+Ukv3AdAG7FaTEUNkhtZR31FNzM9m2XgJYpfztVNImqgMWFA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU0PR04MB9372.eurprd04.prod.outlook.com (2603:10a6:10:35b::7)
 by GV2PR04MB11826.eurprd04.prod.outlook.com (2603:10a6:150:2d1::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.7; Fri, 30 Jan
 2026 17:47:18 +0000
Received: from DU0PR04MB9372.eurprd04.prod.outlook.com
 ([fe80::4f6:1e57:c3b9:62b4]) by DU0PR04MB9372.eurprd04.prod.outlook.com
 ([fe80::4f6:1e57:c3b9:62b4%5]) with mapi id 15.20.9520.010; Fri, 30 Jan 2026
 17:47:17 +0000
Date: Fri, 30 Jan 2026 12:47:09 -0500
From: Frank Li <Frank.li@nxp.com>
To: Aksh Garg <a-garg7@ti.com>
Cc: linux-pci@vger.kernel.org, jingoohan1@gmail.com, mani@kernel.org,
	lpieralisi@kernel.org, kwilczynski@kernel.org, robh@kernel.org,
	bhelgaas@google.com, cassel@kernel.org, Zhiqiang.Hou@nxp.com,
	gustavo.pimentel@synopsys.com, den@valinux.co.jp,
	linux-kernel@vger.kernel.org, s-vadapalli@ti.com,
	danishanwar@ti.com
Subject: Re: [PATCH v5 2/3] PCI: dwc: ep: Add per-PF BAR and inbound ATU
 mapping support
Message-ID: <aXzunVBXeJUrIe/K@lizhi-Precision-Tower-5810>
References: <20260130115516.515082-1-a-garg7@ti.com>
 <20260130115516.515082-3-a-garg7@ti.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260130115516.515082-3-a-garg7@ti.com>
X-ClientProxiedBy: PH8P222CA0022.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:510:2d7::33) To PA4PR04MB9366.eurprd04.prod.outlook.com
 (2603:10a6:102:2a9::8)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9372:EE_|GV2PR04MB11826:EE_
X-MS-Office365-Filtering-Correlation-Id: 4153b973-a74a-40ee-2db8-08de60279c25
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|376014|7416014|52116014|1800799024|366016|38350700014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?hbJPnTymr388avkMy3MebanfBYFNerY7jaHEa9olm7w/pdzKDVC7gZ1iKItb?=
 =?us-ascii?Q?evBho4KDWqHqMZ/+dutKEKC0YLhsQGx9AO3DdxHDpIvdYOEbLvX9ZJpTYmOz?=
 =?us-ascii?Q?1J2sB04AB9V8Veo1oCiQ3MiB5S2NCD+9UKj2Ri4778o5X26BSgh5Z5avQVI5?=
 =?us-ascii?Q?wovTRpYzivsrzEcevFuUWi+QRuCR/m2uWDTh99LrcQI8lufepiu47S0BVg1j?=
 =?us-ascii?Q?NV6lAk9Gjx7nNHY1nsS6VdwaZNLy+xPSwB5eAbJ5nLNkTxSVrWV/2ByxQcCe?=
 =?us-ascii?Q?l/8Zx0naY8hT2EQq034fEqSwJWrEO1g0pUIB495PBLvPF4P4uS4p+8Ee6pBm?=
 =?us-ascii?Q?Y1GUTIJsLK4ykSSn5CEmKmEYt7vwetV8Km9+JzzOY28IR2GO1eMVAOxwdZZT?=
 =?us-ascii?Q?f6w/pyOsMpWkmzefKT1uIXIjVp+mwW7rk3NOaepkmot0yOUAES3UeKhYxuwc?=
 =?us-ascii?Q?08bQzfzN3OlVM5P2jdYqO7KLP9rbnJ4DHOP+hTN7bOOYHfu+WA3SPRSCgh4B?=
 =?us-ascii?Q?xI0X8pGi8FlZN5kOa+3fiwIQ0lbQycpPIr7xMXZabY5stj72abvrTX0mjCpe?=
 =?us-ascii?Q?7GlwZ6aIsx37toVVsSIPbCU70Ccerd4W9+Q9i7bjcrrgGNnH3wc+ZbsS22o/?=
 =?us-ascii?Q?1hV/72otM2LQmTLWwBHKiH8vOCsYz3DIHOBLjqQQ83+FAGkA7+A3/VLG3ksD?=
 =?us-ascii?Q?JlOFdgCLQfEjza7x82AUVIkazaI6R7AyGy6YvEgfTqses2766fojMID7kqxU?=
 =?us-ascii?Q?AarJbZH+St8AI3m2khmKkDwdj9yQ1hhhLiiCSrrUX2RDm1Dx6OPxYLxV3l7e?=
 =?us-ascii?Q?af7ybenRxnAkgnjbBd9usSX4Zj1E689ysdk0x/WEsSgrvydx8gUr3/McgMyT?=
 =?us-ascii?Q?wC/rqTHkCZ4uL7EiGEsW1YeGiZxQf+MC6WCjLJtSutcoycLDYzLx0icxCqqh?=
 =?us-ascii?Q?Egg4FnLcD5bWmuFan9RxAfNWlr2qm9h7n+k2k0UfQhY08msurrQoEslU22n6?=
 =?us-ascii?Q?wicJMoA09whi/NW72eJAc/Hhp+ki6UUzVVpX6sjp/1zbxtuBL+hOH1KD4GEq?=
 =?us-ascii?Q?ciB0NcrwHmrpR0POor4Ay6E7ABZGFTPysCx8r4UulILV0xws7Bc/jfpUkMR/?=
 =?us-ascii?Q?bxekjmWT1lKyAp4mL1spAutNL/Zpqawt1AxxUoH7VYtksG/H3BFm8L40OEMe?=
 =?us-ascii?Q?6aG0P35zr8nEnyoky8qyXQT/2HsmgzZsXFus34fgjuwEPMeSqZsFTGxR8bOx?=
 =?us-ascii?Q?4XWZYTH1N0IgfTJ9LG1RUTi7JSfqmYOl+HOYEh679pZF9HgXC/bw/lhX1Jbi?=
 =?us-ascii?Q?iHkQZgY4nDqtxVGls2kZPw8UusYhrJmuFk3YJySnteReF1R81w9hS1PL/Q+V?=
 =?us-ascii?Q?mwTMoKyIes4YHjPQZwsjVJ5HPA3ChtnDf52j2FC7gVREuJVdIpI19moDz7xy?=
 =?us-ascii?Q?TI6M4g1s3J/JPQqQdCouJpjfuMISvbm3MIcBubff7AZzCHPuk7wCea0X7dvk?=
 =?us-ascii?Q?OGc3jIgzZyEAWU7yDTZ/kdxlQ0XnQRyCFDthPa2pJP1Yb0IBGXKgawdO6o+Z?=
 =?us-ascii?Q?/GR9qzSv09FEC9b1Li9oDEToc5LR9/QBrCWj1aN389pNJdm8OVn8ty6eWvCP?=
 =?us-ascii?Q?Qs+LvhdwwAZ/xflovuY8sH0=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9372.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(376014)(7416014)(52116014)(1800799024)(366016)(38350700014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?JO4ImSEuL0b8FGW9qR1rzrsB0qdu7FO2sEQPrBIGj1ok51SPLhPIHnppaGEY?=
 =?us-ascii?Q?AOfnu9eG+dDWcAY+IgiObc3+LPoxexJ1cw0IqTz1fMLtsYITwVXKh8/pU8kE?=
 =?us-ascii?Q?m2gEq7isaUIpGTTaMSP1uDDpK0rpvxda0yxHF9WbnKYkLz+UzV5nVFNyIRmc?=
 =?us-ascii?Q?krREPGXBZU4FUuMDDtA3cBX095NpNoWoik2MEc+mDIa2mo76HQj898imUoe7?=
 =?us-ascii?Q?cOfYTdgbBL3b/dA6YxawQmp0BdVkLYvh46sRV9Rk1Ova74PaOsRVgiXBOJtY?=
 =?us-ascii?Q?XTTGQamdVLKVQvuGs1ap7uwor6hKCY465gX5DYVkQYyf5xewI2I1E6PVK2Mg?=
 =?us-ascii?Q?G1MIT5YfpoYK83UQ49LgrPqGIAZTXox/AVHLSwiW5qYwzKCBm67SCnz+RhiL?=
 =?us-ascii?Q?1XSyYObD1nDwXBmbCHw2HxT/WJ8BxN3QobEICgu1JsoQG/OagLR09HfxHDwH?=
 =?us-ascii?Q?5h47F6w4fTneZ6K85pvYELzCwbBLy+ZFHsmGjMT9e2zYIniHfCjFOVum16uf?=
 =?us-ascii?Q?+/84OhMsNIOQ3fwK7bZRlQFC+y92WTy4a6Ja5IaM6lyXbHR3s3JCoW1yxgqF?=
 =?us-ascii?Q?a0OhwxgXjX1VN8816w7F2G1MxAiSpVTSTpdwbtBUJQgim1JS5YaWam7C6hHK?=
 =?us-ascii?Q?EH898252nFU6WOyOg5k7hpFF7Jt0rFnbR1npHTYcb783STfccsZmn/w0glP1?=
 =?us-ascii?Q?VsMvnQmnycraMLbxTT4AJFJUBc1tedDkgCmsuF37pGO1eu/2nBj0du2/XYx9?=
 =?us-ascii?Q?QRduQlkwg8qfKAjB6j+7URO1gNw7YfWxtn0FEwMbn6veXFVrBxDRUZaGryor?=
 =?us-ascii?Q?kT+fAY7c7AaL3AtPdx/7rE05XO99lC3+jZQ6m2ZAjs/9k9NFTgjGYKZWQejT?=
 =?us-ascii?Q?HjX5nwwOVbaZQZKz74R7rIUqGU92zKDUldKsXGAfAjTL1phGc/8duH1PWvMX?=
 =?us-ascii?Q?h9g5glJxy1GXo2/dMwv7fUtgV+qld0/toybetQ/hi6tf3LjyyNKVI53fCG4w?=
 =?us-ascii?Q?Mag66B6bktSScUNLuY94H62420AwFRPWZayto6VwfhYePPY5gqYdQSbVm7LJ?=
 =?us-ascii?Q?IDcmx5CY1hzhWGGSm8ar2/ltl50JD+xWIJ6TR0uHaX1NkwxVj05YbRH8f84D?=
 =?us-ascii?Q?wxPvoKpSvZAkDx/cAqHiHBpQ+ndKodPHfVLaCQGGogi4HKnkbkJu52qgfHIz?=
 =?us-ascii?Q?k9rYoyQCgcAq6QFXo9jeV9+y9yI7PTP5spWSnRqXQbFpJNjwBACunGgD61CV?=
 =?us-ascii?Q?lTHhG3HENu1GKmzdWyHUba7KyOA1PT1a1wE56/JfsIeHo1m6sp/X3ofhgB4+?=
 =?us-ascii?Q?TFrstXaKrJ1VpqzObVdGfte7WgABv76AtaWVe7LBv2Jz6hdAAeaUsUXLi6WK?=
 =?us-ascii?Q?49NVYX/GTdK2QhGuICoqczeI37xdOlovDFfu3QzkPmEGY+gJHLgANv7vch79?=
 =?us-ascii?Q?5JQWtTIFGBOC3Am/KVzvB9Tnfcp7RXnZ/SFZBeM+X3ylTXdH9/EcbIRLE0fN?=
 =?us-ascii?Q?6hEBOKzt0XlTkoVEnG0iLDiGvWFKeoeVTfpMG4R4XbbPKJepSaBBFzDOvirT?=
 =?us-ascii?Q?2hTQQHNZVO490rQb9cqpc+35XCPcyviHGI/2SC4tgxGoK0Z/DMZtR9McaEgM?=
 =?us-ascii?Q?Vc/GIcp+tGwtIJy/MnQVod0ZGBc3cykKi/KL590QCDGeECF9q+F1ZtWTnNjH?=
 =?us-ascii?Q?aMxuzsvJ4liUy6NOes8yeihALoeFE5rLquWLgB6GE7WaUmtQi9a5u7yQyDXn?=
 =?us-ascii?Q?TnQjz1whOA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4153b973-a74a-40ee-2db8-08de60279c25
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9366.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jan 2026 17:47:17.8376
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Elgd6YixZtBP9xcEyo4t8etTOhW3ZtgqBP9YA+fl8NIUTqpOZxjYIrDL1qyP4bluoBhAOsXM5DReFjjEtPKKdQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR04MB11826

On Fri, Jan 30, 2026 at 05:25:15PM +0530, Aksh Garg wrote:
> The commit 24ede430fa49 ("PCI: designware-ep: Add multiple PFs support
> for DWC") added support for multiple PFs in the DWC driver, but the
> implementation was incomplete. It did not properly support MSI/MSI-X,
> as well as BAR and inbound ATU mapping for multiple PFs. The MSI/MSI-X
> issue was later fixed by commit 47a062609a30 ("PCI: designware-ep:
> Modify MSI and MSIX CAP way of finding") by introducing a per-PF
> struct dw_pcie_ep_func.
>
> However, even with both commits, the multiple PF support in the driver
> remains broken because BAR configuration and ATU mappings are managed
> globally in struct dw_pcie_ep, meaning all PFs share the same BAR-to-ATU
> mapping table. This causes one PF's EPF to overwrite the address
> translation of another PF's EPF in the internal ATU region,
> creating conflicts when multiple physical functions attempt to
> configure their BARs independently.
>
> The commit cfbc98dbf44d ("PCI: dwc: ep: Support BAR subrange inbound
> mapping via Address Match Mode iATU") later introduced Address Match
> Mode support, which suffers from the same multi-PF conflict issue.
>
> Fix this by moving the required members from struct dw_pcie_ep to
> struct dw_pcie_ep_func, similar to what commit 47a062609a30
> ("PCI: designware-ep: Modify MSI and MSIX CAP way of finding") did for
> MSI/MSI-X capability support, to allow proper multi-function endpoint
> operation, where each PF can configure its BARs and corresponding
> internal ATU region without interfering with other PFs.
>
> Fixes: 24ede430fa49 ("PCI: designware-ep: Add multiple PFs support for DWC")
> Fixes: cfbc98dbf44d ("PCI: dwc: ep: Support BAR subrange inbound mapping via Address Match Mode iATU")
> Signed-off-by: Aksh Garg <a-garg7@ti.com>
> Reviewed-by: Niklas Cassel <cassel@kernel.org>
> ---

not related with patch, Does your hardware have ITS?

Reviewed-by: Frank Li <Frank.Li@nxp.com>

>
> Changes from v4 to v5:
> - Added NULL checker for ep_func in dw_pcie_ep_clear_ib_maps()
>
> Changes from v3 to v4:
> - Fix the similar conflict created by the commit cfbc98dbf44d
>
> Changes from v2 to v3:
> - None
>
> Changes from v1 to v2:
> - Fixed the suggested nits
> - Rephrased the commit message with a proper Fixes tag
>
> v4: https://lore.kernel.org/all/20260129091753.490167-3-a-garg7@ti.com/
> v3: https://lore.kernel.org/all/20260127085010.446116-3-a-garg7@ti.com/
> v2: https://lore.kernel.org/all/20260122082538.309122-3-a-garg7@ti.com/
> v1: https://lore.kernel.org/all/20260121054214.274429-3-a-garg7@ti.com/
>
>  .../pci/controller/dwc/pcie-designware-ep.c   | 79 +++++++++++--------
>  drivers/pci/controller/dwc/pcie-designware.h  | 12 +--
>  2 files changed, 54 insertions(+), 37 deletions(-)
>
> diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c b/drivers/pci/controller/dwc/pcie-designware-ep.c
> index 1cc2985bab03..6d3c35dd280f 100644
> --- a/drivers/pci/controller/dwc/pcie-designware-ep.c
> +++ b/drivers/pci/controller/dwc/pcie-designware-ep.c
> @@ -115,11 +115,15 @@ static int dw_pcie_ep_ib_atu_bar(struct dw_pcie_ep *ep, u8 func_no, int type,
>  	int ret;
>  	u32 free_win;
>  	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
> +	struct dw_pcie_ep_func *ep_func = dw_pcie_ep_get_func_from_ep(ep, func_no);
>
> -	if (!ep->bar_to_atu[bar])
> +	if (!ep_func)
> +		return -EINVAL;
> +
> +	if (!ep_func->bar_to_atu[bar])
>  		free_win = find_first_zero_bit(ep->ib_window_map, pci->num_ib_windows);
>  	else
> -		free_win = ep->bar_to_atu[bar] - 1;
> +		free_win = ep_func->bar_to_atu[bar] - 1;
>
>  	if (free_win >= pci->num_ib_windows) {
>  		dev_err(pci->dev, "No free inbound window\n");
> @@ -137,33 +141,37 @@ static int dw_pcie_ep_ib_atu_bar(struct dw_pcie_ep *ep, u8 func_no, int type,
>  	 * Always increment free_win before assignment, since value 0 is used to identify
>  	 * unallocated mapping.
>  	 */
> -	ep->bar_to_atu[bar] = free_win + 1;
> +	ep_func->bar_to_atu[bar] = free_win + 1;
>  	set_bit(free_win, ep->ib_window_map);
>
>  	return 0;
>  }
>
> -static void dw_pcie_ep_clear_ib_maps(struct dw_pcie_ep *ep, enum pci_barno bar)
> +static void dw_pcie_ep_clear_ib_maps(struct dw_pcie_ep *ep, u8 func_no, enum pci_barno bar)
>  {
> +	struct dw_pcie_ep_func *ep_func = dw_pcie_ep_get_func_from_ep(ep, func_no);
>  	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
>  	struct device *dev = pci->dev;
>  	unsigned int i, num;
>  	u32 atu_index;
>  	u32 *indexes;
>
> +	if (!ep_func)
> +		return;
> +
>  	/* Tear down the BAR Match Mode mapping, if any. */
> -	if (ep->bar_to_atu[bar]) {
> -		atu_index = ep->bar_to_atu[bar] - 1;
> +	if (ep_func->bar_to_atu[bar]) {
> +		atu_index = ep_func->bar_to_atu[bar] - 1;
>  		dw_pcie_disable_atu(pci, PCIE_ATU_REGION_DIR_IB, atu_index);
>  		clear_bit(atu_index, ep->ib_window_map);
> -		ep->bar_to_atu[bar] = 0;
> +		ep_func->bar_to_atu[bar] = 0;
>  	}
>
>  	/* Tear down all Address Match Mode mappings, if any. */
> -	indexes = ep->ib_atu_indexes[bar];
> -	num = ep->num_ib_atu_indexes[bar];
> -	ep->ib_atu_indexes[bar] = NULL;
> -	ep->num_ib_atu_indexes[bar] = 0;
> +	indexes = ep_func->ib_atu_indexes[bar];
> +	num = ep_func->num_ib_atu_indexes[bar];
> +	ep_func->ib_atu_indexes[bar] = NULL;
> +	ep_func->num_ib_atu_indexes[bar] = 0;
>  	if (!indexes)
>  		return;
>  	for (i = 0; i < num; i++) {
> @@ -248,6 +256,7 @@ static int dw_pcie_ep_validate_submap(struct dw_pcie_ep *ep,
>  static int dw_pcie_ep_ib_atu_addr(struct dw_pcie_ep *ep, u8 func_no, int type,
>  				  const struct pci_epf_bar *epf_bar)
>  {
> +	struct dw_pcie_ep_func *ep_func = dw_pcie_ep_get_func_from_ep(ep, func_no);
>  	const struct pci_epf_bar_submap *submap = epf_bar->submap;
>  	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
>  	enum pci_barno bar = epf_bar->barno;
> @@ -258,7 +267,7 @@ static int dw_pcie_ep_ib_atu_addr(struct dw_pcie_ep *ep, u8 func_no, int type,
>  	unsigned int i;
>  	u32 *indexes;
>
> -	if (!epf_bar->num_submap || !submap || !epf_bar->size)
> +	if (!ep_func || !epf_bar->num_submap || !submap || !epf_bar->size)
>  		return -EINVAL;
>
>  	ret = dw_pcie_ep_validate_submap(ep, submap, epf_bar->num_submap,
> @@ -279,8 +288,8 @@ static int dw_pcie_ep_ib_atu_addr(struct dw_pcie_ep *ep, u8 func_no, int type,
>  	if (!indexes)
>  		return -ENOMEM;
>
> -	ep->ib_atu_indexes[bar] = indexes;
> -	ep->num_ib_atu_indexes[bar] = 0;
> +	ep_func->ib_atu_indexes[bar] = indexes;
> +	ep_func->num_ib_atu_indexes[bar] = 0;
>
>  	for (i = 0; i < epf_bar->num_submap; i++) {
>  		size = submap[i].size;
> @@ -308,11 +317,11 @@ static int dw_pcie_ep_ib_atu_addr(struct dw_pcie_ep *ep, u8 func_no, int type,
>
>  		set_bit(free_win, ep->ib_window_map);
>  		indexes[i] = free_win;
> -		ep->num_ib_atu_indexes[bar] = i + 1;
> +		ep_func->num_ib_atu_indexes[bar] = i + 1;
>  	}
>  	return 0;
>  err:
> -	dw_pcie_ep_clear_ib_maps(ep, bar);
> +	dw_pcie_ep_clear_ib_maps(ep, func_no, bar);
>  	return ret;
>  }
>
> @@ -346,15 +355,16 @@ static void dw_pcie_ep_clear_bar(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
>  	struct dw_pcie_ep *ep = epc_get_drvdata(epc);
>  	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
>  	enum pci_barno bar = epf_bar->barno;
> +	struct dw_pcie_ep_func *ep_func = dw_pcie_ep_get_func_from_ep(ep, func_no);
>
> -	if (!ep->epf_bar[bar])
> +	if (!ep_func || !ep_func->epf_bar[bar])
>  		return;
>
>  	__dw_pcie_ep_reset_bar(pci, func_no, bar, epf_bar->flags);
>
> -	dw_pcie_ep_clear_ib_maps(ep, bar);
> +	dw_pcie_ep_clear_ib_maps(ep, func_no, bar);
>
> -	ep->epf_bar[bar] = NULL;
> +	ep_func->epf_bar[bar] = NULL;
>  }
>
>  static unsigned int dw_pcie_ep_get_rebar_offset(struct dw_pcie_ep *ep, u8 func_no,
> @@ -481,12 +491,16 @@ static int dw_pcie_ep_set_bar(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
>  {
>  	struct dw_pcie_ep *ep = epc_get_drvdata(epc);
>  	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
> +	struct dw_pcie_ep_func *ep_func = dw_pcie_ep_get_func_from_ep(ep, func_no);
>  	enum pci_barno bar = epf_bar->barno;
>  	size_t size = epf_bar->size;
>  	enum pci_epc_bar_type bar_type;
>  	int flags = epf_bar->flags;
>  	int ret, type;
>
> +	if (!ep_func)
> +		return -EINVAL;
> +
>  	/*
>  	 * DWC does not allow BAR pairs to overlap, e.g. you cannot combine BARs
>  	 * 1 and 2 to form a 64-bit BAR.
> @@ -500,22 +514,22 @@ static int dw_pcie_ep_set_bar(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
>  	 * calling clear_bar() would clear the BAR's PCI address assigned by the
>  	 * host).
>  	 */
> -	if (ep->epf_bar[bar]) {
> +	if (ep_func->epf_bar[bar]) {
>  		/*
>  		 * We can only dynamically change a BAR if the new BAR size and
>  		 * BAR flags do not differ from the existing configuration.
>  		 */
> -		if (ep->epf_bar[bar]->barno != bar ||
> -		    ep->epf_bar[bar]->size != size ||
> -		    ep->epf_bar[bar]->flags != flags)
> +		if (ep_func->epf_bar[bar]->barno != bar ||
> +		    ep_func->epf_bar[bar]->size != size ||
> +		    ep_func->epf_bar[bar]->flags != flags)
>  			return -EINVAL;
>
>  		/*
>  		 * When dynamically changing a BAR, tear down any existing
>  		 * mappings before re-programming.
>  		 */
> -		if (ep->epf_bar[bar]->num_submap || epf_bar->num_submap)
> -			dw_pcie_ep_clear_ib_maps(ep, bar);
> +		if (ep_func->epf_bar[bar]->num_submap || epf_bar->num_submap)
> +			dw_pcie_ep_clear_ib_maps(ep, func_no, bar);
>
>  		/*
>  		 * When dynamically changing a BAR, skip writing the BAR reg, as
> @@ -574,7 +588,7 @@ static int dw_pcie_ep_set_bar(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
>  	if (ret)
>  		return ret;
>
> -	ep->epf_bar[bar] = epf_bar;
> +	ep_func->epf_bar[bar] = epf_bar;
>
>  	return 0;
>  }
> @@ -969,7 +983,7 @@ int dw_pcie_ep_raise_msix_irq(struct dw_pcie_ep *ep, u8 func_no,
>  	bir = FIELD_GET(PCI_MSIX_TABLE_BIR, tbl_offset);
>  	tbl_offset &= PCI_MSIX_TABLE_OFFSET;
>
> -	msix_tbl = ep->epf_bar[bir]->addr + tbl_offset;
> +	msix_tbl = ep_func->epf_bar[bir]->addr + tbl_offset;
>  	msg_addr = msix_tbl[(interrupt_num - 1)].msg_addr;
>  	msg_data = msix_tbl[(interrupt_num - 1)].msg_data;
>  	vec_ctrl = msix_tbl[(interrupt_num - 1)].vector_ctrl;
> @@ -1032,11 +1046,14 @@ EXPORT_SYMBOL_GPL(dw_pcie_ep_deinit);
>
>  static void dw_pcie_ep_init_rebar_registers(struct dw_pcie_ep *ep, u8 func_no)
>  {
> -	unsigned int offset;
> -	unsigned int nbars;
> +	struct dw_pcie_ep_func *ep_func = dw_pcie_ep_get_func_from_ep(ep, func_no);
> +	unsigned int offset, nbars;
>  	enum pci_barno bar;
>  	u32 reg, i, val;
>
> +	if (!ep_func)
> +		return;
> +
>  	offset = dw_pcie_ep_find_ext_capability(ep, func_no, PCI_EXT_CAP_ID_REBAR);
>
>  	if (offset) {
> @@ -1063,8 +1080,8 @@ static void dw_pcie_ep_init_rebar_registers(struct dw_pcie_ep *ep, u8 func_no)
>  			 */
>  			val = dw_pcie_ep_readl_dbi(ep, func_no, offset + PCI_REBAR_CTRL);
>  			bar = FIELD_GET(PCI_REBAR_CTRL_BAR_IDX, val);
> -			if (ep->epf_bar[bar])
> -				pci_epc_bar_size_to_rebar_cap(ep->epf_bar[bar]->size, &val);
> +			if (ep_func->epf_bar[bar])
> +				pci_epc_bar_size_to_rebar_cap(ep_func->epf_bar[bar]->size, &val);
>  			else
>  				val = BIT(4);
>
> diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
> index 8f170122ad78..43d7606bc987 100644
> --- a/drivers/pci/controller/dwc/pcie-designware.h
> +++ b/drivers/pci/controller/dwc/pcie-designware.h
> @@ -471,6 +471,12 @@ struct dw_pcie_ep_func {
>  	u8			func_no;
>  	u8			msi_cap;	/* MSI capability offset */
>  	u8			msix_cap;	/* MSI-X capability offset */
> +	u8			bar_to_atu[PCI_STD_NUM_BARS];
> +	struct pci_epf_bar	*epf_bar[PCI_STD_NUM_BARS];
> +
> +	/* Only for Address Match Mode inbound iATU */
> +	u32			*ib_atu_indexes[PCI_STD_NUM_BARS];
> +	unsigned int		num_ib_atu_indexes[PCI_STD_NUM_BARS];
>  };
>
>  struct dw_pcie_ep {
> @@ -480,17 +486,11 @@ struct dw_pcie_ep {
>  	phys_addr_t		phys_base;
>  	size_t			addr_size;
>  	size_t			page_size;
> -	u8			bar_to_atu[PCI_STD_NUM_BARS];
>  	phys_addr_t		*outbound_addr;
>  	unsigned long		*ib_window_map;
>  	unsigned long		*ob_window_map;
>  	void __iomem		*msi_mem;
>  	phys_addr_t		msi_mem_phys;
> -	struct pci_epf_bar	*epf_bar[PCI_STD_NUM_BARS];
> -
> -	/* Only for Address Match Mode inbound iATU */
> -	u32			*ib_atu_indexes[PCI_STD_NUM_BARS];
> -	unsigned int		num_ib_atu_indexes[PCI_STD_NUM_BARS];
>
>  	/* MSI outbound iATU state */
>  	bool			msi_iatu_mapped;
> --
> 2.34.1
>
