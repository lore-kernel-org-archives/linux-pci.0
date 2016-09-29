Return-Path: <linux-acpi-owner@vger.kernel.org>
Subject: Re: 4.7 regression: ACPI: No IRQ available for PCI Interrupt Link
 [LNKD]. Try pci=noacpi or acpi=off
To: wim@djo.tudelft.nl
References: <201609251512.05657.linux@rainbow-software.org>
 <201609281902.31500.linux@rainbow-software.org>
 <76303bb8-7ae2-9a6b-8e5d-a144ae7c6009@codeaurora.org>
 <201609282123.48506.linux@rainbow-software.org>
 <946fcb62-272b-61b3-9afa-7c27a1ce7419@codeaurora.org>
 <20160929141818.GA32236@djo.tudelft.nl>
Cc: Ondrej Zary <linux@rainbow-software.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-acpi@vger.kernel.org, linux-pci@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>, ravikanth.nalla@hpe.com
From: Sinan Kaya <okaya@codeaurora.org>
Message-ID: <045a9b11-f3f0-a8f3-1f16-1404fb16b3ae@codeaurora.org>
Date: Thu, 29 Sep 2016 10:31:38 -0400
MIME-Version: 1.0
In-Reply-To: <20160929141818.GA32236@djo.tudelft.nl>
Content-Type: text/plain; charset=windows-1252
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 9/29/2016 10:18 AM, Wim Osterholt wrote:
> On Wed, Sep 28, 2016 at 07:38:41PM -0400, Sinan Kaya wrote:
>>
>> Can you try these patches on your machines please?
> 
> I applied the included patches on vanilla 4.8-rc8 and my machine booted
> fine. (I saw a remark about SCSI interrupts, but I have no SCSI.)
> 
> Regards, Wim.
> 

Thanks Wim. The issue seems to be platform specific. I guess we should fix 
Ondrej's issue first before increasing our test coverage. Apologies for
calling for test this early. I really hoped that the last patch would
solve Ondrej's issue.

> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 


-- 
Sinan Kaya
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
