Return-Path: <SRS0=agom=SC=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40FB0C43381
	for <linux-pci@archiver.kernel.org>; Sun, 31 Mar 2019 15:33:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ECBE720882
	for <linux-pci@archiver.kernel.org>; Sun, 31 Mar 2019 15:33:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oOLXgRnJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731231AbfCaPdy (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Sun, 31 Mar 2019 11:33:54 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:45888 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731118AbfCaPdx (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 31 Mar 2019 11:33:53 -0400
Received: by mail-pl1-f194.google.com with SMTP id bf11so3221526plb.12;
        Sun, 31 Mar 2019 08:33:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Wi55+B5uaXMMuizT7C0RDZMdZG6JumjF18RvIbH4qWM=;
        b=oOLXgRnJouSlQtucWAIqknbX2LFtcFRXFa+s/1ulAONu5uyqIgtoWNyN2ZP14NF7eb
         MGXs66wFNcsS6LWX1TZ7KN+5xarCxJT/47pdprkcSfCEKQpFfec5+QLe3xDj4+1hwO7k
         rlBBxzi6AjsO7EMBBvpYIBKAXBO3gaM1qIPFNaprl99o+EqKQGd13jPSe0LPyQZ2rJzR
         8McroF2mqCJ0EVnTW0OzfxD0CAuQAVonBe1OEwiUOazwewbgWa3AqP0tyng3hAngVCAI
         aidNfefWhYkvgOQ+xvrfIX8FlUbX91TjHEjwIqvJ/rmiSXZJz8xw4ObPh4ygIpuYff8O
         YWBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Wi55+B5uaXMMuizT7C0RDZMdZG6JumjF18RvIbH4qWM=;
        b=XcxeV2n7BS9fPf7iSwlntf3HjhUqhtSJxxooo97Q5qEhsWUuqRkbqUkks3Abiri18H
         C4emtpoARPv4GFIYm9ho+GvAoO/HjAm8gXxNz+96MRRR1cDur5NHhKedMoHt1N/7DXcr
         K0MwowmwR5tD26/3vX1m3Ag9VQHJbsHvowKGv/rD2TudVWFiLYmRka/89S/o9tQvkem3
         lE4bnk+hlxwTW2ymlGHtVZ2WFY09KIl9Ac7YPKTKcevITiY/x/4vY+vr+3NsO8jEXLxv
         tSk7lGnRtl9UGUYKnfIxahkVStgKi5LWZJSQMsFpHApnDQ7FwRNDIerR+728jAzL80pq
         67Bg==
X-Gm-Message-State: APjAAAUidrcFBnK2aZUP7Eu3DfF6zlv0edtJc/sbEr75PCpmvVvN6H10
        H2kluOS3B3tVTatHf6I0fQk=
X-Google-Smtp-Source: APXvYqw3trDF740Ag1Ibem/wi3e2NG3EIUCfYsG+R20hMG/L4OSu9AeaIolxYB6CqqJZv3wItKCEoQ==
X-Received: by 2002:a17:902:8ec1:: with SMTP id x1mr47115745plo.328.1554046432831;
        Sun, 31 Mar 2019 08:33:52 -0700 (PDT)
Received: from mail.google.com ([104.238.181.70])
        by smtp.gmail.com with ESMTPSA id b8sm9274930pgq.33.2019.03.31.08.33.48
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 31 Mar 2019 08:33:52 -0700 (PDT)
Date:   Sun, 31 Mar 2019 23:33:46 +0800
From:   Changbin Du <changbin.du@gmail.com>
To:     Changbin Du <changbin.du@gmail.com>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 05/12] pci doc: convert PCI/MSI-HOWTO.txt to rst format
Message-ID: <20190331153344.k65pzadxieon4dej@mail.google.com>
References: <20190329160413.4293-1-changbin.du@gmail.com>
 <20190329160413.4293-6-changbin.du@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190329160413.4293-6-changbin.du@gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Corbet,
I also plant to convert x86 arch specific docs. And I will merge them into
one big serias for reviewing. Please wait for new revison. Thanks!

On Sat, Mar 30, 2019 at 12:04:06AM +0800, Changbin Du wrote
> This converts the plain text documentation to reStructuredText format and
> add it to Sphinx TOC tree. No essential content change.
> 
> Signed-off-by: Changbin Du <changbin.du@gmail.com>
> ---
>  .../PCI/{MSI-HOWTO.txt => MSI-HOWTO.rst}      | 56 ++++++++++++-------
>  Documentation/PCI/index.rst                   |  1 +
>  2 files changed, 38 insertions(+), 19 deletions(-)
>  rename Documentation/PCI/{MSI-HOWTO.txt => MSI-HOWTO.rst} (89%)
> 
> diff --git a/Documentation/PCI/MSI-HOWTO.txt b/Documentation/PCI/MSI-HOWTO.rst
> similarity index 89%
> rename from Documentation/PCI/MSI-HOWTO.txt
> rename to Documentation/PCI/MSI-HOWTO.rst
> index 618e13d5e276..33f382632fdd 100644
> --- a/Documentation/PCI/MSI-HOWTO.txt
> +++ b/Documentation/PCI/MSI-HOWTO.rst
> @@ -1,13 +1,18 @@
> -		The MSI Driver Guide HOWTO
> -	Tom L Nguyen tom.l.nguyen@intel.com
> -			10/03/2003
> -	Revised Feb 12, 2004 by Martine Silbermann
> -		email: Martine.Silbermann@hp.com
> -	Revised Jun 25, 2004 by Tom L Nguyen
> -	Revised Jul  9, 2008 by Matthew Wilcox <willy@linux.intel.com>
> -		Copyright 2003, 2008 Intel Corporation
> +.. SPDX-License-Identifier: GPL-2.0
> +.. include:: <isonum.txt>
> +
> +==========================
> +The MSI Driver Guide HOWTO
> +==========================
> +
> +:Authors: - Tom L Nguyen <tom.l.nguyen@intel.com> 10/03/2003
> +          - Revised Feb 12, 2004 by Martine Silbermann <Martine.Silbermann@hp.com>
> +	  - Revised Jun 25, 2004 by Tom L Nguyen
> +	  - Revised Jul  9, 2008 by Matthew Wilcox <willy@linux.intel.com>
> +	    Copyright 2003, 2008 Intel Corporation
>  
>  1. About this guide
> +===================
>  
>  This guide describes the basics of Message Signaled Interrupts (MSIs),
>  the advantages of using MSI over traditional interrupt mechanisms, how
> @@ -16,6 +21,7 @@ try if a device doesn't support MSIs.
>  
>  
>  2. What are MSIs?
> +=================
>  
>  A Message Signaled Interrupt is a write from the device to a special
>  address which causes an interrupt to be received by the CPU.
> @@ -30,6 +36,7 @@ a time.
>  
>  
>  3. Why use MSIs?
> +================
>  
>  There are three reasons why using MSIs can give an advantage over
>  traditional pin-based interrupts.
> @@ -62,6 +69,7 @@ in a network card or each port in a storage controller.
>  
>  
>  4. How to use MSIs
> +==================
>  
>  PCI devices are initialised to use pin-based interrupts.  The device
>  driver has to set up the device to use MSI or MSI-X.  Not all machines
> @@ -69,6 +77,7 @@ support MSIs correctly, and for those machines, the APIs described below
>  will simply fail and the device will continue to use pin-based interrupts.
>  
>  4.1 Include kernel support for MSIs
> +-----------------------------------
>  
>  To support MSI or MSI-X, the kernel must be built with the CONFIG_PCI_MSI
>  option enabled.  This option is only available on some architectures,
> @@ -77,13 +86,14 @@ on x86, you must also enable X86_UP_APIC or SMP in order to see the
>  CONFIG_PCI_MSI option.
>  
>  4.2 Using MSI
> +-------------
>  
>  Most of the hard work is done for the driver in the PCI layer.  The driver
>  simply has to request that the PCI layer set up the MSI capability for this
>  device.
>  
>  To automatically use MSI or MSI-X interrupt vectors, use the following
> -function:
> +function::
>  
>    int pci_alloc_irq_vectors(struct pci_dev *dev, unsigned int min_vecs,
>  		unsigned int max_vecs, unsigned int flags);
> @@ -101,12 +111,12 @@ any possible kind of interrupt.  If the PCI_IRQ_AFFINITY flag is set,
>  pci_alloc_irq_vectors() will spread the interrupts around the available CPUs.
>  
>  To get the Linux IRQ numbers passed to request_irq() and free_irq() and the
> -vectors, use the following function:
> +vectors, use the following function::
>  
>    int pci_irq_vector(struct pci_dev *dev, unsigned int nr);
>  
>  Any allocated resources should be freed before removing the device using
> -the following function:
> +the following function::
>  
>    void pci_free_irq_vectors(struct pci_dev *dev);
>  
> @@ -126,7 +136,7 @@ The typical usage of MSI or MSI-X interrupts is to allocate as many vectors
>  as possible, likely up to the limit supported by the device.  If nvec is
>  larger than the number supported by the device it will automatically be
>  capped to the supported limit, so there is no need to query the number of
> -vectors supported beforehand:
> +vectors supported beforehand::
>  
>  	nvec = pci_alloc_irq_vectors(pdev, 1, nvec, PCI_IRQ_ALL_TYPES)
>  	if (nvec < 0)
> @@ -135,7 +145,7 @@ vectors supported beforehand:
>  If a driver is unable or unwilling to deal with a variable number of MSI
>  interrupts it can request a particular number of interrupts by passing that
>  number to pci_alloc_irq_vectors() function as both 'min_vecs' and
> -'max_vecs' parameters:
> +'max_vecs' parameters::
>  
>  	ret = pci_alloc_irq_vectors(pdev, nvec, nvec, PCI_IRQ_ALL_TYPES);
>  	if (ret < 0)
> @@ -143,14 +153,14 @@ number to pci_alloc_irq_vectors() function as both 'min_vecs' and
>  
>  The most notorious example of the request type described above is enabling
>  the single MSI mode for a device.  It could be done by passing two 1s as
> -'min_vecs' and 'max_vecs':
> +'min_vecs' and 'max_vecs'::
>  
>  	ret = pci_alloc_irq_vectors(pdev, 1, 1, PCI_IRQ_ALL_TYPES);
>  	if (ret < 0)
>  		goto out_err;
>  
>  Some devices might not support using legacy line interrupts, in which case
> -the driver can specify that only MSI or MSI-X is acceptable:
> +the driver can specify that only MSI or MSI-X is acceptable::
>  
>  	nvec = pci_alloc_irq_vectors(pdev, 1, nvec, PCI_IRQ_MSI | PCI_IRQ_MSIX);
>  	if (nvec < 0)
> @@ -159,7 +169,7 @@ the driver can specify that only MSI or MSI-X is acceptable:
>  4.3 Legacy APIs
>  
>  The following old APIs to enable and disable MSI or MSI-X interrupts should
> -not be used in new code:
> +not be used in new code::
>  
>    pci_enable_msi()		/* deprecated */
>    pci_disable_msi()		/* deprecated */
> @@ -175,8 +185,10 @@ of vectors we might have to revisit that decision and add a
>  pci_nr_irq_vectors() helper that handles MSI and MSI-X transparently.
>  
>  4.4 Considerations when using MSIs
> +----------------------------------
>  
>  4.4.1 Spinlocks
> +~~~~~~~~~~~~~~~
>  
>  Most device drivers have a per-device spinlock which is taken in the
>  interrupt handler.  With pin-based interrupts or a single MSI, it is not
> @@ -189,6 +201,7 @@ spin_lock_irqsave() or spin_lock_irq() which disable local interrupts
>  and acquire the lock (see Documentation/kernel-hacking/locking.rst).
>  
>  4.5 How to tell whether MSI/MSI-X is enabled on a device
> +--------------------------------------------------------
>  
>  Using 'lspci -v' (as root) may show some devices with "MSI", "Message
>  Signalled Interrupts" or "MSI-X" capabilities.  Each of these capabilities
> @@ -197,6 +210,7 @@ or "-" (disabled).
>  
>  
>  5. MSI quirks
> +=============
>  
>  Several PCI chipsets or devices are known not to support MSIs.
>  The PCI stack provides three ways to disable MSIs:
> @@ -206,6 +220,7 @@ The PCI stack provides three ways to disable MSIs:
>  3. on a single device
>  
>  5.1. Disabling MSIs globally
> +----------------------------
>  
>  Some host chipsets simply don't support MSIs properly.  If we're
>  lucky, the manufacturer knows this and has indicated it in the ACPI
> @@ -220,6 +235,7 @@ in your best interests to report the problem to linux-pci@vger.kernel.org
>  including a full 'lspci -v' so we can add the quirks to the kernel.
>  
>  5.2. Disabling MSIs below a bridge
> +----------------------------------
>  
>  Some PCI bridges are not able to route MSIs between busses properly.
>  In this case, MSIs must be disabled on all devices behind the bridge.
> @@ -230,7 +246,7 @@ as the nVidia nForce and Serverworks HT2000).  As with host chipsets,
>  Linux mostly knows about them and automatically enables MSIs if it can.
>  If you have a bridge unknown to Linux, you can enable
>  MSIs in configuration space using whatever method you know works, then
> -enable MSIs on that bridge by doing:
> +enable MSIs on that bridge by doing::
>  
>         echo 1 > /sys/bus/pci/devices/$bridge/msi_bus
>  
> @@ -245,6 +261,7 @@ Again, please notify linux-pci@vger.kernel.org of any bridges that need
>  special handling.
>  
>  5.3. Disabling MSIs on a single device
> +--------------------------------------
>  
>  Some devices are known to have faulty MSI implementations.  Usually this
>  is handled in the individual device driver, but occasionally it's necessary
> @@ -253,6 +270,7 @@ of MSI.  While this is a convenient workaround for the driver author,
>  it is not good practice, and should not be emulated.
>  
>  5.4. Finding why MSIs are disabled on a device
> +----------------------------------------------
>  
>  From the above three sections, you can see that there are many reasons
>  why MSIs may not be enabled for a given device.  Your first step should
> @@ -260,8 +278,8 @@ be to examine your dmesg carefully to determine whether MSIs are enabled
>  for your machine.  You should also check your .config to be sure you
>  have enabled CONFIG_PCI_MSI.
>  
> -Then, 'lspci -t' gives the list of bridges above a device.  Reading
> -/sys/bus/pci/devices/*/msi_bus will tell you whether MSIs are enabled (1)
> +Then, 'lspci -t' gives the list of bridges above a device. Reading
> +`/sys/bus/pci/devices/*/msi_bus` will tell you whether MSIs are enabled (1)
>  or disabled (0).  If 0 is found in any of the msi_bus files belonging
>  to bridges between the PCI root and the device, MSIs are disabled.
>  
> diff --git a/Documentation/PCI/index.rst b/Documentation/PCI/index.rst
> index 751cd8f23c62..8ed57b9ecfe4 100644
> --- a/Documentation/PCI/index.rst
> +++ b/Documentation/PCI/index.rst
> @@ -10,3 +10,4 @@ Linux PCI Bus Subsystem
>     pci
>     PCIEBUS-HOWTO
>     pci-iov-howto
> +   MSI-HOWTO
> -- 
> 2.20.1
> 

-- 
Cheers,
Changbin Du
