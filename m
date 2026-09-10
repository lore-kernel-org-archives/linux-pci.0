Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EA0D3B2FC8;
	Thu, 10 Sep 2026 21:05:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789074303; cv=none; b=JZKgniN2xURnWkVpduh9T3iZ9HvW3cNaoQasWuirI9nI5M5Zwg77ntjRAxPqPrRQKhBZD0n/S0/NUdnqqfOeYW1zZ1pIZl73TubmmY7mMBj0QzwyhqDSWFPOCL6Ansv1vzd9OgPWPxhdoNm+xKTdr9opO4UOapqWc3sE7wb03PU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789074303; c=relaxed/simple;
	bh=g4G2N9tTCSNJgv0JkQxbG0D0XViQ1kqc6lqIGOspZaU=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=W00yrluA+V0CHJTQNj8nQzcWnpMHJzZPpL4iVgzHe4mVZIA9aCSydxjx8Egxz/DcuvYxHgPvJORIngqAkS+DJWLUHhsowEM6M8/+vC+gDG/MHAYpZVIB/DizENmcH1TSRnqmEsr4ca1Q5KpAYbgf7JNuGelz2qdqg2Gr91+E9hc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kH706mDG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kH706mDG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40D471F00893;
	Thu, 10 Sep 2026 21:05:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789074301;
	bh=NgfEzAFz9xy3/yPYVq2IScFdGQbsyE2c+oXPOxTIUVw=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject;
	b=kH706mDGHlUrM+NBu/Z9H9ve09XdKCvcZzfNCvzzMm0dAqMnEVjyT+zqlCulzhevM
	 X9Vc2O2eqfvsXLYUREsKMwiuGBQja/ZLbLhKY90a8v6gNBz3i5shhG2o20qRHYUxBC
	 eGf3GMZYf/7Y4hTQ/AbWCS/ZLcTWFIQNMj1pB/DbwHNxsoR1Ds89xQ6C/08LpaNSIw
	 G3xkhS1L7JIo/HwO+Vrz/SWr1g8qU4KMHmXAr8yF9uuzJm0GP/j2VG0+yDM/ZYI34F
	 VyHL8srXfDJo2Km7P2x9W708VEok2t1+Ce+YX7ZhThPztinGXP3vzFTM/sY6eVLtkf
	 O3VsQR5DvFKug==
Received: from ams-compute-02.internal (ams-compute-02.internal [10.64.2.62])
	by mailfauth.ams.internal (Postfix) with ESMTP id 8D1EF198003A;
	Thu, 10 Sep 2026 17:04:59 -0400 (EDT)
Received: from ams-imap-11 ([10.64.2.31])
  by ams-compute-02.internal (MEProxy); Thu, 10 Sep 2026 17:04:59 -0400
X-ME-Sender: <xms:ehujaop0KjGCWDnOidhQXdXr2Ucze5XrCYAOr1GQKjZj-2yHPsT1aw>
    <xme:ehujapdujgoeuEbVKST7sIUSRo06jwmaUNDZaohTKJmxw2f0jXJrAD7nsttxgC_wp
    nuT9MCmqNZuN4OOUauTGXeau-API5ADsxVoapTeZ72cSwcV1x9_lC33>
X-ME-Proxy-Cause: dmFkZTEWXG8uXABZnDp8COYBIV980lHBjkhUnJ4A8HsZSGNLXrY6/ZCramCh3PXHEgeUY3
    7Pj2ahlMjc0X2NwZNd04Ot8HSRe7D7v/2l82ANFNTqAe28Mi1IDiqtizfk881n/bGq2Ngh
    UcEwWZhoIIR30sp8Glbuf1bZMz/LGD96fM3OHW50xjOEy8unfRLyLv7Afop3UBBvXjuN6B
    bty8npgWpNjS05xmBaIO5RlSmncXhf0oAuvCG708r94nYAzOBIkWq4erTvpK7BzqJRgWWs
    Oc2V7oZm/7+bTKwHM01vtqo3rNLJhYjJ55s36457S0VGUolrzIZe0Pvx/Ci3iOre7l2Zkn
    TpHaILeWXn8xTBvB2MX2Gz0Ni+FCEGKId0kbObna0ut3wxT05+8jRxV4PwtTqDEyUozGC0
    1fB3z+6Ga15+OaLlTdZ8ntOGwyfULVD//2ywaJgXLQ4zMKZCplQQZu3U+Op1lnUEwutzbU
    EoCC74M091wxoibEysIyh/DC4yWRKoviq2fCWPiG3xjvmad0G/1scqGIIRTxypvfOFXXnx
    xV3i8YOTlMrAEmCUFNL0Tgbb1gmUJtDpv38VbFA5wDOtAeWT2aAD+nSafqG+3GeBkNsk4w
    zSguvqWi9ULX0IQh6oKBO/9loUwkDXZx8LIicWnDwjvgbEdwV5g7jvS8+k6w
X-ME-Proxy: <xmx:exujaldg2hKd_jOwjUq2e6iMWUrbh8Aza-vGhf8jPqBsTjw9Vn8TzA>
    <xmx:exujam5wLnOE3cOY4FAID6yObT6RebxzJDn2GX8JTD8-z2OzyyT3Xg>
    <xmx:exujaoUN9BWSBNzpIEu4bcn4z-27hk9vI_B5b_njtBAcV8FEP3vQZQ>
    <xmx:exujal6vmE1F8E0nsIKqWvpjFUW1biGd1iyE701YBQOfOUxVszyYeg>
    <xmx:exujajrurszmh9Y3-1n-NcCfKl6RwyKGIQoYL0kgL_NBqFosktthP_-4>
Feedback-ID: ice86485a:Fastmail
Received: by mailuser.ams.internal (Postfix, from userid 501)
	id 185E1F8007D; Thu, 10 Sep 2026 17:04:58 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 10 Sep 2026 23:04:35 +0200
From: "Ard Biesheuvel" <ardb@kernel.org>
To: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 "Ard Biesheuvel" <ardb+git@google.com>
Cc: linux-pci@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
 "Bjorn Helgaas" <bhelgaas@google.com>
Message-Id: <41345c53-fea4-4f98-8569-b3dc4e84cdcb@app.fastmail.com>
In-Reply-To: <aa0e034d-fc68-69d6-8d27-8f30d138b9be@linux.intel.com>
References: <20260910143440.3865663-2-ardb+git@google.com>
 <aa0e034d-fc68-69d6-8d27-8f30d138b9be@linux.intel.com>
Subject: Re: [RFC PATCH] PCI: Tolerate non-prefetchable 64-bit BARs in prefetchable
 windows
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable


On Thu, 10 Sep 2026, at 19:31, Ilpo J=C3=A4rvinen wrote:
> On Thu, 10 Sep 2026, Ard Biesheuvel wrote:
>
>> From: Ard Biesheuvel <ardb@kernel.org>
>>=20
>> The prefetchable vs. non-prefetchable distinction is a relic of
>> conventional PCI, to denote from which regions PCI-PCI bridges were
>> permitted to perform speculative readahead.
>>=20
>> For software compatibility reasons, PCI Express inherited the Type 1
>> header and models PCIe root ports as PCI-PCI bridges. However, this
>> readahead behavior does not exist in PCIe, and so this distinction has
>> mostly become meaningless on the bridge level.
>>=20
>> As per the PCIe r6.3 ECN "Removing Prefetchable Terminology", the
>> 'prefetchable' designation has been removed from the specification
>> entirely, on the basis that it is obsolete, and is being abused to
>> inform memory mapping attributes and other device/BAR level properties
>> that it was never intended for.
>>=20
>> Given the limited range for non-prefetchable windows in the Type 1
>> header, and the fact that the distinction no longer exists for PCIe,
>> resource allocation performed by firmware may result in non-prefetcha=
ble
>> 64-bit BARs being allocated inside prefetchable bridge windows.
>>=20
>> Linux rejects such allocations ("can't claim; no compatible bridge
>> window") when it encounters them, but will usually fail to produce an
>> alternative allocation, given that firmware wouldn't have placed them
>> there in the first place if there was sufficient space in the
>> non-prefetchable window.
>>=20
>> So at the very least, let's not reject such allocations when they were
>> made by the firmware.
>>=20
>> Cc: Bjorn Helgaas <bhelgaas@google.com>
>> Cc: "Ilpo J=C3=A4rvinen" <ilpo.jarvinen@linux.intel.com>
>> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
>> ---
>> Link: https://github.com/tianocore/edk2/issues/13104
>>=20
>>  drivers/pci/pci.c   | 3 ++-
>>  include/linux/pci.h | 4 ++--
>>  2 files changed, 4 insertions(+), 3 deletions(-)
>>=20
>> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
>> index b2879a6be5f8..e33eb9f3a139 100644
>> --- a/drivers/pci/pci.c
>> +++ b/drivers/pci/pci.c
>> @@ -761,7 +761,8 @@ struct resource *pci_find_parent_resource(const s=
truct pci_dev *dev,
>>  			 * not, the allocator made a mistake.
>>  			 */
>>  			if (r->flags & IORESOURCE_PREFETCH &&
>> -			    !(res->flags & IORESOURCE_PREFETCH))
>> +			    !(res->flags & IORESOURCE_PREFETCH) &&
>> +			    !pci_is_pcie(dev))
>>  				return NULL;
>> =20
>>  			/*
>
> I was more thinking along the lines of always setting IORESOURCE_PREFE=
TCH=20
> for 64-bit BARs on PCIe devices but I've not had time to look at that/=
test=20
> how many things would break as a result. ...It would seem much simpler=20
> solution to differentiate PCI from PCIe while keeping the existing log=
ic=20
> without adding similar pci_is_pcie() checks everywhere.
>

I agree that the code changes would be much simpler.

However, would this impact the PCI metadata observed by all consumers,
including userspace, and drivers that may expect a certain BAR layout,
and/or base decisions about memory attributes on this?

In particular, I am concerned about non-prefetchable BARs that actually
have side effects on read, being mapped with WC (or Normal-NC on arm64)
semantics, where the interconnect may widen, combine or reorder accesses.


>> diff --git a/include/linux/pci.h b/include/linux/pci.h
>> index d31a8d107b1e..1cbb4b6c02c3 100644
>> --- a/include/linux/pci.h
>> +++ b/include/linux/pci.h
>> @@ -2684,7 +2684,7 @@ static inline void pci_vf_drivers_autoprobe(str=
uct pci_dev *dev, bool probe) { }
>>   * need to calculate PCIe capability offset from raw device for some
>>   * reasons, please use pci_find_capability() instead.
>>   */
>> -static inline int pci_pcie_cap(struct pci_dev *dev)
>> +static inline int pci_pcie_cap(const struct pci_dev *dev)
>>  {
>>  	return dev->pcie_cap;
>>  }
>> @@ -2695,7 +2695,7 @@ static inline int pci_pcie_cap(struct pci_dev *=
dev)
>>   *
>>   * Returns: true if the PCI device is PCI Express capable, false oth=
erwise.
>>   */
>> -static inline bool pci_is_pcie(struct pci_dev *dev)
>> +static inline bool pci_is_pcie(const struct pci_dev *dev)
>>  {
>>  	return pci_pcie_cap(dev);
>>  }
>>=20
>
> This const conversion should be done in a separate preparatory patch (=
if=20
> needed in the end, though IMO it wouldn't hurt to have it as const=20
> anyway even if it's not necessary for the 64-bit/pref change in the en=
d).
>

Of course. But this is just an RFC to get the discussion going, so I did=
n't
bother at this point.

