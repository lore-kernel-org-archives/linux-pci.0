Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ob0-f175.google.com ([209.85.214.175]:34956 "EHLO
	mail-ob0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751928AbbCSPGJ (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 19 Mar 2015 11:06:09 -0400
Received: by obcjt1 with SMTP id jt1so36359041obc.2
        for <linux-pci@vger.kernel.org>; Thu, 19 Mar 2015 08:06:08 -0700 (PDT)
Date: Thu, 19 Mar 2015 10:06:06 -0500
From: Bjorn Helgaas <bhelgaas@google.com>
To: linux-pci@vger.kernel.org
Cc: linux-acpi@vger.kernel.org
Subject: Re: [PATCH v1 0/4] Unassigned resource fixes
Message-ID: <20150319150606.GD26935@google.com>
References: <20150312173201.1052.28341.stgit@bhelgaas-glaptop2.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20150312173201.1052.28341.stgit@bhelgaas-glaptop2.roam.corp.google.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Mar 12, 2015 at 12:35:19PM -0500, Bjorn Helgaas wrote:
> These are some minor resource fixes related to unassigned PCI BARs.  We
> should:
> 
>   - Mark BARS as unassigned when we can figure that out
>   - Not complain about "overlaps" with unassigned BARs
>   - Prevent pci_ioremap_bar() on unassigned BARs
>   - Give better error messages when pci_ioremap_bar() fails
> 
> I don't think these will actually fix any bugs, other than getting rid of
> some annoying messages and improving some others.
> 
> Comments welcome.
> 
> ---
> 
> Bjorn Helgaas (4):
>       PNP: Don't check for overlaps with unassigned PCI BARs
>       PCI: Mark invalid BARs as unassigned
>       PCI: Show driver, BAR#, and resource on pci_ioremap_bar() failure
>       PCI: Fail pci_ioremap_bar() on unassigned resources

Applied with Rafael's ack to pci/resource for v4.1.
