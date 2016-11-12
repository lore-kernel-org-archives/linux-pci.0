Return-Path: <dhdang@apm.com>
Return-Path: <dhdang@apm.com>
MIME-Version: 1.0
From: Duc Dang <dhdang@apm.com>
Date: Fri, 11 Nov 2016 18:49:55 -0800
Message-ID: <CADaLNDmr6ttvsTnPQG3ixDrJgw4e3LeQp3bTwuuTPd1xbusN=g@mail.gmail.com>
Subject: PCI: aer: AER correctable status register may be cleared before the
 aer_isr workqueue inspects it
To: Bjorn Helgaas <bhelgaas@google.com>, Bjorn Helgaas <helgaas@kernel.org>, linux-pci@vger.kernel.org
Cc: patches <patches@apm.com>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-pci.vger.kernel.org>

[resend in text mode]

Hi Bjorn and All,

I ran into this error message when testing with my X-Gene Mustang
board (on kernel 4.9-rc1):
pcieport 0002:00:00.0: AER: Corrected error received: id=0000
pcieport 0002:00:00.0: can't find device of ID0000

Looking into aer_isr() code, in case of handling correctable AER
event, handle_error_source() will be called and it will clear
Correctable Error Status Register of the device that reports AER
event. This operation may end up clearing the status bit of the new
(and same type) correctable AER event that happen when this aer_isr
worker thread is still running; and cause the next aer_isr worker
thread find no error status bit get set, so it prints out the above
warning messages.

I can see a possible solution is we cache all AER status registers of
both the root port and all of its end-point devices inside interrupt
handler (aer_irq) and pass these information to the aer_isr worker
thread. But it seems an expensive operation to be done in interrupt
context and I am not sure if you've already encountered and thought
about this issue before?

Regards,
Duc Dang.
