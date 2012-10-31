Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-bk0-f46.google.com ([209.85.214.46]:41443 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760596Ab2JaVxO (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 31 Oct 2012 17:53:14 -0400
Received: by mail-bk0-f46.google.com with SMTP id jk13so868662bkc.19
        for <linux-pci@vger.kernel.org>; Wed, 31 Oct 2012 14:53:12 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1351718353-6124-3-git-send-email-ddutile@redhat.com>
References: <1351718353-6124-1-git-send-email-ddutile@redhat.com>
	<1351718353-6124-3-git-send-email-ddutile@redhat.com>
Date: Wed, 31 Oct 2012 14:53:12 -0700
Message-ID: <CAE9FiQXQ6cODjkdgKC0XQUnat5_8uz=4gJr2qp5wS2J+=ur5EA@mail.gmail.com>
Subject: Re: [PATCH 2/4] PCI,sys: Use is_visible() with boot_vga attribute for pci_dev
From: Yinghai Lu <yinghai@kernel.org>
To: Donald Dutile <ddutile@redhat.com>
Cc: linux-pci@vger.kernel.org, bhelgaas@google.com,
	yuvalmin@broadcom.com, bhutchings@solarflare.com,
	gregory.v.rose@intel.com, davem@davemloft.net
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Oct 31, 2012 at 2:19 PM, Donald Dutile <ddutile@redhat.com> wrote:
> From: Don Dutile <ddutile@dddsys1.bos.redhat.com>

should be
From:  Yinghai Lu <yinghai@kernel.org>

>
> Should make pci_creae_sysfs_dev_files simpler.
> Also fix possible memleak in remove path.
>
> Authored-by: Yinghai Lu <yinghai@kernel.org>

should be:
Signed-off-by: Yinghai Lu <yinghai@kernel.org>

> Signed-off-by: Donald Dutile <ddutile@redhat.com>

patch 1 and 2 got acked-by from Greg KH

https://patchwork.kernel.org/patch/1542941/
