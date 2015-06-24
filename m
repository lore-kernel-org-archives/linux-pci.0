Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ig0-f181.google.com ([209.85.213.181]:36175 "EHLO
	mail-ig0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750903AbbFXXyN (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 24 Jun 2015 19:54:13 -0400
Received: by igbiq7 with SMTP id iq7so108199324igb.1
        for <linux-pci@vger.kernel.org>; Wed, 24 Jun 2015 16:54:12 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20150624222802.GP7710@google.com>
References: <1434235142-2751-1-git-send-email-yinghai@kernel.org>
	<20150619022612.GI7710@google.com>
	<CAE9FiQVZngaPYvxi1DcXDLvDnDvx6qb2md1xbhMBc0uCPyLisw@mail.gmail.com>
	<20150624222802.GP7710@google.com>
Date: Wed, 24 Jun 2015 16:54:11 -0700
Message-ID: <CAE9FiQVrc523FfnnR=HbZE_QZ+Bns_5cpJV700+TLEgtp7q17A@mail.gmail.com>
Subject: Re: [PATCH] PCI: get correct bridge mmio size with old size checking
From: Yinghai Lu <yinghai@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Jun 24, 2015 at 3:28 PM, Bjorn Helgaas <bhelgaas@google.com> wrote:
>
> I'm dropping this for now; please post an update with an improved
> changelog.

Never mind, this patch is not needed any more.

I am reworking on pbus_size_mem() other resource allocation code.

Will post the patches after v4.2-rc1.

Thanks

Yinghai
