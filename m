Return-Path: <SRS0=BHG1=3V=mellanox.com=bodong@kernel.org>
Return-Path: <SRS0=BHG1=3V=mellanox.com=bodong@kernel.org>
Subject: Re: [v3] PCI: Add an option to control probing of VFs before enabling
 SR-IOV
To: Gavin Shan <gwshan@linux.vnet.ibm.com>, Alex Williamson
	<alex.williamson@redhat.com>
References: <1492037500-84654-1-git-send-email-bodong@mellanox.com>
 <20170412205614.429db99c@t450s.home> <20170413052450.GA32407@gwshan>
CC: <helgaas@kernel.org>, <linux-pci@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <saeedm@mellanox.com>, Eli Cohen
	<eli@mellanox.com>
From: Bodong Wang <bodong@mellanox.com>
Message-ID: <d093fccd-94c8-825a-2b95-35163a872a1d@mellanox.com>
Date: Thu, 13 Apr 2017 09:16:34 -0500
MIME-Version: 1.0
In-Reply-To: <20170413052450.GA32407@gwshan>
Content-Type: text/plain; charset="windows-1252"; format=flowed
List-ID: <linux-pci.vger.kernel.org>

On 4/13/2017 12:24 AM, Gavin Shan wrote:
> On Wed, Apr 12, 2017 at 08:56:14PM -0600, Alex Williamson wrote:
>> On Thu, 13 Apr 2017 01:51:40 +0300
>> bodong@mellanox.com wrote:
>>
>>> From: Bodong Wang <bodong@mellanox.com>
>>>
>>> Sometimes it is not desirable to probe the virtual functions after
>>> SRIOV is enabled. This can save host side resource usage by VF
>>> instances which would be eventually probed to VMs.
>>>
>>> Add a new PCI sysfs interface "sriov_drivers_autoprobe" to control
>>> that from the PF, all current callers still retain the same
>>> functionality. To modify it, echo 0/n/N (disable probe) or 1/y/Y
>>> (enable probe) to:
>>>
>>> /sys/bus/pci/devices/<DOMAIN:BUS:DEVICE.FUNCTION>/sriov_drivers_autoprobe
>>>
>>> Note that, the choice must be made before enabling VFs. The change
>>> will not take effect if VFs are already enabled. Simply, one can set
>>> sriov_numvfs to 0, choose whether to probe or not, and then resume
>>> sriov_numvfs.
>>>
>>> Signed-off-by: Bodong Wang <bodong@mellanox.com>
>>> Signed-off-by: Eli Cohen <eli@mellanox.com>
>>> Reviewed-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
>>> Reviewed-by: Alex Williamson <alex.williamson@redhat.com>
>> Whoa, I reviewed the last version, that's different than providing a
>> Reviewed-by, and I've certainly never seen this version until now, so I
>> can't possibly have endorsed it in any way.  It's also changed since
>> Gavin saw it and I think Bjorn is in the same boat.  Probably a good
>> idea to cc the people you're claiming reviewed this too (cc +Gavin).
>>
> Thanks, Alex. I usually keep an eye on the patches that I ever
> reviewed and follow them until they are merged or rejected. More
> comments would be given if I have. Otherwise, everthing is fine.
> Yes, it's always nice to copy those who reviewed the patch.
>
> For this one, my reviewed-by is still valid.
>
> Thanks,
> Gavin
>
Thanks Alex/Gavin for the suggestion. Will follow this pattern in the 
future.
