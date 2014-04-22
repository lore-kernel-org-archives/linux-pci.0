Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:5712 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752201AbaDVOW1 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Tue, 22 Apr 2014 10:22:27 -0400
Date: Tue, 22 Apr 2014 08:22:25 -0600 (MDT)
From: Keith Busch <keith.busch@intel.com>
To: "Mayes, Barrett N" <barrett.n.mayes@intel.com>
cc: Learner Study <learner.study@gmail.com>,
	"Busch, Keith" <keith.busch@intel.com>,
	"bhelgaas@google.com" <bhelgaas@google.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	linux-nvme <linux-nvme@lists.infradead.org>
Subject: RE: [PATCH 2/2] NVMe: Implement PCI-e reset notification callback
In-Reply-To: <B8DB29EA17EB2742AC3405C31A9B9EE961457B96@ORSMSX111.amr.corp.intel.com>
Message-ID: <alpine.LRH.2.03.1404220805390.5490@AMR>
References: <1397000541-1085-1-git-send-email-keith.busch@intel.com> <1397000541-1085-2-git-send-email-keith.busch@intel.com> <CAP8+hKWcybw5u_m5M4c1p4eUAaTq4x+kO+tnegwD2ciDMEFNCw@mail.gmail.com> <alpine.LRH.2.03.1404211935510.5490@AMR>
 <1E05E2AB-198E-473A-8AA5-87DA2E9910B8@gmail.com> <CAP8+hKUEygoeEv=LvY2ccp6cepnXEpi4WGVSaCnRw+zN7BUE_Q@mail.gmail.com> <B8DB29EA17EB2742AC3405C31A9B9EE961457B96@ORSMSX111.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323328-1184062565-1398176546=:5490"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1184062565-1398176546=:5490
Content-Type: TEXT/PLAIN; charset=ISO-8859-7; format=flowed
Content-Transfer-Encoding: 8BIT

On Mon, 21 Apr 2014, Mayes, Barrett N wrote:
> Section 8.5 of the NVMe 1.1 spec contains the following:  "While the details
> associated with implementing a controller that supports SR-IOV are outside
> the scope of this specification, such a controller shall implement fully
> compliant NVM Express Virtual Functions (VFs). This ensures that the same
> host software developed for non-virtualized environments is capable of
> running unmodified within an SI. No such requirement exists for the Physical
> Function (PF)."
>
> If a VF is a fully NVMe compliant device then it must at least act like it
> implements NVMe subsystem reset.  How the SR-IOV-capable controller actually
> implements this is left up to the vendor.  But the spec does not require that
> a reset of one VF initiate a reset of other VF.

The NVMe spec does not, but PCI does.

In case it wasn't clear from PATCH 1/2, this proposed callback is for a
function level reset. The PCI SR-IOV spec says all VF's implement FLR and
that this reset does not affect any other functions, from section 2.2.2:

   VFs must support Function Level Reset (FLR).

   Note: Software may use FLR to reset a VF. FLR to a VF affects a VF¢s
   state but does not affect its existence in PCI Configuration Space or
   PCI Bus address space. The VFs BARn values (see Section 3.3.14) and
   VF MSE (see Section 3.3.3.4) in the PF¢s SR-IOV extended capability
   are unaffected by FLRs issued to the VF.

Further, an NVMe subsystem reset is not the same as a controller or
function level reset. I have not proposed doing a subsytem reset here.

Since this is a call-back invoked from an FLR that happens outside the
driver whether the driver wants it to happen or not, it's better the
driver is aware and prepared that this occured rather than not knowing
and left to wonder why the heck the controller stopped responding.
--8323328-1184062565-1398176546=:5490--
