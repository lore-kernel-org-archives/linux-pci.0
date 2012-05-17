Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:39259 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S967636Ab2EQTLE (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Thu, 17 May 2012 15:11:04 -0400
Message-ID: <4FB54D49.8040302@redhat.com>
Date: Thu, 17 May 2012 15:11:05 -0400
From: Don Dutile <ddutile@redhat.com>
MIME-Version: 1.0
To: Prarit Bhargava <prarit@redhat.com>
CC: linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH] pci, Add AER_panic sysfs file
References: <1337274270-18785-1-git-send-email-prarit@redhat.com> <4FB548A8.9010003@redhat.com> <4FB54960.5080500@redhat.com>
In-Reply-To: <4FB54960.5080500@redhat.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 05/17/2012 02:54 PM, Prarit Bhargava wrote:
>
>>> +    if (dev->rp_AER_panic)
>>> +        panic("%s: AER detected on Root Port", pci_name(dev));
>>> +
>> It'd be more informative if the Root Port D:B:D.F was printed out above,
>> so one knows where the errors are coming from the system.  More likely than
>> not, the root is ok, but a device dangling from it is the 'root cause' (all pun
>> intended)
>> of the error.
>
> That's what pci_name() is.
>
> P.

ok. When I find where it's set, and what values it can be (init_name, vs kobject->name)
at what times in the kernel boot.



