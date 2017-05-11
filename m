Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-sn1nam02on0089.outbound.protection.outlook.com ([104.47.36.89]:44512
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932801AbdEKOs6 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 11 May 2017 10:48:58 -0400
Subject: Re: [PATCH] efi/cper: Fix endianness of PCI class code
To: Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Lukas Wunner <lukas@wunner.de>
Cc: Arnd Bergmann <arnd@arndb.de>,
        "linux-efi@vger.kernel.org" <linux-efi@vger.kernel.org>,
        Ashok Raj <ashok.raj@intel.com>,
        linux-pci <linux-pci@vger.kernel.org>,
        Huang Ying <ying.huang@intel.com>
References: <771bc335fb5856792d086ae7db288dcf244cb4cd.1493964354.git.lukas@wunner.de>
 <CAKv+Gu9PpmTBbSMKUsx6svm6fodV8x=i4b1j8QGapnEoCFcrNA@mail.gmail.com>
 <20170506090755.GB19740@wunner.de>
 <CAKv+Gu_4xHhX8oK847k8=s5S7Mx3sALPTtX8Eo=2+9uZyQoEAQ@mail.gmail.com>
 <20170510084143.GA16261@wunner.de>
 <CAKv+Gu81gvNL1jkb3T35=-5fr_x-BmSg9X2CcQ97xv5JTZ-c1A@mail.gmail.com>
From: David Daney <ddaney@caviumnetworks.com>
Message-ID: <2d5f9331-6f31-2584-9ec1-2447163c6611@caviumnetworks.com>
Date: Thu, 11 May 2017 07:48:52 -0700
MIME-Version: 1.0
In-Reply-To: <CAKv+Gu81gvNL1jkb3T35=-5fr_x-BmSg9X2CcQ97xv5JTZ-c1A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 05/11/2017 07:06 AM, Ard Biesheuvel wrote:
> On 10 May 2017 at 09:41, Lukas Wunner <lukas@wunner.de> wrote:
>> On Wed, May 10, 2017 at 09:03:11AM +0100, Ard Biesheuvel wrote:
[...]
>>
>> It seems clumsy and unnecessary to me so I'd prefer the bitfield.
>> Please excuse my stubbornness.
>>
> 
> Stubbornness alone is not going to convince me. What *could* convince
> me (although unlikely) is a quote from the C spec which explains why
> it is 100% legal to make assumptions about how bitfields are projected
> onto byte locations in memory.

I don't think you will find that in the C specifications.

Structure layout is specified per-architecture/per-ABI so for the Linux 
kernel you would only have to check that it is strongly specified and 
compatible across `ls arch | wc -l` different architectures.  If you 
want to get started with MIPS, for example, you could look in the 
"SYSTEM V APPLICATION BINARY INTERFACE MIPS(r) RISC Processor Supplement 
3rd Edition" starting on page 3-7.  For x86 and arm{,64} I am sure you 
could find similar specifications.

David Daney
