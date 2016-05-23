Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.linuxfoundation.org ([140.211.169.12]:59738 "EHLO
	mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754113AbcEWPeE (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 23 May 2016 11:34:04 -0400
Date: Mon, 23 May 2016 08:34:02 -0700
From: Greg KH <gregkh@linuxfoundation.org>
To: Amir Levy <amir.jer.levy@intel.com>
Cc: andreas.noever@gmail.com, bhelgaas@google.com,
	linux-pci@vger.kernel.org, michael.jamet@intel.com,
	dan.alloun@intel.com, mika.westerberg@intel.com,
	kai.svahn@intel.com, andriy.shevchenko@intel.com,
	tomas.winkler@intel.com
Subject: Re: [PATCH 6/6] thunderbolt: Networking doc
Message-ID: <20160523153402.GA30137@kroah.com>
References: <1463993336-2750-1-git-send-email-amir.jer.levy@intel.com>
 <1463993336-2750-7-git-send-email-amir.jer.levy@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1463993336-2750-7-git-send-email-amir.jer.levy@intel.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, May 23, 2016 at 11:48:56AM +0300, Amir Levy wrote:
> Adding Thunderbolt(TM) networking documentation.
> 
> Signed-off-by: Amir Levy <amir.jer.levy@intel.com>
> Signed-off-by: Michael Jamet <michael.jamet@intel.com>
> ---
>  Documentation/00-INDEX        |   2 +
>  Documentation/thunderbolt.txt | 135 ++++++++++++++++++++++++++++++++++++++++++

This is networking with thunderbolt, you might want to name the
documentation file to reflect that otherwise people are going to think
this is describing all thunderbolt support in the kernel.

thanks,

greg k-h
