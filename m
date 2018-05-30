Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-it0-f49.google.com ([209.85.214.49]:51278 "EHLO
        mail-it0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932471AbeE3XdV (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 30 May 2018 19:33:21 -0400
Received: by mail-it0-f49.google.com with SMTP id d10-v6so25365017itj.1
        for <linux-pci@vger.kernel.org>; Wed, 30 May 2018 16:33:21 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180525232009.GV11037@localhost.localdomain>
References: <CAKDfzeD5_AV=YtWqTPr=40vvW4oMFAs4gJs_r42PJWcb815zyQ@mail.gmail.com>
 <20180507123035.GA20097@gmail.com> <20180525232009.GV11037@localhost.localdomain>
From: Bryan Gurney <bgurney@redhat.com>
Date: Wed, 30 May 2018 19:33:20 -0400
Message-ID: <CAHhmqcQmyLRJqh=A3kni181cpX+CXOHfvF1em6OBscPCZCihpQ@mail.gmail.com>
Subject: Re: PCIe unsupported request with Intel 760p
To: Keith Busch <keith.busch@linux.intel.com>
Cc: Aron Griffis <aron@arongriffis.com>, linux-pci@vger.kernel.org,
        willy@infradead.org, linux-nvme@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, May 25, 2018 at 7:20 PM, Keith Busch
<keith.busch@linux.intel.com> wrote:
> On Mon, May 07, 2018 at 08:30:35AM -0400, Aron Griffis wrote:
>> (Reposting to fix line wrapping, and cc'ing linux-pci at Bjorn's request.)
>>
>> I'm getting this error continuously with an Intel 760p on 4.16.5 (Fedora 28)
>>
>> pcieport 0000:00:1d.0: AER: Uncorrected (Non-Fatal) error received: id=00e8
>> pcieport 0000:00:1d.0: PCIe Bus Error: severity=Uncorrected (Non-Fatal), type=Transaction Layer, id=00e8(Requester ID)
>> pcieport 0000:00:1d.0:   device [8086:a298] error status/mask=00100000/00010000
>> pcieport 0000:00:1d.0:    [20] Unsupported Request    (First)
>> pcieport 0000:00:1d.0:   TLP Header: 34000000 70000010 00000000 88468846
>> pcieport 0000:00:1d.0: broadcast error_detected message
>> pcieport 0000:00:1d.0: broadcast mmio_enabled message
>> pcieport 0000:00:1d.0: broadcast resume message
>> pcieport 0000:00:1d.0: AER: Device recovery successful
>>
>> Willy graciously decoded this for me to a "Latency Tolerance Reporting
>> Message," and suggested I send email to this list to check whether it's a
>> problem with the device or driver.
>>
>> lspci and full dmesg follow. Please let me know if something else would be
>> helpful.
>
> I have some information back from the development team to share. They
> believe this may be a hardware errata and are investigating a firmware
> side fix.
>
> In the meantime, they think there may be other ways to work around this,
> if these are acceptable. Specifically, disabling any non-operational
> link states may make this go away, and adding kernel parameter
> "pcie_aspm=off" should achieve that.

Hi Keith,

Sorry to chain off of this, but I remembered that I have an X99
chipset system with a couple of Intel 750 Series SSDs that were
outputting similar messages after I performed some writes to them.
The system's running CentOS 7.4 (kernel 3.10.0-693.11.6.el7.x86_64),
but I can install Fedora 28 for testing on a recent upstream kernel.

Here's a sample of the messages I see, along with the drive firmware
(which I'm guessing is not the latest; I believe I updated them at
some point), and the lspci output from the device IDs cited:

pcieport 0000:00:03.0: AER: Multiple Corrected error received: id=0018
pcieport 0000:00:03.0: PCIe Bus Error: severity=Corrected, type=Data
Link Layer, id=0018(Transmitter ID)
pcieport 0000:00:03.0:   device [8086:6f08] error status/mask=00001040/00002000
pcieport 0000:00:03.0:    [ 6] Bad TLP
pcieport 0000:00:03.0:    [12] Replay Timer Timeout
pcieport 0000:00:03.0:   Error of this Agent(0018) is reported first
nvme 0000:02:00.0: PCIe Bus Error: severity=Corrected, type=Physical
Layer, id=0200(Receiver ID)
nvme 0000:02:00.0:   device [8086:0953] error status/mask=000000c1/00002000
nvme 0000:02:00.0:    [ 0] Receiver Error         (First)
nvme 0000:02:00.0:    [ 6] Bad TLP
nvme 0000:02:00.0:    [ 7] Bad DLLP
pcieport 0000:00:03.0: AER: Multiple Corrected error received: id=0018
pcieport 0000:00:03.0: PCIe Bus Error: severity=Corrected, type=Data
Link Layer, id=0018(Receiver ID)
pcieport 0000:00:03.0:   device [8086:6f08] error status/mask=00000040/00002000
pcieport 0000:00:03.0:    [ 6] Bad TLP
pcieport 0000:00:03.0:   Error of this Agent(0018) is reported first
nvme 0000:02:00.0: PCIe Bus Error: severity=Corrected, type=Physical
Layer, id=0200(Receiver ID)
nvme 0000:02:00.0:   device [8086:0953] error status/mask=00000001/00002000
nvme 0000:02:00.0:    [ 0] Receiver Error
pcieport 0000:00:02.0: AER: Corrected error received: id=0010
pcieport 0000:00:02.0: PCIe Bus Error: severity=Corrected, type=Data
Link Layer, id=0010(Receiver ID)
pcieport 0000:00:02.0:   device [8086:6f04] error status/mask=00000040/00002000
pcieport 0000:00:02.0:    [ 6] Bad TLP
pcieport 0000:00:02.0: AER: Corrected error received: id=0010
pcieport 0000:00:02.0: PCIe Bus Error: severity=Corrected, type=Data
Link Layer, id=0010(Receiver ID)
pcieport 0000:00:02.0:   device [8086:6f04] error status/mask=00000040/00002000
pcieport 0000:00:02.0:    [ 6] Bad TLP
pcieport 0000:00:02.0: AER: Corrected error received: id=0010
pcieport 0000:00:02.0: PCIe Bus Error: severity=Corrected, type=Data
Link Layer, id=0010(Receiver ID)
pcieport 0000:00:02.0:   device [8086:6f04] error status/mask=00000040/00002000
pcieport 0000:00:02.0:    [ 6] Bad TLP
pcieport 0000:00:02.0: AER: Corrected error received: id=0010
pcieport 0000:00:02.0: PCIe Bus Error: severity=Corrected, type=Data
Link Layer, id=0010(Receiver ID)
pcieport 0000:00:02.0:   device [8086:6f04] error status/mask=00000040/00002000
pcieport 0000:00:02.0:    [ 6] Bad TLP

lrwxrwxrwx. 1 root root 0 May 30 18:57 nvme0n1 ->
../devices/pci0000:00/0000:00:02.0/0000:03:00.0/nvme/nvme0/nvme0n1
lrwxrwxrwx. 1 root root 0 May 30 18:57 nvme1n1 ->
../devices/pci0000:00/0000:00:03.0/0000:02:00.0/nvme/nvme1/nvme1n1

/sys/block/nvme0n1/device/firmware_rev:8EV10174
/sys/block/nvme0n1/device/model:INTEL SSDPEDMW400G4

/sys/block/nvme1n1/device/firmware_rev:8EV10174
/sys/block/nvme1n1/device/model:INTEL SSDPEDMW400G4

00:03.0 PCI bridge: Intel Corporation Xeon E7 v4/Xeon E5 v4/Xeon E3
v4/Xeon D PCI Express Root Port 3 (rev 01)
00:02.0 PCI bridge: Intel Corporation Xeon E7 v4/Xeon E5 v4/Xeon E3
v4/Xeon D PCI Express Root Port 2 (rev 01)
02:00.0 Non-Volatile memory controller: Intel Corporation PCIe Data
Center SSD (rev 01)
03:00.0 Non-Volatile memory controller: Intel Corporation PCIe Data
Center SSD (rev 01)


Thanks,

Bryan
