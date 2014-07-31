Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from nbfkord-smmo04.seg.att.com ([209.65.160.86]:30131 "EHLO
	nbfkord-smmo04.seg.att.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751165AbaGaSNd convert rfc822-to-8bit
	(ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Thu, 31 Jul 2014 14:13:33 -0400
Message-ID: <53DA8745.2070405@solarflare.com>
Date: Thu, 31 Jul 2014 19:13:25 +0100
From: Edward Cree <ecree@solarflare.com>
MIME-Version: 1.0
To: Don Dutile <ddutile@redhat.com>
CC: Alexander Duyck <alexander.h.duyck@intel.com>,
	<linux-pci@vger.kernel.org>, Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH] PCI: handle pci_sriov_set_totalvfs(dev, 0)
References: <53D9288B.5030302@solarflare.com> <53D93407.8040308@redhat.com> <53D93848.7070203@solarflare.com> <53D9602A.4010406@intel.com> <53DA3180.5040302@solarflare.com> <alpine.LFD.2.03.1407311500570.16821@solarflare.com> <53DA5EF4.1030500@intel.com> <53DA674A.9030305@solarflare.com> <53DA718A.9040407@intel.com> <53DA7574.4050103@solarflare.com> <53DA82AF.7000503@redhat.com>
In-Reply-To: <53DA82AF.7000503@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 31/07/14 18:53, Don Dutile wrote:
> On 07/31/2014 12:57 PM, Edward Cree wrote:
>> Alas, it's (once again) more complicated than that.  There's another
>> mode, NIC partitioning, which has multiple PFs per port but connected
>> with a VLAN aggregator rather than a v-switch, which means that each PF
>> then can support VFs (the firmware limitation is that v-switches can't
>> be stacked).
>> So having multiple PFs on the port doesn't necessarily mean we can't do
>> SR-IOV.
>>
> Ed,
> It is fairly obvious that your PCIe device operates in very unexpected,
> non-std modes.
I really don't think it does.  As far as PCIe is concerned, the device
is behaving perfectly sanely: it claims to support VFs, and it does
support VFs.  You can add the VFs as PCIe functions just fine.  It's
just that the higher-layer entities those VFs give access to don't work
properly.

> Ignore twiddling total-vfs, and just have the driver fail sriov
> configuration when they can operate, print a warning why, and let's
> not create
> complicated/convoluted hacks dependent on the use of various
> assumptions/uses
> of pdev flags.
I don't like the idea of failing sriov configuration (I assume by this
you mean the pci_driver.sriov_configure function), simply because we
know at PF probe time that VFs won't work - so why advertise them?  We
have a pci_sriov_set_totalvfs function, why shouldn't it be used here?

> Ideally, when the device is configured in different modes, the SRIOV
> cap structure
> should be modified so the pci sriov code doesn't try to act or reflect
> the
> non-reality the device is in.
That would be much nicer of course, and I'll ask our firmware team if
that's possible.  But I don't think it will be.

-Edward
The information contained in this message is confidential and is intended for the addressee(s) only. If you have received this message in error, please notify the sender immediately and delete the message. Unless you are an addressee (or authorized to receive for an addressee), you may not use, copy or disclose to anyone this message or any information contained in this message. The unauthorized use, disclosure, copying or alteration of this message is strictly prohibited.
