Return-Path: <linux-kernel-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <56A32702.7080909@mcc.vniiem.ru>
References: <56A32702.7080909@mcc.vniiem.ru>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Sat, 23 Jan 2016 08:54:08 -0600
Message-ID: <CAErSpo6MtFSxnH8uSqeLiJVR3P-R5DUX2Furw3yw8JiMN29H0A@mail.gmail.com>
Subject: Re: PCI device driver broken between 4.2 and 4.3
To: =?UTF-8?B?0J7Qu9C10LMg0JzQvtGA0L7Qtw==?= <oleg.moroz@mcc.vniiem.ru>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

[+cc linux-kernel]

Hi Олег,

On Sat, Jan 23, 2016 at 1:08 AM, Олег Мороз <oleg.moroz@mcc.vniiem.ru> wrote:
> Hello. I've got a device driver for MIL-1553b card called TA1-PCI, which
> could be found at
> https://github.com/qmor/elcus-1553-driver-linux
> Card is using PLX_PCI9030 PCI controller.
> Today i've found that this driver compiles, installes, but is not working as
> it should.
> Looks like it not receives any interrupts from PCI. I've test it again with
> kernel
> 4.2 and it works okay. What changes was made in PCI subsystem from 4.2 to
> 4.3
> which could have impact this driver work.

Thank you very much for this problem report.  There were many PCI
changes between v4.2 and v4.3, and without more information, I can't
guess what might be causing this problem.

I opened a bug report at https://bugzilla.kernel.org/show_bug.cgi?id=111211

Please attach complete dmesg logs for both v4.2 and v4.3 to that bug
report.  Also, please attach the complete "lspci -vv" output (as
root).

Thanks!

Bjorn
