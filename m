Return-Path: <okaya@codeaurora.org>
Return-Path: <okaya@codeaurora.org>
Subject: Re: [PATCH V3 1/4] acpi,pci,irq: reduce resource requirements
To: "Nalla, Ravikanth" <ravikanth.nalla@hpe.com>,
 Bjorn Helgaas <helgaas@kernel.org>
References: <1460914617-8259-1-git-send-email-okaya@codeaurora.org>
 <20160426183611.GC27803@localhost> <571FBACB.1020606@codeaurora.org>
 <49D617FA63152941907AADE32CF072F12FF09187@G4W3290.americas.hpqcorp.net>
 <57279551.3010000@codeaurora.org>
 <49D617FA63152941907AADE32CF072F12FF09400@G4W3290.americas.hpqcorp.net>
Cc: "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
 "timur@codeaurora.org" <timur@codeaurora.org>,
 "cov@codeaurora.org" <cov@codeaurora.org>,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 "lenb@kernel.org" <lenb@kernel.org>, "K, Harish (MCOU/UPEL)"
 <harish.k@hpe.com>,
 "Reghunandanan, Ashwin (STSD)" <ashwin.reghunandanan@hpe.com>,
 "bhelgaas@google.com" <bhelgaas@google.com>,
 "rjw@rjwysocki.net" <rjw@rjwysocki.net>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
From: Sinan Kaya <okaya@codeaurora.org>
Message-ID: <5728DCF7.7080505@codeaurora.org>
Date: Tue, 3 May 2016 13:16:39 -0400
MIME-Version: 1.0
In-Reply-To: <49D617FA63152941907AADE32CF072F12FF09400@G4W3290.americas.hpqcorp.net>
Content-Type: text/plain; charset=windows-1252
List-ID: <linux-pci.vger.kernel.org>

On 5/3/2016 12:17 PM, Nalla, Ravikanth wrote:
>> >https://patchwork.ozlabs.org/patch/611493/mbox/
>> >https://patchwork.ozlabs.org/patch/611496/mbox/
>> >https://patchwork.ozlabs.org/patch/611495/mbox/
>> >https://patchwork.ozlabs.org/patch/611494/mbox/
> The above mbox patches worked with "git apply".  We have now verified the fix after applying these 4 patches on a 60 CPU system 
> with mainline kernel (4.6-rc6) and we don't see any panic or issues during boot (multiple). We will try verifying on a high end system 
> and we will let you know the results.

Thanks, let us know how it goes.

-- 
Sinan Kaya
Qualcomm Technologies, Inc. on behalf of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, a Linux Foundation Collaborative Project
