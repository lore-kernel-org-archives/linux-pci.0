Return-Path: <SRS0=yikN=X3=gmail.com=mingo.kernel.org@kernel.org>
Return-Path: <SRS0=yikN=X3=gmail.com=mingo.kernel.org@kernel.org>
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date: Mon, 12 Dec 2016 08:27:33 +0100
From: Ingo Molnar <mingo@kernel.org>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Lukas Wunner <lukas@wunner.de>, x86@kernel.org,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
Subject: Re: [PATCH] x86/platform/intel-mid: Constify mid_pci_platform_pm
Message-ID: <20161212072733.GA23597@gmail.com>
References: <ba07572b4c4fad1f60593454693a58137f518896.1480859081.git.lukas@wunner.de>
 <20161207225315.GI22129@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20161207225315.GI22129@bhelgaas-glaptop.roam.corp.google.com>
List-ID: <linux-pci.vger.kernel.org>


* Bjorn Helgaas <helgaas@kernel.org> wrote:

> On Sun, Dec 04, 2016 at 03:35:55PM +0100, Lukas Wunner wrote:
> > This struct never needs to be modified.  The size of pci-mid.o ELF
> > sections changes thusly:
> > 
> > -.data          56
> > +.data           0
> > -.rodata        32
> > +.rodata        88
> > 
> > Acked-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > Acked-by: Bjorn Helgaas <bhelgaas@google.com>
> > Signed-off-by: Lukas Wunner <lukas@wunner.de>
> 
> Ingo, do you want this, since you've taken the previous updates?
> 
> It's trivial but doesn't apply cleanly to my tree, which makes me think
> it might be based on other changes I don't have.

It applies to upstream v4.9 cleanly, so I guess it's due to other changes you have 
in your tree?

Could you take it? Me having dabbled in drivers/pci/ is more of an outlier.

Thnks,

	Ingo
