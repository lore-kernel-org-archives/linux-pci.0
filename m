Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:45632 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752367AbdHGJhT (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 7 Aug 2017 05:37:19 -0400
Subject: Re: [PATCH v8 1/3] perf: cavium: Support memory controller PMU
 counters
To: Jan Glauber <jan.glauber@caviumnetworks.com>,
        Borislav Petkov <bp@alien8.de>
References: <20170726153502.GE28875@nazgul.tnic> <20170726154515.GA11453@hc>
 <20170726155548.GF28875@nazgul.tnic> <20170726161949.GB15426@kroah.com>
 <20170726163049.GG28875@nazgul.tnic> <20170726173353.GB21705@kroah.com>
 <1a2eedea-040d-c746-eaf0-1d8085b3f2bf@gmail.com>
 <20170726200802.GA17722@kroah.com>
 <b27cda60-8bf8-47a1-15b5-bf8b3a83fc45@gmail.com>
 <20170727051157.GA4525@nazgul.tnic> <20170727090856.GB15784@hc>
Cc: David Daney <ddaney.cavm@gmail.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Mark Rutland <mark.rutland@arm.com>, linux-pci@vger.kernel.org,
        Will Deacon <will.deacon@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-arm-kernel@lists.infradead.org
From: Suzuki K Poulose <Suzuki.Poulose@arm.com>
Message-ID: <647e2941-d854-0341-3e6a-709a6c3db839@arm.com>
Date: Mon, 7 Aug 2017 10:37:15 +0100
MIME-Version: 1.0
In-Reply-To: <20170727090856.GB15784@hc>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 27/07/17 10:08, Jan Glauber wrote:
> On Thu, Jul 27, 2017 at 07:11:57AM +0200, Borislav Petkov wrote:
>> On Wed, Jul 26, 2017 at 02:02:42PM -0700, David Daney wrote:
>>> Also, if a given configuration disables CONFIG_EDAC there is some hackery
>>> needed to get the perf portion of the driver included.
>>
>> Yes, and we don't do performance counters in EDAC.
>>
>> So you could add a small memory controller driver which does the
>> arbitration or fix the firmware.
>
> OK. As fixing the firmware will take quite some time I'll go for the memory
> controller driver that starts EDAC / PMU depending on their CONFIG_.

Please could you also rename CAVIUM_PMU to something like CAVIUM_MMC_PMU or even
CAVIUM_UNCOR_PMU ? The symbol could easily be mistaken for a "cavium" CPU PMU.

Suzuki


>
> What would be the proper location for the multiplexer?
> drivers/soc/cavium or drivers/misc?
>
> --Jan
>
