Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pz0-f46.google.com ([209.85.210.46]:55885 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755262Ab2IADM2 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 31 Aug 2012 23:12:28 -0400
Received: by dady13 with SMTP id y13so2360673dad.19
        for <linux-pci@vger.kernel.org>; Fri, 31 Aug 2012 20:12:27 -0700 (PDT)
Message-ID: <50417D0B.2070003@gmail.com>
Date: Sat, 01 Sep 2012 11:12:11 +0800
From: Jiang Liu <liuj97@gmail.com>
MIME-Version: 1.0
To: Paolo <paolopiace@gmail.com>
CC: linux-pci@vger.kernel.org
Subject: Re: BAR0/1 & enumeration
References: <loom.20120831T212633-656@post.gmane.org> <20120831194626.GB21160@parisc-linux.org> <loom.20120831T214839-854@post.gmane.org>
In-Reply-To: <loom.20120831T214839-854@post.gmane.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

The genefic PCI/PCIe framework doesn't do any thing special for NTB device,
just treat it as a normal PCI device. The issue you mentioned must be
handled by BIOS/OS driver with device specific knowledge.
--Gerry

On 09/01/2012 03:56 AM, Paolo wrote:
> Not really.
> 
> I'm working on a NTB. NTBs are Type-0 headers, like any PCIe end point.
> BAR0/1 on NTB can be set as base address for the config-space of its function OR
> as based address of the memory space for memory transactions.
> 
> Hence my initial question. Looking fwd to some hint.
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

