Return-Path: <SRS0=dPij=ET=gmail.com=linus971@kernel.org>
Return-Path: <SRS0=dPij=ET=gmail.com=linus971@kernel.org>
MIME-Version: 1.0
Sender: linus971@gmail.com
In-Reply-To: <20180124202501.yoy65ubq2zqumehn@chibold.localdomain>
References: <20180123195644.GA92112@bhelgaas-glaptop.roam.corp.google.com>
 <CA+55aFxFp_rjSviLUEH-uZ1U=x_g-xiAFKoEQqOOxZQs4xV11A@mail.gmail.com>
 <20180124004603.GH5317@bhelgaas-glaptop.roam.corp.google.com>
 <CA+55aFwpmqZUnD=3U23c-r89XmyncoXQzK7+b8AyuQ9+soC19g@mail.gmail.com>
 <20180124162027.GI5317@bhelgaas-glaptop.roam.corp.google.com>
 <CA+55aFzLwPDYz2dEM_X8Ase7+tLJDGU=ChasesP0ZGii4-D7Ow@mail.gmail.com> <20180124202501.yoy65ubq2zqumehn@chibold.localdomain>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 24 Jan 2018 12:48:25 -0800
Message-ID: <CA+55aFxf6ALo=1ODt76rN6FMM7RN12v_RHM-XB-hD1f9oqq1TQ@mail.gmail.com>
Subject: Re: [GIT PULL] PCI fixes for v4.15
To: Peter Grayson <jpgrayson@gmail.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>, Catalin Marinas <catalin.marinas@gmail.com>,
	linux-pci@vger.kernel.org,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
	Aaro Koskinen <aaro.koskinen@iki.fi>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Boris Ostrovsky <boris.ostrovsky@oracle.com>, Juergen Gross <jgross@suse.com>,
	Alex Deucher <alexander.deucher@amd.com>, David Airlie <airlied@linux.ie>
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-pci.vger.kernel.org>

On Wed, Jan 24, 2018 at 12:25 PM, Peter Grayson <jpgrayson@gmail.com> wrote:
>
> The latest stgit release (v0.18) ignores any mis-encoding of the email
> body. However, stgit master now decodes email bodies and is thus exposed
> to this kind of stray latin-1 character in a UTF-8 body.
>
> I believe stgit's goal should be to identify and repair this kind of
> issue as git does. I will be working on that.

Yes, good. The "latin1 vs utf-8" confusion is sadly still somewhat
common in Western Europe, from personal experience. People just got
used to Latin1 working almost by accident without any explicit
encoding, possibly _because_ it also acts as the first 256 bytes of
unicode.

I suspect the old 8-bit DOS character set (aka "code page 437") is
perhaps even more commonly seen in some situations, just not in unix
development contexts.. And it lacks a number of the (admittedly rarer)
European accented characters anyway.

So git basically first does a conversion according to the stated
encoding, but after that conversion it will then do another pass to
actually verify that the end result is valid utf-8, and if not, do the
(trivial) latin1 -> utf-8 conversion.

And part of the reason for that latin1 special case is very much the
whole "it's trivial" part. So it's not _just_ about "common error in
western emails", it's also simply that Latin1 really is special in the
Unicode domain.

No other character set has that trivial conversion into utf-8.

See verify_utf8() in commit.c in the git code.

> Unfortunately, the head of stgit master does not yet solve this issue. I
> am working to remedy that.

Thanks. We used to be *horrible* about getting "complex" names right
in the kernel logs, but I've tried to make sure that we actually get
this right and have proper names for the last many years.

              Linus
