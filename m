Received: from OS0P286CU010.outbound.protection.outlook.com (mail-japanwestazon11021099.outbound.protection.outlook.com [40.107.74.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E1891E7C18;
	Mon, 23 Mar 2026 01:46:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.74.99
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774230372; cv=fail; b=uzLXWwtRta5cvIWg9N0YhxNXRMkXH08tG8FiKXE9rvtWj4kZA/JUpoWgx5vY7bUzithfln5EEXfnTXf/JjAS9gyRH81gIN2a80s7qJBKzoMD0333ErQVAcoLb0CQN6yf6pDXL5wO2Kxy5NQ7o7X6PrTZOXlTBzSqxKJWIdgJyTA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774230372; c=relaxed/simple;
	bh=juIzJXlIRsphqYpgqRW9xxe6pvqeS40e/FRwyQ3mkBQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=qsU6fHbuNG640o8EPPAccvn6r/rCl1u3Qcx+l2QlVNKq6WEaRut8+XjeA/DW4smiCvgZplyq38hIyy5Mb2dxo8PeCEnvhSHdPLQfEK4h1kGxY5LUu1Z/ywXsR7Caofv4WMdMDvYynOWp/gLQH79enPnmBMjfhHwo0tw+5VqYIuY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=LyeJbalg; arc=fail smtp.client-ip=40.107.74.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="LyeJbalg"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eINbUquydnT4XIGdCjQ1AQsiRPw1WT/+DsdbBbwmH0z/4VXMNE3ThnuXDiaFLmzuKh9koxOs6LHzvQaczh6SnDjCBp2scxaP89cj5Dp+Ghxoo5ZXeKDx9ZoOoILlgvbCdhNIfdQPsYwucFXGz9hpuu814nxNRH0vDsFh4qBh0MArGech1pRm9aCPO2UxdOkenJJxqA3vxrwO10cX7wLyy1tC/wj2AbqLrznNt0UwTOmLgi+GhKVrSHtvoTmynZJHw0yLGo7bY0laYS393CC5TIJp0J7GYdiFhwCoxdov8fH8KvicBfF69AtPRXH2lU7sCKjdDx6ZlIwt5iQouOR+uw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YY02QTFBwmmdB5ricRpBpZXM4VO+KhFN8PObgLr2d+s=;
 b=VfYi4XZo23bo7UVDo0i7gJqmTUpE6zA7ZIrRpldQcqxpQxgM9WBSJ6Hpi0fQv7klwPxJ1SWe8z533yWfVgyJKf/XUZsQdEJyY87vR5S5tihU2CPmIbmeMEsafRyW2rF1h22W7H1Sbcbb16qktWdUcxxqtIUezoOCL/aRaxqi3la/Tb6somTcjF61u4fnmLZmQ1nwrLc1QkAcQ3WQv3yOZk9nW61pYdCrc9qhNqRIqhP5+lQ0TRL2hNSkWlXGzbrbJxHxlsCnhieMqSSNQJUvaMroMqMYKIV1RXpHD7/7PT4pJKMDavkT/NI1D4UYy8w1dbCNoCrjx3YaL1OVMhdIpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YY02QTFBwmmdB5ricRpBpZXM4VO+KhFN8PObgLr2d+s=;
 b=LyeJbalgHvdeGsdf4Gi5rf8lP0j2aFs/A8OS4fdauBUvPFp/i1B8M/7j0pj5WaUmvX9guvDNBc61t28C8ynq5lC78bPrFdXXBsGTJ7RlVv4E+Q4Z5nXOMkMRMtjZpS3GPeRRUVKm3Lt5G8WZdgxWD8yyFQ2dLHE/JsYn1pec22A=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from OSOP286MB7730.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:468::22)
 by OS7P286MB6604.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:433::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.31; Mon, 23 Mar
 2026 01:46:07 +0000
Received: from OSOP286MB7730.JPNP286.PROD.OUTLOOK.COM
 ([fe80::b7ab:6af2:d18e:4a71]) by OSOP286MB7730.JPNP286.PROD.OUTLOOK.COM
 ([fe80::b7ab:6af2:d18e:4a71%3]) with mapi id 15.20.9723.022; Mon, 23 Mar 2026
 01:46:07 +0000
Date: Mon, 23 Mar 2026 10:46:06 +0900
From: Koichiro Den <den@valinux.co.jp>
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: Jingoo Han <jingoohan1@gmail.com>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	Kishon Vijay Abraham I <kishon@kernel.org>, Jon Mason <jdmason@kudzu.us>, Dave Jiang <dave.jiang@intel.com>, 
	Allen Hubbe <allenbh@gmail.com>, Niklas Cassel <cassel@kernel.org>, Frank Li <Frank.Li@nxp.com>, 
	Bhanu Seshu Kumar Valluri <bhanuseshukumar@gmail.com>, Marco Crivellari <marco.crivellari@suse.com>, 
	Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>, Manikanta Maddireddy <mmaddireddy@nvidia.com>, 
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, ntb@lists.linux.dev
Subject: Re: [PATCH v10 2/7] PCI: dwc: Record integrated eDMA register window
Message-ID: <fsgt54zbuefiyf325ndgvbuygfte5ne5dtje5shptkqnjbk5gy@uaplhztrmi3q>
References: <20260302071427.534158-1-den@valinux.co.jp>
 <20260302071427.534158-3-den@valinux.co.jp>
 <tzcqd4makvehalrvpv2t7oiioz24vuewyggnnmlcjusuhv74hl@7ywfq565tm74>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <tzcqd4makvehalrvpv2t7oiioz24vuewyggnnmlcjusuhv74hl@7ywfq565tm74>
X-ClientProxiedBy: TYCP301CA0058.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:400:384::7) To OSOP286MB7730.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:604:468::22)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OSOP286MB7730:EE_|OS7P286MB6604:EE_
X-MS-Office365-Filtering-Correlation-Id: 21d634fb-7c4d-4334-c1fc-08de887df3b8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|10070799003|366016|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	Gwdqsc3NMl3k3fO1Q0LFi9KFTjxvMKfhaVgoJi+X39EHkfkH58QulNSgpecI40xc/8lPWIdLJVUTdbYNvCRljwq+ErLuTwK4U2kG53CW5+EcLq+x6YmM6jXgric2M/+4+0t8srs0FvraDmRIxnNBS8gQaFvUuzyNFZQVP1xWFMe0NpxETK41WUlqBxzxuEjEMLmbAp/sB+FGxktyuWnESG+1K3wvrQ82vaVKomeotsI60mYmNp3laDBJjvebJzbwNLUrtFubEC2+qk2oeYxu4rXUhTxp8snvYDQwhYMOM13bXAzGt1iRWePwdpCX2BBBwzgjGmzc0XKC/naHmieFpQslKbNS/l99VjUzTVpmHzgwGLfJKIg0d1NiDY/DSLrja33g9ZCoT0wdLgwzGPmzdERVdWnOrIchr4P2A+N+u+lVvMolvKhZf7QyXqrzxP4GYGaFDs5e9iq2pQpvUN58qtCB9PXWFhcuShvXSNXbcrwknbFENtPhJM5G1b2M1WHfq00tiU6P9+BKo/6iUbqOFQaKY0ZGvxjNYUQ1Ur0cyDH6HgpFzNDqSufxAVnOG3VbEqN56x9OK7KU1PFYlaJW1endQ8Xnl2usabyGjn1IsKzqK3+rnII/Nkzzx9cNpLuPHMalkdB1luP7sGdPLj/Ur8VIJwMUgkD3Ji8oewsF2FR7GxbwJirYjIC1TKNJ1LTSrJN+H+2o6//j69E9hcUfeLEi5dxpvYvdkXjnGiiTP9E=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSOP286MB7730.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(10070799003)(366016)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WUkzU3FuZm9zc24xbVBIRWNyaGFBUnpFKzJ3dzg1cHlZSjJqR2w3Zjc1M0Zx?=
 =?utf-8?B?ZXQzVmJDWmdsVWtlZHlDeDRpUGczM21tc0tOV0NIRW1LRkVyLzNsUGR1TnRp?=
 =?utf-8?B?THo5MnJGWHlCYWUrZDJFd1VzK3dxZXNhVzFnZWQxOFJrbUZPeUZKSWZMSHg2?=
 =?utf-8?B?M0NuVzczUXhFT2RTWGhicGtRRmpEQXNUWHlTanBKbGFzM1U4TWxGYWF4VUFM?=
 =?utf-8?B?cWRNQm9tVXl4aXltYlFkejJGaG4wdVowKzRVaTYvWFpNeE1zSUQrZGp3SVQz?=
 =?utf-8?B?SGJiWXE2TXl2djhFZ0V3S3RKSWhya2lKSXVzbU1QNm1sdXZnVDFseDRMb0Np?=
 =?utf-8?B?YUJTaE5mdzA4ZWZza01ORS9vUE55UUg2VklHK2dNQk5CV1dkaUNQOXFNbCt0?=
 =?utf-8?B?eTdvSG9QNGZQWHJEUVRNWmhTVWlRdEdVdWlPeVBXRWFhN2p4VUdqVmluNG1m?=
 =?utf-8?B?OXhmaE9EY3lJWmxUb0VDcnVKS1QzaU5DUTJkWnd0NXpXODgxS2JUYmllQWIy?=
 =?utf-8?B?Sno1WlBmR1FPL1pXOFF2V01YM2tKQ1BSRUxXcnVWQ2JjdDBRNWkzajdpbGZm?=
 =?utf-8?B?RGFFSGJIZWFzQkRFUThGTk1IZEt3RHJ3UWJWdWZCcDVHMjhjZHhKQmx6T005?=
 =?utf-8?B?N1J3a0ZwVTlTVmxmbmpYc0dGMGZTTStvd2dpYkw4bDNKTnlZVjYvbDZSYlBw?=
 =?utf-8?B?dkgyRFFEaHBaeEhIZTUwaXhDYUttWDBHSGdNVGxjM1JuVFRlYWdQdXpHNzUv?=
 =?utf-8?B?N01jOVJGMllrL3VaOENnQloxZnA0OG8vdXF5UmRkVTY1Z2JwVXErTnpuZmtF?=
 =?utf-8?B?R2VqVUNOSTA3akpNUmt5clRmQ0JrdnNBZ0MxWDFFZXVIcjZmdmxaNlRESGVJ?=
 =?utf-8?B?WThldmlFcTBRWXg0OWQ3d0ZreWs2ZTVUMitNZWtVT1A2Wm5ZZEp0TGVFU2dK?=
 =?utf-8?B?YnppNjE2VUw3N0ZlZ0k1WDllSytYczVOUkw1a1hjRnBRWHFxVnkzY0xGUTFK?=
 =?utf-8?B?eWFRWlJhSTlOMGpWZGdUcGdPRzJpS1ZOcWNJK0N0eU12cVVSMDhUQjh0WHVn?=
 =?utf-8?B?Y2JSaXppYXFoTTNQeXhSc0lNemlWNHlYSDFVYitQY1k0SitIUkJndlFQeGhO?=
 =?utf-8?B?WGl1MXlrK3loYmZxTkJrcE1TQ0l2Vlk2bnFaZW8zK0tVQ0JNTXMyeHZYWWJS?=
 =?utf-8?B?enlXZUZ4SXR3dTJocTRzVnBzUDh2Y1FuYkNvMEtmbDBEc01UdWJIL3JVTkFG?=
 =?utf-8?B?UXZuUEZzb1dXSmNwK0tzTTVEVlEvblY0aFpvbGxyTHRjMXBqKzgzNVMrMlFh?=
 =?utf-8?B?bnVtS0pIRm90dW44UVZYeVlMQmFzazVYcnhWaDBBNjBndWdrTUNNbGlxYlNj?=
 =?utf-8?B?T2ZKSy9tV3JiUkZUdEN3YWFxSEt3MnFpQk9ybHBKMFlIb2VPUmQxUy9RSDgv?=
 =?utf-8?B?cERXc3ljUHlKSGoxYkJUakVycXVFMzI3TnpEcTlNbml6MDNLVU1IRno2cUl0?=
 =?utf-8?B?OGsxbnNvR3lGYXRicm5odnRXazloSGU4SStzenhtVGpaeHh1cnVLRVFJYzVV?=
 =?utf-8?B?ajZSTXU3ejhtY2ZnWW53b0VhZEhQbmU0cUk0Y2t1L20zZjRPRHdURldtMWdV?=
 =?utf-8?B?ZERjTUpCYVRaaUlJTTVraVlsRzhRYm5KQWoxOStaMXJ3OFBtbnhITW9MQTRU?=
 =?utf-8?B?N00wZHFBUlUxR3Bsd1lEbEFUZzkyS3RsblA1a2lXRmNOTmtxYWJjNisyZEdH?=
 =?utf-8?B?NUpyTXYzdkY2VW45VTd3UUhHOWhJOHZaUDJFcjM3cUYxRW1oalVKQTJ6M1dY?=
 =?utf-8?B?Qi85TWJ5a29zK1R0MVRJTENPSjFDYVhHSXNYT2dVcm1PRVpyWTdZVG1pV2pS?=
 =?utf-8?B?VnZxV3FxMUNuTklqbmtxZjF6ZDJJVjlJVnRkSlYzU1oxZUVsY0pBWVYyNDBI?=
 =?utf-8?B?cEZQMkJ3YkdLR2l4SFZhZUcyMW90cnQ2a08yYVZrMzRkcjZFWkJYMkpsZXdz?=
 =?utf-8?B?TERCVmtIVzU2NHdWNE4xN2Rub2ZoWnh0cWhMb1pxd2dMTFYyMUJmWWMrMU0r?=
 =?utf-8?B?emc3M0hpemJwd29XRm5vcW93S29KbURjWXIzdTRoMC9XTmxyTEZ3NERlR0FK?=
 =?utf-8?B?TWJ5aDJSOUdDSTlxeUFSc3g3MzF3dmFTQ2NSaWJkNjEyeEl3Q0k3ekZIa3ZJ?=
 =?utf-8?B?K0VHWXNoY214Y3B0M2ZSZEFodnRBN0RRM0RXTUo0NFk5SzFYWnJvZysrMUNn?=
 =?utf-8?B?NHZqT0lESGUvMmo0MXU1OXZPazY4WnVkRXFzbFdMZW9sR0EveVpnZFliQW56?=
 =?utf-8?B?cFcxbjRkSHVuZEFmbGwrY3ZXNWMzWGRyR0ovd2NMU09SQ1Fvem1DNkhkdVdw?=
 =?utf-8?Q?nmI1KKV1VcGV+b7wUp5F537jSOkw0hEUPDVfF?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 21d634fb-7c4d-4334-c1fc-08de887df3b8
X-MS-Exchange-CrossTenant-AuthSource: OSOP286MB7730.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2026 01:46:07.5281
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WffzQ9mOFurVymMO0KV4iEeIofwYPU+L48lKeaCzEsdPDPhYp02CZfBU17cyOKRoxJ68wIaw7kajp2WcB5d+gQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS7P286MB6604

On Sat, Mar 21, 2026 at 07:51:08PM +0530, Manivannan Sadhasivam wrote:
> On Mon, Mar 02, 2026 at 04:14:22PM +0900, Koichiro Den wrote:
> > Some DesignWare PCIe controllers integrate an eDMA block whose registers
> > are located in a dedicated register window. Endpoint function drivers
> > may need the physical base and size of this window to map/expose it to a
> > peer.
> > 
> 
> This sounds exactly like 'Remote eDMA' concept where the eDMA registers are
> exposed over BAR and programmed by the host. So why this duplication and why
> can't you reuse remote eDMA?

Thanks for reviewing.

The intent is not to introduce another "remote eDMA" scheme. I am trying to
reuse the same model, but what is missing today is the EP-side resource
plumbing.

In-tree today, the remote path is effectively host-driven, i.e. a driver such as
dw-edma-pcie discovers and maps the remote eDMA windows after enumeration. For a
DesignWare EP, we still need a way for the EPC/EPF side to describe what
integrated eDMA resources are available to be exposed to the RC.

This patch is only the preparatory part. Today, pci->edma.reg_base is just a
local kernel VA, but the EP side needs the physical base/size so it can expose
that window in a BAR, or reuse a reserved BAR window as-is (e.g. RK3588).
Patch 3 then exports the eDMA register / LL / doorbell resources via
get_aux_resources().

So this is meant to make existing remote-eDMA style exposure usable from the PCI
endpoint framework, not to duplicate it. I can revise the commit message to
better explain this.

Best regards,
Koichiro

> 
> - Mani
> 
> > Record the physical base and size of the integrated eDMA register window
> > in struct dw_pcie.
> > 
> > Reviewed-by: Frank Li <Frank.Li@nxp.com>
> > Tested-by: Niklas Cassel <cassel@kernel.org>
> > Signed-off-by: Koichiro Den <den@valinux.co.jp>
> > ---
> >  drivers/pci/controller/dwc/pcie-designware.c | 4 ++++
> >  drivers/pci/controller/dwc/pcie-designware.h | 2 ++
> >  2 files changed, 6 insertions(+)
> > 
> > diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
> > index 5741c09dde7f..f82ed189f6ae 100644
> > --- a/drivers/pci/controller/dwc/pcie-designware.c
> > +++ b/drivers/pci/controller/dwc/pcie-designware.c
> > @@ -162,8 +162,12 @@ int dw_pcie_get_resources(struct dw_pcie *pci)
> >  			pci->edma.reg_base = devm_ioremap_resource(pci->dev, res);
> >  			if (IS_ERR(pci->edma.reg_base))
> >  				return PTR_ERR(pci->edma.reg_base);
> > +			pci->edma_reg_phys = res->start;
> > +			pci->edma_reg_size = resource_size(res);
> >  		} else if (pci->atu_size >= 2 * DEFAULT_DBI_DMA_OFFSET) {
> >  			pci->edma.reg_base = pci->atu_base + DEFAULT_DBI_DMA_OFFSET;
> > +			pci->edma_reg_phys = pci->atu_phys_addr + DEFAULT_DBI_DMA_OFFSET;
> > +			pci->edma_reg_size = pci->atu_size - DEFAULT_DBI_DMA_OFFSET;
> >  		}
> >  	}
> >  
> > diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
> > index ae6389dd9caa..52f26663e8b1 100644
> > --- a/drivers/pci/controller/dwc/pcie-designware.h
> > +++ b/drivers/pci/controller/dwc/pcie-designware.h
> > @@ -541,6 +541,8 @@ struct dw_pcie {
> >  	int			max_link_speed;
> >  	u8			n_fts[2];
> >  	struct dw_edma_chip	edma;
> > +	phys_addr_t		edma_reg_phys;
> > +	resource_size_t		edma_reg_size;
> >  	bool			l1ss_support;	/* L1 PM Substates support */
> >  	struct clk_bulk_data	app_clks[DW_PCIE_NUM_APP_CLKS];
> >  	struct clk_bulk_data	core_clks[DW_PCIE_NUM_CORE_CLKS];
> > -- 
> > 2.51.0
> > 
> 
> -- 
> மணிவண்ணன் சதாசிவம்
