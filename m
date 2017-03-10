Return-Path: <SRS0=1EYN=2T=free.fr=slash.tmp@kernel.org>
Return-Path: <SRS0=1EYN=2T=free.fr=slash.tmp@kernel.org>
Subject: Re: Neophyte questions about PCIe
To: David Laight <David.Laight@ACULAB.COM>,
 Robin Murphy <robin.murphy@arm.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>, Rob Herring <robh@kernel.org>,
 Arnd Bergmann <arnd@arndb.de>, Ard Biesheuvel <ard.biesheuvel@linaro.org>,
 Marc Zyngier <marc.zyngier@arm.com>, linux-pci <linux-pci@vger.kernel.org>,
 Thibaud Cornic <thibaud_cornic@sigmadesigns.com>,
 linux-usb <linux-usb@vger.kernel.org>,
 Phuong Nguyen <phuong_nguyen@sigmadesigns.com>,
 Shawn Lin <shawn.lin@rock-chips.com>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>
References: <ced6a4bf-c94a-c116-1e94-52a8d675d132@free.fr>
 <20170308151724.GA20780@bhelgaas-glaptop.roam.corp.google.com>
 <f964ee05-db7f-c381-c91c-82897175da6d@free.fr>
 <1092d971-5d81-2da7-4b34-0a88637c0ec5@arm.com>
 <063D6719AE5E284EB5DD2968C1650D6DCFE7C8BA@AcuExch.aculab.com>
 <c4712e19-863c-16b8-6920-5ad7dd178929@free.fr>
 <063D6719AE5E284EB5DD2968C1650D6DCFE7C973@AcuExch.aculab.com>
From: Mason <slash.tmp@free.fr>
Message-ID: <6c9027c8-2d2a-6cba-1fa7-e64f6795bfbb@free.fr>
Date: Fri, 10 Mar 2017 16:33:07 +0100
MIME-Version: 1.0
In-Reply-To: <063D6719AE5E284EB5DD2968C1650D6DCFE7C973@AcuExch.aculab.com>
Content-Type: text/plain; charset=windows-1252
List-ID: <linux-pci.vger.kernel.org>

On 10/03/2017 16:14, David Laight wrote:

> Mason wrote:
> 
>> My RC drops packets not targeting its BAR0.
> 
> I suspect the fpga/cpld logic supports RC and endpoint modes
> and is using much the same names for the registers (and logic
> implementation).

Your guess is spot on.

In the controller's MMIO registers, the so-called core_conf_0
register has the following field:

chip_is_root: 1 means tango is root port, 0 means tango is endpoint.

> If your cpu support more than 1GB of memory but only part is
> PCIe accessible you'll have to ensure that all the memory
> definitions are set correctly and 'bounce buffers' used for
> some operations.

Do you mean I would have to "fix" something in the XHCI driver?

Hopefully, no customer plans to give Linux more than 1 GB.
(Although the latest systems do support 4 GB... A lot of it is
used for video buffers, handled outside Linux.)

Regards.
