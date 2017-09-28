Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:38162 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751355AbdI1QMW (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 28 Sep 2017 12:12:22 -0400
Subject: Re: [PATCH 1/4] pci: introduce __pci_walk_bus for caller with
 pci_bus_sem held
To: Govindarajulu Varadarajan <gvaradar@cisco.com>, benve@cisco.com,
        bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, jlbec@evilplan.org, hch@lst.de,
        mingo@redhat.com, peterz@infradead.org
References: <20170927214220.41216-1-gvaradar@cisco.com>
 <20170927214220.41216-2-gvaradar@cisco.com>
From: Sinan Kaya <okaya@codeaurora.org>
Message-ID: <5bbeefd2-a409-168c-b596-bcaa29a54eb7@codeaurora.org>
Date: Thu, 28 Sep 2017 12:12:19 -0400
MIME-Version: 1.0
In-Reply-To: <20170927214220.41216-2-gvaradar@cisco.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 9/27/2017 5:42 PM, Govindarajulu Varadarajan wrote:
> +void __pci_walk_bus(struct pci_bus *top, int (*cb)(struct pci_dev *, void *),
> +		    void *userdata);

pci_walk_bus_locked would be a better name as you are assuming that caller is
holding the lock. 

-- 
Sinan Kaya
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
