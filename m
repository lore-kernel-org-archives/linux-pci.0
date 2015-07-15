Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ig0-f171.google.com ([209.85.213.171]:38031 "EHLO
	mail-ig0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750772AbbGOFg7 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 15 Jul 2015 01:36:59 -0400
MIME-Version: 1.0
In-Reply-To: <1436935796-28995-1-git-send-email-Sreekanth.Reddy@avagotech.com>
References: <1436935796-28995-1-git-send-email-Sreekanth.Reddy@avagotech.com>
Date: Tue, 14 Jul 2015 22:36:58 -0700
Message-ID: <CAE9FiQWzbwzQ7mrtyumhMFYg0-8N18+KZhjfvMfs5j5eV0C5wA@mail.gmail.com>
Subject: Re: [PATCH v3] [SCSI] mpt2sas, mpt3sas: Abort initialization if no
 memory I/O resources detected
From: Yinghai Lu <yinghai@kernel.org>
To: Sreekanth Reddy <sreekanth.reddy@avagotech.com>
Cc: tpearson@raptorengineeringinc.com,
	James Bottomley <jejb@kernel.org>, martin.petersen@oracle.com,
	Linux-Scsi <linux-scsi@vger.kernel.org>,
	"James E.J. Bottomley" <JBottomley@parallels.com>,
	Sathya.Prakash@avagotech.com,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Christoph Hellwig <hch@infradead.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Jul 14, 2015 at 9:49 PM, Sreekanth Reddy
<sreekanth.reddy@avagotech.com> wrote:
> Driver crashes if the BIOS do not set up at least one
> memory I/O resource. This failure can happen if the device is too
> slow to respond during POST and is missed by the BIOS, but Linux
> then detects the device later in the boot process.

But pci subsystem should assign resources to those unassigned BAR.

Do you mean even kernel can not assign resource to them? or it takes so long for
mpt FW to get ready?

Thanks

Yinghai
