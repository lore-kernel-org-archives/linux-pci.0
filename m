Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-oa0-f51.google.com ([209.85.219.51]:39375 "EHLO
	mail-oa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751586Ab3G0OZU (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Sat, 27 Jul 2013 10:25:20 -0400
Received: by mail-oa0-f51.google.com with SMTP id i4so9967175oah.10
        for <linux-pci@vger.kernel.org>; Sat, 27 Jul 2013 07:25:19 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAErSpo5KZkxJ+rwkmEUKEPRuj1nZ=7xv8Y9m0T6yp9Jo=FXPbw@mail.gmail.com>
References: <1374759098-6746-1-git-send-email-yinghai@kernel.org>
	<CAErSpo79rJZuEkJB+W0XGq-sKUDwTgrG5SVzJbFBqobLY2+nGQ@mail.gmail.com>
	<CAE9FiQUmetaXJ-=d3HV-AiaeEEh_ehdbT5E=Mrm7d7Z7y78Tng@mail.gmail.com>
	<CAErSpo5KZkxJ+rwkmEUKEPRuj1nZ=7xv8Y9m0T6yp9Jo=FXPbw@mail.gmail.com>
Date: Sat, 27 Jul 2013 07:25:19 -0700
Message-ID: <CAE9FiQVzLm1=3YbD76FvzoVbg6-n3bNrHnmEqz1SerODNbVRDg@mail.gmail.com>
Subject: Re: [PATCH v6] PCI: Don't let mmio fallback to must-only, if ioport
 fails with must+optional
From: Yinghai Lu <yinghai@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Gavin Shan <shangw@linux.vnet.ibm.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Jul 26, 2013 at 10:08 AM, Bjorn Helgaas <bhelgaas@google.com> wrote:
> On Fri, Jul 26, 2013 at 6:57 AM, Yinghai Lu <yinghai@kernel.org> wrote:

>> BenH at last only hope it could backport to v3.10 for the distribution.
>
> OK, I applied this to for-linus and marked it for stable.  Please take
> a look and see if it makes sense, especially the changelog:
>
> http://git.kernel.org/cgit/linux/kernel/git/helgaas/pci.git/commit/?h=for-linus&id=aa914f5

yes, thanks for that.

Yinghai
