Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from ale.deltatee.com ([207.54.116.67]:34772 "EHLO ale.deltatee.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933092AbcLSR05 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 19 Dec 2016 12:26:57 -0500
To: Keith Busch <keith.busch@intel.com>
References: <1481994562-9283-1-git-send-email-logang@deltatee.com>
 <CAL-B5D3g=ZWRg7Qh8_KumJkdg6F2+2a8=HCz2US7a4g2tKC0Lw@mail.gmail.com>
 <735068a7-7805-dad0-b5b0-5218a18f335c@deltatee.com>
 <20161219172903.GB1043@localhost.localdomain>
Cc: Myron Stowe <myron.stowe@gmail.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Jonathan Corbet <corbet@lwn.net>,
        "David S. Miller" <davem@davemloft.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Emil Velikov <emil.l.velikov@gmail.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Kurt Schwemmer <kurt.schwemmer@microsemi.com>,
        Stephen Bates <stephen.bates@microsemi.com>,
        linux-pci <linux-pci@vger.kernel.org>, linux-doc@vger.kernel.org,
        linux-nvme@lists.infradead.org, LKML <linux-kernel@vger.kernel.org>
From: Logan Gunthorpe <logang@deltatee.com>
Message-ID: <7a537ea0-afb1-48d5-0706-5066dfaef1dd@deltatee.com>
Date: Mon, 19 Dec 2016 10:26:50 -0700
MIME-Version: 1.0
In-Reply-To: <20161219172903.GB1043@localhost.localdomain>
Content-Type: text/plain; charset=windows-1252
Subject: Re: [RFC 0/1] New PCI Switch Management Driver
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>



On 19/12/16 10:29 AM, Keith Busch wrote:
> Since the in-kernel driver binds to the device, won't this driver
> conflict with the initialization the in-kernel one already does? Bus
> master, MSI setup, etc?

No. The management interface is on a completely separate PCI endpoint.
So from the kernels perspective, the management interface is just
another PCI device. It has the same vendor and device ID as the switch
but uses separate class codes so it can be bound by an independent driver.

> Could you also provide the reasoning against making the functionality
> this driver provides in user space?

I'm not sure how you mean. I suppose we could write a UIO driver but
that seemed like an ugly solution to me and doesn't seem like an
approach the community prefers. We do have to make use of interrupts so
simply using /sys/bus/pci/.../resourceN wouldn't work either.

Logan
