Return-Path: <SRS0=mAxC=H7=gmail.com=tom.leiming@kernel.org>
Return-Path: <SRS0=mAxC=H7=gmail.com=tom.leiming@kernel.org>
MIME-Version: 1.0
In-Reply-To: <20180511165752.GG190385@bhelgaas-glaptop.roam.corp.google.com>
References: <CAObL_7G5k7XNqXqDZASChiQd1mt+AJPAdNKz-DE+xQawhUy6ZA@mail.gmail.com>
 <20180511165752.GG190385@bhelgaas-glaptop.roam.corp.google.com>
From: Ming Lei <tom.leiming@gmail.com>
Date: Sat, 12 May 2018 10:38:05 +0800
Message-ID: <CACVXFVOieYJ3EJDNydoWWX91n7o8RT7UXvTfo0ExEPLsit9mxg@mail.gmail.com>
Subject: Re: Another NVMe failure, this time with AER info
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Andrew Lutomirski <amluto@gmail.com>, Jesse Vincent <jesse@fsck.com>, Sagi Grimberg <sagi@grimberg.me>,
	linux-pci@vger.kernel.org,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-nvme <linux-nvme@lists.infradead.org>,
	Jens Axboe <axboe@fb.com>, Bjorn Helgaas <bhelgaas@google.com>, Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-pci.vger.kernel.org>

On Sat, May 12, 2018 at 12:57 AM, Bjorn Helgaas <helgaas@kernel.org> wrote:
> Andrew wrote:
>> A friend of mine has a brand new LG laptop that has intermittent NVMe
>> failures.  They mostly happen during a suspend/resume cycle
>> (apparently during suspend, not resume).  Unlike the earlier
>> Dell/Samsung issue, the NVMe device isn't completely gone -- MMIO
>> reads fail, but PCI configuration space is apparently still there:
>
>> nvme nvme0: controller is down; will reset: CSTS=0xffffffff, PCI_STATUS=0x10
>
>> and it comes with a nice AER dump:
>
>> [12720.894411] pcieport 0000:00:1c.0: AER: Multiple Corrected error received: id=00e0
>> [12720.909747] pcieport 0000:00:1c.0: PCIe Bus Error: severity=Corrected, type=Physical Layer, id=00e0(Transmitter ID)
>> [12720.909751] pcieport 0000:00:1c.0:   device [8086:9d14] error status/mask=00001001/00002000
>> [12720.909754] pcieport 0000:00:1c.0:    [ 0] Receiver Error         (First)
>> [12720.909756] pcieport 0000:00:1c.0:    [12] Replay Timer Timeout
>
> I opened this bugzilla and attached the dmesg and lspci -vv output to
> it: https://bugzilla.kernel.org/show_bug.cgi?id=199695
>
> The root port at 00:1c.0 leads to the NVMe device at 01:00.0 (this is
> nvme0):
>
>   00:1c.0 PCI bridge: Intel Corporation Sunrise Point-LP PCI Express Root Port #5 (rev f1) (prog-if 00 [Normal decode])
>         Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
>   01:00.0 Non-Volatile memory controller: Samsung Electronics Co Ltd NVMe SSD Controller SM961/PM961 (prog-if 02 [NVM Express])
>         Subsystem: Samsung Electronics Co Ltd Device a801
>
> We reported several corrected errors before the nvme timeout:
>
>   [12750.281158] nvme nvme0: controller is down; will reset: CSTS=0xffffffff, PCI_STATUS=0x10
>   [12750.297594] nvme nvme0: I/O 455 QID 2 timeout, disable controller
>   [12750.305196] nvme 0000:01:00.0: enabling device (0000 -> 0002)
>   [12750.305465] nvme nvme0: Removing after probe failure status: -19
>   [12750.313188] nvme nvme0: I/O 456 QID 2 timeout, disable controller
>   [12750.329152] nvme nvme0: I/O 457 QID 2 timeout, disable controller
>
> The corrected errors are supposedly recovered in hardware without
> software intervention, and AER logs them for informational purposes.
>
> But it seems very likely that these corrected errors are related to
> the nvme timeout: the first corrected errors were logged at
> 12720.894411, nvme_io_timeout defaults to 30 seconds, and the nvme
> timeout was at 12750.281158.

The following patchset might help this issue:

https://marc.info/?l=linux-block&m=152604179903505&w=2

--
Ming Lei
