Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from emh04.mail.saunalahti.fi ([62.142.5.110]:50968 "EHLO
        emh04.mail.saunalahti.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727140AbeIRMqk (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 18 Sep 2018 08:46:40 -0400
Date: Tue, 18 Sep 2018 10:15:19 +0300
From: Pasi =?iso-8859-1?Q?K=E4rkk=E4inen?= <pasik@iki.fi>
To: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Cc: Jan Beulich <JBeulich@suse.com>, Juergen Gross <jgross@suse.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        bhelgaas@google.com, xen-devel@lists.xenproject.org,
        roger.pau@citrix.com,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        George Dunlap <george.dunlap@eu.citrix.com>
Subject: Re: [Xen-devel] [PATCH V3 2/2] Xen/PCIback: Implement PCI
 flr/slot/bus reset with 'reset' SysFS attribute
Message-ID: <20180918071519.GG18222@reaktio.net>
References: <20171207222145.9769-1-Govinda.Tatti@Oracle.COM>
 <20171207222145.9769-3-Govinda.Tatti@Oracle.COM>
 <5A2A6AB10200007800195D4F@prv-mh.provo.novell.com>
 <8a3bc517-1255-4547-d244-5c400e44cc77@Oracle.COM>
 <f19dbb09-ef22-2cf4-fb38-2a7c42b5dc48@Oracle.COM>
 <5A377E020200007800197FFA@prv-mh.provo.novell.com>
 <559ffd12-b541-8a69-60bd-fbe10e3dc159@oracle.com>
 <20180916114306.GF18222@reaktio.net>
 <a726840b-8a5c-0890-73c6-3a95a7205153@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <a726840b-8a5c-0890-73c6-3a95a7205153@oracle.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi,

On Mon, Sep 17, 2018 at 02:06:02PM -0400, Boris Ostrovsky wrote:
> On 9/16/18 7:43 AM, Pasi Kärkkäinen wrote:
> > Hi,
> >
> > On Mon, Dec 18, 2017 at 12:32:11PM -0500, Boris Ostrovsky wrote:
> >> On 12/18/2017 02:36 AM, Jan Beulich wrote:
> >>>>>> On 15.12.17 at 20:52, <Govinda.Tatti@Oracle.COM> wrote:
> >>>>>>> +static int pcistub_device_reset(struct pci_dev *dev)
> >>>>>>> +{
> >>>>>>> +	struct xen_pcibk_dev_data *dev_data;
> >>>>>>> +	bool slot = false, bus = false;
> >>>>>>> +	struct pcistub_args arg = {};
> >>>>>>> +
> >>>>>>> +	if (!dev)
> >>>>>>> +		return -EINVAL;
> >>>>>>> +
> >>>>>>> +	dev_dbg(&dev->dev, "[%s]\n", __func__);
> >>>>>>> +
> >>>>>>> +	/* First check and try FLR */
> >>>>>>> +	if (pcie_has_flr(dev)) {
> >>>>>>> +		dev_dbg(&dev->dev, "resetting %s device using FLR\n",
> >>>>>>> +			pci_name(dev));
> >>>>>>> +		pcie_flr(dev);
> >>>>>> The lack of error check here puzzled me, but I see the function
> >>>>>> indeed returns void right now. I think the prereq patch should
> >>>>>> change this along with exporting the function - you really don't
> >>>>>> want the device to be handed to a guest when the FLR timed
> >>>>>> out.
> >>>>> We will change pcie_flr() to return error code. I will make this change
> >>>>> in the next version of this patch.
> >>>> I exchanged some emails with Bjorn/Christoph and it looks like Christoph
> >>>> as some planto restructure pcie flr specific functions but I don't know
> >>>> the exact time-frame. For now,I am planning to use existing pcie_flr()
> >>>> after checking FLR capability. We will switchto revised pcie_flr() once
> >>>> it is available.
> >>>>
> >>>> I hope you are fine with this approach. Please let me know. Thanks.
> >>> I've seen that other discussion. I don't think the change here
> >>> should be done prior to the error reporting being put in place,
> >>> for security reasons. But in the end it'll be Konrad as the
> >>> maintainer to judge.
> >>>
> >>> Or wait, looks like there's some confusion in ./MAINTAINERS:
> >>> Konrad is listed as maintainer for "XEN PCI SUBSYSTEM", but the
> >>> list of files doesn't include pciback. So it would instead be Boris
> >>> or Jürgen to give you a final word.
> >>
> >> This is now 4.16 material so we can at least wait until closer to
> >> opening of the merge window when we may have the PCI updates. (And I
> >> just noticed that you responded to Christoph.)
> >>
> >> Besides, we don't want to make kernel changes until the interface is
> >> settled (i.e the toolstack changes are accepted).
> >>
> > It seems Govinda's email address is giving an error, so I assume someone else needs to pick up this pciback 'reset' feature.
> > Is it likely someone else from Oracle can/will pick up and refresh this patch, with the review comments addressed?
> 
> 
> Govinda is no longer at Oracle.
> 

Yep, thought so. Removed from CC list.


> What about the toolstack changes? Have they been accepted? I vaguely
> recall there was a discussion about those changes but don't remember how
> it ended.
> 

I don't think toolstack/libxl patch has been applied yet either.


"[PATCH V1 0/1] Xen/Tools: PCI reset using 'reset' SysFS attribute":
https://lists.xen.org/archives/html/xen-devel/2017-12/msg00664.html

"[PATCH V1 1/1] Xen/libxl: Perform PCI reset using 'reset' SysFS attribute":
https://lists.xen.org/archives/html/xen-devel/2017-12/msg00663.html

George asked for some clarifications:
https://lists.xen.org/archives/html/xen-devel/2017-12/msg01044.html
https://lists.xen.org/archives/html/xen-devel/2017-12/msg01116.html

> 
> -boris
> 


Thanks,

-- Pasi

> 
> >
> >
> > Meanwhile the pcie_has_flr() has been exported in upstream Linux kernel, so that's already available for use now.
> >
> > "PCI: Export pcie_has_flr()":
> > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=2d2917f7747805a1f4188672f308d82a8ba01700
> >
> >
> >
> 
