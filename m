Return-Path: <SRS0=WgwQ=JU=gmail.com=kernelfans@kernel.org>
Return-Path: <SRS0=WgwQ=JU=gmail.com=kernelfans@kernel.org>
MIME-Version: 1.0
References: <1530600642-25090-1-git-send-email-kernelfans@gmail.com> <4685360.VNmeYLh0dQ@aspire.rjw.lan>
In-Reply-To: <4685360.VNmeYLh0dQ@aspire.rjw.lan>
From: Pingfan Liu <kernelfans@gmail.com>
Date: Wed, 4 Jul 2018 10:47:07 +0800
Message-ID: <CAFgQCTusBM0-E=wAJgRJA7g-RnDi9ts==-M7KezNBwSWnyO=HA@mail.gmail.com>
Subject: Re: [PATCHv3 0/4] drivers/base: bugfix for supplier<-consumer
 ordering in device_kset
To: rjw@rjwysocki.net
Cc: linux-kernel@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Grygorii Strashko <grygorii.strashko@ti.com>,
	Christoph Hellwig <hch@infradead.org>, Bjorn Helgaas <helgaas@kernel.org>, Dave Young <dyoung@redhat.com>,
	linux-pci@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-pci.vger.kernel.org>

On Tue, Jul 3, 2018 at 10:36 PM Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
>
> On Tuesday, July 3, 2018 8:50:38 AM CEST Pingfan Liu wrote:
> > commit 52cdbdd49853 ("driver core: correct device's shutdown order")
> > places an assumption of supplier<-consumer order on the process of probe.
> > But it turns out to break down the parent <- child order in some scene.
> > E.g in pci, a bridge is enabled by pci core, and behind it, the devices
> > have been probed. Then comes the bridge's module, which enables extra
> > feature(such as hotplug) on this bridge.
>
> So what *exactly* does happen in that case?
>
I saw the  shpc_probe() is called on the bridge, although the probing
failed on that bare-metal. But if it success, then it will enable the
hotplug feature on the bridge.

Thanks,
Pingfan
