Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:60536 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934362AbeFRLdE (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 18 Jun 2018 07:33:04 -0400
Date: Mon, 18 Jun 2018 12:34:41 +0100
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To: Scott Branden <scott.branden@broadcom.com>
Cc: Guenter Roeck <linux@roeck-us.net>, Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        Jan Kiszka <jan.kiszka@siemens.com>,
        Ley Foon Tan <lftan@altera.com>,
        Russell King <linux@armlinux.org.uk>
Subject: Re: [v4] PCI: improve host drivers compile test coverage
Message-ID: <20180618113440.GA338@red-moon>
References: <20180405193154.27897-1-robh@kernel.org>
 <20180612170229.GA10141@roeck-us.net>
 <20180613100935.GA7707@e107981-ln.cambridge.arm.com>
 <20180613181146.GA28856@roeck-us.net>
 <20180615125847.GA7735@e107981-ln.cambridge.arm.com>
 <980b68c0-6034-b495-753f-c75c04e0f5d1@broadcom.com>
 <3d84b647-1bc5-3b56-bca3-7a7a72d31c21@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <3d84b647-1bc5-3b56-bca3-7a7a72d31c21@broadcom.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Jun 15, 2018 at 10:58:19AM -0700, Scott Branden wrote:
> 
> 
> On 18-06-15 10:55 AM, Scott Branden wrote:
> >Hi Lorenzo,
> >
> >
> >On 18-06-15 05:58 AM, Lorenzo Pieralisi wrote:
> >>On Wed, Jun 13, 2018 at 11:11:46AM -0700, Guenter Roeck wrote:
> >>>On Wed, Jun 13, 2018 at 11:09:35AM +0100, Lorenzo Pieralisi wrote:
> >>>>[+Jan, Ley Foon, RMK]
> >>>>
> >>>>On Tue, Jun 12, 2018 at 10:02:29AM -0700, Guenter Roeck wrote:
> >>>>>On Thu, Apr 05, 2018 at 02:31:54PM -0500, Rob Herring wrote:
> >>>>>>Add COMPILE_TEST on driver config options with it. Some ARM drivers
> >>>>>>still have arch dependencies, so we have to keep those
> >>>>>>dependent on ARM.
> >>>>>>
> >>>>>>Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> >>>>>>Cc: Bjorn Helgaas <bhelgaas@google.com>
> >>>>>>Cc: linux-pci@vger.kernel.org
> >>>>>>Signed-off-by: Rob Herring <robh@kernel.org>
> >>>>>This patch has the undesirable side effect that it selects
> >>>>>PCI_DOMAINS for
> >>>>>sparc32:allmodconfig, which in turn results in
> >>>>>
> >>>>>drivers/ata/pata_ali.c: In function 'ali_init_chipset':
> >>>>>drivers/ata/pata_ali.c:469:38: error:
> >>>>>    implicit declaration of function 'pci_domain_nr'; did
> >>>>>you mean 'pci_iomap_wc'?
> >>>>>
> >>>>>Unfortunately, 37bd62d224c82 ("PCI: Enable PCI_DOMAINS
> >>>>>along with generic
> >>>>>PCI host controller") has pretty much the same result. No
> >>>>>idea how to fix
> >>>>>the problem, so I won't even try.
> >>>>Sorry about that.
> >>>>
> >>>>One option would consist in removing all PCI_DOMAINS selection from
> >>>>drivers/pci/controller/Kconfig and delegate it to arches even though
> >>>>this would force PCI_DOMAINS selection on all ARM platforms (it is
> >>>>already selected for ARCH_MULTIPLATFORM).
> >>>>
> >>>>Or we add back arch dependency to the relevant host bridges.
> >>>>
> >>>>Everything else I have in mind seems overkill to me given that this
> >>>>patch was added to improve test coverage (we could add a default
> >>>>pci_domain_nr() stub - weak or #define - that returns 0 in case arches
> >>>>do not provide an implementation but do we really want to do that ?).
> >>>>
> >>>>Thoughts appreciated.
> >>>>
> >>> From the definition of PCI_DOMAINS, I suspect the original
> >>>idea was that
> >>>drivers should depend on it, not select it. Especially auto-selecting
> >>>it with PCI_HOST_GENERIC seems like a bad idea to me. However, that is
> >>>just me. I'll leave it up to Bjorn to decide what if anything he wants
> >>>to do about it.
> >>Here is a patch that should reinstate the previous behaviour but
> >>it will make PCI_DOMAINS a visible option on ARM 32-bit systems; whether
> >>that's acceptable that's the question I need to answer, it should
> >>honour old configs and it does not force PCI_DOMAINS selection on
> >>non-DT arch/arm PCI host controllers (that do not need PCI_DOMAINS
> >>anyway so I suspect that enabling it on all ARM 32-bit platforms
> >>should not break anything but I preferred to be cautious).
> >I think this change will also require a patch enabling
> >CONFIG_PCI_DOMAINS in multi_v7_defconfig and iproc_defconfig at
> >the very least?
> as well as arm64/configs/defconfig?  Rather than having to change
> all the defconfigs perhaps can to make default y in Kconfig for
> architectures that should have it as such?

I can't do that on ARM, this would force PCI_DOMAINS on platforms
that never relied on it and that can trigger regressions.

It is unfortunate but the safest option consists in selecting
PCI_DOMAINS in the respective ARCH_* options I think.

Lorenzo
