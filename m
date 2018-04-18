Return-Path: <SRS0=JGhu=HH=broadcom.com=srinath.mannam@kernel.org>
Return-Path: <SRS0=JGhu=HH=broadcom.com=srinath.mannam@kernel.org>
MIME-Version: 1.0
In-Reply-To: <20180417171111.GI28657@bhelgaas-glaptop.roam.corp.google.com>
References: <CABe79T47vUjq20HuMrJZxhZWMr0q3uXMF6xL1TgkqhqA8qi1wg@mail.gmail.com>
 <20180413135659.GC46420@bhelgaas-glaptop.roam.corp.google.com>
 <CABe79T4nO7dC9uHwX-woAvkdw0+b2ssUyxgs0cnGo90OH_YD+Q@mail.gmail.com>
 <20180413211651.GA80087@bhelgaas-glaptop.roam.corp.google.com>
 <CABe79T4XC07tExSTOEoj9d5hkYWsm5QHUMD8rWorzz8S=V0yUA@mail.gmail.com>
 <20180414160918.GA158153@bhelgaas-glaptop.roam.corp.google.com>
 <CABe79T5Qzm1uSSZJH38pgYrSuhxo1W-EJK-LU+NpWBgvoehm2w@mail.gmail.com>
 <20180416213536.GC28657@bhelgaas-glaptop.roam.corp.google.com>
 <CABe79T630o8cHkLZDZ8N+8f6MjsS7JE2ggLAv5Z0XuM9Eqsa7Q@mail.gmail.com> <20180417171111.GI28657@bhelgaas-glaptop.roam.corp.google.com>
From: Srinath Mannam <srinath.mannam@broadcom.com>
Date: Wed, 18 Apr 2018 14:35:24 +0530
Message-ID: <CABe79T7K4tGnm-9=pR4hZsUTOQXdkTCT2-9kksZFwUU7xBP7gQ@mail.gmail.com>
Subject: Re: Issue with Enable LTR while pcie_aspm off
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Ray Jui <ray.jui@broadcom.com>, linux-pci@vger.kernel.org,
	Rajat Jain <rajatja@google.com>, Keith Busch <keith.busch@intel.com>,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-pci.vger.kernel.org>

Hi Bjorn,

Thank you very much for you time and solution.

On Tue, Apr 17, 2018 at 10:41 PM, Bjorn Helgaas <helgaas@kernel.org> wrote:
> On Tue, Apr 17, 2018 at 02:33:52PM +0530, Srinath Mannam wrote:
>> Hi Bjorn,
>>
>> Thank you for more insight you have given about the problem.
>>
>> For us the issue comes before we disable apst feature.
>> on APST quirk set, NVMe driver disable apst by send a command to NVMe
>> controller.
>> We see issue at the time of NVMe initialization only.
>>
>> So APST quirk did not helped.
>
> OK, thanks for checking that.
>
>> On Tue, Apr 17, 2018 at 3:05 AM, Bjorn Helgaas <helgaas@kernel.org> wrote:
>> > On Mon, Apr 16, 2018 at 09:03:33PM +0530, Srinath Mannam wrote:
>> >> On Sat, Apr 14, 2018 at 9:39 PM, Bjorn Helgaas <helgaas@kernel.org> wrote:
>> >> > On Sat, Apr 14, 2018 at 09:04:05AM +0530, Srinath Mannam wrote:
>
>> >> >> But In our platform we required to disable ASPM.
>> >>
>> >> > We're trying to figure out exactly *why* you must disable ASPM.  If
>> >> > it's because of a hardware defect, e.g., the device advertises ASPM
>> >> > support but it's actually broken, we probably need to add a quirk.
>> >> > Given the complexity of ASPM, it's surprising we don't have similar
>> >> > quirks already.
>> >>
>> >> We see issues with ASPM enabled. Some link issues observed so for
>> >> time being we are using with aspm disabled until we fix that issue.
>> >> ...
>
>> >> with LTR enabled also we observed some problem, that after LTR
>> >> messages received from EP, we see completion timeout with config
>> >> write.
>> >
>> >> So I thought If LTR configuration function also part of aspm file,
>> >> as it was under CONFIG_ASPM.  using pcie_aspm boot arg I can disable
>> >> both ASPM and LTR.
>> >
>> >> If this is not possible, then I will go for alternative solution of
>> >> quirk implementation as you suggest.
>> >
>> > Is this platform a lab prototype or is it already shipping?  If it's
>> > already shipping, you probably need some sort of upstream solution
>> > like an NVMe or PCIe quirk, but if not, maybe you can just hack your
>> > bringup kernel to disable ASPM and LTR until you fix the root cause.
>> >
>> we are at evolution stage so we need to fix this ASAP.
>> As you said earlier, Can I add sysfs interface to enable LTR same as
>> we do L1SS or in the part of aspm cap init function.
>
> I don't know what evolution stage means, but it sounds like you do
> need an upstream fix.
>
> I don't understand the root cause of the problem yet, so I don't know
> what the best solution for you is.  Turning off LTR and ASPM
> completely is a pretty big hammer.  Ideally we could isolate this to
> certain devices or certain pieces of ASPM so we could still get some
> of the benefit.
>
>   - Do you need to disable LTR on the entire system, or just for the
>     Samsung NVMe device?
>
We see both ASPM and LTR issues with samsung device SM961/PM961.
But the same device works fine with multiple other platforms, means we
have to debug our RC.

>   - Do you need to disable LTR if you replace the Samsung device with
>     something else?
>
So far we see issue with samsung device only. Need to explore more.

>   - LTR is only needed for the ASPM L1.2 substate.  Do you need to
>     completely disable ASPM, or is it sufficient to disable LTR and
>     the ASPM L1.2 substate?

We need to disable common clock configuration which is done in the part of ASPM.
If we enable common clock, we see issues with samsung device.
>
> Here are some patches you can try.  These require some tweaking based
> on what the root cause of the problem is.
>
>   1  PCI/ACPI: Request control of LTR from the platform
>   2  PCI/ASPM: Disable ASPM L1.2 Substate if we don't have LTR
>   3  PCI: Enable LTR only if ASPM is enabled
>   4  PCI: Disable LTR for Samsung NVMe SSD Controller SM961/PM961
>
> If LTR is completely broken for all devices on your platform, and
> disabling it and the ASPM L1.2 substate is sufficient, you could use
> patches 1 and 2 along with a PCI or DMI quirk to clear
> host->native_ltr.  That should prevent use of LTR and the ASPM L1.2
> substate.
>
> Patch 3 should disable LTR as well as all of ASPM (not just the ASPM
> L1.2 substate) if you boot with "pcie_aspm=off".  I don't like this
> very well because the user experience is poor -- you need a release
> note or something telling the user to boot with "pcie_aspm=off", which
> is a really ugly solution.
>
> If the problem is some sort of interaction between the Samsung SSD and
> your platform, you could use patches 2 and 4 to disable LTR and ASPM
> L1.2 just for that device in your system.  Of course, you would need
> to add a DMI or similar check in the quirk, because we can't disable
> LTR and ASPM L1.2 for the Samsung SSD in *all* systems.
>
> I think patches 1-3 are candidates for the mainline kernel, regardless
> of whether you need them yourself.
>
As you suggested I am using patch 2 and 4 which are suitable to our requirement.
Until we resolve the HW issue, we will continue to use these patches.

>
> commit 0e78bd8bd5a99f47282b1ab5dbd679d28ff3b460
> Author: Bjorn Helgaas <bhelgaas@google.com>
> Date:   Tue Apr 17 10:58:09 2018 -0500
>
>     PCI/ACPI: Request control of LTR from the platform
>
>     Per the PCI Firmware spec r3.2, sec 4.5, the OS should request control of
>     Latency Tolerance Reporting (LTR) before using it.  LTR is only required
>     for the ASPM L1.2 Substate.
>
>     If we support ASPM, request control of LTR.  If the platform does not grant
>     us control of LTR, don't use it.
>
> diff --git a/drivers/acpi/pci_root.c b/drivers/acpi/pci_root.c
> index 0da18bde6a16..f32d767e8e3b 100644
> --- a/drivers/acpi/pci_root.c
> +++ b/drivers/acpi/pci_root.c
> @@ -153,6 +153,7 @@ static struct pci_osc_bit_struct pci_osc_control_bit[] = {
>         { OSC_PCI_EXPRESS_PME_CONTROL, "PME" },
>         { OSC_PCI_EXPRESS_AER_CONTROL, "AER" },
>         { OSC_PCI_EXPRESS_CAPABILITY_CONTROL, "PCIeCapability" },
> +       { OSC_PCI_EXPRESS_LTR_CONTROL, "LTR" },
>  };
>
>  static void decode_osc_bits(struct acpi_pci_root *root, char *msg, u32 word,
> @@ -475,6 +476,10 @@ static void negotiate_os_control(struct acpi_pci_root *root, int *no_aspm)
>                 | OSC_PCI_EXPRESS_NATIVE_HP_CONTROL
>                 | OSC_PCI_EXPRESS_PME_CONTROL;
>
> +#ifdef CONFIG_PCIEASPM
> +       control |= OSC_PCI_EXPRESS_LTR_CONTROL;
> +#endif
> +
>         if (pci_aer_available()) {
>                 if (aer_acpi_firmware_first())
>                         dev_info(&device->dev,
> @@ -905,6 +910,8 @@ struct pci_bus *acpi_pci_root_create(struct acpi_pci_root *root,
>                 host_bridge->native_aer = 0;
>         if (!(root->osc_control_set & OSC_PCI_EXPRESS_PME_CONTROL))
>                 host_bridge->native_pme = 0;
> +       if (!(root->osc_control_set & OSC_PCI_EXPRESS_LTR_CONTROL))
> +               host_bridge->native_ltr = 0;
>
>         pci_scan_child_bus(bus);
>         pci_set_host_bridge_release(host_bridge, acpi_pci_root_release_info,
> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> index ac91b6fd0bcd..cc1688d75664 100644
> --- a/drivers/pci/probe.c
> +++ b/drivers/pci/probe.c
> @@ -554,6 +554,7 @@ struct pci_host_bridge *pci_alloc_host_bridge(size_t priv)
>         bridge->native_aer = 1;
>         bridge->native_hotplug = 1;
>         bridge->native_pme = 1;
> +       bridge->native_ltr = 1;
>
>         return bridge;
>  }
> @@ -1954,9 +1955,13 @@ static void pci_configure_relaxed_ordering(struct pci_dev *dev)
>  static void pci_configure_ltr(struct pci_dev *dev)
>  {
>  #ifdef CONFIG_PCIEASPM
> +       struct pci_host_bridge *host = pci_find_host_bridge(dev->bus);
>         u32 cap;
>         struct pci_dev *bridge;
>
> +       if (!host->native_ltr)
> +               return;
> +
>         if (!pci_is_pcie(dev))
>                 return;
>
> diff --git a/include/linux/acpi.h b/include/linux/acpi.h
> index 15bfb15c2fa5..49f63c67a9d1 100644
> --- a/include/linux/acpi.h
> +++ b/include/linux/acpi.h
> @@ -506,7 +506,8 @@ extern bool osc_pc_lpi_support_confirmed;
>  #define OSC_PCI_EXPRESS_PME_CONTROL            0x00000004
>  #define OSC_PCI_EXPRESS_AER_CONTROL            0x00000008
>  #define OSC_PCI_EXPRESS_CAPABILITY_CONTROL     0x00000010
> -#define OSC_PCI_CONTROL_MASKS                  0x0000001f
> +#define OSC_PCI_EXPRESS_LTR_CONTROL            0x00000020
> +#define OSC_PCI_CONTROL_MASKS                  0x0000003f
>
>  #define ACPI_GSB_ACCESS_ATTRIB_QUICK           0x00000002
>  #define ACPI_GSB_ACCESS_ATTRIB_SEND_RCV         0x00000004
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index 73178a2fcee0..d0149c01996d 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -473,6 +473,7 @@ struct pci_host_bridge {
>         unsigned int    native_aer:1;           /* OS may use PCIe AER */
>         unsigned int    native_hotplug:1;       /* OS may use PCIe hotplug */
>         unsigned int    native_pme:1;           /* OS may use PCIe PME */
> +       unsigned int    native_ltr:1;           /* OS may use PCIe LTR */
>         /* Resource alignment requirements */
>         resource_size_t (*align_resource)(struct pci_dev *dev,
>                         const struct resource *res,
>
> commit 4c65e86ad91284f4ceac1a8cbde86855829f3db8
> Author: Bjorn Helgaas <bhelgaas@google.com>
> Date:   Tue Apr 17 11:25:51 2018 -0500
>
>     PCI/ASPM: Disable ASPM L1.2 Substate if we don't have LTR
>
>     When in the ASPM L1.0 state (but not the PCI-PM L1.0 state), the most
>     recent LTR value and the LTR_L1.2_THRESHOLD determines whether the link
>     enters the L1.2 substate.
>
>     If we don't have LTR enabled, prevent the use of ASPM L1.2.
>
>     PCI-PM L1.2 may still be used because it doesn't depend on
>     LTR_L1.2_THRESHOLD (see PCIe r4.0, sec 5.5.1).
>
> diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
> index f76eb7704f64..938ced5bbbfc 100644
> --- a/drivers/pci/pcie/aspm.c
> +++ b/drivers/pci/pcie/aspm.c
> @@ -400,6 +400,15 @@ static void pcie_get_aspm_reg(struct pci_dev *pdev,
>                 info->l1ss_cap = 0;
>                 return;
>         }
> +
> +       /*
> +        * If we don't have LTR for the entire path from the Root Complex
> +        * to this device, we can't use ASPM L1.2 because it relies on the
> +        * LTR_L1.2_THRESHOLD.  See PCIe r4.0, secs 5.5.4, 6.18.
> +        */
> +       if (!pdev->ltr_path)
> +               info->l1ss_cap &= ~PCI_L1SS_CTL1_ASPM_L1_2;
> +
>         pci_read_config_dword(pdev, info->l1ss_cap_ptr + PCI_L1SS_CTL1,
>                               &info->l1ss_ctl1);
>         pci_read_config_dword(pdev, info->l1ss_cap_ptr + PCI_L1SS_CTL2,
>
> commit a4229ad9e9d9c8acf1f1e43444f93372a4fbc8c2
> Author: Bjorn Helgaas <bhelgaas@google.com>
> Date:   Tue Apr 17 11:54:06 2018 -0500
>
>     PCI: Enable LTR only if ASPM is enabled
>
>     The only time we need LTR is when we enable the ASPM L1.2 substate.  If
>     ASPM is disabled, don't bother enabling LTR.
>
> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> index cc1688d75664..988876a2868f 100644
> --- a/drivers/pci/probe.c
> +++ b/drivers/pci/probe.c
> @@ -1962,6 +1962,9 @@ static void pci_configure_ltr(struct pci_dev *dev)
>         if (!host->native_ltr)
>                 return;
>
> +       if (!pcie_aspm_support_enabled())
> +               return;
> +
>         if (!pci_is_pcie(dev))
>                 return;
>
>
> commit c62d4a5e5006ed71e154fe49ed64e78c16ffaebc
> Author: Bjorn Helgaas <bhelgaas@google.com>
> Date:   Tue Apr 17 10:27:26 2018 -0500
>
>     PCI: Disable LTR for Samsung NVMe SSD Controller SM961/PM961
>
>     This is just for testing purposes.  Obviously we can't disable LTR (and
>     hence ASPM L1 Substates) for this device in *all* systems, because it works
>     in most cases.
>
> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> index 988876a2868f..25dcf4817e8a 100644
> --- a/drivers/pci/probe.c
> +++ b/drivers/pci/probe.c
> @@ -1962,6 +1962,9 @@ static void pci_configure_ltr(struct pci_dev *dev)
>         if (!host->native_ltr)
>                 return;
>
> +       if (dev->no_ltr)
> +               return;
> +
>         if (!pcie_aspm_support_enabled())
>                 return;
>
> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> index 2990ad1e7c99..ae0a088373e9 100644
> --- a/drivers/pci/quirks.c
> +++ b/drivers/pci/quirks.c
> @@ -4741,3 +4741,9 @@ DECLARE_PCI_FIXUP_CLASS_FINAL(PCI_VENDOR_ID_AMD, PCI_ANY_ID,
>                               PCI_CLASS_MULTIMEDIA_HD_AUDIO, 8, quirk_gpu_hda);
>  DECLARE_PCI_FIXUP_CLASS_FINAL(PCI_VENDOR_ID_NVIDIA, PCI_ANY_ID,
>                               PCI_CLASS_MULTIMEDIA_HD_AUDIO, 8, quirk_gpu_hda);
> +
> +static void quirk_samsung_ssd(struct pci_dev *dev)
> +{
> +       dev->no_ltr = 1;
> +}
> +DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_SAMSUNG, 0xa804, quirk_samsung_ssd);
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index d0149c01996d..443802bc5663 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -346,6 +346,7 @@ struct pci_dev {
>
>  #ifdef CONFIG_PCIEASPM
>         struct pcie_link_state  *link_state;    /* ASPM link state */
> +       unsigned int    no_ltr:1;       /* May not use LTR */
>         unsigned int    ltr_path:1;     /* Latency Tolerance Reporting
>                                            supported from root to here */
>  #endif


Thank you again,

Regards,
Srinath.
