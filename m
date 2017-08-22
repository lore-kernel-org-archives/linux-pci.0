Return-Path: <SRS0=D3nn=7Y=linux.ee=mroos@kernel.org>
Return-Path: <SRS0=D3nn=7Y=linux.ee=mroos@kernel.org>
Date: Tue, 22 Aug 2017 19:32:31 +0300 (EEST)
From: Meelis Roos <mroos@linux.ee>
Sender: mroos@math.ut.ee
To: Bjorn Helgaas <helgaas@kernel.org>
cc: =?ISO-8859-15?Q?G=FCrkan_Myczko?= <gurkan@phys.ethz.ch>,
    linux-pci@vger.kernel.org
Subject: Re: pci layer problem
In-Reply-To: <20170822162356.GA6948@bhelgaas-glaptop.roam.corp.google.com>
Message-ID: <alpine.LRH.2.20.1708221930480.23061@math.ut.ee>
References: <0c50a5ba7ceadc93555c6c6dedb22829@phys.ethz.ch> <20170822162356.GA6948@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
List-ID: <linux-pci.vger.kernel.org>

> > i've been told on #debian-sparc to report this (SUN UltraSparc,
> > SPARC64, Debian):
> >=20
> > some dmesg output:
> > [ 2683.006327] e1000: Intel(R) PRO/1000 Network Driver - version
> > 7.3.21-k8-NAPI
> > [ 2683.006792] e1000: Copyright (c) 1999-2006 Intel Corporation.
> > [ 2683.007379] e1000 0000:02:02.0: can't ioremap BAR 0: [mem size
> > 0x00020000]
> > [ 2683.007772] e1000: probe of 0000:02:02.0 failed with error -5
>=20
> Hi G=FCrkan,
>=20
> Sorry you tripped over a problem.  Can you please collect the complete
> dmesg log?

Yes, we would like to see the full dmesg, that also shows the kernel=20
version. If you do not have the networking, perhaps you can get it with=20
some USB stick?

The problem seems to another face of the problem I reported and that is=20
still there for most BAR allocations:=20
https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=3D594525

--=20
Meelis Roos (mroos@linux.ee)
