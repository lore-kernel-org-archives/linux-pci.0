Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-yw0-f173.google.com ([209.85.161.173]:33559 "EHLO
	mail-yw0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932128AbcFBOKD convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 2 Jun 2016 10:10:03 -0400
Received: by mail-yw0-f173.google.com with SMTP id h19so50891208ywc.0
        for <linux-pci@vger.kernel.org>; Thu, 02 Jun 2016 07:10:03 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAHhAz+hA8D+-7j_b2nSaCxdSDYM=t0qFhO1J1ob-Wh71Tu+Qsg@mail.gmail.com>
References: <CAHhAz+hA8D+-7j_b2nSaCxdSDYM=t0qFhO1J1ob-Wh71Tu+Qsg@mail.gmail.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Thu, 2 Jun 2016 09:09:42 -0500
Message-ID: <CAErSpo5aDekgAo5jY1USTg8CwhL93X6DNzG7-2zzFp4R4G4o-Q@mail.gmail.com>
Subject: =?UTF-8?Q?Re=3A_How_PCI_drivers=28compiled_as_modules=29_loads_autom?=
	=?UTF-8?Q?atically_=E2=80=93_doubt=3F?=
To: Muni Sekhar <munisekharrms@gmail.com>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Jun 2, 2016 at 5:31 AM, Muni Sekhar <munisekharrms@gmail.com> wrote:
> Hello,
>
>
> We are having a “Generic SD host controller” on PCI bus and noticed
> that sdhci-pci.ko is getting loaded automatically after booting the
> system.
>
> I would like to know how does sdhci-pci.ko automatically getting loaded?
>
> Does kernel has any startup scripts to load drivers automatically for
> devices present on PCI bus?

See https://wiki.archlinux.org/index.php/Modalias
