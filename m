Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:39023 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756724Ab2HFWrC (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 6 Aug 2012 18:47:02 -0400
Received: by pbbrr13 with SMTP id rr13so3235729pbb.19
        for <linux-pci@vger.kernel.org>; Mon, 06 Aug 2012 15:47:01 -0700 (PDT)
Date: Mon, 6 Aug 2012 15:46:58 -0700
From: Greg KH <gregkh@linuxfoundation.org>
To: Paolo <paolopiace@gmail.com>
Cc: linux-pci@vger.kernel.org
Subject: Re: accessing pci_dev
Message-ID: <20120806224658.GA8579@kroah.com>
References: <loom.20120807T001740-895@post.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <loom.20120807T001740-895@post.gmane.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Aug 06, 2012 at 10:19:55PM +0000, Paolo wrote:
> My apologies if this is inappropriate, but I really don't know where to go for
> asking this (eventually, I'd be pleased to be addressed to valuable forums or
> documents).
> 
> Question:
> Is there any way to access to the struct pci_dev without registering any driver?

Yes, but why would you?

What problem are you trying to solve?

greg k-h
