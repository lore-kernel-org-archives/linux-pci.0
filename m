Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ob0-f181.google.com ([209.85.214.181]:49228 "EHLO
	mail-ob0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932065Ab3CLPh2 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 12 Mar 2013 11:37:28 -0400
Received: by mail-ob0-f181.google.com with SMTP id ni5so4640687obc.12
        for <linux-pci@vger.kernel.org>; Tue, 12 Mar 2013 08:37:27 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CANB7UkHhjUYkSt7j=P41qGO-BApiukLNcFr86kX4hJ7s+j_iYw@mail.gmail.com>
References: <CANB7UkHhjUYkSt7j=P41qGO-BApiukLNcFr86kX4hJ7s+j_iYw@mail.gmail.com>
Date: Tue, 12 Mar 2013 09:37:27 -0600
Message-ID: <CAL-B5D18zhTNP=aie=O1KDCOzr0-teu8itDQ9tEYPK=X+ZCiMQ@mail.gmail.com>
Subject: Re: Questions about PCIe
From: Myron Stowe <myron.stowe@gmail.com>
To: Aurelien Cedeyn <aurelien.cedeyn@gmail.com>
Cc: linux-pci@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Mar 12, 2013 at 8:09 AM, Aurelien Cedeyn
<aurelien.cedeyn@gmail.com> wrote:
> Hi,
>
> I am trying to figure out how the PCI Express specification is
> implemented in the Linux kernel.
>
> I read[1] that the PCI Express devices can be accessed like in a
> network with a specific protocol with read/wirte requests.
> I looked at the kernel source code and i didn't see anything about
> such of PCIe packets.
>
> Is this kind of mecanism in the PCIe implementation of the linux
> kernel  ? Is this "network" protocol completly transparent and only
> managed at the lower layers ?

The transaction protocols of PCI, PCI-X, and PCI Express are all
transparent, completely managed by the hardware devices themselves.

Perhaps there are snippets of some of the protocol's aspects exposed,
such as when there are errors - which are partially exposed by AER, or
protocol attributes like Max Payload Setting (MPS) but even those
examples may be considered stretching things in the context you are
asking about.
>
>
> [1] http://xillybus.com/tutorials/pci-express-tlp-pcie-primer-tutorial-guide-1
>
>
> Thanks,
>
> --
> Aurélien Cedeyn
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
