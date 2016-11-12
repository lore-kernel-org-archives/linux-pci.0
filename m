Return-Path: <dhdang@apm.com>
Return-Path: <dhdang@apm.com>
MIME-Version: 1.0
From: Duc Dang <dhdang@apm.com>
Date: Fri, 11 Nov 2016 18:38:40 -0800
Message-ID: <CADaLNDmq_RY89=FUkM7q98ukUq5_zOn8iAF70Jm_U-4RwtDc1Q@mail.gmail.com>
Subject: PCI: aer: AER correctable status register may be cleared before the
 aer_isr workqueue inspects it
To: Bjorn Helgaas <helgaas@kernel.org>, linux-pci@vger.kernel.org
Cc: patches <patches@apm.com>
Content-Type: multipart/alternative; boundary=001a114edca0f23f5e05411182a3
List-ID: <linux-pci.vger.kernel.org>

--001a114edca0f23f5e05411182a3
Content-Type: text/plain; charset=UTF-8

Hi Bjorn and All,

I ran into this error message when testing with my X-Gene Mustang board (on
kernel 4.9-rc1):
pcieport 0002:00:00.0: AER: Corrected error received: id=0000
pcieport 0002:00:00.0: can't find device of ID0000

Looking into aer_isr() code, in case of handling correctable AER event,
handle_error_source() will be called and it will clear Correctable Error
Status Register of the device that reports AER event. This operation may
end up clearing the status bit of the new (and same type) correctable AER
event that happen when this aer_isr worker thread is still running; and
cause the next aer_isr worker thread find no error status bit get set, so
it prints out the above warning messages.

I can see a possible solution is we cache all AER status registers of both
the root port and all of its end-point devices inside interrupt handler
(aer_irq) and pass these information to the aer_isr worker thread. But it
seems an expensive operation to be done in interrupt context and I am not
sure if you've already encountered and thought about this issue before?

Regards,
Duc Dang.

--001a114edca0f23f5e05411182a3
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div><div>Hi Bjorn and All,<br><br></div><div>I ran into t=
his error message when testing with my X-Gene Mustang board (on kernel 4.9-=
rc1):<br><span style=3D"font-family:monospace,monospace">pcieport 0002:00:0=
0.0: AER: Corrected error received: id=3D0000<br></span></div><div><span st=
yle=3D"font-family:monospace,monospace">pcieport 0002:00:00.0: can&#39;t fi=
nd device of ID0000<br><br></span></div><div>Looking into aer_isr() code, i=
n case of handling correctable AER event, handle_error_source() will be cal=
led and it will clear Correctable Error Status Register of the device that =
reports AER event. This operation may end up clearing the status bit of the=
 new (and same type) correctable AER event that happen when this aer_isr wo=
rker thread is still running; and cause the next aer_isr worker thread find=
 no error status bit get set, so it prints out the above warning messages.<=
br></div><br><div>I can see a possible solution is we cache all AER status =
registers of both the root port and all of its end-point devices inside int=
errupt handler (aer_irq) and pass these information to the aer_isr worker t=
hread. But it seems an expensive operation to be done in interrupt context =
and I am not sure if you&#39;ve already encountered and thought about this =
issue before?<br></div><div><br></div>Regards,<br></div>Duc Dang.<br></div>

--001a114edca0f23f5e05411182a3--
