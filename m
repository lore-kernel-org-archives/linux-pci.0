Received: from OS0P286CU010.outbound.protection.outlook.com (mail-japanwestazon11021123.outbound.protection.outlook.com [40.107.74.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D621730648C;
	Wed,  9 Sep 2026 04:53:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.74.123
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788929641; cv=fail; b=FolMaLBlUXJ824xBUEMVwksZNWQKqw0CRZqlxjIQlnsHGsGN4IJ0CPrz1EtxnW3CWTcJKUqgsSRyfqihavVMVhrpCtmSQgvAo5Lg7KNc7ttJYocJJIoeFyx2omtUILqm7ppxUhmcTTwQZqjYO2egXF3ZQcxGjjykm8zZ6Z+ujcw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788929641; c=relaxed/simple;
	bh=k6gx6s13Y0p8GMceHzuhttRooT4yJzHpK+9CvGes9EM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=txl+79LX3eOimy2lVKa2qhZzkKpAAtTynE6SQLhCmU4raNDIrM5Q5l6GB0BSZIjIPGRemrGTMwjw3hBCMSU3Z8yqRyzCfgocjZ9EBJpi2I2f7/fDmC9g+btuoaHAi+fMrGIcXBQo7u4mAoeDwArXYYP20RWweGekGMRVTxlT2CQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=Czy5AFNw; arc=fail smtp.client-ip=40.107.74.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="Czy5AFNw"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TXL8ksQEKwm/6+SO7/OtHWUuZFAwOrLTEnwy1eKts/PHwYQio6k/ARKnEdWIYQyCewOGnAX8ZwbqOV4S3l6C/gE/bfm8hQgNb4qG/pkISfUrSxxz1keLMjZ0AT4AE8rPS6yieSAQ5R89aOd6X5TW8BoDf1gUEf7RKHoVVaB/NeNfp9pnM4+eRebxuNmCorM8uuIv924K8ovOeRLB761ojSYUq1IzqFQARdOiu53nK7X6oICqrX/UZGAFVpZ68cHLJXbqVJFyC8rLFtU2FWunIeE7Mqgk/0Pg77DdzfgDjPPejZbourfPhfBOSN+yiewRXQWK9GAjTuhsZp+2ThOZ9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PZt5BVVXUGgIg4OMG08CWpMG3glAof3jb6Cw178cckc=;
 b=wRxoISvryCu+ix9WYd0IRMr9xAkBprgNQyLBoqFllaqkG/OLP88IeytBwhT5rNIOqbbgOcba3+mkFPK+Vmm/K0oQTqixyuaXORqve/Q2hlWJC31FdEqtnBVXlKc6SqD7EewcBvFn3IfrE0x94RR0epYlU0bpEMb+pcaoED21xEj2RCfFGVISJs0VrICqro8Ew6Gk0vtqtyo74LRGC9jh4s4G7/FZIu/Hqj9RaWjrN2l4CjnHKvGgAKKRNFbCiqzOKbUJp/3SXEpjJE/vJHjKKvCN3UnQ99cKQCUj8weWwFzxipti3GDmqU5F18Ky5nukv+ssGhTuOmmwfHHPpOJtRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PZt5BVVXUGgIg4OMG08CWpMG3glAof3jb6Cw178cckc=;
 b=Czy5AFNwKGP2VUrFxBxoBONGnDCv6I+Py+0jDlNYeJZewRY3bpW5oMTMuzypb0b/JMXNJOm+889tRoKwyWROLSdLeeJXT/xcf+FzUoqfxTeTl5nEbK9trq6jFxUfTOMDH+zGgXxlQmGer6ICgNDPbRLeEW99PXwvfQok5OPcO78=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by TY1P286MB3311.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:2e1::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.7; Wed, 9 Sep 2026
 04:53:54 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%4]) with mapi id 15.21.0406.005; Wed, 9 Sep 2026
 04:53:54 +0000
Date: Wed, 9 Sep 2026 13:53:53 +0900
From: Koichiro Den <den@valinux.co.jp>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Manivannan Sadhasivam <mani@kernel.org>, Frank Li <Frank.Li@nxp.com>, 
	Niklas Cassel <cassel@kernel.org>, Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Kishon Vijay Abraham I <kishon@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	Jon Mason <jdmason@kudzu.us>, Dave Jiang <dave.jiang@intel.com>, 
	Allen Hubbe <allenbh@gmail.com>, linux-pci@vger.kernel.org, ntb@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] PCI: endpoint: pci-epf-vntb: Pass PF/VF number when
 BAR programming
Message-ID: <rmso2szdpfjy4qoqalhhpf3zxzn2te25m573qmwmpmoilk5jz2@arvvr4hdzbbj>
References: <3nerafdorapt7erqpkqvsamuzy2ms7w23g3vrs5bildgxu7e3k@ml2udfhaqodd>
 <20260909022311.GA166287@bhelgaas>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260909022311.GA166287@bhelgaas>
X-ClientProxiedBy: TYCP301CA0035.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:400:380::11) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|TY1P286MB3311:EE_
X-MS-Office365-Filtering-Correlation-Id: dc30bbce-7368-4904-a044-08df0e2e5999
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|376014|23010399003|1800799024|10070799003|6133799003|22082099003|18002099003|4143699003|56012099006|10067099003;
X-Microsoft-Antispam-Message-Info:
	invGvUH6p6YhzOFGYFhIy7DyVgUamNxdJ05Yt21m12VL7brMIgDURzZhKciqI7jeVNs4+FszNtPXbqih6ggElq7tmXxfAWIhpQyTqiYrkqz3pa3nRQF7EP5bn2fSPYNGQpxSQWVXhQPp5omUpCORtY78m4y/gN1pMqKxqa2ayPOSc9jBmdS/MvHs8i7i+qO45wwp+mtSmrP5eoIZGWe4XHk1M1Qk/Lv/gYKn3Gfdzzxy9d5BMYlWBqbs1ZSS8gGa+vNcxHXsR8u8e0xxanJNs4/X2BNoKrmNdXXtX88HnHfvwwO37qwD+KpIRVJ63BtytTfTVVNZRfR38YViMws0X3jEnKi31qgYIDPNgRhh2h2rSxhdJy6hFSonZBLsdJwxHHrGh+RTWUKyJonluD2xdHsJA17HJ6r4eEWF6XkDsXfI9GPQ5W5j6hfVk0kyJhMXbAzVCY4MLpoHIc8kHkBTF0KGPPqfNkJOAj3GQHTJxiQKAMLFjaIb/XwQubQ6R2htTedzjiR4x8BlDtrk5lAvtH8N/SYdTEM52bcK4QVn8liqaIUVKEFfLlobOB3/ihI+8xAMO2V3ApW+fR/EZ4eghaYPju7ckA1DbraOX1gjvXxhcSTbw+mjd/K7an9pSUn6
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(23010399003)(1800799024)(10070799003)(6133799003)(22082099003)(18002099003)(4143699003)(56012099006)(10067099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?u8MFAsFQZxm1RQRgMqIVbBlHdZdoKvOsQOzI4CqB7f/ebNz2QZA3/CDi5z9K?=
 =?us-ascii?Q?q75vb99+o3saNt+/9QhFHOd6u77DOXpNRxri6B2FdZq9LGBMwQVPM4TQ/wU0?=
 =?us-ascii?Q?Cfrok9FXZ2QJXbtb2Z2XZQIIBqWPmDK4UQEUJCCyhAmVgGBUhluyZSbZnK6L?=
 =?us-ascii?Q?T+P17zgdbX0Vp5MzD6g6GIFVd/A/2JHwzM9KE1L4ckgo1y7xR5MsTKWK0/Xz?=
 =?us-ascii?Q?fGPaqDNDo5MV7rKyFrPxlBB0Y8dRIAASTxZzXyThVDL+BuBzkLXoRy9Nn42B?=
 =?us-ascii?Q?tO7vB98ToR5Vk9KZJXn+kZGBvk7K237c1TDq/xhY2ltqAcGGriSuWaNcyK3o?=
 =?us-ascii?Q?euN+aDdyE4qFEdU3hSCJ76X7UEPExJKVlj8OX+P+PRhsTaaZNliztt83cF1n?=
 =?us-ascii?Q?G5DkdDtCIGSXrbImV9n1riiAp7QiNr48jBY0Uap1LxpeXerHCxOWlHvqgEZA?=
 =?us-ascii?Q?mXJgXa9oZQ/hM7JgltrVo+XE+FeYDlQnIsR8uYNu14uiD2mXvnnuVUpGm1aq?=
 =?us-ascii?Q?mmr6g3DvrHqO8uzVcAQEIlH8Ef7dGSpneQjRFlH3WDntu4rdi7lcC9X7wpYE?=
 =?us-ascii?Q?GeSb9+ZykZttue7t+IGatT/pUd2UKuItu4N1HhIBCCssddMKHt5XuQdJRZDF?=
 =?us-ascii?Q?ROaALoPcuPwF9HKoz7I2ul/yoWFd5bT3OKfk/o7YFI0+6LyIoakObKbKVDY0?=
 =?us-ascii?Q?rG3tLSq7fhlwKubZOGQ1FCYTw9IopGAtpg1f+6/QaZORpA4GC4C/KDeaFfMo?=
 =?us-ascii?Q?Yq3GKKApa2j2RuyJdQ7v8Tj+NzqAMcsz+SmjdvPEgOM2k+wXxCfPQWtLJroo?=
 =?us-ascii?Q?Y+/Yc6vP/MFN93hcDb3gFBtMk5btK4PlQCuxYE/JEZthVhopGu/1evYAxZsx?=
 =?us-ascii?Q?7k1CKZ3eXZcV1zJQTlfqAjyTN5q48B3WiYsRfvDKXeH1EMACxlb7lGGEJzSC?=
 =?us-ascii?Q?amq37Ed6NLdtHv6E9km6mG7oyGs2T0X8EIAzOFsw6h5kcktd32ftYhkAJXhl?=
 =?us-ascii?Q?olRwEeA9szlXohgfy0mdKJxewlgVZeUUWnDYumesHKX+kmmiz0xpcFCaiouE?=
 =?us-ascii?Q?/zVhFq0XSgen05ueI3YQhZrRa4g5IbDutnGSGu98uVI9Fhq/mp/MnOxiGdYU?=
 =?us-ascii?Q?K7az1EwanGHi9DS1WvSsSipqZYHifGMzIupuoqw2guIKseIlbcv94srg9cDL?=
 =?us-ascii?Q?zqdevJADrHc++djYdaSu+0WBZJLaA1s8javlin6cdBDvMkxl/IUJTnoaqyKN?=
 =?us-ascii?Q?WNG2uV4MtuJP78Qs878OWJjQPkh+zQ4FEoOgJfC/NfjvZoidMMWeH6GXC4Ki?=
 =?us-ascii?Q?KDU6PEtlTZKqs2CqMgw2W7OIK5tXTScQIbjkCAZM71EcOeXjLD0x1vrmgSE5?=
 =?us-ascii?Q?7beyqD2DsN8hCoeB99OJNseZA0DYoNAwWW2zFXAngQph/9nw0VUtB7dLQ3Yl?=
 =?us-ascii?Q?yHISa5rHaouQUco9quCMN1U+jRAFZt6lcfLUxxqJcQqgvuMU9HL0IajQaiSf?=
 =?us-ascii?Q?MN5fLNi3CjqGrlQkiJG6+YlCg8M8tHCo+DKiIl8RuiPNb4v0w0Ox0sOYFR15?=
 =?us-ascii?Q?+373ok3rNDy2ixFYMy3YJb7SNrSrtJMKqdo0Pwa8kdt+R3F62m5kTZIOt12f?=
 =?us-ascii?Q?88LjRlIJJtm+eQ2oudwobhJpnlAGAUbzlaepVxRWRLK2fZCF7nXPjM92tLop?=
 =?us-ascii?Q?+g2NNhrZ/x/Gg9CTtoOALHfdFnbWgHtEfPvdzXc939K5dVrYjdejmCyA4LEI?=
 =?us-ascii?Q?eHQH+9PRfg0vtAMmXQuK6K5p5ejnVC3yg9LrQ7qaZw4MeXBFXK67?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: dc30bbce-7368-4904-a044-08df0e2e5999
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2026 04:53:54.5313
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BL56IbnXJeS9pKisRw2eCeZDknMdodbUybhQFUnWCxRS7vu3WQXXXm8fdeS6k1gb68FdZygOvvgyBFR0JFYb8g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY1P286MB3311

On Tue, Sep 08, 2026 at 09:23:11PM -0500, Bjorn Helgaas wrote:
> On Wed, Sep 09, 2026 at 11:01:48AM +0900, Koichiro Den wrote:
> > On Tue, Sep 08, 2026 at 11:53:15AM -0500, Bjorn Helgaas wrote:
> > > On Wed, Jul 29, 2026 at 02:23:04AM +0900, Koichiro Den wrote:
> > > > vntb_epf_mw_set_trans() programs the memory-window BAR through
> > > > pci_epc_set_bar() with hardcoded function numbers (0, 0), so the BAR
> > > > lands on the wrong function whenever the vNTB EPF is bound to anything
> > > > but PF0. The other BAR programming sites in the vNTB driver already pass
> > > > the EPF's own numbers.
> > > > 
> > > > Pass the EPF's own func_no/vfunc_no here as well.
> > > 
> > > We're referring to these as "PF" and "VF" in the subject and "physical
> > > endpoint function" and "virtual endpoint function" in the
> > > pci_epc_set_bar() kernel-doc, but I don't think these have anything to
> > > do with the SR-IOV PF and VF concepts, do they?
> > 
> > Not in the specific case that motivated this series. But AFAICT, the EPC API
> > uses the same (func_no, vfunc_no) pair to cover both ordinary functions and
> > SR-IOV PFs/VFs scenarios. With vfunc_no == 0, func_no can identify either an
> > ordinary function or an SR-IOV PF. A non-zero vfunc_no identifies a VF
> > associated with the PF selected by func_no.
> 
> Now I'm even more confused :)
> 
> Are you saying that a non-zero vfunc_no always identifies an SR-IOV
> VF?  And there's some dependency on that?  I don't any mention of
> "iov" in drivers/pci/endpoint/.

Yes, that is my understanding of the current in-tree implementation. You're
right that drivers/pci/endpoint/ itself contains no explicit reference to
SR-IOV. E.g. pci_epf_add_vepf() just calls it a "virtual EP function".
So my saying was kind of assumptive, but I still think the same because:

- The support was introduced for SR-IOV:
  https://lore.kernel.org/r/20210819123343.1951-1-kishon@ti.com/

- The core rejects a non-zero vfunc_no unless the EPC provides max_vfs, and
  Cadence is the only in-tree EPC driver I found that does so. For example,
  cdns_pcie_ep_set_bar() calls cdns_pcie_get_fn_from_vfn(), which uses the
  SR-IOV First VF Offset and VF Stride for a non-zero vfn.

Best regards,
Koichiro

> 
> > > I don't have a better naming suggestion, but this is slightly
> > > confusing.
> > 
> > Perhaps a better subject might be:
> > 
> >   PCI: endpoint: pci-epf-vntb: Pass (func_no, vfunc_no) when programming BARs
> > 
> > Best regards,
> > Koichiro
> > 
> > > 
> > > > Fixes: e35f56bb0330 ("PCI: endpoint: Support NTB transfer between RC and EP")
> > > > Signed-off-by: Koichiro Den <den@valinux.co.jp>
> > > > ---
> > > >  drivers/pci/endpoint/functions/pci-epf-vntb.c | 3 ++-
> > > >  1 file changed, 2 insertions(+), 1 deletion(-)
> > > > 
> > > > diff --git a/drivers/pci/endpoint/functions/pci-epf-vntb.c b/drivers/pci/endpoint/functions/pci-epf-vntb.c
> > > > index c3caec927d74..fba65abfb6b2 100644
> > > > --- a/drivers/pci/endpoint/functions/pci-epf-vntb.c
> > > > +++ b/drivers/pci/endpoint/functions/pci-epf-vntb.c
> > > > @@ -1427,7 +1427,8 @@ static int vntb_epf_mw_set_trans(struct ntb_dev *ndev, int pidx, int idx,
> > > >  	epf_bar->barno = barno;
> > > >  	epf_bar->size = size;
> > > >  
> > > > -	ret = pci_epc_set_bar(ntb->epf->epc, 0, 0, epf_bar);
> > > > +	ret = pci_epc_set_bar(ntb->epf->epc, ntb->epf->func_no,
> > > > +			      ntb->epf->vfunc_no, epf_bar);
> > > >  	if (ret) {
> > > >  		dev_err(dev, "failure set mw trans\n");
> > > >  		return ret;
> > > > -- 
> > > > 2.51.0
> > > > 
