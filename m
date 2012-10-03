Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:16270 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755068Ab2JCNSU (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Wed, 3 Oct 2012 09:18:20 -0400
Message-ID: <506C3B11.9010009@redhat.com>
Date: Wed, 03 Oct 2012 09:18:09 -0400
From: Don Dutile <ddutile@redhat.com>
MIME-Version: 1.0
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC: Yinghai Lu <yinghai@kernel.org>, linux-pci@vger.kernel.org,
	bhelgaas@google.com, yuvalmin@broadcom.com,
	bhutchings@solarflare.com, gregory.v.rose@intel.com,
	davem@davemloft.net
Subject: Re: [RFC] PCI: enable and disable sriov support via sysfs at per
 device level
References: <1349134020-62152-1-git-send-email-ddutile@redhat.com> <CAE9FiQUd=sM3XaMKfJjnJq6mkugL7P=wEjdcMHtGjfe4ooRXUQ@mail.gmail.com> <506B4D4C.3080101@redhat.com> <20121002203951.GA28663@kroah.com> <506B575A.4060304@redhat.com> <20121003031018.GB13391@kroah.com>
In-Reply-To: <20121003031018.GB13391@kroah.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 10/02/2012 11:10 PM, Greg Kroah-Hartman wrote:
> On Tue, Oct 02, 2012 at 05:06:34PM -0400, Don Dutile wrote:
>> On 10/02/2012 04:39 PM, Greg Kroah-Hartman wrote:
>>> On Tue, Oct 02, 2012 at 04:23:40PM -0400, Don Dutile wrote:
>>>> Greg: Why not use the above functions?
>>>
>>> What "above functions"?  You make a lot of calls in the code :)
>>>
>>> You are creating an attribute group, and then manually walking through
>>> it to create/destroy the file?  That's not good, use the in-kernel
>>> functions to do that automatically for you.
>>>
>>> Also, you need to do this _before_ the device shows up to userspace,
>>> otherwise you have a race that you just lost with udev and the like.
>>>
>>> thanks,
>>>
>>> greg k-h
>>
>> So, why is it ok to create the 'reset' file after the device shows up?
>
> It's not, that should be fixed, patches are always welcome.
>
>> Like reset, SRIOV is optional.  The sysfs files are designed to only
>> be used by userspace utils to enable/disable VFs after the system is up.
>>
>> Or should the design allow a udev rule to be created that if one
>> of these new sriov files exists, then perform a set of read-max-vf&
>> enable n-vf ops ?
>
> Yes it should.  Never create sysfs files after the device is present in
> the system, otherwise userspace never knows about it.
>
> thanks,
>
> greg k-h

ok, thanks for feedback and bit of education ....
still looking for more on this 'visible' tagging though.

so, I guess Bjorn ought to add 'cleaning up pci-sysfs' to
his PCI to-do list...

maybe once i figure out the proper sriov sysfs code, I
can duplicate that effort in the reset,vga & pm-capabilities
section.

- Don
