Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:32818 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754209AbeFLPQO (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 12 Jun 2018 11:16:14 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Date: Tue, 12 Jun 2018 20:46:12 +0530
From: poza@codeaurora.org
To: Keith Busch <keith.busch@intel.com>
Cc: Sinan Kaya <okaya@codeaurora.org>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH] PCI/AER: Prevent runtime power management during recovery
In-Reply-To: <20180612144443.GA3142@localhost.localdomain>
References: <20180611222918.1708-1-keith.busch@intel.com>
 <08e0ba9f-69cd-ea18-ae1b-d0795cceb306@codeaurora.org>
 <76f700a5484d82529272d94b4531e434@codeaurora.org>
 <20180612144443.GA3142@localhost.localdomain>
Message-ID: <24bc5664ce1c0ac40b48eb6d757e19aa@codeaurora.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 2018-06-12 20:14, Keith Busch wrote:
> On Tue, Jun 12, 2018 at 01:21:53PM +0530, poza@codeaurora.org wrote:
>> On 2018-06-12 10:10, Sinan Kaya wrote:
>> > On 6/11/2018 6:29 PM, Keith Busch wrote:
>> > > A bridge that supports D3 but not hotplug will be subject to runtime
>> > > power management placing it in a non-operation power state if it
>> > > doesn't
>> > > have any devices attached. This patch will prevent this power
>> > > management
>> > > during error recovery so that the rescan at the end may be successful.
>> >
>> > If there is no card connected, why would the bridge observe a fatal
>> > error?
>> 
>> fatal error could be coming from anywhere let us say below RootPort..
>> and RP observes it and decides to take the tree down....
>> Is that the case Keith is talking about ?
> 
> Right, the err fatal handling removes all the devices below a bridge,
> making that bridge allowed for run time d3.
> 
>> Why will re-enumeration be a problem even if runtime PM is active ?
>> I assume that enumeration will get bridge out of D3.
> 
> That doesn't seem to be the case.

reset_link(udev, service); will initiate SBR, and which should do hot 
reset the bridge and bring it out of D3 !
but it seems even SBR is not doing it for you.

Although I am not sure if the EP has to be designed to reset its config 
space upon SBR.. even if they are, some just might not do it all 
correctly !

The code looks okay to me anyway.
Reviewed-by: Oza Pawandeep <poza@codeaurora.org>
