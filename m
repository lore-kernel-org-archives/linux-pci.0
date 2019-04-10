Return-Path: <SRS0=u0zl=SM=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0DB9C10F11
	for <linux-pci@archiver.kernel.org>; Wed, 10 Apr 2019 14:21:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 62A7520854
	for <linux-pci@archiver.kernel.org>; Wed, 10 Apr 2019 14:21:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554906110;
	bh=30bt21JYBRQYnSdO8yJFiC48EYrxWJJyLsYQnwBb2Ps=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=c/4/gLTeSoFTb+tnj8qG8bp26HU6V48nB3/aNKdvNapfDiT8NkUPjOiaEvmyrK/Tz
	 kNkTqPquXXwUgmROPNFgNPRVQbzdffGI+ruF5BBiFiBs3nybjB8IywEs61melzMFZ3
	 6frsuawNrrHAEz65Drz8tv+TrhV2HrjrPeFvxsdY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732678AbfDJOVt (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 10 Apr 2019 10:21:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:57044 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732410AbfDJOVt (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 10 Apr 2019 10:21:49 -0400
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 69D2920854;
        Wed, 10 Apr 2019 14:21:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554906107;
        bh=30bt21JYBRQYnSdO8yJFiC48EYrxWJJyLsYQnwBb2Ps=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=dsThSkPDc4U3Z41Hk3iLqyZKgLCaoxselE1msvmZGAKGELXnSB4vIlngp4Ly8eVGN
         M2PQmjtIpZW75YsVxdV9OIO/c/5BNVHBM/gp19UrOVR+1OV6DLCbDEKfdyorbw87Mr
         Nx+o1DpI+N5wj4lv6jplXVYwetn7IPuIoc1KtLFw=
Received: by mail-ed1-f47.google.com with SMTP id h22so2202001edw.7;
        Wed, 10 Apr 2019 07:21:47 -0700 (PDT)
X-Gm-Message-State: APjAAAVyq+b2ItJMx7rjRODIlGRLwCknyjnaCLfv1ta3mu2lBYNVYtFy
        nc84+2pBV4Pfwu9hOAmo7NOk3Ge3NFUAzJKasp8=
X-Google-Smtp-Source: APXvYqxE2+ZkgdQ7Ch+JKLyR7sQQIEBYR7tpdIhgnO5hQ0FFnx/rjI9S7rGRZ3eIrpP00vfs66Jblhzl2O/Bvf+ggk4=
X-Received: by 2002:a50:fe15:: with SMTP id f21mr18469618edt.135.1554906105952;
 Wed, 10 Apr 2019 07:21:45 -0700 (PDT)
MIME-Version: 1.0
References: <1629227.alSmCsHHUc@pcbe13614> <6563205.xRkLC0driV@pcbe13614>
 <dae0b7ba500cc03fab23956eac85ca79@sw-optimization.com> <31100498.IIhqzTXyFT@pcbe13614>
In-Reply-To: <31100498.IIhqzTXyFT@pcbe13614>
From:   Alan Tull <atull@kernel.org>
Date:   Wed, 10 Apr 2019 09:21:09 -0500
X-Gmail-Original-Message-ID: <CANk1AXSQCFGE94R8ZxVSF2Gp+diCHJhFJPSVSx+iEyWp2URcpw@mail.gmail.com>
Message-ID: <CANk1AXSQCFGE94R8ZxVSF2Gp+diCHJhFJPSVSx+iEyWp2URcpw@mail.gmail.com>
Subject: Re: Device Description for FPGA Components on x86 system
To:     Federico Vaga <federico.vaga@cern.ch>
Cc:     Eric Schwarz <eas@sw-optimization.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-fpga@vger.kernel.org, linux-pci@vger.kernel.org,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, linux-x86_64@vger.kernel.org,
        linux-fpga-owner@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Apr 10, 2019 at 7:50 AM Federico Vaga <federico.vaga@cern.ch> wrote:

Hi Federico,

I wish I could point you to a complete solution, but there is a lot of
work to be done in this area.  Most of what is in the kernel is a low
level in-kernel API [4].  As you correctly state, the hardest part of
this is doing the enumerating if you are on x86 and aren't using
devicetree.

>
> Hi,
>
> P.S. sorry if I'm too verbose, hopefully it is useful
>
> thanks for the answer
>
> On Wednesday, April 10, 2019 12:30:14 PM CEST Eric Schwarz wrote:
> > Hi,
> >
> > everything you want is already available and on the way to mainline
> > concerning support for various FPGA loading modes or available for
> > checkout from a git repository.
> > All that has already been discussed on the mailing list.
> >
> > FPGA loading interface is available here [1].
> > Patchset missing for FPGA loading has been sent to the mailing list from
> > Anatolij Gustschin for various Linux kernel versions. Link to the most
> > recent patchset version [2].
> > FPGA Manager mailing list archive link [3] - Please read up the story
> > here around those patches and also the replies of the others.
>
> This does not answer the problem, which perhaps need to be clarified.
>
> Loading FPGA is **not** the problem, I listed it in the things I want to
> achieve because it is a pre-requirement for the real problem and because the
> two processes are linked (or could be).
>
> I continue by commenting myself below, trying to make the use case clearer.
>
> >
> > Cheers
> > Eric
> >
> > [1] https://github.com/vdsao/fpga-cfg
> > [2] https://marc.info/?l=linux-fpga&m=155078072107199&w=2
> > [3] https://marc.info/?l=linux-fpga
> >
> > Am 10.04.2019 12:01, schrieb Federico Vaga:
> > > Hello,
> > >
> > > sorry to push for an answer but I do not want to take the risk of
> > > designing
> > > something useless. I do not know how should I interpret a no-answer.
> > >
> > > If the solution really does not exist today, then I would like to
> > > collect
> > > opinions/arguments/requirements on the topic so that I can write
> > > something
> > > useful not only for CERN but for the entire community.
> > >
> > > Thank you
> > >
> > > On Wednesday, March 27, 2019 6:17:18 PM CEST Federico Vaga wrote:
> > >> Hello,
> > >>
> > >> I'm looking for guidance
> > >>
> > >> What I have:
> > >> * Intel x86_64 computer
> > >> * PCIe card with FPGA on it
> > >>
> > >> What I want to achieve:
> > >> * load an FPGA bitstream on the card
> > >> * load a device-tree like description for the FPGA devices contained
> > >> in the bitstream
>
> Let me first elaborate on my knowledge to avoid misunderstandings.
>
> On ARM, nowadays, we boot with a device tree. Later we program an FPGA in
> which there are other devices described by a device tree overlay. This can be
> done easily.
>
> A typical PC (x86/x86_64) does not boot with DeviceTree (it is possible, but
> it is not common and probably not even suggested, not sure), instead it uses
> ACPI.

I have heard it suggested that we work on using DT overlays on x86*.
It's clear there's work to be done to make that work.  I don't know if
anybody has really tried.  It seems impractical to map or translate a
x86 systems ACPI into a DT and go from there.  One suggestion a few
years ago was adding a partial DT that had nodes that could serve as
overlay targets and have that running in parallel with ACPI.

>
> The FPGA Manager has support only for DeviceTree (there are patching floating
> around to load a bitstream with configfs, debugfs or a chardevice (guilty))

There's one other interface in the kernel upstream. The DFL (device
feature list) framework built on the FPGA manager/bridge/region stuff
[5].   It's probably not what you specifically are looking for, I'm
mentioning as it exists in upstream.  It has a limited type of
enumeration and appears to mostly be geared for acceleration rather
than adding and enumerating any random hardware block.  Also it
requires specific bitstreams as the feature list is in fpga fabric.

>
> Most drivers foresee a DeviceTree loading but not an ACPI one (my feeling, I
> did not extract exact numbers from the sources)
>
> DeviceTree overlay requires that the system boots with DeviceTree.
>
> DeviceTree and ACPI do not work together
>
> So, this is the state of art that I am aware of. Correct me if, and where, I
> am wrong.
>
>
> Restarting from this point. I have a PC (x86_64) with a PCIe FPGA card (e.g.
> sis8160, spec, links below). How to load the FPGA bitstream (not really a
> problem as you correctly pointed out) **and** load all the IP-core instances
> in that FPGA bitstream so that drivers will start running?
>
> - Is there a recommendation for such use case?
> - ACPI SSDT overlay?
> - DT overlay?
> - is there a standard way to load FPGA IP-core devices which is architecture
> independent?
>
> A simple and practical example. The i2c-ocore.c is a platform_driver for an
> HDL I2C Master from open cores. I synthesize it and then load it on the FPGA.
> How to create the Linux platform_device instance to driver that IP-core? How
> to do that when you have also IRQ controller(s), DMA engine(s), EEPROM(s) and
> other devices?
>
> The fastest solution is to do what was common on ARM systems: having all
> platform devices declared (hard coded) in a file and load them. Which is not a
> good solution, for the same reasons why arm stuff moved to devicetree.
>
> Is it clearer?
>
> I do not know if it important to highlight but those cards are extensible,
> potentially any FMC module could be plugged and this needs a different FPGA,
> with different FPGA devices etc. So, It is not possible to hardcode the
> description of all possible FPGA code (infinite) that can enable the usage of
> all possible FMC module (not infinite, but definitively grater than 1)
>
>
> https://www.struck.de/sis8160.html
> https://ohwr.org/project/spec/wikis/home
>
>
> > >>
> > >> This is achievable on ARM with DeviceTree, overlay-dt, fpga-mgr; but
> > >> I'm
> > >> puzzled about the x86_64 use-case. I'm not able to find recent and
> > >> clear
> > >> information.
> > >>
> > >> Does anyone know if this is doable? Perhaps with ACPI SSDTs overlay?
> > >> Or with
> > >> the DT?
> > >>
> > >> thanks

Thanks,
Alan

[4] https://www.kernel.org/doc/html/latest/driver-api/fpga/index.html
[5] https://github.com/torvalds/linux/blob/master/Documentation/fpga/dfl.txt
