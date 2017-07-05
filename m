Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:47106 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752656AbdGENVB (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 5 Jul 2017 09:21:01 -0400
Subject: Re: Red Hat (Fedora) bug report 1467674 concerning your kernel
 functional performance enhancements causing PCI Express crashes,
To: Wim ten Have <wim.ten.have@oracle.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
References: <20170704161352.1cdb2670.wim.ten.have@oracle.com>
 <CAErSpo7PbSZgRtPJiXuOd6FPgLK5AGki51fTUm_-KUDZ96sRww@mail.gmail.com>
 <2acc9a73-0c2c-31f3-fcdf-42289213860e@codeaurora.org>
 <20170704195916.43fbe6e4.wim.ten.have@oracle.com>
 <97b8c58e-7384-0519-5ccb-837fa5054d84@codeaurora.org>
 <17f06c42-a96f-d1da-38e5-95117626eb29@codeaurora.org>
 <20170705131312.6073b8aa.wim.ten.have@oracle.com>
 <c350ebc3-51cf-d2d7-e40c-740360f1dc4d@codeaurora.org>
 <20170705150006.7f6a3c44.wim.ten.have@oracle.com>
From: Sinan Kaya <okaya@codeaurora.org>
Message-ID: <1ab0fffc-822c-8ce8-eb67-9e74d5a8556f@codeaurora.org>
Date: Wed, 5 Jul 2017 09:20:57 -0400
MIME-Version: 1.0
In-Reply-To: <20170705150006.7f6a3c44.wim.ten.have@oracle.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 7/5/2017 9:00 AM, Wim ten Have wrote:
>> Can I have a tested-by?
>   Sure.
> 
>   tested-by: Wim ten Have <wim.ten.have@oracle.com>
> 
> - Wim.
> 

Thanks, I just re-posted the patch. The only change is replacing dev_info
with dev_dbg to reduce verbosity. Feel free to retest.

-- 
Sinan Kaya
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
