Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:48342 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755417AbeEaPyV (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 31 May 2018 11:54:21 -0400
Subject: Re: [PATCH] PCI: Check for PCIe downtraining conditions
To: "Alex G." <mr.nuke.me@gmail.com>, Alex_Gagniuc@Dellteam.com,
        bhelgaas@google.com
Cc: Austin.Bolen@dell.com, Shyam.Iyer@dell.com, keith.busch@intel.com,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20180531150535.9684-1-mr.nuke.me@gmail.com>
 <28004506-24f0-6d10-2d1e-074e0483d2f9@codeaurora.org>
 <4e0611c872054e768daa96b302651db3@ausx13mps321.AMER.DELL.COM>
 <f260078b-6918-7fd9-39d6-e9f300e4c048@codeaurora.org>
 <3b8a895b-3080-7ddb-cbfd-5aa972e9bf65@gmail.com>
From: Sinan Kaya <okaya@codeaurora.org>
Message-ID: <35563ce3-e235-096c-4b9b-5f3664d67d0f@codeaurora.org>
Date: Thu, 31 May 2018 11:54:18 -0400
MIME-Version: 1.0
In-Reply-To: <3b8a895b-3080-7ddb-cbfd-5aa972e9bf65@gmail.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 5/31/2018 11:46 AM, Alex G. wrote:
>> https://lkml.org/lkml/2018/3/30/553
> Oh, pcie_get_speed_cap()/pcie_get_width_cap() seems to handle the
> capability. Not seeing one for status and speed name.
> 
>> are you working on linux-next?
> v4.17-rc7
> 

I think everything you need is in the series. I don't know which linux
tree this landed or if it landed. Probably, it is shipping for 4.18. 
Need some help from Bjorn where to locate these.

Fri, 30 Mar 2018 16:04:40 -0500

Bjorn Helgaas (6):
      bnx2x: Report PCIe link properties with pcie_print_link_status()
      bnxt_en: Report PCIe link properties with pcie_print_link_status()
      cxgb4: Report PCIe link properties with pcie_print_link_status()
      fm10k: Report PCIe link properties with pcie_print_link_status()
      ixgbe: Report PCIe link properties with pcie_print_link_status()
      PCI: Remove unused pcie_get_minimum_link()

Tal Gilboa (8):
      PCI: Add pcie_get_speed_cap() to find max supported link speed
      PCI: Add pcie_get_width_cap() to find max supported link width
      PCI: Add pcie_bandwidth_capable() to compute max supported link bandwidth
      PCI: Add pcie_bandwidth_available() to compute bandwidth available to device
      PCI: Add pcie_print_link_status() to log link speed and whether it's limited


-- 
Sinan Kaya
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
