Return-Path: <SRS0=o6Kt=A5=redhat.com=ddutile@kernel.org>
Return-Path: <SRS0=o6Kt=A5=redhat.com=ddutile@kernel.org>
Subject: Re: [PATCH] uio/uio_pci_generic: Add SR-IOV support
To: Bjorn Helgaas <helgaas@kernel.org>, David Woodhouse <dwmw2@infradead.org>
References: <1506517162.30379.2.camel@infradead.org>
 <20170927220005.GB23674@bhelgaas-glaptop.roam.corp.google.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linux-pci <linux-pci@vger.kernel.org>,
 linux-kernel <linux-kernel@vger.kernel.org>,
 Alexander Duyck <alexander.h.duyck@intel.com>,
 "Bryant G. Ly" <bryantly@linux.vnet.ibm.com>,
 Bodong Wang <bodong@mellanox.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, kvm@vger.kernel.org
From: Don Dutile <ddutile@redhat.com>
Message-ID: <2627d7e8-eb5b-674b-2e70-6074597cb90b@redhat.com>
Date: Thu, 28 Sep 2017 08:12:22 -0400
MIME-Version: 1.0
In-Reply-To: <20170927220005.GB23674@bhelgaas-glaptop.roam.corp.google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
List-ID: <linux-pci.vger.kernel.org>

On 09/27/2017 06:00 PM, Bjorn Helgaas wrote:
> [+cc Don, Alex D, Alex W, Bryant, Bodong, Michael, kvm list]
>
> On Wed, Sep 27, 2017 at 01:59:22PM +0100, David Woodhouse wrote:
>> From: David Woodhouse <dwmw@amazon.co.uk>
>>
>> Allow userspace to configure SR-IOV VFs through sysfs.
>>
>> Currently, we need an in-kernel driver to permit this. But sometimes
>> *all* we want to do is enable the VFs so that we can assign them to
>> guests; we don't actually need to deal with the PF in any other way
>> from the host kernel. So let's make it possible to use UIO for that.
>>
>> Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
>> ---
>> It's not entirely clear to me why we require the driver to "enable"
>> SR-IOV like this anyway — were there some which needed to do something
>> special and device-specific instead of just falling through to
>> pci_{en,dis}able_sriov(), such that we need to effectively whitelist
>> this in the driver rather than blacklisting the "problematic" ones via
>> PCI quirks?
>
> IIUC, this question is basically "why doesn't the PCI core enable IOV
> automatically when it sees an IOV-capable device?"
>
> I think one reason is that an admin might want to control the number
> of VFs we enable (e.g., via 1789382a72a5 ("PCI: SRIOV control and
> status via sysfs" [1]).  But I guess you already know about that,
> since this patch uses that sysfs path, so maybe I don't understand
> your question.
>
The major reason is that most bios don't scan extended pci config for
SRIOV info, and thus, dont provide enough resources to configure VFs.
If an SRIOV-capable device is one of the first devices scanned in a PCI tree
(off a PCI Root Port), then it could consume all the bus resources,
and fail configuring the rest of the PCI devices, often leaving the system
unbootable.
Another reason why it's not an all-or-nothing selection when a PF's VFs are
enabled as well -- there may be enough resources available for some VFs to
be enabled, but not all.  The (needs-to-be-ECN'd) req that VFs of a PF
have to be aligned to the VF BAR[n]*num_VFs_enabled is the real difficulty,
since large, aligned free mmio space is not commonly 'free' after a PCI bus(tree)
scan and resource allocation. Free bus num space (gaps), and MSI resources
add further complications.

Will try to make some time later today to dig into the patches further
and add more concrete suggestions/feedback afterward.

> [1] http://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/commit/?id=1789382a72a5
>
>>  drivers/uio/uio_pci_generic.c | 12 ++++++++++++
>>  1 file changed, 12 insertions(+)
>>
>> diff --git a/drivers/uio/uio_pci_generic.c b/drivers/uio/uio_pci_generic.c
>> index a56fdf9..bd196f0 100644
>> --- a/drivers/uio/uio_pci_generic.c
>> +++ b/drivers/uio/uio_pci_generic.c
>> @@ -108,15 +108,27 @@ static void remove(struct pci_dev *pdev)
>>  	struct uio_pci_generic_dev *gdev = pci_get_drvdata(pdev);
>>
>>  	uio_unregister_device(&gdev->info);
>> +	pci_disable_sriov(pdev);
>>  	pci_disable_device(pdev);
>>  	kfree(gdev);
>>  }
>>
>> +static int sriov_configure(struct pci_dev *pdev, int num_vfs)
>> +{
>> +	if (!num_vfs) {
>> +		pci_disable_sriov(pdev);
>> +		return 0;
>> +	}
>> +
>> +	return pci_enable_sriov(pdev, num_vfs);
>> +}
>> +
>>  static struct pci_driver uio_pci_driver = {
>>  	.name = "uio_pci_generic",
>>  	.id_table = NULL, /* only dynamic id's */
>>  	.probe = probe,
>>  	.remove = remove,
>> +	.sriov_configure = sriov_configure,
>>  };
>>
>>  module_pci_driver(uio_pci_driver);
>> --
>> 2.7.4
>>
>> --
>> dwmw2
>
>
