Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ie0-f177.google.com ([209.85.223.177]:53033 "EHLO
	mail-ie0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751389AbaAPNTh (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 16 Jan 2014 08:19:37 -0500
Received: by mail-ie0-f177.google.com with SMTP id at1so677813iec.36
        for <linux-pci@vger.kernel.org>; Thu, 16 Jan 2014 05:19:36 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <XNM1$9$0$4$$3$3$7$A$9006862U52d758ed@hitachi.com>
References: <1389499841-6097-1-git-send-email-linux@eikelenboom.it>
 <XNM1$9$0$4$$3$3$7$A$9006858U52d4d109@hitachi.com> <6310129377.20140114162641@eikelenboom.it>
 <XNM1$9$0$4$$3$3$7$A$9006860U52d614ca@hitachi.com> <126550032.20140115203605@eikelenboom.it>
 <CAErSpo7Bjo3rVCnuf9fkKc=T33Z5ZBzS+nHOBqDDKt1j4u0yWg@mail.gmail.c>
 <1524137311.20140115232528@eikelenboom.it> <XNM1$9$0$4$$3$3$7$A$9006862U52d758ed@hitachi.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Thu, 16 Jan 2014 06:19:16 -0700
Message-ID: <CAErSpo7GFN2e3GOzb_+4oAZAQiUQZUV+ijQDKvQzVinBbTNvFA@mail.gmail.com>
Subject: Re: In "pci_fixup_video" check if this is or should be the primary
 video d
To: eiichiro.oiwa.nm@hitachi.com
Cc: Sander Eikelenboom <linux@eikelenboom.it>,
	Dave Airlie <airlied@redhat.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jesse Barnes <jbarnes@virtuousgeek.org>,
	David Airlie <airlied@linux.ie>,
	"qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

[+cc Michael, Jesse, David, qemu-devel]

On Wed, Jan 15, 2014 at 8:58 PM,  <eiichiro.oiwa.nm@hitachi.com> wrote:
> I suggest you should not break the PCI specification, as a developer of proprietary
> hypervisor, but I think your patch is no problem.
> Your PCI structure is specialized structure for your virtual machine.
> Maybe, your virtual machine will be causing another problem on Linux or other kernels
> because of breaking the PCI specification.

I assume you think qemu is breaking the PCI spec.  What exactly do you
think is broken?  Please give specific references to the spec.  This
conversation is pretty fragmented, and I came in late, so I apologize
if I missed this.

Bjorn
