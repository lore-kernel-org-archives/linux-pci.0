Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazon11020089.outbound.protection.outlook.com [52.101.229.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 589E63ACEF2;
	Tue, 24 Mar 2026 08:06:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.229.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774339594; cv=fail; b=cuQRSWfGrCBOHGhCHoTFswCP0IMhzNpzc8iXunMiH7OO6wnNsKExLJIwJ6eDbvyIV4ocZTXkqK0Xz6Iq6EIVgItFdbsdoXgsG6HjfdJrjDqBZ9rJJ3ZnPqkmHKO58KwFAF6VYobpi5L94eyn6MkDAV5WWfOc6wNhjdWS9uAEkGU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774339594; c=relaxed/simple;
	bh=MjxvG6QVymP62gTGxB9EXtsqfgI6NWS4OK+10rmp8+8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=jGZ9yWv3SnImm4TyLr0rEU8V3Er0j3iadIvAYSrbqA6DJxGfMGz4ZTw8AtDG+eu7uJeq2hRGcnRECC1YOfSn5LWcF50l0bstAZrKFwMP76w/HdrfEO4EcIlnYbDM6cDn8LlxWMpRiVsHFx7jfPpZKQ7jPuNY4dDzU0cXU7aHhGM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=Efpqk13Y; arc=fail smtp.client-ip=52.101.229.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="Efpqk13Y"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xMwnY+oRTBrBQJ/+NsP/AKW+mepNwHJtHFUzz/CdZZTob/SYxdRWOYwRFiJVRSvIESR4Fz52FXKkKFlhcQjjo69YkJgYhtd8gKxKtFP3ZY3F9eyJUDoAfb6xJR3BEt2YWJhDqKayyywxv9syURQYi2rI8YYJN0nbXib31KoBlXszhpnt3KejMgwdNIhsdpQcrewwMuZijjTbHhhtLMEiu5CAmk0n2alGHu/zoESBC68ByBOTwp93gIkE756sb3IgpVJC23Vva1dxBf4oMkBXz4AslwGW56fZv+BBepets5vsZBl6JI+5yXyD3mXAxL/OoC8cQPl58QGxU76uetkZlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AYGPrZvjLwzijeDwOmda8EL5tRvhp4rD1fgj7MxfLhc=;
 b=ice9KriysVaxBZ0kmjO0JKMExW2bKt6pmb8sEtcJkr5g1lqRRt2bqECffaZvypx2i238etb9Y7FingP+rFrV2F1/Q1oKpSDnX7v/kfHGvVqOIC5HLHHKnx43Su4anlec6pQkN7FRgQMWFa8oPBBgMHIx5hKV2INBZUDoFOUERAHXSn10J+nip61prwzvpfo2Qf/GFr4XL7J7+OeWBvm6u5Gq/iTUu6nRUywvN9wgEYWiU1F7uVuMyUfkb+xtWT680WmbK1Zt6RXpONcYpuM5ZyCzw7QxJKFGGa8Bu87h4H21V64pA8eJBWnIFPeGDeVR5tZAOUgQLZ1QZLNIud+9bQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AYGPrZvjLwzijeDwOmda8EL5tRvhp4rD1fgj7MxfLhc=;
 b=Efpqk13YbyUKNYkC42780RrH3prFf6FttPmXI4KUvAjPpf8LX+NCGzCerYq/6KyvDPD9Zvj6MzkVCBUZuG2PPDa3Dc4LKBleca/VAJapULq0FfhLPQQASU8yNt2GXk9x49gxfkgQ4E1UgGWJC8rLvDQEO4+RrH0hq+wg5xWKz6w=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by TY3P286MB3613.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:3ad::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.31; Tue, 24 Mar
 2026 08:06:22 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%5]) with mapi id 15.20.9723.030; Tue, 24 Mar 2026
 08:06:21 +0000
Date: Tue, 24 Mar 2026 17:06:20 +0900
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
Message-ID: <i7qaaoi46njjzty5ui3wacjvqbmjnvrrjf6ztvkk3xwbhe2rri@vlag5fcb37ra>
References: <20260302071427.534158-1-den@valinux.co.jp>
 <20260302071427.534158-3-den@valinux.co.jp>
 <tzcqd4makvehalrvpv2t7oiioz24vuewyggnnmlcjusuhv74hl@7ywfq565tm74>
 <fsgt54zbuefiyf325ndgvbuygfte5ne5dtje5shptkqnjbk5gy@uaplhztrmi3q>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <fsgt54zbuefiyf325ndgvbuygfte5ne5dtje5shptkqnjbk5gy@uaplhztrmi3q>
X-ClientProxiedBy: TYCP286CA0131.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:2b6::13) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|TY3P286MB3613:EE_
X-MS-Office365-Filtering-Correlation-Id: 557dcdb4-d882-4535-61d9-08de897c3c72
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|10070799003|366016|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	H2vWwskHU7U2TwvPjKvUbFCwhapK1LopPZDelxlZuCo8tss5xmL4gbB9pLq3xf9rUlSnrvjOm/8DetSKRmqmcGwC98dv32buh01mLLO8/txW/6wnQ0VoSSrh8JfXFUO1riM5I0ZYIWQcnTjJfqKN+2OMrp4bB2yXkKbXDAUNqcnQSFP9HCVzS4InKgO/16GzgydrVDrxaG1wj5cz7PsNyqGQkCpPRf+WF810/NKNlLMG9BP0sAy3Z1dS4czMyceMFtNL94/HMwwd+ABx/hAq6BFL/8ZG+XBxWHTLV5bCwnt1LlC0oUyFaq2/ChltwMAlpevcb1X3mls+igPaN+3k5g+LtD0PMxyRjSMtXSaRA07J3QYc+SzcKrsKWIn9pClvk7V81ghdYW8G9LseZEPvi60fgyqOiofPwk92EwFo/vBLWd8Q7NGwVjI6rhRFgYSVozxktD3vXB4bvP+cMVZR1rZjosdfMz9nZ5ZRmxfyQhfWqrwNnbx8rH/w5/Q+2nV7RvixFDHsfT5NTsQXcevXGzsiwCtDV7u8+ovTKzRsxh1vsWQgqqg4gV/0cmlOA2SlI1x9QcD8YjYZxd53Q6a11rnDdbLb2xaA7VVg6FLiyScmRmDXsBdLh1kgdkMS7cUkjvQreipZmGjrKwftx+wtVWD/7pHZgGs+HDfva5CvBjFaF4O+HDSUB+5E0zk+I4X2/RQLdjmrUP/7ywUekD44Y9K36Zf7HqSzhpxaHQ0f06Q=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(10070799003)(366016)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VkZZSnpsNDhCaTcvcUhmUHlZU3RER0hLdTVuTFlHVjNsS0dSYnNGeitJZ08x?=
 =?utf-8?B?VGxLa2ppSWZhdmtHeTh2eXFYWFFDem4xZmY2eE5jZFlLaXFoZGUrd0dPcGNG?=
 =?utf-8?B?YjFqTDBUeUNYVitqajhUUmE4S2hMbHJNZWZoNTZ0dXpHc3hkbGhaNkZFVGg5?=
 =?utf-8?B?MzMzRVBvWEhUQzJDbjlOdGl2ZVJEdElOU2JJWHdYR0ZXWU9ubjlZQkVtNE5j?=
 =?utf-8?B?djhGZHBQc0VXT2ducFRsM1VUbGRNcGt2RW9KN25ZNDdvMWx1UnNqNTREZVFq?=
 =?utf-8?B?Ym5hNjQwbDV4ejF0V0FjTUZQT3BmTzFIR004ZjBNY3AxcEFwWitIVVZqZENV?=
 =?utf-8?B?MHpTTlpsTGd5aEZrZzRockFuNkJ0bE9PRUlEMlM0U1djWUNIR3AyejB1aU8z?=
 =?utf-8?B?ZThJUjNlL29CbEVUUlUyS0pEdVEwRVZJT0JRR3lMUDM5WXk4T3MxV2pGbGhB?=
 =?utf-8?B?WGxOY3JpWGUvUXgxS2RQczJqd05qQ3labkhkd1hpTWtLaUJCK1VmT0UzbVNw?=
 =?utf-8?B?Mk41VXdVeVF3Mm9pcEdEMDQ0cWhLYnh2UE9WSUNYQTV4c0JiT3l3cmlaQitr?=
 =?utf-8?B?cm9KZDl6dFF1OUcwc0o4R0hxS0djYlhabGlMbld1MC9tclpUdXozdFVNK3l3?=
 =?utf-8?B?UWRUZk45VTBjMTg2Wm84aWVVNU9EVExSS3BvdUxKMUFaNjArRWhpTlgvNzJs?=
 =?utf-8?B?R0Q0VEhObCtaV2tuK2Z6N0MyT3UvTm9jK3JXYUhvcWkrdjN0ZXpKckh2QjBJ?=
 =?utf-8?B?SEk0bUYwQllLYktWRzZLT3pzOWkyeVJYVnZ3cEp2ZUV4Sm5RakJ4cDNaa0xG?=
 =?utf-8?B?SmxvYkM5cC80aE5NWC9ROFAwTEh5eW5Gc0xLOThLbzRLWWNKdkpqbFZtYmw5?=
 =?utf-8?B?d3c4RGxFWEJ5Qyt0RExjOXdoZ2VCUytDSFUvUkw4QXZzZ05wVXZsWE9VTWZh?=
 =?utf-8?B?RERIOW9XRFBhYnVteTllZmpQU2U2b0ZHRExsbnVrY2hPdXFQd2tTcjBUOHpH?=
 =?utf-8?B?TkhsYldQeGhEUFNKeC9iSkdNQkxIb2JhQkJNT2tKcU1XbTd4NzZ6cjFYRW00?=
 =?utf-8?B?aEFRNG50WEYyRTR5UFBwTmFQMTFJUVJxMHJ1MjVQbVRHaXBqMlUyZ05FNHFB?=
 =?utf-8?B?RDlLUG5QbWw2a1ErOGd1SVhIWFIyR0xPZmZkSkhoVCtINlFrTUNwY01mWW9m?=
 =?utf-8?B?bTdXdGZzaFFQZG50QzB2YkpVSkE4dEMrQ3YzREdiMmc3R2ltNFVTR1lUSExx?=
 =?utf-8?B?RHowNUhnYlNLajV3WVpKZTNsN1hmTXZqMmI3TGZFa2ROWXZqQW1oQURhMjZu?=
 =?utf-8?B?Mk1CYXc0QmwwZnhQZmxIV080UFpNM211dzJHQ1o1RXd2cHQ1bXpIUVNBT0lI?=
 =?utf-8?B?R3k4NktqZ0JVV2JmTGlBV2o4MENTWVZaRnBWVkFiZ0FGSHkzcitMcWd1U2J5?=
 =?utf-8?B?Mm5PbGhJL0VjNnJTWDdIZU1aWW14Nit3RVhOWk54SzRwRG1ocGlnU0JTemVp?=
 =?utf-8?B?VG0rd2Z3N0oyZnZTMVFycU1FeGJRSkd6dlkvVWFXVi9qM2Zud2NUcElUMnYx?=
 =?utf-8?B?ZU5hbkE4dU56dUxuQTNWdGdTVHNaS0E5S2Z6Nk0ySmlEbi85TXFlS29KOVE3?=
 =?utf-8?B?YnRLRlpKSlN5aElESnJXYjhXcFMvVWtFYmJielhQUEdvcUpQR3dmcGVEbTRv?=
 =?utf-8?B?QVVMdnNPNWsxYk11NEhtMWlUMCtCWERGUUFOTnFPUmM5N2ZlMWxud3VUM2c4?=
 =?utf-8?B?ZWNmeVo2eG0zUHFTaVN4OUJjU3pPNmx3anN0YkR3RExZUnBCc0k3YUpxUnZS?=
 =?utf-8?B?SFVUK3U3WktCVnNXMVRIWG5qRjFkQkgrQTIyQ0VaSDhqUTVua1BkMkhIN3pa?=
 =?utf-8?B?b2cwV3JvNEVlbmE1b1h4S2tRcTRadnZhQU11Um9RazRSSGlUbDNhcFlkVUJx?=
 =?utf-8?B?VXQ1cTY4NGZWUXk3M0dreW9HeHFaYitLQWVRcFNQVWNaTXNZZ0laZnlTNFkw?=
 =?utf-8?B?andyQ3FZWW1RMUFJcHdqR00vcjhaRGY4R2NlRG9aY3gwK25XYkdsRG1kTTR0?=
 =?utf-8?B?NDhVVUVoTjU5MUhINE8wVGd4YW9XRkYwYUMwMHAwYU5XaUhMS1RKYU4zK1FK?=
 =?utf-8?B?TGFoNCsyREpKbS9La3NkUUZMN2trUDk3NFg2d2NGVEU3bEVCVUJRbTJhVzB0?=
 =?utf-8?B?T0l5M0dOVG1Fa2RwTkxoRkJ5T3BlZ01mMkcrcHUvSUFMODRqdkpUK2pDRHdt?=
 =?utf-8?B?S0x6SkN6UmV6aEYyTWE0NmpYTHM0V1JYbVVwdHE0NFB1ek9pNUtTMTA5SUFS?=
 =?utf-8?B?V3BNT2IxdHk5Z1lxMVJXbVFUMjI5elpTSE9jeXpkS080d0grUHREMldiNE9j?=
 =?utf-8?Q?hwpK/t7TVbjCoTXVIQFUDsXqY4B9rVyf6B6LJ?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 557dcdb4-d882-4535-61d9-08de897c3c72
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2026 08:06:21.7764
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OMrkEx7EX6ktLRPK5PRXfiZzu7fNYGLnPX51ve+OudBaLpLISyVciDHlau2brTVTo7urwkwWbZWJgok07Ms8Qw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY3P286MB3613

On Mon, Mar 23, 2026 at 10:46:07AM +0900, Koichiro Den wrote:
> On Sat, Mar 21, 2026 at 07:51:08PM +0530, Manivannan Sadhasivam wrote:
> > On Mon, Mar 02, 2026 at 04:14:22PM +0900, Koichiro Den wrote:
> > > Some DesignWare PCIe controllers integrate an eDMA block whose registers
> > > are located in a dedicated register window. Endpoint function drivers
> > > may need the physical base and size of this window to map/expose it to a
> > > peer.
> > > 
> > 
> > This sounds exactly like 'Remote eDMA' concept where the eDMA registers are
> > exposed over BAR and programmed by the host. So why this duplication and why
> > can't you reuse remote eDMA?
> 
> Thanks for reviewing.
> 
> The intent is not to introduce another "remote eDMA" scheme. I am trying to
> reuse the same model, but what is missing today is the EP-side resource
> plumbing.
> 
> In-tree today, the remote path is effectively host-driven, i.e. a driver such as
> dw-edma-pcie discovers and maps the remote eDMA windows after enumeration. For a
> DesignWare EP, we still need a way for the EPC/EPF side to describe what
> integrated eDMA resources are available to be exposed to the RC.
> 
> This patch is only the preparatory part. Today, pci->edma.reg_base is just a
> local kernel VA, but the EP side needs the physical base/size so it can expose
> that window in a BAR, or reuse a reserved BAR window as-is (e.g. RK3588).
> Patch 3 then exports the eDMA register / LL / doorbell resources via
> get_aux_resources().

I think I missed your point in my previous reply.

Based on another feedback on [PATCH v10 1/7], the v11 scope is to be strictly
narrowed so that this series only keeps the pieces needed for the embedded
doorbell fallback, with PCI_EPC_AUX_DMA_CTRL_MMIO and PCI_EPC_AUX_DMA_CHAN_DESC
dropped.

With that in mind, the current commit message does indeed sound a bit confusing.
In this series we only expose a standalone DOORBELL_MMIO resource, whose
register location is derived as:

  edma_reg_phys + db_offset

where db_offset comes from the existing dw-edma metadata. This patch records
edma_reg_phys (and the window size), which provides the base for that
calculation. The recorded window size is then used to validate that the derived
doorbell register stays within range.

I'll rewrite the Patch 2 commit message accordingly in v11 to better clarify its
purpose.

Best regards,
Koichiro

> 
> So this is meant to make existing remote-eDMA style exposure usable from the PCI
> endpoint framework, not to duplicate it. I can revise the commit message to
> better explain this.
> 
> Best regards,
> Koichiro
> 
> > 
> > - Mani
> > 
> > > Record the physical base and size of the integrated eDMA register window
> > > in struct dw_pcie.
> > > 
> > > Reviewed-by: Frank Li <Frank.Li@nxp.com>
> > > Tested-by: Niklas Cassel <cassel@kernel.org>
> > > Signed-off-by: Koichiro Den <den@valinux.co.jp>
> > > ---
> > >  drivers/pci/controller/dwc/pcie-designware.c | 4 ++++
> > >  drivers/pci/controller/dwc/pcie-designware.h | 2 ++
> > >  2 files changed, 6 insertions(+)
> > > 
> > > diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
> > > index 5741c09dde7f..f82ed189f6ae 100644
> > > --- a/drivers/pci/controller/dwc/pcie-designware.c
> > > +++ b/drivers/pci/controller/dwc/pcie-designware.c
> > > @@ -162,8 +162,12 @@ int dw_pcie_get_resources(struct dw_pcie *pci)
> > >  			pci->edma.reg_base = devm_ioremap_resource(pci->dev, res);
> > >  			if (IS_ERR(pci->edma.reg_base))
> > >  				return PTR_ERR(pci->edma.reg_base);
> > > +			pci->edma_reg_phys = res->start;
> > > +			pci->edma_reg_size = resource_size(res);
> > >  		} else if (pci->atu_size >= 2 * DEFAULT_DBI_DMA_OFFSET) {
> > >  			pci->edma.reg_base = pci->atu_base + DEFAULT_DBI_DMA_OFFSET;
> > > +			pci->edma_reg_phys = pci->atu_phys_addr + DEFAULT_DBI_DMA_OFFSET;
> > > +			pci->edma_reg_size = pci->atu_size - DEFAULT_DBI_DMA_OFFSET;
> > >  		}
> > >  	}
> > >  
> > > diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
> > > index ae6389dd9caa..52f26663e8b1 100644
> > > --- a/drivers/pci/controller/dwc/pcie-designware.h
> > > +++ b/drivers/pci/controller/dwc/pcie-designware.h
> > > @@ -541,6 +541,8 @@ struct dw_pcie {
> > >  	int			max_link_speed;
> > >  	u8			n_fts[2];
> > >  	struct dw_edma_chip	edma;
> > > +	phys_addr_t		edma_reg_phys;
> > > +	resource_size_t		edma_reg_size;
> > >  	bool			l1ss_support;	/* L1 PM Substates support */
> > >  	struct clk_bulk_data	app_clks[DW_PCIE_NUM_APP_CLKS];
> > >  	struct clk_bulk_data	core_clks[DW_PCIE_NUM_CORE_CLKS];
> > > -- 
> > > 2.51.0
> > > 
> > 
> > -- 
> > மணிவண்ணன் சதாசிவம்
