Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from aserp1050.oracle.com ([141.146.126.70]:23380 "EHLO
        aserp1050.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750893AbdGENlV (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 5 Jul 2017 09:41:21 -0400
Received: from aserp1040.oracle.com (aserp1040.oracle.com [141.146.126.69])
        by aserp1050.oracle.com (Sentrion-MTA-4.3.2/Sentrion-MTA-4.3.2) with ESMTP id v65D0FBf010258
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-pci@vger.kernel.org>; Wed, 5 Jul 2017 13:00:15 GMT
Date: Wed, 5 Jul 2017 15:00:06 +0200
From: Wim ten Have <wim.ten.have@oracle.com>
To: Sinan Kaya <okaya@codeaurora.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        Wim ten Have <wim.ten.have@oracle.com>
Subject: Re: Red Hat (Fedora) bug report 1467674 concerning your kernel
 functional performance enhancements causing PCI Express crashes,
Message-ID: <20170705150006.7f6a3c44.wim.ten.have@oracle.com>
In-Reply-To: <c350ebc3-51cf-d2d7-e40c-740360f1dc4d@codeaurora.org>
References: <20170704161352.1cdb2670.wim.ten.have@oracle.com>
        <CAErSpo7PbSZgRtPJiXuOd6FPgLK5AGki51fTUm_-KUDZ96sRww@mail.gmail.com>
        <2acc9a73-0c2c-31f3-fcdf-42289213860e@codeaurora.org>
        <20170704195916.43fbe6e4.wim.ten.have@oracle.com>
        <97b8c58e-7384-0519-5ccb-837fa5054d84@codeaurora.org>
        <17f06c42-a96f-d1da-38e5-95117626eb29@codeaurora.org>
        <20170705131312.6073b8aa.wim.ten.have@oracle.com>
        <c350ebc3-51cf-d2d7-e40c-740360f1dc4d@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, 5 Jul 2017 08:37:03 -0400
Sinan Kaya <okaya@codeaurora.org> wrote:

> On 7/5/2017 7:13 AM, Wim ten Have wrote:
> >  From an 'rpmbuild -ba kernel.spec' nicely proceeded and generated all
> >   package.  They all installed and the system boots and works like a charm!  
> 
> Thanks for testing. I'll re-post the same patch with better commit text
> and fixes tag so that Bjorn can review it.
> 
> Can I have a tested-by?

  Sure.

  tested-by: Wim ten Have <wim.ten.have@oracle.com>

- Wim.
