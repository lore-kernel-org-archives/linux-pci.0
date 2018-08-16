Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:57704 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726342AbeHPKxd (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 16 Aug 2018 06:53:33 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Date: Thu, 16 Aug 2018 13:26:51 +0530
From: poza@codeaurora.org
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Thomas Tai <thomas.tai@oracle.com>, bhelgaas@google.com,
        keith.busch@intel.com, linux-pci@vger.kernel.org,
        linux-pci-owner@vger.kernel.org,
        Sam Bobroff <sam.bobroff@au1.ibm.com>
Subject: Re: [PATCH 1/1] PCI/AER: prevent pcie_do_fatal_recovery from using
 device after it is removed
In-Reply-To: <3f454ec4e96842286e1bfeba960f9f37bfcfaf6f.camel@kernel.crashing.org>
References: <1534179088-44219-1-git-send-email-thomas.tai@oracle.com>
 <1534179088-44219-2-git-send-email-thomas.tai@oracle.com>
 <51f4b387d9bd96a42d526a6a029fc43b@codeaurora.org>
 <b0104a716319d76e734c307cb4bedd9d@codeaurora.org>
 <903394c04d6ad468ed06dc0a779200e7555345a7.camel@kernel.crashing.org>
 <6cb069038530757f31f3dd60328c7e30@codeaurora.org>
 <e931bc7a7e468e8bb2ee3766b3fcf96f1800f552.camel@kernel.crashing.org>
 <bf7ceabb6fe51398e0f4eebd9c4fe4ac1ec2b8a4.camel@kernel.crashing.org>
 <3f454ec4e96842286e1bfeba960f9f37bfcfaf6f.camel@kernel.crashing.org>
Message-ID: <96ecbc5963993703381ffcdda093d147@codeaurora.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 2018-08-16 12:45, Benjamin Herrenschmidt wrote:
> On Thu, 2018-08-16 at 17:05 +1000, Benjamin Herrenschmidt wrote:
>> Those changes are utterly broken.
>> 
>> The basic premise of the design that we woudl do that unplug/replug
>> trick if and ONLY IF the driver doesn't have the appropriate 
>> callbacks.
>> 
>> We are also now looking at replacing this with an ubind/re-bind 
>> because
>> in practice, the unplugging is causing us all sort of problems. Sam
>> (CC) can elaborate.
>> 
>> Bjorn, we are the main authors of that spec (Linas wrote it under my
>> supervision) and created those callbacks for EEH. AER picked them up
>> only later. Those changes must be at the very least acked by us before
>> going upstream.
> 
> Also I had a quick look at the DPC spec, it looks like a subset of our
> EEH capability.
> 
> Again, the code in Linux was written without concertation with us,
> misunderstands/misuses the driver callbacks, does unplugs when it
> shouldn't etc...
> 
> It's all very broken.
> 
> Please, at the very least revert the spec changes. They are utterly
> wrong.
> 
> The driver MUST remain active during the recovery process *including*
> fatal errors.
> 
> Only if the recovery fails and the driver gives us may you chose to
> unplug the device (though there is little point).
> 
> What you have designed will work fine for network drivers but will not
> work for storage.
> 
> Ben.

Hi Ben,

If you look at original DPC driver it was doing exactly the same as it 
is doing now.
so with or without new changes DPC driver had the same behavior from 
beginning.

commit 26e515713342b6f7c553aa3c66b21c6ab7cf82af

Regards,
Oza.
