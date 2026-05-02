Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2A761DF980
	for <linux-pci@vger.kernel.org>; Sat,  2 May 2026 01:34:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777685678; cv=none; b=ZdTnMWgiVJ5H9l+b9o0OaddOQ1A2SQ40OQJRRPeScPmsN+p8ocD1XSFGXnczIU+DJuyjWK70sybK2X76dc1SAk+RQdhh7HQaB4KiL+A+kuqHjWF322BXK85bPbrulVAAcvs1dHY2TJUIFn4OdTMWL0ObT+6S2GU9G+cw8LFed0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777685678; c=relaxed/simple;
	bh=6IeC1fGfmSPk4G3F6nPV2xqcB+uRScXf1At+qXNCcU0=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=JqAqMauLZNiySMztOxmM7CbyAzPYSyxdYzNi6aTunmNvicKEx/A5UcrHuJ+s31v6CH4MCn6Hr0C5tdyEVqYtZdPeVB29mBCGRGR/7j1mcrSiS5TCfkKJMar8ZCcP4ZNd7+q+zHIjXa3mS5O3cjF6tiBeJ6Kb2x9FcZmim27etcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MXuKcRsA; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MXuKcRsA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 274B2C2BCB7;
	Sat,  2 May 2026 01:34:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777685677;
	bh=6IeC1fGfmSPk4G3F6nPV2xqcB+uRScXf1At+qXNCcU0=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=MXuKcRsAjTALD8vMP3GW9K46PJ4HDPY/a46SQDRk5KHATi0P0n9RqEcOgpxApNcLY
	 Y41WKuu24xcx/3qQ4t5aC6MepMerDQBLH4a1KmYKvuI8Znz77Q8Jj/1pfdEomdQcyQ
	 4qBW6Pz1BNGq57pWoLvAWLnt3e2bZxGbP5EgefirnGGh/YBy9fHPH7WHSS2hBCOgF8
	 wdMfsVBlupnuBBeJjMl4wu0Z4H9ixk2SsoLgQ+tUUjEJrR6DWb4Nmy6BshV7COUFhZ
	 z3JzSbQTUVDoqsDU71CnqtpFa3ZYzF/kQRQi9VrGzxm1QAlhf6GM8OeIZPBnBC/E8+
	 iF5TracxV2+Fg==
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfauth.phl.internal (Postfix) with ESMTP id 25773F40068;
	Fri,  1 May 2026 21:34:36 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Fri, 01 May 2026 21:34:36 -0400
X-ME-Sender: <xms:rFT1afuifF2JbnowJq4kxoIgyO-uLBAziJXH2HU-PvRUTd-VSyuOgg>
    <xme:rFT1aZT0nDCDorI_Udz-bxTIWOwGj53gyB0X6tgT-Jv9ieJiDo_Ht89kLzxWPo3ZZ
    6f_G4_gB2l2xou6VUKIuHvJhFXklNE6QhAASkFi5VqRA5yPZXMryQ>
X-ME-Received: <xmr:rFT1aUHM0iSu9pb_3ZP71jsV_aQPpWl0Wt-5_LvFaU1UjA3uGNMHL2KaeLzGOwV3YctM1Qv_R4O9k7NWGDz2oH98T8NtwZcG_gU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdeludejjecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefkjghfufggtgfgsehtqhertddttdejnecuhfhrohhmpedfffgrnhcuhghi
    lhhlihgrmhhsucdlnhhvihguihgrmddfuceoughjsgifsehkvghrnhgvlhdrohhrgheqne
    cuggftrfgrthhtvghrnhepueeffeeugfeggfehudduvdejieduveduvdekieeghefhkedv
    hedtkefgtdevveeknecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvg
    hrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegujhgsfidomhgvshhmthhp
    rghuthhhphgvrhhsohhnrghlihhthidqudejjedvfedtgeehhedqfeeffeelgedtgeejqd
    gujhgsfieppehkvghrnhgvlhdrohhrghesfhgrshhtmhgrihhlrdgtohhmpdhnsggprhgt
    phhtthhopedvuddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoheprghlihhsthgrih
    hrvdefsehgmhgrihhlrdgtohhmpdhrtghpthhtoheplhhukhgrshesfihunhhnvghrrdgu
    vgdprhgtphhtthhopegujhgsfieskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepsghhvg
    hlghgrrghssehgohhoghhlvgdrtghomhdprhgtphhtthhopehruhhsthdqfhhorhdqlhhi
    nhhugiesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegrkhhpmheslhhinh
    hugidqfhhouhhnuggrthhiohhnrdhorhhgpdhrtghpthhtoheplhhinhhugidqphgtihes
    vhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehjohhnrghthhgrnhdrtggrmh
    gvrhhonheshhhurgifvghirdgtohhmpdhrtghpthhtoheplhhinhhugidqtgiglhesvhhg
    vghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:rFT1aTdiXlbZ_rOqV3YK1oT0q6xZ9lOUuj0peMWZIZuZLk3OlITC7w>
    <xmx:rFT1aTvj3HnIhqPgnQv-tZbZ6iReHQQc1ExGbOah9j-GIgZzK__1eA>
    <xmx:rFT1aZdfvUEHJ-36rnnqvp5Qp62Fzv-71_uy21ccmcl2xdtFSIfwnQ>
    <xmx:rFT1aXokJE6QNEAmSTfRDUNaRVFCg2cciSmTcfTgSPocsCUd8hWFSw>
    <xmx:rFT1aX9nX_-DPVYkku6FLbAH0vZ2oCBxx5X74GhykvliG9nxYEZhCmEe>
Feedback-ID: i67ae4b3e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 1 May 2026 21:34:35 -0400 (EDT)
Date: Fri, 01 May 2026 18:34:34 -0700
From: "Dan Williams (nvidia)" <djbw@kernel.org>
To: Alistair Francis <alistair23@gmail.com>, 
 Lukas Wunner <lukas@wunner.de>
Cc: Dan Williams <djbw@kernel.org>, 
 bhelgaas@google.com, 
 rust-for-linux@vger.kernel.org, 
 akpm@linux-foundation.org, 
 linux-pci@vger.kernel.org, 
 Jonathan.Cameron@huawei.com, 
 linux-cxl@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 alex.gaynor@gmail.com, 
 benno.lossin@proton.me, 
 boqun.feng@gmail.com, 
 a.hindborg@kernel.org, 
 gary@garyguo.net, 
 bjorn3_gh@protonmail.com, 
 tmgross@umich.edu, 
 ojeda@kernel.org, 
 wilfred.mallawa@wdc.com, 
 aliceryhl@google.com, 
 Alistair Francis <alistair.francis@wdc.com>
Message-ID: <69f554aa525ae_44a831001f@djbw-dev.notmuch>
In-Reply-To: <CAKmqyKN3nuA_uH+1o9XPrFoi7TnBY_R92SiP1srhXFdhnngd3A@mail.gmail.com>
References: <20260211032935.2705841-1-alistair.francis@wdc.com>
 <698d6b7faa190_2e57100d3@dwillia2-mobl4.notmuch>
 <CAKmqyKPyR165rACXRMJXgyUOp6OUdQqSsym-gfYVFnKLZ4ednQ@mail.gmail.com>
 <69e19c80b892b_fe0831000@djbw-dev.notmuch>
 <aeG4UnyYd1FKdt1D@wunner.de>
 <CAKmqyKN3nuA_uH+1o9XPrFoi7TnBY_R92SiP1srhXFdhnngd3A@mail.gmail.com>
Subject: Re: [RFC v3 00/27] lib: Rust implementation of SPDM
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

Alistair Francis wrote:
> On Fri, Apr 17, 2026 at 2:34=E2=80=AFPM Lukas Wunner <lukas@wunner.de> =
wrote:
> >
> > On Thu, Apr 16, 2026 at 07:35:44PM -0700, Dan Williams wrote:
> > > Later in the thread I proposed an alternative that instead of suppo=
rting
> > > 2 flavors of uapi through "authenticated", instead implement CMA as=

> > > another TSM driver [1].
> > >
> > > [1]: http://lore.kernel.org/69976d7d39c60_2f4a1009@dwillia2-mobl4.n=
otmuch
> >
> > Please keep in mind though that CMA is just the PCIe adaption of SPDM=
,
> > SPDM is not only needed for PCIe but also SCSI, ATA and possibly othe=
rs
> > and so implementing CMA as a TSM driver must not preclude use of SPDM=

> > in other subsystems.
> =

> That should be fine as the current SPDM implementation is
> self-contained, but thanks for raising that.
> =

> Just to make sure I'm not going in the wrong direction, the idea would
> be to build on
> =

> https://lore.kernel.org/all/20260303000207.1836586-9-dan.j.williams@int=
el.com/
> =

> and add something like this?
> =

> ```
> static const struct pci_tsm_ops pci_cma_tsm_ops =3D {
>     .link_ops =3D {
>         .probe        =3D pci_cma_tsm_probe,
>         .remove        =3D pci_cma_tsm_remove,
>         .connect    =3D pci_cma_tsm_connect,
>         .disconnect    =3D pci_cma_tsm_disconnect,
>     },
>     .refresh_evidence    =3D pci_cma_tsm_refresh,
> };
> ```
> =

> The docs for `struct pci_tsm_ops` seem pretty TSM specific, so I just
> wanted to double check before going ahead.
> =

> That means all of the netlink stuff in this series can be dropped and
> we just use the TSM netlink (which might need some adjustments then,
> I'll have to double check)

Right, the above looks what I was expecting.

As for netlink, Lukas is right about non CMA use cases. The netlink
interface will either need to move to be a generic "device evidence"
facility, not scoped to PCI/TSM, or itself become a library that
different producers of SPDM material can use to export it to userspace.=
