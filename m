Return-Path: <SRS0=nTun=ZE=codeaurora.org=okaya@kernel.org>
Return-Path: <SRS0=nTun=ZE=codeaurora.org=okaya@kernel.org>
Subject: Re: ASPM after Hotplug Question
To: Bjorn Helgaas <helgaas@kernel.org>
References: <7fea039c-5921-0c12-c7b4-991b4c27778f@codeaurora.org>
 <20170122144810.GD6619@bhelgaas-glaptop.roam.corp.google.com>
Cc: Linux PCI <linux-pci@vger.kernel.org>
From: Sinan Kaya <okaya@codeaurora.org>
Message-ID: <13ae3a56-76d5-e069-1c6c-67092c586029@codeaurora.org>
Date: Sun, 22 Jan 2017 14:06:57 -0500
MIME-Version: 1.0
In-Reply-To: <20170122144810.GD6619@bhelgaas-glaptop.roam.corp.google.com>
Content-Type: text/plain; charset=windows-1252
List-ID: <linux-pci.vger.kernel.org>

On 1/22/2017 9:48 AM, Bjorn Helgaas wrote:
> Hi Sinan,
> 
> On Sat, Jan 21, 2017 at 08:35:30PM -0500, Sinan Kaya wrote:
>> When I boot the system, I see the ASPM is working fine. After hotplug removal
>> and insertion, I see that the ASPM is disabled.
>>
>> I do not have any ASPM related kernel command line parameter and
>> the policy is default.
>>
>> ASPM gets configured by the firmware before the OS boots by default
>> unless powersave policy is passed to the kernel command line. 
>>
>> Is there a particular reason why we are not re-configuring ASPM after
>> hotplug insertion?
>>
>> I think default policy applies to power-up values but not for
>> the hotplug case.
>>
>> With similar reasoning, maximum payload size gets configured by
>> the firmware before boot. I see that the OS is re-configuring the
>> MPS settings following hotplug. 
>>
>> I feel like ASPM should have followed a similar policy.
> 
> Huh, I was just wondering whether ASPM would work on hot-added devices.
> 
> I think the ASPM enumeration path is ugly because we only call it for
> bridges, not for endpoints (pci_scan_slot() calls
> pcie_aspm_init_link_state() for "bus->self").  I'd like it better if
> we called it for *every* device from pci_configure_device() and let
> ASPM internally figure out whether this is a bridge or endpoint.
> 
> It looks like the intent is that pcie_aspm_init_link_state() allocates
> dev->link_state and configures ASPM on the link.  The hotplug remove
> *should* call pcie_aspm_exit_link_state() on the bridge to free
> dev->link_state, and the hotplug add should call
> pcie_aspm_init_link_state() again to reallocate dev->link_state and
> configure ASPM again.
> 
> But I'm not sure the remove path is correct.  It looks like
> pci_stop_dev() calls pcie_aspm_exit_link_state(dev) on the device
> we're removing, not on the bridge.  If that's the case, we won't free
> the dev->link_state, and when we call pcie_aspm_init_link_state()
> after the hotplug add, it will see that dev->link_state is already set
> and won't do anything.
> 
> You could add some instrumentation to pcie_aspm_init_link_state() and
> pcie_aspm_exit_link_state() to see what devices we call them for, and
> whether they actually do what they should.
> 
> Bjorn
> 

/ # lspci
03:00:00.0 Class 0604: 17cb:0401
03:01:00.0 Class 0200: 8086:1572
03:01:00.1 Class 0200: 8086:1572


It looks like ASPM is only getting configured for the root port following
insertion.

Removal:
[   32.142474] pci 0003:01:00.1: pcie_aspm_exit_link_state:662
[   34.142378] pci 0003:01:00.0: pcie_aspm_exit_link_state:659

Insertion:
[   35.910342] pcieport 0003:00:00.0: pcie_aspm_init_link_state:565
[   35.931227] pcieport 0003:00:00.0: pcie_aspm_init_link_state:617

551 void pcie_aspm_init_link_state(struct pci_dev *pdev)
552 {
553         struct pcie_link_state *link;
554         int blacklist = !!pcie_aspm_sanity_check(pdev);
555
556         if (!aspm_support_enabled) {
557                 dev_info(&pdev->dev, "%s:%d\n", __func__, __LINE__);
558                 return;
559         }
560
561         if (pdev->link_state) {
562                 dev_info(&pdev->dev, "%s:%d\n", __func__, __LINE__);
563                 return;
564         }
565         dev_info(&pdev->dev, "%s:%d\n", __func__, __LINE__);


551 void pcie_aspm_init_link_state(struct pci_dev *pdev)
552 {
...

607          * At this stage drivers haven't had an opportunity to change the
608          * link policy setting. Enabling ASPM on broken hardware can cripple
609          * it even before the driver has had a chance to disable ASPM, so
610          * default to a safe level right now. If we're enabling ASPM beyond
611          * the BIOS's expectation, we'll do so once pci_enable_device() is
612          * called.
613          */
614         if (aspm_policy != POLICY_POWERSAVE) {
615                 pcie_config_aspm_path(link);
616                 pcie_set_clkpm(link, policy_to_clkpm_state(link));
617                 dev_info(&pdev->dev, "%s:%d\n", __func__, __LINE__);
618         } else {
619                 dev_info(&pdev->dev, "%s:%d\n", __func__, __LINE__);
620         }




-- 
Sinan Kaya
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
