Return-Path: <SRS0=kzs2=DF=assembler.cz=r.marek@kernel.org>
Return-Path: <SRS0=kzs2=DF=assembler.cz=r.marek@kernel.org>
Subject: Re: [PATCH] lspci: Decode "VGA 16-bit decode" in bridge control
 register
To: Bjorn Helgaas <helgaas@kernel.org>, Martin Mares <mj@ucw.cz>
Cc: linux-pci@vger.kernel.org, RayeR <rayer@seznam.cz>
References: <20171208212410.30418.94419.stgit@bhelgaas-glaptop.roam.corp.google.com>
From: Rudolf Marek <r.marek@assembler.cz>
Message-ID: <ef7e0e6a-404a-c54e-de99-cfebe2ff20cf@assembler.cz>
Date: Sat, 9 Dec 2017 12:08:00 +0100
MIME-Version: 1.0
In-Reply-To: <20171208212410.30418.94419.stgit@bhelgaas-glaptop.roam.corp.google.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-pci.vger.kernel.org>

Hi Bjorn,

Thanks for the patch. It works as expected on my system.
I tried to swap the bit and see if lspci sees that.

The patch does not apply cleanly on git or on 3.5.6, but maybe my mail client did something to it.

Thanks
Rudolf
