Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:56508 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S966965AbeCSSF1 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 19 Mar 2018 14:05:27 -0400
Date: Mon, 19 Mar 2018 18:05:19 +0000
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To: Rob Herring <robh@kernel.org>
Cc: Scott Branden <scott.branden@broadcom.com>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        Jon Mason <jonmason@broadcom.com>
Subject: Re: [PATCH 7/9] PCI: improve host drivers compile test coverage
Message-ID: <20180319180519.GA13211@e107981-ln.cambridge.arm.com>
References: <20180307154243.3205-1-robh@kernel.org>
 <20180307154243.3205-8-robh@kernel.org>
 <368a94dc-72d3-9365-447b-07e9e811ade3@broadcom.com>
 <CAL_JsqKemmq8nucjVavhdSahx5NaGupzSt4cNkqvsCpSGMNHWw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAL_JsqKemmq8nucjVavhdSahx5NaGupzSt4cNkqvsCpSGMNHWw@mail.gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Mar 16, 2018 at 02:53:16PM -0500, Rob Herring wrote:
> On Wed, Mar 7, 2018 at 11:57 AM, Scott Branden
> <scott.branden@broadcom.com> wrote:
> > Hi Rob,
> >
> > Change to PCIE_IPROC_BCMA to be made.
> >
> >
> > On 18-03-07 07:42 AM, Rob Herring wrote:
> >>
> >> Add COMPILE_TEST on driver config options with it. Some ARM drivers
> >> still have arch dependencies, so we have to keep those dependent on ARM.
> >>
> >> Signed-off-by: Rob Herring <robh@kernel.org>
> >> ---
> >>   drivers/pci/dwc/Kconfig  | 24 ++++++++++++------------
> >>   drivers/pci/host/Kconfig | 33 +++++++++++++++------------------
> >>   2 files changed, 27 insertions(+), 30 deletions(-)
> 
> [...]
> 
> >> @@ -127,7 +126,7 @@ config PCIE_IPROC_PLATFORM
> >>     config PCIE_IPROC_BCMA
> >>         tristate "Broadcom iProc PCIe BCMA bus driver"
> >> -       depends on ARM && (ARCH_BCM_IPROC || COMPILE_TEST)
> >> +       depends on ARCH_BCM_IPROC || (ARM && COMPILE_TEST)
> >>         select PCIE_IPROC
> >>         select BCMA
> >>         default ARCH_BCM_5301X
> >
> > The was intentionally depending on ARM (as it does not apply to ARM64 which
> > ARCH_BCM__IPROC also applies to).  Please keep that in place.
> > depends on (ARM && ARCH_BCM_IPROC) || COMPILE_TEST
> 
> Indeed.
> 
> Lorenzo, can you fix up or want me to send a new version?

Hi Rob,

I can fix it up, I am not sure where the dependency on ARM is though,
isn't patch 2 supposed to remove it ? I am certainly missing something
here so please chime in.

Thanks,
Lorenzo
