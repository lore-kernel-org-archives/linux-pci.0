Return-Path: <linux-arch-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20120131114250.b0e6af10.yuasa@linux-mips.org>
References: <20120130165430.3231.97740.stgit@bhelgaas.mtv.corp.google.com>
 <20120130165805.3231.99160.stgit@bhelgaas.mtv.corp.google.com> <20120131114250.b0e6af10.yuasa@linux-mips.org>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Mon, 30 Jan 2012 19:54:35 -0800
Message-ID: <CAErSpo7xUL++rqnJug7=Wd_nfvaUDOewGjz1C2Fp-oQrkxO2yg@mail.gmail.com>
Subject: Re: [RFC PATCH v1 11/18] mips/PCI: get rid of device resource fixups
To: Yoichi Yuasa <yuasa@linux-mips.org>
Cc: linux-pci@vger.kernel.org, linux-arch@vger.kernel.org,
	Ralf Baechle <ralf@linux-mips.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Jan 30, 2012 at 6:42 PM, Yoichi Yuasa <yuasa@linux-mips.org> wrote:
> Hi,
>
> On Mon, 30 Jan 2012 09:58:05 -0700
> Bjorn Helgaas <bhelgaas@google.com> wrote:
>
>> Tell the PCI core about host bridge address translation so it can take
>> care of bus-to-resource conversion for us.
>>
>> N.B. cobalt_legacy_ide_fixup() does scary things with resources, but I
>> *think* it will still work because we're still making the same adjustments,
>> just in the opposite order.  Here are the legacy IDE resource.start
>> values I expect:
>>
>>          current                                        new
>>
>>            0x1f0   (pci_setup_device)                 0x1f0
>>                    (pci_bus_to_resource)       + 0xf0000000
>>     - 0xf0000000   (cobalt_legacy_ide_fixup)   - 0xf0000000
>>     + 0xf0000000   (pcibios_fixup_bus)
>>     ------------                               ------------
>>            0x1f0    final value                       0x1f0
>
> It seems to be unable to handle the offset correctly.
>
> failed on Cobalt:
>
> pata_via 0000:00:09.1: BAR 0: can't reserve [io  0x100001f0-0x100001f7]
> pata_via 0000:00:09.1: failed to request/iomap BARs for port 0 (errno=-16)
> pata_via 0000:00:09.1: BAR 2: can't reserve [io  0x10000170-0x10000177]
> pata_via 0000:00:09.1: failed to request/iomap BARs for port 1 (errno=-16)
> pata_via 0000:00:09.1: no available native port

Thank you very much for testing this.  Could you collect the complete
dmesg and /proc/ioport contents, before and after my patches?

Bjorn
