Return-Path: <linux-acpi-owner@vger.kernel.org>
Subject: Re: [1/3] Revert "ACPI,PCI,IRQ: reduce static IRQ array size to 16"
To: Jonathan Liu <net147@gmail.com>
References: <1475343976-20744-1-git-send-email-okaya@codeaurora.org>
 <CANwerB2bhMbkQrGG55Bq-yrFk_DC3Pz2tF0CRrt4ccmrzTmrzQ@mail.gmail.com>
Cc: linux-acpi@vger.kernel.org, rjw@rjwysocki.net, bhelgaas@google.com,
        ravikanth.nalla@hpe.com, linux@rainbow-software.org,
        timur@codeaurora.org, cov@codeaurora.org, jcm@redhat.com,
        alex.williamson@redhat.com, linux-pci@vger.kernel.org,
        agross@codeaurora.org, linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, wim@djo.tudelft.nl,
        Len Brown <lenb@kernel.org>, linux-kernel@vger.kernel.org
From: Sinan Kaya <okaya@codeaurora.org>
Message-ID: <bf16b077-603f-bc7e-cd7b-bf006242f781@codeaurora.org>
Date: Sun, 2 Oct 2016 21:07:21 -0400
MIME-Version: 1.0
In-Reply-To: <CANwerB2bhMbkQrGG55Bq-yrFk_DC3Pz2tF0CRrt4ccmrzTmrzQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 10/2/2016 7:40 AM, Jonathan Liu wrote:
> This series fixes one or more network adapters in VirtualBox not
> working with Linux 32-bit x86 guest if I have 4 network adapters
> enabled. The following message no longer appears in the kernel log:
> ACPI: No IRQ available for PCI Interrupt Link [LNKD]. Try pci=noacpi or acpi=off
> 
> Tested-by: Jonathan Liu <net147@gmail.com>

Thanks for the test. I didn't realize that VirtualBox was broken too.

So far I got some random test results in the mail list that something
is broken. I hope to hear more that we close the issue for some time
now. 

The IRQ stuff got broken three times already. Hopefully, this will be
the seal.

-- 
Sinan Kaya
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
