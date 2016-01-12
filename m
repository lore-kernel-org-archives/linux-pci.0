Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from smtprelay.synopsys.com ([198.182.47.9]:33825 "EHLO
	smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932987AbcALJzl (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 12 Jan 2016 04:55:41 -0500
Subject: Re: [PATCH v4 1/2] PCI support added to ARC
To: Vineet Gupta <Vineet.Gupta1@synopsys.com>,
	Joao Pinto <Joao.Pinto@synopsys.com>, <helgaas@kernel.org>
References: <cover.1452526707.git.jpinto@synopsys.com>
 <b46c0fbfe3d383ca527e8eb7cbf953e59d346577.1452526707.git.jpinto@synopsys.com>
 <569497AE.3030405@synopsys.com>
CC: <Vineet.Gupta1@synopsys.com>, <linux-pci@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>,
	<linux-snps-arc@lists.infradead.org>,
	<CARLOS.PALMINHA@synopsys.com>, <Alexey.Brodkin@synopsys.com>,
	<robh+dt@kernel.org>, <pawel.moll@arm.com>, <mark.rutland@arm.com>,
	<ijc+devicetree@hellion.org.uk>, <galak@codeaurora.org>
From: Joao Pinto <Joao.Pinto@synopsys.com>
Message-ID: <5694CD8F.1060706@synopsys.com>
Date: Tue, 12 Jan 2016 09:55:27 +0000
MIME-Version: 1.0
In-Reply-To: <569497AE.3030405@synopsys.com>
Content-Type: text/plain; charset="windows-1252"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Vineet,

On 1/12/2016 6:05 AM, Vineet Gupta wrote:
> On Monday 11 January 2016 10:54 PM, Joao Pinto wrote:
>> This patch adds PCI support to ARC and updates drivers/pci Makefile enabling
>> the ARC arch to use the generic PCI setup functions.
>>
>> Signed-off-by: Joao Pinto <jpinto@synopsys.com>
> 
> BTW this patch has whitespace errors still - can you make sure they are not in the
> next version(s)

By executing checkpatch.pl no whitespaces were detected:

WARNING: Possible unwrapped commit description (prefer a maximum 75 chars per line)
#9:
This patch adds PCI support to ARC and updates drivers/pci Makefile enabling

WARNING: added, moved or deleted file(s), does MAINTAINERS need updating?
#132:
new file mode 100644

total: 0 errors, 2 warnings, 212 lines checked

0001-PCI-support-added-to-ARC.patch has style problems, please review.

> 
> -Vineet
> 

I am going to check your comments and make the necessary adjustments.

Thanks,
Joao
