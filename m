Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01C5B3F54D9;
	Fri, 11 Sep 2026 10:02:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789120935; cv=none; b=JNa9H1iZdHkwX2qRS4njoekCSdkiFtj5SaREEVeCG5ZQYZCoiG2jHo8Hvr2PlH44p8w5hEfxdJRaIvY3Yaf6Fy6io+MO9dgxf7DAc0b4Ue73dEkJ+eoT2udndM1AYinIJXn05jcDju7Z1WqqBmXThJBP+40ZFXMFWU+biW0i+vI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789120935; c=relaxed/simple;
	bh=Qg9Pf5m4fAlnXQyxa0YxUpu1miSnWRO3wmHqhRgDb/s=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=iV5+nGPtc7nt6bX4pkDFnnnNFHHnstHES/2R/Wm3EpVjaAeuIxdy9EPHEku0BZyoma/Djvxvplwm1si6wIfOxR3kmvITBzZt0wRDuOIJRaFEjLVfx8Pe+WpGAHJswFoLvyMpwERifvJEyfH6W+A2HfMOlzwBTfofeMht36LTN6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C7k8V0h8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C7k8V0h8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5DAD91F00893;
	Fri, 11 Sep 2026 10:02:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789120929;
	bh=w9bWC+Y7XLkxTdmDgp438euNI00pTW8sqJuzE5U3P+Y=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject;
	b=C7k8V0h8QtAVlv9Ie0rVZ2eKXBd+YD+28C/1oEZ23V6bCHC/xKvdYS3jNiyHEaEvH
	 EjhWQlPsCi7cD7m6mmL+Uw4Eldvmvt9532P1eQC9veIupMNSbXdsZxkdJdVZ+mjiK8
	 IdSwdEDbZ+w712aWPMzDG028sBkEpZaiMwAhcxQ9mdqyKun7rN1Qfn2+Fhr0gEJoTQ
	 43jAAM1kSSE66cJ2svmASRIr0dWfKkRsYcO0X6wXDnbFadooeVQ7egkmT827NjduTj
	 P/4uFIpWFMy8gKumDs/2O5Z8KlMBlrPRbxdrtr7nSYjBl8HbAkSi0VR65Ztz3fg77n
	 wcHBOpSTER55A==
Received: from ams-compute-02.internal (ams-compute-02.internal [10.64.2.62])
	by mailfauth.ams.internal (Postfix) with ESMTP id C0D4D1980054;
	Fri, 11 Sep 2026 06:02:07 -0400 (EDT)
Received: from ams-imap-11 ([10.64.2.31])
  by ams-compute-02.internal (MEProxy); Fri, 11 Sep 2026 06:02:07 -0400
X-ME-Sender: <xms:ntGjahZMoVQE9rtT_tPzYQwPsFtCh8HqJhJCWXdsDjxHDi-vKR1XpA>
    <xme:ntGjajP93wb2USWdonzykUirIXX3bYfwrh5raZyq43THV-VaSBLASX20gQLfLbAyX
    j809tDWWUGNMoq7fv0dO6J0JRl-lCnBLQ1EXPxbfH3M1MShxFbnmOqR>
X-ME-Proxy-Cause: dmFkZTGhJJeSc9NrlHirlaMeFwM1Tf/ZlaV7N5wqtk4nwTWW92rE2zIWFLXcjmlPYTDjgJ
    djRSKEd4FkqHpmIkrxZ8DNUazmiLJRcdEevvd8UM5qZBEagwLtAyPoGDSfS+JQ3VDGlCd6
    w6T5IILnvpPfOAB6vbDoyovSV0H0oNxlkDjNYQdSFheN8PVnQwnCW9MFReCj2os/4Rqt7r
    E15mXFJoHlwcCJ80CG47C5FbEQA+9JhQXdraj0+xTPf17XEoyl5IEX9Q0S2yNYJEzESWcB
    Xy2ur3j7P8UovskxT2fXwNZ47sb4cFTJiKiMwx4gJZ9FcbTnta86+yis7rvEvIh/oV4+pp
    g7www+a0B6azD4BodIcaHmiE6ybCkO8qL0Klx3xbxkPDcNmJthpoIufFeazF60G/YxWmsp
    D3NgDi0+YM+CONGQpXL/XfRyrNYUYy+O7zw1ek7Ya66rApc5R0tdRnJz+1zWHyWB44mkP0
    TOgfNDFv2KiTzvum+Ziu8tc0HWs7ZDyBq9Px8wOhngcJNjC17gOJ5wiX8YBvkoNcQ15pKO
    HPYPzFE/oLynbw+1xvbQ3LOUjzZVyJv/sWZWtKE0JnJZabbwz6XDZE3WDe03w6O1UMRUbk
    OvVYL3OciTwyCQPCPu6LLUKAkPYFP5EujdxONkPjm/Is0fljbzD3ma9JSo+A
X-ME-Proxy: <xmx:n9GjaoNhU3INvHu0CAGZDtT9AnOr78NjE0iXRnJiZ7L2gjg2PelDiw>
    <xmx:n9Gjaip4UQ3PIoGoJwSNM60tk2gJYLGuC0swB8BOJXrXmbddTyAJ1g>
    <xmx:n9GjapFAIVnXJIHMZ2o8gfSk09M9x18Db99OS-y_K2ldB7NIwrhpVA>
    <xmx:n9GjanozxPo42J-e5S-mKfY-vmbUn6M2U1pLzoZ9rZvMbl-JJlgSjQ>
    <xmx:n9GjaiZWt7JKDmFjzuHmlZnkUem3iMaZ0ZeaNNg8c7Fk36GT7JQ1FK2n>
Feedback-ID: ice86485a:Fastmail
Received: by mailuser.ams.internal (Postfix, from userid 501)
	id 4944FF8007E; Fri, 11 Sep 2026 06:02:06 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Fri, 11 Sep 2026 12:01:46 +0200
From: "Ard Biesheuvel" <ardb@kernel.org>
To: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: "Ard Biesheuvel" <ardb+git@google.com>, linux-pci@vger.kernel.org,
 LKML <linux-kernel@vger.kernel.org>, "Bjorn Helgaas" <bhelgaas@google.com>
Message-Id: <48bb0fb6-10dc-46a7-84f6-3464d7c7bdfe@app.fastmail.com>
In-Reply-To: <2e392b1b-3cbe-5cf8-e190-b1c82d69562f@linux.intel.com>
References: <20260910143440.3865663-2-ardb+git@google.com>
 <aa0e034d-fc68-69d6-8d27-8f30d138b9be@linux.intel.com>
 <41345c53-fea4-4f98-8569-b3dc4e84cdcb@app.fastmail.com>
 <2e392b1b-3cbe-5cf8-e190-b1c82d69562f@linux.intel.com>
Subject: Re: [RFC PATCH] PCI: Tolerate non-prefetchable 64-bit BARs in prefetchable
 windows
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable


On Fri, 11 Sep 2026, at 11:27, Ilpo J=C3=A4rvinen wrote:
> On Thu, 10 Sep 2026, Ard Biesheuvel wrote:
>
>>=20
>> On Thu, 10 Sep 2026, at 19:31, Ilpo J=C3=A4rvinen wrote:
>> > On Thu, 10 Sep 2026, Ard Biesheuvel wrote:
>> >
>> >> From: Ard Biesheuvel <ardb@kernel.org>
>> >>=20
>> >> The prefetchable vs. non-prefetchable distinction is a relic of
>> >> conventional PCI, to denote from which regions PCI-PCI bridges were
>> >> permitted to perform speculative readahead.
>> >>=20
>> >> For software compatibility reasons, PCI Express inherited the Type=
 1
>> >> header and models PCIe root ports as PCI-PCI bridges. However, this
>> >> readahead behavior does not exist in PCIe, and so this distinction=
 has
>> >> mostly become meaningless on the bridge level.
>> >>=20
>> >> As per the PCIe r6.3 ECN "Removing Prefetchable Terminology", the
>> >> 'prefetchable' designation has been removed from the specification
>> >> entirely, on the basis that it is obsolete, and is being abused to
>> >> inform memory mapping attributes and other device/BAR level proper=
ties
>> >> that it was never intended for.
>> >>=20
>> >> Given the limited range for non-prefetchable windows in the Type 1
>> >> header, and the fact that the distinction no longer exists for PCI=
e,
>> >> resource allocation performed by firmware may result in non-prefet=
chable
>> >> 64-bit BARs being allocated inside prefetchable bridge windows.
>> >>=20
>> >> Linux rejects such allocations ("can't claim; no compatible bridge
>> >> window") when it encounters them, but will usually fail to produce=
 an
>> >> alternative allocation, given that firmware wouldn't have placed t=
hem
>> >> there in the first place if there was sufficient space in the
>> >> non-prefetchable window.
>> >>=20
>> >> So at the very least, let's not reject such allocations when they =
were
>> >> made by the firmware.
>> >>=20
>> >> Cc: Bjorn Helgaas <bhelgaas@google.com>
>> >> Cc: "Ilpo J=C3=A4rvinen" <ilpo.jarvinen@linux.intel.com>
>> >> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
>> >> ---
>> >> Link: https://github.com/tianocore/edk2/issues/13104
>> >>=20
>> >>  drivers/pci/pci.c   | 3 ++-
>> >>  include/linux/pci.h | 4 ++--
>> >>  2 files changed, 4 insertions(+), 3 deletions(-)
>> >>=20
>> >> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
>> >> index b2879a6be5f8..e33eb9f3a139 100644
>> >> --- a/drivers/pci/pci.c
>> >> +++ b/drivers/pci/pci.c
>> >> @@ -761,7 +761,8 @@ struct resource *pci_find_parent_resource(cons=
t struct pci_dev *dev,
>> >>  			 * not, the allocator made a mistake.
>> >>  			 */
>> >>  			if (r->flags & IORESOURCE_PREFETCH &&
>> >> -			    !(res->flags & IORESOURCE_PREFETCH))
>> >> +			    !(res->flags & IORESOURCE_PREFETCH) &&
>> >> +			    !pci_is_pcie(dev))
>> >>  				return NULL;
>> >> =20
>> >>  			/*
>> >
>> > I was more thinking along the lines of always setting IORESOURCE_PR=
EFETCH=20
>> > for 64-bit BARs on PCIe devices but I've not had time to look at th=
at/test=20
>> > how many things would break as a result. ...It would seem much simp=
ler=20
>> > solution to differentiate PCI from PCIe while keeping the existing =
logic=20
>> > without adding similar pci_is_pcie() checks everywhere.
>> >
>>=20
>> I agree that the code changes would be much simpler.
>>=20
>> However, would this impact the PCI metadata observed by all consumers,
>> including userspace,
>
> Yes, it will impact userspace. But quoting you from above:
>
> "is being abused to inform memory mapping attributes and other device/=
BAR=20
> level properties that it was never intended for."
>
> What does the userspace then do with the information? Does it qualify=20
> under "it was never intended for"?
>

Perhaps, but that does not mean we are allowed to break it now.

More specifically, would the output of 'lspci' change as a result?

>> and drivers that may expect a certain BAR layout,
>
> ??? Would that even be spec compliant??
>

Again, maybe not, but if something that works fine today stops
working because the PCI subsystem started lying to the driver about
how the PCIe device describes itself, we'll be on the hook to fix it.

>> and/or base decisions about memory attributes on this?
>
> The point is to consider them 64-bit window eligible so yes, kernel wo=
uld=20
> definitely be basing decision on that but that's intentional.
>

That would mean that a driver may decide to use ioremap_wc() rather than
ioremap() to map a non-prefetchable BAR that we decided to misrepresent
as a prefetchable one. Even if the (pseudo-)PCI-PCI bridge will not do
any readahead, the CPU or interconnect may behave very differently as a
result, and touch BAR regions that the driver never accessed explicitly.

>> In particular, I am concerned about non-prefetchable BARs that actual=
ly
>> have side effects on read, being mapped with WC (or Normal-NC on arm6=
4)
>> semantics, where the interconnect may widen, combine or reorder acces=
ses.
>
> So on a more concrete terms, you're referring to the check in=20
> proc_bus_pci_mmap()? And the one in __pci_resource_attr_is_visible() +=20
> pci_dev_resource_wc_is_visible()? I suppose that wouldn't work then.
>

No, I am referring to the hundreds of ioremap() and ioremap_wc() calls
under drivers. Maybe none of them are affected but who knows.

> So if just setting IORESOURCE_PREFETCH is not workable, how about addi=
ng a=20
> getter for res->flags which adds IORESOURCE_PREFETCH into the returned=20
> flags if it's PCIe device and (in the end) use the raw value only in t=
hose=20
> places that actually care about wc distinction. What I don't want to s=
ee=20
> us adding that pci_is_pcie() everywhere.
>

Maybe add another IORESOURCE_PREFETCH_xxx flag that indicates that the
resource may be placed in a prefetchable bridge window? We'd only have
to set it in a single place (when probing the BAR), and we can add
support for it piecemeal in the validation and allocation logic.




