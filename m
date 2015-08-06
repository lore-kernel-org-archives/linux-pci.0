Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-io0-f173.google.com ([209.85.223.173]:36711 "EHLO
	mail-io0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753958AbbHFP6l (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 6 Aug 2015 11:58:41 -0400
MIME-Version: 1.0
In-Reply-To: <55C2E79E.3090809@roeck-us.net>
References: <1438308908-12259-1-git-send-email-linux@roeck-us.net>
	<CAE9FiQXuTKmXXCFsKUiMK43U+LpOzfa3oV0iNWS+Jh879EDNsw@mail.gmail.com>
	<CAE9FiQVGhfbFW5-5deYcU2bDWE9k0-4+V+cepwdqZ661sLWOFA@mail.gmail.com>
	<55C2C4F4.1040600@roeck-us.net>
	<CAE9FiQXtSDBFy1rf4TPHwD-JjoB+5Wii1MBMBfGTaNosqnRJGg@mail.gmail.com>
	<55C2E79E.3090809@roeck-us.net>
Date: Thu, 6 Aug 2015 08:58:40 -0700
Message-ID: <CAE9FiQVDwX_-bX9sH2qv3thkKzOosFR3WvkUYWM=TsU-4oOSzA@mail.gmail.com>
Subject: Re: [PATCH v3] PCI: Only enable IO window if supported
From: Yinghai Lu <yinghai@kernel.org>
To: Guenter Roeck <linux@roeck-us.net>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Aug 5, 2015 at 9:50 PM, Guenter Roeck <linux@roeck-us.net> wrote:
> If I understand you correctly, we might need to change the code
> in pci_read_bridge_io() as follows.
>
> From
>
>         if (!(child->bus_flags & PCI_BUS_FLAGS_SUPPORTS_IO))
>                 return;
>
> to something like
>
>         if (!(child->bus_flags & PCI_BUS_FLAGS_SUPPORTS_IO)) {
>                 if (dev->transparent)
>                         return;
>                 child->bus_flags |= PCI_BUS_FLAGS_SUPPORTS_IO;
>         }
>
Then how about: the root bus really does not support IO PORT resource.
