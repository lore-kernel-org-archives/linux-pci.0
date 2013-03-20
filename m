Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from e8.ny.us.ibm.com ([32.97.182.138]:40033 "EHLO e8.ny.us.ibm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752289Ab3CTSG7 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Wed, 20 Mar 2013 14:06:59 -0400
Received: from /spool/local
	by e8.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pci@vger.kernel.org> from <zohar@linux.vnet.ibm.com>;
	Wed, 20 Mar 2013 14:06:58 -0400
Message-ID: <1363802506.2580.55.camel@falcor1.watson.ibm.com>
Subject: Re: [PATCH 01/12] Security: Add CAP_COMPROMISE_KERNEL
From: Mimi Zohar <zohar@linux.vnet.ibm.com>
To: Matthew Garrett <matthew.garrett@nebula.com>
Cc: James Morris <jmorris@namei.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-security-module@vger.kernel.org"
	<linux-security-module@vger.kernel.org>,
	"linux-efi@vger.kernel.org" <linux-efi@vger.kernel.org>,
	"kexec@lists.infradead.org" <kexec@lists.infradead.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Date: Wed, 20 Mar 2013 14:01:46 -0400
In-Reply-To: <1363798166.2553.29.camel@x230.sbx07502.somerma.wayport.net>
References: <1363642353-30749-1-git-send-email-matthew.garrett@nebula.com>
	 <alpine.LRH.2.02.1303191542200.30973@tundra.namei.org>
	 <1363797717.2580.10.camel@falcor1.watson.ibm.com>
	 <1363798166.2553.29.camel@x230.sbx07502.somerma.wayport.net>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, 2013-03-20 at 16:49 +0000, Matthew Garrett wrote:
> On Wed, 2013-03-20 at 12:41 -0400, Mimi Zohar wrote:
> 
> > Matthrew, perhaps you could clarify whether this will be tied to MAC
> > security.  Based on the kexec thread, I'm under the impression that is
> > not the intention, or at least not for kexec.  As root isn't trusted,
> > neither is the boot command line, nor any policy that is loaded by root,
> > including those for MAC.
> 
> The work done on signed initramfs fragments would seem to be the best
> option here so far?

Sorry, I'm not sure to which work you're referring. If you're referring
to Dmitry's "initramfs with digital signature protection" patches, then
we're speaking about enforcing integrity, not MAC security.  

thanks,

Mimi

