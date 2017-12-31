Return-Path: <SRS0=qoD1=D3=ucw.cz=mj+f-311217+helgaas=kernel.org@kernel.org>
Return-Path: <SRS0=qoD1=D3=ucw.cz=mj+f-311217+helgaas=kernel.org@kernel.org>
Date: Sun, 31 Dec 2017 18:20:43 +0100
From: Martin Mares <mj@ucw.cz>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org, Rudolf Marek <r.marek@assembler.cz>,
	RayeR <rayer@seznam.cz>
Subject: Re: [PATCH] lspci: Decode "VGA 16-bit decode" in bridge control
 register
Message-ID: <mj+md-20171231.172036.7264.albireo@ucw.cz>
References: <20171208212410.30418.94419.stgit@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20171208212410.30418.94419.stgit@bhelgaas-glaptop.roam.corp.google.com>
List-ID: <linux-pci.vger.kernel.org>

Hi!

> Decode the "VGA 16-bit decode" bit in the bridge control register.  This
> bit was added in the PCI-to-PCI Bridge Arch Spec, r1.2, sec 3.2.5.18.
> Note that the bit is only meaningful if the VGA Enable bit or the VGA
> Palette Snoop Enable bit is set.

Thanks, applied.

				Have a nice fortnight
-- 
Martin `MJ' Mares                          <mj@ucw.cz>   http://mj.ucw.cz/
Faculty of Math and Physics, Charles University, Prague, Czech Rep., Earth
A sine curve goes off to infinity or at least the end of the blackboard.
