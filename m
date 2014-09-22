Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ig0-f179.google.com ([209.85.213.179]:32900 "EHLO
	mail-ig0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754707AbaIVUeb (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 22 Sep 2014 16:34:31 -0400
Received: by mail-ig0-f179.google.com with SMTP id l13so3454023iga.6
        for <linux-pci@vger.kernel.org>; Mon, 22 Sep 2014 13:34:31 -0700 (PDT)
Date: Mon, 22 Sep 2014 14:34:28 -0600
From: Bjorn Helgaas <bhelgaas@google.com>
To: Mathias Krause <minipli@googlemail.com>
Cc: linux-pci@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	"H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/5] x86/PCI: Minor size reduction by marking init code
 and data as such
Message-ID: <20140922203428.GF1880@google.com>
References: <1409001999-23161-1-git-send-email-minipli@googlemail.com>
 <20140922202748.GE1880@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20140922202748.GE1880@google.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

[+cc x86 folks]

On Mon, Sep 22, 2014 at 02:27:48PM -0600, Bjorn Helgaas wrote:
> On Mon, Aug 25, 2014 at 11:26:34PM +0200, Mathias Krause wrote:
> > Hi Bjorn,
> > 
> > this series is a collection of patches trying to mark initialization
> > code and data of the x86 specific PCI code as such. It also contains
> > __init annotation cleanups to move them to the spot they belong to
> > according to include/linux/init.h.
> > 
> > The annotation leads to a nice reduction of run-time memory size. At
> > least two additional pages can be released after initialization which
> > are otherwise occupied by code and data no longer needed.
> > 
> > Please apply!
> > 
> > Thanks,
> > 
> > Mathias Krause (5):
> >   x86/PCI: Mark DMI tables as initialization data
> >   x86/PCI: Move __init annotation were it belongs to
> >   x86/PCI: Mark constants of pci_mmcfg_nvidia_mcp55() as __initconst
> >   x86/PCI: Constify pci_mmcfg_probes[] array
> >   x86/PCI: Mark PCI BIOS initialization code as such
> 
> All applied to pci/initdata for v3.18, thanks!

Oops, I didn't notice that you hadn't cc'd the x86 folks.

Guys, if these should go through -tip, here's my ack:

Acked-by: Bjorn Helgaas <bhelgaas@google.com>

I don't have any other arch/x86 changes in my tree, so I don't care which
way these go.

> >  arch/x86/pci/common.c          |   20 ++++++++--------
> >  arch/x86/pci/mmconfig-shared.c |   40 ++++++++++++++++++--------------
> >  arch/x86/pci/pcbios.c          |    8 +++----
> >  3 files changed, 36 insertions(+), 32 deletions(-)
> > 
> > -- 
> > 1.7.10.4
> > 
