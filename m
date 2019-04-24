Return-Path: <SRS0=9smm=S2=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DED32C282CE
	for <linux-pci@archiver.kernel.org>; Wed, 24 Apr 2019 15:25:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A55D0218FE
	for <linux-pci@archiver.kernel.org>; Wed, 24 Apr 2019 15:25:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556119531;
	bh=5E8NB2UNktmAfzYPPTcTNRVwHi4DrCcaxU9n7yS4Ee8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=LhskuXiEDuiV+WF4OLdz6WrgBsw1/yQtlwlrlhAUgiRNO0xPTPzu/zFaugAdcbWNW
	 Z9v1foNzATNOimWbYWjTBTZH2FCLWcEZYLgdcZC8sHShkDunmDZSrYSaifVj2KvPYh
	 7wH+GZMiqSqHfXIgPZ+Va7D3wCtk7PgTmuaQz5t4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730476AbfDXPZb (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 24 Apr 2019 11:25:31 -0400
Received: from casper.infradead.org ([85.118.1.10]:54932 "EHLO
        casper.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727995AbfDXPZa (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 24 Apr 2019 11:25:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:From:Date:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=hjf0dowWGlQyrZpt2Xx4o0uy5Am62BPm2+PXT3U6LLY=; b=oWcUnMS2lhYXgVS/DpTjNlaZsq
        lDoT/6DeheePqiQ9/9i5szkfNRwtbiimxVt3i6wIref2rAoajSakWZ2jTrxbsUrKhbJCPuu9L3LdK
        py7zqO2tfUhvu/KI5KejwQ2x8CWQ03lq5r7Hwh/hwqPaiJbAu64rFcNKS6bF2uM+/YDTyRcFNqkxw
        uvkA8OlMKo/wUT528OLyAiKNA/yb/s8PqUkFxpu6u1ZJ1LqcMn/mrWvTy4TO0zK8GR2quQmnJFn1l
        gOwNDWKSAR4uRPMPcTPfFQGrkYps+oyF6XAFfAORH6FddTkUnkkhOpn35veuf77iZOjAoHbxna0iR
        XkIKtQ6g==;
Received: from 177.17.136.231.dynamic.adsl.gvt.net.br ([177.17.136.231] helo=coco.lan)
        by casper.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hJJm1-0002KP-VI; Wed, 24 Apr 2019 15:25:26 +0000
Date:   Wed, 24 Apr 2019 12:25:19 -0300
From:   Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To:     Changbin Du <changbin.du@gmail.com>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Bjorn Helgaas <bhelgaas@google.com>, rjw@rjwysocki.net,
        linux-pci@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, tglx@linutronix.de, mingo@redhat.com,
        x86@kernel.org, fenghua.yu@intel.com,
        linuxppc-dev@lists.ozlabs.org, linux-acpi@vger.kernel.org,
        linux-gpio@vger.kernel.org
Subject: Re: [PATCH v4 28/63] Documentation: PCI: convert pci-iov-howto.txt
 to reST
Message-ID: <20190424122519.615ff4f3@coco.lan>
In-Reply-To: <20190423162932.21428-29-changbin.du@gmail.com>
References: <20190423162932.21428-1-changbin.du@gmail.com>
        <20190423162932.21428-29-changbin.du@gmail.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Em Wed, 24 Apr 2019 00:28:57 +0800
Changbin Du <changbin.du@gmail.com> escreveu:

> This converts the plain text documentation to reStructuredText format and
> add it to Sphinx TOC tree. No essential content change.
> 
> Signed-off-by: Changbin Du <changbin.du@gmail.com>
> Acked-by: Bjorn Helgaas <bhelgaas@google.com>
> ---
>  Documentation/PCI/index.rst                   |   1 +
>  .../{pci-iov-howto.txt => pci-iov-howto.rst}  | 161 ++++++++++--------
>  2 files changed, 94 insertions(+), 68 deletions(-)
>  rename Documentation/PCI/{pci-iov-howto.txt => pci-iov-howto.rst} (63%)

Reviewed-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>

> 
> diff --git a/Documentation/PCI/index.rst b/Documentation/PCI/index.rst
> index 452723318405..e1c19962a7f8 100644
> --- a/Documentation/PCI/index.rst
> +++ b/Documentation/PCI/index.rst
> @@ -10,3 +10,4 @@ Linux PCI Bus Subsystem
>  
>     pci
>     PCIEBUS-HOWTO
> +   pci-iov-howto
> diff --git a/Documentation/PCI/pci-iov-howto.txt b/Documentation/PCI/pci-iov-howto.rst
> similarity index 63%
> rename from Documentation/PCI/pci-iov-howto.txt
> rename to Documentation/PCI/pci-iov-howto.rst
> index d2a84151e99c..b9fd003206f1 100644
> --- a/Documentation/PCI/pci-iov-howto.txt
> +++ b/Documentation/PCI/pci-iov-howto.rst
> @@ -1,14 +1,19 @@
> -		PCI Express I/O Virtualization Howto
> -		Copyright (C) 2009 Intel Corporation
> -		    Yu Zhao <yu.zhao@intel.com>
> +.. SPDX-License-Identifier: GPL-2.0
> +.. include:: <isonum.txt>
>  
> -		Update: November 2012
> -			-- sysfs-based SRIOV enable-/disable-ment
> -		Donald Dutile <ddutile@redhat.com>
> +====================================
> +PCI Express I/O Virtualization Howto
> +====================================
>  
> -1. Overview
> +:Copyright: |copy| 2009 Intel Corporation
> +:Authors: - Yu Zhao <yu.zhao@intel.com>
> +          - Donald Dutile <ddutile@redhat.com>
>  
> -1.1 What is SR-IOV
> +Overview
> +========
> +
> +What is SR-IOV
> +--------------
>  
>  Single Root I/O Virtualization (SR-IOV) is a PCI Express Extended
>  capability which makes one physical device appear as multiple virtual
> @@ -23,9 +28,11 @@ Memory Space, which is used to map its register set. VF device driver
>  operates on the register set so it can be functional and appear as a
>  real existing PCI device.
>  
> -2. User Guide
> +User Guide
> +==========
>  
> -2.1 How can I enable SR-IOV capability
> +How can I enable SR-IOV capability
> +----------------------------------
>  
>  Multiple methods are available for SR-IOV enablement.
>  In the first method, the device driver (PF driver) will control the
> @@ -43,105 +50,123 @@ checks, e.g., check numvfs == 0 if enabling VFs, ensure
>  numvfs <= totalvfs.
>  The second method is the recommended method for new/future VF devices.
>  
> -2.2 How can I use the Virtual Functions
> +How can I use the Virtual Functions
> +-----------------------------------
>  
>  The VF is treated as hot-plugged PCI devices in the kernel, so they
>  should be able to work in the same way as real PCI devices. The VF
>  requires device driver that is same as a normal PCI device's.
>  
> -3. Developer Guide
> +Developer Guide
> +===============
>  
> -3.1 SR-IOV API
> +SR-IOV API
> +----------
>  
>  To enable SR-IOV capability:
> -(a) For the first method, in the driver:
> +
> +(a) For the first method, in the driver::
> +
>  	int pci_enable_sriov(struct pci_dev *dev, int nr_virtfn);
> -	'nr_virtfn' is number of VFs to be enabled.
> -(b) For the second method, from sysfs:
> +
> +'nr_virtfn' is number of VFs to be enabled.
> +
> +(b) For the second method, from sysfs::
> +
>  	echo 'nr_virtfn' > \
>          /sys/bus/pci/devices/<DOMAIN:BUS:DEVICE.FUNCTION>/sriov_numvfs
>  
>  To disable SR-IOV capability:
> -(a) For the first method, in the driver:
> +
> +(a) For the first method, in the driver::
> +
>  	void pci_disable_sriov(struct pci_dev *dev);
> -(b) For the second method, from sysfs:
> +
> +(b) For the second method, from sysfs::
> +
>  	echo  0 > \
>          /sys/bus/pci/devices/<DOMAIN:BUS:DEVICE.FUNCTION>/sriov_numvfs
>  
>  To enable auto probing VFs by a compatible driver on the host, run
>  command below before enabling SR-IOV capabilities. This is the
>  default behavior.
> +::
> +
>  	echo 1 > \
>          /sys/bus/pci/devices/<DOMAIN:BUS:DEVICE.FUNCTION>/sriov_drivers_autoprobe
>  
>  To disable auto probing VFs by a compatible driver on the host, run
>  command below before enabling SR-IOV capabilities. Updating this
>  entry will not affect VFs which are already probed.
> +::
> +
>  	echo  0 > \
>          /sys/bus/pci/devices/<DOMAIN:BUS:DEVICE.FUNCTION>/sriov_drivers_autoprobe
>  
> -3.2 Usage example
> +Usage example
> +-------------
>  
>  Following piece of code illustrates the usage of the SR-IOV API.
> +::
>  
> -static int dev_probe(struct pci_dev *dev, const struct pci_device_id *id)
> -{
> -	pci_enable_sriov(dev, NR_VIRTFN);
> +	static int dev_probe(struct pci_dev *dev, const struct pci_device_id *id)
> +	{
> +		pci_enable_sriov(dev, NR_VIRTFN);
>  
> -	...
> -
> -	return 0;
> -}
> +		...
>  
> -static void dev_remove(struct pci_dev *dev)
> -{
> -	pci_disable_sriov(dev);
> +		return 0;
> +	}
>  
> -	...
> -}
> +	static void dev_remove(struct pci_dev *dev)
> +	{
> +		pci_disable_sriov(dev);
>  
> -static int dev_suspend(struct pci_dev *dev, pm_message_t state)
> -{
> -	...
> +		...
> +	}
>  
> -	return 0;
> -}
> +	static int dev_suspend(struct pci_dev *dev, pm_message_t state)
> +	{
> +		...
>  
> -static int dev_resume(struct pci_dev *dev)
> -{
> -	...
> +		return 0;
> +	}
>  
> -	return 0;
> -}
> +	static int dev_resume(struct pci_dev *dev)
> +	{
> +		...
>  
> -static void dev_shutdown(struct pci_dev *dev)
> -{
> -	...
> -}
> +		return 0;
> +	}
>  
> -static int dev_sriov_configure(struct pci_dev *dev, int numvfs)
> -{
> -	if (numvfs > 0) {
> -		...
> -		pci_enable_sriov(dev, numvfs);
> +	static void dev_shutdown(struct pci_dev *dev)
> +	{
>  		...
> -		return numvfs;
>  	}
> -	if (numvfs == 0) {
> -		....
> -		pci_disable_sriov(dev);
> -		...
> -		return 0;
> +
> +	static int dev_sriov_configure(struct pci_dev *dev, int numvfs)
> +	{
> +		if (numvfs > 0) {
> +			...
> +			pci_enable_sriov(dev, numvfs);
> +			...
> +			return numvfs;
> +		}
> +		if (numvfs == 0) {
> +			....
> +			pci_disable_sriov(dev);
> +			...
> +			return 0;
> +		}
>  	}
> -}
> -
> -static struct pci_driver dev_driver = {
> -	.name =		"SR-IOV Physical Function driver",
> -	.id_table =	dev_id_table,
> -	.probe =	dev_probe,
> -	.remove =	dev_remove,
> -	.suspend =	dev_suspend,
> -	.resume =	dev_resume,
> -	.shutdown =	dev_shutdown,
> -	.sriov_configure = dev_sriov_configure,
> -};
> +
> +	static struct pci_driver dev_driver = {
> +		.name =		"SR-IOV Physical Function driver",
> +		.id_table =	dev_id_table,
> +		.probe =	dev_probe,
> +		.remove =	dev_remove,
> +		.suspend =	dev_suspend,
> +		.resume =	dev_resume,
> +		.shutdown =	dev_shutdown,
> +		.sriov_configure = dev_sriov_configure,
> +	};



Thanks,
Mauro
