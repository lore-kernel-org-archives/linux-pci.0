Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:33486 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752339AbeCVLZj (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 22 Mar 2018 07:25:39 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Date: Thu, 22 Mar 2018 07:25:38 -0400
From: okaya@codeaurora.org
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        Michael Neuling <michael.neuling@au1.ibm.com>,
        linux-pci-owner@vger.kernel.org
Subject: Re: PCIe resets/restore and lack of CRS wait
In-Reply-To: <1521699853.16434.301.camel@kernel.crashing.org>
References: <1521691380.16434.287.camel@kernel.crashing.org>
 <f6af9b6e424c469f433735a106b8ee69@codeaurora.org>
 <1521695531.16434.294.camel@kernel.crashing.org>
 <1521699853.16434.301.camel@kernel.crashing.org>
Message-ID: <4d1c04efa51db50dd5095ae258c3c52b@codeaurora.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 2018-03-22 02:24, Benjamin Herrenschmidt wrote:
> On Thu, 2018-03-22 at 16:12 +1100, Benjamin Herrenschmidt wrote:
>> 
>> > > I'm keen on doing a rather "blanket" fix by adding a CRS wait inside
>> > > pci_dev_restore(). Would you guys agree ?
>> > >
>> > > Also why does pci_flr_wait() not use vendor/device ID but instead waits
>> > > on the COMMAND register being all 1's ? It's not clear to me ...
>> > > VID/DID will give a very specific signature for CRS which is ffff0001
>> > > while COMMAND could return all 1's for other reasons (device unplugged
>> > > for example).
>> > >
>> >
>> > Because if you read vendor id of a virtual function, you get 0xffffffff
>> 
>> Ah indeed, I forgot about that...
> 
> Actually, that makes me a bit nervous, I wonder if we should limit
> that "trick" to VFs and otherwise do the right thing. As per PCIe
> spec 3.1a (I haven't looked at 4.0 yet)
> 
> <<
> stalled while the device completes its self-initialization. Software
> that intends to take advantage of
> this mechanism must ensure that the first access made to a device
> following a valid reset condition is
> a Configuration Read Request accessing both bytes of the Vendor ID
> field in the device’s
> Configuration Space header. For this case only, the Root Complex, if
> enabled, will synthesize a
> special read-data value for the Vendor ID field to indicate to software
> that CRS Completion Status
> has been returned by the device. For other Configuration Requests, or
> when CRS Software
> Visibility is not enabled, the Root Complex will generally re-issue the
> Configuration Request until it
> completes with a status other than CRS as described in Section 2.3.2.
>>> 
> 
> That tells me that there is no guarantee by spec that we'll get
> ffff's, instead we might get HW stalls, or other really nasty
> effects when probing a register other than 0 (VID/DID) for CRS.

AFAIK, spec also mentions that sw needs to observe 0xffffffff for all 
other registers other than vendor id during CRS period.

> 
> Cheers,
> Ben.
