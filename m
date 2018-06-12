Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:51494 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933649AbeFLHvy (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 12 Jun 2018 03:51:54 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Date: Tue, 12 Jun 2018 13:21:53 +0530
From: poza@codeaurora.org
To: Sinan Kaya <okaya@codeaurora.org>
Cc: Keith Busch <keith.busch@intel.com>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH] PCI/AER: Prevent runtime power management during recovery
In-Reply-To: <08e0ba9f-69cd-ea18-ae1b-d0795cceb306@codeaurora.org>
References: <20180611222918.1708-1-keith.busch@intel.com>
 <08e0ba9f-69cd-ea18-ae1b-d0795cceb306@codeaurora.org>
Message-ID: <76f700a5484d82529272d94b4531e434@codeaurora.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 2018-06-12 10:10, Sinan Kaya wrote:
> On 6/11/2018 6:29 PM, Keith Busch wrote:
>> A bridge that supports D3 but not hotplug will be subject to runtime
>> power management placing it in a non-operation power state if it 
>> doesn't
>> have any devices attached. This patch will prevent this power 
>> management
>> during error recovery so that the rescan at the end may be successful.
> 
> If there is no card connected, why would the bridge observe a fatal 
> error?

fatal error could be coming from anywhere let us say below RootPort..
and RP observes it and decides to take the tree down....
Is that the case Keith is talking about ?

Why will re-enumeration be a problem even if runtime PM is active ?
I assume that enumeration will get bridge out of D3.
