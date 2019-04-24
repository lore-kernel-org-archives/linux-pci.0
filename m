Return-Path: <SRS0=9smm=S2=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1FEBC282CE
	for <linux-pci@archiver.kernel.org>; Wed, 24 Apr 2019 17:44:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9333521902
	for <linux-pci@archiver.kernel.org>; Wed, 24 Apr 2019 17:44:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556127866;
	bh=Q6j80x8/4uhpo/6hv4x5GFIjz6ad91JdGUnBNg3cZ1E=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=RiPLEfHRtg2hd7hNU/XfXx0JAv0T6Qfh0OEpWWvoLsGJ3x+RQkhkK3ylxNQ3gf7wr
	 ml/rrbU/GoML8DR9cA4/F+l7VEYhv2R+CE7lklYBC1eldgcQvZ+eXLsMmOxYyPhRs6
	 wsHfJPk0pHCtHx6IVFBEr2rvAqyqVoeZpa4ayB5U=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391734AbfDXRoU (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 24 Apr 2019 13:44:20 -0400
Received: from casper.infradead.org ([85.118.1.10]:44808 "EHLO
        casper.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388298AbfDXRoT (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 24 Apr 2019 13:44:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:From:Date:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=4nPrb4b1fctyA9GKT2FbXo1a//Gl3EwNcd34pdkl0oM=; b=lZtzl45o9myzN34Q//zkdayhyZ
        pvdcM9q7wIJRCsFHmZxaJNHLVctQOVpep0V/uco7pGbkbkwsr7Xq59eDbpsLLP2t/O8zhbHpWNU8N
        icmZ/ZCJ7CkCWwm9NLfmryRdxA6j87syDNe4PXh4TYj0CDUK5uFbASE2dAjljSLou0Ub8zDIz6FuO
        CaDmC5sQEhbJxiDI7u776Jbf45zzOOjc+WrKpDp5HtUSgrTtUH5ejPaRQ7g8wBJXcoSczRtmwGWj+
        rnwlvBwVH2UxKSlI72LCkA41fj18oEPhSqU38xRKHrb9InM5amL5ewoDfi3wzgudXI2MXC8uzvLwU
        InvdBZ1Q==;
Received: from 177.17.136.231.dynamic.adsl.gvt.net.br ([177.17.136.231] helo=coco.lan)
        by casper.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hJLwL-0008O3-V6; Wed, 24 Apr 2019 17:44:14 +0000
Date:   Wed, 24 Apr 2019 14:44:07 -0300
From:   Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To:     Changbin Du <changbin.du@gmail.com>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Bjorn Helgaas <bhelgaas@google.com>, rjw@rjwysocki.net,
        linux-pci@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, tglx@linutronix.de, mingo@redhat.com,
        x86@kernel.org, fenghua.yu@intel.com,
        linuxppc-dev@lists.ozlabs.org, linux-acpi@vger.kernel.org,
        linux-gpio@vger.kernel.org
Subject: Re: [PATCH v4 39/63] Documentation: x86: convert topology.txt to
 reST
Message-ID: <20190424144407.0df2c2f5@coco.lan>
In-Reply-To: <20190423162932.21428-40-changbin.du@gmail.com>
References: <20190423162932.21428-1-changbin.du@gmail.com>
        <20190423162932.21428-40-changbin.du@gmail.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Em Wed, 24 Apr 2019 00:29:08 +0800
Changbin Du <changbin.du@gmail.com> escreveu:

> This converts the plain text documentation to reStructuredText format and
> add it to Sphinx TOC tree. No essential content change.
> 
> Signed-off-by: Changbin Du <changbin.du@gmail.com>
> ---
>  Documentation/x86/index.rst    |   1 +
>  Documentation/x86/topology.rst | 228 +++++++++++++++++++++++++++++++++
>  Documentation/x86/topology.txt | 217 -------------------------------
>  3 files changed, 229 insertions(+), 217 deletions(-)
>  create mode 100644 Documentation/x86/topology.rst
>  delete mode 100644 Documentation/x86/topology.txt

Why? Please preserve as much as possible from the original file...
it is really hard to see what you're doing. Most of those x86
files are already almost at ReST format (like this one). There's
absolutely **no reason** why you would do so much radical changes
that would below the 50% similarity threshold that would make git
to recognize as a change on the same file!

I'll give a quick review on this one, but it is really hard to be
sure that something is missing, when the similarity is too low.

> 
> diff --git a/Documentation/x86/index.rst b/Documentation/x86/index.rst
> index 8f08caf4fbbb..2033791e53bc 100644
> --- a/Documentation/x86/index.rst
> +++ b/Documentation/x86/index.rst
> @@ -9,3 +9,4 @@ Linux x86 Support
>     :numbered:
>  
>     boot
> +   topology
> diff --git a/Documentation/x86/topology.rst b/Documentation/x86/topology.rst
> new file mode 100644
> index 000000000000..1df5f56f4882
> --- /dev/null
> +++ b/Documentation/x86/topology.rst
> @@ -0,0 +1,228 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +
> +============
> +x86 Topology
> +============
> +
> +This documents and clarifies the main aspects of x86 topology modelling and
> +representation in the kernel. Update/change when doing changes to the
> +respective code.
> +
> +The architecture-agnostic topology definitions are in
> +Documentation/cputopology.txt. This file holds x86-specific
> +differences/specialities which must not necessarily apply to the generic
> +definitions. Thus, the way to read up on Linux topology on x86 is to start
> +with the generic one and look at this one in parallel for the x86 specifics.
> +
> +Needless to say, code should use the generic functions - this file is *only*
> +here to *document* the inner workings of x86 topology.
> +
> +Started by Thomas Gleixner <tglx@linutronix.de> and Borislav Petkov <bp@alien8.de>.
> +
> +The main aim of the topology facilities is to present adequate interfaces to
> +code which needs to know/query/use the structure of the running system wrt
> +threads, cores, packages, etc.
> +
> +The kernel does not care about the concept of physical sockets because a
> +socket has no relevance to software. It's an electromechanical component. In
> +the past a socket always contained a single package (see below), but with the
> +advent of Multi Chip Modules (MCM) a socket can hold more than one package. So
> +there might be still references to sockets in the code, but they are of
> +historical nature and should be cleaned up.
> +
> +The topology of a system is described in the units of:
> +
> +    - packages
> +    - cores
> +    - threads 
> +
> +Package
> +=======
> +
> +Packages contain a number of cores plus shared resources, e.g. DRAM
> +controller, shared caches etc.
> +
> +AMD nomenclature for package is 'Node'.
> +
> +Package-related topology information in the kernel:
> +
> +  - cpuinfo_x86.x86_max_cores:
> +
> +    The number of cores in a package. This information is retrieved via CPUID.
> +
> +  - cpuinfo_x86.phys_proc_id:
> +
> +    The physical ID of the package. This information is retrieved via CPUID
> +    and deduced from the APIC IDs of the cores in the package.
> +
> +  - cpuinfo_x86.logical_id:
> +
> +    The logical ID of the package. As we do not trust BIOSes to enumerate the
> +    packages in a consistent way, we introduced the concept of logical package
> +    ID so we can sanely calculate the number of maximum possible packages in
> +    the system and have the packages enumerated linearly.
> +
> +  - topology_max_packages():
> +
> +    The maximum possible number of packages in the system. Helpful for per
> +    package facilities to preallocate per package information.
> +
> +  - cpu_llc_id:
> +
> +    A per-CPU variable containing:
> +
> +    - On Intel, the first APIC ID of the list of CPUs sharing the Last Level
> +      Cache.
> +
> +    - On AMD, the Node ID or Core Complex ID containing the Last Level
> +      Cache. In general, it is a number identifying an LLC uniquely on the
> +      system.
> +
> +Cores
> +=====
> +
> +A core consists of 1 or more threads. It does not matter whether the threads
> +are SMT- or CMT-type threads.
> +
> +AMDs nomenclature for a CMT core is "Compute Unit". The kernel always uses
> +"core".
> +
> +Core-related topology information in the kernel:
> +
> +  - smp_num_siblings:
> +
> +    The number of threads in a core. The number of threads in a package can be
> +    calculated by::
> +
> +      threads_per_package = cpuinfo_x86.x86_max_cores * smp_num_siblings
> +
> +
> +Threads
> +=======
> +
> +A thread is a single scheduling unit. It's the equivalent to a logical Linux
> +CPU.
> +
> +AMDs nomenclature for CMT threads is "Compute Unit Core". The kernel always
> +uses "thread".
> +
> +Thread-related topology information in the kernel:
> +
> +  - topology_core_cpumask():
> +
> +    The cpumask contains all online threads in the package to which a thread
> +    belongs.
> +
> +    The number of online threads is also printed in /proc/cpuinfo "siblings."
> +
> +  - topology_sibling_cpumask():
> +
> +    The cpumask contains all online threads in the core to which a thread
> +    belongs.
> +
> +  - topology_logical_package_id():
> +
> +    The logical package ID to which a thread belongs.
> +
> +  - topology_physical_package_id():
> +
> +    The physical package ID to which a thread belongs.
> +
> +  - topology_core_id();
> +
> +    The ID of the core to which a thread belongs. It is also printed in /proc/cpuinfo
> +    "core_id."
> +
> +
> +
> +System topology examples
> +========================
> +
> +.. note:: The alternative Linux CPU enumeration depends on how the BIOS
> +  enumerates the threads. Many BIOSes enumerate all threads 0 first and
> +  then all threads 1. That has the "advantage" that the logical Linux CPU
> +  numbers of threads 0 stay the same whether threads are enabled or not.
> +  That's merely an implementation detail and has no practical impact.
> +
> +1) Single Package, Single Core
> +::

I would just place the :: on the above line. Same applies to similar
cases on this file.

> +
> +   [package 0] -> [core 0] -> [thread 0] -> Linux CPU 0
> +
> +2) Single Package, Dual Core
> +
> +  a) One thread per core
> +  ::
> +
> +    [package 0] -> [core 0] -> [thread 0] -> Linux CPU 0
> +          -> [core 1] -> [thread 0] -> Linux CPU 1

Something got broken here.

> +
> +  b) Two threads per core
> +  ::
> +
> +    [package 0] -> [core 0] -> [thread 0] -> Linux CPU 0
> +          -> [thread 1] -> Linux CPU 1
> +          -> [core 1] -> [thread 0] -> Linux CPU 2
> +          -> [thread 1] -> Linux CPU 3

And here... This one, for example, should be, instead:

        [package 0] -> [core 0] -> [thread 0] -> Linux CPU 0
                                -> [thread 1] -> Linux CPU 1
                    -> [core 1] -> [thread 0] -> Linux CPU 2
                                -> [thread 1] -> Linux CPU 3

Clearly there's something that it is messing with tabs on your
x86 conversion.

I'll stop my review here, as it sounds pointless to review it,
as there are too many broken whitespace stuff on your
conversion.

Thanks,
Mauro
