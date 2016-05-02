Return-Path: <okaya@codeaurora.org>
Return-Path: <okaya@codeaurora.org>
Subject: Re: [PATCH V3 1/4] acpi,pci,irq: reduce resource requirements
To: "Nalla, Ravikanth" <ravikanth.nalla@hpe.com>,
 Bjorn Helgaas <helgaas@kernel.org>
References: <1460914617-8259-1-git-send-email-okaya@codeaurora.org>
 <20160426183611.GC27803@localhost> <571FBACB.1020606@codeaurora.org>
 <49D617FA63152941907AADE32CF072F12FF09187@G4W3290.americas.hpqcorp.net>
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
Message-ID: <57279551.3010000@codeaurora.org>
Date: Mon, 2 May 2016 13:58:41 -0400
MIME-Version: 1.0
In-Reply-To: <49D617FA63152941907AADE32CF072F12FF09187@G4W3290.americas.hpqcorp.net>
Content-Type: text/plain; charset=windows-1252
List-ID: <linux-pci.vger.kernel.org>

On 5/2/2016 1:44 PM, Nalla, Ravikanth wrote:
>> Thanks, can the HPE developers in CC test the series in order to avoid another revert? 
>  I'm facing below errors while applying these patches on mainline kernel for verification. Please check and let me know what is the issue or if I'm 
>  missing  anything. I use outlook for mail and I copied your mail formatted patches into each individual file manually and converted these files into
>  unix format (using dos2unix cmd)  and when trying to apply with cmd "patch -p1  patch1.patch" /  "git apply patch1.patch" i see
>  below errors. I'm getting similar errors for remaining  patches too and also "checkpatch.pl" looks to be throwing errors. Hence I'm not able to 
>  verify your changes.

This should get you the patch files.

https://patchwork.ozlabs.org/patch/611493/raw/
https://patchwork.ozlabs.org/patch/611496/raw/
https://patchwork.ozlabs.org/patch/611495/raw/
https://patchwork.ozlabs.org/patch/611494/raw/

You can download the mailbox files here and do "git am" instead

https://patchwork.ozlabs.org/patch/611493/mbox/
https://patchwork.ozlabs.org/patch/611496/mbox/
https://patchwork.ozlabs.org/patch/611495/mbox/
https://patchwork.ozlabs.org/patch/611494/mbox/

-- 
Sinan Kaya
Qualcomm Technologies, Inc. on behalf of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, a Linux Foundation Collaborative Project
