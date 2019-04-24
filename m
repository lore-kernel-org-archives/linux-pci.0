Return-Path: <SRS0=9smm=S2=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B6A9C10F11
	for <linux-pci@archiver.kernel.org>; Wed, 24 Apr 2019 16:26:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B3AC2148D
	for <linux-pci@archiver.kernel.org>; Wed, 24 Apr 2019 16:26:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556123207;
	bh=NzaKVv2DcPOsLUo4LaMy5Pf/YekOnnzrziJDLDWY24s=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=El0hrLMO+MKtMAh7yMGlq6qlkvYs4X246ptnJSJ2c0MgETDHjheqUg8bZDfjSbb4p
	 B9iGKUvx2gE/F/quT7F9fvPt91IZ/ieVS9GfyH5oFG6uCMtip1aYce0yAOi8yX9xG8
	 KSIjs8bFPJKhUnwG4zoMPrq7zTQDuwaEX8okNGEs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731189AbfDXQ0q (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 24 Apr 2019 12:26:46 -0400
Received: from casper.infradead.org ([85.118.1.10]:33174 "EHLO
        casper.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727393AbfDXQ0q (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 24 Apr 2019 12:26:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:From:Date:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=t8kYoJE49hBBh3BzA0yHzxLJpEzzDBWtalWv3f1Mn6s=; b=X9UTBP4WY50r88VR8QLRyoJ5D9
        mybLnjRiouOFgaq0S+qfqRbyRMQCeCIdYuDGNFLlsXLrcdAGBogjPfmOoV6UYKGoLnq8DBahGs+PL
        qKy8ENPlJgt607vHQmyIq5W6F11zRXcmv+/pIoGhmHE1tQGDpchew52j2RKN+Yx2UBTYLpkMfb6ZU
        gmd7VipbYm0Xl1/l6zlejaAkfmv2C/Z1YJjAEpDyDAMS1eKqVJnWZNiUZ86mfGVktv5yHRnlZ8pNk
        wIJLc5oVyK9fd5QH1sQG9871Vp3CUpCbY9dja6nRrvgbyF5vEHccWi09MlXh9f6FP+0G1X0gGwVMt
        /WpmNQBw==;
Received: from 177.17.136.231.dynamic.adsl.gvt.net.br ([177.17.136.231] helo=coco.lan)
        by casper.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hJKjI-0004cs-Ff; Wed, 24 Apr 2019 16:26:41 +0000
Date:   Wed, 24 Apr 2019 13:26:34 -0300
From:   Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To:     Changbin Du <changbin.du@gmail.com>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Bjorn Helgaas <bhelgaas@google.com>, rjw@rjwysocki.net,
        linux-pci@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, tglx@linutronix.de, mingo@redhat.com,
        x86@kernel.org, fenghua.yu@intel.com,
        linuxppc-dev@lists.ozlabs.org, linux-acpi@vger.kernel.org,
        linux-gpio@vger.kernel.org
Subject: Re: [PATCH v4 34/63] Documentation: PCI: convert
 endpoint/pci-endpoint-cfs.txt to reST
Message-ID: <20190424132634.5e1d486e@coco.lan>
In-Reply-To: <20190423162932.21428-35-changbin.du@gmail.com>
References: <20190423162932.21428-1-changbin.du@gmail.com>
        <20190423162932.21428-35-changbin.du@gmail.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Em Wed, 24 Apr 2019 00:29:03 +0800
Changbin Du <changbin.du@gmail.com> escreveu:

> This converts the plain text documentation to reStructuredText format and
> add it to Sphinx TOC tree. No essential content change.
> 
> Signed-off-by: Changbin Du <changbin.du@gmail.com>
> Acked-by: Bjorn Helgaas <bhelgaas@google.com>

Reviewed-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>

> ---
>  Documentation/PCI/endpoint/index.rst          |  1 +
>  ...-endpoint-cfs.txt => pci-endpoint-cfs.rst} | 99 +++++++++++--------
>  2 files changed, 57 insertions(+), 43 deletions(-)
>  rename Documentation/PCI/endpoint/{pci-endpoint-cfs.txt => pci-endpoint-cfs.rst} (64%)
> 
> diff --git a/Documentation/PCI/endpoint/index.rst b/Documentation/PCI/endpoint/index.rst
> index 0db4f2fcd7f0..3951de9f923c 100644
> --- a/Documentation/PCI/endpoint/index.rst
> +++ b/Documentation/PCI/endpoint/index.rst
> @@ -8,3 +8,4 @@ PCI Endpoint Framework
>     :maxdepth: 2
>  
>     pci-endpoint
> +   pci-endpoint-cfs
> diff --git a/Documentation/PCI/endpoint/pci-endpoint-cfs.txt b/Documentation/PCI/endpoint/pci-endpoint-cfs.rst
> similarity index 64%
> rename from Documentation/PCI/endpoint/pci-endpoint-cfs.txt
> rename to Documentation/PCI/endpoint/pci-endpoint-cfs.rst
> index d740f29960a4..b6d39cdec56e 100644
> --- a/Documentation/PCI/endpoint/pci-endpoint-cfs.txt
> +++ b/Documentation/PCI/endpoint/pci-endpoint-cfs.rst
> @@ -1,41 +1,51 @@
> -                   CONFIGURING PCI ENDPOINT USING CONFIGFS
> -                    Kishon Vijay Abraham I <kishon@ti.com>
> +.. SPDX-License-Identifier: GPL-2.0
> +
> +=======================================
> +Configuring PCI Endpoint Using CONFIGFS
> +=======================================
> +
> +:Author: Kishon Vijay Abraham I <kishon@ti.com>
>  
>  The PCI Endpoint Core exposes configfs entry (pci_ep) to configure the
>  PCI endpoint function and to bind the endpoint function
>  with the endpoint controller. (For introducing other mechanisms to
>  configure the PCI Endpoint Function refer to [1]).
>  
> -*) Mounting configfs
> +Mounting configfs
> +=================
>  
>  The PCI Endpoint Core layer creates pci_ep directory in the mounted configfs
> -directory. configfs can be mounted using the following command.
> +directory. configfs can be mounted using the following command::
>  
>  	mount -t configfs none /sys/kernel/config
>  
> -*) Directory Structure
> +Directory Structure
> +===================
>  
>  The pci_ep configfs has two directories at its root: controllers and
>  functions. Every EPC device present in the system will have an entry in
>  the *controllers* directory and and every EPF driver present in the system
>  will have an entry in the *functions* directory.
> +::
>  
> -/sys/kernel/config/pci_ep/
> -	.. controllers/
> -	.. functions/
> +	/sys/kernel/config/pci_ep/
> +		.. controllers/
> +		.. functions/
>  
> -*) Creating EPF Device
> +Creating EPF Device
> +===================
>  
>  Every registered EPF driver will be listed in controllers directory. The
>  entries corresponding to EPF driver will be created by the EPF core.
> +::
>  
> -/sys/kernel/config/pci_ep/functions/
> -	.. <EPF Driver1>/
> -		... <EPF Device 11>/
> -		... <EPF Device 21>/
> -	.. <EPF Driver2>/
> -		... <EPF Device 12>/
> -		... <EPF Device 22>/
> +	/sys/kernel/config/pci_ep/functions/
> +		.. <EPF Driver1>/
> +			... <EPF Device 11>/
> +			... <EPF Device 21>/
> +		.. <EPF Driver2>/
> +			... <EPF Device 12>/
> +			... <EPF Device 22>/
>  
>  In order to create a <EPF device> of the type probed by <EPF Driver>, the
>  user has to create a directory inside <EPF DriverN>.
> @@ -44,34 +54,37 @@ Every <EPF device> directory consists of the following entries that can be
>  used to configure the standard configuration header of the endpoint function.
>  (These entries are created by the framework when any new <EPF Device> is
>  created)
> -
> -	.. <EPF Driver1>/
> -		... <EPF Device 11>/
> -			... vendorid
> -			... deviceid
> -			... revid
> -			... progif_code
> -			... subclass_code
> -			... baseclass_code
> -			... cache_line_size
> -			... subsys_vendor_id
> -			... subsys_id
> -			... interrupt_pin
> -
> -*) EPC Device
> +::
> +
> +		.. <EPF Driver1>/
> +			... <EPF Device 11>/
> +				... vendorid
> +				... deviceid
> +				... revid
> +				... progif_code
> +				... subclass_code
> +				... baseclass_code
> +				... cache_line_size
> +				... subsys_vendor_id
> +				... subsys_id
> +				... interrupt_pin
> +
> +EPC Device
> +==========
>  
>  Every registered EPC device will be listed in controllers directory. The
>  entries corresponding to EPC device will be created by the EPC core.
> -
> -/sys/kernel/config/pci_ep/controllers/
> -	.. <EPC Device1>/
> -		... <Symlink EPF Device11>/
> -		... <Symlink EPF Device12>/
> -		... start
> -	.. <EPC Device2>/
> -		... <Symlink EPF Device21>/
> -		... <Symlink EPF Device22>/
> -		... start
> +::
> +
> +	/sys/kernel/config/pci_ep/controllers/
> +		.. <EPC Device1>/
> +			... <Symlink EPF Device11>/
> +			... <Symlink EPF Device12>/
> +			... start
> +		.. <EPC Device2>/
> +			... <Symlink EPF Device21>/
> +			... <Symlink EPF Device22>/
> +			... start
>  
>  The <EPC Device> directory will have a list of symbolic links to
>  <EPF Device>. These symbolic links should be created by the user to
> @@ -81,7 +94,7 @@ The <EPC Device> directory will also have a *start* field. Once
>  "1" is written to this field, the endpoint device will be ready to
>  establish the link with the host. This is usually done after
>  all the EPF devices are created and linked with the EPC device.
> -
> +::
>  
>  			 | controllers/
>  				| <Directory: EPC name>/
> @@ -102,4 +115,4 @@ all the EPF devices are created and linked with the EPC device.
>  						| interrupt_pin
>  						| function
>  
> -[1] -> Documentation/PCI/endpoint/pci-endpoint.txt
> +[1] :doc:`pci-endpoint`

Thanks,
Mauro
