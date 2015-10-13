Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Arnd Bergmann <arnd@arndb.de>
To: Ray Jui <rjui@broadcom.com>
Cc: Hauke Mehrtens <hauke@hauke-m.de>,
	linux-arm-kernel@lists.infradead.org,
	Kevin Hilman <khilman@kernel.org>,
	Tyler Baker <tyler.baker@linaro.org>,
	lkml <linux-kernel@vger.kernel.org>,
	Olof Johansson <olof@lixom.net>,
	Mark Brown <broonie@kernel.org>,
	bcm-kernel-feedback-list@broadcom.com,
	Linux PCI <linux-pci@vger.kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH] PCI: iproc: fix 32-bit build error
Date: Tue, 13 Oct 2015 23:00:31 +0200
Message-ID: <5204456.Kxa6kNhPYW@wuerfel>
In-Reply-To: <561D6576.2020107@broadcom.com>
References: <1442363962-29805-1-git-send-email-rjui@broadcom.com> <561D6458.40504@hauke-m.de> <561D6576.2020107@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tuesday 13 October 2015 13:11:34 Ray Jui wrote:
> >> diff --git a/drivers/pci/host/pcie-iproc.c b/drivers/pci/host/pcie-iproc.c
> >> index f3481ddff344..abcb4be2ee19 100644
> >> --- a/drivers/pci/host/pcie-iproc.c
> >> +++ b/drivers/pci/host/pcie-iproc.c
> >> @@ -235,12 +235,13 @@ static void iproc_pcie_enable(struct iproc_pcie *pcie)
> >>   *
> >>   * axi_addr -> iproc_pcie_address -> OARR -> OMAP -> pci_address
> >>   */
> >> -static int iproc_pcie_setup_ob(struct iproc_pcie *pcie, u64 axi_addr,
> >> +int iproc_pcie_setup_ob(struct iproc_pcie *pcie, u64 axi_addr,
> > 
> > Why are you removing the static here?
> > 
> 
> Yeah we should keep this function as static. The rest of this change
> looks good!
> 

Sorry, this accidentally ended up in the patch when I marked the
function as global to track down how the division got called.

I'll send a new version.

	Arnd
