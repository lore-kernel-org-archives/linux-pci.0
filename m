Return-Path: <linux-acpi-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CAErSpo7nfYxAmP-kotxBEo20eCZtrWxUzTmk=74MsiJXXZaxBg@mail.gmail.com>
References: <20120918151215.59ea763b.izumi.taku@jp.fujitsu.com>
 <20120918152553.8c8390d8.izumi.taku@jp.fujitsu.com> <CAErSpo7hYHkFAgFy=q6ASV_15r-y_Cp=92nUdRAnBSGLi9ZMrA@mail.gmail.com>
 <CAErSpo5bTDWCoVbzP-zz_ZcbSL-QJg+eFwoJHQxvaeQAY5OG2A@mail.gmail.com>
 <20120928091520.92bf495b.izumi.taku@jp.fujitsu.com> <CAErSpo7nfYxAmP-kotxBEo20eCZtrWxUzTmk=74MsiJXXZaxBg@mail.gmail.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Fri, 28 Sep 2012 08:16:17 -0600
Message-ID: <CAErSpo6S2kR6se2vVwe+9f0KN6_no7oMTJLs+B2-9yCofWwbVA@mail.gmail.com>
Subject: Re: [PATCH v3 7/8] ACPI, PCI: add hostbridge removal function
To: Taku Izumi <izumi.taku@jp.fujitsu.com>
Cc: linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org,
	kaneshige.kenji@jp.fujitsu.com, yinghai@kernel.org,
	jiang.liu@huawei.com
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Sep 27, 2012 at 6:23 PM, Bjorn Helgaas <bhelgaas@google.com> wrote:
> On Thu, Sep 27, 2012 at 6:15 PM, Taku Izumi <izumi.taku@jp.fujitsu.com> wrote:
>> On Thu, 27 Sep 2012 10:48:09 -0600
>> Bjorn Helgaas <bhelgaas@google.com> wrote:
>>
>>> On Fri, Sep 21, 2012 at 2:09 PM, Bjorn Helgaas <bhelgaas@google.com> wrote:
>>> > On Tue, Sep 18, 2012 at 12:25 AM, Taku Izumi <izumi.taku@jp.fujitsu.com> wrote:

>>> >> @@ -661,6 +663,11 @@ static int acpi_pci_root_remove(struct a
>>> >>         device_set_run_wake(root->bus->bridge, false);
>>> >>         pci_acpi_remove_bus_pm_notifier(device);
>>> >>
>>> >> +       acpi_pci_irq_del_prt(root->bus);
>>> >
>>> > acpi_pci_irq_del_prt() does not actually have a dependency on the
>>> > struct pci_bus, so I think its interface should be changed so it takes
>>> > a segment number and a bus number instead of the "struct pci_bus *".
>>> > The same applies to acpi_pci_irq_add_prt().
>>> >
>>> > This basically boils down to reverting 859a3f86ca8 and d9efae3688a.  I
>>> > acked those changes at the time, but I think they were a mistake.  The
>>> > reason is that passing in the struct pci_bus * ties them into the host
>>> > bridge add/remove flow in a way that's not necessary.
>>> >
>>> > If we get rid of the struct pci_bus * dependency, then we can easily
>>> > add the _PRT before doing PCI enumeration behind the bridge, and we
>>> > can remove the _PRT after removing the PCI devices.  I think this is
>>> > one small step toward getting rid of the add/start and stop/remove
>>> > split.
>>>
>>> I'm going to work on doing this if nobody else is interested.
>>
>>   I'll do that. Maybee that is separeted from this patchset.
>
> Great, thanks!  A separate patchset is definitely fine.

Whether this is a waste of time or not, I don't know.  But I did a
little bit of work on this before you volunteered, Taku.  Sorry, I
should have pointed you at the work-in-progress patches; maybe they
could have saved you a bit of time.  Anyway, here they are:

http://git.kernel.org/?p=linux/kernel/git/helgaas/pci.git;a=shortlog;h=refs/heads/pci/bjorn-misc
