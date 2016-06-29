Return-Path: <jhugo@codeaurora.org>
Return-Path: <jhugo@codeaurora.org>
Subject: Re: [RFC PATCH v4 3/5] PCI: Check platform specific ECAM quirks
To: Tomasz Nowicki <tn@semihalf.com>,
 Christopher Covington <cov@codeaurora.org>, Duc Dang <dhdang@apm.com>
References: <1467100442-28078-1-git-send-email-tn@semihalf.com>
 <1467100442-28078-4-git-send-email-tn@semihalf.com>
 <577275EA.7010002@codeaurora.org>
 <CADaLNDkhPZuG7UJ4SK_j5v_nXbd782Q17LAcXduG0uEObaFF=g@mail.gmail.com>
 <5773A773.8040700@semihalf.com> <5773CE49.1050802@codeaurora.org>
 <5773D284.8060404@semihalf.com>
Cc: Gabriele Paoloni <gabriele.paoloni@huawei.com>,
 Rafael Wysocki <rafael@kernel.org>, linux-pci@vger.kernel.org,
 Will Deacon <will.deacon@arm.com>, Sinan Kaya <okaya@codeaurora.org>,
 Yijing Wang <wangyijing@huawei.com>, Andrea Gallo <andrea.gallo@linaro.org>,
 Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>, linaro-acpi@lists.linaro.org,
 David Daney <ddaney@caviumnetworks.com>, linux-acpi@vger.kernel.org,
 Robert Richter <robert.richter@caviumnetworks.com>,
 Bjorn Helgaas <helgaas@kernel.org>, Dongdong Liu <liudongdong3@huawei.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Liviu Dudau
 <Liviu.Dudau@arm.com>, Arnd Bergmann <arnd@arndb.de>,
 Jon Masters <jcm@redhat.com>, Mark Salter <msalter@redhat.com>,
 Marcin Wojtas <mw@semihalf.com>,
 linux-arm <linux-arm-kernel@lists.infradead.org>,
 Jayachandran C <jchandra@broadcom.com>,
 Ard Biesheuvel <ard.biesheuvel@linaro.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 jeremy.linton@arm.com, Hanjun Guo <hanjun.guo@linaro.org>
From: Jeffrey Hugo <jhugo@codeaurora.org>
Message-ID: <a083360c-9b75-30f9-fe3c-ba968928fd92@codeaurora.org>
Date: Wed, 29 Jun 2016 09:38:50 -0600
MIME-Version: 1.0
In-Reply-To: <5773D284.8060404@semihalf.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-ID: <linux-pci.vger.kernel.org>

On 6/29/2016 7:52 AM, Tomasz Nowicki wrote:
> On 29.06.2016 15:34, Christopher Covington wrote:
>> I'm confused by this statement. OEMID is defined as 6 bytes long and OEM
>> Table ID as 8 bytes long in the ACPI specification. As far as I can
>> tell, if your string isn't exactly that long, padding up to that length
>> is required.
>
> Well, I cannot find that requirement in ACPI spec. but I might missed
> something.

Have a look at table 5-29 in Section 5.2.6 which starts on page 114 of 
ACPI 6.1

>
> I dumped my x86 machine ACPI tables and here is an example of MCFG:
>
> $ cat mcfg.dsl
> /*
>  * Intel ACPI Component Architecture
>  * AML/ASL+ Disassembler version 20160108-64
>  * Copyright (c) 2000 - 2016 Intel Corporation
>  *
>  * Disassembly of mcfg.dat, Wed Jun 29 15:48:16 2016
>  *
>  * ACPI Data Table [MCFG]
>  *
>  * Format: [HexOffset DecimalOffset ByteLength]  FieldName : FieldValue
>  */
>
> [000h 0000   4]                    Signature : "MCFG"    [Memory Mapped
> Configuration table]
> [004h 0004   4]                 Table Length : 0000003C
> [008h 0008   1]                     Revision : 01
> [009h 0009   1]                     Checksum : A9
> [00Ah 0010   6]                       Oem ID : "ALASKA"
> [010h 0016   8]                 Oem Table ID : "A M I"
> [018h 0024   4]                 Oem Revision : 01072009
> [01Ch 0028   4]              Asl Compiler ID : "MSFT"
> [020h 0032   4]        Asl Compiler Revision : 00000097
>
> [024h 0036   8]                     Reserved : 0000000000000000
>
> [02Ch 0044   8]                 Base Address : 00000000F8000000
> [034h 0052   2]         Segment Group Number : 0000
> [036h 0054   1]             Start Bus Number : 00
> [037h 0055   1]               End Bus Number : 3F
> [038h 0056   4]                     Reserved : 00000000
>
> Raw Table Data: Length 60 (0x3C)
>
> 00000000  4d 43 46 47 3c 00 00 00  01 a9 41 4c 41 53 4b 41
> |MCFG<.....ALASKA|
> 00000010  41 20 4d 20 49 00 00 00  09 20 07 01 4d 53 46 54  |A M I....
> ..MSFT|
> 00000020  97 00 00 00 00 00 00 00  00 00 00 00 00 00 00 f8
> |................|
> 00000030  00 00 00 00 00 00 00 3f  00 00 00 00              |.......?....|
>
> So in this example I have OEM table ID "A M I" 6 character long and 0
> padding.
>
> Tomasz
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel


-- 
Jeffrey Hugo
Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, a 
Linux Foundation Collaborative Project
