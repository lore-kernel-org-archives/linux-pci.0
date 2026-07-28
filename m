Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011045.outbound.protection.outlook.com [52.101.70.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DED64734DC;
	Tue, 28 Jul 2026 19:26:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785266819; cv=fail; b=EVeFv8EIFW7MwL0ceSmIi0rGDMrCAKPjrytUJcGTNrf6BtKP4X08pxZ7ajqjmmqNI+jqVBGhqXNNuB0LVvvIkrJoN3U2J1/ZhKoNaEgO/lb8U5B5ZmblH05aEEcif2MQfDtOUG2N1OLC5hh7nq6ZHEsDQmHXli++JN/yUqdpyV8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785266819; c=relaxed/simple;
	bh=m7zfziCJZyPTRhmccbITrlqxtj06S849DSXqKKiFTAI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=RvP2FSc6E7+d16mXizGi2NU3GvtvcYGUTiQ5qVsFI6kGbZr4D5iAOLL0Fjcz7+0WJi/ouepHD5MT7FSYH+OXipbEMcwWgr8WI+By3F5/Dml6lKUO55Kb+cUd5X9BjN+w+yM83m0L8Z2wQcsIbqcmEyWiJikvJ3SqiKxDUDjvOiQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=jPV4kjDa; arc=fail smtp.client-ip=52.101.70.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="jPV4kjDa"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pwoAZ1nlOBsxO0Q3oP4NONVsJOhVs0kSGXHubEw4lOD+UOxNKsQRMNBf8Oo+1EeMCQKgzxKVPpLZyQslBN2Ifal8qWd6e2bTdCap898FjwCeN5DXUHPlG4n/zNYAEslNyTVRgAI2kodDRk4U1gcydgiPhIOsCJU1+ateLLX9XW43t02Ib4LcDpBVRlPNlAu8TThHOqsYD2Ed8YjAyKahr8ZmdjOygV4VxdcAf8kERhzMssG8YIvMOSauI6r1TafPWWzglhbai3z4+MH+frzeVqTI12HVS09quGGfgIgkA5AY7T84CMEPk5Psmc7ixj4nRYwIeBRHq8bmbakenh2sxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xNucg/0Mmnut6LJzdFtgNijYtLYz+pVbvdYqA5QCezc=;
 b=trcVuxZrH/Gda+m/XFPrR88OgymLd35jvveVmIoj5PrsWZdhqB+Mq6xd6TT036781FEaDnPUH1b7QKVWEFWbk+mEON+xFLIG2qDfYOvRPGjpV9ffBAtNLHYGGpY+pYArorn9VLqNUPNMsagXtmIJwWT1Q7BpnP/xC1QdgFkpPlxvbcCwuMEZZyqRK6n3wjAlrpkioU+KUrT4CHQrOs4RPTULOFj8cFBT7D4edvDbaV//BbipU37QGzguiK59J0SCcPRILIDtDx+brkb30y4/0REupUvBHKIljHJvRTJYYM89fMPP72ewQjsOHutZakuZZpxgIpKhC7krXlVOjujgEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xNucg/0Mmnut6LJzdFtgNijYtLYz+pVbvdYqA5QCezc=;
 b=jPV4kjDaqIZ6bJ2o+h8Wh1XKTZ0n4CteXo7kCjRdwPNwKBKIs6D4rGCxAE3Pc3fk23i0U0V8tyYBOdDQZzHwF5tcRZIHG3Xd8TxZ4zZqqCwSCsa/BUo/tSNVgIq3/MREqAuz042kGwKfei6V9dXUhV9kDuY37G5lS6Ea8eMgQ/C0xTKm0T9D5F2x7aqaA9uUOWbhH/9vsAFTpQ9u1RJMaODoSRdkT/bX++9OfxuAl2oRzMAiCFWAGREeco+zKHG1qPeglG6lX7Fc0aZEYFpvzHWA4v5KO4MrZuXGBgAiltzbNU0F8xukOj13kQTRmdB5VScjqtzJTsykscLOcKOyzg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9)
 by DUYPR04MB12666.eurprd04.prod.outlook.com (2603:10a6:10:65f::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.13; Tue, 28 Jul
 2026 19:26:51 +0000
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c]) by GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c%7]) with mapi id 15.21.0270.009; Tue, 28 Jul 2026
 19:26:51 +0000
Date: Tue, 28 Jul 2026 15:26:44 -0400
From: Frank Li <Frank.li@oss.nxp.com>
To: Koichiro Den <den@valinux.co.jp>
Cc: Manivannan Sadhasivam <mani@kernel.org>, Frank Li <Frank.Li@nxp.com>,
	Niklas Cassel <cassel@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>, Jon Mason <jdmason@kudzu.us>,
	Dave Jiang <dave.jiang@intel.com>, Allen Hubbe <allenbh@gmail.com>,
	linux-pci@vger.kernel.org, ntb@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] PCI: endpoint: pci-ep-msi: Let non-first EPFs use
 embedded doorbells
Message-ID: <amkCdJKg2enzDC6D@lizhi-Precision-Tower-5810>
References: <20260728172306.2751813-1-den@valinux.co.jp>
 <20260728172306.2751813-4-den@valinux.co.jp>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260728172306.2751813-4-den@valinux.co.jp>
X-ClientProxiedBy: SA0PR11CA0041.namprd11.prod.outlook.com
 (2603:10b6:806:d0::16) To GV2PR04MB11799.eurprd04.prod.outlook.com
 (2603:10a6:150:2cf::9)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB11799:EE_|DUYPR04MB12666:EE_
X-MS-Office365-Filtering-Correlation-Id: d94c7a70-a48e-463d-5d39-08deecde2d05
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|366016|23010399003|19092799006|7416014|4143699003|11063799006|56012099006|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	MjVqy1a4bIJrwPSSouF7osgNcpeVsQG/Wi0e9x/svt85YXxLTnEq87y9kwmXAE9ZKWCPgxDaaShqJvWtccSuCIqQezYEpWZCiryos5atw6Oc4MVwsRBnrMk0l0Kv7UaiYixgVLp+PPBAE4VsTPEXPoTAE0TATGJR22QC4D3yuP6Wgqc5dLT0ME2aDdGWpo3yfLt4SZc4pT2j5HipU6vqZ8iLtS1xsvqC4dUGVO43YJOt02XGgQbggT4ulqzeAO8Lx85iGx2il6YBknfsQOtsEQnFyttYo9L0r9+5oed/CDN+IG/l+o++lpUKj/zQZvvAvS5SkJ2sfVY9MkSaqWwwtACJHjiSVQ3S+c7lpcAmMH99KpFhwZ3M1eZDIH+EmBujl0WxhRGLcWwfh1GRkM15iNxBksKd0WmgufaKOV2bO7M27goKMY+ZlAPwkEsJnLQXrdb3j5HDUs53JrSUAvPuG+r9msq35lGQT/y5gqCnyY1q8GQ60H8ylrUsBNc9LDUWtS4qabvm+RHYL1PKE0owkxDGSbi4nujAeB2Mtz6vZ030tp3i3J4Nl59gsvNd39Ud3JLhfO/yLHISiyv6Jgl52ZsY473sSwxXeHgaxLIiAJwqtNVn0Bf4O5DNEtuiY3bI+knm6WEkCOuWlwLPLxxh4dC0bx8LTjR31YymkcJ7Xgc=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11799.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(23010399003)(19092799006)(7416014)(4143699003)(11063799006)(56012099006)(10067099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?IB61jyA7GQakQenUbZQ/j4qORWhCCwO+27x4s7yA+GwfpgQui1mnP1wjCbVa?=
 =?us-ascii?Q?L2ceJD8vQtUlsb4RWel3ZSgAOuXXirS7PTOnQvTC1kfW+DH4gHckU2GspEdW?=
 =?us-ascii?Q?fkgAd+Zl+W0YNSGLijO5BRouDGroCerWTHbOUpVgTXGbQViEDLE5stRxO5P7?=
 =?us-ascii?Q?gOLKAMhQy2hF8t3A71J5KkrV67f+NwLYWQnAW5sG6OGaPQWjesbBNAM2Cgi1?=
 =?us-ascii?Q?bYCzHVB1IpiOwb4QEWjrQaPkh6zmz6zt4CJFMLlq39awngad29O+09hLOPmk?=
 =?us-ascii?Q?44MOfgexW6fsHO4PZtQ3M2QZC3YpaKSlQOmUfx4baHJZIc0NrlnnhZoI+k3j?=
 =?us-ascii?Q?/1Umuj9pm8mPLqF6aVgaf+UAp7K9Hg8Pwf3up9aKZ0G41+3xBnq89ZB94Sdm?=
 =?us-ascii?Q?s/dTevI0lcw6NRJ7Cw4V/pTv2xKJbBFlvKA72KHT4EShmWsNOf8IRbK3DjWU?=
 =?us-ascii?Q?doCgOAKDSLDaezFM9pfc4zwu+qqy2tjBl8llNIUrYkW9rjYhMlNYjP6K4gHS?=
 =?us-ascii?Q?76j3yPFMJuVQUx7SkhPZqDV0DgCqbF8sPI3k+jqu6fxbwd0VxuNWn/ION2SP?=
 =?us-ascii?Q?fK3t9Xg4Wpsb150XOhL2MRp2mMURSvUeL30AH4pF5dkgS4uQb29Fv5cGWxur?=
 =?us-ascii?Q?qxzzo1Usv6zIRkpfNrLdBIWW26fYg+cLpwsJTUt4NrIefKzGU4cV2lhxMUa8?=
 =?us-ascii?Q?4UgRWdYo3eZfPSIO0hILKR0bS+p+i+f7a8q1AyL7YKmCCQ7cjLMgnWqX8yaH?=
 =?us-ascii?Q?XXOIvq9KIqX9PtQa+ywN9Hq0s7c/dfUcP5mkSd44s1Ji5x8+IDXCumiyoWKn?=
 =?us-ascii?Q?iwrahoZwJ2sHmZ13Ncg5H67r+rjXX+RWMtX8DGYRZOFH6Pbk4IVxL9IlvhPa?=
 =?us-ascii?Q?TizuZPf0nnnmnXnTlIqOrQSYugWdp6GtaZRM1bGoVNfs30WcXILGj883sae2?=
 =?us-ascii?Q?JY5DmISt5/oXed7sOpgJDQFa+3qi/OwvgvKaTGScOYiLViEbEZHlCdWT2yLx?=
 =?us-ascii?Q?l6ucM1ix+9d3NR/Sxj8kR34SykwSu9fYxNogRRvuvVMLMaVUHRjZ98q+QXN4?=
 =?us-ascii?Q?+PCq1gwKyzOFCJdG+iXHRQ4D6ovNE+291c8cHR96aoCiQ8s1ii+zo1L99uVP?=
 =?us-ascii?Q?yzyXZYL1cFWb0QfzIWJbkAKX87/NtTi6uL5j0EjeABC42vjYC3WDpO0mteVX?=
 =?us-ascii?Q?OX5GDmNRDpdYWzJPP10uggzG/ASzGRdGDaBMD9XNTPmmxQBxa5Ixl5A+y+83?=
 =?us-ascii?Q?QrigUrPgMmP0weOicpwMZQNHnWrsMA9ZLKv2Rp/IhsP8mcMgafq8CEijKpGj?=
 =?us-ascii?Q?qLZ4b+ngczCeSVtKrGUiLs4EVNq2TaelTa8MO3Xta0QyhhCa08B6odNPgdXa?=
 =?us-ascii?Q?O+Z/9xXjrKy67LILTEX428uMyME2G8m6IXlB4NRGytTw8nibR/2NsbX51rQu?=
 =?us-ascii?Q?Khmp19aA3S58BOckX37CzJytqPlW/YoHNmrbrfUQgb/+uC9v9pRGUkyikX/M?=
 =?us-ascii?Q?Ou+0D+cbAdfus3aJeEOLaFT6WaAsXH9HkmGXot+kvKzlx9OlEcEMVTOBeygi?=
 =?us-ascii?Q?K8wE6Ny7GLTZqCX5G3wyV3nfqPELBw1RAFEGv7K3WD3U0YGQ+ulRXKgy9NHb?=
 =?us-ascii?Q?HpD9fw/arVvghqqGV29XQsi+MMvAt8F8++YFqM9q6+eluZgmWZGuoBnzl01z?=
 =?us-ascii?Q?IiDUl4e8fpjvyLq8pd0pcC4sPSf5MweY62HiKkh6NfhqEpmxky4jM1Ly9aT9?=
 =?us-ascii?Q?J3vfu9PRatzRJelX6DjEnE2kfPkihOz5Fox4UD/JoAYo7kd2v42h?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d94c7a70-a48e-463d-5d39-08deecde2d05
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2026 19:26:51.7179
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lMcsQ7nfn0MnqzKrK9lfUWSjq8HXuKimrJ3YW0g1j3rd1t8wxeFeSDXNIGRZn5CPTIwNROJYaxlESSh1UkLqCr25nIet0RgtrUnsFOIxhZwiz87kAUBkz25PhD2QATkF
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DUYPR04MB12666

On Wed, Jul 29, 2026 at 02:23:06AM +0900, Koichiro Den wrote:
> pci_epf_alloc_doorbell() rejects every EPF that is not the first one
> attached to the EPC because the MSI-backed path can populate doorbell
> messages only for that EPF. This also prevents non-first EPFs from using
> the embedded doorbell backend.
>
> Keep the MSI-backed path limited to the first attached EPF. Let
> non-first EPFs skip it and try the embedded doorbell directly. The
> embedded IRQ is exclusive, so a second embedded user fails to request
> the IRQ instead of receiving another EPF's notifications.
>
> Signed-off-by: Koichiro Den <den@valinux.co.jp>
> ---

Reviewed-by: Frank Li <Frank.Li@nxp.com>

>  drivers/pci/endpoint/pci-ep-msi.c | 31 +++++++++++++++++--------------
>  1 file changed, 17 insertions(+), 14 deletions(-)
>
> diff --git a/drivers/pci/endpoint/pci-ep-msi.c b/drivers/pci/endpoint/pci-ep-msi.c
> index a123a189b4e6..5ea7eef9794f 100644
> --- a/drivers/pci/endpoint/pci-ep-msi.c
> +++ b/drivers/pci/endpoint/pci-ep-msi.c
> @@ -199,28 +199,31 @@ static int pci_epf_alloc_doorbell_msi(struct pci_epf *epf, u16 num_db)
>  int pci_epf_alloc_doorbell(struct pci_epf *epf, u16 num_db)
>  {
>  	struct pci_epc *epc = epf->epc;
> +	struct pci_epf *first_epf;
>  	struct device *dev = &epf->dev;
>  	int ret;
>
> -	/* TODO: Multi-EPF support */
> -	if (list_first_entry_or_null(&epc->pci_epf, struct pci_epf, list) != epf) {
> -		dev_err(dev, "Doorbell doesn't support multiple EPF\n");
> -		return -EINVAL;
> -	}
> -
>  	if (epf->db_msg)
>  		return -EBUSY;
>
> -	ret = pci_epf_alloc_doorbell_msi(epf, num_db);
> -	if (!ret)
> -		return 0;
> -
>  	/*
> -	 * Fall back to embedded doorbell only when platform MSI is unavailable
> -	 * for this EPC.
> +	 * The MSI-backed doorbell path currently targets the first EPF attached
> +	 * to the EPC. Let non-first EPFs try the embedded doorbell instead.
>  	 */
> -	if (ret != -ENODEV)
> -		return ret;
> +	first_epf = list_first_entry_or_null(&epc->pci_epf, struct pci_epf,
> +					     list);
> +	if (first_epf == epf) {
> +		ret = pci_epf_alloc_doorbell_msi(epf, num_db);
> +		if (!ret)
> +			return 0;
> +
> +		/*
> +		 * Fall back to embedded doorbell only when platform MSI is
> +		 * unavailable for this EPC.
> +		 */
> +		if (ret != -ENODEV)
> +			return ret;
> +	}
>
>  	ret = pci_epf_alloc_doorbell_embedded(epf, num_db);
>  	if (ret) {
> --
> 2.51.0
>
