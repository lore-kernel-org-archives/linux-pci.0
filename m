Return-Path: <SRS0=WMCN=3W=codeaurora.org=okaya@kernel.org>
Return-Path: <SRS0=WMCN=3W=codeaurora.org=okaya@kernel.org>
Subject: Re: [PATCH V8 4/5] PCI/ASPM: save power on values during bridge init
To: Bjorn Helgaas <helgaas@kernel.org>
References: <1491627351-1111-1-git-send-email-okaya@codeaurora.org>
 <1491627351-1111-5-git-send-email-okaya@codeaurora.org>
 <CACK8Z6GXfMWxakNQnvMToig9z9McnJKeYFc2BAAFy7ys8=PUWg@mail.gmail.com>
 <d3857812-7e03-4b62-f7cb-ac0d139b6123@codeaurora.org>
 <20170414214452.GA21870@bhelgaas-glaptop.roam.corp.google.com>
Cc: Rajat Jain <rajatja@google.com>,
 "Patel, Mayurkumar" <mayurkumar.patel@intel.com>,
 Rajat Jain <rajatxjain@gmail.com>, David Daney <david.daney@cavium.com>,
 linux-pci@vger.kernel.org, timur@codeaurora.org,
 linux-kernel@vger.kernel.org, Julia Lawall <Julia.Lawall@lip6.fr>,
 linux-arm-msm@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
 Yinghai Lu <yinghai@kernel.org>, Shawn Lin <shawn.lin@rock-chips.com>,
 linux-arm-kernel@lists.infradead.org, Myron Stowe <myron.stowe@redhat.com>
From: Sinan Kaya <okaya@codeaurora.org>
Message-ID: <66168dde-7719-6f74-3f06-8e4724dd2918@codeaurora.org>
Date: Fri, 14 Apr 2017 18:17:02 -0400
MIME-Version: 1.0
In-Reply-To: <20170414214452.GA21870@bhelgaas-glaptop.roam.corp.google.com>
Content-Type: text/plain; charset=windows-1252
List-ID: <linux-pci.vger.kernel.org>

On 4/14/2017 5:44 PM, Bjorn Helgaas wrote:
> I think there's an argument to be made that if we care about ASPM
> configuration, we should be using a non-POLICY_DEFAULT setting.  And I
> think there's value in having POLICY_DEFAULT be the absolute lowest-
> risk setting, which I think means option 1.
> 
> What do you think?

I see your point. The counter argument is that most of the users do not
know what an ASPM kernel command line is unless they understand PCI
language. 

I have been using the powersave policy option until now. I recently realized
that nobody except me is using this option. Therefore, we are wasting
power by default following a hotplug insertion.

This is the case where I'm trying to avoid. With the introduction of NVMe
u.2 drives, hotplug is becoming more and more mainstream. I decided to
take the matters into my hand with this series for this very reason.

Like you said, BIOS is out of the picture with pciehp. There is nobody
to configure ASPM following a hotplug insertion.

I can also claim that If user wants performance, they should boot with
the performance policy or pcie_aspm=off parameters. 

I saw this recommendation in multiple DPDK tuning documents.

Like you said, what do we do by default is the question. Should we opt
for safe like we are doing, or try to save some power.

Maybe, we are missing a HPP option from the PCI spec.

-- 
Sinan Kaya
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
