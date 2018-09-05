Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from aserp2120.oracle.com ([141.146.126.78]:52130 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727623AbeIFDjL (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 5 Sep 2018 23:39:11 -0400
Subject: Re: [PATCH for-rc v2 2/3] PCI: Request reset type as part of function
 reset
To: Sinan Kaya <okaya@kernel.org>, linux-pci@vger.kernel.org
Cc: Derek Chickles <derek.chickles@caviumnetworks.com>,
        Satanand Burla <satananda.burla@caviumnetworks.com>,
        Felix Manlunas <felix.manlunas@caviumnetworks.com>,
        Raghu Vatsavayi <raghu.vatsavayi@caviumnetworks.com>,
        "David S. Miller" <davem@davemloft.net>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Juergen Gross <jgross@suse.com>,
        Jia-Ju Bai <baijiaju1990@gmail.com>
References: <20180905160805.5680-1-okaya@kernel.org>
 <20180905160805.5680-2-okaya@kernel.org>
From: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Message-ID: <74681de4-4f08-0df3-a0ba-430ffa54c36f@oracle.com>
Date: Wed, 5 Sep 2018 19:07:53 -0400
MIME-Version: 1.0
In-Reply-To: <20180905160805.5680-2-okaya@kernel.org>
Content-Type: text/plain; charset=utf-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 09/05/2018 12:08 PM, Sinan Kaya wrote:
> We need a contract between the reset API users and the PCI core about the
> types of reset that a user needs vs. what PCI core can do internally.
> If a platform supports hotplug, we need to do hotplug reset as an example.
>
> Expose the reset types to the drivers and try different reset types based
> on the new reset_type parameter.
>
> Most users are expected to use PCI_RESET_ANY, PCI_RESET_FUNC or
> PCI_RESET_LINK parameters.
>
> Fixes: 811c5cb37df4 ("PCI: Unify try slot and bus reset API")
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=200985
> Suggested-by: Alex Williamson <alex.williamson@redhat.com>
> Signed-off-by: Sinan Kaya <okaya@kernel.org>


Reviewed-by: Boris Ostrovsky <boris.ostrovsky@oracle.com>
