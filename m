Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-oi0-f48.google.com ([209.85.218.48]:36341 "EHLO
	mail-oi0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751295AbbDTS6J (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 20 Apr 2015 14:58:09 -0400
Received: by oift201 with SMTP id t201so134821353oif.3
        for <linux-pci@vger.kernel.org>; Mon, 20 Apr 2015 11:58:08 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAErSpo7TkdZ7nHHwFzwqhyTA3X_09x0ywbAmW+m2D-Or1AhyYw@mail.gmail.com>
References: <1429555323-11127-1-git-send-email-sonnyrao@chromium.org>
	<CAErSpo7TkdZ7nHHwFzwqhyTA3X_09x0ywbAmW+m2D-Or1AhyYw@mail.gmail.com>
Date: Mon, 20 Apr 2015 11:58:08 -0700
Message-ID: <CABPqkBSuQmGD=ho8vJvDw=r2CdW+_gqpapy5sYyzZrPXg0mWfg@mail.gmail.com>
Subject: Re: [PATCH] perf/x86/intel/uncore: add support for Haswell ULT IMC uncore
From: Stephane Eranian <eranian@google.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Sonny Rao <sonnyrao@chromium.org>,
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
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Apr 20, 2015 at 11:56 AM, Bjorn Helgaas <bhelgaas@google.com> wrote:
>
> On Mon, Apr 20, 2015 at 1:42 PM, Sonny Rao <sonnyrao@chromium.org> wrote:
> > This uncore is the same as the Haswell desktop part but uses a
> > different PCI ID.
> >
> > Signed-off-by: Sonny Rao <sonnyrao@chromium.org>
> > ---
> >  arch/x86/kernel/cpu/perf_event_intel_uncore_snb.c | 5 +++++
> >  include/linux/pci_ids.h                           | 1 +
> >  2 files changed, 6 insertions(+)
> >
> > diff --git a/arch/x86/kernel/cpu/perf_event_intel_uncore_snb.c b/arch/x86/kernel/cpu/perf_event_intel_uncore_snb.c
> > index 3001015..0bda6fc 100644
> > --- a/arch/x86/kernel/cpu/perf_event_intel_uncore_snb.c
> > +++ b/arch/x86/kernel/cpu/perf_event_intel_uncore_snb.c
> > @@ -472,6 +472,10 @@ static const struct pci_device_id hsw_uncore_pci_ids[] = {
> >                 PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_HSW_IMC),
> >                 .driver_data = UNCORE_PCI_DEV_DATA(SNB_PCI_UNCORE_IMC, 0),
> >         },
> > +       { /* IMC */
> > +               PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_HSW_U_IMC),
> > +               .driver_data = UNCORE_PCI_DEV_DATA(SNB_PCI_UNCORE_IMC, 0),
> > +       },
> >         { /* end: all zeroes */ },
> >  };
> >
> > @@ -502,6 +506,7 @@ static const struct imc_uncore_pci_dev desktop_imc_pci_ids[] = {
> >         IMC_DEV(IVB_IMC, &ivb_uncore_pci_driver),    /* 3rd Gen Core processor */
> >         IMC_DEV(IVB_E3_IMC, &ivb_uncore_pci_driver), /* Xeon E3-1200 v2/3rd Gen Core processor */
> >         IMC_DEV(HSW_IMC, &hsw_uncore_pci_driver),    /* 4th Gen Core Processor */
> > +       IMC_DEV(HSW_U_IMC, &hsw_uncore_pci_driver),  /* 4th Gen Core ULT Mobile Processor */
> >         {  /* end marker */ }
> >  };
> >
> > diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
> > index 38cff8f..e5ae042 100644
> > --- a/include/linux/pci_ids.h
> > +++ b/include/linux/pci_ids.h
> > @@ -2545,6 +2545,7 @@
> >  #define PCI_DEVICE_ID_INTEL_IVB_IMC    0x0154
> >  #define PCI_DEVICE_ID_INTEL_IVB_E3_IMC 0x0150
> >  #define PCI_DEVICE_ID_INTEL_HSW_IMC    0x0c00
> > +#define PCI_DEVICE_ID_INTEL_HSW_U_IMC  0x0a04
>
> Please either use the 0x0a04 constant directly in
> perf_event_intel_uncore_snb.c, or explain why the #define should be
> here, e.g., maybe it will be used in multiple places.  See the comment
> at the top of pci_ids.h.
>
But then, the same reasoning would apply to the other 3 IMC defines,
wouldn't it?

>
> >  #define PCI_DEVICE_ID_INTEL_PXHD_0     0x0320
> >  #define PCI_DEVICE_ID_INTEL_PXHD_1     0x0321
> >  #define PCI_DEVICE_ID_INTEL_PXH_0      0x0329
> > --
> > 2.1.2
> >
