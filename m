Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:41438 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728460AbeIQBcc (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sun, 16 Sep 2018 21:32:32 -0400
Subject: Re: [PATCH v3 1/6] PCI: Expose reset_type to users of
 __pci_reset_function_locked()
To: linux-pci@vger.kernel.org
Cc: alex.williamson@redhat.com,
        Derek Chickles <derek.chickles@caviumnetworks.com>,
        Satanand Burla <satananda.burla@caviumnetworks.com>,
        Felix Manlunas <felix.manlunas@caviumnetworks.com>,
        Raghu Vatsavayi <raghu.vatsavayi@caviumnetworks.com>,
        "David S. Miller" <davem@davemloft.net>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>,
        Jia-Ju Bai <baijiaju1990@gmail.com>
References: <20180916200439.21960-1-okaya@kernel.org>
 <20180916200439.21960-2-okaya@kernel.org>
From: Sinan Kaya <okaya@kernel.org>
Message-ID: <a266c436-b53e-4069-73ad-a2ac276ce36e@kernel.org>
Date: Sun, 16 Sep 2018 16:08:23 -0400
MIME-Version: 1.0
In-Reply-To: <20180916200439.21960-2-okaya@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 9/16/2018 4:04 PM, Sinan Kaya wrote:
> +int __pci_reset_function_locked(struct pci_dev *dev, u32 reset_type)
>   {
> -	int rc;
> +	int rc = 0;

I forgot about this. I'll wait a couple of more days before when I spin a new 
version.
