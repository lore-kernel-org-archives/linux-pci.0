Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-qc0-f170.google.com ([209.85.216.170]:36389 "EHLO
	mail-qc0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755925AbbFCUVN (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 3 Jun 2015 16:21:13 -0400
Received: by qcxw10 with SMTP id w10so9476538qcx.3
        for <linux-pci@vger.kernel.org>; Wed, 03 Jun 2015 13:21:12 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <alpine.LNX.2.00.1506032000570.15930@localhost.lm.intel.com>
References: <CAFMq3wEyk9PMbD8Cgn5trJyDjaOKpMzR-TNzbx0zXN=Mms573Q@mail.gmail.com>
 <00c601d098cd$41255e30$c3701a90$@storageio.com> <CAFMq3wE7PzKs=dYxxUhFsHeTkR0CT8mh6NVfrk-9mKxdisoDTg@mail.gmail.com>
 <00cd01d098d1$94047010$bc0d5030$@storageio.com> <CAFMq3wEa=kxznE77oFdg03QBHqszmH5-Vvmmm9pW1nkPUZi_Og@mail.gmail.com>
 <CA+At7pWf6Ge3pc7=aeiqz=iWxtYJSPVdM_W2XW9pL4d22q432Q@mail.gmail.com>
 <000a01d098ee$b52ce0c0$1f86a240$@storageio.com> <CAFMq3wH67yMqWGcde77kiyWJ6_ieZjVyhc8L-oq1e_b4x5mS7w@mail.gmail.com>
 <alpine.LNX.2.00.1505282059400.15930@localhost.lm.intel.com> <alpine.LNX.2.00.1506032000570.15930@localhost.lm.intel.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Wed, 3 Jun 2015 15:20:51 -0500
Message-ID: <CAErSpo5HkLA8Yh0QeBPXL_64GaO+VcSugNHmCLR_UT+6mdM3JA@mail.gmail.com>
Subject: Re: Problems writing to intel P3700 NVMe drive
To: Keith Busch <keith.busch@intel.com>
Cc: Pavilion Storage <storagepavilion@gmail.com>,
	linux-nvme <linux-nvme@lists.infradead.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Jun 3, 2015 at 3:10 PM, Keith Busch <keith.busch@intel.com> wrote:
> +cc the pci list
>
> Hi Bjorn,
>
> A while back, there were a few proposals on changing the pci driver's
> default MPS tuning from the existing do-nothing policy to something
> safe so end-users don't need to remember kernel parameters as described
> below. Is this still active, or can we kick that back to life if not?

I'd love to see some activity there.  Somebody else asked me about
this a few weeks ago, and I sent him this list of some of the things I
think are wrong with the current situation:

- MPS configuration is done in pcie_bus_configure_settings().  This is
  not arch-specific, but it is done by arch code, and only arm,
  powerpc, tile, and x86 call it.

- MPS configuration should be done before a driver claims a device.
  This is currently wrong on arm.

- I would rather have MPS configuration done somewhere in the
  pci_scan_single_device() path.  That way it would be done on every
  arch and in every hotplug path.

- I know MPS depends on more than just the individual device and its
  upstream bridge, so it's not as simple as some other properties.
  But if we have a correctly-configured tree, we should be able to
  figure out what needs to change if we add one more device to it.

- I do not believe it is safe for drivers to manipulate MPS behind the
  back of the PCI core, so pcie_set_mps() should probably not be
  exported.

5f39e6705faa ("PCI: Disable MPS configuration by default") turned off
most the tuning we used to do.  I expect that if we turn it back on,
we'll trip over a few issues.  That in itself is not so much of a
problem, but before we turn things back on, I want to have better
infrastructure in place that makes it easier to diagnose and fix those
issues.  For example, I'd like to see just enough clues in dmesg to
enable us to see what the kernel's doing and verify that it's correct.
And I want it do be done cleanly on every arch for every device, with
hot-added ones being handled the same as those present at boot.

> On Thu, 28 May 2015, Keith Busch wrote:
>>
>> Perhaps not a desirable/permanent solution, but for everyone's benefit,
>> we can work-around the problem with kernel parameter:
>>
>>  pci=pcie_bus_safe
>>
>> Using 'pcie_bus_perf' instead may also work, though your original
>> solution of just using x86 sounded perfectly reasonable to me. :)
>>
>> On Thu, 28 May 2015, Pavilion Storage wrote:
>>>
>>> Thanks to Keith Busch for the providing the clues.
>>> The problem was that the PCIe MPSS on the drive and the CPU root
>>> complex did not match and that caused a problem. Setting it to a
>>> common value fixed the problem.
>>> Kishore
