Return-Path: <linux-kernel-owner@vger.kernel.org>
Subject: Re: [PATCH 1/5] iov: Update virtfn_max_buses to validate offset and
 stride
To: Bjorn Helgaas <helgaas@kernel.org>,
	Alexander Duyck <aduyck@mirantis.com>
References: <20151027204607.14626.59671.stgit@localhost.localdomain>
 <20151027205215.14626.93504.stgit@localhost.localdomain>
 <20151028163216.GA2927@localhost>
Cc: bhelgaas@google.com, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
From: Alexander Duyck <alexander.duyck@gmail.com>
Message-ID: <56310C78.6030703@gmail.com>
Date: Wed, 28 Oct 2015 10:57:12 -0700
MIME-Version: 1.0
In-Reply-To: <20151028163216.GA2927@localhost>
Content-Type: text/plain; charset=windows-1252; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 10/28/2015 09:32 AM, Bjorn Helgaas wrote:
> Hi Alex,
>
> Thanks a lot for cleaning this up.  I think this is a great
> improvement over what I did.
>
> On Tue, Oct 27, 2015 at 01:52:15PM -0700, Alexander Duyck wrote:
>> This patch pulls the validation of offset and stride into virtfn_max_buses.
>> The general idea is to validate offset and stride for each possible value
>> of numvfs in addition to still determining the maximum bus value for the
>> VFs.
>>
>> I also reversed the loop as the most likely maximum will be when numvfs is
>> set to total_VFs.  In addition this makes it so that we loop down to a
>> value of 0 for numvfs which should be the resting state for the register.
>>
>> Fixes: 8e20e89658f2 ("PCI: Set SR-IOV NumVFs to zero after enumeration")
>> Signed-off-by: Alexander Duyck <aduyck@mirantis.com>
>
> I'd like to squash this together with my patch instead of having fixes
> on top of fixes.  What do you think of the following?  (This applies
> on top of 70675e0b6a1a ("PCI: Don't try to restore VF BARs")).
>
>
> commit c20e11b572c5d4e4f01c86580a133122fbd13cfa
> Author: Alexander Duyck <aduyck@mirantis.com>
> Date:   Wed Oct 28 10:54:32 2015 -0500
>
>      PCI: Set SR-IOV NumVFs to zero after enumeration
>
>      The enumeration path should leave NumVFs set to zero.  But after
>      4449f079722c ("PCI: Calculate maximum number of buses required for VFs"),
>      we call virtfn_max_buses() in the enumeration path, which changes NumVFs.
>      This NumVFs change is visible via lspci and sysfs until a driver enables
>      SR-IOV.
>
>      Iterate from TotalVFs down to zero so NumVFs is zero when we're finished
>      computing the maximum number of buses.  Validate offset and stride in
>      the loop, so we can test it at every possible NumVFs setting.  Rename
>      virtfn_max_buses() to compute_max_vf_buses() to hint that it does have a
>      side effect of updating iov->max_VF_buses.
>
>      [bhelgaas: changelog, rename, reverse sense of error path]
>      Fixes: 4449f079722c ("PCI: Calculate maximum number of buses required for VFs")
>      Based-on-patch-by: Ethan Zhao <ethan.zhao@oracle.com>
>      Signed-off-by: Alexander Duyck <aduyck@mirantis.com>
>      Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
>

This looks fine to me.

Acked-by: Alexander Duyck <aduyck@mirantis.com>

