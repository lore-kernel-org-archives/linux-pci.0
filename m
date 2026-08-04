Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011069.outbound.protection.outlook.com [52.101.65.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E9D43CB562;
	Tue,  4 Aug 2026 15:24:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785857051; cv=fail; b=SeH3EEocjv1kGUoA7MltH65ZRjOHI9xONL2nQUC7qfAjhU1pmpUDxKDNpv6JKYCMk4S3/Fl7GPzmeaifD+3NGVkE7aUyVySxX+AjY8k9kG7oqcI0J70ANjnLGfM9XBMhhhfAoZs3YkIntJXTiZFfA6s4EBFZOxzfFcwxfPXi5n4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785857051; c=relaxed/simple;
	bh=4aBUBIcU4622io+EnrU8ROYTp95mmpC4bF0cP+9S3Uw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=p5gDOb6y2KWRN9TdxnzQhbbZhKirpcq6TelHYH3OZX54RXdae+654UF4WghnvNvkpKEMexPKbPzRzjAFfrw/Z9l1uo5QoIAYy4aYvBKZ4ZLeZHZmA5i3pVyfSdKEKbnsi8GY+Z7aC9sl6yGGerbbKK4vkjdBzfamaej+ARvMib4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=EsrK5FKH; arc=fail smtp.client-ip=52.101.65.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="EsrK5FKH"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QsNgsBrefhiWnNT6ex5LsTUMx4Sz7JzIzLHpmYwgG/8KkH5ryz1pToZAVO4zZDzHAAzfTm6hUcL5mhES/1P8YNcMwjOruQYZ3rW2k3tAr1CcYFvs5rEGB9aMLrv54Lei4+pTVT9rz2Wqj1N/uxIvAuqCf+8+cxUJT+UC+zZBjrPvVEulHlMZgEaMd3I2Ov/901OdpN7PYNzQCminkycRZ9Zkcn79b91Ja8YbOSMJ42V8tO6EE/dOWruVwk8DUgF+Rsf6aRESk3gKU6MhsDkenEzH0jvRsIFJQIUVFgj9e0jo1IlmRZm+fzUFpdWXzXUtvUdWB7Nw7VJqeQv4RYfPjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HHqoXX3v71SMVVLws/mdpyV2JS5hW8n41JcByvTcTrc=;
 b=qQmNRmd0OVWGQhAnH1LUJyB5idObNG28avpYAGMhLuZ3PCsRdilOyh5Ka1sM9N5xowCgTaem8E3Rds3YfiVFm0anNynD6y8HIJD4PEPk5md6rbZSqO/c0W9uM6STCJHpg3mPf/o6ApCNU38xmerkvcFqBbcRN7nBmEtX5jjQgFTmipS3ElA6GezUlE85q+/yeLPdTWynp4gBIZq1uBDLV19Jvj+mUqBCkTeys28QQ2esaAR8FHp8MVpIP14AKBsw0ouk8xOZDGZAygs0C3j1JkFT9PbMiFzN4ry9DOJJmtbYXm72bophcFbm8UOJDzSIbXV4Au90YpHVSJPGrOSdNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HHqoXX3v71SMVVLws/mdpyV2JS5hW8n41JcByvTcTrc=;
 b=EsrK5FKHkX8yRlTK6BgOC0gDHPwtRrz9EpduiW0MPg/H6R5Z208Fu2gw4iIVZ/cQq+fS3V99DlW6gkHU6SI0WT+7B6ycDJseb0IrVBLjAdz3mWqUgvHGQgbjF3mHtYGblbnjHK7V4CI2CXqZDvw/vhNCF7va1LBGXxzCeuqvr45wvzv0wbQLYWGeT/VIoYEpWv7v/1AyJ59rJVs6Vq/+5hYOVA7s7ATpM1xuBU9BtzqZEvpQ5JJOZe02df5Nc1hNzDdkFiOCU7g+ZoU6vaClv7DXQEcrlbm4MFxnllcVR8hkqwmskHL1pGEccnaEWgSy5thmrJgnmRC2WiYKrADsUQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9)
 by AM9PR04MB8440.eurprd04.prod.outlook.com (2603:10a6:20b:3df::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.18; Tue, 4 Aug
 2026 15:24:06 +0000
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c]) by GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c%7]) with mapi id 15.21.0270.017; Tue, 4 Aug 2026
 15:24:06 +0000
Date: Tue, 4 Aug 2026 10:23:56 -0500
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
Subject: Re: [PATCH v6 1/6] PCI: endpoint: Define endpoint DMA BAR metadata
 format
Message-ID: <anIEDHaNqg9P4m4E@SMW015318>
References: <20260804033855.2115817-1-den@valinux.co.jp>
 <20260804033855.2115817-2-den@valinux.co.jp>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260804033855.2115817-2-den@valinux.co.jp>
X-ClientProxiedBy: PH8P221CA0057.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:510:349::12) To GV2PR04MB11799.eurprd04.prod.outlook.com
 (2603:10a6:150:2cf::9)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB11799:EE_|AM9PR04MB8440:EE_
X-MS-Office365-Filtering-Correlation-Id: 48dd5644-35aa-47e4-d622-08def23c6c0e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|19092799006|366016|1800799024|23010399003|4143699003|56012099006|11063799006|10067099003|6133799003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	ts1tK0x+6JS8lqyzOoAtTWWHmENLv+1kz5o3kiB+hGRypHkcj+e8ZLuKF32GrYlP3oFvE4T3aRqvnwk0PfCT0yp5HyBBenZA7DtswMoG0FyzabcqcHGoNmR4JFWomqSiRTj78/slt3kaUQ4KfraJ8C3louM2Igv7O+nOut/5dsarHb0PcxHKIiHAb+YQoyre21zORO3KZ5DKcFSPlHrqxDB991zVRBD2riDuDAcmYr15513dn5qr9tiyyyGTaHGgx8IvY7X43uFHqhCwD1+wIoWCAZjUR0nuxJOeyBtA1MLePDR2EJX4NykdmJ3nuscgT2tY0dJOUe6RHuoQbPGvmVYoa8MGLcvnMJw+0QR7MD9HaMhW4uvJSl6Kd8KOsibKyosfyxRFU/WNZDI/FikCWBT8u8mIrl4jTZvk7ekogjFV3Rlty/C5BHD81EBzep1+es+DWKH0IdBBNKSt/uNUnD3Dvo1vSQ/tyNMWtm4YgdVcH9GvOgg1K4tsb1AQIFjJc/ZV9DO85LUaZMiM2g1el7QPWst2qUqNilxz2VxJ1ofBfNxWhi5OGp3ICoapEVvDVlrfnBvXsyh499+BrT7pDD5QDWlJWrzbKy/7gWoV1EOtzXKZTD2RGweBWbBLRKx9ODoSM5U13mTtg+zcHeZ4kHKNe2of0sAtDx9n+1Mbxpw=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11799.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(19092799006)(366016)(1800799024)(23010399003)(4143699003)(56012099006)(11063799006)(10067099003)(6133799003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?lHZWE80u2hRBtVi0Pmi3LQEIcNQrhHWdqCtx+B2q6OTX1iF/B2kSmJqLINjs?=
 =?us-ascii?Q?k4l8Va81Sy6qW80j7lU1yVS1l1LMUMFme6MkjWEwW3+KLQ8jlS4NJNi7ePdH?=
 =?us-ascii?Q?K0eK0AG1i3qAuzNG4EqCFH0SvbNxxJJ/INtR2bQPW0sKLTNceEdntmx7mOPO?=
 =?us-ascii?Q?Rb5WRcwm+v219Z94632QlaxFpEift1Of6+cSDU2DBT2avSNaOln2x8LKyNub?=
 =?us-ascii?Q?Fq100l5q2rTSPWIZZwcZpCBQ2n+LBq3HhEp7dqM4YCqEwpGoRe2VD+HdqHzj?=
 =?us-ascii?Q?FD+2/FjX+VuGseKsTIqXuwp9t040gqzE34I5MNE8MHysNpydi1zr1FkM0D2/?=
 =?us-ascii?Q?4hjqNhkMZ5SPBwvhExKRc1UdtDMf5OUW6BiqkXOUPBA3KT1bxaaIe5/u7IyH?=
 =?us-ascii?Q?4ve+5e9brt5jAdn8Qi1zRwJV29+Mqf3m6I80vhHD1wAtP6uOS6V74537enuk?=
 =?us-ascii?Q?1s6Kq6Ad/rGqOZwqjDoBwCSsEjE5VSrwwIA90GxvZ749k5DnJ8ItcytDPcwi?=
 =?us-ascii?Q?DbAndzy6I57KmOQ7ukmM7wp8M+MLCAWRwmUUoGIA55yzkd+EtC5JXA04GgpL?=
 =?us-ascii?Q?pS9qofa17EIVT/m1w5GJq6nwGws8QnnhMCgNfrLChFDi70fvJag5E48WNEqK?=
 =?us-ascii?Q?bUPc1z8/99gRpsIOgteuA+yc6lIlPpVXvciOxms/v9DbpIC+63X97LgKtCqK?=
 =?us-ascii?Q?YHP/TD7pugO7a0VBMgpFDKpkCLef6Humx/SHp9igMcdcm7+2L7zfU28/6kX4?=
 =?us-ascii?Q?Lij7trXGGabTknBHNoGPsJ0mirOmMZ2UH8pAsVEqbFB796MTQ/tJJsbYQCJk?=
 =?us-ascii?Q?E4RLHRG3JA3zU1gHwN/HutwDAgg+z3sNNZxgHyqQUsOIYwValSu+/WJQt9hu?=
 =?us-ascii?Q?0Qpl0A2bRINH55dvPo0XTUc4/wT+AHmoTR4+C0uTUy09BC/kSDSRpm/PteIE?=
 =?us-ascii?Q?SUQteAwNWElGRMgw6yBGaWvJlIYm6Y85Bf6LZwXCmJYXhcW81HdBIQyL3e7F?=
 =?us-ascii?Q?fXaTaw92ILs/40BguiIf3MqzqcLLr0T8B5APqVo16QH5NmICJTlI3r7YfBqt?=
 =?us-ascii?Q?M1jPeXAacppfh+/DZ8pXRd4E6hoAyZcvJsWZT3mz6LlPkH0u10GUMOOiQ1eI?=
 =?us-ascii?Q?rAmF38bSp4M0Y7OjRhekKO/DdNksRDCVSajUM9BNNaX5NmbFQyVNTiFdUGSX?=
 =?us-ascii?Q?7u3dIvuFCbBdEUgjIntSOh4apjxV/hdlOB1sTc5mDjjTZROoFGFS6BWGGrvE?=
 =?us-ascii?Q?St1rbr5tFllfmPn6hc+FBfXO26qPjw5nCEDHMLPrk0NxKd59/Ag19tR4k93S?=
 =?us-ascii?Q?br7V0LwL7QR+StKodboJkNvBQwInFys+e3ou2G3W1nIyiVDv4uwPYxlp/7JD?=
 =?us-ascii?Q?4HmAAIHAdmdz2gHTVAjkCeQ3IUyYnez5UFKUzTzYZFPv5rploWlZZpMQcsFW?=
 =?us-ascii?Q?Ri3+usQ6P6wGiH4L3sZ1xWPsOk/HyIEWcqpV1GjR6pI4k9FWf81HrfIpBhYb?=
 =?us-ascii?Q?ypvPvnVY8h9LTiRC1s6Vy1Csxpgi4JURQ3TgsFYZ1WpIvncjI4SJYzPKFIbt?=
 =?us-ascii?Q?CXFCOjr2XYBufqzMuiMCtXholPy8jzxYMbn0tRhlHwyj3GfWkhd/ID0VfBzF?=
 =?us-ascii?Q?BdlleeQV1HDQEkxckWRaOco6N4LzRjPMfbKCqORmzXx4yb08bXprYxkGUQPK?=
 =?us-ascii?Q?LBq+Ad94Z6wFasIK8troqNcFQiwolE3AH9uBhYMuQH071tS29yWAS9wrmka5?=
 =?us-ascii?Q?HzMqBlPAeX0yn5DSe6RxapVIDn+lq1w+F5XJgJ0fEyLu8np54upb?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 48dd5644-35aa-47e4-d622-08def23c6c0e
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2026 15:24:06.0189
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: P9FcP568VaebXbl3hgyc5tsvcY2RO6Yw60UR0BG5y+wKJdyHuGaaCtWXOLzT7DBkHvqFxrnrbR2eKUfrZNCjFa0Osw0zSwo4XGRf4shn/F8Db7Gyor0ZugKP55EUkDKZ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8440

On Tue, Aug 04, 2026 at 12:38:50PM +0900, Koichiro Den wrote:
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
> Changes in v6:
>   - No changes.
>
>  MAINTAINERS                |   1 +
>  include/linux/pci-ep-dma.h | 170 +++++++++++++++++++++++++++++++++++++
>  2 files changed, 171 insertions(+)
>  create mode 100644 include/linux/pci-ep-dma.h
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 03febbc91a06..c503cf11b5a2 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -20933,6 +20933,7 @@ F:	Documentation/PCI/endpoint/*
>  F:	Documentation/misc-devices/pci-endpoint-test.rst
>  F:	drivers/misc/pci_endpoint_test.c
>  F:	drivers/pci/endpoint/
> +F:	include/linux/pci-ep-dma.h
>  F:	tools/testing/selftests/pci_endpoint/
>
>  PCI ENHANCED ERROR HANDLING (EEH) FOR POWERPC
> diff --git a/include/linux/pci-ep-dma.h b/include/linux/pci-ep-dma.h
> new file mode 100644
> index 000000000000..73f72455843c
> --- /dev/null
> +++ b/include/linux/pci-ep-dma.h
> @@ -0,0 +1,170 @@
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
> + *          31                                                              0
> + *          +---------------------------------------------------------------+
> + * +0x000   | metadata magic                                                |
> + *          +---------------------------------------------------------------+
> + *          31                            16 15            8 7              0
> + *          +-------------------------------+---------------+---------------+
> + * +0x004   | metadata length               | reserved      | revision      |
> + *          +-------------------------------+---------------+---------------+
> + *          31 30 29     27 26          19 18          11 10           3 2  0
> + *          +--+--+--------+--------------+--------------+--------------+---+
> + * +0x008   |R |H |reserved| ch entry size| RD count     | WR count     |BAR|
> + *          +--+--+--------+--------------+--------------+--------------+---+
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
> + * +0x01c   | write table                                                   |
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

Is possible to put all H bit to sperate 32bit space to avoid
Read-modify-write in case need sync with EP side although other bit is
read only by host now.

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
> + *          31                 17 16 15 14   12 11 10     8 7                0
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
> +#define PCI_EP_DMA_METADATA_HDR_LEN		0x1c
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
> +#define  PCI_EP_DMA_METADATA_CTRL_HOST_REQ	BIT(30)
> +#define  PCI_EP_DMA_METADATA_CTRL_READY		BIT(31)
> +
> +#define PCI_EP_DMA_METADATA_REG_OFF_LO		0x0c
> +#define PCI_EP_DMA_METADATA_REG_OFF_HI		0x10
> +#define PCI_EP_DMA_METADATA_REG_LAYOUT		0x14
> +#define  PCI_EP_DMA_METADATA_REG_LAYOUT_ID	GENMASK(7, 0)
> +#define  PCI_EP_DMA_METADATA_REG_LAYOUT_DATA	GENMASK(15, 8)
> +#define PCI_EP_DMA_METADATA_REG_SIZE		0x18
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
