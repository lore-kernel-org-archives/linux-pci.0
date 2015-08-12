Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from casper.infradead.org ([85.118.1.10]:52269 "EHLO
	casper.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751259AbbHLSFk (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 12 Aug 2015 14:05:40 -0400
Subject: Re: linux-next: Tree for Aug 12 (include/linux/pci.h)
To: Stephen Rothwell <sfr@canb.auug.org.au>, linux-next@vger.kernel.org
References: <20150812233914.451d1fcf@canb.auug.org.au>
Cc: linux-kernel@vger.kernel.org, linux-pci <linux-pci@vger.kernel.org>
From: Randy Dunlap <rdunlap@infradead.org>
Message-ID: <55CB8AF0.4060905@infradead.org>
Date: Wed, 12 Aug 2015 11:05:36 -0700
MIME-Version: 1.0
In-Reply-To: <20150812233914.451d1fcf@canb.auug.org.au>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 08/12/15 06:39, Stephen Rothwell wrote:
> Hi all,
> 
> Changes since 20150810:
> 

on i386 or x86_64:

Many (repeated) errors like this one:

../include/linux/pci.h:390:12: error: âstruct pci_devâ has no member named âphysfnâ

when CONFIG_PCI_ATS is not enabled.


-- 
~Randy
