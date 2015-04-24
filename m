Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from szxga03-in.huawei.com ([119.145.14.66]:27878 "EHLO
	szxga03-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754677AbbDXGNT (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 24 Apr 2015 02:13:19 -0400
Message-ID: <5539DEDF.3050503@huawei.com>
Date: Fri, 24 Apr 2015 14:12:47 +0800
From: Yijing Wang <wangyijing@huawei.com>
MIME-Version: 1.0
To: Bjorn Helgaas <bhelgaas@google.com>
CC: <linux-pci@vger.kernel.org>, <mjg59@coreos.com>,
	<rwhite@pobox.com>, <alex.williamson@redhat.com>
Subject: Re: [PATCH] PCI: Fix NULL pointer when find parent pcie_link_state
References: <1429774916-24920-1-git-send-email-wangyijing@huawei.com> <20150423142407.GL20701@google.com>
In-Reply-To: <20150423142407.GL20701@google.com>
Content-Type: text/plain; charset="ISO-8859-1"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 2015/4/23 22:24, Bjorn Helgaas wrote:
> [+cc Alex]
> 
> Hi Yijing,
> 
> Thanks for picking this up and working on it!
> 
> On Thu, Apr 23, 2015 at 03:41:56PM +0800, Yijing Wang wrote:
>> https://bugzilla.kernel.org/show_bug.cgi?id=94361 reported
>> NULL Pointer in pcie_aspm_init_link_state(), Some platform
>> like ATCA may has strange PCIe topology:
>> E.g.
>> ---root port---downstream port---upstream port
>>                               |--downstream port
>>                               |--downstream port
> 
> I agree that this is "strange" in the sense that it's not the typical PC
> topology.  However, I can't find anything in the spec that prohibits it.
> As far as I can tell, it is legal, so the PCI core shouldn't treat it as
> an exception.
> 
> PCI bridges (including PCIe switch ports) are symmetric: anything in the
> bridge windows will be transferred from the primary interface to the
> secondary, and anything outside the windows will be transferred from
> secondary to primary.  That applies to both address-routed transactions
> (using the I/O port, memory, and prefetchable memory windows) and
> ID-routed transactions (using the bus number windows).  And it applies
> to both Upstream and Downstream Ports, so from a routing perspective, I
> think Upstream and Downstream Ports are mostly interchangeable.
> 
> There are some wrinkles that might be issues:
> 
>   - PCIe spec r3.0, sec 7.3.3 says propagation of config requests from
>     Downstream to Upstream is unsupported.  I think that means we
>     wouldn't be able to discover anything on the other side of the
>     Upstream Port in the above topology.
> 
>   - Sec 7.5.1.7 says primary side Error Control/Status registers apply
>     to the link for Upstream Ports and to the internal logic for
>     Downstream Ports.  For this ATCA topology that means the primary
>     side registers of a Downstream Port really refer to the *secondary*
>     interface.
> 
>   - Sec 7.16 (ACS) might have issues similar to this ASPM one.
> 
> If this topology is legal, the NULL pointer is a hint that the code uses
> an incorrect assumption, and I'd rather fix the incorrect assumption
> than apply a point fix for the NULL pointer.
> 
> In this case, the code incorrectly assumes that a Downstream Port is
> always on the upstream end of a link.  I think it's safe to assume that
> a *Root Port* is always on the upstream end of a link.  Maybe we can
> start from there and deduce where the links are, without relying on
> whether a Port is an Upstream or Downstream Port.  The levels of the
> hierarchy should alternate between links and internal switch logic,

I agree with this assumption, there should be no adjacent links or internal buses.

Thanks!
Yijing.


> e.g.:
> 
>   RP -link- endpoint
>   RP -link- UP -int-bus- DP -link- endpoint
>   RP -link- UP -int-bus- DP -link- UP -int-bus- DP -link- endpoint
>   RP -link- DP -int-bus- DP -link- endpoint
>   RP -link- DP -int-bus- DP -link- UP -int-bus- DP -link- endpoint
> 
>> When we try to alloc pcie_link_state, we assumed downstream port
>> always has a upstream port, in this case, NULL pointer would
>> be triggered when try to find the parent pci_link_state,
>> because downstream port connects to root port directly.
> 
>> Signed-off-by: Yijing Wang <wangyijing@huawei.com>
>> ---
>>  drivers/pci/pcie/aspm.c |   13 +++++++++++--
>>  1 files changed, 11 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
>> index 7d4fcdc..f295824 100644
>> --- a/drivers/pci/pcie/aspm.c
>> +++ b/drivers/pci/pcie/aspm.c
>> @@ -526,8 +526,17 @@ static struct pcie_link_state *alloc_pcie_link_state(struct pci_dev *pdev)
>>  	INIT_LIST_HEAD(&link->link);
>>  	link->pdev = pdev;
>>  	if (pci_pcie_type(pdev) == PCI_EXP_TYPE_DOWNSTREAM) {
>> -		struct pcie_link_state *parent;
>> -		parent = pdev->bus->parent->self->link_state;
>> +		struct pci_bus *pbus = pdev->bus;
>> +		struct pcie_link_state *parent = NULL;
>> +
>> +		while (pbus) {
>> +			if (pbus->self) {
>> +				parent = pbus->self->link_state;
>> +				if (parent)
>> +					break;
>> +			}
>> +			pbus = pbus->parent;
>> +		}
>>  		if (!parent) {
>>  			kfree(link);
>>  			return NULL;
> 
> .
> 


-- 
Thanks!
Yijing

