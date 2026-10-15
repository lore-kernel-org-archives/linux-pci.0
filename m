Received: from TYVP286CU001.outbound.protection.outlook.com (mail-japaneastazon11021142.outbound.protection.outlook.com [52.101.125.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F353519644B;
	Thu, 15 Oct 2026 17:44:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.125.142
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792086257; cv=fail; b=XdwNuRgmWI/V/0/OTKIhlspiQOreS7Lez5q5wlK++4vlMA5oKeD+vqjc7V0wEBzN/MVHDcWCNIIoBZVE3qwoJxXRgMccMm4jPZSlcUesPXHtawZ47Sp6li6v43CUvMozrXUX+tJGYzGLnzVdwMQdeyCRMINiyz3mZud12D80Hhk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792086257; c=relaxed/simple;
	bh=+etaLFzRBW7C5hysCtOXTmhvYPHM81gn6if7igVcO/U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=UsxqPd34Jwunlorjt5FaO/SMva5KGV404kZCjHsIPrljbzgk3wLWCPbWC5yZ/Ipr+sVH7z9TVh9O4Yq0uCS6mWq73SnghtjvANVuI4KQag5zjRD4roPkpFV3kmEQlcluyiyCa+221PFSwLDYAUC6vToXh0UB4aFll4ttu9VQhqs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=oe9T+w7l; arc=fail smtp.client-ip=52.101.125.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="oe9T+w7l"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JboVcFcVvl8FFnoPs74gC/21vpQqDvs+VfcyKHWigsJRIG6JWYXsD7s5cP2P/61a1EGKYLdPr5b5p7ixoYU68YJTgrzYQ/hcgqIFxvaDNv9U2CWVLMzBOj/6G7YYwtH+HmF48MQHM81Ug2Po/3YaqPETNRlS2Q/dSFnhKLXaWxcgVnsL/1Ls8L2UQhWo174bCyxltqkQ6xw+4muto8+APTK9cjukaGth89jh+njCEtEJycozZfP+1qrwnCr0jor6Q9huQfp/ZFs/T4fmfc06ZsyIVhbR0CsTqG9W7L83O4UpRp7P/Wng2uD3IHZz2xFp8bhOKp1YPzMMlPNwb+alJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qKYjd4zm0FW0jBhQCKznzmOhWJdSQItp0tn8+jAhBOs=;
 b=L0DaHj+kU7ZdJOeD3oIYaQSGA6YwbXc7Ud2GVKJ6Ia98XRKwThqwwI/H06MTeCW/YaPWuvX5If6LkHJL8CTFz48uKCix8A3SuuexrUbHFN0dCI/GIDtx+OMhK+a9uLu9+ynoG2h82MqB34GJL+/sj2qX2GpqdD7b1KJxSrzL8CzGiBqEzjFjNYveq3hIO8EBhxrwSYyp/Ig8V9AwUQpSpw6s19MIbKI3vX4BblCpF4zEA8wIzSzWQzND0q8UXTNzi5RDttCy9a/hE3YdMesMKJftnssxxJuILX2rhOh6bmLLqlO71E3q02RM9hnUjI/0CDsenGs9AMxFXxlUVrw5Wg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qKYjd4zm0FW0jBhQCKznzmOhWJdSQItp0tn8+jAhBOs=;
 b=oe9T+w7liSmUeu6/t+VZVDvuHrNzM7UWCnby2ds21IfAPDbKQ6l+R9lALHvleZSvOYOJvREdY6hAcvP58603/4sgpgWoLQ43GLFa+yx02ufGMYJFeMLxvn4c3REIHFuj/b98eJHMGQZDHI27Dclki574zTMaAPS0mBrDiIsq0kA=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:325::11)
 by TYWP286MB3786.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:400::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.14; Thu, 15 Oct
 2026 17:43:57 +0000
Received: from TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 ([fe80::cce5:2aa8:53f9:dba9]) by TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 ([fe80::cce5:2aa8:53f9:dba9%5]) with mapi id 15.21.0522.013; Thu, 15 Oct 2026
 17:43:57 +0000
Date: Fri, 16 Oct 2026 02:43:55 +0900
From: Koichiro Den <den@valinux.co.jp>
To: Manikanta Maddireddy <mmaddireddy@nvidia.com>, 
	Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>, Niklas Cassel <cassel@kernel.org>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	Krzysztof Wilczynski <kwilczynski@kernel.org>, Manivannan Sadhasivam <mani@kernel.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org, Rob Herring <robh@kernel.org>, 
	Thierry Reding <thierry.reding@kernel.org>, Jonathan Hunter <jonathanh@nvidia.com>, 
	Kishon Vijay Abraham I <kishon@kernel.org>, Frank Li <Frank.Li@kernel.org>, Vidya Sagar <vidyas@nvidia.com>, 
	Marco Crivellari <marco.crivellari@suse.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 11/11] PCI: endpoint: test: Do not relocate fixed MSI-X
 tables
Message-ID: <wfzi6cojnam2flqksk55i2nghpovhteeirsy3phfa6zxlloy66@oajxjlhqusrb>
References: <20260923072237.1139013-1-mmaddireddy@nvidia.com>
 <20260923072237.1139013-12-mmaddireddy@nvidia.com>
 <arPjAeYzVbe5_qo8@ryzen>
 <179198883276.63727.4456977474157450415.b4-reply@b4>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <179198883276.63727.4456977474157450415.b4-reply@b4>
X-ClientProxiedBy: TY4P286CA0060.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:371::8) To TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:325::11)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB6866:EE_|TYWP286MB3786:EE_
X-MS-Office365-Filtering-Correlation-Id: fa6b1083-c251-4cb7-5c0c-08df2ae3e37f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|10070799003|23010399003|1800799024|366016|56012099006|4143699003|5023799004|261009223027099003|10067099003|22082099003|18002099003|6133799003|27256017;
X-Microsoft-Antispam-Message-Info:
	Y678JP8KnBx+rjulKT4uRSztvU7RJPJv3Ny4QzvjTaAM0W53XJSvldH9GD3Gpw9gmeQZk5oX+CKhS60r13DclVAipS5KJBKQ+TABWyCPnd50eGuQ4ymyOX17Coo8hprcB5PMqen3re2lNqddVH1GMEXZLErbfArwtzdGELs2CvbjkuZTZH4BXV75bNIs0waeuWEsiVSu+yaPLrHH/i7yNjHv7BpAlZkt5PIQvdiA1AfM1n9iOUfc/iJG+GodZ2ytg6kXvzbJt8KlUAr4JUKtMLRP71jo9CVn8ct//eWPP3tS08wSlO+GTUG/FW1X0Y0+6wcz1G0BHUH0fTh34uGxxiVxBci5KD2s5/NjKcQjv1nqCxkGxZXA2Bq4dz1HgHcEgw/etAuCGt2qGXzM+f/po5lFSdkNdX39pQwoZdKYaUg6KcjBExsnn6LwtNIGJilMuHRavV+ZbUase7GMxyb/P6OHhl3GElWqmubmV8fHGVIl/in6KxdnLAnoXxO5gC4nREDPz2ZP/o1y0LHLf4YdgyOaopFfqjTBCUmU6PgjodBGrrgpIqrjrblJ5OBDKK/A3N24EzcH7F+Nv608VmDWeM41AqXeWxRlxzhgAbV48PiBcJTxqUG6Z86wRRt/B+cHgHKnYh+3UEGyG8145z81ZrtsvrGP/FkxSJjfBO1IZpA=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(10070799003)(23010399003)(1800799024)(366016)(56012099006)(4143699003)(5023799004)(261009223027099003)(10067099003)(22082099003)(18002099003)(6133799003)(27256017);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?n56x2V6UcfD3HSUGJ9Fh2QJ8pvEkJwS/KpDu35kI1xBQC4ChcBi382No1fLX?=
 =?us-ascii?Q?rPgJlqiXVSjxcINoe5F8rGwU9x3jZMl62mxUai614/0DYv9ctJCWuiR3yDCs?=
 =?us-ascii?Q?Odt/gBoCqes+aRw+YcGTZfpz6n/cFj465J0QgA3ZovlMY+ya208v3MU9VQ3I?=
 =?us-ascii?Q?J6q0+pGXrTlYFLMu83Gec4EHxQHKFNxnIizwQLt2KABfr8v224cdLRf7Kve/?=
 =?us-ascii?Q?1oyt5UexrhChs1efAjkcOB80m8C2WjvR58jsW9wGOffiHtDFmiMG0wLHPoyI?=
 =?us-ascii?Q?nJnr2h6B9uds1bfD0SGJ1iVu8KJ9dn8hFlbFdhC7ec7sstNGzCZFklhQ0v8S?=
 =?us-ascii?Q?g1OzD9rh7JR0oynbxbKA70v2m3a1CvZUhv/wvjkSvByp7Q8mOn9Rz+6tsmB3?=
 =?us-ascii?Q?4vRYL4kHNKZUzMyX79SuVQhNdSqQ2Et7ROfuO//Tmir29G0gqrxHrvdmCiux?=
 =?us-ascii?Q?wDahl+RvZtTCsVk/L2NTVH0Vb/Tg9Vrt4DjuBwNwYOV57dd0Act/+z2ImHKV?=
 =?us-ascii?Q?HeZrMiKbYkJvDaIOI713uEy35LS/qGkUURQ+uTJmY0LCZIWIvStSi8x1Gd4A?=
 =?us-ascii?Q?57v2dhPMac9wvPi/mHFp0NlQayWuWpG8IEDDflJOYZqllXqYMCnGwAsOuch/?=
 =?us-ascii?Q?8Wk8pFeH13mIMX9L6sooTzL3qzOAnetr57P0YP/RGO/gI1J+BCYYBrUz7QXd?=
 =?us-ascii?Q?UXLCtIgYgryBvM4DpSzpk8GgOM9lX9Ta9Xvdk8UWwN4pG9PSJV9FpLodl83W?=
 =?us-ascii?Q?tqb2oq2NlqGGCMlMNvSUzmpb3NcRuezG8rwpSXT/tSOJeny6RFtZrNDBi8Wy?=
 =?us-ascii?Q?e8sbKC8BVn5sTAvyLoukSDo88BUbCzJXmfQTiXTsq3Gq/ui7vWl2sTM+QrAn?=
 =?us-ascii?Q?/YKbb1Z2Rdnf6L0qqF5iQiKJ34Pi+MgjKPvu1Yk/GW/PKoSjKYPK1VpWtGPe?=
 =?us-ascii?Q?IdtUrPIKf5ZjLfJClgTnrWi3LPV8RpdJZF2c9+e+aUavELV8MN5knhRJ4VQQ?=
 =?us-ascii?Q?k62QJerTBjj96DmfCNo5QuqhPBY+mIQl/GbCtQtow/QfUrCZtkhlzjTOC/n2?=
 =?us-ascii?Q?sQXRnaFi+4+GNi10kenxu6nxweF/Pzs23s8/ZaIcMm7m5UXM54thBvVaWMcr?=
 =?us-ascii?Q?Gh0Yb+EGeDKD/q0KnmoaWft882u91h8j8LKN8BvxsYmtakX+EYWlLLCHPdYy?=
 =?us-ascii?Q?IqLCTdfiuM1Vjw08doIJc8h/gTSdyuiGgwOIoBi1b41W2vQmZhCEMFux/dIE?=
 =?us-ascii?Q?UPCy8osIH1RwoszsaqTn8tCeBBsMFD1NRRCxCb/UflUNmTqPmfwbNeKfTlUe?=
 =?us-ascii?Q?fLekQZrpcBWGlcIAqWlvnq3P37rP/N0161VUddsWrxABbRFFsLinPJR2DhCy?=
 =?us-ascii?Q?+CJA4SHaPwnqCS8GXQROjhkhUEOt+w8PxOIfp6fO6WsoAxOn7LDr/xBo3Iny?=
 =?us-ascii?Q?pMOMkmo2ZOv+Y8i40WZE7bWaMH8CJ5TjxOpXP/n0tXp4Hhy1qoB+WYfCPlFN?=
 =?us-ascii?Q?Cbfw72YLY6px5egnZHOdgea+TgyFFd701htExCzir66QTEaoXqC1Lt/kmqZo?=
 =?us-ascii?Q?GPtCNgYwHmKpt9UTZmCxHDipl3Be2ZoNebQGMUDwbM11uQW8rpj7SOCBVdve?=
 =?us-ascii?Q?H5SHyZkZwfY+Atp7lwO30lycadYrafUgg04GB4REFxX6zp4NND35S63LsTaM?=
 =?us-ascii?Q?f9L178+2rcXkMos0EeODddbphc7s2EPNoCXVWmFpvYwgBlWCjXIDqisatmdX?=
 =?us-ascii?Q?m11LmUNur1fO45ss1l8kmtH1+fub1UWufZQHrdmYcpQUCH24QXvP?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: fa6b1083-c251-4cb7-5c0c-08df2ae3e37f
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2026 17:43:57.4842
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Af9gKG47R2eI1KZtQRCl5SRJSfUrjlmHeRzocKYgnLwqhcjXXa+2+IpsZqNapXGzSsjYFojDlZItJY+wfGL+mg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWP286MB3786

On Wed, Oct 14, 2026 at 08:10:32PM +0530, Manivannan Sadhasivam wrote:
> On 2026-09-23 16:32 +0200, Niklas Cassel wrote:
> > On Wed, Sep 23, 2026 at 12:52:37PM +0530, Manikanta Maddireddy wrote:
> > > Some endpoint controllers expose MSI-X table/PBA storage at fixed,
> > > hardware-owned BARs. Such BARs are described to endpoint functions as
> > > BAR_RESERVED with PCI_EPC_BAR_RSVD_MSIX_TBL_RAM, so the function driver
> > > must not reprogram the MSI-X Table/PBA capability to point into ordinary
> > > function BAR memory.
> > > 
> > > pci_epf_test always allocates MSI-X storage after its test registers and
> > > calls pci_epc_set_msix(). On controllers with fixed MSI-X storage, this
> > > overwrites the controller-defined MSI-X layout. For example, the generic
> > > DesignWare path derives the PBA offset from the number of vectors, which
> > > can make the host program the wrong MSI-X storage and prevent MSI-X
> > > delivery.
> > > 
> > > Detect fixed MSI-X table BARs and leave the controller-owned MSI-X
> > > capability layout unchanged. Keep allocating and programming MSI-X
> > > storage in the test BAR only for controllers that do not advertise fixed
> > > MSI-X table storage.
> > > 
> > > Signed-off-by: Manikanta Maddireddy <mmaddireddy@nvidia.com>
> > > ---
> > >  drivers/pci/endpoint/functions/pci-epf-test.c | 27 +++++++++++++++++--
> > >  1 file changed, 25 insertions(+), 2 deletions(-)
> > > 
> > > diff --git a/drivers/pci/endpoint/functions/pci-epf-test.c b/drivers/pci/endpoint/functions/pci-epf-test.c
> > > index d4905aa8e4c0..82d4714e998c 100644
> > > --- a/drivers/pci/endpoint/functions/pci-epf-test.c
> > > +++ b/drivers/pci/endpoint/functions/pci-epf-test.c
> > > @@ -83,6 +83,7 @@ struct pci_epf_test {
> > >  	struct config_group	group;
> > >  	enum pci_barno		test_reg_bar;
> > >  	size_t			msix_table_offset;
> > > +	bool			msix_table_fixed;
> > >  	struct delayed_work	cmd_handler;
> > >  	struct dma_chan		*dma_chan_tx;
> > >  	struct dma_chan		*dma_chan_rx;
> > > @@ -98,6 +99,26 @@ struct pci_epf_test {
> > >  	size_t			bar_size[PCI_STD_NUM_BARS];
> > >  };
> > >  
> > > +static bool pci_epf_test_msix_table_fixed(const struct pci_epc_features *features)
> > > +{
> > > +	enum pci_barno bar;
> > > +	int i;
> > > +
> > > +	for (bar = BAR_0; bar < PCI_STD_NUM_BARS; bar++) {
> > > +		const struct pci_epc_bar_desc *desc = &features->bar[bar];
> > > +
> > > +		if (desc->type != BAR_RESERVED)
> > > +			continue;
> > > +
> > > +		for (i = 0; i < desc->nr_rsvd_regions; i++) {
> > > +			if (desc->rsvd_regions[i].type == PCI_EPC_BAR_RSVD_MSIX_TBL_RAM)
> > > +				return true;
> > > +		}
> > > +	}
> > > +
> > > +	return false;
> > > +}
> > > +
> > >  struct pci_epf_test_reg {
> > >  	__le32 magic;
> > >  	__le32 command;
> > > @@ -1214,7 +1235,7 @@ static int pci_epf_test_epc_init(struct pci_epf *epf)
> > >  		}
> > >  	}
> > >  
> > > -	if (epc_features->msix_capable) {
> > > +	if (epc_features->msix_capable && !epf_test->msix_table_fixed) {
> > >  		ret = pci_epc_set_msix(epc, epf->func_no, epf->vfunc_no,
> > >  				       epf->msix_interrupts,
> > >  				       epf_test->test_reg_bar,
> > > @@ -1282,7 +1303,9 @@ static int pci_epf_test_alloc_space(struct pci_epf *epf)
> > >  
> > >  	test_reg_bar_size = ALIGN(sizeof(struct pci_epf_test_reg), 128);
> > >  
> > > -	if (epc_features->msix_capable) {
> > > +	epf_test->msix_table_fixed = pci_epf_test_msix_table_fixed(epc_features);
> > > +
> > > +	if (epc_features->msix_capable && !epf_test->msix_table_fixed) {
> > >  		msix_table_size = PCI_MSIX_ENTRY_SIZE * epf->msix_interrupts;
> > >  		epf_test->msix_table_offset = test_reg_bar_size;
> > >  		/* Align to QWORD or 8 Bytes */
> > 
> > Here you are only updating pci-epf-test. What about the other EPF drivers?
> > 
> 
> How can we test those other EPF drivers if there is no hw setup available? TBH,
> we don't need to add all functionalities to all EPF drivers. Adding them to
> pci-epf-test driver is enough. If other EPF driver maintainers want to add the
> missing features, then they can add them after testing on relevant hw setup.

I wonder if nvmet-pci-epf was one of the cases Niklas had in mind.
Patch #10 sets .msix_capable = true, so with msix_interrupts set to a non-zero
value, nvmet_pci_epf_init_irq() selects MSI-X and calls pci_epc_set_msix() with
BAR0, which looks like the concern this patch #11 itself wants to resolve.

So, Manikanta, have you tested nvmet-pci-epf with MSI-X on Tegra with and
without this series? I don't have the hardware, so please correct me if I'm
missing something.

> 
> > 
> > Also, if you run then pci_endpoint kselftest, with the default 2048 MSI-X
> > interrupts. Are really all 2048 MSI-X successful?

This also reminds me of the unresolved entry #0 issue Niklas and I saw on
RK3588... The kselftest's final status hid the failure when a later vector was
skipped, so it's worth checking the individual results. If the same symptom
appears on Tegra, it would be useful to compare the two.

> > 
> > It seems that often the "hardware owned" MSI-X table is much smaller than
> > that. See e.g. Koichiro's series which tries to use "hardware owned" MSI-X
> > table, but if the "hardware owned" MSI-X table is too small to hold all
> > 2048 MSI-X IRQs, then "hardware owned" MSI-X table would not be used:
> > 
> > https://lore.kernel.org/linux-pci/20260830151948.3547577-2-den@valinux.co.jp/
> > 
> > +	if (layout->table_size < table_size || layout->pba_size < pba_size)
> > +		return -ENOSPC;

Unlike my previous series, this patch skips pci_epc_set_msix(), so as I
understand it, msix_interrupts does not change the Table Size advertised to the
host. Assuming the existing Table Size matches the hardware, that would avoid
advertising more entries than it has.

(BTW, skipping pci_epc_set_msix() alone would not be enough for RK3588. Its
upstream driver does not yet advertise the fixed MSI-X Table/PBA regions, so
this patch does not change its behaviour. But if we add those regions later, the
interrupt path may need to change too. dw_pcie_ep_raise_msix_irq() reads an
EPF-owned Table through ep_func->epf_bar[], which is not populated for the
reserved BAR4. The rockchip driver would need to select the controller doorbell
when using the fixed Table.)

Best regards,
Koichiro Den

> > 
> > 
> > 
> > Apparently NTB EPF needs to read the MSI-X table from RAM:
> > https://lore.kernel.org/linux-pci/pj5vpwwd5tr5tuvhdq3bcpefnq27r6ljvwoysguz2o4tglcqx5@l7zmb6wjnhla/
> > 
> > Which is why he also decided to let an EPF driver choose if it should
> > use "hardware owned" MSI-X table or not.
> > 
> 
> Yeah, makes sense. Otherwise, we will see kselftests failures.
> 
> - Mani
> 
