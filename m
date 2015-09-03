Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pa0-f43.google.com ([209.85.220.43]:33112 "EHLO
	mail-pa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754008AbbICNcr (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 3 Sep 2015 09:32:47 -0400
Received: by pacex6 with SMTP id ex6so42291093pac.0
        for <linux-pci@vger.kernel.org>; Thu, 03 Sep 2015 06:32:46 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <55E7A90A.5080406@gmail.com>
References: <CAD8Lp44cpj0Z3aadOzW=Lc=m88AbQpaW3g=GCgtpvbpGATT7uw@mail.gmail.com>
	<CAErSpo6tMJYqiynS-+svvMB2mskMBrTpWNBxR7OLPSxGxKbBvw@mail.gmail.com>
	<55E7A90A.5080406@gmail.com>
Date: Thu, 3 Sep 2015 07:32:46 -0600
Message-ID: <CAD8Lp4534o9+=MSSt5Rf_9HgxpoNJdA=gRsFAG8w-U8Eh5Otng@mail.gmail.com>
Subject: Re: pcieport AER error spam on Intel Skylake
From: Daniel Drake <drake@endlessm.com>
To: Alexander Duyck <alexander.duyck@gmail.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Linux Kernel <linux-kernel@vger.kernel.org>,
	Carlo Caione <carlo@endlessm.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Sep 2, 2015 at 7:57 PM, Alexander Duyck
<alexander.duyck@gmail.com> wrote:
> Since it is correctable errors it is likely some sort of signalling issue.
> Could we get the output of something like an lspci -vt? Then you would be
> able to tell what the device is on the other side of the link from 00:1c.5
> and then we could probably check to see if there has been any changes for
> the device driver on the other end of the link.

"lspci -vt" reliably causes one occurance of the message, which is
logged by the kernel before lspci has written anything to stdout.
 pcieport 0000:00:1c.5: AER: Corrected error received: id=00e5
 pcieport 0000:00:1c.5: PCIe Bus Error: severity=Corrected,
type=Physical Layer, id=00e5(Receiver ID)
 pcieport 0000:00:1c.5:   device [8086:9d15] error status/mask=00000001/00002000
 pcieport 0000:00:1c.5:    [ 0] Receiver Error

-[0000:00]-+-00.0  Intel Corporation Device 1904
           +-02.0  Intel Corporation Device 1916
           +-04.0  Intel Corporation Device 1903
           +-08.0  Intel Corporation Device 1911
           +-14.0  Intel Corporation Device 9d2f
           +-14.2  Intel Corporation Device 9d31
           +-15.0  Intel Corporation Device 9d60
           +-15.1  Intel Corporation Device 9d61
           +-16.0  Intel Corporation Device 9d3a
           +-17.0  Intel Corporation Device 9d03
           +-1c.0-[01]--
           +-1c.4-[02]----00.0  Realtek Semiconductor Co., Ltd.
RTL8111/8168 PCI Express Gigabit Ethernet controller
           +-1c.5-[03]----00.0  Realtek Semiconductor Co., Ltd. Device b723
           +-1f.0  Intel Corporation Device 9d48
           +-1f.2  Intel Corporation Device 9d21
           +-1f.3  Intel Corporation Device 9d70
           \-1f.4  Intel Corporation Device 9d23

Does this mean these messages are somehow related to the Realtek b723
device? That is the wifi card.
Using x86_64_defconfig there is not even any driver loaded for this
device, yet the messages appear quite a bit.
If I use a full config with all the relevant drivers including
rtlwifi, the frequency of these messages goes up a lot though.

> My suspicion since this is a laptop is that something like a power
> management change might be responsible if this is a regression as I have
> seen messages like this pop up as a result of ASPM being enabled before.

It's likely not a regression, this is brand new hardware and this
message is seen on all kernels that we have tried (4.1, 4.2, master).
pcie_aspm=off also makes these messages go away.

Thanks
Daniel
