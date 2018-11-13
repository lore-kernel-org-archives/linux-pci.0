Return-Path: <SRS0=6VBI=NY=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F439C43441
	for <linux-pci@archiver.kernel.org>; Tue, 13 Nov 2018 23:21:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 031DC20835
	for <linux-pci@archiver.kernel.org>; Tue, 13 Nov 2018 23:21:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="EORBKekZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 031DC20835
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=synopsys.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728066AbeKNJVa (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 14 Nov 2018 04:21:30 -0500
Received: from us01smtprelay-2.synopsys.com ([198.182.47.9]:41700 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726022AbeKNJV3 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 14 Nov 2018 04:21:29 -0500
Received: from mailhost.synopsys.com (mailhost3.synopsys.com [10.12.238.238])
        by smtprelay.synopsys.com (Postfix) with ESMTP id 41C6324E0935;
        Tue, 13 Nov 2018 15:20:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1542151258; bh=ZgucZdDPHea4HA6oGdTKzUQV3XgGQeqEp0He94KaQLc=;
        h=Subject:To:CC:References:From:Date:In-Reply-To:From;
        b=EORBKekZa/5395D/84VOx2MvaOmYyVjFEEuewdO2hI1yPfWmiwBDnYosZNrrM4wDL
         XOnGqUXa+XNgbB7/yvBDw3/qOr9LoCRoKQS36PDS3yx43xKr4kjmkFBPIsAxEIsvJs
         u6xKqyAhjb0uIzPICd1yikcHGXXTSs3u7PwfYDw3n/OW1C4fktMHek2IYXsx+WW28+
         D5MxP+BS3zmfgNyo1ZtbnxEHC4wbkoSMlD6aNCr3bSNh7lXNbn29/tHqV8utwP8EV0
         Y5qAf3XIfu+U1cpKZkRcUFkSkLY/wwL+rTsY/+a/dcmRs3w7Fmjqrr0sBm4Gb3aqrX
         b2P7ssl5tPSWw==
Received: from us01wehtc1.internal.synopsys.com (us01wehtc1-vip.internal.synopsys.com [10.12.239.236])
        by mailhost.synopsys.com (Postfix) with ESMTP id 1B2E43DCD;
        Tue, 13 Nov 2018 15:20:58 -0800 (PST)
Received: from DE02WEHTCA.internal.synopsys.com (10.225.19.92) by
 us01wehtc1.internal.synopsys.com (10.12.239.231) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Tue, 13 Nov 2018 15:20:38 -0800
Received: from DE02WEHTCB.internal.synopsys.com (10.225.19.94) by
 DE02WEHTCA.internal.synopsys.com (10.225.19.92) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Wed, 14 Nov 2018 00:20:37 +0100
Received: from [10.4.120.48] (10.4.120.48) by DE02WEHTCB.internal.synopsys.com
 (10.225.19.80) with Microsoft SMTP Server (TLS) id 14.3.408.0; Wed, 14 Nov
 2018 00:20:37 +0100
Subject: Re: [PATCH 0/3] PCI: designware: Fixing MSI handling flow
To:     Marc Zyngier <marc.zyngier@arm.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <helgaas@google.com>
CC:     Trent Piepho <tpiepho@impinj.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        "faiz_abbas@ti.com" <faiz_abbas@ti.com>,
        Joao Pinto <Joao.Pinto@synopsys.com>,
        Vignesh R <vigneshr@ti.com>
References: <20181113225734.8026-1-marc.zyngier@arm.com>
From:   Gustavo Pimentel <gustavo.pimentel@synopsys.com>
Message-ID: <e73891a5-d798-ee9c-607c-9648d07f6505@synopsys.com>
Date:   Tue, 13 Nov 2018 23:16:33 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181113225734.8026-1-marc.zyngier@arm.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.4.120.48]
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 13/11/2018 22:57, Marc Zyngier wrote:
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

As we spoke on the conference, as soon as I get back and I've the necessary
conditions I'll test the discussed modifications on my HW.

> 
> Thanks,
> 
> 	M.
> 
> [1] https://urldefense.proofpoint.com/v2/url?u=https-3A__patchwork.kernel.org_patch_10657987_&d=DwIDAg&c=DPL6_X_6JkXFx7AXWqB0tg&r=bkWxpLoW-f-E3EdiDCCa0_h0PicsViasSlvIpzZvPxs&m=ksl4uVn2tYUOeqywcyeYHziG6ejYHFeq-Cm4p8q7amU&s=WILOPbhOsYjM3XNhZwxGb2T6069LtLL1aqf9hbS-ajg&e=
> 
> Marc Zyngier (3):
>   PCI: designware: Use interrupt masking instead of disabling
>   PCI: designware: Take lock when ACKing an interrupt
>   PCI: designware: Move interrupt acking into the proper callback
> 
>  .../pci/controller/dwc/pcie-designware-host.c | 22 ++++++++++++-------
>  1 file changed, 14 insertions(+), 8 deletions(-)
> 

