Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-cys01nam02on0068.outbound.protection.outlook.com ([104.47.37.68]:19200
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750897AbeFGKWe (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 7 Jun 2018 06:22:34 -0400
Subject: Re: [PATCH] i2c:amd I2C Driver based on PCI Interface for upcoming
 platform
To: Bjorn Helgaas <bhelgaas@google.com>
References: <1524928597-23312-1-git-send-email-Nehal-bakulchandra.Shah@amd.com>
 <SN1PR12MB257536FC4322C1D3D6F2F972A06C0@SN1PR12MB2575.namprd12.prod.outlook.com>
 <20180531214311.i6s5xginjgevkwoe@ninjato>
 <SN1PR12MB257592515E4A436078D43E68A0670@SN1PR12MB2575.namprd12.prod.outlook.com>
 <CAErSpo6SvtKL6HsPGn2KM5Tw+oadHZXWeq=aLMA+1pyrBfBA1Q@mail.gmail.com>
Cc: Wolfram Sang <wsa@the-dreams.de>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        linux-acpi@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-i2c <linux-i2c@vger.kernel.org>, Sandeep.Singh@amd.com,
        Shyam-sundar.S-k@amd.com, kai.heng.feng@canonical.com
From: "Shah, Nehal-bakulchandra" <Nehal-Bakulchandra.shah@amd.com>
Message-ID: <315546a5-3f3a-d921-abd6-dd500db98953@amd.com>
Date: Thu, 7 Jun 2018 15:52:03 +0530
MIME-Version: 1.0
In-Reply-To: <CAErSpo6SvtKL6HsPGn2KM5Tw+oadHZXWeq=aLMA+1pyrBfBA1Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi

Thanks for your valuable input.
On 6/4/2018 10:45 PM, Bjorn Helgaas wrote:
> On Mon, Jun 4, 2018 at 11:33 AM Shah, Nehal-bakulchandra
> <Nehal-bakulchandra.Shah@amd.com> wrote:
>>
>> Hi All,
>>
>> Please help in reviewing the patch.
> 
> If you'd like PCI review, please post the patches to linux-pci@vger.kernel.org.

This patch is more onto I2C which is using PCI Interface. Is it still good to send for linux-pci review? I am really confused how to take it forward. Your suggestion will be well appreciated.
 
>> -----Original Message-----
>> From: linux-i2c-owner@vger.kernel.org [mailto:linux-i2c-owner@vger.kernel.org] On Behalf Of Wolfram Sang
>> Sent: Friday, June 1, 2018 3:13 AM
>> To: Shah, Nehal-bakulchandra <Nehal-bakulchandra.Shah@amd.com>
>> Cc: linux-i2c@vger.kernel.org; Singh, Sandeep <Sandeep.Singh@amd.com>; S-k, Shyam-sundar <Shyam-sundar.S-k@amd.com>; Kai Heng Feng <kai.heng.feng@canonical.com>
>> Subject: Re: [PATCH] i2c:amd I2C Driver based on PCI Interface for upcoming platform
>>
>> Hi,
>>
>>> I am waiting for the feedback on this patch. It has been there since
>>> long time. Can you please provide the feedback.
>>
>> Well, reviewing drivers is a community effort these days. While I am part of this community, I am surely not the only one. So, please ask the list for help (rather than me personally). Furthermore, I think I am not the right person here to ask for help. I don't know much about PCI & ACPI. We have dedicated I2C-ACPI maintainers, maybe they have some bandwidth for review?
>>
>> That being said: yes, it is sad that you need to wait this long; yet I simply can't fill up all the resource problems we have here.
>>
>> Thanks,
>>
>>    Wolfram
>>

Thanks,
Nehal Shah
