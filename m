Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-cys01nam02on0074.outbound.protection.outlook.com ([104.47.37.74]:27712
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754251AbcJONql (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sat, 15 Oct 2016 09:46:41 -0400
From: Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>
To: Marc Zyngier <marc.zyngier@arm.com>
CC: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Bjorn Helgaas <helgaas@kernel.org>,
        "arnd@arndb.de" <arnd@arndb.de>
Subject: RE: Why MSI is limited to 32 interrupts maximum
Date: Sat, 15 Oct 2016 13:30:13 +0000
Message-ID: <8520D5D51A55D047800579B0941471982594B127@XAP-PVEXMBX01.xlnx.xilinx.com>
References: <8520D5D51A55D047800579B0941471982594B0F3@XAP-PVEXMBX01.xlnx.xilinx.com>
 <20161015141401.70d95035@why.wild-wind.fr.eu.org>
In-Reply-To: <20161015141401.70d95035@why.wild-wind.fr.eu.org>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

 > On Sat, 15 Oct 2016 12:37:55 +0000
> Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com> wrote:
>=20
> Hi Bharat,
>=20
> > Can anyone tell why MSI interrupts are limited to maximum 32
> > interrupts, even though we have 16bit message data register ?
>=20
> That's the very definition of the original PCI MSI: Up to 32 consecutive =
interrupts
> per function, and a single doorbell address.
> MSI-X lifts that restriction and offers up to 2048 interrupts that do not=
 have to
> be contiguous can target individual doorbells. Assuming your MSI controll=
er
> advertises MSI-X support and that your devices do support it as well, you=
'll be
> able to enjoy those.
>=20

Thanks Marc, so then only 5 bits of message data register will be used, so =
what is the purpose rest of the bits ?

> >
> > Regards,
> > Bharat
> >
> >
> > This email and any attachments are intended for the sole use of the
> > named recipient(s) and contain(s) confidential information that may be
> > proprietary, privileged or copyrighted under applicable law. If you
> > are not the intended recipient, do not read, copy, or forward this
> > email message or any attachments. Delete this email message and any
> > attachments immediately.
> >
>=20
> Please fix your email not to carry such disclaimer (or use a private emai=
l address
> if you can't work around your company policy). Posting confidential infor=
mation
> on a public mailing list feels a bit silly.
>=20
> Thanks,
>=20
> 	M.
> --
> Without deviation from the norm, progress is not possible.
