Return-Path: <SRS0=ROz5=S4=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04288C43218
	for <linux-pci@archiver.kernel.org>; Fri, 26 Apr 2019 14:24:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B4858208C4
	for <linux-pci@archiver.kernel.org>; Fri, 26 Apr 2019 14:24:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bNKjPJXY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726282AbfDZOYF (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 26 Apr 2019 10:24:05 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:46416 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726060AbfDZOYF (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 26 Apr 2019 10:24:05 -0400
Received: by mail-pf1-f196.google.com with SMTP id j11so1790713pff.13;
        Fri, 26 Apr 2019 07:24:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=8AQ2GkngH1De/6XzGohWoAVpJB2lelkaRG8sTS9mhMQ=;
        b=bNKjPJXYCcnMRb4CgyavROJDvz580E5qQgxUpn/9Mj6rjtE0rYaq0SxQoBgfO48vmk
         /VfzrOZ8ZN8qUeLoAGxLZORUANQ3JCesRjEORUbuogBqZk+YHD0xGKrJT/GoGnaToe4r
         kwbSTcZgXfi2jii8y2pKTvsBggAdJjkCsr0MaQw6K6c35I+nGHQzH3by0XgR8LUZxl36
         SEQDlRGZmg0vt2B8cihXYdTPvB+3iwfaOgZ6NnBjiv/E5HnhtZrNsUFX8CT4A3b4ZKgZ
         d3fhwF+uOta6W9nuvJxkbiNrEqTHqb6Z5QV0VzcQqypw2PTKlQwfL6YSN9c46hWTSdCy
         B88A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=8AQ2GkngH1De/6XzGohWoAVpJB2lelkaRG8sTS9mhMQ=;
        b=dmpQsIQDGt3hmq7VCF6Ab1NQy9bX5Y3oCdjosnmQ8yYNQjp4WrX3wi4evmZ4MKTX2Z
         NZ+erGdfOkGPxyYYQPA2TN6+xYFoUValqDiz0X3u0tgAfvkkEvda29bvYymLceg1Szf8
         wsJIsJSuF5RW0aOYHzDQhFPBy72Y9bWGWpFdob3W8klEEi9PM8c9DJoK2ni5uUKI9sdQ
         0fDRR19uSgpaUXiMj+DUuU9BKFVMGrpWIkwkK5uXG4785VO3f4t2KaEZJjqGul44XD4J
         l6TW8b8pOMjl/K+omcKzfdmsR5qAg1HEybkD1laYgbhXZoHwh/n/KaPLN6oeLpSyVdHm
         tZYg==
X-Gm-Message-State: APjAAAWc7iqVA40DahPy7e6AMMd6XiIAqPL8+sc3/o0T6DT9AGV2ZQx4
        yBw8m1KyblcHXpRNPTJKJM4=
X-Google-Smtp-Source: APXvYqzOhSS96XBS6//FlzBxLAJB7NizGmVPmh3diujylNVWoJ/k4w9X4288juAjaooqChU9jWEdcQ==
X-Received: by 2002:a65:4489:: with SMTP id l9mr42554893pgq.1.1556288643966;
        Fri, 26 Apr 2019 07:24:03 -0700 (PDT)
Received: from mail.google.com ([104.238.181.70])
        by smtp.gmail.com with ESMTPSA id e23sm35659131pfd.11.2019.04.26.07.23.57
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 26 Apr 2019 07:24:03 -0700 (PDT)
Date:   Fri, 26 Apr 2019 22:23:54 +0800
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
Subject: Re: [PATCH v4 39/63] Documentation: x86: convert topology.txt to reST
Message-ID: <20190426142352.dyrxkzrw6h7hgyv4@mail.google.com>
References: <20190423162932.21428-1-changbin.du@gmail.com>
 <20190423162932.21428-40-changbin.du@gmail.com>
 <20190424144407.0df2c2f5@coco.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190424144407.0df2c2f5@coco.lan>
User-Agent: NeoMutt/20180716
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Apr 24, 2019 at 02:44:07PM -0300, Mauro Carvalho Chehab wrote:
> Em Wed, 24 Apr 2019 00:29:08 +0800
> Changbin Du <changbin.du@gmail.com> escreveu:
> 
> > This converts the plain text documentation to reStructuredText format and
> > add it to Sphinx TOC tree. No essential content change.
> > 
> > Signed-off-by: Changbin Du <changbin.du@gmail.com>
> > ---
> >  Documentation/x86/index.rst    |   1 +
> >  Documentation/x86/topology.rst | 228 +++++++++++++++++++++++++++++++++
> >  Documentation/x86/topology.txt | 217 -------------------------------
> >  3 files changed, 229 insertions(+), 217 deletions(-)
> >  create mode 100644 Documentation/x86/topology.rst
> >  delete mode 100644 Documentation/x86/topology.txt
> 
> Why? Please preserve as much as possible from the original file...
> it is really hard to see what you're doing. Most of those x86
> files are already almost at ReST format (like this one). There's
> absolutely **no reason** why you would do so much radical changes
> that would below the 50% similarity threshold that would make git
> to recognize as a change on the same file!
>
My editor changed the indent. I need to redo this conversion. Thanks.

> I'll give a quick review on this one, but it is really hard to be
> sure that something is missing, when the similarity is too low.
> 
> > 
> > diff --git a/Documentation/x86/index.rst b/Documentation/x86/index.rst
> > index 8f08caf4fbbb..2033791e53bc 100644
> > --- a/Documentation/x86/index.rst
> > +++ b/Documentation/x86/index.rst
> > @@ -9,3 +9,4 @@ Linux x86 Support
> >     :numbered:
> >  
> >     boot
> > +   topology
> > diff --git a/Documentation/x86/topology.rst b/Documentation/x86/topology.rst
> > new file mode 100644
> > index 000000000000..1df5f56f4882
> > --- /dev/null
> > +++ b/Documentation/x86/topology.rst
> > @@ -0,0 +1,228 @@
> > +.. SPDX-License-Identifier: GPL-2.0
> > +
> > +============
> > +x86 Topology
> > +============
> > +
> > +This documents and clarifies the main aspects of x86 topology modelling and
> > +representation in the kernel. Update/change when doing changes to the
> > +respective code.
> > +
> > +The architecture-agnostic topology definitions are in
> > +Documentation/cputopology.txt. This file holds x86-specific
> > +differences/specialities which must not necessarily apply to the generic
> > +definitions. Thus, the way to read up on Linux topology on x86 is to start
> > +with the generic one and look at this one in parallel for the x86 specifics.
> > +
> > +Needless to say, code should use the generic functions - this file is *only*
> > +here to *document* the inner workings of x86 topology.
> > +
> > +Started by Thomas Gleixner <tglx@linutronix.de> and Borislav Petkov <bp@alien8.de>.
> > +
> > +The main aim of the topology facilities is to present adequate interfaces to
> > +code which needs to know/query/use the structure of the running system wrt
> > +threads, cores, packages, etc.
> > +
> > +The kernel does not care about the concept of physical sockets because a
> > +socket has no relevance to software. It's an electromechanical component. In
> > +the past a socket always contained a single package (see below), but with the
> > +advent of Multi Chip Modules (MCM) a socket can hold more than one package. So
> > +there might be still references to sockets in the code, but they are of
> > +historical nature and should be cleaned up.
> > +
> > +The topology of a system is described in the units of:
> > +
> > +    - packages
> > +    - cores
> > +    - threads 
> > +
> > +Package
> > +=======
> > +
> > +Packages contain a number of cores plus shared resources, e.g. DRAM
> > +controller, shared caches etc.
> > +
> > +AMD nomenclature for package is 'Node'.
> > +
> > +Package-related topology information in the kernel:
> > +
> > +  - cpuinfo_x86.x86_max_cores:
> > +
> > +    The number of cores in a package. This information is retrieved via CPUID.
> > +
> > +  - cpuinfo_x86.phys_proc_id:
> > +
> > +    The physical ID of the package. This information is retrieved via CPUID
> > +    and deduced from the APIC IDs of the cores in the package.
> > +
> > +  - cpuinfo_x86.logical_id:
> > +
> > +    The logical ID of the package. As we do not trust BIOSes to enumerate the
> > +    packages in a consistent way, we introduced the concept of logical package
> > +    ID so we can sanely calculate the number of maximum possible packages in
> > +    the system and have the packages enumerated linearly.
> > +
> > +  - topology_max_packages():
> > +
> > +    The maximum possible number of packages in the system. Helpful for per
> > +    package facilities to preallocate per package information.
> > +
> > +  - cpu_llc_id:
> > +
> > +    A per-CPU variable containing:
> > +
> > +    - On Intel, the first APIC ID of the list of CPUs sharing the Last Level
> > +      Cache.
> > +
> > +    - On AMD, the Node ID or Core Complex ID containing the Last Level
> > +      Cache. In general, it is a number identifying an LLC uniquely on the
> > +      system.
> > +
> > +Cores
> > +=====
> > +
> > +A core consists of 1 or more threads. It does not matter whether the threads
> > +are SMT- or CMT-type threads.
> > +
> > +AMDs nomenclature for a CMT core is "Compute Unit". The kernel always uses
> > +"core".
> > +
> > +Core-related topology information in the kernel:
> > +
> > +  - smp_num_siblings:
> > +
> > +    The number of threads in a core. The number of threads in a package can be
> > +    calculated by::
> > +
> > +      threads_per_package = cpuinfo_x86.x86_max_cores * smp_num_siblings
> > +
> > +
> > +Threads
> > +=======
> > +
> > +A thread is a single scheduling unit. It's the equivalent to a logical Linux
> > +CPU.
> > +
> > +AMDs nomenclature for CMT threads is "Compute Unit Core". The kernel always
> > +uses "thread".
> > +
> > +Thread-related topology information in the kernel:
> > +
> > +  - topology_core_cpumask():
> > +
> > +    The cpumask contains all online threads in the package to which a thread
> > +    belongs.
> > +
> > +    The number of online threads is also printed in /proc/cpuinfo "siblings."
> > +
> > +  - topology_sibling_cpumask():
> > +
> > +    The cpumask contains all online threads in the core to which a thread
> > +    belongs.
> > +
> > +  - topology_logical_package_id():
> > +
> > +    The logical package ID to which a thread belongs.
> > +
> > +  - topology_physical_package_id():
> > +
> > +    The physical package ID to which a thread belongs.
> > +
> > +  - topology_core_id();
> > +
> > +    The ID of the core to which a thread belongs. It is also printed in /proc/cpuinfo
> > +    "core_id."
> > +
> > +
> > +
> > +System topology examples
> > +========================
> > +
> > +.. note:: The alternative Linux CPU enumeration depends on how the BIOS
> > +  enumerates the threads. Many BIOSes enumerate all threads 0 first and
> > +  then all threads 1. That has the "advantage" that the logical Linux CPU
> > +  numbers of threads 0 stay the same whether threads are enabled or not.
> > +  That's merely an implementation detail and has no practical impact.
> > +
> > +1) Single Package, Single Core
> > +::
> 
> I would just place the :: on the above line. Same applies to similar
> cases on this file.
> 
Sure.

> > +
> > +   [package 0] -> [core 0] -> [thread 0] -> Linux CPU 0
> > +
> > +2) Single Package, Dual Core
> > +
> > +  a) One thread per core
> > +  ::
> > +
> > +    [package 0] -> [core 0] -> [thread 0] -> Linux CPU 0
> > +          -> [core 1] -> [thread 0] -> Linux CPU 1
> 
> Something got broken here.
> 
> > +
> > +  b) Two threads per core
> > +  ::
> > +
> > +    [package 0] -> [core 0] -> [thread 0] -> Linux CPU 0
> > +          -> [thread 1] -> Linux CPU 1
> > +          -> [core 1] -> [thread 0] -> Linux CPU 2
> > +          -> [thread 1] -> Linux CPU 3
> 
> And here... This one, for example, should be, instead:
> 
>         [package 0] -> [core 0] -> [thread 0] -> Linux CPU 0
>                                 -> [thread 1] -> Linux CPU 1
>                     -> [core 1] -> [thread 0] -> Linux CPU 2
>                                 -> [thread 1] -> Linux CPU 3
> 
> Clearly there's something that it is messing with tabs on your
> x86 conversion.
>
Sorry for such mistake. I will check them one by one.

> I'll stop my review here, as it sounds pointless to review it,
> as there are too many broken whitespace stuff on your
> conversion.
> 
> Thanks,
> Mauro

-- 
Cheers,
Changbin Du
