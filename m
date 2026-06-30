Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013046.outbound.protection.outlook.com [40.107.159.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F52B466B59;
	Tue, 30 Jun 2026 15:52:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782834750; cv=fail; b=t8CjneuFFxJZoJv1i8iRinkqZ1ecxcg5npPeqLADpJ6xJhJyGLw2sB5hh+nCEQJwPYD/BwguR3MLp2cjV1vTjK8m64T449eF+KF2HNHC0FnLIsS05dD7ZoKZGycw1kYkHDrMuQo/0M2O+fxpz8ZkKZJA3kvMe/M3VIE7/fIMXj8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782834750; c=relaxed/simple;
	bh=ZoQm2oLSD3NGukMknAkQRVF02eloMWhEVi9MqCZz+94=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=kf9//sXIntVZ3itJrcp2pQVOXlByT2ltdDHbeTJLNZtIiPsgo/RdmOJ/F3aBHNjkzS8xkVrtUPQZx4aCGPLj23fcThGD3CIwInTVKXYfbCQUp/OAotGZp0M2rvd+ogwsFyuqC7ElVkHNvrOuQegGmJxtEKK9YTjKYYNLbcBsyY4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=JkaUkmSM; arc=fail smtp.client-ip=40.107.159.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="JkaUkmSM"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=g4w6QZRqhmW81ZGc8tT31WLcLlMEgztDYwok6SGDhAkHaYusZDnCJ9Q/QHC4J5z5pS9UCMM0L96rGBYDR1NvVbqYpBAjBpLq6B4AUJVl74MhNOga/OLBJy8xP4NUtRXuwZNbmGBL/LkKvLVUBmJMwpuS8M3Hg4T5geQdAH3SFHjsUIzEuefATsm42QVx+pfaAsn3AVchWQBEeHAP/JSThUlTN+zMkLPpXNzsUXAh2TLdPrPzHW/YIw8DYqu+yexcAaRAk93BlcRiMaZjr2vLl1LeN+/l8JdecKO9ncJWOHEDOyA1NxFAmhv0ZYlCix96lcWgXQR5Sllu7Oy0iig6rw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Wlv76N5EuH9P6KSkDdhOV8+L2Ot3b9xQqRotC21u6ac=;
 b=gAxE0fcTNIAPaD0ES/RNFikjcFAC5/izGQyH4+EGNyeFKE+t9nDYhDMuo1o5IP8Uq+sOjwRMpygMWcGFab2jWRCbpA6CAoEBnXJ19m6d7k81xq/Oshmhgp6yhosO0+eLAloMPrxH64X9KgcVBWXou8DCpud9M2Z17auOJExsMVg0PRYf7MSMmllhz7PiDZKmUL0LqNvhzNgfqh4/QMO51O7rDtRmjMCBjV8X7WoN+ZKOjbdvl57/E2EPyF9m0bPasYVVjHpnZuUaIzbsDcT8e4SN6UVFOYQz0ctA9RsryKSQ6doshoa7yAjUNTNCrYSMZWxzHhjwf/0HpyfcjPsL9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Wlv76N5EuH9P6KSkDdhOV8+L2Ot3b9xQqRotC21u6ac=;
 b=JkaUkmSMYj6AEkDIuG24ZUbAgJmarq9320fPqpAOiTsuUpt+aXnha0mQt2THKn9FvJC7CAarAHrN7EJRFJbFfDjtHTQ4uPwAe773iDycFTJdRi/Gx3RzRmLecctYXLHmZMMFKWbeHTBX7mOlUWUHS6BKDiPZwUTdp+FqEZE4m1rzYI+RLt03nt6nYgQ07ctQ8C+N4+aSsEf1isPg/JCI93ZLIi60h8/pvqnXDd6JzIiNdcmHKbBV63kvT0lYVeKeRpt5YLuVLQesdI6DVNoySQgroxUvVxE18Woz3Xl9DMpQmWyy2FYidcEDh+/9m9nQW7EQuWgfAMgpxZmK6qe7bA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9)
 by AS8PR04MB8913.eurprd04.prod.outlook.com (2603:10a6:20b:42c::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.8; Tue, 30 Jun
 2026 15:52:21 +0000
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c]) by GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c%6]) with mapi id 15.21.0159.007; Tue, 30 Jun 2026
 15:52:21 +0000
Date: Tue, 30 Jun 2026 10:52:11 -0500
From: Frank Li <Frank.li@oss.nxp.com>
To: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
	lpieralisi@kernel.org, kwilczynski@kernel.org, mani@kernel.org,
	bhelgaas@google.com, hongxing.zhu@nxp.com, l.stach@pengutronix.de,
	"Sherry Sun (OSS)" <sherry.sun@oss.nxp.com>
Cc: Frank Li <Frank.Li@nxp.com>, imx@lists.linux.dev,
	linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	sherry.sun@nxp.com
Subject: Re: [PATCH V4 0/7] PCI: imx6: Integrate pwrctrl API and update
 device trees
Message-ID: <akPmK--SgmTTAjFw@SMW015318>
References: <20260630060710.3294811-1-sherry.sun@oss.nxp.com>
 <178283343009.3269775.506226017892254973.b4-ty@b4>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <178283343009.3269775.506226017892254973.b4-ty@b4>
X-ClientProxiedBy: PH8P220CA0019.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:510:345::10) To GV2PR04MB11799.eurprd04.prod.outlook.com
 (2603:10a6:150:2cf::9)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB11799:EE_|AS8PR04MB8913:EE_
X-MS-Office365-Filtering-Correlation-Id: eca95978-4c03-4163-a32b-08ded6bf921d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|7416014|376014|19092799006|23010399003|18002099003|22082099003|11063799006|4143699003|56012099006|921020;
X-Microsoft-Antispam-Message-Info:
	woZGRPVj7+NGse2EYVeANnsV5hOLQ8SbTwjcSVKGjzkeRpxwogeNSLFKzFg6nZkBDxR8clkpwDF1f2PiYz1gEG1OkR5MgPwMyruaPct7qFeuHQUfu8NPTTPffK32V7e52l887qQkXIq8gdunlFiEbryFJPU/dhd3/FcOnSLvDubs/ze+xAcDkb7FX9qslrjV74ueSwu5/7+42vKoAOWR0w3Mcrm9wHfBUfthGv2nrZo3CvPoowhRWjeyKEqCtF/vxjk81P8ZpGjslDTmvp+T602T2weiuzF4kwQn1Aeb39BcKgNXaYlaQmothePwf61dRcjxGuZMKtXvxOyVvTdycPTQIzP1AvPVcd54DYg0TUyzfxw1J2ZU1SwnrA9PDmR4I/Zgm3Ir5LFHXP2P34AGjLuP8PC7Sw6fqPvNzSIYOwDCTM3SMAcFNcfaESBGKJnjUMFQx3an4ZQqLm3fv69khJ2VeSCenUljR5POrUqYi9ehLuAETZGyzY7tEIsRRfdbx6Url9o5dqnM8umjbzKi/kN1wGOzvWN8PJBlZdyvBYOTVExAlZiCDk5lEW3XnGxuDMr63ylrnTJQX8VqHvl65QXWWI+EybAYJ2ZAAnTSe4KSwI9b4a7JJKhQ8sGiq8iWuXT+0AqBqGjVLe+KYNugFtVM6R500qJUNtOCFncrzaPDGw5IbU+ZrMdEthNyXjPl+31byXWaf4oGNG9Dj9CxJA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11799.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(19092799006)(23010399003)(18002099003)(22082099003)(11063799006)(4143699003)(56012099006)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?z7RTtSGV8/XZPZ4xs8BJQkSZ9bF2NwNrzMFLJiquKB0Nr0ywCOdegIuVDJKO?=
 =?us-ascii?Q?8EdHO7dxwNfbxyYR6fIHkVzK+QrhsaaozNxuu87whZkGxIbkbV6rKv0l4qEO?=
 =?us-ascii?Q?7cTlSaGCnxElbLpk3xZWLup29iws6ah4dZDFIUjd+pSEVRb7W9J0ixJIn9b4?=
 =?us-ascii?Q?Ea/m03T5fMvrCLH94GddaAl3E6965WsPuMCkLuGr3feBueeA1COo+vLTIoyU?=
 =?us-ascii?Q?gWknCQLglKOeQEW6TD6HVdOsC2cCfaOVYz1BaAR5c0nEnaCNE+IA/htfDHXe?=
 =?us-ascii?Q?9SZr756GMTVEsXirHldopKVhxuMpfr1vjOIFHMM7bwXR/NfPYoCSVW0UOxlO?=
 =?us-ascii?Q?jDFIbHwvSoMX1rpxG3C6SvXF3aay89E+4q1N8OcrTvl2LUTv8e2dDKPSKNe4?=
 =?us-ascii?Q?EmEnhX9lqb7MOwAT9Ce67goQBDVeDgJEVmzNhYdqCUTYMR7pAWP/rh/uupZ5?=
 =?us-ascii?Q?yaFDS5dIeoSmzL2L8muKSdRTeBjfQIUP6naRct8wgfQxpzA8aHKmylib4js1?=
 =?us-ascii?Q?OBg1nDZkaprIEQUwGkZpU8yB9OAykmiJ+KQx2PTpvLBTIululIu0bsl+1yA7?=
 =?us-ascii?Q?OWOFLGDaij7t3oFitZ8SAQM5+AZNIQ2gSirztcgSrXSen7dO9caVdSj+XBaE?=
 =?us-ascii?Q?uZQXWSLEv5Kqw0RbXqA7KIsI7/zPoY6mZZKmoPXL1E+8GoLqT+OAc/ocwHNn?=
 =?us-ascii?Q?QhZRdK6k0UfaC6+OWbXngq9/EXtDRIwE3TW/LzeewxwxOby8bQ71aVDHDlmL?=
 =?us-ascii?Q?u3PIcx1yJjn/LyC2DvcP6xfXGmV48grKvbmU7jzZSU/em886JfZfG/wVeUBR?=
 =?us-ascii?Q?OBWbUyOcg76El2cWOBcs5nNf1+6LIQbCx0Dg4UV1rLjLzKAlRWAaZ4y+x08L?=
 =?us-ascii?Q?q0NnnunnUIpcJLyB4T7N6HrzBAHYhSko+uErDYMbGdmqiqXq/pKqyADPSgt1?=
 =?us-ascii?Q?SFgNoGBiSg7koVeb4MkS5UILZY4ZzIqy048ZrtCynmlGWt0ZKrrC/TpXdEnm?=
 =?us-ascii?Q?XzjgymREJz/oMXdH0oAth0PBlypmKZG1vSG0k1D/OYbRd4uGvAGXBlYR9+xN?=
 =?us-ascii?Q?FsHwt3px268uxWXjXSnH2G4MLGjGrF4tt+eHIp/6PE5QqKQn03+PYvd2GOTu?=
 =?us-ascii?Q?6sAEo9Ww9Y3umYvDu47wr3pFB3TWDgF9sMNd+cFlg7Ht14RRHHOgzXGI4Mqa?=
 =?us-ascii?Q?oqa7wCTr8xn4PJQNPgRuivk+oRP4+hQeMe+YjoX9Uw7K5GTeWZgza3GIXXk1?=
 =?us-ascii?Q?2WbXftb7vOhwtOTfnDrG5IZNS5TG9RwGxY7+Tp55tKyjJar1quSWXKCDFZjB?=
 =?us-ascii?Q?JhzIOlmlM6yj1yocEL4oYMWiYMgu0ocjLwiM81iENTNb1/X92fHsQfDgPLzY?=
 =?us-ascii?Q?kT1/D+CeleAOncMuNzFooggU7/9xXP5q0n0tKPd7chtI5yM6kqbgg5RYAlXT?=
 =?us-ascii?Q?gyFUy17E/gMrf7xw/uPdhbQo4I5Ibn52Y9Hc9YcQDn0cZ4obZTNXkthh0L5G?=
 =?us-ascii?Q?1Ihf0cQE4wtlLMfgDvbqj7sPJX+x2fv98bHKncIwaPVfQ+eZ+HHXCMU+bRMe?=
 =?us-ascii?Q?i8lChujuGR5PCJ1U3HLtp+LXk3U2zaaD+gBI5+rxbpVt+Da7/9WYS373HZqs?=
 =?us-ascii?Q?3OCa3Ngp5KyOxfUBWHvJHCduz0xxptdIpj/tDHHj9Pz/JdbLlvypNiWNROFa?=
 =?us-ascii?Q?n34DmWF2XiKCdNQ0ySnzpHzj74vlE8sUGLgBYT4mGjWmo9T+kJklo+MhGPhD?=
 =?us-ascii?Q?CyFK3Insd1P6UfTAXpiQO4/AB5BlwYBkUI6+D+79aj2sGmOpdiOl?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eca95978-4c03-4163-a32b-08ded6bf921d
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2026 15:52:21.5475
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: m0+2l7YKqfZGL6MSQxdOrhGHMji65dHXEWUd9NYHSfbbHdfQHg1zXf4oW9SJ1xJFkMr2roBHXvR7ketmjmZx0uJ66GY4U148XjOBWupEJ0yud9ZdbfE+wbJ+QNcK/4AS
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8913

On Tue, Jun 30, 2026 at 11:31:10AM -0400, Frank.Li@oss.nxp.com wrote:
> From: Frank Li <Frank.Li@nxp.com>
>
>
> On Tue, 30 Jun 2026 14:07:03 +0800, Sherry Sun (OSS) wrote:
> > From: Sherry Sun <sherry.sun@nxp.com>
> >
> > This series integrates the PCI pwrctrl framework into the pci-imx6
> > driver and updates i.MX EVK board device trees to support it.
> >
> > Patches 2-8 update device trees for i.MX EVK boards which maintained
> > by NXP to move power supply properties from the PCIe controller node
> > to the Root Port child node, which is required for pwrctrl framework.
> > Affected boards:
> > - i.MX6Q/DL SABRESD
> > - i.MX6SX SDB
> > - i.MX8MM EVK
> > - i.MX8MP EVK
> > - i.MX8MQ EVK
> > - i.MX8DXL/QM/QXP EVK
> > - i.MX95 15x15/19x19 EVK
> >
> > [...]
>
> Applied, thanks!
>
> [1/7] arm: dts: imx6qdl-sabresd: Move power supply property to Root Port node
>       commit: b16fded592305f04ae40764f5fa91d5ac6f02a65
> [2/7] arm: dts: imx6sx-sdb: Move power supply property to Root Port node
>       commit: a1af6cf5a6ce526ea41d4686fa14580a48b2e768
> [3/7] arm64: dts: imx8mm-evk: Move power supply property to Root Port node
>       commit: b6a38d70bcbf0893ce5493f3daf0cb19e5102269
> [4/7] arm64: dts: imx8mp-evk: Move power supply properties to Root Port node
>       commit: fde093c386a64c820a704abaab9ffd9ec738cd4d
> [5/7] arm64: dts: imx8mq-evk: Move power supply properties to Root Port node
>       commit: 78610987333b0811a456f9a4782472fad00f4a19
> [6/7] arm64: dts: imx8dxl/qm/qxp: Move power supply properties to Root Port node
>       commit: 240950f3ad76761066ffe399f62670321c1be1f1
> [7/7] arm64: dts: imx95: Move power supply properties to Root Port node
>       commit: 6e53e8b854bc6f8330d07905b73e53ad02aff62b

Sorry, I have to drop again because miss consider back compatible problem.

All old platform, 1 - 6, need keep both under pcie and root port.

iMX95, you can move under root becasue it is new platform, it should be
fine to break compatible since development phase.

Frank


>
> Best regards,
> --
> Frank Li <Frank.Li@nxp.com>
>
