Return-Path: <SRS0=lgne=XA=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE43DC43331
	for <linux-pci@archiver.kernel.org>; Thu,  5 Sep 2019 18:42:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BFA4420825
	for <linux-pci@archiver.kernel.org>; Thu,  5 Sep 2019 18:42:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=anastas.io header.i=@anastas.io header.b="Y5HpMYTv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732033AbfIESmM (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 5 Sep 2019 14:42:12 -0400
Received: from alpha.anastas.io ([104.248.188.109]:52821 "EHLO
        alpha.anastas.io" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728258AbfIESmM (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 5 Sep 2019 14:42:12 -0400
Received: from authenticated-user (alpha.anastas.io [104.248.188.109])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by alpha.anastas.io (Postfix) with ESMTPSA id E21BC7F933;
        Thu,  5 Sep 2019 13:42:10 -0500 (CDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=anastas.io; s=mail;
        t=1567708931; bh=rxv4QLf9HCtfom1Uhju5LVSvzANgFuLIb2JMOlcou9I=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=Y5HpMYTvY7D1uU9xy0wS+ulM64Im5+we5EsSRy3YE4PphhLKAXM7V01+gc5421Phc
         Hi/+w/NXCWeCOPDGXb3S/ZcAcYFWc7ZJ27UTOnehNo6fxM9nePzdzcVzxOhNgZYVXC
         B8WlnlkZ0Ajkl2H/eTSMFvpmiShR05wf+rHAxBogSKOAr+C4wOVHPYeBctCn0KYZ5/
         suOXKh0B4jdhfam8RyYfsZF8CpF5gzICeNMgHJywWN1JxoqGpkzqczNcK0HeBTCQm2
         2Lc2W5gkmd5JemKl9sQkcTLmOS78/lRu6rSOY9qsAQYwiNk4/poTvpvIk6Gwfnw+0v
         XRv8FbKEVrXzw==
Subject: Re: [PATCH 0/2] Fix IOMMU setup for hotplugged devices on pseries
To:     Lukas Wunner <lukas@wunner.de>
Cc:     linux-pci@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        bhelgaas@google.com, mpe@ellerman.id.au, aik@ozlabs.ru,
        benh@kernel.crashing.org, sbobroff@linux.ibm.com, oohall@gmail.com
References: <20190905042215.3974-1-shawn@anastas.io>
 <20190905093841.mkpvzkcrafwpo5lj@wunner.de>
From:   Shawn Anastasio <shawn@anastas.io>
Message-ID: <b43dada8-7fc8-2ee1-46da-273c522426a4@anastas.io>
Date:   Thu, 5 Sep 2019 13:42:10 -0500
MIME-Version: 1.0
In-Reply-To: <20190905093841.mkpvzkcrafwpo5lj@wunner.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 9/5/19 4:38 AM, Lukas Wunner wrote:
> On Wed, Sep 04, 2019 at 11:22:13PM -0500, Shawn Anastasio wrote:
>> If anybody has more insight or a better way to fix this, please let me know.
> 
> Have you considered moving the invocation of pcibios_setup_device()
> to pcibios_bus_add_device()?
> 
> The latter is called from pci_bus_add_device() in drivers/pci/bus.c.
> At this point device_add() has been called, so the device exists in
> sysfs.
> 
> Basically when adding a PCI device, the order is:
> 
> * pci_device_add() populates struct pci_dev, calls device_add(),
>    binding the device to a driver is prevented
> * after pci_device_add() has been called for all discovered devices,
>    resources are allocated
> * pci_bus_add_device() is called for each device,
>    calls pcibios_bus_add_device() and binds the device to a driver

Thank you, this is exactly what I was looking for! Just tested and
this seems to work perfectly. I'll go ahead and submit a v2 that
does this instead.

Thanks again,
Shawn
