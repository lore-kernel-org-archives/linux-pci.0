Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from smtprelay.synopsys.com ([198.182.47.9]:42229 "EHLO
	smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751501AbbKZPlf (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 26 Nov 2015 10:41:35 -0500
Subject: Re: [PATCH 2/2] PCI support added to ARC
To: Bjorn Helgaas <helgaas@kernel.org>,
	Vineet Gupta <Vineet.Gupta1@synopsys.com>
References: <cover.1448375184.git.jpinto@synopsys.com>
 <9b80d6c1db4d7e2b5ee5dc0056a3d8284e7c2b9b.1448375184.git.jpinto@synopsys.com>
 <C2D7FE5348E1B147BCA15975FBA23075F44D3B42@IN01WEMBXA.internal.synopsys.com>
 <20151125164636.GB1380@localhost>
CC: Joao Pinto <Joao.Pinto@synopsys.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"bhelgaas@google.com" <bhelgaas@google.com>,
	Carlos Palminha <CARLOS.PALMINHA@synopsys.com>,
	Alexey Brodkin <Alexey.Brodkin@synopsys.com>,
	arcml <linux-snps-arc@lists.infradead.org>,
	Arnd Bergmann <arnd@arndb.de>
From: Joao Pinto <Joao.Pinto@synopsys.com>
Message-ID: <56572829.4090102@synopsys.com>
Date: Thu, 26 Nov 2015 15:41:29 +0000
MIME-Version: 1.0
In-Reply-To: <20151125164636.GB1380@localhost>
Content-Type: text/plain; charset="windows-1252"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Bjorn,

On 11/25/2015 4:46 PM, Bjorn Helgaas wrote:
> On Wed, Nov 25, 2015 at 05:25:37AM +0000, Vineet Gupta wrote:
>> On Tuesday 24 November 2015 08:02 PM, Joao Pinto wrote:
> 
>>> +			pr_err("PCI: Device %s not available because"/
>>> +			       " of resource collisions\n", pci_name(dev));
>>
>> Better not to break strings - even if they sometime exceed line sz limit of 80.
>> You could anyways reduce the string content herer.
> 
> Also use dev_err() instead of pr_err().
> 

Thanks for the review. Could you please check PATCH 1/2 regarding the new
platform driver? This way I would produce a v2 of the patch set.

Thanks,
Joao

