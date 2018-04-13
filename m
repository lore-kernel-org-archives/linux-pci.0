Return-Path: <SRS0=TmvE=HC=broadcom.com=srinath.mannam@kernel.org>
Return-Path: <SRS0=TmvE=HC=broadcom.com=srinath.mannam@kernel.org>
MIME-Version: 1.0
In-Reply-To: <20180413135659.GC46420@bhelgaas-glaptop.roam.corp.google.com>
References: <CABe79T47vUjq20HuMrJZxhZWMr0q3uXMF6xL1TgkqhqA8qi1wg@mail.gmail.com>
 <20180413135659.GC46420@bhelgaas-glaptop.roam.corp.google.com>
From: Srinath Mannam <srinath.mannam@broadcom.com>
Date: Fri, 13 Apr 2018 21:13:42 +0530
Message-ID: <CABe79T4nO7dC9uHwX-woAvkdw0+b2ssUyxgs0cnGo90OH_YD+Q@mail.gmail.com>
Subject: Re: Issue with Enable LTR while pcie_aspm off
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Ray Jui <ray.jui@broadcom.com>, linux-pci@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-pci.vger.kernel.org>

Hi Bjorn,

Thank you very much for quick response.

I am using samsung NVMe card as EP connected to our platform. As per
link capabilities device does not support L1.s.
But LTR is enabled in DEVCAP2.
In my observation after setting LTR without enabling ASPM (common
clock and link retraining) in software, device stopped responding.
I have no Idea, How endpoint should behave as per spec in this case.


>From your explanation, I understand that LTR configuration we can't
keep it in the part of ASPM cap init function in aspm.c where we
enable common clock.
and L1.ss capabilities.

Also, as you said we use sysfs functions to set ASPM policies. that to
ASPM support enabled which configure aspm_capabilities and common
clock.

ASPM_CONFIG is depend on PCIE_CONFIG, so there may be cases where
people want to enable PCIE and donot want ASPM.
In that case pcie_aspm boot args will help to disable ASPM.

Is there any such cases where we don't need ASPM and need to set LTR.
If not we can move LTR configuration to aspm.c file.

I think as you said it will be better to add LTR configuration also
part of sysfs interface while we enable L1.ss feature.



Regards,
Srinath.

On Fri, Apr 13, 2018 at 7:26 PM, Bjorn Helgaas <helgaas@kernel.org> wrote:
> Hi Srinath,
>
> On Fri, Apr 13, 2018 at 12:16:46PM +0530, Srinath Mannam wrote:
>> Hi Bjorn,
>>
>> In our platform we disable aspm using boot_arg "pcie_aspm=off".
>> But with the below patch, LTR is enabled which is part of ASPM.
>> even we keep disable aspm using "pcie_aspm=off" then why we need to
>> enable LTR. This is causing issues with few NVMe cards.
>
> Strictly speaking, the spec does not define LTR as "part of" ASPM,
> although as far as I can tell, the only references to *using* the LTR
> information are related to ASPM L1 substates.
>
> I think the reason I made this patch enable LTR regardless of the
> initial ASPM settings is because the ASPM settings can be changed at
> run-time via sysfs (see pcie_aspm_set_policy()).
>
> If we enable L1 substates at run-time, LTR has to be enabled somehow,
> either at enumeration-time (as we currently do) or by some similar
> code in the pcie_aspm_set_policy() path.
>
> LTR consumes some PCIe bandwidth, so it's not free, and I do agree
> that it seems pointless to enable it if nothing is going to use the
> information.
>
> What sort of issues are you seeing?  Are the issues caused by hardware
> defects, e.g., things that don't conform to the PCIe spec, or are they
> caused by a software defect, e.g., something done wrong in the patch
> below, or maybe some requirement that LTR not be enabled unless ASPM
> L1 substates are enabled?
>
> If the issues are related to hardware defects with LTR itself, maybe a
> quirk would be the best way to approach it.  That would make it clear
> what the actual problem is and may allow us to do a better job of
> working around it.  For example, maybe we could enable some ASPM
> states, but not those requiring LTR.  Or maybe we could enable ASPM in
> some parts of the system, but not for the devices that have LTR
> issues.
>
> Also, it could potentially remove the need for you to use the
> "pcie_aspm=off" parameter, which would improve the user experience.
>
>> Please advice us how can we proceed in this scenario.
>>
>> commit c46fd358070f22ba68d6e74c22016a33b914c20a
>> Author: Bjorn Helgaas <bhelgaas@google.com>
>> Date:   Tue Nov 28 16:43:50 2017 -0600
>>
>>     PCI/ASPM: Enable Latency Tolerance Reporting when supported
>>
>>     Enable Latency Tolerance Reporting (LTR).  Note that LTR must be enabled in
>>     the Root Port first, and must not be enabled in any downstream device
>>     unless the Root Port and all intermediate Switches also support LTR.
>>     See PCIe r3.1, sec 6.18.
>>
>>     Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
>>     Reviewed-by: Vidya Sagar <vidyas@nvidia.com>
>>
>> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
>> index 14e0ea1..3761b13 100644
>> --- a/drivers/pci/probe.c
>> +++ b/drivers/pci/probe.c
>> @@ -1875,6 +1875,38 @@ static void
>> pci_configure_relaxed_ordering(struct pci_dev *dev)
>>         }
>>  }
>>
>> +static void pci_configure_ltr(struct pci_dev *dev)
>> +{
>> +#ifdef CONFIG_PCIEASPM
>> +       u32 cap;
>> +       struct pci_dev *bridge;
>> +
>> +       if (!pci_is_pcie(dev))
>> +               return;
>> +
>> +       pcie_capability_read_dword(dev, PCI_EXP_DEVCAP2, &cap);
>> +       if (!(cap & PCI_EXP_DEVCAP2_LTR))
>> +               return;
>> +
>> +       /*
>> +        * Software must not enable LTR in an Endpoint unless the Root
>> +        * Complex and all intermediate Switches indicate support for LTR.
>> +        * PCIe r3.1, sec 6.18.
>> +        */
>> +       if (pci_pcie_type(dev) == PCI_EXP_TYPE_ROOT_PORT)
>> +               dev->ltr_path = 1;
>> +       else {
>> +               bridge = pci_upstream_bridge(dev);
>> +               if (bridge && bridge->ltr_path)
>> +                       dev->ltr_path = 1;
>> +       }
>> +
>> +       if (dev->ltr_path)
>> +               pcie_capability_set_word(dev, PCI_EXP_DEVCTL2,
>> +                                        PCI_EXP_DEVCTL2_LTR_EN);
>> +#endif
>> +}
>> +
>>  static void pci_configure_device(struct pci_dev *dev)
>>  {
>>         struct hotplug_params hpp;
>> @@ -1883,6 +1915,7 @@ static void pci_configure_device(struct pci_dev *dev)
>>         pci_configure_mps(dev);
>>         pci_configure_extended_tags(dev, NULL);
>>         pci_configure_relaxed_ordering(dev);
>>
>>
>> Regards,
>> Srinath.
