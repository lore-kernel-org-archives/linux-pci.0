Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.linuxfoundation.org ([140.211.169.12]:34615 "EHLO
	mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750970AbaDRCrw (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 17 Apr 2014 22:47:52 -0400
Date: Thu, 17 Apr 2014 19:47:58 -0700
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Sebastian Ott <sebott@linux.vnet.ibm.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
Subject: Re: [PATCH] pci: remove pcibios_add_platform_entries
Message-ID: <20140418024758.GB10084@kroah.com>
References: <alpine.LFD.2.11.1404171947150.1588@denkbrett>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <alpine.LFD.2.11.1404171947150.1588@denkbrett>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Apr 17, 2014 at 07:48:07PM +0200, Sebastian Ott wrote:
> Remove pcibios_add_platform_entries. Architecture specific attributes
> can be achieved by setting pdev->dev.groups .
> 
> Link: https://lkml.kernel.org/r/alpine.LFD.2.11.1404141101500.1529@denkbrett
> Signed-off-by: Sebastian Ott <sebott@linux.vnet.ibm.com>

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
