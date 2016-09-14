Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.9]:48124 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1761900AbcINMtt (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 14 Sep 2016 08:49:49 -0400
Date: Wed, 14 Sep 2016 05:49:47 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Adit Ranadive <aditr@vmware.com>
Cc: dledford@redhat.com, linux-rdma@vger.kernel.org,
        pv-drivers@vmware.com, netdev@vger.kernel.org,
        linux-pci@vger.kernel.org, jhansen@vmware.com, asarwade@vmware.com,
        georgezhang@vmware.com, bryantan@vmware.com
Subject: Re: [PATCH v4 05/16] IB/pvrdma: Add functions for Verbs support
Message-ID: <20160914124947.GA14616@infradead.org>
References: <1473655766-31628-1-git-send-email-aditr@vmware.com>
 <1473655766-31628-6-git-send-email-aditr@vmware.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1473655766-31628-6-git-send-email-aditr@vmware.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

> +	props->max_fmr = dev->dsr->caps.max_fmr;
> +	props->max_map_per_fmr = dev->dsr->caps.max_map_per_fmr;

Please don't add FMR support to any new drivers.
