Return-Path: <SRS0=M0Me=2W=codeaurora.org=okaya@kernel.org>
Return-Path: <SRS0=M0Me=2W=codeaurora.org=okaya@kernel.org>
Subject: Re: [PATCH V3] PCI/ASPM: reconfigure ASPM following hotplug for
 POLICY_DEFAULT
To: Bjorn Helgaas <helgaas@kernel.org>
References: <1489005551-23598-1-git-send-email-okaya@codeaurora.org>
 <20170309222751.GD19517@bhelgaas-glaptop.roam.corp.google.com>
Cc: linux-pci@vger.kernel.org, timur@codeaurora.org,
 linux-arm-msm@vger.kernel.org, Mayurkumar Patel
 <mayurkumar.patel@intel.com>, open list <linux-kernel@vger.kernel.org>,
 linux-arm-kernel@lists.infradead.org
From: Sinan Kaya <okaya@codeaurora.org>
Message-ID: <48b14a37-3b5c-e128-aa96-b924d05b7636@codeaurora.org>
Date: Mon, 13 Mar 2017 17:06:46 -0400
MIME-Version: 1.0
In-Reply-To: <20170309222751.GD19517@bhelgaas-glaptop.roam.corp.google.com>
Content-Type: text/plain; charset=windows-1252
List-ID: <linux-pci.vger.kernel.org>

Hi Bjorn,

On 3/9/2017 5:27 PM, Bjorn Helgaas wrote:
> This is an aspect of the ASPM design that I don't like:
> 
>   - pcie_aspm_init_link_state() is called on a *bridge* after we've
>     enumerated any devices below the bridge, and we allocate the
>     link_state.
> 
>   - pcie_aspm_exit_link_state() is called on an *endpoint*, and if
>     we're removing the last endpoint below a bridge, we release the
>     *parent's* link_state.

I just posted V4 a minute ago. I divided ASPM init into two so that the
ASPM registers are captured in device_add path. 

There is a section of the ASPM init code that needs to walk all the devices
under the bridge. 

This section of the code is not working in device_add path as the link list
for child devices has not been set up yet. 

Unless you tell me there is a better way to handle this, I don't see how
we can remove the call from scan_slot. 

After further review, I think I can split PATCH V4 3/3 into two. Before
diving into too much clean up, I wanted to get some feedback as it is
obvious from the messed up cover letter.

Sinan


-- 
Sinan Kaya
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
