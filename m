Return-Path: <SRS0=gmVn=QH=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FFEFC169C4
	for <linux-pci@archiver.kernel.org>; Thu, 31 Jan 2019 20:20:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0308D218EA
	for <linux-pci@archiver.kernel.org>; Thu, 31 Jan 2019 20:20:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727381AbfAaUUV (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 31 Jan 2019 15:20:21 -0500
Received: from mga06.intel.com ([134.134.136.31]:11200 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725802AbfAaUUV (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 31 Jan 2019 15:20:21 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 31 Jan 2019 12:20:20 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,545,1539673200"; 
   d="scan'208";a="315300470"
Received: from djiang5-mobl2.amr.corp.intel.com (HELO [10.255.72.219]) ([10.255.72.219])
  by fmsmga006.fm.intel.com with ESMTP; 31 Jan 2019 12:20:19 -0800
Subject: Re: [PATCH 0/9] Support using MSI interrupts in ntb_transport
To:     Logan Gunthorpe <logang@deltatee.com>,
        linux-kernel@vger.kernel.org, linux-ntb@googlegroups.com,
        linux-pci@vger.kernel.org, iommu@lists.linux-foundation.org,
        linux-kselftest@vger.kernel.org, Jon Mason <jdmason@kudzu.us>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Joerg Roedel <joro@8bytes.org>
Cc:     Allen Hubbe <allenbh@gmail.com>,
        Serge Semin <fancer.lancer@gmail.com>,
        Eric Pilmore <epilmore@gigaio.com>
References: <20190131185656.17972-1-logang@deltatee.com>
From:   Dave Jiang <dave.jiang@intel.com>
Message-ID: <345197a6-89e6-c0de-5f7b-a646b5f396c9@intel.com>
Date:   Thu, 31 Jan 2019 13:20:19 -0700
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:65.0) Gecko/20100101
 Thunderbird/65.0
MIME-Version: 1.0
In-Reply-To: <20190131185656.17972-1-logang@deltatee.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


On 1/31/2019 11:56 AM, Logan Gunthorpe wrote:
> Hi,
>
> This patch series adds optional support for using MSI interrupts instead
> of NTB doorbells in ntb_transport. This is desirable seeing doorbells on
> current hardware are quite slow and therefore switching to MSI interrupts
> provides a significant performance gain. On switchtec hardware, a simple
> apples-to-apples comparison shows ntb_netdev/iperf numbers going from
> 3.88Gb/s to 14.1Gb/s when switching to MSI interrupts.
>
> To do this, a couple changes are required outside of the NTB tree:
>
> 1) The IOMMU must know to accept MSI requests from aliased bused numbers
> seeing NTB hardware typically sends proxied request IDs through
> additional requester IDs. The first patch in this series adds support
> for the Intel IOMMU. A quirk to add these aliases for switchtec hardware
> was already accepted. See commit ad281ecf1c7d ("PCI: Add DMA alias quirk
> for Microsemi Switchtec NTB") for a description of NTB proxy IDs and why
> this is necessary.
>
> 2) NTB transport (and other clients) may often need more MSI interrupts
> than the NTB hardware actually advertises support for. However, seeing
> these interrupts will not be triggered by the hardware but through an
> NTB memory window, the hardware does not actually need support or need
> to know about them. Therefore we add the concept of Virtual MSI
> interrupts which are allocated just like any other MSI interrupt but
> are not programmed into the hardware's MSI table. This is done in
> Patch 2 and then made use of in Patch 3.

Logan,

Does this work when the system moves the MSI vector either via software 
(irqbalance) or BIOS APIC programming (some modes cause round robin 
behavior)?



>
> The remaining patches in this series add a library for dealing with MSI
> interrupts, a test client and finally support in ntb_transport.
>
> The series is based off of v5.0-rc4 and I've tested it on top of a
> of the patches I've already sent to the NTB tree (though they are
> independent changes). A git repo is available here:
>
> https://github.com/sbates130272/linux-p2pmem/ ntb_transport_msi_v1
>
> Thanks,
>
> Logan
>
> --
>
> Logan Gunthorpe (9):
>    iommu/vt-d: Allow interrupts from the entire bus for aliased devices
>    PCI/MSI: Support allocating virtual MSI interrupts
>    PCI/switchtec: Add module parameter to request more interrupts
>    NTB: Introduce functions to calculate multi-port resource index
>    NTB: Rename ntb.c to support multiple source files in the module
>    NTB: Introduce MSI library
>    NTB: Introduce NTB MSI Test Client
>    NTB: Add ntb_msi_test support to ntb_test
>    NTB: Add MSI interrupt support to ntb_transport
>
>   drivers/iommu/intel_irq_remapping.c     |  12 +
>   drivers/ntb/Kconfig                     |  10 +
>   drivers/ntb/Makefile                    |   3 +
>   drivers/ntb/{ntb.c => core.c}           |   0
>   drivers/ntb/msi.c                       | 313 ++++++++++++++++++
>   drivers/ntb/ntb_transport.c             | 134 +++++++-
>   drivers/ntb/test/Kconfig                |   9 +
>   drivers/ntb/test/Makefile               |   1 +
>   drivers/ntb/test/ntb_msi_test.c         | 416 ++++++++++++++++++++++++
>   drivers/pci/msi.c                       |  51 ++-
>   drivers/pci/switch/switchtec.c          |  12 +-
>   include/linux/msi.h                     |   1 +
>   include/linux/ntb.h                     | 139 ++++++++
>   include/linux/pci.h                     |   9 +
>   tools/testing/selftests/ntb/ntb_test.sh |  54 ++-
>   15 files changed, 1150 insertions(+), 14 deletions(-)
>   rename drivers/ntb/{ntb.c => core.c} (100%)
>   create mode 100644 drivers/ntb/msi.c
>   create mode 100644 drivers/ntb/test/ntb_msi_test.c
>
> --
> 2.19.0
>
