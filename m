Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pd0-f174.google.com ([209.85.192.174]:64184 "EHLO
	mail-pd0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751267AbaDVCpV (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 21 Apr 2014 22:45:21 -0400
Received: by mail-pd0-f174.google.com with SMTP id y13so4272122pdi.5
        for <linux-pci@vger.kernel.org>; Mon, 21 Apr 2014 19:45:20 -0700 (PDT)
References: <1397000541-1085-1-git-send-email-keith.busch@intel.com> <1397000541-1085-2-git-send-email-keith.busch@intel.com> <CAP8+hKWcybw5u_m5M4c1p4eUAaTq4x+kO+tnegwD2ciDMEFNCw@mail.gmail.com> <alpine.LRH.2.03.1404211935510.5490@AMR>
In-Reply-To: <alpine.LRH.2.03.1404211935510.5490@AMR>
Mime-Version: 1.0 (1.0)
Content-Type: text/plain;
	charset=us-ascii
Message-Id: <1E05E2AB-198E-473A-8AA5-87DA2E9910B8@gmail.com>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	linux-nvme <linux-nvme@lists.infradead.org>,
	"bhelgaas@google.com" <bhelgaas@google.com>
From: Learner <learner.study@gmail.com>
Subject: Re: [PATCH 2/2] NVMe: Implement PCI-e reset notification callback
Date: Mon, 21 Apr 2014 19:45:17 -0700
To: Keith Busch <keith.busch@intel.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

But Won't resetting from a VF impact functionality of other VFs?

On Apr 21, 2014, at 6:57 PM, Keith Busch <keith.busch@intel.com> wrote:

> On Mon, 21 Apr 2014, Learner Study wrote:
>> Hi Keith,
>> 
>> I think NVMe Reset should apply to PF mode driver only, and not to VF
>> mode driver.
>> Is that understanding correct? Does the NVMe driver know which mode
>> its running in?
> 
> Oh, this driver doesn't enable SR-IOV and has no PF/VF awareness. Shame
> on us, I'll add it to my list unless someone beats me to it.
> 
> Still, I think we'd like to be able to reset a VF if only because it
> gets the queues back to a pristine state. A VF reset should not affect
> any of the other functions.
