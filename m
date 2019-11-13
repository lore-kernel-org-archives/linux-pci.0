Return-Path: <SRS0=u7li=ZF=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.4 required=3.0
	tests=BUG6152_INVALID_DATE_TZ_ABSURD,DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INVALID_DATE_TZ_ABSURD,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EC7BC43331
	for <linux-pci@archiver.kernel.org>; Wed, 13 Nov 2019 13:49:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 02DA3222BD
	for <linux-pci@archiver.kernel.org>; Wed, 13 Nov 2019 13:49:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573652995;
	bh=G/H/25XOIBV/tVCn3Kcc1t4NrQPyjMLjjJ0VAvwfiew=;
	h=To:Subject:Date:From:Cc:In-Reply-To:References:List-ID:From;
	b=VrB112GihiV5dqm3FTx9v7YQDqnXMd855si5QaagmjwbmQC1N72HT+n8mrpYgU1i3
	 DL6e3AOH0+s5Sgqaa+RbgqVstY2SgoSH6fIbRFOi9/NhRFPAluRNZ1WZXivzRLu7dW
	 hIp/YgsGqigCEnnh2QmnSCU0NKm9d5v4JOKHkc88=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727406AbfKMNts (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 13 Nov 2019 08:49:48 -0500
Received: from inca-roads.misterjones.org ([213.251.177.50]:58103 "EHLO
        inca-roads.misterjones.org" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726521AbfKMNts (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 13 Nov 2019 08:49:48 -0500
Received: from www-data by cheepnis.misterjones.org with local (Exim 4.80)
        (envelope-from <maz@kernel.org>)
        id 1iUt1c-00023o-CE; Wed, 13 Nov 2019 14:49:36 +0100
To:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Subject: Re: [PATCH v2 5/6] PCI: brcmstb: add MSI capability
X-PHP-Originating-Script: 0:main.inc
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Wed, 13 Nov 2019 14:58:57 +0109
From:   Marc Zyngier <maz@kernel.org>
Cc:     <andrew.murray@arm.com>, <linux-kernel@vger.kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        <bcm-kernel-feedback-list@broadcom.com>,
        Eric Anholt <eric@anholt.net>,
        Stefan Wahren <wahrenst@gmx.net>, <james.quinlan@broadcom.com>,
        <mbrugger@suse.com>, <phil@raspberrypi.org>,
        <jeremy.linton@arm.com>, Bjorn Helgaas <bhelgaas@google.com>,
        <linux-pci@vger.kernel.org>,
        <linux-rpi-kernel@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>
In-Reply-To: <20191112155926.16476-6-nsaenzjulienne@suse.de>
References: <20191112155926.16476-1-nsaenzjulienne@suse.de>
 <20191112155926.16476-6-nsaenzjulienne@suse.de>
Message-ID: <d8cae6625265f95441019e33129febcd@www.loen.fr>
X-Sender: maz@kernel.org
User-Agent: Roundcube Webmail/0.7.2
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Rcpt-To: nsaenzjulienne@suse.de, andrew.murray@arm.com, linux-kernel@vger.kernel.org, lorenzo.pieralisi@arm.com, f.fainelli@gmail.com, bcm-kernel-feedback-list@broadcom.com, eric@anholt.net, wahrenst@gmx.net, james.quinlan@broadcom.com, mbrugger@suse.com, phil@raspberrypi.org, jeremy.linton@arm.com, bhelgaas@google.com, linux-pci@vger.kernel.org, linux-rpi-kernel@lists.infradead.org, linux-arm-kernel@lists.infradead.org
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on cheepnis.misterjones.org); SAEximRunCond expanded to false
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 2019-11-12 17:08, Nicolas Saenz Julienne wrote:
> From: Jim Quinlan <james.quinlan@broadcom.com>
>
> This commit adds MSI to the Broadcom STB PCIe host controller. It 
> does
> not add MSIX since that functionality is not in the HW.  The MSI
> controller is physically located within the PCIe block, however, 
> there
> is no reason why the MSI controller could not be moved elsewhere in
> the future.
>
> Since the internal Brcmstb MSI controller is intertwined with the 
> PCIe
> controller, it is not its own platform device but rather part of the
> PCIe platform device.
>
> Signed-off-by: Jim Quinlan <james.quinlan@broadcom.com>
> Co-developed-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
> Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>

Reviewed-by: Marc Zyngier <maz@kernel.org>

         M.
-- 
Jazz is not dead. It just smells funny...
