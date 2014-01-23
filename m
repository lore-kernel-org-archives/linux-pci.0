Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:18906 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754896AbaAWUH5 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Thu, 23 Jan 2014 15:07:57 -0500
Date: Thu, 23 Jan 2014 15:07:38 -0500
From: Dave Jones <davej@redhat.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
Subject: Re: [PATCH] PCI: msi: properly free memory on an error path
Message-ID: <20140123200738.GB9269@redhat.com>
References: <20140123184246.GA7461@google.com>
 <20140123193037.GA2605@kroah.com>
 <20140123200112.GA15503@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20140123200112.GA15503@kroah.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Jan 23, 2014 at 12:01:12PM -0800, Greg Kroah-Hartman wrote:
 > From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
 > 
 > Coverity reported that I forgot to clean up some allocated memory on the
 > error path in populate_msi_sysfs(), so this patch fixes that.
 > 
 > Thanks to Dave Jones for pointing out where the error was, I obviously
 > can't read code this morning...
 
I think it doesn't help that you have 'msi_attr' and 'msi_attrs'.
My eyes kinda glazed over a few times reading those.

	Dave

