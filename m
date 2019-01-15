Return-Path: <SRS0=HN6g=PX=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F21ABC43387
	for <linux-pci@archiver.kernel.org>; Tue, 15 Jan 2019 02:00:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C11D720651
	for <linux-pci@archiver.kernel.org>; Tue, 15 Jan 2019 02:00:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727184AbfAOCAD (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 14 Jan 2019 21:00:03 -0500
Received: from lucky1.263xmail.com ([211.157.147.132]:33926 "EHLO
        lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727169AbfAOCAD (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 14 Jan 2019 21:00:03 -0500
X-Greylist: delayed 437 seconds by postgrey-1.27 at vger.kernel.org; Mon, 14 Jan 2019 21:00:02 EST
Received: from shawn.lin?rock-chips.com (unknown [192.168.167.70])
        by lucky1.263xmail.com (Postfix) with ESMTP id 6E0421198;
        Tue, 15 Jan 2019 09:52:41 +0800 (CST)
X-263anti-spam: KSV:0;
X-MAIL-GRAY: 1
X-MAIL-DELIVERY: 0
X-KSVirus-check: 0
X-ABS-CHECKED: 4
Received: from [172.16.12.37] (unknown [58.22.7.114])
        by smtp.263.net (postfix) whith ESMTP id P23568T140054489974528S1547517158769871_;
        Tue, 15 Jan 2019 09:52:40 +0800 (CST)
X-IP-DOMAINF: 1
X-UNIQUE-TAG: <e1a9c467c5e308c9a57ff0dd8e477239>
X-RL-SENDER: shawn.lin@rock-chips.com
X-SENDER: lintao@rock-chips.com
X-LOGIN-NAME: shawn.lin@rock-chips.com
X-FST-TO: linux-arm-kernel@lists.infradead.org
X-SENDER-IP: 58.22.7.114
X-ATTACHMENT-NUM: 0
X-DNS-TYPE: 0
Cc:     shawn.lin@rock-chips.com, Bjorn Helgaas <bhelgaas@google.com>,
        Jingoo Han <jingoohan1@gmail.com>, linux-omap@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-rockchip@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 00/15] PCI: endpoint: Cleanup EPC features
To:     Kishon Vijay Abraham I <kishon@ti.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Alan Douglas <adouglas@cadence.com>,
        Heiko Stuebner <heiko@sntech.de>
References: <20190114111513.21618-1-kishon@ti.com>
From:   Shawn Lin <shawn.lin@rock-chips.com>
Message-ID: <29d44805-9cfb-450c-e7b3-7556dc36fc40@rock-chips.com>
Date:   Tue, 15 Jan 2019 09:52:41 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190114111513.21618-1-kishon@ti.com>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


On 2019/1/14 19:14, Kishon Vijay Abraham I wrote:
> Hi Lorenzo,
> 
> The Endpoint controller driver uses features member in 'struct pci_epc'
> to advertise the list of supported features to the endpoint function
> driver.
> 
> There are a few shortcomings with this approach.
>    *) Certain endpoint controllers support fixed size BAR (e.g. TI's
>       AM654 uses Designware configuration with fixed size BAR). The
>       size of each BARs cannot be passed to the endpoint function
>       driver.
>    *) Too many macros for handling EPC features.
>       (EPC_FEATURE_NO_LINKUP_NOTIFIER, EPC_FEATURE_BAR_MASK,
>        EPC_FEATURE_MSIX_AVAILABLE, EPC_FEATURE_SET_BAR,
>        EPC_FEATURE_GET_BAR)
>    *) Endpoint controllers are directly modifying struct pci_epc
>       members. (I have plans to move struct pci_epc to
>       drivers/pci/endpoint so that pci_epc members are referenced
>       only by endpoint core).
> 
> To overcome the above shortcomings, introduced pci_epc_get_features()
> API, pci_epc_features structure and a ->get_features() callback.
> 
> Also added a patch to set BAR flags in pci_epf_alloc_space and
> remove it from pci-epf-test function driver.
> 
> Changes from v1:
> *) Fixed helper function to return '0' (or BAR_0) for any incorrect
>     values in reserved BAR.
> *) Do not set_bar or alloc space for BARs if the BARs are reserved
> *) Fix incorrect check of epc_features in pci_epf_test_bind
> 
> Tested on TI's DRA7xx platform and AM654 platform. Support for PCIe
> in AM654 platform will be posted shortly.
> 


----8<-----

>   drivers/pci/controller/pcie-rockchip-ep.c     | 16 +++-

Acked-by: Shawn Lin <shawn.lin@rock-chips.com>



