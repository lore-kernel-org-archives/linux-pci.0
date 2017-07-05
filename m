Return-Path: <SRS0=SVn8=6I=ucw.cz=mj+f-050717+helgaas=kernel.org@kernel.org>
Return-Path: <SRS0=SVn8=6I=ucw.cz=mj+f-050717+helgaas=kernel.org@kernel.org>
Date: Wed, 5 Jul 2017 15:19:12 +0200
From: Martin Mares <mj@ucw.cz>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Jeffy Chen <jeffy.chen@rock-chips.com>, linux-pci@vger.kernel.org,
	rajatja@google.com, briannorris@chromium.org
Subject: Re: [PCIUTILS PATCH v2] lspci: Fix wrong read size for RootSta
Message-ID: <mj+md-20170705.131850.63428.nikam@ucw.cz>
References: <1498817340-24918-1-git-send-email-jeffy.chen@rock-chips.com>
 <20170701132640.GA18324@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170701132640.GA18324@bhelgaas-glaptop.roam.corp.google.com>
List-ID: <linux-pci.vger.kernel.org>

Hello!

> > We are reading wrong size(word) for this cap, since:
> > 
> > RootSta has:
> > PCI_EXP_RTSTA_PME_STATUS  0x00010000 /* PME Status */
> > PCI_EXP_RTSTA_PME_PENDING 0x00020000 /* PME is Pending */
> > 
> > Signed-off-by: Jeffy Chen <jeffy.chen@rock-chips.com>
> 
> Looks good to me.  Root Status is indeed a 32-bit register, per
> PCIe r3.1, sec 7.8.14.
> 
> Reviewed-by: Bjorn Helgaas <bhelgaas@google.com>

Thanks, applied.

				Have a nice fortnight
-- 
Martin `MJ' Mares                          <mj@ucw.cz>   http://mj.ucw.cz/
Faculty of Math and Physics, Charles University, Prague, Czech Rep., Earth
Even nostalgia isn't what it used to be.
