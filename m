Return-Path: <SRS0=Emu/=SZ=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71D85C10F03
	for <linux-pci@archiver.kernel.org>; Tue, 23 Apr 2019 20:39:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3BF24218B0
	for <linux-pci@archiver.kernel.org>; Tue, 23 Apr 2019 20:39:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556051990;
	bh=AUwONfDFresshjHCjn4hRCS09hTB9aK1sF+yXRuOHyY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=UQM65ugaNre3LdIG+DPI2i/Dvl7D5whsaBkCgU6Ol9vZ04F8CMB7CxOurOvyp2eAL
	 jF83qU6w9vg3WDTkjufFOXd/1JPgSuiSue0rvRxcCC8NTholcnDrbzArN4mi2f4PmF
	 SbG+Fs3URWE3gAZedngMTHsPWmBOwXizQkIOsxac=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726969AbfDWUjt (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 23 Apr 2019 16:39:49 -0400
Received: from casper.infradead.org ([85.118.1.10]:35220 "EHLO
        casper.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726136AbfDWUjt (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 23 Apr 2019 16:39:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:From:Date:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=d5llYTJLQKvQnpfXJQfVyb9GlJxcOW18WOhBIq5ofzA=; b=lI4jOYawIKyAhJnm5WkrVuTjlB
        yAGrjefHLp3CelADnzyBomvy95S7R9vkMDGuFnlpNsynWsSgY2nTrREkGxpczUan5K9LZdKMdCXFQ
        aNO7BW2GSsTf4uxI4kkYgjLg/rArZgKnpYRh6XG0WUfuz1bmv6ooaqSxfV4lGU9XGE3JFc9fDNdu9
        wbQOhU+nSZQB9Yp58Tb1QUiHV79npPtjU3VHglgl2DzCDoNlRL2oHhlJlR9lMi0vUD4KpXLmFGunv
        JEU9idb9oD3wdqRDCp31JGUNZxZnUzHPFt3rRNUw/eZI2lQjnxo3vhk0OFUmbp7cCDuRpvzRl4h9U
        7coNh6fg==;
Received: from 177.17.136.231.dynamic.adsl.gvt.net.br ([177.17.136.231] helo=coco.lan)
        by casper.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hJ2Cf-0002Nu-Am; Tue, 23 Apr 2019 20:39:45 +0000
Date:   Tue, 23 Apr 2019 17:39:39 -0300
From:   Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To:     Changbin Du <changbin.du@gmail.com>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Bjorn Helgaas <bhelgaas@google.com>, rjw@rjwysocki.net,
        linux-pci@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, tglx@linutronix.de, mingo@redhat.com,
        x86@kernel.org, fenghua.yu@intel.com,
        linuxppc-dev@lists.ozlabs.org, linux-acpi@vger.kernel.org,
        linux-gpio@vger.kernel.org
Subject: Re: [PATCH v4 01/63] Documentation: add Linux ACPI to Sphinx TOC
 tree
Message-ID: <20190423173939.14246e98@coco.lan>
In-Reply-To: <20190423162932.21428-2-changbin.du@gmail.com>
References: <20190423162932.21428-1-changbin.du@gmail.com>
        <20190423162932.21428-2-changbin.du@gmail.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Em Wed, 24 Apr 2019 00:28:30 +0800
Changbin Du <changbin.du@gmail.com> escreveu:

> Add below index.rst files for ACPI subsystem. More docs will be added later.
>   o admin-guide/acpi/index.rst
>   o driver-api/acpi/index.rst
>   o firmware-guide/index.rst

Nice! you split it by usage.

Reviewed-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
> 
> Signed-off-by: Changbin Du <changbin.du@gmail.com>
> ---
>  Documentation/admin-guide/acpi/index.rst    | 10 ++++++++++
>  Documentation/admin-guide/index.rst         |  1 +
>  Documentation/driver-api/acpi/index.rst     |  7 +++++++
>  Documentation/driver-api/index.rst          |  1 +
>  Documentation/firmware-guide/acpi/index.rst |  9 +++++++++
>  Documentation/firmware-guide/index.rst      | 13 +++++++++++++
>  Documentation/index.rst                     | 10 ++++++++++
>  7 files changed, 51 insertions(+)
>  create mode 100644 Documentation/admin-guide/acpi/index.rst
>  create mode 100644 Documentation/driver-api/acpi/index.rst
>  create mode 100644 Documentation/firmware-guide/acpi/index.rst
>  create mode 100644 Documentation/firmware-guide/index.rst
> 
> diff --git a/Documentation/admin-guide/acpi/index.rst b/Documentation/admin-guide/acpi/index.rst
> new file mode 100644
> index 000000000000..3e041206089d
> --- /dev/null
> +++ b/Documentation/admin-guide/acpi/index.rst
> @@ -0,0 +1,10 @@
> +============
> +ACPI Support
> +============
> +
> +Here we document in detail how to interact with various mechanisms in
> +the Linux ACPI support.
> +
> +.. toctree::
> +   :maxdepth: 1
> +
> diff --git a/Documentation/admin-guide/index.rst b/Documentation/admin-guide/index.rst
> index 0a491676685e..5b8286fdd91b 100644
> --- a/Documentation/admin-guide/index.rst
> +++ b/Documentation/admin-guide/index.rst
> @@ -77,6 +77,7 @@ configure specific aspects of kernel behavior to your liking.
>     LSM/index
>     mm/index
>     perf-security
> +   acpi/index
>  
>  .. only::  subproject and html
>  
> diff --git a/Documentation/driver-api/acpi/index.rst b/Documentation/driver-api/acpi/index.rst
> new file mode 100644
> index 000000000000..898b0c60671a
> --- /dev/null
> +++ b/Documentation/driver-api/acpi/index.rst
> @@ -0,0 +1,7 @@
> +============
> +ACPI Support
> +============
> +
> +.. toctree::
> +   :maxdepth: 2
> +
> diff --git a/Documentation/driver-api/index.rst b/Documentation/driver-api/index.rst
> index c0b600ed9961..aa87075c7846 100644
> --- a/Documentation/driver-api/index.rst
> +++ b/Documentation/driver-api/index.rst
> @@ -56,6 +56,7 @@ available subsections can be seen below.
>     slimbus
>     soundwire/index
>     fpga/index
> +   acpi/index
>  
>  .. only::  subproject and html
>  
> diff --git a/Documentation/firmware-guide/acpi/index.rst b/Documentation/firmware-guide/acpi/index.rst
> new file mode 100644
> index 000000000000..0ec7d072ba22
> --- /dev/null
> +++ b/Documentation/firmware-guide/acpi/index.rst
> @@ -0,0 +1,9 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +
> +============
> +ACPI Support
> +============
> +
> +.. toctree::
> +   :maxdepth: 1
> +
> diff --git a/Documentation/firmware-guide/index.rst b/Documentation/firmware-guide/index.rst
> new file mode 100644
> index 000000000000..5355784ca0a2
> --- /dev/null
> +++ b/Documentation/firmware-guide/index.rst
> @@ -0,0 +1,13 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +
> +===============================
> +The Linux kernel firmware guide
> +===============================
> +
> +This section describes the ACPI subsystem in Linux from firmware perspective.
> +
> +.. toctree::
> +   :maxdepth: 1
> +
> +   acpi/index
> +
> diff --git a/Documentation/index.rst b/Documentation/index.rst
> index 80a421cb935e..fdfa85c56a50 100644
> --- a/Documentation/index.rst
> +++ b/Documentation/index.rst
> @@ -35,6 +35,16 @@ trying to get it to work optimally on a given system.
>  
>     admin-guide/index
>  
> +Firmware-related documentation
> +------------------------------
> +The following holds information on the kernel's expectations regarding the
> +platform firmwares.
> +
> +.. toctree::
> +   :maxdepth: 2
> +
> +   firmware-guide/index
> +
>  Application-developer documentation
>  -----------------------------------
>  



Thanks,
Mauro
