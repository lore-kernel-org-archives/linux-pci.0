Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-wg0-f44.google.com ([74.125.82.44]:58933 "EHLO
	mail-wg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751936Ab2GTNhI convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 20 Jul 2012 09:37:08 -0400
Received: by wgbdr13 with SMTP id dr13so3653232wgb.1
        for <linux-pci@vger.kernel.org>; Fri, 20 Jul 2012 06:37:07 -0700 (PDT)
From: Bert van Leeuwen <bert@e.co.za>
Content-Type: text/plain; charset=us-ascii
Subject: pci_iomap bug?
Date: Fri, 20 Jul 2012 15:37:03 +0200
Message-Id: <C3F57A84-3334-4A30-8D55-773F11B0B511@e.co.za>
To: linux-pci@vger.kernel.org
Mime-Version: 1.0 (Apple Message framework v1278)
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

I noticed that the pci_iomap() function in the lib/iomap.c file seems (to me) do be doing the wrong thing here:

    if (flags & IORESOURCE_CACHEABLE)
      return ioremap(start, len);
    return ioremap_nocache(start, len);

since, as of 2.6.26 or so, the ioremap() function is defined as:
static inline void __iomem *ioremap(resource_size_t offset, unsigned long size)
{
  return ioremap_nocache(offset, size);
}

So it seems to me that pci_iomap() is calling ioremap_nocache() regardless of the IORESOURCE_CACHEABLE flag?