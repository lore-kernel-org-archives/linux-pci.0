Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from smtprelay6.synopsys.com ([198.182.37.59]:50312 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750735AbeDXRUH (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 24 Apr 2018 13:20:07 -0400
Subject: Re: [RFC 10/10] tools: PCI: Add MSI-X support
To: Alan Douglas <adouglas@cadence.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "Joao.Pinto@synopsys.com" <Joao.Pinto@synopsys.com>,
        "jingoohan1@gmail.com" <jingoohan1@gmail.com>,
        "kishon@ti.com" <kishon@ti.com>,
        "niklas.cassel@axis.com" <niklas.cassel@axis.com>,
        "jesper.nilsson@axis.com" <jesper.nilsson@axis.com>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <cover.1523379766.git.gustavo.pimentel@synopsys.com>
 <9865822fb89ea84cb55fe93e151295afcd5c96b3.1523379766.git.gustavo.pimentel@synopsys.com>
 <SN6PR07MB45126298F09735193B0F0F00D8880@SN6PR07MB4512.namprd07.prod.outlook.com>
From: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
Message-ID: <b51efe22-f57e-ee1c-ab00-87f34ea6452d@synopsys.com>
Date: Tue, 24 Apr 2018 18:18:55 +0100
MIME-Version: 1.0
In-Reply-To: <SN6PR07MB45126298F09735193B0F0F00D8880@SN6PR07MB4512.namprd07.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Alan,

On 24/04/2018 10:57, Alan Douglas wrote:
> Hi Gustavo,
> 
> On 10 April 2018 18:15, Gustavo Pimentel wrote:
>> Adds MSI-X support to the pcitest tool and modified the pcitest.sh script to
>> accomodate this new type of interruption test.
>>
>> Signed-off-by: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
>> ---
>>  include/uapi/linux/pcitest.h |  1 +
>>  tools/pci/pcitest.c          | 18 +++++++++++++++++-
>>  tools/pci/pcitest.sh         | 25 +++++++++++++++++++++++++
>>  3 files changed, 43 insertions(+), 1 deletion(-)
> I found some possible problems when testing with the Cadence EP driver.  The problem
> is that pcitest uses the BARs for tests, but we also use one for the MSI-X tables
> 
> In Cadence core the MSI-X table is in BAR0 by default, but this is configured to a size
> of 0x80 in the test driver, since it is used as the test_reg_bar.  So, I changed the 
> configuration to use BAR4 instead, which is configured to a size of 131072 
> in pci-efp-test.c, and this gives me enough space.
> 
> However, if I run the BAR tests in pcitest before running the MSI-X tests, the
> MSI-X tests fail, since the BAR content is overwritten.  It's not a problem with the 
> scenario in pcitest.sh, but it would be if the module wasn't re-loaded.
> 
> So, wondering if we need to come up with some mechanism to specify that a specific
> BAR will be used for MSI-X, and that its size and content shouldn't be modified by
> pcitest?

I see your point. I have bypassed the problem by doing the module load/unload
(to avoid having to fight on multiple fronts).

I like your suggestion. Maybe we could have a bool variable for each BARs that
could be set to false if a resource have intent to use it.

However this change must be accepted by Kishon.

> 
> Regards,
> Alan
> 
Regards,
Gustavo
