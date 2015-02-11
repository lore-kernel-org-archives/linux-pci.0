Return-Path: <linux-kernel-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20150204191831.GA13785@google.com>
References: <20150204191831.GA13785@google.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Wed, 11 Feb 2015 10:48:24 -0600
Message-ID: <CAErSpo7ss1YvFVPc-f0SxkLNgWd3=TAKMj4D+x-vJa83M01-9g@mail.gmail.com>
Subject: Re: [GIT PULL] PCI fixes for v3.19
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Lucas Stach <l.stach@pengutronix.de>,
	Myron Stowe <myron.stowe@redhat.com>, Nix <nix@esperi.org.uk>,
	Charlotte Richardson <charlotte.richardson@stratus.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

[+cc lists, etc.; sorry, this has been merged already, but I forgot to
cc: everybody the first time]

On Wed, Feb 4, 2015 at 1:18 PM, Bjorn Helgaas <bhelgaas@google.com> wrote:
> Hi Linus,
>
> These are a regression fix for read-only BARs, a DesignWare fix that keeps
> drivers from using MSI-X (which isn't supported), and a DMI quirk to handle
> ftServer the same whether it says Stratus or NEC on the front.
>
> Bjorn
>
>
> The following changes since commit f175aa2c9f6cc08f043e85ea37f44ef3676cbac1:
>
>   MAINTAINERS: Update Richard Zhu's email address (2015-01-22 13:40:59 -0600)
>
> are available in the git repository at:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git tags/pci-v3.19-fixes-2
>
> for you to fetch changes up to 06cf35f903aa6da0cc8d9f81e9bcd1f7e1b534bb:
>
>   PCI: Handle read-only BARs on AMD CS553x devices (2015-02-03 20:28:02 -0600)
>
> ----------------------------------------------------------------
> PCI updates for v3.19:
>
>   Enumeration
>     - Scan all device numbers on NEC as well as Stratus (Charlotte Richardson)
>
>   Resource management
>     - Handle read-only BARs on AMD CS553x devices (Myron Stowe)
>
>   Synopsys DesignWare
>     - Reject MSI-X IRQs (Lucas Stach)
>
> ----------------------------------------------------------------
> Charlotte Richardson (1):
>       PCI: Add NEC variants to Stratus ftServer PCIe DMI check
>
> Lucas Stach (1):
>       PCI: designware: Reject MSI-X IRQs
>
> Myron Stowe (1):
>       PCI: Handle read-only BARs on AMD CS553x devices
>
>  arch/x86/pci/common.c              | 16 +++++++++++++++
>  drivers/pci/host/pcie-designware.c |  3 +++
>  drivers/pci/quirks.c               | 40 +++++++++++++++++++++++++++++++++++---
>  3 files changed, 56 insertions(+), 3 deletions(-)
