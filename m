Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:28066 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751489AbaFEQl6 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Thu, 5 Jun 2014 12:41:58 -0400
Date: Thu, 5 Jun 2014 10:41:30 -0600 (MDT)
From: Keith Busch <keith.busch@intel.com>
To: Jon Mason <jon.mason@intel.com>
cc: Bjorn Helgaas <bhelgaas@google.com>,
	Keith Busch <keith.busch@intel.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Yijing Wang <wangyijing@huawei.com>
Subject: Re: Debugging incorrect mps settings detected
In-Reply-To: <20140604174440.GA17837@jonmason-lab>
Message-ID: <alpine.LRH.2.03.1406051037580.11244@AMR>
References: <alpine.LRH.2.03.1406031308200.11244@AMR> <CAErSpo6B76KL=PVGuuLjvC77kvxSjjYNnngXxPEjj_3dMbA0yg@mail.gmail.com> <20140604174440.GA17837@jonmason-lab>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, 4 Jun 2014, Jon Mason wrote:
> On Tue, Jun 03, 2014 at 03:01:31PM -0600, Bjorn Helgaas wrote:
>> [+cc Yijing, Jon]
>> The PCI core should be doing something intelligent here.  If we can't
>> configure MPS safely, we should prevent the device from being enabled.
>>  But this is stuff the PCI core doesn't implement yet.
>
> The tuning of the MPS is disabled by default, which is why the warning
> is there.  Now, we can attempt to tune it regardless of whether tuning
> is enabled (assuming this device is the only one under the root port),
> we can fail to all the hotplug, or we can enable "safe" tuning by
> default.  The first option seems a bit hacky.  The second will fail
> too often, since the MPSS of the hotplugged device would have to match
> the MPS setting of slot/fabric.  The third seems like the best option.
>
>> It's hard to reconfigure MPS after boot because it affects other
>> devices in the system, and I don't think we can always change the
>> settings of other devices while they're active.
>
> Unless the slot is under its own root port, otherwise the MPS will
> have to be floored.  This is the behavior in the "safe" tuning.
>
> I suggest that the "safe" tuning get made the default behavior and we
> let it soak for a little while to shake out any issues that there may
> be.

Thanks for all the info. I've tried different tunings on several different
platforms that were all failing before. The 'safe' tuning was the only
one successful on all platforms, so just providing a data point that
this appears to be a good direction to go.
