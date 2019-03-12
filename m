Return-Path: <SRS0=lIFx=RP=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E3D7C43381
	for <linux-pci@archiver.kernel.org>; Tue, 12 Mar 2019 17:35:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2AF84206DF
	for <linux-pci@archiver.kernel.org>; Tue, 12 Mar 2019 17:35:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729708AbfCLRfR (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 12 Mar 2019 13:35:17 -0400
Received: from smtp3-g21.free.fr ([212.27.42.3]:56654 "EHLO smtp3-g21.free.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729354AbfCLRfQ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 12 Mar 2019 13:35:16 -0400
Received: from [192.168.108.8] (unknown [213.36.7.13])
        (Authenticated sender: marc.w.gonzalez)
        by smtp3-g21.free.fr (Postfix) with ESMTPSA id 9C78313F8E2;
        Tue, 12 Mar 2019 18:34:55 +0100 (CET)
Subject: Re: [RFC PATCH v1] PCI: qcom: Use quirk to override incorrect device
 class
From:   Marc Gonzalez <marc.w.gonzalez@free.fr>
To:     Stanimir Varbanov <svarbanov@mm-sol.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc:     Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        PCI <linux-pci@vger.kernel.org>,
        MSM <linux-arm-msm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Jeffrey Hugo <jhugo@codeaurora.org>
References: <94bb3f22-c5a7-1891-9d89-42a520e9a592@free.fr>
 <65321fe3-ca29-c454-63ae-98a46c2e5158@mm-sol.com>
 <1205cbfb-ac06-63a5-9401-75d4e68b15b5@free.fr>
Message-ID: <38ad143b-3b07-4d19-8ccd-ca39fb51e53d@free.fr>
Date:   Tue, 12 Mar 2019 18:34:55 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <1205cbfb-ac06-63a5-9401-75d4e68b15b5@free.fr>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 12/03/2019 18:18, Marc Gonzalez wrote:

> On 12/03/2019 13:42, Stanimir Varbanov wrote:
> 
>> I wonder, in case that dw_pcie_setup_rc() already has a write to
>> PCI_CLASS_DEVICE configuration register to set it as a bridge do we
>> still need to do the above fixup?
> 
> I don't know, I don't have an affected device. Unless the msm8998 /is/ affected,
> and dw_pcie_setup_rc() actually fixes it?

I think you hit the nail on the head...

If I comment out
//dw_pcie_wr_own_conf(pp, PCI_CLASS_DEVICE, 2, PCI_CLASS_BRIDGE_PCI);
from dw_pcie_setup_rc()
then pci_class() returns 0xff000000 instead of 0x6040000

So perhaps you're right: the quirk can be omitted altogether.
Unless it is not possible to program the device class on older chips?

Regards.
