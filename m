Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-oa0-f41.google.com ([209.85.219.41]:60197 "EHLO
	mail-oa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756692AbaDVPAZ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 22 Apr 2014 11:00:25 -0400
Received: by mail-oa0-f41.google.com with SMTP id j17so5853962oag.0
        for <linux-pci@vger.kernel.org>; Tue, 22 Apr 2014 08:00:23 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <alpine.LRH.2.03.1404220805390.5490@AMR>
References: <1397000541-1085-1-git-send-email-keith.busch@intel.com>
 <1397000541-1085-2-git-send-email-keith.busch@intel.com> <CAP8+hKWcybw5u_m5M4c1p4eUAaTq4x+kO+tnegwD2ciDMEFNCw@mail.gmail.com>
 <alpine.LRH.2.03.1404211935510.5490@AMR> <1E05E2AB-198E-473A-8AA5-87DA2E9910B8@gmail.com>
 <CAP8+hKUEygoeEv=LvY2ccp6cepnXEpi4WGVSaCnRw+zN7BUE_Q@mail.gmail.com>
 <B8DB29EA17EB2742AC3405C31A9B9EE961457B96@ORSMSX111.amr.corp.intel.com> <alpine.LRH.2.03.1404220805390.5490@AMR>
From: Learner Study <learner.study@gmail.com>
Date: Tue, 22 Apr 2014 08:00:03 -0700
Message-ID: <CAP8+hKWcB_ojGT=231ExpdcVSnYGUVEjMMzVAbpYTKGCPf+8Dg@mail.gmail.com>
Subject: Re: [PATCH 2/2] NVMe: Implement PCI-e reset notification callback
To: Keith Busch <keith.busch@intel.com>
Cc: "Mayes, Barrett N" <barrett.n.mayes@intel.com>,
	"bhelgaas@google.com" <bhelgaas@google.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	linux-nvme <linux-nvme@lists.infradead.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Thanks for the clarification that the patch is for FLR, and not NVMe
subsystem Reset event.
Any thoughts on how NVMe subsystem Reset would be handled in future?

Thanks!

On Tue, Apr 22, 2014 at 7:22 AM, Keith Busch <keith.busch@intel.com> wrote:
> On Mon, 21 Apr 2014, Mayes, Barrett N wrote:
>>
>> Section 8.5 of the NVMe 1.1 spec contains the following:  "While the
>> details
>> associated with implementing a controller that supports SR-IOV are outside
>> the scope of this specification, such a controller shall implement fully
>> compliant NVM Express Virtual Functions (VFs). This ensures that the same
>> host software developed for non-virtualized environments is capable of
>> running unmodified within an SI. No such requirement exists for the
>> Physical
>> Function (PF)."
>>
>> If a VF is a fully NVMe compliant device then it must at least act like it
>> implements NVMe subsystem reset.  How the SR-IOV-capable controller
>> actually
>> implements this is left up to the vendor.  But the spec does not require
>> that
>> a reset of one VF initiate a reset of other VF.
>
>
> The NVMe spec does not, but PCI does.
>
> In case it wasn't clear from PATCH 1/2, this proposed callback is for a
> function level reset. The PCI SR-IOV spec says all VF's implement FLR and
> that this reset does not affect any other functions, from section 2.2.2:
>
>   VFs must support Function Level Reset (FLR).
>
>   Note: Software may use FLR to reset a VF. FLR to a VF affects a VF’s
>   state but does not affect its existence in PCI Configuration Space or
>   PCI Bus address space. The VFs BARn values (see Section 3.3.14) and
>   VF MSE (see Section 3.3.3.4) in the PF’s SR-IOV extended capability
>   are unaffected by FLRs issued to the VF.
>
> Further, an NVMe subsystem reset is not the same as a controller or
> function level reset. I have not proposed doing a subsytem reset here.
>
> Since this is a call-back invoked from an FLR that happens outside the
> driver whether the driver wants it to happen or not, it's better the
> driver is aware and prepared that this occured rather than not knowing
> and left to wonder why the heck the controller stopped responding.
