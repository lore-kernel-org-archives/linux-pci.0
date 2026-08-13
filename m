Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013002.outbound.protection.outlook.com [52.101.83.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 401F836CDF3;
	Thu, 13 Aug 2026 20:32:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.2
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786653164; cv=fail; b=B9w+HuP5zUZnJexUeKtxFKpkkm8HZqCQ7bwkiw7FeH2rzQCrBSDA+Ub6z+4HgCglm2EA6pTotDoZ7z/Md3P+bYaUr0iHvg3UPlCRwiU8XY+B0ilJsdLOkt2636mj1GLUngQedaSLBTIo+Eh784uvpvHEc4H9oSdheLGFfGiLvIM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786653164; c=relaxed/simple;
	bh=7DE0qUEsM64GgwBTImcjup6V5F1kC/PkL+Xr1ewQhc4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=obEOD5HfWy3pQt5zLSwUUqvsXXGmsBODiRVp8eY7iSynzCVqLedScBJGjeinKnIAbv06n1DtJSW12NYaC+okNy5jIDCkNcwq+Dztk7k/u/nf/oJ0/sRSywL9mzV7dlG+mvbySoLvjDc/wJfN1PzUF2IjoEtFkk+QICpdDv2MnsE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=hBzzwDtk; arc=fail smtp.client-ip=52.101.83.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="hBzzwDtk"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=E+g8MLuoFmV4BNS8ULAc+gURkUvl0ISnpvCDsL8o9VDrXpoOA15Rqohu2U14j2jQuvWLPGGnency2fSMFKcjQfVPIAYKMeH84nngoiIlpq2j2Vs5Plom9UwwJBFAi1rFHQ5Ys8MKejXH1ZA6/AkohgnTaieE3pWLe+f1fjdErgjz+o1ctDO41/nWaZg7st/C30S/5e/7ZR1J7z8Ap/+1akbDi6e26WGvtmWIK6XZPmL+6hwn5va5XJ8tBLA54Jlhgn3go2RBalQSIgHC4Jc33tKGMgJ/lMqPySUnAqfVwO+OJYV2yvavn42RHyVgNy++d3QlmcdDUZOUoW/FP/z4tg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IkbAita2qOKZ7jKjxoa2BV1QSGeDqunJ37P1KFsIWpQ=;
 b=CZzpdcOawlpcmThzOeVkkusl4bfeCopzHTGQuy/bGgZvbVKqZsSi2pG9TNA5FEto1Syyhpm3bCQQDLmVBjfFWd+TZjOUHDtWbg+IVTmDaQi0Iv9kst+8pdpb7AdZyqExZCArHEz2kkvqbLr/BgkNpKVCndxKdqtHK63rgys4tDlFzNwgouiDsshmCnOg0nip0T/McU7yG4ytd4SKZm7iOwSS+/0LvteoZNaeJE0K3NX1YzUyUeU0MguwmGPbjfh+zxUwrJR2/QInxF2ixEP7C6P/9pBn7Zaw3lSuXD6VoEZwWPBPnqK+jMM3Mlx8H58Y+hmUi8KjDm4ufyUirr58mA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IkbAita2qOKZ7jKjxoa2BV1QSGeDqunJ37P1KFsIWpQ=;
 b=hBzzwDtkkZ++G6ltPYmR+OGeC9j5TkgiYxDIpmTm3G9bC40fiZLnVAXCjzpm++yGRvjl/vYfNCNFYi3ZFNaSPZqqHSb4vqbVIfVsl8IkWHSGIAxatCjiMWvDOp4CHOlPUpNfklNcHPutKmCJbGih9S3BA57/Xe6STL3ex3lDV4lbEjMYYr4O3UD33yCgS1zWIHLjwgSzYejcq0kKKGgVF1+jPRIKpLCPqwXT3LxDa7R5i2D2iQG5H1zoc4kLw/n4rIJ+OC5rqg/nAAuLpFQ5kjNDTtsdhKwdKXdlEibNMmww2DPOE4ZLN1Q2V+XbZKy5V4yZ8ksDdJWwjjDkY7BJjg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9)
 by VI0PR04MB12303.eurprd04.prod.outlook.com (2603:10a6:800:326::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.13; Thu, 13 Aug
 2026 20:32:37 +0000
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c]) by GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c%7]) with mapi id 15.21.0315.014; Thu, 13 Aug 2026
 20:32:37 +0000
Date: Thu, 13 Aug 2026 15:32:27 -0500
From: Frank Li <Frank.li@oss.nxp.com>
To: Koichiro Den <den@valinux.co.jp>
Cc: Manivannan Sadhasivam <mani@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Frank Li <Frank.Li@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Randy Dunlap <rdunlap@infradead.org>, Vinod Koul <vkoul@kernel.org>,
	Jingoo Han <jingoohan1@gmail.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Rob Herring <robh@kernel.org>, Niklas Cassel <cassel@kernel.org>,
	Damien Le Moal <dlemoal@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
	Marek Vasut <marek.vasut+renesas@mailbox.org>,
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
	linux-pci@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org
Subject: Re: [PATCH v7 02/10] PCI: endpoint: Define endpoint DMA BAR metadata
 format
Message-ID: <an4p20Akfc_4y4gq@SMW015318>
References: <20260813063757.3131865-1-den@valinux.co.jp>
 <20260813063757.3131865-3-den@valinux.co.jp>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260813063757.3131865-3-den@valinux.co.jp>
X-ClientProxiedBy: SA1PR02CA0003.namprd02.prod.outlook.com
 (2603:10b6:806:2cf::9) To GV2PR04MB11799.eurprd04.prod.outlook.com
 (2603:10a6:150:2cf::9)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB11799:EE_|VI0PR04MB12303:EE_
X-MS-Office365-Filtering-Correlation-Id: b7bbeba2-7c3d-40f0-4e09-08def97a038b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|19092799006|1800799024|23010399003|7416014|22082099003|18002099003|56012099006|6133799003|10067099003|11063799006|4143699003;
X-Microsoft-Antispam-Message-Info:
	t4j8MLyB2ZHNfp95gPYtRKbVbeS55oix7+OhWvK1VdAi/AFiuYKZEpEjfv8a/rp/H2BNcm5xXwbQgGCV3a5oxuOsW1Em0PEAfgExKF5fZSqCAkoitGobfu83FjdoXG/7qOUowWDHw9k3wrCrp4eiWhDaid9NEwH+mSI2CpjH+9KiIIjXMNDmbhD1rTpziZxv6dxeub+YtUPHSyEwmFMGSi9Tukr7y7kX+eHvCx1fxI3VPqfmhDCd406J9tEe9qd5vCe1Mr7nDWLRh1C69eYQGMiqYHUxlUfcxk1pCQuvtRQH38AzbSztM/lhRtv/zFrT9fiRtucHY7NtEJDVou/xaprrra6ddIqKqiPD0W3wijLb0BfDL47nfoQJll2euhezR3Qw14r+l2Xr9v8YpppQTNv+SPbvN2ff4WypljhU3fQBpGFxFPu1kRmpB924/mdorz/84KOBibaRhHfSAEHNWpEdgtoVQYi85OlaXIRkntjau3K3cdeuLaEopfj6AtXtJRQJZDy7louIiRiAjxxVOS2UzSVkEMKhw+h1oaDLt/XPrbwUkkgqwGQWMdlwyz6/gkZ4/740FzNAIJ+rh1OvFak2i4DGc3ZCAFkMlvsCtof3QxvIHSWWCtXopmuctS2w8I1IqI6kHJKRN2+gKKzR7q4SA3XyTqGRakHLWgdMWq8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11799.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(19092799006)(1800799024)(23010399003)(7416014)(22082099003)(18002099003)(56012099006)(6133799003)(10067099003)(11063799006)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?5Nb0H/ltBdCigwfE4hgNNTxRyU9mhIe0NWuUgYi3mMc0TSFi/F122+3xplF0?=
 =?us-ascii?Q?2FeESZ621a1mjFbtG675RLNttBabDXzytc5PeD1Zjm68tPMjdtSHDHYT6HFr?=
 =?us-ascii?Q?PtE1RLnEWibCBPkWyO2oTd/9r5zRo2RL07uJjBivNUl7RX7hYRbUnKOlCsuJ?=
 =?us-ascii?Q?zOdgXtYVNQc6s4iMDVBO9lXBlkhOsd1Ai0+5kkjaxP1LuS6J32ndx01FMQ6E?=
 =?us-ascii?Q?jM1Z5YrzO5x73gKABaI3BIOXTvldACpcFrVKueKrHfecwctfr7dH5luaXBwB?=
 =?us-ascii?Q?JkePwJw5GNaPknUQzmT0kNRxedaL4DmK3XqeEkRNozQpmGK0bKFXyRSpudgu?=
 =?us-ascii?Q?Bj2JFca2n+ezPhvp0PjWTrN2ncSabZDCy813eDsOY8TskOEhQl30COOa/L6g?=
 =?us-ascii?Q?o25WU54gITboWoZ2t6wpTyN5VW0uDET4qoM87O28XoqBNc+JUY3fSpjrOjgh?=
 =?us-ascii?Q?uM5MxUWog2VH8Mlntw4GQaztLy9SRXDHKd61xjpu4nZEM2D6DuR+DB/bSIkb?=
 =?us-ascii?Q?tIri+MX3/z9QHy1vcZZCJLmvHd9gr4qYvssL5V8gwBeaw9yil9zb9kUQtkNH?=
 =?us-ascii?Q?0/SD/3C/8ZYfcidetsv2sxEdEqEEPsTv2syr4EzPyiSAvmf1X8E6urWiXCwd?=
 =?us-ascii?Q?UtQhgHV0JhxwAXCArL7lZYcn0UCvQDfwgPEOJSSlpnw++NXuy/yoDjG1qLnS?=
 =?us-ascii?Q?RfWqDrUd+NzEbw6B6ZrYIuwnC4cJWNDiP62GTzX8JW/5f+LlwU/0ue6aqhk0?=
 =?us-ascii?Q?YIBanhnOV6Gf7yxmYzwewfZCVxv6KpyowDDpSL65BJpX1jhJRRU6MScmS23V?=
 =?us-ascii?Q?s+b4N/Sfdvej4B6xO25uuMFc84zrYeGRumEqcfPDjv0u71dSFWBBKW2L74K1?=
 =?us-ascii?Q?5CGoobfcayMheyGVosWVyReAoujU6LVqlvY8EXqxNT/g7r+XsEZD/eFLV2s/?=
 =?us-ascii?Q?6FZJq5NhEuGrrYShgVK93bE4CjKQLgCAvD0YIqvwP+fO9MwMZjgNSSIbBaXz?=
 =?us-ascii?Q?FlqZ6t0PoQjv73Blat+fOG5/IpLOwhzg58FVFyds4JwV9P1mStIK5Z47Cutr?=
 =?us-ascii?Q?oQE8OnrXORb1omlUC/iKrTyEVOd0zO8aABpAnbqZAXfmyHWYeMDun1KOHh97?=
 =?us-ascii?Q?BpcwnBBeOyXpCLX0V3IoT6norkvwuE2dfHvFMj52LYDmWN2iUixhXs0wajjG?=
 =?us-ascii?Q?zgIV6mKnmtFpDF9ttNYm/OFpyrTo0jIlex1/KjIiSMLLqXM3cnAPMUWatNYk?=
 =?us-ascii?Q?YS2n/uExcIbXO73KzGbuEZ25l2ri1afm2I3+XiI2btCxJy4s4zuAGuG9Fc7/?=
 =?us-ascii?Q?hna9OTDS2vNqcGIWIi0ESw6ybkdAJt71lMSuB9Ui0e0DajX7LD1e0CkZY9WT?=
 =?us-ascii?Q?x8Cq8+oXRBrT8Z+NDVSMNdRj7Oi2g3i1zdbvlYGjtminUxt2NwaViOcRd2qI?=
 =?us-ascii?Q?k+6q0pcp615A8Hchc/BJCnGU3kCptwMCR4dCrkWbLERBrMVgu7VoCfOkxI+5?=
 =?us-ascii?Q?RWOpTj0DnAP/iPvR3KULxxlxuMsgpBAYbbRFyVEbWNFGPhKdcHfCIC3Leqdy?=
 =?us-ascii?Q?GQTPg10EtHlzjAqv789l/WQGPputDCqv15LxRWnWGNwCshzPmnxcD1coHxjh?=
 =?us-ascii?Q?xDqYQZ6XRGoXrAo5grOQLOnDe6dTwSx1QmNl8rhLYIMY5+luv2wT47xG/SHQ?=
 =?us-ascii?Q?xsO279Gq5bdAgyvW7EEs1j7CvZkoZBxefsqcX6XfKt2abik19zQh0xS1pyP0?=
 =?us-ascii?Q?dClWBaQo5YgP/8Rhzy4oh33DQpuf+XonrLMkLG23BOQd9RyH/tMy?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b7bbeba2-7c3d-40f0-4e09-08def97a038b
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2026 20:32:37.6036
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pUwVzljex0Pz4EfeVcw1giHESKDcMqReMf+bsB/PaTC2+c1ALkxVuyl+WKVOYNbhTxxC7TprlfbCI0C9Gk+bZPZIWw4vqKKPD9XI3E6uqEjrnB6CK6fcqvx4GXIme6DB
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB12303

On Thu, Aug 13, 2026 at 03:37:49PM +0900, Koichiro Den wrote:
> Define the BAR-resident metadata format used by endpoint functions that
> expose an endpoint-integrated DMA controller to the host.
>
> A VSEC-based discovery scheme would be a natural fit, and existing
> dw-edma-pcie providers such as Synopsys EDDA and AMD (Xilinx) MDB/CPM6
> already use VSECs for DMA discovery. However, some endpoint controllers
> cannot provide enough writable configuration-space storage for a
> complete, controller-defined payload. Keep the extensible metadata in a
> BAR instead, where the endpoint function controls the layout and size.
>
> The format describes the DMA register window, exported channel counts,
> descriptor windows, optional auxiliary windows, endpoint-local descriptor
> and auxiliary DMA addresses, and a ready bit that tells the host when the
> described BAR windows are usable. Channel entries keep the auxiliary
> window optional so layouts that need a separate data or auxiliary aperture
> can describe it without a format bump.
>
> Signed-off-by: Koichiro Den <den@valinux.co.jp>
> ---
> Changes in v7:
>   - Move HOST_REQ to a separate 32-bit word. (Frank)
>   - Increase the metadata header length to 0x20 accordingly.
>
>  MAINTAINERS                |   1 +
>  include/linux/pci-ep-dma.h | 175 +++++++++++++++++++++++++++++++++++++
>  2 files changed, 176 insertions(+)
>  create mode 100644 include/linux/pci-ep-dma.h
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 15c7dc516f7c..d330178ac1f7 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -20990,6 +20990,7 @@ F:	Documentation/PCI/endpoint/*
>  F:	Documentation/misc-devices/pci-endpoint-test.rst
>  F:	drivers/misc/pci_endpoint_test.c
>  F:	drivers/pci/endpoint/
> +F:	include/linux/pci-ep-dma.h
>  F:	tools/testing/selftests/pci_endpoint/
>
>  PCI ENHANCED ERROR HANDLING (EEH) FOR POWERPC
> diff --git a/include/linux/pci-ep-dma.h b/include/linux/pci-ep-dma.h
> new file mode 100644
> index 000000000000..03b48ee7669e
> --- /dev/null
> +++ b/include/linux/pci-ep-dma.h
> @@ -0,0 +1,175 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef __LINUX_PCI_EP_DMA_H
> +#define __LINUX_PCI_EP_DMA_H
> +
> +#include <linux/bits.h>
> +
> +/*
> + * BAR metadata format used by PCI endpoint functions that expose an
> + * endpoint-integrated DMA controller to a PCI host.
> + *
> + * Offsets are relative to the beginning of the metadata blob. Multi-byte
> + * fields are little-endian. The blob is normally placed at offset 0 of a
> + * function BAR selected by the endpoint function and discovered by the host
> + * driver using device-specific policy. Other data in the same BAR, such as a
> + * standard MSI-X table or PBA, is outside this metadata format.
> + *
> + *          31                                                             0
> + *          +---------------------------------------------------------------+
> + * +0x000   | metadata magic                                                |
> + *          +---------------------------------------------------------------+
> + *          31                            16 15            8 7             0
> + *          +-------------------------------+---------------+---------------+
> + * +0x004   | metadata length               | reserved      | revision      |
> + *          +-------------------------------+---------------+---------------+
> + *          31 30         27 26          19 18          11 10          3 2 0
> + *          +--+------------+--------------+--------------+-------------+---+
> + * +0x008   |R | reserved   | ch entry size| RD count     | WR count    |BAR|
> + *          +--+------------+--------------+--------------+-------------+---+
> + * +0x00c   | register window offset[31:0]                                  |
> + *          +---------------------------------------------------------------+
> + * +0x010   | register window offset[63:32]                                 |
> + *          +---------------------------------------------------------------+
> + *          31                            16 15            8 7              0
> + *          +-------------------------------+---------------+---------------+
> + * +0x014   | reserved                      | layout data   | layout        |
> + *          +-------------------------------+---------------+---------------+
> + * +0x018   | register window size                                          |
> + *          +---------------------------------------------------------------+
> + *          31                                                           1 0
> + *          +-------------------------------------------------------------+-+
> + * +0x01c   | reserved                                                    |H|
> + *          +-------------------------------------------------------------+-+
> + * +0x020   | write table                                                   |
> + *          | ( channel table entries #0 ~ #N )                             |
> + *          +---------------------------------------------------------------+
> + *          | read table                                                    |
> + *          | ( channel table entries #0 ~ #N )                             |
> + *          +---------------------------------------------------------------+
> + *
> + *          metadata magic: PCI_EP_DMA_METADATA_MAGIC.
> + *          metadata length: byte size of the whole metadata blob. The value
> + *                           must fit in PCI_EP_DMA_METADATA_HDR_LEN_FIELD and
> + *                           in the BAR allocation that contains the metadata.
> + *          revision: metadata format revision.
> + *          R: ready bit. Set only by the endpoint after all fields and BAR
> + *             windows described by this metadata have been programmed and can
> + *             be used by the host. The host must not consume the windows
> + *             before observing this bit.
> + *          H: host-request bit. Set only by the host driver after it has found
> + *             this metadata. The endpoint may use this as the trigger to
> + *             program DMA window BAR subrange mappings, and may clear it while
> + *             revoking R during teardown or reinitialization.

EPF driver should known which DMA channel will export to host. So data
structure should be embeded into bar0 as Niklas's suggestion.

Frank

> + *          ch entry size: byte stride between consecutive channel table
> + *                         entries. Revision 1 requires at least
> + *                         PCI_EP_DMA_METADATA_CH_ENTRY_SIZE bytes.
> + *          RD count: number of exposed RC-to-endpoint DMA read channels and
> + *                    read channel-table entries.
> + *          WR count: number of exposed endpoint-to-RC DMA write channels and
> + *                    write channel-table entries.
> + *          BAR: BAR that contains the DMA controller register window.
> + *          register window offset: BAR-local byte offset of the DMA controller
> + *                                  register window in BAR.
> + *          register window size: DMA controller register window size in bytes.
> + *          layout: DMA controller register layout identifier.
> + *          layout data: layout-specific data. For
> + *                       PCI_EP_DMA_METADATA_REG_LAYOUT_DW_EDMA this is the
> + *                       DesignWare eDMA/HDMA map format.
> + *          write table: starts at PCI_EP_DMA_METADATA_HDR_LEN if write channel
> + *                       count is non-zero.
> + *          read table: starts at PCI_EP_DMA_METADATA_HDR_LEN plus the write
> + *                      table size if read channel count is non-zero.
> + *          reserved fields and bits: write zero and ignore on read.
> + *
> + *
> + * Channel table entry:
> + *
> + *          31                 17 16 15 14   12 11 10     8 7              0
> + *          +--------------------+--+--+-------+--+--------+----------------+
> + * +0x000   | reserved           |A |rs|aux BAR|rs|desc BAR|hardware channel|
> + *          +--------------------+--+--+-------+--+--------+----------------+
> + * +0x004   | descriptor window BAR offset[31:0]                            |
> + *          +---------------------------------------------------------------+
> + * +0x008   | descriptor window BAR offset[63:32]                           |
> + *          +---------------------------------------------------------------+
> + * +0x00c   | descriptor window size                                        |
> + *          +---------------------------------------------------------------+
> + * +0x010   | descriptor DMA address[31:0]                                  |
> + *          +---------------------------------------------------------------+
> + * +0x014   | descriptor DMA address[63:32]                                 |
> + *          +---------------------------------------------------------------+
> + * +0x018   | auxiliary window BAR offset[31:0]                             |
> + *          +---------------------------------------------------------------+
> + * +0x01c   | auxiliary window BAR offset[63:32]                            |
> + *          +---------------------------------------------------------------+
> + * +0x020   | auxiliary window size                                         |
> + *          +---------------------------------------------------------------+
> + * +0x024   | auxiliary DMA address[31:0]                                   |
> + *          +---------------------------------------------------------------+
> + * +0x028   | auxiliary DMA address[63:32]                                  |
> + *          +---------------------------------------------------------------+
> + *
> + *          A: auxiliary-window-valid bit. If clear, aux BAR and auxiliary
> + *             window fields are ignored.
> + *          aux BAR: BAR that contains the optional auxiliary window.
> + *          desc BAR: BAR that contains the descriptor window.
> + *          hardware channel: DMA controller's hardware channel number.
> + *                            Revision 1 entries are currently consumed in dense
> + *                            0-based order.
> + *          descriptor window BAR offset: BAR-local byte offset of the
> + *                                        descriptor window in desc BAR.
> + *          descriptor window size: descriptor window size in bytes.
> + *          descriptor DMA address: endpoint-local address used by the DMA
> + *                                  controller to fetch descriptors.
> + *          auxiliary window BAR offset: BAR-local byte offset of the auxiliary
> + *                                       window in aux BAR.
> + *          auxiliary window size: auxiliary window size in bytes.
> + *          auxiliary DMA address: endpoint-local address corresponding to the
> + *                                 auxiliary window.
> + *          reserved fields and bits: write zero and ignore on read.
> + */
> +#define PCI_EP_DMA_METADATA_MAGIC		0x4d444550 /* "PEDM" */
> +#define PCI_EP_DMA_METADATA_REV			0x1
> +
> +#define PCI_EP_DMA_METADATA_HDR_LEN		0x20
> +
> +#define PCI_EP_DMA_METADATA_HDR			0x04
> +#define  PCI_EP_DMA_METADATA_HDR_REV		GENMASK(7, 0)
> +#define  PCI_EP_DMA_METADATA_HDR_LEN_FIELD	GENMASK(31, 16)
> +
> +#define PCI_EP_DMA_METADATA_CTRL		0x08
> +#define  PCI_EP_DMA_METADATA_CTRL_REG_BAR	GENMASK(2, 0)
> +#define  PCI_EP_DMA_METADATA_CTRL_WR_CH_COUNT	GENMASK(10, 3)
> +#define  PCI_EP_DMA_METADATA_CTRL_RD_CH_COUNT	GENMASK(18, 11)
> +#define  PCI_EP_DMA_METADATA_CTRL_CH_ENTRY_SIZE	GENMASK(26, 19)
> +#define  PCI_EP_DMA_METADATA_CTRL_READY		BIT(31)
> +
> +#define PCI_EP_DMA_METADATA_REG_OFF_LO		0x0c
> +#define PCI_EP_DMA_METADATA_REG_OFF_HI		0x10
> +#define PCI_EP_DMA_METADATA_REG_LAYOUT		0x14
> +#define  PCI_EP_DMA_METADATA_REG_LAYOUT_ID	GENMASK(7, 0)
> +#define  PCI_EP_DMA_METADATA_REG_LAYOUT_DATA	GENMASK(15, 8)
> +#define PCI_EP_DMA_METADATA_REG_SIZE		0x18
> +#define PCI_EP_DMA_METADATA_HOST_CTRL		0x1c
> +#define  PCI_EP_DMA_METADATA_HOST_CTRL_REQ	BIT(0)
> +
> +#define PCI_EP_DMA_METADATA_REG_LAYOUT_DW_EDMA	0x1
> +
> +#define PCI_EP_DMA_METADATA_CH_ENTRY_SIZE	0x2c
> +#define PCI_EP_DMA_METADATA_CH_CTRL		0x00
> +#define  PCI_EP_DMA_METADATA_CH_CTRL_HW_CH	GENMASK(7, 0)
> +#define  PCI_EP_DMA_METADATA_CH_CTRL_DESC_BAR	GENMASK(10, 8)
> +#define  PCI_EP_DMA_METADATA_CH_CTRL_AUX_BAR	GENMASK(14, 12)
> +#define  PCI_EP_DMA_METADATA_CH_CTRL_AUX_VALID	BIT(16)
> +#define PCI_EP_DMA_METADATA_CH_DESC_OFF_LO	0x04
> +#define PCI_EP_DMA_METADATA_CH_DESC_OFF_HI	0x08
> +#define PCI_EP_DMA_METADATA_CH_DESC_SIZE	0x0c
> +#define PCI_EP_DMA_METADATA_CH_DESC_ADDR_LO	0x10
> +#define PCI_EP_DMA_METADATA_CH_DESC_ADDR_HI	0x14
> +#define PCI_EP_DMA_METADATA_CH_AUX_OFF_LO	0x18
> +#define PCI_EP_DMA_METADATA_CH_AUX_OFF_HI	0x1c
> +#define PCI_EP_DMA_METADATA_CH_AUX_SIZE		0x20
> +#define PCI_EP_DMA_METADATA_CH_AUX_ADDR_LO	0x24
> +#define PCI_EP_DMA_METADATA_CH_AUX_ADDR_HI	0x28
> +
> +#endif /* __LINUX_PCI_EP_DMA_H */
> --
> 2.51.0
>
