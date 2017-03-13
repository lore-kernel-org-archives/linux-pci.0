Return-Path: <SRS0=Ad0z=2W=intel.com=mayurkumar.patel@kernel.org>
Return-Path: <SRS0=Ad0z=2W=intel.com=mayurkumar.patel@kernel.org>
From: "Patel, Mayurkumar" <mayurkumar.patel@intel.com>
To: Sinan Kaya <okaya@codeaurora.org>, Bjorn Helgaas <helgaas@kernel.org>
CC: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"timur@codeaurora.org" <timur@codeaurora.org>,
	"linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>, open list
	<linux-kernel@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>
Subject: RE: [PATCH V3] PCI/ASPM: reconfigure ASPM following hotplug for
 POLICY_DEFAULT
Date: Mon, 13 Mar 2017 08:49:30 +0000
Message-ID: <92EBB4272BF81E4089A7126EC1E7B28466670D75@IRSMSX101.ger.corp.intel.com>
References: <1489005551-23598-1-git-send-email-okaya@codeaurora.org>
 <20170309222751.GD19517@bhelgaas-glaptop.roam.corp.google.com>
 <ec7ee607-60f3-7e1a-b1cd-8e4534ab98eb@codeaurora.org>
In-Reply-To: <ec7ee607-60f3-7e1a-b1cd-8e4534ab98eb@codeaurora.org>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-ID: <linux-pci.vger.kernel.org>


>
>Hi Bjorn,
>
>On 3/9/2017 5:27 PM, Bjorn Helgaas wrote:
>> How hard do you think it would be to rework this path slightly so we:
>>
>>   - call pcie_aspm_init_link_state() for every device, maybe from
>>     pci_init_capabilities()
>>
>>   - for bridges, have pcie_aspm_init_link_state() allocate a
>>     link_state, regardless of whether it currently has any children,
>>     and save the ASPM settings done by firmware
>>
>>   - for endpoints, have pcie_aspm_init_link_state() do the actual ASPM
>>     setup of the link as it currently does
>>
>>   - for endpoints, change pcie_aspm_exit_link_state() so it cleans up
>>     the device's own state and disables ASPM if necessary, but doesn't
>>     remove the parent's link_state
>>
>>   - for bridges, change pcie_aspm_exit_link_state() so it frees the
>>     bridge's own link_state
>
>Thanks for the feedback, Let me take a stab at this.
>Sinan

Thanks Bjorn and Sinan. I will wait for new patch-sets from Sinan.

>
>--
>Sinan Kaya
>Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technol=
ogies, Inc.
>Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux =
Foundation Collaborative Project.
Intel Deutschland GmbH
Registered Address: Am Campeon 10-12, 85579 Neubiberg, Germany
Tel: +49 89 99 8853-0, www.intel.de
Managing Directors: Christin Eisenschmid, Christian Lamprechter
Chairperson of the Supervisory Board: Nicole Lau
Registered Office: Munich
Commercial Register: Amtsgericht Muenchen HRB 186928
