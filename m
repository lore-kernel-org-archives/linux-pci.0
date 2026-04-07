Received: from OS0P286CU011.outbound.protection.outlook.com (mail-japanwestazon11020078.outbound.protection.outlook.com [52.101.228.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D069E4AEE2;
	Tue,  7 Apr 2026 14:56:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.228.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775573771; cv=fail; b=ugs0jaPaLJNw8AI0XWU9WjTbUug+7R4vy6+E21mMh1HMg0SKP7yDkKUkDvuwA6rueIJscYTOBCMqx1x1/SJzqGAgBGf38dCVXfwBZDwYrna8r2/SelxdXTTdpcg4jeCjpbm92ccrn8iuYlJqg8br5PjcjnRiokSCumOBMzruagI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775573771; c=relaxed/simple;
	bh=FQUNAXAaXMWmhpFbTxVaBx/+UzBy82nms37Swev7ZZw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Yr08Dt9o3vmuZBYBFnNMSbFjuOiCdkTJQVSeNy2kPfWx4eMppjjqggbhMoyCVLdL/y3BkALNMD7Z0wMMN4Z+IJ9k67+nijRFqrzXk0sh5SNhRnrS/5XD9VD/feAOuNMHHu7iLB/kKWoWXTZOxvj06ECWAyE90HkUDB9V/1d1jME=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=cFCRw/N1; arc=fail smtp.client-ip=52.101.228.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="cFCRw/N1"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hGoHEwbSA+jKENJFDABOzN+foQqBBbxeXqO/JAn47dCqA+8nVL/0SDmh5VoJ7FP9GEBtwgPM++WAY6wLknw4DQoxg+LhsqP9JFQ1coJnbjthNrKwZjb1RQuQKUCjzrnnExnnmZgQ2kQD0Fec6f4vOBscI+VmQBTJz6xHqu55gbFC12g/9J1tDTVEEPEzEpDH2dNCISNLumhDeqws1IMkcZzZRf0k50wUIRxwH97Hc+un52ehKWrBpcBZMbweu7ZAzoKzQV9HS/uPAEtgaJnUWxr6y0Kx+6Mcxtpgfg80XEw1JoTji8NP8xH8mu6M5BGOHbtZWhGOjTkZRNxWfOXV2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cZkqCrq24ViSmZkZVhlSeAs0dfd3/gFXIUtrqEdxCt0=;
 b=wXUoynqiPPL16QsrwG/y5eW+IkEvsuYrGi7ToBSP9QUnBS66VHZ2mXHxkqVDhJaVxLxXI45XpTHtYgSpQWd3bmdQxvvj9dw0rUWVby6HAuHJhacl2Z0hjv16saL2B9SGr9Qn/XtQfWUHEKo7wMZOZ0B2PYYkpvCoASxCfrF8V/tw3GOnsv82J06jkqsfGuD+eiesL7Ab9tJhwEIqexaaatxMaF+qLC/OQx6TsyOz7vLLgRDWYyBZLtim2ynxs6PIEtfaOYmg05lZKPecZnTJ/uIc1xrQEuaz9wOdecd3ljqoHpe0IjT6RCqnR3lyzT5fSPc/i9BJAhPtTXewejy9MA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cZkqCrq24ViSmZkZVhlSeAs0dfd3/gFXIUtrqEdxCt0=;
 b=cFCRw/N1kCKCs/cmf9videlVqmDlnr3oQovxk05CdHbr6/qkXydaGeVoZnWAPMWduArmtGuLr7tq0jS50ovsb+1DjYccyJgzqZtjtzWcHOl8JhTXopTTuoWqMx+/2l/t/cZi3D/h4+AQRJSXbcKsbtrTQD0103nhL5jmQ/YCQHY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by TYCP286MB3740.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:38d::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.18; Tue, 7 Apr
 2026 14:56:03 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%5]) with mapi id 15.20.9769.017; Tue, 7 Apr 2026
 14:56:03 +0000
Date: Tue, 7 Apr 2026 23:56:01 +0900
From: Koichiro Den <den@valinux.co.jp>
To: Frank Li <Frank.li@nxp.com>
Cc: Jingoo Han <jingoohan1@gmail.com>, 
	Manivannan Sadhasivam <mani@kernel.org>, Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, Rob Herring <robh@kernel.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, Kishon Vijay Abraham I <kishon@kernel.org>, 
	Jon Mason <jdmason@kudzu.us>, Dave Jiang <dave.jiang@intel.com>, 
	Allen Hubbe <allenbh@gmail.com>, Niklas Cassel <cassel@kernel.org>, 
	Bhanu Seshu Kumar Valluri <bhanuseshukumar@gmail.com>, Marco Crivellari <marco.crivellari@suse.com>, 
	Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>, Manikanta Maddireddy <mmaddireddy@nvidia.com>, 
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, ntb@lists.linux.dev
Subject: Re: [PATCH v13 7/7] PCI: endpoint: pci-ep-msi: Add embedded doorbell
 fallback
Message-ID: <7wteqgmnzbkrv5427nwxmjgre3l3vrpvjcubm2bwhr4pkmsqup@a2hrkg33z4ly>
References: <20260406155717.880246-1-den@valinux.co.jp>
 <20260406155717.880246-8-den@valinux.co.jp>
 <adTS1gj1nqi9DLFZ@lizhi-Precision-Tower-5810>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <adTS1gj1nqi9DLFZ@lizhi-Precision-Tower-5810>
X-ClientProxiedBy: TYCP286CA0358.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:7c::9) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|TYCP286MB3740:EE_
X-MS-Office365-Filtering-Correlation-Id: 4a7cd42f-af6f-497e-6a7c-08de94b5c9ca
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|10070799003|7416014|376014|366016|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	2ncMHnX3iWQqEVLDCcMqdnZTEWk7QY8OckK8jdvoX+/UhehC7eG1iZIBxfyg80MDAFUCc+fbDRbOVLdIxwD2tAnWvMzq81vPtbPlsmYB/T3gWq+dMp7iEpQeJPko0mCfdStz1qhXWXpWts119UDXABSIbmuEaDAnQ1DVu2e0cXqEHis+ERCnJ8PiF7Kp2Ry/r4d97Hp1oRI9xsNXwvjejfV9as3LAx0TcIwmApYkCws/S9ykfGArYHnpdseU+HHXVLczZRiUvcicyWo5ceuJgjetlVmpey6lkYywvgz3pkSW4EAVWHvxfvusnqhUHjsuI6N8MF62ljWgx9fdZEpJA6+iEr/ikpCDxc9nt5Ij3yUtBwKiGVyemgNZgtzkdqkwHWXHg+5KCMKHXe3phXjXRS4fUmZNN9nR1lz5upCQLR3+19uHTJFGQetqzUA52qW98U1JzuydXNdCIzktss1tooQ7ApT3zbnadnCFi85yzcdcNlu/cOZPxKAffVDLc2eg7ZSs8+Z4UYDIp5RVe35gZ2hkFK+0PW4UOKsVJJ6HPJMx0VgNMLwZDWos25MG+hS8JOxsFXm3oj92Zg5lZUnX165mUB4nC8KRYKi8ixMJWiAwiRprhVJMUPzNMNzTlsbbZ5nDwBG0S2X7OPaTZ9ZuEy7RYTenzIyP3fRRYOZxKah4mvQQKdbQUYk2kmwsRfJo2HVygl+mQCbPH0v+a3i+79/CJ0jv5FnoiFEwXI7XnAQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(10070799003)(7416014)(376014)(366016)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Ly/nOyrMJOpoFUUmo0+zdhWVaPep/CXO5pniKU10/o5UwWktmOV4MFAqYep1?=
 =?us-ascii?Q?7khu59z8HHz/Ijr4zqzoR7gODP3ypxmkEZwakUvnuc5HXsCeRvGIg/T2kPc7?=
 =?us-ascii?Q?M32oj22UY2Ed2YGlujAaxtNfiIHUSlAsEKqJp7yTclXoJAvOX+y1ZV+YhNaL?=
 =?us-ascii?Q?0yBKHQnuo0nqMV1Ltx+ouZblmXS7wcZmk2Xo8nVFxg/XXIcp/PEfy0cy2L3I?=
 =?us-ascii?Q?uG4lJnKSFoKYIjthXoSWyhr9hBDpXQQCKRvUBH97TA8BNiSsUf4OVcBxqzUr?=
 =?us-ascii?Q?FGhMG+M6sN/6AEo5r716TfCUydifeuC/qFBII+TtW6l3gZUKBg09d4HAWOP4?=
 =?us-ascii?Q?vDTGlG/qA7+ax6TFSup/qkGeJCiSHhY31jAhlYcQi6VmXMelZ2CjlMeUOqo4?=
 =?us-ascii?Q?Smuy5OlxIH3IHS817vdstSNtQaH/Gl/hi+itSkf693662QgU6te4ukL8mLRP?=
 =?us-ascii?Q?K+6YW84nxL5UCy+ATWphIYav3x+KoKNBjYLotYo5FJCCzCc/ZRVa0JnDDmhV?=
 =?us-ascii?Q?S092HhjecWuahs3gcB3fOQqV/ScVNoVC1p3kn/Eef9vJSdxUrYlX+3WZvH/X?=
 =?us-ascii?Q?4S0fDDN6Gi4EfzMLtOYBH8vM+XFE797q9gbkapVpqaZRuBFvJBJYwc23o1Gx?=
 =?us-ascii?Q?cUVcrxN2P1uU7P9gVXvmEbJeFeFQCRZZ3h2xCaC28+iVe8mlTxTP/ndjbeLi?=
 =?us-ascii?Q?0V8A2WXOrTIzvXobnd+t7W84MfLIE/Ow4ZDHY5FVReP8tm/Jrf6t1yhqKIUQ?=
 =?us-ascii?Q?x1q5Vx27Qeq85VNGi8DeaX6wQoXJ22dPgc6xUhY3EfkgEqDQrMxnR9LSOTbJ?=
 =?us-ascii?Q?cWyD5Guy/iGqACtW6XL+tdkao6wvM9Q+r32zsH3Ko8PGfOEv12gbMW9nwCOB?=
 =?us-ascii?Q?3nRX3xwngqwAKjhsqTTNOOVln+H/z8u0H3PmnfUa3dwHJdbfnlkhN6MZcWaC?=
 =?us-ascii?Q?DuL4O28rSPciDOcayaU8We2UqzMFeOIzA+TKzw5YwWUNkCtay1R98TmU5tjj?=
 =?us-ascii?Q?/7d5s1QnjkVenZWxCLr3t0eZLrJwkbzsCBvb3BO2aHkjRaxpjz+3p8dqBEet?=
 =?us-ascii?Q?9z9l0ZKDImz/wkITDgCgN4A5Zgh6x0VldlHVz6bapyhkGRFmhlurqCb4Cxoj?=
 =?us-ascii?Q?aTPm725pO+vMc9gGNpwfICQkf0jFh8y8MkZVWx7xrkUjhOyfykSFzPPiaZTb?=
 =?us-ascii?Q?6mQi9uqSM+u22xNrygOq/NUg74ZaU6Vkb8bKohcbn2qlTCnQWzwWXwyTs8du?=
 =?us-ascii?Q?t6pRYXicl+VBth9Byehod7g/6Hmdiwv/UfRZyrkGv4tgx9cBLKhWli7b0Qvr?=
 =?us-ascii?Q?i83cQkegw/0mvexulh+P9u8L0fkceFnE8+xUciKcVEMVYuP/wO67LiEI2FNn?=
 =?us-ascii?Q?iEvgK0tKNYB9Rc1R9XxOmDbpa+ViSm1k0qeOR8WMscM2772Io5ZpC4a4YM3J?=
 =?us-ascii?Q?+LmIZki/eb8/KfEgdLYhwR7FC71y8lFUOx/T9Wnk9MJEHw42shEAhRwf1cHp?=
 =?us-ascii?Q?uoMNXB5ahYQZwcsLEoVA2SAHBOhkuptS3SHQ1q7N7OzHVeMBfY9ZK7KQkeMR?=
 =?us-ascii?Q?BJFyu8yNOpd9dY2Wlx5n7iiPKSLe9PpfccoaOX8dzajiPMyliRgfyTBDlzG5?=
 =?us-ascii?Q?jFG5BCbdQnzu3g/aGHtP/zNk1TXCprwrDPLRPd91rSflux39GTKcUBjpVx3K?=
 =?us-ascii?Q?klqJ4qNaaPiPb1r2pF/h/ijrFhIFAsxGTc19RCuCIr1nuDAcapG3xMe7fbnm?=
 =?us-ascii?Q?6epb8b2q76CJMWYgfeXb8dAgaJXiAIcPp17CNIw0U6az1t8aqg2r?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a7cd42f-af6f-497e-6a7c-08de94b5c9ca
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Apr 2026 14:56:02.9450
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TSl1itx68QdPjOS9h4C+kG6KUQYCA3ACNcECKluWjGzdVom/XJ8LDxv2+BfKUUvnFafPwXLEdItPWmCqWGfkog==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCP286MB3740

On Tue, Apr 07, 2026 at 05:48:06AM -0400, Frank Li wrote:
> On Tue, Apr 07, 2026 at 12:57:17AM +0900, Koichiro Den wrote:
> > Some endpoint platforms cannot use platform MSI / GIC ITS to implement
> > EP-side doorbells. In those cases, EPF drivers cannot provide an
> > interrupt-driven doorbell and often fall back to polling.
> >
> > Add an "embedded" doorbell backend that uses a controller-integrated
> > doorbell target (e.g. DesignWare integrated eDMA interrupt-emulation
> > doorbell).
> >
> > The backend locates the doorbell register and a corresponding Linux IRQ
> > via the EPC aux-resource API. If the doorbell register is already
> > exposed via a fixed BAR mapping, provide BAR+offset. Otherwise provide
> > the DMA address returned by dma_map_resource() (which may be an IOVA
> > when an IOMMU is enabled) so EPF drivers can map it into BAR space.
> >
> > When MSI doorbell allocation fails with -ENODEV,
> > pci_epf_alloc_doorbell() falls back to this embedded backend.
> >
> > Suggested-by: Manivannan Sadhasivam <mani@kernel.org>
> > Signed-off-by: Koichiro Den <den@valinux.co.jp>
> > ---
> >
> ...
> > +static int pci_epf_alloc_doorbell_embedded(struct pci_epf *epf, u16 num_db)
> > +{
> > +	const struct pci_epc_aux_resource *doorbell = NULL;
> > +	struct pci_epf_doorbell_msg *msg;
> > +	struct pci_epc *epc = epf->epc;
> > +	size_t map_size = 0, off = 0;
> > +	dma_addr_t iova_base = 0;
> > +	phys_addr_t phys_base;
> > +	int count, ret, i;
> > +	u64 addr;
> > +
> > +	count = pci_epc_get_aux_resources_count(epc, epf->func_no,
> > +						epf->vfunc_no);
> > +	if (count == -EOPNOTSUPP)
> > +		return -ENODEV;
> 
> why need replace error code here ?

Thanks for the comment. I've been somewhat on the fence here, as this conversion
has been in place since v5 without any objections or comments.

I used -ENODEV here as it felt more natural from the caller's point of view,
while -EOPNOTSUPP reflects an EPC-internal detail.

That said, propagating -EOPNOTSUPP should work fine, so this conversion can be
dropped if preferred. Perhaps keeping things simple is better.

Best regards,
Koichiro

> 
> 
> Frank
