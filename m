Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:17607 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750875AbbHQXD7 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Mon, 17 Aug 2015 19:03:59 -0400
Date: Mon, 17 Aug 2015 23:03:44 +0000 (UTC)
From: Keith Busch <keith.busch@intel.com>
To: Bjorn Helgaas <bhelgaas@google.com>
cc: Keith Busch <keith.busch@intel.com>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, Dave Jiang <dave.jiang@intel.com>,
	Austin Bolen <Austin_Bolen@Dell.com>,
	Myron Stowe <mstowe@redhat.com>, Jon Mason <jdmason@kudzu.us>
Subject: Re: [PATCH] pci: Default MPS tuning, match upstream port
In-Reply-To: <20150817222844.GJ26431@google.com>
Message-ID: <alpine.LNX.2.00.1508172232140.15930@localhost.lm.intel.com>
References: <1438208335-19457-1-git-send-email-keith.busch@intel.com> <1438208335-19457-2-git-send-email-keith.busch@intel.com> <20150817222844.GJ26431@google.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, 17 Aug 2015, Bjorn Helgaas wrote:
> On Wed, Jul 29, 2015 at 04:18:53PM -0600, Keith Busch wrote:
>> The new pcie tuning will check the device's MPS against the parent bridge
>> when it is initially added to the pci subsystem, prior to attaching
>> to a driver. If MPS is mismatched, the downstream port is set to the
>> parent bridge's if capable.
>
> This is a little confusing (at least, *I'm* confused).  You're talking
> about setting the MPS configuration of the "downstream port," but I
> think you are talking about either a Switch Upstream Port or an
> Endpoint.  Such a port is indeed *downstream* from the parent bridge,
> but referring to it as a "downstream port" risks confusing it with the
> parent bridge, which is either a Switch Downstream Port or a Root
> Port.

Yes, the wording is confusing, yet you've managed to describe my
intention, though. :)

>>  {
>>  	int retval;
>>
>> +	if (dev->bus->self &&
>> +			pcie_get_mps(dev) != pcie_get_mps(dev->bus->self))
>> +		return;
>
> This part looks like it could be in its own separate patch that
> basically enforces the "if we can't safely configure this device's MPS
> setting, prevent drivers from using the device" idea.  What happens in
> this case?  Does the device still appear in sysfs and lspci, even if
> we can't configure its MPS safely?  This seems like good place for a
> dev_warn().

It will remain in the pci topology and all the associated sysfs
artifacts and lspic capabilities will be there. You could retune the
whole topology from user space with "setpci" and do a rescan if you were
so inclined, but that could cause problems if transactions are in-flight
while re-tuning.

A dev_warn will be produced when the device is initially scanned as you
noted below, but another at this point might be useful to
make it clear a driver will not be bound.

The above is broken, though, for PCI device's that are not PCI-e, so
need to fix that at the very least if we will enforce this.

>> -	if (mps != p_mps)
>> -		dev_warn(&dev->dev, "Max Payload Size %d, but upstream %s set to %d; if necessary, use \"pci=pcie_bus_safe\" and report a bug\n",
>> -			 mps, pci_name(bridge), p_mps);
>> +	if (mps != p_mps) {
>> +		if (128 << dev->pcie_mpss < p_mps) {
>> +			dev_warn(&dev->dev,
>> +				"Max Payload Size Supported %d, but upstream %s set to %d. If problems are experienced, try running with pci=pcie_bus_safe\n",
>> +				128 << dev->pcie_mpss, pci_name(bridge), p_mps);
>> +			return;
>
> Isn't this the same case where the above change to
> pci_bus_add_device() will now decline to add the device?  So I think
> there are really two policy changes:
>
>  1) If an device can be configured to match the upstream bridge's MPS
>  setting, do it, and
>
>  2) Don't add a device when its MPS setting doesn't match the
>  upstream bridge
>
> I'd like those to be separate patches.

Ok.

>> +		}
>> +		pcie_write_mps(dev, p_mps);
>> +		dev_info(&dev->dev, "Max Payload Size set to %4d/%4d (was %4d)\n",
>> +			pcie_get_mps(dev), 128 << dev->pcie_mpss, mps);
>> +	}
>
> I assume this hunk is related to the policy change (from "do nothing"
> to "update the downstream port").  Can you split that policy change
> into its own separate minimal patch?  Yes, I'm looking for minimal and
> specific bisect targets :)
>
> I think this will be clearer if you write it as:
>
>  if (mps == p_mps)
>    return;
>
>  if (128 << dev->pcie_mpss < p_mps) {
>    dev_warn(...);
>    return;
>  }
>
>  pcie_write_mps(...);
>  dev_info(...);
>
> Now that this actively updates the MPS setting, it's starting to grow
> beyond the original "pcie_bus_detect_mps()" function name.

Agreed that's a cleaner flow.


Thanks for all the feedback. Will work on a revision this week.
