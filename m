Return-Path: <SRS0=nTun=ZE=codeaurora.org=okaya@kernel.org>
Return-Path: <SRS0=nTun=ZE=codeaurora.org=okaya@kernel.org>
Subject: Re: ASPM after Hotplug Question
To: Bjorn Helgaas <helgaas@kernel.org>
References: <7fea039c-5921-0c12-c7b4-991b4c27778f@codeaurora.org>
 <20170122144810.GD6619@bhelgaas-glaptop.roam.corp.google.com>
 <13ae3a56-76d5-e069-1c6c-67092c586029@codeaurora.org>
Cc: Linux PCI <linux-pci@vger.kernel.org>
From: Sinan Kaya <okaya@codeaurora.org>
Message-ID: <8dd6d5da-bab0-8f77-11b6-9982b02134ed@codeaurora.org>
Date: Sun, 22 Jan 2017 14:08:52 -0500
MIME-Version: 1.0
In-Reply-To: <13ae3a56-76d5-e069-1c6c-67092c586029@codeaurora.org>
Content-Type: text/plain; charset=windows-1252
List-ID: <linux-pci.vger.kernel.org>

[snip]

>>
>> Bjorn
>>
> 
> / # lspci
> 03:00:00.0 Class 0604: 17cb:0401
> 03:01:00.0 Class 0200: 8086:1572
> 03:01:00.1 Class 0200: 8086:1572
> 
> 
> It looks like ASPM is only getting configured for the root port following
> insertion.
> 
> Removal:
> [   32.142474] pci 0003:01:00.1: pcie_aspm_exit_link_state:662
> [   34.142378] pci 0003:01:00.0: pcie_aspm_exit_link_state:659
> 
> Insertion:
> [   35.910342] pcieport 0003:00:00.0: pcie_aspm_init_link_state:565
> [   35.931227] pcieport 0003:00:00.0: pcie_aspm_init_link_state:617
> 
> 551 void pcie_aspm_init_link_state(struct pci_dev *pdev)
> 552 {
> 553         struct pcie_link_state *link;
> 554         int blacklist = !!pcie_aspm_sanity_check(pdev);
> 555
> 556         if (!aspm_support_enabled) {
> 557                 dev_info(&pdev->dev, "%s:%d\n", __func__, __LINE__);
> 558                 return;
> 559         }
> 560
> 561         if (pdev->link_state) {
> 562                 dev_info(&pdev->dev, "%s:%d\n", __func__, __LINE__);
> 563                 return;
> 564         }
> 565         dev_info(&pdev->dev, "%s:%d\n", __func__, __LINE__);
> 
> 
> 551 void pcie_aspm_init_link_state(struct pci_dev *pdev)
> 552 {
> ...
> 
> 607          * At this stage drivers haven't had an opportunity to change the
> 608          * link policy setting. Enabling ASPM on broken hardware can cripple
> 609          * it even before the driver has had a chance to disable ASPM, so
> 610          * default to a safe level right now. If we're enabling ASPM beyond
> 611          * the BIOS's expectation, we'll do so once pci_enable_device() is
> 612          * called.
> 613          */
> 614         if (aspm_policy != POLICY_POWERSAVE) {
> 615                 pcie_config_aspm_path(link);
> 616                 pcie_set_clkpm(link, policy_to_clkpm_state(link));
> 617                 dev_info(&pdev->dev, "%s:%d\n", __func__, __LINE__);
> 618         } else {
> 619                 dev_info(&pdev->dev, "%s:%d\n", __func__, __LINE__);
> 620         }
> 
> 
> 
> 

Here is the exit path:

652 /* @pdev: the endpoint device */
653 void pcie_aspm_exit_link_state(struct pci_dev *pdev)
654 {
655         struct pci_dev *parent = pdev->bus->self;
656         struct pcie_link_state *link, *root, *parent_link;
657
658         if (!parent || !parent->link_state) {
659                 dev_info(&pdev->dev, "%s:%d\n", __func__, __LINE__);
660                 return;
661         }
662         dev_info(&pdev->dev, "%s:%d\n", __func__, __LINE__);


-- 
Sinan Kaya
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
