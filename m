Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from hqemgate15.nvidia.com ([216.228.121.64]:15335 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752652AbdJ3QWf (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 30 Oct 2017 12:22:35 -0400
Subject: Re: [PATCH 07/12] PCI: tegra: Disable AFI dynamic clock gating
To: David Laight <David.Laight@ACULAB.COM>,
        "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "jonathanh@nvidia.com" <jonathanh@nvidia.com>
CC: "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "vidyas@nvidia.com" <vidyas@nvidia.com>,
        "kthota@nvidia.com" <kthota@nvidia.com>
References: <1509132569-9398-1-git-send-email-mmaddireddy@nvidia.com>
 <1509132569-9398-8-git-send-email-mmaddireddy@nvidia.com>
 <063D6719AE5E284EB5DD2968C1650D6DD00A90B0@AcuExch.aculab.com>
From: Manikanta Maddireddy <mmaddireddy@nvidia.com>
Message-ID: <382903eb-a6ab-218f-c1e1-4cb64d2c802e@nvidia.com>
Date: Mon, 30 Oct 2017 21:48:56 +0530
MIME-Version: 1.0
In-Reply-To: <063D6719AE5E284EB5DD2968C1650D6DD00A90B0@AcuExch.aculab.com>
Content-Type: text/plain; charset="windows-1252"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>



On 30-Oct-17 9:28 PM, David Laight wrote:
> From: Manikanta Maddireddy
>> Sent: 27 October 2017 20:29
>> When there are 32 outstanding writes from AFI to memory, the outstanding
>> write counter overflows and indicates that there are "0" outstanding write
>> transactions. This outstanding write counter is used to generate IDLE
>> signal to dynamically gate the AFI clock.
>>
>> When memory controller is under heavy load, its possible that write
>> completions will come back to AFI after long delay and AFI write counter
>> overflows. AFI clock gets gated even when there are outstanding
>> transactions towards memory controller resutling in system hang.
>>
>> Disable dynamic clock gating of AFI clock to avoid system hang.
> 
> At least some of the above really ought to be comments in the code.
> (and with the earlier fix for limiting the number of writes.)
> 
> 	David
> 

Ok, will take care of it in next version
