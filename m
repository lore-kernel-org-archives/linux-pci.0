Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-yx0-f174.google.com ([209.85.213.174]:64813 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S966571Ab2ERBvK (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 17 May 2012 21:51:10 -0400
Received: by yenm10 with SMTP id m10so2439399yen.19
        for <linux-pci@vger.kernel.org>; Thu, 17 May 2012 18:51:10 -0700 (PDT)
Message-ID: <4FB57862.5000700@gmail.com>
Date: Thu, 17 May 2012 17:14:58 -0500
From: Rob Herring <robherring2@gmail.com>
MIME-Version: 1.0
To: John Crispin <blogic@openwrt.org>
CC: Grant Likely <grant.likely@secretlab.ca>,
	linux-mips@linux-mips.org, linux-pci@vger.kernel.org,
	devicetree-discuss@lists.ozlabs.org,
	Ralf Baechle <ralf@linux-mips.org>,
	Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH] OF: PCI: const usage needed by MIPS
References: <1335808019-24502-1-git-send-email-blogic@openwrt.org> <4F9ED1DC.3050007@gmail.com> <4F9FE4F6.5070909@openwrt.org> <CAErSpo4bZ=0=DtbDots_GOGeLNhX6Q4eJrdetaFQMv4iiv5+XA@mail.gmail.com> <4FA32E47.7020406@gmail.com> <4FA3B596.3050106@openwrt.org> <CAErSpo4AQh3cJzULkmP_Dqsf0cSPRP1WqvhuQR3gePXw2rN7rQ@mail.gmail.com> <4FADFB39.6010100@openwrt.org>
In-Reply-To: <4FADFB39.6010100@openwrt.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 05/12/2012 12:55 AM, John Crispin wrote:
> 
>> I compiled alpha, ia64, mips, parisc, powerpc, sh, sparc, and x86 and
>> didn't see any issues related to this patch.  There might still be
>> something,  but I'm willing to help work through them or revert this
>> if it turns out to be a problem.  I'm still assuming that Grant will
>> handle this.
>>
>> Bjorn
> Hi Grant,
> 
> Is this patch ok with you ? If so would you mind if Ralf takes this via
> his tree ? (this would avoid merge order problems)
> 

This looks fine to me and merging thru Ralf's tree is fine.

Acked-by: Rob Herring <rob.herring@calxeda.com>

Rob

> Thanks,
> John
> _______________________________________________
> devicetree-discuss mailing list
> devicetree-discuss@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/devicetree-discuss

