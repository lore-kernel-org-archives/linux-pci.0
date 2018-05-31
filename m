Return-Path: <linux-kernel-owner@vger.kernel.org>
Subject: Re: [PATCH] PCI: Check for PCIe downtraining conditions
To: Alexandru Gagniuc <mr.nuke.me@gmail.com>, bhelgaas@google.com
Cc: alex_gagniuc@dellteam.com, austin_bolen@dell.com,
        shyam_iyer@dell.com, keith.busch@intel.com,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20180531150535.9684-1-mr.nuke.me@gmail.com>
From: Sinan Kaya <okaya@codeaurora.org>
Message-ID: <e137d5bf-b640-68ef-c07e-d872a9343548@codeaurora.org>
Date: Thu, 31 May 2018 11:30:24 -0400
MIME-Version: 1.0
In-Reply-To: <20180531150535.9684-1-mr.nuke.me@gmail.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 5/31/2018 11:05 AM, Alexandru Gagniuc wrote:
> +	if (dev_cur_speed < max_link_speed)
> +		pci_warn(dev, "PCIe downtrain: link speed is %s (%s capable)",
> +			 pcie_bus_speed_name(dev_cur_speed),
> +			 pcie_bus_speed_name(max_link_speed));
> +

Also this isn't quite correct. Target link speed is what the device tries to
train. A device can try to train to much lower speed than the maximum on purpose.

It makes sense to print this if the speed that platform wants via target link
speed is different from what is actually established though.

-- 
Sinan Kaya
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
