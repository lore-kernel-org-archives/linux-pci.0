Return-Path: <linux-kernel-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CAPz6YkUYU_hSSeU+EyLF3HXuep23t2fc-qtZL41RR6iOWj-CEA@mail.gmail.com>
References: <1429555323-11127-1-git-send-email-sonnyrao@chromium.org>
 <CAErSpo7TkdZ7nHHwFzwqhyTA3X_09x0ywbAmW+m2D-Or1AhyYw@mail.gmail.com>
 <CABPqkBSuQmGD=ho8vJvDw=r2CdW+_gqpapy5sYyzZrPXg0mWfg@mail.gmail.com>
 <CAErSpo7iQgigqV6dhUQsWqzob-3Kwh4-YNPqBBtDMHCOvhtOnQ@mail.gmail.com> <CAPz6YkUYU_hSSeU+EyLF3HXuep23t2fc-qtZL41RR6iOWj-CEA@mail.gmail.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Mon, 20 Apr 2015 15:20:09 -0500
Message-ID: <CAErSpo4g6PRxTeb-4MGhU=bnC84_LRdvGwVc8TU3Fe8HRYuzWg@mail.gmail.com>
Subject: Re: [PATCH] perf/x86/intel/uncore: add support for Haswell ULT IMC uncore
To: Sonny Rao <sonnyrao@chromium.org>
Cc: Stephane Eranian <eranian@google.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Peter Zijlstra <a.p.zijlstra@chello.nl>,
	Paul Mackerras <paulus@samba.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	"H. Peter Anvin" <hpa@zytor.com>,
	"x86@kernel.org" <x86@kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Apr 20, 2015 at 2:43 PM, Sonny Rao <sonnyrao@chromium.org> wrote:
> On Mon, Apr 20, 2015 at 12:34 PM, Bjorn Helgaas <bhelgaas@google.com> wrote:
>> On Mon, Apr 20, 2015 at 1:58 PM, Stephane Eranian <eranian@google.com> wrote:
>>> On Mon, Apr 20, 2015 at 11:56 AM, Bjorn Helgaas <bhelgaas@google.com> wrote:
>>>>
>>>> On Mon, Apr 20, 2015 at 1:42 PM, Sonny Rao <sonnyrao@chromium.org> wrote:
>>>> > This uncore is the same as the Haswell desktop part but uses a
>>>> > different PCI ID.
>>>> >
>>>> > Signed-off-by: Sonny Rao <sonnyrao@chromium.org>
>>>> > ---
>>>> >  arch/x86/kernel/cpu/perf_event_intel_uncore_snb.c | 5 +++++
>>>> >  include/linux/pci_ids.h                           | 1 +
>>>> >  2 files changed, 6 insertions(+)
>>>> >
>>>> > diff --git a/arch/x86/kernel/cpu/perf_event_intel_uncore_snb.c b/arch/x86/kernel/cpu/perf_event_intel_uncore_snb.c
>>>> > index 3001015..0bda6fc 100644
>>>> > --- a/arch/x86/kernel/cpu/perf_event_intel_uncore_snb.c
>>>> > +++ b/arch/x86/kernel/cpu/perf_event_intel_uncore_snb.c
>>>> > @@ -472,6 +472,10 @@ static const struct pci_device_id hsw_uncore_pci_ids[] = {
>>>> >                 PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_HSW_IMC),
>>>> >                 .driver_data = UNCORE_PCI_DEV_DATA(SNB_PCI_UNCORE_IMC, 0),
>>>> >         },
>>>> > +       { /* IMC */
>>>> > +               PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_HSW_U_IMC),
>>>> > +               .driver_data = UNCORE_PCI_DEV_DATA(SNB_PCI_UNCORE_IMC, 0),
>>>> > +       },
>>>> >         { /* end: all zeroes */ },
>>>> >  };
>>>> >
>>>> > @@ -502,6 +506,7 @@ static const struct imc_uncore_pci_dev desktop_imc_pci_ids[] = {
>>>> >         IMC_DEV(IVB_IMC, &ivb_uncore_pci_driver),    /* 3rd Gen Core processor */
>>>> >         IMC_DEV(IVB_E3_IMC, &ivb_uncore_pci_driver), /* Xeon E3-1200 v2/3rd Gen Core processor */
>>>> >         IMC_DEV(HSW_IMC, &hsw_uncore_pci_driver),    /* 4th Gen Core Processor */
>>>> > +       IMC_DEV(HSW_U_IMC, &hsw_uncore_pci_driver),  /* 4th Gen Core ULT Mobile Processor */
>>>> >         {  /* end marker */ }
>>>> >  };
>>>> >
>>>> > diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
>>>> > index 38cff8f..e5ae042 100644
>>>> > --- a/include/linux/pci_ids.h
>>>> > +++ b/include/linux/pci_ids.h
>>>> > @@ -2545,6 +2545,7 @@
>>>> >  #define PCI_DEVICE_ID_INTEL_IVB_IMC    0x0154
>>>> >  #define PCI_DEVICE_ID_INTEL_IVB_E3_IMC 0x0150
>>>> >  #define PCI_DEVICE_ID_INTEL_HSW_IMC    0x0c00
>>>> > +#define PCI_DEVICE_ID_INTEL_HSW_U_IMC  0x0a04
>>>>
>>>> Please either use the 0x0a04 constant directly in
>>>> perf_event_intel_uncore_snb.c, or explain why the #define should be
>>>> here, e.g., maybe it will be used in multiple places.  See the comment
>>>> at the top of pci_ids.h.
>>>>
>>> But then, the same reasoning would apply to the other 3 IMC defines,
>>> wouldn't it?
>>
>> Yes.  But if we made a mistake in the past, that doesn't mean we
>> should repeat it today.
>
> Shall I post a patch moving the others as well?

I'm not pushing for that, since they're already there and we haven't
tried to apply that policy retroactively.

>>>> >  #define PCI_DEVICE_ID_INTEL_PXHD_0     0x0320
>>>> >  #define PCI_DEVICE_ID_INTEL_PXHD_1     0x0321
>>>> >  #define PCI_DEVICE_ID_INTEL_PXH_0      0x0329
>>>> > --
>>>> > 2.1.2
>>>> >
