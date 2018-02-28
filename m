Return-Path: <SRS0=7D2e=FW=gmail.com=andy.shevchenko@kernel.org>
Return-Path: <SRS0=7D2e=FW=gmail.com=andy.shevchenko@kernel.org>
MIME-Version: 1.0
In-Reply-To: <20180228084418.7566-1-jthumshirn@suse.de>
References: <20180228084418.7566-1-jthumshirn@suse.de>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Wed, 28 Feb 2018 16:43:35 +0200
Message-ID: <CAHp75VfbZCitjh2spwCqFCa5ckLp2rTqqgT17NWiuSgwrL_=vQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] MCB Update for v4.17
To: Johannes Thumshirn <jthumshirn@suse.de>
Cc: Greg KH <gregkh@linuxfoundation.org>, Bjorn Helgaas <helgaas@kernel.org>,
	Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>, Michael Moese <mmoese@suse.de>, linux-pci@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-pci.vger.kernel.org>

On Wed, Feb 28, 2018 at 10:44 AM, Johannes Thumshirn <jthumshirn@suse.de> wrote:
> Hi Greg or Bjorn,
>
> here's a small mcb update for the 4.17 window. The first patch makes
> the PCI Vendor ID of Altera generally available in pci_ids.h and
> removes it from the two private implementations before I would have to
> add a 3rd one.
>
> The 2nd patch adds the Altera's PCI vendor ID to the mcb pci driver
> which enables at least one carrier board. This was reported and tested
> by Ben Turner.
>
> Bjorn asked me to Cc linux-pci@ in his response, so I'm not sure if he want's
> to merge these two patches. I'm fine either way.
>

FWIW,
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

> Thanks,
>         Johannes
>
> Changes to v1:
> * Removed redundant pci_ids.h include
>
> Johannes Thumshirn (2):
>   PCI: add vendor id for Altera
>   mcb: add Altera PCI ID to mcb-pci
>
>  drivers/char/xillybus/xillybus_pcie.c | 1 -
>  drivers/fpga/altera-cvp.c             | 2 --
>  drivers/mcb/mcb-pci.c                 | 1 +
>  include/linux/pci_ids.h               | 2 ++
>  4 files changed, 3 insertions(+), 3 deletions(-)
>
> --
> 2.13.6
>



-- 
With Best Regards,
Andy Shevchenko
