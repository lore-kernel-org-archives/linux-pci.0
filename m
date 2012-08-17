Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-lb0-f174.google.com ([209.85.217.174]:56794 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755211Ab2HQXhe (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 17 Aug 2012 19:37:34 -0400
Received: by lbbgj3 with SMTP id gj3so2417513lbb.19
        for <linux-pci@vger.kernel.org>; Fri, 17 Aug 2012 16:37:33 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20120816232620.3662.90438.stgit@bhelgaas.mtv.corp.google.com>
References: <20120816232620.3662.90438.stgit@bhelgaas.mtv.corp.google.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Fri, 17 Aug 2012 17:37:12 -0600
Message-ID: <CAErSpo7R1wz0OEU2JVrdHJnoA0Rjk8vkhrBYnSRNDDXeUfPekg@mail.gmail.com>
Subject: Re: [PATCH 1/6] PCI: Use list_for_each_entry() for bus->devices traversal
To: linux-pci@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Aug 16, 2012 at 5:26 PM, Bjorn Helgaas <bhelgaas@google.com> wrote:
> Replace list_for_each() + pci_dev_b() with the simpler
> list_for_each_entry().

This series of 6 patches is obsoleted by "[PATCH v2 00/16] Clean up
drivers/pci/remove.c", posted 8/17.
