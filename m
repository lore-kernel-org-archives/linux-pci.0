Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-we0-f174.google.com ([74.125.82.174]:55037 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S2992476Ab2JYRgT (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 25 Oct 2012 13:36:19 -0400
Received: by mail-we0-f174.google.com with SMTP id t9so976155wey.19
        for <linux-pci@vger.kernel.org>; Thu, 25 Oct 2012 10:36:17 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1345739803-21017-1-git-send-email-mjg@redhat.com>
References: <1345739803-21017-1-git-send-email-mjg@redhat.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Thu, 25 Oct 2012 11:35:57 -0600
Message-ID: <CAErSpo6dn_0b8Ngx9VT=ARs_UXQftEx=2Kczeqemtmo0XyKzuQ@mail.gmail.com>
Subject: Re: Use PCI ROMs from EFI boot services
To: Matthew Garrett <mjg@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-efi@vger.kernel.org, mfleming@intel.com, dwmw2@infradead.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Aug 23, 2012 at 10:36 AM, Matthew Garrett <mjg@redhat.com> wrote:
> V3 just fixes all the casting issues and incorporates David's change in
> search ordering.

I think there's still a section mismatch issue with these patches, so
I haven't merged them yet.

I rebased my pci/mjg-pci-roms-from-efi branch to v3.7-rc2, and if we
get this issue fixed I'll put it in -next as v3.8 material.

Bjorn
