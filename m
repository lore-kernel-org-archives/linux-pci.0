Return-Path: <SRS0=cd0N=R6=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B0CEC43381
	for <linux-pci@archiver.kernel.org>; Wed, 27 Mar 2019 13:56:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2FE8E2075E
	for <linux-pci@archiver.kernel.org>; Wed, 27 Mar 2019 13:56:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553694969;
	bh=C4eU9oRaEoL9ygJ2ub8AOMbCb6mF+DAa+wIHyDXUyFM=;
	h=Date:From:To:Subject:References:In-Reply-To:List-ID:From;
	b=cn3owYNQfwPx9QhpWA3hFKqNq9A6l84F/DWxzDudnhkjKOXdhW02h0W2ZxkXn04hW
	 04EcNB+aKrFUkYl9g5EUVpmSz7YrSIPeg5z78V6lUUmFM1BnSOexjzHQ3H5RR/84l1
	 Cd9gLWPV+LR4dbLD+VlPyCMAzapD3ZeZ+Tr40VPw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728296AbfC0N4I (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 27 Mar 2019 09:56:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:54476 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728177AbfC0N4I (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 27 Mar 2019 09:56:08 -0400
Received: from localhost (173-25-63-173.client.mchsi.com [173.25.63.173])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B409C2075E;
        Wed, 27 Mar 2019 13:56:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553694968;
        bh=C4eU9oRaEoL9ygJ2ub8AOMbCb6mF+DAa+wIHyDXUyFM=;
        h=Date:From:To:Subject:References:In-Reply-To:From;
        b=VkuJV/1/F/QM9sNRDJhNEHc+8/Uc1ZsXHu9iLxzbkzDfgcYMypNTa2vycZpll0F9h
         sJKQstsbqrJrFhkQI4YbV/ImwKktAv9fLQZ5YJi87dHH16vY0L0CJV9Cbc28OCrWk1
         GcGeQQtwhfQ+HuEmVLFIV2N9nnZ1vIrwcmCnZ6rs=
Date:   Wed, 27 Mar 2019 08:56:06 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/4] PCI, CPER: Trivial cleanups
Message-ID: <20190327135606.GZ24180@google.com>
References: <20190325181425.247227-1-helgaas@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190325181425.247227-1-helgaas@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Mar 25, 2019 at 01:14:21PM -0500, helgaas@kernel.org wrote:
> From: Bjorn Helgaas <bhelgaas@google.com>
> 
> Clean up whitespace, fix some typos, add some spec references, and convert
> unnecessary __u32 usage to u32.
> 
> Bjorn Helgaas (4):
>   PCI: Cleanup register definition width and whitespace
>   PCI: Fix comment typos
>   CPER: Add UEFI spec references
>   CPER: Remove unnecessary use of user-space types

These are on pci/trivial for v5.2.

>  drivers/pci/controller/dwc/pci-keystone.c |   2 +-
>  drivers/pci/controller/pci-host-generic.c |   2 +-
>  drivers/pci/controller/pcie-iproc-msi.c   |   2 +-
>  drivers/pci/pci.c                         | 328 +++++++++++----------
>  include/linux/cper.h                      | 336 +++++++++++-----------
>  include/uapi/linux/pci_regs.h             | 132 +++++----
>  6 files changed, 405 insertions(+), 397 deletions(-)
> 
> -- 
> 2.21.0.392.gf8f6787159e-goog
> 
