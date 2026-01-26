Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazon11020140.outbound.protection.outlook.com [52.101.229.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4946933B966;
	Mon, 26 Jan 2026 14:26:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.229.140
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769437620; cv=fail; b=csveds58YOepTOQLJ1xFQXTYKdB6jwNTbLDhjc3nDdvQMDVnroX8wi4RG01WHEAjWjo+n6w3sjIjFy2RhPg7yb1tRAL5+KJ0zec03KSMkdVfA06jafuaYfTsOc2AJQCEtfzn58npdyqMlEguh52yqyulmUvNMQVKRXfGvUYx1xQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769437620; c=relaxed/simple;
	bh=T7GKxlkS1bWhJ/r8S8q4pBi2IzqTaF5yDqnRZb/nVjM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=aFhujnsKHz25pD2bWTP92BhbDf+QOVrciw0dF8h8DpkRNjjnF8AhXKpCheMsYdjdBZez/JLu5g5889NzZk6yTT/3B/b/QgddR3IflWSEHp4rV3cKHzxI+WHpzpUIFIJ/5DGHHIzrVzo67+/j+2Ssxm2ZWJ31rT+SsXV5VX9O+1g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=H6j/aG5E; arc=fail smtp.client-ip=52.101.229.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="H6j/aG5E"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HYkSnSrPNoJ1ZkgHiTb+oKNB4PJ5r1huR09BJTWKpEvbhiIleCWL5g9kE5HiW4c8MRTzXgMLYTJmRYbNV/AMrQ1PZthHoM+dXKHgwvKKdls/A5j/7tt474NmkAVPBBm9Qyz4tIz5/ZvA39GOFsZybWRw3Eq+qHIRfYloqTWEeOJrwaEAfDpJdvXzz1qIhs8H4BSQddMy9HVBR2w4XA/4+zBLXg//1p4z8g6D4ERQ/eF/z1LjfNRiGguy99EZWI/+fACdx0ytE3GG2T9oyPIqvPHvFkNU1ogonNr2mlQEOY9jHoy+7f1HBThMFRkUfKTupNPm8Y9K0dgY87pV9qfvQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wf0Z6juF64vf5KnlaXukUVX9uVRFCMQi4ZwJH4Cnp/E=;
 b=DwX2lhiNKfmS9wFcI9hONPYO3dEVymLappwIeLmriEB+u5BEMsyoUtqGdcue9s9sAKJmz0YYpY7izbIye5occpukMuQN6y3lbiNwiTg9uQr+b1C2LvSlIeIzkB9WyBsNn24nM3N6NJwJi3aZj5UFw3F51BdBUcBsFHduVqdchtP8bk4ObN4ng245XHZ1xZgBGS5aGII4fYcyfkoIOQRy/eNovIHQ3uPZTsvQ1slnpFCe7zrKSGjpRzABuW9jpR9yPIEvXr/jqKFxGQipHn6jtC7ELGu3bQRzUxTMJDLd1wOFGqwaazUFioyz3xQBkxYHq6YmAodT+i9OTrLdwdVUWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wf0Z6juF64vf5KnlaXukUVX9uVRFCMQi4ZwJH4Cnp/E=;
 b=H6j/aG5ErJYFzZVKGziuTytxGlORZ8A2s0Zmf9EkWV5BI6IpC9YaxKUHx1Py8xphHQOApcXHfvJ94H/uBzK4PPDq4xZSH4Nc1wiBIw0iWsPpe1OcAjaKI6/B9jMBzhDtoHAElFqIk4RXdyGfqhj6ib7ChW1XPuEVbilm+ldDj3w=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by TY6P286MB7430.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:360::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.15; Mon, 26 Jan
 2026 14:26:51 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%5]) with mapi id 15.20.9542.010; Mon, 26 Jan 2026
 14:26:50 +0000
Date: Mon, 26 Jan 2026 23:26:53 +0900
From: Koichiro Den <den@valinux.co.jp>
To: Niklas Cassel <cassel@kernel.org>
Cc: Manivannan Sadhasivam <mani@kernel.org>, bhelgaas@google.com, 
	kwilczynski@kernel.org, frank.li@nxp.com, linux-pci@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 0/5] PCI: endpoint: BAR subrange mapping support
Message-ID: <f7rkqbvq4rrpngafz5hr23zza6hfrslym5px2izgdsvlnvqvfu@v7zk3jks4cuu>
References: <ugxohcm4tvtjwnhkkz7jw226upm7o5hihohzn2f4eoamhkd77v@mjefdgxneghm>
 <waapztvy6jyjqtfcoo3rbgvagi4z3p5afw6x2acgf5bxatcui6@nkodhtqqtetr>
 <aXHfUyd0EPFnoVBO@ryzen>
 <tvaumsi4ahosz4herbxoc636fj3lhetjzqlwp5n4e34tthmn26@bld32k6xntmw>
 <aXI_ny1-5NlN8r_z@ryzen>
 <ajuq5dpbzzoghd2hk7cz6w4t6jzcxfmygbyiciqjjhhg6ipkoh@usuhzmne6cap>
 <nrvamhbpi4372c4qmb2q3h74irrqkntlb2rwfasiorgavylp25@rx2lp6ldk64j>
 <aXMytcJTIeBHatIF@ryzen>
 <t2hsk77mp3shacbehlqfnpjgc4az2phvo2cyjn5hkybqdmzrcj@hnuwporebhz2>
 <aXOMVYowDxHBL8kg@ryzen>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aXOMVYowDxHBL8kg@ryzen>
X-ClientProxiedBy: TY4P301CA0124.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:37e::14) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|TY6P286MB7430:EE_
X-MS-Office365-Filtering-Correlation-Id: 2a723fc0-5bf7-440f-249e-08de5ce6f221
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|10070799003|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?X+++nSX92Gl19eMoyABHVbFc2j+q+5Iamw/hOX/YGAmr5VycC5P4qebbG4QD?=
 =?us-ascii?Q?y/EcTZps/73ZNpEdY/rGrGPohRcc2/0bZYsIxtCQdbjCJ7t3x3Dkp11b5VIB?=
 =?us-ascii?Q?IZnX91iZBJ1iIKuotizYxhFav1oCg37BX0f7Lj5VIzDh+mKImSF3ztbbwhQG?=
 =?us-ascii?Q?2/TjZ37HGUjh0XHuHjXap4KuVNKDJgYYYhF+Gfd9M6bexRpDFAMemRIboAwS?=
 =?us-ascii?Q?E8F5kcjKQUdnJY6qp+pAsMhEx63s3GbQfvEJ3GFjbz8unFV1fVAZxreN62Al?=
 =?us-ascii?Q?1O0rfUZwTMpynQAVE+8mElN8k9ggIJFiAwqHCo/2DDXUumUDLM1IGq1vR2h2?=
 =?us-ascii?Q?U/8cW9jDgEqWQ9h4PAYcznal924Gpns1NiYJ6NXLM7Z+aQoGPoxjm7A/E8of?=
 =?us-ascii?Q?qQMmTabLCmmwfxgnBD4ciOspCLFPs0Z+iIRL3VYFD2AE90Ua04JzIyFGTIvQ?=
 =?us-ascii?Q?qxxC3juN7ZTsln0ojoL8CTs3UQGFr1WfWimF/1Wp7PPGxNDsv5rf0emuIu4A?=
 =?us-ascii?Q?cl2nvJiWwZ7+GR8bpsbtztxT2x2aNMLSLI2hwCadHq+nK48n+1bXDHVw67Jo?=
 =?us-ascii?Q?H/uWzGP6OKNUhEm+tz7dS34fywczUwpvzb8BiG8rsw8Pgfd29CuImhj4nc98?=
 =?us-ascii?Q?aGuCgHcjyCx8AOumgLgQlhvQcnqLSAbwXLU1xTjd7J7Y6wrLaxlukbg/IAzs?=
 =?us-ascii?Q?jW9njJ5UvaFYROj+PV7CNkCelhGBj/6jM/jPOh2iogFbHsijUPNe5IEXHt7e?=
 =?us-ascii?Q?c+znwFMY5Y+9K5RLpwBoAl9cvimBTj10Z/QPf1adxIug/Xwf7xoNCtjDmuqA?=
 =?us-ascii?Q?ZiqwhfwwdQHqbt6k1M5C8EYt9ujSyLWmzI3ebe2vjv+vOoeApOgvu805QXEm?=
 =?us-ascii?Q?GPe15vc67rKecTzZj5MGZa1KWhk4u+x0DHYlzsC3yU+S8hIRTVhnW//PyKq5?=
 =?us-ascii?Q?3zxs26ErXhKLE/bccrEYagzlMtztCMgBgNw2mEInMBZ7NpLON/TzwBWqKcHY?=
 =?us-ascii?Q?rnzF+U5rNBh+yAgSGIBud3zuTRZp0x//sExuHe5QC2MM6KHMOXzriZoSXNkR?=
 =?us-ascii?Q?+c+ArAtiWRzQ5MWqpMXKBrsN3z1//W2g4yPiUQJB8AGhpSL45Y194lfkfM2d?=
 =?us-ascii?Q?vLyg5rQYmitM6dt9/YXyEJEhbF4Um0gwKdOilVEDC6I0NvU3aWaatKGNDYKd?=
 =?us-ascii?Q?MRKG0vZQKF81OfkKMWfK3w2LMT9Oj8Iv6JZPa6F+TbSOiVQ+S4W/rAoJD5f7?=
 =?us-ascii?Q?ikkBzhip4CZgIafEugUlkGQBqcZEMHCptNx7ShNst2aAaf1f+oT71hoBfWou?=
 =?us-ascii?Q?AOnDH3As4qYEGYHfdB1+b3PEOnBG7625BucPcCJNuWqwOPnyQaX0lZYbdeti?=
 =?us-ascii?Q?c2NNXyfzEQJadEXbzxRc0WeuFQzS98uBuJKocS3pIdK2Pt4WI4dNwnnkbDun?=
 =?us-ascii?Q?UhbG8S6Hn+GUppYgi6CsJqkKvbq4dj6k+X1g7oIOjAZO7vk0kVx2BXPn5/IZ?=
 =?us-ascii?Q?3aVS5+K1prLZMWBK3mCub2/5W1ZzFFMcvS4gBGBbSUbIpqlsw3WQ13W+pNQ2?=
 =?us-ascii?Q?NqqSBbSDUIELp/CDKD8=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(10070799003)(366016);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?04FFc4taF6/UqqXTYU0S1nIUki9MDX8goB1DgoUZ2EKxrmuJaYHv36umuOKS?=
 =?us-ascii?Q?Q9ASMNwF1cQ+w4q/YOZPtexZ792YOIbrm+yKvKx7uj/3CtwR9GcpLwJmBi3d?=
 =?us-ascii?Q?b4pd8dRhGn+NlIbYmEc9YZKfXIVOMsSxDsRR4eDeiPJRgPnr04YdR4Kq29ul?=
 =?us-ascii?Q?NVXh5KBMaSw5T7z4pXQ/pWpxIdmK3uqWYU31ZjRnWcPJTNWUEumnbFmEIo8Z?=
 =?us-ascii?Q?/6HL4b34EVc7i21zj0TSYpBa6CAnZ59/mrbhL2GYo6+4rfKQsROFq1wJ8lsI?=
 =?us-ascii?Q?aKNugnT8dr7VFtzAaJBkJeYstRB03NwKSgbwkVZQdSQoeoalH+KRx5skYyAN?=
 =?us-ascii?Q?BBqLDKpjuTvDc92LcQ7cf8KsTkBzbV/4ou4K3FRPA2d2jrOOKWzw9oi9TS6y?=
 =?us-ascii?Q?FCJlij+SgTl+QfGuRioQXnI18USk/Uxt+oIGjJkJU0oBLUjkA3R0tjKiMa2T?=
 =?us-ascii?Q?emfq9wZhfTfL3nO8ijCiMB2naAdsjMLQGNV6RiqQZYiDg0wLxjaOtxxTsQRj?=
 =?us-ascii?Q?3Jb5dhVF6xx310Ya3MyKahOFo4dcAycToZj1xo2EiyY+RhFxxLiMITRKrknl?=
 =?us-ascii?Q?3q7FW0rQjAoeCGIOTtNEY/9bR92vBQLk17G3DJCamPG9mRfRuOwXpOaP8Xq5?=
 =?us-ascii?Q?+rCUVndTbwe6EWpAjQHltSRO+AkntMjhHQCNAwprN3fZkFXOgsVRYgSEqHUL?=
 =?us-ascii?Q?eS0MyxVAPxWIp7pDAMW3NWlPqDD+bdS7LxrP77OSG3TMVH6m6aAdWDwkwNyv?=
 =?us-ascii?Q?4J+Ha0z5OpDIk/nSm1nCHbgq+7Mll5ZpI1i5+txD/0POmlMqQFX9NJMi1QHD?=
 =?us-ascii?Q?FP/ZLLd4jDxnAxVOGc2VNOnVbUpc5Fljtg+DGH0zk/h+teipemYSMDzE3msC?=
 =?us-ascii?Q?GEJqbUuvHpbdmDgtELozCcSOojCk2gkDyLElmYtKFoWwB3/KAkYp46/xexm0?=
 =?us-ascii?Q?rCV0ZZ3regsPZKs2JTH2jW5N9MA7EJ7KodeSSRtzEY0Pm2hKgVSV1cIP2dCD?=
 =?us-ascii?Q?xOvbiVorQtFFjp8KNl4GmEqKo7gZzkvtOh+Y2rsCh1HIFowG6q+e9BzMfAUf?=
 =?us-ascii?Q?hZgKdz0XagUL+py31RzMf8I/CQpCbheS9hvCGES0+Ul5bfQIUhkQWQhZRGSK?=
 =?us-ascii?Q?46obRXP5kMrWW6NdP/jzCIUroDIqJLVl4vjR5wmhKVFd4KVT7TLb8NgHEKoT?=
 =?us-ascii?Q?XHY+wJpmcY8quwmhI/J+StZVwhI9xzw81biVnkZJFP+t9YiSmzUS8Lb4c1UI?=
 =?us-ascii?Q?eW8ScwRy4EN5z8WmwNny0/1g0hW4DZuJhtpLlC06Ll7pr9lljXHG44qswAb3?=
 =?us-ascii?Q?NpdAcYWBIUdULtIAtGXZ4Jniz8qBTmAllzJWBHSOIhyrXlE2CryK0Oi2Ehqy?=
 =?us-ascii?Q?y7BKRnjDUSRqQjHC/D0q0xzX2WJwjH60fIDYBH/tjLzxxa2dHOxBS9y11a8t?=
 =?us-ascii?Q?MSKmTB+GDhi1U/gmTDRAuMDGJdLI4Ty80jhzlPX4YpkYbeOlCKuvOerhTRMD?=
 =?us-ascii?Q?umHq7xdkKzIofe4m+F8xc0w0hhZoyPMun9cJsb8KQjG+ZIRFHNhv1IHrSGYC?=
 =?us-ascii?Q?Zj9NJ2cyQwkR9f5ahhjVJtyS+L2CQIwvjHojnLN0iJF2+ptiKjLA5URFeJ+q?=
 =?us-ascii?Q?ZGEHtvnBhdRv4DXkBJGvU3Uy2H8gihquIDWWRW6wGZYVqSoZJFxs2Ke98wnr?=
 =?us-ascii?Q?Ps7OATCR4VxOiG4tFVbAjR/tDSWAAZOmNQrOhQniZvZMXOrhorVSqbu0Pnxy?=
 =?us-ascii?Q?X2uXcINmNGgNx7yci96Gm9mWIR5xxM51WJQwom2xC42XMy+RLt4/?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a723fc0-5bf7-440f-249e-08de5ce6f221
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jan 2026 14:26:50.8439
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OIsqHX5JaGNWgSFHKcWgFLV5lat1g4SXtcpqdGtWT2iN6NTNQcAM5+T4VBARaGnIsog0SrFYTzKSb+uVizEN4g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY6P286MB7430

On Fri, Jan 23, 2026 at 03:57:25PM +0100, Niklas Cassel wrote:
> On Fri, Jan 23, 2026 at 11:08:39PM +0900, Koichiro Den wrote:
> > > 
> > > So if we wanted to, a good number would be to have at least a few BARs of size
> > > 128k or larger (so there could be two submaps), since I assume that some other
> > > DWC controllers might also have have 64k min alignment.
> > 
> > I'm not entirely sure whether it's really acceptable to bump the hard-coded
> > sizes for BAR0/1/2/3 (512, 512, 1024, 16384) to 128k, in other words,
> > whether there were any reasons behind choosing such small default numbers.
> > Let's see. I agree that 128k or larger should suffice for DWC-based
> > platforms (as you mentioned, testing with two submaps).
> 
> When the PCI endpoint subsystem was created, most SoC were arm32, and many
> of them had a very small PCIe aperture, like a few megabytes in total.
> 
> So if you were running two boards based on the same SoC, one as host and
> one as endpoint, and perhaps you even had a PCIe switch on the host board,
> you really did not want to have larger BARs than needed because it would
> not fit inside the small address space dedicated to PCIe.
> 
> Additionally, the PCI endpoint subsystem allocates backing memory for
> these BARs, some of these systems might have a very small amount of RAM.
> 
> However, I think that:
> static size_t bar_size[] = { 512, 512, 1024, 16384, 131072, 1048576 };
> 
> 512+512+1024+16384+131072+1048576 = 1 Mi + 146 Ki
> 
> Is still quite low...
> 
> When adding more and more features to the PCI endpoint subsystem,
> these small BAR sizes will not be enough to evaluate new features.
> E.g. for Resizable BARs, as per the PCIe specification, the minimum
> possible size for a Resizable BAR is 1 MB.
> 
> I solved this by making sure that pci_epf_alloc_space() overrides
> the requested size, to set it to 1MB, if BAR type is BAR_RESIZABLE:
> https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git/commit/?h=52132f3a63b33fd38ceef07392ed176db84d579f
> 
> If a few MB is too much for your host system, use a different host
> system to test. (E.g. if you connect these arm32 boards to a PC,
> and run pci_endpoint_test, larger BAR sizes would not be a problem,
> assuming that the endpoint itself can allocate enough backing memory.)
> 
> So my suggestion is that we that we just bump the defaults...
> 
> 
> I guess in worst case, if someone actually complains, I think a nice
> solution would be do to like you are doing for vntb:
> https://lore.kernel.org/linux-pci/20260118135440.1958279-34-den@valinux.co.jp/
> 
> i.e. pci-epf-test could have {barX_size} in configfs, one per BAR,
> and then the user themselves could configure the BAR sizes that they
> want to run pci-epf-test with, if the pci-epf-test default sizes are
> not desirable, before starting the link. (Some tests like e.g. the
> subrange mapping test should of course fail if there is not a single
> BAR with BAR size larger than needed to test the feature.)
> 
> But if I were you, I would just bump the defaults, since the defaults
> are currently overrided for BAR type FIXED_BAR and RESIZABLE_BAR anyway,
> and just add the barX_size attributes in configfs if someone complains.

That makes sense. I bumped the default sizes in v10, and if this turns out
to be a concern for some setups, I'll consider sending a patch to add such
configfs knobs. Thanks for sharing your thoughts.

(For forward reference, I sent v10 at:
https://lore.kernel.org/all/20260124145012.2794108-1-den@valinux.co.jp/)

Koichiro

> 
> 
> Kind regards,
> Niklas
