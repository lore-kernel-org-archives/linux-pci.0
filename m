Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from cpsmtpb-ews07.kpnxchange.com ([213.75.39.10]:54291 "EHLO
	cpsmtpb-ews07.kpnxchange.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758541Ab3BSJ2W (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 19 Feb 2013 04:28:22 -0500
Message-ID: <1361266095.26423.19.camel@x61.thuisdomein>
Subject: Re: pciehp: errors on resume
From: Paul Bolle <pebolle@tiscali.nl>
To: Wei Yang <weiyang@linux.vnet.ibm.com>
Cc: Oliver Neukum <oneukum@suse.de>, "Rafael J. Wysocki" <rjw@sisk.pl>,
	Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
Date: Tue, 19 Feb 2013 10:28:15 +0100
In-Reply-To: <512336fb.42d70e0a.73ed.ffffc77eSMTPIN_ADDED_BROKEN@mx.google.com>
References: <1359377173.1345.25.camel@x61.thuisdomein>
	 <512336fb.42d70e0a.73ed.ffffc77eSMTPIN_ADDED_BROKEN@mx.google.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Richard,

On Tue, 2013-02-19 at 16:25 +0800, Wei Yang wrote:
> Sorry for bothering, I am looking at this and try to understand the process, 
> while get some confusion.
> 
> 1. The error log will be printed every time suspend/resume, no matter whether
>    the device is plug in/plug out during the suspend as discussed below?
> 
>    If the device is always there, no one touch it, the error message still be
>    printed?
> 
> 2. In my mind, before the pcied_init is called, those pci_dev are
>    already enumerated, such as the wireless card in this case. 
> 
>    During the boot stage, if the pciehp_force is set to true, the error messge
>    still be printed? Since I don't have those devices to create pcie_device, I
>    can't test this.
> 
> 3. Do you think it would be find to remove those devices at the suspend stage?
>    Then they will be added again at the resume stage?

Bypassing your questions, I'd like to point you at
http://article.gmane.org/gmane.linux.kernel.pci/20077 , in which Rafael
suggested a possible solution to this situation. (There's some extra
info in other messages in this thread.)

I must confess that I'm not at all sure how to implement it and that so
far I have, rather cowardly, not even drafted a solution along those
lines.


Paul Bolle

