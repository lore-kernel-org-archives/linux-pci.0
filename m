Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazon11020143.outbound.protection.outlook.com [52.101.229.143])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06B1230F540;
	Wed, 25 Mar 2026 08:44:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.229.143
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774428246; cv=fail; b=VadjWscnQQd8xvqjdFUmpcFEdlPtb2zitGm7D2moJZF5Zya6c6HwNUfveTqJV4bnYfzlTYZ0wBdMsYisD8v77ONb4tpw/5ujZlscmQrCyL7XymNpdvrHOH1Ukn62L+GNhvF8MVKDn8RDISdrR0yiYdAhZ5VV5M/fOjHkwNla1Fg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774428246; c=relaxed/simple;
	bh=wRInYWd9KlR+Nnt8Njyjg2zQd9urMZDxvlMEnBmROnw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Q5VOUBQEOnTalMutVZ9cnJE2NfZq16cx88FteLxK4Km+/ZWvSGhyfOTbnLzVfLRJso99HJA2/MIpNhQEPkwf8ZpGD87Y+fdGUNyqUoAahlFvJyHdcw1r6YXYs4Dq/bRXXutqQLAiWKksVi0xvFHLnDrA2f0GUgpNkpwhfYlhlB4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=eHrwI+SB; arc=fail smtp.client-ip=52.101.229.143
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="eHrwI+SB"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MovIAq8MxH/og0gT0BIE4sx1Y7Mcdq+q21HX2Mz8E4Jk9wRfKWPkwfZvki5Tf1NPmZNzZ4fgOV7vBG0/nv3oZ9fJ4RRwIKJoVe6zkih2fJrO40Jf1m5mX6RnXBltnxrCpJ7NzHyxwLiK8OQA5IP/RotPIuFsX2jaJ0Zz/Mbp+BD9e12+N5BPYXiK2+PD8e1z388UHdDmKSrw0YruOGvt6179Tx+rlzIZOmWt82uYUfG1kDhMHjKSGoBgwXsTyfOP9zDFxA25Y2IeHhXFB5bI8O61IjU6Y57ts4RpciiLqziaIlHmIQbFthGicmj0RsLJO1/u2NvzJBYPGrFqMoIRQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XoKyv5MfB1qL/AYAtzXe+Ap9FAJaxMmzEgxLhvS2WUU=;
 b=tw8YNix/nD82wguXA371xN9pqdcneFKDC2WSsFgITJ4XOIuaBeqS6TFcJ6YWFM7z9VGRAJV0JHpeYXVADjFM7UNeDmJFv/YlPpAOMSCcAcYXGsmqyUzIRqEMBPvmogaLT9Xf66WBliLtgiOyYCyFzQeXen8dLRTN/p7Ye4LvuKtaMAU4l1p3oiI6n8lyoJ/LA+TgjVvJ3rxSRnLSXX0CZZrNSdqdXggzML7rxuaYMd4CJy+mJd+gcr1bEoJ7QolHWAciNn9rxzI/XfGP/aSzSNK7rMLhiN9svSzurR9g6DkOvOdkgx6QskDZCWLEE+Wsq8kOMSqig89GLGJ1gFf4AA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XoKyv5MfB1qL/AYAtzXe+Ap9FAJaxMmzEgxLhvS2WUU=;
 b=eHrwI+SBoHTYKLl/FCu7gND/QMY7HkP9QmHI8pVbK9JZScGHGftppPbFZ2b7vOsN71fRJOEhw0lyL0hLC3WLQ8qT8IOFme6gFOkLBb4Y1bniMQabIfrFGsCWEosxjYDVqrgF4ZjsNmm9nUXQamKfhggMY9giVvKB3cGgMv6wlno=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by OS7P286MB7226.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:455::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Wed, 25 Mar
 2026 08:43:59 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%5]) with mapi id 15.20.9745.019; Wed, 25 Mar 2026
 08:43:59 +0000
Date: Wed, 25 Mar 2026 17:43:58 +0900
From: Koichiro Den <den@valinux.co.jp>
To: Niklas Cassel <cassel@kernel.org>
Cc: Frank Li <Frank.li@nxp.com>, Jingoo Han <jingoohan1@gmail.com>, 
	Manivannan Sadhasivam <mani@kernel.org>, Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, Rob Herring <robh@kernel.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, Kishon Vijay Abraham I <kishon@kernel.org>, 
	Jon Mason <jdmason@kudzu.us>, Dave Jiang <dave.jiang@intel.com>, 
	Allen Hubbe <allenbh@gmail.com>, Bhanu Seshu Kumar Valluri <bhanuseshukumar@gmail.com>, 
	Marco Crivellari <marco.crivellari@suse.com>, Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>, 
	Manikanta Maddireddy <mmaddireddy@nvidia.com>, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, 
	ntb@lists.linux.dev
Subject: Re: [PATCH v10 7/7] PCI: endpoint: pci-ep-msi: Add embedded doorbell
 fallback
Message-ID: <ec62kljt36zh2autlth5jivdqlojbpdo2gbs43ayob7hobcpre@bpos6hqyuwkv>
References: <20260302071427.534158-1-den@valinux.co.jp>
 <20260302071427.534158-8-den@valinux.co.jp>
 <acGK6rUIyuJP6gF7@lizhi-Precision-Tower-5810>
 <ksr6hlcwmrkrgrql5jqhtpkaihsugtsztfhxxjbq3au6kz3ksu@mk7hhmwabgsi>
 <acOJcMt7E8PLHAD6@ryzen>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <acOJcMt7E8PLHAD6@ryzen>
X-ClientProxiedBy: TYWPR01CA0008.jpnprd01.prod.outlook.com
 (2603:1096:400:a9::13) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|OS7P286MB7226:EE_
X-MS-Office365-Filtering-Correlation-Id: 798820b4-d12a-4d2e-7729-08de8a4aa884
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|10070799003|366016|7416014|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	HM333gBFgkTWT8dKYOPqbRKPsh6xLhLcaLcVq8BSg9CBPxtlwBZLcJ7ZcZcciG87lFCdQfHTGaY9C2FvHDBl5vcmpTx28VdQ9QiCrtI1p+vy1YCJCVYERhOte4sosjYCzlzWUDw3UMfmRkTaMdmxUBLYXISBPddbw2C9wuH/SqDJmBoBQlG7T0bp+9w3ZL6WSLeovAgB9GRHyMu/b7Sdt4gmvaW1N4DVvV5XL+7RLcTQysMZLcC7C6iqIQVNVyecqxWAZ0Zl+JTChEOq9BUXWTuJaMQDG2wEZ9GihRJx17knykEs/+7Ejvv5tmTITQJL33U36lE2YWbA4IdpPVYH2JmUDS5ZpH63phNo4OH7Ln+5Nl5WE7HDeMKy2woC3x1RNG2eRd+RDX+D4MtoIoAttGCqFikgH42DiUNpiaWRlMANjVmDm1UQTH+iGVfZo98XH8bVLrUy511BfSFN4Itf2fsQVP/ytrrjfq+rluIQ3lOEkJ51jWPS1I4TWhbz8eg7b8Ono1JS8aRj5qrlfXEKVlqshU0/sSX5lQupNkIxCvmD+Ei+oZ/kWEB1xGBdVb6mBHGVRSn612N682sXieiBpKGLRjs5xND7Ttv+PypRlBOFp94kBSj1pmJB7wj3DwmIwZbs3oLu+cJDHgKeCnohKxoYuRj8HzV6u4K6CfZaHKXvLM/Wp6hAHWxxEEVdViUMU3TUZzmwXz2AO533RxR4w56YIBaAjyahferCL8U+OFY=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(10070799003)(366016)(7416014)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?xRYPoQWhK5qEApRKeK+TavZzKeD5Y5qQ9toDJjvtwa9JMw2a4r8n5na6cgas?=
 =?us-ascii?Q?dHHbTBoFqViWRGXqrJX0mksYlwA65mPW9cxC8tH3TbZMc+T9tD9Dgud62hFl?=
 =?us-ascii?Q?FIYa/Sj9mhqquaCvZy6gXeF4LP4p1POzYQJQim7WECwAoVyiwuPRCH4N+ewO?=
 =?us-ascii?Q?ES2jYThfRJQqte0h7DJZQSt9e2CxXXtqEFYYefDHIIfyTEnB+y/PDllXRvOw?=
 =?us-ascii?Q?FB2D37BwWDvCJCZCsZ1KcH0KamVSRM1emwHCLAAJ955S6WBDZqPM6spdtaw9?=
 =?us-ascii?Q?kSrawZf2qUz4HHMfUUbkBTwuKS59HgeWWFqEZttmOJYaOWS/U0JWFp9Lg3pn?=
 =?us-ascii?Q?6CtQtqDc8RYJt9MnXgUOmtkZVNp16SPi2lciv+3xaFRwxD854kADXvpJh2RH?=
 =?us-ascii?Q?tqqL5Girp4h/PGDAvDXjINTbV9lD1LupirxPRNz5X0a+U2fuWuv7Y9GEQCWa?=
 =?us-ascii?Q?VvHuQ4f8H791Zd+/1ctI0mgdJz2yJRzaaG6TwSGxMXEXBAldrycEf6EXaFxO?=
 =?us-ascii?Q?TENwMKvXJv9/5ukKXib0t3aotRxvJHVLO6MFtRwUVwZv902WzmWmQbnJt5Es?=
 =?us-ascii?Q?ZsFxxYeH2ypApyfw+cwdg1Cy1us2eAjhX8AbXO32GhiloCTh934Wwxzo0qpB?=
 =?us-ascii?Q?PiRuxvytCYE+btGijMdOr3WRnIWjP9r9ZJqfahqJ9jbYMUMRZPygzeVXf78M?=
 =?us-ascii?Q?WM9kIBpBRWM9cmc8kkYTXY4R4MFhMjeG41TIDK//sgxdRSWYqR/d8ord0oX9?=
 =?us-ascii?Q?gkylRCWcVTVjOy448qXWgRXeN+3isjatep+tSQf6Yxl2oNumCR6Tgk0Sdvgm?=
 =?us-ascii?Q?fIvaZ4COj2U5KBiMNiaZZT8lph5JH58H3yIaacEzHrP73WQoTHDK5FqVxe5g?=
 =?us-ascii?Q?u1qWtRppHiWrCq1e1arLbibLwbuHhjY18ahg3GxWGE+6NdLFfh/JXFcOUfIP?=
 =?us-ascii?Q?JaYirw3GCWuCmy9IQVa+j7tn48rrAH5Tpg/ubSNDTV2Bp3i2o5XS0DAeFtOC?=
 =?us-ascii?Q?X2EelCCZSOkD3hmFcteUJSkjPDNibCPRcyMDvhNOXN8KqpKiweajTh+n8ZST?=
 =?us-ascii?Q?dbLIyi+ArGGzmOpg9uLWqkUhnsUbBwlOtigWIZxg0tsk4cgPd1p+s75zS8b2?=
 =?us-ascii?Q?R2BwJBO1rBZilW1Y2fWaw8qK8NDLwrnIDIyvy0Gju6APsalfUNgWbmOtVyO/?=
 =?us-ascii?Q?9cKe1YR6pTJylBZsEsqFRGsxzLCYNVkmtMpRP8q/GVeOgvCOq5+C6AWZxGbR?=
 =?us-ascii?Q?H+w+L5XdhjZroSfMYZ68G/lhsrCPbvEDabUDryQAXPxMu63g9OO8ll+MVukw?=
 =?us-ascii?Q?7gJdxZz0qP5ZYGd6yujrC78MoJ3rwRVn00qcn2/pIbiHVBloDRrf0sHRA4Nd?=
 =?us-ascii?Q?8p67E3eBfdOX19eeufieaTGGv7tcPllOs4vCcKLwsBU1+07SOSzMB9bvkF29?=
 =?us-ascii?Q?TJOxNtxdD9XVq3eyTv/o3T5OV2J5H1plIT2TFjP9eVYM2/K1pVm2PnhLhTxf?=
 =?us-ascii?Q?LBcEcj9l8jhDliVjF6eByfxDErQZJeZgFO347Qyq9YCwYcHWSqa0OmFm+yR+?=
 =?us-ascii?Q?/W9RBzU53+7RgJ6aLrcTv3FP5OuDosx9VVfDqsEVcoMVko0CVCfqvGgRd6tr?=
 =?us-ascii?Q?MI9ZlnIC3aTXsTS1M+Ju/xvuzQeTWMacEagswhDOTC85dEhsiW0pVuTjPmn4?=
 =?us-ascii?Q?+0lvYi3sWTlX9j4r6kevdTRQI8fhgb6nO8ezHMRwcmysmEkyba1J+jonWrNt?=
 =?us-ascii?Q?YyyyP5pdVWLa4jj9N2NvlvM0lHkRgZKoN1m49IsHqOrB8Vlf/xVr?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 798820b4-d12a-4d2e-7729-08de8a4aa884
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2026 08:43:59.4112
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4E8UEHqNNsJIKOyKHAsdUQzx9J1LsSZnaAALNudsnSMZTRXDCu9YfTLydOSknVl6iP3E7bzoDQLfNqL/g8yxsQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS7P286MB7226

On Wed, Mar 25, 2026 at 08:06:24AM +0100, Niklas Cassel wrote:
> On Tue, Mar 24, 2026 at 10:40:24AM +0900, Koichiro Den wrote:
> > On Mon, Mar 23, 2026 at 02:48:10PM -0400, Frank Li wrote:
> > > On Mon, Mar 02, 2026 at 04:14:27PM +0900, Koichiro Den wrote:
> > > > Some endpoint platforms cannot use platform MSI / GIC ITS to implement
> > > > EP-side doorbells. In those cases, EPF drivers cannot provide an
> > > > interrupt-driven doorbell and often fall back to polling.
> > > >
> > > > Add an "embedded" doorbell backend that uses a controller-integrated
> > > > doorbell target (e.g. DesignWare integrated eDMA interrupt-emulation
> > > > doorbell).
> > > >
> > > > The backend locates the doorbell register and a corresponding Linux IRQ
> > > > via the EPC aux-resource API. If the doorbell register is already
> > > > exposed via a fixed BAR mapping, provide BAR+offset. Otherwise provide
> > > > the DMA address returned by dma_map_resource() (which may be an IOVA
> > > > when an IOMMU is enabled) so EPF drivers can map it into BAR space.
> > > >
> > > > When MSI doorbell allocation fails with -ENODEV,
> > > > pci_epf_alloc_doorbell() falls back to this embedded backend.
> > > >
> > > > Signed-off-by: Koichiro Den <den@valinux.co.jp>
> > > > ---
> > > ...
> > > > +	 */
> > > > +	if (doorbell->bar == NO_BAR) {
> > > > +		phys_base = addr & PAGE_MASK;
> > > > +		off = addr - phys_base;
> > > > +		map_size = PAGE_ALIGN(off + sizeof(u32));
> > > > +
> > > > +		iova_base = dma_map_resource(epc->dev.parent, phys_base,
> > > > +					     map_size, DMA_FROM_DEVICE, 0);
> > > 
> > > DB should write. Is it DMA_TO_DEVICE?
> > 
> > Thanks for reviewing.
> > 
> > The write is initiated by the peer (RC) and lands in this EP-side doorbell
> > target, so from the EP side this is a DMA_FROM_DEVICE mapping.
> 
> I don't understand.
> 
> If the RC side does a PCI TLP write, the iATU on the EP side should translate
> that to an AXI write, no?

Yes.

> 
> If the target address (doorbell register in this case) is only mapped as a
> DMA_FROM_DEVICE (read), I would have expected that AXI write to result in an
> IOMMU fault.

My understanding is that the inbound MWr becomes a local write on the EP side.
Here, the EP controller needs write permission to the doorbell target, so
DMA_FROM_DEVICE is intentional.

As noted in the cover letter, IOMMU coverage was tested.

> 
> Is the IOMMU really running in strict mode and not in passthrough mode on
> your platform?
> 
> Do you get an IOMMU fault if you change this code to DMA_TO_DEVICE ?

Yes, changing it to DMA_TO_DEVICE triggers an IOMMU fault. I've confirmed this
experimentally. This also indicates that it's not passthrough for this mapping
on my setup.

Best regards,
Koichiro

> 
> 
> Kind regards,
> Niklas
