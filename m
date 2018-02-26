Return-Path: <SRS0=BsMt=FU=xilinx.com=bharatku@kernel.org>
Return-Path: <SRS0=BsMt=FU=xilinx.com=bharatku@kernel.org>
To: <linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>
CC: <helgaas@kernel.org>
From: Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>
Subject: Multi MSI with multiple End Points
Message-ID: <d1cdbe97-8ed4-c4d5-0b1f-8d281b44871d@xilinx.com>
Date: Mon, 26 Feb 2018 19:40:28 +0530
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
List-ID: <linux-pci.vger.kernel.org>

Hi,

A switch is connected to an RC with 2 EP=E2=80=99s, the RC supports multi M=
SI.
1st EP requests one MSI vector, 2nd EP requests 4 MSI vectors.

If we are programming hwirq as MSI data (hwirq being obtained from
bitmap_find_next_zero_area, with number of zeroed bits being requested
based on number of irq=E2=80=99s being requested).

This results in 1st EP is given zero as hwirq, 2nd EP is given one as hwirq=
.

If we use msi data to retrieve virq (use msi data as hwirq), Since as
per PCI spec lower 2 bits of MSI data are modifiable  for 2nd EP, if an
interrupt is raised by 2nd EP on msi data zero, but this is already used
by 1st EP, so the current EP=E2=80=99s interrupt will never be served.

One way to deal with this issue is, using bit shift operations on hwriq
before programming to msi data and at retrieving.

Is there any other way to handle this ?

Regards,
Bharat
This email and any attachments are intended for the sole use of the named r=
ecipient(s) and contain(s) confidential information that may be proprietary=
, privileged or copyrighted under applicable law. If you are not the intend=
ed recipient, do not read, copy, or forward this email message or any attac=
hments. Delete this email message and any attachments immediately.
