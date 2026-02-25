Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013070.outbound.protection.outlook.com [52.101.83.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 324B230596F
	for <linux-pci@vger.kernel.org>; Wed, 25 Feb 2026 20:24:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772051097; cv=fail; b=RagKjZDnqX0XYSsw08mNB+V7yBe7wOUY3WmMK5y590najp/+Bri9xgMb4mozJbVn022eicUFMBlzsii16LfGVX4bZnBFIEuCKTKzkMhEXsqZWKnXjZO8SKLjADqSq0AYB+BpB44kWUMiTwGyuatuO/bcofmRXk/kxQyoh2Br6sI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772051097; c=relaxed/simple;
	bh=kFrwk44MjTHnFVg3j1r9SisFNS/SLh8KmATr/+0F0yw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=VWbxyIuEFExjgEd4EC4UPBzXaftMKguS8U6o+Qg61+0Hfxh2Ed84p6KOqNH9+t5Jtl3egRZnK16I69FrfUiZe0gkwTgiGaK8oywOatXXIrsahqhbsN9C04Tc1DTgz/heoBS4Sy3PS8muTI4LHHta3NKKz2cy8udK+QnqFq4x3sU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=ZaA71NKb; arc=fail smtp.client-ip=52.101.83.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="ZaA71NKb"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=k0/ozSC+mOQ3JW+JeBF0l8V8CQY11yKVPoWz111yRKD7sagKIL4NRTjD+95lAPWBpRdEj6iZMNPD2kcKSbcllzOIp6Upviq13QlN8rD2m5jHBcFMGK1PLSD1W6YQe48OYK9qK/owH3f+TxfOX8SKDtUN3rla/06N7X+1+qRavAp7l25VdtTMu4lIlAAlDenCLZgb3jw7L/a4sE82WAmFYtERNwYsFFyO5cp8Fd196xnOu5XUblm8mXWN4xg5PPe+4NyFth+3JCRjzCBO0ATxMphmLiYWJyFhegAFTPgKGMWcnxk14yUve+5pZDP8HGTAutVSCq2g3iqjnMX2wxb4Pw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QXE3pYy6gNfbGzkF64N19GxsrPiOZwUqpxoVfOodOpo=;
 b=sghMXLD81Bj1ng++PGpDna/kol4b3e9EpDnq2z6cttjQY4GdOoty6wXvQkSQbXRbcPoBGB+7ynLIuH6bIi7TIjXeCmK5uBwjxI0l94aLWWz8cBJ0a3xI59OMYTi3a+wYRisFI6lPr2cbywd0wb9J7Bfc/LxbtQixiw9zaU5e3Hulvt0AubqxxjV3SU4Y0M0FoKqZI653Yl/VgXsVqIWn/45W2wiS7KYWRRbJqwLwko6wxRGLGDjyxsFyENI4CyDfllUeUrQJ5ieddd5Om5IB9mLODTzrX/9yFrfEHOa2EYdxthbi944HHrWN32OyTVWcQ4LcCIx1nOGjnttWK+igLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QXE3pYy6gNfbGzkF64N19GxsrPiOZwUqpxoVfOodOpo=;
 b=ZaA71NKbBPyL4wc2VjOwqt90ig5m/F4zcTMKY5HoPJ2g/7AMkvVBSFDVEaeOYRD2zlYs4O9aB0vaHrYRArcmuij1v536EGUQKVhm1A4nNQsCvV/21u+U2JTtcTB8RGMvb+4XLbMH3QzP41NlpA0JSuYeAWsUhdoDH2ylrXn/A/jyHaGpKltTs2e5T4d2DsnUfkSmK9ZL9QmCoFz4vQnehhtdrOOIM5XdvK/5i7scsVTDhnzyoqMowP7ki1h2UeO0lrpOdYqifzUovbLRKu0+JOC4AnDV+b55SgTZyJuLvPcVd+ZZhbVy+HxRw3p3uo+vmVnh5gMmnPV2Y66PvxtiWQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com (2603:10a6:102:2a9::8)
 by AM0PR04MB7172.eurprd04.prod.outlook.com (2603:10a6:208:192::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.13; Wed, 25 Feb
 2026 20:24:53 +0000
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588]) by PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588%6]) with mapi id 15.20.9632.017; Wed, 25 Feb 2026
 20:24:53 +0000
Date: Wed, 25 Feb 2026 15:24:47 -0500
From: Frank Li <Frank.li@nxp.com>
To: Niklas Cassel <cassel@kernel.org>
Cc: Manivannan Sadhasivam <mani@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Manikanta Maddireddy <mmaddireddy@nvidia.com>,
	Koichiro Den <den@valinux.co.jp>,
	Damien Le Moal <dlemoal@kernel.org>, linux-pci@vger.kernel.org
Subject: Re: [PATCH v2 4/9] PCI: endpoint: Introduce pci_epc_bar_type
 BAR_DISABLED
Message-ID: <aZ9aj4YFDSLvepDw@lizhi-Precision-Tower-5810>
References: <20260225170324.4033466-11-cassel@kernel.org>
 <20260225170324.4033466-15-cassel@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260225170324.4033466-15-cassel@kernel.org>
X-ClientProxiedBy: SA1P222CA0117.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:3c5::23) To PA4PR04MB9366.eurprd04.prod.outlook.com
 (2603:10a6:102:2a9::8)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB9366:EE_|AM0PR04MB7172:EE_
X-MS-Office365-Filtering-Correlation-Id: 6b671e2e-df4e-4d75-98cd-08de74abef1c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|366016|1800799024|19092799006|38350700014|7053199007;
X-Microsoft-Antispam-Message-Info:
	sj3IOKmukfmB/3gG3v3WgLrjP7DrnOYwPWxRRbPDNxuchXeE6tmR3Sh5N1YYda8tGL36NkjioE8sJP8a9FdWjVM3R0lCuO1cp6RNZlXFMsl+ziLhZWDUSYh7PpRfSoP21tAuYZeehCIp1tQpENQ0+aRWqlK2H/n78U8Id2A+JVj7O/cOijgDepEw6MJ+N/EqendWHxHdg0eXZ5eB3PUJ/aDy/UNO1wG+etFHwghAFEQUDI5w/zEA6sz5l927qzAW7QTvWUASJ9lHDqdsdjp07C3m9EOLdTFymB+j8SaOh0khLxggjo+9AYZDF63uTcapDX2sjSnBLBbVSkBjBXBefhLccLbLWvHm/GwYxDXkDeW6Sd+tAqLOjfyuwr5t7blQ8MBzZhRs9jm3QU5NnRHraaTgkIq4uVj1WH4s7wax2FA8dWuoDzwAEAhPhVQO5GW3xlPF/9BKeYQhgGMbQ6PR1NI7OWxPTx8bm3urHZa5Swi70RGyoDm5+G8rfziAE91GBeio4+r9F1dMSFuAwhZvzMAsEJZRg8WjA+DR0e7uRip3QInitLRL69uVD/OFPHNYlMyOjTpa/wEX2TRyP8bQnFZnD1afXs/5NcBNzikznjQAiAK89ygbaAjJULtqxaIXC4Fy5OkPwttOkHMQpRE2drOsEVD9OMGwLhbJLHC1KMglsYTzVfDwB37qK5cLtPYrfI147fr+qBiMBT2KEEQmVm78SS0VG512lO/3j37tz0MqJQmHrjUGbPy0fPl+QDd+jO+SGS5QqktwkUBmdcolVFm1kJ0rsUetgbk7n/nPae0=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9366.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(366016)(1800799024)(19092799006)(38350700014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?/PIH5EbzsTyDyhbemC1SZ/ABC3cEruSnhob8WipClg8lDIWucdMs3MPNa+vG?=
 =?us-ascii?Q?nko8ufkXFOPqccmafEeAinkYxQXvEsBnbcGJ4u5nTcOr8GVfUeyuWxduXySK?=
 =?us-ascii?Q?MIU2pk2VI9ZZkWc52UgEosIw84LmbA7nxW0VJCVcQuTxhwLPEmrYCDBIt/oo?=
 =?us-ascii?Q?d24lmSkufdJjvXnDwOxrBY/WSp2vqtK/m4F7a7yLEIHLb4fqNdIL334stT6v?=
 =?us-ascii?Q?Ap9F6XCweBUwovghANM+a59tpwzWap6G38B3+6Zw5g2tJ9jhSTvyq2na1uxt?=
 =?us-ascii?Q?dOHo8xyx+ilh1NZl07d7eo10BJusxjoL4v2RMrTsbAQix3mZbCi8En+1Puiv?=
 =?us-ascii?Q?Bu1Ahf2PscCcR2KXYl1sKf+6zFjEPheEvzcqI9sUlae6OtbtetfsYqP5iISh?=
 =?us-ascii?Q?UtepBuwXZGhIoND5Q8wA05yUky3qSE09p0qkZn+IH7nEJI1uWO1DlDVofpgo?=
 =?us-ascii?Q?TELt4y50STOcAhYZoUQ1OBjRvLz+9vNY/pe0C3RsVtVlmKVqhH2dDV8jDdMf?=
 =?us-ascii?Q?u6LQZMIsY63CZ2xa2Tp1uo24W6zgDpIsC2foaj9A3FptDHnaccGV3sTVyWS3?=
 =?us-ascii?Q?MbQXORnlpVaJnquDRv0iBLHN4f92sqlUl68D6rmNqBvR85MaAKo0kVIWIMsO?=
 =?us-ascii?Q?UIqbpB4Ds7u+K5tK+RiMmNTKCY9cEfoyLupE7qbJsFiXoLlxd3ktgu0GmISt?=
 =?us-ascii?Q?XrKwXzEQpwUXP7V4rmyX8U6iL9Ib7D0eG9szo5ed1llLiwf6Z73vl47OY0NS?=
 =?us-ascii?Q?h3zOz0IKp1/feuOu5uP4r5c1fyfUUx/YFkdyKxP8I/oEZrz47E+q8z6rfQSl?=
 =?us-ascii?Q?mmN+JfvFPXb21FSF0W5OvC7Hqvu4E+RPalxXMAfXh00DBT92yuzZseISxvBa?=
 =?us-ascii?Q?igFDYt625x6rk8zlFblvCfNki4t9+/CUBh6DaQQoCkJZJsM2e0jZ5YqW57kW?=
 =?us-ascii?Q?0zFV7DZ7dGzVlF1JxA1l4OLtd+BKTNammn/DUBYN/6Zv/eINeYnfBSlWJxNv?=
 =?us-ascii?Q?ADhcMs1E6xqI9oFq0dnuu7hCzejrqfc/77zJlYE7q/v1XEHa3oyHkSUY3Zn3?=
 =?us-ascii?Q?+fzBaKmuluIJ8I+aHHo5+sRfUua6mZIiV8adUVG92QA5Mg4mS1GxkEkICvQ/?=
 =?us-ascii?Q?FHOJnIAAs1ExUad0NBOQX4PUucF+rYjvRUbvViNLCn+Bv00Xi6TTCCcJF3bV?=
 =?us-ascii?Q?2f7Dh8lI4GLD72rDjCNaJLFeqtt5NXZUpO3cMzL0ox/LHg9XlsdbmBCWLlQr?=
 =?us-ascii?Q?3OY3LfccjkquucuM3rHAGsXK7zxcBz4N4KSMpeS6+LTtUPdyaT7VvifQ8pow?=
 =?us-ascii?Q?gimso9Pua/6GzoublVt1jq0RGZCkDJw6qtF6hPNu/eZNfyJNVx1ejJodTisq?=
 =?us-ascii?Q?5YDWVErTowHlOVKyRw6hTxTMp1S9zAOe6kbRF2bEew1qD30w6HyOE3aAD0w9?=
 =?us-ascii?Q?nRJ/xJE/eZSQ9jTR2zuwviU2/Q5FBwrntnzEBy1iW2plbhRinMeUQOqSJiIB?=
 =?us-ascii?Q?GpOiC6UxkcyJOamxIGOhUJ0q3ZvQ+dK7WcBPfgLKhYOy5t/+U2X+WmCYdP0J?=
 =?us-ascii?Q?pQM338vS8GMIwPjkJzJUxFAWRDt2FlBeXz5n+A2JPIP5E10Nt1PANMaICRsN?=
 =?us-ascii?Q?PPOfiqEAn4Exs++Vndaq9wAB7nvtyn7K+GiPDBhcp27mfzMEZxEYCaxmNLOp?=
 =?us-ascii?Q?vhZeAXfAAqEGJVPvj/H6KwKph6AlCzbjdpgm7WYxH4HdRNl5vGj/L/8jTQBR?=
 =?us-ascii?Q?yimPXLimyQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b671e2e-df4e-4d75-98cd-08de74abef1c
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9366.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2026 20:24:53.4435
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ntwU4ux4RdS8UN6l/OKjIPhoH3B1t7fMRtq4dQEoAqMLaMU+7IYxqz5y7FIFSsYftiEewttTyiWpUjXIJQTU8A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB7172

On Wed, Feb 25, 2026 at 06:03:27PM +0100, Niklas Cassel wrote:
> Add a pci_epc_bar_type BAR_DISABLED to more clearly differentiate from
> BAR_RESERVED.
>
> This BAR type will only be used to describe a BAR that the EPC driver
> should disable, and will thus never be available to an EPF drive.
> (Unlike BAR_RESERVED, which will never be disabled by default by an EPC
> driver.)
>
> Tested-by: Manikanta Maddireddy <mmaddireddy@nvidia.com>
> Reviewed-by: Manikanta Maddireddy <mmaddireddy@nvidia.com>
> Co-developed-by: Manikanta Maddireddy <mmaddireddy@nvidia.com>
> Signed-off-by: Manikanta Maddireddy <mmaddireddy@nvidia.com>
> Signed-off-by: Niklas Cassel <cassel@kernel.org>
> ---

Reviewed-by: Frank Li <Frank.Li@nxp.com>
>  drivers/pci/endpoint/pci-epc-core.c |  5 +++--
>  include/linux/pci-epc.h             | 12 ++++++++++--
>  2 files changed, 13 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/pci/endpoint/pci-epc-core.c b/drivers/pci/endpoint/pci-epc-core.c
> index 1ad2f62963c8..32cf9a9bc365 100644
> --- a/drivers/pci/endpoint/pci-epc-core.c
> +++ b/drivers/pci/endpoint/pci-epc-core.c
> @@ -103,9 +103,10 @@ enum pci_barno pci_epc_get_next_free_bar(const struct pci_epc_features
>  		bar++;
>
>  	for (i = bar; i < PCI_STD_NUM_BARS; i++) {
> -		/* If the BAR is not reserved, return it. */
> +		/* If the BAR is not reserved or disabled, return it. */
>  		if (epc_features->bar[i].type != BAR_RESERVED &&
> -		    epc_features->bar[i].type != BAR_64BIT_UPPER)
> +		    epc_features->bar[i].type != BAR_64BIT_UPPER &&
> +		    epc_features->bar[i].type != BAR_DISABLED)
>  			return i;
>  	}
>
> diff --git a/include/linux/pci-epc.h b/include/linux/pci-epc.h
> index f7f48f43d370..63a24ebf144c 100644
> --- a/include/linux/pci-epc.h
> +++ b/include/linux/pci-epc.h
> @@ -191,7 +191,14 @@ struct pci_epc {
>   * @BAR_RESIZABLE: The BAR implements the PCI-SIG Resizable BAR Capability.
>   *		   NOTE: An EPC driver can currently only set a single supported
>   *		   size.
> - * @BAR_RESERVED: The BAR should not be touched by an EPF driver.
> + * @BAR_RESERVED: Used for HW-backed BARs (e.g. MSI-X table, DMA regs). The BAR
> + *		  should not be disabled by an EPC driver. The BAR should not be
> + *		  reprogrammed by an EPF driver. An EPF driver is allowed to
> + *		  disable the BAR if absolutely necessary. (However, right now
> + *		  there is no EPC operation to disable a BAR that has not been
> + *		  programmed using pci_epc_set_bar().)
> + * @BAR_DISABLED: The BAR should be disabled by an EPC driver. The BAR will be
> + *		  unavailable to an EPF driver.
>   * @BAR_64BIT_UPPER: Should only be set on a BAR if the preceding BAR is marked
>   *		     as only_64bit.
>   */
> @@ -200,6 +207,7 @@ enum pci_epc_bar_type {
>  	BAR_FIXED,
>  	BAR_RESIZABLE,
>  	BAR_RESERVED,
> +	BAR_DISABLED,
>  	BAR_64BIT_UPPER,
>  };
>
> @@ -238,7 +246,7 @@ struct pci_epc_bar_rsvd_region {
>   *
>   *		only_64bit should not be set on a BAR of type BAR_RESERVED.
>   *		(If BARx is a 64-bit BAR that an EPF driver is not allowed to
> - *		touch, then both BARx and BARx+1 must be set to type
> + *		reprogram, then both BARx and BARx+1 must be set to type
>   *		BAR_RESERVED.)
>   * @nr_rsvd_regions: number of fixed subregions described for BAR_RESERVED
>   * @rsvd_regions: fixed subregions behind BAR_RESERVED
> --
> 2.53.0
>
