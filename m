Return-Path: <SRS0=sP6C=KY=gmail.com=mr.nuke.me@kernel.org>
Return-Path: <SRS0=sP6C=KY=gmail.com=mr.nuke.me@kernel.org>
Subject: Re: [PATCH] PCI/AER: Do not clear AER bits if we don't own AER
To: Bjorn Helgaas <helgaas@kernel.org>, Alex_Gagniuc@Dellteam.com
Cc: bhelgaas@google.com, keith.busch@intel.com, Austin.Bolen@dell.com,
 Shyam.Iyer@dell.com, fred@fredlawl.com, poza@codeaurora.org,
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20180717153135.25925-1-mr.nuke.me@gmail.com>
 <20180809141551.GH49411@bhelgaas-glaptop.roam.corp.google.com>
 <2cae6a5ac8324be18b8dcf3d7dfcc288@ausx13mps321.AMER.DELL.COM>
 <20180809182905.GA113140@bhelgaas-glaptop.roam.corp.google.com>
From: "Alex G." <mr.nuke.me@gmail.com>
Message-ID: <d235e71d-647f-00d1-8a21-2784b7939c25@gmail.com>
Date: Thu, 9 Aug 2018 14:00:23 -0500
MIME-Version: 1.0
In-Reply-To: <20180809182905.GA113140@bhelgaas-glaptop.roam.corp.google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
List-ID: <linux-pci.vger.kernel.org>



On 08/09/2018 01:29 PM, Bjorn Helgaas wrote:
> On Thu, Aug 09, 2018 at 04:46:32PM +0000, Alex_Gagniuc@Dellteam.com wrote:
>> On 08/09/2018 09:16 AM, Bjorn Helgaas wrote:
(snip_
>>>     enable_ecrc_checking()
>>>     disable_ecrc_checking()
>>
>> I don't immediately see how this would affect FFS, but the bits are part
>> of the AER capability structure. According to the FFS model, those would
>> be owned by FW, and we'd have to avoid touching them.
> 
> Per ACPI v6.2, sec 18.3.2.4, the HEST may contain entries for Root
> Ports that contain the FIRMWARE_FIRST flag as well as values the OS is
> supposed to write to several AER capability registers.  It looks like
> we currently ignore everything except the FIRMWARE_FIRST and GLOBAL
> flags (ACPI_HEST_FIRMWARE_FIRST and ACPI_HEST_GLOBAL in Linux).
> 
> That seems like a pretty major screwup and more than I want to fix
> right now.

The logic is not very clear, but I think it goes like this:
For GLOBAL and FFS, disable native AER everywhere.
When !GLOBAL and FFS, then only disable native AER for the root port 
described by the HEST entry.

aer_acpi_firmware_first() doesn't care about context. Though check 
aer_set_firmware_first(), where we pass a pci_device as a context.

The FFS implementations I've seen have one HEST entry, with GLOBAL and 
FFS. I have yet to see more fine-grained control of root ports. I 
suspect that if we had this finer control from HEST, we'd honor it.

I do eventually want to get a test BIOS with different HEST entries, and 
make sure things work as intended. Though BIOS team is overloaded with 
other requests.

>>>     pci_cleanup_aer_uncorrect_error_status()
>>
>> This probably should be guarded. It's only called from a few specific
>> drivers, so the impact is not as high as being called from the core.
>>
>>>     pci_aer_clear_fatal_status()
>>
>> This is only called when doing fatal_recovery, right?
> 
> True.  It takes a lot of analysis to convince oneself that this is not
> used in the firmware-first path, so I think we should add a guard
> there.

I agree. GHES has a header severity and a severity field for each 
section. All BIOSes I've seen do fatal/fatal, though a BIOS that would 
report correctable/fatal, would bypass the apei code and take us here.

>> For practical considerations this is not an issue today. The ACPI error
>> handling code currently crashes when it encounters any fatal error, so
>> we wouldn't hit this in the FFS case.
> 
> I wasn't aware the firmware-first path was *that* broken.  Are there
> problem reports for this?  Is this a regression?

It's been like this since, I believe, 3.10, and probably much earlier. 
All reports that I have seen of linux crashing on surprise hot-plug have 
been caused by the panic() call in the apei code. Dell BIOSes do an 
extreme amount of work to determine when it's safe to _not_ report 
errors to the OS, since all known OSes crash on this path.

Fun fact: there's even dedicated hardware to accomplish the above.

>> The PCIe standards contact I usually talk to about these PCIe subtleties
>> is currently on vacation. The number one issue was a FFS corner case
>> with OS clearing bits on probe. The other functions you mention are a
>> corner case of a corner case. The big fish is
>> pci_cleanup_aer_error_status_regs() on probe(), and it would be nice to
>> have that resolved.
>>
>> I'll sync up with Austin when he gets back to see about the other
>> functions though I suspect we'll end up fixing them as well.
> 
> I'd like to fix all the obvious cases at once (excluding the ECRC
> stuff).  What do you think about the following patch?

That looks very sensible to me. Thank you for updating it :).
I'm pulling in the changes right now to run some quick tests, and I 
don't expect any trouble.

Alex

> commit 15ed68dcc26864c849a12a36db4d4771bad7991f
> Author: Alexandru Gagniuc <mr.nuke.me@gmail.com>
> Date:   Tue Jul 17 10:31:23 2018 -0500
> 
>      PCI/AER: Don't clear AER bits if error handling is Firmware-First
>      
>      If the platform requests Firmware-First error handling, firmware is
>      responsible for reading and clearing AER status bits.  If OSPM also clears
>      them, we may miss errors.  See ACPI v6.2, sec 18.3.2.5 and 18.4.
>      
>      This race is mostly of theoretical significance, as it is not easy to
>      reasonably demonstrate it in testing.
>      
>      Signed-off-by: Alexandru Gagniuc <mr.nuke.me@gmail.com>
>      [bhelgaas: add similar guards to pci_cleanup_aer_uncorrect_error_status()
>      and pci_aer_clear_fatal_status()]
>      Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> 
> diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
> index c6cc855bfa22..4e823ae051a7 100644
> --- a/drivers/pci/pcie/aer.c
> +++ b/drivers/pci/pcie/aer.c
> @@ -397,6 +397,9 @@ int pci_cleanup_aer_uncorrect_error_status(struct pci_dev *dev)
>   	if (!pos)
>   		return -EIO;
>   
> +	if (pcie_aer_get_firmware_first(dev))
> +		return -EIO;
> +
>   	/* Clear status bits for ERR_NONFATAL errors only */
>   	pci_read_config_dword(dev, pos + PCI_ERR_UNCOR_STATUS, &status);
>   	pci_read_config_dword(dev, pos + PCI_ERR_UNCOR_SEVER, &sev);
> @@ -417,6 +420,9 @@ void pci_aer_clear_fatal_status(struct pci_dev *dev)
>   	if (!pos)
>   		return;
>   
> +	if (pcie_aer_get_firmware_first(dev))
> +		return;
> +
>   	/* Clear status bits for ERR_FATAL errors only */
>   	pci_read_config_dword(dev, pos + PCI_ERR_UNCOR_STATUS, &status);
>   	pci_read_config_dword(dev, pos + PCI_ERR_UNCOR_SEVER, &sev);
> @@ -438,6 +444,9 @@ int pci_cleanup_aer_error_status_regs(struct pci_dev *dev)
>   	if (!pos)
>   		return -EIO;
>   
> +	if (pcie_aer_get_firmware_first(dev))
> +		return -EIO;
> +
>   	port_type = pci_pcie_type(dev);
>   	if (port_type == PCI_EXP_TYPE_ROOT_PORT) {
>   		pci_read_config_dword(dev, pos + PCI_ERR_ROOT_STATUS, &status);
> 
