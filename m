Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013041.outbound.protection.outlook.com [40.107.162.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 053F02877DA;
	Wed,  1 Jul 2026 03:26:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782876367; cv=fail; b=tfI69t6RgBHQHO/FfimDdJEcy6vBg6qsYdIyfxL02h88ofD9da0wt0jPmdCOS6aHdIDmmciPuuFtYFWPcEV7HWHZ1s1PVknZlPrRSE30SzHyriwlXij0zQ6iy/sMAW6ZzJxl9qA+iIIF2KDc0n1teK8/pqeXihkUMfkdxL3JhhY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782876367; c=relaxed/simple;
	bh=XLy3qjPv8Go7LvXzVuy8LIwTF0TG7YDH8FkYsq7FiII=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=QqJJyIkogLnPc1P67dO4ZSyRdPs+iB6sCTdekkeeF5X1U57lLmoOp5GaLrLKc8bPMObhc7vl1dV0Kb/UZaI63XfrRXD1Rtf9j5fbghPMlBraBEJJaypJ2dwNkXGim5BJHjAIWKTsWqNHIVBYqoh/+JhzEwM2nyDpx3U0HmlrQUs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=WPHv6WD2; arc=fail smtp.client-ip=40.107.162.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="WPHv6WD2"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UMP5adjxJjtBxpk/9/ajZI/nmnp8LegS2vyd6Hrd1ahjNRO+GmBgna1qOQYDeu1nGa4blSugG97NuIiF1wnXvBMZBBqwzoDPt94HngINr09M25vqQqaulfY1L3KgIhYnDW/380boX07twMgCP1d/JWwwAJZVIGWy0wZPMZlwUG3jNyQakHgBIQ29k86BjHEXtcZr6tW5Jh/7ssVgHdXpZKX5RSSiPUf2sD7thzj8OqV9BpLWx9kDJMObsQKxdDVIEpCCMdJd0Ijee7mSMI/7esUU30YxgmnibCA+X7pCbtemobNRnjgEo5gvwhCx5FkKWeFvJJ3T3yEz9Di2qVNqaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OBF9H7nyflDWuazaviMuaqLXo9K6RlR60mO/pRp9JKI=;
 b=iktjTISlYQsvm9+ouVxKNWI3+OBBo8iZtjaGdyMk+4ZgAPOAlLwj80jPJWIGOxb01l/YYAZAiSr+uE8HThgRS/G4Tv3WaHo7q/diC5ZRoQ4fl13jXbWrR3HqZ1L0kd1CiASJ8pEbTH/m6+eP4ikI8ZjwSZDgxr64AuTtux61lwlhCmVnrHvCCyBv86VrLjoi9n/wn/jKuTvTVXT6ylWKmOwLYMGBX0J9U3Cuso2Ng//datX0UQOarVB9cbduvCtUsM9htMwSFePk+BR2m9XX/VQNdCD2Xmz2EJv4EsyDZkz0oHYaQw0Idd0zG03/pwugo/RO0dHJfpjf/Ihs4U2Icw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OBF9H7nyflDWuazaviMuaqLXo9K6RlR60mO/pRp9JKI=;
 b=WPHv6WD25mnw1FnA2G0jwtZmDfXYkR9qd0/L9fRRket+VKW+e4/KPSlI/onN2MnSEWIPkeo+5BQfSIDKrQgxBka5u5D7QaGV1UGDejVyJa3gDlxVj0JCh+f3Kw8mEIix9aFVu8F1nu4aPZcb7td65LHhW+nj0U4J8KAi1GDM8ATEGh3ucwFV7mg7dUXwLI2U9J8tdneZHgiNDBT3nUJkJmXsNrQUr9CVFCZhhnksYo0N+i+CuU/2/QouQYM9Riwr4YFsMuBQNx+W8EqqVpSav4Wx78dkxsxQec1rfxXQQYuZofWgZn6TwVB9AmDvlp67uwEA2nCEXytZvO4C2TBMxA==
Received: from VI0PR04MB12114.eurprd04.prod.outlook.com
 (2603:10a6:800:315::13) by GVXPR04MB10430.eurprd04.prod.outlook.com
 (2603:10a6:150:1e2::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.8; Wed, 1 Jul 2026
 03:26:01 +0000
Received: from VI0PR04MB12114.eurprd04.prod.outlook.com
 ([fe80::feda:fd0e:147f:f994]) by VI0PR04MB12114.eurprd04.prod.outlook.com
 ([fe80::feda:fd0e:147f:f994%6]) with mapi id 15.21.0159.015; Wed, 1 Jul 2026
 03:26:01 +0000
From: Sherry Sun <sherry.sun@nxp.com>
To: Arnd Bergmann <arnd@kernel.org>, Lorenzo Pieralisi
	<lpieralisi@kernel.org>, =?iso-8859-2?Q?Krzysztof_Wilczy=F1ski?=
	<kwilczynski@kernel.org>, Manivannan Sadhasivam <mani@kernel.org>, Bjorn
 Helgaas <bhelgaas@google.com>
CC: Arnd Bergmann <arnd@arndb.de>, Rob Herring <robh@kernel.org>, Frank Li
	<frank.li@nxp.com>, "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] PCI: imx6: fix building against pwrctrl
Thread-Topic: [PATCH] PCI: imx6: fix building against pwrctrl
Thread-Index: AQHc/y/8Ugt8XQoFz0erM0/48CYIxbZYE7Qw
Date: Wed, 1 Jul 2026 03:26:00 +0000
Message-ID:
 <VI0PR04MB121148B67F7667BDD9C6845ED92F62@VI0PR04MB12114.eurprd04.prod.outlook.com>
References: <20260618143629.2035247-1-arnd@kernel.org>
In-Reply-To: <20260618143629.2035247-1-arnd@kernel.org>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: VI0PR04MB12114:EE_|GVXPR04MB10430:EE_
x-ms-office365-filtering-correlation-id: 5b098630-c174-4235-3cd5-08ded7207979
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|23010399003|376014|19092799006|366016|56012099006|11063799006|4133799003|38070700021|22082099003|18002099003;
x-microsoft-antispam-message-info:
 94CwjuyVZDGDH0ALVKIVXnqDmpgdGseXs9OnDm9WQ2RQI3fdVBFhmF3kLbYBR8BkKc90TdQPlBp4mPNPm16fhmXxTQ1TObhFS+EG0XXd2L/pJFjmibUCupqreGc/QZS5g9DGfatQO6+2BzKUm1MW9gMq6CLvjo/6HEuGAjegO55ztiZ1oMSzr1jKmoSviHzFFeamMAlWRSwNi2SEGvb0wplRbQ8UfYAc9prS9AP5NiBCbne+eBLUTrV5H3e/3sQtH9drCIPylnrCtfPd+WW9VO303ngfojd1zoWq6Q3M8mXksyeMIXxCDU5ZzjOXwiJaVep3wHMzUgOQ+Td3f/g5MJAi6Dbz0HUNDhuW6NSCUJ/Rk3j9d5DIVCTsJ9MpQ0JS+JzB6h3yPaSxIjJ350Lq6TUkbBGbSRgw7ILJPtIOypWfINkVVcBCsLrSG+l38zSRW8iuxjjo/2MyzG5j9zY0lHiULMwADyZ0o/BffXb1JF8qRcpLtbfFClYRwzcppgW/4+c3TXUEFVKcreZ6+CldJTX2l0xXmevQawWXSCmr5IdmQqgoLCHE2X6zT5B5nF9am8KCzxpS11AMetzeh/df2BKGMM+SLbkxUsdRBeM2g31QUrCYtkaC3w6KvIJBewI42fC2t38YBgOxYka1Tq/cLu7WyQfsjsGfnvgA+J5/avA=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI0PR04MB12114.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(376014)(19092799006)(366016)(56012099006)(11063799006)(4133799003)(38070700021)(22082099003)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-2?Q?wI5Z/PO4kbIVAZE5nmwXlPMjAX4yC660ZMw0izs1MfRATjRU8BCmwzlg6x?=
 =?iso-8859-2?Q?iCZtvs9HdjLJME7+hRmVs8dZ1Ez8+XQ35+K2d+lvmpcSW+1FWnfHSW8kSK?=
 =?iso-8859-2?Q?Y5Raatm5TIrgAMOeG/+szsCJqFoqoK9ZzkgtvwlYSfTxBn8LX0h0xOvB2z?=
 =?iso-8859-2?Q?RAWb7cHTVApwQX/xNVaJie8i+EzGW9tpcG89PURNEB2d2gDMGykeGtF1a0?=
 =?iso-8859-2?Q?FrBWvesNfsXPwk0sYVGaSZxIADt3bRiLLW+lYADI8++oPAme6ky9TRoFjG?=
 =?iso-8859-2?Q?1GAt0SXSPby6X1zoWrdv2SlwHO6N2h9rRkPVH3gcXy5qUMYnqkj6kMzSYG?=
 =?iso-8859-2?Q?4WfhETgtIC7N9TxhIyjGk6BTHuLizCt3P0eLMu4AN5zo1h+WLynGphGHs/?=
 =?iso-8859-2?Q?5NkhesUmpe7DVQAsWM6BqNiQr9Kvvby28B75euriqseFCxDzjeUglMKvyq?=
 =?iso-8859-2?Q?3WoATVSty44JfI0w68OD8axc8j2XVzGihyCTblaBX3nxIXA27zSoDrWRt+?=
 =?iso-8859-2?Q?1wMcXU3INn7Ee88QUWBrcuS7x4iLXVu2qzHTPbRQRVJdw1xf/ZgxtuGDhU?=
 =?iso-8859-2?Q?v3N5DfSlsKmZWY4VmCnNqGjy0fy8Z5kD5A50l/DKTUZie3k2rOX76Ke8dk?=
 =?iso-8859-2?Q?L+iw8RiVq7zTUZSa4W0wOSB3N3o1WpaKzrIpx1NcBNGnY3IMa+hNqbturX?=
 =?iso-8859-2?Q?MKtvZj9eq8okEkidtiTjKtcuzKGMyiTqo+v/RCZDoSX+737loe3hv5I7zT?=
 =?iso-8859-2?Q?oyx1NiN6mJh821g5PJE31MWp+SY0FjdKkk7LzRayrBeoRPucd7UdtQ6NvV?=
 =?iso-8859-2?Q?oJFcE9be1LWwddA0aJfzL/K5xldsGMQl1lN56b8jwQWuXmDF4fVpSWlf7W?=
 =?iso-8859-2?Q?HFRGfXJ3oD4CDQIo3uw+x2KfsuIu+0RahwLCvue64OY6AyP9DFUBZV1teG?=
 =?iso-8859-2?Q?6iD3WqnhKZhnWrJ0J4h3xhj38laB6SLZvf/EOGGz0dhKoaOpYhsMdcsVkJ?=
 =?iso-8859-2?Q?9v5fbhQu4m8M8LeXN+PI6ze1sdIOLImSNYMVggr2Gg/3WEiGNKZ5nY+ef4?=
 =?iso-8859-2?Q?9nERrTvdWctmkrNLl3EQvYtJY17/AkE2IBEoV1rJy8vHwW0iBNEV+hnajj?=
 =?iso-8859-2?Q?CiMbtLeKzA6tG57Bv5Jax4NcRM5t4eUOe8VM8rJ+NfwmVuoAufm5khwbkS?=
 =?iso-8859-2?Q?JO1xyfNPKyvBEjAOzS9sucN8udk0pQsQ+R3em/iiUIv8v7VYhWb26YtO8Y?=
 =?iso-8859-2?Q?XlfvCEc+KM/4w4NU+APQ90uuwOAAYbba4+ru5+l2nWpSr9BsuvMNqY+rBb?=
 =?iso-8859-2?Q?CM7+OgC1HhLsBqL+T5qbrDQ41SWN4k2QTtfdafM7OAWvsyXEQRWrInSrN1?=
 =?iso-8859-2?Q?PbdkfQtJtFbvn+sunDjsB3/cbfeR10sMW09TLilnHv6ByQway2RkeK3PG1?=
 =?iso-8859-2?Q?zTA8I1+S/WZTvH8EtL+cfBxJ9jwMpQ7HJJAU4gT8ex7aBwoGCjRjXvV7+1?=
 =?iso-8859-2?Q?7ZfL+I1Z8hnIZ5Fs5h3GWRn2jTPIISicgMlXLSmD2NlvUQZRbaxHhj03YU?=
 =?iso-8859-2?Q?WsOsmz39qGKdzarRBCdqrjP0QAXLvqkmNh7qMLlYS+00p01pj7oZAgOo6N?=
 =?iso-8859-2?Q?3oiNUbtbmXhCSYngXAxvnj6M+3B4yG/mqqUHXSo/xmbNCEoe3lIPWKasLZ?=
 =?iso-8859-2?Q?CrrmkJfDSp3JMTRT/DUZwc2Os3Z41xkTog8TWQgFW3LZWKV4diKV+XInuc?=
 =?iso-8859-2?Q?UabE6xP4xQDVyds3RB2UTBnG+Rt+TxSBBGLJrJED85hGO8?=
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: VI0PR04MB12114.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b098630-c174-4235-3cd5-08ded7207979
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Jul 2026 03:26:00.9481
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4VarN6Y8lZxE+Q5kOP0hh0VdOPw+/vvcvm5k9Phliq+cNanPHq/lYPDMNz7it1yWaJHBvk4ED1b3s44+PEkKtQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB10430

> Subject: [PATCH] PCI: imx6: fix building against pwrctrl
>
> From: Arnd Bergmann <arnd@arndb.de>
>
> When endpoint mode is built-in, but pwrctrl support is in a loadable modu=
le,
> the imx driver fails to build because the unused host support still tries=
 to link
> against pwrctrl:
>
> ld.lld: error: undefined symbol: pci_pwrctrl_power_off_devices
> >>> referenced by pci-imx6.c:1988 (drivers/pci/controller/dwc/pci-
> imx6.c:1988)
> >>>
> >>> drivers/pci/controller/dwc/pci-imx6.o:(imx_pcie_shutdown) in archive
> >>> vmlinux.a
>
> Add one more select for this.
>

Please add fixes tag:
Fixes: 85c1fcfa740d ("PCI: imx6: Integrate new pwrctrl API")
Then, Reviewed-by: Sherry Sun <sherry.sun@nxp.com>

Best Regards
Sherry

> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ----
> There is already another fix pending that I sent earlier, see
> https://lore.ke/
> rnel.org%2Fall%2FajF_LyjOnINAHvA3%40lizhi-Precision-Tower-
> 5810%2F&data=3D05%7C02%7Csherry.sun%40nxp.com%7C3e0137032b804a37
> de3908decd471c75%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0%7C6
> 39173902484468360%7CUnknown%7CTWFpbGZsb3d8eyJFbXB0eU1hcGkiOn
> RydWUsIlYiOiIwLjAuMDAwMCIsIlAiOiJXaW4zMiIsIkFOIjoiTWFpbCIsIldUIjoyfQ
> %3D%3D%7C0%7C%7C%7C&sdata=3DEoEuSedEedto7cGxbHL%2Fid4wcs6%2FTi
> BKI1sewlNdt%2FU%3D&reserved=3D0
>
> If you prefer a combined patch, I can send an updated version, or you can=
 just
> fold the two into one commit when applying.
> ---
>  drivers/pci/controller/dwc/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/pci/controller/dwc/Kconfig
> b/drivers/pci/controller/dwc/Kconfig
> index 7d49027c6736..49a7a2c50ca1 100644
> --- a/drivers/pci/controller/dwc/Kconfig
> +++ b/drivers/pci/controller/dwc/Kconfig
> @@ -128,6 +128,7 @@ config PCI_IMX6_EP
>       select PCIE_DW_EP
>       select PCI_HOST_COMMON
>       select PCI_IMX6
> +     select PCI_PWRCTRL_GENERIC
>       help
>         Enables support for the PCIe controller in the i.MX SoCs to
>         work in endpoint mode. The PCI controller on i.MX is based
> --
> 2.39.5
>

