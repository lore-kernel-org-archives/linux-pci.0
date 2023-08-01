Return-Path: <linux-pci-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36314C001E0
	for <linux-pci@archiver.kernel.org>; Tue,  1 Aug 2023 13:26:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234322AbjHAN0Y (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 1 Aug 2023 09:26:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234211AbjHAN0K (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 1 Aug 2023 09:26:10 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0B832D4A;
        Tue,  1 Aug 2023 06:25:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D4B556158F;
        Tue,  1 Aug 2023 13:25:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2164C433C7;
        Tue,  1 Aug 2023 13:25:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1690896342;
        bh=mhm8335E+d9BDqsYwoCfPeS41QphmN4pFLZ8pGZo2ck=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=c1wWlV9sqmwtZWCX7PsODhSVmE05MoT+AiyBvXBfsBtg8VWRlNVvTKkPPlAH+fB1/
         8hKDgcQ2aVhjAflW66W7zcH5YZj5eXLrzbBe6vhwBgw4a0vkUoVurbKhPBlGHU8Ikt
         OTR18B3QnP4bM99qfEtxoD4fQ2yq1tz/MN22arWk=
Date:   Tue, 1 Aug 2023 15:25:39 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Alistair Francis <alistair23@gmail.com>
Cc:     bhelgaas@google.com, linux-pci@vger.kernel.org,
        Jonathan.Cameron@huawei.com, lukas@wunner.de,
        alex.williamson@redhat.com, christian.koenig@amd.com,
        kch@nvidia.com, logang@deltatee.com, linux-kernel@vger.kernel.org,
        Alistair Francis <alistair.francis@wdc.com>
Subject: Re: [PATCH v2] PCI/DOE: Expose the DOE protocols via sysfs
Message-ID: <2023080123-botany-magnesium-99b0@gregkh>
References: <20230801121824.174556-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230801121824.174556-1-alistair.francis@wdc.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Aug 01, 2023 at 08:18:24AM -0400, Alistair Francis wrote:
> The PCIe 6 specification added support for the Data Object Exchange (DOE).
> When DOE is supported the Discovery Data Object Protocol must be
> implemented. The protocol allows a requester to obtain information about
> the other DOE protocols supported by the device.
> 
> The kernel is already querying the DOE protocols supported and cacheing
> the values. This patch exposes the values via sysfs. This will allow
> userspace to determine which DOE protocols are supported by the PCIe
> device.
> 
> By exposing the information to userspace tools like lspci can relay the
> information to users. By listing all of the supported protocols we can
> allow userspace to parse and support the list, which might include
> vendor specific protocols as well as yet to be supported protocols.
> 
> Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
> ---
>  Documentation/ABI/testing/sysfs-bus-pci | 11 ++++++
>  drivers/pci/doe.c                       | 52 +++++++++++++++++++++++++
>  drivers/pci/pci-sysfs.c                 |  8 ++++
>  include/linux/pci-doe.h                 |  2 +
>  4 files changed, 73 insertions(+)
> 

Hi,

This is the friendly patch-bot of Greg Kroah-Hartman.  You have sent him
a patch that has triggered this response.  He used to manually respond
to these common problems, but in order to save his sanity (he kept
writing the same thing over and over, yet to different people), I was
created.  Hopefully you will not take offence and will fix the problem
in your patch and resubmit it so that it can be accepted into the Linux
kernel tree.

You are receiving this message because of the following common error(s)
as indicated below:

- This looks like a new version of a previously submitted patch, but you
  did not list below the --- line any changes from the previous version.
  Please read the section entitled "The canonical patch format" in the
  kernel file, Documentation/process/submitting-patches.rst for what
  needs to be done here to properly describe this.

If you wish to discuss this problem further, or you have questions about
how to resolve this issue, please feel free to respond to this email and
Greg will reply once he has dug out from the pending patches received
from other developers.

thanks,

greg k-h's patch email bot
