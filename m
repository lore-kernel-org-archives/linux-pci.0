Return-Path: <SRS0=vrGS=JT=rjwysocki.net=rjw@kernel.org>
Return-Path: <SRS0=vrGS=JT=rjwysocki.net=rjw@kernel.org>
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Pingfan Liu <kernelfans@gmail.com>
Cc: linux-kernel@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Grygorii Strashko <grygorii.strashko@ti.com>, Christoph Hellwig <hch@infradead.org>, Bjorn Helgaas <helgaas@kernel.org>, Dave Young <dyoung@redhat.com>, linux-pci@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCHv3 0/4] drivers/base: bugfix for supplier<-consumer ordering in device_kset
Date: Tue, 03 Jul 2018 16:35:05 +0200
Message-ID: <4685360.VNmeYLh0dQ@aspire.rjw.lan>
In-Reply-To: <1530600642-25090-1-git-send-email-kernelfans@gmail.com>
References: <1530600642-25090-1-git-send-email-kernelfans@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
List-ID: <linux-pci.vger.kernel.org>

On Tuesday, July 3, 2018 8:50:38 AM CEST Pingfan Liu wrote:
> commit 52cdbdd49853 ("driver core: correct device's shutdown order")
> places an assumption of supplier<-consumer order on the process of probe.
> But it turns out to break down the parent <- child order in some scene.
> E.g in pci, a bridge is enabled by pci core, and behind it, the devices
> have been probed. Then comes the bridge's module, which enables extra
> feature(such as hotplug) on this bridge.

So what *exactly* does happen in that case?
