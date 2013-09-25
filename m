Return-Path: <linux-acpi-owner@vger.kernel.org>
Message-ID: <5242882A.5090401@gmail.com>
Date: Wed, 25 Sep 2013 00:52:26 -0600
From: Robert Hancock <hancockrwd@gmail.com>
MIME-Version: 1.0
To: Bjorn Helgaas <bhelgaas@google.com>
CC: "Rafael J. Wysocki" <rjw@sisk.pl>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
	Len Brown <lenb@kernel.org>,
	Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [PATCH 00/14] _OSC simplification
References: <20130906171010.11482.34235.stgit@bhelgaas-glaptop> <16818914.Hl8YjzUdJi@vostro.rjw.lan> <CAErSpo4YRS3-EC5NcFVyi-yBbEX2Fmr0G=Vt2pk_SO7+5Ad91A@mail.gmail.com>
In-Reply-To: <CAErSpo4YRS3-EC5NcFVyi-yBbEX2Fmr0G=Vt2pk_SO7+5Ad91A@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 09/07/2013 07:59 AM, Bjorn Helgaas wrote:
> On Fri, Sep 6, 2013 at 6:01 PM, Rafael J. Wysocki <rjw@sisk.pl> wrote:
>> On Friday, September 06, 2013 11:13:24 AM Bjorn Helgaas wrote:
>>> This is a long series of mostly minor changes with the goal of
>>> simplifying the _OSC-related code and making the negotiation between
>>> Linux and the platform more understandable.
>>>
>>> My intent is that this doesn't change any behavior except for the text
>>> in dmesg.
>>>
>>> However, this restructuring does raise some questions in my mind, such
>>> as the fact that we do not call pcie_no_aspm() to disable ASPM in two
>>> cases where it seems like we might want to:
>>>
>>>    1) When pcie_ports_disabled, e.g., when booting with
>>>       "pcie_ports=compat".
>>>
>>>    2) When Linux doesn't support all the required services, e.g., if
>>>       compiled with ASPM support but not MSI support.
>>
>> We tried that (i.e. 2)), but then it caused energy usage to increase on some
>> systems with power-hungry graphics adapters and Phoronix made some fuss about
>> that. :-)
>
> The _OSC section of the spec is pretty obtuse, but my reading of Table
> 4-6 (PCI Firmware r3.0) is that the OS is prohibited from writing to
> the PCIe Capability (for ASPM, VC, AER, or other control) unless it
> has been granted "PCI Express Capability Structure control".  That's
> why I'm dubious about the fact that we use ASPM in those two cases
> where we don't even *ask* for that control.

AFAIK, I believe the problem was that in cases where we decided that 
ASPM shouldn't be used (such as if the FADT flag for "don't enable ASPM" 
was set), the kernel was explicitly disabling ASPM for devices even if 
the BIOS had turned it on. This caused a power regression compared to 
Windows which left ASPM enabled on those devices. I believe this was 
later changed to treat this case as "don't touch ASPM settings" rather 
than "force ASPM off on everything".

I'm not sure that all kernel messages have been updated to reflect this, 
though - there seem to be some cases where we confusingly say "disabling 
ASPM" when what it should likely say "disabling ASPM control".

>
> For the Phoronix case, I assume they made the argument that Windows
> does use ASPM without having PCIe Capability control?  Do you have any
> pointers to that discussion?
>
> I don't propose changing this now, but it does raise my eyebrows.
> Maybe some sort of dmesg note would be appropriate.
>
> Thanks for looking at all this stuff; I know from experience that it's
> pretty hard to wade through :)

