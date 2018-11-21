Return-Path: <SRS0=MCOJ=OA=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4E88C43441
	for <linux-pci@archiver.kernel.org>; Wed, 21 Nov 2018 17:31:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E11F214F1
	for <linux-pci@archiver.kernel.org>; Wed, 21 Nov 2018 17:31:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=mm-sol.com header.i=@mm-sol.com header.b="IHzQad9J"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8E11F214F1
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=mm-sol.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730119AbeKVEG6 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 21 Nov 2018 23:06:58 -0500
Received: from ns.mm-sol.com ([37.157.136.199]:53254 "EHLO extserv.mm-sol.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730088AbeKVEG6 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 21 Nov 2018 23:06:58 -0500
X-Greylist: delayed 402 seconds by postgrey-1.27 at vger.kernel.org; Wed, 21 Nov 2018 23:06:56 EST
Received: from [192.168.28.193] (unknown [37.157.136.206])
        by extserv.mm-sol.com (Postfix) with ESMTPSA id AFA70CE33;
        Wed, 21 Nov 2018 19:24:55 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mm-sol.com; s=201706;
        t=1542821095; bh=QEWwFkpAa0yg2vk6i/ysM5mFh+v0v9/VpLfS57wLgeY=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=IHzQad9JO7mSADTGU5//IogsKcgYnCyd7KEmD608S6tArepnUcw7xpf+HLe3d8V3e
         NnO/woFkaMpvIlPvQ34Fpb8v8mDy+DyfxQCUf3Ev1oF6xx/qIj1HS8DxgdrEe6Wr6j
         tlGoEtmi4XqXIsDG+gI7TJ6V/xqLU7DQhEEJozYTCbrt5ly753muh/z5XiE7I9AhfE
         eOVVf6CeVpl8Fh2bH4EWdwMxSa8Yls4620B20Cm3O7A1JCoCuV5xEU7rYQN/fCndoW
         qewjrjcajKFn9H5+5+fnEkoGVah+JxOPF2hDGnFVvtCL0Yxp1sWdUJKKQf29KnoQQE
         H4fOTAZphXmXA==
Subject: Re: [PATCH 0/3] PCI: designware: Fixing MSI handling flow
To:     Marc Zyngier <marc.zyngier@arm.com>, linux-pci@vger.kernel.org,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <helgaas@google.com>
Cc:     Trent Piepho <tpiepho@impinj.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        faiz_abbas@ti.com, Joao Pinto <Joao.Pinto@synopsys.com>,
        Vignesh R <vigneshr@ti.com>
References: <20181113225734.8026-1-marc.zyngier@arm.com>
From:   Stanimir Varbanov <svarbanov@mm-sol.com>
Message-ID: <693b46a1-18ea-ef94-ca18-8d3c23698986@mm-sol.com>
Date:   Wed, 21 Nov 2018 19:24:53 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181113225734.8026-1-marc.zyngier@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi,

On 11/14/18 12:57 AM, Marc Zyngier wrote:
> It recently came to light that the Designware PCIe driver is rather
> broken in the way it handles MSI[1]:
> 
> - It masks interrupt by disabling them, meaning that MSIs generated
>   during the masked window are simply lost. Oops.
> 
> - Acking of the currently pending MSI is done outside of the interrupt
>   flow, getting moved around randomly and ultimately breaking the
>   driver. Not great.
> 
> This series attempts to address this by switching to using the MASK
> register for masking interrupts (!), and move the ack into the
> appropriate callback, giving it a fixed place in the MSI handling
> flow.
> 
> Note that this is only compile-tested on my arm64 laptop, as I'm
> travelling and do not have the required HW to test it anyway. I'd
> welcome both review and testing by the interested parties (dwc
> maintainer and users affected by existing bugs).
> 
> Thanks,
> 
> 	M.
> 
> [1] https://patchwork.kernel.org/patch/10657987/
> 
> Marc Zyngier (3):
>   PCI: designware: Use interrupt masking instead of disabling
>   PCI: designware: Take lock when ACKing an interrupt
>   PCI: designware: Move interrupt acking into the proper callback
> 
>  .../pci/controller/dwc/pcie-designware-host.c | 22 ++++++++++++-------
>  1 file changed, 14 insertions(+), 8 deletions(-)
> 

for pcie-qcom:

Tested-by: Stanimir Varbanov <svarbanov@mm-sol.com>

-- 
regards,
Stan
