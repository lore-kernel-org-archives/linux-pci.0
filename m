Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010048.outbound.protection.outlook.com [52.101.193.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F8752E7165;
	Wed, 25 Mar 2026 03:49:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774410567; cv=fail; b=XUp4+x7Q88LJOkB3rgem9yna9Nb9INHAz6Yp0F2MmJAsqOySWBd9VNkx76HFmUcq6Vl5JaOM7eN4xvyMOZ5vkWXnsKBJo+55/jP5iPRDrwXtCb0xc+9D71Co2aKSmsOc6Q5WXaMRZ4lzowZH8ZNR5haJ7JFpoHn8FM341rCauuc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774410567; c=relaxed/simple;
	bh=PAJLD58R3aJu7pRHWmneqfPTl4lk5/S0hQnK6uMj+qw=;
	h=Content-Type:Subject:From:To:Cc:In-Reply-To:References:Date:
	 Message-Id:MIME-Version; b=Us8XSNiayUSOn0j2kt5+6BjlZ169ssLDym/WaiS80WRsNA1ONu0i5mXrg+vmRlrg5N32g+cBAOTTS1sVXLfjLJ3VfwrifuXXPuGx5JlUXwNeoqcm5EIyYizZ6bLif8OLccRdRguDnfuYSDyFbjPgtg1nwp2zTK4IXdwF4QK6SI0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=NKj2B6Gl; arc=fail smtp.client-ip=52.101.193.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="NKj2B6Gl"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SXuEpCyAO4+VbKFoxgU638LJZFAa+mmsX35tJBWbZFYuNDFP9qVuutIqvV2KlFUlkogrs3FCOJ4q0JKd+w9VAZx7ErMyF+ugIyYolmd75zIfuh1/ur+o5LIMF+0yqNJBj5AMh8lJRriXDvudPaPI1tR2mgMb70heL9rB1Q7t2qzKsESoRQVpT95d0OJ//TiWNaaEDbGc8an4osE7WA6L3ktKM28wcC5zHVk1t2SgsABdqDTDbmnLUWVQgVQ7B90K8KNBEMdP5ZgHsihLJZlK4Phs9cmU2/vMFkb3CyD0dJsUkh7U1+juyn67db2ZTnZ3B2ZgZvNCDbBP7W5lJu+TAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5CUJMi5iX/18lXeUHXVT5MTraQJvuErimksoqsvra1U=;
 b=vfECr1UyHuAWWSSQUUSkXCfABPKCjXLSPUy/SddSOVkUebfxsp1bMo2MV3fBw0VwJ0bOny8BU2RGJfyRRKgOD+gJVu+0f53Iwkoa62MUXHnZ8MGfuKPt9wYonhQ9GR3Km6Afzvzyq2ZAZoC6FN2Tzn0Kugs03u9AkuN9651YT3yP6ENorwPFRa0/AuE1tfrP6pPLYr61RucJ3cMfSdwmoshtlkO1VTPaDoTmyxheH8O0prrEw76I5J0/ok1E+EbHNGCAKYonEXO0AE/bHw0uJ21SVIm41TIkkJvdDu09K6+Yoxv5c05vV0/MdmWvV7azvd3niSn6dLpTSkRkkB3wRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5CUJMi5iX/18lXeUHXVT5MTraQJvuErimksoqsvra1U=;
 b=NKj2B6Glk+wIp3EFUGa4aCnMi6ujO3OLev0bad/OaFjmSNOe8/ya4xHqKeANRK7qDwPjUU9RlZr1JimVc3z0zcr5x61oII+fGwlR2v6HksFk1VnU6ZpwFZf2fk17LffFNlTt3CEwybD6O/DY2biH1faA6DINiGVvyxpKuWfwnXY2QWW+WrJbe2QuFkZt8NrFph3U1f8FQJX0iEstju72wbDIYD9K8X85XuJzWYEBexQMPS7z/sZo60dlNd9NaWJViEBkjZ8gvPlh6pA1jyjCTy6c1mKSXNhR+d/x7YygWsEdf3Ng3JrkxmT1DkOfJ6J4FfFrMm2H4AX5A0dadKuIAQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ2PR12MB9161.namprd12.prod.outlook.com (2603:10b6:a03:566::20)
 by MN0PR12MB5884.namprd12.prod.outlook.com (2603:10b6:208:37c::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Wed, 25 Mar
 2026 03:49:22 +0000
Received: from SJ2PR12MB9161.namprd12.prod.outlook.com
 ([fe80::d9d1:8c49:a703:b017]) by SJ2PR12MB9161.namprd12.prod.outlook.com
 ([fe80::d9d1:8c49:a703:b017%4]) with mapi id 15.20.9745.019; Wed, 25 Mar 2026
 03:49:22 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v2 4/5] PCI: tegra: Add Tegra264 support
From: Mikko Perttunen <mperttunen@nvidia.com>
To: Thierry Reding <thierry.reding@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Jon Hunter <jonathanh@nvidia.com>, 
 Mikko Perttunen <mperttunen@nvidia.com>, linux-pci@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-tegra@vger.kernel.org
In-Reply-To: <20260320225443.2571920-5-thierry.reding@kernel.org>
References: <20260320225443.2571920-1-thierry.reding@kernel.org>
 <20260320225443.2571920-5-thierry.reding@kernel.org>
Date: Wed, 25 Mar 2026 12:48:50 +0900
Message-Id: <177441053067.494795.3366002972241434311.b4-review@b4>
X-Mailer: b4 0.16-dev-ad80c
X-ClientProxiedBy: TY4P286CA0140.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:37f::7) To SJ2PR12MB9161.namprd12.prod.outlook.com
 (2603:10b6:a03:566::20)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB9161:EE_|MN0PR12MB5884:EE_
X-MS-Office365-Filtering-Correlation-Id: 46db42c0-8996-4e91-7df8-08de8a218061
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|10070799003|7416014|376014|366016|7053199007|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	mBV8DomFcGKuQcxXxDBYGrhzjSyb5PegOGV0HRl7wA0NPKX7W/FpHeyVDkyfVbUzTEINhVyJqLWjgF32pGakFV4nGpq/zp2hstN8JD8zByaKX5up3J7RqNytYhpZ91t7VPGQHyOZ4SgtEmCvb+xnCWsymLhnamoZnqNiE4KQLfOLWNIL0dJClAnfiFwWvMrGAF7OWN8XN4moYMr8hy8upApSBEoQsL9IrJcl7V0Aj/+zRrRjmT755fGMl3QBnebWNjtU2/iyOmt8U4/PNnlXQ7CUnn6kLUzkvnSP+iXmBUXlmjYLNlNhxJke2yc/fm0ecVC7aa7Ijm/uOfzo4+fvY8zjbyTRyaq6o/XsMttIAN3mkeJurpwFK86js8hZS33ZzEqHKARwtP2f+PVC4KmtYCq1aEqGQHLkpOuwelerr+xX1Kykx1BFLevPiUPEJKHrXHRtR+j3lZG2XtbJ22GlkGFF86RmexHW3+hioauaxOcjhmaTQL8glcZHl6r+PVvsKPH5vZFnUeLBMbCPvxtahSFhCiPr+XPgPuFBtrpMqX/aqYZm6S8j+IIXO1XfrhqInRxO+Z/sZzRDHchXfIoMYJLFOZ4hk90jPWpHwhMXo1BUirwfmvwMNiVJaY14jIuO5YQBxoQAt795wQvNnxKgha5Rbk0HKUV0D7yHmHS+KUghGglGIcO0SeYNIlSa8eOOfXgQwcwoRajyo6CzdspZUT8WlTZQqglbDh+Vt694RX8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR12MB9161.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(10070799003)(7416014)(376014)(366016)(7053199007)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?amlTTCtDR1paZ2I3OVdIS1k2Ty8rbE9NQ3ZESTI0MGh4K1FIcFhKL3NBeTBW?=
 =?utf-8?B?cVc4Wm8vdjVQU3ByQXQvaVdFNHhNUTU2ODNydElLUnBNaWNXdyt4Njhrb1E5?=
 =?utf-8?B?TytlazB1T1VIVjNRb2tNYXUxVHRKWUpCY2xyK1hVaUxCZkxmenpGSVVCZTN4?=
 =?utf-8?B?VmRSU01CTlJLMitqcnNIUDJBREFnWExHYmpobERQalhpcnpVZTR3ZEpzdjBi?=
 =?utf-8?B?bFcyN0k0QlBIRUJZa3AvcmtjQVpZMVV0THF6N01FdjZvdFI4bmEzM2JtRCsx?=
 =?utf-8?B?SE9TUGIzZmtpZlBIZEFmZjAvWGRBNGJrWTBXTzc1R1E0V1J6NHlpZHpyYzZm?=
 =?utf-8?B?SncrTGR2ZGExMXdJZzhQLzc3ZVdwWG1xT1VGOEFSamxTRjh6bnROc0w4TUE3?=
 =?utf-8?B?T1NHdG1SS3F5YUwySzZDbThKb2k1TkxCcmNXSlUxZThPTFQ5ZlllRlpZNnhn?=
 =?utf-8?B?ZitYaG1BZW0wMFR4S3cvdnRidTA2QWxFRHN4Rm0zNGV6Zm1NT01nYThSNU5P?=
 =?utf-8?B?K1FwYjdSdmUyVmxNRUpTNlhwSjFUbUsydk5QQjdwY0R5cDMxV1FWSnB5K1B1?=
 =?utf-8?B?bUFpcVV2NFBLUUNWcCtSQnlld08vZDkvMGJ5WlNHNUVsWVVvNWdLTHBvb3Ns?=
 =?utf-8?B?eit2UFN5L1dYKzViVE1SaGlxeXNiQSt2ZEcvTFlSWU1OU2wxcTR3VGdWZk1a?=
 =?utf-8?B?bWJhMnBXNnVhWjJ5dm94a0syZ2NGOWFBazVlSjNhZGdLY0xVQTRKTWNBWXUx?=
 =?utf-8?B?MGdlb1d2RHRRRzdEbGNCOWd5WHpObnhlK09FZ21RbDBISlBZUzhyK0duL3p6?=
 =?utf-8?B?SDM2STJiWFZWOWtkMVBJQndkbkU2aG1BM3k4N0JFM3p2eE1LQVpYdklQN2Jt?=
 =?utf-8?B?VDdPTENOY0xyTFlnTUNuUnFNZFNjSjBNeE9sUVhncHhXZGYxMTZFRlRqZkNN?=
 =?utf-8?B?UlpXa2JISi9iZkNRR2hIMURBZlFocFg0M09xL0Jja0N0TU45TEM5MUdiMmNm?=
 =?utf-8?B?NE9HelNVbHJPWWpPMUtERUZkQUgxM2tVTU42dm9GbUE2RHMwSDFhaW9oVE5y?=
 =?utf-8?B?ek1iNGV6bGZ3RHhSeUJESFpDbE1ibGVoR0d2T293eFVtOGJYTEo3SFNycWNX?=
 =?utf-8?B?eHRBeWN2ZlJqZmM1d2t6L2hpM2NVQTV4MndPV2E0Zm55cDFwOVlMMHN6TlYy?=
 =?utf-8?B?dHNwOVg4OGJ1VzJ2TjB5ZTM3S3JTbWVPSUFmVHZtLy9SMzl6bzl0Q3hCRFFI?=
 =?utf-8?B?OERDMEpucHJ4M2QwLzhpT1JSeU5NcnRaR2VuOTRCSWpQdkxaSDBLS0grK2Vt?=
 =?utf-8?B?NVEwZDNlMXZiUksvRUJUU21heGNZVHg0VDdENFpZbjFxRENRaGlxR0FGZUp4?=
 =?utf-8?B?cTlER1pUTzFldDAyVGJqMkFaVWtHemN1RDNOVEdDN2dEc05vNG9qa3VJYW0x?=
 =?utf-8?B?eWIwR2o0aTltckM0RE9sRGQ5SkJiQ01uS0ZKVnpacjljeHJYaTVVZ0p3MDV2?=
 =?utf-8?B?S2dlUEVIczROQ00rRlI5QVp6Vjd2Zi8yWDdBY1FIbmIzbEFXOEdlQ3NOc0po?=
 =?utf-8?B?UWQ1NHFWRDFidmVVUlViR09hTXZuWHE0ck1COGR3dDYxMUZScHByU3dxcmN2?=
 =?utf-8?B?cHhkRUtGRUtMcnNWT011OTFDdi94UXdVZm1LeHFTU1BGZEgwNGtCRHNpWVd0?=
 =?utf-8?B?MVNXZnlZYWxDUkMwNWg3MFlNVTNWekRaVnlLSUl4Q1pvbVlGdmpnZS9ESk13?=
 =?utf-8?B?LzVLRDFIR0RXNS9iOTE2ZzZPa2dVS2FYNGcrTUt3RnhaZGpmenAzSll6TjFG?=
 =?utf-8?B?MUNUbnJaeUVreHR3R1dMaGd0NjMxSlZsNm00TUtaNzB0Vy8vcjQ3ZWtXOUU1?=
 =?utf-8?B?M1JBUzloWHhVNlFnRTd3eEM5akpMZGhuaXJqSzh6SVlDeUdjK1BhalhvSDJP?=
 =?utf-8?B?ME4xQTN2d3drZGpBd0hvcUtGM2phOS9iWGU4d1J4bkw1ckdKcnFCc1lXTDZN?=
 =?utf-8?B?ejREYlE1SlYzbFdkVE55SFRmeVFVK3hCb0N5RzBUSkprb3N1OUxQakF0TTlM?=
 =?utf-8?B?dTFwMUszTk0ybTlZQWg1VUpuMkJmMWdpV21SYWRlek1KNVBGbG1yWVdvb2c1?=
 =?utf-8?B?WXlMMW05SHJ6TVZmazNqNTR6OEt3WE1XbnBKUGNVZy9FRDhBSDBiYVJvWFJP?=
 =?utf-8?B?ZlpZRzJXZmk1VVlBSS9xQlltZVQzODRtd3cxRjVORDdSVGVqMXNFMUtacmxr?=
 =?utf-8?B?Mm9jaWkzM1dOYk9xeERYUXM3M3pKdFpsODFiR3dVaWNQYlUybFVOdTJLVVpP?=
 =?utf-8?B?U1hqRENPUzhjNjhPKy9FRVpEQzZJcyttalFMZ2NKL1NqVldSQVhyNTZmOFh4?=
 =?utf-8?Q?qkgHGPBWCZlBr9IgsVzk7sP/rhUKPvTSxvnHtUMiCf2vI?=
X-MS-Exchange-AntiSpam-MessageData-1: LWpRwI16m2ve1CAHT6yJyuQefnTgFnqi8nM=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 46db42c0-8996-4e91-7df8-08de8a218061
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB9161.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2026 03:49:22.6699
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Gomaoy7b/DLACbO2koPbXVJX6INnVjSNvQXxMr998ahQo1BvJTrJ7Hw9I2kAZ9WCfelSKfzbiJVG8fET6frzCw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5884

On Fri, 20 Mar 2026 23:54:36 +0100, Thierry Reding <thierry.reding@kernel.org> wrote:
> diff --git a/drivers/pci/controller/pcie-tegra264.c b/drivers/pci/controller/pcie-tegra264.c
> new file mode 100644
> index 000000000000..3ce1ad971bdb
> --- /dev/null
> +++ b/drivers/pci/controller/pcie-tegra264.c
> @@ -0,0 +1,527 @@
> [ ... skip 123 lines ... ]
> +	err = tegra_bpmp_transfer(pcie->bpmp, &msg);
> +	if (err)
> +		dev_info(pcie->dev, "failed to turn off PCIe #%u: %pe\n",
> +			 pcie->ctl_id, ERR_PTR(err));
> +
> +	if (msg.rx.ret)
> +		dev_info(pcie->dev, "failed to turn off PCIe #%u: %d\n",
> +			 pcie->ctl_id, msg.rx.ret);
> +}

Ideally we would distinguish by message in these two cases. I suppose
the %pe vs. %d does that, but it's not quite obvious.

> +
> +static void tegra264_pcie_icc_set(struct tegra264_pcie *pcie)
> +{
> +	u32 value, speed, width, bw;
> +	int err;
> +
> +	value = readw(pcie->ecam + XTL_RC_PCIE_CFG_LINK_STATUS);
> +	speed = FIELD_GET(PCI_EXP_LNKSTA_CLS, value);
> +	width = FIELD_GET(PCI_EXP_LNKSTA_NLW, value);
> +
> +	bw = width * (PCIE_SPEED2MBS_ENC(speed) / BITS_PER_BYTE);

PCIE_SPEED2MBS_ENC takes enum pci_bus_speed values rather than
LNKSTA_CLS values. Perhaps it should be converted to a static inline
function to catch such issues.

> +	value = MBps_to_icc(bw);

The result of this is unused.

> [ ... skip 271 lines ... ]
> +	pcie->ecam = pcie->cfg->win;
> +
> +	tegra264_pcie_init(pcie);
> +
> +	if (!pcie->link_up)
> +		goto free;

This path causes things to be freed, but the driver still probes. The
remove callback will then try to remove things again.

Thanks
Mikko

-- 

