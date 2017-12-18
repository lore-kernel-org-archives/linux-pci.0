Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from userp2130.oracle.com ([156.151.31.86]:58396 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934994AbdLRRc3 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 18 Dec 2017 12:32:29 -0500
Subject: Re: [PATCH V3 2/2] Xen/PCIback: Implement PCI flr/slot/bus reset with
 'reset' SysFS attribute
To: Jan Beulich <JBeulich@suse.com>,
        Govinda Tatti <Govinda.Tatti@oracle.com>
References: <20171207222145.9769-1-Govinda.Tatti@Oracle.COM>
 <20171207222145.9769-3-Govinda.Tatti@Oracle.COM>
 <5A2A6AB10200007800195D4F@prv-mh.provo.novell.com>
 <8a3bc517-1255-4547-d244-5c400e44cc77@Oracle.COM>
 <f19dbb09-ef22-2cf4-fb38-2a7c42b5dc48@Oracle.COM>
 <5A377E020200007800197FFA@prv-mh.provo.novell.com>
Cc: roger.pau@citrix.com, bhelgaas@google.com,
        xen-devel@lists.xenproject.org, konrad.wilk@oracle.com,
        Juergen Gross <jgross@suse.com>, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org
From: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Message-ID: <559ffd12-b541-8a69-60bd-fbe10e3dc159@oracle.com>
Date: Mon, 18 Dec 2017 12:32:11 -0500
MIME-Version: 1.0
In-Reply-To: <5A377E020200007800197FFA@prv-mh.provo.novell.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 12/18/2017 02:36 AM, Jan Beulich wrote:
>>>> On 15.12.17 at 20:52, <Govinda.Tatti@Oracle.COM> wrote:
>>>>> +static int pcistub_device_reset(struct pci_dev *dev)
>>>>> +{
>>>>> +	struct xen_pcibk_dev_data *dev_data;
>>>>> +	bool slot = false, bus = false;
>>>>> +	struct pcistub_args arg = {};
>>>>> +
>>>>> +	if (!dev)
>>>>> +		return -EINVAL;
>>>>> +
>>>>> +	dev_dbg(&dev->dev, "[%s]\n", __func__);
>>>>> +
>>>>> +	/* First check and try FLR */
>>>>> +	if (pcie_has_flr(dev)) {
>>>>> +		dev_dbg(&dev->dev, "resetting %s device using FLR\n",
>>>>> +			pci_name(dev));
>>>>> +		pcie_flr(dev);
>>>> The lack of error check here puzzled me, but I see the function
>>>> indeed returns void right now. I think the prereq patch should
>>>> change this along with exporting the function - you really don't
>>>> want the device to be handed to a guest when the FLR timed
>>>> out.
>>> We will change pcie_flr() to return error code. I will make this change
>>> in the next version of this patch.
>> I exchanged some emails with Bjorn/Christoph and it looks like Christoph
>> as some planto restructure pcie flr specific functions but I don't know
>> the exact time-frame. For now,I am planning to use existing pcie_flr()
>> after checking FLR capability. We will switchto revised pcie_flr() once
>> it is available.
>>
>> I hope you are fine with this approach. Please let me know. Thanks.
> I've seen that other discussion. I don't think the change here
> should be done prior to the error reporting being put in place,
> for security reasons. But in the end it'll be Konrad as the
> maintainer to judge.
>
> Or wait, looks like there's some confusion in ./MAINTAINERS:
> Konrad is listed as maintainer for "XEN PCI SUBSYSTEM", but the
> list of files doesn't include pciback. So it would instead be Boris
> or Jürgen to give you a final word.


This is now 4.16 material so we can at least wait until closer to
opening of the merge window when we may have the PCI updates. (And I
just noticed that you responded to Christoph.)

Besides, we don't want to make kernel changes until the interface is
settled (i.e the toolstack changes are accepted).

-boris
