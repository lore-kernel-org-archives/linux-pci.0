Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013067.outbound.protection.outlook.com [40.107.162.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED77E1DE8BE;
	Mon, 26 Jan 2026 18:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769451633; cv=fail; b=pKS6d4g3T+nzWpUhOekUT4pKcqCz88rLhLimQT42uHO6ZjFzKwuUWGp/CrfnhjOqFb3TJAL09RXkM8Fas/L5NasS1ETKw4MeUjPDJWVVR55L4NqIDIRTUtjcvaBXoLW3Az71y1z9I0U4s9aPr4dxceYCBxdu3SttiJqb3/6WmdA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769451633; c=relaxed/simple;
	bh=Wc7qWDdTVQixZyvozdhBiGwRFMuUmlhCllRF3npBUOc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=NSWxnLJEURNE1LrNuUC0VMRiemkdDVqmj+/vTw7Y5Ng9WdEMCiJAs2e1LRkr1msciQ15MC5PzxAcasZyM/UGx0U1RFvA9GDCTZp6wB9q+3dZCDVhSc6EbUnuJ4Id2OF0sV6pOpSrq+5Inrq0dhNOAcnw+BPHBB/dXch05Ck7v2E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=dZKqFd2J; arc=fail smtp.client-ip=40.107.162.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="dZKqFd2J"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qgo90f54C3BFfRkDe3ROZFbDN2vBAEcgZ8apr9QcSlmVBEoA9PcfUVjHYUyX1dsuUPJHDrbRR/4Kn5j7S3wPbK5IcI0otvl1ysn4S0DCi68kk+D633foiwXPGjQCUCjJmZctcqapTeq7i6cB02XABtwsFGuriJD1lZWpNIPPv1wjlSXL3BXzZ8ZU1avOLpnEc+K0b7tkCnd7qWdAXp6eIllQ+XiSFakfiyq44IGYtsbbFPvVr1GZl1uip2G/KuBB+s0fQmGFBZ8S2rwxUAdGtTJwIFTzqyv0ecfjQBLYQrNoMLYl7508NfxHXl8UorZbiZA16EjEQLtTZsBiLbxdwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t3skV+d/8bKl0U+ow3EwfnpYa03vPZGUM0VYoCnqvGk=;
 b=YAeWrvMaGdO51szIOTSbnvnkF1j4Eh63P53FoWbmfGFrX/NvmiFbDPMO9bsED65WLZ8PeKSrkr5jL7Q3awf4Bmcb8XvZt0pJ+DypKh8gK1OxlIBF6b4fy3lQpPlbSKdTqYbpG6AVILVgssC91/OquYjPAY2byvGkSL1iduXgsKVOzYpjYW+O4k9cxfhotZ3Ues2HOjKtAvVo6RNNQJPDB4wpPxKJSxKuVK9hxLc0MoW2HUkkxtUdL3x8feNGpgSSF48brYLp2NHcKzAYptV+Cdz7EFrcQMe3CzitzY1Hs+pmm/cKJnKyCm0oZC6T1rREFNejXOI3FlFu6iyhwtxygw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t3skV+d/8bKl0U+ow3EwfnpYa03vPZGUM0VYoCnqvGk=;
 b=dZKqFd2JJ3+mbJFwPJpy+1a2RY+5zX6rh8q35ZvXX7djQ8mQ7GXow9ju9wK6ZLTtxuap5IkASmcI75/t9te50m1HRXJOhchCx86rnE04ou5n6vDa5eKzJAGC59BRICaK71YUwkS/pPyxXRjuySV8JiPGsuTmbH9mhoeaaRvMLk3pU5A804OkeEkhj9ZJ86Topc16O+fGEmA/nO2IoaSBdgtBoPQth48tqTrAOH+NGUMqsM1NLDD2Tc1vs8xBuLTqo2gVkMXA7RhoD5sV4D/zAHp+8MxsoERrFFHZDigZPzQdhcTQtVvoM7JUG0ujxe3XItAGPhseM4msaLWO+KlpIg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com (2603:10a6:102:2a9::8)
 by DB9PR04MB8187.eurprd04.prod.outlook.com (2603:10a6:10:24a::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.15; Mon, 26 Jan
 2026 18:20:30 +0000
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588]) by PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588%6]) with mapi id 15.20.9520.005; Mon, 26 Jan 2026
 18:20:29 +0000
Date: Mon, 26 Jan 2026 13:20:21 -0500
From: Frank Li <Frank.li@nxp.com>
To: Niklas Cassel <cassel@kernel.org>
Cc: Manivannan Sadhasivam <mani@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Jonathan Corbet <corbet@lwn.net>, dlemoal@kernel.org,
	Koichiro Den <den@valinux.co.jp>, linux-pci@vger.kernel.org,
	linux-doc@vger.kernel.org
Subject: Re: [PATCH] PCI: endpoint: pci-epf-test: Allow overriding default
 BAR sizes
Message-ID: <aXewZYkk46B11zho@lizhi-Precision-Tower-5810>
References: <20260123180747.827357-2-cassel@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260123180747.827357-2-cassel@kernel.org>
X-ClientProxiedBy: PH8PR07CA0018.namprd07.prod.outlook.com
 (2603:10b6:510:2cd::15) To PA4PR04MB9366.eurprd04.prod.outlook.com
 (2603:10a6:102:2a9::8)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB9366:EE_|DB9PR04MB8187:EE_
X-MS-Office365-Filtering-Correlation-Id: e4fcb55c-4165-4c9f-50a1-08de5d0795d3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|1800799024|7416014|19092799006|376014|366016|7053199007|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?UIJg7bHx+23fJa4MXB/m/hdaczRCYTkdKP+rYl1ZaotekRaakCmGq2KAcgQo?=
 =?us-ascii?Q?U11je7Y8ERHNUrVfysdcdHdfdPClU99ujEN//olB2xU1bTS9vSmREYVJ77Tm?=
 =?us-ascii?Q?I8/WQDRBoPB5OlLPZwwT/wqr32yyQ6tYp0LZHhXns03W6mn+XHNJDqWV+xiW?=
 =?us-ascii?Q?ttglvaF94hAUdzUwMG7PmSZannunEXHHLaS5qNSH3GvRM8s3cmOuF/BF7PM2?=
 =?us-ascii?Q?xjKVwPVleQ7/9J56NX3XTEOdbVpnIEgwMM3rXlZDTao07OUKH83yqJnebrBn?=
 =?us-ascii?Q?qo5nPxfquga3mAwjH8KVduU15L0V2qRC/bjOpya51JdfGmaDbPggllhfTbmf?=
 =?us-ascii?Q?bBp4PdpkdB/LdTI+slG395uF9hfC2HUGwKp/nd+nC4OSQyzlWxU3qQwEFlia?=
 =?us-ascii?Q?Id6G2FXyYqU3cne6ySo0I/xE0Gboa5yVBTZoy9BBjyMCBK2etcFxzba0P68l?=
 =?us-ascii?Q?EhCOO/pWrxXkopBJP51RM2agpy1mmPsw0K4Z1eOioV4qta6SEz9C9dTZMsWC?=
 =?us-ascii?Q?9ojSZu/SdtD52aNNd8YXbQHJmIZX4cKZgweNRyl+0/3whkkziPLbUXRyalnq?=
 =?us-ascii?Q?W1Y3XRGBHQ+CTKK6ISoxnE818AInuFNtKu23SLocI9i0N8uC9o3W5eVF2Z0x?=
 =?us-ascii?Q?ahJatn8PLNmjgBBRjvHeILTp3PF4UiC513JN5x5y9qmO2W/DAOtzMmQu628M?=
 =?us-ascii?Q?t1jUi/+NYK/cp19EkyAu1SxLK7OaIoyBWwu4YReJ/kh0zxJqANgFCMdxZOyI?=
 =?us-ascii?Q?UZVPjtXYPzSCOvNI5sHuWB6R/5peUSXBV1+GVl4JtwLXHJlrwh/wyb4aXn/T?=
 =?us-ascii?Q?mq+KzqAri11LwkujZsIOOEnbjL6WMQ0VmKkRRYAcN7tDqsVyqnALWREcj1la?=
 =?us-ascii?Q?YyJDcOSdRXl7mZ/fdbW25qC8U7YnXnVfumgGWiqIaqa/4IxvytU+NcY6IgtV?=
 =?us-ascii?Q?JZr+N3FgWHdV0elA/2n0J+4NZdL3uovX2rlpwGaJ2fWI1dSwV7SRsP8y8tlW?=
 =?us-ascii?Q?2CvU4R7KZLLTKYFkPuKvP6L2KxQZioR3ZoB80FBNor9Vyk1MX45kGzL9b8MV?=
 =?us-ascii?Q?mKVd5W++rxIMtwYrWfV8U77Oe2A+8J6bS6EXM5wvShMO6TreEBG6H5NvIN0d?=
 =?us-ascii?Q?Evdyv4R3Xeg3RtQPvTO1GBuWy0gVGIr+eX8j619aadtu/wYqRrbnWj39+arj?=
 =?us-ascii?Q?dpUY7RCuIXiRWC9Iwjv5yPn7Ymo671fj1zt2jAMBWEdQ7P6FzX6SpdtQgvSz?=
 =?us-ascii?Q?xffQ56OCwj72bK2NwJxbh/BdW8cdIZ4uKGot5p2qMDtYKrmX0NqozDhOnkqW?=
 =?us-ascii?Q?f/rB9/EqhJSpB8CrbLfhC/IzurynAHyGk1EBZ+venvW9bTsRho2v3c4d0Shm?=
 =?us-ascii?Q?IXyKKoNEWWu4dRAktdS7qiwaFoYLJSbyRxEoq2dKwwRHyXpwhefN+W1/3YVE?=
 =?us-ascii?Q?oijaNkr82hIzlow4sgUHRyQGgjUbVA9G/0J/UqqgVBOgn/FPN4I5kd0rpoVD?=
 =?us-ascii?Q?LQcPrBJMHOFbxsEPT+jN1RMFI0jGNkdVBeskV8HJSEjru93NOTvId9qhS4zP?=
 =?us-ascii?Q?l3cBGnjjfrWqUPk95dnJAzyHlKwvWwlTiaDVNnaXBptdYhu8ru4vLN0/zRBQ?=
 =?us-ascii?Q?5HGbmAAsXgzFsGL6Cet+AR4=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9366.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(1800799024)(7416014)(19092799006)(376014)(366016)(7053199007)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?2T9yP5cvwe4KdGI/pBxB64MzV+yLl0gUJjLAa7P5pY8YdX38mP8BjvMivfDb?=
 =?us-ascii?Q?yzsDktmH/ZATupv9xLn3Cs7L33QloH9RHWUSa/FgUBiSElkcTMfAYeZrdNpR?=
 =?us-ascii?Q?Aa//jgCykBoL41ACIbIMUgLbaLrSy5gnpPabbvnvsE+bBFynHNIdIUka/Zk7?=
 =?us-ascii?Q?5nQnqKZJZTVd5MeZro/ZWwgZF+8OI3uckAHiBSTePkFwH/YoiNkW/i4Yt+IA?=
 =?us-ascii?Q?x3pbV/gxR96Okq3t0+nZKmQ/aOWydYGcIscS/PlD6UJWRC8XxlEsQ9O/BfHC?=
 =?us-ascii?Q?qhbRF21yzypVCzumrLqIJH1JcZ+Aq4vmpCwAdqD35VsxuFH5/Q18bnpVKR8e?=
 =?us-ascii?Q?EQTE3dfvyZsftwz2j9gVBc8MlGQ7ZmVDs2SY5TkyNd/kHl4pqcVX07oBXqVV?=
 =?us-ascii?Q?l1Pcffi6pOxMElOd9jDQ4rUFaP4EY3YsaXyXp5mnj0fH9sw50Dx8NHen0IUK?=
 =?us-ascii?Q?wFTEs9cQQH7hjrMiasBEuX6v2CZzmFamX4364wRWMdSp3o9jk6BfFQW/hrCR?=
 =?us-ascii?Q?/RnrztogLWLNDUfC5XsTT1RF1AO4wIRlmID1NWYnkmbNMU3b4lSpuoibzfFw?=
 =?us-ascii?Q?jR9D8o8lNt5V1ax8b4Lnw2e/1r9BkSEGDJeKEZVdWGpQjSZR/RdWzAs3bvhK?=
 =?us-ascii?Q?qg1VZuZudjupV6m/aUq9hGzc0+bX+DpbMhiFOaqAf/hNwQn7VCri4/6YK+Yl?=
 =?us-ascii?Q?yV8CyZyMFd7HIqObr8gJKWI0GxcXym/4rTrs1trt2JdR7FKcL++MDKy1qBFI?=
 =?us-ascii?Q?RXRKlEV/M/8B+mQ4rvN5B2/rJUKy1rfNzNwAgJXHGJQ0pRoAcgeqKdUwnKTL?=
 =?us-ascii?Q?9h+MXABTEeUEn9Xgdnck8OBQWUQ/I1dbFkRO9QbWV9HPYRAUy1uLMkLZbSjw?=
 =?us-ascii?Q?+NZm+ShMjaL4JKeJ8ThteX1/3Vi5gfxzrZOm6MyfXOU5SpGBZKYcSyEz6R4p?=
 =?us-ascii?Q?XQZI1P4CPSbFmqMZOXRDAp+Zja6zCszfkhxkREJhCqb4RwKWNGD91iZmER+d?=
 =?us-ascii?Q?KbKo6WdJPkwCFi8dAGvELC9mLJ+3oLTuMLlMmpE8QbsfBu4V2KGTXcV67Vop?=
 =?us-ascii?Q?dgbwRI33bXBA/Mz2j2ZUMfX6oTP8ZAwYMW6VOHjjCasAW8H92iIr8i67Fz0L?=
 =?us-ascii?Q?jzlXotwOGav2cm7Kq2IVkIGSzvJ/C03f+0CVQ1ApDBIGzdYpKnYPekf08x7A?=
 =?us-ascii?Q?J6YK5EYOmfZNqFEilzEqTMi/5G1JOcCkmOxeBgQ5H7p7Xxas0L8ywAAmRCTm?=
 =?us-ascii?Q?CrTah3dbJ2R2vxbYAE6CXoHQeeHofi15j0mCeBm+uTRixpoPpy8KfDgt0enh?=
 =?us-ascii?Q?QmNFyS5VtFTPU+WqxUxuHCp9Gs5Qma/c08RFVBODDV75RfwBDTdDpgqh2+CV?=
 =?us-ascii?Q?lGCjEmPix45OV6iMLddAZ7Rv+FNr/WZk+oWeohS+YPU6cf8S2qx4cBouD4XT?=
 =?us-ascii?Q?xYvsbzPSof4lV0NtUYqLrUdNM/O90sM2Th6aEhc9snsfo87OdjkcC7mmMKmo?=
 =?us-ascii?Q?EzZg+JPV6nC9V59fTVXUUomWNb+dlfPzyXCil9g29/v8+q/Zc2mIskq47jjv?=
 =?us-ascii?Q?lOM0o1sryQqPSzPxThlnTX5rpbHp9IwGV0E5S4eN1bCAiJC06kfX80nOOco1?=
 =?us-ascii?Q?6iSerqwfpP1lxf1SIgYXC+vLm3FNforWaJ+B03EJXOaffllLgj1usNrACekg?=
 =?us-ascii?Q?Jy0jTApd4jdnqqjw3gKGF8hgx/0gy2CleclhEeTz1tsPZF0mc0fZfS4W4nEz?=
 =?us-ascii?Q?YfLLuKMyKg=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e4fcb55c-4165-4c9f-50a1-08de5d0795d3
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9366.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jan 2026 18:20:29.6652
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: h/N/xkNXKIbTxk6SrzRLSmpGl9GjmzMR2/ZZNWIuQGnJNtH3CEW0tz4dttb6JZCjQg6QzRqzlVnFFEC6gozKWg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8187

On Fri, Jan 23, 2026 at 07:07:48PM +0100, Niklas Cassel wrote:
> Add bar{0,1,2,3,4,5}_size attributes in configfs, so that the user is not
> restricted to run pci-epf-test with the hardcoded BAR size values defined
> in pci-epf-test.c.
>
> This code is shamelessly more or less copy pasted from pci-epf-vntb.c
>
> Signed-off-by: Niklas Cassel <cassel@kernel.org>

Reviewed-by: Frank Li <Frank.Li@nxp.com>
> ---
>  Documentation/PCI/endpoint/pci-test-howto.rst | 16 ++++
>  drivers/pci/endpoint/functions/pci-epf-test.c | 92 ++++++++++++++++++-
>  2 files changed, 106 insertions(+), 2 deletions(-)
>
> diff --git a/Documentation/PCI/endpoint/pci-test-howto.rst b/Documentation/PCI/endpoint/pci-test-howto.rst
> index dd66858cde46..71975721cfd5 100644
> --- a/Documentation/PCI/endpoint/pci-test-howto.rst
> +++ b/Documentation/PCI/endpoint/pci-test-howto.rst
> @@ -84,6 +84,22 @@ device, the following commands can be used::
>  	# echo 32 > functions/pci_epf_test/func1/msi_interrupts
>  	# echo 2048 > functions/pci_epf_test/func1/msix_interrupts
>
> +By default, pci-epf-test uses the following BAR sizes::
> +
> +	# grep . functions/pci_epf_test/func1/pci_epf_test.0/bar?_size
> +	  functions/pci_epf_test/func1/pci_epf_test.0/bar0_size:512
> +	  functions/pci_epf_test/func1/pci_epf_test.0/bar1_size:512
> +	  functions/pci_epf_test/func1/pci_epf_test.0/bar2_size:1024
> +	  functions/pci_epf_test/func1/pci_epf_test.0/bar3_size:16384
> +	  functions/pci_epf_test/func1/pci_epf_test.0/bar4_size:131072
> +	  functions/pci_epf_test/func1/pci_epf_test.0/bar5_size:1048576
> +
> +The user can override a default value using e.g.::
> +	# echo 1048576 > functions/pci_epf_test/func1/pci_epf_test.0/bar1_size
> +
> +Note: Some endpoint controllers might have fixed size BARs, or reserved BARs,
> +for such controllers, the corresponding BAR size in configfs will be ignored.
> +
>
>  Binding pci-epf-test Device to EP Controller
>  --------------------------------------------
> diff --git a/drivers/pci/endpoint/functions/pci-epf-test.c b/drivers/pci/endpoint/functions/pci-epf-test.c
> index b785d488c284..fda257e46920 100644
> --- a/drivers/pci/endpoint/functions/pci-epf-test.c
> +++ b/drivers/pci/endpoint/functions/pci-epf-test.c
> @@ -63,6 +63,7 @@ static struct workqueue_struct *kpcitest_workqueue;
>  struct pci_epf_test {
>  	void			*reg[PCI_STD_NUM_BARS];
>  	struct pci_epf		*epf;
> +	struct config_group	group;
>  	enum pci_barno		test_reg_bar;
>  	size_t			msix_table_offset;
>  	struct delayed_work	cmd_handler;
> @@ -76,6 +77,7 @@ struct pci_epf_test {
>  	bool			dma_private;
>  	const struct pci_epc_features *epc_features;
>  	struct pci_epf_bar	db_bar;
> +	size_t			bar_size[PCI_STD_NUM_BARS];
>  };
>
>  struct pci_epf_test_reg {
> @@ -102,7 +104,8 @@ static struct pci_epf_header test_header = {
>  	.interrupt_pin	= PCI_INTERRUPT_INTA,
>  };
>
> -static size_t bar_size[] = { 512, 512, 1024, 16384, 131072, 1048576 };
> +/* default BAR sizes, can be overridden by the user using configfs */
> +static size_t default_bar_size[] = { 512, 512, 1024, 16384, 131072, 1048576 };
>
>  static void pci_epf_test_dma_callback(void *param)
>  {
> @@ -1070,7 +1073,7 @@ static int pci_epf_test_alloc_space(struct pci_epf *epf)
>  		if (epc_features->bar[bar].type == BAR_FIXED)
>  			test_reg_size = epc_features->bar[bar].fixed_size;
>  		else
> -			test_reg_size = bar_size[bar];
> +			test_reg_size = epf_test->bar_size[bar];
>
>  		base = pci_epf_alloc_space(epf, test_reg_size, bar,
>  					   epc_features, PRIMARY_INTERFACE);
> @@ -1142,6 +1145,87 @@ static void pci_epf_test_unbind(struct pci_epf *epf)
>  	pci_epf_test_free_space(epf);
>  }
>
> +#define PCI_EPF_TEST_BAR_SIZE_R(_name, _id)				\
> +	static ssize_t pci_epf_test_##_name##_show(struct config_item *item,	\
> +						   char *page)		\
> +	{								\
> +		struct config_group *group = to_config_group(item);	\
> +		struct pci_epf_test *epf_test = container_of(group,	\
> +					struct pci_epf_test, group);	\
> +									\
> +		return sprintf(page, "%zu\n", epf_test->bar_size[_id]);	\
> +	}
> +
> +#define PCI_EPF_TEST_BAR_SIZE_W(_name, _id)				\
> +	static ssize_t pci_epf_test_##_name##_store(struct config_item *item, \
> +						    const char *page, size_t len) \
> +	{								\
> +		struct config_group *group = to_config_group(item);	\
> +		struct pci_epf_test *epf_test = container_of(group,	\
> +					struct pci_epf_test, group);	\
> +		int val;						\
> +		int ret;						\
> +									\
> +		ret = kstrtouint(page, 0, &val);			\
> +		if (ret)						\
> +			return ret;					\
> +									\
> +		if (!is_power_of_2(val))				\
> +			return -EINVAL;					\
> +									\
> +		epf_test->bar_size[_id] = val;				\
> +									\
> +		return len;						\
> +	}
> +
> +PCI_EPF_TEST_BAR_SIZE_R(bar0_size, BAR_0)
> +PCI_EPF_TEST_BAR_SIZE_W(bar0_size, BAR_0)
> +PCI_EPF_TEST_BAR_SIZE_R(bar1_size, BAR_1)
> +PCI_EPF_TEST_BAR_SIZE_W(bar1_size, BAR_1)
> +PCI_EPF_TEST_BAR_SIZE_R(bar2_size, BAR_2)
> +PCI_EPF_TEST_BAR_SIZE_W(bar2_size, BAR_2)
> +PCI_EPF_TEST_BAR_SIZE_R(bar3_size, BAR_3)
> +PCI_EPF_TEST_BAR_SIZE_W(bar3_size, BAR_3)
> +PCI_EPF_TEST_BAR_SIZE_R(bar4_size, BAR_4)
> +PCI_EPF_TEST_BAR_SIZE_W(bar4_size, BAR_4)
> +PCI_EPF_TEST_BAR_SIZE_R(bar5_size, BAR_5)
> +PCI_EPF_TEST_BAR_SIZE_W(bar5_size, BAR_5)
> +
> +CONFIGFS_ATTR(pci_epf_test_, bar0_size);
> +CONFIGFS_ATTR(pci_epf_test_, bar1_size);
> +CONFIGFS_ATTR(pci_epf_test_, bar2_size);
> +CONFIGFS_ATTR(pci_epf_test_, bar3_size);
> +CONFIGFS_ATTR(pci_epf_test_, bar4_size);
> +CONFIGFS_ATTR(pci_epf_test_, bar5_size);
> +
> +static struct configfs_attribute *pci_epf_test_attrs[] = {
> +	&pci_epf_test_attr_bar0_size,
> +	&pci_epf_test_attr_bar1_size,
> +	&pci_epf_test_attr_bar2_size,
> +	&pci_epf_test_attr_bar3_size,
> +	&pci_epf_test_attr_bar4_size,
> +	&pci_epf_test_attr_bar5_size,
> +	NULL,
> +};
> +
> +static const struct config_item_type pci_epf_test_group_type = {
> +	.ct_attrs	= pci_epf_test_attrs,
> +	.ct_owner	= THIS_MODULE,
> +};
> +
> +static struct config_group *pci_epf_test_add_cfs(struct pci_epf *epf,
> +						 struct config_group *group)
> +{
> +	struct pci_epf_test *epf_test = epf_get_drvdata(epf);
> +	struct config_group *epf_group = &epf_test->group;
> +	struct device *dev = &epf->dev;
> +
> +	config_group_init_type_name(epf_group, dev_name(dev),
> +				    &pci_epf_test_group_type);
> +
> +	return epf_group;
> +}
> +
>  static const struct pci_epf_device_id pci_epf_test_ids[] = {
>  	{
>  		.name = "pci_epf_test",
> @@ -1154,6 +1238,7 @@ static int pci_epf_test_probe(struct pci_epf *epf,
>  {
>  	struct pci_epf_test *epf_test;
>  	struct device *dev = &epf->dev;
> +	enum pci_barno bar;
>
>  	epf_test = devm_kzalloc(dev, sizeof(*epf_test), GFP_KERNEL);
>  	if (!epf_test)
> @@ -1161,6 +1246,8 @@ static int pci_epf_test_probe(struct pci_epf *epf,
>
>  	epf->header = &test_header;
>  	epf_test->epf = epf;
> +	for (bar = BAR_0; bar < PCI_STD_NUM_BARS; bar++)
> +		epf_test->bar_size[bar] = default_bar_size[bar];
>
>  	INIT_DELAYED_WORK(&epf_test->cmd_handler, pci_epf_test_cmd_handler);
>
> @@ -1173,6 +1260,7 @@ static int pci_epf_test_probe(struct pci_epf *epf,
>  static const struct pci_epf_ops ops = {
>  	.unbind	= pci_epf_test_unbind,
>  	.bind	= pci_epf_test_bind,
> +	.add_cfs = pci_epf_test_add_cfs,
>  };
>
>  static struct pci_epf_driver test_driver = {
>
> base-commit: c0dbaab0524adbc90d693aa15ab84354dd71acb2
> --
> 2.52.0
>
