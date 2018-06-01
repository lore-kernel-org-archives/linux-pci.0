Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-qt0-f196.google.com ([209.85.216.196]:43755 "EHLO
        mail-qt0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750827AbeFAKlW (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 1 Jun 2018 06:41:22 -0400
MIME-Version: 1.0
In-Reply-To: <20180531235010.5279-3-logang@deltatee.com>
References: <20180531235010.5279-1-logang@deltatee.com> <20180531235010.5279-3-logang@deltatee.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Fri, 1 Jun 2018 13:41:20 +0300
Message-ID: <CAHp75Vc4yxeM+jz2biMBoWB-h_dG1_Qx91VCP+f1mhvvgPVPxQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] PCI: Allow specifying devices using a base bus and
 path of devfns
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
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Jun 1, 2018 at 2:50 AM, Logan Gunthorpe <logang@deltatee.com> wrote=
:
> When specifying PCI devices on the kernel command line using a
> BDF, the bus numbers can change when adding or replacing a device,
> changing motherboard firmware, or applying kernel parameters like
> pci=3Dassign-buses. When this happens, it is usually undesirable to
> apply whatever command line tweak to the wrong device.
>
> Therefore, it is useful to be able to specify devices with a base
> bus number and the path of devfns needed to get to it. (Similar to
> the "device scope" structure in the Intel VT-d spec, Section 8.3.1.)
>
> Thus, we add an option to specify devices in the following format:
>
> path:[<domain>:]<bus>:<slot>.<func>/<slot>.<func>[/ ...]
>
> The path can be any segment within the PCI hierarchy of any length and
> determined through the use of 'lspci -t'. When specified this way, it is
> less likely that a renumbered bus will result in a valid device specifica=
tion
> and the tweak won't be applied to the wrong device.
>
> Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
> Reviewed-by: Stephen Bates <sbates@raithlin.com>
> Acked-by: Christian K=C3=B6nig <christian.koenig@amd.com>

> -                               specified in one of two formats:
> +                               specified in one of three formats:

...in one of the following formats:

in the first place and don't fix it each time you add/remove one?


--=20
With Best Regards,
Andy Shevchenko
