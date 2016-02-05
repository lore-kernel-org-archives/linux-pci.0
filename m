Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mout2.freenet.de ([195.4.92.92]:34561 "EHLO mout2.freenet.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751035AbcBEGkn (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Fri, 5 Feb 2016 01:40:43 -0500
Subject: Re: AMD-Vi: Unable to write to IOMMU perf counter.
To: Bjorn Helgaas <helgaas@kernel.org>
References: <56B365E0.4020100@01019freenet.de>
 <20160204152309.GA27351@localhost>
Cc: linux-pci@vger.kernel.org, Joerg Roedel <joro@8bytes.org>,
	iommu@lists.linux-foundation.org
From: Andreas Hartmann <andihartmann@freenet.de>
Message-ID: <56B44330.4020507@maya.org>
Date: Fri, 5 Feb 2016 07:37:36 +0100
MIME-Version: 1.0
In-Reply-To: <20160204152309.GA27351@localhost>
Content-Type: text/plain; charset=windows-1252
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hello Bjorn,

On 02/04/2016 at 04:23 PM Bjorn Helgaas wrote:
> [+cc Joerg, iommu list]
> 
> Hi Andreas,
> 
> On Thu, Feb 04, 2016 at 03:53:20PM +0100, Andreas Hartmann wrote:
>> Hello!
>>
>> The following happens with Linux 4.4.1 during boot on an MSI A78M-E35
>> board. Additionally, I attached the complete dmesg.
> 
> Thanks a lot for the report!  I cc'd some folks who know more about
> this than I do.  Is this a regression?

Problem doesn't happen in 4.2 - I didn't test 4.3 because I actually
don't have a 4.3 kernel and Suravee Suthikulanit patchset fixes the
problem as I already wrote.

Therefore the problem could be there since 4.3 or maybe firstly at 4.4.


Regards,
Andreas
