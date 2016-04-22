Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from kirsty.vergenet.net ([202.4.237.240]:40677 "EHLO
	kirsty.vergenet.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751508AbcDVAPC (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 21 Apr 2016 20:15:02 -0400
Date: Fri, 22 Apr 2016 10:14:58 +1000
From: Simon Horman <horms@verge.net.au>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Phil Edworthy <phil.edworthy@renesas.com>,
	Magnus Damm <magnus.damm@gmail.com>,
	linux-pci <linux-pci@vger.kernel.org>,
	linux-renesas-soc@vger.kernel.org,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v3] PCI: rcar-pcie: Remove Gen2 designation from Kconfig
Message-ID: <20160422001455.GA25416@verge.net.au>
References: <1461210715-29304-1-git-send-email-horms+renesas@verge.net.au>
 <CAMuHMdXtVvNERECxbp1EtJ1SNOQG-j_xtV3NpsGqgyDLmc7cOg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAMuHMdXtVvNERECxbp1EtJ1SNOQG-j_xtV3NpsGqgyDLmc7cOg@mail.gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Apr 21, 2016 at 03:38:35PM +0200, Geert Uytterhoeven wrote:
> On Thu, Apr 21, 2016 at 5:51 AM, Simon Horman
> <horms+renesas@verge.net.au> wrote:
> > It appears that Gen2 is a misnomer for the R-Car PCIE driver
> > which also supports Gen 1 and Gen 3 SoCs. Accordingly, drop Gen 2
> > from the help text and Kconfig symbol.
> >
> > Also, re-arange the Kconfig symbol name to use PCIE as the prefix.
> > This appears to be in keeping with other PCIE Kconfig symbols.
> >
> > Reported-by: Geert Uytterhoeven <geert+renesas@glider.be>
> > Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
> > Acked-by: Bjorn Helgaas <bhelgaas@google.com>
> 
> Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>

Thanks, I have queued this up.
