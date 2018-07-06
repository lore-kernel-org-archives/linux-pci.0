Return-Path: <SRS0=QR5v=JW=h08.hostsharing.net=foo00@kernel.org>
Return-Path: <SRS0=QR5v=JW=h08.hostsharing.net=foo00@kernel.org>
Date: Fri, 6 Jul 2018 10:36:03 +0200
From: Lukas Wunner <lukas@wunner.de>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Pingfan Liu <kernelfans@gmail.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Grygorii Strashko <grygorii.strashko@ti.com>,
	Christoph Hellwig <hch@infradead.org>,
	Bjorn Helgaas <helgaas@kernel.org>, Dave Young <dyoung@redhat.com>,
	Linux PCI <linux-pci@vger.kernel.org>,
	linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
	Linux PM <linux-pm@vger.kernel.org>,
	Kishon Vijay Abraham I <kishon@ti.com>
Subject: Re: [PATCHv3 0/4] drivers/base: bugfix for supplier<-consumer
 ordering in device_kset
Message-ID: <20180706083603.GA9063@wunner.de>
References: <1530600642-25090-1-git-send-email-kernelfans@gmail.com>
 <4685360.VNmeYLh0dQ@aspire.rjw.lan>
 <CAFgQCTusBM0-E=wAJgRJA7g-RnDi9ts==-M7KezNBwSWnyO=HA@mail.gmail.com>
 <6281446.GoJLz6Hq6C@aspire.rjw.lan>
 <CAFgQCTt7VfqM=UyCnvNFxrSw8Z6cUtAi3HUwR4_xPAc03SgHjQ@mail.gmail.com>
 <CAJZ5v0jo5-z0ZYDzdNPpn54+oAxpdG_=EvVDdz-HKxp7psu-EA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAJZ5v0jo5-z0ZYDzdNPpn54+oAxpdG_=EvVDdz-HKxp7psu-EA@mail.gmail.com>
List-ID: <linux-pci.vger.kernel.org>

[cc += Kishon Vijay Abraham]

On Thu, Jul 05, 2018 at 11:18:28AM +0200, Rafael J. Wysocki wrote:
> OK, so calling devices_kset_move_last() from really_probe() clearly is
> a mistake.
> 
> I'm not really sure what the intention of it was as the changelog of
> commit 52cdbdd49853d doesn't really explain that (why would it be
> insufficient without that change?)

It seems 52cdbdd49853d fixed an issue with boards which have an MMC
whose reset pin needs to be driven high on shutdown, lest the MMC
won't be found on the next boot.

The boards' devicetrees use a kludge wherein the reset pin is modelled
as a regulator.  The regulator is enabled when the MMC probes and
disabled on driver unbind and shutdown.  As a result, the pin is driven
low on shutdown and the MMC is not found on the next boot.

To fix this, another kludge was invented wherein the GPIO expander
driving the reset pin unconditionally drives all its pins high on
shutdown, see pcf857x_shutdown() in drivers/gpio/gpio-pcf857x.c
(commit adc284755055, "gpio: pcf857x: restore the initial line state
of all pcf lines").

For this kludge to work, the GPIO expander's ->shutdown hook needs to
be executed after the MMC expander's ->shutdown hook.

Commit 52cdbdd49853d achieved that by reordering devices_kset according
to the probe order.  Apparently the MMC probes after the GPIO expander,
possibly because it returns -EPROBE_DEFER if the vmmc regulator isn't
available yet, see mmc_regulator_get_supply().

Note, I'm just piecing the information together from git history,
I'm not responsible for these kludges.  (I'm innocent!)

@Pingfan Liu, if you just remove the call to devices_kset_move_last()
from really_probe(), does the issue go away?

If so, it might be best to remove that call and model the dependency
with a call to device_link_add() in mmc_regulator_get_supply().
Another idea would be to automatically add a device_link in the
driver core if -EPROBE_DEFER is returned.

Thanks,

Lukas
