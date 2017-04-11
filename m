Return-Path: <SRS0=N5Sh=3T=codeaurora.org=okaya@kernel.org>
Return-Path: <SRS0=N5Sh=3T=codeaurora.org=okaya@kernel.org>
Subject: Re: [PATCH V8 0/5] PCI/ASPM: reconfigure ASPM following hotplug for
 POLICY_DEFAULT
To: Bjorn Helgaas <helgaas@kernel.org>
References: <1491627351-1111-1-git-send-email-okaya@codeaurora.org>
 <20170411211924.GC14778@bhelgaas-glaptop.roam.corp.google.com>
Cc: linux-pci@vger.kernel.org, timur@codeaurora.org,
 linux-arm-msm@vger.kernel.org, mayurkumar.patel@intel.com,
 linux-arm-kernel@lists.infradead.org
From: Sinan Kaya <okaya@codeaurora.org>
Message-ID: <7b94bfbb-b3e6-cbc3-06a1-4490f4142ffe@codeaurora.org>
Date: Tue, 11 Apr 2017 17:27:59 -0400
MIME-Version: 1.0
In-Reply-To: <20170411211924.GC14778@bhelgaas-glaptop.roam.corp.google.com>
Content-Type: text/plain; charset=windows-1252
List-ID: <linux-pci.vger.kernel.org>

On 4/11/2017 5:19 PM, Bjorn Helgaas wrote:
> Hi Sinan,
> 
> What are these patches based on?  I normally apply things to my "master"
> branch, which is typically -rc1 or -rc2.  Right now it's v4.11-rc1, and
> these don't apply cleanly:
> 
>   04:17:59 ~/linux (master)$ stg branch --create pci/aspm-sk-v8 v4.11-rc1
>   Checking for changes in the working directory ... done
>   Don't know how to determine parent branch from "v4.11-rc1"
>   Branch "pci/aspm-sk-v8" created
>   04:18:18 ~/linux (pci/aspm-sk-v8)$ stg import -M --sign m/sk-v8
>   Checking for changes in the working directory ... done
>   Importing patch "pci-aspm-introduce" ... done
>   Importing patch "pci-aspm-split-pci_aspm_init" ... done
>   Importing patch "pci-aspm-add-init-hook-to" ... error: patch failed: drivers/pci/pcie/aspm.c:798
>   error: drivers/pci/pcie/aspm.c: patch does not apply
>   stg import: Diff does not apply cleanly

This is what I have.

41a7175 PCI/ASPM: move link_state cleanup to bridge remove
3b646e2 PCI/ASPM: save power on values during bridge init
181510d PCI/ASPM: add init hook to device_add
282d008 PCI/ASPM: split pci_aspm_init() into two
8e89fc2 PCI/ASPM: introduce pci_aspm_init() and add to pci_init_capabilities()
97da385 Linux 4.11-rc3


-- 
Sinan Kaya
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
