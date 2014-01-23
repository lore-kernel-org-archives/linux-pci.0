Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.linuxfoundation.org ([140.211.169.12]:35142 "EHLO
	mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753235AbaAWTOb (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 23 Jan 2014 14:14:31 -0500
Date: Thu, 23 Jan 2014 11:15:21 -0800
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org
Subject: Re: [scan-admin@coverity.com: New Defects reported by Coverity Scan
 for Linux]
Message-ID: <20140123191521.GA11865@kroah.com>
References: <20140123184246.GA7461@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20140123184246.GA7461@google.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Jan 23, 2014 at 11:42:46AM -0700, Bjorn Helgaas wrote:
> FYI.  I think the first two (related to "name") are valid.  I haven't
> figured out the "msi_attrs" one yet.

Ah, missed the name kmalloc() call, I'll send you a patch now to fix
that up, and try to figure out the msi_attrs one as well.

thanks for the note, this blew by me in the results, I should have seen
it as I do get these emails as well.

greg k-h
