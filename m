Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from userp2130.oracle.com ([156.151.31.86]:32927 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756221AbdLOTw6 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 15 Dec 2017 14:52:58 -0500
Subject: Re: [PATCH V3 2/2] Xen/PCIback: Implement PCI flr/slot/bus reset with
 'reset' SysFS attribute
From: Govinda Tatti <Govinda.Tatti@Oracle.COM>
To: Jan Beulich <JBeulich@suse.com>
Cc: roger.pau@citrix.com, bhelgaas@google.com,
        xen-devel@lists.xenproject.org, boris.ostrovsky@Oracle.COM,
        konrad.wilk@Oracle.COM, Juergen Gross <jgross@suse.com>,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
References: <20171207222145.9769-1-Govinda.Tatti@Oracle.COM>
 <20171207222145.9769-3-Govinda.Tatti@Oracle.COM>
 <5A2A6AB10200007800195D4F@prv-mh.provo.novell.com>
 <8a3bc517-1255-4547-d244-5c400e44cc77@Oracle.COM>
Message-ID: <f19dbb09-ef22-2cf4-fb38-2a7c42b5dc48@Oracle.COM>
Date: Fri, 15 Dec 2017 13:52:14 -0600
MIME-Version: 1.0
In-Reply-To: <8a3bc517-1255-4547-d244-5c400e44cc77@Oracle.COM>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Jan,

One quick update on pcie_flr() specific implementation. Please see below.
>>> +static int pcistub_device_reset(struct pci_dev *dev)
>>> +{
>>> +	struct xen_pcibk_dev_data *dev_data;
>>> +	bool slot = false, bus = false;
>>> +	struct pcistub_args arg = {};
>>> +
>>> +	if (!dev)
>>> +		return -EINVAL;
>>> +
>>> +	dev_dbg(&dev->dev, "[%s]\n", __func__);
>>> +
>>> +	/* First check and try FLR */
>>> +	if (pcie_has_flr(dev)) {
>>> +		dev_dbg(&dev->dev, "resetting %s device using FLR\n",
>>> +			pci_name(dev));
>>> +		pcie_flr(dev);
>> The lack of error check here puzzled me, but I see the function
>> indeed returns void right now. I think the prereq patch should
>> change this along with exporting the function - you really don't
>> want the device to be handed to a guest when the FLR timed
>> out.
> We will change pcie_flr() to return error code. I will make this change
> in the next version of this patch.
I exchanged some emails with Bjorn/Christoph and it looks like Christoph
as some planto restructure pcie flr specific functions but I don't know
the exact time-frame. For now,I am planning to use existing pcie_flr()
after checking FLR capability. We will switchto revised pcie_flr() once
it is available.

I hope you are fine with this approach. Please let me know. Thanks.

Cheers
GOVINDA
