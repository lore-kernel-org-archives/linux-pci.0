Return-Path: <linux-kernel-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20180531235010.5279-2-logang@deltatee.com>
References: <20180531235010.5279-1-logang@deltatee.com> <20180531235010.5279-2-logang@deltatee.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Fri, 1 Jun 2018 13:39:49 +0300
Message-ID: <CAHp75VcQwDGqND8v1RTo4+6Hyf9G5_2w9x9aiVONwKXsTKgJ1Q@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] PCI: Make specifying PCI devices in kernel
 parameters reusable
To: Logan Gunthorpe <logang@deltatee.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-pci@vger.kernel.org,
        Linux Documentation List <linux-doc@vger.kernel.org>,
        Stephen Bates <sbates@raithlin.com>,
        Christoph Hellwig <hch@lst.de>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Jun 1, 2018 at 2:50 AM, Logan Gunthorpe <logang@deltatee.com> wrote=
:
> Separate out the code to match a PCI device with a string (typically
> originating from a kernel parameter) from the
> pci_specified_resource_alignment() function into its own helper
> function.
>
> While we are at it, this change fixes the kernel style of the function
> (fixing a number of long lines and extra parentheses).
>
> Additionally, make the analogous change to the kernel parameter
> documentation: Separating the description of how to specify a PCI device
> into it's own section at the head of the pci=3D parameter.
>
> Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
> Reviewed-by: Stephen Bates <sbates@raithlin.com>
> Acked-by: Christian K=C3=B6nig <christian.koenig@amd.com>

Sorry for maybe being late here.

> -       pci=3Doption[,option...]  [PCI] various PCI subsystem options:
> +       pci=3Doption[,option...]  [PCI] various PCI subsystem options.
> +
> +                               Some options herein operate on a specific=
 device
> +                               or a set of devices (<pci_dev>). These ar=
e
> +                               specified in one of two formats:

I would rather to add

 <pci_dev>

here in the same way as done for options.
It would be easy for people to find a referenced paragraph.

> +
> +                               [<domain>:]<bus>:<slot>.<func>
> +                               pci:<vendor>:<device>[:<subvendor>:<subde=
vice>]
> +
> +                               Note: the first format specifies a PCI
> +                               bus/slot/function address which may chang=
e
> +                               if new hardware is inserted, if motherboa=
rd
> +                               firmware changes, or due to changes cause=
d
> +                               by other kernel parameters. The second fo=
rmat
> +                               selects devices using IDs from the
> +                               configuration space which may match multi=
ple
> +                               devices in the system.

> +static int pci_dev_str_match(struct pci_dev *dev, const char *p,
> +                            const char **endptr)

This change I hope has no functional alteration, so, can be split to a
separate patch.

--=20
With Best Regards,
Andy Shevchenko
