Return-Path: <SRS0=9smm=S2=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E001C10F11
	for <linux-pci@archiver.kernel.org>; Wed, 24 Apr 2019 16:29:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E24521903
	for <linux-pci@archiver.kernel.org>; Wed, 24 Apr 2019 16:29:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WPHf3Y/7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731419AbfDXQ3D (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 24 Apr 2019 12:29:03 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:43369 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731052AbfDXQ3D (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 24 Apr 2019 12:29:03 -0400
Received: by mail-pl1-f193.google.com with SMTP id n8so9532337plp.10;
        Wed, 24 Apr 2019 09:29:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=bLys31l9/HtR0gSevCJUcFGbrOQgpnbHMIJ7q+iNcKM=;
        b=WPHf3Y/7518X8OjGmk4kJociHicUHvLs2E4FxrqicWsFy+5TqJE0QPVvblv8VV5+Mb
         Ydcx8kHryc0xpPfkYESaKs3rmTW4/F6jPoNLJ1ASYfvgMJuG9CgVcObxs+hRiqJqACX/
         E6SCA7DTaf5jVXASiyS9myYJ+bc0P5Dq9LfksMQEXzb2MUIKM4RvqAPxXSTVAhbdz3lR
         SH1iudRJbfOxoysIV3j0Xvvw+tv4BiEPHF1khDtveZOn5or4JiQinecNhbspuAizXfWT
         UFL5IgCGRLcmFwhd7VoZAceUxFA4u4P/LvZcKAbIURyb2oNKLAQhqQYFiy9P5wa/ojqe
         1L7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=bLys31l9/HtR0gSevCJUcFGbrOQgpnbHMIJ7q+iNcKM=;
        b=MewTfcViYVDgIo7p5670hLrkid3iQISc0tWMDZ5RCKIzuK1ib0GOts4aW7j3y6UoCP
         jq0E1/dl2rTDLzYH39YoF/5ZPZ7J/gpk6EzMf1qaA9eQOt/4tVDZtGloiLLz+UaBUVtn
         n7gPBJQPXoGNpQDK4MgK4OEbFqOdLc4fIz72cAFJ/1O+XHQ0x4Prxls73YmRxV+eD+uT
         FLU249c9o4dz5xr/lutx3n7qfgx4mQWEx9zEl/iGrD78gd+lHIj2IkuKz1iP+AJ3pQyr
         ykTrA8a7sOHoNoi0dHgYaGObvmthq2GvRip9SYuTJWrTei4f05rUZSwChzkckpB5869C
         eDlQ==
X-Gm-Message-State: APjAAAV7WHZ6cpHRREKSINtZiW7znKpD9M/AalbPdsknAleH1XvhC39C
        Voh7CtjdW/Ct+WjCQGQT7jM=
X-Google-Smtp-Source: APXvYqwj+rqVJqgkKSSbm/Y6GPhTx3Zab9/YFe5dPtrynatM62gMCQNeimm/qan4G1XP9IaiY+yr1A==
X-Received: by 2002:a17:902:9a0c:: with SMTP id v12mr33970161plp.184.1556123342275;
        Wed, 24 Apr 2019 09:29:02 -0700 (PDT)
Received: from mail.google.com ([104.238.181.70])
        by smtp.gmail.com with ESMTPSA id m131sm45156279pga.3.2019.04.24.09.28.55
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 24 Apr 2019 09:29:01 -0700 (PDT)
Date:   Thu, 25 Apr 2019 00:28:52 +0800
From:   Changbin Du <changbin.du@gmail.com>
To:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Cc:     Changbin Du <changbin.du@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Bjorn Helgaas <bhelgaas@google.com>, rjw@rjwysocki.net,
        linux-pci@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, tglx@linutronix.de, mingo@redhat.com,
        x86@kernel.org, fenghua.yu@intel.com,
        linuxppc-dev@lists.ozlabs.org, linux-acpi@vger.kernel.org,
        linux-gpio@vger.kernel.org
Subject: Re: [PATCH v4 09/63] Documentation: ACPI: move
 method-customizing.txt to firmware-guide/acpi and convert to reST
Message-ID: <20190424162850.g5ripuixdkvvzsjm@mail.google.com>
References: <20190423162932.21428-1-changbin.du@gmail.com>
 <20190423162932.21428-10-changbin.du@gmail.com>
 <20190423180316.7f042bc4@coco.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190423180316.7f042bc4@coco.lan>
User-Agent: NeoMutt/20180716
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Apr 23, 2019 at 06:03:16PM -0300, Mauro Carvalho Chehab wrote:
> Em Wed, 24 Apr 2019 00:28:38 +0800
> Changbin Du <changbin.du@gmail.com> escreveu:
> 
> > This converts the plain text documentation to reStructuredText format and
> > add it to Sphinx TOC tree. No essential content change.
> > 
> > Signed-off-by: Changbin Du <changbin.du@gmail.com>
> > ---
> >  Documentation/acpi/method-customizing.txt     | 73 -----------------
> >  Documentation/firmware-guide/acpi/index.rst   |  3 +-
> >  .../acpi/method-customizing.rst               | 82 +++++++++++++++++++
> >  3 files changed, 84 insertions(+), 74 deletions(-)
> >  delete mode 100644 Documentation/acpi/method-customizing.txt
> >  create mode 100644 Documentation/firmware-guide/acpi/method-customizing.rst
> > 
> > diff --git a/Documentation/acpi/method-customizing.txt b/Documentation/acpi/method-customizing.txt
> > deleted file mode 100644
> > index 7235da975f23..000000000000
> > --- a/Documentation/acpi/method-customizing.txt
> > +++ /dev/null
> > @@ -1,73 +0,0 @@
> > -Linux ACPI Custom Control Method How To
> > -=======================================
> > -
> > -Written by Zhang Rui <rui.zhang@intel.com>
> > -
> > -
> > -Linux supports customizing ACPI control methods at runtime.
> > -
> > -Users can use this to
> > -1. override an existing method which may not work correctly,
> > -   or just for debugging purposes.
> > -2. insert a completely new method in order to create a missing
> > -   method such as _OFF, _ON, _STA, _INI, etc.
> > -For these cases, it is far simpler to dynamically install a single
> > -control method rather than override the entire DSDT, because kernel
> > -rebuild/reboot is not needed and test result can be got in minutes.
> > -
> > -Note: Only ACPI METHOD can be overridden, any other object types like
> > -      "Device", "OperationRegion", are not recognized. Methods
> > -      declared inside scope operators are also not supported.
> > -Note: The same ACPI control method can be overridden for many times,
> > -      and it's always the latest one that used by Linux/kernel.
> > -Note: To get the ACPI debug object output (Store (AAAA, Debug)),
> > -      please run "echo 1 > /sys/module/acpi/parameters/aml_debug_output".
> > -
> > -1. override an existing method
> > -   a) get the ACPI table via ACPI sysfs I/F. e.g. to get the DSDT,
> > -      just run "cat /sys/firmware/acpi/tables/DSDT > /tmp/dsdt.dat"
> > -   b) disassemble the table by running "iasl -d dsdt.dat".
> > -   c) rewrite the ASL code of the method and save it in a new file,
> > -   d) package the new file (psr.asl) to an ACPI table format.
> > -      Here is an example of a customized \_SB._AC._PSR method,
> > -
> > -      DefinitionBlock ("", "SSDT", 1, "", "", 0x20080715)
> > -      {
> > -	Method (\_SB_.AC._PSR, 0, NotSerialized)
> > -	{
> > -		Store ("In AC _PSR", Debug)
> > -		Return (ACON)
> > -	}
> > -      }
> > -      Note that the full pathname of the method in ACPI namespace
> > -      should be used.
> > -   e) assemble the file to generate the AML code of the method.
> > -      e.g. "iasl -vw 6084 psr.asl" (psr.aml is generated as a result)
> > -      If parameter "-vw 6084" is not supported by your iASL compiler,
> > -      please try a newer version.
> > -   f) mount debugfs by "mount -t debugfs none /sys/kernel/debug"
> > -   g) override the old method via the debugfs by running
> > -      "cat /tmp/psr.aml > /sys/kernel/debug/acpi/custom_method"
> > -
> > -2. insert a new method
> > -   This is easier than overriding an existing method.
> > -   We just need to create the ASL code of the method we want to
> > -   insert and then follow the step c) ~ g) in section 1.
> > -
> > -3. undo your changes
> > -   The "undo" operation is not supported for a new inserted method
> > -   right now, i.e. we can not remove a method currently.
> > -   For an overridden method, in order to undo your changes, please
> > -   save a copy of the method original ASL code in step c) section 1,
> > -   and redo step c) ~ g) to override the method with the original one.
> > -
> > -
> > -Note: We can use a kernel with multiple custom ACPI method running,
> > -      But each individual write to debugfs can implement a SINGLE
> > -      method override. i.e. if we want to insert/override multiple
> > -      ACPI methods, we need to redo step c) ~ g) for multiple times.
> > -
> > -Note: Be aware that root can mis-use this driver to modify arbitrary
> > -      memory and gain additional rights, if root's privileges got
> > -      restricted (for example if root is not allowed to load additional
> > -      modules after boot).
> > diff --git a/Documentation/firmware-guide/acpi/index.rst b/Documentation/firmware-guide/acpi/index.rst
> > index 61d67763851b..d1d069b26bbc 100644
> > --- a/Documentation/firmware-guide/acpi/index.rst
> > +++ b/Documentation/firmware-guide/acpi/index.rst
> > @@ -10,5 +10,6 @@ ACPI Support
> >     namespace
> >     enumeration
> >     osi
> > +   method-customizing
> >     DSD-properties-rules
> > -   gpio-properties
> > +   gpio-properties
> > \ No newline at end of file
> > diff --git a/Documentation/firmware-guide/acpi/method-customizing.rst b/Documentation/firmware-guide/acpi/method-customizing.rst
> > new file mode 100644
> > index 000000000000..32eb1cdc1549
> > --- /dev/null
> > +++ b/Documentation/firmware-guide/acpi/method-customizing.rst
> > @@ -0,0 +1,82 @@
> > +.. SPDX-License-Identifier: GPL-2.0
> > +
> > +=======================================
> > +Linux ACPI Custom Control Method How To
> > +=======================================
> > +
> > +:Author: Zhang Rui <rui.zhang@intel.com>
> > +
> > +
> > +Linux supports customizing ACPI control methods at runtime.
> > +
> > +Users can use this to:
> > +
> > +1. override an existing method which may not work correctly,
> > +   or just for debugging purposes.
> > +2. insert a completely new method in order to create a missing
> > +   method such as _OFF, _ON, _STA, _INI, etc.
> > +
> > +For these cases, it is far simpler to dynamically install a single
> > +control method rather than override the entire DSDT, because kernel
> > +rebuild/reboot is not needed and test result can be got in minutes.
> > +
> > +.. note:: Only ACPI METHOD can be overridden, any other object types like
> > +   "Device", "OperationRegion", are not recognized. Methods
> > +   declared inside scope operators are also not supported.
> > +.. note:: The same ACPI control method can be overridden for many times,
> > +   and it's always the latest one that used by Linux/kernel.
> > +.. note:: To get the ACPI debug object output (Store (AAAA, Debug)),
> > +   please run "echo 1 > /sys/module/acpi/parameters/aml_debug_output".
> 
> Hmm... this may work (not sure if Sphinx would warn or not), but it
> is visually bad on text mode. I would code it, instead, with something 
> like:
> 
> .. note::
> 
>     - Only ACPI METHOD can be overridden, any other object types like
>       "Device", "OperationRegion", are not recognized. Methods
>       declared inside scope operators are also not supported.
> 
>     - The same ACPI control method can be overridden for many times,
>       and it's always the latest one that used by Linux/kernel.
> 
>     - To get the ACPI debug object output (Store (AAAA, Debug)),
>       please run::
> 
> 		echo 1 > /sys/module/acpi/parameters/aml_debug_output
> 
> As this would make it visually better on both text and html formats.
>
No warnings given. Your suggested style is better so applied it. Thanks!

> > +
> > +1. override an existing method
> > +==============================
> > +a) get the ACPI table via ACPI sysfs I/F. e.g. to get the DSDT,
> > +   just run "cat /sys/firmware/acpi/tables/DSDT > /tmp/dsdt.dat"
> > +b) disassemble the table by running "iasl -d dsdt.dat".
> > +c) rewrite the ASL code of the method and save it in a new file,
> > +d) package the new file (psr.asl) to an ACPI table format.
> > +   Here is an example of a customized \_SB._AC._PSR method::
> > +
> > +      DefinitionBlock ("", "SSDT", 1, "", "", 0x20080715)
> > +      {
> > +         Method (\_SB_.AC._PSR, 0, NotSerialized)
> > +         {
> > +            Store ("In AC _PSR", Debug)
> > +            Return (ACON)
> > +         }
> > +      }
> > +
> > +   Note that the full pathname of the method in ACPI namespace
> > +   should be used.
> > +e) assemble the file to generate the AML code of the method.
> > +   e.g. "iasl -vw 6084 psr.asl" (psr.aml is generated as a result)
> > +   If parameter "-vw 6084" is not supported by your iASL compiler,
> > +   please try a newer version.
> 
> I would use ``iasl -vw 6084 psr.asl`` and ``-vw 6084``.
> 
> > +f) mount debugfs by "mount -t debugfs none /sys/kernel/debug"
> 
> I would do:
> 
>    f) mount debugfs by running::
> 
> 	mount -t debugfs none /sys/kernel/debug
> 
> As it makes a better html document. I believe that the focus here is
> sysadmins. Doing the above makes easier for them to cut and paste
> commands.
> 
> > +g) override the old method via the debugfs by running
> > +   "cat /tmp/psr.aml > /sys/kernel/debug/acpi/custom_method"
> 
> Same applies here: I would also place the "cat" command on a literal
> block.
> 
> > +
> > +2. insert a new method
> > +======================
> > +This is easier than overriding an existing method.
> > +We just need to create the ASL code of the method we want to
> > +insert and then follow the step c) ~ g) in section 1.
> > +
> > +3. undo your changes
> > +====================
> > +The "undo" operation is not supported for a new inserted method
> > +right now, i.e. we can not remove a method currently.
> > +For an overridden method, in order to undo your changes, please
> > +save a copy of the method original ASL code in step c) section 1,
> > +and redo step c) ~ g) to override the method with the original one.
> > +
> > +
> > +.. note:: We can use a kernel with multiple custom ACPI method running,
> > +   But each individual write to debugfs can implement a SINGLE
> > +   method override. i.e. if we want to insert/override multiple
> > +   ACPI methods, we need to redo step c) ~ g) for multiple times.
> > +
> > +.. note:: Be aware that root can mis-use this driver to modify arbitrary
> > +   memory and gain additional rights, if root's privileges got
> > +   restricted (for example if root is not allowed to load additional
> > +   modules after boot).
> 
> Same comment as above: IMHO, having a single note block with the two
> notes would be better.
> 
> Thanks,
> Mauro

-- 
Cheers,
Changbin Du
