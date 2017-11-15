Return-Path: <SRS0=m0+l=CN=codeaurora.org=tbaicar@kernel.org>
Return-Path: <SRS0=m0+l=CN=codeaurora.org=tbaicar@kernel.org>
Subject: Re: [PATCH] PCI/AER: update AER status string print to match other
 AER logs
To: bhelgaas@google.com, helgaas@kernel.org, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <1508254922-30925-1-git-send-email-tbaicar@codeaurora.org>
From: Tyler Baicar <tbaicar@codeaurora.org>
Message-ID: <6d5b3747-ceb7-d47f-9d5f-47aa69ec33cf@codeaurora.org>
Date: Wed, 15 Nov 2017 09:47:41 -0500
MIME-Version: 1.0
In-Reply-To: <1508254922-30925-1-git-send-email-tbaicar@codeaurora.org>
Content-Type: text/plain; charset=utf-8; format=flowed
List-ID: <linux-pci.vger.kernel.org>

On 10/17/2017 11:42 AM, Tyler Baicar wrote:
> Currently the AER driver uses cper_print_bits() to print the AER status
> string. This causes the status string to not include the proper PCI device
> name prefix that the other AER prints include. Also, it has a different
> print level than all the other AER prints.
>
> Update the AER driver to print the AER status string with the proper string
> prefix and proper print level.
Hello,

Will this patch be pulled into 4.15?

Thanks,
Tyler

-- 
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project.
