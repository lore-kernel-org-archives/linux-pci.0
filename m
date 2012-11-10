Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-bk0-f46.google.com ([209.85.214.46]:47712 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751154Ab2KJXOc (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Sat, 10 Nov 2012 18:14:32 -0500
Received: by mail-bk0-f46.google.com with SMTP id jk13so1991231bkc.19
        for <linux-pci@vger.kernel.org>; Sat, 10 Nov 2012 15:14:30 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <CAErSpo7CBwBs5YhS3+GPew3yufMv4KLs9tW2ogmUKLRrmpL+qA@mail.gmail.com>
References: <1352146841-64458-1-git-send-email-ddutile@redhat.com>
	<1352146841-64458-4-git-send-email-ddutile@redhat.com>
	<CAE9FiQWx64YeLp=3fUCuOvZFQbyKxYd400azFvvi=oLYtQDbcA@mail.gmail.com>
	<CAE9FiQX2tNX25O1pcEzn6nvc7BxFCx0t2UKD11y-=17FhOmC+Q@mail.gmail.com>
	<CAErSpo7CBwBs5YhS3+GPew3yufMv4KLs9tW2ogmUKLRrmpL+qA@mail.gmail.com>
Date: Sat, 10 Nov 2012 15:14:30 -0800
Message-ID: <CAE9FiQWyaezexZwT3AgKD9cSuyD9M_JxNJAqJVFRyOLYOo4VvA@mail.gmail.com>
Subject: Re: [PATCH 3/4] PCI,sys: SRIOV control and status via sysfs
From: Yinghai Lu <yinghai@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Donald Dutile <ddutile@redhat.com>, linux-pci@vger.kernel.org,
	yuvalmin@broadcom.com, bhutchings@solarflare.com,
	gregory.v.rose@intel.com, davem@davemloft.net
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Sat, Nov 10, 2012 at 1:16 PM, Bjorn Helgaas <bhelgaas@google.com> wrote:
> On Sat, Nov 10, 2012 at 12:31 AM, Yinghai Lu <yinghai@kernel.org> wrote:
>> On Fri, Nov 9, 2012 at 10:47 PM, Yinghai Lu <yinghai@kernel.org> wrote:
>>> On Mon, Nov 5, 2012 at 12:20 PM, Donald Dutile <ddutile@redhat.com> wrote:
>>>>
>>>>  static const struct attribute_group *pci_dev_attr_groups[] = {
>>>>         &pci_dev_attr_group,
>>>> +#ifdef CONFIG_PCI_IOV
>>>> +       &sriov_dev_attr_group,
>>>> +#endif
>>>
>>> should move sriov_dev_attr_group related code to
>>> drivers/pci/iov.c
>>> or driver/pci/iov_sysfs.c
>>>
>>> and kill those CONFIG_IOV.
>>
>> Bjorn,
>>
>> please check attached patch that separate sriov_dev_attr_group out.
>> it is against to your pci/don-sriov branch.
>
> The convention is to include patches inline, which makes them easier
> to review.  I know gmail makes that hard.  I use mutt or stacked git
> to do it.

yes, gmail web client should support plain attachment.

so you are using mutt with smtp enabled ?

>
> I'm not opposed to moving the SR-IOV sysfs stuff out of pci-sysfs.c.
> Since these patches haven't been merged yet, you should work it out
> with Don first, so we can merge it in the right place to begin with,
> rather than merging them and then immediately moving them.

sure. it should be out of pci-sysfs.c at first place.

I thought that you are going to merge your pci/don-sriov.

BTW, when you redo pci/don-sriov, please add acked-by from GregKH for
first two patches.

>
> Personally, I would put it all in pci/iov.c rather than creating a new
> file just for this.  That would also avoid the question of whether it
> should be "iov_sysfs.c" or "iov-sysfs.c".  All the other files in
> drivers/pci use a hyphen.  All the files in subdirectories of
> drivers/pci use an underscore.  A minor but annoying difference.

yeah, looks like should be iov-sysfs.c to keep them consistent.

iov.c is already about 800 lines. better not to stuff more code into it anymore.

Yinghai
