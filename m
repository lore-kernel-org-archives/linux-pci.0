Return-Path: <SRS0=4R7u=JH=arm.com=lorenzo.pieralisi@kernel.org>
Return-Path: <SRS0=4R7u=JH=arm.com=lorenzo.pieralisi@kernel.org>
Date: Thu, 21 Jun 2018 17:48:29 +0100
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To: Ray Jui <ray.jui@broadcom.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Bjorn Helgaas <helgaas@kernel.org>,
	linux-kernel@vger.kernel.org, bcm-kernel-feedback-list@broadcom.com,
	linux-pci@vger.kernel.org
Subject: Re: [PATCH v2 0/5] Improve Broadcom PAXC support
Message-ID: <20180621164821.GA14519@e107981-ln.cambridge.arm.com>
References: <1528762867-16823-1-git-send-email-ray.jui@broadcom.com>
 <45945371-3cd7-102d-bb47-69a60435542b@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <45945371-3cd7-102d-bb47-69a60435542b@broadcom.com>
List-ID: <linux-pci.vger.kernel.org>

On Wed, Jun 20, 2018 at 10:26:28AM -0700, Ray Jui wrote:
> Hi Lorenzo/Bjorn,
> 
> Could you please help to review this patch series when you have time?
> 
> I believe I have addressed major comment in v1 from Bjorn and answered all
> questions from Lorenzo.

I will have a look next week, sorry for the delay.

Thanks,
Lorenzo

> Thanks,
> 
> Ray
> 
> On 6/11/2018 5:21 PM, Ray Jui wrote:
> >This patch series improves the Broadcom PAXC support by 1) adding more
> >quirks for specific versions of PAXC controllers; 2) adding logic to
> >reject internally unconfigured physical functions from the embedded
> >network processor acting as endpoint; 3) reducing verbose print level
> >in the outbound/inbound mapping code
> >
> >This patch series is based off v4.17 and is available on GIHUB:
> >repo: https://github.com/Broadcom/arm64-linux.git
> >branch: sr-paxc-v2
> >
> >Changes since v1:
> >  - consolidate 2 PAXC related patch series into 1
> >  - change the way how the capability list corruption is handled, per
> >recommendation from Bjorn. Now handle and fix up the corruption at
> >the config register read
> >  - rebase to v4.17
> >
> >Ray Jui (5):
> >   PCI: iproc: Activate PAXC bridge quirk for more devices
> >   PCI: iproc: Fix up corrupted PAXC root complex config registers
> >   PCI: iproc: Disable MSI parsing in certain PAXC blocks
> >   PCI: iproc: Reject unconfigured physical functions from PAXC
> >   PCI: iproc: Reduce inbound/outbound mapping print level
> >
> >  drivers/pci/host/pcie-iproc.c | 159 +++++++++++++++++++++++++++++++++++-------
> >  drivers/pci/host/pcie-iproc.h |   8 +++
> >  drivers/pci/quirks.c          |   3 +
> >  3 files changed, 144 insertions(+), 26 deletions(-)
> >
