Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from service87.mimecast.com ([91.220.42.44]:46805 "EHLO
	service87.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756433AbaIRPqS convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 18 Sep 2014 11:46:18 -0400
Date: Thu, 18 Sep 2014 16:46:14 +0100
From: Liviu Dudau <Liviu.Dudau@arm.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: PCI: request to pull the generic OF hostbridge patches
Message-ID: <20140918154613.GS15899@e106497-lin.cambridge.arm.com>
References: <20140918021125.GR15899@e106497-lin.cambridge.arm.com>
MIME-Version: 1.0
In-Reply-To: <20140918021125.GR15899@e106497-lin.cambridge.arm.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Sep 18, 2014 at 03:11:25AM +0100, Liviu Dudau wrote:
> Hi Bjorn,
> 
> I would like to get my generic OF host bridge patches integrated into your PCI
> tree if possible. I have pushed my v11 series into
> 
> git://linux-arm.org/linux-ld.git for-upstream/pci_v11
> 
> I would like to thank you in advance for your support.

Hi Bjorn,

If you haven't pull from the aforementioned git tree before you read this email,
then please ignore this message.

I have discovered that I have inadvertenly included as the last patch in the
tree the commit that is intended to go through Catalin's tree. I have reset
the HEAD for that tree now, but I don't want to cause problems later on when
trees get pulled, hence the announcement.

I have moved the arm64 commit to a separate branch in that tree,

git://linux-arm.org/linux-ld.git for-upstream/pci_arm64_v11

Sorry for my clumsiness.

Best regards,
Liviu

-- 
====================
| I would like to |
| fix the world,  |
| but they're not |
| giving me the   |
 \ source code!  /
  ---------------
    ¯\_(ツ)_/¯

