Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:51306 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752038AbdGDP5m (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 4 Jul 2017 11:57:42 -0400
Subject: Re: Fwd: Red Hat (Fedora) bug report 1467674 concerning your kernel
 functional performance enhancements causing PCI Express crashes,
To: Bjorn Helgaas <bhelgaas@google.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Cc: Wim ten Have <wim.ten.have@oracle.com>
References: <20170704161352.1cdb2670.wim.ten.have@oracle.com>
 <CAErSpo7PbSZgRtPJiXuOd6FPgLK5AGki51fTUm_-KUDZ96sRww@mail.gmail.com>
From: Sinan Kaya <okaya@codeaurora.org>
Message-ID: <2acc9a73-0c2c-31f3-fcdf-42289213860e@codeaurora.org>
Date: Tue, 4 Jul 2017 11:57:37 -0400
MIME-Version: 1.0
In-Reply-To: <CAErSpo7PbSZgRtPJiXuOd6FPgLK5AGki51fTUm_-KUDZ96sRww@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi,

On 7/4/2017 11:32 AM, Bjorn Helgaas wrote:
> [+cc linux-pci]
> 
> Thanks very much for the detailed problem report, Wim!  I'm taking the
> liberty to forward to the linux-pci list in case others trip over the
> same thing.
> 

So, the spec is lying :) and reality doesn't match theory.

"Per the ECN mentioned below, all PCIe Receivers are expected to support
 Extended Tags"

> 
> 
> 
> The problem is not specific to this piece of h/w.  I did pin-point the
> issue to specific kernel code commit
<snip>

> 60db3a4d8cc9073cf56264785197ba75ee1caca4
>   * <wtenhave@hagen:55> git bisect good
>     60db3a4d8cc9073cf56264785197ba75ee1caca4 is the first bad commit
>     commit 60db3a4d8cc9073cf56264785197ba75ee1caca4
>     Author: Sinan Kaya <okaya@codeaurora.org>
>     Date:   Fri Jan 20 09:16:51 2017 -0500
> 
>       PCI: Enable PCIe Extended Tags if supported
> 
<snip>

> 3. Boot and see it crash as soon it starts to operate on specific PCI
> Express Ethernet controller.
> 

I guess we have an endpoint/system with errata that needs to be blacklisted.
Can you please try another endpoint with the same system?

You have conflicting information above. I want to understand whether it
is the endpoint or the system that needs to be blacklisted.

Please also provide sudo lspci -vvv output from the system with the patch.

Sinan

-- 
Sinan Kaya
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
