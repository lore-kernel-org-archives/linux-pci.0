Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from nbfkord-smmo03.seg.att.com ([209.65.160.84]:15985 "EHLO
	nbfkord-smmo03.seg.att.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752753AbaHDODi convert rfc822-to-8bit
	(ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Mon, 4 Aug 2014 10:03:38 -0400
Message-ID: <53DF92B4.1040505@solarflare.com>
Date: Mon, 4 Aug 2014 15:03:32 +0100
From: Edward Cree <ecree@solarflare.com>
MIME-Version: 1.0
To: Don Dutile <ddutile@redhat.com>
CC: Alexander Duyck <alexander.h.duyck@intel.com>,
	<linux-pci@vger.kernel.org>, Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH] PCI: handle pci_sriov_set_totalvfs(dev, 0)
References: <53D9288B.5030302@solarflare.com> <53D93407.8040308@redhat.com> <53D93848.7070203@solarflare.com> <53D9602A.4010406@intel.com> <53DA3180.5040302@solarflare.com> <alpine.LFD.2.03.1407311500570.16821@solarflare.com> <53DA5EF4.1030500@intel.com> <53DA674A.9030305@solarflare.com> <53DA718A.9040407@intel.com> <53DA7574.4050103@solarflare.com> <53DA82AF.7000503@redhat.com> <53DA8745.2070405@solarflare.com>
In-Reply-To: <53DA8745.2070405@solarflare.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 31/07/14 19:13, Edward Cree wrote:
> On 31/07/14 18:53, Don Dutile wrote:
>> Ideally, when the device is configured in different modes, the SRIOV
>> cap structure
>> should be modified so the pci sriov code doesn't try to act or reflect
>> the
>> non-reality the device is in.
> That would be much nicer of course, and I'll ask our firmware team if
> that's possible.  But I don't think it will be.
As I feared, it's not practical for the device to do this.
(Unfortunately, the IMEM (instruction memory) on the device is rather
small and the firmware team are struggling to fit all the required
features into it.)
However, I also found out that in principle, the device _is_ capable of
supporting VFs in PF-IOV mode, by attaching them directly to the
underlying v-switch.  The firmware may or may not already do this; the
person who's likely to know this isn't in today.  The driver at present
doesn't support it because it assumes it always needs to attach VFs to
its own v-switch, but it could (again, in principle) be taught otherwise.

So at this point it becomes a policy question of whether we want to
support this, and our opinion is that this isn't a valid use-case (as
the only time you'd want PF-IOV is if your system doesn't support VFs)
and thus shouldn't be supported (as it creates extra testing and
maintenance work).  The driver should probe the device, detect PF-IOV
mode, recognise that it (the driver) doesn't have support for VFs in
that mode, and set totalvfs to 0.
Others may demur, of course, but that's likely to be decided when
sending the driver patches to davem.  It's my belief that, uncertainty
about my use case notwithstanding, pci_sriov_set_totalvfs(dev, 0) should
be a valid operation with the semantics I've implemented in my patch.

-Edward
The information contained in this message is confidential and is intended for the addressee(s) only. If you have received this message in error, please notify the sender immediately and delete the message. Unless you are an addressee (or authorized to receive for an addressee), you may not use, copy or disclose to anyone this message or any information contained in this message. The unauthorized use, disclosure, copying or alteration of this message is strictly prohibited.
