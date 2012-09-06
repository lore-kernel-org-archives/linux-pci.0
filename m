Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-lb0-f174.google.com ([209.85.217.174]:54875 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753588Ab2IFN7u (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 6 Sep 2012 09:59:50 -0400
Received: by lbbgj3 with SMTP id gj3so1151269lbb.19
        for <linux-pci@vger.kernel.org>; Thu, 06 Sep 2012 06:59:49 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20120904134518.GF18151@srcf.ucam.org>
References: <1345739803-21017-1-git-send-email-mjg@redhat.com>
 <1345739803-21017-2-git-send-email-mjg@redhat.com> <CAErSpo4Y=z-sP6cjJSzCtD-Gsnrm6-CWWKJpqiScv6QdbzTeyA@mail.gmail.com>
 <20120904134518.GF18151@srcf.ucam.org>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Thu, 6 Sep 2012 06:59:28 -0700
Message-ID: <CAErSpo4A=ZWDuiGCFr6gQnFz--3OReVt0iWmzfjmOSQO=ZHNEw@mail.gmail.com>
Subject: Re: [PATCH V3 1/4] EFI: Stash ROMs if they're not in the PCI BAR
To: Matthew Garrett <mjg@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-efi@vger.kernel.org, mfleming@intel.com, dwmw2@infradead.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Sep 4, 2012 at 6:45 AM, Matthew Garrett <mjg@redhat.com> wrote:
> On Thu, Aug 23, 2012 at 05:44:22PM -0600, Bjorn Helgaas wrote:
>> On Thu, Aug 23, 2012 at 10:36 AM, Matthew Garrett <mjg@redhat.com> wrote:
>> > EFI provides support for providing PCI ROMs via means other than the ROM
>> > BAR. This support vanishes after we've exited boot services, so add support
>> > for stashing copies of the ROMs in setup_data if they're not otherwise
>> > available.
>>
>> -ENO_SIGNED_OFF_BY
>>
>> I'll add it if you confirm it.
>
> Signed-off-by: Matthew Garrett <mjg@redhat.com>

I put these on a branch
(http://git.kernel.org/?p=linux/kernel/git/helgaas/pci.git;a=shortlog;h=refs/heads/pci/mjg-pci-roms-from-efi),
but Fengguang found a new warning on the branch, so I'm waiting for a
fix for that before merging it to -next.  I'll bounce you the info
again.

Bjorn
