Return-Path: <SRS0=SbOF=2Y=codeaurora.org=okaya@kernel.org>
Return-Path: <SRS0=SbOF=2Y=codeaurora.org=okaya@kernel.org>
Subject: Re: [PATCH V4 0/3] PCI/ASPM: reconfigure ASPM following hotplug for
 POLICY_DEFAULT
To: Bjorn Helgaas <helgaas@kernel.org>
References: <1489438085-2055-1-git-send-email-okaya@codeaurora.org>
 <20170313214616.GE8232@bhelgaas-glaptop.roam.corp.google.com>
 <c6b78903-ea09-9719-7073-c679b0b64a05@codeaurora.org>
 <20170313230855.GG8232@bhelgaas-glaptop.roam.corp.google.com>
 <b44fa6b3-7db5-bea4-7f2e-7f880362d171@codeaurora.org>
 <20170314192138.GA26264@bhelgaas-glaptop.roam.corp.google.com>
Cc: linux-pci@vger.kernel.org, timur@codeaurora.org,
 linux-arm-msm@vger.kernel.org, mayurkumar.patel@intel.com,
 linux-arm-kernel@lists.infradead.org
From: Sinan Kaya <okaya@codeaurora.org>
Message-ID: <8fa282de-9896-0e2a-01cb-7146817268e6@codeaurora.org>
Date: Wed, 15 Mar 2017 10:33:53 -0400
MIME-Version: 1.0
In-Reply-To: <20170314192138.GA26264@bhelgaas-glaptop.roam.corp.google.com>
Content-Type: text/plain; charset=windows-1252
List-ID: <linux-pci.vger.kernel.org>

On 3/14/2017 3:21 PM, Bjorn Helgaas wrote:
> On Mon, Mar 13, 2017 at 07:21:42PM -0400, Sinan Kaya wrote:
>> On 3/13/2017 7:08 PM, Bjorn Helgaas wrote:
>>> On Mon, Mar 13, 2017 at 06:05:55PM -0400, Sinan Kaya wrote:
>>>> On 3/13/2017 5:46 PM, Bjorn Helgaas wrote:
>>>>> What is this series based on?  Unless they depend on other in-flight
>>>>> patches, I apply patches to branches based on my "master" branch,
>>>>> which is typically -rc1 or -rc2 (it's currently v4.11-rc1).  These
>>>>> don't apply to either.
>>>>
>>>> It looks like I am on 4.10. I can rebase and post again. 
>>>
>>> Rebasing would be good, but I can give you some comments on your v4,
>>> now that I can apply it and see what it looks like.
>>>
>>
>> Thanks, 
>>
>> I'm mostly done with the rebase. I'll have to retest tomorrow morning and
>> then post.
>>
>> I had to drop this
>>
>>    - for endpoints, have pcie_aspm_init_link_state() do the actual ASPM
>>       setup of the link as it currently does.
>>
>> during rebase.
>>
>> The reason is that the clock configuration needs to switch to common clock
>> mode across all the devices before any ASPM latency is read/configured.
>>
>> Common clock configuration seem to be trying to walk the device list.
>>
>> Here is the untested version. It might not even compile.
>> I'll wait until I receive your comments.
> 
> I had already started looking at v4, so these comments are based on
> that.  Your v4 is a great start and these are all general comments so
> I didn't try to match each one up with the code.
> 
>   - Goal: retain BIOS ASPM config of bridge even if children are
>     removed and re-added.  Is there a bugzilla for this problem?

No, I do not have a bugzilla.

> 
>   - pci_aspm_init(): Fix function comment.  Called for every device we
>     enumerate.  

Sure.

>     Maybe split body into pci_aspm_init_upstream() (the
>     has_secondary_link part) and pci_aspm_init_downstream() (or maybe
>     these end up being similar enough that splitting doesn't make
>     sense).  I don't think we should need locking in either case
>     because this is a new device we're in the process of enumerating.

I'll get rid of the locking. 
> 
>     - Upstream link partner:  Shouldn't need to check pdev->link_state
>       (should always be NULL for a brand-new device).  Should allocate
>       link_state and capture everything that doesn't depend on the
>       downstream link partner, i.e., all DEVCAP & LNKCAP info (this
>       includes the initial BIOS config you're after).

Yup, this is done on my last patch. I moved it to a separate patch to make
it obvious. Once I finish incorporating your comments and tests, I'll post
the updated version.

> 
>     - Downstream link partner: (devices where dev->has_secondary_link
>       is not set).  Capture device-specific state, i.e., DEVCAP &
>       LNKCAP info, exit latencies and latency requirements.  The
>       sanity check/blacklist stuff only depends on the downstream link
>       partner and maybe could be computed and saved here, e.g., in a
>       new pdev->aspm_blacklist or pdev->link->blacklist.  

I removed reading upstream device specific pieces out of this function on
the last patch. The reason is that common clock may not have been set up
by the time we reach to this function. Any register reads from capabilities
will be incorrect until we switch to common clock and switching to common
clock requires walking the children objects.

> 
>       Probably should not *write* to any hardware configuration, e.g.,
>       common clock configuration, because some of that depends on all
>       siblings, and we haven't enumerated them all yet.  The hardware
>       configuration should probably be done in
>       pcie_aspm_init_link_state().

Even reading the capabilities are incorrect. Devices maintain two sets of
capabilities. One for common clock and one without common clock. We would
be reading the incorrect one based on whether common clock is setup or not
during boot.

> 
>   - pcie_aspm_init_link_state(): Called for bridges (upstream end of
>     link) after all children have been enumerated.  No longer needs to
>     check aspm_support_enabled or pdev->has_secondary_link or the VIA
>     quirk: pci_aspm_init() already checked that stuff, so we only need
>     to check pdev->link_state here.  Probably should do the common
>     clock config here instead of in pci_aspm_init().

I agree. This is the correct place. I'll remove the extra checks. The only
thing that I do not understand well is the VIA configuration and I'm afraid
I'm going to break it. 

> 
>   - pcie_aspm_configure_common_clock(): I don't think you touched
>     this, but this might be a good opportunity to move the re-read
>     (pcie_get_aspm_reg() stuff) into this function so it doesn't
>     clutter the caller?  Could be a preliminary cleanup patch.
> 
>     PCI_EXP_LNKSTA_SLC is HwInit, which means it's read-only and could
>     be captured at pci_aspm_init()-time.  Currently we only look at
>     SLC for the first child, but pci_aspm_init_upstream() could set a
>     link->downstream_slc bit, and pci_aspm_init_downstream() could
>     clear it if it found a device with SLC not set.
> 

Let me look at these more.

-- 
Sinan Kaya
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
