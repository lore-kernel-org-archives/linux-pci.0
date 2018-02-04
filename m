Return-Path: <SRS0=JOz6=E6=codeaurora.org=okaya@kernel.org>
Return-Path: <SRS0=JOz6=E6=codeaurora.org=okaya@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Date: Sun, 04 Feb 2018 08:43:10 -0500
From: okaya@codeaurora.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Bjorn Helgaas <helgaas@kernel.org>, "Rafael J. Wysocki"
 <rjw@rjwysocki.net>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
 Timur Tabi <timur@codeaurora.org>, linux-arm-msm
 <linux-arm-msm@vger.kernel.org>, linux-arm-kernel@lists.infradead.org, Linux
 PCI <linux-pci@vger.kernel.org>, Len Brown <lenb@kernel.org>, Linux Kernel
 Mailing List <linux-kernel@vger.kernel.org>,
 linux-acpi-owner@vger.kernel.org
Subject: Re: [PATCH] ACPI/PCI: pci_link: reduce verbosity when IRQ is enabled
In-Reply-To: <CAJZ5v0gW7hHAAisSemyvgTyMxpqxmUTADLZTmpyERB+qSMoA=w@mail.gmail.com>
References: <1516128664-23634-1-git-send-email-okaya@codeaurora.org>
 <f508e749-2976-ec6f-681a-553b79c4ab76@codeaurora.org>
 <20180116214939.GC10860@bhelgaas-glaptop.roam.corp.google.com>
 <fde756f4-eb74-4002-6ac4-a44405bad2da@codeaurora.org>
 <CAJZ5v0jNVENRq-3QjF6nY9_5-0ff=6j_qneLqCQ57h6t1R4Fow@mail.gmail.com>
 <CAJZ5v0gW7hHAAisSemyvgTyMxpqxmUTADLZTmpyERB+qSMoA=w@mail.gmail.com>
Message-ID: <f941444fae6a217c8ecd90010062a04b@codeaurora.org>
List-ID: <linux-pci.vger.kernel.org>

On 2018-02-04 04:03, Rafael J. Wysocki wrote:
> On Thu, Feb 1, 2018 at 8:32 AM, Rafael J. Wysocki <rafael@kernel.org> 
> wrote:
>> On Mon, Jan 29, 2018 at 8:01 PM, Sinan Kaya <okaya@codeaurora.org> 
>> wrote:
>>> Rafael,
>>> 
>>> On 1/16/2018 4:49 PM, Bjorn Helgaas wrote:
>>>> On Tue, Jan 16, 2018 at 01:53:00PM -0500, Sinan Kaya wrote:
>>>>> Correcting linux-pci email.
>>>>> 
>>>>> On 1/16/2018 1:51 PM, Sinan Kaya wrote:
>>>>>> When ACPI Link object is enabled, the message is printed with a 
>>>>>> warning
>>>>>> prefix. Some test tools are capturing warning and test error types 
>>>>>> as
>>>>>> errors. Let's reduce the verbosity of success case.
>>>>>> 
>>>>>> Signed-off-by: Sinan Kaya <okaya@codeaurora.org>
>>>> Acked-by: Bjorn Helgaas <bhelgaas@google.com>
>>>> 
>>>> Looks like this was a result of 4d9391557b68 ("ACPI: add missing 
>>>> KERN_*
>>>> constants to printks"), which I think added the wrong level in this 
>>>> case.
>>>> 
>>> 
>>> Any chance of merging this for 4.16?
>> 
>> There is.
> 
> This one is already there in the Linus' tree AFAICS.

You are right. I see it there. I have not seen an applied email. I 
thought it was still outstanding.

> --
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" 
> in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
