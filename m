Return-Path: <SRS0=Emu/=SZ=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C29A2C10F03
	for <linux-pci@archiver.kernel.org>; Tue, 23 Apr 2019 21:03:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A1D6208E4
	for <linux-pci@archiver.kernel.org>; Tue, 23 Apr 2019 21:03:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556053408;
	bh=xTrlxiFOTcpXw70Kh5oQJFXQ1A2nKF096LMU8ZOfMtg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=SYqD0q6EC6onxA1FcDN2kAe/dG/VjCLpadxlHGxBfAoE3dfxUZ7ts5qUI892TYj7H
	 zBK2DICGEmClyPG/+ZWZbY1yzobyk600iaYIoXuSxH0mb7Umqi+0TyughWgjY3KvPA
	 v/UEK1Jpi6/IaaxGD9/FKImuHKwJR55V0yhnN3OA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726665AbfDWVD1 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 23 Apr 2019 17:03:27 -0400
Received: from casper.infradead.org ([85.118.1.10]:38030 "EHLO
        casper.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726339AbfDWVD1 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 23 Apr 2019 17:03:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:From:Date:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=ftW7TLTNQpZfmeqS9K+UZrXbuDtFKKdKPg+o6NCAUQc=; b=gt8/210/fBH2ZjMiPxig3YwhE+
        kNJQ3dDdJQ9Bv2lDlPO9j6cMXZ6hpGfYzUnzMf2WTDZkH3w5U2fOUB8trLORHEKyvvedSzG7g9+ns
        6qeBfW/As+BOI08P8/mq+2KeTiZo7IghFVj3sap2uSfQw9VcUO5a1AW97TRgEvhQoJvXVBYTHg4Sw
        EW2Blr2AiYqsHANg12/DKlbbQYuGZYprsDaM8E6TKtvjm/XZ+kA/hkRgcINwJVu6RBfZQ0NYPXsqM
        xI3iXujuIGV12TZ6Ew2+cCTknuknNS/mTKuRkL7/5sStaozd98+Ymg8JflJIPIBPxqVoN6Xdcs6qR
        AfW34lwQ==;
Received: from 177.17.136.231.dynamic.adsl.gvt.net.br ([177.17.136.231] helo=coco.lan)
        by casper.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hJ2ZW-0003YV-Hi; Tue, 23 Apr 2019 21:03:23 +0000
Date:   Tue, 23 Apr 2019 18:03:16 -0300
From:   Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To:     Changbin Du <changbin.du@gmail.com>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Bjorn Helgaas <bhelgaas@google.com>, rjw@rjwysocki.net,
        linux-pci@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, tglx@linutronix.de, mingo@redhat.com,
        x86@kernel.org, fenghua.yu@intel.com,
        linuxppc-dev@lists.ozlabs.org, linux-acpi@vger.kernel.org,
        linux-gpio@vger.kernel.org
Subject: Re: [PATCH v4 09/63] Documentation: ACPI: move
 method-customizing.txt to firmware-guide/acpi and convert to reST
Message-ID: <20190423180316.7f042bc4@coco.lan>
In-Reply-To: <20190423162932.21428-10-changbin.du@gmail.com>
References: <20190423162932.21428-1-changbin.du@gmail.com>
        <20190423162932.21428-10-changbin.du@gmail.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Em Wed, 24 Apr 2019 00:28:38 +0800
Changbin Du <changbin.du@gmail.com> escreveu:

> This converts the plain text documentation to reStructuredText format and
> add it to Sphinx TOC tree. No essential content change.
> 
> Signed-off-by: Changbin Du <changbin.du@gmail.com>
> ---
>  Documentation/acpi/method-customizing.txt     | 73 -----------------
>  Documentation/firmware-guide/acpi/index.rst   |  3 +-
>  .../acpi/method-customizing.rst               | 82 +++++++++++++++++++
>  3 files changed, 84 insertions(+), 74 deletions(-)
>  delete mode 100644 Documentation/acpi/method-customizing.txt
>  create mode 100644 Documentation/firmware-guide/acpi/method-customizing.rst
> 
> diff --git a/Documentation/acpi/method-customizing.txt b/Documentation/acpi/method-customizing.txt
> deleted file mode 100644
> index 7235da975f23..000000000000
> --- a/Documentation/acpi/method-customizing.txt
> +++ /dev/null
> @@ -1,73 +0,0 @@
> -Linux ACPI Custom Control Method How To
> -=======================================
> -
> -Written by Zhang Rui <rui.zhang@intel.com>
> -
> -
> -Linux supports customizing ACPI control methods at runtime.
> -
> -Users can use this to
> -1. override an existing method which may not work correctly,
> -   or just for debugging purposes.
> -2. insert a completely new method in order to create a missing
> -   method such as _OFF, _ON, _STA, _INI, etc.
> -For these cases, it is far simpler to dynamically install a single
> -control method rather than override the entire DSDT, because kernel
> -rebuild/reboot is not needed and test result can be got in minutes.
> -
> -Note: Only ACPI METHOD can be overridden, any other object types like
> -      "Device", "OperationRegion", are not recognized. Methods
> -      declared inside scope operators are also not supported.
> -Note: The same ACPI control method can be overridden for many times,
> -      and it's always the latest one that used by Linux/kernel.
> -Note: To get the ACPI debug object output (Store (AAAA, Debug)),
> -      please run "echo 1 > /sys/module/acpi/parameters/aml_debug_output".
> -
> -1. override an existing method
> -   a) get the ACPI table via ACPI sysfs I/F. e.g. to get the DSDT,
> -      just run "cat /sys/firmware/acpi/tables/DSDT > /tmp/dsdt.dat"
> -   b) disassemble the table by running "iasl -d dsdt.dat".
> -   c) rewrite the ASL code of the method and save it in a new file,
> -   d) package the new file (psr.asl) to an ACPI table format.
> -      Here is an example of a customized \_SB._AC._PSR method,
> -
> -      DefinitionBlock ("", "SSDT", 1, "", "", 0x20080715)
> -      {
> -	Method (\_SB_.AC._PSR, 0, NotSerialized)
> -	{
> -		Store ("In AC _PSR", Debug)
> -		Return (ACON)
> -	}
> -      }
> -      Note that the full pathname of the method in ACPI namespace
> -      should be used.
> -   e) assemble the file to generate the AML code of the method.
> -      e.g. "iasl -vw 6084 psr.asl" (psr.aml is generated as a result)
> -      If parameter "-vw 6084" is not supported by your iASL compiler,
> -      please try a newer version.
> -   f) mount debugfs by "mount -t debugfs none /sys/kernel/debug"
> -   g) override the old method via the debugfs by running
> -      "cat /tmp/psr.aml > /sys/kernel/debug/acpi/custom_method"
> -
> -2. insert a new method
> -   This is easier than overriding an existing method.
> -   We just need to create the ASL code of the method we want to
> -   insert and then follow the step c) ~ g) in section 1.
> -
> -3. undo your changes
> -   The "undo" operation is not supported for a new inserted method
> -   right now, i.e. we can not remove a method currently.
> -   For an overridden method, in order to undo your changes, please
> -   save a copy of the method original ASL code in step c) section 1,
> -   and redo step c) ~ g) to override the method with the original one.
> -
> -
> -Note: We can use a kernel with multiple custom ACPI method running,
> -      But each individual write to debugfs can implement a SINGLE
> -      method override. i.e. if we want to insert/override multiple
> -      ACPI methods, we need to redo step c) ~ g) for multiple times.
> -
> -Note: Be aware that root can mis-use this driver to modify arbitrary
> -      memory and gain additional rights, if root's privileges got
> -      restricted (for example if root is not allowed to load additional
> -      modules after boot).
> diff --git a/Documentation/firmware-guide/acpi/index.rst b/Documentation/firmware-guide/acpi/index.rst
> index 61d67763851b..d1d069b26bbc 100644
> --- a/Documentation/firmware-guide/acpi/index.rst
> +++ b/Documentation/firmware-guide/acpi/index.rst
> @@ -10,5 +10,6 @@ ACPI Support
>     namespace
>     enumeration
>     osi
> +   method-customizing
>     DSD-properties-rules
> -   gpio-properties
> +   gpio-properties
> \ No newline at end of file
> diff --git a/Documentation/firmware-guide/acpi/method-customizing.rst b/Documentation/firmware-guide/acpi/method-customizing.rst
> new file mode 100644
> index 000000000000..32eb1cdc1549
> --- /dev/null
> +++ b/Documentation/firmware-guide/acpi/method-customizing.rst
> @@ -0,0 +1,82 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +
> +=======================================
> +Linux ACPI Custom Control Method How To
> +=======================================
> +
> +:Author: Zhang Rui <rui.zhang@intel.com>
> +
> +
> +Linux supports customizing ACPI control methods at runtime.
> +
> +Users can use this to:
> +
> +1. override an existing method which may not work correctly,
> +   or just for debugging purposes.
> +2. insert a completely new method in order to create a missing
> +   method such as _OFF, _ON, _STA, _INI, etc.
> +
> +For these cases, it is far simpler to dynamically install a single
> +control method rather than override the entire DSDT, because kernel
> +rebuild/reboot is not needed and test result can be got in minutes.
> +
> +.. note:: Only ACPI METHOD can be overridden, any other object types like
> +   "Device", "OperationRegion", are not recognized. Methods
> +   declared inside scope operators are also not supported.
> +.. note:: The same ACPI control method can be overridden for many times,
> +   and it's always the latest one that used by Linux/kernel.
> +.. note:: To get the ACPI debug object output (Store (AAAA, Debug)),
> +   please run "echo 1 > /sys/module/acpi/parameters/aml_debug_output".

Hmm... this may work (not sure if Sphinx would warn or not), but it
is visually bad on text mode. I would code it, instead, with something 
like:

.. note::

    - Only ACPI METHOD can be overridden, any other object types like
      "Device", "OperationRegion", are not recognized. Methods
      declared inside scope operators are also not supported.

    - The same ACPI control method can be overridden for many times,
      and it's always the latest one that used by Linux/kernel.

    - To get the ACPI debug object output (Store (AAAA, Debug)),
      please run::

		echo 1 > /sys/module/acpi/parameters/aml_debug_output

As this would make it visually better on both text and html formats.

> +
> +1. override an existing method
> +==============================
> +a) get the ACPI table via ACPI sysfs I/F. e.g. to get the DSDT,
> +   just run "cat /sys/firmware/acpi/tables/DSDT > /tmp/dsdt.dat"
> +b) disassemble the table by running "iasl -d dsdt.dat".
> +c) rewrite the ASL code of the method and save it in a new file,
> +d) package the new file (psr.asl) to an ACPI table format.
> +   Here is an example of a customized \_SB._AC._PSR method::
> +
> +      DefinitionBlock ("", "SSDT", 1, "", "", 0x20080715)
> +      {
> +         Method (\_SB_.AC._PSR, 0, NotSerialized)
> +         {
> +            Store ("In AC _PSR", Debug)
> +            Return (ACON)
> +         }
> +      }
> +
> +   Note that the full pathname of the method in ACPI namespace
> +   should be used.
> +e) assemble the file to generate the AML code of the method.
> +   e.g. "iasl -vw 6084 psr.asl" (psr.aml is generated as a result)
> +   If parameter "-vw 6084" is not supported by your iASL compiler,
> +   please try a newer version.

I would use ``iasl -vw 6084 psr.asl`` and ``-vw 6084``.

> +f) mount debugfs by "mount -t debugfs none /sys/kernel/debug"

I would do:

   f) mount debugfs by running::

	mount -t debugfs none /sys/kernel/debug

As it makes a better html document. I believe that the focus here is
sysadmins. Doing the above makes easier for them to cut and paste
commands.

> +g) override the old method via the debugfs by running
> +   "cat /tmp/psr.aml > /sys/kernel/debug/acpi/custom_method"

Same applies here: I would also place the "cat" command on a literal
block.

> +
> +2. insert a new method
> +======================
> +This is easier than overriding an existing method.
> +We just need to create the ASL code of the method we want to
> +insert and then follow the step c) ~ g) in section 1.
> +
> +3. undo your changes
> +====================
> +The "undo" operation is not supported for a new inserted method
> +right now, i.e. we can not remove a method currently.
> +For an overridden method, in order to undo your changes, please
> +save a copy of the method original ASL code in step c) section 1,
> +and redo step c) ~ g) to override the method with the original one.
> +
> +
> +.. note:: We can use a kernel with multiple custom ACPI method running,
> +   But each individual write to debugfs can implement a SINGLE
> +   method override. i.e. if we want to insert/override multiple
> +   ACPI methods, we need to redo step c) ~ g) for multiple times.
> +
> +.. note:: Be aware that root can mis-use this driver to modify arbitrary
> +   memory and gain additional rights, if root's privileges got
> +   restricted (for example if root is not allowed to load additional
> +   modules after boot).

Same comment as above: IMHO, having a single note block with the two
notes would be better.

Thanks,
Mauro
