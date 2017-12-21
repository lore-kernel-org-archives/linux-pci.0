Return-Path: <SRS0=qZKk=DR=linux.vnet.ibm.com=jjalvare@kernel.org>
Return-Path: <SRS0=qZKk=DR=linux.vnet.ibm.com=jjalvare@kernel.org>
Subject: Re: [PATCH v2 2/7] powerpc/kernel: Add uevents in EEH error/resume
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Bjorn Helgaas <helgaas@kernel.org>,
        "Bryant G. Ly" <bryantly@linux.vnet.ibm.com>
Cc: paulus@samba.org, mpe@ellerman.id.au, seroyer@linux.vnet.ibm.com,
        alex.williamson@redhat.com, aik@ozlabs.ru, ruscur@russell.cc,
        linux-pci@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        bodong@mellanox.com, eli@mellanox.com, saeedm@mellanox.com,
        Keith Busch <keith.busch@intel.com>,
        Gabriele Paoloni <gabriele.paoloni@huawei.com>,
        Dongdong Liu <liudongdong3@huawei.com>
References: <20171218223808.83928-1-bryantly@linux.vnet.ibm.com>
 <20171218223808.83928-3-bryantly@linux.vnet.ibm.com>
 <20171219045009.GC14941@bhelgaas-glaptop.roam.corp.google.com>
 <1513664878.2743.8.camel@kernel.crashing.org>
From: Juan Alvarez <jjalvare@linux.vnet.ibm.com>
Date: Wed, 20 Dec 2017 21:04:27 -0600
MIME-Version: 1.0
In-Reply-To: <1513664878.2743.8.camel@kernel.crashing.org>
Content-Type: text/plain; charset=utf-8
Message-Id: <952dac4e-cf22-ed68-1a29-58ac7ed3515a@linux.vnet.ibm.com>
List-ID: <linux-pci.vger.kernel.org>

On 12/19/17 12:27 AM, Benjamin Herrenschmidt wrote:

> On Mon, 2017-12-18 at 22:50 -0600, Bjorn Helgaas wrote:
>> [+cc Keith, Gabriele, Dongdong]
>>
>> On Mon, Dec 18, 2017 at 04:38:03PM -0600, Bryant G. Ly wrote:
>>> Devices can go offline when EEH is reported. This patch adds
>>> a change to the kernel object and lets udev know of error.
>>> When device resumes a change is also set reporting device as
>>> online. Therefore, EEH events are better propagated to user
>>> space for devices in powerpc arch.
>> I'm on vacation and can't review this in detail, but I wonder if you
>> can compare this with the uevents we emit for DPC, AER, and hotplug
>> events (if any).  I hope we don't end up with userspace having to be
>> aware of the differences between EEH, DPC, AER, etc.
>>
>>> From a very quick look, I only see a few uevents even mentioned in
>> drivers/pci: KOBJ_ADD in __pci_hp_register() and KOBJ_CHANGE in the
>> SR-IOV code.  I'm worried that we're missing some important uevents in
>> the PCI core.  That's not an argument against what you're doing here;
>> it just would be nice to fill in any missing pieces in the core also,
>> and hopefully make them consistent with these EEH events.
> We also need to be careful about what specific EEH activity we are
> talking about, and if we bring into the picture things like DPDK, it
> gets even more murky...
>
> The basic way EEH is supposed to work for recovery (minus all sort of
> implementation nasties which hopefully Russell and Sam are trying to
> cleanup and fix) is that either:
>
> 	- The driver of the device has recovery callbacks, in which
> case the driver participates in the recovery process, the device
> doesn't "go away" (though it shouldn't be accessed during that process
> by other entities, userspace originated config space could be a problem
> and needs to be blocked...). The recovery typically involves a reset of
> the device but in sync with the driver.
>
> 	- The driver doesn't have the callbacks. In this case, we
> simulate an unplug, reset the device, and replug.
>
> So it makes sense for the second case to emit the same uevents as a
> normal PCI(e) hotplug.
>
> For the former case I'm less sure.... Do we really need userspace to be
> notified ? If yes, what for precisely ?

In pSeries SR-IOV environment the management console might need to apply
certain configuration changes to the PF driver after it has been recovered
and before the VF drivers are allowed to resume their recovery path.
I could not think of another way to notify user space of these events.
I made this assumption because I saw there were no uevents added when 
the device goes offline and come back online in EEH code. It was my 
intention to make the event as generic as possible in EEH component,
therefore, making this change independent of pSeries SR-IOV.

- Juan
