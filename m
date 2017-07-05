Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:45868 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750909AbdGEM3B (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 5 Jul 2017 08:29:01 -0400
Subject: Re: Red Hat (Fedora) bug report 1467674 concerning your kernel
 functional performance enhancements causing PCI Express crashes,
To: Ethan Zhao <ethan.kernel@gmail.com>
Cc: Wim ten Have <wim.ten.have@oracle.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
References: <20170704161352.1cdb2670.wim.ten.have@oracle.com>
 <CAErSpo7PbSZgRtPJiXuOd6FPgLK5AGki51fTUm_-KUDZ96sRww@mail.gmail.com>
 <2acc9a73-0c2c-31f3-fcdf-42289213860e@codeaurora.org>
 <20170704195916.43fbe6e4.wim.ten.have@oracle.com>
 <97b8c58e-7384-0519-5ccb-837fa5054d84@codeaurora.org>
 <17f06c42-a96f-d1da-38e5-95117626eb29@codeaurora.org>
 <CABawtvOOWV1aKk=1LBk+S0UfG02UTNMvtdJM58HQYW4JXFAyrQ@mail.gmail.com>
From: Sinan Kaya <okaya@codeaurora.org>
Message-ID: <47e18e59-5417-33d6-e150-25b2c714e391@codeaurora.org>
Date: Wed, 5 Jul 2017 08:28:55 -0400
MIME-Version: 1.0
In-Reply-To: <CABawtvOOWV1aKk=1LBk+S0UfG02UTNMvtdJM58HQYW4JXFAyrQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi,

On 7/5/2017 3:42 AM, Ethan Zhao wrote:
> Sinan，
> 
>     About the patch attached, why clear the word of
> PCI_EXP_DEVCTL_EXT_TAG ?  does the device will be set by default after
> POST it is not supported ?
> 
>    dev_info(&dev->dev, "clearing extended tags capability\n");
> 
> + pcie_capability_clear_word(dev, PCI_EXP_DEVCTL,
> +   PCI_EXP_DEVCTL_EXT_TAG);

We don't usually trust the FW in Linux. Some outdated firmware might have
done the same mistake and end users usually don't upgrade their BIOS in
general. We end up working around issues in Linux with quirks etc.

The other issue is this. Default value of the register is not zero.

"Extended Tag Field Enable:
Default value of this bit is implementation specific"

https://pcisig.com/sites/default/files/specification_documents/ECN_Extended_Tag_Enable_Default_05Sept2008_final.pdf

Hope this helps,

Sinan

-- 
Sinan Kaya
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
