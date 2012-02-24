Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ww0-f44.google.com ([74.125.82.44]:35404 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753876Ab2BXVlD convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 24 Feb 2012 16:41:03 -0500
Received: by wgbdr13 with SMTP id dr13so100167wgb.1
        for <linux-pci@vger.kernel.org>; Fri, 24 Feb 2012 13:41:01 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <CAErSpo7Qh8_3m1TNG-mGEYnPrGbM9Saiv-fk+OjnCFYKDJ=qRQ@mail.gmail.com>
References: <CAErSpo67Y4xtctJ=a8LQLqopRyM9_3gYKwFSUw8kT6XEVsPZzA@mail.gmail.com>
 <CAE9FiQWjNW8W+TROU1HOdaDS_Ccii+fyDj7GidsOqF2h56R21g@mail.gmail.com> <CAErSpo7Qh8_3m1TNG-mGEYnPrGbM9Saiv-fk+OjnCFYKDJ=qRQ@mail.gmail.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Fri, 24 Feb 2012 14:40:41 -0700
Message-ID: <CAErSpo49Pc6rYuGdKOsA0fchYNqwGZhXSqH1feJYQVBEj230wA@mail.gmail.com>
Subject: Re: pci_probe_only and bus_to_resources patches rebased to pci
 linux-next branch
To: Yinghai Lu <yinghai@kernel.org>
Cc: Jesse Barnes <jbarnes@virtuousgeek.org>, linux-pci@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Feb 24, 2012 at 10:38 AM, Bjorn Helgaas <bhelgaas@google.com> wrote:
> On Thu, Feb 23, 2012 at 9:23 PM, Yinghai Lu <yinghai@kernel.org> wrote:
>> On Thu, Feb 23, 2012 at 9:04 PM, Bjorn Helgaas <bhelgaas@google.com> wrote:
>>> Hi Jesse,
>>>
>>> I rebased these series:
>>
>>>    v2 add PCI bus-to-resource offset support in core
>>>    (http://marc.info/?l=linux-pci&m=132884138928641&w=2)
>>
>> did you solve concerns that i raised?
>> 1. two lists that one for host bridge and one for root buses

I looked at all the uses of the pci_root_buses list, and I think
almost all of them should be removed by restructuring the code.

alpha, frv, microblaze, mn10300, powerpc, and x86 use pci_root_buses
to find all PCI devices, call pci_claim_resource(), and do some
resource allocation.  x86 is fairly typical:

    pci_subsys_init (subsys_initcall)
      pcibios_init
        pcibios_resource_survey
          pcibios_allocate_bus_resources(&pci_root_buses)
            list_for_each_entry(each root bus):
              for_each_bridge_window:
                pci_claim_resource
              pcibios_allocate_bus_resources(&bus->children)
          pcibios_allocate_resources(0)
          pcibios_allocate_resources(1)

I think this is a broken model.  We only call
pcibios_resource_survey() at boot-time, so hotplug devices are treated
differently, which is a problem.  Some architectures use
pci_claim_resource() in a different path, or not at all.  That's
another problem.  None of this stuff is really architecture-dependent,
so having a half-dozen separate implementations is adding complexity
and inconsistencies without any benefit.

In addition to the uses in pcibios_resource_survey(), pci_root_buses
is also used by some ARM PCI IRQ handlers, a powerpc syscall
(sys_pciconfig_iobase()) and DRM (on alpha only).  I suspect these
uses could be removed by keeping a little more architecture-specific
state.

There are also a few uses in the PCI core, but again, these are mostly
in resource allocation paths that I think are not correctly designed.
PCI resource allocation is not a system-wide problem.  It's at most a
per-host bridge problem.  We should not be iterating over all PCI root
buses; rather, we should be doing a piece of the allocation every time
we scan below a host bridge.

I don't want to trivialize the work here.  Restructuring this is a
large amount of work.  But I think it's good to have some idea of
where things should go.

I *could* trivially remove the pci_root_buses usages by converting
them all to iterators over the pci_host_bridges list.  But I don't
really want to do that because it polishes code that I think should be
removed completely, and it would require exporting pci_host_bridges
outside the PCI core, where I don't think it should go.

Bjorn
