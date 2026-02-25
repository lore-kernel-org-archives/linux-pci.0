Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013041.outbound.protection.outlook.com [40.107.159.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3755930DEA5
	for <linux-pci@vger.kernel.org>; Wed, 25 Feb 2026 20:29:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772051396; cv=fail; b=aqTfIRUa1+WOzzBgd+uU4wc+8OAjbM6beOQaVxmDBkTG3YRrWWSpzvOJ0EyiwynLcI3fAP6EgnL257BiitEuWcEXTFDvM2yElz4MWytXj+ZvKVLwXpTzJJlTU1dMjnrGqvHcOKXpe5k3lcaJhzOGl2r5htlco42O1AJbk5BfgE4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772051396; c=relaxed/simple;
	bh=lNCFP7wsrgXn9nzzaJvNbfx6uisSwAc9BATdPhljIss=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=sSVOxGTMRTpn3CkmTjH1ORfYCeyfrWZqM77AqDRptPa7KiXE3YOzisqCK3lQyn3TmHVeLSivv9SM9DaFaDnZKZB7FYWVotlZVGpKS4Pj2BB2ar25BtXPjAlDG0ruMOc7b1DAujZerq1yPD4S5SJipJAir1h/8bk5nj626EPKPIo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=M0aQHL6G; arc=fail smtp.client-ip=40.107.159.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="M0aQHL6G"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fQiLt9PGQsdF7T/3sc1hNrZiIT8DL+HDRGrVNPnyVcPCgUOWkJpH/0rOXrXlB/at3it/7u3YvoWZ/u0Gh1/Um/f7n4qbayeZTgmNHvdPrO0si83NI0bt4BCfhpprPWAOFf7nY8DKWeBJZ9Q2uEfsF4mCGXfJBzIxIWRzGsAZfxNUa5moMDfptLXo4w4L/hdFNUmn2V30eCPZewoHMFPpOiJOoHAQ524jpqaH9lAPv04HR8o3l1h56WfFIk8gXEEN07iTMjNaaRH7WWCTACpgpYEpDfA/z5XsaYCbbjp3cwXYKn5EZvE18DqwJP3M8xNO8mOtPRb9Vt5pMTQGW3+jEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vx07VmI9jTI/VElveXFpp3ePfUpGplgBf5Qz8sGmIIE=;
 b=VrMBnJ+Z+sfU1NTLKwnRCiMlpI2XHbISEbAdMxbPQI34U3d1gA4yaja0itC6P0I+F1Hs0UXNdYcF85l5eAcGldoIuWIZIHg7fjGTXD2ZJl6wXdR3CUHIkmnjDhk8JblEoQVYzhnvYvGGdK8Cmt+ed1garw+Spnxpx+zD+lU7nHwp6plvKtaxxDkx39JM4npxNXbJy5nXYxCYJnBLcJoXtC9nO8nROq0plsEDkWvp17wz6hs9BH5Zgo1YdSU5+u6wSopTKXuEms9ypvmXBon0OkfgKfIq7Q62NsnHmOJ0WpmCfh/x3pDtGIOo522k9QBs1lNRbuCxDD9RI+KzpONXtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vx07VmI9jTI/VElveXFpp3ePfUpGplgBf5Qz8sGmIIE=;
 b=M0aQHL6GstkbD/ErHuGO3xqolxwQLIMg19ekO2sHhbCzIlQYD5E+a/VHl/gmtKsUUOkwY5ARoHJHuorcQxBTgQPEMb7FdryppEYwPRa/LA6tJjmDGEQha7A0Ze1Hauq/oKZX0eNT1zVMRdSfLkJ2d7DsdRkMjLAARVFjKrin/FDL95EYIionsghMqaF8r8Scjkx/9iahcUkvVymqdWFU6SUjgpLlvmTwj+LhaEutGh0TDvTJTzX8cwf+1YXaF4jDsU2fsTPqk3tdnnrELs0Q7u2Kk6F6adNVB9QuaJqzlmcV82YsYURhGJgt3ttNnybg1fB83wZWw30YksF1U3mQFA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com (2603:10a6:102:2a9::8)
 by AM0PR04MB6817.eurprd04.prod.outlook.com (2603:10a6:208:17e::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.15; Wed, 25 Feb
 2026 20:29:52 +0000
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588]) by PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588%6]) with mapi id 15.20.9632.017; Wed, 25 Feb 2026
 20:29:52 +0000
Date: Wed, 25 Feb 2026 15:29:44 -0500
From: Frank Li <Frank.li@nxp.com>
To: Niklas Cassel <cassel@kernel.org>
Cc: Manivannan Sadhasivam <mani@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Manikanta Maddireddy <mmaddireddy@nvidia.com>,
	Koichiro Den <den@valinux.co.jp>,
	Damien Le Moal <dlemoal@kernel.org>, linux-pci@vger.kernel.org
Subject: Re: [PATCH v2 8/9] misc: pci_endpoint_test: Give reserved BARs a
 distinct error code
Message-ID: <aZ9buMZcgImOaBzh@lizhi-Precision-Tower-5810>
References: <20260225170324.4033466-11-cassel@kernel.org>
 <20260225170324.4033466-19-cassel@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260225170324.4033466-19-cassel@kernel.org>
X-ClientProxiedBy: PH8PR05CA0012.namprd05.prod.outlook.com
 (2603:10b6:510:2cc::11) To PA4PR04MB9366.eurprd04.prod.outlook.com
 (2603:10a6:102:2a9::8)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB9366:EE_|AM0PR04MB6817:EE_
X-MS-Office365-Filtering-Correlation-Id: 59d9a378-564e-45a9-b033-08de74aca129
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|52116014|7416014|376014|19092799006|7053199007|38350700014;
X-Microsoft-Antispam-Message-Info:
	8HUalqwijbCmPpB256sT3TnamVQqHvobv5umYmihGrIYyExTg2KqiyiAh7eekF1NIb3BIEa6ppZ0FAJN3NQU+5XSxiTvJH6ESaBbjiTHkwfrzNwDgkkI3QPvPbRUJnlVRAbX3lXbKqODNycprcUKenwCd9yFVA742r4R0LvDSNUF9JUDxZIKccC6ziDJ3hW/oxe2SjLk1Kq6M5M35P43DaQfI2igv0n9+CIarEtLQhip8rfu3395PeA5ViRUGUa/2HD8invXF86zWqW5ueeTMjuLJlKHkb+DMBqgjJD+4bcwyVZ32+72AW7TP4bMHrnJJF7gXUcaf51aQnPe9CZOLZO/WFnK/WaShjswGWXWK26UQgKfvh8mxrvpT2x1P3bKwY0Gb3oOXGoBgAo3e89yQqigQhf5e8NiC8oC7FubrNpf1A4gFHLNRnt9f4cMM840kGeRkMvO9hDkltel4LP2BddsQMWcFy7ifVtZwD3JyfU378suxqDceR5yKNYlM/hXtqaT1QDmV5eRptZXb7Ns3zogR+MyCQgYLBBbXZaWaPMTCl9UY5ZQWBkFL2JqeXXnQ1sR4bRJeh8ztG+bstRhiFeTLfEtENizUGqJyWgXHHroLYzuRj28P1LjYbHhweFH4+w5g6wtY0bdw5YkG283JF7fD5InP35yH2O4Z6ai0VSS0ehMINDYvFIhu/E2groOInq5DOzc9MBLFIOCByjbjIUKr1MM/nm6kZAypSAAroH4nMii5Rt94xiugbPsiqBwr12az6Sz5qhb7N9XDbTK0niS7UteWW2vZbqnOpqR/g4=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9366.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(52116014)(7416014)(376014)(19092799006)(7053199007)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Khb+0bO3ffecz1grMF0yLHXfE8jcjBJevmACxGybIF7e7MjvaplAGxwzIW07?=
 =?us-ascii?Q?kN1qvKhiWeTt0F5kHgpE15xOu/zXlgvo2c9elj1UdBl6vSTi3tMLMYhlbZVK?=
 =?us-ascii?Q?4TUKRlA90e1aaBBgqz1MQ1bn8YB/4Q5nwnOBwql/Lfqb4WIjbImYB2xsm2KA?=
 =?us-ascii?Q?Lk+tE493boUzSbc+YbnALuG37QlnwJgnaybz9GFWPXmfLq6K5CcQWxkixB8R?=
 =?us-ascii?Q?tkm/LGGHKoo7xe3IhDlQ0odpYdzRsE7FFhVk/UeAtYqSH/oVChb6oPwdL2HK?=
 =?us-ascii?Q?/E5VsasmyFh5cIEKmjBbvhzWwRt6xm6G8/RmbimoC9JraAKp9ge/ANHXjp5x?=
 =?us-ascii?Q?6oay6RboME5H5w7YXJLadZtRhWdC5hVPhx7aknjzpUbt6KrxnJ+EXt2E4uyy?=
 =?us-ascii?Q?w/WHYo5xMyIc4AgH3DBZrJ6Y9NXdu/3K4osZSqTvkno+XoZQgNf6Rc3K/X1W?=
 =?us-ascii?Q?2AuEET7Q2Z0Bwa7zvfDRfVVAZNf502zxYAYK7bG37X2cEXROjDr3HTB4Adwz?=
 =?us-ascii?Q?X372lJhovgk82oMTYtVSh9nKkXC1z5jQnRBU1wgRRpTiRUkAp8OR5aXpiLgI?=
 =?us-ascii?Q?q6+1eUgN8cjErjuuhNkheNg956mPVPnmPjea9DFdM1HdOZa/Gimpflqyko4T?=
 =?us-ascii?Q?N1j6FnwC4y7JOIx0PySISZvoi6f7Ox1wzOe8zq3MPHH8Z+VCfA4hPe1r28mt?=
 =?us-ascii?Q?SvfUB2LadcJP1lBCK9jG10vKLvutsaYB4U7U0bVhu2TspE+3uZBHNA7BS0HC?=
 =?us-ascii?Q?GXuHii02Jh/VmlD1RC3NuT/i3KbCBToeArCfSh2pZIbG2j0a2w/bzim78kO6?=
 =?us-ascii?Q?AVQHDffB0H3mSbGICGSEhRDNk8q72fOfQOEm4UkdeL0AZT5vCsxrA6Jjg4JT?=
 =?us-ascii?Q?Iu5GWasLODZwLXT5P5Jj72QCYN6iCdRJqaz5kQbXuCLdkNgeJAW7IBQJjwWu?=
 =?us-ascii?Q?C52LFWGitYvmzwj9jU1kAQhjKrfgq6mB9MGu9SxrYysTrjdJvBhNEpu5gC7L?=
 =?us-ascii?Q?POeOK7sZqWhwjZTkfkAV/JKduCqFk/t0ScTk6zQ/lItBstj56o+dk0hb7CAt?=
 =?us-ascii?Q?bqnsuqjUZ3a+gqgea/+c/brvFNfI9KfKv9Zl77hiyyZmXOhTR2h1DiuXfY2L?=
 =?us-ascii?Q?2lJY5mOf+KaAufYXeKG1UkehWGFR/LdHjT/fCrKZDbd9jGkieiDFbcEnmY9t?=
 =?us-ascii?Q?kUJmB88qJq3TgRCm5RCWIjd+bcJJKRqTAJmEZIxVhir1CIl765wxeWtLNe1q?=
 =?us-ascii?Q?U7T2BSYFMf0LLrigzAV6PAEe6HYONsSx9Wgtdh9OmZneol6qDP/meZnpW5cp?=
 =?us-ascii?Q?5P3p8kxmTIMB3cBHcY/B3i6/gLpV/8QPcMCc5Ztu7Axpcbuiydb7dTCNo1r+?=
 =?us-ascii?Q?4edbWcXiamTxfD2rxJdKXotL2wLrPyn73KtCDN+p7+V9ZESfPeZC9rvlfoqX?=
 =?us-ascii?Q?IZbQqS7L9tfWupzJ/VvfQxTxUdkAqGIe2E2HB0LNLXVPxbIXYt39YbUPXf+r?=
 =?us-ascii?Q?qKbXmsP0HHkVihgo9QwjCmTAtOUgnSc+syeCWWIwDMAo7zh1DWsSNTgGMsYl?=
 =?us-ascii?Q?vY+ZoVQKrVjAMYgzy/TOfXlhHcJophSXDvdY47CsHWpwORL7Q8Lmc5UWZq1+?=
 =?us-ascii?Q?9XCydzNy96PFUmG4QkG89SwzJEmbiWYwtZXJcHBD7NI6d/z3PxJa+aP52NfC?=
 =?us-ascii?Q?1Lie9VOxBmVJSyrIzMdvOa8ryGRWIG3JrWd5yRoqG5sqTPeXjbGAH3m3eV02?=
 =?us-ascii?Q?zrZ8K74bRg=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 59d9a378-564e-45a9-b033-08de74aca129
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9366.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2026 20:29:52.1832
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cRyD4i2UazpooYl8+Bmt3yHkAe6gOnfKGh1Rj00kOuWoeFpSoXzzqD03f/Ouv8SKGhtuQifj3xkdGeXRgkxmXw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6817

On Wed, Feb 25, 2026 at 06:03:31PM +0100, Niklas Cassel wrote:
> Give reserved BARs a distinct error code, such that the pci_endpoint_test
> selftest will be able to skip test cases that are run against reserved
> BARs.
>
> Tested-by: Manikanta Maddireddy <mmaddireddy@nvidia.com>
> Signed-off-by: Niklas Cassel <cassel@kernel.org>
> ---
Reviewed-by: Frank Li <Frank.Li@nxp.com>
>  drivers/misc/pci_endpoint_test.c | 21 +++++++++++++++++++--
>  1 file changed, 19 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/misc/pci_endpoint_test.c b/drivers/misc/pci_endpoint_test.c
> index 93cd57d20881..89d0aba059da 100644
> --- a/drivers/misc/pci_endpoint_test.c
> +++ b/drivers/misc/pci_endpoint_test.c
> @@ -85,6 +85,12 @@
>  #define CAP_INTX				BIT(3)
>  #define CAP_SUBRANGE_MAPPING			BIT(4)
>  #define CAP_DYNAMIC_INBOUND_MAPPING		BIT(5)
> +#define CAP_BAR0_RESERVED			BIT(6)
> +#define CAP_BAR1_RESERVED			BIT(7)
> +#define CAP_BAR2_RESERVED			BIT(8)
> +#define CAP_BAR3_RESERVED			BIT(9)
> +#define CAP_BAR4_RESERVED			BIT(10)
> +#define CAP_BAR5_RESERVED			BIT(11)
>
>  #define PCI_ENDPOINT_TEST_DB_BAR		0x34
>  #define PCI_ENDPOINT_TEST_DB_OFFSET		0x38
> @@ -109,6 +115,7 @@
>  #define PCI_DEVICE_ID_ROCKCHIP_RK3588		0x3588
>
>  #define PCI_ENDPOINT_TEST_BAR_SUBRANGE_NSUB	2
> +#define PCI_ENDPOINT_CAP_BAR0_RESERVED_BIT	6
>
>  static DEFINE_IDA(pci_endpoint_test_ida);
>
> @@ -276,6 +283,11 @@ static int pci_endpoint_test_request_irq(struct pci_endpoint_test *test)
>  	return ret;
>  }
>
> +static bool bar_is_reserved(struct pci_endpoint_test *test, enum pci_barno bar)
> +{
> +	return test->ep_caps & BIT(bar + PCI_ENDPOINT_CAP_BAR0_RESERVED_BIT);
> +}
> +
>  static const u32 bar_test_pattern[] = {
>  	0xA0A0A0A0,
>  	0xA1A1A1A1,
> @@ -404,7 +416,7 @@ static int pci_endpoint_test_bars(struct pci_endpoint_test *test)
>
>  	/* Write all BARs in order (without reading). */
>  	for (bar = 0; bar < PCI_STD_NUM_BARS; bar++)
> -		if (test->bar[bar])
> +		if (test->bar[bar] && !bar_is_reserved(test, bar))
>  			pci_endpoint_test_bars_write_bar(test, bar);
>
>  	/*
> @@ -414,7 +426,7 @@ static int pci_endpoint_test_bars(struct pci_endpoint_test *test)
>  	 * (Reading back the BAR directly after writing can not detect this.)
>  	 */
>  	for (bar = 0; bar < PCI_STD_NUM_BARS; bar++) {
> -		if (test->bar[bar]) {
> +		if (test->bar[bar] && !bar_is_reserved(test, bar)) {
>  			ret = pci_endpoint_test_bars_read_bar(test, bar);
>  			if (ret)
>  				return ret;
> @@ -1143,6 +1155,11 @@ static long pci_endpoint_test_ioctl(struct file *file, unsigned int cmd,
>  		if (is_am654_pci_dev(pdev) && bar == BAR_0)
>  			goto ret;
>
> +		if (bar_is_reserved(test, bar)) {
> +			ret = -ENOBUFS;
> +			goto ret;
> +		}
> +
>  		if (cmd == PCITEST_BAR)
>  			ret = pci_endpoint_test_bar(test, bar);
>  		else
> --
> 2.53.0
>
