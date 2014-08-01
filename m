Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from nbfkord-smmo04.seg.att.com ([209.65.160.86]:9264 "EHLO
	nbfkord-smmo04.seg.att.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755234AbaHAMPq convert rfc822-to-8bit
	(ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Fri, 1 Aug 2014 08:15:46 -0400
Message-ID: <53DB84E6.1070206@solarflare.com>
Date: Fri, 1 Aug 2014 13:15:34 +0100
From: Edward Cree <ecree@solarflare.com>
MIME-Version: 1.0
To: Ethan Zhao <ethan.kernel@gmail.com>
CC: linux-pci <linux-pci@vger.kernel.org>,
	Alexander Duyck <alexander.h.duyck@intel.com>,
	Don Dutile <ddutile@redhat.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Vasundhara Volam <vasundhara.volam@emulex.com>
Subject: Re: [PATCH] PCI: handle pci_sriov_set_totalvfs(dev, 0)
References: <53D9288B.5030302@solarflare.com> <53D93407.8040308@redhat.com> <53D93848.7070203@solarflare.com> <53D9602A.4010406@intel.com> <53DA3180.5040302@solarflare.com> <alpine.LFD.2.03.1407311500570.16821@solarflare.com> <CABawtvPwxovKV==8RVCL1OcsdfnZDDjr=d1uYp-A=bAzYbmKww@mail.gmail.com>
In-Reply-To: <CABawtvPwxovKV==8RVCL1OcsdfnZDDjr=d1uYp-A=bAzYbmKww@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 01/08/14 04:51, Ethan Zhao wrote:
> Though I like this patch, it shows direct style, but it will change
> the meaning of a function not mentioned here.
>
>   int pci_sriov_set_totalvfs(struct pci_dev *dev, u16 numvfs)
Am I missing something here, or is that exactly the function mentioned
in the patch title / subject line?

> So far seems no driver call pci_sriov_set_totalvfs() with numvfs = 0
> and the patch will change the behavior of the drivers, but it will
> definitely change the test cases and documents related to IOV.
As for test cases and documents, I can't find any in the kernel tree -
if I grep for pci_sriov_set_totalvfs, the only mentions I find are:
* The declaration in include/linux/pci.h.  Doesn't have any comments.
* The definition in drivers/pci/iov.c.  The comment doesn't document the
behaviour in the numvfs = 0 case.
* Documentation/ABI/testing/sysfs-bus-pci.  Describes the function's
purpose "reduce the value read from [the sriov_totalvfs sysfs file]" but
doesn't say anything about the numvfs = 0 case.
* the Intel igb and ixgbe ethernet drivers.  Both pass nonzero constants
for numvfs.
* the Emulex benet driver.  This went into Dave Miller's net-next branch
on 30/06/2014 (so hasn't hit Linus' or other trees yet), but it looks to
me like it might call with numvfs = 0.  CCing the author of that patch
(Vasundhara Volam) for comments.

-Edward
The information contained in this message is confidential and is intended for the addressee(s) only. If you have received this message in error, please notify the sender immediately and delete the message. Unless you are an addressee (or authorized to receive for an addressee), you may not use, copy or disclose to anyone this message or any information contained in this message. The unauthorized use, disclosure, copying or alteration of this message is strictly prohibited.
