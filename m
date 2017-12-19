Return-Path: <SRS0=rO2X=DP=ellerman.id.au=mpe@kernel.org>
Return-Path: <SRS0=rO2X=DP=ellerman.id.au=mpe@kernel.org>
From: Michael Ellerman <mpe@ellerman.id.au>
To: Bjorn Helgaas <helgaas@kernel.org>, linux-pci@vger.kernel.org
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, linuxppc-dev@lists.ozlabs.org, Paul Mackerras <paulus@samba.org>, Russell Currey <ruscur@russell.cc>
Subject: Re: [PATCH] PCI: Add #defines for Completion Timeout Disable feature
In-Reply-To: <20171215225711.176712.65146.stgit@bhelgaas-glaptop.roam.corp.google.com>
References: <20171215225711.176712.65146.stgit@bhelgaas-glaptop.roam.corp.google.com>
Date: Tue, 19 Dec 2017 22:24:20 +1100
Message-ID: <871sjr9d0b.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-pci.vger.kernel.org>

Bjorn Helgaas <helgaas@kernel.org> writes:

> From: Bjorn Helgaas <bhelgaas@google.com>
>
> Add #defines for the Completion Timeout Disable feature and use them.  No
> functional change intended.
>
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> ---
>  arch/powerpc/platforms/powernv/eeh-powernv.c |    6 +++---
>  include/uapi/linux/pci_regs.h                |    2 ++
>  2 files changed, 5 insertions(+), 3 deletions(-)

LGTM.

Acked-by: Michael Ellerman <mpe@ellerman.id.au>

cheers
