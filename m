Return-Path: <SRS0=cd0N=R6=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5DC5C43381
	for <linux-pci@archiver.kernel.org>; Wed, 27 Mar 2019 13:58:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 83DFF2087C
	for <linux-pci@archiver.kernel.org>; Wed, 27 Mar 2019 13:58:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553695131;
	bh=aUmUklp7Ivv3GyGqbd0YUb6qmHm6kG8ZHeYPYC02o6Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=ENZckut4e4kSzXNeE4HPhGAgKGkZpuHPEFrTcSfB+yeuEEpQ6hH4LPuAIXgpV0vsx
	 rYCgmm2UGDMlQilaLcdwbZJwEvhmeJj1hWJuA7wAtYDReP3K1YGvYG7UiQ4+C89Kcp
	 nbZ0vEi6WLOYqzD6SSHZ5/wMzfTMvkNh97W+W+Ek=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727488AbfC0N6u (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 27 Mar 2019 09:58:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:55416 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725797AbfC0N6u (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 27 Mar 2019 09:58:50 -0400
Received: from localhost (173-25-63-173.client.mchsi.com [173.25.63.173])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AFDB22075E;
        Wed, 27 Mar 2019 13:58:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553695129;
        bh=aUmUklp7Ivv3GyGqbd0YUb6qmHm6kG8ZHeYPYC02o6Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=zT1MCNlGj9RhY8AgOj7IDCfnOiEvbUdVWCLymPQFo59Hqp/D8zjye+yy2fnIIZ64w
         aQnM7ANzKreDfZsb02u7JJnKUDFUYCIqE2A02wQTeh/yWUp/SC13Jv0YwV11A9CqRn
         ReZFuutym3gfxX4lqR+E+vsM0IyNwr3o9WB2A0qM=
Date:   Wed, 27 Mar 2019 08:58:48 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     linux-pci@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Michal Simek <michal.simek@xilinx.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 0/2] PCI/MSI: Remove unused interfaces
Message-ID: <20190327135848.GA24180@google.com>
References: <20190325221229.36930-1-helgaas@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190325221229.36930-1-helgaas@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[+cc Lorenzo, Michal, linux-arm-kernel]

On Mon, Mar 25, 2019 at 05:12:27PM -0500, Bjorn Helgaas wrote:
> From: Bjorn Helgaas <bhelgaas@google.com>
> 
> pcie-xilinx-nwl.c is the only driver to use mask_msi_irq() and
> unmask_msi_irq(), which are trivial wrappers around PCI-specific functions.
> We obviously know we need the PCI versions in this driver, so use them
> directly, as all the other PCI host controller drivers do, and remove the
> unused wrappers.
> 
> Unless there's objection, I'll merge both of these via my tree just to keep
> them together.

These are on pci/msi for v5.2.

> Bjorn Helgaas (2):
>   PCI/MSI: Remove unused __write_msi_msg() and write_msi_msg()
>   PCI/MSI: Remove unused mask_msi_irq() and unmask_msi_irq()
> 
>  drivers/pci/controller/pcie-xilinx-nwl.c |  9 ++++-----
>  include/linux/msi.h                      | 18 ------------------
>  2 files changed, 4 insertions(+), 23 deletions(-)
> 
> -- 
> 2.21.0.392.gf8f6787159e-goog
> 
