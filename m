Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from e28smtp06.in.ibm.com ([122.248.162.6]:34014 "EHLO
	e28smtp06.in.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750951Ab3KNDXu (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 13 Nov 2013 22:23:50 -0500
Received: from /spool/local
	by e28smtp06.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pci@vger.kernel.org> from <qiudayu@linux.vnet.ibm.com>;
	Thu, 14 Nov 2013 08:53:48 +0530
Message-ID: <5284423D.4090907@linux.vnet.ibm.com>
Date: Thu, 14 Nov 2013 11:23:41 +0800
From: mike <qiudayu@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Alan Stern <stern@rowland.harvard.edu>
CC: Bjorn Helgaas <bhelgaas@google.com>,
	Huang Ying <ying.huang@intel.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	linux-pm@vger.kernel.org, rjw@rjwysocki.net
Subject: Re: A question about the patch: [PATCH] PCI/PM: Keep runtime PM enabled
 for unbound PCI devices
References: <Pine.LNX.4.44L0.1311131416110.1424-100000@iolanthe.rowland.org>
In-Reply-To: <Pine.LNX.4.44L0.1311131416110.1424-100000@iolanthe.rowland.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 11/14/2013 03:20 AM, Alan Stern wrote:
> On Wed, 13 Nov 2013, Bjorn Helgaas wrote:
>
>> [+cc Rafael, linux-pm]
>>
>> On Wed, Nov 13, 2013 at 6:09 AM, mike<qiudayu@linux.vnet.ibm.com>  wrote:
>>> Hi Huang Ying,
>>>
>>> I see you are the author of this patch, commit id is:
>>> 967577b062417b4e4b8e27b711220f4124f5153a
>>>
>>> I have a question while I try to understand this patch,
>>> So I would very grateful if you or others can give me some reply.....
>>>
>>> ............
>>> -       rc = ddi->drv->probe(ddi->dev, ddi->id);
>>> +       pm_runtime_get_sync(dev);
>>> +       pci_dev->driver = pci_drv;
>>> ^^^^^^^^^^^^^^^^^^^^^^^^^^
>>> I see here you make the driver to initialize before probe,
>>> But I have no idea of why you do this change.....
>>>
>>> and I look inside the code, it may be pm_runtime relate??
> Yes, it is related to runtime PM.  In the PCI subsystem, runtime PM
> doesn't do anything unless pci_dev->driver is set.  You can see this at
> the start of pci_pm_runtime_suspend().
>
> Since we want the driver's probe routine to be able to carry out
> runtime PM operations, we have to set pci_dev->driver before the probe
> routine runs.
Is there any situations , like in  probe state,  pci_dev->driver
has been set. the  pci_pm_runtime_xxx() has passed
pci_dev->driver NULL check, but at this point, probe fail
occurs, and  pci_dev->driver to be set to NULL.

What will happen ? Or this situation will never happen?
I'm confuse about this.

Because it may be dangerous to call the functions in driver
to do some actions in the device  which probe failed.

Even if it will at last probe success, the driver itself must be
very strong, because may be a lot critical data structs
haven't be created or initialized, if we call driver function in
probe state may be lead a invalid access to some pointer.

So I think this logic may have some issue, am I right?

If I am right, I have a *patch to fix this issue*, but I'm not sure
it is safe enough to do PM ops in probe state.

Actually, I face a *bug report* to this issue, access the
driver function in probe state, even though it can be fixed
in driver ( Make the driver more stronger), but the root
cause is this issue.

Pray for your reply, and I really want to know.

Thanks
Mike
> Alan Stern
>

