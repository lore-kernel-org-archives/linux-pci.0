Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-oa0-f50.google.com ([209.85.219.50]:51743 "EHLO
	mail-oa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758784Ab3DHRlh (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 8 Apr 2013 13:41:37 -0400
Received: by mail-oa0-f50.google.com with SMTP id n1so6357773oag.23
        for <linux-pci@vger.kernel.org>; Mon, 08 Apr 2013 10:41:36 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1365237884.2787.2.camel@dabdike>
References: <20130321043449.7229.81056.stgit@amt.stowe> <20130321043509.7229.93525.stgit@amt.stowe>
 <CAErSpo77UWR3u+DfdaOW0hG6FXQv+ADsb24bjKQ3fJOR5SFBZg@mail.gmail.com> <1365237884.2787.2.camel@dabdike>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Mon, 8 Apr 2013 11:41:16 -0600
Message-ID: <CAErSpo7YZdcTVYZFrDd62QptYEge6jJLkkZ9pRkGMa-d7AK-sg@mail.gmail.com>
Subject: Re: [PATCH 3/3] PCI, scsi, ahci: Unify usages of 0x1b4b vendor ID to
 use PCI_VENDOR_ID_MARVELL_EXT
To: James Bottomley <James.Bottomley@hansenpartnership.com>
Cc: Myron Stowe <myron.stowe@redhat.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
	linux-ide@vger.kernel.org, Jeff Garzik <jgarzik@pobox.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Sat, Apr 6, 2013 at 2:44 AM, James Bottomley
<James.Bottomley@hansenpartnership.com> wrote:
> On Thu, 2013-04-04 at 12:23 -0600, Bjorn Helgaas wrote:
>> On Wed, Mar 20, 2013 at 10:35 PM, Myron Stowe <myron.stowe@redhat.com> wrote:
>> > With the 0x1b4b vendor ID #define in place, convert hard-coded ID values.
>> > Also, unify the previous SCSI specific use of this vendor ID to the new
>> > macro.
>> >
>> > Signed-off-by: Myron Stowe <myron.stowe@redhat.com>
>> > ---
>> >
>> >  drivers/ata/ahci.c           |   10 +++++-----
>> >  drivers/scsi/mvsas/mv_init.c |    6 +++---
>> >  drivers/scsi/mvumi.c         |    4 ++--
>> >  drivers/scsi/mvumi.h         |    1 -
>> >  4 files changed, 10 insertions(+), 11 deletions(-)
>>
>> Jeff & James, if you don't object to these, I can push them through my
>> PCI tree along with the corresponding pci_ids.h addition.
>
> Fine by me.  You can add my acked by if you need it.

Thanks, I applied these to my pci/misc branch.  I split the
ahci/mvsas/mvumi changes into three separate patches (one for each
driver) to try to make driver updates simpler:

477cfdb [SCSI] mvumi: Use PCI_VENDOR_ID_MARVELL_EXT for 0x1b4b
f13e04c [SCSI] mvsas: Use PCI_VENDOR_ID_MARVELL_EXT for 0x1b4b
2e4fae9 ahci: Use PCI_VENDOR_ID_MARVELL_EXT for 0x1b4b
fcf88ab PCI: Define macro for Marvell vendor ID

Bjorn
