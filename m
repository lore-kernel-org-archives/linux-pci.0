Return-Path: <SRS0=ez2/=YR=gmail.com=hjmallon@kernel.org>
Return-Path: <SRS0=ez2/=YR=gmail.com=hjmallon@kernel.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 10.2 \(3259\))
Subject: Re: lspci memory behind bridge reporting
From: Harry Mallon <hjmallon@gmail.com>
In-Reply-To: <mj+md-20161231.155855.4261.nikam@ucw.cz>
Date: Tue, 3 Jan 2017 10:07:11 +0000
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 Bjorn Helgaas <helgaas@kernel.org>
Message-Id: <F194ADD0-4F27-4F91-A800-E30157A01D48@gmail.com>
References: <CDB45911-510C-459D-BCDC-17955FCC400D@gmail.com>
 <20161221201635.GA31167@bhelgaas-glaptop.roam.corp.google.com>
 <F9DB0FE1-0518-4799-98A9-DA9053A86AEC@gmail.com>
 <mj+md-20161231.155855.4261.nikam@ucw.cz>
To: Martin Mares <mj@ucw.cz>
List-ID: <linux-pci.vger.kernel.org>

Hi Martin,

Happy New Year. Thanks for looking at my patch. The reason I had the, =
admittedly horrible, ifdeffery is that I assumed that I should not be =
using u64 types without making sure they were available, looking back =
now I think I was mistaken.

I will make a configuration space dump/output combination when I can. =
The current machine I am working on is very non-standard and seems to be =
having some problems assigning PCI bridge memory so I will have to bring =
another machine up.

Harry

> On 31 Dec 2016, at 16:01, Martin Mares <mj@ucw.cz> wrote:
>=20
> Hi!
>=20
>> I attach a patch with behaviour similar to what you describe. It is =
based on
>> the current master branch of pciutils (hash
>> 4a190235224ff6dfe44adbb07ac929afea612acd).
>=20
> I like the idea, but not much the ifdeffery in your implementation.
> I wrote something similar in a little bit more systematic way, please
> see commit 41d883cb97f94e844e96b4631a99c3da557cf162.
>=20
>> I have not altered anything in the tests folder yet as I am not sure =
about how to run them.
>=20
> The tests are not automated yet. Just add a configuration space
> dump together with the expected output.
>=20
> 				Have a nice fortnight
> --=20
> Martin `MJ' Mares                          <mj@ucw.cz>   =
http://mj.ucw.cz/
> Faculty of Math and Physics, Charles University, Prague, Czech Rep., =
Earth
> Power corrupts; Powerpoint corrupts absolutely.  -- Vint Cerf
