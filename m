Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011051.outbound.protection.outlook.com [52.101.70.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 723CB385503;
	Tue, 23 Jun 2026 14:25:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782224701; cv=fail; b=D+Mp2snFrT90t/LktvHIfuD2TDkFutng8xPmuBSVIP5PK8mtSggcu8wSry/Cn/VdEIu0gsr4W59xJDvUnYrKuHWJU7mmhntpWWjJKY8zaZYptYu7R+7uK7CG0tDsNr3pzvRnXs04QcVMNTYy5f5Zeyvte6aD6b+vflQ0SkkUZ+w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782224701; c=relaxed/simple;
	bh=EeioU1p3d5VklOM5tgYvEfC7HV9l1nlQGVEYzZ1Ftr4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=eH2LOP14LSnrPsD49YRAYHf6DizTvBN1D1UPPyCzFDCDMG1+QDLU7YAwscgE6XJ3SFxervGTupuGJFDYrmaGZLSZWA8SAE8AQRw28+aKwh8Ow3uG/wI5V6fiKe/iGJF92yTcbu+KPUSggDGpFF5PzghMTjKEkunxTexsvt9J4/c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=HgMWY8AA; arc=fail smtp.client-ip=52.101.70.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="HgMWY8AA"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EiAXbyUfjxWMceK1OOUNYiOISMLJ8P54ihwVzcXYA1xkKHIqQz2+nGyrf/ZLRqqjRE5PjTEUaATnBA1mKCdUN+0CShTjUjqWmZmZVOzsib/nHosvwdaYjGZOqfJsrk1BoMXAJ77VyrqsgZvB4kTrJDX/idJvSWMVXCrTAxoqgAKOgJxGk9kZkn5a5e8hQR351jPbfUMDMUzp1VBXt+iaK4ijQ5Vz0K8L/YtarjKy7+qwQWHk2PE+m1BfivuDSHNpACW7K5ko4/6sn+JXTTIpgObdZ/l0jbt+usL9g4cC/xw3hHx1Q8nadQoHpDx7n+N4hOMqb3lcam86CYCFCudK7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1itCu2FsQzREsfp8kM6Bp7Zah1j5ty2bgb6hwamJMeA=;
 b=oF5I1nedymmlx70hTRcEvbMUxfBp+Rr2gGu6f6a4e2+tu8hPzQN95gheLywZbzDv6McH1Gckrqr5R+3oTTkwrmb7ah57O7Gv6qR9g76IbLIIsgfI5bhZEcijWd5I6t5HMF/jwn+cuEmOPZBz5HQ28lEgmtuQopJwgw6Hw1LgRlw1vWmUvx7licBrwbTt40UNsJbkD8wmRbAvcV9yjEQoZFU8LJqg6A6GZFYK3EDD2KPQOso6t9Qumu9zmwgnNMDA5y0GJhEvuudC/dloadPkGF1oXSi+HHH1ZlIdLxQtlnZoMxyXRYguUFQzEn6WHAse+/lFouWbS7nHmGDLaYnt1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1itCu2FsQzREsfp8kM6Bp7Zah1j5ty2bgb6hwamJMeA=;
 b=HgMWY8AATQwMs7VrNNOdP5PmnGw5Mr9VsgsELn3gwzvQiWA+YsWcePukYmLYc6Os8fmUe/jUhlmR7+hrHxn76GXe4m9q3Gy3s9d2v9Ubct77cts3ZTxDmMciNFRq0vi+lWmDFeZsWh4vAlERI3YA+qjyYCwDi3fnZR03jRjns5DD4VkEG5eHjJXCXvxhGFrijFVtB5pazj/kZMeiPLNksPDT6i7dZXEq5UO43N6aej630mXUc0A2nWdR3W+HqsL6d3mXoq2WyJ8uLlsZ/VeYqRWCoF5iyaAchcyobCwVJY5OV2ie025BuM0uj2TS5JTFr5uvWxfmTXeP5vM/MeWOXw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9)
 by DBBPR04MB7659.eurprd04.prod.outlook.com (2603:10a6:10:209::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.11; Tue, 23 Jun
 2026 14:24:56 +0000
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c]) by GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c%6]) with mapi id 15.21.0159.007; Tue, 23 Jun 2026
 14:24:56 +0000
Date: Tue, 23 Jun 2026 09:24:42 -0500
From: Frank Li <Frank.li@oss.nxp.com>
To: "Sherry Sun (OSS)" <sherry.sun@oss.nxp.com>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	Frank.Li@nxp.com, s.hauer@pengutronix.de, kernel@pengutronix.de,
	festevam@gmail.com, amitkumar.karwar@nxp.com,
	neeraj.sanjaykale@nxp.com, marcel@holtmann.org,
	luiz.dentz@gmail.com, hongxing.zhu@nxp.com, l.stach@pengutronix.de,
	lpieralisi@kernel.org, kwilczynski@kernel.org, mani@kernel.org,
	bhelgaas@google.com, brgl@kernel.org, imx@lists.linux.dev,
	linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-bluetooth@vger.kernel.org, linux-pm@vger.kernel.org,
	sherry.sun@nxp.com
Subject: Re: [PATCH V2 3/8] Bluetooth: btnxpuart: Add M.2 Bluetooth device
 support using pwrseq
Message-ID: <ajqXKnUQ2wlWS_jz@SMW015318>
References: <20260623030736.1421537-1-sherry.sun@oss.nxp.com>
 <20260623030736.1421537-4-sherry.sun@oss.nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260623030736.1421537-4-sherry.sun@oss.nxp.com>
X-ClientProxiedBy: PH7PR17CA0065.namprd17.prod.outlook.com
 (2603:10b6:510:325::9) To GV2PR04MB11799.eurprd04.prod.outlook.com
 (2603:10a6:150:2cf::9)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB11799:EE_|DBBPR04MB7659:EE_
X-MS-Office365-Filtering-Correlation-Id: 90086a6b-2bed-4d88-dbdb-08ded13332e2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|23010399003|19092799006|376014|7416014|22082099003|18002099003|56012099006|11063799006|4143699003;
X-Microsoft-Antispam-Message-Info:
	4KP/1J64EHz2AbytdAj37kyC0YStFb3fdPVOpu5aHUJ8uZUigYwUdm/LjkXPdG3QwC9mhMuJBOBeszygDT17jouOuDjqB9t/I4P35v8gLXujvqdeApJj0b3livHmLHXTwAMnRp8OFo/4BZwDLyWDNQavEacqPyCI2CXsgBnOBQoqg63HOlteiFXO0UayR670u7s71z1yUi9N+wuPs3o72wq/XbF6Y87g0ekTI8HKbKThlPnyM1pX6wUXP9RH1xbrcgn2eosKvcdFmqtnvbYBBEd/Oo/Yy6Pol9ZYIbu3zBzQ6p6BtwEqCiArxUIzSfkaBMu60ullOEhQqlESGaMPP9Bk8oJnCjEFqL5wzik+7PnxDxmjHt6nQkKQB50wDNPgSCpJhiUkqTqX7JN7sFTsg6BmbnN+8hiP75RAJfs/t1xD5p/8uU44SOYnlQWZ/N0qJulv28RPePMi2JjHhm6W6O0BvGMfFfiqEDa8Mr7UgSrBe0jy1KphOK2zhoP9+lc2YN2WTd8VKk/SEL3M4920kp0090tWwNLyApKv433NedB9aIjF0+OitNpHW36NY8Ocz54Y/wbclXHU99OCUy4mI+PuQ991bgy5ncOg4w6OK1H4RA//Bqc92kQOiacShxwZIh5bKA7UVlvRUt7WTXTn9QFXasMplNE8e2ICJadQlQM=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11799.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(23010399003)(19092799006)(376014)(7416014)(22082099003)(18002099003)(56012099006)(11063799006)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?nQEMKdSQCCHGLIB7DzVtBrPA9gIkrys3hiSydyc1IJfkDTlcLLXZJ0VcPG7W?=
 =?us-ascii?Q?iezLHbHYJZeYi/TprqT6sYxk/j7ZQSIrdFZ4mCbM/h6SK2nUVoQ07lkUmQ6u?=
 =?us-ascii?Q?lKv0KY5GNpVZZV8SPhPQgT51IAw/pFKVu3iU0aCN35L3wpKmA7ozmuvvoPye?=
 =?us-ascii?Q?kYeGxGLZ2/I6XeWJZsLHmf8igrG/kdzID3lzATKZs8xyIYlYW+P3+y/mXyZU?=
 =?us-ascii?Q?J2VQLx7bX+Z5cGF+avOdF4CCZoKxroE+4D9wFuNtDtgqAZw1HWTjzBFppX5A?=
 =?us-ascii?Q?j7naZ8/WR0ZtTYkWMNd7AkOoblixqFG1fE2LDi9j+PZpYQ8JubYDH2Oak+j3?=
 =?us-ascii?Q?ukDjaChMRep8wcIKs8qayLW/q4npdQQwWCCMvRMkBbVBcUESCmOoEacaM6KZ?=
 =?us-ascii?Q?mDSpUZmfrU6yCFwfr9Vtg8tM/OBqfaPexzDYp0Rya0Ucn8E5At8kHz5amUv2?=
 =?us-ascii?Q?E9i+zaLZQ5YB9MU3DI7ypLZrlNjYkt/7rlpKeoUBxkcb9ksXU3GC57DMWGJd?=
 =?us-ascii?Q?hts9HmtjX1V730JqJExjyh3jgbUnSzuqM8eFnNSFBAAbfWKSa9SfovlVjOP/?=
 =?us-ascii?Q?ZCRO+9BlLVKneKAlW1HODPsWw03lPlKwvdSJCN9nQGkYTUblmfaBu6ITJw4K?=
 =?us-ascii?Q?fUUlqbBxzmYpbBNA9jEvkIgRjnsF5LYddfeM+iCNMH/p0dzdncqvAMcpQG5+?=
 =?us-ascii?Q?1ypDWtB4Ba/lZ+tAIAK5uZa2G7N32E6D7VkqFegfVvIYVoPeCKLKTA8FDvgQ?=
 =?us-ascii?Q?lcfOq+VCzpuEj+olLqxJEFPaHG9kI9m2QPc5m3/w2WJhdYVZEhvWPVJoqgMX?=
 =?us-ascii?Q?Jw8wGgqD8nI+0cSgM5GyNbozYEs1Cx8KeiFPPXEptz8l9dqwvV2GwKTRnyfG?=
 =?us-ascii?Q?3RL8omg7Z9/gsSPpujAnr+KMs1BcFjIuO0cC0dgIye7pSpSFhBxiM3Lz2tY5?=
 =?us-ascii?Q?S6ybOJ8ivw2kQ/PyHGeNM98uh076HBecHF+t8dlJXB31V/t5WefiSM9bCX1s?=
 =?us-ascii?Q?53yF4GFKEd2Fxoa6OUbZmHW+bYSdfi/m0N+kNRM3H5hm85ZFKggP+Zfs4Alg?=
 =?us-ascii?Q?trlfUab0D87wV8IMXqO9PlHFWZG3pxqMV46Rj/sytZ/nFdW8Pa5iLNtSRaKR?=
 =?us-ascii?Q?Vus3IwwXB5gNSjPUQn+5uhM9Aa1WYYOYbObgMSH3YIqjQxOkdIzA2FvBU8FC?=
 =?us-ascii?Q?/pj5YbI/GtRZchb6eff9Uuj0q6Xwdmq3TfrpDqeTCv/6F2cQhA1mtogC7PY2?=
 =?us-ascii?Q?xGkj+3Xfdzy0g8NUMm76AwrKWZdh7UhxGQg5J/KARMvTlvB0hqS1XX/6gBst?=
 =?us-ascii?Q?nKdEY9DSKFEe/0m+hZThOUybplFND8trs0g3gBGxgzZhhOCUIvDvgkBW6QpI?=
 =?us-ascii?Q?l2bZBxE9re9wac6JZoUVyLzSn37f++7cPrd2bnricuUGme4HapMgqeCFC4OW?=
 =?us-ascii?Q?nwfX6IKK+KUifLKuCiFJcRbzr3hPiOXoTlvhxqkWTKGZBJxaAmP+7ja59eGX?=
 =?us-ascii?Q?Nlggr34lLVZQ746penLMGGarROgdNxsmW94yChYPyr5D2VdNll/GvWetRmI5?=
 =?us-ascii?Q?Zjydj2sOVCnHKWrkjIEHn0S0Ch1bhjXPTaUmOTpwvL3N/HVZ4X84JbloMqOG?=
 =?us-ascii?Q?ufLzv2dcplVQMF0icR1oxAhGycY5zbsy0mABCr0OeC44k98/TSqdQ8H8Pc/m?=
 =?us-ascii?Q?LY+x9RDx3jz6rKcQSwGJ9XW+qkeQacFncf50lWXUDabZ6wbRqvAzFgs1tE6J?=
 =?us-ascii?Q?eASrcKoNxY/1HMbAQWa1hrQ8MP/qSQtHLj+6y3lcGGynfrFhtDQ6?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 90086a6b-2bed-4d88-dbdb-08ded13332e2
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2026 14:24:56.3641
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: x7n2vugvrO0cRk17e9cATNs8UZna5ts4mI5/rp9PFCgx7TfRNnsf5lbT9+1TkSny4Ls1GH5+tBYUe2TS4UbOIZspsvn+bkJSa0Ee0xzjtl7Wyfqe7LsJ2IlzOXRBSmVk
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7659

On Tue, Jun 23, 2026 at 11:07:30AM +0800, Sherry Sun (OSS) wrote:
> From: Sherry Sun <sherry.sun@nxp.com>
>
> Power supply to the M.2 Bluetooth device attached to the host using M.2
> connector is controlled using the 'uart' pwrseq device. So add support for
> getting the pwrseq device if the OF graph link is present. Once obtained,
> pwrseq_power_on() is called to power up the M.2 Bluetooth card. The power
> sequencer descriptor is obtained via devm_pwrseq_get(), so the power-off
> and cleanup are handled automatically when the device is unbound.
>
> Signed-off-by: Sherry Sun <sherry.sun@nxp.com>
> ---

Reviewed-by: Frank Li <Frank.Li@nxp.com>

>  drivers/bluetooth/btnxpuart.c | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
>
> diff --git a/drivers/bluetooth/btnxpuart.c b/drivers/bluetooth/btnxpuart.c
> index e7036a48ce48..438ccaa2b56d 100644
> --- a/drivers/bluetooth/btnxpuart.c
> +++ b/drivers/bluetooth/btnxpuart.c
> @@ -9,6 +9,8 @@
>
>  #include <linux/serdev.h>
>  #include <linux/of.h>
> +#include <linux/of_graph.h>
> +#include <linux/pwrseq/consumer.h>
>  #include <linux/skbuff.h>
>  #include <linux/unaligned.h>
>  #include <linux/firmware.h>
> @@ -1866,6 +1868,18 @@ static int nxp_serdev_probe(struct serdev_device *serdev)
>  		return err;
>  	}
>
> +	if (of_graph_is_present(dev_of_node(&serdev->ctrl->dev))) {
> +		struct pwrseq_desc *pwrseq;
> +
> +		pwrseq = devm_pwrseq_get(&serdev->ctrl->dev, "uart");
> +		if (IS_ERR(pwrseq))
> +			return PTR_ERR(pwrseq);
> +
> +		err = pwrseq_power_on(pwrseq);
> +		if (err)
> +			return err;
> +	}
> +
>  	/* Initialize and register HCI device */
>  	hdev = hci_alloc_dev();
>  	if (!hdev) {
> --
> 2.50.1
>
>
