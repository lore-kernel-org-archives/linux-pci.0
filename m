Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
From: Arnd Bergmann <arnd@arndb.de>
To: Ray Jui <ray.jui@broadcom.com>
Subject: Re: [PATCH 2/2] PCI: iproc: avoid maybe-uninitialized warning
Date: Tue, 22 Nov 2016 22:15:08 +0100
Message-ID: <2504851.C6gOdhdaGF@wuerfel>
In-Reply-To: <31c4c52b-3de5-2277-7a44-2a4231531074@broadcom.com>
References: <20161122141844.1655574-1-arnd@arndb.de>
 <20161122141844.1655574-2-arnd@arndb.de>
 <31c4c52b-3de5-2277-7a44-2a4231531074@broadcom.com>
MIME-Version: 1.0
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: Scott Branden <sbranden@broadcom.com>, Jon Mason <jonmason@broadcom.com>,
 Ray Jui <rjui@broadcom.com>, linux-kernel@vger.kernel.org,
 Oza Oza <oza.oza@broadcom.com>,
 "Dmitry V. Krivenok" <krivenok.dmitry@gmail.com>, linux-pci@vger.kernel.org,
 Bjorn Helgaas <bhelgaas@google.com>, bcm-kernel-feedback-list@broadcom.com,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

On Tuesday, November 22, 2016 9:45:24 AM CET Ray Jui wrote:
> > diff --git a/drivers/pci/host/pcie-iproc.c b/drivers/pci/host/pcie-iproc.c
> > index 857ff5198317..0359569c8d78 100644
> > --- a/drivers/pci/host/pcie-iproc.c
> > +++ b/drivers/pci/host/pcie-iproc.c
> > @@ -936,6 +936,7 @@ static int iproc_pcie_setup_ib(struct iproc_pcie *pcie,
> >  
> >               }
> >       }
> > +     ret = -EINVAL;
> >  err_ib:
> >       dev_err(dev, "unable to configure inbound mapping\n");
> >       dev_err(dev, "axi %pap, pci %pap, res size %pap\n",
> > 
> 
> This change is good, but in my opinion, a further improvement for
> clarity would be to initialize 'ret' to -EINVAL in the beginning of this
> function when 'ret' is declared. What do you think?
> 

I never do that, see https://rusty.ozlabs.org/?p=232 for a great
explanation about why.

	Arnd

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
