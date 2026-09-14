Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 316CC47607C;
	Mon, 14 Sep 2026 12:50:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789390253; cv=none; b=V1NZc851AKGgVeVVpFP1zvZ/qQ5o3EIgFTJXc9XEUwXMAxWiWnD1s2PFTGp4MHtSf93g1MVWzcuCspGXb1ZKlQ9Bs8zXqWoisJdneZNtJxlTQO7ZpzqU8dZdeMCdAEsX+cnjpzyJqox8RcnFLIMv1NfAovPPK3i1waVE9utzI6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789390253; c=relaxed/simple;
	bh=0NoH2Tpvl1/n5mc9VhKuszNE5hXA5/cZ4Yc4OxS3+p0=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=tIcs13OVQAYMilKa+mDl7yvSuOcPXOED2MSTnngPGTbLyPspELd4OUqrdnk0NOstRXnedR4Lp2FIzG0aT0qzL8Hsh/YLZWnfSOz1+MeazfAYF9+0AK+zV5hvAVbIE0zzzIme4Ft7mvGknhOi3MVKQni8ZNjuvmE677Y6/O1JwdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Uegma85N; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Uegma85N"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 211B81F00893;
	Mon, 14 Sep 2026 12:50:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789390251;
	bh=0NoH2Tpvl1/n5mc9VhKuszNE5hXA5/cZ4Yc4OxS3+p0=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject;
	b=Uegma85NvdyC3nKPByfZz/wHunTL+AtfrimcUzjcUqmVv61LxmcIQKcBNGlZacm8R
	 oh7F7jq+Uxs5ak1IzLDuoOOln4K4mN3A1RyBrjXt3+szgCIzhY4eSyLOA5IEiNUKVb
	 aNeGrzFePiCff2ZFmV3LL8lrncGXa6p2uaB2t5r4xqFGiYGwYSaG0K3vbG2dWDxoG+
	 JT8HTG3k5ZTViz6Lnm1Mq1gx3Dvf33bAWt8Qr/NJyYVuqw/hiY6rZ+JFtnfglSXCng
	 2Z0+aOaR5WfP+E08IrTNioDNyCbf1fESGoJ0FIQsPRniyQNJuaAB5HUKH8QquS2aIx
	 ek5C2blaR2HAA==
Received: from ams-compute-02.internal (ams-compute-02.internal [10.64.2.62])
	by mailfauth.ams.internal (Postfix) with ESMTP id 63624198003A;
	Mon, 14 Sep 2026 08:50:49 -0400 (EDT)
Received: from ams-imap-11 ([10.64.2.31])
  by ams-compute-02.internal (MEProxy); Mon, 14 Sep 2026 08:50:49 -0400
X-ME-Sender: <xms:p-2najfIrxVZphoNzMxTRa2n_KsIF6SO9116W9H8OuNyWttblNTvvw>
    <xme:p-2nakB9_EksMQwptwVKRyi32XK68D5XI7TCK3iZ7RJA8kLxeVqrfPBtQcXjVIMPG
    SGgbXY5f50QQhgdzCJW5odotnIoKeDw1-_tYYzphN3jfrJtYHHMbF9n>
X-ME-Proxy-Cause: dmFkZTESotjtFhXssfzvg9HgkWuk2HSbN+DlvSQiO3swTsOLBDiZU9n9V72o0v72bH5xBo
    3M063wj4dWcYKIbDMt9m10gOZPY7Ahog10r2g6YzayMQja7Vsq89Sxpaq4M9BNwi6jh5b+
    HAD21X5KRL41QX9FcSB9VUEy0x/quVsW1uPAPcsVRoT2K8HAspDoLlWp/NQM4+VjVKjq2o
    Y2nBQcXBqv4KptyGOYmNMMA7vCf+JJmOq9F8bt0Ht015ko5OR9po5tEmH99iUfaXnlxhwk
    15aP4426A/U4cWK8ikTGzACfiNxznS03opTWdYcCyWvxIRsbMa205aCUuKbVWw/13PsvBt
    IRaWKMIgsjDB08haC3Yal3dxNswI6T7aGK+LVO73DAQo17ApEKE0RiPZSoJX/YB2X1d2fl
    spdGeUPCQDvSOIinVbLMattIf6iIGiAc6sokCBZMI+YXsX+yJ0cfQEsW9sCrd9/00tqkvN
    BofdGsNMKk4htpm5vt2uLnZNHysSzVlUrL00y2N4oPdibFbsYJsB3YoM2owJSo47BXRODX
    F7eZDE0dtLN0g7ulLLyRAkd5cBYAddwZGK6/wNSA7xvz6TKArIWnN5fYSsD4tLgwDH9rlW
    2DFiEWQJNThCJzgphlXvEwnMWChjum5cdVoOFGiN7f+8XzhzEskHNSzxHSSQ
X-ME-Proxy: <xmx:qe2napCiy-xvDSSISpspKcyvz1r7nWTgnmZlGKTptCGGXH2jtq3DjQ>
    <xmx:qe2napybT4J0j94oUCpL4-3K5WQ843GYoBaVP5-UHyvbNFnRdBVUGQ>
    <xmx:qe2nam1Fx6hfBlRUpvrtk9_C1EbX2Fv3drPui1U2gSDe7sgGWRvXeA>
    <xmx:qe2napzrY_oqVjii0Ye9d0px9C2MRs2oSKuxe_Fgtcl8EODZMGZ64w>
    <xmx:qe2natFNviVRY-_GlMexbcwDPFIRvZcG65PBYRbBx_1VbrfKEj-JWIn7>
Feedback-ID: ice86485a:Fastmail
Received: by mailuser.ams.internal (Postfix, from userid 501)
	id AB5EEF8007D; Mon, 14 Sep 2026 08:50:47 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 14 Sep 2026 14:50:27 +0200
From: "Ard Biesheuvel" <ardb@kernel.org>
To: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 "Lorenzo Pieralisi" <lpieralisi@kernel.org>
Cc: "Ard Biesheuvel" <ardb+git@google.com>, linux-pci@vger.kernel.org,
 LKML <linux-kernel@vger.kernel.org>, "Bjorn Helgaas" <bhelgaas@google.com>
Message-Id: <b92392d4-22e5-4648-9373-ac7b90c44379@app.fastmail.com>
In-Reply-To: <d2a561a9-e175-e102-3fa2-0be02342774a@linux.intel.com>
References: <20260910143440.3865663-2-ardb+git@google.com>
 <aa0e034d-fc68-69d6-8d27-8f30d138b9be@linux.intel.com>
 <41345c53-fea4-4f98-8569-b3dc4e84cdcb@app.fastmail.com>
 <2e392b1b-3cbe-5cf8-e190-b1c82d69562f@linux.intel.com>
 <48bb0fb6-10dc-46a7-84f6-3464d7c7bdfe@app.fastmail.com>
 <d2a561a9-e175-e102-3fa2-0be02342774a@linux.intel.com>
Subject: Re: [RFC PATCH] PCI: Tolerate non-prefetchable 64-bit BARs in prefetchable
 windows
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable


On Mon, 14 Sep 2026, at 13:38, Ilpo J=C3=A4rvinen wrote:
> On Fri, 11 Sep 2026, Ard Biesheuvel wrote:
>> On Fri, 11 Sep 2026, at 11:27, Ilpo J=C3=A4rvinen wrote:
>> > On Thu, 10 Sep 2026, Ard Biesheuvel wrote:
>> >> On Thu, 10 Sep 2026, at 19:31, Ilpo J=C3=A4rvinen wrote:
...
>> >> >
>> >> > I was more thinking along the lines of always setting IORESOURCE=
_PREFETCH=20
>> >> > for 64-bit BARs on PCIe devices but I've not had time to look at=
 that/test=20
>> >> > how many things would break as a result. ...It would seem much s=
impler=20
>> >> > solution to differentiate PCI from PCIe while keeping the existi=
ng logic=20
>> >> > without adding similar pci_is_pcie() checks everywhere.
>> >> >
>> >>=20
>> >> I agree that the code changes would be much simpler.
>> >>=20
>> >> However, would this impact the PCI metadata observed by all consum=
ers,
>> >> including userspace,
>> >
>> > Yes, it will impact userspace. But quoting you from above:
>> >
>> > "is being abused to inform memory mapping attributes and other devi=
ce/BAR=20
>> > level properties that it was never intended for."
>> >
>> > What does the userspace then do with the information? Does it quali=
fy=20
>> > under "it was never intended for"?
>> >
>>=20
>> Perhaps, but that does not mean we are allowed to break it now.
>>=20
>> More specifically, would the output of 'lspci' change as a result?
>
> I'm not sure and I'm under impression there are multiple ways lspci ca=
n=20
> derive its information.
>
>> >> and drivers that may expect a certain BAR layout,
>> >
>> > ??? Would that even be spec compliant??
>>=20
>> Again, maybe not, but if something that works fine today stops
>> working because the PCI subsystem started lying to the driver about
>> how the PCIe device describes itself, we'll be on the hook to fix it.
>
> Understood.
>
> So I suppose you're not wanting to do this for the actual placement=20
> algorithm then because of the same risk but only cover the case where =
FW=20
> placed 64-bit non-pref BAR into prefetchable window like this patch=20
> currently does?
>

Basically. The firmware knows the platform better than the OS, so if it
produces a resource allocation with non-prefetchable PCIe BARs in
prefetchable bridge windows, there is a good chance this was deliberate.

> ...And limiting to that case only likely implies remove + rescan cycle=
 may=20
> fail because resources can no longer be placed into the same windows=20
> which will surprise user (arguably, not the most common use case but=20
> definitely surprising for the user if the kernel cannot place the=20
> resources the same way they were after boot =3D> another way to get pr=
oblem=20
> reports).
>
> (Unrelated to this change, I'm going to open that BAR placement can of=20
> worms myself in a week or two because of resource placement changes I'=
m=20
> preparing. And I already hit one such problem where a particular BAR=20
> address results in probe failure I'll probably have to quirk around. A=
nd=20
> I didn't even have to move things into another window to trigger that.)
>

Awesome :-)

>> >> and/or base decisions about memory attributes on this?
>> >
>> > The point is to consider them 64-bit window eligible so yes, kernel=
 would=20
>> > definitely be basing decision on that but that's intentional.
>>=20
>> That would mean that a driver may decide to use ioremap_wc() rather t=
han
>> ioremap() to map a non-prefetchable BAR that we decided to misreprese=
nt
>> as a prefetchable one. Even if the (pseudo-)PCI-PCI bridge will not do
>> any readahead, the CPU or interconnect may behave very differently as=
 a
>> result, and touch BAR regions that the driver never accessed explicit=
ly.
>>=20
>> >> In particular, I am concerned about non-prefetchable BARs that act=
ually
>> >> have side effects on read, being mapped with WC (or Normal-NC on a=
rm64)
>> >> semantics, where the interconnect may widen, combine or reorder ac=
cesses.
>> >
>> > So on a more concrete terms, you're referring to the check in=20
>> > proc_bus_pci_mmap()? And the one in __pci_resource_attr_is_visible(=
) +=20
>> > pci_dev_resource_wc_is_visible()? I suppose that wouldn't work then.
>>=20
>> No, I am referring to the hundreds of ioremap() and ioremap_wc() calls
>> under drivers. Maybe none of them are affected but who knows.
>
> I'm left to wonder how many of those are based on a IORESOURCE_PREFETC=
H=20
> check, I strongly suspect none. Somehow I feel I'm the only one runnin=
g=20
> git grep and I fail to locate any examples of the problem you mention.=
 No=20
> offense meant, I just feel we're dicussion code that is hypothetical a=
nd=20
> doesn't exist for real, and definitely not on large scale.
>

I can assure you you are not the only one running 'git grep'.

But I feel that presenting non-prefetchable BARs as prefetchable in every
respect just to simplify our logic wrt bridge window placement is not the
right approach. We must assume that non-prefetchable BARs may have side
effects on read - we are just relying on the fact that PCIe ports modeled
as PPBs will never perform readahead through their prefetchable windows.

For instance, such non-prefetchable BARs will end up having resourceN_wc
sysfs nodes created for them. They will also become mmap()'able with
WC attributes through /proc/bus/pci (via proc_bus_pci_mmap()).

> That being said, I don't have problem in accepting adding=20
> IORESOURCE_PREFETCH to all PCIe resources was not a good idea so there=
's=20
> no point in continuing discussion towards this direction.
>

Ok.

>> > So if just setting IORESOURCE_PREFETCH is not workable, how about a=
dding a=20
>> > getter for res->flags which adds IORESOURCE_PREFETCH into the retur=
ned=20
>> > flags if it's PCIe device and (in the end) use the raw value only i=
n those=20
>> > places that actually care about wc distinction. What I don't want t=
o see=20
>> > us adding that pci_is_pcie() everywhere.
>>=20
>> Maybe add another IORESOURCE_PREFETCH_xxx flag that indicates that the
>> resource may be placed in a prefetchable bridge window? We'd only have
>> to set it in a single place (when probing the BAR), and we can add
>> support for it piecemeal in the validation and allocation logic.
>
> Unfortunately, I've earlier discovered there's no "single place" unles=
s=20
> we add some gross res->flags fixup hack into PCI core. See e.g., the=20
> commit bdb32359eab9 ("sparc/PCI: Correct 64-bit non-pref -> pref BAR=20
> resources"), which we could hopefully revert after your change! So I'm=20
> afraid if you go to the new flag approach, besides drivers/pci/ you'd =
have=20
> to hunt down these from under arch/, and likely miss a few in the proc=
ess.
>
> Also, res->flags is currently full (for 32-bit) so you'd need to make =
the=20
> field (and therefore struct resource) larger.
>

Shame.

> So I still suggest having a flags getter for this purpose would be bet=
ter.
> In the complete solution covering also resource fitting and assignment=20
> algorithm, the main complication with that approach comes from the few=20
> cases that don't have the struct pci_dev readily available. Some can=20
> easily be handled by passing it as a param but there might be cases th=
at=20
> are given pci_bus as parameter that could be somewhat trickier if ther=
e is=20
> no resource nor pci_dev (in case of a root bus), but I'm not immediate=
ly=20
> sure if there are actually any cases for real that fall into the latte=
r=20
> category.
>

Yeah this is getting complicated very quickly :-)

So I take it you prefer to address this as a single feature, rather than
starting out by being more permissive when preserving the existing resou=
rce
allocation?

