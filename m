Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:54724 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753516AbeFIXt2 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 9 Jun 2018 19:49:28 -0400
Subject: Re: [PATCH v2] pci/aspm: Remove CONFIG_PCIEASPM_DEBUG
To: Rajat Jain <rajatja@google.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "Busch, Keith" <keith.busch@intel.com>,
        Vidya Sagar <vidyas@nvidia.com>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Kees Cook <keescook@chromium.org>,
        "Gustavo A. R. Silva" <garsilva@embeddedor.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Frederick Lawler <fred@fredlawl.com>,
        linux-pci <linux-pci@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Patel, Mayurkumar" <mayurkumar.patel@intel.com>
Cc: Rajat Jain <rajatxjain@gmail.com>
References: <20180508230148.121852-1-rajatja@google.com>
 <20180510233912.96454-1-rajatja@google.com>
 <CACK8Z6H0PE-xBiNxhS+-P=-SyqAzKQi87xQoLGzgh6sgyt8zGA@mail.gmail.com>
From: Sinan Kaya <okaya@codeaurora.org>
Message-ID: <d856a2c3-2f75-8e79-f791-d5c0787a9018@codeaurora.org>
Date: Sat, 9 Jun 2018 19:49:23 -0400
MIME-Version: 1.0
In-Reply-To: <CACK8Z6H0PE-xBiNxhS+-P=-SyqAzKQi87xQoLGzgh6sgyt8zGA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

> On Thu, May 10, 2018 at 4:39 PM Rajat Jain <rajatja@google.com> wrote:
>>
>> Currently, the linux kernel disables ASPM when a device is
>> removed from the kernel. But it is not enabled again when
>> a new device is added on that slot even if it was originally
>> enabled (by the BIOS) when the system booted up (assuming
>> POLICY_DEFAULT).
>>
>> This was earlier discussed here:
>> https://www.spinics.net/lists/linux-pci/msg60212.html
>>
>> And some suggestions from Bjorn here:
>> https://www.spinics.net/lists/linux-pci/msg60541.html
>>
>> This patch picks up one of the suggestion, to remove the
>> CONFIG_PCIEASPM_DEBUG and thus make the code always
>> avilable. This provides control to userspace to control
>> ASPM on a per slot / device basis using sysfs interface.
>>
>> Signed-off-by: Rajat Jain <rajatja@google.com>
>> ---
>> v2: provide function definitions for !CONFIG_PCIEASPM case

Reviewed-by: Sinan Kaya <okaya@codeaurora.org>

-- 
Sinan Kaya
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
