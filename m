Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:38441 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1031740Ab2CGBPr convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 6 Mar 2012 20:15:47 -0500
Received: by iagz16 with SMTP id z16so7857259iag.19
        for <linux-pci@vger.kernel.org>; Tue, 06 Mar 2012 17:15:47 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20120307005905.27465.71131.stgit@bhelgaas.mtv.corp.google.com>
References: <20120307005905.27465.71131.stgit@bhelgaas.mtv.corp.google.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Tue, 6 Mar 2012 18:15:26 -0700
Message-ID: <CAErSpo7iGYcwTXnT=2Z_hCWem_ZtxGDMs4YjHqMZDbv9H5rZTw@mail.gmail.com>
Subject: Re: [PATCH v1 0/9] PCI core support for bus-to-resource offsets (fixes)
To: Jesse Barnes <jbarnes@virtuousgeek.org>
Cc: linux-pci@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Mar 6, 2012 at 6:00 PM, Bjorn Helgaas <bhelgaas@google.com> wrote:
> This is a set of fixes related to my recent "remove device resource fixups"
> series.  Patches [1-4] are essential; they fix bugs that prevent machines from
> booting.  Patches [5-9] don't fix any current issues, so they could be
> deferred.

These patches are also available in this git repo, on a branch based
on jbarnes' current pci/linux-next branch:
  git://github.com/bjorn-helgaas/linux.git pci-offset-fixes-v1-3fec284

Or you can browse them here:
  https://github.com/bjorn-helgaas/linux/compare/pci-next-63ab387...pci-offset-fixes-v1-3fec284

Bjorn
