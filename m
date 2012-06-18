Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:42058 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751986Ab2FRSaO convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 18 Jun 2012 14:30:14 -0400
Received: by pbbrp8 with SMTP id rp8so8557530pbb.19
        for <linux-pci@vger.kernel.org>; Mon, 18 Jun 2012 11:30:13 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20120618050333.GA13469@ram-ThinkPad-T61>
References: <20120618050333.GA13469@ram-ThinkPad-T61>
Date: Mon, 18 Jun 2012 11:30:13 -0700
Message-ID: <CAE9FiQWwPOgBa5guG1y-xF95nBMwE+TC75E_xcg-N8ZxuPW_XQ@mail.gmail.com>
Subject: Re: [RFC PATCH] methods to access resources of a struct pci_dev
From: Yinghai Lu <yinghai@kernel.org>
To: Ram Pai <linuxram@us.ibm.com>
Cc: linux-pci@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Sun, Jun 17, 2012 at 10:03 PM, Ram Pai <linuxram@us.ibm.com> wrote:
> PCI: methods to access resources of struct pci_dev
>
> Currently pci_dev structure holds an array of 17 PCI resources; six base
> BARs, one ROM BAR, four BRIDGE BARs, six sriov BARs.  This is wasteful.
> A bridge device just needs the 4 bridge resources. A non-bridge device
> just needs the six base resources and one ROM resource. The sriov
> resources are needed only if the device has SRIOV capability.
>
> The pci_dev structure needs to be re-organized to avoid unnecessary
> bloating.  However too much code outside the pci-bus driver, assumes the
> internal details of the pci_dev structure, thus making it hard to
> re-organize the datastructure.
>
> As a first step this patch provides generic methods to access the
> resource structure of the pci_dev.
>
> Once this patch is accepted, I have another 40+ patches that modify all
> the files that directly access the resource structure, to use the new
> methods provided in the first step.
>
> Finally we can re-organize the resource structure in the pci_dev
> structure and correspondingly update the methods.

I have patchset on this, please check

  git://git.kernel.org/pub/scm/linux/kernel/git/yinghai/linux-yinghai.git
 for-pci-for-each-res-addon

Thanks

Yinghai
