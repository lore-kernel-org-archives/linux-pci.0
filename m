Received: from CWXP265CU009.outbound.protection.outlook.com (mail-ukwestazon11021095.outbound.protection.outlook.com [52.101.100.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FCC74746A8;
	Wed, 12 Aug 2026 16:44:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.100.95
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786553101; cv=fail; b=pMR0pO38uqg3sw31DdgC2+Xrzz38wA59J4EPmre0/l6ymEtPzPZoQct91QjjYxazRIyP1BKNoLiOSM8JskRgOTOMQDYZer17XaisLpGq+hzi4cfzTEKJzTx/G3uKuX89LZqscw3wWH3GDzt5HxQxLZRnLk6H3S3VCc85arGGg7o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786553101; c=relaxed/simple;
	bh=L9F2fLp3gFtLpqMPZgfkJEeD3yOij6pRBt/CCRn5j+s=;
	h=Content-Type:Date:Message-Id:Cc:Subject:From:To:References:
	 In-Reply-To:MIME-Version; b=m8YFi3h/94WP0FgTftbmp7hOd38lMO9KTRhBTyxLv5OSmi8JqwyY8QqUVx8r4Yuwpu3cMRLEKT3lKTMR+6SIKfDvRHN9ZwxE1gMqxbZCqyVa7qK4JDfqvSC76AnU5HEtppZ9KADwYppgvom8lJnRD6Rm1hXppcB1/5lIjyomdf8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=gNEpN4ai; arc=fail smtp.client-ip=52.101.100.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="gNEpN4ai"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VmuVY+M9PLPf4XPrCB9i3zQ+bIYlEi22YRwmWsLAIetM+GHhqFv17Ka4oyXfe/zh/WZV3cub1x0ZR/0+L2paEu7pv0hx1S/5rcfAYL/2jrKNVI7Dms/be3MN7zlyPDPDXuLB4lx3+8avm9hQ/c9N6fuoeqR+h87Wpfj9e7hX9AAjLd9mO+N0jcS6uGxSUEuI/mYKozKpFXkgEPnz41sW+eQn2ECSHdcGH5jyh1vNL0lX8rE504OXMgVQlGFUjFJpG+V5ORg0Qe3g4etYNbfip3XBf4l9nT23Gcahfugvejy59YPIsjU/8wbweb8EIoc39oGKCs3vN2RWCS0gYa7Rrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q9i9eIXvwZUn//mTtU/n5DxeeWo6ULdX7/Vn5fX3B6Q=;
 b=tc+HOgVv16XVes27XdWaWrR0Yz+bv35G3GBQZ8k0md1Ggse8nF1AES5RYrAtl36gUhdL4WOHpL4B4kuKJ10/MbIHA3wrz1LlwDQx1lhheetmO2NRKkOjHkwhVZ5K/Tdo1+hdZO9klpiIqvKM+5A5l8VsGmAa70sX6L9WozbO2XPzQmtP7/pIDJjYc6AsLEC7heOFjt4zfqaohgLLvyemz382C3ggU57aWXp+pmJFWzRmvWBwT3j8bSzabAKS/cetDw30f5IgXYe8TJyP4g5Mr1T5J7KKAdZ5xg/D3Wrblb8NQGDfuY6XulzKXgyWNXCH6vBlVsxBH/3jWi9BuNjtSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q9i9eIXvwZUn//mTtU/n5DxeeWo6ULdX7/Vn5fX3B6Q=;
 b=gNEpN4aiLeW+Xe0NCy0yS1lLKRrEGzgiIzduENxor6HiiuLFKNbG7kRVe3ukCjYyvZMnDQnrgZz50boM1JfkBZKvASpcI2t6prMnGGXD2EtaZ3ipyuAguuJ8kIb5ad4rrDOmhJc/eL0rX7FTPG0S/d//uBZ8e14rAmaafHQOjIc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:4ab::19)
 by CWLP265MB2308.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:6e::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.12; Wed, 12 Aug
 2026 16:44:55 +0000
Received: from LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
 ([fe80::f60b:1537:68d7:4fc1]) by LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
 ([fe80::f60b:1537:68d7:4fc1%4]) with mapi id 15.21.0315.011; Wed, 12 Aug 2026
 16:44:55 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 12 Aug 2026 17:44:54 +0100
Message-Id: <DKN47TIEH9R7.2Z6FDMEZTUKL5@garyguo.net>
Cc: <driver-core@lists.linux.dev>, <linux-pci@vger.kernel.org>,
 <rust-for-linux@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 5/5] rust: pci: expose the allocated interrupt type
From: "Gary Guo" <gary@garyguo.net>
To: "Danilo Krummrich" <dakr@kernel.org>, <bhelgaas@google.com>,
 <kwilczynski@kernel.org>, <aliceryhl@google.com>,
 <daniel.almeida@collabora.com>, <ojeda@kernel.org>, <boqun@kernel.org>,
 <gary@garyguo.net>, <bjorn3_gh@protonmail.com>, <lossin@kernel.org>,
 <a.hindborg@kernel.org>, <tmgross@umich.edu>, <tamird@kernel.org>,
 <acourbot@nvidia.com>, <work@onurozkan.dev>, <jhubbard@nvidia.com>,
 <ttabi@nvidia.com>, <apopple@nvidia.com>, <ecourtney@nvidia.com>,
 <shashanks@nvidia.com>, <zhiw@nvidia.com>
X-Mailer: aerc 0.21.0
References: <20260811233952.3000968-1-dakr@kernel.org>
 <20260811233952.3000968-6-dakr@kernel.org>
In-Reply-To: <20260811233952.3000968-6-dakr@kernel.org>
X-ClientProxiedBy: LO2P265CA0508.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:13b::15) To LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:4ab::19)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LOAP265MB8560:EE_|CWLP265MB2308:EE_
X-MS-Office365-Filtering-Correlation-Id: 0a1222d9-b0c9-48b9-5031-08def8910a1c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|23010399003|10070799003|366016|56012099006|4143699003|10067099003|6133799003|22082099003|18002099003|921020;
X-Microsoft-Antispam-Message-Info:
	gcQ4s/8ZhSbU5TaEx0XFEknQvdiPev9FQEEnUNJbQGJcCf3E4agTdUqWhh/1oKpmMUGM9yLrehB/DYscFnnze4c4YB99LpFYxdHg9Ikx4cMjl6I/Kxfiv1nxHyRuFpI2A4Epsb23DBIPKvLCJtDI/nBC5l9AzgLETIXSghanQlXxxiClTjOss91LSrAym7xrzG7lEM+V70JSSQiSjUoM+hNnJF7HQ/YEXrhSvB3HNqBSCPziUjeoyxYX9yrM+IEuzxiMqjTfRU8eT4Px8cqKpahXK62MHcEzag+v6V6zbIWhQwNcCQuKFLtmN6yoJiNc514HaO4d8D9mHpNxyxMjHfIGCRzjCBe7gDiIrP8fRFQw74wLVjBG5pz7a3XndqpSBidq9QD3FY27/e277AStRrCbPFcXzHys3mygbrj2Kyl/VWVQDFsIr0V0oeNPjOKzVmB7KzAEm43dajc557Z5LjXOrbg9tWc+u6TbSVKn2uOWKjtU19Z/rmL07RGHo8g/MWZ7xmbmNZNMQrDqMIanQhItkdsR6kNZfaZTbGOq+Vk5vkJ29B3YCCW/jcSp1wazVWPzAg0Z04nQIZn0F/ONn6llV6e4gl5ziO4lXbm+0xz9gj2lo4D8BUTWVRQZZLQ59gP0a3ZyseZ0z/kDkf6go+fhGxjm9GLhfSxP7dhS0aixhQ3XBUUQmFFgvVVGS+1tg45qjPit1tovLdvGhVKVHQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(23010399003)(10070799003)(366016)(56012099006)(4143699003)(10067099003)(6133799003)(22082099003)(18002099003)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RU9DcDViRVNKN0EvbCtjdnpxdjVmYVBhbzZjK0srd2gyWHB6aUZOU0ZUR0dG?=
 =?utf-8?B?V1hsT0hoV1l4R0FIOGZ5MnNyNjNlNG5MWHlIZEdDWERmK1RhOXJ2OWt3cUZx?=
 =?utf-8?B?V1cxeFVYVCswSGd3cFVSUEFZelB0dUJLZjJPQ0I2elEwQ0JsaVhZL292ODNL?=
 =?utf-8?B?SFpxMVhDRkdvVnVTM0k0SzZNUmtXTFhoU1JPYm96Ym9hNE9NanNOM0s2U05J?=
 =?utf-8?B?T0VtSjlEU29FNnFJdTNEZFVsWlM4cWYvZlJUL0FJVUhVaGVjb21NbzR2NUFm?=
 =?utf-8?B?THFDazNwdFMrUCtiK0tKNy9lVnRYaUhFYkYyY2ZjMjhhWVdNellsRDhVSUdy?=
 =?utf-8?B?bnBqSFQrSTNudjUvQzNpNTNXYzZvUytEQ0YvTmRwb1dvVDBnUVA4SEhucERh?=
 =?utf-8?B?ckJneVdpYXMzd2cxRzl1RjVoRWxnbkt0ZWtKQkpXRWtXajBpazBwcFZVUzRX?=
 =?utf-8?B?WXA0ZHM1aHZ1YW02OE1TeDRSeXZxWHAxWDI5RUhwZ28zdkR1NlNMY3NRaDI0?=
 =?utf-8?B?b01qQzl2M3Z1VkJudllzWUNXZEtWbUVYV3lETlBGSWxaUGN1MlNLWGtEZG52?=
 =?utf-8?B?M2EySEJIY3FKRWNob2FRTnNYZ1l2ZWZOcDVTYXdrb1ZkUTRzOHlxeXdpTHlH?=
 =?utf-8?B?YmZrZXA0NDdkaW1xcnh0RjcraXUvR1NRNjR0M3hIUjZ2eEJJSms2VjJFcU5R?=
 =?utf-8?B?Y3ZMQWwzTTR6b1oyRkNmR3E4emJOYlF4MmhXN2ZHaWUvWFMreWpMSml1MGh2?=
 =?utf-8?B?eFZCbTgzdkMyRzluOXVZKzQ4KzBoakl5b0hNRnFpUWJ2TGhYSUhtSWJPNjM0?=
 =?utf-8?B?NUZCVGNFdnAvcWhmY1pRV3lTUS9GZ1JUbjZIRnFndnpNbGN2cVUreXNQVkM2?=
 =?utf-8?B?cXcxUXk4dHJwVTRsTGxOMVk0NDdkVjBucmtsc3oyV3hxS1ZHZUVKN1VTN1c0?=
 =?utf-8?B?Z0grZVI0dzlmQ3RWa2pTU3c4ck8yaWgwRE96djNlQ21adkd5Z2ZIUlAxNGZZ?=
 =?utf-8?B?cUlYUW12YzJTVjFLTzNESW1CR2pLL2hBSkxmYVJ1Ri9ZYW9waTZYWmFFZmtx?=
 =?utf-8?B?YVlhUzdJei9GZzhJSGE0K04xRlVVTTRPYUZScmVMUGlBM2tZOUJaWUpiL1Ju?=
 =?utf-8?B?bitMV3BvcFE5NDRHVmpjL0owUzNjL1doWkVoL1FWYnhTMlUxd01TMmI3K25M?=
 =?utf-8?B?WWNQanQzSzVheEUzZFlrYy9VNzZIUU9YaDVJSnluRDFad2JnWS9kMExrTGtn?=
 =?utf-8?B?dFJBR1Vydk1rLy9rZnk1VlJNZW14Zmw2YzliVVk3SC9EWkF5T0d3NEVkSGUw?=
 =?utf-8?B?NVhKK1d5WkdTS01UQWdJTVhUNXU2NitidnlzbUpRaFA2UFZnQTVyNzNvZnZt?=
 =?utf-8?B?aCtvZGZRQkd0MFlwM2VtYkRUUUoxbmtPbmJKOUtwTHhRSHZ3MjdWREJaVmZa?=
 =?utf-8?B?a2VXTUxvV2haRmFMZkNpZjRhUHdJTndiZ1kwMERVWVowaXYyTXFFaHdHWFcz?=
 =?utf-8?B?bzRMYlYwUzF1UVJUSFJoNTBteVc3T3hiL09tVnduYWdoQTlVOXF5L0t4bkZw?=
 =?utf-8?B?YXRaSVFqWkl1RDFzdEE0d1FpZ0x3b1VuTSs5YWdxM1U3RGxGUWZtM1I4TGls?=
 =?utf-8?B?TVZZekc1N0JwWndPWElSalp3clRxT01CbDh5bFZnUDBPUXRISEFMWW01bFFY?=
 =?utf-8?B?V29zV05yUUZXOUJPT3I0dHNUWDFpZERDZDNGS2l3WkVUa2NEakpaaXY4Z2Jq?=
 =?utf-8?B?ajZjRitVN1VWTGNIdFVlbGUyeFN6d3pVeHFKZFBBQklDOEhGR3ZHK0Z6TCtq?=
 =?utf-8?B?d2kxend6ZmRFVmtqV2JpOUY0NzlGc3lIUXhOcXY2TTVNZFc4Vm8rM0RHT1dE?=
 =?utf-8?B?NThITlNRTEk3R0R6cXdJNUFwL1FzR3lvZzMyYzNHaEcwYURtekZYS3VTdWlF?=
 =?utf-8?B?bGhaRkxBdTZsK3F4T2ZUaWkzTnFTMDRNbGRsV3dnVmlLOUEyR3RHRU1Ba3JF?=
 =?utf-8?B?VHdPcEdMdldKOE0vVWd0bG52N1p1UTJHTTRka1NuTXJwTVRYaEVsRGhVY0hB?=
 =?utf-8?B?dURQNHdFdFJOMGpXUlVxL1o4SldkWGY5WmEyM2dIT1RhYzRSOUQreU9VQngv?=
 =?utf-8?B?cmx2Zlp0RW5nVkhlNlkvRFVTbTIzSkc0T2dPWTVzNy9mUW50RjY0VElGV212?=
 =?utf-8?B?UXRiYWVwTC9MMGM0THZFSVpJTVNtUmNWOUdSTU12UTIzbXgvQStBQ08vd0tY?=
 =?utf-8?B?SUQyWGwrQldSVFcvYmxLTFlTcERjQWNhT0VRY0RpbDl0QVkrZ3V4TVZBdU5U?=
 =?utf-8?B?Ui82Zmgyc2lWUlVrQkNHOVdSYnNVSjBVVDNRZSsvdHdoZkdoR25RQT09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a1222d9-b0c9-48b9-5031-08def8910a1c
X-MS-Exchange-CrossTenant-AuthSource: LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2026 16:44:55.7522
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EOkobPJcc1VOHDtZoqMN/BEGwmLDbBdg3lyE8FjU0WLu0ttpZx/hW+cbs58BxjT7oiycyOYrzNkAAvIoT8IU3g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWLP265MB2308

On Wed Aug 12, 2026 at 12:39 AM BST, Danilo Krummrich wrote:
> Add irq_type() on IrqVectorRegistration and IrqVector, wrapping the new
> pci_irq_type() C function. A driver whose interrupt acknowledgment
> depends on the type (MSI-X vs MSI vs INTx) queries it here rather than
> assuming which type the PCI core selected.
>
> Suggested-by: John Hubbard <jhubbard@nvidia.com>
> Link: https://lore.kernel.org/all/20260808031120.363869-4-jhubbard@nvidia=
.com/
> Signed-off-by: Danilo Krummrich <dakr@kernel.org>
> ---
>  rust/helpers/pci.c     |  5 +++++
>  rust/kernel/pci/irq.rs | 22 ++++++++++++++++++++++
>  2 files changed, 27 insertions(+)
>
> diff --git a/rust/helpers/pci.c b/rust/helpers/pci.c
> index e44905317d75..23b06becb448 100644
> --- a/rust/helpers/pci.c
> +++ b/rust/helpers/pci.c
> @@ -24,6 +24,11 @@ __rust_helper bool rust_helper_dev_is_pci(const struct=
 device *dev)
>  	return dev_is_pci(dev);
>  }
> =20
> +__rust_helper unsigned int rust_helper_pci_irq_type(struct pci_dev *pdev=
)
> +{
> +	return pci_irq_type(pdev);
> +}
> +
>  #ifndef CONFIG_PCI_MSI
>  __rust_helper int rust_helper_pci_alloc_irq_vectors(struct pci_dev *dev,
>  						    unsigned int min_vecs,
> diff --git a/rust/kernel/pci/irq.rs b/rust/kernel/pci/irq.rs
> index b3dce5b49d57..41059b922492 100644
> --- a/rust/kernel/pci/irq.rs
> +++ b/rust/kernel/pci/irq.rs
> @@ -33,6 +33,16 @@ const fn as_raw(self) -> u32 {
>              IrqType::MsiX =3D> bindings::PCI_IRQ_MSIX,
>          }
>      }
> +
> +    /// Construct from raw value.
> +    #[inline]
> +    const fn from_raw(raw: u32) -> Self {
> +        match raw {
> +            bindings::PCI_IRQ_MSIX =3D> IrqType::MsiX,
> +            bindings::PCI_IRQ_MSI =3D> IrqType::Msi,
> +            _ =3D> IrqType::Intx,
> +        }
> +    }
>  }
> =20
>  /// Set of IRQ types that can be used for PCI interrupt allocation.
> @@ -106,6 +116,11 @@ pub fn index(&self) -> usize {
>      pub fn vectors(&self) -> &'a IrqVectorRegistration<'a> {
>          self.reg
>      }
> +
> +    /// Returns the interrupt type the PCI core selected for this vector=
's allocation.

#[inline]

> +    pub fn irq_type(&self) -> IrqType {
> +        self.reg.irq_type()

Do you expect people to call this on the `IrqVetor` (or even
`IrqVectorRegistration`)? This is really a property of the device, and not =
on a
specific IRQ vector/allocation.

Asking this because I think we can avoid keeping reference to `reg` if we d=
on't
need this and `vectors` (just keep `&'a Device<Bound>`; the mere signature =
of
`IrqVectorRegistration::vector` will ensure the correct lifetime)

Best,
Gary

> +    }
>  }
> =20
>  impl<'a> From<IrqVector<'a>> for IrqRequest<'a> {
> @@ -137,6 +152,13 @@ pub fn vector_count(&self) -> usize {
>          self.count.get()
>      }
> =20
> +    /// Returns the interrupt type the PCI core selected for this alloca=
tion.
> +    #[inline]
> +    pub fn irq_type(&self) -> IrqType {
> +        // SAFETY: `self.dev.as_raw()` is a valid pointer to a `struct p=
ci_dev`.
> +        IrqType::from_raw(unsafe { bindings::pci_irq_type(self.dev.as_ra=
w()) })
> +    }
> +
>      /// Returns the [`IrqVector`] at `index`.
>      ///
>      /// The returned [`IrqVector`] borrows from this registration, ensur=
ing the vector allocation


