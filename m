Return-Path: <SRS0=vCch=R7=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E7A8C43381
	for <linux-pci@archiver.kernel.org>; Thu, 28 Mar 2019 11:45:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 211112177E
	for <linux-pci@archiver.kernel.org>; Thu, 28 Mar 2019 11:45:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kudzu-us.20150623.gappssmtp.com header.i=@kudzu-us.20150623.gappssmtp.com header.b="n1in9iTU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726182AbfC1Lpk (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 28 Mar 2019 07:45:40 -0400
Received: from mail-it1-f194.google.com ([209.85.166.194]:53891 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726046AbfC1Lpk (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 28 Mar 2019 07:45:40 -0400
Received: by mail-it1-f194.google.com with SMTP id y204so5484209itf.3
        for <linux-pci@vger.kernel.org>; Thu, 28 Mar 2019 04:45:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kudzu-us.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Stt24VhWO7/R9Ab9hsEcwa3VG0DfScK96kZoumRDhmY=;
        b=n1in9iTUL13FOP70xGr5ILqLP2Ji3Fbf+aHfGnBGGBwLgAqQWx23VDq/WoniHKDs47
         T5I6WYETHhH+yni4B2SUgkAEixcVZuZifkYyAdJOubxKEPUiKPwAhyeI6CIOQ+793QV7
         ULmBknDYToGM1oz5cNpOcNE/mDpN89DGd4lRYcz+7X4aARPqx1BSpq3ggsANt1Jj76+k
         EiDyMyULKglsxavXV44r56owrHEZVQFymBnMOPuOK/JVpst5UYRg/UvMOmhkdo7ORiZe
         u11mWFRnmJmz1K4KsuExQPLdRaGGpTzW1kdbetj0anxEKwpB/deXBQiKb4syRAtR9OAZ
         YrRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Stt24VhWO7/R9Ab9hsEcwa3VG0DfScK96kZoumRDhmY=;
        b=aCurtH6f/iS2e4VZgZS0sjia9cdRCtzjA4UD4XyawrImqo766th6sqN7+q5w6/sQbN
         oKhM3n/1hdK6EMggGMFHdy1T+8iiobUXI2aL2fTpjTkacFMB3fUhMg6EGoRtGC7XJ7VV
         SVmWlh6fEePbXaqYtuOkWRkJERPmVRefqX6xPHZO8XL7r6FSA4+eloshsVXfHXv+df5R
         oPdqykUl/kK8ARRB1hKOtxWEvD46VobD5R0S+zraDFbma21UJT3nUs4+204zRO7jiTTV
         VfjKsBH9/n4rKqTxnybkn4hlOPs8Od8lLK/YAOTvd+ineOF6oyRQ76+BoiCbDD6otiiT
         TJPA==
X-Gm-Message-State: APjAAAV7Bd50cvbZeezK11OLqQFL/sKbgEr43aEGircpt7G7c/GoCk8b
        Td8SrA8QEExKFBi7nYzF8jQ3U+pmDKPAO+RCdW1XKA==
X-Google-Smtp-Source: APXvYqyKHpVrV9NT4WgjTr3kPeelwEitbSTgeTpX0eYo5sno9cLM527sY9IV3r2lozx3DYd+6YizbV5v6O2W0Rca4yc=
X-Received: by 2002:a24:7553:: with SMTP id y80mr7658544itc.107.1553773538931;
 Thu, 28 Mar 2019 04:45:38 -0700 (PDT)
MIME-Version: 1.0
References: <1551898265-18909-1-git-send-email-info@metux.net>
 <1551909774-24030-1-git-send-email-info@metux.net> <20190320211517.GG251185@google.com>
In-Reply-To: <20190320211517.GG251185@google.com>
From:   Jon Mason <jdmason@kudzu.us>
Date:   Thu, 28 Mar 2019 11:45:28 +0000
Message-ID: <CAPoiz9x6bSdFpE-cuOBinE7WdNvzaD5R+tsweUqWe+KsL87GQw@mail.gmail.com>
Subject: Re: [PATCH v2] drivers: ntb: Kconfig: pedantic cleanups
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     "Enrico Weigelt, metux IT consult" <info@metux.net>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Kurt Schwemmer <kurt.schwemmer@microsemi.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        linux-ntb <linux-ntb@googlegroups.com>,
        linux-pci@vger.kernel.org, Dave Jiang <dave.jiang@intel.com>,
        Allen Hubbe <allenbh@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Mar 20, 2019 at 9:15 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
>
> [+cc Jon, Dave, Allen]
>
> On Wed, Mar 06, 2019 at 11:02:54PM +0100, Enrico Weigelt, metux IT consult wrote:
> > Formatting of Kconfig files doesn't look so pretty, so just
> > take damp cloth and clean it up.
>
> Oops, I didn't notice that this was a v2.  I first thought this was a
> 2/2 patch.  Sorry for the noise.  Most of my comments still apply
> here, I think.

I 100% agree with the comments form Bjorn.  Though most of the
comments were from previous versions, but if you are going to change
it then might as well make it right.  :)
Assuming you make the changes, I'll pull it in.

Thanks,
Jon

>
> > Signed-off-by: Enrico Weigelt, metux IT consult <info@metux.net>
> > ---
> >  drivers/ntb/Kconfig          | 20 ++++++++++----------
> >  drivers/ntb/hw/amd/Kconfig   |  4 ++--
> >  drivers/ntb/hw/idt/Kconfig   | 41 ++++++++++++++++++++---------------------
> >  drivers/ntb/hw/intel/Kconfig |  4 ++--
> >  drivers/ntb/hw/mscc/Kconfig  |  8 ++++----
> >  drivers/ntb/test/Kconfig     | 26 +++++++++++++-------------
> >  6 files changed, 51 insertions(+), 52 deletions(-)
> >
> > diff --git a/drivers/ntb/Kconfig b/drivers/ntb/Kconfig
> > index 95944e5..5ce3fdd 100644
> > --- a/drivers/ntb/Kconfig
> > +++ b/drivers/ntb/Kconfig
> > @@ -2,13 +2,13 @@ menuconfig NTB
> >       tristate "Non-Transparent Bridge support"
> >       depends on PCI
> >       help
> > -      The PCI-E Non-transparent bridge hardware is a point-to-point PCI-E bus
> > -      connecting 2 systems.  When configured, writes to the device's PCI
> > -      mapped memory will be mirrored to a buffer on the remote system.  The
> > -      ntb Linux driver uses this point-to-point communication as a method to
> > -      transfer data from one system to the other.
> > +       The PCI-E Non-transparent bridge hardware is a point-to-point PCI-E bus
> > +       connecting 2 systems.  When configured, writes to the device's PCI
> > +       mapped memory will be mirrored to a buffer on the remote system.  The
> > +       ntb Linux driver uses this point-to-point communication as a method to
> > +       transfer data from one system to the other.
> >
> > -      If unsure, say N.
> > +       If unsure, say N.
> >
> >  if NTB
> >
> > @@ -19,10 +19,10 @@ source "drivers/ntb/test/Kconfig"
> >  config NTB_TRANSPORT
> >       tristate "NTB Transport Client"
> >       help
> > -      This is a transport driver that enables connected systems to exchange
> > -      messages over the ntb hardware.  The transport exposes a queue pair api
> > -      to client drivers.
> > +       This is a transport driver that enables connected systems to exchange
> > +       messages over the ntb hardware.  The transport exposes a queue pair api
> > +       to client drivers.
> >
> > -      If unsure, say N.
> > +       If unsure, say N.
> >
> >  endif # NTB
> > diff --git a/drivers/ntb/hw/amd/Kconfig b/drivers/ntb/hw/amd/Kconfig
> > index cfe903c..9a90f17 100644
> > --- a/drivers/ntb/hw/amd/Kconfig
> > +++ b/drivers/ntb/hw/amd/Kconfig
> > @@ -2,6 +2,6 @@ config NTB_AMD
> >       tristate "AMD Non-Transparent Bridge support"
> >       depends on X86_64
> >       help
> > -      This driver supports AMD NTB on capable Zeppelin hardware.
> > +       This driver supports AMD NTB on capable Zeppelin hardware.
> >
> > -      If unsure, say N.
> > +       If unsure, say N.
> > diff --git a/drivers/ntb/hw/idt/Kconfig b/drivers/ntb/hw/idt/Kconfig
> > index f8948cf..5d106ac 100644
> > --- a/drivers/ntb/hw/idt/Kconfig
> > +++ b/drivers/ntb/hw/idt/Kconfig
> > @@ -3,28 +3,27 @@ config NTB_IDT
> >       depends on PCI
> >       select HWMON
> >       help
> > -      This driver supports NTB of cappable IDT PCIe-switches.
> > +       This driver supports NTB of cappable IDT PCIe-switches.
> >
> > -      Some of the pre-initializations must be made before IDT PCIe-switch
> > -      exposes it NT-functions correctly. It should be done by either proper
> > -      initialisation of EEPROM connected to master smbus of the switch or
> > -      by BIOS using slave-SMBus interface changing corresponding registers
> > -      value. Evidently it must be done before PCI bus enumeration is
> > -      finished in Linux kernel.
> > +       Some of the pre-initializations must be made before IDT PCIe-switch
> > +       exposes it NT-functions correctly. It should be done by either proper
> > +       initialisation of EEPROM connected to master smbus of the switch or
> > +       by BIOS using slave-SMBus interface changing corresponding registers
> > +       value. Evidently it must be done before PCI bus enumeration is
> > +       finished in Linux kernel.
> >
> > -      First of all partitions must be activated and properly assigned to all
> > -      the ports with NT-functions intended to be activated (see SWPARTxCTL
> > -      and SWPORTxCTL registers). Then all NT-function BARs must be enabled
> > -      with chosen valid aperture. For memory windows related BARs the
> > -      aperture settings shall determine the maximum size of memory windows
> > -      accepted by a BAR. Note that BAR0 must map PCI configuration space
> > -      registers.
> > +       First of all partitions must be activated and properly assigned to all
> > +       the ports with NT-functions intended to be activated (see SWPARTxCTL
> > +       and SWPORTxCTL registers). Then all NT-function BARs must be enabled
> > +       with chosen valid aperture. For memory windows related BARs the
> > +       aperture settings shall determine the maximum size of memory windows
> > +       accepted by a BAR. Note that BAR0 must map PCI configuration space
> > +       registers.
> >
> > -      It's worth to note, that since a part of this driver relies on the
> > -      BAR settings of peer NT-functions, the BAR setups can't be done over
> > -      kernel PCI fixups. That's why the alternative pre-initialization
> > -      techniques like BIOS using SMBus interface or EEPROM should be
> > -      utilized.
> > -
> > -      If unsure, say N.
> > +       It's worth to note, that since a part of this driver relies on the
> > +       BAR settings of peer NT-functions, the BAR setups can't be done over
> > +       kernel PCI fixups. That's why the alternative pre-initialization
> > +       techniques like BIOS using SMBus interface or EEPROM should be
> > +       utilized.
> >
> > +       If unsure, say N.
> > diff --git a/drivers/ntb/hw/intel/Kconfig b/drivers/ntb/hw/intel/Kconfig
> > index 91f995e..c166d50 100644
> > --- a/drivers/ntb/hw/intel/Kconfig
> > +++ b/drivers/ntb/hw/intel/Kconfig
> > @@ -2,6 +2,6 @@ config NTB_INTEL
> >       tristate "Intel Non-Transparent Bridge support"
> >       depends on X86_64
> >       help
> > -      This driver supports Intel NTB on capable Xeon and Atom hardware.
> > +       This driver supports Intel NTB on capable Xeon and Atom hardware.
> >
> > -      If unsure, say N.
> > +       If unsure, say N.
> > diff --git a/drivers/ntb/hw/mscc/Kconfig b/drivers/ntb/hw/mscc/Kconfig
> > index 013ed67..74ec015 100644
> > --- a/drivers/ntb/hw/mscc/Kconfig
> > +++ b/drivers/ntb/hw/mscc/Kconfig
> > @@ -2,8 +2,8 @@ config NTB_SWITCHTEC
> >       tristate "MicroSemi Switchtec Non-Transparent Bridge Support"
> >       select PCI_SW_SWITCHTEC
> >       help
> > -      Enables NTB support for Switchtec PCI switches. This also
> > -      selects the Switchtec management driver as they share the same
> > -      hardware interface.
> > +       Enables NTB support for Switchtec PCI switches. This also
> > +       selects the Switchtec management driver as they share the same
> > +       hardware interface.
> >
> > -      If unsure, say N.
> > +       If unsure, say N.
> > diff --git a/drivers/ntb/test/Kconfig b/drivers/ntb/test/Kconfig
> > index a5d0eda..416ab56 100644
> > --- a/drivers/ntb/test/Kconfig
> > +++ b/drivers/ntb/test/Kconfig
> > @@ -1,27 +1,27 @@
> >  config NTB_PINGPONG
> >       tristate "NTB Ping Pong Test Client"
> >       help
> > -      This is a simple ping pong driver that exercises the scratchpads and
> > -      doorbells of the ntb hardware.  This driver may be used to test that
> > -      your ntb hardware and drivers are functioning at a basic level.
> > +       This is a simple ping pong driver that exercises the scratchpads and
> > +       doorbells of the ntb hardware.  This driver may be used to test that
> > +       your ntb hardware and drivers are functioning at a basic level.
> >
> > -      If unsure, say N.
> > +       If unsure, say N.
> >
> >  config NTB_TOOL
> >       tristate "NTB Debugging Tool Test Client"
> >       help
> > -      This is a simple debugging driver that enables the doorbell and
> > -      scratchpad registers to be read and written from the debugfs.  This
> > -      enables more complicated debugging to be scripted from user space.
> > -      This driver may be used to test that your ntb hardware and drivers are
> > -      functioning at a basic level.
> > +       This is a simple debugging driver that enables the doorbell and
> > +       scratchpad registers to be read and written from the debugfs.  This
> > +       enables more complicated debugging to be scripted from user space.
> > +       This driver may be used to test that your ntb hardware and drivers are
> > +       functioning at a basic level.
> >
> > -      If unsure, say N.
> > +       If unsure, say N.
> >
> >  config NTB_PERF
> >       tristate "NTB RAW Perf Measuring Tool"
> >       help
> > -      This is a tool to measure raw NTB performance by transferring data
> > -      to and from the window without additional software interaction.
> > +       This is a tool to measure raw NTB performance by transferring data
> > +       to and from the window without additional software interaction.
> >
> > -      If unsure, say N.
> > +       If unsure, say N.
> > --
> > 1.9.1
> >
