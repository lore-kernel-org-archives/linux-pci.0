Return-Path: <linux-kernel-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20150618161207.32739.62577.stgit@bhelgaas-glaptop2.roam.corp.google.com>
References: <20150618161207.32739.62577.stgit@bhelgaas-glaptop2.roam.corp.google.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Thu, 18 Jun 2015 16:12:52 -0500
Message-ID: <CAErSpo55Ek+G3BxBMYBqsqFZRVR7ZrLboNW8bCJWZmnFw8JgLQ@mail.gmail.com>
Subject: Re: [PATCH 0/4] PCI: pciehp cleanup
To: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Cc: Rajat Jain <rajatja@google.com>, Yinghai Lu <yinghai@kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Jun 18, 2015 at 11:12 AM, Bjorn Helgaas <bhelgaas@google.com> wrote:
> These patches don't *do* anything except get rid of some overly verbose
> debug logging and a bunch of boilerplate code by inlining trivial things.
>
> Unless I made a mistake, this should not change the way anything works at
> all, although I did change some of the message text.
>
> ---
>
> Bjorn Helgaas (4):
>       PCI: pciehp: Clean up debug logging
>       PCI: pciehp: Make queue_interrupt_event() void
>       PCI: pciehp: Rename queue_interrupt_event() to pciehp_queue_interrupt_event()
>       PCI: pciehp: Inline the "handle event" functions into the ISR
>
>
>  drivers/pci/hotplug/pciehp.h      |    6 -
>  drivers/pci/hotplug/pciehp_core.c |   37 +--------
>  drivers/pci/hotplug/pciehp_ctrl.c |  154 +++----------------------------------
>  drivers/pci/hotplug/pciehp_hpc.c  |   89 +++++++++------------
>  4 files changed, 53 insertions(+), 233 deletions(-)

I applied these to pci/hotplug for v4.2 with acks/reviewed-by from
Rajat and Yinghai.  Thanks for taking a look!

Bjorn
