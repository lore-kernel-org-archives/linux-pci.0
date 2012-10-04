Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mout0.freenet.de ([195.4.92.90]:38310 "EHLO mout0.freenet.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965618Ab2JDQA0 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Thu, 4 Oct 2012 12:00:26 -0400
Message-ID: <506DB1E2.9060006@01019freenet.de>
Date: Thu, 04 Oct 2012 17:57:22 +0200
From: Andreas Hartmann <andihartmann@01019freenet.de>
MIME-Version: 1.0
To: Alex Williamson <alex.williamson@redhat.com>
CC: kvm@vger.kernel.org, "Roedel, Joerg" <Joerg.Roedel@amd.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	linux-pci <linux-pci@vger.kernel.org>
Subject: Re: vfio: missing patch in linux 3.6
References: <506DA799.5090603@01019freenet.de> <1349364399.2759.42.camel@ul30vt.home>
In-Reply-To: <1349364399.2759.42.camel@ul30vt.home>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Alex Williamson wrote:
> On Thu, 2012-10-04 at 17:13 +0200, Andreas Hartmann wrote:
>> Hello Alex,
>> 
>> I just tested vfio as part of linux 3.6 and detected, that it
>> doesn't work because of the following missing patch:
>> 
>> http://news.gmane.org/find-root.php?group=gmane.linux.kernel.pci&article=16422
>>
>>
>> 
Could you please get it applied for the next stable release?
> 
> Hi Andreas,
> 
> This patch needs to go through Bjorn's PCI tree, but as noted in
> the comments I have some outstanding questions that need to be
> answered, probably by Joerg.  Thanks,

Sorry Alex,
I missed your additional questions because this patch just works
pretty fine here with kernel 3.4.x.

But you're right, your questions should be resolved before freeing it
to the wild.

@Joerg:
Please, liberate me from compiling and patching each kernel myself to
get it working and give all the other users out there a chance to use
this pretty code and the IOMMU support of AMD's hardware :-) by
answering Alex' questions.


Thanks,
kind regards,
Andreas
