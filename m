Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:5488 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753381AbbFCULD (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Wed, 3 Jun 2015 16:11:03 -0400
Date: Wed, 3 Jun 2015 20:10:54 +0000 (UTC)
From: Keith Busch <keith.busch@intel.com>
To: Keith Busch <keith.busch@intel.com>,
	Bjorn Helgaas <bhelgaas@google.com>
cc: Pavilion Storage <storagepavilion@gmail.com>,
	linux-nvme@lists.infradead.org, linux-pci@vger.kernel.org
Subject: Re: Problems writing to intel P3700 NVMe drive
In-Reply-To: <alpine.LNX.2.00.1505282059400.15930@localhost.lm.intel.com>
Message-ID: <alpine.LNX.2.00.1506032000570.15930@localhost.lm.intel.com>
References: <CAFMq3wEyk9PMbD8Cgn5trJyDjaOKpMzR-TNzbx0zXN=Mms573Q@mail.gmail.com> <00c601d098cd$41255e30$c3701a90$@storageio.com> <CAFMq3wE7PzKs=dYxxUhFsHeTkR0CT8mh6NVfrk-9mKxdisoDTg@mail.gmail.com> <00cd01d098d1$94047010$bc0d5030$@storageio.com>
 <CAFMq3wEa=kxznE77oFdg03QBHqszmH5-Vvmmm9pW1nkPUZi_Og@mail.gmail.com> <CA+At7pWf6Ge3pc7=aeiqz=iWxtYJSPVdM_W2XW9pL4d22q432Q@mail.gmail.com> <000a01d098ee$b52ce0c0$1f86a240$@storageio.com> <CAFMq3wH67yMqWGcde77kiyWJ6_ieZjVyhc8L-oq1e_b4x5mS7w@mail.gmail.com>
 <alpine.LNX.2.00.1505282059400.15930@localhost.lm.intel.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

+cc the pci list

Hi Bjorn,

A while back, there were a few proposals on changing the pci driver's
default MPS tuning from the existing do-nothing policy to something
safe so end-users don't need to remember kernel parameters as described
below. Is this still active, or can we kick that back to life if not?

Thanks,
Keith

On Thu, 28 May 2015, Keith Busch wrote:
> Perhaps not a desirable/permanent solution, but for everyone's benefit,
> we can work-around the problem with kernel parameter:
>
>  pci=pcie_bus_safe
>
> Using 'pcie_bus_perf' instead may also work, though your original
> solution of just using x86 sounded perfectly reasonable to me. :)
>
> On Thu, 28 May 2015, Pavilion Storage wrote:
>> Thanks to Keith Busch for the providing the clues.
>> The problem was that the PCIe MPSS on the drive and the CPU root
>> complex did not match and that caused a problem. Setting it to a
>> common value fixed the problem.
>> Kishore
