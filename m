Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:17383 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752615AbaHFNim (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Wed, 6 Aug 2014 09:38:42 -0400
Message-ID: <53E1F793.3050106@redhat.com>
Date: Wed, 06 Aug 2014 05:38:27 -0400
From: Don Dutile <ddutile@redhat.com>
MIME-Version: 1.0
To: Alexander Duyck <alexander.h.duyck@intel.com>
CC: Edward Cree <ecree@solarflare.com>, linux-pci@vger.kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH] PCI: handle pci_sriov_set_totalvfs(dev, 0)
References: <53D9288B.5030302@solarflare.com> <53D93407.8040308@redhat.com> <53D93848.7070203@solarflare.com> <53D9602A.4010406@intel.com> <53DA3180.5040302@solarflare.com> <alpine.LFD.2.03.1407311500570.16821@solarflare.com> <53DA5EF4.1030500@intel.com> <53DA674A.9030305@solarflare.com> <53DA718A.9040407@intel.com> <53DA7574.4050103@solarflare.com> <53DA82AF.7000503@redhat.com> <53DA8745.2070405@solarflare.com> <53DF92B4.1040505@solarflare.com> <53DF9A9F.9060600@intel.com>
In-Reply-To: <53DF9A9F.9060600@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 08/04/2014 10:37 AM, Alexander Duyck wrote:
> On 08/04/2014 07:03 AM, Edward Cree wrote:
>> On 31/07/14 19:13, Edward Cree wrote:
>>> On 31/07/14 18:53, Don Dutile wrote:
>>>> Ideally, when the device is configured in different modes, the SRIOV
>>>> cap structure
>>>> should be modified so the pci sriov code doesn't try to act or reflect
>>>> the
>>>> non-reality the device is in.
>>> That would be much nicer of course, and I'll ask our firmware team if
>>> that's possible.  But I don't think it will be.
>> As I feared, it's not practical for the device to do this.
>> (Unfortunately, the IMEM (instruction memory) on the device is rather
>> small and the firmware team are struggling to fit all the required
>> features into it.)
>> However, I also found out that in principle, the device _is_ capable of
>> supporting VFs in PF-IOV mode, by attaching them directly to the
>> underlying v-switch.  The firmware may or may not already do this; the
>> person who's likely to know this isn't in today.  The driver at present
>> doesn't support it because it assumes it always needs to attach VFs to
>> its own v-switch, but it could (again, in principle) be taught otherwise.
>>
>> So at this point it becomes a policy question of whether we want to
>> support this, and our opinion is that this isn't a valid use-case (as
>> the only time you'd want PF-IOV is if your system doesn't support VFs)
>> and thus shouldn't be supported (as it creates extra testing and
>> maintenance work).  The driver should probe the device, detect PF-IOV
>> mode, recognise that it (the driver) doesn't have support for VFs in
>> that mode, and set totalvfs to 0.
>> Others may demur, of course, but that's likely to be decided when
>> sending the driver patches to davem.  It's my belief that, uncertainty
>> about my use case notwithstanding, pci_sriov_set_totalvfs(dev, 0) should
>> be a valid operation with the semantics I've implemented in my patch.
>>
>> -Edward
>
> How is it you get yourself into the PF-IOV mode?  Is this something that
> is stored in the NVM of the adapter, or is it something where the driver
> has to issue a request for it?  Also does each PF advertise SR-IOV
> support in PF-IOV mode or only function 0?
>
> Modifying the total VFs and/or the initial VFs in the configuration
> space is not practical.  You would likely run into issues as one of
> these fields is read at probe time and the other is read at SR-IOV
> enablement and if the two differ you cannot enable SR-IOV.
>
> I'm not sure what davem has to do with any of this.  We are discussing
> PCI at this point, not the network drivers.  As such Dave won't be the
> one accepting the pci_sriov_set_totalvfs changes you proposed.  If you
> are just wanting to get a patch through Dave for this you would be much
> better off just returning an error on sriov_configure if the vswitch
> isn't available rather than trying to change the SR-IOV API to match
> your use case.
>
> Thanks,
>
> Alex
>
+1 to the points Alex makes.
This is a device-specific issue that can be handled with device-specific
changes, leaving the existing PCI SRIOV infrastructure working as-is.
pci_sriov_set_totalvfs() was not designed to disable SRIOV for a device,
merely adjust it's max number reported in the config structure, which is
common in a number of PCIe-SRIOV devices.  returning failure on sriov_configure()
is the proper solution for this device in this state... no different then
if some other failure occurred in the device to fail sriov configuration.

Nack to this patch request.


>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>

