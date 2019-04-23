Return-Path: <SRS0=Emu/=SZ=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58755C10F03
	for <linux-pci@archiver.kernel.org>; Tue, 23 Apr 2019 21:12:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 16B65218B0
	for <linux-pci@archiver.kernel.org>; Tue, 23 Apr 2019 21:12:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556053969;
	bh=BWxvGr0qGvlTx7fLrnaZqZMaPJT+VkSzaWxMloc4rq4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=DWt8ab4F+ISaLQwlMdeXqZ+1Y/jGpKr+ixnzYOaiSqXuxSygzGEwd6GDZ7LyogGXo
	 sgcutav2JkUCSBTLc5wqYxVxQYNjeK/KGVums5NkKcUUeKscpfCZ9TmY4QsYnibwVR
	 Q2yhRajx8exbNr1KOCXxe8v8crgzQ5U+UGEr/nA4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726351AbfDWVMs (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 23 Apr 2019 17:12:48 -0400
Received: from casper.infradead.org ([85.118.1.10]:38896 "EHLO
        casper.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726029AbfDWVMr (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 23 Apr 2019 17:12:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:From:Date:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=ZD96kitRr8igE3+JY10qe34adEM/oyvkNaEMzzG8fnY=; b=EvP6rLEGAhqB1F8o9hM6vchUDQ
        2esUtWbn6UC5Qg776ziYdGFDqOii/cQb8YQYTHfYK3+HuUVQEk+OI3wjFZDO9Dp4J8L68+yGnxZDA
        RmlHsFk8OM5LaCohxEp5HraSe5/RFZr7V6aVUxe4hqY3le0mQEa10lyBjYXyreqfRVuiWCmIxc+s6
        cEMoQLioj2B8QF/BGDUu+EgkiH/JH1WiL+3UZZ6Mv9zc8MjvCm6pLZpBkCmInxsEm2QwpNjK11XIH
        twhekmimb1Ft8hE5Dp85ggyercIGvu35ODlTvosIUw8JdEoIM9sX3SvmFY1T3OAmq34PE9KWMpCcP
        RjqnCMdg==;
Received: from 177.17.136.231.dynamic.adsl.gvt.net.br ([177.17.136.231] helo=coco.lan)
        by casper.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hJ2iY-0003uJ-AY; Tue, 23 Apr 2019 21:12:42 +0000
Date:   Tue, 23 Apr 2019 18:12:36 -0300
From:   Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To:     Changbin Du <changbin.du@gmail.com>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Bjorn Helgaas <bhelgaas@google.com>, rjw@rjwysocki.net,
        linux-pci@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, tglx@linutronix.de, mingo@redhat.com,
        x86@kernel.org, fenghua.yu@intel.com,
        linuxppc-dev@lists.ozlabs.org, linux-acpi@vger.kernel.org,
        linux-gpio@vger.kernel.org
Subject: Re: [PATCH v4 13/63] Documentation: ACPI: move acpi-lid.txt to
 firmware-guide/acpi and convert to reST
Message-ID: <20190423181236.18e4b6a0@coco.lan>
In-Reply-To: <20190423162932.21428-14-changbin.du@gmail.com>
References: <20190423162932.21428-1-changbin.du@gmail.com>
        <20190423162932.21428-14-changbin.du@gmail.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Em Wed, 24 Apr 2019 00:28:42 +0800
Changbin Du <changbin.du@gmail.com> escreveu:

> This converts the plain text documentation to reStructuredText format and
> add it to Sphinx TOC tree. No essential content change.
> 
> Signed-off-by: Changbin Du <changbin.du@gmail.com>
> ---
>  .../acpi/acpi-lid.rst}                        | 48 ++++++++++++-------
>  Documentation/firmware-guide/acpi/index.rst   |  1 +
>  2 files changed, 33 insertions(+), 16 deletions(-)
>  rename Documentation/{acpi/acpi-lid.txt => firmware-guide/acpi/acpi-lid.rst} (77%)
> 
> diff --git a/Documentation/acpi/acpi-lid.txt b/Documentation/firmware-guide/acpi/acpi-lid.rst
> similarity index 77%
> rename from Documentation/acpi/acpi-lid.txt
> rename to Documentation/firmware-guide/acpi/acpi-lid.rst
> index effe7af3a5af..1d19e15a6945 100644
> --- a/Documentation/acpi/acpi-lid.txt
> +++ b/Documentation/firmware-guide/acpi/acpi-lid.rst
> @@ -1,25 +1,29 @@
> -Special Usage Model of the ACPI Control Method Lid Device
> +.. SPDX-License-Identifier: GPL-2.0
> +.. include:: <isonum.txt>
>  
> -Copyright (C) 2016, Intel Corporation
> -Author: Lv Zheng <lv.zheng@intel.com>
> +=========================================================
> +Special Usage Model of the ACPI Control Method Lid Device
> +=========================================================
>  
> +:Copyright: |copy| 2016, Intel Corporation
>  
> -Abstract:
> +:Author: Lv Zheng <lv.zheng@intel.com>
>  
> -Platforms containing lids convey lid state (open/close) to OSPMs using a
> -control method lid device. To implement this, the AML tables issue
> -Notify(lid_device, 0x80) to notify the OSPMs whenever the lid state has
> -changed. The _LID control method for the lid device must be implemented to
> -report the "current" state of the lid as either "opened" or "closed".
> +:Abstract: Platforms containing lids convey lid state (open/close) to OSPMs
> +  using a control method lid device. To implement this, the AML tables issue
> +  Notify(lid_device, 0x80) to notify the OSPMs whenever the lid state has
> +  changed. The _LID control method for the lid device must be implemented to
> +  report the "current" state of the lid as either "opened" or "closed".

Same comment for the abstract.
>  
> -For most platforms, both the _LID method and the lid notifications are
> -reliable. However, there are exceptions. In order to work with these
> -exceptional buggy platforms, special restrictions and expections should be
> -taken into account. This document describes the restrictions and the
> -expections of the Linux ACPI lid device driver.
> +  For most platforms, both the _LID method and the lid notifications are
> +  reliable. However, there are exceptions. In order to work with these
> +  exceptional buggy platforms, special restrictions and expections should be
> +  taken into account. This document describes the restrictions and the
> +  expections of the Linux ACPI lid device driver.
>  
>  
>  1. Restrictions of the returning value of the _LID control method
> +=================================================================
>  
>  The _LID control method is described to return the "current" lid state.
>  However the word of "current" has ambiguity, some buggy AML tables return
> @@ -31,6 +35,7 @@ with cached value, the initial returning value is likely not reliable.
>  There are platforms always retun "closed" as initial lid state.
>  
>  2. Restrictions of the lid state change notifications
> +=====================================================
>  
>  There are buggy AML tables never notifying when the lid device state is
>  changed to "opened". Thus the "opened" notification is not guaranteed. But
> @@ -40,17 +45,21 @@ trigger some system power saving operations on Windows. Since it is fully
>  tested, it is reliable from all AML tables.
>  
>  3. Expections for the userspace users of the ACPI lid device driver
> +===================================================================
>  
>  The ACPI button driver exports the lid state to the userspace via the
> -following file:
> +following file::
> +
>    /proc/acpi/button/lid/LID0/state
> +
>  This file actually calls the _LID control method described above. And given
>  the previous explanation, it is not reliable enough on some platforms. So
>  it is advised for the userspace program to not to solely rely on this file
>  to determine the actual lid state.
>  
>  The ACPI button driver emits the following input event to the userspace:
> -  SW_LID
> +  * SW_LID
> +
>  The ACPI lid device driver is implemented to try to deliver the platform
>  triggered events to the userspace. However, given the fact that the buggy
>  firmware cannot make sure "opened"/"closed" events are paired, the ACPI
> @@ -59,20 +68,25 @@ button driver uses the following 3 modes in order not to trigger issues.
>  If the userspace hasn't been prepared to ignore the unreliable "opened"
>  events and the unreliable initial state notification, Linux users can use
>  the following kernel parameters to handle the possible issues:
> +
>  A. button.lid_init_state=method:

Just for the sake of a better visual at the html output, I would place those
button.* as:

  A. ``button.lid_init_state=method``:

Anyway, with or without such change:

Reviewed-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>

>     When this option is specified, the ACPI button driver reports the
>     initial lid state using the returning value of the _LID control method
>     and whether the "opened"/"closed" events are paired fully relies on the
>     firmware implementation.
> +
>     This option can be used to fix some platforms where the returning value
>     of the _LID control method is reliable but the initial lid state
>     notification is missing.
> +
>     This option is the default behavior during the period the userspace
>     isn't ready to handle the buggy AML tables.
> +
>  B. button.lid_init_state=open:
>     When this option is specified, the ACPI button driver always reports the
>     initial lid state as "opened" and whether the "opened"/"closed" events
>     are paired fully relies on the firmware implementation.
> +
>     This may fix some platforms where the returning value of the _LID
>     control method is not reliable and the initial lid state notification is
>     missing.
> @@ -80,6 +94,7 @@ B. button.lid_init_state=open:
>  If the userspace has been prepared to ignore the unreliable "opened" events
>  and the unreliable initial state notification, Linux users should always
>  use the following kernel parameter:
> +
>  C. button.lid_init_state=ignore:
>     When this option is specified, the ACPI button driver never reports the
>     initial lid state and there is a compensation mechanism implemented to
> @@ -89,6 +104,7 @@ C. button.lid_init_state=ignore:
>     notifications can be delivered to the userspace when the lid is actually
>     opens given that some AML tables do not send "opened" notifications
>     reliably.
> +
>     In this mode, if everything is correctly implemented by the platform
>     firmware, the old userspace programs should still work. Otherwise, the
>     new userspace programs are required to work with the ACPI button driver.
> diff --git a/Documentation/firmware-guide/acpi/index.rst b/Documentation/firmware-guide/acpi/index.rst
> index 1c89888f6ee8..bedcb0b242a2 100644
> --- a/Documentation/firmware-guide/acpi/index.rst
> +++ b/Documentation/firmware-guide/acpi/index.rst
> @@ -14,3 +14,4 @@ ACPI Support
>     DSD-properties-rules
>     gpio-properties
>     i2c-muxes
> +   acpi-lid
> \ No newline at end of file



Thanks,
Mauro
