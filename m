Return-Path: <SRS0=9hNM=BN=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14CE6C433E0
	for <linux-pci@archiver.kernel.org>; Mon,  3 Aug 2020 11:03:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DC7EC20781
	for <linux-pci@archiver.kernel.org>; Mon,  3 Aug 2020 11:03:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596452607;
	bh=kdV7nHVNjty6826z22YXZvkV7yNmAWNNVkJspMjhDpQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=jUL4EYnO2/dmh/otwXF6KWDJ1TwKnV8YQ8Bf/dNPtRm7tgLp0azvlVZhWjsbWk+aN
	 ag5i/BEXAI6JOHLJ2PjjM6um+15oy7ZSAHINb72Sh9zoR4WevQKDaljMY6gkJowaN7
	 kTDsBKYzjfQegVM5vd3xgq/yWvpG4ailfWM69fbg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726222AbgHCLD1 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 3 Aug 2020 07:03:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:49754 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725945AbgHCLD1 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 3 Aug 2020 07:03:27 -0400
Received: from localhost (unknown [122.171.202.192])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B026320672;
        Mon,  3 Aug 2020 11:03:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596452605;
        bh=kdV7nHVNjty6826z22YXZvkV7yNmAWNNVkJspMjhDpQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=I1UGew/EonPvBfcIvQSllI607JXiTFxgOpYG/ahAnfSaaX2cCBLXZutNbgBCwL/jH
         gy/69hJtFvnx/EL/uaLe7HbUboflywrSGlsV9W/IQUhzEL8Iinvk14qDs/Ll/qfMwl
         W+ZFdbSIaURryBit7A8k8eLZ2x4XPENz26IngUhI=
Date:   Mon, 3 Aug 2020 16:33:22 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Sivaprakash Murugesan <sivaprak@codeaurora.org>
Cc:     agross@kernel.org, bjorn.andersson@linaro.org, bhelgaas@google.com,
        robh+dt@kernel.org, kishon@ti.com, mturquette@baylibre.com,
        sboyd@kernel.org, svarbanov@mm-sol.com, lorenzo.pieralisi@arm.com,
        p.zabel@pengutronix.de, mgautam@codeaurora.org,
        smuthayy@codeaurora.org, varada@codeaurora.org,
        linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, stable@vger.kernel.org,
        Selvam Sathappan Periakaruppan <speriaka@codeaurora.org>
Subject: Re: [PATCH 5/9] phy: qcom-qmp: use correct values for ipq8074 gen2
 pcie phy init
Message-ID: <20200803110322.GM12965@vkoul-mobl>
References: <1593940680-2363-1-git-send-email-sivaprak@codeaurora.org>
 <1593940680-2363-6-git-send-email-sivaprak@codeaurora.org>
 <20200713055558.GB34333@vkoul-mobl>
 <9988249f-53aa-e615-f64b-28c0c0641ab4@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9988249f-53aa-e615-f64b-28c0c0641ab4@codeaurora.org>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Sivaprakash,

On 29-07-20, 12:15, Sivaprakash Murugesan wrote:
> 
> On 7/13/2020 11:25 AM, Vinod Koul wrote:
> > On 05-07-20, 14:47, Sivaprakash Murugesan wrote:
> > > There were some problem in ipq8074 gen2 pcie phy init sequence, fix
> > Can you please describe these problems, it would help review to
> > understand the issues and also for future reference to you
> 
> Hi Vinod,
> 
> As you mentioned we are updating few register values
> 
> and also adding clocks and resets.
> 
> the register values are given by the Hardware team and there
> 
> is some fine tuning values are provided by Hardware team for the
> 
> issues we faced downstream.
> 
> Also, few register values are typos for example QSERDES_RX_SIGDET_CNTRL
> 
> is a rx register it was wrongly in serdes table.
> 
> I will try to mention these details in next patch.

The right thing to do would be a change per patch explaining the reason.
For example, fixing typos in QSERDES_RX_SIGDET_CNTRL, then another to
update tuning values based on hw recommendations. Clocks and reset
should be different patch

This helps us review each change for what it does and helps you down the
line to figure why a line of code was changed

HTH

-- 
~Vinod
