Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from foss-mx-na.foss.arm.com ([217.140.108.86]:34364 "EHLO
	foss-mx-na.foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756669AbaIRR0L (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 18 Sep 2014 13:26:11 -0400
Date: Thu, 18 Sep 2014 18:26:03 +0100
From: Catalin Marinas <catalin.marinas@arm.com>
To: Liviu Dudau <Liviu.Dudau@arm.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: Re: PCI: request to pull the generic OF hostbridge patches
Message-ID: <20140918172602.GG25330@e104818-lin.cambridge.arm.com>
References: <20140918021125.GR15899@e106497-lin.cambridge.arm.com>
 <20140918154613.GS15899@e106497-lin.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20140918154613.GS15899@e106497-lin.cambridge.arm.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Sep 18, 2014 at 04:46:14PM +0100, Liviu Dudau wrote:
> On Thu, Sep 18, 2014 at 03:11:25AM +0100, Liviu Dudau wrote:
> > I would like to get my generic OF host bridge patches integrated into your PCI
> > tree if possible. I have pushed my v11 series into
> > 
> > git://linux-arm.org/linux-ld.git for-upstream/pci_v11
> > 
> > I would like to thank you in advance for your support.
> 
> Hi Bjorn,
> 
> If you haven't pull from the aforementioned git tree before you read this email,
> then please ignore this message.
> 
> I have discovered that I have inadvertenly included as the last patch in the
> tree the commit that is intended to go through Catalin's tree. I have reset
> the HEAD for that tree now, but I don't want to cause problems later on when
> trees get pulled, hence the announcement.

I really don't care via which tree it goes in, as long as it has my ack
(and I recall it does).

-- 
Catalin
