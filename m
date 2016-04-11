Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-lf0-f66.google.com ([209.85.215.66]:34138 "EHLO
	mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932505AbcDKNiK (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 11 Apr 2016 09:38:10 -0400
MIME-Version: 1.0
In-Reply-To: <20160411085605.GB1727@lahna.fi.intel.com>
References: <1460111790-92836-1-git-send-email-mika.westerberg@linux.intel.com>
	<1460111790-92836-3-git-send-email-mika.westerberg@linux.intel.com>
	<0DD381DBF8F68D419C32ACFCEB28EB2521D2B374@SHSMSX101.ccr.corp.intel.com>
	<20160411085605.GB1727@lahna.fi.intel.com>
Date: Mon, 11 Apr 2016 15:38:07 +0200
Message-ID: <CAJZ5v0he594EgJqoT4MMvhsKBSRLk7d4jFBVAfR+hGHs4oRfsA@mail.gmail.com>
Subject: Re: [PATCH v2 2/4] PCI: Move PCIe ports to D3 during suspend
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: "Zheng, Qi" <qi.zheng@intel.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	"Rafael J. Wysocki" <rjw@rjwysocki.net>,
	"Zha, Qipeng" <qipeng.zha@intel.com>,
	Dave Airlie <airlied@gmail.com>,
	"Nyman, Mathias" <mathias.nyman@intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Apr 11, 2016 at 10:56 AM, Mika Westerberg
<mika.westerberg@linux.intel.com> wrote:
> On Mon, Apr 11, 2016 at 03:36:41AM +0000, Zheng, Qi wrote:
>> > +static int pci_dev_check_d3cold(struct pci_dev *pdev, void *data) {
>> > +   bool *d3cold_ok = data;
>> > +
>> > +   /*
>> > +    * The device needs to be allowed to go D3cold and if it is wake
>> > +    * capable to do so from D3cold.
>> > +    */
>> > +   if (pdev->no_d3cold || !pdev->d3cold_allowed)
>> > +           *d3cold_ok = false;
>> > +   if (device_may_wakeup(&pdev->dev) && !pci_pme_capable(pdev, PCI_D3cold))
>> > +           *d3cold_ok = false;
>> > +
>> > +   return !*d3cold_ok;
>> >+}
>>
>> How about the pme_poll?
>> IMHO, if the pme_poll is set for some device, the PCIe port couldn't
>> go to sleep as well.
>
> I wasn't sure about that. If the device has pme_poll set, and the bridge
> is in D3 (or anything else than D0) the it will not be scanned for PME
> (this is done in pci_pme_list_scan()).
>
> My understanding is that pme_poll is a workaround for bridges which do not
> forward PME messages upstream properly. Since this whole thing is only
> enabled for recent PCIe hardware, I would expect that this works also :)

Fair enough, but we may need to do something about that in the future
if things turn out to not work properly.
