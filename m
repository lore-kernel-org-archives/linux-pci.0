Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ob0-f182.google.com ([209.85.214.182]:32838 "EHLO
	mail-ob0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753103AbbDHTWg (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 8 Apr 2015 15:22:36 -0400
Received: by oblw8 with SMTP id w8so103913501obl.0
        for <linux-pci@vger.kernel.org>; Wed, 08 Apr 2015 12:22:36 -0700 (PDT)
Date: Wed, 8 Apr 2015 14:22:33 -0500
From: Bjorn Helgaas <bhelgaas@google.com>
To: Ray Jui <rjui@broadcom.com>
Cc: Scott Branden <sbranden@broadcom.com>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, bcm-kernel-feedback-list@broadcom.com
Subject: Re: [PATCH v8 0/3] pci: iproc: Add Broadcom iProc PCIe support
Message-ID: <20150408192233.GD30967@google.com>
References: <1428517295-12825-1-git-send-email-rjui@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1428517295-12825-1-git-send-email-rjui@broadcom.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Apr 08, 2015 at 11:21:32AM -0700, Ray Jui wrote:
> This patch series adds the support for Broadcom iProc PCIe controller
> 
> pcie-iproc.c servers as the common core driver, and front-end bus
> interface needs to be added to support different bus interfaces
> 
> pcie-iproc-pltfm.c contains the support for the platform bus interface
> 
> Changes from v7:
>  - Consolidate iProc PCIe patches and rebase to v4.0-rc1 per request
>    from Bjorn
>  - Restrict CONFIG_PCIE_IPROC to ARM based platforms
>  - Spell out 'pltfm' as 'platform'

Thanks, I applied this to pci/host-iproc and will merge it to "next" for
v4.1 as soon as the build test completes.

Bjorn
