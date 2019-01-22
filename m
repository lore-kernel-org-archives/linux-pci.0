Return-Path: <SRS0=s1t5=P6=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17FA5C282C3
	for <linux-pci@archiver.kernel.org>; Tue, 22 Jan 2019 15:12:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D958621721
	for <linux-pci@archiver.kernel.org>; Tue, 22 Jan 2019 15:12:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548169925;
	bh=o8skt/MZy91lk4GAAgbR4GSjdbiudJ68A+VNv76fAJo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=uICkaMrwv1eTydWmOOI5zHRaLcKfj4maV1baeud6mQbEhKZVH9ra/b+mQUfAokC4x
	 uIjRZjrYcaKoL7Xjm6QHSlHMnQXqN0L9cg1tzDEapSdXAKjSXYj5XpnEkaZ9IiIwaO
	 kmdsX0hz8oiRc9MQk8zN1p0+CzmrtpZu3USPE4C0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728928AbfAVPMF (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 22 Jan 2019 10:12:05 -0500
Received: from mail.kernel.org ([198.145.29.99]:51716 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728899AbfAVPMF (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 22 Jan 2019 10:12:05 -0500
Received: from localhost (173-25-171-118.client.mchsi.com [173.25.171.118])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 62A5420879;
        Tue, 22 Jan 2019 15:12:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548169924;
        bh=o8skt/MZy91lk4GAAgbR4GSjdbiudJ68A+VNv76fAJo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NNppmDFLn3lcEBCBI25pv2oowYmu9WgHb7gmcODy4J/bDIGin9eXrI9Jll4BIkM6j
         PJUhc2PVOCFbpaATgcWzeavZxPvcHGidlibh8NnmNSrtuy9R0mxNWNgoZXZnhe4uW4
         8W1cyCs0Ijc74XjzvGTihMLFighQYPSOU7UCrHhk=
Date:   Tue, 22 Jan 2019 09:12:02 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     saumah <saumah@gmail.com>
Cc:     linux-pci@vger.kernel.org, morris_ku@sunix.com.tw
Subject: Re: [PATCH] pci_ids.h change for fix hanging problem while suspend
 machine. pci_ids.h has the same vendor id and device id definition as sunix
 multi-I/O board driver, when the sunix multi-io board driver is installed,
 it will cause operation error
Message-ID: <20190122151202.GA14636@google.com>
References: <20190122022237.27871-1-saumah@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190122022237.27871-1-saumah@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Thanks for your patch, but I can't figure out exactly what problem
you're solving.

There is only one definition of PCI_VENDOR_ID_SUNIX in the current
upstream tree, so I don't see what the conflict is.  If there's a
conflicting definition in some out-of-tree driver, we generally
wouldn't change the upstream tree, we'd ask you to change the
out-of-tree driver.  Or even better, to merge your driver into the
upstream kernel so it's no longer maintained out of the tree.

Please start with
https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/submitting-patches.rst

Bjorn

On Tue, Jan 22, 2019 at 10:22:37AM +0800, saumah wrote:
> Signed-off-by: saumah <saumah@gmail.com>
> ---
>  ....-8250-16550-build-in-driver-conflic.patch | 28 -------------------
>  1 file changed, 28 deletions(-)
>  delete mode 100644 0001-pci_ids.h-change.-8250-16550-build-in-driver-conflic.patch
> 
> diff --git a/0001-pci_ids.h-change.-8250-16550-build-in-driver-conflic.patch b/0001-pci_ids.h-change.-8250-16550-build-in-driver-conflic.patch
> deleted file mode 100644
> index dd1b7bf..0000000
> --- a/0001-pci_ids.h-change.-8250-16550-build-in-driver-conflic.patch
> +++ /dev/null
> @@ -1,28 +0,0 @@
> -From 15a467e9bb45d76a9373cb21c499a0cb21df2dda Mon Sep 17 00:00:00 2001
> -From: Morris Ku <morris_ku@sunix.com>
> -Date: Tue, 8 Jan 2019 20:08:48 +0800
> -Subject: [PATCH] pci_ids.h change. 8250/16550 build-in driver conflict with SUNIX Multi-I/O Borad Driver
> -
> -Signed-off-by: Morris Ku <morris_ku@sunix.com>
> ----
> - pci_ids.h | 4 ++--
> - 1 file changed, 2 insertions(+), 2 deletions(-)
> -
> -diff --git a/pci_ids.h b/pci_ids.h
> -index 2950223..b681a66 100644
> ---- a/pci_ids.h
> -+++ b/pci_ids.h
> -@@ -2567,8 +2567,8 @@
> - #define PCI_DEVICE_ID_TEHUTI_3010	0x3010
> - #define PCI_DEVICE_ID_TEHUTI_3014	0x3014
> -
> --#define PCI_VENDOR_ID_SUNIX		0x1fd4
> --#define PCI_DEVICE_ID_SUNIX_1999	0x1999
> -+//#define PCI_VENDOR_ID_SUNIX		0x1fd4
> -+//#define PCI_DEVICE_ID_SUNIX_1999	0x1999
> -
> - #define PCI_VENDOR_ID_HINT             0x3388
> - #define PCI_DEVICE_ID_HINT_VXPROII_IDE 0x8013
> ---
> -2.17.1
> -
> --
> 2.17.1
> 
