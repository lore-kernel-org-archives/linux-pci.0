Return-Path: <SRS0=UcfF=MX=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81CDCC677FC
	for <linux-pci@archiver.kernel.org>; Thu, 11 Oct 2018 16:27:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F76920658
	for <linux-pci@archiver.kernel.org>; Thu, 11 Oct 2018 16:27:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="ambQx7lK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3F76920658
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729908AbeJKXzr (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 11 Oct 2018 19:55:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:34708 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729906AbeJKXzr (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 11 Oct 2018 19:55:47 -0400
Received: from localhost (unknown [204.56.7.10])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6FCB820658;
        Thu, 11 Oct 2018 16:27:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539275268;
        bh=bw9IHwLHTNF/IzB7MYNkhTRBQgrJLHEsOWFRdFiDp8E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ambQx7lK0tBhOC4v/k19lqmU8vOLHwmuOKQYwK9OrYW9Pc2Nz88CRJZ8TBykh1QtJ
         gg2cD/VzwkKWuu//DV2sWMZAxx86l9bWPTtJZtyzfOVk6p5hXwRAQYBH5To5fe9kIG
         PLYIkNp2ubrMKSl7ewlODg+jIPVIqeD/9YpTSg38=
Date:   Thu, 11 Oct 2018 11:27:47 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Wesley Sheng <wesley.sheng@microchip.com>
Cc:     bhelgaas@google.com, corbet@lwn.net, logang@deltatee.com,
        kurt.schwemmer@microsemi.com, linux-ntb@googlegroups.com,
        linux-pci@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Wesley Yung <wesley.yung@microchip.com>,
        Kelvin Cao <kelvin.cao@microchip.com>,
        Jon Mason <jdmason@kudzu.us>
Subject: Re: [PATCH v3] NTB: switchtec_ntb: Update switchtec documentation
 with pre-requisites for NTB
Message-ID: <20181011162747.GP5906@bhelgaas-glaptop.roam.corp.google.com>
References: <1539182575-26851-1-git-send-email-wesley.sheng@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1539182575-26851-1-git-send-email-wesley.sheng@microchip.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[+cc Jon Mason]

On Wed, Oct 10, 2018 at 10:42:55PM +0800, Wesley Sheng wrote:
> From: Wesley Yung <wesley.yung@microchip.com>
> 
> The ntb_hw_switchtec driver has requirements on kernel configuration
> so we add these notes to the documentation and also clean up a few 
> other sentences in the documentation.
> 
> Signed-off-by: Wesley Yung <wesley.yung@microchip.com>
> Signed-off-by: Kelvin Cao <kelvin.cao@microchip.com>
> Signed-off-by: Wesley Sheng <wesley.sheng@microchip.com>

I'm not sure who should really own this file:

  $ ./scripts/get_maintainer.pl -f Documentation/switchtec.txt
  Kurt Schwemmer <kurt.schwemmer@microsemi.com> (maintainer:PCI DRIVER FOR MICROSEMI SWITCHTEC)
  Logan Gunthorpe <logang@deltatee.com> (maintainer:PCI DRIVER FOR MICROSEMI SWITCHTEC)
  Jonathan Corbet <corbet@lwn.net> (maintainer:DOCUMENTATION)
  linux-pci@vger.kernel.org (open list:PCI DRIVER FOR MICROSEMI SWITCHTEC)
  linux-doc@vger.kernel.org (open list:DOCUMENTATION)
  linux-kernel@vger.kernel.org (open list)

and Jon (NTB driver core maintainer) has applied recent updates
to it.

But in the interest of forward progress, I applied this patch with
Logan's ack to pci/misc for v4.20.

> ---
>  Documentation/switchtec.txt | 30 ++++++++++++++++++++----------
>  1 file changed, 20 insertions(+), 10 deletions(-)
> 
> diff --git a/Documentation/switchtec.txt b/Documentation/switchtec.txt
> index f788264..d6f04dcc 100644
> --- a/Documentation/switchtec.txt
> +++ b/Documentation/switchtec.txt
> @@ -23,7 +23,7 @@ The primary means of communicating with the Switchtec management firmware is
>  through the Memory-mapped Remote Procedure Call (MRPC) interface.
>  Commands are submitted to the interface with a 4-byte command
>  identifier and up to 1KB of command specific data. The firmware will
> -respond with a 4 bytes return code and up to 1KB of command specific
> +respond with a 4-byte return code and up to 1KB of command specific
>  data. The interface only processes a single command at a time.
>  
>  
> @@ -36,8 +36,8 @@ device: /dev/switchtec#, one for each management endpoint in the system.
>  The char device has the following semantics:
>  
>  * A write must consist of at least 4 bytes and no more than 1028 bytes.
> -  The first four bytes will be interpreted as the command to run and
> -  the remainder will be used as the input data. A write will send the
> +  The first 4 bytes will be interpreted as the Command ID and the
> +  remainder will be used as the input data. A write will send the
>    command to the firmware to begin processing.
>  
>  * Each write must be followed by exactly one read. Any double write will
> @@ -45,9 +45,9 @@ The char device has the following semantics:
>    produce an error.
>  
>  * A read will block until the firmware completes the command and return
> -  the four bytes of status plus up to 1024 bytes of output data. (The
> -  length will be specified by the size parameter of the read call --
> -  reading less than 4 bytes will produce an error.
> +  the 4-byte Command Return Value plus up to 1024 bytes of output
> +  data. (The length will be specified by the size parameter of the read
> +  call -- reading less than 4 bytes will produce an error.)
>  
>  * The poll call will also be supported for userspace applications that
>    need to do other things while waiting for the command to complete.
> @@ -83,10 +83,20 @@ The following IOCTLs are also supported by the device:
>  Non-Transparent Bridge (NTB) Driver
>  ===================================
>  
> -An NTB driver is provided for the switchtec hardware in switchtec_ntb.
> -Currently, it only supports switches configured with exactly 2
> -partitions. It also requires the following configuration settings:
> +An NTB hardware driver is provided for the Switchtec hardware in
> +ntb_hw_switchtec. Currently, it only supports switches configured with
> +exactly 2 NT partitions and zero or more non-NT partitions. It also requires
> +the following configuration settings:
>  
> -* Both partitions must be able to access each other's GAS spaces.
> +* Both NT partitions must be able to access each other's GAS spaces.
>    Thus, the bits in the GAS Access Vector under Management Settings
>    must be set to support this.
> +* Kernel configuration MUST include support for NTB (CONFIG_NTB needs
> +  to be set)
> +
> +NT EP BAR 2 will be dynamically configured as a Direct Window, and
> +the configuration file does not need to configure it explicitly.
> +
> +Please refer to Documentation/ntb.txt in Linux source tree for an overall
> +understanding of the Linux NTB stack. ntb_hw_switchtec works as an NTB
> +Hardware Driver in this stack.
> -- 
> 2.7.4
> 
