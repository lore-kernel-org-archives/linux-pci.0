Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-lpp01m010-f46.google.com ([209.85.215.46]:62607 "EHLO
	mail-lpp01m010-f46.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751957Ab2HPO1w (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 16 Aug 2012 10:27:52 -0400
Received: by lagy9 with SMTP id y9so1492036lag.19
        for <linux-pci@vger.kernel.org>; Thu, 16 Aug 2012 07:27:51 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20120726204435.A2F49245526@molor.provo.novell.com>
References: <bug-750320-60020@http.bugzilla.novell.com/> <20120726204435.A2F49245526@molor.provo.novell.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Thu, 16 Aug 2012 08:27:30 -0600
Message-ID: <CAErSpo7c9VmKt_j-TPTJLTrd1ggj+E4byGkOka0jVGPKz28ATA@mail.gmail.com>
Subject: Re: [Bug 750320] various Express Cards are not recognized by lspci
To: bugzilla_noreply@novell.com
Cc: linux-pci@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

> https://bugzilla.novell.com/show_bug.cgi?id=750320

I think this hotplug should be handled by the pciehp driver, but that
driver doesn't appear to be loaded.  Can you load it and try this
hotplug again, and attach the dmesg log?
