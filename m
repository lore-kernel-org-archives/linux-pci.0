Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ee0-f46.google.com ([74.125.83.46]:64291 "EHLO
	mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751080Ab2F0Oc2 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 27 Jun 2012 10:32:28 -0400
Received: by eeit10 with SMTP id t10so387014eei.19
        for <linux-pci@vger.kernel.org>; Wed, 27 Jun 2012 07:32:26 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20120627140641.2187711F8B0@bugzilla.kernel.org>
References: <bug-15362-41252@https.bugzilla.kernel.org/> <20120627140641.2187711F8B0@bugzilla.kernel.org>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Wed, 27 Jun 2012 08:32:06 -0600
Message-ID: <CAErSpo4T5rBwoE7X2h1-CG9GoEPzXO+_1R7YVyv8wiL2qZW+XA@mail.gmail.com>
Subject: Re: [Bug 15362] MPT Fusion SCSI drives no longer appear - suspect PCI
 bus scan bug
To: bugzilla-daemon@bugzilla.kernel.org
Cc: linux-pci@vger.kernel.org, Yinghai Lu <yinghai@kernel.org>,
	Jiang Liu <liuj97@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

> I do still plan to work on bisecting this.

Can you also attach a dmesg log from a current kernel, e.g., 3.4 or
newer?  We now print a lot more information during PCI enumeration.

But I guess the problem is that 2.6.26 finds devices in domains 1 and
2, while 2.6.32 does not.  I think MMCONFIG is the only config access
method we have for domains other than 0.  That suggests that MMCONFIG
used to work but doesn't any more.  The dmesg logs claim that we're
not using MMCONFIG in either 2.6.26 or 2.6.32 though, so I don't know
why we found anything in 2.6.26.
