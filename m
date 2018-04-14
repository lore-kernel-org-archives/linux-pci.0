Return-Path: <SRS0=do/p=HD=broadcom.com=srinath.mannam@kernel.org>
Return-Path: <SRS0=do/p=HD=broadcom.com=srinath.mannam@kernel.org>
MIME-Version: 1.0
In-Reply-To: <20180413211651.GA80087@bhelgaas-glaptop.roam.corp.google.com>
References: <CABe79T47vUjq20HuMrJZxhZWMr0q3uXMF6xL1TgkqhqA8qi1wg@mail.gmail.com>
 <20180413135659.GC46420@bhelgaas-glaptop.roam.corp.google.com>
 <CABe79T4nO7dC9uHwX-woAvkdw0+b2ssUyxgs0cnGo90OH_YD+Q@mail.gmail.com> <20180413211651.GA80087@bhelgaas-glaptop.roam.corp.google.com>
From: Srinath Mannam <srinath.mannam@broadcom.com>
Date: Sat, 14 Apr 2018 09:04:05 +0530
Message-ID: <CABe79T4XC07tExSTOEoj9d5hkYWsm5QHUMD8rWorzz8S=V0yUA@mail.gmail.com>
Subject: Re: Issue with Enable LTR while pcie_aspm off
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Ray Jui <ray.jui@broadcom.com>, linux-pci@vger.kernel.org,
	Rajat Jain <rajatja@google.com>
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-pci.vger.kernel.org>

Hi Bjorn,

Thank you for the patch. I will try on monday and let you know the results.

I am sorry, in previous mail by mistake I have written L1.s support is
not there, Actually I wanted to write L0s support is not there.
L1 and L1ss support is there.

But In our platform we required to disable ASPM.

RC in our platform supports upto Gen3 only.

I dnot have setup access now. I will share lspci output and results of
your patch on monday.

Hi Rajat,

Device stop responding means, completion timeout for config read.


Regards,
Srinath.

On Sat, Apr 14, 2018 at 2:46 AM, Bjorn Helgaas <helgaas@kernel.org> wrote:
> On Fri, Apr 13, 2018 at 09:13:42PM +0530, Srinath Mannam wrote:
>> Hi Bjorn,
>>
>> Thank you very much for quick response.
>>
>> I am using samsung NVMe card as EP connected to our platform. As per
>> link capabilities device does not support L1.s.
>> But LTR is enabled in DEVCAP2.
>
> Interesting that the device advertises LTR support, but not L1.2
> support.  As far as I can tell, that's legal per spec, but I don't
> know what the LTR info would be used for.  The only use I know about
> is comparison with LTR_L1.2_THRESHOLD, as in PCIe r4.0, sec 5.5.1.
>
> Can you attach lspci -vv output for the NVMe device and all the
> devices in the path leading to it?
>
>> In my observation after setting LTR without enabling ASPM (common
>> clock and link retraining) in software, device stopped responding.
>
> From sec 5.5.1, it seems clear that LTR would have to be enabled
> before L1.2 is enabled, because the decision to enter L1.2 depends on
> information from LTR messages.
>
> Since the device advertised LTR support, it seems like a hardware
> defect if enabling it breaks something.  But I can imagine that if it
> doesn't advertise L1.2 support, nobody expected LTR to be used.  Can
> you try the patch below?  It should make it so we don't enable LTR
> unless we also support L1.2.  Maybe that's enough to avoid the issue.
>
> Bjorn
>
>
> diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
> index f76eb7704f64..9e2212889e7e 100644
> --- a/drivers/pci/pcie/aspm.c
> +++ b/drivers/pci/pcie/aspm.c
> @@ -400,6 +400,16 @@ static void pcie_get_aspm_reg(struct pci_dev *pdev,
>                 info->l1ss_cap = 0;
>                 return;
>         }
> +
> +       /*
> +        * If we don't have LTR for the entire path from the Root Complex
> +        * to this device, we can't use L1.2.  PCIe r4.0, secs 5.5.4, 6.18.
> +        */
> +       if (!pdev->ltr_path) {
> +               info->l1ss_cap &= ~PCI_L1SS_CTL1_PCIPM_L1_2;
> +               info->l1ss_cap &= ~PCI_L1SS_CTL1_ASPM_L1_2;
> +       }
> +
>         pci_read_config_dword(pdev, info->l1ss_cap_ptr + PCI_L1SS_CTL1,
>                               &info->l1ss_ctl1);
>         pci_read_config_dword(pdev, info->l1ss_cap_ptr + PCI_L1SS_CTL2,
> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> index ac91b6fd0bcd..9a224612b3f8 100644
> --- a/drivers/pci/probe.c
> +++ b/drivers/pci/probe.c
> @@ -1954,12 +1954,29 @@ static void pci_configure_relaxed_ordering(struct pci_dev *dev)
>  static void pci_configure_ltr(struct pci_dev *dev)
>  {
>  #ifdef CONFIG_PCIEASPM
> -       u32 cap;
> +       u32 cap, l1ss_cap, l1ss;
>         struct pci_dev *bridge;
>
>         if (!pci_is_pcie(dev))
>                 return;
>
> +       /*
> +        * Per PCIe r4.0, sec 5.5.4, we must program LTR_L1.2_THRESHOLD if
> +        * either L1.2 enable bit is set.  That suggests that LTR must be
> +        * enabled before L1.2.  If the device (and the entire path leading
> +        * to it) advertises L1.2 and LTR support, enable LTR.
> +        */
> +       l1ss_cap = pci_find_ext_capability(dev, PCI_EXT_CAP_ID_L1SS);
> +       if (!l1ss_cap)
> +               return;
> +
> +       pci_read_config_dword(dev, l1ss_cap + PCI_L1SS_CAP, &l1ss);
> +       if (!(l1ss & PCI_L1SS_CAP_L1_PM_SS))
> +               return;
> +
> +       if (!(l1ss & (PCI_L1SS_CAP_PCIPM_L1_2 | PCI_L1SS_CAP_ASPM_L1_2)))
> +               return;
> +
>         pcie_capability_read_dword(dev, PCI_EXP_DEVCAP2, &cap);
>         if (!(cap & PCI_EXP_DEVCAP2_LTR))
>                 return;
> @@ -1967,7 +1984,7 @@ static void pci_configure_ltr(struct pci_dev *dev)
>         /*
>          * Software must not enable LTR in an Endpoint unless the Root
>          * Complex and all intermediate Switches indicate support for LTR.
> -        * PCIe r3.1, sec 6.18.
> +        * PCIe r4.0, sec 6.18.
>          */
>         if (pci_pcie_type(dev) == PCI_EXP_TYPE_ROOT_PORT)
>                 dev->ltr_path = 1;
