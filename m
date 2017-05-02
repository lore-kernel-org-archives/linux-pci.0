Return-Path: <SRS0=AgWd=4I=codeaurora.org=okaya@kernel.org>
Return-Path: <SRS0=AgWd=4I=codeaurora.org=okaya@kernel.org>
Subject: Re: [GIT PULL] PCI fixes for v4.10
To: Lukas Wunner <lukas@wunner.de>, "Raj, Ashok" <ashok.raj@intel.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org, Yinghai Lu <yinghai@kernel.org>,
 "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
 Mika Westerberg <mika.westerberg@linux.intel.com>,
 Keith Busch <keith.busch@intel.com>
References: <20170208192054.GA31395@bhelgaas-glaptop.roam.corp.google.com>
 <20170208192256.GB31395@bhelgaas-glaptop.roam.corp.google.com>
 <20170209040648.GA1304@wunner.de>
 <20170209150950.GA11905@bhelgaas-glaptop.roam.corp.google.com>
 <20170209182328.GB77900@otc-nc-03> <20170209184613.GA78375@otc-nc-03>
 <20170502015405.GA13918@wunner.de>
From: Sinan Kaya <okaya@codeaurora.org>
Message-ID: <65f46b49-950a-270f-8bc4-c3fb7513866e@codeaurora.org>
Date: Mon, 1 May 2017 22:41:20 -0400
MIME-Version: 1.0
In-Reply-To: <20170502015405.GA13918@wunner.de>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-pci.vger.kernel.org>

On 5/1/2017 9:54 PM, Lukas Wunner wrote:
> (b) ASPM L1 enabled on boot, but disabled after powering off and back on
>     => I believe Sinan is working on this (+cc).

The decision was made not to touch ASPM registers following hotplug insertion
unless pcie_aspm.policy=powersave is specified.

The discussion is here: https://lkml.org/lkml/2017/4/17/255

This was done to maintain existing behavior and not break things.

-- 
Sinan Kaya
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
