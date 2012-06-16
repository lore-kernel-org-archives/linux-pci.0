Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from Chamillionaire.breakpoint.cc ([80.244.247.6]:44344 "EHLO
	Chamillionaire.breakpoint.cc" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755961Ab2FPIv3 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Sat, 16 Jun 2012 04:51:29 -0400
Date: Sat, 16 Jun 2012 10:50:49 +0200
From: Sebastian Andrzej Siewior <sebastian@breakpoint.cc>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Ralf Baechle <ralf@linux-mips.org>,
	Myron Stowe <myron.stowe@gmail.com>, linux-pci@vger.kernel.org,
	linux-kbuild@vger.kernel.org, Michal Marek <mmarek@suse.cz>
Subject: Re: [PATCH 7/9] mips: move PCI fixup hooks from __init to __devinit
Message-ID: <20120616085049.GA2723@breakpoint.cc>
References: <1338749305-22558-1-git-send-email-sebastian@breakpoint.cc>
 <1338749305-22558-8-git-send-email-sebastian@breakpoint.cc>
 <CAL-B5D1GEMd9TPMqbYBqDuzs5U2jo7ByRg73Z=dPsPcgTSyJJA@mail.gmail.com>
 <CAErSpo77vyUaGTzVNwFGzTHsOapYNFRy_KOvNnXo=jdU2kYLbA@mail.gmail.com>
 <20120615163823.GA14302@linux-mips.org>
 <CAErSpo5kv_vE9D=AnyVdcXOAQpM6U3dyPpouE-NyNoU98R+syA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; x-action=pgp-signed
In-Reply-To: <CAErSpo5kv_vE9D=AnyVdcXOAQpM6U3dyPpouE-NyNoU98R+syA@mail.gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA256

On Fri, Jun 15, 2012 at 03:13:26PM -0600, Bjorn Helgaas wrote:
> On Fri, Jun 15, 2012 at 10:38 AM, Ralf Baechle <ralf@linux-mips.org> wrote:
> > On Fri, Jun 15, 2012 at 10:33:15AM -0600, Bjorn Helgaas wrote:
> >
> >> > Doesn't the above line also need changed to __devinitdata if the
> >> > function itself is being
> >> > changed from __init to __devinit?
> >>
> >> I think so.  And pci_irq[] and piixirqmap[] also need to be moved,
> >> since they're referenced by __devinit code.  I fixed these, audited
> >> all the other patches, and updated the "next" branch.
> >
> > I'm going to patch that up.
> 
> Does this mean you're going to push it through your tree and I should
> remove the mips patch from my "next" branch?  Either way is fine with
> me; currently I'm planning to push all the other arch patches via my
> tree.

Ralf picked up my patch [0] and commited a few fixups on top [1] and a malta
fixup [2].

[0] http://git.linux-mips.org/?p=ralf/linux.git;a=commitdiff;h=184170a613f4bccf4d58a4e73fa5d3a1ee839f38
[1] http://git.linux-mips.org/?p=ralf/linux.git;a=commitdiff;h=f54d03696bdc1a9457c11ed6ae61e8f001217b25
[2] http://git.linux-mips.org/?p=ralf/linux.git;a=commitdiff;h=2ec8663f9c03a96f2c328c7c483603c31d62ad37

> Bjorn

Sebastian
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBCAAGBQJP3EjpAAoJEHuW6BYqjPXRNnQP/j6+Dt1fklG3wKYkU+svqhiE
P7BeOQa4AK+8cPG7o5T1e+F3aNszSu8J/f7d0Y4qSy5u/b1kwNSgochU6fGSTeIt
jFZM7Yevft4RUU76q5ga1CdRWEVVJ8aex0lbfQs2aEsASndXZNSCkm3KQOXGd+mj
pwwe3rdiDxKBQJ0QeebpQRym0sUw9hsAaO4XXLJ8d2fVo+rIjJMSKM3bzMzb6GFh
D3slYMCIYvIXg8+s6Hslv2Wc51oL+FkoASZXx1d7gCK/Utf+WLo30OyQdStC5rsq
MqVy7+P4cZOKAAq181gX7Jx655ghVrnllJNjtMXgauCu8wjLE5FjIyh5DBz1VzDj
w7rG7mbRMQz2P+CEmPNQwy6e4pspUh7GgKnc0duTQaPRderi3CN+rQRVdz9bBEDK
Qtcf+vtReW8fRdcIAqgRcs/JmTgTZLyLeKf0Aa8s0h2SA9TRz/U7lqxf8Mq2zzyq
TJXLtTtqXekTum11cuxbAUsbfuDCVtuHu648WJu0YS5J3mWEbIg94kULGLKclSy9
aK3feDiS1kSWonKxr4LZ4pPh452dJl1+1Eq121rnK+IAG2qWSsda4ju8RVxxIHex
hVhME1x8rkarBEUH2w4Y4aMKCgNbeHIVotnGhzwzYUQXXkZ+43RvQgPeCIkhwYx4
1cx3lPomgGNN9JIETK6n
=pKYs
-----END PGP SIGNATURE-----
