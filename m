Return-Path: <SRS0=sVnv=Q2=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EB27C43381
	for <linux-pci@archiver.kernel.org>; Tue, 19 Feb 2019 05:16:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 46DD321848
	for <linux-pci@archiver.kernel.org>; Tue, 19 Feb 2019 05:16:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="aeb4beq1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725802AbfBSFQH (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 19 Feb 2019 00:16:07 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:38573 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725763AbfBSFQH (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 19 Feb 2019 00:16:07 -0500
Received: by mail-pg1-f196.google.com with SMTP id m2so7257113pgl.5
        for <linux-pci@vger.kernel.org>; Mon, 18 Feb 2019 21:16:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=GHaiFJohMk/q3KHj6Y6LVP0NZOY6zkpU7SEBNWmbwK0=;
        b=aeb4beq1JnNJVu8udZqV9C+B5pJw7DBN24bv3ie1CrTX084LkPZRrsNfsfw7Ik8jSq
         XvnsqTHhRL6a2c+oEakYX+3ArjXpGiJW/6NXqUUMMHvXEqwtnsbijis3uAekqKzDZ0P3
         iDev2S/sHgwhk16JPOLIqbFGxFTQsDzAPjryb1gnLZVNaNlmIeO0L1BlWcRL47R9DTUD
         1wQxU3WFQF1DQmQZOzsGawrTmknoQo9Zt7nVnzEaiXXmW19/SIPkUwgrvM3x5bixJ991
         ZYr9sXikBWLLN+BtmOvBdJr1M0IDE4PDeXl4+8b+icjR1Q6wF7FHjCuxZvYZ1j5KeI7x
         Qn0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=GHaiFJohMk/q3KHj6Y6LVP0NZOY6zkpU7SEBNWmbwK0=;
        b=Fn4BCfG9VSz4PJL5l6atpX6ATruSRBc50cYvHoei8f7y03nDK7FQ+sUGRHmjxfVTYy
         7aitL2aWvClbiaulSfnVIYSu++F8CxNmfhsbCy21ZxsUFqZUmzkpa2ILceiMfWwE1PmE
         7qJnBNooMXEUWZNEfJABpHBo9Mrf7anoScR4alXJtXl5gql40JYCofER/ItXW2yXFdDJ
         9FzTZzMJ64R9asIWXaW36ns/WDQi9wvOA89vrJNZ2YeaQbgZFa78ZscinDun7NbvKcv6
         4mcjrQoVQvsRdmOGxnXdnqrQoT3qdavIdy2K7LJZGMQeDAoNmnhT8HESsKmOQemHm1oU
         edFw==
X-Gm-Message-State: AHQUAubGF7XGH/Qnczsk03v2SGRICP/sQhe3x3YWFmvGb6otB+DArMr4
        egDCz0sxNXEZ/rR4maDqMaUfgw==
X-Google-Smtp-Source: AHgI3IbAcdxv/aecIuiSM9oKQdp2ioc72RpAdcjYuYAdRxJVumxI809S3uT7BMIugM45nW2OCnz5pg==
X-Received: by 2002:a63:2a96:: with SMTP id q144mr21902063pgq.338.1550553366276;
        Mon, 18 Feb 2019 21:16:06 -0800 (PST)
Received: from tuxbook-pro (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id p29sm20403435pgm.78.2019.02.18.21.16.04
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 18 Feb 2019 21:16:05 -0800 (PST)
Date:   Mon, 18 Feb 2019 21:16:03 -0800
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     Stanimir Varbanov <svarbanov@mm-sol.com>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Khasim Syed Mohammed <khasim.mohammed@linaro.org>,
        Niklas Cassel <niklas.cassel@linaro.org>,
        stable@vger.kernel.org
Subject: Re: [PATCH] PCI: qcom: Don't deassert reset GPIO during probe
Message-ID: <20190219051602.GB13018@tuxbook-pro>
References: <20190125232616.25714-1-bjorn.andersson@linaro.org>
 <20190213152352.GB417@e107981-ln.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190213152352.GB417@e107981-ln.cambridge.arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed 13 Feb 07:23 PST 2019, Lorenzo Pieralisi wrote:

> On Fri, Jan 25, 2019 at 03:26:16PM -0800, Bjorn Andersson wrote:
> > Acquiring the reset GPIO low means that reset is being deasserted, this
> > is followed almost immediately with qcom_pcie_host_init() asserting it,
> > initializing it and then finally deasserting it again, for the link to
> > come up.
> > 
> > Some PCIe devices requires a minimum time between the initial deassert
> > and subsequent reset cycles. In a platform that boots with the reset
> > GPIO asserted this requirement is being violated by this deassert/assert
> > pulse.
> > 
> > Acquiring the reset GPIO high will prevent this by matching the state to
> > the subsequent asserted state.
> > 
> > Cc: stable@vger.kernel.org
> 
> Missing Fixes: tag, please provide me one so that I can proceed.
> 

This applies to the original commit introducing this driver, so:

Fixes: 82a823833f4e ("PCI: qcom: Add Qualcomm PCIe controller driver")

Regards,
Bjorn
