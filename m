Return-Path: <SRS0=TL/u=KD=h08.hostsharing.net=foo00@kernel.org>
Return-Path: <SRS0=TL/u=KD=h08.hostsharing.net=foo00@kernel.org>
Date: Thu, 19 Jul 2018 20:55:38 +0200
From: Lukas Wunner <lukas@wunner.de>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Hari Vyas <hari.vyas@broadcom.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>, linux-pci@vger.kernel.org,
	Ray Jui <ray.jui@broadcom.com>, Paul Mackerras <paulus@samba.org>,
	Michael Ellerman <mpe@ellerman.id.au>,
	linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v3] PCI: Data corruption happening due to race condition
Message-ID: <20180719185538.GA7731@wunner.de>
References: <1530608741-30664-1-git-send-email-hari.vyas@broadcom.com>
 <1530608741-30664-2-git-send-email-hari.vyas@broadcom.com>
 <20180718232904.GJ128988@bhelgaas-glaptop.roam.corp.google.com>
 <65dd986d0b8b2ebe5132b365dabb2dbaaed9177f.camel@kernel.crashing.org>
 <CAM5rFu8b1mdim8uA15TzpJtcxH5jXN3C53rBGZcyXG2h7bRoyA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAM5rFu8b1mdim8uA15TzpJtcxH5jXN3C53rBGZcyXG2h7bRoyA@mail.gmail.com>
List-ID: <linux-pci.vger.kernel.org>

On Thu, Jul 19, 2018 at 9:48 AM, Benjamin Herrenschmidt <benh@kernel.crashing.org wrote:
> Indeed. However I'm not fan of the solution. Shouldn't we instead have
> some locking for the content of pci_dev? I've always been wary of us
> having other similar races in there.

The solution presented is perfectly fine as it uses atomic bitops which
obviate the need for locking.  Why do you want to add unnecessary locking
on top?

Certain other parts of struct pci_dev use their own locking, e.g.
pci_bus_sem to protect bus_list.  Most elements can and should
be accessed lockless for performance.


> > The powerpc PCI code contains a lot of cruft coming from the depth of
> > history, including rather nasty assumptions. We want to progressively
> > clean it up, starting with EEH, but it will take time.

Then I suggest using the #include "../../../drivers/pci/pci.h" for now
until the powerpc arch code has been consolidated.

Thanks,

Lukas
