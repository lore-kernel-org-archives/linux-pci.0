Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.linuxfoundation.org ([140.211.169.12]:37438 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751405AbeCUJWo (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 21 Mar 2018 05:22:44 -0400
Date: Wed, 21 Mar 2018 10:22:41 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Niklas Cassel <niklas.cassel@axis.com>
Cc: kishon@ti.com, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Arnd Bergmann <arnd@arndb.de>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 5/5] misc: pci_endpoint_test: Handle 64-bit BARs
 properly
Message-ID: <20180321092241.GP14085@kroah.com>
References: <20180308133331.19464-1-niklas.cassel@axis.com>
 <20180308133331.19464-6-niklas.cassel@axis.com>
 <20180321035931.GB28953@axis.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180321035931.GB28953@axis.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Mar 21, 2018 at 04:59:31AM +0100, Niklas Cassel wrote:
> Hello Greg,
> 
> Lorenzo	is fine with this series
> ( https://marc.info/?l=linux-kernel&m=152147837619191&w=2 )
> 
> However, he wants your ack on this patch before merging.

No need for my ack, if you all want to maintain this driver, it's fine
with me, go ahead and merge what you want :)

greg k-h
