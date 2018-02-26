Return-Path: <linux-kernel-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20180226171617.10016-3-embedded24@evers-fischer.de>
References: <20180226171617.10016-1-embedded24@evers-fischer.de> <20180226171617.10016-3-embedded24@evers-fischer.de>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Mon, 26 Feb 2018 21:12:08 +0200
Message-ID: <CAHp75VcYas_2i8r1G1J=DXnwmor_4tbWm0GZtP_VorVMK1vKpw@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] pci: endpoint: Fix kernel panic after put_device()
To: Rolf Evers-Fischer <embedded24@evers-fischer.de>
Cc: Kishon Vijay Abraham I <kishon@ti.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Rolf Evers-Fischer <rolf.evers.fischer@aptiv.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Feb 26, 2018 at 7:16 PM, Rolf Evers-Fischer
<embedded24@evers-fischer.de> wrote:
> From: Rolf Evers-Fischer <rolf.evers.fischer@aptiv.com>
>
> 'put_device()' calls the relase function 'pci_epf_dev_release()',
> which already frees 'epf->name' and 'epf'.
>
> Therefore we must not free them again after 'put_device()'.

>  put_dev:
>         put_device(dev);
> -       kfree(epf->name);
> +       return ERR_PTR(ret);

Ouch, if it's double free (sounds like it is) it should be fixed up to
initial commit which brought that.
Thus, Fixes tag would be good to see.

-- 
With Best Regards,
Andy Shevchenko
