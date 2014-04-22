Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:6525 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751280AbaDVFCG convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 22 Apr 2014 01:02:06 -0400
From: "Mayes, Barrett N" <barrett.n.mayes@intel.com>
To: Learner Study <learner.study@gmail.com>,
	"Busch, Keith" <keith.busch@intel.com>
CC: "bhelgaas@google.com" <bhelgaas@google.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	linux-nvme <linux-nvme@lists.infradead.org>
Subject: RE: [PATCH 2/2] NVMe: Implement PCI-e reset notification callback
Date: Tue, 22 Apr 2014 05:02:02 +0000
Message-ID: <B8DB29EA17EB2742AC3405C31A9B9EE961457B96@ORSMSX111.amr.corp.intel.com>
References: <1397000541-1085-1-git-send-email-keith.busch@intel.com>
 <1397000541-1085-2-git-send-email-keith.busch@intel.com>
 <CAP8+hKWcybw5u_m5M4c1p4eUAaTq4x+kO+tnegwD2ciDMEFNCw@mail.gmail.com>
 <alpine.LRH.2.03.1404211935510.5490@AMR>
 <1E05E2AB-198E-473A-8AA5-87DA2E9910B8@gmail.com>
 <CAP8+hKUEygoeEv=LvY2ccp6cepnXEpi4WGVSaCnRw+zN7BUE_Q@mail.gmail.com>
In-Reply-To: <CAP8+hKUEygoeEv=LvY2ccp6cepnXEpi4WGVSaCnRw+zN7BUE_Q@mail.gmail.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Section 8.5 of the NVMe 1.1 spec contains the following:  "While the details associated with implementing a controller that supports SR-IOV are outside the scope of this specification, such a controller shall implement fully compliant NVM Express Virtual Functions (VFs). This ensures that the same host software developed for non-virtualized environments is capable of running unmodified within an SI. No such requirement exists for the Physical Function (PF)."

If a VF is a fully NVMe compliant device then it must at least act like it implements NVMe subsystem reset.  How the SR-IOV-capable controller actually implements this is left up to the vendor.  But the spec does not require that a reset of one VF initiate a reset of other VF.

-----Original Message-----
From: Linux-nvme [mailto:linux-nvme-bounces@lists.infradead.org] On Behalf Of Learner Study
Sent: Monday, April 21, 2014 8:34 PM
To: Busch, Keith
Cc: bhelgaas@google.com; linux-pci@vger.kernel.org; linux-nvme
Subject: Re: [PATCH 2/2] NVMe: Implement PCI-e reset notification callback

Per the spec, "When an NVM Subsystem Reset occurs, the entire NVM subsystem is reset"....so all VFs would get impacted, if a VF does a Reset. So, I think Reset kind of control should be in PF mode only.

On Mon, Apr 21, 2014 at 7:45 PM, Learner <learner.study@gmail.com> wrote:
> But Won't resetting from a VF impact functionality of other VFs?
>
> On Apr 21, 2014, at 6:57 PM, Keith Busch <keith.busch@intel.com> wrote:
>
>> On Mon, 21 Apr 2014, Learner Study wrote:
>>> Hi Keith,
>>>
>>> I think NVMe Reset should apply to PF mode driver only, and not to 
>>> VF mode driver.
>>> Is that understanding correct? Does the NVMe driver know which mode 
>>> its running in?
>>
>> Oh, this driver doesn't enable SR-IOV and has no PF/VF awareness. 
>> Shame on us, I'll add it to my list unless someone beats me to it.
>>
>> Still, I think we'd like to be able to reset a VF if only because it 
>> gets the queues back to a pristine state. A VF reset should not 
>> affect any of the other functions.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
