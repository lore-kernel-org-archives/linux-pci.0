Return-Path: <SRS0=Emu/=SZ=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90B2FC282DD
	for <linux-pci@archiver.kernel.org>; Tue, 23 Apr 2019 20:52:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D073218D3
	for <linux-pci@archiver.kernel.org>; Tue, 23 Apr 2019 20:52:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556052770;
	bh=lcVX20YUk30I7RF1Dg3DydURR7WnBjG2OqtgB0CkRKU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=wWKVYs+kLej60wn0J0iWhd0lsSmnX7AjOv8K91rfh78E/zFk2JuoIi5ji+V7vdmyv
	 xE19iY0nKxEeKfzEI+rxR96ieM2YDzPKxDvgv6hbsquUYRPvZOTk8eilN+pp+J3u6o
	 D1diMJfi3tfNmxsb0lFf+YHlIoV2SXE2VXQEUfMU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727838AbfDWUwn (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 23 Apr 2019 16:52:43 -0400
Received: from casper.infradead.org ([85.118.1.10]:36738 "EHLO
        casper.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727801AbfDWUwm (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 23 Apr 2019 16:52:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:From:Date:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=pUj6taDIDIX0RwWhLgs2VmMdHzD1AwNqbDMCZDMkgjo=; b=ZA+VPq/OfG7JGQOlhB0otLmSjU
        pxIdeZlXcxMo5sk8LvrMboM239nMcoTE4fzzwVWT8SKvl/PbN+owRzF9A0oSdS2TGFCKXaf5p9Mpu
        ixoi6eqN/j6myx8I0qHD8mYT13ABhceHWSSbWFN3PbXBczM/wAg8WGofbKFMv2Vs/snm7eS2M+oXb
        ljewuZrhOjWa3EyZK9aHbv7ojDuFbIaKx9+77GqSez10U3778Z9JO2GoA4s7us6K4Snh09A/VCaRZ
        K+4rcKJ/0BuOhvPqCavkFFleswKn/P4VioNuotmX+g5Ejt9BDu8thcY0L4EpP5UtysQQxzd/d43YS
        R7h+PBYg==;
Received: from 177.17.136.231.dynamic.adsl.gvt.net.br ([177.17.136.231] helo=coco.lan)
        by casper.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hJ2P8-0002xc-2x; Tue, 23 Apr 2019 20:52:38 +0000
Date:   Tue, 23 Apr 2019 17:52:31 -0300
From:   Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To:     Changbin Du <changbin.du@gmail.com>, mingo@redhat.com,
        x86@kernel.org, fenghua.yu@intel.com,
        linuxppc-dev@lists.ozlabs.org, linux-acpi@vger.kernel.org
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Bjorn Helgaas <bhelgaas@google.com>, rjw@rjwysocki.net,
        linux-pci@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, tglx@linutronix.de,
        linux-gpio@vger.kernel.org
Subject: Re: [PATCH v4 07/63] Documentation: ACPI: move
 DSD-properties-rules.txt to firmware-guide/acpi and covert to reST
Message-ID: <20190423175231.371be9ef@coco.lan>
In-Reply-To: <20190423162932.21428-8-changbin.du@gmail.com>
References: <20190423162932.21428-1-changbin.du@gmail.com>
        <20190423162932.21428-8-changbin.du@gmail.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Em Wed, 24 Apr 2019 00:28:36 +0800
Changbin Du <changbin.du@gmail.com> escreveu:

> This converts the plain text documentation to reStructuredText format and
> add it to Sphinx TOC tree. No essential content change.
> 
> Signed-off-by: Changbin Du <changbin.du@gmail.com>

For the conversion itself:

Reviewed-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>

> ---
>  .../acpi/DSD-properties-rules.rst}            | 21 +++++++++++--------
>  Documentation/firmware-guide/acpi/index.rst   |  1 +
>  2 files changed, 13 insertions(+), 9 deletions(-)
>  rename Documentation/{acpi/DSD-properties-rules.txt => firmware-guide/acpi/DSD-properties-rules.rst} (88%)
> 
> diff --git a/Documentation/acpi/DSD-properties-rules.txt b/Documentation/firmware-guide/acpi/DSD-properties-rules.rst
> similarity index 88%
> rename from Documentation/acpi/DSD-properties-rules.txt
> rename to Documentation/firmware-guide/acpi/DSD-properties-rules.rst
> index 3e4862bdad98..4306f29b6103 100644
> --- a/Documentation/acpi/DSD-properties-rules.txt
> +++ b/Documentation/firmware-guide/acpi/DSD-properties-rules.rst
> @@ -1,8 +1,11 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +
> +==================================
>  _DSD Device Properties Usage Rules
> -----------------------------------
> +==================================
>  
>  Properties, Property Sets and Property Subsets
> -----------------------------------------------
> +==============================================
>  
>  The _DSD (Device Specific Data) configuration object, introduced in ACPI 5.1,
>  allows any type of device configuration data to be provided via the ACPI
> @@ -18,7 +21,7 @@ specific type) associated with it.
>  
>  In the ACPI _DSD context it is an element of the sub-package following the
>  generic Device Properties UUID in the _DSD return package as specified in the
> -Device Properties UUID definition document [1].
> +Device Properties UUID definition document [1]_.
>  
>  It also may be regarded as the definition of a key and the associated data type
>  that can be returned by _DSD in the Device Properties UUID sub-package for a
> @@ -33,14 +36,14 @@ Property subsets are nested collections of properties.  Each of them is
>  associated with an additional key (name) allowing the subset to be referred
>  to as a whole (and to be treated as a separate entity).  The canonical
>  representation of property subsets is via the mechanism specified in the
> -Hierarchical Properties Extension UUID definition document [2].
> +Hierarchical Properties Extension UUID definition document [2]_.
>  
>  Property sets may be hierarchical.  That is, a property set may contain
>  multiple property subsets that each may contain property subsets of its
>  own and so on.
>  
>  General Validity Rule for Property Sets
> ----------------------------------------
> +=======================================
>  
>  Valid property sets must follow the guidance given by the Device Properties UUID
>  definition document [1].
> @@ -73,7 +76,7 @@ suitable for the ACPI environment and consequently they cannot belong to a valid
>  property set.
>  
>  Property Sets and Device Tree Bindings
> ---------------------------------------
> +======================================
>  
>  It often is useful to make _DSD return property sets that follow Device Tree
>  bindings.
> @@ -91,7 +94,7 @@ expected to automatically work in the ACPI environment regardless of their
>  contents.
>  
>  References
> -----------
> +==========
>  
> -[1] http://www.uefi.org/sites/default/files/resources/_DSD-device-properties-UUID.pdf
> -[2] http://www.uefi.org/sites/default/files/resources/_DSD-hierarchical-data-extension-UUID-v1.1.pdf
> +.. [1] http://www.uefi.org/sites/default/files/resources/_DSD-device-properties-UUID.pdf
> +.. [2] http://www.uefi.org/sites/default/files/resources/_DSD-hierarchical-data-extension-UUID-v1.1.pdf
> diff --git a/Documentation/firmware-guide/acpi/index.rst b/Documentation/firmware-guide/acpi/index.rst
> index 868bd25a3398..0e05b843521c 100644
> --- a/Documentation/firmware-guide/acpi/index.rst
> +++ b/Documentation/firmware-guide/acpi/index.rst
> @@ -10,3 +10,4 @@ ACPI Support
>     namespace
>     enumeration
>     osi
> +   DSD-properties-rules



Thanks,
Mauro
