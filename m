Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:39082 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S965158AbeCSSuV (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 19 Mar 2018 14:50:21 -0400
Date: Mon, 19 Mar 2018 13:50:18 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: linux-pci@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 0/4] PCI/VPD: Encapsulate VPD stuff in vpd.c
Message-ID: <20180319185018.GC77194@bhelgaas-glaptop.roam.corp.google.com>
References: <152097990638.37832.15000151673990461303.stgit@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <152097990638.37832.15000151673990461303.stgit@bhelgaas-glaptop.roam.corp.google.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Mar 13, 2018 at 05:26:14PM -0500, Bjorn Helgaas wrote:
> This is strictly cleanup, not intended to change or fix anything.
> 
> Move all the VPD-related code and structures to drivers/pci/vpd.c.
> 
> ---
> 
> Bjorn Helgaas (4):
>       PCI/VPD: Move VPD access code to vpd.c
>       PCI/VPD: Move VPD sysfs code to vpd.c
>       PCI/VPD: Move VPD quirks to vpd.c
>       PCI/VPD: Move VPD structures to vpd.c

Applied to pci/vpd for v4.17.
