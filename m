Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D36BC44E646
	for <linux-pci@vger.kernel.org>; Tue,  4 Aug 2026 13:08:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785848921; cv=none; b=utieUbkjGYrlSch2upNPKJ6R9hgNs6pMiHEwA225ZOqEgzxfWTToy053gPeG/CgZcJD8BigqMHqmgFcFCZK/VNeRGZWu9ir1epSVWRr+z+mWDPM+Od3zqFylni40GFSuawmBFB/gEyi8goeTVzIFhMJBslaIy4bQ/c9ZaGcSFPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785848921; c=relaxed/simple;
	bh=xHZo1A1VtDJYlY6EkrWMbjKGxYCuZXgRF6NwfwHiDRg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ugESUdi8GNGs/qCEuYChDd+TXbxWYFb0CIuEDqnqV6vUfnh7+YGy8YRn+sDfqZHHWHhL3ixOiBgWrpDvyfTBLi4+b2pj/pza+H6NZa9D3/OY3Yx0QNjn0N0rommdLyBcS86MPV6eG1Nx210QSsTAXD1MpRaNjrWivPdyXMAULoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LlmJGv5v; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LlmJGv5v"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9FF411F00AC4
	for <linux-pci@vger.kernel.org>; Tue,  4 Aug 2026 13:08:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785848919;
	bh=ofJRSLDs8195GpMm/ynERVjZK0A8UzqOhqpVsGdmDLs=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=LlmJGv5vhzU3z0OGaoe3PB5BvaoAx7xwKrXTnNVxSrF3xDB9dJJnj7ZOscyGbq4Vu
	 cn2ynLxR82mF0sJU8L+IfdiGborxOlxYIhn1/EUKmJeR2LNp528Xej9LR+n7fXaElj
	 FRiXUftAdejARtTUPtrAxltFnFB9rNWnGI8HJWYtgZ6QluWMjdWEJxpSEVEdo62iy2
	 Y04xdDXOzJtDQvjYM2Asl2dZk1AN0JSRs1LxeDjFet2neblKD/LJOrQRufExC516oi
	 iwahGEyO0pisahZvwXy4bj6MQdPy2twGvlTqtSsOsNm/bucYg1XE8lFSf+ZofKmJ7w
	 njGNimNRhplcA==
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-39c9452244aso43678681fa.3
        for <linux-pci@vger.kernel.org>; Tue, 04 Aug 2026 06:08:39 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+Rp9Ljl1nync2tSUAh0NySKv+fNF5sPdBw6Q/phUY+RDmwDqovUrjwAvKw32L1+X6sdzVL6qNkA/oIc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6HaV1ZqPxMVr9ambk2thNk9KGEJOCeITxt9B7LGpjSGuhf9rN
	tDz5d646StzGzJwRbd8FWP776jtTmg35hRZNqOTX6Cn9UnnEBfLA8rKv6zMridToQ2xG1e+oMxP
	/HzGSwdxpUxKB3ZW9OnBTSHj28k266cw=
X-Received: by 2002:a2e:b8d5:0:b0:39c:60f3:5baf with SMTP id
 38308e7fff4ca-39f8613febcmr31970411fa.4.1785848918039; Tue, 04 Aug 2026
 06:08:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260803203459.10680-1-derekjohn.clark@gmail.com> <CAJZ5v0h78CSSORe_td1gp0n5DDWXN4zcnuXJsz247KYxgs-mdg@mail.gmail.com>
In-Reply-To: <CAJZ5v0h78CSSORe_td1gp0n5DDWXN4zcnuXJsz247KYxgs-mdg@mail.gmail.com>
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Tue, 4 Aug 2026 15:08:26 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0iY-SjCG3hdqggbchBA1DrYw04ARyNuzoyO67NF0dt2Ww@mail.gmail.com>
X-Gm-Features: AUfX_mx7PXL7rR74DC0X7XWaCgLchj17rF888okLUpxtINtQeJL297Ya49o15-k
Message-ID: <CAJZ5v0iY-SjCG3hdqggbchBA1DrYw04ARyNuzoyO67NF0dt2Ww@mail.gmail.com>
Subject: Re: [PATCH] acpi: pci_root: Add quirks table for _OSC support
To: "Derek J. Clark" <derekjohn.clark@gmail.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org, 
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, 
	"Pierre-Loup A . Griffais" <pgriffais@valvesoftware.com>, David Box <david.e.box@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 4, 2026 at 2:46=E2=80=AFPM Rafael J. Wysocki (Intel)
<rafael@kernel.org> wrote:
>
> On Mon, Aug 3, 2026 at 10:35=E2=80=AFPM Derek J. Clark
> <derekjohn.clark@gmail.com> wrote:
> >
> > The MSI Claw A8 hard-locks on resume from s2idle whenever an SD/MMC
> > card is present in the RTS525A card reader (10ec:525a, PCI ID). This
> > issue is not present on the Lenovo Legion Go with the same card reader.
> > The primary difference is that the Claw A8 withholds LTR and DPC while
> > granting ASPM control to the OS, leading to a split ownership. The issu=
e
> > can be mitigated by passing pcie_asmp=3Doff, but quirking on the pci_de=
v
>
> You mean pcie_aspm=3Doff I suppose.
>
> > in pci/quirks has no effect.
> >
> > Attempted quirks included use of pci_disable_link_state(),
> > dev->link_state =3D NULL, manually zeroing aspm_l0s_support/aspm_l1_sup=
port
> > via DECLARE_PCI_FIXUP_FINAL, and pcie_aspm_remove_cap() on
> > DECLARE_PCI_FIXUP_HEADER. Only by disabling ASPM on the root hub is the
> > system able to resume successfully.
>
> So if there is a clash between the firmware and the OS, the question
> is why it only happens during system resume and only for this specific
> device in this specific configuration.
>
> If disabling ASPM globally makes the symptom go away, it certainly is
> related to ASPM, but it is kind of hard to say what exactly the
> relationship is at this point.

Besides, does disabling ASPM globally affect what happens to LTR and
DPC?  I think so.

If that is the case, maybe the suspend-resume code paths skip LTR and
DPC if ASPM is disabled and they do something to those capabilities
otherwise?  LTR and DPC generally should not be touched by the system
suspend-resume paths if native_ltr and native_dpc are zero,
respectively.
