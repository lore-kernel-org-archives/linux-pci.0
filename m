Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:58221 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1762234Ab2EQSy0 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Thu, 17 May 2012 14:54:26 -0400
Message-ID: <4FB54960.5080500@redhat.com>
Date: Thu, 17 May 2012 14:54:24 -0400
From: Prarit Bhargava <prarit@redhat.com>
MIME-Version: 1.0
To: Don Dutile <ddutile@redhat.com>
CC: linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH] pci, Add AER_panic sysfs file
References: <1337274270-18785-1-git-send-email-prarit@redhat.com> <4FB548A8.9010003@redhat.com>
In-Reply-To: <4FB548A8.9010003@redhat.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>


>> +    if (dev->rp_AER_panic)
>> +        panic("%s: AER detected on Root Port", pci_name(dev));
>> +
> It'd be more informative if the Root Port D:B:D.F was printed out above,
> so one knows where the errors are coming from the system.  More likely than
> not, the root is ok, but a device dangling from it is the 'root cause' (all pun
> intended)
> of the error.

That's what pci_name() is.

P.
