Return-Path: <linux-acpi-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <bf16b077-603f-bc7e-cd7b-bf006242f781@codeaurora.org>
References: <1475343976-20744-1-git-send-email-okaya@codeaurora.org>
 <CANwerB2bhMbkQrGG55Bq-yrFk_DC3Pz2tF0CRrt4ccmrzTmrzQ@mail.gmail.com> <bf16b077-603f-bc7e-cd7b-bf006242f781@codeaurora.org>
From: Jonathan Liu <net147@gmail.com>
Date: Mon, 3 Oct 2016 19:03:28 +1100
Message-ID: <CANwerB2fNtCDZLiAFZ3XPE_6NJ7STnUfhaLmWKUp-eU+8_FzfA@mail.gmail.com>
Subject: Re: [1/3] Revert "ACPI,PCI,IRQ: reduce static IRQ array size to 16"
To: Sinan Kaya <okaya@codeaurora.org>
Cc: linux-acpi@vger.kernel.org, rjw@rjwysocki.net,
        Bjorn Helgaas <bhelgaas@google.com>, ravikanth.nalla@hpe.com,
        linux@rainbow-software.org, timur@codeaurora.org,
        cov@codeaurora.org, jcm@redhat.com, alex.williamson@redhat.com,
        linux-pci@vger.kernel.org, Andy Gross <agross@codeaurora.org>,
        linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, wim@djo.tudelft.nl,
        Len Brown <lenb@kernel.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 3 October 2016 at 12:07, Sinan Kaya <okaya@codeaurora.org> wrote:
> On 10/2/2016 7:40 AM, Jonathan Liu wrote:
>> This series fixes one or more network adapters in VirtualBox not
>> working with Linux 32-bit x86 guest if I have 4 network adapters
>> enabled. The following message no longer appears in the kernel log:
>> ACPI: No IRQ available for PCI Interrupt Link [LNKD]. Try pci=noacpi or acpi=off
>>
>> Tested-by: Jonathan Liu <net147@gmail.com>
>
> Thanks for the test. I didn't realize that VirtualBox was broken too.

I am running VirtualBox on Windows 7 64-bit host with Linux guest. The
problem occurs in the Linux guest.

>
> So far I got some random test results in the mail list that something
> is broken. I hope to hear more that we close the issue for some time
> now.
>
> The IRQ stuff got broken three times already. Hopefully, this will be
> the seal.
