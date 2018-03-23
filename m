Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.linuxfoundation.org ([140.211.169.12]:50600 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751668AbeCWQrS (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 23 Mar 2018 12:47:18 -0400
Date: Fri, 23 Mar 2018 17:47:16 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Sridhar Pitchai <Sridhar.Pitchai@microsoft.com>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Michael Kelley (EOSG)" <Michael.H.Kelley@microsoft.com>,
        Jake Oshins <jakeo@microsoft.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "devel@linuxdriverproject.org" <devel@linuxdriverproject.org>
Subject: Re: [PATCH v3]PCI: hv: fix PCI-BUS domainID corruption
Message-ID: <20180323164716.GA7794@kroah.com>
References: <C600E28F-E581-431E-9CD4-47C776E8E70F@microsoft.com>
 <20180315120522.GA15651@e107981-ln.cambridge.arm.com>
 <DM5PR21MB0826439DF296763A3FA861C3F6D00@DM5PR21MB0826.namprd21.prod.outlook.com>
 <04DBCCAB-4BA7-4E05-A047-44824995963E@microsoft.com>
 <65B4E847-CC40-4166-BE8F-D44049EDB2FF@microsoft.com>
 <20180320183208.GB24991@e107981-ln.cambridge.arm.com>
 <4E6E5EE3-2EFA-4326-BE14-D5465F5F439F@microsoft.com>
 <20180321162555.GA16028@red-moon>
 <55A0639B-3C54-456D-95C1-829332C024EE@microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <55A0639B-3C54-456D-95C1-829332C024EE@microsoft.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Mar 23, 2018 at 04:41:02PM +0000, Sridhar Pitchai wrote:
>     Please read the link I sent you in relation to email formatting.
>     
>     Then add your description above in a way that anyone not 100% familiar
>     with hyperv can understand it - that's what the commit log is for.
>     
>     You are sending this patch to stable kernels, patch above has been in
>     the kernel from v4.14. The patch you are fixing since v4.11, you ought
>     to be careful since you do not want to have broken kernel versions owing
>     to stable patches mismatches, that's why I asked and I will ask again,
>     are you sure you won't trigger a regression by sending this fix to
>     stable ?
>     
>     I assume the bond driver mechanism is now done and dusted.
>     
> That is correct. I have sent a v4 version of the patch. I am sending this
> patch for stable kernel. We have tested and I am sure this should not trigger
> regression by sending this fix to stable.


<formletter>

This is not the correct way to submit patches for inclusion in the
stable kernel tree.  Please read:
    https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html
for how to do this properly.

</formletter>
