Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from ms.lwn.net ([45.79.88.28]:33874 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752434AbdLCWMe (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sun, 3 Dec 2017 17:12:34 -0500
Date: Sun, 3 Dec 2017 15:12:32 -0700
From: Jonathan Corbet <corbet@lwn.net>
To: Randy Dunlap <rdunlap@infradead.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-pci <linux-pci@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH] Documentation: fix docs build error after source file
 removed
Message-ID: <20171203151232.502b25f9@lwn.net>
In-Reply-To: <5fc71be8-e465-211d-757f-457a8054673c@infradead.org>
References: <5fc71be8-e465-211d-757f-457a8054673c@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Sun, 3 Dec 2017 13:15:39 -0800
Randy Dunlap <rdunlap@infradead.org> wrote:

> The pci/htirq.c file was removed so remove it from the documentation
> file also.
> 
> Error: Cannot open file ../drivers/pci/htirq.c
> WARNING: kernel-doc '../scripts/kernel-doc -rst -enable-lineno -export ../drivers/pci/htirq.c' failed with return code 2
> 
> Fixes: fd2fa6c18b72 ("x86/PCI: Remove unused HyperTransport interrupt support")
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>

Applied, thanks.

jon
