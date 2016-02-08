Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Mon, 8 Feb 2016 10:53:56 -0500
From: Paul Gortmaker <paul.gortmaker@windriver.com>
To: Arnd Bergmann <arnd@arndb.de>
CC: <linux-kernel@vger.kernel.org>, Jingoo Han <jingoohan1@gmail.com>,
	Pratyush Anand <pratyush.anand@gmail.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Stanimir Varbanov <svarbanov@mm-sol.com>,
	Thierry Reding <thierry.reding@gmail.com>,
	<linux-pci@vger.kernel.org>
Subject: Re: [PATCH 3/5] drivers/pci: export dw syms enabling board specific
 PCI code to be tristate
Message-ID: <20160208155356.GV23093@windriver.com>
References: <1454889644-27830-1-git-send-email-paul.gortmaker@windriver.com>
 <1454889644-27830-4-git-send-email-paul.gortmaker@windriver.com>
 <4185524.RaOx11t2l7@wuerfel>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
In-Reply-To: <4185524.RaOx11t2l7@wuerfel>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

[Re: [PATCH 3/5] drivers/pci: export dw syms enabling board specific PCI code to be tristate] On 08/02/2016 (Mon 10:57) Arnd Bergmann wrote:

> On Sunday 07 February 2016 19:00:42 Paul Gortmaker wrote:
> > After converting the drivers who select PCI_DW from bool to tristate,
> > the following symbols need to be exported, simply based on the output
> > from modpost failures.
> > 
> > Cc: Jingoo Han <jingoohan1@gmail.com>
> > Cc: Pratyush Anand <pratyush.anand@gmail.com>
> > Cc: Bjorn Helgaas <bhelgaas@google.com>
> > Cc: Geert Uytterhoeven <geert+renesas@glider.be>
> > Cc: Stanimir Varbanov <svarbanov@mm-sol.com>
> > Cc: Thierry Reding <thierry.reding@gmail.com>
> > Cc: Arnd Bergmann <arnd@arndb.de>
> > Cc: linux-pci@vger.kernel.org
> > Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
> > 
> 
> Looks good in principle, but maybe use EXPORT_SYMBOL_GPL? These
> are just meant to be used internally by the drivers after all.

Sure, I can make that restriction.

P.
--

> 
> 	Arnd
