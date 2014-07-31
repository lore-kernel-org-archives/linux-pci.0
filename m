Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from nbfkord-smmo01.seg.att.com ([209.65.160.76]:10875 "EHLO
	nbfkord-smmo01.seg.att.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751013AbaGaMHd convert rfc822-to-8bit
	(ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Thu, 31 Jul 2014 08:07:33 -0400
Message-ID: <53DA3180.5040302@solarflare.com>
Date: Thu, 31 Jul 2014 13:07:28 +0100
From: Edward Cree <ecree@solarflare.com>
MIME-Version: 1.0
To: Alexander Duyck <alexander.h.duyck@intel.com>
CC: Don Dutile <ddutile@redhat.com>, <linux-pci@vger.kernel.org>
Subject: Re: pci_sriov_set_totalvfs again
References: <53D9288B.5030302@solarflare.com> <53D93407.8040308@redhat.com> <53D93848.7070203@solarflare.com> <53D9602A.4010406@intel.com>
In-Reply-To: <53D9602A.4010406@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 30/07/14 22:14, Alexander Duyck wrote:
> My $.02 on the issue would be to simply have sriov_configure return an
> error indicating the resources are not available if you have the
> PF-IOV mode enabled it is consuming the VF v-switch resources. Thanks,
> Alex
That would work, but I don't like the idea of saying (in sysfs
device/sriov_totalvfs) "I have some VFs" only to say "not really, ha"
when someone tries to use them.  At least, not when we knew all along.

Let's look at this from a different angle:
If I posted a patch to make pci_sriov_set_totalvfs(dev, 0) do what I
want, would there be any objections to taking it?  It seems like a sane
API, the only existing (in-tree) users never pass 0, and it shouldn't
require too ugly an implementation.

-Edward
The information contained in this message is confidential and is intended for the addressee(s) only. If you have received this message in error, please notify the sender immediately and delete the message. Unless you are an addressee (or authorized to receive for an addressee), you may not use, copy or disclose to anyone this message or any information contained in this message. The unauthorized use, disclosure, copying or alteration of this message is strictly prohibited.
