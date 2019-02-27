Return-Path: <SRS0=6dzI=RC=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B6CCC43381
	for <linux-pci@archiver.kernel.org>; Wed, 27 Feb 2019 16:42:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 36C5F217F5
	for <linux-pci@archiver.kernel.org>; Wed, 27 Feb 2019 16:42:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726478AbfB0Qm3 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 27 Feb 2019 11:42:29 -0500
Received: from foss.arm.com ([217.140.101.70]:35540 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725854AbfB0Qm3 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 27 Feb 2019 11:42:29 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A3967A78;
        Wed, 27 Feb 2019 08:42:28 -0800 (PST)
Received: from e107981-ln.cambridge.arm.com (e107981-ln.cambridge.arm.com [10.1.197.40])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 23DDA3F738;
        Wed, 27 Feb 2019 08:42:26 -0800 (PST)
Date:   Wed, 27 Feb 2019 16:42:20 +0000
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Vitaly Kuznetsov <vkuznets@redhat.com>,
        Maya Nakamura <m.maya.nakamura@gmail.com>
Cc:     bhelgaas@google.com, linux-pci@vger.kernel.org, kys@microsoft.com,
        sthemmin@microsoft.com, olaf@aepfle.de, apw@canonical.com,
        jasowang@redhat.com, mikelley@microsoft.com,
        Alexander.Levin@microsoft.com, linux-kernel@vger.kernel.org,
        driverdev-devel@linuxdriverproject.org, haiyangz@microsoft.com,
        marcelo.cerri@canonical.com
Subject: Re: [PATCH v3 1/2] PCI: hv: Replace hv_vp_set with hv_vpset
Message-ID: <20190227164220.GA20672@e107981-ln.cambridge.arm.com>
References: <cover.1548745212.git.m.maya.nakamura@gmail.com>
 <19aea785b78cf14c71f58bf278df17dc3adf8368.1548745212.git.m.maya.nakamura@gmail.com>
 <87k1hlqlby.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87k1hlqlby.fsf@vitty.brq.redhat.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Feb 27, 2019 at 04:53:37PM +0100, Vitaly Kuznetsov wrote:
> Maya Nakamura <m.maya.nakamura@gmail.com> writes:
> 
> > Remove a duplicate definition of VP set (hv_vp_set) and use the common
> > definition (hv_vpset) that is used in other places.
> >
> > Change the order of the members in struct hv_pcibus_device so that the
> > declaration of retarget_msi_interrupt_params is the last member. Struct
> > hv_vpset, which contains a flexible array, is nested two levels deep in
> > struct hv_pcibus_device via retarget_msi_interrupt_params.
> >
> > Add a comment that retarget_msi_interrupt_params should be the last member
> > of struct hv_pcibus_device.
> >
> > Signed-off-by: Maya Nakamura <m.maya.nakamura@gmail.com>
> > ---
> > Change in v3:
> > - Correct the v2 change log.
> >
> > Change in v2:
> > - Update the commit message.
> >
> >  drivers/pci/controller/pci-hyperv.c | 25 ++++++++++++-------------
> >  1 file changed, 12 insertions(+), 13 deletions(-)
> >
> > diff --git a/drivers/pci/controller/pci-hyperv.c b/drivers/pci/controller/pci-hyperv.c
> > index 9ba4d12c179c..da8b58d8630d 100644
> > --- a/drivers/pci/controller/pci-hyperv.c
> > +++ b/drivers/pci/controller/pci-hyperv.c
> > @@ -393,12 +393,6 @@ struct hv_interrupt_entry {
> >  
> >  #define HV_VP_SET_BANK_COUNT_MAX	5 /* current implementation limit */
> >  
> > -struct hv_vp_set {
> > -	u64	format;			/* 0 (HvGenericSetSparse4k) */
> > -	u64	valid_banks;
> > -	u64	masks[HV_VP_SET_BANK_COUNT_MAX];
> > -};
> > -
> >  /*
> >   * flags for hv_device_interrupt_target.flags
> >   */
> > @@ -410,7 +404,7 @@ struct hv_device_interrupt_target {
> >  	u32	flags;
> >  	union {
> >  		u64		 vp_mask;
> > -		struct hv_vp_set vp_set;
> > +		struct hv_vpset vp_set;
> >  	};
> >  };
> >  
> > @@ -460,12 +454,16 @@ struct hv_pcibus_device {
> >  	struct msi_controller msi_chip;
> >  	struct irq_domain *irq_domain;
> >  
> > -	/* hypercall arg, must not cross page boundary */
> > -	struct retarget_msi_interrupt retarget_msi_interrupt_params;
> > -
> >  	spinlock_t retarget_msi_interrupt_lock;
> >  
> >  	struct workqueue_struct *wq;
> > +
> > +	/* hypercall arg, must not cross page boundary */
> > +	struct retarget_msi_interrupt retarget_msi_interrupt_params;
> > +
> 
> One more thing here (and again sorry for being late): this structure is
> being used as Hyper-V hypercall argument and these have special
> requirements on alignment (8 bytes). struct retarget_msi_interrupt is
> packed and depending on your environment/compiler you may or may not see
> the issue but I has able to get HVCALL_RETARGET_INTERRUPT failing with
> the return value of 4 (HV_STATUS_INVALID_ALIGNMENT).
> 
> I suggest we add __aligned(8) to 'struct retarget_msi_interrupt'
> definition (I haven't tested this but should work). This is not a new
> issue, it existed before your patch, but the code movement you do may
> change the exposure.

I am happy to apply this small fix _before_ this patch but if you want
me to merge them for v5.1 this must be put together and tested quite
quickly.

For the time being I am not dropping this patch from the PCI queue,
waiting for an update from you guys.

Thanks,
Lorenzo

> 
> 
> > +	/*
> > +	 * Don't put anything here: retarget_msi_interrupt_params must be last
> > +	 */
> >  };
> >  
> >  /*
> > @@ -955,12 +953,13 @@ static void hv_irq_unmask(struct irq_data *data)
> >  		 */
> >  		params->int_target.flags |=
> >  			HV_DEVICE_INTERRUPT_TARGET_PROCESSOR_SET;
> > -		params->int_target.vp_set.valid_banks =
> > +		params->int_target.vp_set.valid_bank_mask =
> >  			(1ull << HV_VP_SET_BANK_COUNT_MAX) - 1;
> >  
> >  		/*
> >  		 * var-sized hypercall, var-size starts after vp_mask (thus
> > -		 * vp_set.format does not count, but vp_set.valid_banks does).
> > +		 * vp_set.format does not count, but vp_set.valid_bank_mask
> > +		 * does).
> >  		 */
> >  		var_size = 1 + HV_VP_SET_BANK_COUNT_MAX;
> >  
> > @@ -974,7 +973,7 @@ static void hv_irq_unmask(struct irq_data *data)
> >  				goto exit_unlock;
> >  			}
> >  
> > -			params->int_target.vp_set.masks[cpu_vmbus / 64] |=
> > +			params->int_target.vp_set.bank_contents[cpu_vmbus / 64]	|=
> >  				(1ULL << (cpu_vmbus & 63));
> >  		}
> >  	} else {
> 
> -- 
> Vitaly
