Return-Path: <SRS0=9smm=S2=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE2D7C10F11
	for <linux-pci@archiver.kernel.org>; Wed, 24 Apr 2019 14:28:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 81B3321904
	for <linux-pci@archiver.kernel.org>; Wed, 24 Apr 2019 14:28:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556116102;
	bh=gdiTxgSrvM7VAliEAL6+xGPf+CXu1bVngDXh+bvVXlY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=ZI4QOQur+E3o0lWKwnqpGLABjvm4fivwxqWk+L5ftLgtKD+liX66c3JArnRC4U9kc
	 B0XbC+mP8OTqDhgoiX45JlgHaGPNxErBEhYCCoHENuHmTM2ZapPVnPK87hIcufuQRQ
	 MldEOJFGIUxvX8hNLUCURRXexFNeqN4UZG/wQcv0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730555AbfDXO2R (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 24 Apr 2019 10:28:17 -0400
Received: from casper.infradead.org ([85.118.1.10]:44854 "EHLO
        casper.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726272AbfDXO2R (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 24 Apr 2019 10:28:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:From:Date:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=lUVNb3TmsW/vtX0F0HscDkeBpyLUTk7v8flKfNrAXD0=; b=uL5DzxJPoYFIKFZ7VcaGwTlgzd
        wEs2BErhwxpem3gRRBl2PeKvBJxrh+x1tJbpFOY+6FZOBlw3KTlyKH9zJCr1sMFl+M1lfrYJh8lZv
        oYkv+QCAT+Dnwcg8ChhslxzDmPb3bSIlsLFjbr3+XLXrknboi83PlBGUl3C5RFcx6uW1dZ1jB6HqW
        H4VGKr0OZwafRPN4zWYbn7ZhbBMZqT9QF0fWUxIKx/bn9u4AN4Z8HXqrQTZv2CKzPUM5zoPfILgjl
        E7V9kXnrFrZZzft8HBnIA1BbDoMCpEWj5J/3dplK4X4zmwFssUMwyzDxg+JVPq2m/5OoflLPMow2L
        gRDCUQGA==;
Received: from 177.17.136.231.dynamic.adsl.gvt.net.br ([177.17.136.231] helo=coco.lan)
        by casper.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hJIse-0007KR-Kk; Wed, 24 Apr 2019 14:28:13 +0000
Date:   Wed, 24 Apr 2019 11:28:06 -0300
From:   Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To:     Changbin Du <changbin.du@gmail.com>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Bjorn Helgaas <bhelgaas@google.com>, rjw@rjwysocki.net,
        linux-pci@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, tglx@linutronix.de, mingo@redhat.com,
        x86@kernel.org, fenghua.yu@intel.com,
        linuxppc-dev@lists.ozlabs.org, linux-acpi@vger.kernel.org,
        linux-gpio@vger.kernel.org
Subject: Re: [PATCH v4 18/63] Documentation: ACPI: move aml-debugger.txt to
 firmware-guide/acpi and convert to reST
Message-ID: <20190424112806.3581d0a4@coco.lan>
In-Reply-To: <20190423162932.21428-19-changbin.du@gmail.com>
References: <20190423162932.21428-1-changbin.du@gmail.com>
        <20190423162932.21428-19-changbin.du@gmail.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Em Wed, 24 Apr 2019 00:28:47 +0800
Changbin Du <changbin.du@gmail.com> escreveu:

> This converts the plain text documentation to reStructuredText format and
> add it to Sphinx TOC tree. No essential content change.
> 
> Signed-off-by: Changbin Du <changbin.du@gmail.com>

For the conversion changes:

Reviewed-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>

> ---
>  Documentation/acpi/aml-debugger.txt           | 66 ----------------
>  .../firmware-guide/acpi/aml-debugger.rst      | 75 +++++++++++++++++++
>  Documentation/firmware-guide/acpi/index.rst   |  1 +
>  3 files changed, 76 insertions(+), 66 deletions(-)
>  delete mode 100644 Documentation/acpi/aml-debugger.txt
>  create mode 100644 Documentation/firmware-guide/acpi/aml-debugger.rst
> 
> diff --git a/Documentation/acpi/aml-debugger.txt b/Documentation/acpi/aml-debugger.txt
> deleted file mode 100644
> index 75ebeb64ab29..000000000000
> --- a/Documentation/acpi/aml-debugger.txt
> +++ /dev/null
> @@ -1,66 +0,0 @@
> -The AML Debugger
> -
> -Copyright (C) 2016, Intel Corporation
> -Author: Lv Zheng <lv.zheng@intel.com>
> -
> -
> -This document describes the usage of the AML debugger embedded in the Linux
> -kernel.
> -
> -1. Build the debugger
> -
> -   The following kernel configuration items are required to enable the AML
> -   debugger interface from the Linux kernel:
> -
> -   CONFIG_ACPI_DEBUGGER=y
> -   CONFIG_ACPI_DEBUGGER_USER=m
> -
> -   The userspace utilities can be built from the kernel source tree using
> -   the following commands:
> -
> -   $ cd tools
> -   $ make acpi
> -
> -   The resultant userspace tool binary is then located at:
> -
> -     tools/power/acpi/acpidbg
> -
> -   It can be installed to system directories by running "make install" (as a
> -   sufficiently privileged user).
> -
> -2. Start the userspace debugger interface
> -
> -   After booting the kernel with the debugger built-in, the debugger can be
> -   started by using the following commands:
> -
> -   # mount -t debugfs none /sys/kernel/debug
> -   # modprobe acpi_dbg
> -   # tools/power/acpi/acpidbg
> -
> -   That spawns the interactive AML debugger environment where you can execute
> -   debugger commands.
> -
> -   The commands are documented in the "ACPICA Overview and Programmer Reference"
> -   that can be downloaded from
> -
> -   https://acpica.org/documentation
> -
> -   The detailed debugger commands reference is located in Chapter 12 "ACPICA
> -   Debugger Reference".  The "help" command can be used for a quick reference.
> -
> -3. Stop the userspace debugger interface
> -
> -   The interactive debugger interface can be closed by pressing Ctrl+C or using
> -   the "quit" or "exit" commands.  When finished, unload the module with:
> -
> -   # rmmod acpi_dbg
> -
> -   The module unloading may fail if there is an acpidbg instance running.
> -
> -4. Run the debugger in a script
> -
> -   It may be useful to run the AML debugger in a test script. "acpidbg" supports
> -   this in a special "batch" mode.  For example, the following command outputs
> -   the entire ACPI namespace:
> -
> -   # acpidbg -b "namespace"
> diff --git a/Documentation/firmware-guide/acpi/aml-debugger.rst b/Documentation/firmware-guide/acpi/aml-debugger.rst
> new file mode 100644
> index 000000000000..a889d43bc6c5
> --- /dev/null
> +++ b/Documentation/firmware-guide/acpi/aml-debugger.rst
> @@ -0,0 +1,75 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +.. include:: <isonum.txt>
> +
> +================
> +The AML Debugger
> +================
> +
> +:Copyright: |copy| 2016, Intel Corporation
> +:Author: Lv Zheng <lv.zheng@intel.com>
> +
> +
> +This document describes the usage of the AML debugger embedded in the Linux
> +kernel.
> +
> +1. Build the debugger
> +=====================
> +
> +The following kernel configuration items are required to enable the AML
> +debugger interface from the Linux kernel::
> +
> +   CONFIG_ACPI_DEBUGGER=y
> +   CONFIG_ACPI_DEBUGGER_USER=m
> +
> +The userspace utilities can be built from the kernel source tree using
> +the following commands::
> +
> +   $ cd tools
> +   $ make acpi
> +
> +The resultant userspace tool binary is then located at::
> +
> +   tools/power/acpi/acpidbg
> +
> +It can be installed to system directories by running "make install" (as a
> +sufficiently privileged user).
> +
> +2. Start the userspace debugger interface
> +=========================================
> +
> +After booting the kernel with the debugger built-in, the debugger can be
> +started by using the following commands::
> +
> +   # mount -t debugfs none /sys/kernel/debug
> +   # modprobe acpi_dbg
> +   # tools/power/acpi/acpidbg
> +
> +That spawns the interactive AML debugger environment where you can execute
> +debugger commands.
> +
> +The commands are documented in the "ACPICA Overview and Programmer Reference"
> +that can be downloaded from
> +
> +https://acpica.org/documentation
> +
> +The detailed debugger commands reference is located in Chapter 12 "ACPICA
> +Debugger Reference".  The "help" command can be used for a quick reference.
> +
> +3. Stop the userspace debugger interface
> +========================================
> +
> +The interactive debugger interface can be closed by pressing Ctrl+C or using
> +the "quit" or "exit" commands.  When finished, unload the module with::
> +
> +   # rmmod acpi_dbg
> +
> +The module unloading may fail if there is an acpidbg instance running.
> +
> +4. Run the debugger in a script
> +===============================
> +
> +It may be useful to run the AML debugger in a test script. "acpidbg" supports
> +this in a special "batch" mode.  For example, the following command outputs
> +the entire ACPI namespace::
> +
> +   # acpidbg -b "namespace"
> diff --git a/Documentation/firmware-guide/acpi/index.rst b/Documentation/firmware-guide/acpi/index.rst
> index 287a7cbd82ac..e9f253d54897 100644
> --- a/Documentation/firmware-guide/acpi/index.rst
> +++ b/Documentation/firmware-guide/acpi/index.rst
> @@ -16,6 +16,7 @@ ACPI Support
>     method-tracing
>     DSD-properties-rules
>     debug
> +   aml-debugger
>     gpio-properties
>     i2c-muxes
>     acpi-lid



Thanks,
Mauro
