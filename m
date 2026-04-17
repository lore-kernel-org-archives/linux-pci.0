Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67F3818BC3B
	for <linux-pci@vger.kernel.org>; Fri, 17 Apr 2026 02:35:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776393348; cv=none; b=H/SKwaz9ukMOZpuAthF70+trUn/A3FDveahL5gRU01RmXYE+Y2DvBG+jcM5QQ8lyqvTfLZLtRRve//8kin6wF47R1CY48vppdOO51Ezfne8vqaoCupogHSrozlU+v+vqjDglHhmUI70SO+Bed+rM58+g3o2FcwhmZoHuu0Vs+1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776393348; c=relaxed/simple;
	bh=4ewrZC1pbvvWyiCjNfr5Tz0N06j8o3Fh4tuSS5rDTJ4=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=gh1q+KrC59jbgD1YBoy2mOX1iVyjwJi28mwX2nnlV62raB+naNnZUq3vyAjhR020CAZQus/sD53aOZL1q0wB12ZF2gFG/uTqAMZMP89B5dlW5s/unmu5k5S58CBc1T+tG8T+fnYI+Up6bIo3aPFAwf8iO8ssYFaqVmMXcUko0GM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nklv1ezo; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nklv1ezo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9827FC2BCAF;
	Fri, 17 Apr 2026 02:35:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776393348;
	bh=4ewrZC1pbvvWyiCjNfr5Tz0N06j8o3Fh4tuSS5rDTJ4=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=nklv1ezoMQLDRFg3bQ4Nb3oIz+0mczDaWlyfjrIbPJv/jbvKWrNfMDwOHNp/CNBEd
	 GNZsgGrsdFNcKJekHILFitnh0GJuCcP5lryx+CyGUHRha5OycRuOkwCVmP5DHG7IRa
	 dG7VFHbJdSAB7GwCpCn3dOgRx0lc4b1HANvpwXsF9fZb5uOa/uSiM1IEdNkTSPqfLR
	 o7ySJ3jNau2eRj41jxHv8TgeGcQuesIG7hbyZzuD48gev7RnA0nH1GHlLULpFccLj8
	 cCS9xZvpM3jbwAAQZOAlk2S9t8Q8mVBOIE98nL7WXxp0jDjnrVNvsVNswPfjSLiEdP
	 bVywn807oDJCw==
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfauth.phl.internal (Postfix) with ESMTP id 9EB09F40084;
	Thu, 16 Apr 2026 22:35:46 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Thu, 16 Apr 2026 22:35:46 -0400
X-ME-Sender: <xms:gpzhaX3uuGFusm-Pwkfg0detpGEZ6qXfmNL839sme2xLFSqbm_d0AQ>
    <xme:gpzhaR8oQd-zsqXlYZwoOkDVCs0iEf7t7ckAODkH2xdf3AB0sWBquCUg_LympITi7
    61ySM12mLm93-FLdgPpCOIIKkgExhV01FC8wtcdqjav6fVN96zWog>
X-ME-Received: <xmr:gpzhaTbWcYArXfw_Cr3h9ESlb2ddlVsB6_I07D_0AWNI-BdKGj4hy4OyMt2sANEn2fzMzAw9RUA7wcLK9l_R7P3cS7tKJPbH37U>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdegkeejtdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefkjghfufggtgfgsehtqhertddttdejnecuhfhrohhmpeffrghnucghihhl
    lhhirghmshcuoegujhgsfieskhgvrhhnvghlrdhorhhgqeenucggtffrrghtthgvrhhnpe
    dukeelueetjeekgeeiheelvdehleekgeejvdejvdetgfdugffgveefgfejhffhvdenucff
    ohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepughjsgifodhmvghsmhhtphgruhhthhhpvghrshhonhgr
    lhhithihqddujeejvdeftdegheehqdeffeefleegtdegjedqughjsgifpeepkhgvrhhnvg
    hlrdhorhhgsehfrghsthhmrghilhdrtghomhdpnhgspghrtghpthhtohepvddtpdhmohgu
    vgepshhmthhpohhuthdprhgtphhtthhopegrlhhishhtrghirhdvfeesghhmrghilhdrtg
    homhdprhgtphhtthhopegshhgvlhhgrggrshesghhoohhglhgvrdgtohhmpdhrtghpthht
    oheplhhukhgrshesfihunhhnvghrrdguvgdprhgtphhtthhopehruhhsthdqfhhorhdqlh
    hinhhugiesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegrkhhpmheslhhi
    nhhugidqfhhouhhnuggrthhiohhnrdhorhhgpdhrtghpthhtoheplhhinhhugidqphgtih
    esvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehjohhnrghthhgrnhdrtggr
    mhgvrhhonheshhhurgifvghirdgtohhmpdhrtghpthhtoheplhhinhhugidqtgiglhesvh
    hgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhes
    vhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:gpzhaQyjJ5hIMyv3bQgt1VY-Wlf8vsA1J8PzmA2cAH9ttZq1JQTxpw>
    <xmx:gpzhaR_t2JfSj7XZVIZhp0rc4dlCiJdiO2rZqt3a90KEj27kgAfInQ>
    <xmx:gpzhacxmVscxJaUt3yaqz4PDlNtVJg2HBUYYoZJe0POI6J8KDiFoyg>
    <xmx:gpzhaWsu_zUF_480HHg52DHnJ3Pxx4i9vsEQ7PGqilUCeBh1HSOO0Q>
    <xmx:gpzhab2ZDaBwDco3092wa-bHgUim0pZs9xKk9XItNPg8SGMWIiIoCKF9>
Feedback-ID: i67ae4b3e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 16 Apr 2026 22:35:46 -0400 (EDT)
Date: Thu, 16 Apr 2026 19:35:44 -0700
From: Dan Williams <djbw@kernel.org>
To: Alistair Francis <alistair23@gmail.com>
Cc: bhelgaas@google.com, 
 lukas@wunner.de, 
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
Message-ID: <69e19c80b892b_fe0831000@djbw-dev.notmuch>
In-Reply-To: <CAKmqyKPyR165rACXRMJXgyUOp6OUdQqSsym-gfYVFnKLZ4ednQ@mail.gmail.com>
References: <20260211032935.2705841-1-alistair.francis@wdc.com>
 <698d6b7faa190_2e57100d3@dwillia2-mobl4.notmuch>
 <CAKmqyKPyR165rACXRMJXgyUOp6OUdQqSsym-gfYVFnKLZ4ednQ@mail.gmail.com>
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
> On Thu, Feb 12, 2026 at 3:56=E2=80=AFPM <dan.j.williams@intel.com> wrot=
e:
[..]
> >
> > So this is where it will collide with TSM that also emits an
> > authenticated attribute. See Documentation/ABI/testing/sysfs-bus-pci.=

> >
> > The rough plan Lukas and I worked out is that switching between TSM a=
nd
> > CMA based authentication would use sysfs visibility to coordinate. I.=
e.
> > TSM to CMA conversion hides the TSM "authenticated" attribute and
> > unhides the CMA attribute of the same name.
> =

> That seems straightforward and is already documented upstream as well,
> so that's pretty easy.

Later in the thread I proposed an alternative that instead of supporting
2 flavors of uapi through "authenticated", instead implement CMA as
another TSM driver [1].

[1]: http://lore.kernel.org/69976d7d39c60_2f4a1009@dwillia2-mobl4.notmuch=


> > The most significant unsolved point of contention between TSM and CMA=
 is
> > the policy on when authentication is mandated and the driver probe
> > policy. The proposed model for enforcing device security for
> > Confidential Computing is make it completely amenable to userspace
> > policy. Draft details here [2] to be refreshed "soon" when I send out=

> > the next version of that.
> >
> > [2]: http://lore.kernel.org/20250827035259.1356758-6-dan.j.williams@i=
ntel.com
> =

> CMA will eventually need to support some sort of drive probe policy as
> well, but that can wait until later and isn't going to be dealt with
> in this series.

Makes sense, and Greg wants to a see a more universal "device trust"
mechanism for this. This also means CMA as a TSM driver gets that
mechanism "for free" when the PCI/TSM effort moves it forward.

> > To be clear I am ok if there is an incremental option to have auto_cm=
a
> > and/or auto_tsm that arranges for authentication or link encryption t=
o
> > happen without asking. I take issue with auto_cma being the only hard=

> > coded option.
> =

> I have been working through all of the comments and discussions and I
> think I have addressed everything, except for this one.
> =

> To summerise, is the high level issue is how do we know if we should
> use CMA or TSM?
> =

> Do you have any more thoughts on this?

So most of the thinking is in that [1] above, and the new mechanism
would just be to auto-connect to the first TSM driver that appears, or
auto-connect to the TSM driver with the most capbility. For example,
auto-connect to the CMA-TSM at initial discovery, switch to Platform-TSM
if the device additionally supports IDE.=
